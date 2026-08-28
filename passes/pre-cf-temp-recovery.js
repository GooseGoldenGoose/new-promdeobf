"use strict";

function operationWrites(operation) {
    if (!operation || typeof operation !== "object") return [];
    if (typeof operation.emittedTarget === "string") return [operation.emittedTarget];
    if (Array.isArray(operation.emittedTargets)) return operation.emittedTargets.filter(name => typeof name === "string");
    return [];
}

function graphReachable(stateById, fromId, targetId) {
    if (fromId === targetId) return true;
    const queue = [fromId];
    const seen = new Set([fromId]);
    while (queue.length) {
        const id = queue.shift();
        const state = stateById.get(id);
        for (const next of state?.successors || []) {
            if (next === targetId) return true;
            if (!seen.has(next) && stateById.has(next)) {
                seen.add(next);
                queue.push(next);
            }
        }
    }
    return false;
}

function buildPreCfTempProofIndex(betaResult) {
    const graph = betaResult?.graph;
    if (!graph || !Array.isArray(graph.states)) {
        return { safe: false, reason: "Missing beta graph", byBinding: new Map(), stateById: new Map() };
    }

    const stateById = new Map(graph.states.map(state => [state.id, state]));
    const writes = new Map();
    const reads = new Map();
    const locations = new Map();

    for (const state of graph.states) {
        const operations = Array.isArray(state.operations) ? state.operations : [];
        for (let offset = 0; offset < operations.length; offset++) {
            const operation = operations[offset];
            const location = { stateId: state.id, offset, operation };
            locations.set(operation, location);
            for (const name of operationWrites(operation)) {
                if (!writes.has(name)) writes.set(name, []);
                writes.get(name).push(location);
            }
            for (const name of operation.reads || []) {
                if (typeof name !== "string") continue;
                if (!reads.has(name)) reads.set(name, []);
                reads.get(name).push(location);
            }
        }
    }

    const captured = new Set(graph.recoveredUpvalueBindings || []);
    const byBinding = new Map();
    const names = new Set([...writes.keys(), ...reads.keys()]);
    for (const name of names) {
        const producers = writes.get(name) || [];
        const consumers = reads.get(name) || [];
        const producer = producers.length === 1 ? producers[0] : null;
        const consumer = consumers.length === 1 ? consumers[0] : null;
        const sameState = Boolean(producer && consumer && producer.stateId === consumer.stateId);
        const adjacent = Boolean(sameState && consumer.offset === producer.offset + 1);
        const crossesCycle = Boolean(
            producer && consumer && producer.stateId !== consumer.stateId &&
            graphReachable(stateById, consumer.stateId, producer.stateId)
        );
        const facts = {
            name,
            producer,
            consumer,
            definitionCount: producers.length,
            readCount: consumers.length,
            singleDefinition: producers.length === 1,
            singleUse: consumers.length === 1,
            captured: captured.has(name),
            sameState,
            adjacent,
            crossesCycle,
            cfgComplete: graph.cfgComplete === true,
        };
        facts.safeSameStateTransport = Boolean(
            facts.cfgComplete && facts.singleDefinition && facts.singleUse &&
            !facts.captured && facts.sameState && !facts.crossesCycle
        );
        byBinding.set(name, facts);
    }

    return { safe: true, byBinding, stateById, locations };
}

function provePreCfTempUse(betaResult, bindingName) {
    const index = buildPreCfTempProofIndex(betaResult);
    if (!index.safe) return { safe: false, reason: index.reason };
    const facts = index.byBinding.get(bindingName);
    if (!facts) return { safe: false, reason: `Unknown beta binding ${bindingName}` };
    return { safe: facts.safeSameStateTransport, ...facts };
}

module.exports = {
    buildPreCfTempProofIndex,
    provePreCfTempUse,
};