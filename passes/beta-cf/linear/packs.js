"use strict";

const { allocateLocal, localName } = require("./bindings");
const { hasOnlyDeadCopyUses } = require("./lifetime");
function reservePendingPackDisplayNamesThrough(ctx, targetPack, targetSlot) {
    const packs = [...ctx.pendingPacks.values()].sort((a, b) => a.order - b.order);
    for (const pendingPack of packs) {
        if (pendingPack.order > targetPack.order) break;
        const slots = [...pendingPack.slots.keys()].sort((a, b) => a - b);
        for (const slotNumber of slots) {
            if (pendingPack.order === targetPack.order && slotNumber > targetSlot) break;
            const slotInfo = pendingPack.slots.get(slotNumber);
            if (!slotInfo?.localReg || typeof slotInfo.displayName === "string") continue;
            if (ctx.localNames.has(slotInfo.localReg)) slotInfo.displayName = localName(ctx, slotInfo.localReg);
            else {
                slotInfo.displayName = `v${++ctx.valueLocalCount}`;
                ctx.declaredCount++;
            }
        }
    }
    return targetPack.slots.get(targetSlot)?.displayName ?? null;
}

function flushPendingPacks(ctx) {
    if (!ctx.pendingPacks.size) return true;
    const packs = [...ctx.pendingPacks.values()].sort((a, b) => a.order - b.order);
    for (const pendingPack of packs) {
        const slots = [...pendingPack.slots.keys()].sort((a, b) => a - b);
        if (!slots.length || slots[0] !== 1) { return false; }
        for (let i = 0; i < slots.length; i++) if (slots[i] !== i + 1) { return false; }
        const slotInfos = slots.map(i => pendingPack.slots.get(i));
        const hasAnyLocal = slotInfos.some(slot => !!slot?.localReg);
        if (!hasAnyLocal) {
            if (!slotInfos.every(slot => slot && hasOnlyDeadCopyUses(ctx, slot.extractionIndex, slot.tempReg))) { return false; }
            ctx.out.push(pendingPack.call);
            ctx.consumedPackRegs.add(pendingPack.packReg);
        } else {
            for (const slot of slotInfos) {
                if (!slot?.localReg) { return false; }
                if (typeof slot.displayName !== "string") {
                    if (ctx.locals.has(slot.localReg)) slot.displayName = allocateLocal(ctx, slot.localReg, "value");
                    else { slot.displayName = `v${++ctx.valueLocalCount}`; ctx.declaredCount++; }
                }
            }
            const names = slotInfos.map(slot => slot.displayName);
            for (const slot of slotInfos) {
                if (!ctx.locals.has(slot.localReg)) continue;
                ctx.localNames.set(slot.localReg, slot.displayName);
                ctx.expr.set(slot.localReg, slot.displayName);
                ctx.exprKinds.set(slot.localReg, "value");
                ctx.exprMeta.delete(slot.localReg);
            }
            ctx.out.push(`local ${names.join(", ")} = ${pendingPack.call}`);
            ctx.consumedPackRegs.add(pendingPack.packReg);
        }
        for (let i = 0; i < ctx.deferredSourceLines.length;) {
            if (ctx.deferredSourceLines[i].afterPackOrder <= pendingPack.order) {
                const deferred = ctx.deferredSourceLines[i];
                ctx.out.push(deferred.line);
                if (deferred.declaresReg) ctx.deferredLocalBarriers.delete(deferred.declaresReg);
                ctx.deferredSourceLines.splice(i, 1);
            } else i++;
        }
    }
    ctx.pendingPacks.clear();
    return ctx.deferredSourceLines.length === 0;
}

module.exports = { reservePendingPackDisplayNamesThrough, flushPendingPacks };
