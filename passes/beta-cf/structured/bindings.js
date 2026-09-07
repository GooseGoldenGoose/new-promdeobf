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
function pathLocalOwnerKey(ctx, name) { return ctx.pathLocalOwnerPrefix + name; }
function deadJoinTempKey(ctx, name) { return ctx.deadJoinTempPrefix + name; }
function pathUpvalueCellKey(ctx, name) { return ctx.pathUpvalueCellPrefix + name; }
function hasPathUpvalueCell(ctx, name, env) { return env.has(pathUpvalueCellKey(ctx, name)); }

function allocateUpvalueCellIdentity(ctx) {
    return Object.freeze({ kind: "fresh-upvalue-cell", id: ctx.nextUpvalueCellIdentity++ });
}
function isUpvalueCellIdentity(value) {
    return value?.kind === "fresh-upvalue-cell" && Number.isInteger(value.id);
}
function upvalueCellIdentityBindingKey(ctx, identity) {
    return ctx.upvalueCellIdentityBindingPrefix + identity.id;
}
function upvalueCellIdentity(ctx, name, env) {
    const pathValue = env.get(pathUpvalueCellKey(ctx, name));
    if (isUpvalueCellIdentity(pathValue)) return pathValue;
    return ctx.upvalueCellIdentities.get(name) ?? null;
}
function bindUpvalueCellIdentity(ctx, identity, display, env) {
    if (!isUpvalueCellIdentity(identity) || typeof display !== "string") return false;
    env.set(upvalueCellIdentityBindingKey(ctx, identity), display);
    return true;
}
function pathUpvalueCellBinding(ctx, name, env) {
    const value = env.get(pathUpvalueCellKey(ctx, name));
    if (typeof value === "string") return value !== ctx.pathUpvalueCellUnbound ? value : null;
    if (isUpvalueCellIdentity(value)) {
        const binding = env.get(upvalueCellIdentityBindingKey(ctx, value));
        return typeof binding === "string" ? binding : null;
    }
    return null;
}
function upvalueCellBinding(ctx, name, env) {
    if (hasPathUpvalueCell(ctx, name, env)) return pathUpvalueCellBinding(ctx, name, env);
    const identity = ctx.upvalueCellIdentities.get(name);
    if (isUpvalueCellIdentity(identity)) {
        const binding = env.get(upvalueCellIdentityBindingKey(ctx, identity));
        if (typeof binding === "string") return binding;
    }
    return ctx.upvalueCellBindings.get(name) ?? null;
}

function deferredClosureValue(ctx, call, env) {
    if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !/^createClosure\d*$/.test(call.base.name)) return null;
    const args = call.arguments || [];
    if (args.length !== 2 || args[0]?.type !== "NumericLiteral" || args[1]?.type !== "TableConstructorExpression") return null;
    const captureRefs = [];
    for (const field of args[1].fields || []) {
        if (field?.type !== "TableValue") return null;
        if (isIdentifier(field.value)) {
            const bound = upvalueCellBinding(ctx, field.value.name, env);
            if (typeof bound === "string") { captureRefs.push({ kind: "name", name: bound }); continue; }
            const identity = upvalueCellIdentity(ctx, field.value.name, env);
            if (!isUpvalueCellIdentity(identity)) return null;
            captureRefs.push({ kind: "cell", identity });
            continue;
        }
        const forwarded = forwardedCaptureName(ctx, field.value);
        if (typeof forwarded !== "string") return null;
        captureRefs.push({ kind: "name", name: forwarded });
    }
    return Object.freeze({ kind: "fresh-deferred-closure", call, captureRefs: Object.freeze(captureRefs) });
}
function isDeferredClosureValue(value) { return value?.kind === "fresh-deferred-closure" && value.call?.type === "CallExpression"; }
function pendingDeferredLocalValue(initializer, pathScoped = false) {
    if (!isDeferredClosureValue(initializer)) return null;
    return Object.freeze({ kind: "fresh-pending-deferred-local", initializer, pathScoped: pathScoped === true });
}
function isPendingDeferredLocalValue(value) {
    return value?.kind === "fresh-pending-deferred-local" && isDeferredClosureValue(value.initializer);
}
function renderDeferredClosureValue(ctx, value, env) {
    if (!isDeferredClosureValue(value) || typeof ctx.options?.renderCapturedCall !== "function") return null;
    const captureNames = new Map();
    for (let i = 0; i < value.captureRefs.length; i++) {
        const ref = value.captureRefs[i];
        let name = null;
        if (ref?.kind === "name") name = ref.name;
        else if (ref?.kind === "cell" && isUpvalueCellIdentity(ref.identity)) {
            const binding = env.get(upvalueCellIdentityBindingKey(ctx, ref.identity));
            if (typeof binding === "string") name = binding;
        }
        if (typeof name !== "string") return null;
        captureNames.set(i + 1, name);
    }
    return ctx.options.renderCapturedCall(value.call, captureNames);
}

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
    if (isPendingDeferredLocalValue(value)) {
        const owned = value.pathScoped
            ? env.get(pathLocalOwnerKey(ctx, name)) === value
            : ctx.locals.has(name);
        return owned ? "\0freshPendingDeferredLocal" : null;
    }
    if (typeof value === "string" && ctx.pathLocalBindingNames.has(value) &&
        env.get(pathLocalOwnerKey(ctx, name)) === value) return value;
    if (ctx.locals.has(name)) {
        const display = displayLocal(ctx, name);
        if (value === display) return display;
    }
    return null;
}

function hasActiveLocal(ctx, name, env) { return activeLocalDisplay(ctx, name, env) !== null; }

function resolveId(ctx, name, env) {
    const raw = env.get(name);
    if (isPendingDeferredLocalValue(raw)) return raw;
    const active = activeLocalDisplay(ctx, name, env);
    if (active !== null) return active;
    return raw ?? null;
}

function resolveRenderableId(ctx, name, env) {
    const value = resolveId(ctx, name, env);
    if (isPendingDeferredLocalValue(value)) return null;
    if (isDeferredClosureValue(value)) return renderDeferredClosureValue(ctx, value, env);
    if (structuredPackId(ctx, value) || structuredPackSlot(ctx, value) || value === ctx.varargPackMarker) return null;
    return typeof value === "string" ? value : null;
}

module.exports = { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, pathLocalOwnerKey, deadJoinTempKey, pathUpvalueCellKey, hasPathUpvalueCell, allocateUpvalueCellIdentity, isUpvalueCellIdentity, upvalueCellIdentity, bindUpvalueCellIdentity, pathUpvalueCellBinding, upvalueCellBinding, deferredClosureValue, isDeferredClosureValue, pendingDeferredLocalValue, isPendingDeferredLocalValue, renderDeferredClosureValue, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId };
