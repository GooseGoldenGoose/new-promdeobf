const luaparse = require("../parser/luaparse");
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

const PARSE_CACHE_LIMIT = 4096;
const expressionParseCache = new Map();
const statementParseCache = new Map();

function cacheParse(cache, key, parse) {
    if (cache.has(key)) return cache.get(key);
    const value = parse();
    if (cache.size >= PARSE_CACHE_LIMIT) cache.clear();
    cache.set(key, value);
    return value;
}

function parseExpression(text) {
    const key = String(text || "");
    return cacheParse(expressionParseCache, key, () => {
        const prefix = "local __beta_upvalue_expr = ";
        const source = prefix + key;
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
            return expression ? { source, prefix, expression } : null;
        } catch {
            return null;
        }
    });
}

function parseStatement(text) {
    const source = String(text || "");
    return cacheParse(statementParseCache, source, () => {
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
    });
}

function isCall(node, name, argCount = null) {
    if (node?.type !== "CallExpression" || !isIdentifier(node.base, name)) return false;
    return argCount === null || (node.arguments || []).length === argCount;
}

function isClosureFactoryName(name) {
    return typeof name === "string" && /^createClosure(?:\d+)?$/.test(name);
}

function upvalueSlot(node) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalues")) return null;
    const slot = numericValue(node.index);
    return Number.isInteger(slot) && slot >= 1 ? slot : null;
}

function isUpvalueValuesIndex(node) {
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

function tableValues(node) {
    if (node?.type !== "TableConstructorExpression") return null;
    const values = [];
    for (const field of node.fields || []) {
        if (field?.type !== "TableValue") return null;
        values.push(field.value);
    }
    return values;
}

function partitionClosureRegions(graph) {
    const entries = [...(graph.entries || [])];
    const entrySet = new Set(entries);
    const stateById = new Map((graph.states || []).map(state => [state.id, state]));
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

    if (ownerByState.size !== (graph.states || []).length) {
        return { error: `Upvalue recovery owns ${ownerByState.size}/${(graph.states || []).length} states` };
    }
    return { ownerByState, stateById };
}

function factoryCallFromOperation(operation) {
    const parsed = parseExpression(operationRhsText(operation));
    const call = parsed?.expression;
    if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !isClosureFactoryName(call.base.name)) return null;
    const args = call.arguments || [];
    const entry = numericValue(args[0]);
    const captures = tableValues(args[1]);
    if (entry === null || !captures) return null;
    return { parsed, call, entry, captures, factoryName: call.base.name };
}

function indexedWriteFromOperation(operation) {
    const parsed = parseStatement(operation?.emittedText);
    const statement = parsed?.statement;
    if (statement?.type === "AssignmentStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (variables.length !== 1 || init.length !== 1 || !isUpvalueValuesIndex(variables[0])) return null;
        return { parsed, statement, target: variables[0], value: init[0], compoundOperator: null };
    }
    if (statement?.type === "CompoundAssignmentStatement" && isUpvalueValuesIndex(statement.variable)) {
        return { parsed, statement, target: statement.variable, value: statement.value, compoundOperator: statement.op || null };
    }
    return null;
}

function releaseCellFromOperation(position, overflowAnalysis) {
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

function cloneGraph(graph) {
    return {
        ...graph,
        entries: [...(graph.entries || [])],
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: Array.isArray(state.predecessors) ? [...state.predecessors] : state.predecessors,
            successors: Array.isArray(state.successors) ? [...state.successors] : state.successors,
            operations: (state.operations || []).map(operation => ({
                ...operation,
                reads: [...(operation.reads || [])],
                returnExpressions: Array.isArray(operation.returnExpressions)
                    ? [...operation.returnExpressions]
                    : operation.returnExpressions,
            })),
        })),
    };
}

function operationPositions(graph, ownerByState) {
    const positions = [];
    for (const state of graph.states || []) {
        const ownerEntry = ownerByState.get(state.id);
        for (let operationIndex = 0; operationIndex < (state.operations || []).length; operationIndex++) {
            positions.push({ state, stateId: state.id, ownerEntry, operationIndex, operation: state.operations[operationIndex] });
        }
    }
    return positions;
}

function rewriteExpressionUpvalues(text, position, resolveCellIndex, bindingByCell) {
    const parsed = parseExpression(text);
    if (!parsed) return { error: "Expression could not be reparsed during beta upvalue recovery" };
    const edits = [];
    const bindingReads = new Set();
    let unresolved = null;

    function visit(node) {
        if (!isNode(node) || unresolved) return;
        if (isUpvalueValuesIndex(node)) {
            const cellId = resolveCellIndex(position.ownerEntry, node.index, position);
            if (!cellId) {
                unresolved = "An upvalueValues read has no uniquely resolved cell";
                return;
            }
            const bindingName = bindingByCell.get(cellId);
            if (!bindingName) {
                unresolved = `Resolved cell ${cellId} has no recovered lexical binding`;
                return;
            }
            edits.push({ start: node.range[0], end: node.range[1], replacement: bindingName });
            bindingReads.add(bindingName);
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }

    visit(parsed.expression);
    if (unresolved) return { error: unresolved };
    const rewritten = edits.length ? applyTextEdits(parsed.source, edits).slice(parsed.prefix.length) : String(text || "");
    return { text: rewritten, bindingReads };
}

function rewriteStatementUpvalueReads(text, position, resolveCellIndex, bindingByCell) {
    const parsed = parseStatement(text);
    if (!parsed) return { error: "Statement could not be reparsed during beta upvalue recovery" };
    const edits = [];
    const bindingReads = new Set();
    let unresolved = null;

    function visit(node) {
        if (!isNode(node) || unresolved) return;
        if (isUpvalueValuesIndex(node)) {
            const cellId = resolveCellIndex(position.ownerEntry, node.index, position);
            if (!cellId) {
                unresolved = "An upvalueValues read has no uniquely resolved cell";
                return;
            }
            const bindingName = bindingByCell.get(cellId);
            if (!bindingName) {
                unresolved = `Resolved cell ${cellId} has no recovered lexical binding`;
                return;
            }
            edits.push({ start: node.range[0], end: node.range[1], replacement: bindingName });
            bindingReads.add(bindingName);
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }

    visit(parsed.statement);
    if (unresolved) return { error: unresolved };
    const rewritten = edits.length ? applyTextEdits(parsed.source, edits) : String(text || "");
    return { text: rewritten, bindingReads };
}
function countIdentifier(node, name) {
    let count = 0;
    walk(node, current => {
        if (isIdentifier(current, name)) count++;
    });
    return count;
}

function countStorageKeyUsesAtPosition(position, storageKey, overflowAnalysis) {
    const parsed = parseStatement(position.operation?.emittedText);
    if (!parsed) return null;
    if (!String(storageKey).startsWith("overflow-def:")) {
        return countIdentifier(parsed.statement, storageKey);
    }

    const statement = parsed.statement;
    let skipTarget = null;
    if (statement?.type === "AssignmentStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (variables.length === 1 && init.length === 1 && registerOverflowSlot(variables[0]) !== null) {
            skipTarget = variables[0];
        }
    }
    let count = overflowAnalysis.currentWriteDefinition(position) === storageKey ? 1 : 0;

    function visit(node) {
        if (!isNode(node) || node === skipTarget) return;
        const slot = registerOverflowSlot(node);
        if (slot !== null) {
            if (storageReadKey(node, position, overflowAnalysis) === storageKey) count++;
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }

    visit(parsed.statement);
    return count;
}

function containsVmUpvalueMachinery(text) {
    const parsed = parseStatement(text);
    if (!parsed) return true;
    let found = false;
    walk(parsed.statement, node => {
        if (found) return;
        if (isUpvalueValuesIndex(node) || upvalueSlot(node) !== null) {
            found = true;
            return;
        }
        if (node?.type === "CallExpression" && isIdentifier(node.base) &&
            (node.base.name === "allocUpvalue" || node.base.name === "releaseUpvalue")) {
            found = true;
        }
    });
    return found;
}

function recoverBetaUpvalues(betaResult) {
    const originalGraph = betaResult?.graph || betaResult;
    if (!originalGraph?.cfgComplete || !Array.isArray(originalGraph.states) || !Array.isArray(originalGraph.entries)) {
        return { applied: false, safe: false, reason: "Beta upvalue recovery requires a complete beta CFG" };
    }

    const graph = cloneGraph(originalGraph);
    const partition = partitionClosureRegions(graph);
    if (partition.error) return { applied: false, safe: false, reason: partition.error };
    const { ownerByState, stateById } = partition;
    const positions = operationPositions(graph, ownerByState);
    const overflowAnalysis = buildOverflowStorageAnalysis(graph);

    // CFG dominance is computed per closure owner. A captured cell does not need
    // its whole owner function to be single-state: it is sufficient for the
    // allocation point to dominate every owner-side occurrence of that cell.
    // This keeps a cell allocated inside a loop body inside that loop body, while
    // cells allocated in a loop preheader remain visible to the loop states they
    // dominate.
    const dominatorsByState = new Map();
    for (const ownerEntry of graph.entries) {
        const ownerStateIds = graph.states
            .filter(state => ownerByState.get(state.id) === ownerEntry)
            .map(state => state.id);
        const ownerSet = new Set(ownerStateIds);
        const allOwnerStates = new Set(ownerStateIds);
        const dominators = new Map();
        for (const stateId of ownerStateIds) {
            dominators.set(stateId, stateId === ownerEntry ? new Set([stateId]) : new Set(allOwnerStates));
        }

        let changed = true;
        while (changed) {
            changed = false;
            for (const stateId of ownerStateIds) {
                if (stateId === ownerEntry) continue;
                const state = stateById.get(stateId);
                const predecessors = (state?.predecessors || []).filter(id => ownerSet.has(id));
                if (!predecessors.length) continue;
                let intersection = new Set(dominators.get(predecessors[0]) || []);
                for (const predecessor of predecessors.slice(1)) {
                    const predecessorDominators = dominators.get(predecessor) || new Set();
                    intersection = new Set([...intersection].filter(id => predecessorDominators.has(id)));
                }
                intersection.add(stateId);
                const previous = dominators.get(stateId) || new Set();
                if (previous.size !== intersection.size || [...previous].some(id => !intersection.has(id))) {
                    dominators.set(stateId, intersection);
                    changed = true;
                }
            }
        }
        for (const [stateId, stateDominators] of dominators) dominatorsByState.set(stateId, stateDominators);
    }

    function dominates(dominatorStateId, stateId) {
        return dominatorsByState.get(stateId)?.has(dominatorStateId) === true;
    }

    const usedBindingNames = new Set();
    for (const position of positions) {
        const parsed = parseStatement(position.operation?.emittedText);
        if (!parsed) continue;
        walk(parsed.statement, node => {
            if (isIdentifier(node)) usedBindingNames.add(node.name);
        });
    }
    let nextOverflowCellBindingId = 1;
    function allocateCellStorageBindingName(storageName) {
        if (/^[A-Za-z_][A-Za-z0-9_]*$/.test(String(storageName || ""))) return storageName;
        while (usedBindingNames.has(`r_overflow_cell_${nextOverflowCellBindingId}`)) nextOverflowCellBindingId++;
        const name = `r_overflow_cell_${nextOverflowCellBindingId++}`;
        usedBindingNames.add(name);
        return name;
    }

    const cells = new Map();
    for (const position of positions) {
        const allocation = allocationFromOperation(position, overflowAnalysis);
        if (!allocation) continue;
        if (cells.has(allocation.cellName)) {
            return { applied: false, safe: false, reason: `Beta upvalue cell register ${allocation.cellName} has multiple allocations` };
        }
        cells.set(allocation.cellName, {
            id: allocation.cellName,
            registerName: allocation.cellName,
            storageBindingName: allocateCellStorageBindingName(allocation.cellName),
            ownerEntry: position.ownerEntry,
            allocation: position,
            initialization: null,
            bindingName: null,
            bindingMode: null,
            aliases: new Set(),
        });
    }

    // Local Prometheus ForIn upvalue promotion may allocate a cell through a
    // temporary (often the reusable POS register), initialize that cell, then
    // copy the cell id into the source variable reserved register. Treat only
    // this compiler-shaped same-state copy as a static alias of the allocation
    // site; arbitrary identifier copies remain ordinary values.
    const cellIdByRegister = new Map([...cells.keys()].map(name => [name, name]));
    const aliasCopyOperations = new Set();
    for (const cell of cells.values()) {
        const sameState = positions.filter(position =>
            position.ownerEntry === cell.ownerEntry && position.stateId === cell.allocation.stateId
        );
        for (const candidate of sameState) {
            if (candidate.operationIndex <= cell.allocation.operationIndex) continue;
            const copy = storageCopyFromOperation(candidate, overflowAnalysis);
            if (!copy || copy.sourceName !== cell.registerName || copy.targetName === cell.registerName) continue;

            const initializationsBeforeCopy = sameState.filter(position => {
                if (position.operationIndex <= cell.allocation.operationIndex || position.operationIndex >= candidate.operationIndex) return false;
                const write = indexedWriteFromOperation(position.operation);
                return write && resolveCellIndex(position.ownerEntry, write.target.index, position) === cell.id;
            });
            if (initializationsBeforeCopy.length !== 1) continue;

            const aliasWrites = positions.filter(position =>
                position.ownerEntry === cell.ownerEntry && operationTargetStorageKey(position, overflowAnalysis) === copy.targetName
            );
            if (!aliasWrites.length || aliasWrites.some(position => {
                if (position.operation === candidate.operation) return false;
                return releaseCellFromOperation(position, overflowAnalysis)?.cellName !== copy.targetName;
            })) continue;

            const existing = cellIdByRegister.get(copy.targetName);
            if (existing && existing !== cell.id) {
                return { applied: false, safe: false, reason: "Beta upvalue alias " + copy.targetName + " resolves to multiple cell allocations" };
            }
            cellIdByRegister.set(copy.targetName, cell.id);
            cell.aliases.add(copy.targetName);
            aliasCopyOperations.add(candidate.operation);
        }
    }

    const factorySites = [];
    for (const position of positions) {
        const factory = factoryCallFromOperation(position.operation);
        if (!factory) continue;
        factorySites.push({ ...position, ...factory });
    }

    const hasCapturedFactories = factorySites.some(site => site.captures.length > 0);
    if (!hasCapturedFactories) {
        return {
            applied: false,
            safe: true,
            graph,
            stats: { cellCount: cells.size, recoveredCellCount: 0, captureCount: 0, readRewriteCount: 0, writeRewriteCount: 0, releaseRemovalCount: 0 },
        };
    }

    const entrySet = new Set(graph.entries);
    const referencedEntries = new Set(factorySites.filter(site => entrySet.has(site.entry)).map(site => site.entry));
    const rootEntries = graph.entries.filter(entry => !referencedEntries.has(entry));
    if (rootEntries.length !== 1) {
        return { applied: false, safe: false, reason: `Beta upvalue recovery requires one root closure entry (found ${rootEntries.length})` };
    }
    const rootEntry = rootEntries[0];

    const siteByChild = new Map();
    const sitesByParent = new Map(graph.entries.map(entry => [entry, []]));
    for (const site of factorySites) {
        if (!entrySet.has(site.entry)) continue;
        if (siteByChild.has(site.entry)) {
            return { applied: false, safe: false, reason: `Closure entry ${site.entry} has multiple static factory sites; captured lexical recovery is ambiguous` };
        }
        siteByChild.set(site.entry, site);
        sitesByParent.get(site.ownerEntry)?.push(site);
    }
    for (const entry of graph.entries) {
        if (entry === rootEntry) continue;
        if (!siteByChild.has(entry)) {
            return { applied: false, safe: false, reason: `Closure entry ${entry} has no static parent factory site` };
        }
    }

    const captureCellsByEntry = new Map([[rootEntry, new Map()]]);

    function resolveCellIndex(ownerEntry, indexNode, position) {
        const storageKey = position ? storageReadKey(indexNode, position, overflowAnalysis) : null;
        if (storageKey) {
            const cellId = cellIdByRegister.get(storageKey);
            return cellId && cells.get(cellId)?.ownerEntry === ownerEntry ? cellId : null;
        }
        const slot = upvalueSlot(indexNode);
        if (slot === null) return null;
        return captureCellsByEntry.get(ownerEntry)?.get(slot) || null;
    }

    const queue = [rootEntry];
    let queueCursor = 0;
    const visitedEntries = new Set();
    let captureCount = 0;
    while (queueCursor < queue.length) {
        const parentEntry = queue[queueCursor++];
        if (visitedEntries.has(parentEntry)) continue;
        visitedEntries.add(parentEntry);
        for (const site of sitesByParent.get(parentEntry) || []) {
            const slotMap = new Map();
            for (let index = 0; index < site.captures.length; index++) {
                const capture = site.captures[index];
                const cellId = resolveCellIndex(parentEntry, capture, site);
                if (!cellId) {
                    return { applied: false, safe: false, reason: `Closure entry ${site.entry} capture slot ${index + 1} does not resolve to a proven upvalue cell` };
                }
                slotMap.set(index + 1, cellId);
                captureCount++;
            }
            captureCellsByEntry.set(site.entry, slotMap);
            queue.push(site.entry);
        }
    }
    if (visitedEntries.size !== graph.entries.length) {
        return { applied: false, safe: false, reason: `Beta upvalue closure graph reached ${visitedEntries.size}/${graph.entries.length} entries` };
    }

    const capturedCellIds = new Set();
    for (const slots of captureCellsByEntry.values()) {
        for (const cellId of slots.values()) capturedCellIds.add(cellId);
    }

    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        if (!cell) return { applied: false, safe: false, reason: `Captured cell ${cellId} has no allocUpvalue definition` };

        const cellRegisterNames = new Set([cell.registerName, ...cell.aliases]);
        const ownerFootprint = positions.filter(position => {
            if (position.ownerEntry !== cell.ownerEntry) return false;
            return [...cellRegisterNames].some(name => {
                const count = countStorageKeyUsesAtPosition(position, name, overflowAnalysis);
                return count !== null && count > 0;
            });
        });
        if (!ownerFootprint.length || ownerFootprint.some(position => !dominates(cell.allocation.stateId, position.stateId))) {
            return { applied: false, safe: false, reason: `Captured cell ${cellId} has owner-side uses not dominated by its allocation state` };
        }

        const candidates = [];
        for (const position of positions) {
            if (position.ownerEntry !== cell.ownerEntry || position.stateId !== cell.allocation.stateId) continue;
            if (position.operationIndex <= cell.allocation.operationIndex) continue;
            const write = indexedWriteFromOperation(position.operation);
            if (!write) continue;
            const targetCell = resolveCellIndex(position.ownerEntry, write.target.index, position);
            if (targetCell === cellId) candidates.push({ ...position, ...write });
        }
        if (!candidates.length) {
            return { applied: false, safe: false, reason: `Captured cell ${cellId} has no compiler-shaped initialization write` };
        }
        cell.initialization = candidates[0];

        const initValue = cell.initialization.value;
        if (isIdentifier(initValue)) {
            const candidateName = initValue.name;
            const candidateWrites = positions.filter(position => position.operation?.emittedTarget === candidateName);
            const candidateDeclaration = candidateWrites.length === 1 ? candidateWrites[0] : null;
            const candidateReads = positions.filter(position => (position.operation?.reads || []).includes(candidateName));
            const onlyFeedsInitialization = candidateReads.length === 1 && candidateReads[0].operation === cell.initialization.operation;
            if (
                candidateDeclaration &&
                onlyFeedsInitialization &&
                candidateDeclaration.ownerEntry === cell.ownerEntry &&
                candidateDeclaration.stateId === cell.initialization.stateId &&
                candidateDeclaration.operationIndex < cell.initialization.operationIndex &&
                String(candidateDeclaration.operation.emittedText || "").trimStart().startsWith("local ")
            ) {
                cell.bindingName = candidateName;
                cell.bindingMode = "existing-beta-binding";
            }
        }
        if (!cell.bindingName) {
            cell.bindingName = cell.storageBindingName;
            cell.bindingMode = "cell-register-binding";
        }

        // A closure may be created before the compiler emits the cell's first
        // value initialization (captured parameters are a real example). A Lua
        // local declared only at that later initialization point would not be in
        // lexical scope for the already-created nested function. In that case,
        // keep the recovered cell binding name but hoist only its declaration to
        // the original allocUpvalue site, then assign the value at the original
        // initialization site. Same-state order is textual; cross-state order is
        // accepted only when CFG dominance proves which point must execute first.
        const captureSites = factorySites.filter(site =>
            site.ownerEntry === cell.ownerEntry &&
            site.captures.some(capture => resolveCellIndex(site.ownerEntry, capture, site) === cellId)
        );
        let captureBeforeInitialization = false;
        for (const site of captureSites) {
            if (site.stateId === cell.initialization.stateId) {
                if (site.operationIndex < cell.initialization.operationIndex) captureBeforeInitialization = true;
                continue;
            }
            if (dominates(cell.initialization.stateId, site.stateId)) continue;
            if (dominates(site.stateId, cell.initialization.stateId)) {
                captureBeforeInitialization = true;
                continue;
            }
            return { applied: false, safe: false, reason: `Captured cell ${cellId} has a factory capture with ambiguous order relative to initialization` };
        }
        if (captureBeforeInitialization) {
            cell.bindingName = cell.storageBindingName;
            cell.bindingMode = "hoisted-cell-binding";
        }
    }

    const bindingByCell = new Map([...cells.values()].filter(cell => capturedCellIds.has(cell.id)).map(cell => [cell.id, cell.bindingName]));
    const localCellNames = new Set();
    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        localCellNames.add(cell.registerName);
        for (const alias of cell.aliases) localCellNames.add(alias);
    }

    // Validate every direct allocation storage identity and every proven compiler alias
    // before deleting the VM cell representation. Scalar beta locals and static
    // RegisterOverflow slots use the same storage-identity proof here; overflow
    // identities are distinguished by their unique reaching definition rather than
    // by the raw physical slot number.
    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        for (const registerName of [cell.registerName, ...cell.aliases]) {
            for (const position of positions) {
                const totalUses = countStorageKeyUsesAtPosition(position, registerName, overflowAnalysis);
                if (totalUses === null) {
                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " appears in an unparseable beta operation" };
                }
                if (totalUses === 0) continue;

                let understood = 0;
                const allocation = allocationFromOperation(position, overflowAnalysis);
                if (allocation?.cellName === registerName) understood += 1;

                const release = releaseCellFromOperation(position, overflowAnalysis);
                if (release?.cellName === registerName && cellIdByRegister.get(registerName) === cellId) {
                    understood += 1;
                    if (release.resultName === registerName) understood += 1;
                }

                const factory = factoryCallFromOperation(position.operation);
                if (factory) {
                    for (const capture of factory.captures) {
                        if (
                            storageReadKey(capture, position, overflowAnalysis) === registerName &&
                            resolveCellIndex(position.ownerEntry, capture, position) === cellId
                        ) understood += 1;
                    }
                }

                const statementParsed = parseStatement(position.operation?.emittedText);
                if (!statementParsed) {
                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " appears in an unparseable beta operation" };
                }
                walk(statementParsed.statement, node => {
                    if (!isUpvalueValuesIndex(node)) return;
                    if (
                        storageReadKey(node.index, position, overflowAnalysis) === registerName &&
                        resolveCellIndex(position.ownerEntry, node.index, position) === cellId
                    ) understood += 1;
                });

                const aliasCopy = storageCopyFromOperation(position, overflowAnalysis);
                if (aliasCopyOperations.has(position.operation) && aliasCopy) {
                    if (aliasCopy.sourceName === registerName) understood += 1;
                    if (aliasCopy.targetName === registerName) understood += 1;
                }

                if (understood < totalUses) {
                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " escapes recognized upvalue machinery in state " + position.stateId + " op " + (position.operationIndex + 1) + " (" + understood + "/" + totalUses + "): " + String(position.operation?.emittedText || "") };
                }
            }
        }
    }

    const removals = new Set();
    const replacements = new Map();
    for (const position of positions) {
        if (!aliasCopyOperations.has(position.operation)) continue;
        const copy = storageCopyFromOperation(position, overflowAnalysis);
        const cellId = copy ? cellIdByRegister.get(copy.sourceName) : null;
        if (cellId && capturedCellIds.has(cellId)) removals.add(position.operation);
    }
    let readRewriteCount = 0;
    let writeRewriteCount = 0;
    let releaseRemovalCount = 0;
    let factoryRewriteCount = 0;

    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        if (cell.bindingMode === "hoisted-cell-binding") {
            replacements.set(cell.allocation.operation, {
                ...cell.allocation.operation,
                kind: "upvalue-binding-declaration",
                originalTarget: cell.registerName,
                emittedTarget: cell.bindingName,
                rhs: null,
                reads: [],
                emittedText: `local ${cell.bindingName}`,
                returnSinkSafe: false,
            });
        } else {
            removals.add(cell.allocation.operation);
        }

        if (cell.bindingMode === "existing-beta-binding") {
            removals.add(cell.initialization.operation);
        } else {
            const initRhsText = cell.initialization.parsed.source.slice(cell.initialization.value.range[0], cell.initialization.value.range[1]);
            const rewritten = rewriteExpressionUpvalues(initRhsText, cell.initialization, resolveCellIndex, bindingByCell);
            if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
            const hoisted = cell.bindingMode === "hoisted-cell-binding";
            replacements.set(cell.initialization.operation, {
                ...cell.initialization.operation,
                kind: hoisted ? "upvalue-binding-init" : "upvalue-binding-start",
                originalTarget: cell.registerName,
                emittedTarget: cell.bindingName,
                rhs: rewritten.text,
                reads: [...new Set([...(cell.initialization.operation.reads || []).filter(name => !localCellNames.has(name)), ...rewritten.bindingReads])],
                emittedText: `${hoisted ? "" : "local "}${cell.bindingName} = ${rewritten.text}`,
                returnSinkSafe: false,
            });
        }
    }

    for (const site of factorySites) {
        if (!entrySet.has(site.entry) || site.captures.length === 0) continue;
        const source = site.parsed.source;
        const captureArg = site.call.arguments[1];
        const rewrittenSource = applyTextEdits(source, [{ start: captureArg.range[0], end: captureArg.range[1], replacement: "{}" }]);
        const rhs = rewrittenSource.slice(site.parsed.prefix.length);
        const originalText = String(site.operation.emittedText || "").trimStart();
        const localPrefix = originalText.startsWith("local ") ? "local " : "";
        replacements.set(site.operation, {
            ...site.operation,
            rhs,
            emittedText: site.operation.emittedTarget
                ? `${localPrefix}${site.operation.emittedTarget} = ${rhs}`
                : site.operation.emittedText,
            reads: (site.operation.reads || []).filter(name => !localCellNames.has(name)),
            returnSinkSafe: false,
        });
        factoryRewriteCount++;
    }

    for (const position of positions) {
        const operation = position.operation;
        if (removals.has(operation) || replacements.has(operation)) continue;

        const release = releaseCellFromOperation(position, overflowAnalysis);
        const releaseCellId = release ? cellIdByRegister.get(release.cellName) : null;
        if (releaseCellId && capturedCellIds.has(releaseCellId)) {
            if (release.resultName && release.resultName !== release.cellName) {
                const resultIsRead = positions.some(item =>
                    item.operation !== operation && (item.operation?.reads || []).includes(release.resultName)
                );
                if (resultIsRead) {
                    return { applied: false, safe: false, reason: "releaseUpvalue result " + release.resultName + " is still live after captured-cell recovery" };
                }
            }
            removals.add(operation);
            releaseRemovalCount++;
            continue;
        }

        const write = indexedWriteFromOperation(operation);
        if (write) {
            const cellId = resolveCellIndex(position.ownerEntry, write.target.index, position);
            if (cellId && capturedCellIds.has(cellId)) {
                const bindingName = bindingByCell.get(cellId);
                const rhsText = write.parsed.source.slice(write.value.range[0], write.value.range[1]);
                const rewritten = rewriteExpressionUpvalues(rhsText, position, resolveCellIndex, bindingByCell);
                if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
                const isCompound = Boolean(write.compoundOperator);
                replacements.set(operation, {
                    ...operation,
                    kind: "upvalue-write",
                    originalTarget: bindingName,
                    emittedTarget: bindingName,
                    rhs: rewritten.text,
                    compoundOperator: write.compoundOperator,
                    reads: [...new Set([...(operation.reads || []).filter(name => !localCellNames.has(name)), ...(isCompound ? [bindingName] : []), ...rewritten.bindingReads])],
                    emittedText: isCompound
                        ? `${bindingName} ${write.compoundOperator}= ${rewritten.text}`
                        : `${bindingName} = ${rewritten.text}`,
                    returnSinkSafe: false,
                });
                writeRewriteCount++;
                continue;
            }
        }

        if (operation.kind === "effect-write" && String(operation.emittedText || "").includes("upvalueValues")) {
            const rewritten = rewriteStatementUpvalueReads(operation.emittedText, position, resolveCellIndex, bindingByCell);
            if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
            if (rewritten.text !== operation.emittedText) {
                replacements.set(operation, {
                    ...operation,
                    reads: [...new Set([...(operation.reads || []).filter(name => !localCellNames.has(name)), ...rewritten.bindingReads])],
                    emittedText: rewritten.text,
                    returnSinkSafe: false,
                });
                readRewriteCount++;
                continue;
            }
        }
        if (operation.rhs && String(operation.rhs).includes("upvalueValues")) {
            const rewritten = rewriteExpressionUpvalues(operation.rhs, position, resolveCellIndex, bindingByCell);
            if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
            if (rewritten.text !== operation.rhs) {
                const originalText = String(operation.emittedText || "").trimStart();
                const localPrefix = originalText.startsWith("local ") ? "local " : "";
                replacements.set(operation, {
                    ...operation,
                    rhs: rewritten.text,
                    reads: [...new Set([...(operation.reads || []).filter(name => !localCellNames.has(name)), ...rewritten.bindingReads])],
                    emittedText: operation.emittedTarget
                        ? `${localPrefix}${operation.emittedTarget} = ${rewritten.text}`
                        : operation.emittedText,
                    returnSinkSafe: false,
                });
                readRewriteCount++;
            }
        }
    }

    for (const state of graph.states) {
        const next = [];
        for (const operation of state.operations || []) {
            if (removals.has(operation)) continue;
            next.push(replacements.get(operation) || operation);
        }
        state.operations = next;
        for (let index = 0; index < next.length; index++) next[index].index = index + 1;
    }

    // No recovered closure region may retain VM upvalue table accesses after the
    // transform. If it does, the cell graph was incomplete and we fail closed.
    for (const state of graph.states) {
        for (const operation of state.operations || []) {
            const text = String(operation.emittedText || "");
            if (containsVmUpvalueMachinery(text)) {
                return { applied: false, safe: false, reason: `State ${state.id} retains unresolved VM upvalue machinery after recovery: ${text}` };
            }
        }
    }

    graph.recoveredUpvalueBindings = [...new Set([...capturedCellIds].map(cellId => cells.get(cellId)?.bindingName).filter(Boolean))];

    return {
        applied: true,
        safe: true,
        graph,
        stats: {
            cellCount: cells.size,
            recoveredCellCount: capturedCellIds.size,
            captureCount,
            readRewriteCount,
            writeRewriteCount,
            releaseRemovalCount,
            factoryRewriteCount,
        },
        cells: [...capturedCellIds].map(cellId => {
            const cell = cells.get(cellId);
            return {
                id: cell.id,
                ownerEntry: cell.ownerEntry,
                bindingName: cell.bindingName,
                bindingMode: cell.bindingMode,
            };
        }),
    };
}

module.exports = {
    recoverBetaUpvalues,
};
