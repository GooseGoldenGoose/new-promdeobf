"use strict";

const { isEmptyTable, isIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, upvalueCellBinding, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { structuredPackId, structuredPackSlot, structuredPackSlotToken } = require("./tokens");
const { isCompilerVarargPack, isCompilerVarargSelect, isVarargUnpack, expectedPackSlotsInBlock, cleanupOrTerminalEpoch, maybeOwnStructuredPackSlot, preclaimFutureStructuredPackOwner, preclaimFutureStructuredPackSlots, flushStructuredPack, flushReadyStructuredPacks } = require("./packs");
const { renderEnvironmentRead, renderIndexAccess, renderInfix, renderCallable } = require("../expression-semantics");
function render(ctx, rhs, env, provenRecursive = false, singleCallPacks = null) {
    if (rhs?.type === "FreshGenericForExpression") return render(ctx, rhs.expression, env, true, singleCallPacks);
    if (rhs?.type === "FreshTerminalRepeatConditionExpression") return render(ctx, rhs.expression, env, true, singleCallPacks);
    if (rhs?.type === "FreshGenericMethodCallExpression") {
        const receiver = render(ctx, rhs.receiver, env, true, singleCallPacks);
        if (typeof receiver !== "string" || typeof rhs.member !== "string") return null;
        const args = [];
        for (const arg of rhs.arguments || []) {
            const value = render(ctx, arg, env, true, singleCallPacks);
            if (typeof value !== "string") return null;
            args.push(value);
        }
        return `${receiver}:${rhs.member}(${args.join(", ")})`;
    }
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
        return renderIndexAccess(base, key);
    }
    if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base)) {
        // Proven recursive expressions may use an arbitrary computed key even
        // when the base itself is a register. This occurs after logical/loop
        // reduction folds compiler TEMP chains into one expression.
        const key = isIdentifier(rhs.index) ? resolveRenderableId(ctx, rhs.index.name, env)
            : (isPrimitiveLiteral(rhs.index) ? sourceOf(ctx.source, rhs.index)
                : (provenRecursive ? render(ctx, rhs.index, env, true, singleCallPacks) : null));
        if (key == null) return null;
        if (rhs.base.name === "_env") {
            return renderEnvironmentRead(key);
        }
        const base = resolveRenderableId(ctx, rhs.base.name, env);
        if (base == null) return null;
        return renderIndexAccess(base, key);
    }
    if (rhs?.type === "UnaryExpression") {
        const argument = provenRecursive ? render(ctx, rhs.argument, env, true, singleCallPacks)
            : (isIdentifier(rhs.argument) ? resolveRenderableId(ctx, rhs.argument.name, env) : (isPrimitiveLiteral(rhs.argument) ? sourceOf(ctx.source, rhs.argument) : null));
        return renderUnary(rhs.operator, argument);
    }
    if ((provenRecursive || (rhs?.type === "LogicalExpression" &&
        (rhs.freshCompilerLogical === true || rhs.freshSemanticFallbackLogical === true))) &&
        (rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
        const left = render(ctx, rhs.left, env, true, singleCallPacks);
        const right = render(ctx, rhs.right, env, true, singleCallPacks);
        if (left == null || right == null) return null;
        return renderInfix(left, rhs.operator, right);
    }
    if ((rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
        const left = isIdentifier(rhs.left) ? resolveRenderableId(ctx, rhs.left.name, env) : (isPrimitiveLiteral(rhs.left) ? sourceOf(ctx.source, rhs.left) : null);
        const right = isIdentifier(rhs.right) ? resolveRenderableId(ctx, rhs.right.name, env) : (isPrimitiveLiteral(rhs.right) ? sourceOf(ctx.source, rhs.right) : null);
        if (left == null || right == null) return null;
        return renderInfix(left, rhs.operator, right);
    }
    if (rhs?.type === "CallExpression") {
        // Logical/loop reduction may inline a proven compiler RETURN_ALL pack
        // directly into unpack(), producing unpack({ call(...) }). In recursive
        // proven expressions that table is compiler transport, not source table
        // identity, so preserve the original multi-return call directly.
        if (provenRecursive && isIdentifier(rhs.base, "unpack") && (rhs.arguments || []).length === 1) {
            const inlinePack = rhs.arguments[0];
            const fields = inlinePack?.type === "TableConstructorExpression" ? (inlinePack.fields || []) : [];
            if (fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression") {
                const packedCall = render(ctx, fields[0].value, env, true, singleCallPacks);
                if (typeof packedCall === "string") return packedCall;
            }
        }
        if (isIdentifier(rhs.base, "unpack") && (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0]) && singleCallPacks instanceof Map) {
            const packed = singleCallPacks.get(rhs.arguments[0].name);
            if (typeof packed === "string") return packed;
        }
        if (ctx.renderAsFunction && isVarargUnpack(ctx, rhs, env)) {
            ctx.sawVarargs = true;
            return "...";
        }
        if (isCompilerVarargSelect(ctx, rhs)) {
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
        return renderCallable(base, args);
    }
    return null;
}

module.exports = { render };
