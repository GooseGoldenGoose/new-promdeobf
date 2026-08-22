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
    if (lines.length <= 1) return lines.join("\n");

    // AST ranges begin at the first token, so continuation lines still carry
    // original source indentation while line 1 starts at column 0.
    let min = Infinity;
    for (let i = 1; i < lines.length; i++) {
        if (!lines[i].trim()) continue;
        const match = lines[i].match(/^[\t ]*/);
        min = Math.min(min, match ? match[0].length : 0);
    }
    if (!Number.isFinite(min) || min === 0) return lines.join("\n");
    return [lines[0], ...lines.slice(1).map(line => line.trim() ? line.slice(min) : "")].join("\n");
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

function isClosureFactoryName(name) {
    return typeof name === "string" && /^createClosure(?:\d+)?$/.test(name);
}

function findClosureEntries(ast) {
    const entries = [];
    function walk(node) {
        if (!isNode(node)) return;
        if (node.type === "CallExpression" && isIdentifier(node.base) &&
            isClosureFactoryName(node.base.name)) {
            const args = node.arguments || [];
            const entryId = numericValue(args[0]);
            if (entryId !== null) entries.push({ entryId, factory: node.base.name, call: node });
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) for (const child of value) walk(child);
            else if (isNode(value)) walk(value);
        }
    }
    walk(ast);
    return entries;
}

function bodyKey(body) {
    if (!body?.length) return "empty";
    return `${body[0].range?.[0] ?? -1}:${body[body.length - 1].range?.[1] ?? -1}`;
}

function collectDispatcherLeaves(body, source, out = []) {
    if (body?.length === 1 && body[0]?.type === "IfStatement") {
        for (const clause of body[0].clauses || []) {
            collectDispatcherLeaves(clause.body || [], source, out);
        }
        return out;
    }
    out.push({ body: body || [], key: bodyKey(body || []) });
    return out;
}

function findStateAssignment(statement, stateName) {
    if (statement?.type !== "AssignmentStatement") return null;
    const vars = statement.variables || [];
    const init = statement.init || [];
    for (let i = 0; i < Math.min(vars.length, init.length); i++) {
        if (isIdentifier(vars[i], stateName)) return init[i];
    }
    return null;
}

function analyzeBranchTarget(node, source) {
    if (node?.type !== "LogicalExpression" || node.operator !== "or") return null;
    if (node.left?.type !== "LogicalExpression" || node.left.operator !== "and") return null;
    const onTrue = numericValue(node.left.right);
    const onFalse = numericValue(node.right);
    if (onTrue === null || onFalse === null) return null;
    return {
        kind: "branch",
        condition: sourceOf(source, node.left.left),
        onTrue,
        onFalse,
        expression: sourceOf(source, node),
    };
}

function analyzeBlockTerminator(body, stateName, source) {
    // Prometheus can reuse POS_REGISTER as a temporary register. Only the
    // final write to the state/POS variable is a block terminator.
    for (let i = (body?.length ?? 0) - 1; i >= 0; i--) {
        const rhs = findStateAssignment(body[i], stateName);
        if (!rhs) continue;
        const direct = numericValue(rhs);
        if (direct !== null) {
            return { kind: "jump", target: direct, statementIndex: i, expression: sourceOf(source, rhs) };
        }
        const branch = analyzeBranchTarget(rhs, source);
        if (branch) return { ...branch, statementIndex: i };
        return { kind: "stop", statementIndex: i, expression: sourceOf(source, rhs) };
    }
    return { kind: "unknown", statementIndex: -1, expression: null };
}

function resolveStateBlock(dispatcherBody, stateName, stateId, source) {
    const path = [];
    const body = resolveDispatcherBody(dispatcherBody, stateName, stateId, source, path);
    if (!body) return null;
    return {
        id: stateId,
        body,
        key: bodyKey(body),
        path,
        terminator: analyzeBlockTerminator(body, stateName, source),
    };
}

function successorsOf(term) {
    if (term?.kind === "jump") return [term.target];
    if (term?.kind === "branch") return [term.onTrue, term.onFalse];
    return [];
}

function walkStateGraph(dispatcherBody, stateName, rootId, source) {
    const queue = [rootId];
    const blocks = new Map();
    const order = [];
    while (queue.length) {
        const id = queue.shift();
        if (blocks.has(id)) continue;
        const block = resolveStateBlock(dispatcherBody, stateName, id, source);
        if (!block) {
            blocks.set(id, { id, unresolved: true, terminator: { kind: "unresolved" } });
            order.push(id);
            continue;
        }
        blocks.set(id, block);
        order.push(id);
        for (const next of successorsOf(block.terminator)) {
            if (!blocks.has(next)) queue.push(next);
        }
    }
    return { rootId, blocks, order };
}

function renderStateMembership(stateName, ids) {
    return ids.map(id => `${stateName} == ${id}`).join(" or ");
}

function renderGroupedDispatcher(source, stateWhile, stateName, graphRoots, blocks, complete) {
    const indent = lineIndentAt(source, stateWhile.range[0]);
    const bodyIndent = indent + "    ";
    const groupIndent = bodyIndent + "    ";
    const caseIndent = groupIndent + "    ";
    const lines = [`while ${stateName} do`];
    const assigned = new Set();
    let groupIndex = 0;

    for (const root of graphRoots) {
        const ids = root.graph.order.filter(id => blocks.has(id) && !assigned.has(id));
        if (!ids.length) continue;
        for (const id of ids) assigned.add(id);

        const keyword = groupIndex === 0 ? "if" : "elseif";
        const label = root.kind === "root"
            ? `root entry ${root.entryId}`
            : `${root.factory} entry ${root.entryId}`;
        lines.push(`${bodyIndent}${keyword} ${renderStateMembership(stateName, ids)} then -- beta: ${label}`);

        if (ids.length === 1) {
            const block = blocks.get(ids[0]);
            if (block?.body?.length) lines.push(renderStatements(source, block.body, groupIndent));
            else lines.push(`${groupIndent}${stateName} = nil`);
        } else {
            ids.forEach((id, index) => {
                const block = blocks.get(id);
                const entryComment = id === root.entryId ? " -- entry" : "";
                lines.push(`${groupIndent}${index === 0 ? "if" : "elseif"} ${stateName} == ${id} then${entryComment}`);
                if (block?.body?.length) lines.push(renderStatements(source, block.body, caseIndent));
                else lines.push(`${caseIndent}${stateName} = nil`);
            });
            lines.push(`${groupIndent}end`);
        }
        groupIndex++;
    }

    lines.push(`${bodyIndent}${groupIndex === 0 ? "if true then" : "else"}`);
    if (complete) {
        lines.push(`${groupIndent}-- beta: invalid/unreachable VM state`);
        lines.push(`${groupIndent}${stateName} = nil`);
    } else {
        lines.push(`${groupIndent}-- beta: unresolved state, keep original dispatcher behavior`);
        lines.push(renderStatements(source, stateWhile.body || [], groupIndent));
    }
    lines.push(`${bodyIndent}end`);
    lines.push(`${indent}end`);
    return lines.join("\n");
}

function resolveEntryStateGraphBeta(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) return { source, found: false, reason: "No semantically named vm function was found" };

    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) return { source, found: false, reason: "VM state parameter is not an identifier" };
    const stateName = stateParam.name;

    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) return { source, found: false, reason: "No while <state> dispatcher was found" };

    const rootEntry = findRootEntry(ast);
    if (!rootEntry) return { source, found: false, reason: "No root entry was found" };

    const rootGraph = walkStateGraph(stateWhile.body || [], stateName, rootEntry.entryId, source);
    const closureEntries = findClosureEntries(ast);

    const allBlocks = new Map();
    const graphRoots = [];
    const seenRoots = new Set();

    function addRoot(kind, factory, entryId) {
        if (seenRoots.has(entryId)) return;
        seenRoots.add(entryId);
        const graph = walkStateGraph(stateWhile.body || [], stateName, entryId, source);
        graphRoots.push({ kind, factory, entryId, graph });
        for (const id of graph.order) if (!allBlocks.has(id)) allBlocks.set(id, graph.blocks.get(id));
    }

    addRoot("root", rootEntry.factory || "createClosure", rootEntry.entryId);
    for (const entry of closureEntries) addRoot("closure", entry.factory, entry.entryId);

    const leaves = collectDispatcherLeaves(stateWhile.body || [], source);
    const leafKeys = new Set(leaves.map(leaf => leaf.key));
    const resolvedKeys = new Set([...allBlocks.values()].filter(b => b?.key).map(b => b.key));

    const owners = new Map();
    let collision = false;
    for (const [id, block] of allBlocks) {
        if (!block?.key) continue;
        if (owners.has(block.key) && owners.get(block.key) !== id) collision = true;
        else owners.set(block.key, id);
    }

    const complete = !collision &&
        leafKeys.size > 0 &&
        leafKeys.size === resolvedKeys.size &&
        [...leafKeys].every(key => resolvedKeys.has(key));

    const orderedIds = [];
    for (const root of graphRoots) {
        for (const id of root.graph.order) if (!orderedIds.includes(id)) orderedIds.push(id);
    }

    const replacement = renderGroupedDispatcher(source, stateWhile, stateName, graphRoots, allBlocks, complete);
    const output = source.slice(0, stateWhile.range[0]) + replacement + source.slice(stateWhile.range[1]);

    return {
        source: output,
        found: true,
        rootEntryId: rootEntry.entryId,
        rootGraph,
        graphRoots,
        blocks: allBlocks,
        orderedIds,
        dispatcherLeafCount: leafKeys.size,
        resolvedLeafCount: resolvedKeys.size,
        complete,
        collision,
    };
}

module.exports = {
    numericValue,
    findVmFunction,
    findRootEntry,
    findClosureEntries,
    evaluateStateCondition,
    analyzeBlockTerminator,
    resolveStateBlock,
    walkStateGraph,
    resolveEntryStateGraphBeta,
};
