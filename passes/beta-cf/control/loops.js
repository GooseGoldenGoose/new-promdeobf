"use strict";

const { createStateGraph } = require("../cfg");
const { extractNormalizedStateLeaves } = require("../normalize");
const { matchMultiStateLogicalLocals } = require("../structured/solver");
const { candidateLoopCarriedRegisters, remapLoopCarriedStarts } = require("./loop-storage");
const {
    applyCompilerWhileMatch,
    findNaturalLoops,
    loopsAreNestedOrDisjoint,
    matchCompilerWhileConditionRegion,
} = require("./while");
const { applyCompilerRepeatMatch, matchCompilerRepeatNaturalLoop } = require("./repeat");

function cloneLeaves(leaves) {
    return new Map([...leaves].map(([id, body]) => [id, [...body]]));
}

function mergeSet(target, source) {
    for (const value of source || []) target.add(value);
}

function mergeSetMap(target, source) {
    if (!(source instanceof Map)) return;
    for (const [key, values] of source) {
        if (!target.has(key)) target.set(key, new Set());
        mergeSet(target.get(key), values);
    }
}

function mergeEvidence(target, source) {
    if (!(source instanceof Map)) return;
    for (const [key, items] of source) {
        if (!target.has(key)) target.set(key, []);
        target.get(key).push(...items);
    }
}

function nextSyntheticBelow(leaves, current) {
    let id = current;
    while (leaves.has(id)) id--;
    return id;
}

function collapseCompilerStructuredLoops(leaves, entryId, stateName, returnName = null) {
    if (!(leaves instanceof Map) || !Number.isInteger(entryId) || typeof stateName !== "string") return null;
    const transformed = cloneLeaves(leaves);
    const loopBranchIds = new Set();
    const loopBodyJoinIds = new Set();
    const loopBackedgeCountsByJoin = new Map();
    const repeatBranchIds = new Set();
    const repeatBodyStarts = new Map();
    const loopControlByBlockId = new Map();
    const loopCarriedEvidence = new Map();
    const matches = [];
    let whileLoopCount = 0;
    let repeatLoopCount = 0;
    let removedCompilerConditionStatementCount = 0;
    let nextSyntheticId = nextSyntheticBelow(transformed, -1);
    let rounds = 0;

    while (true) {
        if (rounds++ > leaves.size * 3 + 16) return null;
        const graph = createStateGraph(transformed, entryId, stateName);
        if (!graph) return null;
        const natural = findNaturalLoops(graph);
        if (!natural) return null;
        if (!natural.loops.length) break;
        if (!loopsAreNestedOrDisjoint(natural.loops)) return null;

        const ordered = [...natural.loops].sort((a, b) => a.coreIds.size - b.coreIds.size || a.headerId - b.headerId);
        let applied = false;
        for (const loopInfo of ordered) {
            const repeatMatch = matchCompilerRepeatNaturalLoop(graph, loopInfo, returnName);
            if (repeatMatch) {
                repeatMatch.headerId = repeatMatch.bodyId;
                const carried = candidateLoopCarriedRegisters(graph, [repeatMatch]);
                mergeEvidence(loopCarriedEvidence, carried.evidence);
                const joinId = nextSyntheticId;
                nextSyntheticId = nextSyntheticBelow(transformed, joinId - 1);
                const repeatId = `repeat:${repeatLoopCount + 1}:${repeatMatch.bodyId}:${repeatMatch.decisionId}`;
                if (!applyCompilerRepeatMatch(transformed, graph, repeatMatch, stateName, joinId, repeatId, {
                    repeatBranchIds, repeatBodyStarts, loopControlByBlockId,
                })) return null;
                matches.push({ type: "repeat", match: repeatMatch });
                repeatLoopCount++;
                removedCompilerConditionStatementCount += repeatMatch.duplicate?.removedStatementCount || 0;
                applied = true;
                break;
            }

            const whileMatch = matchCompilerWhileConditionRegion(graph, loopInfo, natural.dominators, returnName);
            if (whileMatch) {
                const carried = candidateLoopCarriedRegisters(graph, [whileMatch]);
                mergeEvidence(loopCarriedEvidence, carried.evidence);
                const bodyJoinId = nextSyntheticId;
                nextSyntheticId = nextSyntheticBelow(transformed, bodyJoinId - 1);
                if (!applyCompilerWhileMatch(transformed, graph, whileMatch, stateName, bodyJoinId, {
                    loopBranchIds, loopBodyJoinIds, loopBackedgeCountsByJoin, controlByBlockId: loopControlByBlockId,
                })) return null;
                matches.push({ type: "while", match: whileMatch });
                whileLoopCount++;
                applied = true;
                break;
            }
        }
        if (!applied) return null;
    }

    if (!matches.length) return null;
    const remappedCarried = remapLoopCarriedStarts({ evidence: loopCarriedEvidence }, transformed);
    return {
        leaves: transformed,
        matches,
        loopCount: matches.length,
        whileLoopCount,
        repeatLoopCount,
        removedCompilerConditionStatementCount,
        loopBranchIds,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        repeatBranchIds,
        repeatBodyStarts,
        loopControlByBlockId,
        loopCarriedStorageRegs: remappedCarried.registers,
        loopCarriedStorageStarts: remappedCarried.starts,
    };
}

function matchCompilerStructuredLoopProgram(source, stateWhile, stateName, returnName, options = {}) {
    const originalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!originalLeaves || originalLeaves.size < 4) return null;
    const entryId = Number.isInteger(options.entryId) ? options.entryId : 1;
    const originalGraph = createStateGraph(originalLeaves, entryId, stateName);
    if (!originalGraph) return null;
    const collapsed = collapseCompilerStructuredLoops(originalLeaves, entryId, stateName, returnName);
    if (!collapsed) return null;
    const program = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, {
        ...options,
        allowConditionalIf: true,
        normalizedLeaves: collapsed.leaves,
        loopBranchIds: collapsed.loopBranchIds,
        loopBodyJoinIds: collapsed.loopBodyJoinIds,
        loopBackedgeCountsByJoin: collapsed.loopBackedgeCountsByJoin,
        repeatBranchIds: collapsed.repeatBranchIds,
        repeatBodyStarts: collapsed.repeatBodyStarts,
        loopControlByBlockId: collapsed.loopControlByBlockId,
        forcedPersistentStorageRegs: collapsed.loopCarriedStorageRegs,
        forcedPersistentStorageStarts: collapsed.loopCarriedStorageStarts,
        suppressFutureWriteCallArgumentPromotion: true,
    });
    if (!program) return null;
    return {
        ...program,
        stateCount: originalGraph.reachable.size,
        reachableStateIds: [...originalGraph.reachable],
        loopCount: collapsed.loopCount,
        whileLoopCount: collapsed.whileLoopCount,
        repeatLoopCount: collapsed.repeatLoopCount,
        removedCompilerConditionStatementCount: collapsed.removedCompilerConditionStatementCount,
        loopMatches: collapsed.matches,
    };
}

module.exports = { collapseCompilerStructuredLoops, matchCompilerStructuredLoopProgram };
