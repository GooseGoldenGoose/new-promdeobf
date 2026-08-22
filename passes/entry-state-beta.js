function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (!node || node.type !== "NumericLiteral") return null;
    if (typeof node.value === "number") return node.value;
    const value = Number(node.raw);
    return Number.isFinite(value) ? value : null;
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

function dedent(text) {
    const lines = text.replace(/\r\n/g, "\n").split("\n");
    let min = Infinity;
    for (const line of lines) {
        if (!line.trim()) continue;
        const match = line.match(/^[\t ]*/);
        min = Math.min(min, match ? match[0].length : 0);
    }
    if (!Number.isFinite(min) || min === 0) return lines.join("\n");
    return lines.map(line => line.trim() ? line.slice(min) : "").join("\n");
}

function indentText(text, indent) {
    return dedent(text)
        .split("\n")
        .map(line => line.length ? indent + line : line)
        .join("\n");
}

function renderStatements(source, statements, indent) {
    return (statements || [])
        .map(statement => indentText(sourceOf(source, statement), indent))
        .join("\n");
}

function findVmFunction(ast) {
    let found = null;

    function walk(node) {
        if (!isNode(node) || found) return;

        if (node.type === "AssignmentStatement") {
            const vars = node.variables || [];
            const init = node.init || [];
            const count = Math.min(vars.length, init.length);

            for (let i = 0; i < count; i++) {
                if (isIdentifier(vars[i], "vm") && init[i]?.type === "FunctionDeclaration") {
                    found = {
                        assignment: node,
                        functionNode: init[i],
                        variable: vars[i],
                    };
                    return;
                }
            }
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

    walk(ast);
    return found;
}

function isEmptyTable(node) {
    return node?.type === "TableConstructorExpression" && (node.fields?.length ?? 0) === 0;
}

function findRootEntry(ast) {
    const candidates = [];

    function walk(node, parent = null, insideVm = false) {
        if (!isNode(node)) return;

        const nowInsideVm =
            insideVm ||
            (node.type === "FunctionDeclaration" &&
                (node.parameters || []).length >= 1 &&
                isIdentifier(node.parameters[0], "state"));

        if (!nowInsideVm &&
            node.type === "CallExpression" &&
            node.base?.type === "CallExpression" &&
            isIdentifier(node.base.base, "createClosure")) {
            const factoryCall = node.base;
            const args = factoryCall.arguments || [];
            const entryId = numericValue(args[0]);
            if (entryId !== null) {
                let score = 0;
                if (isEmptyTable(args[1])) score += 2;
                if (parent?.type === "ReturnStatement") score += 4;
                candidates.push({
                    entryId,
                    entryNode: args[0],
                    factoryCall,
                    invocation: node,
                    score,
                });
            }
        }

        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) walk(child, node, nowInsideVm);
            } else if (isNode(value)) {
                walk(value, node, nowInsideVm);
            }
        }
    }

    walk(ast);
    if (candidates.length === 0) return null;
    candidates.sort((a, b) => b.score - a.score || a.factoryCall.range[0] - b.factoryCall.range[0]);
    return candidates[0];
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

function compare(operator, left, right) {
    switch (operator) {
        case "==": return left === right;
        case "~=": return left !== right;
        case "<": return left < right;
        case "<=": return left <= right;
        case ">": return left > right;
        case ">=": return left >= right;
        default: return null;
    }
}

function evaluateStateCondition(node, stateName, stateValue) {
    if (!isNode(node)) return null;

    if (node.type === "UnaryExpression" && node.operator === "not") {
        const value = evaluateStateCondition(node.argument, stateName, stateValue);
        return value === null ? null : !value;
    }

    if (node.type === "LogicalExpression") {
        const left = evaluateStateCondition(node.left, stateName, stateValue);
        const right = evaluateStateCondition(node.right, stateName, stateValue);
        if (left === null || right === null) return null;
        if (node.operator === "and") return left && right;
        if (node.operator === "or") return left || right;
        return null;
    }

    if (node.type !== "BinaryExpression") return null;

    const leftIsState = isIdentifier(node.left, stateName);
    const rightIsState = isIdentifier(node.right, stateName);
    const leftNumber = numericValue(node.left);
    const rightNumber = numericValue(node.right);

    if (leftIsState && rightNumber !== null) {
        return compare(node.operator, stateValue, rightNumber);
    }

    if (rightIsState && leftNumber !== null) {
        return compare(node.operator, leftNumber, stateValue);
    }

    return null;
}

function selectIfClause(statement, stateName, entryId, source, path) {
    if (statement?.type !== "IfStatement") return null;

    for (const clause of statement.clauses || []) {
        if (clause.type === "ElseClause" || !clause.condition) {
            path.push("else");
            return clause.body || [];
        }

        const result = evaluateStateCondition(clause.condition, stateName, entryId);
        if (result === null) return null;

        path.push(`${sourceOf(source, clause.condition)} => ${result}`);
        if (result) return clause.body || [];
    }

    return [];
}

function resolveDispatcherBody(body, stateName, entryId, source, path) {
    let current = body || [];

    // Prometheus emits the dispatcher as nested if trees. Descend only while
    // the entire current region is a single state-only decision.
    while (current.length === 1 && current[0]?.type === "IfStatement") {
        const selected = selectIfClause(current[0], stateName, entryId, source, path);
        if (!selected) break;
        current = selected;
    }

    return current;
}

function resolveFirstEntryStateBeta(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) {
        return {
            source,
            found: false,
            reason: "No semantically named vm function was found",
        };
    }

    const params = vm.functionNode.parameters || [];
    const stateParameter = params[0];
    if (!isIdentifier(stateParameter)) {
        return {
            source,
            found: false,
            reason: "VM state parameter is not an identifier",
        };
    }

    const rootEntry = findRootEntry(ast);
    if (!rootEntry) {
        return {
            source,
            found: false,
            reason: "No root createClosure(<numeric entry>, ...) invocation was found",
        };
    }

    const stateWhile = findStateWhile(vm.functionNode, stateParameter.name);
    if (!stateWhile) {
        return {
            source,
            found: false,
            entryId: rootEntry.entryId,
            reason: "No while <state> VM dispatcher was found",
        };
    }

    const path = [];
    const resolvedBody = resolveDispatcherBody(
        stateWhile.body || [],
        stateParameter.name,
        rootEntry.entryId,
        source,
        path,
    );

    if (!resolvedBody.length) {
        return {
            source,
            found: false,
            entryId: rootEntry.entryId,
            reason: "The root entry state resolved to an empty dispatcher region",
        };
    }

    const indent = lineIndentAt(source, stateWhile.range[0]);
    const bodyIndent = indent + "    ";
    const branchIndent = bodyIndent + "    ";
    const entryRaw = sourceOf(source, rootEntry.entryNode) || String(rootEntry.entryId);

    const resolvedText = renderStatements(source, resolvedBody, branchIndent);
    const fallbackText = renderStatements(source, stateWhile.body || [], branchIndent);
    const pathText = path.length ? path.join(" | ") : "direct dispatcher body";

    const replacement = [
        `while ${stateParameter.name} do`,
        `${bodyIndent}-- beta: resolved root entry state ${entryRaw}`,
        `${bodyIndent}-- beta dispatcher path: ${pathText}`,
        `${bodyIndent}if ${stateParameter.name} == ${entryRaw} then`,
        resolvedText,
        `${bodyIndent}else`,
        fallbackText,
        `${bodyIndent}end`,
        `${indent}end`,
    ].join("\n");

    const output =
        source.slice(0, stateWhile.range[0]) +
        replacement +
        source.slice(stateWhile.range[1]);

    return {
        source: output,
        found: true,
        entryId: rootEntry.entryId,
        entryRaw,
        path,
        resolvedStatementCount: resolvedBody.length,
        originalDispatcherStatementCount: (stateWhile.body || []).length,
        vmRange: vm.functionNode.range,
        whileRange: stateWhile.range,
    };
}

module.exports = {
    numericValue,
    findVmFunction,
    findRootEntry,
    evaluateStateCondition,
    resolveFirstEntryStateBeta,
};
