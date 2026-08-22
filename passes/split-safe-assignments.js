function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node) {
    return node?.type === "Identifier";
}

function isPrimitiveLiteral(node) {
    return node && [
        "NumericLiteral",
        "StringLiteral",
        "BooleanLiteral",
        "NilLiteral",
    ].includes(node.type);
}

function isSafeAssignmentInitializer(node) {
    if (!isNode(node)) return false;
    if (isPrimitiveLiteral(node)) return true;
    if (node.type === "FunctionDeclaration") return node.identifier == null;
    if (node.type === "TableConstructorExpression") return (node.fields || []).length === 0;
    if (node.type === "UnaryExpression" && (node.operator === "-" || node.operator === "+")) {
        return node.argument?.type === "NumericLiteral";
    }
    return false;
}

function indentationAt(source, offset) {
    const lineStart = Math.max(source.lastIndexOf("\n", offset - 1) + 1, 0);
    const prefix = source.slice(lineStart, offset);
    const match = prefix.match(/^[\t ]*/);
    return match ? match[0] : "";
}

function sourceOf(source, node) {
    if (!Array.isArray(node?.range)) throw new Error("Node has no source range");
    return source.slice(node.range[0], node.range[1]);
}

function collectSafeSplits(source, ast) {
    const candidates = [];

    function visit(node) {
        if (!isNode(node)) return;

        if (node.type === "AssignmentStatement") {
            const variables = node.variables || [];
            const init = node.init || [];
            if (
                variables.length > 1 &&
                variables.length === init.length &&
                variables.every(isIdentifier) &&
                init.every(isSafeAssignmentInitializer)
            ) {
                candidates.push({ node, variables, init });
                return;
            }
        }

        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }

    visit(ast);
    return candidates;
}

function renderSplit(source, candidate) {
    const indent = indentationAt(source, candidate.node.range[0]);
    const eol = source.includes("\r\n") ? "\r\n" : "\n";
    const lines = candidate.variables.map((variable, index) =>
        `${sourceOf(source, variable)} = ${sourceOf(source, candidate.init[index])}`
    );
    return lines.map((line, index) => index === 0 ? line : indent + line).join(eol);
}

function splitSafeParallelAssignments(source, ast) {
    const candidates = collectSafeSplits(source, ast);
    const edits = candidates.map(candidate => ({
        start: candidate.node.range[0],
        end: candidate.node.range[1],
        replacement: renderSplit(source, candidate),
        count: candidate.variables.length,
    })).sort((a, b) => b.start - a.start);

    let output = source;
    for (const edit of edits) {
        output = output.slice(0, edit.start) + edit.replacement + output.slice(edit.end);
    }

    return {
        source: output,
        changed: edits.length > 0,
        splits: edits,
        statementsSplit: edits.length,
        assignmentsProduced: edits.reduce((sum, edit) => sum + edit.count, 0),
    };
}

function splitSafeParallelAssignmentsFully(source, parseLua, maxPasses = 8) {
    let current = source;
    let statementsSplit = 0;
    let assignmentsProduced = 0;
    let passes = 0;
    const splits = [];

    while (passes < maxPasses) {
        const ast = parseLua(current, `<safe assignment split pass ${passes + 1}>`);
        const result = splitSafeParallelAssignments(current, ast);
        if (!result.changed) break;

        current = result.source;
        statementsSplit += result.statementsSplit;
        assignmentsProduced += result.assignmentsProduced;
        splits.push(...result.splits);
        passes++;
    }

    return {
        source: current,
        changed: statementsSplit > 0,
        splits,
        statementsSplit,
        assignmentsProduced,
        passes,
    };
}

module.exports = {
    isSafeAssignmentInitializer,
    collectSafeSplits,
    splitSafeParallelAssignments,
    splitSafeParallelAssignmentsFully,
};