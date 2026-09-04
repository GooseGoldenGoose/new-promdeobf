"use strict";

const { isIdentifier, isSingleAssignment, significant } = require("./ast");

function findStateWhile(vmFunction, stateName) {
    for (const statement of vmFunction.body || []) {
        if (statement?.type === "WhileStatement" && isIdentifier(statement.condition, stateName)) return statement;
    }
    return null;
}

function unwrapSingleStateLeaf(stateWhile, stateName) {
    const body = significant(stateWhile?.body);
    if (body.length !== 1 || body[0]?.type !== "IfStatement") return null;
    const clauses = body[0].clauses || [];
    if (clauses.length !== 1) return null;
    const clause = clauses[0];
    if (clause?.type !== "IfClause") return null;
    const condition = clause.condition;
    if (condition?.type !== "BinaryExpression" || condition.operator !== "==") return null;
    const left = isIdentifier(condition.left, stateName) && condition.right?.type === "NumericLiteral";
    const right = isIdentifier(condition.right, stateName) && condition.left?.type === "NumericLiteral";
    if (!left && !right) return null;
    return significant(clause.body);
}

function extractNormalizedStateLeaves(stateWhile, stateName) {
    const leaves = new Map();

    function walk(node) {
        if (!node) return true;
        if (node.type === "IfStatement") {
            for (const clause of node.clauses || []) {
                if (clause?.type === "IfClause" || clause?.type === "ElseifClause") {
                    const c = clause.condition;
                    const left = isIdentifier(c?.left, stateName) && c?.right?.type === "NumericLiteral";
                    const right = isIdentifier(c?.right, stateName) && c?.left?.type === "NumericLiteral";
                    if (c?.type === "BinaryExpression" && c.operator === "==" && (left || right)) {
                        const id = Number(left ? c.right.value : c.left.value);
                        if (!Number.isInteger(id) || leaves.has(id)) return false;
                        leaves.set(id, significant(clause.body));
                        continue;
                    }
                }
                for (const statement of significant(clause?.body)) {
                    if (statement?.type === "IfStatement" && !walk(statement)) return false;
                }
            }
            return true;
        }
        return true;
    }

    for (const statement of significant(stateWhile?.body)) {
        if (statement?.type === "IfStatement" && !walk(statement)) return null;
    }
    return leaves.size ? leaves : null;
}

function decodeLogicalStateTransition(rhs) {
    if (rhs?.type !== "LogicalExpression" || rhs.operator !== "or") return null;
    const left = rhs.left;
    if (left?.type !== "LogicalExpression" || left.operator !== "and") return null;
    if (!isIdentifier(left.left) || left.right?.type !== "NumericLiteral" || rhs.right?.type !== "NumericLiteral") return null;
    const onTrue = Number(left.right.value);
    const onFalse = Number(rhs.right.value);
    if (!Number.isInteger(onTrue) || !Number.isInteger(onFalse)) return null;
    return { conditionRegister: left.left.name, onTrue, onFalse };
}

function normalizeRegisterOverflowGraph(root) {
    let applied = 0;
    let unsupported = 0;

    function visit(value, parent = null, key = null) {
        if (!value || typeof value !== "object") return;
        if (Array.isArray(value)) {
            for (let i = 0; i < value.length; i++) visit(value[i], value, i);
            return;
        }
        if (value.type === "IndexExpression" && isIdentifier(value.base, "RegisterOverflow")) {
            const slot = value.index?.type === "NumericLiteral" ? Number(value.index.value) : NaN;
            if (!Number.isInteger(slot) || slot < 0) {
                unsupported++;
                return;
            }
            const replacement = {
                type: "Identifier",
                name: `o${slot}`,
                range: value.range,
                loc: value.loc,
            };
            if (parent !== null) parent[key] = replacement;
            applied++;
            return;
        }
        for (const [childKey, child] of Object.entries(value)) {
            if (childKey === "range" || childKey === "loc") continue;
            visit(child, value, childKey);
        }
    }

    visit(root);
    return { applied: applied > 0, count: applied, unsupported };
}

module.exports = {
    findStateWhile,
    unwrapSingleStateLeaf,
    extractNormalizedStateLeaves,
    decodeLogicalStateTransition,
    normalizeRegisterOverflowGraph,
};
