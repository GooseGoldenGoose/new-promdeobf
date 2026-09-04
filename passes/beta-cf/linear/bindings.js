"use strict";

const { isIdentifier } = require("../ast");
function localName(ctx, name) { return ctx.localNames.get(name) || name; }

function emitSourceLine(ctx, line, registers = []) {
    let barrier = 0;
    for (const reg of registers) barrier = Math.max(barrier, ctx.deferredLocalBarriers.get(reg) || 0);
    if (barrier > 0) ctx.deferredSourceLines.push({ line, afterPackOrder: barrier });
    else ctx.out.push(line);
}

function allocateLocal(ctx, reg, kind = "value") {
    if (ctx.localNames.has(reg)) return localName(ctx, reg);
    const displayName = kind === "table" ? `t${++ctx.tableLocalCount}` : `v${++ctx.valueLocalCount}`;
    ctx.localNames.set(reg, displayName); ctx.locals.add(reg); ctx.expr.set(reg, displayName); ctx.exprKinds.set(reg, kind); ctx.declaredCount++;
    return displayName;
}

function reserveLocal(ctx, reg, preserveExpression = false) {
    ctx.locals.add(reg);
    if (!preserveExpression) ctx.exprKinds.set(reg, "value");
}

function canPredeclareNilLocal(ctx, name, index) {
    return ctx.cleanupRegs.has(name) &&
        (ctx.nonNilDefinitionCount.get(name) || 0) === 0 &&
        (ctx.nilDefinitionCount.get(name) || 0) >= 2 &&
        (ctx.firstNilDefinitionIndex.get(name) ?? -1) > index &&
        !ctx.locals.has(name) && !ctx.expr.has(name);
}

function predeclareNilReads(ctx, node, index) {
    if (!node || typeof node !== "object") return;
    if (Array.isArray(node)) {
        for (const item of node) predeclareNilReads(ctx, item, index);
        return;
    }
    if (isIdentifier(node)) {
        if (canPredeclareNilLocal(ctx, node.name, index)) {
            const displayName = allocateLocal(ctx, node.name, "value");
            ctx.out.push(`local ${displayName}`);
            ctx.predeclaredNilLocals.add(node.name);
        }
        return;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        predeclareNilReads(ctx, value, index);
    }
}

module.exports = { localName, emitSourceLine, allocateLocal, reserveLocal, canPredeclareNilLocal, predeclareNilReads };
