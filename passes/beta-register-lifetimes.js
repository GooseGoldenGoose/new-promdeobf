function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isNilLiteral(node) {
    return node?.type === "NilLiteral";
}

function setEquals(a, b) {
    if (a === b) return true;
    if (!a || !b || a.size !== b.size) return false;
    for (const value of a) if (!b.has(value)) return false;
    return true;
}

function mapOfSetsEquals(a, b) {
    if (a === b) return true;
    if (!a || !b || a.size !== b.size) return false;
    for (const [key, values] of a) {
        if (!setEquals(values, b.get(key))) return false;
    }
    return true;
}

function cloneSetMap(map) {
    const out = new Map();
    for (const [key, values] of map || []) out.set(key, new Set(values));
    return out;
}

function mergeSetMaps(maps) {
    const out = new Map();
    for (const map of maps) {
        for (const [key, values] of map || []) {
            let target = out.get(key);
            if (!target) out.set(key, target = new Set());
            for (const value of values) target.add(value);
        }
    }
    return out;
}

function collectReadNames(node, candidateNames, out = [], parent = null, parentKey = null) {
    if (!isNode(node) || node.type === "FunctionDeclaration") return out;
    if (node.type === "Identifier") {
        const isProperty =
            (parent?.type === "MemberExpression" && parentKey === "identifier") ||
            (parent?.type === "TableKeyString" && parentKey === "key");
        if (!isProperty && candidateNames.has(node.name)) out.push(node.name);
        return out;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectReadNames(child, candidateNames, out, node, key);
        } else if (isNode(value)) {
            collectReadNames(value, candidateNames, out, node, key);
        }
    }
    return out;
}

function statementReadNames(statement, candidateNames) {
    const reads = [];
    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (!isIdentifier(variable)) collectReadNames(variable, candidateNames, reads);
        }
        for (const init of statement.init || []) collectReadNames(init, candidateNames, reads);
        return reads;
    }
    collectReadNames(statement, candidateNames, reads);
    return reads;
}

function statementWrittenNames(statement, candidateNames) {
    if (statement?.type !== "AssignmentStatement" && statement?.type !== "LocalStatement") return [];
    const out = [];
    for (const variable of statement.variables || []) {
        if (isIdentifier(variable) && candidateNames.has(variable.name)) out.push(variable.name);
    }
    return out;
}

class UnionFind {
    constructor(items) {
        this.parent = new Map();
        this.rank = new Map();
        for (const item of items) {
            this.parent.set(item, item);
            this.rank.set(item, 0);
        }
    }

    find(item) {
        let parent = this.parent.get(item);
        if (parent === undefined) return null;
        if (parent !== item) {
            parent = this.find(parent);
            this.parent.set(item, parent);
        }
        return parent;
    }

    union(left, right) {
        let a = this.find(left);
        let b = this.find(right);
        if (a === null || b === null || a === b) return a;
        const rankA = this.rank.get(a) || 0;
        const rankB = this.rank.get(b) || 0;
        if (rankA < rankB) [a, b] = [b, a];
        this.parent.set(b, a);
        if (rankA === rankB) this.rank.set(a, rankA + 1);
        return a;
    }
}

function analyzeBetaRegisterLifetimes({
    blocks,
    candidateNames,
    stateName,
    returnName,
    closureEntries,
}) {
    const valueNames = new Set(candidateNames);
    const ordinaryNames = new Set([...candidateNames].filter(name => name !== stateName && name !== returnName));
    const blockByState = new Map(blocks.map(block => [block.stateId, block]));
    const predecessors = new Map(blocks.map(block => [block.stateId, []]));
    const cfgComplete = blocks.every(block =>
        Array.isArray(block.successors) && block.successors.every(target => blockByState.has(target))
    );
    if (cfgComplete) {
        for (const block of blocks) {
            for (const target of block.successors) predecessors.get(target).push(block);
        }
    }

    const definitions = [];
    const definitionById = new Map();
    const definitionByStatementAndName = new Map();
    const unknownDefinitionIds = new Set();
    let nextDefinitionId = 1;

    function definitionKey(statement, name) {
        return `${statement?.range?.[0] ?? "?"}\0${name}`;
    }

    // Build sparse value definitions for all scalar VM registers. state/ReturnVal take
    // part in provenance, but only ordinary registers are eligible for local epochs.
    for (const block of blocks) {
        for (let statementIndex = 0; statementIndex < block.statements.length; statementIndex++) {
            const statement = block.statements[statementIndex];
            const plan = block.plans.get(statement);
            const writes = statementWrittenNames(statement, valueNames);
            if (!writes.length) continue;

            for (const name of writes) {
                const variables = statement.variables || [];
                const init = statement.init || [];
                const exactSingle = variables.length === 1 && init.length === 1 && isIdentifier(variables[0], name);
                const supported = exactSingle && plan?.kind === "versioned";
                const id = supported
                    ? `d${nextDefinitionId++}`
                    : `u:${block.stateId}:${statement.range?.[0] ?? statementIndex}:${name}`;
                const definition = {
                    id,
                    name,
                    blockState: block.stateId,
                    statementIndex,
                    statement,
                    rhs: exactSingle ? init[0] : null,
                    supported,
                    isNil: supported && isNilLiteral(init[0]),
                    sourceOffset: statement.range?.[0] ?? Number.MAX_SAFE_INTEGER,
                    useCount: 0,
                };
                definitions.push(definition);
                definitionById.set(id, definition);
                definitionByStatementAndName.set(definitionKey(statement, name), definition);
                if (!supported) unknownDefinitionIds.add(id);
            }
        }
    }

    const inDefinitions = new Map(blocks.map(block => [block.stateId, new Map()]));
    const outDefinitions = new Map(blocks.map(block => [block.stateId, new Map()]));
    const entryUnknown = new Map();

    function entryUnknownId(stateId, name) {
        const key = `${stateId}\0${name}`;
        let id = entryUnknown.get(key);
        if (!id) {
            id = `u:entry:${stateId}:${name}`;
            entryUnknown.set(key, id);
            unknownDefinitionIds.add(id);
        }
        return id;
    }

    function transfer(block, incoming) {
        const current = cloneSetMap(incoming);
        for (const statement of block.statements) {
            for (const name of statementWrittenNames(statement, valueNames)) {
                const definition = definitionByStatementAndName.get(definitionKey(statement, name));
                if (definition) current.set(name, new Set([definition.id]));
            }
        }
        return current;
    }

    if (cfgComplete) {
        const queue = [...blocks];
        const queued = new Set(queue.map(block => block.stateId));
        let cursor = 0;
        while (cursor < queue.length) {
            const block = queue[cursor++];
            queued.delete(block.stateId);
            const predMaps = (predecessors.get(block.stateId) || []).map(pred => outDefinitions.get(pred.stateId));
            const nextIn = mergeSetMaps(predMaps);
            const isEntry = closureEntries.has(block.stateId) || predMaps.length === 0;
            if (isEntry) {
                for (const name of valueNames) {
                    let defs = nextIn.get(name);
                    if (!defs) nextIn.set(name, defs = new Set());
                    defs.add(entryUnknownId(block.stateId, name));
                }
            }
            const nextOut = transfer(block, nextIn);
            const inChanged = !mapOfSetsEquals(nextIn, inDefinitions.get(block.stateId));
            const outChanged = !mapOfSetsEquals(nextOut, outDefinitions.get(block.stateId));
            if (inChanged) inDefinitions.set(block.stateId, nextIn);
            if (outChanged) {
                outDefinitions.set(block.stateId, nextOut);
                for (const successor of block.successors) {
                    if (!queued.has(successor)) {
                        queued.add(successor);
                        queue.push(blockByState.get(successor));
                    }
                }
            }
        }
    } else {
        for (const block of blocks) {
            const incoming = new Map();
            for (const name of valueNames) incoming.set(name, new Set([entryUnknownId(block.stateId, name)]));
            inDefinitions.set(block.stateId, incoming);
            outDefinitions.set(block.stateId, transfer(block, incoming));
        }
    }

    const reachingBeforeStatement = new Map();
    const uses = [];
    for (const block of blocks) {
        const current = cloneSetMap(inDefinitions.get(block.stateId) || new Map());
        for (let statementIndex = 0; statementIndex < block.statements.length; statementIndex++) {
            const statement = block.statements[statementIndex];
            const before = cloneSetMap(current);
            reachingBeforeStatement.set(statement, before);
            for (const name of statementReadNames(statement, valueNames)) {
                const reaching = new Set(before.get(name) || []);
                const use = { blockState: block.stateId, statementIndex, statement, name, reachingDefinitionIds: reaching };
                uses.push(use);
                for (const defId of reaching) {
                    const definition = definitionById.get(defId);
                    if (definition) definition.useCount++;
                }
            }
            for (const name of statementWrittenNames(statement, valueNames)) {
                const definition = definitionByStatementAndName.get(definitionKey(statement, name));
                if (definition) current.set(name, new Set([definition.id]));
            }
        }
    }

    // Ordinary-register block liveness. This is intentionally independent from cleanup
    // syntax and is retained in the analysis result for later stronger ownership proofs.
    const blockUse = new Map();
    const blockDef = new Map();
    for (const block of blocks) {
        const usedBeforeDef = new Set();
        const defined = new Set();
        for (const statement of block.statements) {
            for (const name of statementReadNames(statement, ordinaryNames)) {
                if (!defined.has(name)) usedBeforeDef.add(name);
            }
            for (const name of statementWrittenNames(statement, ordinaryNames)) defined.add(name);
        }
        blockUse.set(block.stateId, usedBeforeDef);
        blockDef.set(block.stateId, defined);
    }

    const liveIn = new Map(blocks.map(block => [block.stateId, new Set()]));
    const liveOut = new Map(blocks.map(block => [block.stateId, new Set()]));
    let livenessChanged = true;
    let livenessRounds = 0;
    while (livenessChanged && livenessRounds++ < blocks.length * 4 + 8) {
        livenessChanged = false;
        for (let index = blocks.length - 1; index >= 0; index--) {
            const block = blocks[index];
            const nextOut = new Set();
            if (Array.isArray(block.successors)) {
                for (const target of block.successors) {
                    for (const name of liveIn.get(target) || []) nextOut.add(name);
                }
            }
            const nextIn = new Set(blockUse.get(block.stateId));
            for (const name of nextOut) {
                if (!blockDef.get(block.stateId).has(name)) nextIn.add(name);
            }
            if (!setEquals(nextOut, liveOut.get(block.stateId))) {
                liveOut.set(block.stateId, nextOut);
                livenessChanged = true;
            }
            if (!setEquals(nextIn, liveIn.get(block.stateId))) {
                liveIn.set(block.stateId, nextIn);
                livenessChanged = true;
            }
        }
    }

    // Cleanup is only accepted after def/use proof: direct nil, nil value never read,
    // all reaching prior values are known non-nil ordinary definitions, and at least
    // one prior value was actually used. Explicit source `x = nil` normally compiles
    // through a temporary then a copy into x, so the nil temporary itself has a use and
    // does not satisfy this rule.
    const cleanupCandidates = [];
    const cleanupByStatement = new Map();
    let nextCleanupId = 1;
    for (const definition of definitions) {
        if (!ordinaryNames.has(definition.name)) continue;
        if (!definition.supported || !definition.isNil || definition.useCount !== 0) continue;
        const priorIds = new Set(reachingBeforeStatement.get(definition.statement)?.get(definition.name) || []);
        if (!priorIds.size) continue;
        let blocked = false;
        const priorDefinitions = [];
        for (const id of priorIds) {
            if (unknownDefinitionIds.has(id)) {
                blocked = true;
                break;
            }
            const prior = definitionById.get(id);
            if (!prior || !ordinaryNames.has(prior.name) || !prior.supported || prior.isNil) {
                blocked = true;
                break;
            }
            priorDefinitions.push(prior);
        }
        if (blocked || !priorDefinitions.length) continue;
        if (!priorDefinitions.some(prior => prior.useCount > 0)) continue;

        const cleanup = {
            id: `k${nextCleanupId++}`,
            name: definition.name,
            blockState: definition.blockState,
            statementIndex: definition.statementIndex,
            statement: definition.statement,
            definitionId: definition.id,
            priorDefinitionIds: new Set(priorDefinitions.map(item => item.id)),
        };
        cleanupCandidates.push(cleanup);
        cleanupByStatement.set(definition.statement, cleanup);
    }

    // Build sparse value-provenance edges from reaching definitions. These edges can
    // cross state/ReturnVal temporaries, allowing chains like:
    //     oldR -> tmp = oldR + 1 -> R = tmp
    // to prove that the later R write is a mutation of the same logical value epoch.
    const dependenciesByDefinitionId = new Map();
    let provenanceEdgeCount = 0;
    for (const definition of definitions) {
        if (!definition.supported) continue;
        const deps = new Set();
        const before = reachingBeforeStatement.get(definition.statement) || new Map();
        for (const readName of statementReadNames(definition.statement, valueNames)) {
            const reaching = new Set(before.get(readName) || []);
            if (!reaching.size) continue;
            if ([...reaching].some(id => unknownDefinitionIds.has(id))) continue;
            let valid = true;
            const concrete = [];
            for (const id of reaching) {
                const sourceDefinition = definitionById.get(id);
                if (!sourceDefinition || !sourceDefinition.supported) {
                    valid = false;
                    break;
                }
                concrete.push(id);
            }
            if (!valid) continue;
            for (const id of concrete) {
                if (!deps.has(id)) provenanceEdgeCount++;
                deps.add(id);
            }
        }
        dependenciesByDefinitionId.set(definition.id, deps);
    }

    const ordinaryDefinitions = definitions.filter(definition =>
        ordinaryNames.has(definition.name) && definition.supported && !definition.isNil
    );
    const ordinaryDefinitionIds = new Set(ordinaryDefinitions.map(definition => definition.id));
    const unionFind = new UnionFind(ordinaryDefinitionIds);

    // Join evidence: one read can observe several concrete definitions of the same
    // physical ordinary register. Those definitions are one logical storage epoch at
    // that use, unless an unknown/nil definition also reaches it.
    for (const use of uses) {
        if (!ordinaryNames.has(use.name)) continue;
        const concrete = [];
        let blocked = false;
        for (const id of use.reachingDefinitionIds) {
            if (unknownDefinitionIds.has(id)) {
                blocked = true;
                break;
            }
            const definition = definitionById.get(id);
            if (!definition || !ordinaryDefinitionIds.has(id)) {
                blocked = true;
                break;
            }
            concrete.push(id);
        }
        if (blocked || concrete.length < 2) continue;
        for (let index = 1; index < concrete.length; index++) unionFind.union(concrete[0], concrete[index]);
    }

    // Transitive mutation evidence. Walk value provenance backward from each ordinary
    // definition; if it depends on an earlier definition of the same physical register,
    // coalesce them. This handles compiler temporaries without merging unrelated scratch
    // values merely because they happen to share a later cleanup.
    const dependencyClosureByDefinitionId = new Map();
    for (const definition of ordinaryDefinitions) {
        const queue = [...(dependenciesByDefinitionId.get(definition.id) || [])];
        const seen = new Set();
        let cursor = 0;
        while (cursor < queue.length) {
            const dependencyId = queue[cursor++];
            if (seen.has(dependencyId)) continue;
            seen.add(dependencyId);
            const dependency = definitionById.get(dependencyId);
            if (!dependency?.supported) continue;
            if (dependency.name === definition.name && ordinaryDefinitionIds.has(dependency.id)) {
                unionFind.union(definition.id, dependency.id);
            }
            for (const parentId of dependenciesByDefinitionId.get(dependencyId) || []) {
                if (!seen.has(parentId)) queue.push(parentId);
            }
        }
        dependencyClosureByDefinitionId.set(definition.id, seen);
    }

    // Compiler-backed ownership signal: after a physical register is reserved as a
    // VAR_REGISTER, later source assignments write it from another register. Starting
    // from a proven cleanup, walk backward only through adjacent same-register writes
    // that are linked by value provenance or where both writes are simple identifier
    // copies. This recovers blind source mutations without absorbing earlier scratch
    // literals/calls that happened to use the same physical slot before reservation.
    let anchoredCopyMergeCount = 0;
    for (const cleanup of cleanupCandidates) {
        const queue = [...cleanup.priorDefinitionIds];
        const seen = new Set();
        let cursor = 0;
        while (cursor < queue.length) {
            const currentId = queue[cursor++];
            if (seen.has(currentId)) continue;
            seen.add(currentId);
            const current = definitionById.get(currentId);
            if (!current || !ordinaryDefinitionIds.has(currentId)) continue;
            const priorIds = new Set(reachingBeforeStatement.get(current.statement)?.get(current.name) || []);
            if (!priorIds.size || [...priorIds].some(id => unknownDefinitionIds.has(id))) continue;
            for (const priorId of priorIds) {
                const prior = definitionById.get(priorId);
                if (!prior || !ordinaryDefinitionIds.has(priorId) || prior.name !== current.name) continue;
                const provenanceLinked = dependencyClosureByDefinitionId.get(currentId)?.has(priorId) === true;
                const copyLinked = isIdentifier(current.rhs) && isIdentifier(prior.rhs);
                const alreadyLinked = unionFind.find(currentId) === unionFind.find(priorId);
                if (!provenanceLinked && !copyLinked && !alreadyLinked) continue;
                const beforeRoot = unionFind.find(currentId);
                const priorRoot = unionFind.find(priorId);
                unionFind.union(currentId, priorId);
                if (beforeRoot !== priorRoot) anchoredCopyMergeCount++;
                queue.push(priorId);
            }
        }
    }

    const componentByRoot = new Map();
    for (const definition of ordinaryDefinitions) {
        const root = unionFind.find(definition.id);
        let component = componentByRoot.get(root);
        if (!component) {
            component = {
                root,
                name: definition.name,
                definitionIds: [],
                firstOffset: definition.sourceOffset,
            };
            componentByRoot.set(root, component);
        }
        component.definitionIds.push(definition.id);
        component.firstOffset = Math.min(component.firstOffset, definition.sourceOffset);
    }

    const componentsByRegister = new Map();
    for (const component of componentByRoot.values()) {
        let list = componentsByRegister.get(component.name);
        if (!list) componentsByRegister.set(component.name, list = []);
        list.push(component);
    }

    const epochByDefinitionId = new Map();
    const epochByRoot = new Map();
    const epochs = [];
    for (const [name, components] of componentsByRegister) {
        components.sort((left, right) => left.firstOffset - right.firstOffset);
        for (let index = 0; index < components.length; index++) {
            const component = components[index];
            const epoch = {
                key: `${name}:epoch:${index + 1}`,
                name,
                ordinal: index + 1,
                definitionIds: [...component.definitionIds],
                cleanupIds: [],
                firstOffset: component.firstOffset,
            };
            epochs.push(epoch);
            epochByRoot.set(component.root, epoch);
            for (const id of component.definitionIds) epochByDefinitionId.set(id, epoch);
        }
    }

    const epochByStatement = new Map();
    for (const definition of ordinaryDefinitions) {
        const epoch = epochByDefinitionId.get(definition.id);
        if (epoch) epochByStatement.set(definition.statement, { key: epoch.key, epoch, isKill: false });
    }

    // A proven cleanup terminates an already-established epoch. It never merges epochs.
    // If several distinct epochs reach the cleanup, keep the nil write conservative.
    let attachedCleanupCount = 0;
    for (const cleanup of cleanupCandidates) {
        const roots = new Set();
        let blocked = false;
        for (const priorId of cleanup.priorDefinitionIds) {
            const root = unionFind.find(priorId);
            if (!root) {
                blocked = true;
                break;
            }
            roots.add(root);
        }
        if (blocked || roots.size !== 1) continue;
        const epoch = epochByRoot.get([...roots][0]);
        if (!epoch) continue;
        epoch.cleanupIds.push(cleanup.id);
        epochByStatement.set(cleanup.statement, {
            key: epoch.key,
            epoch,
            isKill: true,
            cleanupId: cleanup.id,
        });
        attachedCleanupCount++;
    }

    return {
        cfgComplete,
        converged: !livenessChanged,
        valueNames,
        ordinaryNames,
        definitions,
        uses,
        inDefinitions,
        outDefinitions,
        reachingBeforeStatement,
        liveIn,
        liveOut,
        cleanupCandidates,
        dependenciesByDefinitionId,
        epochs,
        epochByStatement,
        stats: {
            valueRegisterCount: valueNames.size,
            registerCount: ordinaryNames.size,
            definitionCount: definitions.length,
            ordinaryDefinitionCount: definitions.filter(item => ordinaryNames.has(item.name)).length,
            supportedDefinitionCount: definitions.filter(item => item.supported).length,
            useCount: uses.length,
            provenanceEdgeCount,
            anchoredCopyMergeCount,
            provenCleanupCount: cleanupCandidates.length,
            attachedCleanupCount,
            epochCount: epochs.length,
            mergedDefinitionCount: epochs.reduce((sum, epoch) => sum + Math.max(0, epoch.definitionIds.length - 1), 0),
            livenessRounds,
        },
    };
}

module.exports = {
    analyzeBetaRegisterLifetimes,
};
