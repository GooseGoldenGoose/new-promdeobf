// EXPERIMENTAL FORK: isolated beta-CF overflow-register experiments.
// Keep passes/beta-control-flow.js as the verified production solver.
// New RegisterOverflow strategies should be developed here first.

const luaparse = require("../parser/luaparse");
const { recoverBetaUpvalues } = require("./beta-upvalues");
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

function walk(node, visit) {
    if (!isNode(node)) return true;
    if (visit(node) === false) return false;
    for (const key of Object.keys(node)) {
        if (key === "loc" || key === "range") continue;
        const value = node[key];
        if (Array.isArray(value)) {
            for (const child of value) {
                if (walk(child, visit) === false) return false;
            }
        } else if (isNode(value) && walk(value, visit) === false) {
            return false;
        }
    }
    return true;
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
        if (argument) {
            found = argument;
            return false;
        }
    });
    return found;
}

function expressionContainsCall(node, name) {
    let found = false;
    walk(node, current => {
        if (current.type !== "CallExpression") return;
        if (isIdentifier(current.base, name)) {
            found = true;
            return false;
        }
    });
    return found;
}

function expressionContainsIdentifier(node, name) {
    let found = false;
    walk(node, current => {
        if (isIdentifier(current, name)) {
            found = true;
            return false;
        }
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

function parseControlFlowStatement(text) {
    const source = String(text || "");
    try {
        const ast = luaparse.parse(source, {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
        if ((ast.body || []).length !== 1) return null;
        return { source, statement: ast.body[0] };
    } catch {
        return null;
    }
}

function collectRegisterOverflowSlots(node, slots, edits = null, slotNames = null) {
    let error = null;
    function visit(current) {
        if (!isNode(current) || error) return;
        if (current.type === "IndexExpression" && isIdentifier(current.base, "RegisterOverflow")) {
            const slot = numericValue(current.index);
            if (!Number.isInteger(slot) || slot < 1) {
                error = "RegisterOverflow has a non-static or invalid slot access";
                return;
            }
            slots.add(slot);
            if (edits && slotNames) {
                const field = slotNames.get(slot);
                if (!field) {
                    error = `RegisterOverflow slot ${slot} has no normalized field`;
                    return;
                }
                edits.push({ start: current.range[0], end: current.range[1], replacement: `RegisterOverflow.${field}` });
            }
            visit(current.index);
            return;
        }
        if (isIdentifier(current, "RegisterOverflow")) {
            error = "RegisterOverflow appears outside a proven static numeric slot access";
            return;
        }
        for (const key of Object.keys(current)) {
            const value = current[key];
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }
    visit(node);
    return error;
}

function analyzeRegisterOverflowText(text, expression) {
    const source = String(text || "");
    if (!source.includes("RegisterOverflow")) return { slots: new Set() };
    const parsed = expression ? parseTransitionExpression(source) : parseControlFlowStatement(source);
    const node = expression ? parsed?.expression : parsed?.statement;
    if (!node) return { error: "RegisterOverflow operation could not be structurally reparsed" };
    const slots = new Set();
    const error = collectRegisterOverflowSlots(node, slots);
    return error ? { error } : { slots };
}

function rewriteRegisterOverflowText(text, expression, slotNames) {
    const sourceText = String(text || "");
    if (!sourceText.includes("RegisterOverflow")) return { text: sourceText };
    const parsed = expression ? parseTransitionExpression(sourceText) : parseControlFlowStatement(sourceText);
    const node = expression ? parsed?.expression : parsed?.statement;
    if (!node) return { error: "RegisterOverflow operation could not be structurally reparsed" };
    const slots = new Set();
    const edits = [];
    const error = collectRegisterOverflowSlots(node, slots, edits, slotNames);
    if (error) return { error };
    if (!edits.length) return { text: sourceText };
    if (expression) {
        const rewrittenSource = applyTextEdits(parsed.source, edits);
        const prefixLength = parsed.source.length - sourceText.length;
        return { text: rewrittenSource.slice(prefixLength) };
    }
    return { text: applyTextEdits(parsed.source, edits) };
}

function normalizeRegisterOverflowGraph(graph) {
    const slots = new Set();
    for (const state of graph.states || []) {
        for (const operation of state.operations || []) {
            const statement = analyzeRegisterOverflowText(operationText(operation), false);
            if (statement.error) return { error: statement.error };
            for (const slot of statement.slots) slots.add(slot);
            if (operation?.rhs) {
                const rhs = analyzeRegisterOverflowText(operation.rhs, true);
                if (rhs.error) return { error: rhs.error };
                for (const slot of rhs.slots) slots.add(slot);
            }
        }
    }
    const orderedSlots = [...slots].sort((left, right) => left - right);
    const slotNames = new Map(orderedSlots.map((slot, index) => [slot, `v${index + 1}`]));
    const states = [];
    for (const state of graph.states || []) {
        const operations = [];
        for (const operation of state.operations || []) {
            const next = { ...operation };
            if (operation.emittedText) {
                const rewritten = rewriteRegisterOverflowText(operation.emittedText, false, slotNames);
                if (rewritten.error) return { error: rewritten.error };
                next.emittedText = rewritten.text;
            } else if (operation.originalText) {
                const rewritten = rewriteRegisterOverflowText(operation.originalText, false, slotNames);
                if (rewritten.error) return { error: rewritten.error };
                next.originalText = rewritten.text;
            }
            if (operation.rhs) {
                const rewritten = rewriteRegisterOverflowText(operation.rhs, true, slotNames);
                if (rewritten.error) return { error: rewritten.error };
                next.rhs = rewritten.text;
            }
            if (Array.isArray(operation.returnExpressions)) {
                const returnExpressions = [];
                for (const expression of operation.returnExpressions) {
                    const rewritten = rewriteRegisterOverflowText(expression, true, slotNames);
                    if (rewritten.error) return { error: rewritten.error };
                    returnExpressions.push(rewritten.text);
                }
                next.returnExpressions = returnExpressions;
            }
            operations.push(next);
        }
        states.push({ ...state, operations });
    }
    return {
        graph: {
            ...graph,
            states,
            registerOverflowUsed: orderedSlots.length > 0,
            registerOverflowSlotCount: orderedSlots.length,
            registerOverflowSlotNames: Object.fromEntries(orderedSlots.map(slot => [slot, slotNames.get(slot)])),
        },
    };
}

function hasUnsafeUnsupportedOperation(operations) {
    return operations.some(operation => operation?.kind === "unsupported");
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

function buildPresentedSource(originalAst, bodyText, options = {}) {
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
    if (/\bargs\b/.test(bodyText)) headerLines.push("local args = { ... }");
    let registerOverflowHeader = null;
    if (options.registerOverflowUsed === true) {
        registerOverflowHeader = "local RegisterOverflow = {}";
        headerLines.push(registerOverflowHeader);
    }

    const sections = ["--headers"];
    if (headerLines.length) sections.push(headerLines.join("\n"));
    sections.push("--body");
    sections.push(bodyText);
    return {
        applied: true,
        source: sections.join("\n\n") + "\n",
        environmentHeader,
        registerOverflowHeader,
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
    const structuredNodes = lowered.operations.map(operation => rawNode(operation, state.id));
    const structuredLogicalConditionRecoveryCount = recoverStructuredLogicalConditionPrograms(structuredNodes, graph);
    const genericForGlobalMethodTempRecoveryCount = recoverStructuredGenericForGlobalMethodTemps(structuredNodes, graph);
    const postCfNamecallRecoveryCount = recoverStructuredPostCfNamecalls(structuredNodes);
    const postCfClosureDestinationRecoveryCount = recoverStructuredPostCfClosureDestinationTemps(structuredNodes, graph);
    const postCfDeadClosureRecoveryCount = recoverStructuredPostCfDeadClosureTemps(structuredNodes, graph);
    const postCfDeadScalarLocalRecoveryCount = recoverStructuredPostCfDeadScalarLocals(structuredNodes, graph, { syntheticLocals: ["args"] });
    const postCfCopyScalarRecoveryCount = recoverStructuredPostCfCopyScalarTemps(structuredNodes, graph);
    const postCfCompilerGlobalAliasRecoveryCount = recoverStructuredCompilerGlobalAliases(structuredNodes, graph);
    const postCfCompilerClosureTempRecoveryCount = recoverStructuredCompilerClosureTemps(structuredNodes, graph);
    const postCfCompilerReturnAllRecoveryCount = recoverStructuredCompilerReturnAllForwarding(structuredNodes, graph);
    const postCfStaticMemberRecoveryCount = recoverStructuredPostCfStaticMembers(structuredNodes);
    const postCfFunctionDeclarationRecoveryCount = recoverStructuredPostCfFunctionDeclarations(structuredNodes);
    const structuredExpressionPresentationRecoveryCount = recoverStructuredExpressionPresentation(structuredNodes);
    const bodyText = formatStructuredNodes(structuredNodes);
    const presented = buildPresentedSource(originalAst, bodyText, { registerOverflowUsed: graph.registerOverflowUsed === true });
    if (!presented.applied) return presented;

    return {
        source: presented.source,
        applied: true,
        mode: "single-state",
        entryState: state.id,
        stateCount: graph.states.length,
        statementCount: countStructuredStatements(structuredNodes),
        branchCount: 0,
        structuredLogicalConditionRecoveryCount,
        postCfNamecallRecoveryCount,
        postCfClosureDestinationRecoveryCount,
        postCfDeadClosureRecoveryCount,
        postCfDeadScalarLocalRecoveryCount,
        postCfCopyScalarRecoveryCount,
        postCfCompilerGlobalAliasRecoveryCount,
        postCfCompilerClosureTempRecoveryCount,
        postCfCompilerReturnAllRecoveryCount,
        postCfStaticMemberRecoveryCount,
        postCfFunctionDeclarationRecoveryCount,
        structuredExpressionPresentationRecoveryCount,
        terminalReturnCount: lowered.lowered ? 1 : 0,
        terminalReturnPayloadSunk: sunk.moved,
        terminalReturnPayloadSunkCount: sunk.moved ? 1 : 0,
        terminalReturnLowered: lowered.lowered,
        terminalReturnText: lowered.returnText,
        environmentHeader: presented.environmentHeader,
        registerOverflowUsed: graph.registerOverflowUsed === true,
        registerOverflowSlotCount: graph.registerOverflowSlotCount || 0,
    };
}

const TRANSITION_PARSE_CACHE_LIMIT = 131072;
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

    const transitionIndex = state.operations.indexOf(operation);
    function uniquePriorDefinition(name) {
        if (!name || transitionIndex < 0) return null;
        const matches = state.operations.slice(0, transitionIndex).filter(candidate => candidate?.emittedTarget === name);
        return matches.length === 1 ? matches[0] : null;
    }
    function resolveNumericArm(node) {
        const direct = numericValue(node);
        if (direct !== null) return { value: direct, operation: null };
        if (!isIdentifier(node)) return null;
        const definition = uniquePriorDefinition(node.name);
        if (!definition) return null;
        const value = numericValue(parseOperationExpression(definition));
        return value === null ? null : { value, operation: definition };
    }

    let left = expression.left;
    let leftSource = parsed.source;
    let conditionProofOperation = operation;
    if (isIdentifier(left)) {
        const definition = uniquePriorDefinition(left.name);
        const definitionParsed = definition ? parseTransitionExpression(String(definition.rhs || "").trim()) : null;
        const definitionExpression = definitionParsed?.expression;
        if (definitionExpression?.type === "LogicalExpression" && definitionExpression.operator === "and") {
            left = definitionExpression;
            leftSource = definitionParsed.source;
            conditionProofOperation = definition;
        }
    }
    if (left?.type !== "LogicalExpression" || left.operator !== "and") {
        return { error: `State ${state.id} branch transition is missing its condition-and-true arm` };
    }

    const trueArm = resolveNumericArm(left.right);
    const falseArm = resolveNumericArm(expression.right);
    const onTrue = trueArm?.value ?? null;
    const onFalse = falseArm?.value ?? null;
    if (onTrue !== state.successors[0] || onFalse !== state.successors[1]) {
        return { error: `State ${state.id} branch targets do not match its proven CFG successors` };
    }

    // Prometheus compiles the branch condition into a register before the POS/state write.
    // Requiring a plain identifier keeps moving the final decision past any harmless tail
    // bookkeeping side-effect-free and prevents us from re-evaluating a call/index expression.
    if (!isIdentifier(left.left) || !Array.isArray(left.left.range)) {
        return { error: `State ${state.id} branch condition is not a precomputed beta register` };
    }
    const condition = leftSource.slice(left.left.range[0], left.left.range[1]);
    const conditionReads = [...(conditionProofOperation?.reads || [])];
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

function recoverCfAdjacentConditionTemp(graph, state, info, bodyOperations) {
    if (info?.kind !== "branch" || !info.conditionName || !Array.isArray(bodyOperations) || !bodyOperations.length) {
        return { info, bodyOperations, recovered: false };
    }
    const operations = state?.operations || [];
    const transitionIndex = operations.indexOf(info.operation);
    if (transitionIndex <= 0) return { info, bodyOperations, recovered: false };

    let producerIndex = -1;
    let producer = null;
    for (let index = transitionIndex - 1; index >= 0; index--) {
        const candidate = operations[index];
        if (candidate?.emittedTarget !== info.conditionName) continue;
        producerIndex = index;
        producer = candidate;
        break;
    }
    if (!producer) return { info, bodyOperations, recovered: false };
    if (producer.kind !== "version-define" && producer.kind !== "epoch-start" && producer.kind !== "epoch-mutate") {
        return { info, bodyOperations, recovered: false };
    }
    const rhs = String(producer.rhs || "").trim();
    if (!rhs || !parseTransitionExpression(rhs)?.expression) return { info, bodyOperations, recovered: false };
    if ((graph?.recoveredUpvalueBindings || []).includes(info.conditionName)) return { info, bodyOperations, recovered: false };

    let reads = 0;
    let writes = 0;
    for (const candidateState of graph?.states || []) {
        for (const operation of candidateState.operations || []) {
            reads += (operation?.reads || []).filter(name => name === info.conditionName).length;
            if (betaOperationWrites(operation).includes(info.conditionName)) writes++;
        }
    }
    if (reads !== 1 || writes !== 1) return { info, bodyOperations, recovered: false };

    // Final beta scheduling may leave pure compiler bookkeeping between the
    // condition producer and the state transition, or after that transition.
    // Structured emission removes the state write and prints every remaining
    // operation before the `if`; folding therefore moves the producer across all
    // later non-transition operations in this state. Cross only operations already
    // proven effect-free and independent from the producer's inputs/output.
    const producerReads = new Set(producer.reads || []);
    for (let index = producerIndex + 1; index < operations.length; index++) {
        const operation = operations[index];
        if (operation === info.operation) continue;
        if (operation?.returnSinkSafe !== true || !operation?.emittedTarget) {
            return { info, bodyOperations, recovered: false };
        }
        const crossedWrites = betaOperationWrites(operation);
        if (crossedWrites.some(name => name === info.conditionName || producerReads.has(name))) {
            return { info, bodyOperations, recovered: false };
        }
        if ((operation.reads || []).includes(info.conditionName)) {
            return { info, bodyOperations, recovered: false };
        }
    }

    const producerBodyIndex = bodyOperations.indexOf(producer);
    if (producerBodyIndex < 0) return { info, bodyOperations, recovered: false };
    return {
        info: {
            ...info,
            condition: `(${rhs})`,
            conditionReads: [...(producer.reads || [])],
            conditionTempRecovered: true,
            conditionTempProducer: producer,
        },
        bodyOperations: bodyOperations.filter((operation, index) => index !== producerBodyIndex),
        recovered: true,
    };
}

function structuredNodesReadName(nodes, name) {
    for (const node of nodes || []) {
        if ((node.reads || []).includes(name)) return true;
        if (node.type === "if") {
            if (structuredNodesReadName(node.thenBody, name) || structuredNodesReadName(node.elseBody, name)) return true;
        } else if (node.type === "while-guard" || node.type === "repeat-until") {
            if (structuredNodesReadName(node.conditionBody, name) || structuredNodesReadName(node.body, name)) return true;
        } else if (node.type === "numeric-for" || node.type === "generic-for") {
            if (structuredNodesReadName(node.body, name)) return true;
        }
    }
    return false;
}

function conditionPolarityForName(condition, name) {
    const text = String(condition || "").trim();
    if (text === name || text === `(${name})`) return "and";
    const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    if (new RegExp(`^not\\s+${escaped}$`).test(text) || new RegExp(`^not\\s*\\(\\s*${escaped}\\s*\\)$`).test(text)) return "or";
    return null;
}

function collectExpressionVariableIdentifierRanges(node, name, out = [], parent = null, key = null) {
    if (!node || typeof node !== "object") return out;
    if (node.type === "Identifier" && node.name === name) {
        const staticMemberKey = parent?.type === "MemberExpression" && key === "identifier";
        const staticTableKey = parent?.type === "TableKeyString" && key === "key";
        if (!staticMemberKey && !staticTableKey && Array.isArray(node.range)) out.push(node.range);
        return out;
    }
    for (const [childKey, value] of Object.entries(node)) {
        if (childKey === "range" || childKey === "loc") continue;
        if (Array.isArray(value)) {
            for (const child of value) if (child && typeof child === "object" && child.type) collectExpressionVariableIdentifierRanges(child, name, out, node, childKey);
        } else if (value && typeof value === "object" && value.type) {
            collectExpressionVariableIdentifierRanges(value, name, out, node, childKey);
        }
    }
    return out;
}

function substituteSingleExpressionIdentifier(rhs, name, replacement) {
    const parsed = parseTransitionExpression(rhs);
    if (!parsed?.expression) return null;
    const ranges = collectExpressionVariableIdentifierRanges(parsed.expression, name);
    if (ranges.length !== 1) return null;
    const prefixLength = parsed.source.length - String(rhs).length;
    const start = ranges[0][0] - prefixLength;
    const end = ranges[0][1] - prefixLength;
    if (start < 0 || end < start || String(rhs).slice(start, end) !== name) return null;
    return String(rhs).slice(0, start) + `(${replacement})` + String(rhs).slice(end);
}

function recoverCfLinearProducerChain(nodes, targetName, capturedBindings = []) {
    if (!nodes?.length || nodes.some(node => node?.type !== "raw")) return null;
    const captured = new Set(capturedBindings || []);
    const temporaryNames = new Set();
    let expression = null;
    let previousName = null;
    const externalReads = new Set();
    for (let index = 0; index < nodes.length; index++) {
        const operation = nodes[index].operation || {};
        const name = operation.emittedTarget;
        const rhs = String(operation.rhs || "").trim();
        if (!name || captured.has(name) || !rhs || !parseTransitionExpression(rhs)?.expression) return null;
        if (operation.kind !== "version-define" && operation.kind !== "epoch-start" && operation.kind !== "epoch-mutate") return null;
        if (index === 0) {
            expression = rhs;
        } else {
            if ((operation.reads || []).filter(read => read === previousName).length !== 1) return null;
            for (const read of operation.reads || []) if (temporaryNames.has(read) && read !== previousName) return null;
            expression = substituteSingleExpressionIdentifier(rhs, previousName, expression);
            if (!expression) return null;
        }
        for (const read of operation.reads || []) if (!temporaryNames.has(read) && read !== previousName) externalReads.add(read);
        temporaryNames.add(name);
        previousName = name;
    }
    if (previousName !== targetName) return null;
    return { expression: `(${expression})`, reads: [...externalReads] };
}

function recoverCfOrderedProducerChain(nodes, targetName, capturedBindings = [], options = {}) {
    if (!nodes?.length || nodes.some(node => node?.type !== "raw")) return null;
    const captured = new Set(capturedBindings || []);
    const records = new Map();
    const seenTargets = new Set();

    function atomicExpression(node) {
        return node?.type === "Identifier" || node?.type === "NumericLiteral" || node?.type === "StringLiteral" ||
            node?.type === "BooleanLiteral" || node?.type === "NilLiteral";
    }

    function replaceKnown(rhs, parsed, replacements) {
        const prefixLength = parsed.source.length - String(rhs).length;
        const edits = [];
        for (const [name, replacement] of replacements) {
            for (const range of collectExpressionVariableIdentifierRanges(parsed.expression, name)) {
                const start = range[0] - prefixLength;
                const end = range[1] - prefixLength;
                if (start < 0 || end < start || String(rhs).slice(start, end) !== name) return null;
                let renderedReplacement = `(${replacement})`;
                if (options.compact === true) {
                    const replacementAst = parseTransitionExpression(replacement)?.expression;
                    if (replacementAst && ["Identifier", "NumericLiteral", "StringLiteral", "BooleanLiteral", "NilLiteral", "MemberExpression", "IndexExpression", "CallExpression"].includes(replacementAst.type)) {
                        renderedReplacement = replacement;
                    }
                }
                edits.push({ start, end, replacement: renderedReplacement });
            }
        }
        edits.sort((a, b) => b.start - a.start);
        let out = String(rhs);
        for (const edit of edits) out = out.slice(0, edit.start) + edit.replacement + out.slice(edit.end);
        return parseTransitionExpression(out)?.expression ? out : null;
    }

    for (let index = 0; index < nodes.length; index++) {
        const operation = nodes[index].operation || {};
        const name = operation.emittedTarget;
        const rhs = String(operation.rhs || "").trim();
        if (!name || seenTargets.has(name) || captured.has(name) || !rhs) return null;
        if (operation.kind !== "version-define" && operation.kind !== "epoch-start" && operation.kind !== "epoch-mutate") return null;
        const parsed = parseTransitionExpression(rhs);
        if (!parsed?.expression) return null;

        const replacements = new Map();
        const externalReads = new Set();
        const internalDeps = new Set();
        let nonAtomicDependency = null;
        for (const read of operation.reads || []) {
            const prior = records.get(read);
            if (!prior) {
                externalReads.add(read);
                continue;
            }
            const occurrences = collectExpressionVariableIdentifierRanges(parsed.expression, read).length;
            if (occurrences < 1) return null;
            if (!prior.atomic) {
                if (occurrences !== 1 || nonAtomicDependency) return null;
                for (let crossed = prior.index + 1; crossed < index; crossed++) {
                    if (nodes[crossed]?.operation?.returnSinkSafe !== true) return null;
                }
                nonAtomicDependency = read;
            }
            replacements.set(read, prior.expression);
            internalDeps.add(read);
            for (const external of prior.externalReads) externalReads.add(external);
        }

        const expression = replacements.size ? replaceKnown(rhs, parsed, replacements) : rhs;
        if (!expression) return null;
        const expanded = parseTransitionExpression(expression)?.expression;
        if (!expanded) return null;
        records.set(name, {
            expression,
            externalReads,
            index,
            atomic: atomicExpression(expanded),
            internalDeps,
        });
        seenTargets.add(name);
    }

    const result = records.get(targetName);
    const finalTarget = nodes[nodes.length - 1]?.operation?.emittedTarget;
    if (!result || finalTarget !== targetName) return null;

    // A candidate may begin before the real repeat-condition program. Every
    // non-bookkeeping producer in the candidate must transitively feed the
    // final condition value, otherwise it belongs to the actual loop body.
    const required = new Set();
    const stack = [targetName];
    while (stack.length) {
        const name = stack.pop();
        if (required.has(name)) continue;
        required.add(name);
        const record = records.get(name);
        for (const dependency of record?.internalDeps || []) stack.push(dependency);
    }
    for (const node of nodes) {
        const operation = node.operation || {};
        const name = operation.emittedTarget;
        if (!required.has(name) && operation.returnSinkSafe !== true) return null;
    }

    return { expression: `(${result.expression})`, reads: [...result.externalReads], consumedNames: [...required] };
}

function recoverCfLogicalValueProgram(nodes, resultName, capturedBindings = [], options = {}) {
    const work = [...(nodes || [])];
    const captured = new Set(capturedBindings || []);
    if (work[0]?.type === "raw" && String(work[0].text || "").trim() === `local ${resultName}`) work.shift();
    if (!work.length) return null;
    const directLinear = recoverCfLinearProducerChain(work, resultName, capturedBindings);
    if (directLinear) return directLinear;
    if (options.allowOrderedProducerChain === true) {
        const directOrdered = recoverCfOrderedProducerChain(work, resultName, capturedBindings);
        if (directOrdered) return directOrdered;
    }

    const last = work[work.length - 1];
    const branch = last?.type === "if" && !last.elseBody ? last : null;
    const assignIndex = branch ? work.length - 2 : work.length - 1;
    if (assignIndex < 0 || work[assignIndex]?.type !== "raw") return null;
    const assignment = work[assignIndex].operation || {};
    const seedName = String(assignment.rhs || "").trim();
    if (assignment.emittedTarget !== resultName || !/^[A-Za-z_][A-Za-z0-9_]*$/.test(seedName) || seedName === resultName || captured.has(seedName)) return null;
    if (assignment.kind !== "version-define" && assignment.kind !== "epoch-start" && assignment.kind !== "epoch-mutate") return null;

    const prefix = work.slice(0, assignIndex);
    const linearSeed = recoverCfLinearProducerChain(prefix, seedName, capturedBindings);
    const orderedSeed = !linearSeed && options.allowOrderedProducerChain === true
        ? recoverCfOrderedProducerChain(prefix, seedName, capturedBindings)
        : null;
    const seed = linearSeed || orderedSeed || recoverCfLogicalValueProgram(prefix, seedName, capturedBindings, options);
    if (!seed) return null;
    if (!branch) return seed;

    const operator = conditionPolarityForName(branch.condition, seedName);
    if (!operator || structuredNodesReadName(branch.thenBody, seedName)) return null;
    const nested = recoverCfLogicalValueProgram(branch.thenBody, resultName, capturedBindings, options);
    if (!nested) return null;
    return {
        expression: `(${seed.expression}) ${operator} (${nested.expression})`,
        reads: [...new Set([...(seed.reads || []), ...(nested.reads || [])])],
    };
}

function recoverCfLogicalSuffix(nodes, resultName, capturedBindings = []) {
    const matches = [];
    for (let start = 0; start < (nodes || []).length; start++) {
        const recovered = recoverCfLogicalValueProgram(nodes.slice(start), resultName, capturedBindings);
        if (recovered) matches.push({ start, ...recovered });
    }
    return matches.length === 1 ? matches[0] : null;
}

function recoverCfLogicalConditionSuffix(nodes, resultName, capturedBindings = [], graph = null, options = {}) {
    if (!resultName || !Array.isArray(nodes) || nodes.length < 2) return null;
    const exactMatches = [];
    for (let start = 0; start < nodes.length; start++) {
        const recovered = recoverCfLogicalValueProgram(nodes.slice(start), resultName, capturedBindings, options);
        if (recovered) exactMatches.push({ start, retainedNodes: [], ...recovered });
    }
    if (exactMatches.length) {
        // Every exact match is a suffix ending at the same consumer. Prefer the
        // unique maximal enclosing proof (smallest start), rather than rejecting
        // a valid producer chain merely because its own tail is also recoverable.
        return exactMatches.reduce((best, match) => match.start < best.start ? match : best);
    }
    if (!graph) return null;

    // Final beta scheduling can insert unrelated pure snapshots inside the
    // compiler short-circuit value program. Hoisting such a snapshot before the
    // recovered condition is safe only when the snapshot itself is effect-free
    // and every beta binding it reads has exactly one immutable definition.
    const writeCounts = new Map();
    for (const state of graph.states || []) {
        for (const operation of state.operations || []) {
            for (const name of betaOperationWrites(operation)) writeCounts.set(name, (writeCounts.get(name) || 0) + 1);
        }
    }
    const captured = new Set(capturedBindings || []);
    function movableBookkeeping(node, protectedNames) {
        if (node?.type !== "raw") return false;
        const operation = node.operation || {};
        const parameterSnapshot = staticArgsIndex(parseOperationExpression(operation)) !== null;
        if ((operation.returnSinkSafe !== true && !parameterSnapshot) || !operation.emittedTarget || protectedNames.has(operation.emittedTarget)) return false;
        if (captured.has(operation.emittedTarget) || (writeCounts.get(operation.emittedTarget) || 0) !== 1) return false;
        if (operation.kind !== "version-define" && operation.kind !== "epoch-start" && operation.kind !== "epoch-mutate") return false;
        if (parameterSnapshot) return true;
        for (const read of operation.reads || []) {
            if (protectedNames.has(read) || captured.has(read) || (writeCounts.get(read) || 0) !== 1) return false;
        }
        return true;
    }

    const branchIndex = nodes.length - 1;
    const branch = nodes[branchIndex];
    if (branch?.type !== "if" || branch.elseBody) return null;
    for (let assignmentIndex = branchIndex - 1; assignmentIndex >= 1; assignmentIndex--) {
        const assignmentNode = nodes[assignmentIndex];
        if (assignmentNode?.type !== "raw") continue;
        const assignment = assignmentNode.operation || {};
        const seedName = String(assignment.rhs || "").trim();
        if (assignment.emittedTarget !== resultName || !/^[A-Za-z_][A-Za-z0-9_]*$/.test(seedName) || seedName === resultName) continue;
        const protectedNames = new Set([resultName, seedName]);
        for (let producerIndex = assignmentIndex - 1; producerIndex >= 0; producerIndex--) {
            const producerNode = nodes[producerIndex];
            if (producerNode?.type !== "raw" || producerNode.operation?.emittedTarget !== seedName) continue;
            const retainedNodes = [];
            let safe = true;
            for (let index = producerIndex + 1; index < branchIndex; index++) {
                if (index === assignmentIndex) continue;
                const node = nodes[index];
                if (!movableBookkeeping(node, protectedNames)) { safe = false; break; }
                retainedNodes.push(node);
            }
            if (!safe) continue;
            const recovered = recoverCfLogicalValueProgram([producerNode, assignmentNode, branch], resultName, capturedBindings, options);
            if (!recovered) continue;
            return { start: producerIndex, retainedNodes, ...recovered };
        }
    }
    return null;
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
        compilerIteratorRecovered: false,
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
            const stepText = node.step === null || node.step === undefined ? "" : `, ${node.step}`;
            const header = `${"    ".repeat(depth)}for ${node.variable} = ${node.initial}, ${node.limit}${stepText} do`;
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
            if (!node.conditionBody.length) {
                const lines = [`${indent}while ${node.condition} do`];
                if (node.body.length) lines.push("", formatStructuredNodes(node.body, depth + 1));
                lines.push("", `${indent}end`);
                parts.push(lines.join("\n"));
                continue;
            }
            const lines = [`${indent}while true do`];
            lines.push("", formatStructuredNodes(node.conditionBody, depth + 1));
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


function normalizeRecoveredLogicalExpression(text) {
    const parsed = parseTransitionExpression(text);
    if (!parsed?.expression) return String(text || "");
    const prefixLength = parsed.source.length - String(text || "").length;
    const precedence = node => {
        if (node?.type === "LogicalExpression") return node.operator === "or" ? 1 : 2;
        if (node?.type === "UnaryExpression" && node.operator === "not") return 3;
        return 4;
    };
    const original = node => {
        if (!Array.isArray(node?.range)) return null;
        const start = node.range[0] - prefixLength;
        const end = node.range[1] - prefixLength;
        if (start < 0 || end < start) return null;
        return String(text || "").slice(start, end);
    };
    function render(node, parentPrecedence = 0) {
        if (!node) return null;
        let output;
        const ownPrecedence = precedence(node);
        if (node.type === "LogicalExpression" && (node.operator === "and" || node.operator === "or")) {
            const parts = [];
            function flatten(child) {
                if (child?.type === "LogicalExpression" && child.operator === node.operator) {
                    flatten(child.left);
                    flatten(child.right);
                } else {
                    const rendered = render(child, ownPrecedence);
                    if (rendered == null) return false;
                    parts.push(rendered);
                }
                return true;
            }
            if (!flatten(node.left) || !flatten(node.right)) return original(node);
            output = parts.join(` ${node.operator} `);
        } else if (node.type === "UnaryExpression" && node.operator === "not") {
            const argument = render(node.argument, 0);
            if (argument == null) return original(node);
            output = node.argument?.type === "LogicalExpression" ? `not (${argument})` : `not ${argument}`;
        } else {
            output = original(node);
        }
        if (output == null) return null;
        return ownPrecedence < parentPrecedence ? `(${output})` : output;
    }
    let rendered = render(parsed.expression, 0) || String(text || "");
    rendered = rendered.replace(/\(([A-Za-z_][A-Za-z0-9_]*)\)(?=\s*\()/g, "$1");
    rendered = rendered.replace(/([,(]\s*)\(([A-Za-z_][A-Za-z0-9_]*)\)(?=\s*[,)]|\s*\.\.\.)/g, "$1$2");
    return rendered;
}

function normalizeStructuredSingleValueExpression(text) {
    const source = String(text || "");
    const parsedBefore = parseTransitionExpression(source);
    if (!parsedBefore?.expression) return source;
    const rewritten = normalizeRecoveredLogicalExpression(source);
    if (rewritten === source) return source;
    const parsedAfter = parseTransitionExpression(rewritten);
    if (!parsedAfter?.expression) return source;
    return rewritten;
}

function recoverStructuredExpressionPresentation(nodes) {
    let folds = 0;
    function normalizeField(node, field) {
        const before = String(node?.[field] ?? "");
        if (!before) return;
        const after = normalizeStructuredSingleValueExpression(before);
        if (after === before) return;
        node[field] = after;
        folds++;
    }
    function visit(body) {
        for (const node of body || []) {
            if (node?.type === "if") {
                normalizeField(node, "condition");
                visit(node.thenBody);
                visit(node.elseBody);
            } else if (node?.type === "while-guard") {
                normalizeField(node, "condition");
                visit(node.conditionBody);
                visit(node.body);
            } else if (node?.type === "repeat-until") {
                normalizeField(node, "condition");
                visit(node.body);
                visit(node.conditionBody);
            } else if (node?.type === "numeric-for") {
                normalizeField(node, "initial");
                normalizeField(node, "limit");
                if (node.step !== null && node.step !== undefined) normalizeField(node, "step");
                visit(node.body);
            } else if (node?.type === "generic-for") {
                // Generic-for expression lists participate in Lua multi-result
                // adjustment. Leave them untouched in this presentation-only pass.
                visit(node.body);
            }
        }
    }
    visit(nodes);
    return folds;
}

function recoverStructuredCompilerGlobalAliases(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node.type === "if") {
                    visit(node.thenBody);
                    visit(node.elseBody);
                } else if (node.type === "numeric-for" || node.type === "generic-for") {
                    visit(node.body);
                } else if (node.type === "while-guard" || node.type === "repeat-until") {
                    visit(node.conditionBody);
                    visit(node.body);
                }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function aliasInfo(node) {
        if (node?.type !== "raw") return null;
        const operation = node.operation || {};
        const name = operation.emittedTarget;
        const globalName = operation.compilerGlobalLookupRecovered;
        if (!name || captured.has(name) || typeof globalName !== "string") return null;
        if (!/^[A-Za-z_][A-Za-z0-9_]*$/.test(globalName) || POST_CF_MEMBER_KEYWORDS.has(globalName)) return null;
        if (String(operation.rhs || "").trim() !== globalName) return null;
        if (!String(operation.emittedText || node.text || "").trim().startsWith("local ")) return null;
        return { node, operation, name, globalName };
    }

    function expressionIdentifierOffset(text, name) {
        const parsed = parseTransitionExpression(text);
        if (!parsed?.expression) return null;
        const ranges = collectExpressionVariableIdentifierRanges(parsed.expression, name);
        if (ranges.length !== 1) return null;
        const prefixLength = parsed.source.length - String(text || "").length;
        return ranges[0][0] - prefixLength;
    }

    function statementIdentifierOffset(text, name) {
        const parsed = parseControlFlowStatement(text);
        if (!parsed?.statement) return null;
        const ranges = collectExpressionVariableIdentifierRanges(parsed.statement, name);
        return ranges.length === 1 ? ranges[0][0] : null;
    }

    function substituteSingleStatementIdentifier(text, name, replacement) {
        const parsed = parseControlFlowStatement(text);
        if (!parsed?.statement) return null;
        const ranges = collectExpressionVariableIdentifierRanges(parsed.statement, name);
        if (ranges.length !== 1) return null;
        const [start, end] = ranges[0];
        if (parsed.source.slice(start, end) !== name) return null;
        return parsed.source.slice(0, start) + replacement + parsed.source.slice(end);
    }

    function rewrittenAssignmentRhs(text) {
        const parsed = parseControlFlowStatement(text);
        const statement = parsed?.statement;
        const init = statement?.init || [];
        if ((statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") ||
            init.length !== 1 || !Array.isArray(init[0]?.range)) return null;
        return parsed.source.slice(init[0].range[0], init[0].range[1]);
    }

    function rewriteConsumer(consumer, aliases) {
        let text;
        let mode;
        if (consumer?.type === "if") {
            text = String(consumer.condition || "");
            mode = "condition";
        } else if (consumer?.type === "raw") {
            text = String(consumer.text || "");
            mode = "statement";
        } else return null;

        const positions = aliases.map(alias => mode === "condition"
            ? expressionIdentifierOffset(text, alias.name)
            : statementIdentifierOffset(text, alias.name));
        if (positions.some(position => position == null)) return null;
        for (let index = 1; index < positions.length; index++) {
            if (!(positions[index - 1] < positions[index])) return null;
        }

        let rewritten = text;
        for (const alias of aliases) {
            rewritten = mode === "condition"
                ? substituteSingleExpressionIdentifier(rewritten, alias.name, alias.globalName)
                : substituteSingleStatementIdentifier(rewritten, alias.name, alias.globalName);
            if (!rewritten) return null;
        }
        return { mode, rewritten };
    }

    function visitBody(body, facts) {
        for (let consumerIndex = 1; consumerIndex < (body || []).length; consumerIndex++) {
            const consumer = body[consumerIndex];
            const aliases = [];
            for (let index = consumerIndex - 1; index >= 0; index--) {
                const candidateNode = body[index];
                const alias = aliasInfo(candidateNode);
                if (alias) {
                    if ((facts.reads.get(alias.name) || 0) !== 1 || (facts.definitions.get(alias.name) || 0) !== 1) break;
                    if (!(consumer.reads || []).includes(alias.name)) break;
                    aliases.unshift({ ...alias, bodyIndex: index });
                    continue;
                }
                const operation = candidateNode?.type === "raw" ? candidateNode.operation : null;
                const parameterSnapshot = operation && staticArgsIndex(parseOperationExpression(operation)) !== null;
                if (parameterSnapshot) continue;
                break;
            }
            if (aliases.length) {
                const rewritten = rewriteConsumer(consumer, aliases);
                if (rewritten) {
                    const removed = new Set(aliases.map(alias => alias.name));
                    consumer.reads = [...new Set((consumer.reads || []).filter(name => !removed.has(name)))];
                    if (rewritten.mode === "condition") {
                        consumer.condition = normalizeRecoveredLogicalExpression(rewritten.rewritten);
                    } else {
                        const rewrittenRhs = consumer.operation?.kind === "effect-call"
                            ? rewritten.rewritten
                            : rewrittenAssignmentRhs(rewritten.rewritten);
                        if (consumer.operation && !rewrittenRhs) return false;
                        consumer.text = rewritten.rewritten;
                        if (consumer.operation) {
                            consumer.operation.emittedText = rewritten.rewritten;
                            consumer.operation.rhs = rewrittenRhs;
                            consumer.operation.reads = [...consumer.reads];
                            consumer.operation.compilerStructuredGlobalAliasesRecovered = aliases.map(alias => ({ globalName: alias.globalName }));
                        }
                    }
                    for (const alias of aliases) { const at = body.indexOf(alias.node); if (at >= 0) body.splice(at, 1); }
                    folds += aliases.length;
                    return true;
                }
            }
            if (consumer?.type === "if") {
                if (visitBody(consumer.thenBody, facts) || visitBody(consumer.elseBody, facts)) return true;
            } else if (consumer?.type === "numeric-for" || consumer?.type === "generic-for") {
                if (visitBody(consumer.body, facts)) return true;
            } else if (consumer?.type === "while-guard" || consumer?.type === "repeat-until") {
                if (visitBody(consumer.conditionBody, facts) || visitBody(consumer.body, facts)) return true;
            }
        }
        return false;
    }

    let changed = true;
    while (changed) {
        changed = visitBody(nodes, collectFacts(nodes));
    }
    return folds;
}


function recoverStructuredCompilerClosureTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node.type === "if") {
                    visit(node.thenBody); visit(node.elseBody);
                } else if (node.type === "numeric-for" || node.type === "generic-for") {
                    visit(node.body);
                } else if (node.type === "while-guard" || node.type === "repeat-until") {
                    visit(node.conditionBody); visit(node.body);
                }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function statementUseContext(text, name) {
        const parsed = parseControlFlowStatement(text);
        if (!parsed?.statement) return null;
        const matches = [];
        function walk(node, parent = null, key = null) {
            if (!node || typeof node !== "object") return;
            if (node.type === "Identifier" && node.name === name) {
                const staticMemberKey = parent?.type === "MemberExpression" && key === "identifier";
                const staticTableKey = parent?.type === "TableKeyString" && key === "key";
                if (!staticMemberKey && !staticTableKey && Array.isArray(node.range)) matches.push({ node, parent, key });
                return;
            }
            for (const [childKey, value] of Object.entries(node)) {
                if (childKey === "range" || childKey === "loc") continue;
                if (Array.isArray(value)) {
                    for (const child of value) if (child?.type) walk(child, node, childKey);
                } else if (value?.type) {
                    walk(value, node, childKey);
                }
            }
        }
        walk(parsed.statement);
        if (matches.length !== 1) return null;
        const match = matches[0];
        if (match.parent?.type !== "CallExpression") return null;
        const role = match.key === "base" ? "call-base" : match.key === "arguments" ? "call-argument" : null;
        if (!role) return null;
        return { parsed, ...match, role };
    }

    function rewriteStatementIdentifier(text, name, replacement) {
        const parsed = parseControlFlowStatement(text);
        if (!parsed?.statement) return null;
        const ranges = collectExpressionVariableIdentifierRanges(parsed.statement, name);
        if (ranges.length !== 1) return null;
        const [start, end] = ranges[0];
        if (parsed.source.slice(start, end) !== name) return null;
        return parsed.source.slice(0, start) + replacement + parsed.source.slice(end);
    }

    function assignmentRhs(text) {
        const parsed = parseControlFlowStatement(text);
        const statement = parsed?.statement;
        const init = statement?.init || [];
        if ((statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") || init.length !== 1 || !Array.isArray(init[0]?.range)) return null;
        return parsed.source.slice(init[0].range[0], init[0].range[1]);
    }

    function visitBody(body, facts) {
        for (let index = 1; index < (body || []).length; index++) {
            const producerNode = body[index - 1];
            const consumerNode = body[index];
            const producer = producerNode?.type === "raw" ? producerNode.operation : null;
            const info = producer?.compilerClosureFactoryRecovered;
            const name = producer?.emittedTarget;
            if (info && info.captureCount === 0 && name && !captured.has(name) &&
                (facts.reads.get(name) || 0) === 1 && (facts.definitions.get(name) || 0) === 1 &&
                consumerNode?.type === "raw" && (consumerNode.reads || []).includes(name)) {
                const functionText = String(producer.rhs || "").trim();
                const context = /^function\s*\(/.test(functionText) ? statementUseContext(consumerNode.text, name) : null;
                if (context) {
                    let allowed = context.role === "call-base" && consumerNode.operation?.kind === "effect-call";
                    if (context.role === "call-argument") {
                        const recoveredGlobals = consumerNode.operation?.compilerStructuredGlobalAliasesRecovered || [];
                        const base = context.parent?.base;
                        allowed = base?.type === "Identifier" && recoveredGlobals.some(item => item?.globalName === base.name);
                    }
                    if (allowed) {
                        const replacement = context.role === "call-base" ? `(${functionText})` : functionText;
                        const rewritten = rewriteStatementIdentifier(consumerNode.text, name, replacement);
                        if (rewritten && parseControlFlowStatement(rewritten)) {
                            consumerNode.text = rewritten;
                            consumerNode.reads = (consumerNode.reads || []).filter(read => read !== name);
                            if (consumerNode.operation) {
                                consumerNode.operation.emittedText = rewritten;
                                const rhs = consumerNode.operation.kind === "effect-call" ? rewritten : assignmentRhs(rewritten);
                                if (rhs) consumerNode.operation.rhs = rhs;
                                consumerNode.operation.reads = [...consumerNode.reads];
                                if (context.role === "call-base") consumerNode.operation.compilerInlineClosureBaseRecovered = true;
                                if (context.role === "call-argument") consumerNode.operation.compilerInlineClosureArgumentRecovered = true;
                            }
                            body.splice(index - 1, 1);
                            folds++;
                            return true;
                        }
                    }
                }
            }
            if (consumerNode?.type === "if") {
                if (visitBody(consumerNode.thenBody, facts) || visitBody(consumerNode.elseBody, facts)) return true;
            } else if (consumerNode?.type === "numeric-for" || consumerNode?.type === "generic-for") {
                if (visitBody(consumerNode.body, facts)) return true;
            } else if (consumerNode?.type === "while-guard" || consumerNode?.type === "repeat-until") {
                if (visitBody(consumerNode.conditionBody, facts) || visitBody(consumerNode.body, facts)) return true;
            }
        }
        return false;
    }

    let changed = true;
    while (changed) changed = visitBody(nodes, collectFacts(nodes));
    return folds;
}

function recoverStructuredCompilerReturnAllForwarding(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node.type === "if") { visit(node.thenBody); visit(node.elseBody); }
                else if (node.type === "numeric-for" || node.type === "generic-for") visit(node.body);
                else if (node.type === "while-guard" || node.type === "repeat-until") { visit(node.conditionBody); visit(node.body); }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function visitBody(body, facts) {
        for (let index = 1; index < (body || []).length; index++) {
            const packNode = body[index - 1];
            const consumerNode = body[index];
            const pack = packNode?.type === "raw" ? packNode.operation : null;
            const packName = pack?.emittedTarget;
            if (pack && packName && !captured.has(packName) &&
                (facts.reads.get(packName) || 0) === 1 && (facts.definitions.get(packName) || 0) === 1 &&
                consumerNode?.type === "raw" && consumerNode.operation?.compilerInlineClosureBaseRecovered === true) {
                const packExpr = parseOperationExpression(pack);
                const fields = packExpr?.type === "TableConstructorExpression" ? (packExpr.fields || []) : [];
                const innerCall = fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression" ? fields[0].value : null;
                const innerCallText = innerCall ? sourceTextForParsedExpressionNode(String(pack.rhs || ""), innerCall) : null;
                const parsedConsumer = parseControlFlowStatement(consumerNode.text);
                const statement = parsedConsumer?.statement;
                const expression = statement?.type === "CallStatement" ? statement.expression : null;
                const args = expression?.type === "CallExpression" ? (expression.arguments || []) : [];
                const last = args[args.length - 1];
                const unpackArgs = last?.type === "CallExpression" && isIdentifier(last.base, "unpack") ? (last.arguments || []) : [];
                if (innerCallText && expression?.base?.type === "FunctionDeclaration" && unpackArgs.length === 1 && isIdentifier(unpackArgs[0], packName) && Array.isArray(last.range)) {
                    const rewritten = parsedConsumer.source.slice(0, last.range[0]) + innerCallText + parsedConsumer.source.slice(last.range[1]);
                    if (parseControlFlowStatement(rewritten)) {
                        consumerNode.text = rewritten;
                        const nextReads = [];
                        for (const read of consumerNode.reads || []) {
                            if (read === packName) nextReads.push(...(pack.reads || []));
                            else nextReads.push(read);
                        }
                        consumerNode.reads = [...new Set(nextReads)];
                        consumerNode.operation.emittedText = rewritten;
                        consumerNode.operation.rhs = rewritten;
                        consumerNode.operation.reads = [...consumerNode.reads];
                        consumerNode.operation.compilerStructuredReturnAllRecovered = true;
                        body.splice(index - 1, 1);
                        folds++;
                        return true;
                    }
                }
            }
            if (consumerNode?.type === "if") {
                if (visitBody(consumerNode.thenBody, facts) || visitBody(consumerNode.elseBody, facts)) return true;
            } else if (consumerNode?.type === "numeric-for" || consumerNode?.type === "generic-for") {
                if (visitBody(consumerNode.body, facts)) return true;
            } else if (consumerNode?.type === "while-guard" || consumerNode?.type === "repeat-until") {
                if (visitBody(consumerNode.conditionBody, facts) || visitBody(consumerNode.body, facts)) return true;
            }
        }
        return false;
    }

    let changed = true;
    while (changed) changed = visitBody(nodes, collectFacts(nodes));
    return folds;
}

function recoverStructuredLogicalConditionPrograms(nodes, graph) {
    let folds = 0;
    const capturedBindings = graph?.recoveredUpvalueBindings || [];

    function exactConditionName(condition) {
        const text = String(condition || "").trim();
        let match = text.match(/^\(?\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)?$/);
        if (match) return { name: match[1], negated: false };
        match = text.match(/^not\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)$/);
        return match ? { name: match[1], negated: true } : null;
    }

    function visitBody(body) {
        for (let index = 0; index < (body || []).length; index++) {
            const node = body[index];
            if (node?.type === "if") {
                const conditionInfo = exactConditionName(node.condition);
                if (conditionInfo && index > 0) {
                    const logical = recoverCfLogicalConditionSuffix(body.slice(0, index), conditionInfo.name, capturedBindings, graph);
                    if (logical) {
                        const expression = conditionInfo.negated ? `not (${logical.expression})` : logical.expression;
                        node.condition = normalizeRecoveredLogicalExpression(expression);
                        node.reads = [...new Set(logical.reads || [])];
                        body.splice(logical.start, index - logical.start, ...(logical.retainedNodes || []));
                        folds++;
                        return true;
                    }
                }
                if (visitBody(node.thenBody) || visitBody(node.elseBody)) return true;
            } else if (node?.type === "numeric-for" || node?.type === "generic-for") {
                if (visitBody(node.body)) return true;
            } else if (node?.type === "while-guard") {
                if (visitBody(node.conditionBody) || visitBody(node.body)) return true;
            } else if (node?.type === "repeat-until") {
                const conditionInfo = exactConditionName(node.condition);
                if (conditionInfo && !capturedBindings.includes(conditionInfo.name)) {
                    for (const owner of [node.conditionBody, node.body]) {
                        if (!(owner || []).length) continue;
                        const logical = recoverCfLogicalConditionSuffix(owner, conditionInfo.name, capturedBindings, graph, { allowOrderedProducerChain: true });
                        if (!logical || (logical.retainedNodes || []).length) continue;
                        const expression = conditionInfo.negated ? `not (${logical.expression})` : logical.expression;
                        node.condition = normalizeRecoveredLogicalExpression(expression);
                        node.reads = [...new Set(logical.reads || [])];
                        owner.splice(logical.start, owner.length - logical.start, ...(logical.retainedNodes || []));
                        folds++;
                        return true;
                    }
                }
                if (visitBody(node.body) || visitBody(node.conditionBody)) return true;
            }
        }
        return false;
    }

    let changed = true;
    while (changed) changed = visitBody(nodes);
    return folds;
}
function recoverStructuredCompilerValueTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node?.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node?.type === "if") { visit(node.thenBody); visit(node.elseBody); }
                else if (node?.type === "numeric-for" || node?.type === "generic-for") visit(node.body);
                else if (node?.type === "while-guard" || node?.type === "repeat-until") { visit(node.conditionBody); visit(node.body); }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function substituteExact(text, name, recoveredExpression) {
        const parsed = parseTransitionExpression(text);
        if (!parsed?.expression) return null;
        const ranges = collectExpressionVariableIdentifierRanges(parsed.expression, name);
        if (ranges.length !== 1) return null;
        const prefixLength = parsed.source.length - String(text).length;
        const start = ranges[0][0] - prefixLength;
        const end = ranges[0][1] - prefixLength;
        if (start < 0 || end < start || String(text).slice(start, end) !== name) return null;

        let replacement = String(recoveredExpression || "").trim();
        if (replacement.startsWith("(") && replacement.endsWith(")")) replacement = replacement.slice(1, -1).trim();
        const ast = parseTransitionExpression(replacement)?.expression;
        if (!ast) return null;
        const tight = ast.type === "Identifier" || ast.type === "MemberExpression" || ast.type === "IndexExpression" || ast.type === "CallExpression";
        if (!tight) replacement = `(${replacement})`;
        const out = String(text).slice(0, start) + replacement + String(text).slice(end);
        return parseTransitionExpression(out)?.expression ? out : null;
    }

    function replacedReads(reads, target, replacements) {
        const out = [];
        for (const name of reads || []) {
            if (name === target) out.push(...(replacements || []));
            else out.push(name);
        }
        return [...new Set(out)];
    }

    function identifierUsedAsCallBase(ast, name) {
        let found = false;
        function visit(node) {
            if (!node || typeof node !== "object" || found) return;
            if (node.type === "CallExpression" && node.base?.type === "Identifier" && node.base.name === name) {
                found = true;
                return;
            }
            for (const [key, value] of Object.entries(node)) {
                if (key === "range" || key === "loc") continue;
                if (Array.isArray(value)) for (const child of value) visit(child);
                else if (value && typeof value === "object") visit(value);
            }
        }
        visit(ast);
        return found;
    }
    function recoverSuffix(owner, expression, reads, facts) {
        if (!(owner || []).length) return null;
        const last = owner[owner.length - 1];
        const target = last?.type === "raw" ? last.operation?.emittedTarget : null;
        if (!target || captured.has(target)) return null;
        const parsed = parseTransitionExpression(expression);
        if (!parsed?.expression || collectExpressionVariableIdentifierRanges(parsed.expression, target).length !== 1) return null;
        const targetProducerExpression = parseOperationExpression(last.operation);
        let targetProducerContainsCall = false;
        walk(targetProducerExpression, current => {
            if (current?.type === "CallExpression") { targetProducerContainsCall = true; return false; }
        });
        if (targetProducerContainsCall && identifierUsedAsCallBase(parsed.expression, target)) return null;
        if ((facts.definitions.get(target) || 0) !== 1 || (facts.reads.get(target) || 0) !== 1) return null;

        for (let start = 0; start < owner.length; start++) {
            const slice = owner.slice(start);
            if (slice.some(node => node?.type !== "raw")) continue;
            const recovered = recoverCfOrderedProducerChain(slice, target, [...captured], { compact: true });
            if (!recovered) continue;
            const consumed = new Set(recovered.consumedNames || []);
            if (!consumed.has(target)) continue;
            let safe = true;
            for (const node of slice) {
                const operation = node.operation || {};
                const name = operation.emittedTarget;
                if (!name || (facts.definitions.get(name) || 0) !== 1) { safe = false; break; }
                if (consumed.has(name)) {
                    if (captured.has(name) || (facts.reads.get(name) || 0) !== 1) { safe = false; break; }
                    if (name !== target) {
                        let containsCall = false;
                        walk(parseOperationExpression(operation), current => {
                            if (current?.type === "CallExpression") { containsCall = true; return false; }
                        });
                        if (containsCall) { safe = false; break; }
                    }
                } else if (operation.returnSinkSafe !== true) {
                    safe = false;
                    break;
                }
            }
            if (!safe) continue;
            const rewritten = substituteExact(expression, target, recovered.expression);
            if (!rewritten) continue;
            return {
                start,
                rewritten,
                reads: replacedReads(reads, target, recovered.reads),
                removedCount: owner.length - start,
            };
        }
        return null;
    }

    function visit(body, facts) {
        for (let index = 0; index < (body || []).length; index++) {
            const node = body[index];
            if (node?.type === "generic-for" && node.compilerIteratorRecovered === true && (node.expressions || []).length === 1 && index > 0) {
                const prefix = body.slice(0, index);
                const recovered = recoverSuffix(prefix, node.expressions[0], node.reads, facts);
                if (recovered) {
                    node.expressions[0] = recovered.rewritten;
                    node.reads = recovered.reads;
                    body.splice(recovered.start, index - recovered.start);
                    folds += recovered.removedCount;
                    return true;
                }
            }
            if (node?.type === "while-guard") {
                const recovered = recoverSuffix(node.conditionBody, node.condition, node.reads, facts);
                if (recovered) {
                    node.condition = recovered.rewritten;
                    node.reads = recovered.reads;
                    node.conditionBody.splice(recovered.start, node.conditionBody.length - recovered.start);
                    folds += recovered.removedCount;
                    return true;
                }
                if (visit(node.conditionBody, facts) || visit(node.body, facts)) return true;
            } else if (node?.type === "repeat-until") {
                for (const owner of [node.conditionBody, node.body]) {
                    const recovered = recoverSuffix(owner, node.condition, node.reads, facts);
                    if (!recovered) continue;
                    node.condition = recovered.rewritten;
                    node.reads = recovered.reads;
                    owner.splice(recovered.start, owner.length - recovered.start);
                    folds += recovered.removedCount;
                    return true;
                }
                if (visit(node.conditionBody, facts) || visit(node.body, facts)) return true;
            } else if (node?.type === "if") {
                if (visit(node.thenBody, facts) || visit(node.elseBody, facts)) return true;
            } else if (node?.type === "numeric-for" || node?.type === "generic-for") {
                if (visit(node.body, facts)) return true;
            }
        }
        return false;
    }

    let changed = true;
    while (changed) {
        const facts = collectFacts(nodes);
        changed = visit(nodes, facts);
    }
    return folds;
}
function recoverStructuredLoopBranchConditionTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node.type === "if") {
                    visit(node.thenBody);
                    visit(node.elseBody);
                } else if (node.type === "numeric-for" || node.type === "generic-for") {
                    visit(node.body);
                } else if (node.type === "while-guard") {
                    visit(node.conditionBody);
                    visit(node.body);
                } else if (node.type === "repeat-until") {
                    visit(node.body);
                    visit(node.conditionBody);
                }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function exactConditionName(condition) {
        const text = String(condition || "").trim();
        let match = text.match(/^\(?\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)?$/);
        if (match) return match[1];
        match = text.match(/^not\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)$/);
        return match ? match[1] : null;
    }

    function rewriteCondition(condition, name, rhs) {
        return substituteSingleExpressionIdentifier(String(condition || ""), name, rhs);
    }

    function foldLiteralConditionLeaf(node, producerNode, facts) {
        const producer = producerNode?.type === "raw" ? producerNode.operation : null;
        const name = producer?.emittedTarget;
        if (!name || captured.has(name)) return false;
        if ((facts.reads.get(name) || 0) !== 1 || (facts.definitions.get(name) || 0) !== 1) return false;
        if (producer.kind !== "version-define" && producer.kind !== "epoch-start" && producer.kind !== "epoch-mutate") return false;
        const expression = parseOperationExpression(producer);
        if (!isMovableNumericForHeaderConstant(expression)) return false;
        const rhs = String(producer.rhs || "").trim();
        if (!rhs) return false;
        const rewritten = rewriteCondition(node.condition, name, rhs);
        if (!rewritten) return false;
        node.condition = rewritten;
        node.reads = [...new Set([...(node.reads || []).filter(read => read !== name), ...(producer.reads || [])])];
        return true;
    }

    let changed = true;
    while (changed) {
        changed = false;
        const facts = collectFacts(nodes);

        function visitBody(body, inLoop) {
            for (let index = 0; index < (body || []).length; index++) {
                const node = body[index];
                if (node.type === "if") {
                    if (index > 0 && foldLiteralConditionLeaf(node, body[index - 1], facts)) {
                        body.splice(index - 1, 1);
                        folds++;
                        changed = true;
                        return true;
                    }
                    if (index > 0) {
                        const name = exactConditionName(node.condition);
                        const producerNode = body[index - 1];
                        const producer = producerNode?.type === "raw" ? producerNode.operation : null;
                        if (name && producer?.emittedTarget === name &&
                            !captured.has(name) &&
                            (facts.reads.get(name) || 0) === 1 &&
                            (facts.definitions.get(name) || 0) === 1 &&
                            (producer.kind === "version-define" || producer.kind === "epoch-start" || producer.kind === "epoch-mutate")) {
                            const rhs = String(producer.rhs || "").trim();
                            const rewritten = rhs && parseTransitionExpression(rhs)?.expression
                                ? rewriteCondition(node.condition, name, rhs)
                                : null;
                            if (rewritten) {
                                node.condition = rewritten;
                                node.reads = [...(producer.reads || [])];
                                body.splice(index - 1, 1);
                                folds++;
                                changed = true;
                                return true;
                            }
                        }
                    }
                    if (visitBody(node.thenBody, inLoop)) return true;
                    if (visitBody(node.elseBody, inLoop)) return true;
                    continue;
                }
                if (node.type === "numeric-for" || node.type === "generic-for") {
                    if (visitBody(node.body, true)) return true;
                    continue;
                }
                if (node.type === "while-guard") {
                    const conditionBody = node.conditionBody || [];
                    if (conditionBody.length && foldLiteralConditionLeaf(node, conditionBody[conditionBody.length - 1], facts)) {
                        conditionBody.pop();
                        folds++;
                        changed = true;
                        return true;
                    }
                    if (visitBody(node.conditionBody, false)) return true;
                    if (visitBody(node.body, true)) return true;
                    continue;
                }
                if (node.type === "repeat-until") {
                    const conditionBody = node.conditionBody || [];
                    if (conditionBody.length && foldLiteralConditionLeaf(node, conditionBody[conditionBody.length - 1], facts)) {
                        conditionBody.pop();
                        folds++;
                        changed = true;
                        return true;
                    }
                    if (visitBody(node.body, true)) return true;
                    if (visitBody(node.conditionBody, false)) return true;
                }
            }
            return false;
        }

        visitBody(nodes, false);
    }
    return folds;
}

const POST_CF_MEMBER_KEYWORDS = new Set(["and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while","continue"]);
function plainPostCfMemberName(node) {
    if (node?.type !== "StringLiteral") return null;
    const match = String(node.raw || "").match(/^["']([A-Za-z_][A-Za-z0-9_]*)["']$/);
    if (!match || POST_CF_MEMBER_KEYWORDS.has(match[1])) return null;
    return match[1];
}

function recoverStructuredPostCfFunctionDeclarations(nodes) {
    let folds = 0;

    function isDeclarationTarget(node) {
        if (node?.type === "Identifier") return true;
        return node?.type === "MemberExpression" && node.indexer === "." &&
            node.identifier?.type === "Identifier" && isDeclarationTarget(node.base);
    }

    function rewriteRaw(node) {
        const parsed = parseControlFlowStatement(node?.text);
        const statement = parsed?.statement;
        if (statement?.type !== "AssignmentStatement" || statement.variables?.length !== 1 || statement.init?.length !== 1) return;
        const target = statement.variables[0];
        const fn = statement.init[0];
        if (!isDeclarationTarget(target) || fn?.type !== "FunctionDeclaration" || fn.identifier != null) return;
        if (!Array.isArray(target.range) || !Array.isArray(fn.range)) return;
        const targetText = parsed.source.slice(target.range[0], target.range[1]);
        const fnText = parsed.source.slice(fn.range[0], fn.range[1]);
        if (!fnText.startsWith("function")) return;
        const text = `function ${targetText}${fnText.slice("function".length)}`;
        if (!parseControlFlowStatement(text)) return;
        node.text = text;
        if (node.operation) node.operation.emittedText = text;
        folds++;
    }

    function visitBody(body) {
        for (const node of body || []) {
            if (node?.type === "raw") rewriteRaw(node);
            if (node?.type === "if") { visitBody(node.thenBody); visitBody(node.elseBody); }
            else if (node?.type === "numeric-for" || node?.type === "generic-for") visitBody(node.body);
            else if (node?.type === "while-guard") { visitBody(node.conditionBody); visitBody(node.body); }
            else if (node?.type === "repeat-until") { visitBody(node.body); visitBody(node.conditionBody); }
        }
    }

    visitBody(nodes);
    return folds;
}

function recoverStructuredPostCfStaticMembers(nodes) {
    let folds = 0;
    function rewriteRaw(node) {
        const parsed = parseControlFlowStatement(node?.text);
        const statement = parsed?.statement;
        if (!statement) return;
        const edits = [];
        function scan(astNode, parent = null) {
            if (!isNode(astNode)) return;
            if (astNode.type === "FunctionDeclaration") return;
            if (astNode.type === "IndexExpression" && astNode.base?.type === "Identifier") {
                const member = plainPostCfMemberName(astNode.index);
                if (member && Array.isArray(astNode.range)) {
                    edits.push({ start: astNode.range[0], end: astNode.range[1], replacement: `${astNode.base.name}.${member}` });
                    return;
                }
            }
            if (astNode.type === "TableKey") {
                const member = plainPostCfMemberName(astNode.key);
                if (member && Array.isArray(astNode.range) && Array.isArray(astNode.value?.range)) {
                    const valueText = parsed.source.slice(astNode.value.range[0], astNode.value.range[1]);
                    edits.push({ start: astNode.range[0], end: astNode.range[1], replacement: `${member} = ${valueText}` });
                    return;
                }
            }
            for (const key of Object.keys(astNode)) {
                if (key === "loc" || key === "range") continue;
                const value = astNode[key];
                if (Array.isArray(value)) for (const child of value) scan(child, astNode);
                else if (isNode(value)) scan(value, astNode);
            }
        }
        scan(statement);
        if (!edits.length) return;
        const text = applyTextEdits(parsed.source, edits);
        if (!parseControlFlowStatement(text)) return;
        node.text = text;
        if (node.operation) node.operation.emittedText = text;
        folds += edits.length;
    }
    function rewriteExpressionField(node, field) {
        let source = String(node?.[field] ?? "");
        if (!source) return;
        let changed = 0;
        while (true) {
            const parsed = parseTransitionExpression(source);
            if (!parsed?.expression) break;
            const prefixLength = parsed.source.length - source.length;
            let best = null;
            function scan(astNode) {
                if (!isNode(astNode) || astNode.type === "FunctionDeclaration") return;
                if (astNode.type === "IndexExpression" && Array.isArray(astNode.range) && Array.isArray(astNode.base?.range)) {
                    const member = plainPostCfMemberName(astNode.index);
                    if (member) {
                        const start = astNode.range[0] - prefixLength;
                        const end = astNode.range[1] - prefixLength;
                        const baseStart = astNode.base.range[0] - prefixLength;
                        const baseEnd = astNode.base.range[1] - prefixLength;
                        if (start >= 0 && end <= source.length && baseStart >= 0 && baseEnd <= source.length) {
                            const candidate = {
                                start,
                                end,
                                replacement: `${source.slice(baseStart, baseEnd)}.${member}`,
                                span: end - start,
                            };
                            if (!best || candidate.span < best.span) best = candidate;
                        }
                    }
                }
                for (const [key, value] of Object.entries(astNode)) {
                    if (key === "range" || key === "loc") continue;
                    if (Array.isArray(value)) for (const child of value) scan(child);
                    else if (isNode(value)) scan(value);
                }
            }
            scan(parsed.expression);
            if (!best) break;
            const rewritten = source.slice(0, best.start) + best.replacement + source.slice(best.end);
            if (!parseTransitionExpression(rewritten)?.expression) break;
            source = rewritten;
            changed++;
        }
        if (!changed) return;
        node[field] = source;
        folds += changed;
    }
    function visitBody(body) {
        for (const node of body || []) {
            if (node?.type === "raw") rewriteRaw(node);
            if (node?.type === "if") {
                rewriteExpressionField(node, "condition");
                visitBody(node.thenBody);
                visitBody(node.elseBody);
            } else if (node?.type === "numeric-for") {
                rewriteExpressionField(node, "initial");
                rewriteExpressionField(node, "limit");
                if (node.step != null) rewriteExpressionField(node, "step");
                visitBody(node.body);
            } else if (node?.type === "generic-for") {
                for (let index = 0; index < (node.expressions || []).length; index++) rewriteExpressionField(node.expressions, index);
                visitBody(node.body);
            } else if (node?.type === "while-guard") {
                rewriteExpressionField(node, "condition");
                visitBody(node.conditionBody);
                visitBody(node.body);
            } else if (node?.type === "repeat-until") {
                rewriteExpressionField(node, "condition");
                visitBody(node.body);
                visitBody(node.conditionBody);
            }
        }
    }
    visitBody(nodes);
    return folds;
}

function recoverStructuredGenericForGlobalMethodTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node?.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node?.type === "if") { visit(node.thenBody); visit(node.elseBody); }
                else if (node?.type === "numeric-for" || node?.type === "generic-for") visit(node.body);
                else if (node?.type === "while-guard" || node?.type === "repeat-until") { visit(node.conditionBody); visit(node.body); }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function staticMember(expression, baseName) {
        if (expression?.type === "MemberExpression" && expression.base?.type === "Identifier" &&
            expression.base.name === baseName && expression.identifier?.type === "Identifier") {
            const name = expression.identifier.name;
            return /^[A-Za-z_][A-Za-z0-9_]*$/.test(name) && !POST_CF_MEMBER_KEYWORDS.has(name) ? name : null;
        }
        if (expression?.type === "IndexExpression" && expression.base?.type === "Identifier" && expression.base.name === baseName) {
            return plainPostCfMemberName(expression.index);
        }
        return null;
    }

    function isSyntheticSnapshot(node) {
        const operation = node?.type === "raw" ? node.operation : null;
        const expression = operation ? parseOperationExpression(operation) : null;
        return !!operation && (
            staticArgsIndex(expression) !== null ||
            (operation.returnSinkSafe === true && expression?.type === "Identifier" && expression.name === "args")
        );
    }

    function recoverHeader(body, loopIndex, facts) {
        const loop = body[loopIndex];
        if (loop?.type !== "generic-for" || (loop.expressions || []).length !== 1) return false;

        const definitions = new Map();
        for (let index = 0; index < loopIndex; index++) {
            const node = body[index];
            const target = node?.type === "raw" ? node.operation?.emittedTarget : null;
            if (!target || definitions.has(target)) continue;
            definitions.set(target, { node, operation: node.operation, index });
        }

        const consumedNodes = new Set();
        const expectedReads = new Map();
        const active = new Set();
        let earliest = loopIndex;

        function noteRead(name, count = 1) {
            expectedReads.set(name, (expectedReads.get(name) || 0) + count);
        }

        function expressionText(rhs, astNode) {
            return sourceTextForParsedExpressionNode(String(rhs || ""), astNode);
        }

        function recoverArgument(arg, lowerBound, upperBound) {
            if (arg?.type !== "Identifier") return expressionText(loop.expressions[0], arg);
            const item = definitions.get(arg.name);
            if (!item || item.index <= lowerBound || item.index >= upperBound || captured.has(arg.name)) return arg.name;
            if ((facts.definitions.get(arg.name) || 0) !== 1 || item.operation?.returnSinkSafe !== true) return null;
            const expression = parseOperationExpression(item.operation);
            if (!expression || !["NumericLiteral", "StringLiteral", "BooleanLiteral", "NilLiteral"].includes(expression.type)) return null;
            noteRead(arg.name);
            consumedNodes.add(item.node);
            earliest = Math.min(earliest, item.index);
            return String(item.operation.rhs || "").trim();
        }

        function recoverValue(name, useIndex) {
            if (!name || active.has(name) || captured.has(name)) return null;
            const item = definitions.get(name);
            if (!item || item.index >= useIndex || (facts.definitions.get(name) || 0) !== 1) return null;
            const operation = item.operation || {};
            const rhs = String(operation.rhs || "").trim();
            const expression = parseOperationExpression(operation);
            if (!expression) return null;
            active.add(name);
            let result = null;

            const globalName = operation.compilerGlobalLookupRecovered;
            if (typeof globalName === "string" && /^[A-Za-z_][A-Za-z0-9_]*$/.test(globalName) &&
                !POST_CF_MEMBER_KEYWORDS.has(globalName) && rhs === globalName) {
                result = globalName;
            } else if ((expression.type === "MemberExpression" || expression.type === "IndexExpression") && expression.base?.type === "Identifier") {
                const baseName = expression.base.name;
                const member = staticMember(expression, baseName);
                if (member) {
                    noteRead(baseName);
                    const base = recoverValue(baseName, item.index);
                    if (base) result = `${base}.${member}`;
                }
            } else if (expression.type === "CallExpression" && expression.base?.type === "Identifier") {
                result = recoverCall(expression, item.index, rhs);
            }

            active.delete(name);
            if (!result) return null;
            consumedNodes.add(item.node);
            earliest = Math.min(earliest, item.index);
            return result;
        }

        function recoverCall(call, consumerIndex, source) {
            if (call?.base?.type !== "Identifier") return null;
            const methodName = call.base.name;
            const methodItem = definitions.get(methodName);
            if (!methodItem || methodItem.index >= consumerIndex || captured.has(methodName) ||
                (facts.definitions.get(methodName) || 0) !== 1) return null;
            const args = call.arguments || [];
            if (!args.length || args[0]?.type !== "Identifier") return null;
            const receiverName = args[0].name;
            const methodExpression = parseOperationExpression(methodItem.operation);
            const member = staticMember(methodExpression, receiverName);
            if (!member) return null;

            noteRead(methodName);
            noteRead(receiverName, 2);
            const receiver = recoverValue(receiverName, methodItem.index);
            if (!receiver) return null;

            const sourceText = String(source || "");
            const callPrefix = parseTransitionExpression(sourceText)?.source.length - sourceText.length;
            const renderedArgs = [];
            for (const arg of args.slice(1)) {
                let text = null;
                if (arg?.type === "Identifier") {
                    text = recoverArgument(arg, methodItem.index, consumerIndex);
                    if (text === arg.name) noteRead(arg.name);
                } else if (Array.isArray(arg?.range)) {
                    text = sourceText.slice(arg.range[0] - callPrefix, arg.range[1] - callPrefix);
                }
                if (text == null) return null;
                renderedArgs.push(text);
            }

            consumedNodes.add(methodItem.node);
            earliest = Math.min(earliest, methodItem.index);
            const rendered = `${receiver}:${member}(${renderedArgs.join(", ")})`;
            return parseTransitionExpression(rendered)?.expression ? rendered : null;
        }

        const source = String(loop.expressions[0] || "");
        const parsed = parseTransitionExpression(source);
        const call = parsed?.expression;
        const recovered = recoverCall(call, loopIndex, source);
        if (!recovered) return false;

        for (const [name, expected] of expectedReads) {
            if ((facts.reads.get(name) || 0) !== expected) return false;
        }
        for (let index = earliest; index < loopIndex; index++) {
            const node = body[index];
            if (consumedNodes.has(node) || isSyntheticSnapshot(node)) continue;
            return false;
        }

        loop.expressions[0] = recovered;
        loop.reads = [...new Set((loop.reads || []).filter(name => !expectedReads.has(name)))];
        for (let index = loopIndex - 1; index >= earliest; index--) {
            if (consumedNodes.has(body[index])) body.splice(index, 1);
        }
        folds += consumedNodes.size;
        return true;
    }

    let changed = true;
    while (changed) {
        changed = false;
        const facts = collectFacts(nodes);
        function visit(body) {
            for (let index = 0; index < (body || []).length; index++) {
                if (recoverHeader(body, index, facts)) return true;
                const node = body[index];
                if (node?.type === "if" && (visit(node.thenBody) || visit(node.elseBody))) return true;
                if ((node?.type === "numeric-for" || node?.type === "generic-for") && visit(node.body)) return true;
                if ((node?.type === "while-guard" || node?.type === "repeat-until") && (visit(node.conditionBody) || visit(node.body))) return true;
            }
            return false;
        }
        changed = visit(nodes);
    }
    return folds;
}
function recoverStructuredPostCfNamecalls(nodes) {
    let folds = 0;

    function exactNamecallEdit(source, call, prefixLength = 0) {
        if (call?.type !== "CallExpression" || call.base?.type !== "IndexExpression" || call.base.base?.type !== "Identifier") return null;
        const base = call.base.base;
        const method = plainPostCfMemberName(call.base.index);
        const args = call.arguments || [];
        const self = args[0];
        if (!method || self?.type !== "Identifier" || self.name !== base.name || !Array.isArray(call.range)) return null;
        const remaining = args.slice(1).map(arg => {
            if (!Array.isArray(arg?.range)) return null;
            return source.slice(arg.range[0] - prefixLength, arg.range[1] - prefixLength);
        });
        if (remaining.some(text => text === null)) return null;
        return {
            start: call.range[0] - prefixLength,
            end: call.range[1] - prefixLength,
            replacement: `${base.name}:${method}(${remaining.join(", ")})`,
        };
    }

    function recoverExpression(text) {
        const source = String(text || "");
        const parsed = parseTransitionExpression(source);
        if (!parsed?.expression) return null;
        const prefixLength = parsed.source.length - source.length;
        const edits = [];

        function visit(astNode) {
            if (!astNode || typeof astNode !== "object") return;
            const edit = exactNamecallEdit(source, astNode, prefixLength);
            if (edit) edits.push(edit);
            for (const [key, value] of Object.entries(astNode)) {
                if (key === "range" || key === "loc") continue;
                if (Array.isArray(value)) for (const child of value) visit(child);
                else if (value && typeof value === "object") visit(value);
            }
        }
        visit(parsed.expression);
        if (!edits.length) return null;

        // Keep only non-overlapping innermost calls. This preserves nested argument
        // text instead of letting an outer replacement overwrite a proven inner edit.
        edits.sort((a, b) => (a.end - a.start) - (b.end - b.start) || a.start - b.start);
        const selected = [];
        for (const edit of edits) {
            if (selected.some(other => !(edit.end <= other.start || edit.start >= other.end))) continue;
            selected.push(edit);
        }
        selected.sort((a, b) => b.start - a.start);
        let rewritten = source;
        for (const edit of selected) rewritten = rewritten.slice(0, edit.start) + edit.replacement + rewritten.slice(edit.end);
        if (!parseTransitionExpression(rewritten)?.expression) return null;
        return { text: rewritten, count: selected.length };
    }

    function recoverRaw(node) {
        const parsed = parseControlFlowStatement(node.text);
        const statement = parsed?.statement;
        let call = null;
        if (statement?.type === "CallStatement") call = statement.expression;
        else if ((statement?.type === "LocalStatement" || statement?.type === "AssignmentStatement") && statement.init?.length === 1) call = statement.init[0];
        const edit = exactNamecallEdit(parsed?.source || "", call, 0);
        if (!edit) return;
        const text = parsed.source.slice(0, edit.start) + edit.replacement + parsed.source.slice(edit.end);
        if (!parseControlFlowStatement(text)) return;
        node.text = text;
        if (node.operation) {
            node.operation.emittedText = text;
            if (statement.type !== "CallStatement") node.operation.rhs = edit.replacement;
        }
        folds++;
    }

    function recoverField(node, field) {
        const recovered = recoverExpression(node?.[field]);
        if (!recovered) return;
        node[field] = recovered.text;
        folds += recovered.count;
    }

    function visitBody(body) {
        for (const node of body || []) {
            if (node?.type === "raw") recoverRaw(node);
            if (node?.type === "if") {
                recoverField(node, "condition");
                visitBody(node.thenBody);
                visitBody(node.elseBody);
            } else if (node?.type === "numeric-for") {
                recoverField(node, "initial");
                recoverField(node, "limit");
                recoverField(node, "step");
                visitBody(node.body);
            } else if (node?.type === "generic-for") {
                for (let index = 0; index < (node.expressions || []).length; index++) {
                    const recovered = recoverExpression(node.expressions[index]);
                    if (!recovered) continue;
                    node.expressions[index] = recovered.text;
                    folds += recovered.count;
                }
                visitBody(node.body);
            } else if (node?.type === "while-guard") {
                recoverField(node, "condition");
                visitBody(node.conditionBody);
                visitBody(node.body);
            } else if (node?.type === "repeat-until") {
                recoverField(node, "condition");
                visitBody(node.body);
                visitBody(node.conditionBody);
            }
        }
    }
    visitBody(nodes);
    return folds;
}

function recoverStructuredPostCfClosureDestinationTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node.type === "if") { visit(node.thenBody); visit(node.elseBody); }
                else if (node.type === "numeric-for" || node.type === "generic-for") visit(node.body);
                else if (node.type === "while-guard") { visit(node.conditionBody); visit(node.body); }
                else if (node.type === "repeat-until") { visit(node.body); visit(node.conditionBody); }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function closureProducerInfo(node, tempName) {
        const parsed = parseControlFlowStatement(node?.text);
        const statement = parsed?.statement;
        if (statement?.type !== "LocalStatement" || statement.variables?.length !== 1 || statement.init?.length !== 1) return null;
        const variable = statement.variables[0];
        const init = statement.init[0];
        if (variable?.type !== "Identifier" || variable.name !== tempName || init?.type !== "FunctionDeclaration" || !Array.isArray(init.range)) return null;
        return { functionText: parsed.source.slice(init.range[0], init.range[1]) };
    }

    function closureConsumerInfo(node, tempName) {
        const parsed = parseControlFlowStatement(node?.text);
        const statement = parsed?.statement;
        if ((statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") || statement.variables?.length !== 1 || statement.init?.length !== 1) return null;
        const rhs = statement.init[0];
        const lhs = statement.variables[0];
        if (rhs?.type !== "Identifier" || rhs.name !== tempName || !Array.isArray(lhs?.range)) return null;
        if (!["Identifier", "MemberExpression", "IndexExpression"].includes(lhs.type)) return null;
        return {
            prefix: statement.type === "LocalStatement" ? "local " : "",
            targetText: parsed.source.slice(lhs.range[0], lhs.range[1]),
        };
    }

    let changed = true;
    while (changed) {
        changed = false;
        const facts = collectFacts(nodes);
        function visitBody(body) {
            for (let index = 1; index < (body || []).length; index++) {
                const producerNode = body[index - 1];
                const consumerNode = body[index];
                if (producerNode?.type === "raw" && consumerNode?.type === "raw") {
                    const producer = producerNode.operation || {};
                    const consumer = consumerNode.operation || {};
                    const tempName = producer.emittedTarget;
                    if (tempName && !captured.has(tempName) && (facts.reads.get(tempName) || 0) === 1 && (facts.definitions.get(tempName) || 0) === 1) {
                        const producerInfo = closureProducerInfo(producerNode, tempName);
                        const consumerInfo = producerInfo ? closureConsumerInfo(consumerNode, tempName) : null;
                        if (consumerInfo) {
                            const emittedText = `${consumerInfo.prefix}${consumerInfo.targetText} = ${producerInfo.functionText}`;
                            const nextReads = (consumerNode.reads || []).filter(name => name !== tempName);
                            consumerNode.text = emittedText;
                            consumerNode.reads = nextReads;
                            consumer.emittedText = emittedText;
                            consumer.rhs = producerInfo.functionText;
                            consumer.reads = [...nextReads];
                            body.splice(index - 1, 1);
                            folds++;
                            changed = true;
                            return true;
                        }
                    }
                }
                const node = body[index];
                if (node?.type === "if") { if (visitBody(node.thenBody) || visitBody(node.elseBody)) return true; }
                else if (node?.type === "numeric-for" || node?.type === "generic-for") { if (visitBody(node.body)) return true; }
                else if (node?.type === "while-guard") { if (visitBody(node.conditionBody) || visitBody(node.body)) return true; }
                else if (node?.type === "repeat-until") { if (visitBody(node.body) || visitBody(node.conditionBody)) return true; }
            }
            return false;
        }
        visitBody(nodes);
    }
    return folds;
}

function recoverStructuredPostCfDeadClosureTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const localDeclarations = new Set();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw") {
                    const parsed = parseControlFlowStatement(node.text);
                    const statement = parsed?.statement;
                    if (statement?.type === "LocalStatement") {
                        for (const variable of statement.variables || []) {
                            if (variable?.type === "Identifier") localDeclarations.add(variable.name);
                        }
                    }
                }
                if (node.type === "if") { visit(node.thenBody); visit(node.elseBody); }
                else if (node.type === "numeric-for" || node.type === "generic-for") visit(node.body);
                else if (node.type === "while-guard") { visit(node.conditionBody); visit(node.body); }
                else if (node.type === "repeat-until") { visit(node.body); visit(node.conditionBody); }
            }
        }
        visit(root);
        return { reads, localDeclarations };
    }

    function deadClosureProducerInfo(node) {
        const operation = node?.operation || {};
        const name = operation.emittedTarget;
        if (!name) return null;
        const parsed = parseControlFlowStatement(node?.text);
        const statement = parsed?.statement;
        if (statement?.type !== "LocalStatement" || statement.variables?.length !== 1 || statement.init?.length !== 1) return null;
        const variable = statement.variables[0];
        const init = statement.init[0];
        if (variable?.type !== "Identifier" || variable.name !== name || init?.type !== "FunctionDeclaration") return null;
        return { name };
    }

    function deadLocalConsumerInfo(node, tempName, facts) {
        const parsed = parseControlFlowStatement(node?.text);
        const statement = parsed?.statement;
        if ((statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") || statement.variables?.length !== 1 || statement.init?.length !== 1) return null;
        const lhs = statement.variables[0];
        const rhs = statement.init[0];
        if (lhs?.type !== "Identifier" || rhs?.type !== "Identifier" || rhs.name !== tempName) return null;
        const target = lhs.name;
        if (captured.has(target) || (facts.reads.get(target) || 0) !== 0) return null;
        if (statement.type === "AssignmentStatement" && !facts.localDeclarations.has(target)) return null;
        return { target };
    }

    let changed = true;
    while (changed) {
        changed = false;
        const facts = collectFacts(nodes);
        function visitBody(body) {
            for (let index = 0; index < (body || []).length; index++) {
                const node = body[index];
                if (node?.type === "raw") {
                    const producer = deadClosureProducerInfo(node);
                    if (producer && !captured.has(producer.name)) {
                        const readCount = facts.reads.get(producer.name) || 0;
                        if (readCount === 0) {
                            body.splice(index, 1);
                            folds++;
                            changed = true;
                            return true;
                        }
                        if (readCount === 1) {
                            for (let consumerIndex = index + 1; consumerIndex < body.length; consumerIndex++) {
                                const consumerNode = body[consumerIndex];
                                if (consumerNode?.type !== "raw") continue;
                                const consumer = deadLocalConsumerInfo(consumerNode, producer.name, facts);
                                if (!consumer) continue;
                                body.splice(consumerIndex, 1);
                                body.splice(index, 1);
                                folds += 2;
                                changed = true;
                                return true;
                            }
                        }
                    }
                }
                if (node?.type === "if") { if (visitBody(node.thenBody) || visitBody(node.elseBody)) return true; }
                else if (node?.type === "numeric-for" || node?.type === "generic-for") { if (visitBody(node.body)) return true; }
                else if (node?.type === "while-guard") { if (visitBody(node.conditionBody) || visitBody(node.body)) return true; }
                else if (node?.type === "repeat-until") { if (visitBody(node.body) || visitBody(node.conditionBody)) return true; }
            }
            return false;
        }
        visitBody(nodes);
    }
    return folds;
}

function recoverStructuredPostCfDeadScalarLocals(nodes, graph, options = {}) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    const syntheticLocals = new Set(options.syntheticLocals || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        const localDeclarations = new Set();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw") {
                    if (node.operation?.emittedTarget) {
                        const name = node.operation.emittedTarget;
                        definitions.set(name, (definitions.get(name) || 0) + 1);
                    }
                    const parsed = parseControlFlowStatement(node.text);
                    const statement = parsed?.statement;
                    if (statement?.type === "LocalStatement") {
                        for (const variable of statement.variables || []) {
                            if (variable?.type === "Identifier") localDeclarations.add(variable.name);
                        }
                    }
                }
                if (node.type === "if") { visit(node.thenBody); visit(node.elseBody); }
                else if (node.type === "numeric-for" || node.type === "generic-for") visit(node.body);
                else if (node.type === "while-guard") { visit(node.conditionBody); visit(node.body); }
                else if (node.type === "repeat-until") { visit(node.body); visit(node.conditionBody); }
            }
        }
        visit(root);
        return { reads, definitions, localDeclarations };
    }

    function safeDeadInitializer(init, facts, operation) {
        if (!init) return false;
        if (init.type === "NilLiteral" || init.type === "NumericLiteral" || init.type === "StringLiteral" || init.type === "BooleanLiteral") return true;
        if (init.type !== "Identifier") return false;
        if (facts.localDeclarations.has(init.name) || captured.has(init.name)) return true;
        return syntheticLocals.has(init.name) && Boolean(operation?.registerEpoch) && /^(?:r\d+|__overflow_phys_\d+)$/.test(String(operation?.originalTarget || ""));
    }

    let changed = true;
    while (changed) {
        changed = false;
        const facts = collectFacts(nodes);
        function visitBody(body) {
            for (let index = 0; index < (body || []).length; index++) {
                const node = body[index];
                if (node?.type === "raw") {
                    const parsed = parseControlFlowStatement(node.text);
                    const statement = parsed?.statement;
                    const target = node.operation?.emittedTarget;
                    if (target && statement?.type === "LocalStatement" && statement.variables?.length === 1 && statement.init?.length === 1) {
                        const variable = statement.variables[0];
                        const init = statement.init[0];
                        if (variable?.type === "Identifier" && variable.name === target &&
                            !captured.has(target) && (facts.reads.get(target) || 0) === 0 &&
                            (facts.definitions.get(target) || 0) === 1 && safeDeadInitializer(init, facts, node.operation)) {
                            body.splice(index, 1);
                            folds++;
                            changed = true;
                            return true;
                        }
                    }
                }
                if (node?.type === "if") { if (visitBody(node.thenBody) || visitBody(node.elseBody)) return true; }
                else if (node?.type === "numeric-for" || node?.type === "generic-for") { if (visitBody(node.body)) return true; }
                else if (node?.type === "while-guard") { if (visitBody(node.conditionBody) || visitBody(node.body)) return true; }
                else if (node?.type === "repeat-until") { if (visitBody(node.body) || visitBody(node.conditionBody)) return true; }
            }
            return false;
        }
        visitBody(nodes);
    }
    return folds;
}

function recoverStructuredPostCfCopyScalarTemps(nodes, graph) {
    const captured = new Set(graph?.recoveredUpvalueBindings || []);
    let folds = 0;

    function collectFacts(root) {
        const reads = new Map();
        const definitions = new Map();
        function visit(body) {
            for (const node of body || []) {
                for (const name of node.reads || []) reads.set(name, (reads.get(name) || 0) + 1);
                if (node.type === "raw" && node.operation?.emittedTarget) {
                    const name = node.operation.emittedTarget;
                    definitions.set(name, (definitions.get(name) || 0) + 1);
                }
                if (node.type === "if") {
                    visit(node.thenBody);
                    visit(node.elseBody);
                } else if (node.type === "numeric-for" || node.type === "generic-for") {
                    visit(node.body);
                } else if (node.type === "while-guard") {
                    visit(node.conditionBody);
                    visit(node.body);
                } else if (node.type === "repeat-until") {
                    visit(node.body);
                    visit(node.conditionBody);
                }
            }
        }
        visit(root);
        return { reads, definitions };
    }

    function isScalarExpression(node) {
        if (!node) return false;
        if (node.type === "Identifier" || node.type === "NumericLiteral" || node.type === "StringLiteral" ||
            node.type === "BooleanLiteral" || node.type === "NilLiteral") return true;
        if (node.type === "UnaryExpression") return isScalarExpression(node.argument);
        if (node.type === "BinaryExpression" || node.type === "LogicalExpression") return isScalarExpression(node.left) && isScalarExpression(node.right);
        return false;
    }

    function isLeadingUse(node, name) {
        if (!node) return false;
        if (node.type === "Identifier") return node.name === name;
        if (node.type === "UnaryExpression") return isLeadingUse(node.argument, name);
        if (node.type === "BinaryExpression" || node.type === "LogicalExpression") return isLeadingUse(node.left, name);
        return false;
    }

    function escapeRegex(text) {
        return String(text).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    }

    let changed = true;
    while (changed) {
        changed = false;
        const facts = collectFacts(nodes);

        function visitBody(body) {
            for (let index = 1; index < (body || []).length; index++) {
                const producerNode = body[index - 1];
                const consumerNode = body[index];
                if (producerNode?.type === "raw" && consumerNode?.type === "raw") {
                    const producer = producerNode.operation || {};
                    const consumer = consumerNode.operation || {};
                    const target = producer.emittedTarget;
                    const source = String(producer.rhs || "").trim();
                    const consumerTarget = consumer.emittedTarget;
                    const rhs = String(consumer.rhs || "").trim();
                    const parsed = rhs ? parseTransitionExpression(rhs) : null;
                    const expression = parsed?.expression;

                    if (target && consumerTarget === target && !captured.has(target) &&
                        expression?.type === "LogicalExpression" && isLeadingUse(expression, target) &&
                        collectExpressionVariableIdentifierRanges(expression, target).length === 1) {
                        const producerExpression = source ? parseTransitionExpression(source)?.expression : null;
                        const localProducerPattern = new RegExp(`^\\s*local\\s+${escapeRegex(target)}\\s*=\\s*${escapeRegex(source)}\\s*;?\\s*$`);
                        const consumerPattern = new RegExp(`^\\s*${escapeRegex(target)}\\s*=\\s*${escapeRegex(rhs)}\\s*;?\\s*$`);
                        const rewritten = producerExpression && isScalarExpression(producerExpression)
                            ? substituteSingleExpressionIdentifier(rhs, target, source)
                            : null;
                        if (rewritten && localProducerPattern.test(String(producerNode.text || "")) &&
                            consumerPattern.test(String(consumerNode.text || ""))) {
                            const nextReads = [];
                            for (const name of consumerNode.reads || []) {
                                if (name === target) nextReads.push(...(producer.reads || []));
                                else nextReads.push(name);
                            }
                            producer.rhs = rewritten;
                            producer.reads = [...nextReads];
                            producer.emittedText = `local ${target} = ${rewritten}`;
                            producerNode.text = producer.emittedText;
                            producerNode.reads = [...nextReads];
                            body.splice(index, 1);
                            folds++;
                            changed = true;
                            return true;
                        }
                    }
                    const targetUses = expression && target
                        ? collectExpressionVariableIdentifierRanges(expression, target)
                        : [];
                    const producerExpression = source ? parseTransitionExpression(source)?.expression : null;
                    const sourceIsIdentifier = /^[A-Za-z_][A-Za-z0-9_]*$/.test(source);
                    const sourceIsLocal = sourceIsIdentifier && ((facts.definitions.get(source) || 0) > 0 || captured.has(source));
                    const producerIsSafeCopy = sourceIsIdentifier && source !== target && sourceIsLocal;
                    const producerIsDirectRightLiteral = producerExpression &&
                        (producerExpression.type === "NumericLiteral" || producerExpression.type === "StringLiteral" ||
                         producerExpression.type === "BooleanLiteral" || producerExpression.type === "NilLiteral") &&
                        (expression?.type === "BinaryExpression" || expression?.type === "LogicalExpression") &&
                        isIdentifier(expression.right) && expression.right.name === target;
                    const producerIsSafeScalar = producerExpression &&
                        (producerExpression.type === "BinaryExpression" || producerExpression.type === "UnaryExpression" ||
                         producerExpression.type === "LogicalExpression" || producerIsDirectRightLiteral) &&
                        isScalarExpression(producerExpression);
                    if (target && consumerTarget &&
                        (producerIsSafeCopy || producerIsSafeScalar) &&
                        !captured.has(target) &&
                        (facts.reads.get(target) || 0) === 1 &&
                        (facts.definitions.get(target) || 0) === 1 &&
                        (producer.kind === "version-define" || producer.kind === "epoch-start" || producer.kind === "epoch-mutate") &&
                        (consumer.kind === "version-define" || consumer.kind === "epoch-start" || consumer.kind === "epoch-mutate") &&
                        expression && isScalarExpression(expression) && (isLeadingUse(expression, target) || producerIsDirectRightLiteral) && targetUses.length === 1) {
                        const localPattern = new RegExp(`^\\s*local\\s+${escapeRegex(target)}\\s*=\\s*${escapeRegex(source)}\\s*;?\\s*$`);
                        const consumerPattern = new RegExp(`^\\s*(local\\s+)?${escapeRegex(consumerTarget)}\\s*=\\s*${escapeRegex(rhs)}\\s*;?\\s*$`);
                        const consumerMatch = String(consumerNode.text || "").match(consumerPattern);
                        const rewritten = substituteSingleExpressionIdentifier(rhs, target, source);
                        if (localPattern.test(String(producerNode.text || "")) && consumerMatch && rewritten) {
                            const replacementReads = producerIsSafeCopy ? [source] : [...(producer.reads || [])];
                            const nextReads = [];
                            for (const name of consumerNode.reads || []) {
                                if (name === target) nextReads.push(...replacementReads);
                                else nextReads.push(name);
                            }
                            consumerNode.text = `${consumerMatch[1] || ""}${consumerTarget} = ${rewritten}`;
                            consumerNode.reads = nextReads;
                            consumer.rhs = rewritten;
                            consumer.reads = [...nextReads];
                            consumer.emittedText = consumerNode.text;
                            body.splice(index - 1, 1);
                            folds++;
                            changed = true;
                            return true;
                        }
                    }
                }

                const node = body[index];
                if (node?.type === "if") {
                    if (visitBody(node.thenBody) || visitBody(node.elseBody)) return true;
                } else if (node?.type === "numeric-for" || node?.type === "generic-for") {
                    if (visitBody(node.body)) return true;
                } else if (node?.type === "while-guard") {
                    if (visitBody(node.conditionBody) || visitBody(node.body)) return true;
                } else if (node?.type === "repeat-until") {
                    if (visitBody(node.body) || visitBody(node.conditionBody)) return true;
                }
            }
            if ((body || []).length === 1) {
                const node = body[0];
                if (node?.type === "if") return visitBody(node.thenBody) || visitBody(node.elseBody);
                if (node?.type === "numeric-for" || node?.type === "generic-for") return visitBody(node.body);
                if (node?.type === "while-guard") return visitBody(node.conditionBody) || visitBody(node.body);
                if (node?.type === "repeat-until") return visitBody(node.body) || visitBody(node.conditionBody);
            }
            return false;
        }

        visitBody(nodes);
    }
    return folds;
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

function removeCompilerPosPreservationOperations(graph) {
    const stateName = graph?.stateName;
    if (!stateName || !Array.isArray(graph?.states)) return { removed: 0, saveCount: 0, restoreCount: 0, orphanSaveCount: 0 };

    const positions = [];
    for (const state of graph.states) {
        for (const operation of state.operations || []) positions.push({ state, operation });
    }

    const readCounts = new Map();
    for (const { operation } of positions) {
        for (const name of operation.reads || []) readCounts.set(name, (readCounts.get(name) || 0) + 1);
    }

    const saveByTarget = new Map();
    for (const item of positions) {
        const operation = item.operation;
        if (!operation?.emittedTarget || operation.originalTarget === stateName) continue;
        if (String(operation.rhs || '').trim() !== stateName) continue;
        saveByTarget.set(operation.emittedTarget, item);
    }

    const restoresBySavedTarget = new Map();
    for (const item of positions) {
        const operation = item.operation;
        if (operation?.originalTarget !== stateName || operation.kind === 'state-transition' || !operation.emittedTarget) continue;
        const savedTarget = String(operation.rhs || '').trim();
        if (!saveByTarget.has(savedTarget)) continue;
        if ((readCounts.get(operation.emittedTarget) || 0) !== 0) continue;
        let list = restoresBySavedTarget.get(savedTarget);
        if (!list) restoresBySavedTarget.set(savedTarget, list = []);
        list.push(item);
    }

    const removals = new Set();
    let saveCount = 0;
    let restoreCount = 0;
    let orphanSaveCount = 0;
    for (const [savedTarget, save] of saveByTarget) {
        const restores = restoresBySavedTarget.get(savedTarget) || [];
        const totalReads = readCounts.get(savedTarget) || 0;
        const restoreReads = restores.reduce((sum, item) =>
            sum + ((item.operation.reads || []).filter(name => name === savedTarget).length), 0);

        if (restores.length && totalReads === restoreReads) {
            removals.add(save.operation);
            saveCount++;
            for (const restore of restores) {
                removals.add(restore.operation);
                restoreCount++;
            }
            continue;
        }

        if (totalReads === 0) {
            removals.add(save.operation);
            saveCount++;
            orphanSaveCount++;
        }
    }

    if (removals.size) {
        for (const state of graph.states) {
            state.operations = (state.operations || []).filter(operation => !removals.has(operation));
        }
    }

    return { removed: removals.size, saveCount, restoreCount, orphanSaveCount };
}

function hoistEscapingEpochDeclarations(nodes) {
    let nextScopeId = 1;
    const scopes = new Map([[0, { id: 0, parentId: null, insertionBody: nodes }]]);
    const rawLocations = new Map();
    const loopVariables = new Set();

    function childScope(parentId, insertionBody) {
        const id = nextScopeId++;
        scopes.set(id, { id, parentId, insertionBody });
        return id;
    }

    function indexStructure(body, scopeId) {
        for (const node of body || []) {
            if (node.type === "raw") {
                rawLocations.set(node, { scopeId, body });
                continue;
            }
            if (node.type === "numeric-for") {
                loopVariables.add(node.variable);
                indexStructure(node.body, childScope(scopeId, node.body));
                continue;
            }
            if (node.type === "generic-for") {
                for (const variable of node.variables || []) loopVariables.add(variable);
                indexStructure(node.body, childScope(scopeId, node.body));
                continue;
            }
            if (node.type === "while-guard") {
                const scope = childScope(scopeId, node.conditionBody);
                indexStructure(node.conditionBody, scope);
                indexStructure(node.body, scope);
                continue;
            }
            if (node.type === "repeat-until") {
                const scope = childScope(scopeId, node.body);
                indexStructure(node.body, scope);
                indexStructure(node.conditionBody, scope);
                continue;
            }
            if (node.type === "if") {
                indexStructure(node.thenBody, childScope(scopeId, node.thenBody));
                if (node.elseBody) indexStructure(node.elseBody, childScope(scopeId, node.elseBody));
            }
        }
    }
    indexStructure(nodes, 0);

    const candidates = new Map();
    for (const [node, location] of rawLocations) {
        const operation = node.operation || {};
        const name = operation.emittedTarget;
        if (!name || operation.kind !== "epoch-start" || !operation.registerEpoch) continue;
        if (!String(node.text || "").trimStart().startsWith("local ")) continue;
        if (candidates.has(name)) {
            candidates.get(name).invalid = true;
            continue;
        }
        candidates.set(name, {
            name,
            epoch: operation.registerEpoch,
            declarationNode: node,
            declarationScopeId: location.scopeId,
            occurrenceScopes: new Set(),
            invalid: loopVariables.has(name),
        });
    }
    if (!candidates.size) return { applied: false, safe: true, count: 0 };

    function recordReads(reads, scopeId) {
        for (const name of reads || []) {
            const candidate = candidates.get(name);
            if (candidate) candidate.occurrenceScopes.add(scopeId);
        }
    }

    function collectOccurrences(body, scopeId) {
        for (const node of body || []) {
            if (node.type === "raw") {
                const operation = node.operation || {};
                const candidate = candidates.get(operation.emittedTarget);
                if (candidate) {
                    if (operation.registerEpoch && operation.registerEpoch !== candidate.epoch) candidate.invalid = true;
                    else candidate.occurrenceScopes.add(scopeId);
                }
                recordReads(node.reads, scopeId);
                continue;
            }
            if (node.type === "numeric-for" || node.type === "generic-for") {
                recordReads(node.reads, scopeId);
                const child = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.body);
                if (child) collectOccurrences(node.body, child.id);
                continue;
            }
            if (node.type === "while-guard") {
                const child = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.conditionBody);
                if (!child) continue;
                collectOccurrences(node.conditionBody, child.id);
                recordReads(node.reads, child.id);
                collectOccurrences(node.body, child.id);
                continue;
            }
            if (node.type === "repeat-until") {
                const child = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.body);
                if (!child) continue;
                collectOccurrences(node.body, child.id);
                collectOccurrences(node.conditionBody, child.id);
                recordReads(node.reads, child.id);
                continue;
            }
            if (node.type === "if") {
                recordReads(node.reads, scopeId);
                const thenScope = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.thenBody);
                if (thenScope) collectOccurrences(node.thenBody, thenScope.id);
                if (node.elseBody) {
                    const elseScope = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.elseBody);
                    if (elseScope) collectOccurrences(node.elseBody, elseScope.id);
                }
            }
        }
    }
    collectOccurrences(nodes, 0);

    function ancestors(scopeId) {
        const result = [];
        let current = scopeId;
        while (current !== null && current !== undefined) {
            result.push(current);
            current = scopes.get(current)?.parentId ?? null;
        }
        return result;
    }

    function commonAncestor(scopeIds) {
        const ids = [...scopeIds];
        if (!ids.length) return null;
        const first = ancestors(ids[0]);
        for (const candidate of first) {
            if (ids.every(id => ancestors(id).includes(candidate))) return candidate;
        }
        return null;
    }

    let count = 0;
    for (const candidate of candidates.values()) {
        if (candidate.invalid) continue;
        candidate.occurrenceScopes.add(candidate.declarationScopeId);
        const targetScopeId = commonAncestor(candidate.occurrenceScopes);
        if (targetScopeId === null) continue;

        const declarationNode = candidate.declarationNode;
        const operation = declarationNode.operation || {};
        const rhs = operation.rhs;
        if (typeof rhs !== "string" || !rhs.trim()) continue;

        const needsHoist = targetScopeId !== candidate.declarationScopeId || candidate.occurrenceScopes.size > 1;
        if (!needsHoist) continue;

        const declarationOperation = {
            kind: "epoch-hoisted-declaration",
            originalTarget: operation.originalTarget,
            emittedTarget: candidate.name,
            registerEpoch: candidate.epoch,
            rhs: null,
            reads: [],
            emittedText: `local ${candidate.name}`,
            returnSinkSafe: false,
        };
        const targetBody = scopes.get(targetScopeId)?.insertionBody;
        if (!targetBody) continue;
        targetBody.unshift(rawNode(declarationOperation, null));

        const assignmentOperation = {
            ...operation,
            kind: "epoch-mutate",
            emittedText: `${candidate.name} = ${rhs}`,
        };
        declarationNode.operation = assignmentOperation;
        declarationNode.text = assignmentOperation.emittedText;
        declarationNode.reads = [...(assignmentOperation.reads || [])];
        count++;
    }

    return { applied: count > 0, safe: true, count };
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
            // Lua evaluates for expressions in the parent scope, then declares loop
            // variables in the loop-body scope. Ancestor declarations may be
            // shadowed, and separate sibling for-loops may legally reuse the same
            // emitted beta name. Keep unrelated raw locals rejected; the read-scope
            // validation below still proves every beta read sees an ancestor declaration.
            const unrelated = list.filter(declaration => !isAncestor(declaration.scopeId, parentScopeId));
            if (unrelated.some(declaration => declaration.kind !== "numeric-for")) {
                return "Beta name " + name + " has unrelated local declarations after structuring";
            }
        }
        list.push({ scopeId, sequence: declarationSequence, kind: "numeric-for" });
        return null;
    }

    function generatedConditionReads(condition) {
        const parsed = parseTransitionExpression(String(condition || '').trim());
        const names = new Set();
        function visitNode(node) {
            if (!node || typeof node !== 'object') return;
            if (node.type === 'Identifier' && /^(?:r_v\d+_\d+|o_v\d+_\d+)$/.test(node.name)) names.add(node.name);
            for (const [key, value] of Object.entries(node)) {
                if (key === 'range' || key === 'loc') continue;
                if (Array.isArray(value)) for (const child of value) visitNode(child);
                else if (value && typeof value === 'object') visitNode(value);
            }
        }
        visitNode(parsed?.expression);
        return [...names];
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
                if (!node.conditionBody.length) {
                    sequence++;
                    for (const name of [...new Set([...(node.reads || []), ...generatedConditionReads(node.condition)])]) reads.push({ name, scopeId, sequence });
                }
                const conditionError = visit(node.conditionBody, bodyScope);
                if (conditionError) return conditionError;
                if (node.conditionBody.length) {
                    sequence++;
                    for (const name of [...new Set([...(node.reads || []), ...generatedConditionReads(node.condition)])]) reads.push({ name, scopeId: bodyScope, sequence });
                }
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
                for (const name of [...new Set([...(node.reads || []), ...generatedConditionReads(node.condition)])]) reads.push({ name, scopeId: bodyScope, sequence });
                continue;
            }
            const structuredReads = node.type === "if"
                ? [...new Set([...(node.reads || []), ...generatedConditionReads(node.condition)])]
                : (node.reads || []);
            for (const name of structuredReads) reads.push({ name, scopeId, sequence });
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
        // A generated beta name without a declaration in this structured region
        // may be a proven outer lexical capture. Scope validation can reject only
        // names whose declaration ownership is visible in this region.
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
                if (partial.join !== null) {
                    join = partial.join;
                } else {
                    const trueReachesStop = reachesState(info.onTrue, stopState, reachableSets);
                    const falseReachesStop = reachesState(info.onFalse, stopState, reachableSets);
                    if (trueReachesStop || falseReachesStop) {
                        throw new Error('loop body branch has no unique continuation inside the requested region');
                    }
                    // Neither arm can reach the caller's continuation. Keep the
                    // proven immediate post-dominator: this nested branch terminates
                    // the current sequence through break/continue/return instead of
                    // reconverging at the caller stop.
                }
            }
            if (join === breakNode) join = exitNode;
            if (join === null || join === current) throw new Error('loop body branch has no unique join at state ' + String(current) + ' true=' + String(info.onTrue) + ' false=' + String(info.onFalse) + ' join=' + String(join));
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

function isMovableNumericForHeaderConstant(expression) {
    if (!expression) return false;
    if (expression.type === "NumericLiteral" || expression.type === "StringLiteral" || expression.type === "BooleanLiteral" || expression.type === "NilLiteral") return true;
    if (expression.type === "UnaryExpression" && (expression.operator === "-" || expression.operator === "not")) {
        return isMovableNumericForHeaderConstant(expression.argument);
    }
    if (expression.type === "ParenthesizedExpression") return isMovableNumericForHeaderConstant(expression.expression);
    return false;
}

function numericForHeaderExpressionText(operation) {
    const rhs = String(operation?.rhs || "").trim();
    return rhs && parseTransitionExpression(rhs)?.expression ? rhs : null;
}

function recoverNumericForHeaderTemps(graph, preOps, headerNames, internalOperations) {
    const roots = headerNames.map(name => {
        const matches = preOps.map((operation, index) => ({ operation, index })).filter(item => item.operation?.emittedTarget === name);
        if (matches.length !== 1) return null;
        const item = matches[0];
        const expression = parseOperationExpression(item.operation);
        const text = numericForHeaderExpressionText(item.operation);
        if (!text || !expression) return null;
        if (item.operation.kind !== "version-define" && item.operation.kind !== "epoch-start" && item.operation.kind !== "epoch-mutate") return null;
        return { name, ...item, expression, text };
    });
    if (roots.some(root => !root)) return null;

    const internal = new Set(internalOperations || []);
    for (const root of roots) internal.add(root.operation);
    for (const root of roots) {
        for (const state of graph.states || []) {
            for (const operation of state.operations || []) {
                if (!(operation.reads || []).includes(root.name)) continue;
                if (!internal.has(operation)) return null;
            }
        }
    }

    const allConstant = roots.every(root => isMovableNumericForHeaderConstant(root.expression));
    if (!allConstant) {
        // Effectful/mutable header producers may move only as one ordered group.
        // Numeric-for evaluates start, final, step once, left-to-right.
        if (!(roots[0].index < roots[1].index && roots[1].index < roots[2].index)) return null;
        const rootOps = new Set(roots.map(root => root.operation));
        const lastRoot = roots[2].index;
        for (let index = roots[0].index; index <= lastRoot; index++) {
            const operation = preOps[index];
            if (rootOps.has(operation)) continue;
            if (operation?.returnSinkSafe !== true || !operation?.emittedTarget) return null;
            const rootNames = new Set(headerNames);
            if ((operation.reads || []).some(name => rootNames.has(name))) return null;
            if (betaOperationWrites(operation).some(name => rootNames.has(name))) return null;
        }
    }

    return {
        initial: roots[0].text,
        limit: roots[1].text,
        step: roots[2].text,
        removeOperations: new Set(roots.map(root => root.operation)),
        reads: [...new Set(roots.flatMap(root => root.operation.reads || []))],
        defaultStep: roots[2].expression.type === "NumericLiteral" && Number(roots[2].expression.value) === 1,
    };
}
function looksLikeCompilerNumericForCore(graph, checkStateId) {
    const check = (graph.states || []).find(state => state.id === checkStateId);
    if (!check || !Array.isArray(check.successors) || check.successors.length !== 2) return false;
    const items = (check.operations || []).map((operation, index) => ({ operation, index, expression: parseOperationExpression(operation) }));
    const selfAdds = items.filter(item =>
        item.operation?.emittedTarget &&
        item.expression?.type === 'BinaryExpression' && item.expression.operator === '+' &&
        identifierName(item.expression.left) === item.operation.emittedTarget && identifierName(item.expression.right)
    );
    if (selfAdds.length !== 1) return false;
    const currentName = selfAdds[0].operation.emittedTarget;
    const stepName = identifierName(selfAdds[0].expression.right);
    if (!stepName) return false;

    const lessEquals = items.filter(item =>
        item.expression?.type === 'BinaryExpression' && item.expression.operator === '<=' &&
        identifierName(item.expression.left) === currentName && identifierName(item.expression.right)
    );
    const greaterEquals = items.filter(item =>
        item.expression?.type === 'BinaryExpression' && item.expression.operator === '>=' &&
        identifierName(item.expression.left) === currentName && identifierName(item.expression.right)
    );
    if (lessEquals.length !== 1 || greaterEquals.length !== 1) return false;
    const lessEqual = lessEquals[0];
    const greaterEqual = greaterEquals[0];
    const finalName = identifierName(lessEqual.expression.right);
    if (!finalName || identifierName(greaterEqual.expression.right) !== finalName) return false;

    const unaryNotItems = items.filter(item => item.expression?.type === 'UnaryExpression' && item.expression.operator === 'not');
    for (const negativeArm of items) {
        const negativeExpr = negativeArm.expression;
        if (negativeExpr?.type !== 'LogicalExpression' || negativeExpr.operator !== 'and') continue;
        const negativeFlagName = identifierName(negativeExpr.left);
        if (!negativeFlagName || identifierName(negativeExpr.right) !== greaterEqual.operation.emittedTarget) continue;
        for (const positiveArm of items) {
            const positiveExpr = positiveArm.expression;
            if (positiveExpr?.type !== 'LogicalExpression' || positiveExpr.operator !== 'and') continue;
            const notNegativeName = identifierName(positiveExpr.left);
            if (!notNegativeName || identifierName(positiveExpr.right) !== lessEqual.operation.emittedTarget) continue;
            const notNegative = unaryNotItems.find(item => item.operation?.emittedTarget === notNegativeName && identifierName(item.expression.argument) === negativeFlagName);
            if (!notNegative) continue;
            const combined = items.some(item =>
                item.expression?.type === 'LogicalExpression' && item.expression.operator === 'or' &&
                identifierName(item.expression.left) === negativeArm.operation.emittedTarget &&
                identifierName(item.expression.right) === positiveArm.operation.emittedTarget
            );
            if (combined) return true;
        }
    }
    return false;
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
    if (loopVariableDefinitions.length > 1) return null;
    const directLoopBinding = loopVariableDefinitions.length === 0;
    if (!directLoopBinding && loopVariableDefinitions[0].stateId !== bodyId) return null;
    const loopVariableDefinition = directLoopBinding ? null : loopVariableDefinitions[0].operation;
    const loopVariable = directLoopBinding ? currentName : loopVariableDefinition.emittedTarget;
    const loopVariableOriginal = directLoopBinding ? null : originalOperationTarget(loopVariableDefinition);
    if (directLoopBinding && (graph.recoveredUpvalueBindings || []).includes(currentName)) return null;

    const cleanupCandidates = [];
    const loopVariableWrites = [];
    const capturedLoopDeclarations = [];
    for (const stateId of region.ids) {
        const state = stateById.get(stateId);
        for (const operation of state.operations || []) {
            const operationOriginalTarget = originalOperationTarget(operation);
            if (operation?.emittedTarget !== loopVariable && (!loopVariableOriginal || operationOriginalTarget !== loopVariableOriginal)) continue;
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

    const recoveredCapturedLoopVariable = !directLoopBinding &&
        (loopVariableDefinition.kind === 'upvalue-binding-init' || loopVariableDefinition.kind === 'upvalue-binding-start') &&
        capturedLoopDeclarations.length <= 1 &&
        capturedLoopDeclarations.every(candidate => candidate.stateId === bodyId);

    const requiredCleanupStates = new Set([...region.latchIds, ...(region.breakIds || [])]);
    const cleanupStateIds = new Set(cleanupCandidates.map(candidate => candidate.stateId));
    if (directLoopBinding) {
        // Earlier proven PRE-CF/dead-clear cleanup can erase the compiler's
        // visible-loop copy and nil cleanup entirely. In that shape the hidden
        // induction epoch itself is the only surviving loop binding. Accept it
        // only when the body does not write that epoch and it is not captured.
        if (cleanupCandidates.length !== 0 || capturedLoopDeclarations.length !== 0) return null;
    } else if (recoveredCapturedLoopVariable) {
        // beta-upvalues already consumed the compiler releaseUpvalue(cell) cleanup.
        if (cleanupCandidates.length !== 0) return null;
    } else if (cleanupCandidates.length === 0) {
        // finalizeBetaDeadRegisterClears runs before CF and can remove every proven
        // compiler epoch-kill while leaving the explicit visible-loop copy intact.
        // The copy + numeric induction signature still owns the source binding; no
        // missing syntax is required after that earlier proof has consumed it.
    } else if (cleanupCandidates.length !== requiredCleanupStates.size || !sameMembers([...cleanupStateIds], [...requiredCleanupStates])) {
        return null;
    }
    const cleanupOperations = new Set(cleanupCandidates.map(candidate => candidate.operation));

    const sourceLoopVariableWrites = loopVariableWrites.filter(operation =>
        operation !== loopVariableDefinition &&
        !cleanupOperations.has(operation) &&
        !capturedLoopDeclarations.some(candidate => candidate.operation === operation)
    );
    if (directLoopBinding && sourceLoopVariableWrites.length !== 0) return null;
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
        ...(loopVariableDefinition ? [loopVariableDefinition] : []),
        ...cleanupOperations,
        ...capturedLoopDeclarations.map(candidate => candidate.operation),
    ]);
    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, skipOperations, directLoopBinding ? null : currentName, exitId, true);
    if (!structuredBody) return null;

    const numericHeader = recoverNumericForHeaderTemps(
        graph,
        preOps,
        [startName, finalName, stepName],
        new Set([...matchedCheckOperations, currentInit.operation, negativeFlag.operation, preTransition])
    );
    const removeFromPreheader = new Set([currentInit.operation, negativeFlag.operation, zeroDef.operation, preTransition]);
    if (numericHeader) for (const operation of numericHeader.removeOperations) removeFromPreheader.add(operation);
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
        headerInitial: numericHeader?.initial || startName,
        headerLimit: numericHeader?.limit || finalName,
        headerStep: numericHeader ? (numericHeader.defaultStep ? null : numericHeader.step) : stepName,
        headerReads: numericHeader?.reads || [startName, finalName, stepName],
        headerTempRecoveryCount: numericHeader ? 3 : 0,
        loopVariable,
        retainedPreheaderOperations,
        bodyNodes: structuredBody.nodes,
        bodyBranchCount: structuredBody.branchCount,
        bodyJoinCount: structuredBody.joinCount,
    };
}

function sourceTextForParsedExpressionNode(rhs, node) {
    if (!node || !Array.isArray(node.range)) return null;
    const parsed = parseTransitionExpression(rhs);
    if (!parsed?.expression) return null;
    const prefixLength = parsed.source.length - String(rhs).length;
    const start = node.range[0] - prefixLength;
    const end = node.range[1] - prefixLength;
    if (start < 0 || end < start || end > String(rhs).length) return null;
    return String(rhs).slice(start, end);
}

function recoverGenericForPackedIterator(graph, preOps, preTransitionIndex, iteratorRoots, iteratorStep, preTransition, structuralOperations = [], bodyOperations = [], bodyLoopBindings = []) {
    if (!Array.isArray(iteratorRoots) || iteratorRoots.length !== 3) return null;
    const captured = new Set(graph.recoveredUpvalueBindings || []);
    const definitionsByName = new Map();
    for (let index = 0; index < preTransitionIndex; index++) {
        const operation = preOps[index];
        if (!operation?.emittedTarget) continue;
        if (!definitionsByName.has(operation.emittedTarget)) definitionsByName.set(operation.emittedTarget, []);
        definitionsByName.get(operation.emittedTarget).push({ operation, index });
    }
    function priorDefinition(name, beforeIndex) {
        const list = definitionsByName.get(name) || [];
        const prior = list.filter(item => item.index < beforeIndex);
        return prior.length === 1 ? prior[0] : null;
    }
    function traceSlot(rootOperation, expectedSlot) {
        let current = rootOperation;
        let currentIndex = preOps.indexOf(current);
        if (currentIndex < 0) return null;
        const chain = [];
        const seen = new Set();
        for (let depth = 0; depth < 12; depth++) {
            if (!current?.emittedTarget || captured.has(current.emittedTarget) || seen.has(current)) return null;
            seen.add(current);
            chain.push(current);
            const expression = parseOperationExpression(current);
            if (expression?.type === 'IndexExpression' && expression.base?.type === 'Identifier') {
                const slot = numericValue(expression.index);
                if (slot !== expectedSlot) return null;
                return { packName: expression.base.name, chain };
            }
            if (expression?.type !== 'Identifier') return null;
            const next = priorDefinition(expression.name, currentIndex);
            if (!next) return null;
            current = next.operation;
            currentIndex = next.index;
        }
        return null;
    }

    const traced = iteratorRoots.map((operation, index) => traceSlot(operation, index + 1));
    if (traced.some(item => !item)) return null;
    const packName = traced[0].packName;
    if (!packName || traced.some(item => item.packName !== packName)) return null;
    const firstChainIndex = Math.min(...traced.flatMap(item => item.chain.map(operation => preOps.indexOf(operation))));
    const packDefItem = priorDefinition(packName, firstChainIndex);
    if (!packDefItem || captured.has(packName)) return null;
    const packDef = packDefItem.operation;
    const packExpression = parseOperationExpression(packDef);
    if (packExpression?.type !== 'TableConstructorExpression' || packExpression.fields?.length !== 1) return null;
    const field = packExpression.fields[0];
    if (field?.type !== 'TableValue' || field.value?.type !== 'CallExpression') return null;
    let callText = sourceTextForParsedExpressionNode(String(packDef.rhs || ''), field.value);
    if (!callText) return null;

    const extraRemoveOperations = new Set();
    let recoveredCallReads = new Set(packDef.reads || []);

    // Local Prometheus can feed a generic-for iterator factory through RETURN_ALL:
    //   local innerPack = { producer(...) }
    //   local iterPack = { factory(unpack(innerPack)) }
    // Recover only that exact one-pack/one-unpack chain. This keeps the producer at
    // the same iterator-header evaluation point and preserves final-argument
    // multi-return expansion without generic call inlining.
    const outerCall = field.value;
    const outerArgs = outerCall.arguments || [];

    // Direct source field calls compile through a short-lived field snapshot before
    // the iterator pack, while a genuine source alias owns a normal register epoch.
    // Fold only the exact compiler scratch shape and only for zero-argument calls,
    // so lookup timing cannot move across argument evaluation.
    if (outerArgs.length === 0 && isIdentifier(outerCall.base)) {
        const methodDefItem = priorDefinition(outerCall.base.name, packDefItem.index);
        const methodDef = methodDefItem?.operation || null;
        const methodExpression = methodDef ? parseOperationExpression(methodDef) : null;
        const scratchOwned = methodDef && methodDef.originalTarget === graph.stateName && !methodDef.registerEpoch;
        const adjacent = methodDefItem?.index === packDefItem.index - 1;
        let memberName = null;
        let receiverName = null;
        if (methodExpression?.type === 'IndexExpression' && isIdentifier(methodExpression.base)) {
            memberName = plainPostCfMemberName(methodExpression.index);
            receiverName = methodExpression.base.name;
        } else if (methodExpression?.type === 'MemberExpression' && isIdentifier(methodExpression.base) && methodExpression.identifier?.type === 'Identifier') {
            const candidate = methodExpression.identifier.name;
            if (/^[A-Za-z_][A-Za-z0-9_]*$/.test(candidate) && !POST_CF_MEMBER_KEYWORDS.has(candidate)) {
                memberName = candidate;
                receiverName = methodExpression.base.name;
            }
        }
        if (scratchOwned && adjacent && memberName && receiverName && !captured.has(outerCall.base.name)) {
            callText = `${receiverName}.${memberName}()`;
            extraRemoveOperations.add(methodDef);
            recoveredCallReads.delete(outerCall.base.name);
            for (const read of methodDef.reads || []) recoveredCallReads.add(read);
        }
    }
    if (outerArgs.length === 1 && outerArgs[0]?.type === 'CallExpression' && isIdentifier(outerArgs[0].base, 'unpack')) {
        const unpackArgs = outerArgs[0].arguments || [];
        const innerPackName = unpackArgs.length === 1 && isIdentifier(unpackArgs[0]) ? unpackArgs[0].name : null;
        const innerPackDefItem = innerPackName ? priorDefinition(innerPackName, packDefItem.index) : null;
        const innerPackDef = innerPackDefItem?.operation || null;
        const innerPackExpression = innerPackDef ? parseOperationExpression(innerPackDef) : null;
        const innerFields = innerPackExpression?.type === 'TableConstructorExpression' ? (innerPackExpression.fields || []) : [];
        const innerCall = innerFields.length === 1 && innerFields[0]?.type === 'TableValue' && innerFields[0].value?.type === 'CallExpression'
            ? innerFields[0].value
            : null;
        if (innerPackName && innerPackDefItem && !captured.has(innerPackName) && innerCall) {
            let innerCallText = sourceTextForParsedExpressionNode(String(innerPackDef.rhs || ''), innerCall);
            const outerBaseText = sourceTextForParsedExpressionNode(String(packDef.rhs || ''), outerCall.base);
            if (innerCallText && outerBaseText) {
                // Preserve exact native namecall semantics for the compiler's
                // method-snapshot + explicit-self call when structurally proven.
                if (isIdentifier(innerCall.base) && (innerCall.arguments || []).length >= 1 && isIdentifier(innerCall.arguments[0])) {
                    const selfName = innerCall.arguments[0].name;
                    const methodDefItem = priorDefinition(innerCall.base.name, innerPackDefItem.index);
                    const methodDef = methodDefItem?.operation || null;
                    const methodExpression = methodDef ? parseOperationExpression(methodDef) : null;
                    const methodName = methodExpression?.type === 'IndexExpression' && isIdentifier(methodExpression.base, selfName)
                        ? plainPostCfMemberName(methodExpression.index)
                        : null;
                    if (methodName && !captured.has(innerCall.base.name)) {
                        const argTexts = (innerCall.arguments || []).slice(1).map(arg => sourceTextForParsedExpressionNode(String(innerPackDef.rhs || ''), arg));
                        if (argTexts.every(Boolean)) {
                            innerCallText = `${selfName}:${methodName}(${argTexts.join(', ')})`;
                            extraRemoveOperations.add(methodDef);
                            recoveredCallReads.delete(innerCall.base.name);
                            for (const read of methodDef.reads || []) recoveredCallReads.add(read);
                        }
                    }
                }

                callText = `${outerBaseText}(${innerCallText})`;
                extraRemoveOperations.add(innerPackDef);
                recoveredCallReads.delete(innerPackName);
                for (const read of innerPackDef.reads || []) recoveredCallReads.add(read);

                // Compiler-proven _env lookups may be presented directly once every
                // use of the alias is owned by this recovered iterator setup. Do not
                // touch genuine source aliases.
                const aliasCandidates = [];
                if (isIdentifier(outerCall.base)) aliasCandidates.push(outerCall.base.name);
                const innerSelf = innerCall?.arguments?.[0];
                if (isIdentifier(innerSelf)) aliasCandidates.push(innerSelf.name);
                for (const aliasName of aliasCandidates) {
                    const aliasDefItem = priorDefinition(aliasName, innerPackDefItem.index);
                    const aliasDef = aliasDefItem?.operation || null;
                    const globalName = aliasDef?.compilerGlobalLookupRecovered;
                    if (!aliasDef || typeof globalName !== 'string' || !/^[A-Za-z_][A-Za-z0-9_]*$/.test(globalName) || POST_CF_MEMBER_KEYWORDS.has(globalName)) continue;
                    const readerOps = [];
                    for (const state of graph.states || []) {
                        for (const operation of state.operations || []) {
                            if ((operation.reads || []).includes(aliasName)) readerOps.push(operation);
                        }
                    }
                    const ownedReaders = new Set([packDef, innerPackDef, ...extraRemoveOperations]);
                    if (!readerOps.every(operation => ownedReaders.has(operation))) continue;
                    callText = callText.replace(new RegExp(`\\b${aliasName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'g'), globalName);
                    extraRemoveOperations.add(aliasDef);
                    recoveredCallReads.delete(aliasName);
                }
            }
        }
    }

    const removeOperations = new Set([packDef, ...traced.flatMap(item => item.chain), ...extraRemoveOperations]);
    const removedNames = new Set([...removeOperations].map(operation => operation.emittedTarget).filter(Boolean));
    const allowedReaders = new Set([...removeOperations, iteratorStep, preTransition, ...(structuralOperations || [])]);
    const bodyReaderOperations = new Set(bodyOperations || []);
    const bodyBindingNames = new Set(bodyLoopBindings || []);
    for (const state of graph.states || []) {
        for (const operation of state.operations || []) {
            for (const name of removedNames) {
                if (!(operation.reads || []).includes(name) || allowedReaders.has(operation)) continue;
                if (bodyReaderOperations.has(operation) && bodyBindingNames.has(name)) continue;
                return null;
            }
        }
    }

    const callReads = recoveredCallReads;
    for (let index = packDefItem.index + 1; index < preTransitionIndex; index++) {
        const operation = preOps[index];
        if (removeOperations.has(operation)) continue;
        if (operation?.returnSinkSafe !== true || !operation?.emittedTarget) return null;
        if ((operation.reads || []).some(name => removedNames.has(name))) return null;
        if (betaOperationWrites(operation).some(name => removedNames.has(name) || callReads.has(name))) return null;
    }

    return {
        expressions: [callText],
        reads: [...callReads],
        removeOperations,
    };
}
function looksLikeCompilerGenericForCore(graph, checkStateId) {
    const check = (graph.states || []).find(state => state.id === checkStateId);
    if (!check || !Array.isArray(check.successors) || check.successors.length !== 2) return false;
    const steps = (check.operations || []).filter(operation => operation?.kind === "multi-call-write");
    if (steps.length !== 1) return false;
    const step = steps[0];
    const targets = step.emittedTargets || step.originalTargets || [];
    const args = step.callArgumentOriginals || [];
    if (targets.length !== 2 || !targets[0] || !targets[1] || args.length !== 2 || !step.callBaseOriginal) return false;
    const info = transitionInfo(check, { allowUnprovenCondition: true });
    return !info.error && info.kind === "branch" && info.conditionName === targets[0];
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
    const emittedTargets = iteratorStep.emittedTargets || targets;
    const args = iteratorStep.callArgumentOriginals || [];
    if (
        targets.length !== 2 || !targets.every(Boolean) ||
        emittedTargets.length !== 2 || !emittedTargets.every(Boolean) ||
        !iteratorStep.callBaseOriginal || args.length !== 2 || !args.every(Boolean)
    ) return null;
    const controlName = targets[0];
    const emittedControlName = emittedTargets[0];
    const secondVariableOriginal = targets[1];
    const emittedSecondVariable = emittedTargets[1];
    const iteratorName = iteratorStep.callBaseOriginal;
    const iteratorStateName = args[0];
    if (args[1] !== controlName || checkInfo.conditionName !== emittedControlName) return null;

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
    const recoveredUpvalueBindings = new Set(graph.recoveredUpvalueBindings || []);
    const firstCopies = (bodyEntry?.operations || []).filter(operation => {
        const originalTarget = originalOperationTarget(operation);
        if (!originalTarget || !operation?.emittedTarget || originalTarget === controlName) return false;
        const rhsOriginal = originalOperationRhs(operation);
        return rhsOriginal === controlName || operation?.rhs === emittedControlName;
    });
    if (firstCopies.length > 1) return null;
    const directIteratorBindings = firstCopies.length === 0;
    const firstCopy = firstCopies[0] || null;
    const firstVariableOriginal = directIteratorBindings ? controlName : originalOperationTarget(firstCopy);
    const firstVariable = directIteratorBindings ? emittedControlName : firstCopy.emittedTarget;
    if (!firstVariableOriginal || (!directIteratorBindings && firstVariableOriginal === secondVariableOriginal)) return null;

    // Dead register-clear / scalar transport cleanup can erase the compiler's
    // explicit first loop-variable copy after beta lifetime ownership has already
    // proven that the iterator result itself is the surviving source binding. In
    // that shape, use the iterator result epochs directly instead of requiring
    // syntax that an earlier proven cleanup intentionally removed. Captured loop
    // bindings still require the explicit upvalue path below.
    const firstVariableCaptured = recoveredUpvalueBindings.has(firstVariable);
    if (directIteratorBindings && firstVariableCaptured) return null;
    const secondBindingCandidates = (bodyEntry?.operations || []).filter(operation =>
        (operation?.kind === "upvalue-binding-start" || operation?.kind === "upvalue-binding-init") &&
        (originalOperationRhs(operation) === secondVariableOriginal || operation?.rhs === emittedSecondVariable) &&
        operation?.emittedTarget &&
        recoveredUpvalueBindings.has(operation.emittedTarget)
    );

    const requiredCleanupStates = new Set([...region.latchIds, ...(region.breakIds || [])]);
    const secondOrdinaryCleanups = [];
    for (const stateId of region.ids) {
        for (const operation of stateById.get(stateId)?.operations || []) {
            if (originalOperationTarget(operation) !== secondVariableOriginal) continue;
            const expression = parseOperationExpression(operation);
            if (expression?.type === "NilLiteral") secondOrdinaryCleanups.push({ stateId, operation });
        }
    }
    const secondCleanupStates = new Set(secondOrdinaryCleanups.map(item => item.stateId));
    const secondHasCompilerCleanup =
        secondOrdinaryCleanups.length === requiredCleanupStates.size &&
        sameMembers([...secondCleanupStates], [...requiredCleanupStates]);

    // A real captured second ForIn variable has its releaseUpvalue scaffolding
    // consumed by beta-upvalues, so no ordinary var=nil cleanup remains. If the
    // compiler cleanup is still present, any recovered binding initialized from
    // that iterator value is an ordinary captured local copy inside the body.
    if (!secondHasCompilerCleanup && secondOrdinaryCleanups.length !== 0) return null;
    if (directIteratorBindings && secondBindingCandidates.length !== 0) return null;
    let secondBinding = null;
    if (!directIteratorBindings && !secondHasCompilerCleanup) {
        if (secondBindingCandidates.length === 1) {
            secondBinding = secondBindingCandidates[0];
        } else if (secondBindingCandidates.length === 0 && !recoveredUpvalueBindings.has(emittedSecondVariable)) {
            // finalizeBetaDeadRegisterClears may already have removed the ordinary
            // second loop-variable cleanup, leaving the iterator result epoch as
            // the surviving uncaptured binding.
            secondBinding = null;
        } else {
            return null;
        }
    }
    const secondVariable = secondBinding?.emittedTarget || emittedSecondVariable;
    const secondVariableCaptured = Boolean(secondBinding);
    if (directIteratorBindings && recoveredUpvalueBindings.has(secondVariable)) return null;
    const cleanupOperations = new Set();
    for (const variable of directIteratorBindings ? [] : [
        { name: firstVariableOriginal, captured: firstVariableCaptured },
        { name: secondVariableOriginal, captured: secondVariableCaptured },
    ]) {
        const cleanups = [];
        for (const stateId of region.ids) {
            for (const operation of stateById.get(stateId)?.operations || []) {
                if (originalOperationTarget(operation) !== variable.name) continue;
                const expression = parseOperationExpression(operation);
                if (expression?.type === "NilLiteral") cleanups.push({ stateId, operation });
            }
        }
        if (variable.captured) {
            // beta-upvalues already consumed releaseUpvalue for a captured loop binding.
            if (cleanups.length !== 0) return null;
            continue;
        }
        const cleanupStates = new Set(cleanups.map(item => item.stateId));
        if (cleanups.length === 0) {
            // Proven dead register clears run before CF and may consume every
            // ordinary generic-for loop-variable epoch-kill.
            continue;
        }
        if (cleanups.length !== requiredCleanupStates.size || !sameMembers([...cleanupStates], [...requiredCleanupStates])) return null;
        for (const item of cleanups) cleanupOperations.add(item.operation);
    }

    const protectedOriginalNames = new Set([iteratorName, iteratorStateName, controlName]);
    for (const stateId of region.ids) {
        for (const operation of stateById.get(stateId)?.operations || []) {
            if (operation === firstCopy || operation === secondBinding || cleanupOperations.has(operation)) continue;
            const originalTarget = originalOperationTarget(operation);
            if (protectedOriginalNames.has(originalTarget)) return null;
            if (originalTarget === firstVariableOriginal) return null;
            if (originalTarget === secondVariableOriginal) {
                // Lua permits assigning to a generic-for value variable inside the loop body.
                // Accept only a proven write to the exact surviving second-variable beta binding;
                // compiler cleanup/setup writes and physical-register reuse remain refused.
                const expression = parseOperationExpression(operation);
                if (operation.emittedTarget !== secondVariable || expression?.type === "NilLiteral") return null;
            }
        }
    }

    const skipOperations = new Set([...(firstCopy ? [firstCopy] : []), ...(secondBinding ? [secondBinding] : []), ...cleanupOperations]);
    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, skipOperations, null, exitId, true);
    if (!structuredBody) return null;

    const loopBodyOperations = directIteratorBindings
        ? [...region.ids].flatMap(stateId => stateById.get(stateId)?.operations || [])
        : [];
    const packedIterator = recoverGenericForPackedIterator(
        graph,
        preOps,
        preTransitionIndex,
        [iteratorDef, iteratorStateDef, controlDef],
        iteratorStep,
        preInfo.operation,
        [checkInfo.operation, ...(firstCopy ? [firstCopy] : []), ...(secondBinding ? [secondBinding] : []), ...cleanupOperations],
        loopBodyOperations,
        directIteratorBindings ? [firstVariable, secondVariable] : []
    );
    const iteratorExpressions = packedIterator?.expressions || [iteratorDef.emittedTarget, iteratorStateDef.emittedTarget, controlDef.emittedTarget];
    const iteratorReads = packedIterator?.reads || [iteratorDef.emittedTarget, iteratorStateDef.emittedTarget, controlDef.emittedTarget];
    const removedSetupOperations = packedIterator?.removeOperations || new Set();

    return {
        preheaderId,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        loopVariables: [firstVariable, secondVariable],
        iteratorExpressions,
        iteratorReads,
        iteratorSetupRecoveryCount: packedIterator ? removedSetupOperations.size : 0,
        retainedPreheaderOperations: preOps.filter(operation => operation !== preInfo.operation && !removedSetupOperations.has(operation)),
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
        const conditionNodes = [...conditionStructured.nodes, ...decisionOperations.map(operation => operationNode(operation, decision.id))];
        const logicalCondition = recoverCfLogicalValueProgram(conditionNodes, decisionInfo.conditionName, graph.recoveredUpvalueBindings);
        const useLogicalCondition = !!logicalCondition && decisionInfo.condition === decisionInfo.conditionName;
        matches.push({
            preheaderId,
            checkId: decision.id,
            conditionEntryId: header.id,
            conditionStateIds: [...conditionRegion.ids, decision.id],
            bodyId,
            bodyStateIds: [...bodyRegion.ids],
            exitId,
            condition: useLogicalCondition ? logicalCondition.expression : decisionInfo.condition,
            conditionReads: useLogicalCondition ? logicalCondition.reads : decisionInfo.conditionReads,
            conditionNodes: useLogicalCondition ? [] : conditionNodes,
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
    if (looksLikeCompilerNumericForCore(graph, checkStateId) || matchCompilerNumericFor(graph, checkStateId)) return null;
    if (looksLikeCompilerGenericForCore(graph, checkStateId) || matchCompilerGenericFor(graph, checkStateId)) return null;

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

    let conditionOperations = (check.operations || []).filter(operation => operation !== checkInfo.operation);
    let recoveredCheckInfo = checkInfo;
    const adjacentCondition = recoverCfAdjacentConditionTemp(graph, check, checkInfo, conditionOperations);
    recoveredCheckInfo = adjacentCondition.info;
    conditionOperations = adjacentCondition.bodyOperations;
    if (conditionOperations.some(operation => !operationText(operation))) return null;
    let conditionNodes = conditionOperations.map(operation => operationNode(operation, check.id));
    const logicalCondition = recoverCfLogicalValueProgram(conditionNodes, recoveredCheckInfo.conditionName, graph.recoveredUpvalueBindings);
    if (logicalCondition && recoveredCheckInfo.condition === recoveredCheckInfo.conditionName) {
        recoveredCheckInfo = { ...recoveredCheckInfo, condition: logicalCondition.expression, conditionReads: logicalCondition.reads, conditionTempRecovered: true };
        conditionNodes = [];
    }

    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, new Set(), null, exitId, true);
    if (!structuredBody) return null;

    return {
        preheaderId: preheader.id,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        condition: recoveredCheckInfo.condition,
        conditionReads: recoveredCheckInfo.conditionReads,
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

function canonicalCompilerOperationSequence(operations, options = {}) {
    const latestDefinitions = new Map();
    const sequence = [];
    for (let index = 0; index < operations.length; index++) {
        const operation = operations[index];
        const rhs = options.preferCurrentRhs === true
            ? (String(operation?.rhs || '').trim() || originalOperationRhs(operation))
            : originalOperationRhs(operation);
        if (!rhs) return null;
        const parsed = parseTransitionExpression(rhs)?.expression || null;
        if (!parsed) return null;
        sequence.push(canonicalCompilerExpression(parsed, latestDefinitions));
        const target = originalOperationTarget(operation);
        if (target) latestDefinitions.set(target, index);
        if (options.preferCurrentRhs === true && operation?.emittedTarget) {
            latestDefinitions.set(operation.emittedTarget, index);
        }
    }
    return JSON.stringify(sequence);
}

function betaOperationWrites(operation) {
    const writes = [];
    if (operation?.emittedTarget) writes.push(operation.emittedTarget);
    for (const target of operation?.emittedTargets || []) if (target) writes.push(target);
    return writes;
}

function compilerOperationsCanCommute(left, right) {
    if (left?.returnSinkSafe !== true || right?.returnSinkSafe !== true) return false;
    if (!left?.emittedTarget || !right?.emittedTarget) return false;
    const leftOriginal = originalOperationTarget(left);
    const rightOriginal = originalOperationTarget(right);
    if (leftOriginal && rightOriginal && leftOriginal === rightOriginal) return false;
    const leftWrites = new Set(betaOperationWrites(left));
    const rightWrites = new Set(betaOperationWrites(right));
    const leftReads = new Set(left?.reads || []);
    const rightReads = new Set(right?.reads || []);
    for (const name of leftWrites) if (rightWrites.has(name) || rightReads.has(name)) return false;
    for (const name of rightWrites) if (leftReads.has(name)) return false;
    return true;
}

function collectCanonicalDefinitionRefs(value, output = new Set()) {
    if (Array.isArray(value)) {
        if (value[0] === 'def' && Number.isInteger(value[1])) output.add(value[1]);
        for (const child of value) collectCanonicalDefinitionRefs(child, output);
        return output;
    }
    if (value && typeof value === 'object') {
        for (const child of Object.values(value)) collectCanonicalDefinitionRefs(child, output);
    }
    return output;
}

function buildCompilerOperationPattern(pattern) {
    const latestDefinitions = new Map();
    const nodes = [];
    for (let index = 0; index < pattern.length; index++) {
        const operation = pattern[index];
        const rhs = originalOperationRhs(operation);
        if (!rhs) return null;
        const parsed = parseTransitionExpression(rhs)?.expression || null;
        if (!parsed) return null;
        const canonical = canonicalCompilerExpression(parsed, latestDefinitions);
        const dependencies = collectCanonicalDefinitionRefs(canonical);

        // Preserve original order for any pair that cannot be proven safe to commute.
        // Only pure, data-independent compiler definitions may change topological order.
        for (let prior = 0; prior < index; prior++) {
            if (!compilerOperationsCanCommute(pattern[prior], operation)) dependencies.add(prior);
        }

        nodes.push({
            index,
            operation,
            expression: JSON.stringify(canonical),
            dependencies,
        });
        const target = originalOperationTarget(operation);
        if (target) latestDefinitions.set(target, index);
    }
    return nodes;
}

function findUniqueCompilerOperationSubsequence(operations, pattern) {
    if (!pattern.length) return { start: -1, operations: new Set(), indices: [] };
    const patternNodes = buildCompilerOperationPattern(pattern);
    if (!patternNodes) return null;

    const candidates = new Map();
    function visit(searchStart, matchedPattern, selectedIndices, selectedDefinitions) {
        if (candidates.size > 1) return;
        if (matchedPattern.size === patternNodes.length) {
            const selected = new Set(selectedIndices);
            const removedWrites = new Set();
            for (const index of selectedIndices) {
                for (const name of betaOperationWrites(operations[index])) removedWrites.add(name);
            }
            for (let index = 0; index < operations.length; index++) {
                if (selected.has(index)) continue;
                if ((operations[index]?.reads || []).some(name => removedWrites.has(name))) return;
            }
            candidates.set(selectedIndices.join(','), [...selectedIndices]);
            return;
        }

        const ready = patternNodes.filter(node =>
            !matchedPattern.has(node.index) &&
            [...node.dependencies].every(dependency => matchedPattern.has(dependency))
        );
        if (!ready.length) return;

        const remaining = patternNodes.length - matchedPattern.size;
        for (let operationIndex = searchStart; operationIndex <= operations.length - remaining; operationIndex++) {
            const rhs = originalOperationRhs(operations[operationIndex]);
            if (!rhs) continue;
            const parsed = parseTransitionExpression(rhs)?.expression || null;
            if (!parsed) continue;
            const candidateExpression = JSON.stringify(canonicalCompilerExpression(parsed, selectedDefinitions));

            for (const node of ready) {
                if (candidateExpression !== node.expression) continue;
                const nextMatched = new Set(matchedPattern);
                nextMatched.add(node.index);
                const nextDefinitions = new Map(selectedDefinitions);
                const target = originalOperationTarget(operations[operationIndex]);
                if (target) nextDefinitions.set(target, node.index);
                visit(operationIndex + 1, nextMatched, [...selectedIndices, operationIndex], nextDefinitions);
                if (candidates.size > 1) return;
            }
        }
    }

    visit(0, new Set(), [], new Map());
    if (candidates.size !== 1) return null;
    const indices = [...candidates.values()][0];
    return {
        start: indices[0],
        indices,
        operations: new Set(indices.map(index => operations[index])),
    };
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

function isCompilerReturnAlias(operation) {
    if (originalOperationTarget(operation) !== 'ReturnVal' || operation?.returnSinkSafe !== true) return false;
    return parseOperationExpression(operation)?.type === 'Identifier';
}

function rawConditionStateOperations(state, entryStartIndex = 0) {
    const operations = (state?.operations || []).filter(operation =>
        operation?.kind !== 'state-transition' &&
        operation?.kind !== 'phi-declare' &&
        operation?.kind !== 'phi-assign' &&
        !isCompilerReturnAlias(operation)
    );
    return operations.slice(entryStartIndex);
}

function conditionRegionIgnoredCompilerTemporaries(stateById, region, entryId, entryStartIndex = 0) {
    const selectedByState = new Map();
    const reads = new Set();
    for (const stateId of region.ids) {
        const state = stateById.get(stateId);
        const selected = rawConditionStateOperations(state, stateId === entryId ? entryStartIndex : 0);
        selectedByState.set(stateId, selected);
        for (const operation of selected) {
            for (const name of operation?.reads || []) reads.add(name);
        }
        for (const operation of state?.operations || []) {
            if (operation?.kind !== 'state-transition') continue;
            for (const name of operation?.reads || []) reads.add(name);
        }
    }

    const ignored = new Set();
    const scalarKinds = new Set(['version-define', 'epoch-start', 'epoch-mutate']);
    for (const selected of selectedByState.values()) {
        for (const operation of selected) {
            if (!scalarKinds.has(operation?.kind)) continue;
            if (operation?.returnSinkSafe !== true || !operation?.emittedTarget) continue;
            if (reads.has(operation.emittedTarget)) continue;
            ignored.add(operation);
        }
    }
    return ignored;
}

function canonicalConditionStateOperations(state, entryStartIndex = 0, ignoredOperations = null) {
    const selected = rawConditionStateOperations(state, entryStartIndex).filter(operation => !ignoredOperations?.has(operation));
    if (!selected.length) return '[]';
    const signature = canonicalCompilerOperationSequence(selected);
    if (!signature) return null;
    const targets = selected.map(operation => originalOperationTarget(operation));
    const kinds = selected.map(operation => operation?.kind || '');
    return JSON.stringify({ signature, targets, kinds });
}

function conditionRegionSignature(stateById, region, entryId, exitId, entryStartIndex = 0) {
    const ignoredOperations = conditionRegionIgnoredCompilerTemporaries(stateById, region, entryId, entryStartIndex);
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
        const opSig = canonicalConditionStateOperations(state, stateId === entryId ? entryStartIndex : 0, ignoredOperations);
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
                    matches.push({
                        preEntryId: preEntry.id,
                        preRegion: region,
                        entryStartIndex: startIndex,
                        realEntryId: real.realEntryId,
                        realRegion: real.region,
                    });
                }
            }
        }
    }
    const maximal = matches.filter(candidate => !matches.some(other => {
        if (other === candidate) return false;
        const candidatePre = candidate.preRegion.ids;
        const otherPre = other.preRegion.ids;
        const candidateReal = candidate.realRegion.ids;
        const otherReal = other.realRegion.ids;
        const preContained = [...candidatePre].every(id => otherPre.has(id));
        const realContained = [...candidateReal].every(id => otherReal.has(id));
        const strictlyLarger = otherPre.size > candidatePre.size || otherReal.size > candidateReal.size;
        return preContained && realContained && strictlyLarger;
    }));
    return maximal.length === 1 ? maximal[0] : null;
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
        const expression = parseOperationExpression(operation);
        // Root VM argument snapshots can be scheduled inside the compiler's
        // discarded first repeat-condition evaluation even though they are not
        // part of the source condition. Ignore only the proven sink-safe direct
        // synthetic args snapshot; later scope cleanup still owns its lifetime.
        if (operation?.returnSinkSafe === true && expression?.type === 'Identifier' && expression.name === 'args') return false;
        if (originalOperationTarget(operation) !== 'ReturnVal' || operation?.returnSinkSafe !== true) return true;
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
    const operationSignature = canonicalCompilerOperationSequence(operations, { preferCurrentRhs: true });
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
            // The duplicated precheck flows into the ordinary repeat preheader.
            // Include that terminal jump-only state in the topology signature so
            // multi-state short-circuit regions compare against the real condition
            // region including its terminal decision state. Its state-transition
            // is excluded from condition operations, so only control topology is added.
            const signatureIds = new Set([...region.ids, repeatShape.preheaderId]);
            const signature = compilerConditionRegionSignature(stateById, signatureIds, state.id, startIndex);
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
    const junkSlice = findUniqueCompilerOperationSubsequence(preBodyOperations, conditionOperations);
    if (!junkSlice) return null;
    const retainedPreheaderOperations = preBodyOperations.filter(operation => !junkSlice.operations.has(operation));

    const structuredBody = structureLoopBodyRegion(stateById, region, bodyId, check.id, new Set(), null, exitId, false);
    if (!structuredBody) return null;

    let condition = checkInfo.condition;
    let conditionReads = checkInfo.conditionReads;
    let conditionNodes = conditionOperations.map(operation => operationNode(operation, check.id));
    let bodyNodes = structuredBody.nodes;
    const combinedConditionProgram = [...bodyNodes, ...conditionNodes];
    const logicalSuffix = recoverCfLogicalSuffix(combinedConditionProgram, checkInfo.conditionName, graph.recoveredUpvalueBindings);
    let upstreamDuplicate = null;
    let logicalConditionStateIds = [];
    if (logicalSuffix) {
        condition = logicalSuffix.expression;
        conditionReads = logicalSuffix.reads;
        const logicalProgramNodes = combinedConditionProgram.slice(logicalSuffix.start);
        const ids = new Set();
        const collectStateIds = nodes => {
            for (const node of nodes || []) {
                if (node?.type === "raw" && Number.isInteger(node.stateId)) ids.add(node.stateId);
                else if (node?.type === "if") { collectStateIds(node.thenBody); collectStateIds(node.elseBody); }
                else if (node?.type === "while-guard" || node?.type === "repeat-until") { collectStateIds(node.conditionBody); collectStateIds(node.body); }
                else if (node?.type === "numeric-for" || node?.type === "generic-for") collectStateIds(node.body);
            }
        };
        collectStateIds(logicalProgramNodes);
        logicalConditionStateIds = [...ids];
        bodyNodes = combinedConditionProgram.slice(0, logicalSuffix.start);
        conditionNodes = [];

        // Multi-state short-circuit repeat conditions are compiled once before
        // the body and once again as the real post-test. If the immediate
        // preheader contains no duplicate operations, prove the predecessor
        // condition region structurally and consume it with the loop.
        if (junkSlice.operations.size === 0 && logicalConditionStateIds.some(id => id !== check.id)) {
            const conditionStateIds = [...new Set([...logicalConditionStateIds, check.id])];
            const conditionSet = new Set(conditionStateIds);
            upstreamDuplicate = findDuplicateControlRepeatCondition(graph, {
                preheaderId: preheader.id,
                conditionEntryId: logicalConditionStateIds[0],
                conditionStateIds,
                bodyId,
                bodyStateIds: [...region.ids].filter(id => !conditionSet.has(id)),
                exitId,
            });
            if (!upstreamDuplicate) return null;
        }
    } else {
        const adjacent = recoverCfAdjacentConditionTemp(graph, check, checkInfo, conditionOperations);
        condition = adjacent.info.condition;
        conditionReads = adjacent.info.conditionReads;
        conditionNodes = adjacent.bodyOperations.map(operation => operationNode(operation, check.id));
    }

    const duplicateRemovedIds = upstreamDuplicate
        ? new Set([...upstreamDuplicate.regionIds, preheader.id])
        : null;
    if (duplicateRemovedIds) duplicateRemovedIds.delete(upstreamDuplicate.entryId);
    return {
        preheaderId: upstreamDuplicate?.entryId ?? preheader.id,
        checkId: check.id,
        bodyId,
        bodyStateIds: [...region.ids],
        exitId,
        condition,
        conditionReads,
        conditionNodes,
        bodyNodes,
        bodyBranchCount: structuredBody.branchCount,
        bodyJoinCount: structuredBody.joinCount,
        retainedPreheaderOperations: upstreamDuplicate?.retainedPrefix ?? retainedPreheaderOperations,
        removedCompilerConditionOperationCount: upstreamDuplicate?.removedOperationCount ?? junkSlice.operations.size,
        removeStateIds: upstreamDuplicate
            ? [...region.ids, check.id, ...duplicateRemovedIds]
            : undefined,
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
            match.headerInitial,
            match.headerLimit,
            match.headerStep,
            bodyNodes,
            match.headerReads
        );
        const structuredOperation = {
            kind: "structured-numeric-for",
            structuredNode: loopNode,
            emittedText: formatStructuredNodes([loopNode]),
            reads: [...match.headerReads],
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

        const loopNode = genericForNode(match.loopVariables, match.iteratorExpressions, match.bodyNodes, match.iteratorReads);
        loopNode.compilerIteratorRecovered = (match.iteratorSetupRecoveryCount || 0) > 0;
        const structuredOperation = {
            kind: "structured-generic-for",
            structuredNode: loopNode,
            emittedText: formatStructuredNodes([loopNode]),
            reads: [...match.iteratorReads],
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
    const terminalReturnTexts = [];
    let ifConditionTempRecoveryCount = 0;
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
            terminalReturnTexts.push(lowered.returnText || null);
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
        let bodyOperations = state.operations.filter(operation => operation !== info.operation);
        let preparedInfo = info;
        if (info.kind === "branch") {
            const recovered = recoverCfAdjacentConditionTemp(graph, state, info, bodyOperations);
            preparedInfo = recovered.info;
            bodyOperations = recovered.bodyOperations;
            if (recovered.recovered) ifConditionTempRecoveryCount++;
        }
        if (bodyOperations.some(operation => !operationText(operation))) {
            return { applied: false, reason: `State ${state.id} has an unprintable beta operation` };
        }
        prepared.set(state.id, { state, info: preparedInfo, bodyOperations });
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

            let info = item.info;
            if (info.kind === "return") return { nodes, reachesStop: false };
            if (info.kind === "jump") {
                current = info.target;
                continue;
            }
            if (info.kind !== "branch") throw new Error("Unsupported prepared terminator in state " + current);

            if (info.condition === info.conditionName) {
                const logicalCondition = recoverCfLogicalConditionSuffix(nodes, info.conditionName, graph.recoveredUpvalueBindings, graph);
                if (logicalCondition) {
                    nodes.splice(logicalCondition.start, nodes.length - logicalCondition.start, ...(logicalCondition.retainedNodes || []));
                    info = {
                        ...info,
                        condition: logicalCondition.expression,
                        conditionReads: logicalCondition.reads,
                        conditionTempRecovered: true,
                    };
                    ifConditionTempRecoveryCount++;
                }
            }

            branchCount++;
            if (info.onTrue === info.onFalse) {
                current = info.onTrue;
                continue;
            }

            let join = immediatePostdominator(current, postdominators);
            // A nested guard arm may have its own terminal shared join that cannot
            // reach the surrounding partial continuation. Keep that proven local join.
            const joinIsTerminalReturn = join !== null &&
                join !== exitNode &&
                prepared.get(join)?.info?.kind === "return";
            if (
                join === exitNode ||
                (join !== null &&
                    stopState !== exitNode &&
                    join !== stopState &&
                    !reachesState(join, stopState, reachableSets) &&
                    !joinIsTerminalReturn)
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

    const structuredLogicalConditionRecoveryCount = recoverStructuredLogicalConditionPrograms(structured.nodes, graph);
    let loopControlConditionTempRecoveryCount = recoverStructuredLoopBranchConditionTemps(structured.nodes, graph);
    const genericForGlobalMethodTempRecoveryCount = recoverStructuredGenericForGlobalMethodTemps(structured.nodes, graph);
    const postCfNamecallRecoveryCount = recoverStructuredPostCfNamecalls(structured.nodes);
    let postCfCompilerValueRecoveryCount = recoverStructuredCompilerValueTemps(structured.nodes, graph);
    const postCfClosureDestinationRecoveryCount = recoverStructuredPostCfClosureDestinationTemps(structured.nodes, graph);
    const postCfDeadClosureRecoveryCount = recoverStructuredPostCfDeadClosureTemps(structured.nodes, graph);
    const postCfDeadScalarLocalRecoveryCount = recoverStructuredPostCfDeadScalarLocals(structured.nodes, graph, { syntheticLocals: ["args"] });
    const postCfCopyScalarRecoveryCount = recoverStructuredPostCfCopyScalarTemps(structured.nodes, graph);
    const postCfCompilerGlobalAliasRecoveryCount = recoverStructuredCompilerGlobalAliases(structured.nodes, graph);
    const postCfCompilerClosureTempRecoveryCount = recoverStructuredCompilerClosureTemps(structured.nodes, graph);
    const postCfCompilerReturnAllRecoveryCount = recoverStructuredCompilerReturnAllForwarding(structured.nodes, graph);
    postCfCompilerValueRecoveryCount += recoverStructuredCompilerValueTemps(structured.nodes, graph);
    // Dead scalar/copy cleanup can expose a compiler condition leaf that was not
    // adjacent during the first structured condition pass. Re-run the exact same
    // fail-closed proof after those deletions; this does not cross any surviving
    // statement or change condition evaluation frequency.
    loopControlConditionTempRecoveryCount += recoverStructuredLoopBranchConditionTemps(structured.nodes, graph);
    const postCfStaticMemberRecoveryCount = recoverStructuredPostCfStaticMembers(structured.nodes);
    const postCfFunctionDeclarationRecoveryCount = recoverStructuredPostCfFunctionDeclarations(structured.nodes);
    const structuredExpressionPresentationRecoveryCount = recoverStructuredExpressionPresentation(structured.nodes);

    const epochHoisting = hoistEscapingEpochDeclarations(structured.nodes);
    if (!epochHoisting.safe) return { applied: false, reason: epochHoisting.reason || "Beta epoch declaration hoisting failed closed" };
    const scopeError = validateStructuredLocalScopes(structured.nodes);
    if (scopeError) return { applied: false, reason: scopeError };

    const bodyText = formatStructuredNodes(structured.nodes);
    const presented = buildPresentedSource(originalAst, bodyText, { registerOverflowUsed: graph.registerOverflowUsed === true });
    if (!presented.applied) return presented;

    return {
        source: presented.source,
        applied: true,
        mode: "acyclic-structured",
        entryState: entry,
        stateCount: states.length,
        statementCount: countStructuredStatements(structured.nodes),
        branchCount,
        ifConditionTempRecoveryCount,
        structuredLogicalConditionRecoveryCount,
        loopControlConditionTempRecoveryCount,
        postCfClosureDestinationRecoveryCount,
        postCfDeadClosureRecoveryCount,
        postCfDeadScalarLocalRecoveryCount,
        postCfCopyScalarRecoveryCount,
        postCfCompilerGlobalAliasRecoveryCount,
        postCfCompilerClosureTempRecoveryCount,
        postCfCompilerReturnAllRecoveryCount,
        postCfCompilerValueRecoveryCount,
        postCfStaticMemberRecoveryCount,
        postCfFunctionDeclarationRecoveryCount,
        structuredExpressionPresentationRecoveryCount,
        joinCount,
        guardBranchCount,
        terminalReturnCount,
        terminalReturnPayloadSunk: terminalReturnPayloadSunkCount > 0,
        terminalReturnPayloadSunkCount,
        terminalReturnLowered: terminalReturnCount > 0,
        terminalReturnText: terminalReturnCount === 1 ? terminalReturnTexts[0] : null,
        environmentHeader: presented.environmentHeader,
        hoistedEpochDeclarationCount: epochHoisting.count || 0,
        registerOverflowUsed: graph.registerOverflowUsed === true,
        registerOverflowSlotCount: graph.registerOverflowSlotCount || 0,
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
    const statesByOwner = new Map(entries.map(entry => [entry, []]));

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

    for (const state of graph.states) statesByOwner.get(ownerByState.get(state.id)).push(state);

    return { ownerByState, stateById, statesByOwner };
}

function collectClosureFactorySites(graph, ownerByState, closureFactoryByOperation) {
    const entrySet = new Set(graph.entries);
    const sites = [];
    for (const state of graph.states) {
        const parentEntry = ownerByState.get(state.id);
        for (const operation of state.operations || []) {
            const call = parseClosureFactoryCall(operation.rhs);
            if (call) closureFactoryByOperation.set(operation, call);
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

function finalizePresentedSource(source) {
    const text = String(source || "");
    const prefix = "--headers";
    const marker = "\n\n--body\n\n";
    if (!text.startsWith(prefix)) return text;
    const markerIndex = text.indexOf(marker, prefix.length);
    if (markerIndex < 0) return text;
    const headers = text.slice(prefix.length, markerIndex).trim();
    const body = text.slice(markerIndex + marker.length).trim();
    return [headers, body].filter(Boolean).join("\n\n") + "\n";
}

function removeCompilerRootBareReturn(source, terminalReturnText) {
    const text = String(source || "");
    if (terminalReturnText !== "return") return text;
    let ast;
    try {
        ast = luaparse.parse(text, {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
    } catch {
        return text;
    }
    const body = ast.body || [];
    const last = body[body.length - 1];
    if (last?.type !== "ReturnStatement" || (last.arguments || []).length !== 0 || !Array.isArray(last.range)) return text;
    return text.slice(0, last.range[0]).trimEnd() + "\n";
}

function parseNestedBody(bodyText) {
    try {
        return luaparse.parse(String(bodyText || ""), {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
    } catch {
        return null;
    }
}

function directBindingInfo(statement) {
    if (statement?.type !== "LocalStatement" && statement?.type !== "AssignmentStatement") return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) return null;
    return { statement, target: variables[0], init: init[0], declares: statement.type === "LocalStatement" };
}

function staticArgsIndex(node) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "args")) return null;
    const index = numericValue(node.index);
    return Number.isInteger(index) && index >= 1 ? index : null;
}

function varargTailInfo(node) {
    if (node?.type !== "TableConstructorExpression") return null;
    const fields = node.fields || [];
    if (fields.length !== 1 || fields[0]?.type !== "TableValue") return null;
    const call = fields[0].value;
    if (call?.type !== "CallExpression" || !isIdentifier(call.base, "select")) return null;
    const args = call.arguments || [];
    if (args.length !== 2) return null;
    const offset = numericValue(args[0]);
    if (offset === null || offset < 1) return null;
    const unpackCall = args[1];
    if (unpackCall?.type !== "CallExpression" || !isIdentifier(unpackCall.base, "unpack")) return null;
    const unpackArgs = unpackCall.arguments || [];
    if (unpackArgs.length !== 1 || !isIdentifier(unpackArgs[0], "args")) return null;
    return { offset, call, unpackCall };
}

function singleUninitializedLocalFor(body, name, excludedStatements = new Set()) {
    let found = null;
    for (const statement of body) {
        if (excludedStatements.has(statement) || statement?.type !== "LocalStatement") continue;
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (!variables.some(variable => isIdentifier(variable, name))) continue;
        if (variables.length !== 1 || init.length !== 0 || !isIdentifier(variables[0], name)) return { ambiguous: true };
        if (found) return { ambiguous: true };
        found = statement;
    }
    return { statement: found };
}

function recoverNestedFunctionSignature(bodyText, factoryName) {
    const ast = parseNestedBody(bodyText);
    if (!ast) return { recovered: false, bodyText };
    const body = ast.body || [];
    const varargFactory = factoryName === "createClosure";
    const fixedMatch = /^createClosure(\d+)$/.exec(String(factoryName || ""));
    if (!varargFactory && !fixedMatch) return { recovered: false, bodyText };

    const parameterLoads = new Map();
    const tailCandidates = [];
    for (const statement of body) {
        const binding = directBindingInfo(statement);
        if (!binding || !Array.isArray(statement.range)) continue;
        const index = staticArgsIndex(binding.init);
        if (index !== null) {
            if (parameterLoads.has(index)) return { recovered: false, bodyText };
            parameterLoads.set(index, binding);
            continue;
        }
        const tail = varargTailInfo(binding.init);
        if (tail) tailCandidates.push({ ...binding, ...tail });
    }

    let tail = null;
    let fixedCount = 0;
    if (varargFactory) {
        if (tailCandidates.length > 1) return { recovered: false, bodyText };
        tail = tailCandidates[0] || null;
        if (tail) fixedCount = tail.offset - 1;
    } else if (tailCandidates.length !== 0) {
        return { recovered: false, bodyText };
    }

    const directSlots = new Set();
    const directSlotRanges = [];
    let argsSafe = true;
    function scanDirectArgs(node, parent = null, key = null) {
        if (!isNode(node) || !argsSafe) return;
        if (node.type === "FunctionDeclaration") return;
        if (node.type === "IndexExpression" && isIdentifier(node.base, "args")) {
            const slot = numericValue(node.index);
            const isWriteTarget = parent &&
                (parent.type === "AssignmentStatement" || parent.type === "CompoundAssignmentStatement") &&
                key === "variables";
            if (!Number.isInteger(slot) || slot < 1 || isWriteTarget || !Array.isArray(node.range)) {
                argsSafe = false;
                return;
            }
            directSlots.add(slot);
            directSlotRanges.push(node.range);
            return;
        }
        if (isIdentifier(node, "args")) {
            argsSafe = false;
            return;
        }
        for (const childKey of Object.keys(node)) {
            if (childKey === "loc" || childKey === "range") continue;
            const value = node[childKey];
            if (Array.isArray(value)) {
                for (const child of value) scanDirectArgs(child, node, childKey);
            } else if (isNode(value)) scanDirectArgs(value, node, childKey);
        }
    }

    const excludedArgsRanges = [];
    for (const binding of parameterLoads.values()) {
        if (!Array.isArray(binding.init.range)) return { recovered: false, bodyText };
        excludedArgsRanges.push(binding.init.range);
    }
    if (tail) {
        if (!Array.isArray(tail.unpackCall.range)) return { recovered: false, bodyText };
        excludedArgsRanges.push(tail.unpackCall.range);
    }
    const rangeInsideExcluded = range => Array.isArray(range) && excludedArgsRanges.some(excluded => range[0] >= excluded[0] && range[1] <= excluded[1]);
    function scanStatementArgs(node, parent = null, key = null) {
        if (!isNode(node) || !argsSafe) return;
        if (node.type === "FunctionDeclaration") return;
        if (rangeInsideExcluded(node.range)) return;
        if (node.type === "IndexExpression" && isIdentifier(node.base, "args")) {
            const slot = numericValue(node.index);
            const isWriteTarget = parent &&
                (parent.type === "AssignmentStatement" || parent.type === "CompoundAssignmentStatement") &&
                key === "variables";
            if (!Number.isInteger(slot) || slot < 1 || isWriteTarget || !Array.isArray(node.range)) {
                argsSafe = false;
                return;
            }
            directSlots.add(slot);
            directSlotRanges.push(node.range);
            return;
        }
        if (isIdentifier(node, "args")) {
            argsSafe = false;
            return;
        }
        for (const childKey of Object.keys(node)) {
            if (childKey === "loc" || childKey === "range") continue;
            const value = node[childKey];
            if (Array.isArray(value)) for (const child of value) scanStatementArgs(child, node, childKey);
            else if (isNode(value)) scanStatementArgs(value, node, childKey);
        }
    }
    for (const statement of body) scanStatementArgs(statement);
    if (!argsSafe) return { recovered: false, bodyText };

    const highestUsedSlot = Math.max(0, ...parameterLoads.keys(), ...directSlots);
    if (tail) {
        if (highestUsedSlot > fixedCount) return { recovered: false, bodyText };
    } else {
        fixedCount = highestUsedSlot;
    }

    const usedNames = new Set();
    function collectNames(node) {
        if (!isNode(node)) return;
        if (node.type === "Identifier" && typeof node.name === "string") usedNames.add(node.name);
        for (const childKey of Object.keys(node)) {
            if (childKey === "loc" || childKey === "range") continue;
            const value = node[childKey];
            if (Array.isArray(value)) for (const child of value) collectNames(child);
            else if (isNode(value)) collectNames(value);
        }
    }
    for (const statement of body) collectNames(statement);

    const edits = [];
    const parameterNames = [];
    const removedStatements = new Set();
    const slotNames = new Map();
    function freshParameterName(index) {
        const base = `arg${index}`;
        if (!usedNames.has(base)) {
            usedNames.add(base);
            return base;
        }
        for (let suffix = 2; ; suffix++) {
            const name = `${base}_${suffix}`;
            if (!usedNames.has(name)) {
                usedNames.add(name);
                return name;
            }
        }
    }

    for (let index = 1; index <= fixedCount; index++) {
        const binding = parameterLoads.get(index) || null;
        const name = binding ? binding.target.name : freshParameterName(index);
        slotNames.set(index, name);
        parameterNames.push(name);
        if (!binding) continue;
        edits.push({ start: binding.statement.range[0], end: binding.statement.range[1], replacement: "" });
        removedStatements.add(binding.statement);
        if (!binding.declares) {
            const declaration = singleUninitializedLocalFor(body, binding.target.name, removedStatements);
            if (declaration.ambiguous || !declaration.statement || !Array.isArray(declaration.statement.range)) return { recovered: false, bodyText };
            edits.push({ start: declaration.statement.range[0], end: declaration.statement.range[1], replacement: "" });
            removedStatements.add(declaration.statement);
        }
    }

    for (const range of directSlotRanges) {
        const source = String(bodyText || "").slice(range[0], range[1]);
        const parsed = parseTransitionExpression(source);
        const slot = parsed?.expression?.type === "IndexExpression" ? numericValue(parsed.expression.index) : null;
        const name = slotNames.get(slot);
        if (!name) return { recovered: false, bodyText };
        edits.push({ start: range[0], end: range[1], replacement: name });
    }

    if (tail) {
        edits.push({ start: tail.statement.range[0], end: tail.statement.range[1], replacement: "" });
        removedStatements.add(tail.statement);
        if (!tail.declares) {
            const declaration = singleUninitializedLocalFor(body, tail.target.name, removedStatements);
            if (declaration.ambiguous || !declaration.statement || !Array.isArray(declaration.statement.range)) return { recovered: false, bodyText };
            edits.push({ start: declaration.statement.range[0], end: declaration.statement.range[1], replacement: "" });
            removedStatements.add(declaration.statement);
        }

        let tailSafe = true;
        function scanTail(node) {
            if (!isNode(node) || !tailSafe) return;
            if (node.type === "FunctionDeclaration") return;
            if (node.type === "CallExpression" && isIdentifier(node.base, "unpack")) {
                const callArgs = node.arguments || [];
                if (callArgs.length === 1 && isIdentifier(callArgs[0], tail.target.name)) {
                    if (!Array.isArray(node.range)) { tailSafe = false; return; }
                    edits.push({ start: node.range[0], end: node.range[1], replacement: "..." });
                    return;
                }
            }
            if (node.type === "IndexExpression" && isIdentifier(node.base, tail.target.name)) {
                const slot = numericValue(node.index);
                if (slot === null || slot < 1 || !Array.isArray(node.range)) { tailSafe = false; return; }
                edits.push({ start: node.range[0], end: node.range[1], replacement: `(select(${slot}, ...))` });
                return;
            }
            if (isIdentifier(node, tail.target.name)) {
                tailSafe = false;
                return;
            }
            for (const childKey of Object.keys(node)) {
                if (childKey === "loc" || childKey === "range") continue;
                const value = node[childKey];
                if (Array.isArray(value)) for (const child of value) scanTail(child);
                else if (isNode(value)) scanTail(value);
            }
        }
        for (const statement of body) {
            if (removedStatements.has(statement)) continue;
            scanTail(statement);
        }
        if (!tailSafe) return { recovered: false, bodyText };
    }

    const rewrittenBody = applyTextEdits(String(bodyText || ""), edits);
    if (!parseNestedBody(rewrittenBody)) return { recovered: false, bodyText };
    return {
        recovered: true,
        bodyText: rewrittenBody,
        parameters: parameterNames,
        vararg: Boolean(tail),
        fixedParameterCount: fixedCount,
    };
}

function nestedFunctionExpression(bodyText, options = {}) {
    const body = String(bodyText || "").trim();
    const recoveredSignature = options.recoveredSignature === true;
    const parameters = recoveredSignature ? [...(options.parameters || [])] : [];
    if (recoveredSignature && options.vararg === true) parameters.push("...");
    const lines = [recoveredSignature ? `function(${parameters.join(", ")})` : "function(...)"];
    if (!recoveredSignature) lines.push("    local args = { ... }");
    if (options.registerOverflowUsed === true) lines.push("    local RegisterOverflow = {}");
    if (body) lines.push(indentText(body, 1));
    lines.push("end");
    return lines.join("\n");
}

function replaceClosureFactoryOperation(operation, functionExpression, closureInfo = null) {
    const text = String(operationText(operation) || "").trimStart();
    let target = operation?.emittedTarget || null;
    let localPrefix = text.startsWith("local ") ? "local " : "";

    if (!target) {
        const parsed = parseControlFlowStatement(text);
        const statement = parsed?.statement;
        const variables = statement?.variables || [];
        const init = statement?.init || [];
        if (
            (statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") ||
            variables.length !== 1 || init.length !== 1 || !Array.isArray(variables[0]?.range)
        ) return null;
        target = parsed.source.slice(variables[0].range[0], variables[0].range[1]);
        localPrefix = statement.type === "LocalStatement" ? "local " : "";
    }

    return {
        ...operation,
        rhs: functionExpression,
        emittedText: `${localPrefix}${target} = ${functionExpression}`,
        reads: [],
        returnSinkSafe: false,
        compilerClosureFactoryRecovered: closureInfo ? {
            factoryName: closureInfo.factoryName,
            entry: closureInfo.entry,
            captureCount: closureInfo.captureCount,
        } : null,
    };
}

function regionGraph(graph, entry, ownerByState, statesByOwner, solvedBodies, closureFactoryByOperation, signatureByChildFactory) {
    const rawStates = [];
    const closureFactoryCallsByState = new Map();
    const ownedStates = statesByOwner.get(entry);
    if (!ownedStates) return { error: `Closure entry ${entry} has no indexed state region` };
    for (const state of ownedStates) {
        const predecessors = (state.predecessors || []).filter(id => ownerByState.get(id) === entry);
        const successors = [...(state.successors || [])];
        if (successors.some(id => ownerByState.get(id) !== entry)) {
            return { error: `Closure entry ${entry} has a CFG edge into another closure region` };
        }
        const sourceOperations = state.operations || [];
        closureFactoryCallsByState.set(state.id, sourceOperations.map(operation => closureFactoryByOperation.get(operation) || null));
        rawStates.push({
            ...state,
            predecessors,
            successors,
            operations: sourceOperations.map(operation => ({ ...operation })),
        });
    }

    const normalized = normalizeRegisterOverflowGraph({ ...graph, entries: [entry], states: rawStates });
    if (normalized.error) return { error: `Closure entry ${entry}: ${normalized.error}` };

    const states = normalized.graph.states.map(state => {
        const operations = [];
        const closureFactoryCalls = closureFactoryCallsByState.get(state.id) || [];
        for (const [operationIndex, operation] of (state.operations || []).entries()) {
            const call = closureFactoryCalls[operationIndex] || null;
            const child = call ? solvedBodies.get(call.entry) : null;
            if (call && child) {
                if (call.captureCount !== 0) {
                    return { error: `Closure entry ${call.entry} has ${call.captureCount} capture value(s); capture reconstruction is not implemented` };
                }
                const signatureKey = `${call.entry}\0${call.factoryName}`;
                let signature = signatureByChildFactory.get(signatureKey);
                if (!signature) {
                    signature = recoverNestedFunctionSignature(child.bodyText, call.factoryName);
                    signatureByChildFactory.set(signatureKey, signature);
                }
                const replacement = replaceClosureFactoryOperation(
                    operation,
                    nestedFunctionExpression(signature.bodyText, {
                        registerOverflowUsed: child.registerOverflowUsed === true,
                        recoveredSignature: signature.recovered === true,
                        parameters: signature.parameters || [],
                        vararg: signature.vararg === true,
                    }),
                    call
                );
                if (!replacement) {
                    return { error: `Closure factory for entry ${call.entry} has no replaceable beta assignment target` };
                }
                operations.push(replacement);
            } else {
                operations.push({ ...operation });
            }
        }
        return { ...state, operations };
    });
    const stateError = states.find(state => state?.error);
    if (stateError?.error) return { error: stateError.error };

    return {
        graph: {
            ...normalized.graph,
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

    const closureFactoryByOperation = new WeakMap();
    const sites = collectClosureFactorySites(graph, partition.ownerByState, closureFactoryByOperation);
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
    const signatureByChildFactory = new Map();

    for (const entry of ordered.order) {
        const region = regionGraph(
            graph,
            entry,
            partition.ownerByState,
            partition.statesByOwner,
            solvedBodies,
            closureFactoryByOperation,
            signatureByChildFactory
        );
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
        solvedBodies.set(entry, {
            bodyText,
            registerOverflowUsed: solved.registerOverflowUsed === true,
        });
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
        postCfClosureDestinationRecoveryCount: sum("postCfClosureDestinationRecoveryCount"),
        postCfDeadClosureRecoveryCount: sum("postCfDeadClosureRecoveryCount"),
        postCfDeadScalarLocalRecoveryCount: sum("postCfDeadScalarLocalRecoveryCount"),
        postCfNamecallRecoveryCount: sum("postCfNamecallRecoveryCount"),
        postCfStaticMemberRecoveryCount: sum("postCfStaticMemberRecoveryCount"),
        postCfCopyScalarRecoveryCount: sum("postCfCopyScalarRecoveryCount"),
        postCfCompilerGlobalAliasRecoveryCount: sum("postCfCompilerGlobalAliasRecoveryCount"),
        postCfCompilerClosureTempRecoveryCount: sum("postCfCompilerClosureTempRecoveryCount"),
        postCfCompilerReturnAllRecoveryCount: sum("postCfCompilerReturnAllRecoveryCount"),
        terminalReturnLowered: results.every(result => result.terminalReturnLowered),
        terminalReturnText: rootResult.terminalReturnText || null,
        closureRegionCount: graph.entries.length,
        inlinedClosureFactoryCount: sites.length,
    };
}

function solveBetaControlFlowImpl(originalAst, betaResult) {
    if (!betaResult?.graph || !betaResult.applied) {
        return { applied: false, reason: "Beta register analysis is unavailable" };
    }
    const upvalues = betaResult.upvalueRecovery?.completed
        ? {
            applied: Boolean(betaResult.upvalueRecovery.applied),
            safe: Boolean(betaResult.upvalueRecovery.safe),
            reason: betaResult.upvalueRecovery.reason || null,
            stats: betaResult.upvalueRecovery.stats || null,
            graph: betaResult.graph,
        }
        : recoverBetaUpvalues(betaResult);
    if (!upvalues.safe) {
        return { applied: false, reason: upvalues.reason || "Beta upvalue recovery failed closed" };
    }
    const graph = upvalues.graph;
    const posPreservation = removeCompilerPosPreservationOperations(graph);
    if (!graph.cfgComplete) {
        return { applied: false, reason: "Beta CFG is incomplete" };
    }
    let solved;
    if (graph.entries.length === 1) {
        const normalized = normalizeRegisterOverflowGraph(graph);
        if (normalized.error) return { applied: false, reason: normalized.error };
        solved = solveSingleEntryControlFlow(originalAst, normalized.graph);
    } else {
        solved = solveClosureRegions(originalAst, graph);
    }
    if (!solved.applied) return solved;
    const presentedSource = finalizePresentedSource(solved.source);
    const finalSource = removeCompilerRootBareReturn(presentedSource, solved.terminalReturnText);
    return {
        ...solved,
        source: finalSource,
        posPreservationRemoval: posPreservation,
        upvalueRecoveryApplied: upvalues.applied,
        recoveredUpvalueCellCount: upvalues.stats?.recoveredCellCount || 0,
        recoveredCaptureCount: upvalues.stats?.captureCount || 0,
        upvalueReadRewriteCount: upvalues.stats?.readRewriteCount || 0,
        upvalueWriteRewriteCount: upvalues.stats?.writeRewriteCount || 0,
        upvalueReleaseRemovalCount: upvalues.stats?.releaseRemovalCount || 0,
    };
}

function solveBetaControlFlow(originalAst, betaResult) {
    // Transition-expression parses are reused throughout one solve, including
    // repeated loop/branch recognition passes. Large graphs can exceed the old
    // 4k cache many times, so keep one large per-solve cache and release it when
    // the solve finishes.
    transitionParseCache.clear();
    try {
        return solveBetaControlFlowImpl(originalAst, betaResult);
    } finally {
        transitionParseCache.clear();
    }
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
    removeCompilerPosPreservationOperations,
    normalizeRegisterOverflowGraph,
    recoverStructuredPostCfStaticMembers,
    recoverStructuredPostCfFunctionDeclarations,
    recoverStructuredPostCfNamecalls,
    recoverStructuredGenericForGlobalMethodTemps,
    recoverGenericForPackedIterator,
    recoverStructuredPostCfClosureDestinationTemps,
    recoverNestedFunctionSignature,
    recoverStructuredPostCfDeadClosureTemps,
    recoverStructuredPostCfDeadScalarLocals,
    recoverStructuredLogicalConditionPrograms,
    recoverStructuredCompilerValueTemps,
    recoverStructuredCompilerGlobalAliases,
    recoverStructuredCompilerClosureTemps,
    recoverStructuredCompilerReturnAllForwarding,
    normalizeRecoveredLogicalExpression,
    normalizeStructuredSingleValueExpression,
    recoverStructuredExpressionPresentation,
    solveBetaControlFlow,
};
