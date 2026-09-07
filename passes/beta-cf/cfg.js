"use strict";

const { isSingleAssignment } = require("./ast");
const { decodeLogicalStateTransition } = require("./normalize");

function transitionOfBody(body, stateName) {
    for (let index = (body || []).length - 1; index >= 0; index--) {
        if (!isSingleAssignment(body[index], stateName)) continue;
        const rhs = body[index].init[0];
        if (rhs?.type === "NilLiteral") return { index, kind: "stop" };
        if (rhs?.type === "NumericLiteral" && Number.isInteger(Number(rhs.value))) {
            return { index, kind: "jump", target: Number(rhs.value) };
        }
        const branch = decodeLogicalStateTransition(rhs);
        if (branch) return { index, kind: "branch", ...branch };
    }
    return null;
}

function transitionTargets(transition) {
    if (transition?.kind === "jump") return [transition.target];
    if (transition?.kind === "branch") return [transition.onTrue, transition.onFalse];
    return [];
}

function createStateGraph(leaves, entryId, stateName, options = {}) {
    if (!(leaves instanceof Map) || !leaves.has(entryId)) return null;
    const strictTargets = options.strictTargets !== false;
    const reachableOnly = options.reachableOnly === true;
    const blocks = new Map();

    if (reachableOnly) {
        // Child-closure recovery shares one normalized leaf map with its parent
        // invocation. Parse only states reachable from this invocation entry so
        // unrelated parent/sibling compiler shapes cannot invalidate its CFG.
        const queue = [entryId];
        while (queue.length) {
            const id = queue.shift();
            if (blocks.has(id)) continue;
            const body = leaves.get(id);
            if (!body) {
                if (strictTargets) return null;
                continue;
            }
            const transition = transitionOfBody(body, stateName);
            if (!transition) return null;
            blocks.set(id, { id, body, transitionIndex: transition.index, transition });
            for (const target of transitionTargets(transition)) {
                if (!leaves.has(target)) {
                    if (strictTargets) return null;
                    continue;
                }
                if (!blocks.has(target)) queue.push(target);
            }
        }
    } else {
        for (const [id, body] of leaves) {
            const transition = transitionOfBody(body, stateName);
            if (!transition) return null;
            blocks.set(id, { id, body, transitionIndex: transition.index, transition });
        }
    }

    const successors = new Map([...blocks.keys()].map(id => [id, []]));
    const predecessors = new Map([...blocks.keys()].map(id => [id, []]));
    for (const [id, block] of blocks) {
        for (const target of transitionTargets(block.transition)) {
            if (!blocks.has(target)) {
                if (strictTargets && !reachableOnly) return null;
                continue;
            }
            successors.get(id).push(target);
            predecessors.get(target).push(id);
        }
    }

    const reachable = reachableOnly ? new Set(blocks.keys()) : reachableFrom(entryId, successors, blocks);
    return { entryId, blocks, successors, predecessors, reachable };
}

function reachableFrom(start, successors, blocks = null) {
    const reachable = new Set();
    const queue = [start];
    while (queue.length) {
        const id = queue.shift();
        if (reachable.has(id) || (blocks && !blocks.has(id))) continue;
        reachable.add(id);
        for (const next of successors.get(id) || []) queue.push(next);
    }
    return reachable;
}

function canReach(graph, start, target) {
    if (start === target) return true;
    const seen = new Set();
    const queue = [start];
    while (queue.length) {
        const id = queue.shift();
        if (seen.has(id)) continue;
        seen.add(id);
        for (const next of graph.successors.get(id) || []) {
            if (next === target) return true;
            if (!seen.has(next)) queue.push(next);
        }
    }
    return false;
}

function hasLinearPath(graph, fromId, toId) {
    if (!Number.isInteger(fromId) || !Number.isInteger(toId)) return false;
    let current = fromId;
    const seen = new Set();
    while (true) {
        if (current === toId) return true;
        if (seen.has(current)) return false;
        seen.add(current);
        const next = graph.successors.get(current) || [];
        if (next.length !== 1) return false;
        current = next[0];
    }
}

module.exports = {
    canReach,
    createStateGraph,
    hasLinearPath,
    reachableFrom,
    transitionOfBody,
    transitionTargets,
};
