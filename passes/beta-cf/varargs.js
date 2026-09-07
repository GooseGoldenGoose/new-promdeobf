"use strict";

const { isIdentifier, isSingleAssignment } = require("./ast");

function argsIndex(node) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "args") || node.index?.type !== "NumericLiteral") return null;
    const index = Number(node.index.value);
    return Number.isInteger(index) && index >= 1 ? index : null;
}

function compilerVarargSelectIndex(node) {
    if (node?.type !== "CallExpression" || !isIdentifier(node.base, "select") || (node.arguments || []).length !== 2) return null;
    const first = node.arguments[0];
    const unpackCall = node.arguments[1];
    const index = first?.type === "NumericLiteral" ? Number(first.value) : NaN;
    if (!Number.isInteger(index) || index < 1) return null;
    if (unpackCall?.type !== "CallExpression" || !isIdentifier(unpackCall.base, "unpack") ||
        (unpackCall.arguments || []).length !== 1 || !isIdentifier(unpackCall.arguments[0], "args")) return null;
    return index;
}

function compilerVarargPackIndex(node) {
    const fields = node?.type === "TableConstructorExpression" ? (node.fields || []) : [];
    if (fields.length !== 1 || fields[0]?.type !== "TableValue") return null;
    return compilerVarargSelectIndex(fields[0].value);
}

function parameterInitIndices(statements) {
    const indices = new Set();
    for (const statement of statements || []) {
        if (!isSingleAssignment(statement)) continue;
        const index = argsIndex(statement.init?.[0]);
        if (index !== null) indices.add(index);
    }
    return indices;
}

function provesCompilerVarargBoundary(statements, firstVarargIndex) {
    if (!Number.isInteger(firstVarargIndex) || firstVarargIndex < 1) return false;
    const fixed = parameterInitIndices(statements);
    for (let index = 1; index < firstVarargIndex; index++) {
        if (!fixed.has(index)) return false;
    }
    for (const index of fixed) {
        if (index >= firstVarargIndex) return false;
    }
    return true;
}

function inferCompilerVarargFirstIndex(statements) {
    let candidate = null;
    for (const statement of statements || []) {
        if (!isSingleAssignment(statement)) continue;
        const index = compilerVarargPackIndex(statement.init?.[0]);
        if (index === null) continue;
        if (candidate !== null && candidate !== index) return null;
        candidate = index;
    }
    if (candidate === null || !provesCompilerVarargBoundary(statements, candidate)) return null;
    return candidate;
}

module.exports = { argsIndex, compilerVarargSelectIndex, compilerVarargPackIndex, provesCompilerVarargBoundary, inferCompilerVarargFirstIndex };
