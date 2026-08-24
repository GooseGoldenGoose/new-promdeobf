from pathlib import Path
p = Path(r'passes/beta-upvalues.js')
s = p.read_text(encoding='utf-8')

def rep(old, new, label):
    global s
    if old not in s:
        raise SystemExit('missing anchor: ' + label)
    s = s.replace(old, new, 1)

old = '''function isUpvalueValuesIndex(node) {
    return node?.type === "IndexExpression" && isIdentifier(node.base, "upvalueValues");
}
'''
new = '''function isUpvalueValuesIndex(node) {
    return node?.type === "IndexExpression" && isIdentifier(node.base, "upvalueValues");
}

function registerOverflowSlot(node) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "RegisterOverflow")) return null;
    const slot = numericValue(node.index);
    return Number.isInteger(slot) && slot >= 1 ? slot : null;
}

function operationRhsText(operation) {
    if (typeof operation?.rhs === "string" && operation.rhs.trim()) return operation.rhs;
    const parsed = parseStatement(operation?.emittedText);
    const statement = parsed?.statement;
    if (statement?.type === "AssignmentStatement") {
        const init = statement.init || [];
        if ((statement.variables || []).length === 1 && init.length === 1 && Array.isArray(init[0]?.range)) {
            return parsed.source.slice(init[0].range[0], init[0].range[1]);
        }
    }
    if (statement?.type === "CompoundAssignmentStatement" && Array.isArray(statement.value?.range)) {
        return parsed.source.slice(statement.value.range[0], statement.value.range[1]);
    }
    return null;
}

function overflowWriteFromOperation(operation) {
    const parsed = parseStatement(operation?.emittedText);
    const statement = parsed?.statement;
    if (statement?.type === "AssignmentStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (variables.length !== 1 || init.length !== 1) return null;
        const slot = registerOverflowSlot(variables[0]);
        return slot === null ? null : { parsed, statement, target: variables[0], value: init[0], slot, compound: false };
    }
    if (statement?.type === "CompoundAssignmentStatement") {
        const slot = registerOverflowSlot(statement.variable);
        return slot === null ? null : { parsed, statement, target: statement.variable, value: statement.value, slot, compound: true };
    }
    return null;
}

function cloneDefinitionMap(map) {
    return new Map([...map].map(([slot, defs]) => [slot, new Set(defs)]));
}

function definitionMapsEqual(left, right) {
    if (left.size !== right.size) return false;
    for (const [slot, defs] of left) {
        const other = right.get(slot);
        if (!other || other.size !== defs.size || [...defs].some(def => !other.has(def))) return false;
    }
    return true;
}

function mergeOverflowDefinitionMaps(maps) {
    const merged = new Map();
    for (const map of maps) {
        for (const [slot, defs] of map || []) {
            if (!merged.has(slot)) merged.set(slot, new Set());
            for (const def of defs) merged.get(slot).add(def);
        }
    }
    return merged;
}

function buildOverflowStorageAnalysis(graph) {
    const writeByOperation = new Map();
    const writesByState = new Map();
    const defInfoById = new Map();
    for (const state of graph.states || []) {
        const bySlot = new Map();
        for (let index = 0; index < (state.operations || []).length; index++) {
            const operation = state.operations[index];
            const write = overflowWriteFromOperation(operation);
            if (!write) continue;
            const defId = `overflow-def:${write.slot}:${state.id}:${index}`;
            const info = { ...write, defId, stateId: state.id, operationIndex: index, operation };
            writeByOperation.set(operation, info);
            defInfoById.set(defId, info);
            if (!bySlot.has(write.slot)) bySlot.set(write.slot, []);
            bySlot.get(write.slot).push(info);
        }
        writesByState.set(state.id, bySlot);
    }

    const inDefinitions = new Map((graph.states || []).map(state => [state.id, new Map()]));
    const outDefinitions = new Map((graph.states || []).map(state => [state.id, new Map()]));
    let changed = true;
    while (changed) {
        changed = false;
        for (const state of graph.states || []) {
            const predMaps = (state.predecessors || []).map(id => outDefinitions.get(id) || new Map());
            const nextIn = mergeOverflowDefinitionMaps(predMaps);
            const nextOut = cloneDefinitionMap(nextIn);
            for (const operation of state.operations || []) {
                const write = writeByOperation.get(operation);
                if (write) nextOut.set(write.slot, new Set([write.defId]));
            }
            if (!definitionMapsEqual(nextIn, inDefinitions.get(state.id))) {
                inDefinitions.set(state.id, nextIn);
                changed = true;
            }
            if (!definitionMapsEqual(nextOut, outDefinitions.get(state.id))) {
                outDefinitions.set(state.id, nextOut);
                changed = true;
            }
        }
    }

    function uniqueDefinitionBefore(position, slot) {
        const writes = writesByState.get(position.stateId)?.get(slot) || [];
        let low = 0;
        let high = writes.length - 1;
        let found = null;
        while (low <= high) {
            const middle = (low + high) >> 1;
            if (writes[middle].operationIndex < position.operationIndex) {
                found = writes[middle];
                low = middle + 1;
            } else {
                high = middle - 1;
            }
        }
        if (found) return found.defId;
        const incoming = inDefinitions.get(position.stateId)?.get(slot);
        return incoming?.size === 1 ? incoming.values().next().value : null;
    }

    function currentWriteDefinition(position) {
        return writeByOperation.get(position.operation)?.defId || null;
    }

    return { writeByOperation, defInfoById, uniqueDefinitionBefore, currentWriteDefinition };
}

function storageReadKey(node, position, overflowAnalysis) {
    if (isIdentifier(node)) return node.name;
    const slot = registerOverflowSlot(node);
    return slot === null ? null : overflowAnalysis.uniqueDefinitionBefore(position, slot);
}

function operationTargetStorageKey(position, overflowAnalysis) {
    if (position.operation?.emittedTarget) return position.operation.emittedTarget;
    return overflowAnalysis.currentWriteDefinition(position);
}
'''
rep(old,new,'storage helpers')
rep('''function factoryCallFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);''','''function factoryCallFromOperation(operation) {
    const parsed = parseExpression(operationRhsText(operation));''','factory rhs')
old2='''function releaseCellFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);
    const expression = parsed?.expression;
    if (!isCall(expression, "releaseUpvalue", 1)) return null;
    const argument = expression.arguments[0];
    if (!isIdentifier(argument)) return null;
    return { cellName: argument.name, resultName: operation?.emittedTarget || null };
}

function allocationFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);
    const expression = parsed?.expression;
    if (!isCall(expression, "allocUpvalue", 0) || !operation?.emittedTarget) return null;
    return { cellName: operation.emittedTarget };
}

function identifierCopyFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);
    const expression = parsed?.expression;
    if (!isIdentifier(expression) || !operation?.emittedTarget) return null;
    return { sourceName: expression.name, targetName: operation.emittedTarget };
}
'''
new2='''function releaseCellFromOperation(position, overflowAnalysis) {
    const parsed = parseExpression(operationRhsText(position.operation));
    const expression = parsed?.expression;
    if (!isCall(expression, "releaseUpvalue", 1)) return null;
    const cellName = storageReadKey(expression.arguments[0], position, overflowAnalysis);
    if (!cellName) return null;
    return { cellName, resultName: operationTargetStorageKey(position, overflowAnalysis) };
}

function allocationFromOperation(position, overflowAnalysis) {
    const parsed = parseExpression(operationRhsText(position.operation));
    const expression = parsed?.expression;
    const targetName = operationTargetStorageKey(position, overflowAnalysis);
    if (!isCall(expression, "allocUpvalue", 0) || !targetName) return null;
    return { cellName: targetName };
}

function storageCopyFromOperation(position, overflowAnalysis) {
    const parsed = parseExpression(operationRhsText(position.operation));
    const expression = parsed?.expression;
    const sourceName = storageReadKey(expression, position, overflowAnalysis);
    const targetName = operationTargetStorageKey(position, overflowAnalysis);
    if (!sourceName || !targetName) return null;
    return { sourceName, targetName };
}
'''
rep(old2,new2,'cell helpers')
p.write_text(s,encoding='utf-8')
print('patched beta-upvalues storage primitives')
