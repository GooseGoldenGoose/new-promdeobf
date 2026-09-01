const { applyTextEdits } = require("./text-edits");
function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (!node) return null;
    if (node.type === "NumericLiteral") {
        const value = typeof node.value === "number" ? node.value : Number(node.raw);
        return Number.isSafeInteger(value) ? value : null;
    }
    if (node.type === "UnaryExpression" && node.operator === "-") {
        const value = numericValue(node.argument);
        return value === null || !Number.isSafeInteger(-value) ? null : -value;
    }
    if (node.type !== "BinaryExpression") return null;
    const left = numericValue(node.left);
    const right = numericValue(node.right);
    if (left === null || right === null) return null;
    let value;
    switch (node.operator) {
        case "+": value = left + right; break;
        case "-": value = left - right; break;
        case "*": value = left * right; break;
        case "/":
            if (right === 0 || left % right !== 0) return null;
            value = left / right; break;
        case "%":
            if (right === 0) return null;
            value = left - Math.floor(left / right) * right; break;
        case "^":
            if (right < 0) return null;
            value = left ** right; break;
        default: return null;
    }
    return Number.isSafeInteger(value) ? value : null;
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

        for (const key of Object.keys(node)) {
            const value = node[key];
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

        // Root createClosure discovery explicitly excludes the VM function and
        // everything nested beneath it. Once that boundary is reached there is
        // no useful candidate work left in the subtree, so do not traverse it.
        if (nowInsideVm) return;

        if (
            node.type === "CallExpression" &&
            node.base?.type === "CallExpression" &&
            isIdentifier(node.base.base) && isClosureFactoryName(node.base.base.name)) {
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

        for (const key of Object.keys(node)) {
            const value = node[key];
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) walk(child, node, false);
            } else if (isNode(value)) {
                walk(value, node, false);
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

        for (const key of Object.keys(node)) {
            const value = node[key];
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

function collectClosureEntryInfo(root) {
    const entries = [];
    const unsupported = [];
    function walk(node) {
        if (Array.isArray(node)) {
            for (const child of node) walk(child);
            return;
        }
        if (!isNode(node)) return;
        if (node.type === "CallExpression" && isIdentifier(node.base) &&
            isClosureFactoryName(node.base.name)) {
            const args = node.arguments || [];
            const entryId = numericValue(args[0]);
            if (entryId !== null) entries.push({ entryId, factory: node.base.name, call: node });
            else unsupported.push({ factory: node.base.name, call: node, entryNode: args[0] || null });
        }
        for (const key of Object.keys(node)) {
            const value = node[key];
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) for (const child of value) walk(child);
            else if (isNode(value)) walk(value);
        }
    }
    walk(root);
    return { entries, unsupported };
}

function findClosureEntryInfo(ast) {
    return collectClosureEntryInfo(ast);
}

function findClosureEntries(ast) {
    return findClosureEntryInfo(ast).entries;
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
        encoding: "direct-and-or",
        condition: sourceOf(source, node.left.left),
        onTrue,
        onFalse,
        trueTargetNode: node.left.right,
        falseTargetNode: node.right,
        expression: sourceOf(source, node),
    };
}

function singleIdentifierAssignment(statement) {
    if (statement?.type !== "AssignmentStatement") return null;
    const vars = statement.variables || [];
    const init = statement.init || [];
    if (vars.length !== 1 || init.length !== 1 || !isIdentifier(vars[0])) return null;
    return { name: vars[0].name, rhs: init[0], statement };
}

function analyzeSplitBranch(body, finalIndex, stateName, source) {
    if (finalIndex < 3) return null;

    const finalAssign = singleIdentifierAssignment(body[finalIndex]);
    if (!finalAssign || finalAssign.name !== stateName) return null;
    const finalRhs = finalAssign.rhs;
    if (finalRhs?.type !== "LogicalExpression" || finalRhs.operator !== "or" ||
        !isIdentifier(finalRhs.left, stateName) || !isIdentifier(finalRhs.right)) {
        return null;
    }

    const falseLoad = singleIdentifierAssignment(body[finalIndex - 1]);
    if (!falseLoad || falseLoad.name !== finalRhs.right.name) return null;
    const onFalse = numericValue(falseLoad.rhs);
    if (onFalse === null) return null;

    const andAssign = singleIdentifierAssignment(body[finalIndex - 2]);
    if (!andAssign || andAssign.name !== stateName) return null;
    const andRhs = andAssign.rhs;
    if (andRhs?.type !== "LogicalExpression" || andRhs.operator !== "and" ||
        !isIdentifier(andRhs.right)) {
        return null;
    }

    const trueLoad = singleIdentifierAssignment(body[finalIndex - 3]);
    if (!trueLoad || trueLoad.name !== andRhs.right.name) return null;
    const onTrue = numericValue(trueLoad.rhs);
    if (onTrue === null) return null;

    return {
        kind: "branch",
        encoding: "split-and-or",
        condition: sourceOf(source, andRhs.left),
        onTrue,
        onFalse,
        trueTargetNode: trueLoad.rhs,
        falseTargetNode: falseLoad.rhs,
        statementIndex: finalIndex,
        expression: body.slice(finalIndex - 3, finalIndex + 1)
            .map(statement => sourceOf(source, statement))
            .join("; "),
    };
}

function isCanonicalStopSentinel(node) {
    if (node?.type === "NilLiteral") return true;
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "_env") ||
        node.index?.type !== "StringLiteral") {
        return false;
    }
    const raw = node.index.raw || "";
    return /^["'][A-Za-z0-9]{12,14}["']$/.test(raw);
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
        const splitBranch = analyzeSplitBranch(body, i, stateName, source);
        if (splitBranch) return splitBranch;
        if (isCanonicalStopSentinel(rhs)) {
            return {
                kind: "stop",
                encoding: rhs.type === "NilLiteral" ? "literal-nil" : "prometheus-env-nil",
                statementIndex: i,
                expression: sourceOf(source, rhs),
            };
        }
        return { kind: "unknown", statementIndex: i, expression: sourceOf(source, rhs) };
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
    const queued = new Set([rootId]);
    const blocks = new Map();
    const order = [];

    // Cursor-based BFS keeps queue operations O(1). Each state is enqueued at
    // most once, so graph traversal itself is O(V + E).
    for (let cursor = 0; cursor < queue.length; cursor++) {
        const id = queue[cursor];
        const block = resolveStateBlock(dispatcherBody, stateName, id, source);
        if (!block) {
            blocks.set(id, { id, unresolved: true, terminator: { kind: "unresolved" } });
            order.push(id);
            continue;
        }
        blocks.set(id, block);
        order.push(id);
        for (const next of successorsOf(block.terminator)) {
            if (queued.has(next)) continue;
            queued.add(next);
            queue.push(next);
        }
    }
    return { rootId, blocks, order };
}

function renderStateMembership(stateName, ids) {
    return ids.map(id => `${stateName} == ${id}`).join(" or ");
}

function renderOriginalGroupedDispatcher(source, stateWhile, stateName, graphRoots, blocks, complete) {
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
        lines.push(`${bodyIndent}${keyword} ${renderStateMembership(stateName, ids)} then -- ${label}`);

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
        lines.push(`${groupIndent}-- invalid/unreachable VM state`);
        lines.push(`${groupIndent}${stateName} = nil`);
    } else {
        lines.push(`${groupIndent}-- unresolved state, keep original dispatcher behavior`);
        lines.push(renderStatements(source, stateWhile.body || [], groupIndent));
    }
    lines.push(`${bodyIndent}end`);
    lines.push(`${indent}end`);
    return lines.join("\n");
}

function buildNormalizedLayout(graphRoots, blocks) {
    const stateMap = new Map();
    const groups = [];
    const ownerByState = new Map();
    let nextId = 1;
    let overlap = false;

    graphRoots.forEach((root, rootIndex) => {
        const items = [];
        for (const oldId of root.graph.order) {
            if (!blocks.has(oldId)) continue;
            if (ownerByState.has(oldId) && ownerByState.get(oldId) !== rootIndex) {
                overlap = true;
                continue;
            }
            if (stateMap.has(oldId)) continue;
            ownerByState.set(oldId, rootIndex);
            const newId = nextId++;
            stateMap.set(oldId, newId);
            items.push({ oldId, newId, block: blocks.get(oldId) });
        }
        if (!items.length) return;
        groups.push({
            root,
            items,
            min: items[0].newId,
            max: items[items.length - 1].newId,
            entryOldId: root.entryId,
            entryNewId: stateMap.get(root.entryId) ?? null,
        });
    });

    return { stateMap, groups, overlap, count: nextId - 1 };
}

function collectClosureEntryEdits(node, stateMap, out = []) {
    if (!isNode(node)) return out;
    if (node.type === "CallExpression" && isIdentifier(node.base) && isClosureFactoryName(node.base.name)) {
        const entryNode = (node.arguments || [])[0];
        const oldId = numericValue(entryNode);
        const newId = oldId === null ? null : stateMap.get(oldId);
        if (newId !== undefined && newId !== null && Array.isArray(entryNode?.range)) {
            out.push({ start: entryNode.range[0], end: entryNode.range[1], text: String(newId) });
        }
    }
    for (const key of Object.keys(node)) {
        const value = node[key];
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectClosureEntryEdits(child, stateMap, out);
        } else if (isNode(value)) {
            collectClosureEntryEdits(value, stateMap, out);
        }
    }
    return out;
}

function collectTerminatorEdits(block, stateName, stateMap) {
    const edits = [];
    const term = block?.terminator;
    if (!term || term.statementIndex < 0) return edits;
    const statement = block.body?.[term.statementIndex];
    const rhs = findStateAssignment(statement, stateName);
    if (!rhs) return edits;

    if (term.kind === "jump") {
        const newTarget = stateMap.get(term.target);
        if (newTarget !== undefined && Array.isArray(rhs.range)) {
            edits.push({ start: rhs.range[0], end: rhs.range[1], text: String(newTarget) });
        }
    } else if (term.kind === "branch") {
        const trueNode = term.trueTargetNode;
        const falseNode = term.falseTargetNode;
        const newTrue = stateMap.get(term.onTrue);
        const newFalse = stateMap.get(term.onFalse);
        if (newTrue !== undefined && Array.isArray(trueNode?.range)) {
            edits.push({ start: trueNode.range[0], end: trueNode.range[1], text: `(${newTrue})` });
        }
        if (newFalse !== undefined && Array.isArray(falseNode?.range)) {
            edits.push({ start: falseNode.range[0], end: falseNode.range[1], text: `(${newFalse})` });
        }
    }
    return edits;
}

function applyRangeEdits(text, baseOffset, edits) {
    return applyTextEdits(text, edits, baseOffset);
}

function isSingleCanonicalStopStatement(block, stateName) {
    const term = block?.terminator;
    if (term?.kind !== "stop" || term.statementIndex < 0) return false;
    const statement = block.body?.[term.statementIndex];
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    return variables.length === 1 && init.length === 1 &&
        isIdentifier(variables[0], stateName) && isCanonicalStopSentinel(init[0]);
}

function renderNormalizedBlock(source, block, stateName, stateMap, indent) {
    if (!block?.body?.length) return `${indent}${stateName} = nil`;
    const termEdits = collectTerminatorEdits(block, stateName, stateMap);
    const relocateStop = isSingleCanonicalStopStatement(block, stateName);
    const stopIndex = relocateStop ? block.terminator.statementIndex : -1;
    const lines = [];

    for (let i = 0; i < block.body.length; i++) {
        if (i === stopIndex) continue;
        const statement = block.body[i];
        const edits = collectClosureEntryEdits(statement, stateMap, []).concat(termEdits);
        const raw = sourceOf(source, statement);
        const patched = applyRangeEdits(raw, statement.range[0], edits);
        lines.push(indentText(patched, indent));
    }

    // A proven canonical stop is compiler control-flow scaffolding. Recover its
    // semantic value directly and place it at the actual end of the state body.
    if (relocateStop) lines.push(`${indent}${stateName} = nil`);
    return lines.join("\n");
}


function renderStateTree(lines, source, stateName, group, stateMap, start, end, indent) {
    if (start === end) {
        const item = group.items[start];
        const entryComment = item.oldId === group.entryOldId
            ? ` -- entry ${group.entryOldId} -> ${item.newId}`
            : "";
        lines.push(`${indent}if ${stateName} == ${item.newId} then${entryComment}`);
        lines.push(renderNormalizedBlock(source, item.block, stateName, stateMap, indent + "    "));
        lines.push(`${indent}end`);
        return;
    }

    const mid = Math.floor((start + end) / 2);
    const boundary = group.items[mid].newId;
    lines.push(`${indent}if ${stateName} <= ${boundary} then`);
    renderStateTree(lines, source, stateName, group, stateMap, start, mid, indent + "    ");
    lines.push(`${indent}else`);
    renderStateTree(lines, source, stateName, group, stateMap, mid + 1, end, indent + "    ");
    lines.push(`${indent}end`);
}

function renderGroupLeaf(lines, source, stateName, group, stateMap, indent) {
    const label = group.root.kind === "root"
        ? `root entry ${group.entryOldId} -> ${group.entryNewId}, states ${group.min}-${group.max}`
        : `${group.root.factory} entry ${group.entryOldId} -> ${group.entryNewId}, states ${group.min}-${group.max}`;
    lines.push(`${indent}-- ${label}`);
    renderStateTree(lines, source, stateName, group, stateMap, 0, group.items.length - 1, indent);
}

function renderGroupTree(lines, source, stateName, groups, stateMap, start, end, indent) {
    if (start === end) {
        renderGroupLeaf(lines, source, stateName, groups[start], stateMap, indent);
        return;
    }
    const mid = Math.floor((start + end) / 2);
    const boundary = groups[mid].max;
    lines.push(`${indent}if ${stateName} <= ${boundary} then`);
    renderGroupTree(lines, source, stateName, groups, stateMap, start, mid, indent + "    ");
    lines.push(`${indent}else`);
    renderGroupTree(lines, source, stateName, groups, stateMap, mid + 1, end, indent + "    ");
    lines.push(`${indent}end`);
}

function normalizationIsSafe(layout, blocks) {
    if (layout.overlap || layout.groups.length === 0 || layout.stateMap.size !== blocks.size) {
        return false;
    }
    for (const block of blocks.values()) {
        if (!block?.body || block.unresolved) return false;
        const term = block.terminator;
        if (!term || !["jump", "branch", "stop"].includes(term.kind)) return false;
        if (term?.kind === "jump" && !layout.stateMap.has(term.target)) return false;
        if (term?.kind === "branch" &&
            (!layout.stateMap.has(term.onTrue) || !layout.stateMap.has(term.onFalse))) return false;
    }
    return layout.groups.every(group => group.entryNewId !== null);
}

function renderNormalizedDispatcher(source, stateWhile, stateName, layout) {
    const indent = lineIndentAt(source, stateWhile.range[0]);
    const bodyIndent = indent + "    ";
    const lines = [`while ${stateName} do`];
    renderGroupTree(lines, source, stateName, layout.groups, layout.stateMap, 0, layout.groups.length - 1, bodyIndent);
    lines.push(`${indent}end`);
    return lines.join("\n");
}

function applyClosureEntryEditsOutsideDispatcher(source, ast, stateWhile, stateMap, replacement) {
    const edits = collectClosureEntryEdits(ast, stateMap, []);
    const prefix = applyRangeEdits(source.slice(0, stateWhile.range[0]), 0,
        edits.filter(edit => edit.end <= stateWhile.range[0]));
    const suffix = applyRangeEdits(source.slice(stateWhile.range[1]), stateWhile.range[1],
        edits.filter(edit => edit.start >= stateWhile.range[1]));
    return prefix + replacement + suffix;
}
function recoverVmStateGraph(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) return { source, found: false, reason: "No semantically named vm function was found" };

    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) return { source, found: false, reason: "VM state parameter is not an identifier" };
    const stateName = stateParam.name;

    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) return { source, found: false, reason: "No while <state> dispatcher was found" };

    const rootEntry = findRootEntry(ast);
    if (!rootEntry) return { source, found: false, reason: "No root entry was found" };
    const allBlocks = new Map();
    const graphRoots = [];
    const seenRoots = new Set();
    const reachableClosureEntries = [];
    const reachableUnsupportedClosureEntries = [];

    function addRoot(kind, factory, entryId) {
        if (seenRoots.has(entryId)) return null;
        seenRoots.add(entryId);
        const graph = walkStateGraph(stateWhile.body || [], stateName, entryId, source);
        const root = { kind, factory, entryId, graph };
        graphRoots.push(root);
        for (const id of graph.order) if (!allBlocks.has(id)) allBlocks.set(id, graph.blocks.get(id));
        return root;
    }

    const rootRoot = addRoot("root", "createClosure", rootEntry.entryId);
    const pendingRoots = rootRoot ? [rootRoot] : [];

    // Discover nested closure roots only from states that are themselves
    // reachable from an already-proven root. A createClosure call living in a
    // dead dispatcher leaf must not keep that dead closure graph alive.
    for (let pendingCursor = 0; pendingCursor < pendingRoots.length; pendingCursor++) {
        const currentRoot = pendingRoots[pendingCursor];
        const bodies = [];
        for (const id of currentRoot.graph.order) {
            const block = currentRoot.graph.blocks.get(id);
            if (block?.body) bodies.push(block.body);
        }
        const info = collectClosureEntryInfo(bodies);
        reachableUnsupportedClosureEntries.push(...info.unsupported);
        for (const entry of info.entries) {
            reachableClosureEntries.push(entry);
            const child = addRoot("closure", entry.factory, entry.entryId);
            if (child) pendingRoots.push(child);
        }
    }

    const rootGraph = rootRoot?.graph || walkStateGraph(stateWhile.body || [], stateName, rootEntry.entryId, source);

    const leaves = collectDispatcherLeaves(stateWhile.body || [], source);
    const leafKeys = new Set();
    for (const leaf of leaves) leafKeys.add(leaf.key);

    const resolvedKeys = new Set();
    for (const block of allBlocks.values()) {
        if (block?.key) resolvedKeys.add(block.key);
    }

    // Count ignored closure entries only inside dispatcher leaves that are
    // already proven unreachable. Avoid a second full-AST closure scan just
    // for diagnostics.
    let ignoredUnreachableClosureEntryCount = 0;
    for (const leaf of leaves) {
        if (resolvedKeys.has(leaf.key)) continue;
        ignoredUnreachableClosureEntryCount += collectClosureEntryInfo(leaf.body).entries.length;
    }

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
    const orderedIdSet = new Set();
    for (const root of graphRoots) {
        for (const id of root.graph.order) {
            if (orderedIdSet.has(id)) continue;
            orderedIdSet.add(id);
            orderedIds.push(id);
        }
    }

    const normalization = buildNormalizedLayout(graphRoots, allBlocks);
    const reachableClosed = reachableUnsupportedClosureEntries.length === 0 &&
        normalizationIsSafe(normalization, allBlocks);
    const normalized = reachableClosed;
    const prunedDispatcherLeafCount = normalized
        ? Math.max(0, leafKeys.size - resolvedKeys.size)
        : 0;
    const replacement = normalized
        ? renderNormalizedDispatcher(source, stateWhile, stateName, normalization)
        : renderOriginalGroupedDispatcher(source, stateWhile, stateName, graphRoots, allBlocks, complete);
    const output = normalized
        ? applyClosureEntryEditsOutsideDispatcher(source, ast, stateWhile, normalization.stateMap, replacement)
        : source.slice(0, stateWhile.range[0]) + replacement + source.slice(stateWhile.range[1]);

    return {
        source: output,
        found: true,
        rootEntryId: rootEntry.entryId,
        normalizedRootEntryId: normalized ? normalization.stateMap.get(rootEntry.entryId) : null,
        rootGraph,
        graphRoots,
        blocks: allBlocks,
        orderedIds,
        dispatcherLeafCount: leafKeys.size,
        resolvedLeafCount: resolvedKeys.size,
        complete,
        collision,
        reachableClosed,
        reachableClosureEntryCount: reachableClosureEntries.length,
        ignoredUnreachableClosureEntryCount,
        unsupportedClosureEntryCount: reachableUnsupportedClosureEntries.length,
        prunedDispatcherLeafCount,
        normalized,
        normalization,
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
    recoverVmStateGraph,
};
