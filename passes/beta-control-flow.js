const luaparse = require("../parser/luaparse");

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

function walk(node, visit) {
    if (!isNode(node)) return;
    visit(node);
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) walk(child, visit);
        } else if (isNode(value)) {
            walk(value, visit);
        }
    }
}

function findEnvironmentArgument(ast, environmentName = "_env") {
    let found = null;
    walk(ast, node => {
        if (found || node.type !== "CallExpression") return;
        const fn = node.base;
        if (fn?.type !== "FunctionDeclaration") return;
        const parameters = fn.parameters || [];
        const index = parameters.findIndex(parameter => isIdentifier(parameter, environmentName));
        if (index < 0) return;
        const argument = (node.arguments || [])[index];
        if (argument) found = argument;
    });
    return found;
}

function expressionContainsCall(node, name) {
    let found = false;
    walk(node, current => {
        if (found || current.type !== "CallExpression") return;
        if (isIdentifier(current.base, name)) found = true;
    });
    return found;
}

function expressionContainsIdentifier(node, name) {
    let found = false;
    walk(node, current => {
        if (found) return;
        if (isIdentifier(current, name)) found = true;
    });
    return found;
}

function displayEnvironmentProvider(ast, environmentName = "_env") {
    const argument = findEnvironmentArgument(ast, environmentName);
    if (!argument) return null;
    if (expressionContainsCall(argument, "getgenv")) return "getgenv()";
    if (expressionContainsCall(argument, "getfenv")) return "getfenv()";
    if (expressionContainsIdentifier(argument, "_ENV")) return "_ENV";
    return null;
}

function operationText(operation) {
    return operation?.emittedText || operation?.originalText || null;
}

function canSinkTerminalReturnAcross(payload, operation) {
    const expressions = payload?.returnExpressions;
    if (!Array.isArray(expressions)) return false;

    // Empty compiler returns carry no value dependency. In beta CF they represent the
    // function's terminal no-value return, so the marker can be placed at the proven stop.
    if (expressions.length === 0) return true;

    // Non-empty returns may only cross compiler bookkeeping that is structurally pure.
    // Never cross a write to a version consumed by the return payload.
    if (operation?.returnSinkSafe !== true) return false;
    const returnedReads = new Set(payload.reads || []);
    return !returnedReads.has(operation.emittedTarget);
}

function sinkTerminalReturnPayload(operations) {
    const result = [...operations];
    const finalTransitionIndex = result.findLastIndex(operation => operation.kind === "state-transition");
    if (finalTransitionIndex < 0) return { operations: result, moved: false };
    const finalTransition = result[finalTransitionIndex];
    if (String(finalTransition.rhs || "").trim() !== "nil") return { operations: result, moved: false };

    const payloadIndexes = [];
    for (let index = 0; index < finalTransitionIndex; index++) {
        if (result[index].kind === "return-payload" && result[index].terminalCompilerReturnPayload === true) payloadIndexes.push(index);
    }
    if (payloadIndexes.length !== 1) return { operations: result, moved: false };

    const payloadIndex = payloadIndexes[0];
    if (payloadIndex === finalTransitionIndex - 1) return { operations: result, moved: false };
    const payload = result[payloadIndex];
    const crossed = result.slice(payloadIndex + 1, finalTransitionIndex);
    if (!crossed.every(operation => canSinkTerminalReturnAcross(payload, operation))) {
        return { operations: result, moved: false };
    }

    result.splice(payloadIndex, 1);
    const newTransitionIndex = result.findLastIndex(operation => operation.kind === "state-transition");
    result.splice(newTransitionIndex, 0, payload);
    return { operations: result, moved: true };
}

function lowerTerminalReturn(operations) {
    const result = [...operations];
    const finalTransitionIndex = result.findLastIndex(operation => operation.kind === "state-transition");
    if (finalTransitionIndex < 1) return { operations: result, lowered: false, returnText: null };
    const transition = result[finalTransitionIndex];
    if (String(transition.rhs || "").trim() !== "nil") {
        return { operations: result, lowered: false, returnText: null };
    }

    const payloadIndex = finalTransitionIndex - 1;
    const payload = result[payloadIndex];
    if (payload?.kind !== "return-payload" || payload.terminalCompilerReturnPayload !== true || !Array.isArray(payload.returnExpressions)) {
        return { operations: result, lowered: false, returnText: null };
    }

    const returnText = payload.returnExpressions.length
        ? `return ${payload.returnExpressions.join(", ")}`
        : "return";
    result.splice(payloadIndex, 2, {
        kind: "return",
        emittedText: returnText,
        returnExpressions: [...payload.returnExpressions],
        reads: [...(payload.reads || [])],
    });
    return { operations: result, lowered: true, returnText };
}

function buildPresentedSource(originalAst, bodyText) {
    const headerLines = [];
    let environmentHeader = null;
    if (/\b_env\b/.test(bodyText)) {
        const provider = displayEnvironmentProvider(originalAst, "_env");
        if (!provider) {
            return { applied: false, reason: "The structured body uses _env but its provider is not structurally known" };
        }
        environmentHeader = `local _env = ${provider}`;
        headerLines.push(environmentHeader);
    }
    headerLines.push("local args = { ... }");

    const sections = ["--headers"];
    if (headerLines.length) sections.push(headerLines.join("\n"));
    sections.push("--body");
    sections.push(bodyText);
    return {
        applied: true,
        source: sections.join("\n\n") + "\n",
        environmentHeader,
    };
}

function solveSingleState(originalAst, graph) {
    const state = graph.states[0];
    if (state.id !== graph.entries[0]) {
        return { applied: false, reason: "The only state is not the CFG entry" };
    }
    if (!Array.isArray(state.successors) || state.successors.length !== 0) {
        return { applied: false, reason: "Beta CF single-state mode requires the entry state to terminate" };
    }
    if (state.operations.some(operation => operation.kind === "unsupported")) {
        return { applied: false, reason: "The single state contains unsupported beta operations" };
    }

    const operationTexts = state.operations.map(operationText);
    if (operationTexts.some(text => !text)) {
        return { applied: false, reason: "A state operation has no printable beta text" };
    }

    const sunk = sinkTerminalReturnPayload(state.operations);
    const lowered = lowerTerminalReturn(sunk.operations);
    const bodyLines = lowered.operations.map(operationText);
    const bodyText = bodyLines.join("\n\n");
    const presented = buildPresentedSource(originalAst, bodyText);
    if (!presented.applied) return presented;

    return {
        source: presented.source,
        applied: true,
        mode: "single-state",
        entryState: state.id,
        stateCount: graph.states.length,
        statementCount: lowered.operations.length,
        branchCount: 0,
        terminalReturnCount: lowered.lowered ? 1 : 0,
        terminalReturnPayloadSunk: sunk.moved,
        terminalReturnPayloadSunkCount: sunk.moved ? 1 : 0,
        terminalReturnLowered: lowered.lowered,
        terminalReturnText: lowered.returnText,
        environmentHeader: presented.environmentHeader,
    };
}

function parseTransitionExpression(rhs) {
    const prefix = "local __beta_cf_transition = ";
    const source = prefix + rhs;
    let ast;
    try {
        ast = luaparse.parse(source, {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
    } catch {
        return null;
    }
    const statement = ast.body?.[0];
    const expression = statement?.type === "LocalStatement" ? statement.init?.[0] : null;
    return expression ? { source, expression } : null;
}

function transitionInfo(state) {
    if (!Array.isArray(state.successors)) return { error: `State ${state.id} has unknown successors` };
    const transitions = state.operations.filter(operation => operation.kind === "state-transition");
    if (transitions.length !== 1) {
        return { error: `State ${state.id} must have exactly one preserved state transition` };
    }
    const operation = transitions[0];
    const rhs = String(operation.rhs || "").trim();

    if (state.successors.length === 0) {
        if (rhs !== "nil") return { error: `Terminal state ${state.id} does not end in state = nil` };
        return { kind: "stop", operation };
    }

    if (state.successors.length === 1) {
        const parsed = parseTransitionExpression(rhs);
        const target = parsed ? numericValue(parsed.expression) : null;
        if (target !== state.successors[0]) {
            return { error: `State ${state.id} jump target does not match its proven CFG successor` };
        }
        return { kind: "jump", target, operation };
    }

    if (state.successors.length !== 2) {
        return { error: `State ${state.id} has ${state.successors.length} successors; acyclic beta CF supports at most two` };
    }

    if (state.successors[0] === state.successors[1]) {
        return { kind: "jump", target: state.successors[0], operation };
    }

    const parsed = parseTransitionExpression(rhs);
    const expression = parsed?.expression;
    if (expression?.type !== "LogicalExpression" || expression.operator !== "or") {
        return { error: `State ${state.id} branch transition is not the proven condition-and-true-or-false shape` };
    }
    const left = expression.left;
    if (left?.type !== "LogicalExpression" || left.operator !== "and") {
        return { error: `State ${state.id} branch transition is missing its condition-and-true arm` };
    }
    const onTrue = numericValue(left.right);
    const onFalse = numericValue(expression.right);
    if (onTrue !== state.successors[0] || onFalse !== state.successors[1]) {
        return { error: `State ${state.id} branch targets do not match its proven CFG successors` };
    }

    // Prometheus compiles the branch condition into a register before the POS/state write.
    // Requiring a plain identifier keeps moving the final decision past any harmless tail
    // bookkeeping side-effect-free and prevents us from re-evaluating a call/index expression.
    if (!isIdentifier(left.left) || !Array.isArray(left.left.range)) {
        return { error: `State ${state.id} branch condition is not a precomputed beta register` };
    }
    const condition = parsed.source.slice(left.left.range[0], left.left.range[1]);
    return {
        kind: "branch",
        condition,
        conditionReads: [...(operation.reads || [])],
        onTrue,
        onFalse,
        operation,
    };
}

function setEquals(left, right) {
    if (left.size !== right.size) return false;
    for (const value of left) if (!right.has(value)) return false;
    return true;
}

function intersectSets(sets) {
    if (!sets.length) return new Set();
    const result = new Set(sets[0]);
    for (let index = 1; index < sets.length; index++) {
        for (const value of [...result]) {
            if (!sets[index].has(value)) result.delete(value);
        }
    }
    return result;
}

function computePostdominators(states, stateById, exitNode) {
    const allNodes = new Set(states.map(state => state.id));
    allNodes.add(exitNode);
    const postdominators = new Map();
    postdominators.set(exitNode, new Set([exitNode]));
    for (const state of states) postdominators.set(state.id, new Set(allNodes));

    let changed = true;
    let iterations = 0;
    const maxIterations = Math.max(8, states.length * states.length + 8);
    while (changed) {
        if (++iterations > maxIterations) return null;
        changed = false;
        for (const state of states) {
            const successors = state.successors.length ? state.successors : [exitNode];
            const successorSets = successors.map(successor => postdominators.get(successor));
            if (successorSets.some(value => !value)) return null;
            const next = intersectSets(successorSets);
            next.add(state.id);
            if (!setEquals(next, postdominators.get(state.id))) {
                postdominators.set(state.id, next);
                changed = true;
            }
        }
    }
    return postdominators;
}

function immediatePostdominator(stateId, postdominators) {
    const strict = [...(postdominators.get(stateId) || [])].filter(value => value !== stateId);
    const candidates = strict.filter(candidate => {
        const candidateSet = postdominators.get(candidate);
        return candidateSet && strict.every(other => other === candidate || candidateSet.has(other));
    });
    return candidates.length === 1 ? candidates[0] : null;
}

function validateReachableAcyclic(entry, stateById) {
    const visited = new Set();
    const visiting = new Set();
    let cycle = false;
    let badTarget = null;

    function dfs(stateId) {
        if (cycle || badTarget !== null) return;
        if (visiting.has(stateId)) {
            cycle = true;
            return;
        }
        if (visited.has(stateId)) return;
        const state = stateById.get(stateId);
        if (!state) {
            badTarget = stateId;
            return;
        }
        visiting.add(stateId);
        for (const successor of state.successors || []) dfs(successor);
        visiting.delete(stateId);
        visited.add(stateId);
    }

    dfs(entry);
    return { visited, cycle, badTarget };
}

function rawNode(operation, stateId) {
    return {
        type: "raw",
        stateId,
        operation,
        text: operationText(operation),
        reads: [...(operation.reads || [])],
    };
}

function ifNode(condition, conditionReads, thenBody, elseBody = null) {
    return {
        type: "if",
        condition,
        reads: [...(conditionReads || [])],
        thenBody,
        elseBody,
    };
}

function indentText(text, depth) {
    const prefix = "    ".repeat(depth);
    return String(text).split("\n").map(line => prefix + line).join("\n");
}

function formatStructuredNodes(nodes, depth = 0) {
    const parts = [];
    for (const node of nodes) {
        if (node.type === "raw") {
            parts.push(indentText(node.text, depth));
            continue;
        }
        if (node.type !== "if") continue;
        const lines = [`${"    ".repeat(depth)}if ${node.condition} then`];
        if (node.thenBody.length) lines.push("", formatStructuredNodes(node.thenBody, depth + 1));
        if (node.elseBody) {
            lines.push("", `${"    ".repeat(depth)}else`);
            if (node.elseBody.length) lines.push("", formatStructuredNodes(node.elseBody, depth + 1));
        }
        lines.push("", `${"    ".repeat(depth)}end`);
        parts.push(lines.join("\n"));
    }
    return parts.join("\n\n");
}

function countStructuredStatements(nodes) {
    let count = 0;
    for (const node of nodes) {
        count++;
        if (node.type === "if") {
            count += countStructuredStatements(node.thenBody);
            if (node.elseBody) count += countStructuredStatements(node.elseBody);
        }
    }
    return count;
}

function validateStructuredLocalScopes(nodes) {
    let nextScopeId = 1;
    let sequence = 0;
    const parentScope = new Map([[0, null]]);
    const declarations = new Map();
    const reads = [];

    function visit(body, scopeId) {
        for (const node of body) {
            if (node.type === "raw") {
                sequence++;
                const operation = node.operation || {};
                const text = String(node.text || "").trimStart();
                if (operation.emittedTarget && text.startsWith("local ")) {
                    if (declarations.has(operation.emittedTarget)) {
                        return `Beta name ${operation.emittedTarget} has multiple local declarations after structuring`;
                    }
                    declarations.set(operation.emittedTarget, { scopeId, sequence });
                }
                for (const name of node.reads || []) reads.push({ name, scopeId, sequence });
                continue;
            }

            sequence++;
            for (const name of node.reads || []) reads.push({ name, scopeId, sequence });
            const thenScope = nextScopeId++;
            parentScope.set(thenScope, scopeId);
            const thenError = visit(node.thenBody, thenScope);
            if (thenError) return thenError;
            if (node.elseBody) {
                const elseScope = nextScopeId++;
                parentScope.set(elseScope, scopeId);
                const elseError = visit(node.elseBody, elseScope);
                if (elseError) return elseError;
            }
        }
        return null;
    }

    const traversalError = visit(nodes, 0);
    if (traversalError) return traversalError;

    function isAncestor(ancestor, scopeId) {
        let current = scopeId;
        while (current !== null && current !== undefined) {
            if (current === ancestor) return true;
            current = parentScope.get(current);
        }
        return false;
    }

    for (const read of reads) {
        const declaration = declarations.get(read.name);
        if (!declaration) continue;
        if (!isAncestor(declaration.scopeId, read.scopeId)) {
            return `Structuring would move ${read.name} outside the Lua scope of its beta declaration`;
        }
        if (declaration.sequence > read.sequence) {
            return `Structuring would read ${read.name} before its beta declaration`;
        }
    }
    return null;
}

function solveAcyclicStructured(originalAst, graph) {
    const entry = graph.entries[0];
    const states = graph.states;
    const stateById = new Map(states.map(state => [state.id, state]));
    const reachability = validateReachableAcyclic(entry, stateById);
    if (reachability.badTarget !== null) {
        return { applied: false, reason: `Beta CFG references missing state ${reachability.badTarget}` };
    }
    if (reachability.cycle) {
        return { applied: false, reason: "Beta CF acyclic stage detected a loop/backedge; loop structuring is not implemented yet" };
    }
    if (reachability.visited.size !== states.length) {
        return { applied: false, reason: "Beta CF acyclic stage requires every state to be reachable from the single entry" };
    }

    const prepared = new Map();
    let terminalReturnPayloadSunkCount = 0;
    let terminalReturnCount = 0;
    for (const state of states) {
        if (state.operations.some(operation => operation.kind === "unsupported")) {
            return { applied: false, reason: `State ${state.id} contains unsupported beta operations` };
        }
        const info = transitionInfo(state);
        if (info.error) return { applied: false, reason: info.error };

        if (info.kind === "stop") {
            const transitionIndex = state.operations.indexOf(info.operation);
            if (transitionIndex !== state.operations.length - 1) {
                return { applied: false, reason: `Terminal state ${state.id} has operations after state = nil` };
            }
            const sunk = sinkTerminalReturnPayload(state.operations);
            const lowered = lowerTerminalReturn(sunk.operations);
            if (!lowered.lowered) {
                return { applied: false, reason: `Terminal state ${state.id} cannot be proven as a compiler return` };
            }
            if (lowered.operations.some(operation => !operationText(operation))) {
                return { applied: false, reason: `Terminal state ${state.id} has an unprintable beta operation` };
            }
            terminalReturnPayloadSunkCount += sunk.moved ? 1 : 0;
            terminalReturnCount++;
            prepared.set(state.id, { state, info: { kind: "return" }, bodyOperations: lowered.operations });
            continue;
        }

        const transitionIndex = state.operations.indexOf(info.operation);
        const tailOperations = state.operations.slice(transitionIndex + 1);
        if (info.kind === "branch" && tailOperations.length) {
            const conditionReads = new Set(info.conditionReads || []);
            if (tailOperations.some(operation => conditionReads.has(operation.emittedTarget))) {
                return { applied: false, reason: `State ${state.id} writes its branch condition after the state transition` };
            }
        }
        const bodyOperations = state.operations.filter(operation => operation !== info.operation);
        if (bodyOperations.some(operation => !operationText(operation))) {
            return { applied: false, reason: `State ${state.id} has an unprintable beta operation` };
        }
        prepared.set(state.id, { state, info, bodyOperations });
    }

    const exitNode = Symbol("beta-cf-exit");
    const postdominators = computePostdominators(states, stateById, exitNode);
    if (!postdominators) {
        return { applied: false, reason: "Beta CF post-dominator analysis did not converge" };
    }

    const emittedStates = new Set();
    let branchCount = 0;
    let joinCount = 0;
    let guardBranchCount = 0;

    function emitSequence(startState, stopState) {
        const nodes = [];
        let current = startState;

        while (current !== stopState && current !== exitNode) {
            if (emittedStates.has(current)) {
                throw new Error(`State ${current} would be emitted more than once; CFG is not structurally reducible by the acyclic stage`);
            }
            const item = prepared.get(current);
            if (!item) throw new Error(`Missing prepared state ${current}`);
            emittedStates.add(current);
            for (const operation of item.bodyOperations) nodes.push(rawNode(operation, current));

            const info = item.info;
            if (info.kind === "return") return { nodes, terminates: true };
            if (info.kind === "jump") {
                current = info.target;
                continue;
            }
            if (info.kind !== "branch") throw new Error(`Unsupported prepared terminator in state ${current}`);

            branchCount++;
            if (info.onTrue === info.onFalse) {
                current = info.onTrue;
                continue;
            }

            const join = immediatePostdominator(current, postdominators);
            if (join === null) throw new Error(`State ${current} has no unique immediate post-dominator`);

            if (join !== exitNode) {
                joinCount++;
                const trueResult = info.onTrue === join
                    ? { nodes: [], terminates: false }
                    : emitSequence(info.onTrue, join);
                const falseResult = info.onFalse === join
                    ? { nodes: [], terminates: false }
                    : emitSequence(info.onFalse, join);
                if (trueResult.terminates || falseResult.terminates) {
                    throw new Error(`State ${current} has a real join but one branch terminates before reaching it`);
                }

                if (trueResult.nodes.length && falseResult.nodes.length) {
                    nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes, falseResult.nodes));
                } else if (trueResult.nodes.length) {
                    nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes));
                } else if (falseResult.nodes.length) {
                    nodes.push(ifNode(`not (${info.condition})`, info.conditionReads, falseResult.nodes));
                }
                current = join;
                continue;
            }

            const trueResult = emitSequence(info.onTrue, exitNode);
            const falseResult = emitSequence(info.onFalse, exitNode);
            if (!trueResult.terminates || !falseResult.terminates) {
                throw new Error(`State ${current} branches to function exit but an arm does not terminate`);
            }

            // Prefer a guard-return shape when both branches end the function. This keeps
            // the non-taken arm as natural fallthrough, matching source-level early return.
            nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes));
            nodes.push(...falseResult.nodes);
            guardBranchCount++;
            return { nodes, terminates: true };
        }

        return { nodes, terminates: false };
    }

    let structured;
    try {
        structured = emitSequence(entry, exitNode);
    } catch (error) {
        return { applied: false, reason: error.message };
    }
    if (!structured.terminates) {
        return { applied: false, reason: "The acyclic entry region does not terminate at function exit" };
    }
    if (emittedStates.size !== states.length) {
        return { applied: false, reason: `Acyclic structuring emitted ${emittedStates.size}/${states.length} reachable states` };
    }

    const scopeError = validateStructuredLocalScopes(structured.nodes);
    if (scopeError) return { applied: false, reason: scopeError };

    const bodyText = formatStructuredNodes(structured.nodes);
    const presented = buildPresentedSource(originalAst, bodyText);
    if (!presented.applied) return presented;

    return {
        source: presented.source,
        applied: true,
        mode: "acyclic-structured",
        entryState: entry,
        stateCount: states.length,
        statementCount: countStructuredStatements(structured.nodes),
        branchCount,
        joinCount,
        guardBranchCount,
        terminalReturnCount,
        terminalReturnPayloadSunk: terminalReturnPayloadSunkCount > 0,
        terminalReturnPayloadSunkCount,
        terminalReturnLowered: terminalReturnCount > 0,
        terminalReturnText: null,
        environmentHeader: presented.environmentHeader,
    };
}

function solveBetaControlFlow(originalAst, betaResult) {
    if (!betaResult?.graph || !betaResult.applied) {
        return { applied: false, reason: "Beta register analysis is unavailable" };
    }
    const graph = betaResult.graph;
    if (!graph.cfgComplete) {
        return { applied: false, reason: "Beta CFG is incomplete" };
    }
    if (graph.entries.length !== 1) {
        return { applied: false, reason: "Beta CF currently requires exactly one CFG entry" };
    }
    if (graph.states.length === 1) return solveSingleState(originalAst, graph);
    return solveAcyclicStructured(originalAst, graph);
}

module.exports = {
    displayEnvironmentProvider,
    sinkTerminalReturnPayload,
    lowerTerminalReturn,
    solveBetaControlFlow,
};
