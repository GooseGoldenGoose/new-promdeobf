"use strict";

function structuredPackId(ctx, value) {
    return typeof value === "string" && value.startsWith(ctx.structuredPackPrefix)
        ? value.slice(ctx.structuredPackPrefix.length) : null;
}

function structuredPackSlot(ctx, value) {
    if (typeof value !== "string" || !value.startsWith(ctx.structuredPackSlotPrefix)) return null;
    const rest = value.slice(ctx.structuredPackSlotPrefix.length);
    const split = rest.lastIndexOf(":");
    if (split < 1) return null;
    const packId = rest.slice(0, split);
    const slot = Number(rest.slice(split + 1));
    return Number.isInteger(slot) && slot > 0 ? { packId, slot } : null;
}

function structuredPackSlotToken(ctx, packId, slot) { return ctx.structuredPackSlotPrefix + packId + ":" + slot; }

module.exports = { structuredPackId, structuredPackSlot, structuredPackSlotToken };
