
const { findVmFunction } = require("./vm-state");
const { findVmReturnRegister } = require("./vm-register-names");

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

function successorsOf(term) {
    if (term?.kind === "jump") return [term.target];
    if (term?.kind === "branch") return [term.onTrue, term.onFalse];
    return [];
}

function setEquals(a, b) {
    if (a.size !== b.size) return false;
    for (const value of a) if (!b.has(value)) return false;
    return true;
}

class UnionFind {
    constructor(ids) {
        this.parent = new Map();
        for (const id of ids) this.parent.set(id, id);
    }

    find(id) {
        let root = id;
        while (this.parent.get(root) !== root) root = this.parent.get(root);
        while (this.parent.get(id) !== id) {
            const next = this.parent.get(id);
            this.parent.set(id, root);
            id = next;
        }
        return root;
    }

    union(left, right) {
        const a = this.find(left);
        const b = this.find(right);
        if (a === b) return false;
        this.parent.set(b, a);
        return true;
    }
}

function mapOfSetsClone(source) {
    const out = new Map();
    for (const [name, defs] of source) out.set(name, new Set(defs));
    return out;
}

function mapOfSetsEquals(a, b) {
    if (a.size !== b.size) return false;
    for (const [name, defs] of a) {
        const other = b.get(name);
        if (!other || !setEquals(defs, other)) return false;
    }
    return true;
}

function mergeReachingMaps(maps) {
    const out = new Map();
    for (const map of maps) {
        for (const [name, defs] of map) {
            if (!out.has(name)) out.set(name, new Set());
            const target = out.get(name);
            for (const def of defs) target.add(def);
        }
    }
    return out;
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

function isClosureFactoryCall(node) {
    return node?.type === "CallExpression" &&
        isIdentifier(node.base) &&
        /^createClosure(?:\d+)?$/.test(node.base.name);
}

function isEnvironmentReferenceExpression(node) {
    if (isIdentifier(node, "_env")) return true;
    if (node?.type !== "IndexExpression" && node?.type !== "MemberExpression") return false;
    return isEnvironmentReferenceExpression(node.base);
}

function initialDefinitionValueProvenance(definition) {
    if (!definition.exactRhs || !definition.rhs) {
        return { kind: "unknown", reason: "inexact-rhs", sourceDefinitionIds: [] };
    }
    if (isEnvironmentReferenceExpression(definition.rhs)) {
        return { kind: "environment-reference", reason: "direct-environment-reference", sourceDefinitionIds: [] };
    }
    if (!isIdentifier(definition.rhs)) {
        return { kind: "register-value", reason: "computed-or-literal", sourceDefinitionIds: [] };
    }
    const sourceDefinitionIds = [...(definition.rhsReachingDefIds || [])];
    if (!sourceDefinitionIds.length) {
        return {
            kind: "external-reference",
            reason: "identifier-outside-vm-register-flow",
            sourceDefinitionIds,
            sourceName: definition.rhs.name,
        };
    }
    return {
        kind: "unknown",
        reason: "pending-register-copy",
        sourceDefinitionIds,
        sourceName: definition.rhs.name,
    };
}

function annotateDefinitionValueProvenance(definitions, definitionsById, uses) {
    for (const definition of definitions) {
        definition.valueProvenance = initialDefinitionValueProvenance(definition);
    }

    let changed = true;
    let iterations = 0;
    const iterationLimit = Math.max(1, definitions.length + 1);
    while (changed && iterations < iterationLimit) {
        changed = false;
        iterations++;
        for (const definition of definitions) {
            const current = definition.valueProvenance;
            if (current.reason !== "pending-register-copy") continue;
            const sourceKinds = current.sourceDefinitionIds
                .map(id => definitionsById.get(id)?.valueProvenance?.kind || "unknown");
            if (!sourceKinds.length || sourceKinds.includes("unknown")) continue;
            const firstKind = sourceKinds[0];
            const sameKind = sourceKinds.every(kind => kind === firstKind);
            const next = sameKind
                ? { ...current, kind: firstKind, reason: "register-copy" }
                : { ...current, kind: "unknown", reason: "mixed-register-copy" };
            if (next.kind !== current.kind || next.reason !== current.reason) {
                definition.valueProvenance = next;
                changed = true;
            }
        }
    }

    for (const definition of definitions) {
        if (definition.valueProvenance?.reason === "pending-register-copy") {
            definition.valueProvenance = {
                ...definition.valueProvenance,
                reason: "unresolved-register-copy",
            };
        }
    }

    for (const use of uses) {
        const kinds = use.reachingDefIds
            .map(id => definitionsById.get(id)?.valueProvenance?.kind || "unknown");
        let kind = "unknown";
        if (kinds.length && !kinds.includes("unknown") && kinds.every(item => item === kinds[0])) {
            kind = kinds[0];
        }
        use.valueProvenance = {
            kind,
            sourceDefinitionIds: [...use.reachingDefIds],
        };
    }

    return { converged: !changed, iterations };
}

function walkExpression(node, visit) {
    if (!isNode(node)) return;
    if (node.type === "FunctionDeclaration") return;
    visit(node);
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) walkExpression(child, visit);
        } else if (isNode(value)) {
            walkExpression(value, visit);
        }
    }
}

function assignmentDefinitions(statement) {
    if (statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") return [];
    const variables = statement.variables || [];
    const init = statement.init || [];
    const exactPositional = variables.length === init.length;
    const out = [];
    for (let i = 0; i < variables.length; i++) {
        if (!isIdentifier(variables[i])) continue;
        out.push({
            name: variables[i].name,
            variableIndex: i,
            rhs: exactPositional ? init[i] || null : null,
            exactRhs: exactPositional,
        });
    }
    return out;
}

function statementReadIdentifiers(statement) {
    const reads = [];

    function collect(node) {
        walkExpression(node, current => {
            if (current.type === "Identifier") reads.push(current);
        });
    }

    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (!isIdentifier(variable)) collect(variable);
        }
        for (const init of statement.init || []) collect(init);
        return reads;
    }

    collect(statement);
    return reads;
}

function closureCallsInStatement(statement) {
    const calls = [];

    function collect(node) {
        walkExpression(node, current => {
            if (isClosureFactoryCall(current)) calls.push(current);
        });
    }

    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (!isIdentifier(variable)) collect(variable);
        }
        for (const init of statement.init || []) collect(init);
    } else {
        collect(statement);
    }

    return calls;
}

function uniqueReachingDef(reaching, name) {
    const defs = reaching.get(name);
    if (!defs || defs.size !== 1) return null;
    return [...defs][0];
}

function upvalueSlotFromExpression(node) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalues")) return null;
    const slot = numericValue(node.index);
    return Number.isInteger(slot) && slot >= 1 ? slot : null;
}

function classifyCaptureExpression(node, reaching, definitionsById) {
    if (isIdentifier(node)) {
        const defId = uniqueReachingDef(reaching, node.name);
        if (!defId) {
            return {
                kind: "identifier-unproven",
                registerName: node.name,
                reachingDefIds: [...(reaching.get(node.name) || [])],
            };
        }
        const def = definitionsById.get(defId);
        if (def?.kind === "alloc-upvalue") {
            return {
                kind: "local-cell",
                cellId: def.id,
                definitionId: def.id,
                registerName: node.name,
            };
        }
        return {
            kind: "identifier-definition",
            registerName: node.name,
            definitionId: defId,
        };
    }

    const parentSlot = upvalueSlotFromExpression(node);
    if (parentSlot !== null) {
        return {
            kind: "parent-capture-slot",
            parentSlot,
        };
    }

    if (node?.type === "CallExpression" && isIdentifier(node.base, "allocUpvalue")) {
        return {
            kind: "direct-local-cell-allocation",
            range: Array.isArray(node.range) ? [...node.range] : null,
        };
    }

    return {
        kind: "unproven",
        expressionType: node?.type || null,
    };
}

function isUpvalueValuesIndex(node) {
    return node?.type === "IndexExpression" && isIdentifier(node.base, "upvalueValues");
}

function classifyCellIndex(node, reaching, definitionsById) {
    if (isIdentifier(node)) {
        const defId = uniqueReachingDef(reaching, node.name);
        if (!defId) {
            return {
                kind: "identifier-unproven",
                registerName: node.name,
                reachingDefIds: [...(reaching.get(node.name) || [])],
            };
        }
        const def = definitionsById.get(defId);
        if (def?.kind === "alloc-upvalue") {
            return {
                kind: "local-cell",
                cellId: def.id,
                definitionId: def.id,
                registerName: node.name,
            };
        }
        return {
            kind: "identifier-definition",
            registerName: node.name,
            definitionId: defId,
        };
    }

    const captureSlot = upvalueSlotFromExpression(node);
    if (captureSlot !== null) {
        return {
            kind: "capture-slot",
            captureSlot,
        };
    }

    return {
        kind: "unproven",
        expressionType: node?.type || null,
    };
}

function collectUpvalueValueReads(node, out) {
    if (!isNode(node) || node.type === "FunctionDeclaration") return;
    if (isUpvalueValuesIndex(node)) {
        out.push({ mode: "read", node });
        collectUpvalueValueReads(node.index, out);
        return;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectUpvalueValueReads(child, out);
        } else if (isNode(value)) {
            collectUpvalueValueReads(value, out);
        }
    }
}

function upvalueValueAccessesInStatement(statement) {
    const accesses = [];
    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (isUpvalueValuesIndex(variable)) {
                accesses.push({ mode: "write", node: variable });
                collectUpvalueValueReads(variable.index, accesses);
            } else if (!isIdentifier(variable)) {
                collectUpvalueValueReads(variable, accesses);
            }
        }
        for (const init of statement.init || []) collectUpvalueValueReads(init, accesses);
        return accesses;
    }
    collectUpvalueValueReads(statement, accesses);
    return accesses;
}

function buildCaptureSlotResolver(captures) {
    const origins = new Map();
    const resolvedMemo = new Map();
    for (const capture of captures) {
        const key = `${capture.childFunctionId}:${capture.childSlot}`;
        if (!origins.has(key)) origins.set(key, []);
        origins.get(key).push(capture);
    }

    function resolve(functionId, slot, seen = new Set()) {
        const key = `${functionId}:${slot}`;
        if (seen.has(key)) return { kind: "cycle", cellIds: [] };
        const entries = origins.get(key) || [];
        if (!entries.length) return { kind: "unresolved", cellIds: [] };

        const nextSeen = new Set(seen);
        nextSeen.add(key);
        const cellIds = new Set();
        let incomplete = false;

        for (const entry of entries) {
            if (entry.kind === "local-cell") {
                cellIds.add(entry.cellId);
                continue;
            }
            if (entry.kind === "parent-capture-slot") {
                const parent = resolve(entry.parentFunctionId, entry.parentSlot, nextSeen);
                if (parent.kind !== "resolved-cell") incomplete = true;
                for (const cellId of parent.cellIds || []) cellIds.add(cellId);
                continue;
            }
            incomplete = true;
        }

        if (!incomplete && cellIds.size === 1) {
            return { kind: "resolved-cell", cellId: [...cellIds][0], cellIds: [...cellIds] };
        }
        return {
            kind: incomplete ? "unresolved" : "ambiguous",
            cellIds: [...cellIds],
        };
    }

    const resolveUncached = resolve;
    function resolveMemoized(functionId, slot) {
        const key = `${functionId}:${slot}`;
        if (resolvedMemo.has(key)) return resolvedMemo.get(key);
        const result = resolveUncached(functionId, slot, new Set());
        resolvedMemo.set(key, result);
        return result;
    }

    return { origins, resolve: resolveMemoized };
}

function unionSets(sets) {
    const out = new Set();
    for (const set of sets) for (const value of set) out.add(value);
    return out;
}

function reachingIdsAtEntry(reachingMap) {
    const out = new Set();
    for (const defs of reachingMap.values()) for (const def of defs) out.add(def);
    return out;
}

function buildDefinitionLiveness(blockIds, blockSet, root, definitionsById, uses, inByBlock) {
    const entryUsesByBlock = new Map(blockIds.map(id => [id, new Set()]));
    const entryReachByBlock = new Map(blockIds.map(id => [id, reachingIdsAtEntry(inByBlock.get(id) || new Map())]));

    for (const use of uses) {
        for (const defId of use.reachingDefIds) {
            const def = definitionsById.get(defId);
            if (!def) continue;
            if (def.blockId !== use.blockId || def.statementIndex >= use.statementIndex) {
                entryUsesByBlock.get(use.blockId)?.add(defId);
            }
        }
    }

    const liveInByBlock = new Map(blockIds.map(id => [id, new Set()]));
    const liveOutByBlock = new Map(blockIds.map(id => [id, new Set()]));
    let changed = true;
    let iterations = 0;
    const iterationLimit = Math.max(1, blockIds.length * 16);

    while (changed && iterations < iterationLimit) {
        changed = false;
        iterations++;
        for (let index = blockIds.length - 1; index >= 0; index--) {
            const blockId = blockIds[index];
            const block = root.graph.blocks.get(blockId);
            const successorIns = successorsOf(block?.terminator)
                .filter(id => blockSet.has(id))
                .map(id => liveInByBlock.get(id));
            const nextOut = unionSets(successorIns);
            const nextIn = new Set(entryUsesByBlock.get(blockId));
            const entryReach = entryReachByBlock.get(blockId);
            for (const defId of nextOut) if (entryReach.has(defId)) nextIn.add(defId);

            if (!setEquals(liveOutByBlock.get(blockId), nextOut)) {
                liveOutByBlock.set(blockId, nextOut);
                changed = true;
            }
            if (!setEquals(liveInByBlock.get(blockId), nextIn)) {
                liveInByBlock.set(blockId, nextIn);
                changed = true;
            }
        }
    }

    const usesByDefinition = new Map([...definitionsById.keys()].map(id => [id, []]));
    for (const use of uses) {
        for (const defId of use.reachingDefIds) usesByDefinition.get(defId)?.push(use);
    }

    const liveInBlocksByDefinition = new Map();
    const liveOutBlocksByDefinition = new Map();
    function appendLiveBlock(target, definitionId, blockId) {
        if (!target.has(definitionId)) target.set(definitionId, []);
        target.get(definitionId).push(blockId);
    }
    for (const blockId of blockIds) {
        for (const definitionId of liveInByBlock.get(blockId)) {
            appendLiveBlock(liveInBlocksByDefinition, definitionId, blockId);
        }
        for (const definitionId of liveOutByBlock.get(blockId)) {
            appendLiveBlock(liveOutBlocksByDefinition, definitionId, blockId);
        }
    }

    const lifetimes = [];
    for (const def of definitionsById.values()) {
        const defUses = usesByDefinition.get(def.id) || [];
        const liveInBlockIds = liveInBlocksByDefinition.get(def.id) || [];
        const liveOutBlockIds = liveOutBlocksByDefinition.get(def.id) || [];
        const useBlockIdSet = new Set();
        let uniqueUseCount = 0;
        let ambiguousUseCount = 0;
        for (const use of defUses) {
            useBlockIdSet.add(use.blockId);
            if (use.uniqueDefinitionId === def.id) uniqueUseCount++;
            else ambiguousUseCount++;
        }
        const useBlockIds = [...useBlockIdSet];
        lifetimes.push({
            definitionId: def.id,
            functionId: def.functionId,
            registerName: def.name,
            definitionBlockId: def.blockId,
            definitionStatementIndex: def.statementIndex,
            useCount: defUses.length,
            uniqueUseCount,
            ambiguousUseCount,
            useBlockIds,
            liveInBlockIds,
            liveOutBlockIds,
            crossBlock: useBlockIds.some(id => id !== def.blockId) || liveOutBlockIds.some(id => id !== def.blockId),
            loopCarried: liveInByBlock.get(def.blockId).has(def.id),
        });
    }

    const parent = new Map(definitionsById.keys().map(id => [id, id]));
    function find(id) {
        let rootId = id;
        while (parent.get(rootId) !== rootId) rootId = parent.get(rootId);
        while (parent.get(id) !== id) {
            const next = parent.get(id);
            parent.set(id, rootId);
            id = next;
        }
        return rootId;
    }
    function unite(a, b) {
        const ra = find(a);
        const rb = find(b);
        if (ra !== rb) parent.set(rb, ra);
    }
    for (const use of uses) {
        if (use.reachingDefIds.length < 2) continue;
        const [first, ...rest] = use.reachingDefIds;
        for (const other of rest) unite(first, other);
    }
    const groupsByRoot = new Map();
    for (const defId of definitionsById.keys()) {
        const rootId = find(defId);
        if (!groupsByRoot.has(rootId)) groupsByRoot.set(rootId, []);
        groupsByRoot.get(rootId).push(defId);
    }
    const joinGroups = [...groupsByRoot.values()]
        .filter(ids => ids.length > 1)
        .map((definitionIds, index) => ({
            id: `f${definitionIds.length ? definitionsById.get(definitionIds[0]).functionId : "?"}:join${index}`,
            registerName: definitionsById.get(definitionIds[0])?.name || null,
            definitionIds,
        }));

    return {
        converged: !changed,
        iterations,
        liveInByBlock,
        liveOutByBlock,
        lifetimes,
        joinGroups,
    };
}

function buildOrdinaryRegisterEpochs(functionAnalysis, excludedNames = new Set()) {
    const definitions = functionAnalysis.definitions;
    const definitionsById = functionAnalysis.definitionsById;
    const eligibleDefinitions = definitions.filter(definition =>
        definition.exactRhs &&
        definition.rhs?.type !== "NilLiteral" &&
        definition.kind !== "alloc-upvalue" &&
        definition.valueProvenance?.kind === "register-value" &&
        !excludedNames.has(definition.name)
    );
    const eligibleIds = new Set(eligibleDefinitions.map(definition => definition.id));
    const unionFind = new UnionFind(eligibleIds);
    let joinMergeCount = 0;
    let mutationMergeCount = 0;

    // A read that can observe several concrete definitions of the same physical
    // register proves those definitions belong to one live value/storage epoch.
    // Environment/external/unknown values are intentionally ineligible here.
    for (const use of functionAnalysis.uses) {
        if (excludedNames.has(use.name) || use.reachingDefIds.length < 2) continue;
        const ids = use.reachingDefIds;
        if (!ids.every(id => eligibleIds.has(id) && definitionsById.get(id)?.name === use.name)) continue;
        for (let index = 1; index < ids.length; index++) {
            if (unionFind.union(ids[0], ids[index])) joinMergeCount++;
        }
    }

    // Mutation evidence is stronger than register-name reuse: the new definition
    // must data-depend (possibly through compiler temporaries) on an earlier
    // definition of the same register that is still reaching immediately before
    // the write. A cleanup/reuse handoff therefore blocks the merge naturally.
    for (const definition of eligibleDefinitions) {
        const queue = [...(definition.rhsReachingDefIds || [])];
        const seen = new Set();
        let cursor = 0;
        while (cursor < queue.length) {
            const id = queue[cursor++];
            if (seen.has(id)) continue;
            seen.add(id);
            const dependency = definitionsById.get(id);
            if (!dependency) continue;
            for (const parentId of dependency.rhsReachingDefIds || []) {
                if (!seen.has(parentId)) queue.push(parentId);
            }
        }

        const previousIds = (definition.previousReachingDefIds || []).filter(id =>
            eligibleIds.has(id) && definitionsById.get(id)?.name === definition.name
        );
        for (const previousId of previousIds) {
            if (!seen.has(previousId)) continue;
            if (unionFind.union(definition.id, previousId)) mutationMergeCount++;
        }
    }

    const stateOrder = new Map(functionAnalysis.stateIds.map((id, index) => [id, index]));
    const components = new Map();
    for (const definition of eligibleDefinitions) {
        const root = unionFind.find(definition.id);
        if (!components.has(root)) components.set(root, []);
        components.get(root).push(definition);
    }

    const byRegister = new Map();
    for (const items of components.values()) {
        const name = items[0].name;
        const first = items.reduce((best, item) => {
            const key = [stateOrder.get(item.blockId) ?? Number.MAX_SAFE_INTEGER, item.statementIndex, item.variableIndex];
            if (!best) return key;
            for (let i = 0; i < key.length; i++) {
                if (key[i] < best[i]) return key;
                if (key[i] > best[i]) return best;
            }
            return best;
        }, null);
        if (!byRegister.has(name)) byRegister.set(name, []);
        byRegister.get(name).push({ items, first });
    }

    const epochByDefinitionId = new Map();
    const epochs = [];
    for (const [name, groups] of byRegister) {
        groups.sort((left, right) => {
            for (let i = 0; i < left.first.length; i++) {
                if (left.first[i] !== right.first[i]) return left.first[i] - right.first[i];
            }
            return 0;
        });
        for (let index = 0; index < groups.length; index++) {
            const items = groups[index].items;
            const definitionIds = items.map(item => item.id);
            const lifetimeItems = definitionIds
                .map(id => functionAnalysis.definitionLifetimes.find(item => item.definitionId === id))
                .filter(Boolean);
            const epoch = {
                id: `f${functionAnalysis.id}:${name}:epoch${index + 1}`,
                functionId: functionAnalysis.id,
                registerName: name,
                ordinal: index + 1,
                definitionIds,
                blockIds: [...new Set(items.map(item => item.blockId))],
                crossBlock: lifetimeItems.some(item => item.crossBlock),
                loopCarried: lifetimeItems.some(item => item.loopCarried),
                cleanupDefinitionIds: [],
                ownershipHandoffAfter: false,
                sourceBindingProven: false,
            };
            epochs.push(epoch);
            for (const id of definitionIds) epochByDefinitionId.set(id, epoch);
        }
    }

    for (const cleanup of functionAnalysis.bindingEndCandidates || []) {
        const epoch = epochByDefinitionId.get(cleanup.previousDefinitionId);
        if (!epoch) continue;
        epoch.cleanupDefinitionIds.push(cleanup.definitionId);
        if (cleanup.registerReusedInBlock) epoch.ownershipHandoffAfter = true;
    }

    return {
        epochs,
        epochByDefinitionId,
        eligibleDefinitionCount: eligibleDefinitions.length,
        joinMergeCount,
        mutationMergeCount,
        mergedDefinitionCount: epochs.reduce((sum, epoch) => sum + Math.max(0, epoch.definitionIds.length - 1), 0),
    };
}

function buildFunctionAnalysis(root, functionId, excludedEpochNames = new Set()) {
    const blockIds = root.graph.order.filter(id => root.graph.blocks.has(id));
    const blockSet = new Set(blockIds);
    const predecessors = new Map(blockIds.map(id => [id, new Set()]));

    for (const id of blockIds) {
        const block = root.graph.blocks.get(id);
        for (const successor of successorsOf(block?.terminator)) {
            if (blockSet.has(successor)) predecessors.get(successor).add(id);
        }
    }

    const definitions = [];
    const definitionsByBlock = new Map(blockIds.map(id => [id, []]));
    const definitionsByName = new Map();

    for (const blockId of blockIds) {
        const block = root.graph.blocks.get(blockId);
        for (let statementIndex = 0; statementIndex < (block?.body?.length || 0); statementIndex++) {
            const statement = block.body[statementIndex];
            for (const item of assignmentDefinitions(statement)) {
                const id = `f${functionId}:b${blockId}:s${statementIndex}:v${item.variableIndex}`;
                const definition = {
                    id,
                    functionId,
                    blockId,
                    statementIndex,
                    variableIndex: item.variableIndex,
                    name: item.name,
                    rhs: item.rhs,
                    exactRhs: item.exactRhs,
                    statement,
                    previousReachingDefIds: [],
                    rhsReachingDefIds: [],
                    kind: item.exactRhs &&
                        item.rhs?.type === "CallExpression" &&
                        isIdentifier(item.rhs.base, "allocUpvalue") &&
                        (item.rhs.arguments || []).length === 0
                        ? "alloc-upvalue"
                        : "assignment",
                };
                definitions.push(definition);
                definitionsByBlock.get(blockId).push(definition);
                if (!definitionsByName.has(definition.name)) definitionsByName.set(definition.name, new Set());
                definitionsByName.get(definition.name).add(definition.id);
            }
        }
    }

    const definitionsById = new Map(definitions.map(def => [def.id, def]));

    function transfer(input, blockId) {
        const out = mapOfSetsClone(input);
        for (const def of definitionsByBlock.get(blockId) || []) {
            out.set(def.name, new Set([def.id]));
        }
        return out;
    }

    const inByBlock = new Map(blockIds.map(id => [id, new Map()]));
    const outByBlock = new Map(blockIds.map(id => [id, new Map()]));
    let changed = true;
    let iterations = 0;
    const iterationLimit = Math.max(1, blockIds.length * 16);

    while (changed && iterations < iterationLimit) {
        changed = false;
        iterations++;
        for (const blockId of blockIds) {
            const predMaps = [...predecessors.get(blockId)].map(id => outByBlock.get(id));
            const nextIn = predMaps.length ? mergeReachingMaps(predMaps) : new Map();
            const nextOut = transfer(nextIn, blockId);
            if (!mapOfSetsEquals(inByBlock.get(blockId), nextIn)) {
                inByBlock.set(blockId, nextIn);
                changed = true;
            }
            if (!mapOfSetsEquals(outByBlock.get(blockId), nextOut)) {
                outByBlock.set(blockId, nextOut);
                changed = true;
            }
        }
    }

    const converged = !changed;
    const uses = [];
    const closureSites = [];
    const cellAccesses = [];

    for (const blockId of blockIds) {
        const block = root.graph.blocks.get(blockId);
        let reaching = mapOfSetsClone(inByBlock.get(blockId));

        for (let statementIndex = 0; statementIndex < (block?.body?.length || 0); statementIndex++) {
            const statement = block.body[statementIndex];

            for (const identifier of statementReadIdentifiers(statement)) {
                if (!definitionsByName.has(identifier.name)) continue;
                const reachingDefIds = [...(reaching.get(identifier.name) || [])];
                uses.push({
                    functionId,
                    blockId,
                    statementIndex,
                    name: identifier.name,
                    range: Array.isArray(identifier.range) ? [...identifier.range] : null,
                    reachingDefIds,
                    uniqueDefinitionId: reachingDefIds.length === 1 ? reachingDefIds[0] : null,
                });
            }

            for (const access of upvalueValueAccessesInStatement(statement)) {
                cellAccesses.push({
                    functionId,
                    blockId,
                    statementIndex,
                    mode: access.mode,
                    range: Array.isArray(access.node.range) ? [...access.node.range] : null,
                    ...classifyCellIndex(access.node.index, reaching, definitionsById),
                });
            }

            for (const call of closureCallsInStatement(statement)) {
                const entryId = numericValue((call.arguments || [])[0]);
                const captureValues = tableValues((call.arguments || [])[1]);
                if (entryId === null || !captureValues) continue;
                closureSites.push({
                    functionId,
                    blockId,
                    statementIndex,
                    entryId,
                    factory: call.base.name,
                    range: Array.isArray(call.range) ? [...call.range] : null,
                    captures: captureValues.map((value, index) => ({
                        childSlot: index + 1,
                        ...classifyCaptureExpression(value, reaching, definitionsById),
                    })),
                });
            }

            for (const def of definitionsByBlock.get(blockId) || []) {
                if (def.statementIndex !== statementIndex) continue;
                def.previousReachingDefIds = [...(reaching.get(def.name) || [])];
                if (def.exactRhs && def.rhs) {
                    const rhsReachingDefIds = new Set();
                    walkExpression(def.rhs, current => {
                        if (!isIdentifier(current) || !definitionsByName.has(current.name)) return;
                        for (const id of reaching.get(current.name) || []) rhsReachingDefIds.add(id);
                    });
                    def.rhsReachingDefIds = [...rhsReachingDefIds];
                }
                reaching.set(def.name, new Set([def.id]));
            }
        }
    }

    const valueProvenance = annotateDefinitionValueProvenance(definitions, definitionsById, uses);

    const definitionLiveness = buildDefinitionLiveness(
        blockIds,
        blockSet,
        root,
        definitionsById,
        uses,
        inByBlock,
    );

    const lifetimeByDefinitionId = new Map(definitionLiveness.lifetimes.map(item => [item.definitionId, item]));
    const nextDefinitionById = new Map();
    for (const blockId of blockIds) {
        const nextByName = new Map();
        const blockDefinitions = definitionsByBlock.get(blockId) || [];
        for (let index = blockDefinitions.length - 1; index >= 0; index--) {
            const definition = blockDefinitions[index];
            nextDefinitionById.set(definition.id, nextByName.get(definition.name) || null);
            nextByName.set(definition.name, definition);
        }
    }
    const bindingEndCandidates = [];
    for (const def of definitions) {
        if (!def.exactRhs || def.rhs?.type !== "NilLiteral") continue;
        const lifetime = lifetimeByDefinitionId.get(def.id);
        if (!lifetime || lifetime.useCount !== 0) continue;
        if ((def.previousReachingDefIds || []).length !== 1) continue;
        const previousDefinitionId = def.previousReachingDefIds[0];
        const previousLifetime = lifetimeByDefinitionId.get(previousDefinitionId);
        if (!previousLifetime || previousLifetime.useCount === 0) continue;
        const nextDefinition = nextDefinitionById.get(def.id) || null;
        bindingEndCandidates.push({
            definitionId: def.id,
            functionId,
            registerName: def.name,
            blockId: def.blockId,
            statementIndex: def.statementIndex,
            previousDefinitionId,
            nextDefinitionId: nextDefinition?.id || null,
            registerReusedInBlock: Boolean(nextDefinition),
            kind: nextDefinition ? "ownership-handoff-candidate" : "binding-end-candidate",
        });
    }

    const ordinaryRegisterEpochs = buildOrdinaryRegisterEpochs({
        id: functionId,
        stateIds: blockIds,
        definitions,
        definitionsById,
        uses,
        definitionLifetimes: definitionLiveness.lifetimes,
        bindingEndCandidates,
    }, excludedEpochNames);

    return {
        id: functionId,
        kind: root.kind,
        factory: root.factory,
        entryId: root.entryId,
        parentId: null,
        parentAmbiguous: false,
        stateIds: [...blockIds],
        predecessors,
        definitions,
        definitionsById,
        uses,
        closureSites,
        cellAccesses,
        definitionLifetimes: definitionLiveness.lifetimes,
        definitionJoinGroups: definitionLiveness.joinGroups,
        bindingEndCandidates,
        ordinaryRegisterEpochs: ordinaryRegisterEpochs.epochs,
        ordinaryRegisterEpochStats: {
            eligibleDefinitionCount: ordinaryRegisterEpochs.eligibleDefinitionCount,
            joinMergeCount: ordinaryRegisterEpochs.joinMergeCount,
            mutationMergeCount: ordinaryRegisterEpochs.mutationMergeCount,
            mergedDefinitionCount: ordinaryRegisterEpochs.mergedDefinitionCount,
        },
        valueProvenance,
        liveness: {
            converged: definitionLiveness.converged,
            iterations: definitionLiveness.iterations,
            liveInByBlock: definitionLiveness.liveInByBlock,
            liveOutByBlock: definitionLiveness.liveOutByBlock,
        },
        reaching: {
            converged,
            iterations,
            inByBlock,
            outByBlock,
        },
    };
}

function recoverVmBindings(source, ast, vmState) {
    if (!vmState?.found || !vmState?.reachableClosed || !vmState?.normalized) {
        return {
            found: false,
            reason: "VM binding analysis requires a closed, normalized VM state graph",
            functions: [],
            definitions: [],
            uses: [],
            captures: [],
        };
    }

    const excludedEpochNames = new Set(["state", "args", "upvalues", "gcProxy"]);
    if (ast) {
        const vm = findVmFunction(ast);
        const returnRegister = vm ? findVmReturnRegister(vm.functionNode) : null;
        if (returnRegister?.name) excludedEpochNames.add(returnRegister.name);
    }
    const functions = vmState.graphRoots.map((root, index) => buildFunctionAnalysis(root, index, excludedEpochNames));
    const functionByEntry = new Map(functions.map(fn => [fn.entryId, fn]));
    const captures = [];

    for (const parent of functions) {
        for (const site of parent.closureSites) {
            const child = functionByEntry.get(site.entryId);
            if (!child || child.id === parent.id) continue;

            if (child.parentId === null) child.parentId = parent.id;
            else if (child.parentId !== parent.id) child.parentAmbiguous = true;

            for (const capture of site.captures) {
                captures.push({
                    parentFunctionId: parent.id,
                    childFunctionId: child.id,
                    childEntryId: child.entryId,
                    blockId: site.blockId,
                    statementIndex: site.statementIndex,
                    factory: site.factory,
                    ...capture,
                });
            }
        }
    }

    const captureSlotResolver = buildCaptureSlotResolver(captures);
    let unresolvedCaptureCount = 0;
    for (const capture of captures) {
        if (capture.kind === "local-cell") {
            capture.resolution = { kind: "resolved-cell", cellId: capture.cellId, cellIds: [capture.cellId] };
        } else if (capture.kind === "parent-capture-slot") {
            capture.resolution = captureSlotResolver.resolve(capture.parentFunctionId, capture.parentSlot);
        } else {
            capture.resolution = { kind: "unresolved", cellIds: [] };
        }
        capture.resolvedCellId = capture.resolution.kind === "resolved-cell" ? capture.resolution.cellId : null;
        if (capture.resolvedCellId === null) unresolvedCaptureCount++;
    }

    const cellAccesses = functions.flatMap(fn => fn.cellAccesses);
    for (const access of cellAccesses) {
        if (access.kind === "local-cell") {
            access.resolution = { kind: "resolved-cell", cellId: access.cellId, cellIds: [access.cellId] };
        } else if (access.kind === "capture-slot") {
            access.resolution = captureSlotResolver.resolve(access.functionId, access.captureSlot);
        } else {
            access.resolution = { kind: "unresolved", cellIds: [] };
        }
        access.resolvedCellId = access.resolution.kind === "resolved-cell" ? access.resolution.cellId : null;
    }

    const definitionLifetimes = functions.flatMap(fn => fn.definitionLifetimes);
    const ordinaryRegisterEpochs = functions.flatMap(fn => fn.ordinaryRegisterEpochs || []);
    const bindingEndCandidates = functions.flatMap(fn => fn.bindingEndCandidates || []);
    const definitionJoinGroups = functions.flatMap(fn => fn.definitionJoinGroups);
    const definitions = functions.flatMap(fn => fn.definitions);
    const uses = functions.flatMap(fn => fn.uses);
    const uniqueUseCount = uses.filter(use => use.uniqueDefinitionId !== null).length;
    const ambiguousUseCount = uses.filter(use => use.reachingDefIds.length > 1).length;
    const undefinedUseCount = uses.filter(use => use.reachingDefIds.length === 0).length;
    const localCells = definitions.filter(def => def.kind === "alloc-upvalue");
    const environmentReferenceDefinitions = definitions.filter(def => def.valueProvenance?.kind === "environment-reference");
    const registerValueDefinitions = definitions.filter(def => def.valueProvenance?.kind === "register-value");
    const externalReferenceDefinitions = definitions.filter(def => def.valueProvenance?.kind === "external-reference");
    const unknownValueDefinitions = definitions.filter(def => def.valueProvenance?.kind === "unknown");

    const resolvedCellAccessCount = cellAccesses.filter(access => access.resolvedCellId !== null).length;
    const unresolvedCellAccessCount = cellAccesses.length - resolvedCellAccessCount;

    const sharedLocalCells = [];
    const localCellConsumers = new Map();
    for (const capture of captures) {
        if (capture.resolvedCellId === null) continue;
        if (!localCellConsumers.has(capture.resolvedCellId)) localCellConsumers.set(capture.resolvedCellId, new Set());
        localCellConsumers.get(capture.resolvedCellId).add(capture.childFunctionId);
    }
    for (const [cellId, children] of localCellConsumers) {
        if (children.size < 2) continue;
        sharedLocalCells.push({
            cellId,
            childFunctionIds: [...children].sort((a, b) => a - b),
        });
    }

    const lifetimeByDefinitionId = new Map(definitionLifetimes.map(item => [item.definitionId, item]));
    const capturesByCell = new Map(localCells.map(cell => [cell.id, []]));
    const accessesByCell = new Map(localCells.map(cell => [cell.id, []]));
    for (const capture of captures) capturesByCell.get(capture.resolvedCellId)?.push(capture);
    for (const access of cellAccesses) accessesByCell.get(access.resolvedCellId)?.push(access);

    const cellGraphComplete = unresolvedCaptureCount === 0 && unresolvedCellAccessCount === 0;
    const capturedBindingCandidates = localCells.map(cell => {
        const cellCaptures = capturesByCell.get(cell.id) || [];
        const cellAccessesForCell = accessesByCell.get(cell.id) || [];
        const childFunctionIds = [...new Set(cellCaptures.map(capture => capture.childFunctionId))].sort((a, b) => a - b);
        const accessFunctionIds = [...new Set(cellAccessesForCell.map(access => access.functionId))].sort((a, b) => a - b);
        const lifetime = lifetimeByDefinitionId.get(cell.id) || null;
        return {
            id: `captured:${cell.id}`,
            kind: "captured-cell",
            ownerFunctionId: cell.functionId,
            allocationDefinitionId: cell.id,
            allocationRegisterName: cell.name,
            childFunctionIds,
            accessFunctionIds,
            captureCount: cellCaptures.length,
            readCount: cellAccessesForCell.filter(access => access.mode === "read").length,
            writeCount: cellAccessesForCell.filter(access => access.mode === "write").length,
            sharedAcrossFunctions: childFunctionIds.length > 1,
            allocationCrossBlock: lifetime?.crossBlock || false,
            allocationLoopCarried: lifetime?.loopCarried || false,
            provenanceComplete: cellGraphComplete,
        };
    });

    const allConverged = functions.every(fn => fn.reaching.converged && fn.liveness.converged);
    const crossBlockLifetimeCount = definitionLifetimes.filter(item => item.crossBlock).length;
    const loopCarriedLifetimeCount = definitionLifetimes.filter(item => item.loopCarried).length;

    return {
        found: true,
        source,
        functionCount: functions.length,
        functions,
        definitions,
        definitionLifetimes,
        ordinaryRegisterEpochs,
        ordinaryRegisterEpochStats: {
            eligibleDefinitionCount: functions.reduce((sum, fn) => sum + (fn.ordinaryRegisterEpochStats?.eligibleDefinitionCount || 0), 0),
            joinMergeCount: functions.reduce((sum, fn) => sum + (fn.ordinaryRegisterEpochStats?.joinMergeCount || 0), 0),
            mutationMergeCount: functions.reduce((sum, fn) => sum + (fn.ordinaryRegisterEpochStats?.mutationMergeCount || 0), 0),
            mergedDefinitionCount: functions.reduce((sum, fn) => sum + (fn.ordinaryRegisterEpochStats?.mergedDefinitionCount || 0), 0),
        },
        definitionJoinGroups,
        bindingEndCandidates,
        ownershipHandoffCandidates: bindingEndCandidates.filter(item => item.registerReusedInBlock),
        crossBlockLifetimeCount,
        loopCarriedLifetimeCount,
        uses,
        captures,
        unresolvedCaptureCount,
        captureSlotOrigins: captureSlotResolver.origins,
        cellAccesses,
        resolvedCellAccessCount,
        unresolvedCellAccessCount,
        localCells,
        environmentReferenceDefinitions,
        registerValueDefinitions,
        externalReferenceDefinitions,
        unknownValueDefinitions,
        valueProvenanceComplete: unknownValueDefinitions.length === 0 && functions.every(fn => fn.valueProvenance.converged),
        sharedLocalCells,
        capturedBindingCandidates,
        cellGraphComplete,
        uniqueUseCount,
        ambiguousUseCount,
        undefinedUseCount,
        allConverged,
    };
}

module.exports = {
    recoverVmBindings,
    classifyCaptureExpression,
};
