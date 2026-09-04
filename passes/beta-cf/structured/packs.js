"use strict";

const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, pathLocalOwnerKey, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
const { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, cleanupReachedOnAllPaths, analyzePersistentStorage } = require("./lifetime");
function isCompilerVarargPack(ctx, node) {
    const fields = node?.type === "TableConstructorExpression" ? (node.fields || []) : [];
    if (fields.length !== 1 || fields[0]?.type !== "TableValue") return false;
    const selectCall = fields[0].value;
    if (selectCall?.type !== "CallExpression" || !isIdentifier(selectCall.base, "select") || (selectCall.arguments || []).length !== 2) return false;
    if (selectCall.arguments[0]?.type !== "NumericLiteral" || Number(selectCall.arguments[0].value) !== 1) return false;
    const unpackCall = selectCall.arguments[1];
    return unpackCall?.type === "CallExpression" && isIdentifier(unpackCall.base, "unpack") &&
        (unpackCall.arguments || []).length === 1 && isIdentifier(unpackCall.arguments[0], "args");
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

function cleanupOrTerminalEpoch(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return { valid: false, sawCleanup: false };
    const block = ctx.blocks.get(blockId);
    if (!block) return { valid: false, sawCleanup: false };
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) return { valid: false, sawCleanup: false };
        const dest = statement.variables[0];
        if (!isIdentifier(dest, name)) continue;
        if (statement.init[0]?.type === "NilLiteral") return { valid: true, sawCleanup: true };
        return { valid: false, sawCleanup: false };
    }
    const next = ctx.successors.get(blockId) || [];
    if (next.length === 0) return { valid: block.transition.kind === "stop", sawCleanup: false };
    let sawCleanup = false;
    for (const target of next) {
        const child = cleanupOrTerminalEpoch(ctx, target, -1, name, nextVisiting);
        if (!child.valid) return { valid: false, sawCleanup: false };
        sawCleanup = sawCleanup || child.sawCleanup;
    }
    return { valid: true, sawCleanup };
}

function maybeOwnStructuredPackSlot(ctx, pack, slot, reg, blockId, statementIndex) {
    if (!pack || !Number.isInteger(slot) || !isVmRegisterName(reg) || reg === ctx.stateName || reg === ctx.returnName) return;
    const epochEnd = cleanupOrTerminalEpoch(ctx, blockId, statementIndex, reg);
    if (!epochEnd.valid || !valueMayBeReadAfter(ctx, blockId, statementIndex, reg)) return;
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
    if (!info || info.ownerReg || info.ambiguous || !block ||
        !(isVmRegisterName(carrierReg) || carrierReg === ctx.stateName || carrierReg === ctx.returnName)) return;
    const carriers = new Set([carrierReg]);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) return;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        const copiedCarrier = isIdentifier(rhs) && carriers.has(rhs.name);
        if (copiedCarrier && isIdentifier(dest)) {
            maybeOwnStructuredPackSlot(ctx, pack, slot, dest.name, blockId, i);
            if (info.ambiguous) return;
            carriers.add(dest.name);
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
        if (isIdentifier(dest) && carriers.has(dest.name) && !copiedCarrier) carriers.delete(dest.name);
        if (carriers.size === 0) return;
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
        if (!info.ownerReg) preclaimFutureStructuredPackOwner(ctx, pack, slot, dest.name, blockId, i);
        if (info.ambiguous) return false;
    }
    return pack.expectedSlots.every(slot => seen.has(slot));
}

function flushStructuredPack(ctx, packId, env, markers, effects) {
    const pack = ctx.structuredPacks.get(packId);
    if (!pack || pack.emitted) return effects;
    const slots = pack.expectedSlots.map(slot => pack.slots.get(slot));
    if (slots.some(info => !info || info.ambiguous || !info.ownerReg)) return null;
    const ownerRegs = slots.map(info => info.ownerReg);
    if (new Set(ownerRegs).size !== ownerRegs.length) return null;
    const names = [];
    for (const info of slots) {
        let display = info.ownerDeferred ? null : activeLocalDisplay(ctx, info.ownerReg, env);
        if (display === null) display = allocateValueDisplay(ctx);
        info.display = display;
        names.push(display);
    }
    const line = `local ${names.join(", ")} = ${pack.call}`;
    if (markers.length !== 0) {
        for (const info of slots) {
            ctx.pathLocalBindingNames.add(info.display);
            env.set(pathLocalOwnerKey(ctx, info.ownerReg), info.display);
        }
        effects = [...effects, line];
    } else {
        ctx.out.push(line);
        for (const info of slots) {
            ctx.localNames.set(info.ownerReg, info.display);
            ctx.locals.add(info.ownerReg);
            if (info.terminalLive) ctx.terminalLiveLocals.add(info.ownerReg);
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
            return info && !info.ambiguous && !!info.ownerReg;
        });
        if (!ready) { if (requireAll) return null; continue; }
        effects = flushStructuredPack(ctx, packId, env, markers, effects);
        if (effects === null) return null;
    }
    return effects;
}

module.exports = { isCompilerVarargPack, isVarargUnpack, expectedPackSlotsInBlock, cleanupOrTerminalEpoch, maybeOwnStructuredPackSlot, preclaimFutureStructuredPackOwner, preclaimFutureStructuredPackSlots, flushStructuredPack, flushReadyStructuredPacks };
