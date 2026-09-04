"use strict";

const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, upvalueCellBinding, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
const { isCompilerVarargPack, isVarargUnpack, expectedPackSlotsInBlock, cleanupOrTerminalEpoch, maybeOwnStructuredPackSlot, preclaimFutureStructuredPackOwner, preclaimFutureStructuredPackSlots, flushStructuredPack, flushReadyStructuredPacks } = require("./packs");
function render(ctx, rhs, env, provenRecursive = false, singleCallPacks = null) {
    if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(ctx.source, rhs);
    if (rhs?.type === "TableConstructorExpression") return renderTableFields(rhs.fields || [], node => render(ctx, node, env, provenRecursive, singleCallPacks));
    if (isIdentifier(rhs)) return resolveRenderableId(ctx, rhs.name, env);
    const capturedSlot = capturedSlotName(ctx, rhs);
    if (typeof capturedSlot === "string") return capturedSlot;
    if (ctx.renderAsFunction && rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "args") && rhs.index?.type === "NumericLiteral") {
        return parameterName(ctx, Number(rhs.index.value));
    }
    if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index)) {
        return upvalueCellBinding(ctx, rhs.index.name, env);
    }
    if (provenRecursive && rhs?.type === "IndexExpression" && !isIdentifier(rhs.base)) {
        const base = render(ctx, rhs.base, env, true, singleCallPacks);
        const key = isIdentifier(rhs.index) ? resolveRenderableId(ctx, rhs.index.name, env)
            : (isPrimitiveLiteral(rhs.index) ? sourceOf(ctx.source, rhs.index) : render(ctx, rhs.index, env, true, singleCallPacks));
        if (typeof base !== "string" || typeof key !== "string" || structuredPackId(ctx, base) || structuredPackSlot(ctx, base) || base === ctx.varargPackMarker) return null;
        const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
        return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
    }
    if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base)) {
        const key = isIdentifier(rhs.index) ? resolveRenderableId(ctx, rhs.index.name, env)
            : (provenRecursive && isPrimitiveLiteral(rhs.index) ? sourceOf(ctx.source, rhs.index) : null);
        if (key == null) return null;
        if (rhs.base.name === "_env") {
            const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
        }
        const base = resolveRenderableId(ctx, rhs.base.name, env);
        if (base == null) return null;
        const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
        return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
    }
    if (rhs?.type === "UnaryExpression") {
        const argument = provenRecursive ? render(ctx, rhs.argument, env, true, singleCallPacks)
            : (isIdentifier(rhs.argument) ? resolveRenderableId(ctx, rhs.argument.name, env) : (isPrimitiveLiteral(rhs.argument) ? sourceOf(ctx.source, rhs.argument) : null));
        return renderUnary(rhs.operator, argument);
    }
    if ((provenRecursive || (rhs?.type === "LogicalExpression" && rhs.freshCompilerLogical === true)) &&
        (rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
        const left = render(ctx, rhs.left, env, true, singleCallPacks);
        const right = render(ctx, rhs.right, env, true, singleCallPacks);
        if (left == null || right == null) return null;
        return `(${left} ${rhs.operator} ${right})`;
    }
    if ((rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
        const left = isIdentifier(rhs.left) ? resolveRenderableId(ctx, rhs.left.name, env) : (isPrimitiveLiteral(rhs.left) ? sourceOf(ctx.source, rhs.left) : null);
        const right = isIdentifier(rhs.right) ? resolveRenderableId(ctx, rhs.right.name, env) : (isPrimitiveLiteral(rhs.right) ? sourceOf(ctx.source, rhs.right) : null);
        if (left == null || right == null) return null;
        return `(${left} ${rhs.operator} ${right})`;
    }
    if (rhs?.type === "CallExpression") {
        if (ctx.renderAsFunction && isVarargUnpack(ctx, rhs, env)) {
            ctx.sawVarargs = true;
            return "...";
        }
        if (ctx.renderAsFunction && isIdentifier(rhs.base, "select") && (rhs.arguments || []).length === 2 &&
            rhs.arguments[0]?.type === "NumericLiteral" && Number(rhs.arguments[0].value) === 1 &&
            rhs.arguments[1]?.type === "CallExpression" && isIdentifier(rhs.arguments[1].base, "unpack") &&
            (rhs.arguments[1].arguments || []).length === 1 && isIdentifier(rhs.arguments[1].arguments[0], "args")) {
            ctx.sawVarargs = true;
            return "...";
        }
        if (ctx.renderAsFunction && isIdentifier(rhs.base, "unpack") && (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0], "args")) {
            ctx.sawVarargs = true;
            return "...";
        }
        if (isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name) && typeof ctx.options.renderCapturedCall === "function") {
            const args = rhs.arguments || [];
            const fields = args[1]?.type === "TableConstructorExpression" ? (args[1].fields || []) : [];
            if (fields.length > 0) {
                const childCaptureNames = new Map();
                for (let i = 0; i < fields.length; i++) {
                    const field = fields[i];
                    if (field?.type !== "TableValue") return null;
                    let captureName = null;
                    if (isIdentifier(field.value)) captureName = upvalueCellBinding(ctx, field.value.name, env);
                    else captureName = forwardedCaptureName(ctx, field.value);
                    if (typeof captureName !== "string") return null;
                    childCaptureNames.set(i + 1, captureName);
                }
                const captured = ctx.options.renderCapturedCall(rhs, childCaptureNames);
                if (typeof captured === "string") return captured;
                return null;
            }
        }
        if (typeof ctx.options.renderSpecialCall === "function") {
            const special = ctx.options.renderSpecialCall(rhs);
            if (typeof special === "string") return special;
        }
        const base = isIdentifier(rhs.base) ? resolveRenderableId(ctx, rhs.base.name, env)
            : (provenRecursive ? render(ctx, rhs.base, env, true, singleCallPacks) : null);
        if (base == null) return null;
        const args = [];
        const callArgs = rhs.arguments || [];
        for (let argIndex = 0; argIndex < callArgs.length; argIndex++) {
            const arg = callArgs[argIndex];
            let value = null;
            const finalSingleCallPack = argIndex === callArgs.length - 1 &&
                arg?.type === "CallExpression" && isIdentifier(arg.base, "unpack") &&
                (arg.arguments || []).length === 1 && isIdentifier(arg.arguments[0]) &&
                singleCallPacks instanceof Map ? singleCallPacks.get(arg.arguments[0].name) : null;
            if (typeof finalSingleCallPack === "string") {
                value = finalSingleCallPack;
            } else if (ctx.renderAsFunction && isVarargUnpack(ctx, arg, env)) {
                ctx.sawVarargs = true;
                value = "...";
            } else {
                value = provenRecursive ? render(ctx, arg, env, true, singleCallPacks)
                    : (isIdentifier(arg) ? resolveRenderableId(ctx, arg.name, env) : (isPrimitiveLiteral(arg) ? sourceOf(ctx.source, arg) : null));
            }
            if (value == null || structuredPackId(ctx, value) || structuredPackSlot(ctx, value) || value === ctx.varargPackMarker) return null;
            args.push(value);
        }
        const callable = /^function\b/.test(base.trim()) ? "(" + base + ")" : base;
        return callable + "(" + args.join(", ") + ")";
    }
    return null;
}

module.exports = { render };
