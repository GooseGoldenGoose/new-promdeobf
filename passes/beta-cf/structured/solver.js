"use strict";

const { createStructuredContext } = require("./context");
const { isEmptyTable, isIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, pathLocalOwnerKey, deadJoinTempKey, pathUpvalueCellKey, hasPathUpvalueCell, allocateUpvalueCellIdentity, upvalueCellIdentity, bindUpvalueCellIdentity, upvalueCellBinding, deferredClosureValue, isDeferredClosureValue, pendingDeferredLocalValue, isPendingDeferredLocalValue, renderDeferredClosureValue, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
const { isCompilerVarargPack, isVarargUnpack, expectedPackSlotsInBlock, isForwardOnlyPackUseInBlock, cleanupOrTerminalEpoch, maybeOwnStructuredPackSlot, preclaimFutureStructuredPackOwner, preclaimFutureStructuredPackSlots, flushStructuredPack, flushReadyStructuredPacks } = require("./packs");
const { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, allReachingDefinitionsAreDeadNilCleanup, conditionalUpdatedStorageEpoch, provenCallArgumentSourceEpoch, provenSingleUseCallResultAt, valueMayBeIndexWriteBaseAfter, analyzePersistentStorage } = require("./lifetime");
const { render } = require("./render");
const { renderFunction, renderProgram } = require("../render");
const { decodeVmStatement, callKind } = require("../statement-ir");
const { renderOrdinaryIndexWrite, renderOrdinaryIndexCompoundWrite, matchCompilerGlobalAssignmentBatch } = require("../statement-semantics");
const { mergeElseIfCandidates, indentConditionalEffect, mergeCandidates } = require("./branches");
const { markersSharePrefix, terminalSiblingMatch, guardLine, foldTerminalRepeatScopes, collapseTerminalCandidates, foldTerminalGuards } = require("./terminal");


function mutationBaseOwnerKey(name) { return "\0freshMutationBaseOwner:" + name; }

function sourcePackedTablePackReg(rhs, singleCallPacks) {
    if (rhs?.type !== "TableConstructorExpression" || !(singleCallPacks instanceof Map)) return null;
    const fields = rhs.fields || [];
    if (fields.length !== 1 || fields[0]?.type !== "TableValue") return null;
    const call = fields[0].value;
    if (call?.type !== "CallExpression" || !isIdentifier(call.base, "unpack") || (call.arguments || []).length !== 1 || !isIdentifier(call.arguments[0])) return null;
    return singleCallPacks.has(call.arguments[0].name) ? call.arguments[0].name : null;
}

function isRedundantReleasedUpvalueCleanup(ctx, block, index, name) {
    for (let probe = index - 1; probe >= 0; probe--) {
        if (probe === block.transitionIndex) continue;
        const statement = block.body[probe];
        if (!isSingleAssignment(statement)) {
            if (nodeReadsIdentifier(ctx, statement, name)) return false;
            continue;
        }
        const dest = statement.variables[0];
        const value = statement.init[0];
        if (isIdentifier(dest, name)) {
            return value?.type === "CallExpression" && isIdentifier(value.base, "releaseUpvalue") &&
                (value.arguments || []).length === 1 && isIdentifier(value.arguments[0], name);
        }
        if (nodeReadsIdentifier(ctx, value, name) || (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name))) return false;
    }
    return false;
}
function deferredClosureFromRhs(ctx, rhs, env, rhsCallKind) {
    if (rhsCallKind === "closure") return deferredClosureValue(ctx, rhs, env);
    if (!isIdentifier(rhs)) return null;
    const carried = resolveId(ctx, rhs.name, env);
    return isDeferredClosureValue(carried) ? carried : null;
}

function sourceStorageStartsHere(ctx, id, index, name, markers) {
    const epochEnd = cleanupOrTerminalEpoch(ctx, id, index, name);
    const cleanupBacked = ctx.allowConditionalIf && ctx.cleanupRegs.has(name) && !ctx.locals.has(name) &&
        epochEnd.valid && epochEnd.sawCleanup;
    const forcedStarts = ctx.options?.forcedPersistentStorageStarts;
    const forcedRegs = ctx.options?.forcedPersistentStorageRegs;
    const provenLoopPreheaderStart = forcedStarts instanceof Map && forcedStarts.get(name) instanceof Set &&
        forcedStarts.get(name).has(id + ":" + index);
    const isForcedLoopStorage = forcedRegs instanceof Set && forcedRegs.has(name);
    const persistent = ctx.persistentStorageRegs.has(name) &&
        (provenLoopPreheaderStart || (!isForcedLoopStorage && markers.length === 0));
    return cleanupBacked || persistent;
}

function installPendingDeferredLocal(ctx, env, markers, effects, name, initializer, terminalLive = false) {
    if (!isDeferredClosureValue(initializer) || hasActiveLocal(ctx, name, env)) return null;
    const pathScoped = markers.length !== 0;
    if (pathScoped && !ctx.allowConditionalIf) return null;
    const pending = pendingDeferredLocalValue(initializer, pathScoped);
    if (!pending) return null;
    if (pathScoped) {
        env.set(pathLocalOwnerKey(ctx, name), pending);
    } else {
        ctx.locals.add(name);
        if (terminalLive) ctx.terminalLiveLocals.add(name);
    }
    env.set(name, pending);
    return effects;
}

function flushReadyPendingDeferredLocals(ctx, env, markers, effects) {
    let nextEffects = effects;
    for (const [name, pending] of [...env.entries()]) {
        if (!isPendingDeferredLocalValue(pending)) continue;
        const owned = pending.pathScoped
            ? env.get(pathLocalOwnerKey(ctx, name)) === pending
            : ctx.locals.has(name);
        if (!owned) continue;
        const initializer = renderDeferredClosureValue(ctx, pending.initializer, env);
        if (typeof initializer !== "string") continue;
        const display = allocateValueDisplay(ctx);
        const declaration = `local ${display} = ${initializer}`;
        if (pending.pathScoped) {
            ctx.pathLocalBindingNames.add(display);
            env.set(pathLocalOwnerKey(ctx, name), display);
            nextEffects = [...nextEffects, declaration];
        } else {
            ctx.localNames.set(name, display);
            ctx.out.push(declaration);
        }
        env.set(name, display);
    }
    return nextEffects;
}

function collectClosedTerminalRegion(ctx, startId, forbiddenIds, entryPredId = null) {
    const region = new Set();
    const visiting = new Set();
    function visit(id) {
        if (forbiddenIds.has(id) || !ctx.blocks.has(id)) return false;
        if (region.has(id)) return true;
        if (visiting.has(id)) return false;
        visiting.add(id);
        const block = ctx.blocks.get(id);
        const tr = block?.transition;
        let ok = tr?.kind === "stop";
        if (!ok) {
            const nextIds = ctx.successors.get(id) || [];
            ok = nextIds.length > 0 && nextIds.every(visit);
        }
        visiting.delete(id);
        if (!ok) return false;
        region.add(id);
        return true;
    }
    if (!visit(startId)) return null;
    for (const id of region) {
        for (const pred of ctx.predecessors.get(id) || []) {
            if (region.has(pred) || (id === startId && (entryPredId === null || pred === entryPredId))) continue;
            return null;
        }
    }
    return region;
}

function loopTerminalSiblingRegion(ctx, candidate, currentId, requireCurrentRegion = false) {
    const bodyJoins = ctx.options?.loopBodyJoinIds;
    const loopBranchIds = ctx.options?.loopBranchIds;
    const markers = candidate?.markers || [];
    if (!(bodyJoins instanceof Set) || !(loopBranchIds instanceof Set) || markers.length < 2) return null;
    let loopMarker = null;
    for (let i = markers.length - 1; i >= 0; i--) {
        if (loopBranchIds.has(markers[i].branchId)) { loopMarker = markers[i]; break; }
    }
    if (!loopMarker || loopMarker.truth !== true) return null;
    const loopBlock = ctx.blocks.get(loopMarker.branchId);
    if (loopBlock?.transition?.kind !== "branch") return null;
    const forbidden = new Set(bodyJoins);
    forbidden.add(loopBlock.transition.onFalse);
    if (requireCurrentRegion) return collectClosedTerminalRegion(ctx, currentId, forbidden);
    for (let i = markers.length - 1; i >= 0; i--) {
        const marker = markers[i];
        if (loopBranchIds.has(marker.branchId)) break;
        const branch = ctx.blocks.get(marker.branchId);
        if (branch?.transition?.kind !== "branch") continue;
        const siblingStart = marker.truth ? branch.transition.onFalse : branch.transition.onTrue;
        const region = collectClosedTerminalRegion(ctx, siblingStart, forbidden, marker.branchId);
        if (region) return region;
    }
    return null;
}

function isClosedTerminalLoopSibling(ctx, candidate, currentId) {
    return loopTerminalSiblingRegion(ctx, candidate, currentId, true) instanceof Set;
}

function hasControlOnlyJumpPath(ctx, startId, targetId) {
    if (!Number.isInteger(startId) || !Number.isInteger(targetId) || startId === targetId) return false;
    const seen = new Set();
    let id = startId;
    while (id !== targetId) {
        if (seen.has(id)) return false;
        seen.add(id);
        const block = ctx.blocks.get(id);
        if (!block || block.transition?.kind !== "jump" || !Number.isInteger(block.transitionIndex)) return false;
        for (let i = 0; i < block.body.length; i++) {
            if (i !== block.transitionIndex) return false;
        }
        id = block.transition.target;
    }
    return true;
}

function ordinaryTerminalSiblingRegion(ctx, candidate, currentId) {
    const markers = candidate?.markers || [];
    const effects = candidate?.effects || [];
    if (!markers.length || !Number.isInteger(currentId)) return null;
    for (let i = markers.length - 1; i >= 0; i--) {
        const marker = markers[i];
        if (!marker || marker.kind != null || !Number.isInteger(marker.branchId) || marker.effectCount !== effects.length) continue;
        const branch = ctx.blocks.get(marker.branchId);
        if (branch?.transition?.kind !== "branch") continue;
        const ownStart = marker.truth ? branch.transition.onTrue : branch.transition.onFalse;
        if (!hasControlOnlyJumpPath(ctx, ownStart, currentId)) continue;
        const siblingStart = marker.truth ? branch.transition.onFalse : branch.transition.onTrue;
        const region = collectClosedTerminalRegion(ctx, siblingStart, new Set([currentId]), marker.branchId);
        if (region) return region;
    }
    return null;
}
function isLoopAbruptCandidate(candidate) {
    const effects = candidate?.effects || [];
    const tail = effects[effects.length - 1];
    return tail === "break" || tail === "continue";
}

function collapseLoopAbruptPool(ctx, pool) {
    if (!Array.isArray(pool) || pool.length < 2) return true;
    let changed = true;
    while (changed) {
        changed = false;
        outer: for (let i = 0; i < pool.length; i++) {
            if (!isLoopAbruptCandidate(pool[i])) continue;
            for (let j = i + 1; j < pool.length; j++) {
                if (!isLoopAbruptCandidate(pool[j])) continue;
                const a = pool[i], b = pool[j];
                const match = terminalSiblingMatch(ctx, a, b);
                if (!match) continue;
                const trueCandidate = match.al.truth ? a : b;
                const falseCandidate = match.al.truth ? b : a;
                const guard = guardLine(ctx, match.al.condition, true, (trueCandidate.effects || []).slice(match.effectPrefix));
                if (!guard) return false;
                const merged = {
                    env: new Map(falseCandidate.env),
                    markers: (falseCandidate.markers || []).slice(0, -1),
                    effects: [
                        ...(falseCandidate.effects || []).slice(0, match.effectPrefix),
                        guard,
                        ...(falseCandidate.effects || []).slice(match.effectPrefix),
                    ],
                };
                pool.splice(j, 1);
                pool.splice(i, 1, merged);
                changed = true;
                break outer;
            }
        }
    }
    return true;
}

function foldLoopAbruptGuards(ctx, candidate, currentId) {
    const joinIds = ctx.options?.loopBodyJoinIds;
    if (!(joinIds instanceof Set) || joinIds.size === 0 || !candidate) return candidate;
    let current = {
        env: new Map(candidate.env),
        markers: [...(candidate.markers || [])],
        effects: [...(candidate.effects || [])],
    };
    while (current.markers.length > 0) {
        let folded = false;
        for (const joinId of joinIds) {
            // Never mutate the candidate list currently being iterated. The
            // body join itself can use the ordinary candidate merger.
            if (joinId === currentId) continue;
            const pool = ctx.incoming.get(joinId);
            if (!Array.isArray(pool) || pool.length === 0) continue;
            // A proven break candidate can reach the synthetic loop join before its
            // opposite terminal-return sibling is processed. Once that terminal
            // sibling is proven, fold it into the queued break path before
            // matching the abrupt subtree against an outer branch.
            // The terminal guard is safe because its body exits the function;
            // the abrupt tail remains the only continuation of that candidate.
            for (let poolIndex = 0; poolIndex < pool.length; poolIndex++) {
                const tail = pool[poolIndex]?.effects?.[pool[poolIndex].effects.length - 1];
                if (tail !== "break") continue;
                const terminalFoldedAbrupt = foldTerminalGuards(ctx, pool[poolIndex]);
                if (!terminalFoldedAbrupt) return null;
                pool[poolIndex] = terminalFoldedAbrupt;
            }
            if (!collapseLoopAbruptPool(ctx, pool)) return null;
            for (let i = 0; i < pool.length; i++) {
                const abrupt = pool[i];
                if (!isLoopAbruptCandidate(abrupt)) continue;
                const match = terminalSiblingMatch(ctx, current, abrupt);
                if (!match) continue;
                const backedgeCounts = ctx.options?.loopBackedgeCountsByJoin;
                if (backedgeCounts instanceof Map && backedgeCounts.get(joinId) === 1 &&
                    isClosedTerminalLoopSibling(ctx, current, currentId)) continue;
                const marker = abrupt.markers[abrupt.markers.length - 1];
                // The dedicated while merger owns the proven loop decision.
                // Folding an abrupt body path across that marker would turn
                // the loop itself into an if-guard before while rendering.
                const loopBranchIds = ctx.options?.loopBranchIds;
                if (loopBranchIds instanceof Set && loopBranchIds.has(marker.branchId)) continue;
                const numericForBranchIds = ctx.options?.numericForBranchIds;
                if (numericForBranchIds instanceof Set && numericForBranchIds.has(marker.branchId)) continue;
                const genericForBranchIds = ctx.options?.genericForBranchIds;
                if (genericForBranchIds instanceof Set && genericForBranchIds.has(marker.branchId)) continue;
                const guard = guardLine(ctx, marker.condition, marker.truth, (abrupt.effects || []).slice(match.effectPrefix));
                if (!guard) return null;
                const prefix = current.effects.slice(0, match.effectPrefix);
                current = {
                    env: new Map(current.env),
                    markers: current.markers.slice(0, -1),
                    effects: [...prefix, guard, ...current.effects.slice(match.effectPrefix)],
                };
                pool.splice(i, 1);
                if (!collapseLoopAbruptPool(ctx, pool)) return null;
                folded = true;
                break;
            }
            if (folded) break;
        }
        if (!folded) break;
    }
    return current;
}

function reduceLoopNestedCandidates(ctx, candidates, joinId) {
    if (!(ctx.options?.loopBodyJoinIds instanceof Set) || candidates.length < 3) return null;
    const work = candidates.map(candidate => ({
        env: new Map(candidate.env),
        markers: [...(candidate.markers || [])],
        effects: [...(candidate.effects || [])],
    }));
    let changed = true;
    while (work.length > 2 && changed) {
        changed = false;
        outer: for (let i = 0; i < work.length; i++) {
            for (let j = i + 1; j < work.length; j++) {
                const sibling = terminalSiblingMatch(ctx, work[i], work[j]);
                if (!sibling) continue;
                // Keep speculative reduction inside an enclosing branch. A
                // prefix-free pair would be a root conditional and belongs to
                // the existing N-way/root ordering proof instead.
                if ((work[i].markers || []).length <= 1) continue;
                let merged = mergeCandidates(ctx, [work[i], work[j]], joinId);
                if (!merged) continue;
                merged = foldTerminalGuards(ctx, merged);
                if (!merged) return null;
                merged = foldLoopAbruptGuards(ctx, merged, joinId);
                if (!merged) return null;
                work.splice(j, 1);
                work.splice(i, 1, merged);
                changed = true;
                break outer;
            }
        }
    }
    return changed || work.length < candidates.length ? work : null;
}

function recordTerminalFoldedRootContinuation(ctx, beforeCandidate, afterCandidate, joinId) {
    const beforeMarkers = beforeCandidate?.markers || [];
    const afterMarkers = afterCandidate?.markers || [];
    if (beforeMarkers.length === 0 || afterMarkers.length !== 0) return true;
    const rootMarker = beforeMarkers[0];
    // Only an ordinary root conditional can advance the sequential root anchor.
    // Loop-scope/synthetic markers have their own structural merge rules.
    if (!rootMarker || rootMarker.kind != null || !Number.isInteger(rootMarker.branchId)) return true;
    return recordRootConditional(ctx, rootMarker.branchId, joinId);
}

function matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, options = {}) {
    const ctx = createStructuredContext(source, stateWhile, stateName, returnName, options);
    if (!ctx) return null;
    analyzePersistentStorage(ctx);
    const deferredTerminalJoinProgress = new Map();
    while (ctx.processingQueue.length) {
        const id = ctx.processingQueue.shift();
        if (ctx.processed.has(id)) continue;
        const candidates = ctx.incoming.get(id) || [];
        if (!collapseTerminalCandidates(ctx)) return null;
        // A continuation can become graph-ready before an opposite terminal
        // branch has finished producing its terminal candidate because terminal
        // paths have no edge to the continuation. Defer only when CFG proof says
        // that sibling is a closed acyclic terminal region and one of its states
        // is already ready. This makes recovery independent of VM queue order.
        let pendingTerminalSibling = null;
        for (const candidate of candidates) {
            const regions = [
                ordinaryTerminalSiblingRegion(ctx, candidate, id),
                candidates.length > 1 ? loopTerminalSiblingRegion(ctx, candidate, id, false) : null,
            ];
            const region = regions.find(item => item && ctx.processingQueue.some(readyId => item.has(readyId)));
            if (region) {
                pendingTerminalSibling = region;
                break;
            }
        }
        if (pendingTerminalSibling) {
            const lastProgress = deferredTerminalJoinProgress.get(id);
            if (lastProgress !== ctx.processed.size) {
                deferredTerminalJoinProgress.set(id, ctx.processed.size);
                ctx.processingQueue.push(id);
                continue;
            }
        }
        const normalizedCandidates = [];
        for (const candidate of candidates) {
            const terminalFolded = foldTerminalGuards(ctx, candidate);
            if (!terminalFolded) return null;
            if (!recordTerminalFoldedRootContinuation(ctx, candidate, terminalFolded, id)) return null;
            const folded = foldLoopAbruptGuards(ctx, terminalFolded, id);
            if (!folded) return null;
            // Abrupt reduction can remove a nested marker and expose a terminal
            // sibling that was not at equal depth during the first pass. Fold
            // exact terminal siblings again before N-way/ancestor convergence.
            const refoldedTerminal = foldTerminalGuards(ctx, folded);
            if (!refoldedTerminal) return null;
            if (!recordTerminalFoldedRootContinuation(ctx, folded, refoldedTerminal, id)) return null;
            normalizedCandidates.push(refoldedTerminal);
        }
        let merged = mergeCandidates(ctx, normalizedCandidates, id);
        if (!merged && normalizedCandidates.length > 2 && ctx.options?.loopBodyJoinIds instanceof Set) {
            const reduced = reduceLoopNestedCandidates(ctx, normalizedCandidates, id);
            if (reduced) merged = mergeCandidates(ctx, reduced, id);
        }
        if (!merged) return null;
        let env = merged.env;
        let markers = merged.markers;
        let effects = merged.effects || [];
        if (markers.length === 0 && effects.length > 0) {
            ctx.out.push(...effects);
            effects = [];
        }
        const terminalRepeatBodyStarts = ctx.options?.terminalRepeatBodyStarts;
        const terminalRepeatStart = terminalRepeatBodyStarts instanceof Map ? terminalRepeatBodyStarts.get(id) : null;
        if (terminalRepeatStart) {
            const condition = resolveId(ctx, terminalRepeatStart.captureName, env);
            if (typeof condition !== "string") return null;
            env.delete(terminalRepeatStart.captureName);
            markers = [...markers, {
                kind: "terminal-repeat-scope",
                condition,
                truth: null,
                branchId: `terminal-repeat:${terminalRepeatStart.preheaderId}:${id}`,
                effectCount: effects.length,
            }];
        }
        const repeatBodyStarts = ctx.options?.repeatBodyStarts;
        const repeatStart = repeatBodyStarts instanceof Map ? repeatBodyStarts.get(id) : null;
        if (repeatStart) {
            markers = [...markers, {
                kind: "repeat-scope",
                repeatId: repeatStart.repeatId,
                decisionId: repeatStart.decisionId,
                bodyId: id,
                condition: null,
                truth: null,
                branchId: repeatStart.repeatId,
                effectCount: effects.length,
            }];
        }
        const numericForBodyStarts = ctx.options?.numericForBodyStarts;
        const numericForStart = numericForBodyStarts instanceof Map ? numericForBodyStarts.get(id) : null;
        if (numericForStart) {
            if (typeof numericForStart.loopVariableDisplay !== "string") {
                numericForStart.loopVariableDisplay = allocateValueDisplay(ctx);
            }
            const display = numericForStart.loopVariableDisplay;
            ctx.pathLocalBindingNames.add(display);
            if (typeof numericForStart.loopVarReg === "string") {
                env.set(pathLocalOwnerKey(ctx, numericForStart.loopVarReg), display);
                env.set(numericForStart.loopVarReg, display);
                env.delete(upvalueAliasKey(ctx, numericForStart.loopVarReg));
            } else if (typeof numericForStart.loopVarCellReg === "string") {
                // Captured numeric-for variables are represented by a fresh
                // compiler upvalue cell each iteration. The loop classifier
                // removes that cell's alloc/init/release bookkeeping and seeds
                // its source binding here so ordinary captured-closure rendering
                // resolves the cell directly to the recovered loop variable.
                env.set(pathUpvalueCellKey(ctx, numericForStart.loopVarCellReg), display);
            } else {
                return null;
            }
        }
        const genericForBodyStarts = ctx.options?.genericForBodyStarts;
        const genericForStart = genericForBodyStarts instanceof Map ? genericForBodyStarts.get(id) : null;
        if (genericForStart) {
            const bindings = Array.isArray(genericForStart.loopVarBindings)
                ? genericForStart.loopVarBindings
                : genericForStart.loopVarRegs.map(reg => ({ kind: "register", reg }));
            if (!Array.isArray(genericForStart.loopVariableDisplays)) {
                genericForStart.loopVariableDisplays = bindings.map(() => allocateValueDisplay(ctx));
            }
            if (genericForStart.loopVariableDisplays.length !== bindings.length || bindings.length !== genericForStart.loopVarRegs.length) return null;
            for (let loopIndex = 0; loopIndex < bindings.length; loopIndex++) {
                const binding = bindings[loopIndex];
                const display = genericForStart.loopVariableDisplays[loopIndex];
                ctx.pathLocalBindingNames.add(display);
                if (binding?.kind === "register" && typeof binding.reg === "string") {
                    env.set(pathLocalOwnerKey(ctx, binding.reg), display);
                    env.set(binding.reg, display);
                    env.delete(upvalueAliasKey(ctx, binding.reg));
                } else if (binding?.kind === "captured-cell" && typeof binding.handleReg === "string") {
                    env.set(pathUpvalueCellKey(ctx, binding.handleReg), display);
                } else {
                    return null;
                }
            }
        }
        const block = ctx.blocks.get(id);
        let terminalReturnIndex = -1;
        let terminalReturnLine = null;
        const terminalPackExprs = new Map();
        if (block.transition.kind === "stop") {
            for (let i = block.transitionIndex - 1; i >= 0; i--) {
                if (!isSingleAssignment(block.body[i], ctx.returnName)) continue;
                if (block.body[i].init[0]?.type !== "TableConstructorExpression") continue;
                terminalReturnIndex = i;
                break;
            }
            if (terminalReturnIndex < 0) return null;
        }
        // Normalized dispatcher invariant: entering this leaf proves state == id.
        // The compiler may borrow/copy POS as an ordinary temporary before the
        // real transition at the end of the block.
        env.set(ctx.stateName, String(id));
        env.delete(upvalueAliasKey(ctx, ctx.stateName));

        for (let i = 0; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            effects = flushReadyPendingDeferredLocals(ctx, env, markers, effects);
            const statement = block.body[i];
            const op = decodeVmStatement(statement);
            if (!op) return null;
            const dest = op.destination;
            const rhs = op.value;

            if (op.kind === "compound-index-write") {
                const value = render(ctx, rhs, env);
                if (typeof value !== "string" || typeof op.operator !== "string") return null;
                const capturedDestination = capturedSlotName(ctx, dest);
                let line = null;
                if (typeof capturedDestination === "string") {
                    line = capturedDestination + " " + op.operator + "= " + value;
                } else if (isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index) &&
                    (ctx.upvalueCells.has(dest.index.name) || hasPathUpvalueCell(ctx, dest.index.name, env))) {
                    const existing = upvalueCellBinding(ctx, dest.index.name, env);
                    if (typeof existing !== "string") return null;
                    line = existing + " " + op.operator + "= " + value;
                } else {
                    if (!isIdentifier(dest.base)) return null;
                    const key = isIdentifier(dest.index) ? resolveId(ctx, dest.index.name, env)
                        : (isPrimitiveLiteral(dest.index) ? sourceOf(ctx.source, dest.index) : null);
                    const baseName = dest.base.name;
                    const base = baseName === "_env" ? null : resolveId(ctx, baseName, env);
                    const stableBase = baseName === "_env" || hasActiveLocal(ctx, baseName, env) ||
                        (typeof base === "string" && env.get(upvalueAliasKey(ctx, baseName)) === base) ||
                        (typeof base === "string" && env.get(mutationBaseOwnerKey(baseName)) === base);
                    const decoded = renderOrdinaryIndexCompoundWrite({ baseName, renderedBase: base, renderedKey: key, renderedValue: value, stableBase, operator: op.operator });
                    if (!decoded) return null;
                    line = decoded.line;
                }
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    ctx.out.push(line);
                }
                continue;
            }
            if (op.kind === "compound-register-write") {
                const target = activeLocalDisplay(ctx, op.targetName, env);
                const value = render(ctx, rhs, env);
                if (typeof target !== "string" || typeof value !== "string" || typeof op.operator !== "string") return null;
                const line = target + " " + op.operator + "= " + value;
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    ctx.out.push(line);
                }
                continue;
            }

            if (op.kind === "index-write") {
                const globalAssignmentBatch = matchCompilerGlobalAssignmentBatch(block.body, i, {
                    skipIndex: block.transitionIndex,
                    resolveIdentifier: identifier => resolveRenderableId(ctx, identifier, env),
                    isCompilerTemp: identifier => !hasActiveLocal(ctx, identifier, env) &&
                        !hasPathUpvalueCell(ctx, identifier, env) && !ctx.upvalueCells.has(identifier),
                    neutralReturnName: ctx.returnName,
                });
                if (globalAssignmentBatch) {
                    if (globalAssignmentBatch.neutralIndices?.has(terminalReturnIndex)) terminalReturnLine = "return";
                    if (markers.length !== 0) {
                        if (!ctx.allowConditionalIf) return null;
                        effects = [...effects, globalAssignmentBatch.line];
                    } else {
                        ctx.out.push(globalAssignmentBatch.line);
                    }
                    i = globalAssignmentBatch.endIndex;
                    continue;
                }
                const capturedDestination = capturedSlotName(ctx, dest);
                const reservedPackCaptureOwner = ctx.structuredPackFutureCaptureOwners.get(id + ":" + i);
                if (reservedPackCaptureOwner) {
                    const reservedPack = ctx.structuredPacks.get(reservedPackCaptureOwner.packId);
                    const reservedInfo = reservedPack?.slots.get(reservedPackCaptureOwner.slot);
                    if (reservedPack?.emitted && reservedInfo?.display &&
                        capturedDestination === reservedPackCaptureOwner.capturedDestination &&
                        reservedInfo.ownerCaptured === capturedDestination &&
                        isIdentifier(rhs, reservedPackCaptureOwner.carrierReg) &&
                        resolveId(ctx, rhs.name, env) === reservedInfo.display) {
                        continue;
                    }
                }
                if (typeof capturedDestination === "string") {
                    const value = render(ctx, rhs, env);
                    if (typeof value !== "string") return null;
                    const line = capturedDestination + " = " + value;
                    if (markers.length !== 0) {
                        if (!ctx.allowConditionalIf) return null;
                        effects = [...effects, line];
                    } else {
                        ctx.out.push(line);
                    }
                    continue;
                }
                if (isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index) &&
                    (ctx.upvalueCells.has(dest.index.name) || hasPathUpvalueCell(ctx, dest.index.name, env))) {
                    const value = render(ctx, rhs, env);
                    if (typeof value !== "string") return null;
                    const pathCell = hasPathUpvalueCell(ctx, dest.index.name, env);
                    const cellIdentity = upvalueCellIdentity(ctx, dest.index.name, env);
                    const existing = upvalueCellBinding(ctx, dest.index.name, env);
                    if (typeof existing === "string") {
                        const line = existing + " = " + value;
                        if (markers.length !== 0) {
                            if (!ctx.allowConditionalIf) return null;
                            effects = [...effects, line];
                        } else {
                            ctx.out.push(line);
                        }
                        continue;
                    }
                    const display = allocateValueDisplay(ctx);
                    if (pathCell) {
                        if (cellIdentity) {
                            if (!bindUpvalueCellIdentity(ctx, cellIdentity, display, env)) return null;
                        } else {
                            // Synthetic loop bindings can already carry the recovered source
                            // name directly and therefore have no allocUpvalue identity.
                            env.set(pathUpvalueCellKey(ctx, dest.index.name), display);
                        }
                        if (markers.length !== 0) {
                            if (!ctx.allowConditionalIf) return null;
                            ctx.pathLocalBindingNames.add(display);
                            effects = [...effects, "local " + display + " = " + value];
                        } else {
                            // The declaration dominates future branches, but cell liveness still
                            // remains candidate-local through the identity mapping above.
                            ctx.out.push("local " + display + " = " + value);
                        }
                    } else {
                        // Attach the recovered binding to this allocation epoch as well as the
                        // current physical register. Deferred closures keep the epoch identity
                        // after release/reuse of the register.
                        if (markers.length !== 0) return null;
                        ctx.upvalueCellBindings.set(dest.index.name, display);
                        if (cellIdentity && !bindUpvalueCellIdentity(ctx, cellIdentity, display, env)) return null;
                        ctx.out.push("local " + display + " = " + value);
                    }
                    continue;
                }
                if (!isIdentifier(dest.base)) return null;
                const key = isIdentifier(dest.index) ? resolveId(ctx, dest.index.name, env)
                    : (isPrimitiveLiteral(dest.index) ? sourceOf(ctx.source, dest.index) : null);
                const value = render(ctx, rhs, env);
                if (key == null || value == null) return null;
                const baseName = dest.base.name;
                const base = baseName === "_env" ? null : resolveId(ctx, baseName, env);
                const singleUseCallBase = typeof base === "string" && provenSingleUseCallResultAt(ctx, id, i, baseName);
                const stableBase = baseName === "_env" || hasActiveLocal(ctx, baseName, env) ||
                    (typeof base === "string" && env.get(upvalueAliasKey(ctx, baseName)) === base) ||
                    (typeof base === "string" && env.get(mutationBaseOwnerKey(baseName)) === base) || singleUseCallBase;
                const decoded = renderOrdinaryIndexWrite({ baseName, renderedBase: base, renderedKey: key, renderedValue: value, stableBase });
                if (!decoded) return null;
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    effects = [...effects, decoded.line];
                } else {
                    ctx.out.push(decoded.line);
                }
                continue;
            }
            if (op.kind !== "register-write") return null;
            const name = op.targetName;
            const rhsCallKind = callKind(rhs);
            const capturedRhsAlias = capturedSlotName(ctx, rhs);
            const inheritedUpvalueAlias = typeof capturedRhsAlias === "string"
                ? capturedRhsAlias
                : (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index)
                    ? upvalueCellBinding(ctx, rhs.index.name, env)
                    : (isIdentifier(rhs) ? (env.get(upvalueAliasKey(ctx, rhs.name)) ?? null) : null));
            env.delete(upvalueAliasKey(ctx, name));
            env.delete(mutationBaseOwnerKey(name));
            if (rhs?.type !== "NilLiteral") env.delete(deadJoinTempKey(ctx, name));

            const reservedPackExtraction = ctx.structuredPackFutureExtractions.get(id + ":" + i);
            if (reservedPackExtraction) {
                const reservedPack = ctx.structuredPacks.get(reservedPackExtraction.packId);
                const reservedInfo = reservedPack?.slots.get(reservedPackExtraction.slot);
                if (reservedPack?.emitted && reservedInfo?.display && name === reservedPackExtraction.carrierReg &&
                    rhs?.type === "IndexExpression" && isIdentifier(rhs.base, reservedPackExtraction.packReg) &&
                    rhs.index?.type === "NumericLiteral" && Number(rhs.index.value) === reservedPackExtraction.slot) {
                    env.set(name, reservedInfo.display);
                    continue;
                }
            }

            const reservedPackOwnerCopy = ctx.structuredPackFutureOwnerCopies.get(id + ":" + i);
            if (reservedPackOwnerCopy) {
                const reservedPack = ctx.structuredPacks.get(reservedPackOwnerCopy.packId);
                const reservedInfo = reservedPack?.slots.get(reservedPackOwnerCopy.slot);
                if (reservedPack?.emitted && reservedInfo?.display && reservedInfo.ownerReg === name &&
                    isIdentifier(rhs, reservedPackOwnerCopy.carrierReg) && resolveId(ctx, rhs.name, env) === reservedInfo.display) {
                    env.set(name, reservedInfo.display);
                    reservedInfo.ownerDeferred = false;
                    continue;
                }
            }

            if (ctx.renderAsFunction && isCompilerVarargPack(ctx, rhs)) {
                if (name === ctx.stateName || name === ctx.returnName || hasActiveLocal(ctx, name, env)) return null;
                ctx.sawVarargs = true;
                env.set(name, ctx.varargPackMarker);
                continue;
            }

            if (i !== terminalReturnIndex) {
                const packFields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
                if (packFields.length === 1 && packFields[0]?.type === "TableValue" && packFields[0].value?.type === "CallExpression" && !sourcePackedTablePackReg(rhs, terminalPackExprs)) {
                    const packed = render(ctx, packFields[0].value, env, true, terminalPackExprs);
                    if (typeof packed === "string") terminalPackExprs.set(name, packed);
                    else terminalPackExprs.delete(name);
                } else {
                    terminalPackExprs.delete(name);
                }
            }

            const packFieldsForStructured = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
            const structuredPackCallNode = packFieldsForStructured.length === 1 && packFieldsForStructured[0]?.type === "TableValue" &&
                packFieldsForStructured[0].value?.type === "CallExpression" && !sourcePackedTablePackReg(rhs, terminalPackExprs) ? packFieldsForStructured[0].value : null;
            if (structuredPackCallNode && !isCompilerVarargPack(ctx, rhs)) {
                const expectedSlots = expectedPackSlotsInBlock(ctx, block, i, name);
                if (expectedSlots) {
                    const call = render(ctx, structuredPackCallNode, env, true, terminalPackExprs);
                    if (typeof call !== "string") return null;
                    const packId = String(++ctx.nextStructuredPackId);
                    const pack = { id: packId, packReg: name, call, expectedSlots, slots: new Map(), emitted: false };
                    for (const slot of expectedSlots) pack.slots.set(slot, { slot, tempRegs: new Set(), ownerReg: null, display: null, ambiguous: false, ownerDeferred: false });
                    ctx.structuredPacks.set(packId, pack);
                    if (!preclaimFutureStructuredPackSlots(ctx, pack, id, i)) return null;
                    env.set(name, ctx.structuredPackPrefix + packId);
                    effects = flushReadyStructuredPacks(ctx, env, markers, effects, false);
                    if (effects === null) return null;
                    continue;
                }
                // RETURN_ALL packs that are never split into numbered slots may be
                // forwarded directly into the final argument of the next call. Keep
                // the already-proven multi-return expression in terminalPackExprs and
                // suppress the compiler transport table itself. The forward-only proof
                // is deliberately strict so source table identity or duplicated calls
                // cannot be erased.
                if (terminalPackExprs.has(name) && isForwardOnlyPackUseInBlock(ctx, block, i, name)) {
                    env.delete(name);
                    continue;
                }
            }

            const packIndexMeta = rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && rhs.index?.type === "NumericLiteral"
                ? { packId: structuredPackId(ctx, resolveId(ctx, rhs.base.name, env)), slot: Number(rhs.index.value) } : null;
            if (packIndexMeta?.packId) {
                const pack = ctx.structuredPacks.get(packIndexMeta.packId);
                const info = pack?.slots.get(packIndexMeta.slot);
                if (!pack || !info || pack.emitted) return null;
                info.tempRegs.add(name);
                maybeOwnStructuredPackSlot(ctx, pack, packIndexMeta.slot, name, id, i);
                env.set(name, structuredPackSlotToken(ctx, packIndexMeta.packId, packIndexMeta.slot));
                if (!info.ownerReg && !info.ambiguous) preclaimFutureStructuredPackOwner(ctx, pack, packIndexMeta.slot, name, id, i);
                effects = flushReadyStructuredPacks(ctx, env, markers, effects, false);
                if (effects === null) return null;
                continue;
            }

            const copiedPackSlot = isIdentifier(rhs) ? structuredPackSlot(ctx, resolveId(ctx, rhs.name, env)) : null;
            if (copiedPackSlot) {
                const pack = ctx.structuredPacks.get(copiedPackSlot.packId);
                const info = pack?.slots.get(copiedPackSlot.slot);
                if (!pack || !info || pack.emitted) return null;
                info.tempRegs.add(name);
                maybeOwnStructuredPackSlot(ctx, pack, copiedPackSlot.slot, name, id, i);
                env.set(name, structuredPackSlotToken(ctx, copiedPackSlot.packId, copiedPackSlot.slot));
                if (!info.ownerReg && !info.ambiguous) preclaimFutureStructuredPackOwner(ctx, pack, copiedPackSlot.slot, name, id, i);
                effects = flushReadyStructuredPacks(ctx, env, markers, effects, false);
                if (effects === null) return null;
                continue;
            }

            // A physical register can be reused after an early source epoch
            // was emitted.  The later definition owns the next cleanup epoch;
            // do not let the old marker suppress that new value.
            if (rhs?.type !== "NilLiteral" && !hasActiveLocal(ctx, name, env)) ctx.earlyCleanupPending.delete(name);

            if (isIdentifier(rhs, "args") && name !== ctx.stateName && name !== ctx.returnName) {
                env.set(name, "args");
                continue;
            }
            if (rhsCallKind === "alloc-upvalue" && (rhs.arguments || []).length === 0) {
                if (ctx.upvalueCells.has(name) || hasPathUpvalueCell(ctx, name, env) || hasActiveLocal(ctx, name, env)) return null;
                const identity = allocateUpvalueCellIdentity(ctx);
                // Upvalue-cell liveness is CFG-candidate state even when allocation happens
                // in the root preheader. A later branch may release the physical cell on one
                // path while a sibling path still captures/uses the same allocation epoch.
                // Keeping the physical->epoch mapping in env prevents cross-path mutation.
                env.set(pathUpvalueCellKey(ctx, name), identity);
                env.delete(name);
                continue;
            }
            if (rhsCallKind === "release-upvalue" &&
                (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0], name)) {
                if (hasPathUpvalueCell(ctx, name, env)) {
                    env.delete(pathUpvalueCellKey(ctx, name));
                    env.delete(name);
                    continue;
                }
                if (ctx.upvalueCells.has(name)) {
                    ctx.upvalueCells.delete(name);
                    ctx.upvalueCellBindings.delete(name);
                    ctx.upvalueCellIdentities.delete(name);
                    env.delete(name);
                    continue;
                }
            }
            if (i === terminalReturnIndex) {
                const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
                const values = [];
                for (const field of fields) {
                    if (field?.type !== "TableValue") return null;
                    let value = null;
                    const node = field.value;
                    if (node?.type === "CallExpression" && isIdentifier(node.base, "unpack") && (node.arguments || []).length === 1 && isIdentifier(node.arguments[0])) {
                        const packReg = node.arguments[0].name;
                        if (terminalPackExprs.has(packReg)) value = terminalPackExprs.get(packReg);
                        else if (resolveId(ctx, packReg, env) === "args" || resolveId(ctx, packReg, env) === ctx.varargPackMarker) { value = "..."; ctx.sawVarargs = true; }
                    }
                    if (value === null) value = render(ctx, node, env, true);
                    if (typeof value !== "string") return null;
                    values.push(value);
                }
                terminalReturnLine = values.length ? `return ${values.join(", ")}` : "return";
                continue;
            }
            if (name === ctx.returnName && isEmptyTable(rhs)) continue;

            const transportKind = isIdentifier(rhs) && (rhs.name === ctx.stateName || rhs.name === ctx.returnName)
                ? transportSourceKind(ctx, block, i, rhs.name) : null;
            // A terminal-live source closure can have only one static call site
            // (for example inside a recovered loop). The compiler's explicit
            // state/ReturnVal handoff from createClosureN is ownership evidence;
            // direct register=createClosureN anonymous TEMPs never enter here.
            const terminalClosureTransport = transportKind === "closure" && valueMayBeReadAfter(ctx, id, i, name) &&
                !hasFutureNonNilWrite(ctx, id, i, name);
            const terminalTransportEpoch = cleanupOrTerminalEpoch(ctx, id, i, name);
            const terminalReusedVarEpoch = ctx.cleanupRegs.has(name) && terminalTransportEpoch.valid &&
                !terminalTransportEpoch.sawCleanup && !hasFutureNonNilWrite(ctx, id, i, name);
            const terminalUsedTransportAlias = ctx.allowConditionalIf && isVmRegisterName(name) &&
                !hasActiveLocal(ctx, name, env) && isIdentifier(rhs) && (rhs.name === ctx.stateName || rhs.name === ctx.returnName) &&
                (terminalStableUsedEpoch(ctx, id, i, name) || terminalClosureTransport || terminalReusedVarEpoch);
            if (terminalUsedTransportAlias) {
                const value = render(ctx, rhs, env);
                const kind = transportKind ?? transportSourceKind(ctx, block, i, rhs.name);
                if (typeof value !== "string") {
                    const deferred = deferredClosureFromRhs(ctx, rhs, env, rhsCallKind);
                    if (!deferred || kind !== "closure") return null;
                    const installed = installPendingDeferredLocal(ctx, env, markers, effects, name, deferred, true);
                    if (installed === null) return null;
                    effects = installed;
                    continue;
                }
                const display = kind === "table" ? allocateTableDisplay(ctx) : allocateValueDisplay(ctx);
                const declaration = value === "nil" ? `local ${display}` : `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    ctx.pathLocalBindingNames.add(display);
                    env.set(pathLocalOwnerKey(ctx, name), display);
                    effects = [...effects, declaration];
                } else {
                    ctx.localNames.set(name, display);
                    ctx.locals.add(name);
                    ctx.terminalLiveLocals.add(name);
                    ctx.out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            // Prometheus uses nil both as a real expression value and as dead register cleanup.
            // If this exact nil definition reaches a read before any overwrite, it is semantic
            // data and must flow through ordinary value/source-storage handling below. Only a
            // dead nil definition is eligible for compiler-cleanup removal.
            const semanticNilDefinition = rhs?.type === "NilLiteral" && valueMayBeReadAfter(ctx, id, i, name);
            if (ctx.cleanupRegs.has(name) && rhs?.type === "NilLiteral" && !semanticNilDefinition) {
                if (!hasActiveLocal(ctx, name, env) && env.get(deadJoinTempKey(ctx, name)) === true) {
                    env.delete(deadJoinTempKey(ctx, name));
                    env.delete(name);
                    continue;
                }
                if (!hasActiveLocal(ctx, name, env) && isRedundantReleasedUpvalueCleanup(ctx, block, i, name)) {
                    env.delete(name);
                    continue;
                }
                if (isPendingDeferredLocalValue(env.get(name))) return null;
                const activeDisplay = activeLocalDisplay(ctx, name, env);
                if (activeDisplay !== null && ctx.pathLocalBindingNames.has(activeDisplay)) {
                    env.delete(pathLocalOwnerKey(ctx, name));
                    env.delete(name);
                    continue;
                }
                if (ctx.earlyCleanupPending.has(name)) {
                    ctx.earlyCleanupPending.delete(name);
                    ctx.locals.delete(name);
                    ctx.localNames.delete(name);
                    env.delete(name);
                    continue;
                }
                if (ctx.locals.has(name)) {
                    ctx.locals.delete(name);
                    ctx.localNames.delete(name);
                    env.delete(name);
                    continue;
                }
                // An absent candidate value is not enough to prove redundancy: it
                // may represent an ambiguous join. Drop this dead nil only when
                // every reaching definition is itself a previously proven dead nil
                // cleanup, with no intervening value epoch.
                if (!env.has(name) && allReachingDefinitionsAreDeadNilCleanup(ctx, id, i, name)) {
                    env.delete(name);
                    continue;
                }
                if (ctx.accumulatorRegs.has(name)) {
                    // This fallback exists only for legacy ambiguous multi-definition
                    // storage. Never move it out of a branch/loop: without an earlier
                    // proven epoch start, preserving evaluation order is not possible.
                    if (markers.length !== 0) return null;
                    const value = env.get(name);
                    if (value == null) return null;
                    const display = allocateValueDisplay(ctx);
                    ctx.out.push(`local ${display} = ${value}`);
                    env.delete(name);
                    continue;
                }
                return null;
            }

            // Function-call statements are represented by a write to a VM
            // temporary (often ReturnVal).  If that result is overwritten
            // without a read, preserve the call itself.  A path-dependent
            // call cannot be represented as a bare source statement here, so
            // fail closed instead of moving it ctx.out of its branch.
            const callWritesSourceStorage = rhsCallKind === "call" &&
                (hasActiveLocal(ctx, name, env) || sourceStorageStartsHere(ctx, id, i, name, markers));
            const callResultBecomesMutationBase = rhsCallKind === "call" &&
                !hasActiveLocal(ctx, name, env) && valueMayBeIndexWriteBaseAfter(ctx, id, i, name);
            if (rhsCallKind === "call" && !callWritesSourceStorage && !callResultBecomesMutationBase &&
                (!ctx.cleanupRegs.has(name) || !valueMayBeReadAfter(ctx, id, i, name))) {
                const promotedArguments = [];
                if (markers.length === 0) {
                    for (const argument of rhs.arguments || []) {
                        if (!isIdentifier(argument) || !ctx.cleanupRegs.has(argument.name) || ctx.locals.has(argument.name) || ctx.earlyCleanupPending.has(argument.name)) continue;
                        if (valueMayBeReadAfter(ctx, id, i, argument.name)) continue;
                        // Promote only a proven source-storage epoch. An explicit TEMP -> VAR copy is
                        // ownership evidence; an erased direct promotion is accepted only when
                        // the definition reaches cleanup before any later non-nil write. Loop
                        // preheaders keep their additional future-write guard because they can
                        // borrow the eventual VAR register for argument transport before handoff.
                        if (!provenCallArgumentSourceEpoch(ctx, id, i, argument.name)) continue;
                        if (ctx.options?.suppressFutureWriteCallArgumentPromotion &&
                            hasFutureNonNilWrite(ctx, id, i, argument.name)) continue;
                        const argumentValue = env.get(argument.name);
                        if (typeof argumentValue !== "string") return null;
                        const display = allocateValueDisplay(ctx);
                        ctx.localNames.set(argument.name, display);
                        ctx.locals.add(argument.name);
                        ctx.out.push(`local ${display} = ${argumentValue}`);
                        env.set(argument.name, display);
                        ctx.earlyCleanupPending.add(argument.name);
                        promotedArguments.push(argument.name);
                    }
                }
                const value = render(ctx, rhs, env, false, terminalPackExprs);
                if (value == null) return null;
                if (!valueMayBeReadAfter(ctx, id, i, name)) {
                    if (markers.length !== 0) {
                        if (!ctx.allowConditionalIf) return null;
                        effects = [...effects, value];
                    } else {
                        ctx.out.push(value);
                    }
                    env.delete(name);
                } else {
                    env.set(name, value);
                }
                for (const argumentName of promotedArguments) {
                    ctx.locals.delete(argumentName);
                    ctx.localNames.delete(argumentName);
                    env.delete(argumentName);
                }
                continue;
            }

            const sourcePackedTableReg = sourcePackedTablePackReg(rhs, terminalPackExprs);
            // Compiler multi-return transport can feed the final argument of an ordinary assigned call.
            // Pass the proven pack map into call rendering too; real source-packed tables are removed
            // from terminalPackExprs when their source table constructor is recovered.
            const singleCallPacks = rhs?.type === "CallExpression" || sourcePackedTableReg ? terminalPackExprs : null;
            const value = render(ctx, rhs, env, false, singleCallPacks);
            if (value == null) {
                // Closure construction is a semantic value. Track capture-cell identities
                // independently of statement/register order. Source ownership may be proven
                // before every captured binding is renderable, so keep a pending source local
                // and materialize it only when its dependency bindings are available.
                const deferred = deferredClosureFromRhs(ctx, rhs, env, rhsCallKind);
                if (deferred) {
                    if (sourceStorageStartsHere(ctx, id, i, name, markers)) {
                        const installed = installPendingDeferredLocal(ctx, env, markers, effects, name, deferred, false);
                        if (installed === null) return null;
                        effects = installed;
                    } else {
                        env.set(name, deferred);
                    }
                    continue;
                }
                // Borrowed state/temp writes may be dead before overwrite; only allow
                // an immediate same-register overwrite inside this block.
                const next = block.body[i + 1];
                if (name !== ctx.stateName && !hasActiveLocal(ctx, name, env) && isSingleAssignment(next, name)) continue;
                return null;
            }

            // Source-storage ownership is epoch-local. A source binding may
            // end either at its compiler nil cleanup or because the function
            // returns before that cleanup executes. Later writes after either
            // boundary belong to a new physical-register epoch.
            const storageEpochEnd = cleanupOrTerminalEpoch(ctx, id, i, name);
            // Source ownership is epoch-local: an unused source local is still source.
            // If this exact definition reaches compiler nil cleanup before any non-nil
            // rewrite on every path, Prometheus has promoted this value into VAR storage.
            const stableStorageEpoch = ctx.allowConditionalIf && ctx.cleanupRegs.has(name) && !ctx.locals.has(name) &&
                storageEpochEnd.valid && storageEpochEnd.sawCleanup;
            // A semantic nil initializer may be the source VAR itself and reach function
            // termination without a later compiler cleanup. Prove that case from the exact
            // epoch: it must dominate from the root path, be observed later, remain stable
            // through all uses, and never be overwritten. This is storage proof, not a
            // special case for any register/state/layout.
            const terminalStableNilEpoch = ctx.allowConditionalIf && markers.length === 0 &&
                rhs?.type === "NilLiteral" && semanticNilDefinition && !ctx.locals.has(name) &&
                terminalStableUsedEpoch(ctx, id, i, name) && !hasFutureNonNilWrite(ctx, id, i, name);
            const conditionalUpdatedEpoch = ctx.allowConditionalIf && markers.length === 0 &&
                !ctx.locals.has(name) ? conditionalUpdatedStorageEpoch(ctx, id, i, name) : null;
            // A storage binding that survives a conditional join must already
            // exist before entering that conditional. If the same physical
            // register is written on a branch before any active binding exists,
            // that write belongs to an earlier/later TEMP epoch, not to this
            // persistent source lifetime. Only a marker-free definition may
            // start the persistent binding; stable branch-local epochs retain
            // their separate path-scoped proof.
            const forcedPersistentStarts = ctx.options?.forcedPersistentStorageStarts;
            const forcedPersistentRegs = ctx.options?.forcedPersistentStorageRegs;
            const provenLoopPreheaderStart = forcedPersistentStarts instanceof Map &&
                forcedPersistentStarts.get(name) instanceof Set &&
                forcedPersistentStarts.get(name).has(id + ":" + i);
            const isForcedLoopStorage = forcedPersistentRegs instanceof Set && forcedPersistentRegs.has(name);
            const startsPersistentStorage = ctx.persistentStorageRegs.has(name) &&
                (provenLoopPreheaderStart || (!isForcedLoopStorage && markers.length === 0));
            if ((startsPersistentStorage || stableStorageEpoch || terminalStableNilEpoch || conditionalUpdatedEpoch?.proven) && !hasActiveLocal(ctx, name, env)) {
                const display = allocateValueDisplay(ctx);
                const declaration = `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    ctx.pathLocalBindingNames.add(display);
                    env.set(pathLocalOwnerKey(ctx, name), display);
                    effects = [...effects, declaration];
                } else {
                    ctx.localNames.set(name, display);
                    ctx.locals.add(name);
                    if (terminalStableNilEpoch || conditionalUpdatedEpoch?.terminalLive) ctx.terminalLiveLocals.add(name);
                    ctx.out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            // Some compiler TEMPs hold an object/index result that must remain
            // stable across later key/value evaluation before a field write.
            // Materialize that exact epoch at its original definition point,
            // but do not classify the physical register as a source local.
            if (!hasActiveLocal(ctx, name, env) && valueMayBeIndexWriteBaseAfter(ctx, id, i, name)) {
                // A TEMP alias to an already-proven captured/source binding does not
                // need new storage. Preserve its owner provenance so mutation renders
                // directly against the existing source object instead of inventing an
                // alias local. Only explicit alias identity qualifies here.
                if (typeof inheritedUpvalueAlias === "string" && value === inheritedUpvalueAlias) {
                    env.set(name, value);
                    env.set(upvalueAliasKey(ctx, name), inheritedUpvalueAlias);
                    continue;
                }
                const display = allocateValueDisplay(ctx);
                const declaration = `local ${display} = ${value}`;
                if (markers.length !== 0) effects = [...effects, declaration];
                else ctx.out.push(declaration);
                env.set(name, display);
                env.set(mutationBaseOwnerKey(name), display);
                continue;
            }

            if (ctx.cleanupRegs.has(name) && !ctx.accumulatorRegs.has(name) && !hasActiveLocal(ctx, name, env) && isIdentifier(rhs) && rhs.name !== name) {
                const display = allocateValueDisplay(ctx);
                const declaration = `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    ctx.pathLocalBindingNames.add(display);
                    env.set(pathLocalOwnerKey(ctx, name), display);
                    effects = [...effects, declaration];
                } else {
                    ctx.localNames.set(name, display);
                    ctx.locals.add(name);
                    ctx.out.push(declaration);
                }
                env.set(name, display);
            } else if (isPendingDeferredLocalValue(env.get(name))) {
                // A source closure local exists but its capture dependencies are not
                // renderable yet. Do not turn a later write into an assignment to an
                // internal owner token; unresolved semantic use is ambiguous.
                return null;
            } else if (hasActiveLocal(ctx, name, env)) {
                const line = `${activeLocalDisplay(ctx, name, env)} = ${value}`;
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    ctx.out.push(line);
                }
                env.set(name, activeLocalDisplay(ctx, name, env));
            } else {
                env.set(name, value);
                if (typeof inheritedUpvalueAlias === "string" && value === inheritedUpvalueAlias) {
                    env.set(upvalueAliasKey(ctx, name), inheritedUpvalueAlias);
                }
            }
        }

        effects = flushReadyStructuredPacks(ctx, env, markers, effects, true);
        if (effects === null) return null;
        for (const value of env.values()) {
            if (structuredPackId(ctx, value) || structuredPackSlot(ctx, value)) return null;
        }

        const loopControlMap = ctx.options?.loopControlByBlockId;
        const loopControl = loopControlMap instanceof Map ? loopControlMap.get(id) : null;
        if (loopControl !== null && loopControl !== undefined) {
            if ((loopControl !== "break" && loopControl !== "continue") || block.transition.kind !== "jump") return null;
            effects = [...effects, loopControl];
        }

        ctx.processed.add(id);
        effects = flushReadyPendingDeferredLocals(ctx, env, markers, effects);
        const tr = block.transition;
        const sends = [];
        if (tr.kind === "stop") {
            if (terminalReturnLine === null) return null;
            let terminalCandidate = {
                env: new Map(env),
                markers: [...markers],
                effects: [...effects, terminalReturnLine],
                terminal: true,
            };
            terminalCandidate = foldTerminalRepeatScopes(ctx, terminalCandidate);
            if (!terminalCandidate) return null;
            ctx.terminalCandidates.push(terminalCandidate);
            if (!collapseTerminalCandidates(ctx)) return null;
        } else if (tr.kind === "jump") sends.push({ target: tr.target, env, markers, effects });
        else if (tr.kind === "branch") {
            const condition = resolveId(ctx, tr.conditionRegister, env);
            if (condition == null) return null;
            const effectCount = effects.length;
            sends.push({ target: tr.onTrue, env, markers: [...markers, { condition, truth: true, effectCount, branchId: id }], effects });
            sends.push({ target: tr.onFalse, env, markers: [...markers, { condition, truth: false, effectCount, branchId: id }], effects });
        }
        for (const send of sends) {
            if (!ctx.incoming.has(send.target)) ctx.incoming.set(send.target, []);
            ctx.incoming.get(send.target).push({
                env: new Map(send.env),
                markers: [...(send.markers || [])],
                effects: [...(send.effects || [])],
            });
            ctx.indegree.set(send.target, ctx.indegree.get(send.target) - 1);
            if (ctx.indegree.get(send.target) === 0) ctx.processingQueue.push(send.target);
        }
    }

    if (!collapseTerminalCandidates(ctx)) return null;
    if (ctx.terminalCandidates.length !== 1 || (ctx.terminalCandidates[0].markers || []).length !== 0) return null;
    const terminalEffects = [...(ctx.terminalCandidates[0].effects || [])];
    // Compiler fallthrough and an explicit empty return share the same final VM
    // bookkeeping.  At root terminal scope a trailing bare return is therefore
    // not provably source-authored; omit only that final redundant marker.
    if (terminalEffects[terminalEffects.length - 1] === "return") terminalEffects.pop();
    for (const effect of terminalEffects) ctx.out.push(effect);
    for (const name of ctx.terminalLiveLocals) {
        ctx.locals.delete(name);
        ctx.localNames.delete(name);
    }
    if (ctx.processed.size !== ctx.reachable.size || ctx.locals.size !== 0 || ctx.out.length === 0) return null;
    const logicalReductionApplied = ctx.logicalReduction.originalReachableStateIds.size > ctx.reachable.size;
    const provenLoopControl =
        (ctx.options?.loopBranchIds instanceof Set && ctx.options.loopBranchIds.size > 0) ||
        (ctx.options?.repeatBranchIds instanceof Set && ctx.options.repeatBranchIds.size > 0) ||
        (ctx.options?.terminalRepeatBodyStarts instanceof Map && ctx.options.terminalRepeatBodyStarts.size > 0) ||
        (ctx.options?.numericForBranchIds instanceof Set && ctx.options.numericForBranchIds.size > 0) ||
        (ctx.options?.genericForBranchIds instanceof Set && ctx.options.genericForBranchIds.size > 0);
    if (ctx.allowConditionalIf && ctx.conditionalIfCount < 1 && !provenLoopControl &&
        ctx.options?.allowStraightLineStructured !== true &&
        !(ctx.options?.allowLogicalOnlyStructured === true && logicalReductionApplied)) {
        if (!ctx.out.some(line => /^if\s/.test(line) || /^while\s/.test(line))) return null;
        ctx.conditionalIfCount = 1;
    }
    let outputSource = renderProgram(ctx.out);
    if (ctx.renderAsFunction) {
        const params = [...ctx.parameterNames];
        if (ctx.sawVarargs) params.push("...");
        outputSource = renderFunction(params, ctx.out);
    }
    return {
        source: outputSource,
        statementCount: ctx.out.length,
        localCount: ctx.valueCount + ctx.tableCount,
        stateCount: ctx.rootReachableOnly ? ctx.logicalReduction.originalReachableStateIds.size : ctx.originalLeaves.size,
        reachableStateIds: [...ctx.logicalReduction.originalReachableStateIds],
        conditionalIfCount: ctx.conditionalIfCount,
    };
}

module.exports = { matchMultiStateLogicalLocals };
