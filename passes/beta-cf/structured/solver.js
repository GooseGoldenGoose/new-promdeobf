"use strict";

const { createStructuredContext } = require("./context");
const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, pathLocalOwnerKey, pathUpvalueCellKey, hasPathUpvalueCell, upvalueCellBinding, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
const { isCompilerVarargPack, isVarargUnpack, expectedPackSlotsInBlock, cleanupOrTerminalEpoch, maybeOwnStructuredPackSlot, preclaimFutureStructuredPackOwner, preclaimFutureStructuredPackSlots, flushStructuredPack, flushReadyStructuredPacks } = require("./packs");
const { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, analyzePersistentStorage } = require("./lifetime");
const { render } = require("./render");
const { renderFunction, renderProgram } = require("../render");
const { mergeElseIfCandidates, indentConditionalEffect, mergeCandidates } = require("./branches");
const { markersSharePrefix, terminalSiblingMatch, guardLine, collapseTerminalCandidates, foldTerminalGuards } = require("./terminal");


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
        // A join can become graph-ready before an abrupt sibling has finished
        // producing terminal candidates because terminal paths have no edge to
        // the join. Delay only when that opposite branch is a proven closed,
        // acyclic terminal region inside the loop and one of its states is
        // already ready to process.
        let pendingTerminalSibling = null;
        if (candidates.length > 1) {
            for (const candidate of candidates) {
                const region = loopTerminalSiblingRegion(ctx, candidate, id, false);
                if (region && ctx.processingQueue.some(readyId => region.has(readyId))) {
                    pendingTerminalSibling = region;
                    break;
                }
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
            const folded = foldLoopAbruptGuards(ctx, terminalFolded, id);
            if (!folded) return null;
            normalizedCandidates.push(folded);
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
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];

            if (dest?.type === "IndexExpression") {
                const capturedDestination = capturedSlotName(ctx, dest);
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
                        if (!ctx.allowConditionalIf || markers.length === 0) return null;
                        env.set(pathUpvalueCellKey(ctx, dest.index.name), display);
                        ctx.pathLocalBindingNames.add(display);
                        effects = [...effects, "local " + display + " = " + value];
                    } else {
                        // Root cell initialization must dominate later routing.
                        if (markers.length !== 0) return null;
                        ctx.upvalueCellBindings.set(dest.index.name, display);
                        ctx.out.push("local " + display + " = " + value);
                    }
                    continue;
                }
                if (!isIdentifier(dest.base)) return null;
                const base = resolveId(ctx, dest.base.name, env);
                const stableBase = hasActiveLocal(ctx, dest.base.name, env) ||
                    (typeof base === "string" && env.get(upvalueAliasKey(ctx, dest.base.name)) === base);
                if (!stableBase) return null;
                const key = isIdentifier(dest.index) ? resolveId(ctx, dest.index.name, env)
                    : (isPrimitiveLiteral(dest.index) ? sourceOf(ctx.source, dest.index) : null);
                const value = render(ctx, rhs, env);
                if (base == null || key == null || value == null) return null;
                const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                const target = member && isLuaIdentifier(member) ? base + "." + member : base + "[" + key + "]";
                const line = target + " = " + value;
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    ctx.out.push(line);
                }
                continue;
            }
            if (!isIdentifier(dest)) return null;
            const name = dest.name;
            const capturedRhsAlias = capturedSlotName(ctx, rhs);
            const inheritedUpvalueAlias = typeof capturedRhsAlias === "string"
                ? capturedRhsAlias
                : (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index)
                    ? upvalueCellBinding(ctx, rhs.index.name, env)
                    : (isIdentifier(rhs) ? (env.get(upvalueAliasKey(ctx, rhs.name)) ?? null) : null));
            env.delete(upvalueAliasKey(ctx, name));

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
                if (packFields.length === 1 && packFields[0]?.type === "TableValue" && packFields[0].value?.type === "CallExpression") {
                    const packed = render(ctx, packFields[0].value, env, true);
                    if (typeof packed === "string") terminalPackExprs.set(name, packed);
                    else terminalPackExprs.delete(name);
                } else {
                    terminalPackExprs.delete(name);
                }
            }

            const packFieldsForStructured = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
            const structuredPackCallNode = packFieldsForStructured.length === 1 && packFieldsForStructured[0]?.type === "TableValue" &&
                packFieldsForStructured[0].value?.type === "CallExpression" ? packFieldsForStructured[0].value : null;
            if (structuredPackCallNode && !isCompilerVarargPack(ctx, rhs)) {
                const expectedSlots = expectedPackSlotsInBlock(ctx, block, i, name);
                if (expectedSlots) {
                    const call = render(ctx, structuredPackCallNode, env, true);
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
            if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0) {
                if (ctx.upvalueCells.has(name) || hasPathUpvalueCell(ctx, name, env) || hasActiveLocal(ctx, name, env)) return null;
                if (markers.length !== 0) {
                    if (!ctx.allowConditionalIf) return null;
                    env.set(pathUpvalueCellKey(ctx, name), ctx.pathUpvalueCellUnbound);
                } else {
                    ctx.upvalueCells.add(name);
                    ctx.upvalueCellBindings.delete(name);
                }
                env.delete(name);
                continue;
            }
            if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue") &&
                (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0], name)) {
                if (hasPathUpvalueCell(ctx, name, env)) {
                    env.delete(pathUpvalueCellKey(ctx, name));
                    env.delete(name);
                    continue;
                }
                if (ctx.upvalueCells.has(name)) {
                    ctx.upvalueCells.delete(name);
                    ctx.upvalueCellBindings.delete(name);
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
            const terminalUsedTransportAlias = ctx.allowConditionalIf && isVmRegisterName(name) && !ctx.cleanupRegs.has(name) &&
                !hasActiveLocal(ctx, name, env) && isIdentifier(rhs) && (rhs.name === ctx.stateName || rhs.name === ctx.returnName) &&
                (terminalStableUsedEpoch(ctx, id, i, name) || terminalClosureTransport);
            if (terminalUsedTransportAlias) {
                const value = render(ctx, rhs, env);
                if (typeof value !== "string") return null;
                const kind = transportKind ?? transportSourceKind(ctx, block, i, rhs.name);
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

            if (ctx.cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
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
                if (ctx.accumulatorRegs.has(name)) {
                    if (ctx.persistentStorageRegs.has(name) && ctx.locals.has(name)) {
                        ctx.locals.delete(name);
                        ctx.localNames.delete(name);
                        env.delete(name);
                        continue;
                    }
                    const value = env.get(name);
                    if (value == null) return null;
                    const display = allocateValueDisplay(ctx);
                    ctx.out.push(`local ${display} = ${value}`);
                    env.delete(name);
                    continue;
                }
                if (!ctx.locals.has(name)) return null;
                ctx.locals.delete(name);
                ctx.localNames.delete(name);
                env.delete(name);
                continue;
            }

            // Function-call statements are represented by a write to a VM
            // temporary (often ReturnVal).  If that result is overwritten
            // without a read, preserve the call itself.  A path-dependent
            // call cannot be represented as a bare source statement here, so
            // fail closed instead of moving it ctx.out of its branch.
            if (rhs?.type === "CallExpression" && (!ctx.cleanupRegs.has(name) || !valueMayBeReadAfter(ctx, id, i, name))) {
                const promotedArguments = [];
                if (markers.length === 0) {
                    for (const argument of rhs.arguments || []) {
                        if (!isIdentifier(argument) || !ctx.cleanupRegs.has(argument.name) || ctx.locals.has(argument.name) || ctx.earlyCleanupPending.has(argument.name)) continue;
                        if (valueMayBeReadAfter(ctx, id, i, argument.name)) continue;
                        // While preheaders can reuse the eventual source-local
                        // physical register as a call-argument TEMP before the
                        // real source handoff. Suppress only that loop-scoped
                        // promotion when a later non-nil write starts the next
                        // epoch; ordinary structured recovery keeps its legacy
                        // promotion behavior unchanged.
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

            const value = render(ctx, rhs, env);
            if (value == null) {
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
            const stableStorageEpoch = ctx.allowConditionalIf && ctx.cleanupRegs.has(name) && !ctx.locals.has(name) &&
                valueMayBeReadAfter(ctx, id, i, name) && storageEpochEnd.valid && storageEpochEnd.sawCleanup;
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
            if ((startsPersistentStorage || stableStorageEpoch) && !hasActiveLocal(ctx, name, env)) {
                const display = allocateValueDisplay(ctx);
                ctx.accumulatorRegs.delete(name);
                const declaration = `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    ctx.pathLocalBindingNames.add(display);
                    env.set(pathLocalOwnerKey(ctx, name), display);
                    effects = [...effects, declaration];
                } else {
                    ctx.localNames.set(name, display);
                    ctx.locals.add(name);
                    ctx.out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            const conditionalIfLocalHandoff = ctx.allowConditionalIf && ctx.cleanupRegs.has(name) && !hasActiveLocal(ctx, name, env) &&
                isIdentifier(rhs, ctx.stateName) && block.transition.kind === "branch" && block.transition.conditionRegister === name;
            if (conditionalIfLocalHandoff) ctx.accumulatorRegs.delete(name);
            if (ctx.cleanupRegs.has(name) && !ctx.accumulatorRegs.has(name) && !hasActiveLocal(ctx, name, env) && isIdentifier(rhs) && rhs.name !== name) {
                const display = rhs?.type === "TableConstructorExpression" ? allocateTableDisplay(ctx) : allocateValueDisplay(ctx);
                ctx.localNames.set(name, display);
                ctx.locals.add(name);
                ctx.out.push(`local ${display} = ${value}`);
                env.set(name, display);
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
        const tr = block.transition;
        const sends = [];
        if (tr.kind === "stop") {
            if (terminalReturnLine === null) return null;
            ctx.terminalCandidates.push({
                env: new Map(env),
                markers: [...markers],
                effects: [...effects, terminalReturnLine],
                terminal: true,
            });
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
    if (ctx.allowConditionalIf && ctx.conditionalIfCount < 1) {
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
