function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function cloneState(state) {
    return {
        active: state.active.slice(),
        targetVisible: state.targetVisible.slice(),
        replacementShadowed: state.replacementShadowed.slice(),
    };
}

function renameFunctionParameterBindingsBatch(source, requests, traversalRoot = null) {
    const results = requests.map(request => {
        const parameter = request?.parameter;
        const replacementName = request?.replacementName;
        if (parameter?.type !== "Identifier" || typeof replacementName !== "string") {
            return {
                ...request,
                oldName: parameter?.name ?? null,
                newName: replacementName ?? null,
                referencesRenamed: 0,
                collision: true,
                reason: "Batch parameter rename request is missing an identifier parameter or replacement name",
                edits: [],
            };
        }
        return {
            ...request,
            oldName: parameter.name,
            newName: replacementName,
            referencesRenamed: 0,
            collision: false,
            alreadyNamed: parameter.name === replacementName,
            edits: [],
        };
    });

    const groupsByFunction = new Map();
    const oldNameToIndices = new Map();
    const replacementNameToIndices = new Map();
    const parameterIndices = new Map();

    for (let index = 0; index < results.length; index++) {
        const result = results[index];
        if (result.collision || result.alreadyNamed) continue;
        if (result.fn?.type !== "FunctionDeclaration") {
            result.collision = true;
            result.reason = "Batch parameter rename request is missing its owning function";
            continue;
        }
        if (!groupsByFunction.has(result.fn)) groupsByFunction.set(result.fn, []);
        groupsByFunction.get(result.fn).push(index);
        if (!oldNameToIndices.has(result.oldName)) oldNameToIndices.set(result.oldName, []);
        oldNameToIndices.get(result.oldName).push(index);
        if (!replacementNameToIndices.has(result.newName)) replacementNameToIndices.set(result.newName, []);
        replacementNameToIndices.get(result.newName).push(index);
        if (!parameterIndices.has(result.parameter)) parameterIndices.set(result.parameter, []);
        parameterIndices.get(result.parameter).push(index);
    }

    const emptyState = {
        active: Array(results.length).fill(false),
        targetVisible: Array(results.length).fill(false),
        replacementShadowed: Array(results.length).fill(false),
    };

    function bindName(state, name, skippedIndices = null) {
        const hiddenTargets = oldNameToIndices.get(name);
        if (hiddenTargets) {
            for (const index of hiddenTargets) {
                if (!state.active[index] || skippedIndices?.has(index)) continue;
                state.targetVisible[index] = false;
            }
        }
        const shadowedReplacements = replacementNameToIndices.get(name);
        if (shadowedReplacements) {
            for (const index of shadowedReplacements) {
                if (!state.active[index] || skippedIndices?.has(index)) continue;
                state.replacementShadowed[index] = true;
            }
        }
    }

    function addIdentifier(node, state) {
        if (node?.type !== "Identifier") return;
        const matching = oldNameToIndices.get(node.name);
        if (!matching) return;
        for (const index of matching) {
            if (!state.active[index] || !state.targetVisible[index]) continue;
            const result = results[index];
            if (state.replacementShadowed[index]) {
                result.collision = true;
                result.reason = "Cannot rename " + result.oldName + " to " + result.newName + ": the replacement name shadows a use of the target binding";
                continue;
            }
            if (!Array.isArray(node.range)) {
                result.collision = true;
                result.reason = "Target identifier has no source range";
                continue;
            }
            result.edits.push({
                start: node.range[0],
                end: node.range[1],
                replacement: result.newName,
                declaration: false,
            });
        }
    }

    function walkFunction(fn, inheritedState) {
        const state = cloneState(inheritedState);
        const entering = groupsByFunction.get(fn) || [];
        for (const index of entering) {
            state.active[index] = true;
            state.targetVisible[index] = true;
            state.replacementShadowed[index] = false;
        }

        for (const parameter of fn.parameters || []) {
            if (parameter?.type !== "Identifier") continue;
            const ownTargets = parameterIndices.get(parameter);
            bindName(state, parameter.name, ownTargets ? new Set(ownTargets) : null);
        }
        walkBlock(fn.body || [], state);
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
                walkFunction(node, state);
                return;
            default:
                for (const [key, value] of Object.entries(node)) {
                    if (key === "loc" || key === "range" || key === "identifier" || key === "variables" || key === "parameters" || key === "key") continue;
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
                    walkFunction(statement, functionState);
                    bindName(state, statement.identifier.name);
                } else {
                    if (statement.identifier) walkExpression(statement.identifier, state);
                    walkFunction(statement, state);
                }
                return;
            }
            case "ForNumericStatement": {
                walkExpression(statement.start, state);
                walkExpression(statement.end, state);
                if (statement.step) walkExpression(statement.step, state);
                const child = cloneState(state);
                if (statement.variable?.type === "Identifier") bindName(child, statement.variable.name);
                walkBlock(statement.body || [], child);
                return;
            }
            case "ForGenericStatement": {
                for (const iterator of statement.iterators || []) walkExpression(iterator, state);
                const child = cloneState(state);
                for (const variable of statement.variables || []) {
                    if (variable?.type === "Identifier") bindName(child, variable.name);
                }
                walkBlock(statement.body || [], child);
                return;
            }
            case "WhileStatement":
                walkExpression(statement.condition, state);
                walkBlock(statement.body || [], cloneState(state));
                return;
            case "RepeatStatement": {
                const child = walkBlock(statement.body || [], cloneState(state));
                walkExpression(statement.condition, child);
                return;
            }
            case "DoStatement":
                walkBlock(statement.body || [], cloneState(state));
                return;
            case "IfStatement":
                for (const clause of statement.clauses || []) {
                    if (clause.condition) walkExpression(clause.condition, state);
                    walkBlock(clause.body || [], cloneState(state));
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

    if (traversalRoot) {
        walkExpression(traversalRoot, emptyState);
    } else {
        // Compatibility fallback for callers without a common traversal root.
        for (const fn of groupsByFunction.keys()) walkFunction(fn, emptyState);
    }

    for (let index = 0; index < results.length; index++) {
        const result = results[index];
        if (result.collision || result.alreadyNamed) {
            result.edits = [];
            result.referencesRenamed = 0;
            continue;
        }
        if (!Array.isArray(result.parameter.range)) {
            result.collision = true;
            result.reason = "Target parameter has no source range";
            result.edits = [];
            continue;
        }
        result.edits.push({
            start: result.parameter.range[0],
            end: result.parameter.range[1],
            replacement: result.newName,
            declaration: true,
        });
        const unique = new Map();
        for (const edit of result.edits) unique.set(edit.start + ":" + edit.end, edit);
        result.edits = [...unique.values()];
        result.referencesRenamed = result.edits.reduce((count, edit) => count + (edit.declaration ? 0 : 1), 0);
    }

    const combined = new Map();
    let batchConflict = false;
    let batchConflictReason = null;
    for (const result of results) {
        if (result.collision || result.alreadyNamed) continue;
        for (const edit of result.edits) {
            const key = edit.start + ":" + edit.end;
            const previous = combined.get(key);
            if (previous && previous.replacement !== edit.replacement) {
                batchConflict = true;
                batchConflictReason = "Two batch renames target the same source range with different replacements";
                break;
            }
            combined.set(key, edit);
        }
        if (batchConflict) break;
    }

    if (batchConflict) {
        return { source, changed: false, results, batchConflict: true, reason: batchConflictReason, edits: [] };
    }

    const edits = [...combined.values()].sort((a, b) => a.start - b.start || a.end - b.end);
    const chunks = [];
    let cursor = 0;
    for (const edit of edits) {
        if (edit.start < cursor) {
            return { source, changed: false, results, batchConflict: true, reason: "Overlapping batch rename edits", edits: [] };
        }
        chunks.push(source.slice(cursor, edit.start), edit.replacement);
        cursor = edit.end;
    }
    chunks.push(source.slice(cursor));
    const output = chunks.join("");

    return {
        source: output,
        changed: edits.length > 0,
        results,
        batchConflict: false,
        edits,
    };
}

module.exports = {
    renameFunctionParameterBindingsBatch,
};