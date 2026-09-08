"use strict";

const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, pathLocalOwnerKey, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
const { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, cleanupReachedOnAllPaths, isDeadNilCleanup, analyzePersistentStorage } = require("./lifetime");
const { compilerVarargPackIndex, compilerVarargSelectIndex } = require("../varargs");
function isCompilerVarargPack(ctx, node) {
    return ctx?.renderAsFunction === true && Number.isInteger(ctx.varargFirstIndex) &&
        compilerVarargPackIndex(node) === ctx.varargFirstIndex;
}

function isCompilerVarargSelect(ctx, node) {
    return ctx?.renderAsFunction === true && Number.isInteger(ctx.varargFirstIndex) &&
        compilerVarargSelectIndex(node) === ctx.varargFirstIndex;
}

function isVarargUnpack(ctx, node, env) {
    return node?.type === "CallExpression" && isIdentifier(node.base, "unpack") &&
        (node.arguments || []).length === 1 && isIdentifier(node.arguments[0]) &&
        resolveId(ctx, node.arguments[0].name, env) === ctx.varargPackMarker;
}

function expectedPackSlotsInBlock(ctx, block, creationIndex, packReg) {
    const slots = new Set();
    for (let cursor = creationIndex + 1; cursor < block.body.length; cursor++) {
        if (cursor === block.transitionIndex) continue;
        const statement = block.body[cursor];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (isIdentifier(dest, packReg)) break;
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, packReg) && rhs.index?.type === "NumericLiteral") {
            const slot = Number(rhs.index.value);
            if (!Number.isInteger(slot) || slot < 1 || slots.has(slot)) return null;
            slots.add(slot);
        }
    }
    if (!slots.size) return null;
    const ordered = [...slots].sort((a,b) => a-b);
    for (let i = 0; i < ordered.length; i++) if (ordered[i] !== i + 1) return null;
    return ordered;
}


function countIdentifierReads(node, name) {
    if (!node || typeof node !== "object") return 0;
    if (isIdentifier(node, name)) return 1;
    let count = 0;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            for (const item of value) count += countIdentifierReads(item, name);
        } else if (value && typeof value === "object") {
            count += countIdentifierReads(value, name);
        }
    }
    return count;
}

function countFinalForwardUnpacks(node, packReg) {
    if (!node || typeof node !== "object") return 0;
    let count = 0;
    if (node.type === "CallExpression") {
        const args = node.arguments || [];
        const last = args[args.length - 1];
        if (last?.type === "CallExpression" && isIdentifier(last.base, "unpack") &&
            (last.arguments || []).length === 1 && isIdentifier(last.arguments[0], packReg) &&
            !isIdentifier(node.base, "unpack")) {
            count++;
        }
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            for (const item of value) count += countFinalForwardUnpacks(item, packReg);
        } else if (value && typeof value === "object") {
            count += countFinalForwardUnpacks(value, packReg);
        }
    }
    return count;
}

function isForwardOnlyPackUseInBlock(ctx, block, creationIndex, packReg) {
    if (!block || !isVmRegisterName(packReg)) return false;
    let sawUse = false;
    let sawInterveningStatement = false;
    for (let cursor = creationIndex + 1; cursor < block.body.length; cursor++) {
        if (cursor === block.transitionIndex) continue;
        const statement = block.body[cursor];
        if (!statement || typeof statement !== "object") return false;

        const directWrite = statement.type === "AssignmentStatement" &&
            (statement.variables || []).some(dest => isIdentifier(dest, packReg));
        const reads = statement.type === "AssignmentStatement"
            ? (statement.init || []).reduce((sum, node) => sum + countIdentifierReads(node, packReg), 0) +
              (statement.variables || []).reduce((sum, dest) => sum + (dest?.type === "IndexExpression" ? countIdentifierReads(dest, packReg) : 0), 0)
            : countIdentifierReads(statement, packReg);

        if (reads > 0) {
            if (sawUse || sawInterveningStatement || directWrite) return false;
            const forwards = statement.type === "AssignmentStatement"
                ? (statement.init || []).reduce((sum, node) => sum + countFinalForwardUnpacks(node, packReg), 0) +
                  (statement.variables || []).reduce((sum, dest) => sum + (dest?.type === "IndexExpression" ? countFinalForwardUnpacks(dest, packReg) : 0), 0)
                : countFinalForwardUnpacks(statement, packReg);
            if (reads !== 1 || forwards !== 1) return false;
            sawUse = true;
            continue;
        }

        if (directWrite) return sawUse;
        if (!sawUse) sawInterveningStatement = true;
    }
    return sawUse;
}

function cleanupOrTerminalEpoch(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return { valid: false, sawCleanup: false };
    const cache = ctx.cleanupOrTerminalCache || (ctx.cleanupOrTerminalCache = new Map());
    if (cache.has(visitKey)) return cache.get(visitKey);
    const block = ctx.blocks.get(blockId);
    if (!block) return { valid: false, sawCleanup: false };
    visiting.add(visitKey);
    const finish = (valid, sawCleanup = false) => {
        const result = { valid, sawCleanup };
        visiting.delete(visitKey);
        cache.set(visitKey, result);
        return result;
    };
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) return finish(false);
        const dest = statement.variables[0];
        if (!isIdentifier(dest, name)) continue;
        if (statement.init[0]?.type === "NilLiteral" && isDeadNilCleanup(ctx, blockId, i, name)) return finish(true, true);
        return finish(false);
    }
    const next = ctx.successors.get(blockId) || [];
    if (next.length === 0) return finish(block.transition.kind === "stop");
    let sawCleanup = false;
    for (const target of next) {
        const child = cleanupOrTerminalEpoch(ctx, target, -1, name, visiting);
        if (!child.valid) return finish(false);
        sawCleanup = sawCleanup || child.sawCleanup;
    }
    return finish(true, sawCleanup);
}

function maybeOwnStructuredPackSlot(ctx, pack, slot, reg, blockId, statementIndex) {
    if (!pack || !Number.isInteger(slot) || !isVmRegisterName(reg) || reg === ctx.stateName || reg === ctx.returnName) return;
    const epochEnd = cleanupOrTerminalEpoch(ctx, blockId, statementIndex, reg);
    // An unused source local is still a source binding. An exact value epoch
    // ending in proven cleanup supplies ownership even without a later read.
    if (!epochEnd.valid) return;
    const terminalOwned = terminalStableUsedEpoch(ctx, blockId, statementIndex, reg);
    const mixedCleanupOwned = epochEnd.sawCleanup;
    if (!mixedCleanupOwned && !terminalOwned) return;
    const info = pack.slots.get(slot);
    if (!info) return;
    if (info.ownerReg && info.ownerReg !== reg) { info.ambiguous = true; return; }
    info.ownerReg = reg;
    info.terminalLive = terminalOwned && !epochEnd.sawCleanup;
}

function preclaimFutureStructuredPackOwner(ctx, pack, slot, carrierReg, blockId, statementIndex) {
    const info = pack?.slots.get(slot);
    const block = ctx.blocks.get(blockId);
    if (!info || info.ownerReg || info.ownerCaptured || info.ownerNewCaptured || info.ownerTemporary || info.ambiguous || !block ||
        !(isVmRegisterName(carrierReg) || carrierReg === ctx.stateName || carrierReg === ctx.returnName)) return;
    const carriers = new Set([carrierReg]);
    const carrierDefinitions = new Map([[carrierReg, statementIndex]]);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) return;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (i === block.transitionIndex) {
            // The dispatcher transition is still an ordinary sequential assignment
            // inside the current leaf. If it reads this extracted pack slot before
            // overwriting the carrier, that read proves the slot is a compiler TEMP
            // feeding control flow. Do not ignore the read merely because the same
            // statement is also the block transition.
            const transitionRead = [...carriers].some(name => nodeReadsIdentifier(ctx, rhs, name) ||
                (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name)));
            if (transitionRead) {
                info.ownerTemporary = true;
                return;
            }
            if (isIdentifier(dest) && carriers.has(dest.name)) {
                carriers.delete(dest.name);
                carrierDefinitions.delete(dest.name);
            }
            if (carriers.size === 0) return;
            continue;
        }
        const copiedCarrier = isIdentifier(rhs) && carriers.has(rhs.name);
        if (copiedCarrier && dest?.type === "IndexExpression" && isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index)) {
            // A multi-local can initialize a newly captured binding. Its cell
            // allocation is compiler transport; the source declaration belongs
            // to the original multi-return call, not a later separate call.
            let freshAllocation = false;
            for (let probe = i - 1; probe >= 0; probe--) {
                const prior = block.body[probe];
                if (!isSingleAssignment(prior)) break;
                const target = prior.variables[0];
                if (target?.type === "IndexExpression" && isIdentifier(target.base, "upvalueValues") && isIdentifier(target.index, dest.index.name)) break;
                if (!isIdentifier(target, dest.index.name)) continue;
                const value = prior.init[0];
                freshAllocation = value?.type === "CallExpression" && isIdentifier(value.base, "allocUpvalue") && (value.arguments || []).length === 0;
                break;
            }
            if (freshAllocation) {
                info.ownerNewCaptured = dest.index.name;
                ctx.structuredPackFutureCaptureOwners.set(blockId + ":" + i, { packId: pack.id, slot, newCellReg: dest.index.name, carrierReg: rhs.name });
                return;
            }
        }
        const capturedOwner = copiedCarrier ? capturedSlotName(ctx, dest) : null;
        if (typeof capturedOwner === "string") {
            if (info.ownerReg || (info.ownerCaptured && info.ownerCaptured !== capturedOwner)) { info.ambiguous = true; return; }
            info.ownerCaptured = capturedOwner;
            ctx.structuredPackFutureCaptureOwners.set(blockId + ":" + i, {
                packId: pack.id,
                slot,
                capturedDestination: capturedOwner,
                carrierReg: rhs.name,
            });
            return;
        }
        if (copiedCarrier && isIdentifier(dest)) {
            maybeOwnStructuredPackSlot(ctx, pack, slot, dest.name, blockId, i);
            if (info.ambiguous) return;
            carriers.add(dest.name);
            carrierDefinitions.set(dest.name, i);
            if (info.ownerReg === dest.name) {
                info.ownerDeferred = true;
                ctx.structuredPackFutureOwnerCopies.set(blockId + ":" + i, {
                    packId: pack.id,
                    slot,
                    ownerReg: dest.name,
                    carrierReg: rhs.name,
                });
                return;
            }
        }
        if (!copiedCarrier) {
            const carrierRead = [...carriers].some(name => nodeReadsIdentifier(ctx, rhs, name) ||
                (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name)));
            if (carrierRead) {
                info.ownerTemporary = true;
                return;
            }
        }
        if (isIdentifier(dest) && carriers.has(dest.name) && !copiedCarrier) {
            carriers.delete(dest.name);
            carrierDefinitions.delete(dest.name);
        }
        if (carriers.size === 0) return;
    }
    // Values carried into a later block cannot remain symbolic pack slots.
    // Materialize them once at the original call so loop iterations and branch
    // paths reuse the same returned value without repeating the call.
    for (const name of carriers) {
        const definitionIndex = carrierDefinitions.get(name);
        if (Number.isInteger(definitionIndex) && valueMayBeReadAfter(ctx, blockId, definitionIndex, name)) {
            info.ownerTemporary = true;
            return;
        }
    }
}

function preclaimFutureStructuredPackSlots(ctx, pack, blockId, creationIndex) {
    const block = ctx.blocks.get(blockId);
    if (!pack || !block) return false;
    const seen = new Set();
    for (let i = creationIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) return false;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (isIdentifier(dest, pack.packReg)) break;
        if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base, pack.packReg) || rhs.index?.type !== "NumericLiteral") continue;
        const slot = Number(rhs.index.value);
        if (!pack.slots.has(slot) || seen.has(slot) || !isIdentifier(dest)) return false;
        seen.add(slot);
        const info = pack.slots.get(slot);
        info.tempRegs.add(dest.name);
        ctx.structuredPackFutureExtractions.set(blockId + ":" + i, {
            packId: pack.id,
            slot,
            carrierReg: dest.name,
            packReg: pack.packReg,
        });
        maybeOwnStructuredPackSlot(ctx, pack, slot, dest.name, blockId, i);
        if (info.ambiguous) return false;
        if (info.ownerReg === dest.name) info.ownerDeferred = true;
        if (!info.ownerReg && !info.ownerCaptured && !info.ownerNewCaptured && !info.ownerTemporary) preclaimFutureStructuredPackOwner(ctx, pack, slot, dest.name, blockId, i);
        if (info.ambiguous) return false;
    }
    return pack.expectedSlots.every(slot => seen.has(slot));
}

function flushStructuredPack(ctx, packId, env, markers, effects) {
    const pack = ctx.structuredPacks.get(packId);
    if (!pack || pack.emitted) return effects;
    const slots = pack.expectedSlots.map(slot => pack.slots.get(slot));
    if (slots.some(info => !info || info.ambiguous || (!info.ownerReg && !info.ownerCaptured && !info.ownerTemporary && !info.ownerNewCaptured))) return null;
    const ownerKeys = slots.map(info => info.ownerCaptured ? `capture:${info.ownerCaptured}` : info.ownerNewCaptured ? `cell:${info.ownerNewCaptured}` : (info.ownerReg ? `reg:${info.ownerReg}` : `temp:${info.slot}`));
    if (new Set(ownerKeys).size !== ownerKeys.length) return null;

    const allLocalOwners = slots.every(info => !!info.ownerReg || !!info.ownerNewCaptured || info.ownerTemporary === true);
    const allCapturedOwners = slots.every(info => typeof info.ownerCaptured === "string");
    const names = [];
    for (const info of slots) {
        if (info.ownerCaptured) {
            info.display = info.ownerCaptured;
        } else if (info.ownerReg) {
            let display = info.ownerDeferred ? null : activeLocalDisplay(ctx, info.ownerReg, env);
            if (display === null) display = allocateValueDisplay(ctx);
            info.display = display;
        } else {
            info.display = allocateValueDisplay(ctx);
        }
        names.push(info.display);
    }

    if (allLocalOwners) {
        const line = `local ${names.join(", ")} = ${pack.call}`;
        if (markers.length !== 0) {
            for (const info of slots) {
                if (!info.ownerReg) continue;
                ctx.pathLocalBindingNames.add(info.display);
                env.set(pathLocalOwnerKey(ctx, info.ownerReg), info.display);
            }
            effects = [...effects, line];
        } else {
            ctx.out.push(line);
            for (const info of slots) {
                if (!info.ownerReg) continue;
                ctx.localNames.set(info.ownerReg, info.display);
                ctx.locals.add(info.ownerReg);
                if (info.terminalLive) ctx.terminalLiveLocals.add(info.ownerReg);
            }
        }
    } else if (allCapturedOwners) {
        const line = `${names.join(", ")} = ${pack.call}`;
        if (markers.length !== 0) effects = [...effects, line];
        else ctx.out.push(line);
    } else {
        const localInfos = slots.filter(info => !!info.ownerReg || !!info.ownerNewCaptured || info.ownerTemporary === true);
        const declaration = `local ${localInfos.map(info => info.display).join(", ")}`;
        const assignment = `${names.join(", ")} = ${pack.call}`;
        if (markers.length !== 0) {
            for (const info of localInfos) {
                if (!info.ownerReg) continue;
                ctx.pathLocalBindingNames.add(info.display);
                env.set(pathLocalOwnerKey(ctx, info.ownerReg), info.display);
            }
            effects = [...effects, declaration, assignment];
        } else {
            ctx.out.push(declaration);
            for (const info of localInfos) {
                if (!info.ownerReg) continue;
                ctx.localNames.set(info.ownerReg, info.display);
                ctx.locals.add(info.ownerReg);
                if (info.terminalLive) ctx.terminalLiveLocals.add(info.ownerReg);
            }
            ctx.out.push(assignment);
        }
    }

    for (const [reg, value] of [...env.entries()]) {
        if (structuredPackId(ctx, value) === packId) {
            env.delete(reg);
            continue;
        }
        const meta = structuredPackSlot(ctx, value);
        if (!meta || meta.packId !== packId) continue;
        const info = pack.slots.get(meta.slot);
        if (!info?.display) return null;
        env.set(reg, info.display);
    }
    for (const info of slots) {
        if (!info.ownerReg) continue;
        const current = structuredPackSlot(ctx, env.get(info.ownerReg));
        if (current?.packId === packId && current.slot === info.slot) env.set(info.ownerReg, info.display);
    }
    pack.emitted = true;
    return effects;
}

function flushReadyStructuredPacks(ctx, env, markers, effects, requireAll = false) {
    for (const [packId, pack] of ctx.structuredPacks) {
        if (pack.emitted) continue;
        const present = [...env.values()].some(value => structuredPackId(ctx, value) === packId || structuredPackSlot(ctx, value)?.packId === packId);
        if (!present) continue;
        const ready = pack.expectedSlots.every(slot => {
            const info = pack.slots.get(slot);
            return info && !info.ambiguous && !!(info.ownerReg || info.ownerCaptured || info.ownerTemporary || info.ownerNewCaptured);
        });
        if (!ready) { if (requireAll) return null; continue; }
        effects = flushStructuredPack(ctx, packId, env, markers, effects);
        if (effects === null) return null;
    }
    return effects;
}

module.exports = { isCompilerVarargPack, isCompilerVarargSelect, isVarargUnpack, expectedPackSlotsInBlock, isForwardOnlyPackUseInBlock, cleanupOrTerminalEpoch, maybeOwnStructuredPackSlot, preclaimFutureStructuredPackOwner, preclaimFutureStructuredPackSlots, flushStructuredPack, flushReadyStructuredPacks };
