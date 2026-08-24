const luaparse = require("../parser/luaparse");
const { recoverBetaUpvalues } = require("./beta-upvalues");

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

function hasUnsafeUnsupportedOperation(operations) {
    return operations.some(operation => operation?.kind === "unsupported");
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
    if (hasUnsafeUnsupportedOperation(state.operations)) {
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

const TRANSITION_PARSE_CACHE_LIMIT = 4096;
const transitionParseCache = new Map();

function parseTransitionExpression(rhs) {
    const key = String(rhs || "");
    if (transitionParseCache.has(key)) return transitionParseCache.get(key);
    const prefix = "local __beta_cf_transition = ";
    const source = prefix + key;
    let result = null;
    try {
        const ast = luaparse.parse(source, {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
        const statement = ast.body?.[0];
        const expression = statement?.type === "LocalStatement" ? statement.init?.[0] : null;
        if (expression) result = { source, expression };
    } catch {}
    if (transitionParseCache.size >= TRANSITION_PARSE_CACHE_LIMIT) transitionParseCache.clear();
    transitionParseCache.set(key, result);
    return result;
}

function transitionInfo(state, options = {}) {
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
    const conditionReads = [...(operation.reads || [])];
    const conditionProven = conditionReads.includes(left.left.name);
    if (!conditionProven && options.allowUnprovenCondition !== true) {
        return { error: `State ${state.id} branch condition ${left.left.name} has no proven beta read provenance` };
    }
    return {
        kind: "branch",
        condition,
        conditionName: left.left.name,
        conditionProven,
        conditionReads,
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

function computeReachableStateSets(states, stateById) {
    const memo = new Map();
    const visiting = new Set();

    function visit(stateId) {
        if (memo.has(stateId)) return memo.get(stateId);
        if (visiting.has(stateId)) return null;
        const state = stateById.get(stateId);
        if (!state) return null;
        visiting.add(stateId);
        const reachable = new Set([stateId]);
        for (const successor of state.successors || []) {
            const successorReachable = visit(successor);
            if (!successorReachable) return null;
            for (const candidate of successorReachable) reachable.add(candidate);
        }
        visiting.delete(stateId);
        memo.set(stateId, reachable);
        return reachable;
    }

    for (const state of states) {
        if (!visit(state.id)) return null;
    }
    return memo;
}

function reachesState(startState, targetState, reachableSets) {
    return startState === targetState || reachableSets.get(startState)?.has(targetState) === true;
}

function earliestCommonReachableJoin(onTrue, onFalse, stopState, exitNode, reachableSets) {
    const trueReachable = reachableSets.get(onTrue);
    const falseReachable = reachableSets.get(onFalse);
    if (!trueReachable || !falseReachable) return { join: null, ambiguous: true };

    const common = [...trueReachable].filter(candidate => falseReachable.has(candidate));
    const inRegion = common.filter(candidate =>
        stopState === exitNode ||
        candidate === stopState ||
        reachesState(candidate, stopState, reachableSets)
    );

    const earliest = inRegion.filter(candidate =>
        !inRegion.some(other =>
            other !== candidate &&
            reachesState(other, candidate, reachableSets)
        )
    );

    if (earliest.length > 1) return { join: null, ambiguous: true };
    if (earliest.length === 1) return { join: earliest[0], ambiguous: false };

    if (stopState !== exitNode) {
        const trueReachesStop = reachesState(onTrue, stopState, reachableSets);
        const falseReachesStop = reachesState(onFalse, stopState, reachableSets);
        if (trueReachesStop || falseReachesStop) {
            return { join: stopState, ambiguous: false };
        }
    }

    return { join: null, ambiguous: false };
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

function numericForNode(variable, initial, limit, step, body, reads = []) {
    return {
        type: "numeric-for",
        variable,
        initial,
        limit,
        step,
        body,
        reads: [...reads],
    };
}

function genericForNode(variables, expressions, body, reads = []) {
    return {
        type: "generic-for",
        variables: [...variables],
        expressions: [...expressions],
        body,
        reads: [...reads],
    };
}

function whileGuardNode(condition, conditionReads, conditionBody, body) {
    return {
        type: "while-guard",
        condition,
        reads: [...(conditionReads || [])],
        conditionBody,
        body,
    };
}

function repeatUntilNode(condition, conditionReads, body, conditionBody) {
    return {
        type: "repeat-until",
        condition,
        reads: [...(conditionReads || [])],
        body,
        conditionBody,
    };
}

function operationNode(operation, stateId) {
    if ((operation?.kind === "structured-numeric-for" || operation?.kind === "structured-generic-for" || operation?.kind === "structured-while" || operation?.kind === "structured-repeat") && operation.structuredNode) {
        return operation.structuredNode;
    }
    return rawNode(operation, stateId);
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
        if (node.type === "numeric-for") {
            const header = `${"    ".repeat(depth)}for ${node.variable} = ${node.initial}, ${node.limit}, ${node.step} do`;
            const lines = [header];
            if (node.body.length) lines.push("", formatStructuredNodes(node.body, depth + 1));
            lines.push("", `${"    ".repeat(depth)}end`);
            parts.push(lines.join("\n"));
            continue;
        }
        if (node.type === "generic-for") {
            const header = `${"    ".repeat(depth)}for ${node.variables.join(", ")} in ${node.expressions.join(", ")} do`;
            const lines = [header];
            if (node.body.length) lines.push("", formatStructuredNodes(node.body, depth + 1));
            lines.push("", `${"    ".repeat(depth)}end`);
            parts.push(lines.join("\n"));
            continue;
        }
        if (node.type === "while-guard") {
            const indent = "    ".repeat(depth);
            const lines = [`${indent}while true do`];
            if (node.conditionBody.length) lines.push("", formatStructuredNodes(node.conditionBody, depth + 1));
            lines.push("", `${indent}    if not (${node.condition}) then`, `${indent}        break`, `${indent}    end`);
            if (node.body.length) lines.push("", formatStructuredNodes(node.body, depth + 1));
            lines.push("", `${indent}end`);
            parts.push(lines.join("\n"));
            continue;
        }
        if (node.type === "repeat-until") {
            const indent = "    ".repeat(depth);
            const lines = [`${indent}repeat`];
            if (node.body.length) lines.push("", formatStructuredNodes(node.body, depth + 1));
            if (node.conditionBody.length) lines.push("", formatStructuredNodes(node.conditionBody, depth + 1));
            lines.push("", `${indent}until ${node.condition}`);
            parts.push(lines.join("\n"));
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
        } else if (node.type === "numeric-for" || node.type === "generic-for") {
            count += countStructuredStatements(node.body);
        } else if (node.type === "while-guard") {
            count += countStructuredStatements(node.conditionBody);
            count += countStructuredStatements(node.body);
        } else if (node.type === "repeat-until") {
            count += countStructuredStatements(node.body);
            count += countStructuredStatements(node.conditionBody);
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

    function isAncestor(ancestor, scopeId) {
        let current = scopeId;
        while (current !== null && current !== undefined) {
            if (current === ancestor) return true;
            current = parentScope.get(current);
        }
        return false;
    }

    function declarationList(name) {
        if (!declarations.has(name)) declarations.set(name, []);
        return declarations.get(name);
    }

    function addRawDeclaration(name, scopeId, declarationSequence) {
        const list = declarationList(name);
        if (list.length) return "Beta name " + name + " has multiple local declarations after structuring";
        list.push({ scopeId, sequence: declarationSequence, kind: "raw" });
        return null;
    }

    function addNumericForDeclaration(name, scopeId, parentScopeId, declarationSequence) {
        const list = declarationList(name);
        if (list.some(declaration => declaration.scopeId === scopeId)) {
            return "Beta name " + name + " has multiple local declarations in one structured scope";
        }
        if (list.length) {
            // Lua evaluates numeric-for bounds in the parent scope, then declares
            // the loop variable in the loop-body scope. `local x = 1; for x = x, ...`
            // is valid when beta coalesces the start scratch and loop variable.
            if (list.some(declaration => !isAncestor(declaration.scopeId, parentScopeId))) {
                return "Beta name " + name + " has unrelated local declarations after structuring";
            }
        }
        list.push({ scopeId, sequence: declarationSequence, kind: "numeric-for" });
        return null;
    }

    function visit(body, scopeId) {
        for (const node of body) {
            if (node.type === "raw") {
                sequence++;
                const operation = node.operation || {};
                const text = String(node.text || "").trimStart();
                if (operation.emittedTarget && text.startsWith("local ")) {
                    const declarationError = addRawDeclaration(operation.emittedTarget, scopeId, sequence);
                    if (declarationError) return declarationError;
                }
                for (const name of node.reads || []) reads.push({ name, scopeId, sequence });
                continue;
            }

            sequence++;
            if (node.type === "while-guard") {
                const bodyScope = nextScopeId++;
                parentScope.set(bodyScope, scopeId);
                const conditionError = visit(node.conditionBody, bodyScope);
                if (conditionError) return conditionError;
                sequence++;
                for (const name of node.reads || []) reads.push({ name, scopeId: bodyScope, sequence });
                const bodyError = visit(node.body, bodyScope);
                if (bodyError) return bodyError;
                continue;
            }
            if (node.type === "repeat-until") {
                const bodyScope = nextScopeId++;
                parentScope.set(bodyScope, scopeId);
                const bodyError = visit(node.body, bodyScope);
                if (bodyError) return bodyError;
                const conditionError = visit(node.conditionBody, bodyScope);
                if (conditionError) return conditionError;
                sequence++;
                for (const name of node.reads || []) reads.push({ name, scopeId: bodyScope, sequence });
                continue;
            }
            for (const name of node.reads || []) reads.push({ name, scopeId, sequence });
            if (node.type === "numeric-for") {
                const bodyScope = nextScopeId++;
                parentScope.set(bodyScope, scopeId);
                const declarationError = addNumericForDeclaration(node.variable, bodyScope, scopeId, sequence);
                if (declarationError) return declarationError;
                const bodyError = visit(node.body, bodyScope);
                if (bodyError) return bodyError;
                continue;
            }
            if (node.type === "generic-for") {
                const bodyScope = nextScopeId++;
                parentScope.set(bodyScope, scopeId);
                for (const variable of node.variables || []) {
                    const declarationError = addNumericForDeclaration(variable, bodyScope, scopeId, sequence);
                    if (declarationError) return declarationError;
                }
                const bodyError = visit(node.body, bodyScope);
                if (bodyError) return bodyError;
                continue;
            }
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

    for (const read of reads) {
        const list = declarations.get(read.name);
        if (!list || !list.length) continue;
        const visible = list.filter(declaration => isAncestor(declaration.scopeId, read.scopeId));
        if (!visible.length) {
            return "Structuring would move " + read.name + " outside the Lua scope of its beta declaration";
        }
        if (!visible.some(declaration => declaration.sequence <= read.sequence)) {
            return "Structuring would read " + read.name + " before its beta declaration";
        }
    }
    return null;
}

function parseOperationExpression(operation) {
    const rhs = String(operation?.rhs || "").trim();
    if (!rhs) return null;
    return parseTransitionExpression(rhs)?.expression || null;
}

function identifierName(node) {
    return isIdentifier(node) ? node.name : null;
}

function lastOperationDefinition(operations, name, beforeIndex = null) {
    const limit = beforeIndex === null ? operations.length : beforeIndex;
    for (let index = limit - 1; index >= 0; index--) {
        const operation = operations[index];
        if (operation?.emittedTarget !== name) continue;
        return { operation, index, expression: parseOperationExpression(operation) };
    }
    return null;
}

function directNumericOperationValue(definition) {
    return definition ? numericValue(definition.expression) : null;
}

function computeGraphPredecessors(states) {
    const predecessors = new Map(states.map(state => [state.id, []]));
    for (const state of states) {
        for (const successor of state.successors || []) {
            if (!predecessors.has(successor)) continue;
            predecessors.get(successor).push(state.id);
        }
    }
    return predecessors;
}

function computeDominators(states, entryId) {
    const stateById = new Map(states.map(state => [state.id, state]));
    if (!stateById.has(entryId)) return null;
    const predecessors = computeGraphPredecessors(states);
    const all = new Set(states.map(state => state.id));
    const dominators = new Map();
    for (const state of states) dominators.set(state.id, state.id === entryId ? new Set([entryId]) : new Set(all));

    let changed = true;
    let iterations = 0;
    const maxIterations = Math.max(8, states.length * states.length + 8);
    while (changed) {
        if (++iterations > maxIterations) return null;
        changed = false;
        for (const state of states) {
            if (state.id === entryId) continue;
            const preds = predecessors.get(state.id) || [];
            if (!preds.length) return null;
            const predSets = preds.map(id => dominators.get(id));
            if (predSets.some(value => !value)) return null;
            const next = intersectSets(predSets);
            next.add(state.id);
            if (!setEquals(next, dominators.get(state.id))) {
                dominators.set(state.id, next);
                changed = true;
            }
        }
    }
    return dominators;
}

function graphReadCounts(states) {
    const counts = new Map();
    for (const state of states || []) {
        for (const operation of state.operations || []) {
            for (const name of operation?.reads || []) counts.set(name, (counts.get(name) || 0) + 1);
        }
    }
    return counts;
}

function canCanonicalizeTransitionTail(state, info) {
    const transitionIndex = (state.operations || []).indexOf(info.operation);
    if (transitionIndex < 0) return false;
    const tail = state.operations.slice(transitionIndex + 1);
    const stateName = info.operation?.emittedTarget;
    if (tail.some(operation => operation?.emittedTarget === stateName || (operation?.reads || []).includes(stateName))) return false;
    return true;
}

function forwardControlOnlyJoinBranches(graph) {
    let working = {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(state.predecessors || [])],
            successors: [...(state.successors || [])],
            operations: [...(state.operations || [])],
        })),
    };
    let forwardedCount = 0;

    while (true) {
        const states = working.states || [];
        const stateById = new Map(states.map(state => [state.id, state]));
        const predecessors = computeGraphPredecessors(states);
        const readCounts = graphReadCounts(states);
        let match = null;

        for (const decision of states) {
            const decisionInfo = transitionInfo(decision, { allowUnprovenCondition: true });
            if (decisionInfo.error || decisionInfo.kind !== 'branch' || decisionInfo.conditionProven) continue;
            const conditionName = decisionInfo.conditionName;
            if (!conditionName) continue;
            const incoming = predecessors.get(decision.id) || [];
            if (incoming.length < 2) continue;

            const decisionBody = (decision.operations || []).filter(operation => operation !== decisionInfo.operation);
            if (decisionBody.some(operation => {
                if (operation?.returnSinkSafe !== true || !operation?.emittedTarget) return true;
                if ((readCounts.get(operation.emittedTarget) || 0) !== 0) return true;
                return false;
            })) continue;

            const rewrites = [];
            let valid = true;
            for (const predecessorId of incoming) {
                const predecessor = stateById.get(predecessorId);
                if (!predecessor) { valid = false; break; }
                const predecessorInfo = transitionInfo(predecessor, { allowUnprovenCondition: true });
                if (predecessorInfo.error || (predecessorInfo.kind !== 'jump' && predecessorInfo.kind !== 'branch')) { valid = false; break; }
                if (!canCanonicalizeTransitionTail(predecessor, predecessorInfo)) { valid = false; break; }

                const definitions = (predecessor.operations || []).filter(operation =>
                    operation !== predecessorInfo.operation &&
                    originalOperationTarget(operation) === conditionName &&
                    operation?.emittedTarget &&
                    operation?.returnSinkSafe === true
                );
                if (definitions.length !== 1) { valid = false; break; }
                const definition = definitions[0];
                if ((readCounts.get(definition.emittedTarget) || 0) !== 0) { valid = false; break; }
                const valueName = identifierName(parseOperationExpression(definition));
                if (!valueName) { valid = false; break; }

                if (predecessorInfo.kind === 'jump') {
                    if (predecessorInfo.target !== decision.id) { valid = false; break; }
                    rewrites.push({
                        predecessorId,
                        definition,
                        oldTransition: predecessorInfo.operation,
                        successors: [decisionInfo.onTrue, decisionInfo.onFalse],
                        transition: {
                            ...predecessorInfo.operation,
                            rhs: valueName + ' and ' + decisionInfo.onTrue + ' or ' + decisionInfo.onFalse,
                            emittedText: (predecessorInfo.operation.emittedTarget || working.stateName || 'state') + ' = ' + valueName + ' and ' + decisionInfo.onTrue + ' or ' + decisionInfo.onFalse,
                            reads: [valueName],
                        },
                    });
                    continue;
                }

                const trueIsDecision = predecessorInfo.onTrue === decision.id;
                const falseIsDecision = predecessorInfo.onFalse === decision.id;
                if (trueIsDecision === falseIsDecision) { valid = false; break; }
                if (valueName !== predecessorInfo.conditionName || predecessorInfo.conditionProven !== true) { valid = false; break; }
                const onTrue = trueIsDecision ? decisionInfo.onTrue : predecessorInfo.onTrue;
                const onFalse = falseIsDecision ? decisionInfo.onFalse : predecessorInfo.onFalse;
                rewrites.push({
                    predecessorId,
                    definition,
                    oldTransition: predecessorInfo.operation,
                    successors: [onTrue, onFalse],
                    transition: {
                        ...predecessorInfo.operation,
                        rhs: predecessorInfo.conditionName + ' and ' + onTrue + ' or ' + onFalse,
                        emittedText: (predecessorInfo.operation.emittedTarget || working.stateName || 'state') + ' = ' + predecessorInfo.conditionName + ' and ' + onTrue + ' or ' + onFalse,
                        reads: [...(predecessorInfo.conditionReads || [])],
                    },
                });
            }
            if (!valid || rewrites.length !== incoming.length) continue;
            match = { decisionId: decision.id, rewrites };
            break;
        }

        if (!match) break;
        const rewriteByState = new Map(match.rewrites.map(item => [item.predecessorId, item]));
        working = {
            ...working,
            states: working.states.filter(state => state.id !== match.decisionId).map(state => {
                const rewrite = rewriteByState.get(state.id);
                if (!rewrite) return state;
                const operations = (state.operations || []).filter(operation => operation !== rewrite.definition && operation !== rewrite.oldTransition);
                operations.push(rewrite.transition);
                return { ...state, operations, successors: rewrite.successors };
            }),
        };
        working = rebuildGraphPredecessors(working);
        forwardedCount++;
    }

    return { graph: working, forwardedCount };
}

function sameMembers(values, expected) {
    if (values.length !== expected.length) return false;
    const left = [...values].sort((a, b) => a - b);
    const right = [...expected].sort((a, b) => a - b);
    return left.every((value, index) => value === right[index]);
}

function collectLoopBodyRegion(stateById, predecessors, bodyId, checkId, exitId, bodyEntryPredecessorId = checkId) {
    const ids = new Set();
    const visiting = new Set();
    const latchIds = new Set();
    const breakIds = new Set();
    const terminalIds = new Set();
    let invalid = false;

    function visit(stateId) {
        if (invalid || ids.has(stateId)) return;
        if (stateId === checkId || stateId === exitId || visiting.has(stateId)) {
            invalid = true;
            return;
        }
        const state = stateById.get(stateId);
        if (!state || !Array.isArray(state.successors)) {
            invalid = true;
            return;
        }
        if (state.successors.length === 0) {
            const sunk = sinkTerminalReturnPayload(state.operations || []);
            const lowered = lowerTerminalReturn(sunk.operations);
            if (!lowered.lowered) {
                invalid = true;
                return;
            }
            terminalIds.add(stateId);
            ids.add(stateId);
            return;
        }
        visiting.add(stateId);
        for (const successor of state.successors) {
            if (successor === checkId) {
                latchIds.add(stateId);
                continue;
            }
            if (successor === exitId) {
                breakIds.add(stateId);
                continue;
            }
            if (!stateById.has(successor)) {
                invalid = true;
                break;
            }
            visit(successor);
            if (invalid) break;
        }
        visiting.delete(stateId);
        ids.add(stateId);
    }

    visit(bodyId);
    if (invalid || !ids.size || !latchIds.size) return null;

    for (const stateId of ids) {
        const incoming = predecessors.get(stateId) || [];
        if (stateId === bodyId) {
            if (bodyEntryPredecessorId !== null) {
                const expectedIncoming = Array.isArray(bodyEntryPredecessorId) ? bodyEntryPredecessorId : [bodyEntryPredecessorId];
                if (!sameMembers(incoming, expectedIncoming)) return null;
            }
        } else if (incoming.some(predecessor => !ids.has(predecessor))) {
            return null;
        }
    }
    return { ids, latchIds, breakIds, terminalIds };
}

function computeReachableStateSetsWithExit(states, stateById, exitNode) {
    const memo = new Map([[exitNode, new Set([exitNode])]]);
    const visiting = new Set();

    function visit(stateId) {
        if (memo.has(stateId)) return memo.get(stateId);
        if (visiting.has(stateId)) return null;
        const state = stateById.get(stateId);
        if (!state) return null;
        visiting.add(stateId);
        const reachable = new Set([stateId]);
        for (const successor of state.successors || []) {
            const successorReachable = visit(successor);
            if (!successorReachable) return null;
            for (const candidate of successorReachable) reachable.add(candidate);
        }
        visiting.delete(stateId);
        memo.set(stateId, reachable);
        return reachable;
    }

    for (const state of states) if (!visit(state.id)) return null;
    return memo;
}

function structureLoopBodyRegion(stateById, region, bodyId, checkId, skipOperations, currentName = null, loopExitId = null, emitContinue = false) {
    const exitNode = Symbol('loop-body-normal-exit');
    const breakNode = Symbol('loop-body-break');
    const states = [];
    const prepared = new Map();

    function mapTarget(target) {
        if (target === checkId) return exitNode;
        if (loopExitId !== null && target === loopExitId) return breakNode;
        return region.ids.has(target) ? target : null;
    }

    for (const stateId of region.ids) {
        const state = stateById.get(stateId);
        if (!state || hasUnsafeUnsupportedOperation(state.operations || [])) return null;
        const info = transitionInfo(state);
        if (info.error) return null;

        if (info.kind === 'stop') {
            const sunk = sinkTerminalReturnPayload(state.operations || []);
            const lowered = lowerTerminalReturn(sunk.operations);
            if (!lowered.lowered) return null;
            if (lowered.operations.some(operation => !operationText(operation))) return null;
            prepared.set(stateId, { bodyOperations: lowered.operations, info: { kind: 'return' } });
            states.push({ ...state, successors: [] });
            continue;
        }
        if (info.kind !== 'jump' && info.kind !== 'branch') return null;
        const transitionIndex = state.operations.indexOf(info.operation);
        if (transitionIndex < 0) return null;
        const tailOperations = state.operations.slice(transitionIndex + 1);
        const stateName = info.operation?.emittedTarget;
        if (tailOperations.some(operation =>
            operation?.emittedTarget === stateName || (operation?.reads || []).includes(stateName)
        )) return null;
        if (info.kind === 'branch' && tailOperations.length) {
            const conditionReads = new Set(info.conditionReads || []);
            if (tailOperations.some(operation => conditionReads.has(operation.emittedTarget))) return null;
        }

        const bodyOperations = (state.operations || []).filter(operation =>
            operation !== info.operation && !skipOperations.has(operation)
        );
        if (bodyOperations.some(operation => !operationText(operation))) return null;
        if (currentName && bodyOperations.some(operation => (operation.reads || []).includes(currentName))) return null;

        let mappedInfo;
        if (info.kind === 'jump') {
            const target = mapTarget(info.target);
            if (target === null) return null;
            mappedInfo = { ...info, target };
        } else {
            const onTrue = mapTarget(info.onTrue);
            const onFalse = mapTarget(info.onFalse);
            if (onTrue === null || onFalse === null) return null;
            mappedInfo = { ...info, onTrue, onFalse };
        }
        prepared.set(stateId, { bodyOperations, info: mappedInfo });
        states.push({
            ...state,
            successors: (state.successors || []).map(mapTarget),
        });
    }

    if (states.some(state => state.successors.some(successor => successor === null))) return null;
    const hasBreak = states.some(state => state.successors.includes(breakNode));
    const analysisStates = hasBreak
        ? [...states, { id: breakNode, predecessors: [], successors: [exitNode], operations: [] }]
        : states;
    const syntheticById = new Map(analysisStates.map(state => [state.id, state]));
    const postdominators = computePostdominators(analysisStates, syntheticById, exitNode);
    const reachableSets = computeReachableStateSetsWithExit(analysisStates, syntheticById, exitNode);
    if (!postdominators || !reachableSets) return null;

    const emittedStates = new Set();
    let branchCount = 0;
    let joinCount = 0;

    function emitSequence(startState, stopState) {
        const nodes = [];
        let current = startState;
        while (current !== stopState && current !== exitNode) {
            if (current === breakNode) {
                nodes.push(rawNode({ kind: 'loop-break', emittedText: 'break', reads: [] }, null));
                current = exitNode;
                continue;
            }
            if (emittedStates.has(current)) throw new Error('loop body state emitted twice');
            const item = prepared.get(current);
            if (!item) throw new Error('missing loop body state');
            emittedStates.add(current);
            for (const operation of item.bodyOperations) nodes.push(operationNode(operation, current));

            const info = item.info;
            if (info.kind === 'return') {
                current = exitNode;
                continue;
            }
            if (info.kind === 'jump') {
                current = info.target;
                continue;
            }
            branchCount++;
            let join = immediatePostdominator(current, postdominators);
            if (join === exitNode) {
                const partial = earliestCommonReachableJoin(info.onTrue, info.onFalse, stopState, exitNode, reachableSets);
                if (partial.ambiguous) throw new Error('loop body branch has ambiguous shared continuation');
                if (partial.join !== null && partial.join !== exitNode) join = partial.join;
            } else if (
                join !== null && stopState !== exitNode && join !== stopState && !reachesState(join, stopState, reachableSets)
            ) {
                const partial = earliestCommonReachableJoin(info.onTrue, info.onFalse, stopState, exitNode, reachableSets);
                if (partial.ambiguous) throw new Error('loop body branch has ambiguous shared continuation');
                join = partial.join;
            }
            if (join === breakNode) join = exitNode;
            if (join === null || join === current) throw new Error('loop body branch has no unique join');
            if (join !== exitNode && !region.ids.has(join)) throw new Error('loop body branch escapes loop');

            function directControlPath(target) {
                if (target === breakNode) return { kind: 'break', proxyState: null };
                if (emitContinue && target === exitNode) return { kind: 'continue', proxyState: null };
                const proxy = prepared.get(target);
                if (!proxy || proxy.bodyOperations.length !== 0 || proxy.info.kind !== 'jump') return null;
                if (proxy.info.target === breakNode) return { kind: 'break', proxyState: target };
                if (emitContinue && proxy.info.target === exitNode) return { kind: 'continue', proxyState: target };
                return null;
            }

            const trueControl = join === exitNode ? directControlPath(info.onTrue) : null;
            const falseControl = join === exitNode ? directControlPath(info.onFalse) : null;
            const trueReturn = join === exitNode && prepared.get(info.onTrue)?.info?.kind === 'return';
            const falseReturn = join === exitNode && prepared.get(info.onFalse)?.info?.kind === 'return';
            if (trueReturn && falseControl?.kind === 'continue') {
                if (falseControl.proxyState !== null) emittedStates.add(falseControl.proxyState);
                const returned = emitSequence(info.onTrue, exitNode);
                nodes.push(ifNode(info.condition, info.conditionReads, returned.nodes));
                current = exitNode;
                continue;
            }
            if (falseReturn && trueControl?.kind === 'continue') {
                if (trueControl.proxyState !== null) emittedStates.add(trueControl.proxyState);
                const returned = emitSequence(info.onFalse, exitNode);
                nodes.push(ifNode('not (' + info.condition + ')', info.conditionReads, returned.nodes));
                current = exitNode;
                continue;
            }
            if (trueControl && falseControl) {
                if (trueControl.proxyState !== null) emittedStates.add(trueControl.proxyState);
                if (falseControl.proxyState !== null) emittedStates.add(falseControl.proxyState);
                if (trueControl.kind === 'break' && falseControl.kind === 'continue') {
                    nodes.push(ifNode(info.condition, info.conditionReads, [rawNode({ kind: 'loop-break', emittedText: 'break', reads: [] }, null)]));
                } else if (trueControl.kind === 'continue' && falseControl.kind === 'break') {
                    nodes.push(ifNode('not (' + info.condition + ')', info.conditionReads, [rawNode({ kind: 'loop-break', emittedText: 'break', reads: [] }, null)]));
                } else if (trueControl.kind === 'break' && falseControl.kind === 'break') {
                    nodes.push(rawNode({ kind: 'loop-break', emittedText: 'break', reads: [] }, null));
                }
                current = exitNode;
                continue;
            }
            if (trueControl && !falseControl) {
                if (trueControl.proxyState !== null) emittedStates.add(trueControl.proxyState);
                nodes.push(ifNode(info.condition, info.conditionReads, [rawNode({ kind: 'loop-' + trueControl.kind, emittedText: trueControl.kind, reads: [] }, null)]));
                const remainder = info.onFalse === exitNode ? { nodes: [] } : emitSequence(info.onFalse, exitNode);
                nodes.push(...remainder.nodes);
                current = exitNode;
                continue;
            }
            if (falseControl && !trueControl) {
                if (falseControl.proxyState !== null) emittedStates.add(falseControl.proxyState);
                nodes.push(ifNode('not (' + info.condition + ')', info.conditionReads, [rawNode({ kind: 'loop-' + falseControl.kind, emittedText: falseControl.kind, reads: [] }, null)]));
                const remainder = info.onTrue === exitNode ? { nodes: [] } : emitSequence(info.onTrue, exitNode);
                nodes.push(...remainder.nodes);
                current = exitNode;
                continue;
            }

            const trueResult = info.onTrue === join ? { nodes: [] } : emitSequence(info.onTrue, join);
            const falseResult = info.onFalse === join ? { nodes: [] } : emitSequence(info.onFalse, join);
            if (trueResult.nodes.length && falseResult.nodes.length) {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes, falseResult.nodes));
            } else if (trueResult.nodes.length) {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes));
            } else if (falseResult.nodes.length) {
                nodes.push(ifNode('not (' + info.condition + ')', info.conditionReads, falseResult.nodes));
            }
            if (join !== exitNode && join !== breakNode) joinCount++;
            current = join;
        }
        return { nodes };
    }

    let structured;
    try {
        structured = emitSequence(bodyId, exitNode);
    } catch {
        return null;
    }
    if (emittedStates.size !== region.ids.size) return null;
    return { nodes: structured.nodes, branchCount, joinCount };
}

function matchCompilerNumericFor(graph, checkStateId) {
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const check = stateById.get(checkStateId);
    if (!check || !Array.isArray(check.successors) || check.successors.length !== 2) return null;

    const bodyMatches = [];
    for (const bodyId of check.successors) {
        const exitId = check.successors.find(id => id !== bodyId);
        if (exitId === undefined || !stateById.has(exitId)) continue;
        const region = collectLoopBodyRegion(stateById, predecessors, bodyId, check.id, exitId);
        if (region) bodyMatches.push({ bodyId, exitId, region });
    }
    if (bodyMatches.length !== 1) return null;
    const { bodyId, exitId, region } = bodyMatches[0];

    const checkPreds = predecessors.get(check.id) || [];
    const preheaderCandidates = checkPreds.filter(id => !region.ids.has(id));
    if (preheaderCandidates.length !== 1) return null;
    const preheaderId = preheaderCandidates[0];
    if (!sameMembers(checkPreds, [preheaderId, ...region.latchIds])) return null;
    const preheader = stateById.get(preheaderId);
    if (!preheader || !Array.isArray(preheader.successors) || preheader.successors.length !== 1 || preheader.successors[0] !== check.id) return null;

    const checkOps = check.operations || [];
    if (!checkOps.length) return null;
    const transitionIndex = checkOps.findLastIndex(operation => operation?.kind === 'state-transition');
    if (transitionIndex !== checkOps.length - 1) return null;
    const transition = checkOps[transitionIndex];
    const transitionExpr = parseOperationExpression(transition);
    if (transitionExpr?.type !== 'LogicalExpression' || transitionExpr.operator !== 'or') return null;
    const stateTmpName = identifierName(transitionExpr.left);
    const exitLoadName = identifierName(transitionExpr.right);
    if (!stateTmpName || !exitLoadName) return null;

    const exitLoad = lastOperationDefinition(checkOps, exitLoadName, transitionIndex);
    if (directNumericOperationValue(exitLoad) !== exitId) return null;
    const stateTmp = lastOperationDefinition(checkOps, stateTmpName, transitionIndex);
    const stateTmpExpr = stateTmp?.expression;
    if (stateTmpExpr?.type !== 'LogicalExpression' || stateTmpExpr.operator !== 'and') return null;
    const conditionName = identifierName(stateTmpExpr.left);
    const bodyLoadName = identifierName(stateTmpExpr.right);
    if (!conditionName || !bodyLoadName) return null;
    const bodyLoad = lastOperationDefinition(checkOps, bodyLoadName, stateTmp.index);
    if (directNumericOperationValue(bodyLoad) !== bodyId) return null;

    const conditionDef = lastOperationDefinition(checkOps, conditionName, stateTmp.index);
    const conditionExpr = conditionDef?.expression;
    if (conditionExpr?.type !== 'LogicalExpression' || conditionExpr.operator !== 'or') return null;
    const negativeArmName = identifierName(conditionExpr.left);
    const positiveArmName = identifierName(conditionExpr.right);
    if (!negativeArmName || !positiveArmName) return null;

    const negativeArm = lastOperationDefinition(checkOps, negativeArmName, conditionDef.index);
    const negativeExpr = negativeArm?.expression;
    if (negativeExpr?.type !== 'LogicalExpression' || negativeExpr.operator !== 'and') return null;
    const negativeFlagName = identifierName(negativeExpr.left);
    const greaterEqualName = identifierName(negativeExpr.right);
    if (!negativeFlagName || !greaterEqualName) return null;
    const greaterEqual = lastOperationDefinition(checkOps, greaterEqualName, negativeArm.index);
    const greaterEqualExpr = greaterEqual?.expression;
    if (greaterEqualExpr?.type !== 'BinaryExpression' || greaterEqualExpr.operator !== '>=') return null;
    const currentName = identifierName(greaterEqualExpr.left);
    const finalName = identifierName(greaterEqualExpr.right);
    if (!currentName || !finalName) return null;

    const positiveArm = lastOperationDefinition(checkOps, positiveArmName, conditionDef.index);
    const positiveExpr = positiveArm?.expression;
    if (positiveExpr?.type !== 'LogicalExpression' || positiveExpr.operator !== 'and') return null;
    const notNegativeName = identifierName(positiveExpr.left);
    const lessEqualName = identifierName(positiveExpr.right);
    if (!notNegativeName || !lessEqualName) return null;
    const notNegative = lastOperationDefinition(checkOps, notNegativeName, positiveArm.index);
    const notNegativeExpr = notNegative?.expression;
    if (notNegativeExpr?.type !== 'UnaryExpression' || notNegativeExpr.operator !== 'not' || identifierName(notNegativeExpr.argument) !== negativeFlagName) return null;
    const lessEqual = lastOperationDefinition(checkOps, lessEqualName, positiveArm.index);
    const lessEqualExpr = lessEqual?.expression;
    if (lessEqualExpr?.type !== 'BinaryExpression' || lessEqualExpr.operator !== '<=' ||
        identifierName(lessEqualExpr.left) !== currentName || identifierName(lessEqualExpr.right) !== finalName) return null;

    const currentAddCandidates = checkOps.map((operation, index) => ({ operation, index, expression: parseOperationExpression(operation) })).filter(item =>
        item.operation?.emittedTarget === currentName &&
        item.expression?.type === 'BinaryExpression' && item.expression.operator === '+' &&
        identifierName(item.expression.left) === currentName && identifierName(item.expression.right)
    );
    if (currentAddCandidates.length !== 1) return null;
    const currentAdd = currentAddCandidates[0];
    const stepName = identifierName(currentAdd.expression.right);
    if (!stepName) return null;

    const matchedCheckOperations = new Set([
        transition, exitLoad.operation, stateTmp.operation, bodyLoad.operation, conditionDef.operation,
        negativeArm.operation, greaterEqual.operation, positiveArm.operation, notNegative.operation,
        lessEqual.operation, currentAdd.operation,
    ]);
    if (matchedCheckOperations.size !== checkOps.length || checkOps.some(operation => !matchedCheckOperations.has(operation))) return null;

    const preOps = preheader.operations || [];
    const preTransitionIndex = preOps.findLastIndex(operation => operation?.kind === 'state-transition');
    if (preTransitionIndex !== preOps.length - 1) return null;
    const preTransition = preOps[preTransitionIndex];
    if (directNumericOperationValue({ expression: parseOperationExpression(preTransition) }) !== check.id) return null;

    const currentInit = lastOperationDefinition(preOps, currentName, preTransitionIndex);
    const currentInitExpr = currentInit?.expression;
    if (currentInitExpr?.type !== 'BinaryExpression' || currentInitExpr.operator !== '-') return null;
    const startName = identifierName(currentInitExpr.left);
    if (!startName || identifierName(currentInitExpr.right) !== stepName) return null;

    const negativeFlag = lastOperationDefinition(preOps, negativeFlagName, preTransitionIndex);
    const negativeFlagExpr = negativeFlag?.expression;
    if (negativeFlagExpr?.type !== 'BinaryExpression' || negativeFlagExpr.operator !== '<' || identifierName(negativeFlagExpr.left) !== stepName) return null;
    const zeroName = identifierName(negativeFlagExpr.right);
    if (!zeroName) return null;
    const zeroDef = lastOperationDefinition(preOps, zeroName, negativeFlag.index);
    if (directNumericOperationValue(zeroDef) !== 0) return null;

    const startDef = lastOperationDefinition(preOps, startName, preTransitionIndex);
    const finalDef = lastOperationDefinition(preOps, finalName, preTransitionIndex);
    const stepDef = lastOperationDefinition(preOps, stepName, preTransitionIndex);
    if (!startDef || !finalDef || !stepDef) return null;

    const loopVariableDefinitions = [];
    for (const stateId of region.ids) {
        const state = stateById.get(stateId);
        const stateInfo = transitionInfo(state);
        if (stateInfo.error || !stateInfo.operation || !canCanonicalizeTransitionTail(state, stateInfo)) return null;
        for (const operation of state.operations || []) {
            if (operation === stateInfo.operation || !operation?.emittedTarget) continue;
            const expression = parseOperationExpression(operation);
            if (identifierName(expression) === currentName) {
                loopVariableDefinitions.push({ stateId, operation });
            }
        }
    }
    if (loopVariableDefinitions.length !== 1 || loopVariableDefinitions[0].stateId !== bodyId) return null;
    const loopVariableDefinition = loopVariableDefinitions[0].operation;
    const loopVariable = loopVariableDefinition.emittedTarget;

    const cleanupCandidates = [];
    const loopVariableWrites = [];
    const capturedLoopDeclarations = [];
    for (const stateId of region.ids) {
        const state = stateById.get(stateId);
        for (const operation of state.operations || []) {
            if (operation?.emittedTarget !== loopVariable) continue;
            loopVariableWrites.push(operation);
            if (operation.kind === 'upvalue-binding-declaration') {
                capturedLoopDeclarations.push({ stateId, operation });
                continue;
            }
            const expression = parseOperationExpression(operation);
            if (expression?.type === 'NilLiteral' &&
                (!loopVariableDefinition.registerEpoch || !operation.registerEpoch || loopVariableDefinition.registerEpoch === operation.registerEpoch)) {
                cleanupCandidates.push({ stateId, operation });
            }
        }
    }

    const recoveredCapturedLoopVariable =
        (loopVariableDefinition.kind === 'upvalue-binding-init' || loopVariableDefinition.kind === 'upvalue-binding-start') &&
        capturedLoopDeclarations.length <= 1 &&
        capturedLoopDeclarations.every(candidate => candidate.stateId === bodyId);

    const requiredCleanupStates = new Set([...region.latchIds, ...(region.breakIds || [])]);
    const cleanupStateIds = new Set(cleanupCandidates.map(candidate => candidate.stateId));
    if (recoveredCapturedLoopVariable) {
        // beta-upvalues already consumed the compiler releaseUpvalue(cell) cleanup.
        if (cleanupCandidates.length !== 0) return null;
    } else if (cleanupCandidates.length !== requiredCleanupStates.size || !sameMembers([...cleanupStateIds], [...requiredCleanupStates])) {
        return null;
    }
    const cleanupOperations = new Set(cleanupCandidates.map(candidate => candidate.operation));

    const sourceLoopVariableWrites = loopVariableWrites.filter(operation =>
        operation !== loopVariableDefinition &&
        !cleanupOperations.has(operation) &&
        !capturedLoopDeclarations.some(candidate => candidate.operation === operation)
    );
    if (sourceLoopVariableWrites.some(operation =>
        loopVariableDefinition.registerEpoch && operation.registerEpoch &&
        loopVariableDefinition.registerEpoch !== operation.registerEpoch
    )) return null;

    // Source writes to the visible numeric-for variable are legal in Lua/Luau.
    // They must not be confused with the compiler's hidden induction machinery:
    // current/step/final/negative are proven from the check/preheader signature and
    // must never be written by the structured body.
    const protectedInductionNames = new Set([currentName, stepName, finalName, negativeFlagName]);
    for (const stateId of region.ids) {
        for (const operation of stateById.get(stateId)?.operations || []) {
            if (protectedInductionNames.has(operation?.emittedTarget)) return null;
        }
    }

    const skipOperations = new Set([
        loopVariableDefinition,
        ...cleanupOperations,
        ...capturedLoopDeclarations.map(candidate => candidate.operation),
    ]);
    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, skipOperations, currentName, exitId, true);
    if (!structuredBody) return null;

    const removeFromPreheader = new Set([currentInit.operation, negativeFlag.operation, zeroDef.operation, preTransition]);
    const retainedPreheaderOperations = preOps.filter(operation => !removeFromPreheader.has(operation));
    if (retainedPreheaderOperations.some(operation =>
        (operation.reads || []).includes(negativeFlagName) || (operation.reads || []).includes(zeroName)
    )) return null;

    return {
        preheaderId: preheader.id,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        startName,
        finalName,
        stepName,
        loopVariable,
        retainedPreheaderOperations,
        bodyNodes: structuredBody.nodes,
        bodyBranchCount: structuredBody.branchCount,
        bodyJoinCount: structuredBody.joinCount,
    };
}

function matchCompilerGenericFor(graph, checkStateId) {
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const check = stateById.get(checkStateId);
    if (!check || !Array.isArray(check.successors) || check.successors.length !== 2) return null;

    const checkInfo = transitionInfo(check, { allowUnprovenCondition: true });
    if (checkInfo.error || checkInfo.kind !== "branch") return null;
    const bodyId = checkInfo.onTrue;
    const exitId = checkInfo.onFalse;
    if (!stateById.has(bodyId) || !stateById.has(exitId)) return null;

    const iteratorSteps = (check.operations || []).filter(operation => operation?.kind === "multi-call-write");
    if (iteratorSteps.length !== 1) return null;
    const iteratorStep = iteratorSteps[0];
    if ((check.operations || []).length !== 2 || !check.operations.includes(checkInfo.operation)) return null;
    const targets = iteratorStep.originalTargets || [];
    const args = iteratorStep.callArgumentOriginals || [];
    if (targets.length !== 2 || !targets.every(Boolean) || !iteratorStep.callBaseOriginal || args.length !== 2 || !args.every(Boolean)) return null;
    const controlName = targets[0];
    const secondVariableOriginal = targets[1];
    const iteratorName = iteratorStep.callBaseOriginal;
    const iteratorStateName = args[0];
    if (args[1] !== controlName || checkInfo.conditionName !== controlName) return null;

    const region = collectLoopBodyRegion(stateById, predecessors, bodyId, check.id, exitId);
    if (!region) return null;
    const checkPreds = predecessors.get(check.id) || [];
    const preheaderCandidates = checkPreds.filter(id => !region.ids.has(id));
    if (preheaderCandidates.length !== 1) return null;
    const preheaderId = preheaderCandidates[0];
    if (!sameMembers(checkPreds, [preheaderId, ...region.latchIds])) return null;
    const preheader = stateById.get(preheaderId);
    if (!preheader || !Array.isArray(preheader.successors) || preheader.successors.length !== 1 || preheader.successors[0] !== check.id) return null;
    if (hasUnsafeUnsupportedOperation(preheader.operations || [])) return null;
    const preOps = preheader.operations || [];
    const preInfo = transitionInfo(preheader);
    if (preInfo.error || preInfo.kind !== "jump" || preInfo.target !== check.id || !canCanonicalizeTransitionTail(preheader, preInfo)) return null;
    const preTransitionIndex = preOps.indexOf(preInfo.operation);

    function lastOriginalDefinition(name) {
        for (let index = preTransitionIndex - 1; index >= 0; index--) {
            const operation = preOps[index];
            if (originalOperationTarget(operation) === name && operation?.emittedTarget) return operation;
        }
        return null;
    }
    const iteratorDef = lastOriginalDefinition(iteratorName);
    const iteratorStateDef = lastOriginalDefinition(iteratorStateName);
    const controlDef = lastOriginalDefinition(controlName);
    if (!iteratorDef || !iteratorStateDef || !controlDef) return null;

    const bodyEntry = stateById.get(bodyId);
    const firstCopies = (bodyEntry?.operations || []).filter(operation =>
        originalOperationTarget(operation) &&
        operation?.rhs === controlName &&
        operation?.emittedTarget &&
        originalOperationTarget(operation) !== controlName
    );
    if (firstCopies.length !== 1) return null;
    const firstCopy = firstCopies[0];
    const firstVariableOriginal = originalOperationTarget(firstCopy);
    const firstVariable = firstCopy.emittedTarget;
    const secondVariable = secondVariableOriginal;
    if (!firstVariableOriginal || firstVariableOriginal === secondVariableOriginal) return null;

    const requiredCleanupStates = new Set([...region.latchIds, ...(region.breakIds || [])]);
    const cleanupOperations = new Set();
    for (const variableName of [firstVariableOriginal, secondVariableOriginal]) {
        const cleanups = [];
        for (const stateId of region.ids) {
            for (const operation of stateById.get(stateId)?.operations || []) {
                if (originalOperationTarget(operation) !== variableName) continue;
                const expression = parseOperationExpression(operation);
                if (expression?.type === "NilLiteral") cleanups.push({ stateId, operation });
            }
        }
        const cleanupStates = new Set(cleanups.map(item => item.stateId));
        if (cleanups.length !== requiredCleanupStates.size || !sameMembers([...cleanupStates], [...requiredCleanupStates])) return null;
        for (const item of cleanups) cleanupOperations.add(item.operation);
    }

    const protectedOriginalNames = new Set([iteratorName, iteratorStateName, controlName]);
    for (const stateId of region.ids) {
        for (const operation of stateById.get(stateId)?.operations || []) {
            if (operation === firstCopy || cleanupOperations.has(operation)) continue;
            const originalTarget = originalOperationTarget(operation);
            if (protectedOriginalNames.has(originalTarget)) return null;
            if (originalTarget === firstVariableOriginal || originalTarget === secondVariableOriginal) return null;
        }
    }

    const skipOperations = new Set([firstCopy, ...cleanupOperations]);
    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, skipOperations, null, exitId, true);
    if (!structuredBody) return null;

    return {
        preheaderId,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        loopVariables: [firstVariable, secondVariable],
        iteratorExpressions: [iteratorDef.emittedTarget, iteratorStateDef.emittedTarget, controlDef.emittedTarget],
        retainedPreheaderOperations: preOps.filter(operation => operation !== preInfo.operation),
        bodyNodes: structuredBody.nodes,
        bodyBranchCount: structuredBody.branchCount,
        bodyJoinCount: structuredBody.joinCount,
    };
}

function collectAcyclicConditionRegion(stateById, predecessors, entryId, decisionId, forbiddenIds = new Set()) {
    const ids = new Set();
    const visiting = new Set();
    let invalid = false;

    function visit(stateId) {
        if (invalid || stateId === decisionId || ids.has(stateId)) return;
        if (forbiddenIds.has(stateId) || visiting.has(stateId)) {
            invalid = true;
            return;
        }
        const state = stateById.get(stateId);
        if (!state || !Array.isArray(state.successors) || state.successors.length === 0) {
            invalid = true;
            return;
        }
        visiting.add(stateId);
        for (const successor of state.successors) {
            if (successor === decisionId) continue;
            if (forbiddenIds.has(successor) || !stateById.has(successor)) {
                invalid = true;
                break;
            }
            visit(successor);
            if (invalid) break;
        }
        visiting.delete(stateId);
        ids.add(stateId);
    }

    visit(entryId);
    if (invalid || !ids.size) return null;
    const decisionPreds = predecessors.get(decisionId) || [];
    if (!decisionPreds.length || decisionPreds.some(id => !ids.has(id))) return null;
    for (const stateId of ids) {
        if (stateId === entryId) continue;
        const incoming = predecessors.get(stateId) || [];
        if (incoming.some(id => !ids.has(id))) return null;
    }
    return { ids };
}

function matchCompilerWhileConditionRegion(graph, decisionStateId) {
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const decision = stateById.get(decisionStateId);
    if (!decision || !Array.isArray(decision.successors) || decision.successors.length !== 2) return null;
    if (hasUnsafeUnsupportedOperation(decision.operations || [])) return null;
    const decisionInfo = transitionInfo(decision);
    if (decisionInfo.error || decisionInfo.kind !== 'branch') return null;
    const bodyId = decisionInfo.onTrue;
    const exitId = decisionInfo.onFalse;
    if (!stateById.has(bodyId) || !stateById.has(exitId)) return null;

    const matches = [];
    for (const header of states) {
        if (header.id === decision.id || header.id === bodyId || header.id === exitId) continue;
        const bodyRegion = collectLoopBodyRegion(stateById, predecessors, bodyId, header.id, exitId, decision.id);
        if (!bodyRegion) continue;
        const headerPreds = predecessors.get(header.id) || [];
        const preheaderCandidates = headerPreds.filter(id => !bodyRegion.ids.has(id));
        if (preheaderCandidates.length !== 1) continue;
        const preheaderId = preheaderCandidates[0];
        if (!sameMembers(headerPreds, [preheaderId, ...bodyRegion.latchIds])) continue;
        const preheader = stateById.get(preheaderId);
        if (!preheader || !Array.isArray(preheader.successors) || preheader.successors.length !== 1 || preheader.successors[0] !== header.id) continue;
        if (hasUnsafeUnsupportedOperation(preheader.operations || [])) continue;
        const preOps = preheader.operations || [];
        const preTransitionIndex = preOps.findLastIndex(operation => operation?.kind === 'state-transition');
        if (preTransitionIndex !== preOps.length - 1) continue;
        const preTransition = preOps[preTransitionIndex];
        if (directNumericOperationValue({ expression: parseOperationExpression(preTransition) }) !== header.id) continue;

        const forbidden = new Set([...bodyRegion.ids, bodyId, exitId, preheaderId]);
        const conditionRegion = collectAcyclicConditionRegion(stateById, predecessors, header.id, decision.id, forbidden);
        if (!conditionRegion || conditionRegion.ids.has(decision.id)) continue;
        // Only the loop preheader and body latches may enter the condition entry.
        for (const stateId of conditionRegion.ids) {
            if (stateId === header.id) continue;
            const incoming = predecessors.get(stateId) || [];
            if (incoming.some(id => !conditionRegion.ids.has(id))) {
                conditionRegion.invalid = true;
                break;
            }
        }
        if (conditionRegion.invalid) continue;

        const conditionStructured = structureLoopBodyRegion(
            stateById,
            conditionRegion,
            header.id,
            decision.id,
            new Set()
        );
        if (!conditionStructured) continue;
        const decisionTransitionIndex = decision.operations.indexOf(decisionInfo.operation);
        if (decisionTransitionIndex < 0) continue;
        const decisionTail = decision.operations.slice(decisionTransitionIndex + 1);
        const stateName = decisionInfo.operation?.emittedTarget;
        if (decisionTail.some(operation => operation?.emittedTarget === stateName || (operation?.reads || []).includes(stateName))) continue;
        if (decisionTail.some(operation => (decisionInfo.conditionReads || []).includes(operation.emittedTarget))) continue;
        const decisionOperations = (decision.operations || []).filter(operation => operation !== decisionInfo.operation);
        if (decisionOperations.some(operation => !operationText(operation))) continue;

        const bodyStructured = structureLoopBodyRegion(
            stateById,
            bodyRegion,
            bodyId,
            header.id,
            new Set(),
            null,
            exitId,
            true
        );
        if (!bodyStructured) continue;
        matches.push({
            preheaderId,
            checkId: decision.id,
            conditionEntryId: header.id,
            conditionStateIds: [...conditionRegion.ids, decision.id],
            bodyId,
            bodyStateIds: [...bodyRegion.ids],
            exitId,
            condition: decisionInfo.condition,
            conditionReads: decisionInfo.conditionReads,
            conditionNodes: [
                ...conditionStructured.nodes,
                ...decisionOperations.map(operation => operationNode(operation, decision.id)),
            ],
            bodyNodes: bodyStructured.nodes,
            bodyBranchCount: (bodyStructured.branchCount || 0) + (conditionStructured.branchCount || 0),
            bodyJoinCount: (bodyStructured.joinCount || 0) + (conditionStructured.joinCount || 0),
            retainedPreheaderOperations: preOps.filter(operation => operation !== preTransition),
            removeStateIds: [...conditionRegion.ids, decision.id, ...bodyRegion.ids],
        });
    }
    return matches.length === 1 ? matches[0] : null;
}

function matchCompilerWhile(graph, checkStateId) {
    // A numeric for has the same natural-loop topology. Let the stricter compiler
    // signature own it so generic while recovery cannot degrade a for into while true.
    if (matchCompilerNumericFor(graph, checkStateId)) return null;
    if (matchCompilerGenericFor(graph, checkStateId)) return null;

    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const check = stateById.get(checkStateId);
    if (!check || !Array.isArray(check.successors) || check.successors.length !== 2) return null;
    if (hasUnsafeUnsupportedOperation(check.operations || [])) return null;

    const checkInfo = transitionInfo(check);
    if (checkInfo.error || checkInfo.kind !== "branch") return null;
    const transitionIndex = check.operations.indexOf(checkInfo.operation);
    if (transitionIndex !== check.operations.length - 1) return null;

    // Local WeAreDevs WhileStatement lowering is pre-test: condition true enters
    // the body, condition false enters the continuation/final block.
    const bodyId = checkInfo.onTrue;
    const exitId = checkInfo.onFalse;
    if (!stateById.has(bodyId) || !stateById.has(exitId)) return null;
    const region = collectLoopBodyRegion(stateById, predecessors, bodyId, check.id, exitId);
    if (!region) return null;

    const checkPreds = predecessors.get(check.id) || [];
    const preheaderCandidates = checkPreds.filter(id => !region.ids.has(id));
    if (preheaderCandidates.length !== 1) return null;
    const preheaderId = preheaderCandidates[0];
    if (!sameMembers(checkPreds, [preheaderId, ...region.latchIds])) return null;

    const preheader = stateById.get(preheaderId);
    if (!preheader || !Array.isArray(preheader.successors) || preheader.successors.length !== 1 || preheader.successors[0] !== check.id) return null;
    if (hasUnsafeUnsupportedOperation(preheader.operations || [])) return null;
    const preOps = preheader.operations || [];
    const preTransitionIndex = preOps.findLastIndex(operation => operation?.kind === "state-transition");
    if (preTransitionIndex !== preOps.length - 1) return null;
    const preTransition = preOps[preTransitionIndex];
    if (directNumericOperationValue({ expression: parseOperationExpression(preTransition) }) !== check.id) return null;

    const conditionOperations = (check.operations || []).filter(operation => operation !== checkInfo.operation);
    if (conditionOperations.some(operation => !operationText(operation))) return null;
    const conditionNodes = conditionOperations.map(operation => operationNode(operation, check.id));

    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, new Set(), null, exitId, true);
    if (!structuredBody) return null;

    return {
        preheaderId: preheader.id,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        condition: checkInfo.condition,
        conditionReads: checkInfo.conditionReads,
        conditionNodes,
        bodyNodes: structuredBody.nodes,
        bodyBranchCount: structuredBody.branchCount,
        bodyJoinCount: structuredBody.joinCount,
        retainedPreheaderOperations: preOps.filter(operation => operation !== preTransition),
    };
}

function collapseCompilerWhileLoops(graph) {
    let working = {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(state.predecessors || [])],
            successors: [...(state.successors || [])],
            operations: [...(state.operations || [])],
        })),
    };
    let loopCount = 0;
    let bodyBranchCount = 0;
    let bodyJoinCount = 0;

    while (true) {
        let match = null;
        for (const state of working.states) {
            match = matchCompilerWhile(working, state.id) || matchCompilerWhileConditionRegion(working, state.id);
            if (match) break;
        }
        if (!match) break;

        const loopNode = whileGuardNode(match.condition, match.conditionReads, match.conditionNodes, match.bodyNodes);
        const structuredOperation = {
            kind: "structured-while",
            structuredNode: loopNode,
            emittedText: formatStructuredNodes([loopNode]),
            reads: [],
            returnSinkSafe: false,
        };
        const stateName = graph.stateName || "state";
        const syntheticTransition = {
            kind: "state-transition",
            emittedTarget: stateName,
            rhs: String(match.exitId),
            emittedText: `${stateName} = ${match.exitId}`,
            reads: [],
        };

        const removed = new Set(match.removeStateIds || [match.checkId, ...match.bodyStateIds]);
        working = {
            ...working,
            states: working.states.filter(state => !removed.has(state.id)).map(state => {
                if (state.id !== match.preheaderId) return state;
                return {
                    ...state,
                    operations: [...match.retainedPreheaderOperations, structuredOperation, syntheticTransition],
                    successors: [match.exitId],
                };
            }),
        };
        working = rebuildGraphPredecessors(working);
        loopCount++;
        bodyBranchCount += match.bodyBranchCount || 0;
        bodyJoinCount += match.bodyJoinCount || 0;
    }

    return { graph: working, loopCount, bodyBranchCount, bodyJoinCount };
}


function collectRepeatBodyRegion(stateById, predecessors, bodyId, checkId, exitId) {
    const ids = new Set();
    const visiting = new Set();
    const latchIds = new Set();
    const breakIds = new Set();
    const terminalIds = new Set();
    let invalid = false;

    function visit(stateId) {
        if (invalid || ids.has(stateId)) return;
        if (stateId === checkId || stateId === exitId || visiting.has(stateId)) {
            invalid = true;
            return;
        }
        const state = stateById.get(stateId);
        if (!state || !Array.isArray(state.successors)) {
            invalid = true;
            return;
        }
        if (state.successors.length === 0) {
            const sunk = sinkTerminalReturnPayload(state.operations || []);
            const lowered = lowerTerminalReturn(sunk.operations);
            if (!lowered.lowered) {
                invalid = true;
                return;
            }
            terminalIds.add(stateId);
            ids.add(stateId);
            return;
        }
        visiting.add(stateId);
        for (const successor of state.successors) {
            if (successor === checkId) {
                latchIds.add(stateId);
                continue;
            }
            if (successor === exitId) {
                breakIds.add(stateId);
                continue;
            }
            if (!stateById.has(successor)) {
                invalid = true;
                break;
            }
            visit(successor);
            if (invalid) break;
        }
        visiting.delete(stateId);
        ids.add(stateId);
    }

    visit(bodyId);
    if (invalid || !ids.size || !latchIds.size) return null;

    const checkIncoming = predecessors.get(checkId) || [];
    if (!sameMembers(checkIncoming, [...latchIds])) return null;

    const bodyIncoming = predecessors.get(bodyId) || [];
    const externalBodyIncoming = bodyIncoming.filter(predecessor => predecessor !== checkId && !ids.has(predecessor));
    if (externalBodyIncoming.length !== 1) return null;
    const preheaderId = externalBodyIncoming[0];
    if (!sameMembers(bodyIncoming, [checkId, preheaderId])) return null;

    for (const stateId of ids) {
        if (stateId === bodyId) continue;
        const incoming = predecessors.get(stateId) || [];
        if (incoming.some(predecessor => !ids.has(predecessor))) return null;
    }

    return { ids, latchIds, breakIds, terminalIds, preheaderId };
}
function originalOperationTarget(operation) {
    const explicit = String(operation?.originalTarget || '').trim();
    if (explicit) return explicit;
    const text = String(operation?.originalText || '').trim();
    const equalsIndex = text.indexOf('=');
    if (equalsIndex < 0) return '';
    const lhs = text.slice(0, equalsIndex).trim();
    return /^[A-Za-z_][A-Za-z0-9_]*$/.test(lhs) ? lhs : '';
}

function originalOperationRhs(operation) {
    const text = String(operation?.originalText || '').trim();
    if (text) {
        const equalsIndex = text.indexOf('=');
        if (equalsIndex >= 0) return text.slice(equalsIndex + 1).trim();
    }
    return String(operation?.rhs || '').trim();
}

function canonicalCompilerExpression(node, latestDefinitions) {
    if (node === null || node === undefined) return node;
    if (Array.isArray(node)) return node.map(item => canonicalCompilerExpression(item, latestDefinitions));
    if (typeof node !== 'object') return node;
    if (node.type === 'Identifier') {
        const localDefinition = latestDefinitions.get(node.name);
        return { type: 'Identifier', binding: localDefinition === undefined ? 'external:' + node.name : 'definition:' + localDefinition };
    }
    if (node.type === 'StringLiteral') {
        return { type: 'StringLiteral', raw: String(node.raw ?? '') };
    }
    const output = {};
    for (const key of Object.keys(node).sort()) {
        if (key === 'loc' || key === 'range' || key === 'raw' || key === 'comments' || key === 'tokens') continue;
        output[key] = canonicalCompilerExpression(node[key], latestDefinitions);
    }
    return output;
}

function canonicalCompilerOperationSequence(operations) {
    const latestDefinitions = new Map();
    const sequence = [];
    for (let index = 0; index < operations.length; index++) {
        const operation = operations[index];
        const rhs = originalOperationRhs(operation);
        if (!rhs) return null;
        const parsed = parseTransitionExpression(rhs)?.expression || null;
        if (!parsed) return null;
        sequence.push(canonicalCompilerExpression(parsed, latestDefinitions));
        const target = originalOperationTarget(operation);
        if (target) latestDefinitions.set(target, index);
    }
    return JSON.stringify(sequence);
}

function findUniqueCompilerOperationSlice(operations, pattern) {
    if (!pattern.length) return { start: -1, operations: new Set() };
    const patternSignature = canonicalCompilerOperationSequence(pattern);
    if (!patternSignature) return null;
    const candidates = [];
    for (let start = 0; start + pattern.length <= operations.length; start++) {
        const candidate = operations.slice(start, start + pattern.length);
        if (canonicalCompilerOperationSequence(candidate) === patternSignature) candidates.push(start);
    }
    if (candidates.length !== 1) return null;
    const start = candidates[0];
    return { start, operations: new Set(operations.slice(start, start + pattern.length)) };
}

function collectAcyclicRegionToExit(stateById, predecessors, entryId, exitId) {
    const ids = new Set();
    const visiting = new Set();
    let invalid = false;

    function visit(stateId) {
        if (invalid || stateId === exitId || ids.has(stateId)) return;
        if (visiting.has(stateId)) { invalid = true; return; }
        const state = stateById.get(stateId);
        if (!state || !Array.isArray(state.successors) || state.successors.length === 0) { invalid = true; return; }
        visiting.add(stateId);
        for (const successor of state.successors) {
            if (successor === exitId) continue;
            if (!stateById.has(successor)) { invalid = true; break; }
            visit(successor);
            if (invalid) break;
        }
        visiting.delete(stateId);
        ids.add(stateId);
    }

    visit(entryId);
    if (invalid || !ids.size) return null;
    const exitPreds = predecessors.get(exitId) || [];
    if (!exitPreds.length || exitPreds.some(id => !ids.has(id))) return null;
    for (const stateId of ids) {
        if (stateId === entryId) continue;
        const incoming = predecessors.get(stateId) || [];
        if (incoming.some(id => !ids.has(id))) return null;
    }
    return { ids };
}

function canonicalConditionStateOperations(state, entryStartIndex = 0) {
    const operations = (state.operations || []).filter(operation =>
        operation?.kind !== 'state-transition' && operation?.kind !== 'phi-declare' && operation?.kind !== 'phi-assign'
    );
    const selected = operations.slice(entryStartIndex);
    if (!selected.length) return '[]';
    const signature = canonicalCompilerOperationSequence(selected);
    if (!signature) return null;
    const targets = selected.map(operation => originalOperationTarget(operation));
    const kinds = selected.map(operation => operation?.kind || '');
    return JSON.stringify({ signature, targets, kinds });
}

function conditionRegionSignature(stateById, region, entryId, exitId, entryStartIndex = 0) {
    const memo = new Map();
    const visiting = new Set();
    function signature(stateId) {
        if (stateId === exitId) return 'EXIT';
        if (!region.ids.has(stateId) || visiting.has(stateId)) return null;
        if (memo.has(stateId)) return memo.get(stateId);
        const state = stateById.get(stateId);
        if (!state) return null;
        const info = transitionInfo(state);
        if (info.error || (info.kind !== 'jump' && info.kind !== 'branch')) return null;
        const opSig = canonicalConditionStateOperations(state, stateId === entryId ? entryStartIndex : 0);
        if (opSig === null) return null;
        visiting.add(stateId);
        let edgeSig;
        if (info.kind === 'jump') {
            const child = signature(info.target);
            if (child === null) { visiting.delete(stateId); return null; }
            edgeSig = 'J(' + child + ')';
        } else {
            const left = signature(info.onTrue);
            const right = signature(info.onFalse);
            if (left === null || right === null) { visiting.delete(stateId); return null; }
            edgeSig = 'B(' + left + ',' + right + ')';
        }
        visiting.delete(stateId);
        const value = opSig + '|' + edgeSig;
        memo.set(stateId, value);
        return value;
    }
    return signature(entryId);
}

function findDuplicatedRepeatConditionRegion(graph, repeatMatch) {
    if (!repeatMatch || repeatMatch.removedCompilerConditionOperationCount !== 0) return null;
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const bodyIds = new Set(repeatMatch.bodyStateIds || []);
    const realCandidates = [];

    for (const realEntryId of bodyIds) {
        if (realEntryId === repeatMatch.bodyId) continue;
        const region = collectAcyclicRegionToExit(stateById, predecessors, realEntryId, repeatMatch.checkId);
        if (!region || [...region.ids].some(id => !bodyIds.has(id))) continue;
        const incoming = predecessors.get(realEntryId) || [];
        if (!incoming.some(id => bodyIds.has(id) && !region.ids.has(id))) continue;
        const signature = conditionRegionSignature(stateById, region, realEntryId, repeatMatch.checkId, 0);
        if (signature) realCandidates.push({ realEntryId, region, signature });
    }
    if (!realCandidates.length) return null;

    const excluded = new Set([repeatMatch.checkId, repeatMatch.exitId, ...bodyIds]);
    const matches = [];
    for (const preEntry of states) {
        if (excluded.has(preEntry.id) || preEntry.id === repeatMatch.preheaderId) continue;
        const region = collectAcyclicRegionToExit(stateById, predecessors, preEntry.id, repeatMatch.preheaderId);
        if (!region || [...region.ids].some(id => excluded.has(id))) continue;
        const incoming = predecessors.get(preEntry.id) || [];
        if (!incoming.some(id => !region.ids.has(id))) continue;
        const nonTransitions = (preEntry.operations || []).filter(operation => operation?.kind !== 'state-transition');
        for (let startIndex = 0; startIndex < nonTransitions.length; startIndex++) {
            const preSignature = conditionRegionSignature(stateById, region, preEntry.id, repeatMatch.preheaderId, startIndex);
            if (!preSignature) continue;
            for (const real of realCandidates) {
                if (preSignature === real.signature) {
                    matches.push({ preEntryId: preEntry.id, preRegion: region, entryStartIndex: startIndex, realEntryId: real.realEntryId });
                }
            }
        }
    }
    return matches.length === 1 ? matches[0] : null;
}

function removeDuplicatedRepeatConditionRegions(graph) {
    let working = {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(state.predecessors || [])],
            successors: [...(state.successors || [])],
            operations: [...(state.operations || [])],
        })),
    };
    let removedRegionCount = 0;
    let removedStateCount = 0;

    while (true) {
        let found = null;
        for (const state of working.states) {
            const repeatMatch = matchCompilerRepeat(working, state.id);
            if (!repeatMatch) continue;
            const duplicate = findDuplicatedRepeatConditionRegion(working, repeatMatch);
            if (duplicate) { found = { repeatMatch, duplicate }; break; }
        }
        if (!found) break;

        const { repeatMatch, duplicate } = found;
        const preEntry = working.states.find(state => state.id === duplicate.preEntryId);
        if (!preEntry) break;
        const nonTransitions = (preEntry.operations || []).filter(operation => operation?.kind !== 'state-transition');
        const firstRemovedOperation = nonTransitions[duplicate.entryStartIndex];
        const firstRemovedIndex = preEntry.operations.indexOf(firstRemovedOperation);
        if (firstRemovedIndex < 0) break;
        const retainedPrefix = preEntry.operations.slice(0, firstRemovedIndex);
        const stateName = working.stateName || 'state';
        const directBodyTransition = {
            kind: 'state-transition',
            emittedTarget: stateName,
            rhs: String(repeatMatch.bodyId),
            emittedText: stateName + ' = ' + repeatMatch.bodyId,
            reads: [],
        };
        const removedIds = new Set([...duplicate.preRegion.ids, repeatMatch.preheaderId]);
        removedIds.delete(duplicate.preEntryId);
        working = {
            ...working,
            states: working.states.filter(state => !removedIds.has(state.id)).map(state => {
                if (state.id !== duplicate.preEntryId) return state;
                return {
                    ...state,
                    operations: [...retainedPrefix, directBodyTransition],
                    successors: [repeatMatch.bodyId],
                };
            }),
        };
        working = rebuildGraphPredecessors(working);
        removedRegionCount++;
        removedStateCount += removedIds.size;
    }
    return { graph: working, removedRegionCount, removedStateCount };
}

function computeStronglyConnectedComponents(states) {
    const stateById = new Map((states || []).map(state => [state.id, state]));
    let nextIndex = 0;
    const indexById = new Map();
    const lowById = new Map();
    const stack = [];
    const onStack = new Set();
    const components = [];

    function visit(stateId) {
        indexById.set(stateId, nextIndex);
        lowById.set(stateId, nextIndex);
        nextIndex++;
        stack.push(stateId);
        onStack.add(stateId);
        const state = stateById.get(stateId);
        for (const successor of state?.successors || []) {
            if (!stateById.has(successor)) continue;
            if (!indexById.has(successor)) {
                visit(successor);
                lowById.set(stateId, Math.min(lowById.get(stateId), lowById.get(successor)));
            } else if (onStack.has(successor)) {
                lowById.set(stateId, Math.min(lowById.get(stateId), indexById.get(successor)));
            }
        }
        if (lowById.get(stateId) !== indexById.get(stateId)) return;
        const component = [];
        while (stack.length) {
            const current = stack.pop();
            onStack.delete(current);
            component.push(current);
            if (current === stateId) break;
        }
        components.push(component);
    }

    for (const state of states || []) if (!indexById.has(state.id)) visit(state.id);
    return components;
}


function compilerConditionEvaluationOperations(state) {
    return (state?.operations || []).filter(operation => {
        if (operation?.kind === 'state-transition') return false;
        if (originalOperationTarget(operation) !== 'ReturnVal' || operation?.returnSinkSafe !== true) return true;
        const expression = parseOperationExpression(operation);
        return expression?.type !== 'Identifier';
    });
}

function topologicalRegionOrder(stateById, ids, entryId) {
    const indegree = new Map([...ids].map(id => [id, 0]));
    for (const id of ids) {
        for (const successor of stateById.get(id)?.successors || []) {
            if (ids.has(successor)) indegree.set(successor, indegree.get(successor) + 1);
        }
    }
    if (indegree.get(entryId) !== 0) return null;
    const queue = [entryId];
    const queued = new Set(queue);
    const order = [];
    for (let cursor = 0; cursor < queue.length; cursor++) {
        const id = queue[cursor];
        order.push(id);
        for (const successor of stateById.get(id)?.successors || []) {
            if (!ids.has(successor)) continue;
            indegree.set(successor, indegree.get(successor) - 1);
            if (indegree.get(successor) === 0 && !queued.has(successor)) {
                queued.add(successor);
                queue.push(successor);
            }
        }
    }
    return order.length === ids.size ? order : null;
}

function compilerConditionRegionSignature(stateById, ids, entryId, entryStartIndex = 0) {
    const order = topologicalRegionOrder(stateById, ids, entryId);
    if (!order) return null;
    const operations = [];
    for (const id of order) {
        const stateOperations = compilerConditionEvaluationOperations(stateById.get(id));
        operations.push(...(id === entryId ? stateOperations.slice(entryStartIndex) : stateOperations));
    }
    if (!operations.length) return null;
    const operationSignature = canonicalCompilerOperationSequence(operations);
    if (!operationSignature) return null;
    const indexById = new Map(order.map((id, index) => [id, index]));
    const internalEdges = [];
    for (const id of order) {
        for (const successor of stateById.get(id)?.successors || []) {
            if (!ids.has(successor)) continue;
            internalEdges.push([indexById.get(id), indexById.get(successor)]);
        }
    }
    internalEdges.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    return JSON.stringify({ operationSignature, internalEdges });
}

function findDuplicateControlRepeatCondition(graph, repeatShape) {
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const realIds = new Set(repeatShape.conditionStateIds || []);
    const realSignature = compilerConditionRegionSignature(stateById, realIds, repeatShape.conditionEntryId, 0);
    if (!realSignature) return null;
    const excluded = new Set([repeatShape.exitId, ...repeatShape.bodyStateIds, ...repeatShape.conditionStateIds]);
    const candidates = [];

    for (const state of states) {
        if (excluded.has(state.id) || state.id === repeatShape.preheaderId) continue;
        const region = collectAcyclicRegionToExit(stateById, predecessors, state.id, repeatShape.preheaderId);
        if (!region || [...region.ids].some(id => excluded.has(id))) continue;
        const entryOps = compilerConditionEvaluationOperations(state);
        for (let startIndex = 0; startIndex < entryOps.length; startIndex++) {
            const signature = compilerConditionRegionSignature(stateById, region.ids, state.id, startIndex);
            if (signature !== realSignature) continue;
            const firstRemovedOperation = entryOps[startIndex];
            const firstRemovedIndex = (state.operations || []).indexOf(firstRemovedOperation);
            if (firstRemovedIndex < 0) continue;
            candidates.push({
                entryId: state.id,
                regionIds: [...region.ids],
                retainedPrefix: state.operations.slice(0, firstRemovedIndex),
                removedOperationCount: state.operations.length - firstRemovedIndex + [...region.ids].filter(id => id !== state.id).reduce((total, id) => total + (stateById.get(id)?.operations || []).length, 0),
            });
        }
    }
    return candidates.length === 1 ? candidates[0] : null;
}

function matchCompilerRepeatConditionRegion(graph) {
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const matches = [];

    for (const component of computeStronglyConnectedComponents(states)) {
        const componentIds = new Set(component);
        const cyclic = component.length > 1 || (component.length === 1 && (stateById.get(component[0])?.successors || []).includes(component[0]));
        if (!cyclic) continue;

        const incomingEdges = [];
        const outgoingEdges = [];
        for (const stateId of component) {
            for (const predecessor of predecessors.get(stateId) || []) {
                if (!componentIds.has(predecessor)) incomingEdges.push({ predecessor, target: stateId });
            }
            for (const successor of stateById.get(stateId)?.successors || []) {
                if (!componentIds.has(successor)) outgoingEdges.push({ source: stateId, target: successor });
            }
        }
        const incomingTargets = [...new Set(incomingEdges.map(edge => edge.target))];
        const incomingPreds = [...new Set(incomingEdges.map(edge => edge.predecessor))];
        const exitTargets = [...new Set(outgoingEdges.map(edge => edge.target))];
        if (incomingTargets.length !== 1 || incomingPreds.length !== 1 || exitTargets.length !== 1) continue;
        const bodyId = incomingTargets[0];
        const preheaderId = incomingPreds[0];
        const exitId = exitTargets[0];
        if (!stateById.has(exitId)) continue;
        const preheader = stateById.get(preheaderId);
        if (!preheader || !Array.isArray(preheader.successors) || preheader.successors.length !== 1 || preheader.successors[0] !== bodyId) continue;
        const preTransitionInfo = transitionInfo(preheader);
        if (preTransitionInfo.error || preTransitionInfo.kind !== 'jump' || preTransitionInfo.target !== bodyId) continue;
        if (!canCanonicalizeTransitionTail(preheader, preTransitionInfo)) continue;

        for (const conditionEntryId of component) {
            if (conditionEntryId === bodyId) continue;
            const conditionRegion = collectLoopBodyRegion(stateById, predecessors, conditionEntryId, bodyId, exitId, null);
            if (!conditionRegion) continue;
            if ([...conditionRegion.ids].some(id => !componentIds.has(id))) continue;
            const expectedBodyIncoming = [preheaderId, ...conditionRegion.latchIds];
            const bodyRegion = collectLoopBodyRegion(stateById, predecessors, bodyId, conditionEntryId, exitId, expectedBodyIncoming);
            if (!bodyRegion) continue;
            if ([...bodyRegion.ids].some(id => !componentIds.has(id))) continue;
            const union = new Set([...conditionRegion.ids, ...bodyRegion.ids]);
            if (!sameMembers([...union], component)) continue;
            const conditionIncoming = predecessors.get(conditionEntryId) || [];
            if (!sameMembers(conditionIncoming, [...bodyRegion.latchIds])) continue;

            const conditionStructured = structureLoopBodyRegion(
                stateById,
                conditionRegion,
                conditionEntryId,
                bodyId,
                new Set(),
                null,
                exitId,
                true
            );
            if (!conditionStructured) continue;
            const bodyStructured = structureLoopBodyRegion(
                stateById,
                bodyRegion,
                bodyId,
                conditionEntryId,
                new Set(),
                null,
                exitId,
                false
            );
            if (!bodyStructured) continue;

            const shape = {
                preheaderId,
                conditionEntryId,
                conditionStateIds: [...conditionRegion.ids],
                bodyId,
                bodyStateIds: [...bodyRegion.ids],
                exitId,
            };
            const duplicate = findDuplicateControlRepeatCondition(graph, shape);
            if (!duplicate) continue;
            const duplicateRemovedIds = new Set([...duplicate.regionIds, preheaderId]);
            duplicateRemovedIds.delete(duplicate.entryId);
            matches.push({
                preheaderId: duplicate.entryId,
                checkId: conditionEntryId,
                bodyId,
                bodyStateIds: [...union],
                exitId,
                condition: 'false',
                conditionReads: [],
                conditionNodes: conditionStructured.nodes,
                bodyNodes: bodyStructured.nodes,
                bodyBranchCount: (bodyStructured.branchCount || 0) + (conditionStructured.branchCount || 0),
                bodyJoinCount: (bodyStructured.joinCount || 0) + (conditionStructured.joinCount || 0),
                retainedPreheaderOperations: duplicate.retainedPrefix,
                removedCompilerConditionOperationCount: duplicate.removedOperationCount,
                removeStateIds: [...union, ...duplicateRemovedIds],
                controlConditionRegion: true,
                conditionStateIds: [...conditionRegion.ids],
            });
        }
    }
    const maximal = matches.filter(candidate => {
        const candidateIds = new Set(candidate.conditionStateIds || []);
        return !matches.some(other => {
            if (other === candidate) return false;
            const otherIds = new Set(other.conditionStateIds || []);
            return otherIds.size > candidateIds.size && [...candidateIds].every(id => otherIds.has(id));
        });
    });
    return maximal.length === 1 ? maximal[0] : null;
}

function matchCompilerRepeat(graph, checkStateId) {
    const states = graph.states || [];
    const stateById = new Map(states.map(state => [state.id, state]));
    const predecessors = computeGraphPredecessors(states);
    const check = stateById.get(checkStateId);
    if (!check || !Array.isArray(check.successors) || check.successors.length !== 2) return null;
    if (hasUnsafeUnsupportedOperation(check.operations || [])) return null;

    const checkInfo = transitionInfo(check);
    if (checkInfo.error || checkInfo.kind !== 'branch') return null;
    const transitionIndex = check.operations.indexOf(checkInfo.operation);
    if (transitionIndex !== check.operations.length - 1) return null;

    // Local WeAreDevs RepeatStatement lowering is post-test: condition true exits,
    // condition false jumps back to the body entry.
    const exitId = checkInfo.onTrue;
    const bodyId = checkInfo.onFalse;
    if (!stateById.has(bodyId) || !stateById.has(exitId)) return null;

    const region = collectRepeatBodyRegion(stateById, predecessors, bodyId, check.id, exitId);
    if (!region) return null;
    const preheader = stateById.get(region.preheaderId);
    if (!preheader || !Array.isArray(preheader.successors) || preheader.successors.length !== 1 || preheader.successors[0] !== bodyId) return null;
    if (hasUnsafeUnsupportedOperation(preheader.operations || [])) return null;

    const preOps = preheader.operations || [];
    const preTransitionIndex = preOps.findLastIndex(operation => operation?.kind === 'state-transition');
    if (preTransitionIndex !== preOps.length - 1) return null;
    const preTransition = preOps[preTransitionIndex];
    if (directNumericOperationValue({ expression: parseOperationExpression(preTransition) }) !== bodyId) return null;

    const conditionOperations = (check.operations || []).filter(operation => operation !== checkInfo.operation);
    if (conditionOperations.some(operation => !operationText(operation))) return null;

    // Prometheus compileStatement(RepeatStatement) compiles the same condition once
    // in the preheader, discards its result, then compiles it again in the real check.
    // Restore source semantics by removing that compiler-added first evaluation.
    const preBodyOperations = preOps.slice(0, preTransitionIndex);
    const junkSlice = findUniqueCompilerOperationSlice(preBodyOperations, conditionOperations);
    if (!junkSlice) return null;
    const retainedPreheaderOperations = preBodyOperations.filter(operation => !junkSlice.operations.has(operation));

    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, new Set(), null, exitId, false);
    if (!structuredBody) return null;

    return {
        preheaderId: preheader.id,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        condition: checkInfo.condition,
        conditionReads: checkInfo.conditionReads,
        conditionNodes: conditionOperations.map(operation => operationNode(operation, check.id)),
        bodyNodes: structuredBody.nodes,
        bodyBranchCount: structuredBody.branchCount,
        bodyJoinCount: structuredBody.joinCount,
        retainedPreheaderOperations,
        removedCompilerConditionOperationCount: junkSlice.operations.size,
    };
}

function collapseCompilerRepeatLoops(graph) {
    let working = {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(state.predecessors || [])],
            successors: [...(state.successors || [])],
            operations: [...(state.operations || [])],
        })),
    };
    let loopCount = 0;
    let bodyBranchCount = 0;
    let bodyJoinCount = 0;
    let removedCompilerConditionOperationCount = 0;

    while (true) {
        let match = null;
        for (const state of working.states) {
            match = matchCompilerRepeat(working, state.id);
            if (match) break;
        }
        if (!match) match = matchCompilerRepeatConditionRegion(working);
        if (!match) break;

        const loopNode = repeatUntilNode(match.condition, match.conditionReads, match.bodyNodes, match.conditionNodes);
        const structuredOperation = {
            kind: 'structured-repeat',
            structuredNode: loopNode,
            emittedText: formatStructuredNodes([loopNode]),
            reads: [],
            returnSinkSafe: false,
        };
        const stateName = graph.stateName || 'state';
        const syntheticTransition = {
            kind: 'state-transition',
            emittedTarget: stateName,
            rhs: String(match.exitId),
            emittedText: stateName + ' = ' + match.exitId,
            reads: [],
        };

        const removed = new Set(match.removeStateIds || [match.checkId, ...match.bodyStateIds]);
        working = {
            ...working,
            states: working.states.filter(state => !removed.has(state.id)).map(state => {
                if (state.id !== match.preheaderId) return state;
                return {
                    ...state,
                    operations: [...match.retainedPreheaderOperations, structuredOperation, syntheticTransition],
                    successors: [match.exitId],
                };
            }),
        };
        working = rebuildGraphPredecessors(working);
        loopCount++;
        bodyBranchCount += match.bodyBranchCount || 0;
        bodyJoinCount += match.bodyJoinCount || 0;
        removedCompilerConditionOperationCount += match.removedCompilerConditionOperationCount || 0;
    }

    return { graph: working, loopCount, bodyBranchCount, bodyJoinCount, removedCompilerConditionOperationCount };
}

function collapseCompilerStructuredLoops(graph) {
    let working = graph;
    let numericForLoopCount = 0;
    let genericForLoopCount = 0;
    let whileLoopCount = 0;
    let repeatLoopCount = 0;
    let removedRepeatCompilerConditionOperationCount = 0;
    let removedRepeatCompilerConditionRegionCount = 0;
    let removedRepeatCompilerConditionStateCount = 0;
    let bodyBranchCount = 0;
    let bodyJoinCount = 0;

    while (true) {
        const numeric = collapseCompilerNumericForLoops(working);
        working = numeric.graph;
        numericForLoopCount += numeric.loopCount;
        bodyBranchCount += numeric.bodyBranchCount || 0;
        bodyJoinCount += numeric.bodyJoinCount || 0;

        const generic = collapseCompilerGenericForLoops(working);
        working = generic.graph;
        genericForLoopCount += generic.loopCount;
        bodyBranchCount += generic.bodyBranchCount || 0;
        bodyJoinCount += generic.bodyJoinCount || 0;

        const whiles = collapseCompilerWhileLoops(working);
        working = whiles.graph;
        whileLoopCount += whiles.loopCount;
        bodyBranchCount += whiles.bodyBranchCount || 0;
        bodyJoinCount += whiles.bodyJoinCount || 0;

        const repeatJunk = removeDuplicatedRepeatConditionRegions(working);
        working = repeatJunk.graph;
        removedRepeatCompilerConditionRegionCount += repeatJunk.removedRegionCount || 0;
        removedRepeatCompilerConditionStateCount += repeatJunk.removedStateCount || 0;

        const repeats = collapseCompilerRepeatLoops(working);
        working = repeats.graph;
        repeatLoopCount += repeats.loopCount;
        removedRepeatCompilerConditionOperationCount += repeats.removedCompilerConditionOperationCount || 0;
        bodyBranchCount += repeats.bodyBranchCount || 0;
        bodyJoinCount += repeats.bodyJoinCount || 0;

        if (numeric.loopCount === 0 && generic.loopCount === 0 && whiles.loopCount === 0 && repeats.loopCount === 0) break;
    }

    return {
        graph: working,
        numericForLoopCount,
        genericForLoopCount,
        whileLoopCount,
        repeatLoopCount,
        removedRepeatCompilerConditionOperationCount,
        removedRepeatCompilerConditionRegionCount,
        removedRepeatCompilerConditionStateCount,
        bodyBranchCount,
        bodyJoinCount,
    };
}

function rebuildGraphPredecessors(graph) {
    const predecessors = computeGraphPredecessors(graph.states || []);
    return {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(predecessors.get(state.id) || [])],
        })),
    };
}

function collapseCompilerNumericForLoops(graph) {
    let working = {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(state.predecessors || [])],
            successors: [...(state.successors || [])],
            operations: [...(state.operations || [])],
        })),
    };
    let loopCount = 0;
    let bodyBranchCount = 0;
    let bodyJoinCount = 0;

    while (true) {
        let match = null;
        for (const state of working.states) {
            match = matchCompilerNumericFor(working, state.id);
            if (match) break;
        }
        if (!match) break;

        const bodyNodes = match.bodyNodes;
        const loopNode = numericForNode(
            match.loopVariable,
            match.startName,
            match.finalName,
            match.stepName,
            bodyNodes,
            [match.startName, match.finalName, match.stepName]
        );
        const structuredOperation = {
            kind: "structured-numeric-for",
            structuredNode: loopNode,
            emittedText: formatStructuredNodes([loopNode]),
            reads: [match.startName, match.finalName, match.stepName],
            returnSinkSafe: false,
        };
        const stateName = graph.stateName || "state";
        const syntheticTransition = {
            kind: "state-transition",
            emittedTarget: stateName,
            rhs: String(match.exitId),
            emittedText: `${stateName} = ${match.exitId}`,
            reads: [],
        };

        const removed = new Set([match.checkId, ...match.bodyStateIds]);
        working = {
            ...working,
            states: working.states.filter(state => !removed.has(state.id)).map(state => {
                if (state.id !== match.preheaderId) return state;
                return {
                    ...state,
                    operations: [...match.retainedPreheaderOperations, structuredOperation, syntheticTransition],
                    successors: [match.exitId],
                };
            }),
        };
        working = rebuildGraphPredecessors(working);
        loopCount++;
        bodyBranchCount += match.bodyBranchCount || 0;
        bodyJoinCount += match.bodyJoinCount || 0;
    }

    return { graph: working, loopCount, bodyBranchCount, bodyJoinCount };
}

function collapseCompilerGenericForLoops(graph) {
    let working = {
        ...graph,
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: [...(state.predecessors || [])],
            successors: [...(state.successors || [])],
            operations: [...(state.operations || [])],
        })),
    };
    let loopCount = 0;
    let bodyBranchCount = 0;
    let bodyJoinCount = 0;

    while (true) {
        let match = null;
        for (const state of working.states) {
            match = matchCompilerGenericFor(working, state.id);
            if (match) break;
        }
        if (!match) break;

        const loopNode = genericForNode(match.loopVariables, match.iteratorExpressions, match.bodyNodes, match.iteratorExpressions);
        const structuredOperation = {
            kind: "structured-generic-for",
            structuredNode: loopNode,
            emittedText: formatStructuredNodes([loopNode]),
            reads: [...match.iteratorExpressions],
            returnSinkSafe: false,
        };
        const stateName = graph.stateName || "state";
        const syntheticTransition = {
            kind: "state-transition",
            emittedTarget: stateName,
            rhs: String(match.exitId),
            emittedText: `${stateName} = ${match.exitId}`,
            reads: [],
        };
        const removed = new Set([match.checkId, ...match.bodyStateIds]);
        working = {
            ...working,
            states: working.states.filter(state => !removed.has(state.id)).map(state => {
                if (state.id !== match.preheaderId) return state;
                return {
                    ...state,
                    operations: [...match.retainedPreheaderOperations, structuredOperation, syntheticTransition],
                    successors: [match.exitId],
                };
            }),
        };
        working = rebuildGraphPredecessors(working);
        loopCount++;
        bodyBranchCount += match.bodyBranchCount || 0;
        bodyJoinCount += match.bodyJoinCount || 0;
    }
    return { graph: working, loopCount, bodyBranchCount, bodyJoinCount };
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
        if (hasUnsafeUnsupportedOperation(state.operations)) {
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

    const reachableSets = computeReachableStateSets(states, stateById);
    if (!reachableSets) {
        return { applied: false, reason: "Beta CF reachability analysis failed on the acyclic graph" };
    }

    const emittedStates = new Set();
    let branchCount = 0;
    let joinCount = 0;
    let guardBranchCount = 0;

    function emitBranchNode(nodes, info, trueResult, falseResult) {
        const trueReachesJoin = trueResult.reachesStop === true;
        const falseReachesJoin = falseResult.reachesStop === true;

        if (trueReachesJoin && falseReachesJoin) {
            if (trueResult.nodes.length && falseResult.nodes.length) {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes, falseResult.nodes));
            } else if (trueResult.nodes.length) {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes));
            } else if (falseResult.nodes.length) {
                nodes.push(ifNode("not (" + info.condition + ")", info.conditionReads, falseResult.nodes));
            }
            return;
        }

        if (!trueReachesJoin && falseReachesJoin) {
            if (falseResult.nodes.length) {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes, falseResult.nodes));
            } else {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes));
            }
            guardBranchCount++;
            return;
        }

        if (trueReachesJoin && !falseReachesJoin) {
            if (trueResult.nodes.length) {
                nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes, falseResult.nodes));
            } else {
                nodes.push(ifNode("not (" + info.condition + ")", info.conditionReads, falseResult.nodes));
            }
            guardBranchCount++;
            return;
        }

        nodes.push(ifNode(info.condition, info.conditionReads, trueResult.nodes));
        nodes.push(...falseResult.nodes);
        guardBranchCount++;
    }

    function emitSequence(startState, stopState) {
        const nodes = [];
        let current = startState;

        while (current !== stopState && current !== exitNode) {
            if (emittedStates.has(current)) {
                throw new Error("State " + current + " would be emitted more than once; CFG is not structurally reducible by the acyclic stage");
            }
            const item = prepared.get(current);
            if (!item) throw new Error("Missing prepared state " + current);
            emittedStates.add(current);
            for (const operation of item.bodyOperations) nodes.push(operationNode(operation, current));

            const info = item.info;
            if (info.kind === "return") return { nodes, reachesStop: false };
            if (info.kind === "jump") {
                current = info.target;
                continue;
            }
            if (info.kind !== "branch") throw new Error("Unsupported prepared terminator in state " + current);

            branchCount++;
            if (info.onTrue === info.onFalse) {
                current = info.onTrue;
                continue;
            }

            let join = immediatePostdominator(current, postdominators);
            if (
                join === exitNode ||
                (join !== null &&
                    stopState !== exitNode &&
                    join !== stopState &&
                    !reachesState(join, stopState, reachableSets))
            ) {
                join = null;
            }

            if (join === null) {
                const partial = earliestCommonReachableJoin(
                    info.onTrue,
                    info.onFalse,
                    stopState,
                    exitNode,
                    reachableSets
                );
                if (partial.ambiguous) {
                    throw new Error("State " + current + " has multiple incomparable branch continuations");
                }
                join = partial.join;
            }

            if (join !== null && join !== exitNode) {
                joinCount++;
                const trueResult = info.onTrue === join
                    ? { nodes: [], reachesStop: true }
                    : emitSequence(info.onTrue, join);
                const falseResult = info.onFalse === join
                    ? { nodes: [], reachesStop: true }
                    : emitSequence(info.onFalse, join);

                if (!trueResult.reachesStop && !falseResult.reachesStop) {
                    throw new Error("State " + current + " branch continuation " + join + " is unreachable after its terminating arms");
                }

                emitBranchNode(nodes, info, trueResult, falseResult);
                current = join;
                continue;
            }

            const trueResult = emitSequence(info.onTrue, stopState);
            const falseResult = emitSequence(info.onFalse, stopState);

            if (trueResult.reachesStop || falseResult.reachesStop) {
                throw new Error("State " + current + " reaches its surrounding continuation without a unique join");
            }

            emitBranchNode(nodes, info, trueResult, falseResult);
            return { nodes, reachesStop: false };
        }

        return { nodes, reachesStop: true };
    }

    let structured;
    try {
        structured = emitSequence(entry, exitNode);
    } catch (error) {
        return { applied: false, reason: error.message };
    }
    if (structured.reachesStop) {
        return { applied: false, reason: "The acyclic entry region reaches function exit without a proven return" };
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


function parseClosureFactoryCall(rhs) {
    const parsed = parseTransitionExpression(rhs);
    const expression = parsed?.expression;
    if (expression?.type !== "CallExpression" || !isIdentifier(expression.base)) return null;
    if (!/^createClosure(?:\d+)?$/.test(expression.base.name)) return null;
    const args = expression.arguments || [];
    const entry = numericValue(args[0]);
    const captures = args[1];
    if (entry === null || captures?.type !== "TableConstructorExpression") return null;
    return {
        factoryName: expression.base.name,
        entry,
        captureCount: (captures.fields || []).length,
    };
}

function partitionClosureRegions(graph) {
    const entries = [...graph.entries];
    const entrySet = new Set(entries);
    const stateById = new Map(graph.states.map(state => [state.id, state]));
    const ownerByState = new Map();

    for (const entry of entries) {
        const stack = [entry];
        const visited = new Set();
        while (stack.length) {
            const stateId = stack.pop();
            if (visited.has(stateId)) continue;
            visited.add(stateId);
            const state = stateById.get(stateId);
            if (!state) return { error: `Closure entry ${entry} reaches missing state ${stateId}` };

            if (stateId !== entry && entrySet.has(stateId)) {
                return { error: `Closure entry ${entry} transitions into separate closure entry ${stateId}` };
            }

            const owner = ownerByState.get(stateId);
            if (owner !== undefined && owner !== entry) {
                return { error: `State ${stateId} is reachable from closure entries ${owner} and ${entry}` };
            }
            ownerByState.set(stateId, entry);

            for (const successor of state.successors || []) stack.push(successor);
        }
    }

    if (ownerByState.size !== graph.states.length) {
        return { error: `Closure-region recovery owns ${ownerByState.size}/${graph.states.length} states` };
    }

    return { ownerByState, stateById };
}

function collectClosureFactorySites(graph, ownerByState) {
    const entrySet = new Set(graph.entries);
    const sites = [];
    for (const state of graph.states) {
        const parentEntry = ownerByState.get(state.id);
        for (const operation of state.operations || []) {
            const call = parseClosureFactoryCall(operation.rhs);
            if (!call || !entrySet.has(call.entry)) continue;
            sites.push({
                stateId: state.id,
                parentEntry,
                operation,
                ...call,
            });
        }
    }
    return sites;
}

function closureSolveOrder(entries, childEntriesByParent) {
    const order = [];
    const visiting = new Set();
    const visited = new Set();

    function visit(entry) {
        if (visited.has(entry)) return null;
        if (visiting.has(entry)) return `Closure-entry dependency cycle includes ${entry}`;
        visiting.add(entry);
        for (const child of childEntriesByParent.get(entry) || []) {
            const error = visit(child);
            if (error) return error;
        }
        visiting.delete(entry);
        visited.add(entry);
        order.push(entry);
        return null;
    }

    for (const entry of entries) {
        const error = visit(entry);
        if (error) return { error };
    }
    return { order };
}

function presentedBody(source) {
    const marker = "\n\n--body\n\n";
    const index = String(source).indexOf(marker);
    if (index < 0) return null;
    return String(source).slice(index + marker.length).trimEnd();
}

function nestedFunctionExpression(bodyText) {
    const body = String(bodyText || "").trim();
    const lines = [
        "function(...)",
        "    --headers",
        "",
        "    local args = { ... }",
        "",
        "    --body",
    ];
    if (body) lines.push("", indentText(body, 1));
    lines.push("end");
    return lines.join("\n");
}

function replaceClosureFactoryOperation(operation, functionExpression) {
    const text = String(operationText(operation) || "").trimStart();
    const target = operation?.emittedTarget;
    if (!target) return null;
    const localPrefix = text.startsWith("local ") ? "local " : "";
    return {
        ...operation,
        rhs: functionExpression,
        emittedText: `${localPrefix}${target} = ${functionExpression}`,
        reads: [],
        returnSinkSafe: false,
    };
}

function regionGraph(graph, entry, ownerByState, solvedBodies) {
    const states = [];
    for (const state of graph.states) {
        if (ownerByState.get(state.id) !== entry) continue;
        const operations = [];
        for (const operation of state.operations || []) {
            const call = parseClosureFactoryCall(operation.rhs);
            if (call && solvedBodies.has(call.entry)) {
                if (call.captureCount !== 0) {
                    return { error: `Closure entry ${call.entry} has ${call.captureCount} capture value(s); capture reconstruction is not implemented` };
                }
                const replacement = replaceClosureFactoryOperation(
                    operation,
                    nestedFunctionExpression(solvedBodies.get(call.entry))
                );
                if (!replacement) {
                    return { error: `Closure factory for entry ${call.entry} has no replaceable beta assignment target` };
                }
                operations.push(replacement);
            } else {
                operations.push({ ...operation });
            }
        }
        const predecessors = (state.predecessors || []).filter(id => ownerByState.get(id) === entry);
        const successors = [...(state.successors || [])];
        if (successors.some(id => ownerByState.get(id) !== entry)) {
            return { error: `Closure entry ${entry} has a CFG edge into another closure region` };
        }
        states.push({ ...state, predecessors, successors, operations });
    }
    return {
        graph: {
            ...graph,
            entries: [entry],
            states,
        },
    };
}

function solveSingleEntryControlFlow(originalAst, graph) {
    if (graph.entries.length !== 1) {
        return { applied: false, reason: "Internal beta CF region must have exactly one entry" };
    }
    if (graph.states.length === 1) return {
        ...solveSingleState(originalAst, graph),
        numericForLoopCount: 0,
        genericForLoopCount: 0,
        whileLoopCount: 0,
        repeatLoopCount: 0,
        removedRepeatCompilerConditionOperationCount: 0,
        removedRepeatCompilerConditionRegionCount: 0,
        removedRepeatCompilerConditionStateCount: 0,
        forwardedControlJoinCount: 0,
    };

    const forwarded = forwardControlOnlyJoinBranches(graph);
    const collapsed = collapseCompilerStructuredLoops(forwarded.graph);
    const solved = solveAcyclicStructured(originalAst, collapsed.graph);
    if (!solved.applied) return solved;
    return {
        ...solved,
        stateCount: graph.states.length,
        branchCount: (solved.branchCount || 0) + (collapsed.bodyBranchCount || 0),
        joinCount: (solved.joinCount || 0) + (collapsed.bodyJoinCount || 0),
        numericForLoopCount: collapsed.numericForLoopCount,
        genericForLoopCount: collapsed.genericForLoopCount,
        whileLoopCount: collapsed.whileLoopCount,
        repeatLoopCount: collapsed.repeatLoopCount,
        removedRepeatCompilerConditionOperationCount: collapsed.removedRepeatCompilerConditionOperationCount,
        removedRepeatCompilerConditionRegionCount: collapsed.removedRepeatCompilerConditionRegionCount,
        removedRepeatCompilerConditionStateCount: collapsed.removedRepeatCompilerConditionStateCount,
        forwardedControlJoinCount: forwarded.forwardedCount,
    };
}

function solveClosureRegions(originalAst, graph) {
    const partition = partitionClosureRegions(graph);
    if (partition.error) return { applied: false, reason: partition.error };

    const sites = collectClosureFactorySites(graph, partition.ownerByState);
    const referencedEntries = new Set(sites.map(site => site.entry));
    const rootEntries = graph.entries.filter(entry => !referencedEntries.has(entry));
    if (rootEntries.length !== 1) {
        return {
            applied: false,
            reason: `Beta closure solving requires one root entry (found ${rootEntries.length})`,
        };
    }
    const rootEntry = rootEntries[0];

    const childEntriesByParent = new Map(graph.entries.map(entry => [entry, new Set()]));
    const parentByChildEntry = new Map();
    for (const site of sites) {
        if (site.parentEntry === undefined) {
            return { applied: false, reason: `Closure factory for entry ${site.entry} is outside an owned state region` };
        }
        const priorParent = parentByChildEntry.get(site.entry);
        if (priorParent !== undefined && priorParent !== site.parentEntry) {
            return { applied: false, reason: `Closure entry ${site.entry} has multiple structural parents (${priorParent}, ${site.parentEntry})` };
        }
        parentByChildEntry.set(site.entry, site.parentEntry);
        if (site.captureCount !== 0) {
            return {
                applied: false,
                reason: `Closure entry ${site.entry} has ${site.captureCount} capture value(s); capture reconstruction is not implemented`,
            };
        }
        childEntriesByParent.get(site.parentEntry).add(site.entry);
    }

    for (const entry of graph.entries) {
        if (entry === rootEntry) continue;
        if (!referencedEntries.has(entry)) {
            return { applied: false, reason: `Closure entry ${entry} has no structurally proven parent factory call` };
        }
    }

    const ordered = closureSolveOrder(graph.entries, childEntriesByParent);
    if (ordered.error) return { applied: false, reason: ordered.error };

    const solvedBodies = new Map();
    const solvedResults = new Map();

    for (const entry of ordered.order) {
        const region = regionGraph(graph, entry, partition.ownerByState, solvedBodies);
        if (region.error) return { applied: false, reason: region.error };
        const solved = solveSingleEntryControlFlow(originalAst, region.graph);
        if (!solved.applied) {
            return { applied: false, reason: `Closure entry ${entry}: ${solved.reason}` };
        }
        if (entry !== rootEntry && solved.terminalReturnLowered !== true) {
            return {
                applied: false,
                reason: `Closure entry ${entry}: terminal VM return was not fully lowered; refusing to embed a nested function that could change return semantics`,
            };
        }
        const bodyText = presentedBody(solved.source);
        if (bodyText === null) {
            return { applied: false, reason: `Closure entry ${entry} produced no structured body section` };
        }
        solvedBodies.set(entry, bodyText);
        solvedResults.set(entry, solved);
    }

    const rootResult = solvedResults.get(rootEntry);
    if (!rootResult) return { applied: false, reason: "Root closure entry was not solved" };

    const results = [...solvedResults.values()];
    const sum = key => results.reduce((total, result) => total + (result[key] || 0), 0);

    return {
        ...rootResult,
        mode: "closure-regions",
        entryState: rootEntry,
        stateCount: graph.states.length,
        statementCount: sum("statementCount"),
        branchCount: sum("branchCount"),
        joinCount: sum("joinCount"),
        guardBranchCount: sum("guardBranchCount"),
        numericForLoopCount: sum("numericForLoopCount"),
        genericForLoopCount: sum("genericForLoopCount"),
        whileLoopCount: sum("whileLoopCount"),
        repeatLoopCount: sum("repeatLoopCount"),
        removedRepeatCompilerConditionOperationCount: sum("removedRepeatCompilerConditionOperationCount"),
        removedRepeatCompilerConditionRegionCount: sum("removedRepeatCompilerConditionRegionCount"),
        removedRepeatCompilerConditionStateCount: sum("removedRepeatCompilerConditionStateCount"),
        forwardedControlJoinCount: sum("forwardedControlJoinCount"),
        terminalReturnCount: sum("terminalReturnCount"),
        terminalReturnPayloadSunk: results.some(result => result.terminalReturnPayloadSunk),
        terminalReturnPayloadSunkCount: sum("terminalReturnPayloadSunkCount"),
        terminalReturnLowered: results.every(result => result.terminalReturnLowered),
        terminalReturnText: null,
        closureRegionCount: graph.entries.length,
        inlinedClosureFactoryCount: sites.length,
    };
}

function solveBetaControlFlow(originalAst, betaResult) {
    if (!betaResult?.graph || !betaResult.applied) {
        return { applied: false, reason: "Beta register analysis is unavailable" };
    }
    const upvalues = recoverBetaUpvalues(betaResult);
    if (!upvalues.safe) {
        return { applied: false, reason: upvalues.reason || "Beta upvalue recovery failed closed" };
    }
    const graph = upvalues.graph;
    if (!graph.cfgComplete) {
        return { applied: false, reason: "Beta CFG is incomplete" };
    }
    const solved = graph.entries.length === 1
        ? solveSingleEntryControlFlow(originalAst, graph)
        : solveClosureRegions(originalAst, graph);
    if (!solved.applied) return solved;
    return {
        ...solved,
        upvalueRecoveryApplied: upvalues.applied,
        recoveredUpvalueCellCount: upvalues.stats?.recoveredCellCount || 0,
        recoveredCaptureCount: upvalues.stats?.captureCount || 0,
        upvalueReadRewriteCount: upvalues.stats?.readRewriteCount || 0,
        upvalueWriteRewriteCount: upvalues.stats?.writeRewriteCount || 0,
        upvalueReleaseRemovalCount: upvalues.stats?.releaseRemovalCount || 0,
    };
}

module.exports = {
    displayEnvironmentProvider,
    sinkTerminalReturnPayload,
    lowerTerminalReturn,
    collapseCompilerNumericForLoops,
    collapseCompilerGenericForLoops,
    collapseCompilerWhileLoops,
    matchCompilerWhileConditionRegion,
    collapseCompilerRepeatLoops,
    matchCompilerRepeatConditionRegion,
    removeDuplicatedRepeatConditionRegions,
    collapseCompilerStructuredLoops,
    forwardControlOnlyJoinBranches,
    solveBetaControlFlow,
};
