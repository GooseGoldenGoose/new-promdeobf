"use strict";

const { isIdentifier, isLuaIdentifier } = require("../ast");
const { hasLinearPath } = require("../cfg");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
function hasLinearRootContinuation(ctx, fromId, toId) {
    return hasLinearPath(ctx.graph, fromId, toId);
}

function recordRootConditional(ctx, startId, joinId) {
    const anchor = ctx.lastRootConditionalJoinId === null ? ctx.entryId : ctx.lastRootConditionalJoinId;
    if (!hasLinearRootContinuation(ctx, anchor, startId)) return false;
    ctx.lastRootConditionalJoinId = joinId;
    ctx.conditionalIfCount++;
    return true;
}

function upvalueAliasKey(ctx, name) { return ctx.upvalueAliasPrefix + name; }

function allocateValueDisplay(ctx) {
    let display;
    do display = `v${ctx.nextValueSuffix++}`; while (ctx.reservedBindingNames.has(display));
    ctx.reservedBindingNames.add(display);
    ctx.valueCount++;
    return display;
}

function allocateTableDisplay(ctx) {
    let display;
    do display = `t${ctx.nextTableSuffix++}`; while (ctx.reservedBindingNames.has(display));
    ctx.reservedBindingNames.add(display);
    ctx.tableCount++;
    return display;
}

function parameterName(ctx, index) {
    if (!ctx.renderAsFunction || !Number.isInteger(index) || index < 1) return null;
    while (ctx.parameterNames.length < index) {
        let display;
        do display = `v${ctx.nextValueSuffix++}`; while (ctx.reservedBindingNames.has(display));
        ctx.reservedBindingNames.add(display);
        ctx.parameterNames.push(display);
    }
    return ctx.parameterNames[index - 1];
}

function capturedSlotName(ctx, node) {
    if (!ctx.captureNames || node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalueValues")) return null;
    const slotExpr = node.index;
    if (slotExpr?.type !== "IndexExpression" || !isIdentifier(slotExpr.base, "upvalues") || slotExpr.index?.type !== "NumericLiteral") return null;
    const slot = Number(slotExpr.index.value);
    if (!Number.isInteger(slot) || slot < 1) return null;
    return ctx.captureNames.get(slot) ?? null;
}

function forwardedCaptureName(ctx, node) {
    if (!ctx.captureNames || node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalues") || node.index?.type !== "NumericLiteral") return null;
    const slot = Number(node.index.value);
    if (!Number.isInteger(slot) || slot < 1) return null;
    return ctx.captureNames.get(slot) ?? null;
}

function displayLocal(ctx, reg) { return ctx.localNames.get(reg) || reg; }

function activeLocalDisplay(ctx, name, env) {
    const value = env.get(name);
    if (typeof value === "string" && ctx.pathLocalBindingNames.has(value)) return value;
    if (ctx.locals.has(name)) {
        const display = displayLocal(ctx, name);
        if (value === display) return display;
    }
    return null;
}

function hasActiveLocal(ctx, name, env) { return activeLocalDisplay(ctx, name, env) !== null; }

function resolveId(ctx, name, env) {
    const active = activeLocalDisplay(ctx, name, env);
    if (active !== null) return active;
    return env.get(name) ?? null;
}

function resolveRenderableId(ctx, name, env) {
    const value = resolveId(ctx, name, env);
    if (structuredPackId(ctx, value) || structuredPackSlot(ctx, value) || value === ctx.varargPackMarker) return null;
    return value;
}

module.exports = { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId };
