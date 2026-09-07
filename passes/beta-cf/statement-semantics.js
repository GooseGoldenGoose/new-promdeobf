"use strict";

const { staticGlobalNameFromRenderedKey, renderStaticEnvironmentWrite } = require("./global-writes");
const { isIdentifier } = require("./ast");
const { decodeVmStatement } = require("./statement-ir");
const { renderIndexAccess } = require("./expression-semantics");

function matchCompilerGlobalAssignmentBatch(statements, startIndex, options = {}) {
    if (!Array.isArray(statements) || !Number.isInteger(startIndex) || startIndex < 0 || startIndex >= statements.length) return null;
    const resolveIdentifier = typeof options.resolveIdentifier === "function" ? options.resolveIdentifier : null;
    const isCompilerTemp = typeof options.isCompilerTemp === "function" ? options.isCompilerTemp : (() => true);
    const skipIndex = Number.isInteger(options.skipIndex) ? options.skipIndex : -1;
    const neutralReturnName = typeof options.neutralReturnName === "string" ? options.neutralReturnName : null;
    if (!resolveIdentifier || startIndex === skipIndex) return null;

    function globalSinkAt(index, forcedGlobalName = null, forcedKeyReg = null) {
        if (index === skipIndex) return null;
        const op = decodeVmStatement(statements[index]);
        if (!op || op.kind !== "index-write" || !isIdentifier(op.destination.base, "_env") ||
            !isIdentifier(op.destination.index) || !isIdentifier(op.value)) return null;
        if (forcedKeyReg !== null && op.destination.index.name !== forcedKeyReg) return null;
        const globalName = forcedGlobalName ?? staticGlobalNameFromRenderedKey(resolveIdentifier(op.destination.index.name));
        const value = resolveIdentifier(op.value.name);
        if (typeof globalName !== "string" || typeof value !== "string") return null;
        return { target: globalName, value, valueReg: op.value.name };
    }

    function lastRegisterWriteBefore(index, name) {
        for (let i = index - 1; i >= 0; i--) {
            if (i === skipIndex) continue;
            const op = decodeVmStatement(statements[i]);
            if (op?.kind === "register-write" && op.targetName === name) return i;
        }
        return -1;
    }

    function isNeutralReturnReset(index) {
        if (index === skipIndex || neutralReturnName === null) return false;
        const op = decodeVmStatement(statements[index]);
        return !!(op && op.kind === "register-write" && op.targetName === neutralReturnName &&
            op.value?.type === "TableConstructorExpression" && (op.value.fields || []).length === 0);
    }

    const first = globalSinkAt(startIndex);
    if (!first) return null;
    const items = [first];
    let cursor = startIndex + 1;
    const keyTemps = new Set();
    const neutralIndices = new Set();

    // Prometheus AssignmentStatement lowering evaluates every RHS before the
    // first LHS write. Later global LHS writes are then emitted as:
    //   keyTemp = "name"; _env[keyTemp] = precomputedRhsReg
    // The compiler may reset its RETURN register to {} between those writes.
    // That reset is neutral only when the next sink still consumes a carrier
    // whose reaching definition predates startIndex. This proves we are still
    // in the same source assignment and prevents merging a following statement,
    // whose RHS evaluation necessarily occurs after the previous LHS write.
    while (cursor < statements.length) {
        while (cursor < statements.length && isNeutralReturnReset(cursor)) {
            neutralIndices.add(cursor);
            cursor++;
        }
        if (cursor + 1 >= statements.length || cursor === skipIndex || cursor + 1 === skipIndex) break;
        const setup = decodeVmStatement(statements[cursor]);
        if (!setup || setup.kind !== "register-write" || !isCompilerTemp(setup.targetName) ||
            setup.value?.type !== "StringLiteral") break;
        const setupGlobalName = staticGlobalNameFromRenderedKey(setup.value.raw);
        if (typeof setupGlobalName !== "string") break;
        const next = globalSinkAt(cursor + 1, setupGlobalName, setup.targetName);
        if (!next) break;
        const rhsDef = lastRegisterWriteBefore(cursor + 1, next.valueReg);
        if (rhsDef < 0 || rhsDef >= startIndex) break;
        items.push(next);
        keyTemps.add(setup.targetName);
        cursor += 2;
    }

    if (items.length < 2) return null;
    return {
        line: items.map(item => item.target).join(", ") + " = " + items.map(item => item.value).join(", "),
        endIndex: cursor - 1,
        keyTemps,
        neutralIndices,
        count: items.length,
    };
}
function renderOrdinaryIndexCompoundWrite({ baseName, renderedBase, renderedKey, renderedValue, stableBase, operator }) {
    if (typeof baseName !== "string" || typeof renderedKey !== "string" || typeof renderedValue !== "string" || typeof operator !== "string") return null;
    const op = operator + "=";
    if (baseName === "_env") {
        const globalName = staticGlobalNameFromRenderedKey(renderedKey);
        return typeof globalName === "string" ? { kind: "global-compound-write", line: globalName + " " + op + " " + renderedValue, baseName } : null;
    }
    if (!stableBase || typeof renderedBase !== "string") return null;
    const target = renderIndexAccess(renderedBase, renderedKey);
    return target ? { kind: "index-compound-write", line: target + " " + op + " " + renderedValue, baseName } : null;
}

function renderOrdinaryIndexWrite({ baseName, renderedBase, renderedKey, renderedValue, stableBase }) {
    if (typeof baseName !== "string" || typeof renderedKey !== "string" || typeof renderedValue !== "string") return null;
    if (baseName === "_env") {
        const line = renderStaticEnvironmentWrite(renderedKey, renderedValue);
        return line ? { kind: "global-write", line, baseName } : null;
    }
    if (!stableBase || typeof renderedBase !== "string") return null;
    const target = renderIndexAccess(renderedBase, renderedKey);
    return target ? { kind: "index-write", line: `${target} = ${renderedValue}`, baseName } : null;
}

module.exports = { renderOrdinaryIndexWrite, renderOrdinaryIndexCompoundWrite, matchCompilerGlobalAssignmentBatch };
