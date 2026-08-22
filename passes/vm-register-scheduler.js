const { findVmFunction } = require("./vm-state");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isPrimitiveLiteral(node) {
    return ["StringLiteral", "NumericLiteral", "BooleanLiteral", "NilLiteral"].includes(node?.type);
}

function isDelayableAssignment(statement, stateName) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) return false;

    const name = variables[0].name;
    if ([stateName, "args", "upvalues", "gcProxy"].includes(name)) return false;

    const rhs = init[0];
    return isPrimitiveLiteral(rhs) || isIdentifier(rhs);
}

function collectExpressionReads(node, out) {
    if (!isNode(node) || node.type === "FunctionDeclaration") return;
    if (node.type === "Identifier") {
        out.add(node.name);
        return;
    }
    if (node.type === "MemberExpression") {
        collectExpressionReads(node.base, out);
        return;
    }
    if (node.type === "TableKeyString") {
        collectExpressionReads(node.value, out);
        return;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectExpressionReads(child, out);
        } else if (isNode(value)) {
            collectExpressionReads(value, out);
        }
    }
}

function statementReads(statement) {
    const out = new Set();
    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (!isIdentifier(variable)) collectExpressionReads(variable, out);
        }
        for (const rhs of statement.init || []) collectExpressionReads(rhs, out);
        return out;
    }
    collectExpressionReads(statement, out);
    return out;
}

function statementWrites(statement) {
    const out = new Set();
    if (statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") return out;
    for (const variable of statement.variables || []) {
        if (isIdentifier(variable)) out.add(variable.name);
    }
    return out;
}

function intersects(a, b) {
    for (const value of a) if (b.has(value)) return true;
    return false;
}

function canSwapRightAssignmentWithLeftStatement(delayable, current, stateName) {
    if (!isDelayableAssignment(delayable, stateName)) return false;

    const delayReads = statementReads(delayable);
    const delayWrites = statementWrites(delayable);
    const currentReads = statementReads(current);
    const currentWrites = statementWrites(current);

    if (intersects(delayWrites, currentReads)) return false;
    if (intersects(delayReads, currentWrites)) return false;
    if (intersects(delayWrites, currentWrites)) return false;
    return true;
}

function hasPriorBlockDefinition(statements, index) {
    const reads = statementReads(statements[index]);
    if (reads.size === 0) return false;

    const defined = new Set();
    for (let i = 0; i < index; i++) {
        for (const name of statementWrites(statements[i])) defined.add(name);
    }
    return intersects(reads, defined);
}

function scheduleStatementList(statements, stateName) {
    const scheduled = [...statements];
    let swaps = 0;

    for (let i = 1; i < scheduled.length; i++) {
        let currentIndex = i;
        const current = scheduled[currentIndex];
        if (!hasPriorBlockDefinition(scheduled, currentIndex)) continue;

        while (currentIndex > 0) {
            const previous = scheduled[currentIndex - 1];
            if (!canSwapRightAssignmentWithLeftStatement(previous, current, stateName)) break;
            scheduled[currentIndex - 1] = current;
            scheduled[currentIndex] = previous;
            currentIndex--;
            swaps++;
        }
    }

    return { statements: scheduled, swaps };
}

function findStateWhile(vmFunction, stateName) {
    let found = null;
    function walk(node) {
        if (!isNode(node) || found) return;
        if (node.type === "FunctionDeclaration" && node !== vmFunction) return;
        if (node.type === "WhileStatement" && isIdentifier(node.condition, stateName)) {
            found = node;
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) walk(child);
            } else if (isNode(value)) {
                walk(value);
            }
        }
    }
    for (const statement of vmFunction.body || []) walk(statement);
    return found;
}

function isNumericLiteral(node) {
    return node?.type === "NumericLiteral";
}

function isStateDecisionCondition(node, stateName) {
    if (node?.type !== "BinaryExpression") return false;
    if (!["==", "<", "<=", ">", ">="].includes(node.operator)) return false;
    return (
        (isIdentifier(node.left, stateName) && isNumericLiteral(node.right)) ||
        (isNumericLiteral(node.left) && isIdentifier(node.right, stateName))
    );
}

function isDispatcherIf(statement, stateName) {
    if (statement?.type !== "IfStatement") return false;
    const clauses = statement.clauses || [];
    if (clauses.length === 0) return false;
    for (const clause of clauses) {
        if (clause.type === "ElseClause") continue;
        if (!isStateDecisionCondition(clause.condition, stateName)) return false;
    }
    return true;
}

function collectDispatcherLeaves(body, stateName, out = []) {
    const significant = (body || []).filter(statement => statement?.type !== "CommentStatement");
    if (significant.length === 1 && isDispatcherIf(significant[0], stateName)) {
        for (const clause of significant[0].clauses || []) {
            collectDispatcherLeaves(clause.body || [], stateName, out);
        }
        return out;
    }
    out.push(body || []);
    return out;
}

function sourceOf(source, node) {
    if (!Array.isArray(node?.range)) return "";
    return source.slice(node.range[0], node.range[1]);
}

function lineIndentAt(source, offset) {
    const lineStart = source.lastIndexOf("\n", Math.max(0, offset - 1)) + 1;
    const prefix = source.slice(lineStart, offset);
    const match = prefix.match(/^[\t ]*/);
    return match ? match[0] : "";
}

function hasOnlyWhitespaceBetween(source, statements) {
    for (let i = 1; i < statements.length; i++) {
        const gap = source.slice(statements[i - 1].range[1], statements[i].range[0]);
        if (!/^\s*$/.test(gap)) return false;
    }
    return true;
}

function renderScheduledBody(source, original, scheduled) {
    const indent = lineIndentAt(source, original[0].range[0]);
    const newline = source.includes("\r\n") ? "\r\n" : "\n";
    return scheduled.map(statement => sourceOf(source, statement)).join(newline + indent);
}

function applyEdits(source, edits) {
    let output = source;
    for (const edit of edits.sort((a, b) => b.start - a.start)) {
        output = output.slice(0, edit.start) + edit.text + output.slice(edit.end);
    }
    return output;
}

function scheduleVmRegisterUses(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) {
        return { source, found: false, applied: false, reason: "No semantically named vm function was found", blocksChanged: 0, swaps: 0 };
    }

    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) {
        return { source, found: false, applied: false, reason: "VM state parameter is not an identifier", blocksChanged: 0, swaps: 0 };
    }

    const stateName = stateParam.name;
    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) {
        return { source, found: false, applied: false, reason: "No while <state> dispatcher was found", blocksChanged: 0, swaps: 0 };
    }

    const leaves = collectDispatcherLeaves(stateWhile.body || [], stateName);
    const edits = [];
    let blocksChanged = 0;
    let swaps = 0;

    for (const body of leaves) {
        const segments = [];
        let segment = [];
        for (const statement of body) {
            if (statement?.type === "CommentStatement") {
                if (segment.length) segments.push(segment);
                segment = [];
                continue;
            }
            segment.push(statement);
        }
        if (segment.length) segments.push(segment);

        for (const statements of segments) {
            if (statements.length < 2) continue;
            if (!statements.every(statement => Array.isArray(statement.range))) continue;
            if (!hasOnlyWhitespaceBetween(source, statements)) continue;

            const scheduled = scheduleStatementList(statements, stateName);
            if (scheduled.swaps === 0) continue;

            edits.push({
                start: statements[0].range[0],
                end: statements[statements.length - 1].range[1],
                text: renderScheduledBody(source, statements, scheduled.statements),
            });
            blocksChanged++;
            swaps += scheduled.swaps;
        }
    }

    if (edits.length === 0) {
        return { source, found: true, applied: false, blocksChanged: 0, swaps: 0 };
    }

    return {
        source: applyEdits(source, edits),
        found: true,
        applied: true,
        blocksChanged,
        swaps,
    };
}

module.exports = {
    scheduleVmRegisterUses,
    scheduleStatementList,
    canSwapRightAssignmentWithLeftStatement,
};
