function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

const ENV_GETTERS = new Set(["getgenv", "getfenv"]);

function isGlobalIdentifier(node, name = null) {
    return node?.type === "Identifier" &&
        (name === null || node.name === name) &&
        node.isLocal !== true;
}

function environmentEvidence(node) {
    if (!isNode(node)) return null;

    if (node.type === "CallExpression" &&
        isGlobalIdentifier(node.base) &&
        ENV_GETTERS.has(node.base.name) &&
        (node.arguments?.length ?? 0) === 0) {
        return {
            calls: new Set([node.base.name]),
            probes: new Set(),
            fallback: false,
        };
    }

    if (isGlobalIdentifier(node, "_ENV")) {
        return { calls: new Set(), probes: new Set(), fallback: true };
    }

    if (isGlobalIdentifier(node) && ENV_GETTERS.has(node.name)) {
        return { calls: new Set(), probes: new Set([node.name]), fallback: false };
    }

    if (node.type === "LogicalExpression" && (node.operator === "and" || node.operator === "or")) {
        const left = environmentEvidence(node.left);
        const right = environmentEvidence(node.right);
        if (!left || !right) return null;
        return {
            calls: new Set([...left.calls, ...right.calls]),
            probes: new Set([...left.probes, ...right.probes]),
            fallback: left.fallback || right.fallback,
        };
    }

    return null;
}

function environmentSourceKind(node) {
    const evidence = environmentEvidence(node);
    if (!evidence) return null;

    if (evidence.calls.has("getgenv")) return "getgenv";
    if (evidence.calls.has("getfenv")) return "getfenv";
    if (evidence.fallback && evidence.calls.size === 0 && evidence.probes.size === 0) return "_ENV";
    return null;
}

function findEnvironmentBinding(ast) {
    const candidates = [];

    function walk(node) {
        if (!isNode(node)) return;

        if (node.type === "CallExpression" && node.base?.type === "FunctionDeclaration") {
            const fn = node.base;
            const parameters = fn.parameters || [];
            const args = node.arguments || [];
            const count = Math.min(parameters.length, args.length);

            for (let index = 0; index < count; index++) {
                const parameter = parameters[index];
                if (parameter?.type !== "Identifier") continue;

                const sourceKind = environmentSourceKind(args[index]);
                if (!sourceKind) continue;

                candidates.push({
                    call: node,
                    fn,
                    parameter,
                    argument: args[index],
                    argumentIndex: index,
                    sourceKind,
                });
            }
        }

        for (const [key, value] of Object.entries(node)) {
            if (["loc", "range"].includes(key)) continue;
            if (Array.isArray(value)) {
                for (const child of value) walk(child);
            } else if (isNode(value)) {
                walk(value);
            }
        }
    }

    walk(ast);
    if (candidates.length === 0) return null;

    const priority = { getgenv: 3, getfenv: 2, _ENV: 1 };
    candidates.sort((a, b) => priority[b.sourceKind] - priority[a.sourceKind]);
    return candidates[0];
}

function cloneState(state) {
    return {
        targetVisible: state.targetVisible,
        replacementShadowed: state.replacementShadowed,
    };
}

function renameFunctionParameterBinding(source, candidate, replacementName = "_env") {
    const oldName = candidate.parameter.name;
    if (oldName === replacementName) {
        return {
            source,
            oldName,
            newName: replacementName,
            referencesRenamed: 0,
            alreadyNamed: true,
            collision: false,
        };
    }

    const edits = [];
    let collision = false;

    function addIdentifier(node, state) {
        if (node?.type !== "Identifier" || node.name !== oldName || !state.targetVisible) return;
        if (state.replacementShadowed) {
            collision = true;
            return;
        }
        if (!Array.isArray(node.range)) throw new Error("Environment identifier has no source range");
        edits.push({ start: node.range[0], end: node.range[1], replacement: replacementName });
    }

    function bindName(state, name) {
        if (name === oldName) state.targetVisible = false;
        if (name === replacementName) state.replacementShadowed = true;
    }

    function walkFunction(fn, inheritedState, isTargetFunction = false) {
        const state = cloneState(inheritedState);

        if (!isTargetFunction) {
            for (const parameter of fn.parameters || []) {
                if (parameter?.type === "Identifier") bindName(state, parameter.name);
            }
        } else {
            for (const parameter of fn.parameters || []) {
                if (parameter === candidate.parameter) continue;
                if (parameter?.type === "Identifier") bindName(state, parameter.name);
            }
        }

        walkBlock(fn.body || [], state, false);
    }

    function walkTableField(field, state) {
        if (!isNode(field)) return;
        if (field.type === "TableValue") {
            walkExpression(field.value, state);
        } else if (field.type === "TableKey") {
            walkExpression(field.key, state);
            walkExpression(field.value, state);
        } else if (field.type === "TableKeyString") {
            walkExpression(field.value, state);
        }
    }

    function walkExpression(node, state) {
        if (!isNode(node)) return;

        switch (node.type) {
            case "Identifier":
                addIdentifier(node, state);
                return;
            case "NumericLiteral":
            case "StringLiteral":
            case "BooleanLiteral":
            case "NilLiteral":
            case "VarargLiteral":
                return;
            case "UnaryExpression":
                walkExpression(node.argument, state);
                return;
            case "BinaryExpression":
            case "LogicalExpression":
                walkExpression(node.left, state);
                walkExpression(node.right, state);
                return;
            case "IndexExpression":
                walkExpression(node.base, state);
                walkExpression(node.index, state);
                return;
            case "MemberExpression":
                walkExpression(node.base, state);
                return;
            case "CallExpression":
            case "TableCallExpression":
            case "StringCallExpression":
                walkExpression(node.base, state);
                for (const argument of node.arguments || []) walkExpression(argument, state);
                if (node.argument) walkExpression(node.argument, state);
                return;
            case "TableConstructorExpression":
                for (const field of node.fields || []) walkTableField(field, state);
                return;
            case "FunctionDeclaration":
                walkFunction(node, state, false);
                return;
            default:
                for (const [key, value] of Object.entries(node)) {
                    if (["loc", "range", "identifier", "variables", "parameters", "key"].includes(key)) continue;
                    if (Array.isArray(value)) {
                        for (const child of value) walkExpression(child, state);
                    } else if (isNode(value)) {
                        walkExpression(value, state);
                    }
                }
        }
    }

    function walkStatement(statement, state) {
        if (!isNode(statement)) return;

        switch (statement.type) {
            case "LocalStatement":
                for (const init of statement.init || []) walkExpression(init, state);
                for (const variable of statement.variables || []) {
                    if (variable?.type === "Identifier") bindName(state, variable.name);
                }
                return;

            case "AssignmentStatement":
                for (const variable of statement.variables || []) walkExpression(variable, state);
                for (const init of statement.init || []) walkExpression(init, state);
                return;

            case "CallStatement":
                walkExpression(statement.expression, state);
                return;

            case "ReturnStatement":
                for (const argument of statement.arguments || []) walkExpression(argument, state);
                return;

            case "FunctionDeclaration": {
                if (statement.isLocal && statement.identifier?.type === "Identifier") {
                    const functionState = cloneState(state);
                    bindName(functionState, statement.identifier.name);
                    walkFunction(statement, functionState, false);
                    bindName(state, statement.identifier.name);
                } else {
                    if (statement.identifier) walkExpression(statement.identifier, state);
                    walkFunction(statement, state, false);
                }
                return;
            }

            case "ForNumericStatement": {
                walkExpression(statement.start, state);
                walkExpression(statement.end, state);
                if (statement.step) walkExpression(statement.step, state);
                const child = cloneState(state);
                if (statement.variable?.type === "Identifier") bindName(child, statement.variable.name);
                walkBlock(statement.body || [], child, false);
                return;
            }

            case "ForGenericStatement": {
                for (const iterator of statement.iterators || []) walkExpression(iterator, state);
                const child = cloneState(state);
                for (const variable of statement.variables || []) {
                    if (variable?.type === "Identifier") bindName(child, variable.name);
                }
                walkBlock(statement.body || [], child, false);
                return;
            }

            case "WhileStatement":
                walkExpression(statement.condition, state);
                walkBlock(statement.body || [], cloneState(state), false);
                return;

            case "RepeatStatement": {
                const child = walkBlock(statement.body || [], cloneState(state), false);
                walkExpression(statement.condition, child);
                return;
            }

            case "DoStatement":
                walkBlock(statement.body || [], cloneState(state), false);
                return;

            case "IfStatement":
                for (const clause of statement.clauses || []) {
                    if (clause.condition) walkExpression(clause.condition, state);
                    walkBlock(clause.body || [], cloneState(state), false);
                }
                return;

            case "BreakStatement":
            case "GotoStatement":
            case "LabelStatement":
                return;

            default:
                walkExpression(statement, state);
        }
    }

    function walkBlock(statements, initialState) {
        const state = cloneState(initialState);
        for (const statement of statements) walkStatement(statement, state);
        return state;
    }

    const rootState = { targetVisible: true, replacementShadowed: false };
    walkFunction(candidate.fn, rootState, true);

    if (collision) {
        return {
            source,
            oldName,
            newName: replacementName,
            referencesRenamed: 0,
            alreadyNamed: false,
            collision: true,
            reason: `Cannot rename ${oldName} to ${replacementName}: the replacement name shadows a use of the environment binding`,
        };
    }

    edits.push({
        start: candidate.parameter.range[0],
        end: candidate.parameter.range[1],
        replacement: replacementName,
        declaration: true,
    });

    const unique = new Map();
    for (const edit of edits) unique.set(`${edit.start}:${edit.end}`, edit);
    const ordered = [...unique.values()].sort((a, b) => b.start - a.start);

    let output = source;
    for (const edit of ordered) {
        output = output.slice(0, edit.start) + edit.replacement + output.slice(edit.end);
    }

    return {
        source: output,
        oldName,
        newName: replacementName,
        referencesRenamed: ordered.filter(edit => !edit.declaration).length,
        alreadyNamed: false,
        collision: false,
        edits: ordered,
    };
}

function renameEnvironmentBinding(source, ast, replacementName = "_env") {
    const candidate = findEnvironmentBinding(ast);
    if (!candidate) {
        return {
            source,
            found: false,
            renamed: false,
            reason: "No getgenv/getfenv/_ENV environment argument feeding a function parameter was found",
        };
    }

    const renamed = renameFunctionParameterBinding(source, candidate, replacementName);
    return {
        ...renamed,
        found: true,
        renamed: !renamed.collision && !renamed.alreadyNamed,
        sourceKind: candidate.sourceKind,
        argumentIndex: candidate.argumentIndex,
        argumentRange: candidate.argument.range,
        functionRange: candidate.fn.range,
    };
}

module.exports = {
    environmentSourceKind,
    findEnvironmentBinding,
    renameFunctionParameterBinding,
    renameEnvironmentBinding,
};