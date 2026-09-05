"use strict";

const { isIdentifier, isSingleAssignment, isPrimitiveLiteral, isEmptyTable, isVmRegisterName, sourceOf, renderTableFields, renderUnary, isLuaIdentifier } = require("../ast");
const { localName } = require("./bindings");
function memberMeta(ctx, rhs) {
    if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base) || !isIdentifier(rhs.index) || rhs.base.name === "_env") return null;
    const key = ctx.expr.get(rhs.index.name) ?? (ctx.locals.has(rhs.index.name) ? localName(ctx, rhs.index.name) : null);
    const base = ctx.expr.get(rhs.base.name) ?? (ctx.locals.has(rhs.base.name) ? localName(ctx, rhs.base.name) : null);
    if (typeof key !== "string" || typeof base !== "string") return null;
    const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
    return member && isLuaIdentifier(member) ? { kind: "member", base, member } : null;
}

function renderCallArg(ctx, arg) {
    if (isPrimitiveLiteral(arg) || isEmptyTable(arg)) return sourceOf(ctx.source, arg);
    if (isIdentifier(arg)) return ctx.expr.get(arg.name) ?? (ctx.locals.has(arg.name) ? localName(ctx, arg.name) : null);
    if (arg?.type === "CallExpression" && isIdentifier(arg.base, "unpack") && (arg.arguments || []).length === 1 && isIdentifier(arg.arguments[0])) {
        const packReg = arg.arguments[0].name;
        if (ctx.exprKinds.get(packReg) === "return-pack") return ctx.expr.get(packReg) ?? null;
    }
    return renderRhs(ctx, arg);
}

function renderRhs(ctx, rhs) {
    if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(ctx.source, rhs);
    if (rhs?.type === "TableConstructorExpression") {
        const fields = rhs.fields || [];
        if (fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression") return renderRhs(ctx, fields[0].value);
        return renderTableFields(fields, node => renderRhs(ctx, node));
    }
    if (isIdentifier(rhs)) return ctx.expr.get(rhs.name) ?? (ctx.locals.has(rhs.name) ? localName(ctx, rhs.name) : null);
    if (rhs?.type === "UnaryExpression") {
        const argument = renderRhs(ctx, rhs.argument);
        return renderUnary(rhs.operator, argument);
    }
    if (rhs?.type === "BinaryExpression" && typeof rhs.operator === "string") {
        const left = renderRhs(ctx, rhs.left);
        const right = renderRhs(ctx, rhs.right);
        if (typeof left !== "string" || typeof right !== "string") return null;
        return `(${left} ${rhs.operator} ${right})`;
    }
    if (rhs?.type === "LogicalExpression" && rhs.freshCompilerLogical === true && typeof rhs.operator === "string") {
        const left = renderRhs(ctx, rhs.left);
        const right = renderRhs(ctx, rhs.right);
        if (typeof left !== "string" || typeof right !== "string") return null;
        return `(${left} ${rhs.operator} ${right})`;
    }
    if (rhs?.type === "LogicalExpression" && isIdentifier(rhs.left)) {
        const rightIsIdentifier = isIdentifier(rhs.right);
        const rightIsCompilerUpvalueRead = rhs.right?.type === "IndexExpression" &&
            isIdentifier(rhs.right.base, "upvalueValues") && isIdentifier(rhs.right.index);
        if (!rightIsIdentifier && !rightIsCompilerUpvalueRead) return null;
        const left = ctx.expr.get(rhs.left.name) ?? (ctx.locals.has(rhs.left.name) ? localName(ctx, rhs.left.name) : null);
        const right = renderRhs(ctx, rhs.right);
        if (left == null || right == null || typeof rhs.operator !== "string") return null;
        return `(${left} ${rhs.operator} ${right})`;
    }
    if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base)) {
        if (rhs.base.name === "upvalueValues" && isIdentifier(rhs.index)) {
            const captureName = ctx.upvalueCells.get(rhs.index.name);
            return typeof captureName === "string" ? captureName : null;
        }
        if (ctx.exprKinds.get(rhs.base.name) === "return-pack" && rhs.index?.type === "NumericLiteral") {
            const slot = Number(rhs.index.value);
            if (!Number.isInteger(slot) || slot < 1) return null;
            return { packSlot: true, packReg: rhs.base.name, slot, call: ctx.expr.get(rhs.base.name) };
        }
        if (!isIdentifier(rhs.index)) return null;
        const key = ctx.expr.get(rhs.index.name);
        if (key == null) return null;
        if (rhs.base.name === "_env") {
            const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
        }
        const base = ctx.expr.get(rhs.base.name) ?? (ctx.locals.has(rhs.base.name) ? localName(ctx, rhs.base.name) : null);
        if (base == null) return null;
        const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
        return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
    }
    if (rhs?.type === "CallExpression" && isIdentifier(rhs.base)) {
        if (/^createClosure\d*$/.test(rhs.base.name) && typeof ctx.options.renderCapturedCall === "function") {
            const args = rhs.arguments || [];
            const fields = args[1]?.type === "TableConstructorExpression" ? args[1].fields || [] : [];
            if (args.length === 2 && args[0]?.type === "NumericLiteral" && fields.length > 0) {
                const captureNames = new Map();
                for (let i = 0; i < fields.length; i++) {
                    const field = fields[i];
                    if (field?.type !== "TableValue" || !isIdentifier(field.value)) return null;
                    const captureName = ctx.upvalueCells.get(field.value.name);
                    if (typeof captureName !== "string") return null;
                    captureNames.set(i + 1, captureName);
                }
                const special = ctx.options.renderCapturedCall(rhs, captureNames);
                if (special != null) return special;
            }
        }
        if (typeof ctx.options.renderSpecialCall === "function") {
            const special = ctx.options.renderSpecialCall(rhs);
            if (special != null) return special;
        }
        if (rhs.base.name === "unpack" && (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0])) {
            const packReg = rhs.arguments[0].name;
            if (ctx.exprKinds.get(packReg) === "return-pack") return ctx.expr.get(packReg) ?? null;
        }
        const base = ctx.expr.get(rhs.base.name) ?? (ctx.locals.has(rhs.base.name) ? localName(ctx, rhs.base.name) : null);
        if (!base) return null;
        const args = [];
        for (const arg of rhs.arguments || []) {
            const value = renderCallArg(ctx, arg);
            if (typeof value !== "string") return null;
            args.push(value);
        }
        const member = ctx.exprMeta.get(rhs.base.name);
        if (member?.kind === "member" && args.length > 0 && args[0] === member.base) {
            return `${member.base}:${member.member}(${args.slice(1).join(", ")})`;
        }
        const callable = /^function\b/.test(base.trim()) ? `(${base})` : base;
        return `${callable}(${args.join(", ")})`;
    }
    return null;
}

module.exports = { memberMeta, renderCallArg, renderRhs };
