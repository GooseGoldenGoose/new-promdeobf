const { findVmFunction } = require("./vm-state");
const { findVmReturnRegister, findRegisterDeclaration } = require("./vm-register-names");
const { applyTextEdits } = require("./text-edits");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = typeof node.value === "number" ? node.value : Number(node.raw);
    return Number.isInteger(value) ? value : null;
}

function isExactStateLeafClause(clause, stateName) {
    if (clause?.type !== "IfClause") return false;
    const condition = clause.condition;
    if (condition?.type !== "BinaryExpression" || condition.operator !== "==") return false;
    return (
        (isIdentifier(condition.left, stateName) && numericValue(condition.right) !== null) ||
        (isIdentifier(condition.right, stateName) && numericValue(condition.left) !== null)
    );
}

function collectStateLeafClauses(node, stateName, out = []) {
    if (!isNode(node)) return out;
    if (node.type === "IfStatement") {
        for (const clause of node.clauses || []) {
            if (isExactStateLeafClause(clause, stateName)) out.push(clause);
        }
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectStateLeafClauses(child, stateName, out);
        } else if (isNode(value)) {
            collectStateLeafClauses(value, stateName, out);
        }
    }
    return out;
}

function collectIdentifierReadEdits(node, latestVersions, out = [], parent = null, parentKey = null) {
    if (!isNode(node)) return out;
    if (node.type === "Identifier") {
        const isProperty =
            (parent?.type === "MemberExpression" && parentKey === "identifier") ||
            (parent?.type === "TableKeyString" && parentKey === "key");
        const replacement = latestVersions.get(node.name);
        if (!isProperty && replacement && Array.isArray(node.range)) {
            out.push({ start: node.range[0], end: node.range[1], replacement });
        }
        return out;
    }

    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectIdentifierReadEdits(child, latestVersions, out, node, key);
        } else if (isNode(value)) {
            collectIdentifierReadEdits(value, latestVersions, out, node, key);
        }
    }
    return out;
}

function rewriteExpression(source, expression, latestVersions) {
    if (!expression || !Array.isArray(expression.range)) return null;
    const start = expression.range[0];
    const end = expression.range[1];
    const text = source.slice(start, end);
    const edits = collectIdentifierReadEdits(expression, latestVersions, []);
    return applyTextEdits(text, edits, start);
}

function versionVmBlockRegisters(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) {
        return { source, found: false, applied: false, reason: "No semantically named VM function was found" };
    }

    const vmFunction = vm.functionNode;
    const stateParameter = vmFunction.parameters?.[0];
    if (!isIdentifier(stateParameter)) {
        return { source, found: true, applied: false, reason: "VM state parameter is not an identifier" };
    }

    const returnRegister = findVmReturnRegister(vmFunction);
    if (!returnRegister) {
        return { source, found: true, applied: false, reason: "VM return register could not be identified" };
    }

    const registerDeclaration = findRegisterDeclaration(vmFunction, returnRegister.name);
    if (!registerDeclaration) {
        return { source, found: true, applied: false, reason: "VM scalar register declaration could not be identified" };
    }

    const candidateNames = new Set(registerDeclaration.variables.map(variable => variable.name));
    candidateNames.add(stateParameter.name);

    const leaves = collectStateLeafClauses(vmFunction, stateParameter.name, [])
        .sort((a, b) => a.range[0] - b.range[0]);
    if (leaves.length === 0) {
        return { source, found: true, applied: false, reason: "No exact normalized VM state leaves were found" };
    }

    const baseIds = new Map();
    const versionCounts = new Map();
    const edits = [];
    const versions = [];
    let nextBaseId = 1;
    let skippedAssignments = 0;

    function ensureBase(name) {
        if (!baseIds.has(name)) baseIds.set(name, nextBaseId++);
        return baseIds.get(name);
    }

    for (const leaf of leaves) {
        const latestVersions = new Map();
        const statements = (leaf.body || []).filter(statement => statement?.type !== "CommentStatement");
        for (const statement of statements) {
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const init = statement.init || [];
            if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) {
                for (const variable of variables) {
                    if (isIdentifier(variable) && candidateNames.has(variable.name)) latestVersions.delete(variable.name);
                }
                skippedAssignments++;
                continue;
            }

            const originalName = variables[0].name;
            if (!candidateNames.has(originalName)) continue;

            const rhs = rewriteExpression(source, init[0], latestVersions);
            if (rhs === null || !Array.isArray(statement.range)) {
                latestVersions.delete(originalName);
                skippedAssignments++;
                continue;
            }

            const baseId = ensureBase(originalName);
            const version = (versionCounts.get(originalName) || 0) + 1;
            versionCounts.set(originalName, version);
            const newName = `r_v${baseId}_${version}`;
            const replacement = `local ${newName} = ${rhs}`;
            edits.push({
                start: statement.range[0],
                end: statement.range[1],
                replacement,
            });
            latestVersions.set(originalName, newName);
            versions.push({
                blockState: numericValue(leaf.condition.left) ?? numericValue(leaf.condition.right),
                originalName,
                baseId,
                version,
                newName,
            });
        }
    }

    if (edits.length === 0) {
        return { source, found: true, applied: false, reason: "No supported VM register assignments were found" };
    }

    const output = applyTextEdits(source, edits);
    return {
        source: output,
        found: true,
        applied: output !== source,
        blockCount: leaves.length,
        versionedAssignmentCount: versions.length,
        skippedAssignments,
        mapping: [...baseIds.entries()].map(([originalName, baseId]) => ({ originalName, baseName: `r_v${baseId}` })),
        versions,
        edits,
    };
}

module.exports = {
    versionVmBlockRegisters,
};
