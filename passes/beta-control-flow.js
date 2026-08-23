function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
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

function sinkTerminalReturnPayload(operations) {
    const result = [...operations];
    const finalTransitionIndex = result.findLastIndex(operation => operation.kind === "state-transition");
    if (finalTransitionIndex < 0) return { operations: result, moved: false };
    const finalTransition = result[finalTransitionIndex];
    if (String(finalTransition.rhs || "").trim() !== "nil") return { operations: result, moved: false };

    const payloadIndexes = [];
    for (let index = 0; index < finalTransitionIndex; index++) {
        if (result[index].kind === "return-payload" && result[index].terminalEmptyReturnPayload === true) payloadIndexes.push(index);
    }
    if (payloadIndexes.length !== 1) return { operations: result, moved: false };

    // Only the structurally proven empty Prometheus terminal ReturnVal = {} payload
    // may move. Arbitrary table constructors can execute field expressions/calls.
    const payloadIndex = payloadIndexes[0];
    if (payloadIndex === finalTransitionIndex - 1) return { operations: result, moved: false };
    const [payload] = result.splice(payloadIndex, 1);
    const newTransitionIndex = result.findLastIndex(operation => operation.kind === "state-transition");
    result.splice(newTransitionIndex, 0, payload);
    return { operations: result, moved: true };
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
        return { applied: false, reason: "Beta CF first stage requires exactly one CFG entry" };
    }
    if (graph.states.length !== 1) {
        return {
            applied: false,
            reason: `Beta CF first stage only flattens a proven single-state CFG (found ${graph.states.length})`,
        };
    }

    const state = graph.states[0];
    if (state.id !== graph.entries[0]) {
        return { applied: false, reason: "The only state is not the CFG entry" };
    }
    if (!Array.isArray(state.successors) || state.successors.length !== 0) {
        return { applied: false, reason: "Beta CF first stage requires the entry state to terminate" };
    }
    if (state.operations.some(operation => operation.kind === "unsupported")) {
        return { applied: false, reason: "The single state contains unsupported beta operations" };
    }

    const operationTexts = state.operations.map(operationText);
    if (operationTexts.some(text => !text)) {
        return { applied: false, reason: "A state operation has no printable beta text" };
    }

    const sunk = sinkTerminalReturnPayload(state.operations);
    const bodyLines = sunk.operations.map(operationText);
    const bodyText = bodyLines.join("\n\n");

    const headerLines = [];
    if (/\b_env\b/.test(bodyText)) {
        const provider = displayEnvironmentProvider(originalAst, "_env");
        if (!provider) {
            return { applied: false, reason: "The flattened body uses _env but its provider is not structurally known" };
        }
        headerLines.push(`local _env = ${provider}`);
    }

    const sections = ["--headers"];
    if (headerLines.length) sections.push(headerLines.join("\n"));
    sections.push("--body");
    sections.push(bodyText);
    const source = sections.join("\n\n") + "\n";

    return {
        source,
        applied: true,
        mode: "single-state",
        entryState: state.id,
        stateCount: graph.states.length,
        statementCount: sunk.operations.length,
        terminalReturnPayloadSunk: sunk.moved,
        environmentHeader: headerLines[0] || null,
    };
}

module.exports = {
    displayEnvironmentProvider,
    sinkTerminalReturnPayload,
    solveBetaControlFlow,
};
