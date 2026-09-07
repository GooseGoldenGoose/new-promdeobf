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
const { applyCompilerRepeatMatch, matchCompilerRepeatNaturalLoop, applyCompilerTerminalRepeatMatches, matchCompilerTerminalRepeatPreheaders } = require("./repeat");
const { applyCompilerGenericForMatch, matchCompilerGenericForNaturalLoop } = require("./generic-for");
const {
    applyCompilerNumericForMatch,
    canonicalizeCompilerNumericForChecks,
    matchCompilerNumericForNaturalLoop,
} = require("./numeric-for");

function cloneLeaves(leaves) {
    return new Map([...leaves].map(([id, body]) => [id, [...body]]));
}

function mergeSet(target, source) {
    for (const value of source || []) target.add(value);
}

function mergeEvidence(target, source, excluded = null) {
    if (!(source instanceof Map)) return;
    for (const [key, items] of source) {
        if (excluded instanceof Set && excluded.has(key)) continue;
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
    // Numeric-for uses Prometheus' split `state = cond and body; state = state or final`
    // transition. Canonicalize only the exact proven compiler check template so the
    // shared StateGraph can see the loop before classification.
    const numericForSignatures = canonicalizeCompilerNumericForChecks(transformed, stateName);
    if (!numericForSignatures) return null;

    const loopBranchIds = new Set();
    const loopBodyJoinIds = new Set();
    const loopBackedgeCountsByJoin = new Map();
    const repeatBranchIds = new Set();
    const repeatBodyStarts = new Map();
    const terminalRepeatBodyStarts = new Map();
    const numericForBranchIds = new Set();
    const numericForMetaByBranchId = new Map();
    const numericForBodyStarts = new Map();
    const genericForBranchIds = new Set();
    const genericForMetaByBranchId = new Map();
    const genericForBodyStarts = new Map();
    const loopControlByBlockId = new Map();
    const loopCarriedEvidence = new Map();
    const matches = [];
    let whileLoopCount = 0;
    let repeatLoopCount = 0;
    let numericForLoopCount = 0;
    let genericForLoopCount = 0;
    let removedCompilerConditionStatementCount = 0;
    let nextSyntheticId = nextSyntheticBelow(transformed, -1);
    let rounds = 0;

    {
        const initialGraph = createStateGraph(transformed, entryId, stateName);
        if (!initialGraph) return null;
        const terminalRepeatMatches = matchCompilerTerminalRepeatPreheaders(initialGraph, stateName, returnName);
        if (terminalRepeatMatches.length) {
            if (!applyCompilerTerminalRepeatMatches(transformed, terminalRepeatMatches, { terminalRepeatBodyStarts })) return null;
            for (const match of terminalRepeatMatches) matches.push({ type: "repeat-terminal", match });
            repeatLoopCount += terminalRepeatMatches.length;
        }
    }

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
            const numericRaw = numericForSignatures.get(loopInfo.headerId);
            if (numericRaw) {
                const numericMatch = matchCompilerNumericForNaturalLoop(graph, loopInfo, numericRaw, returnName);
                if (!numericMatch) continue;
                const carried = candidateLoopCarriedRegisters(graph, [numericMatch]);
                mergeEvidence(loopCarriedEvidence, carried.evidence, new Set([
                    numericMatch.currentReg,
                    numericMatch.finalReg,
                    numericMatch.incrementReg,
                    numericMatch.negFlagReg,
                    numericMatch.loopVarReg,
                    numericMatch.loopVarCellReg,
                ].filter(Boolean)));
                const bodyJoinId = nextSyntheticId;
                nextSyntheticId = nextSyntheticBelow(transformed, bodyJoinId - 1);
                if (!applyCompilerNumericForMatch(transformed, graph, numericMatch, stateName, bodyJoinId, {
                    numericForBranchIds,
                    numericForMetaByBranchId,
                    numericForBodyStarts,
                    loopBodyJoinIds,
                    loopBackedgeCountsByJoin,
                    loopControlByBlockId,
                })) return null;
                matches.push({ type: "numeric-for", match: numericMatch });
                numericForLoopCount++;
                applied = true;
                break;
            }

            const genericMatch = matchCompilerGenericForNaturalLoop(graph, loopInfo, returnName);
            if (genericMatch) {
                const carried = candidateLoopCarriedRegisters(graph, [genericMatch]);
                mergeEvidence(loopCarriedEvidence, carried.evidence, new Set([
                    genericMatch.iteratorReg,
                    genericMatch.invariantReg,
                    genericMatch.controlReg,
                    ...genericMatch.loopVarRegs,
                ]));
                const bodyJoinId = nextSyntheticId;
                nextSyntheticId = nextSyntheticBelow(transformed, bodyJoinId - 1);
                if (!applyCompilerGenericForMatch(transformed, graph, genericMatch, stateName, bodyJoinId, {
                    genericForBranchIds,
                    genericForMetaByBranchId,
                    genericForBodyStarts,
                    loopBodyJoinIds,
                    loopBackedgeCountsByJoin,
                    loopControlByBlockId,
                })) return null;
                matches.push({ type: "generic-for", match: genericMatch });
                genericForLoopCount++;
                applied = true;
                break;
            }

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
        numericForLoopCount,
        genericForLoopCount,
        removedCompilerConditionStatementCount,
        loopBranchIds,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        repeatBranchIds,
        repeatBodyStarts,
        terminalRepeatBodyStarts,
        numericForBranchIds,
        numericForMetaByBranchId,
        numericForBodyStarts,
        genericForBranchIds,
        genericForMetaByBranchId,
        genericForBodyStarts,
        loopControlByBlockId,
        loopCarriedStorageRegs: remappedCarried.registers,
        loopCarriedStorageStarts: remappedCarried.starts,
    };
}

function matchCompilerStructuredLoopProgram(source, stateWhile, stateName, returnName, options = {}) {
    const suppliedLeaves = options.normalizedLeaves;
    const originalLeaves = suppliedLeaves instanceof Map
        ? cloneLeaves(suppliedLeaves)
        : extractNormalizedStateLeaves(stateWhile, stateName);
    if (!originalLeaves || originalLeaves.size < 4) return null;
    const entryId = Number.isInteger(options.entryId) ? options.entryId : 1;
    const originalGraphLeaves = cloneLeaves(originalLeaves);
    if (!canonicalizeCompilerNumericForChecks(originalGraphLeaves, stateName)) return null;
    const originalGraph = createStateGraph(originalGraphLeaves, entryId, stateName);
    if (!originalGraph) return null;
    const collapsed = collapseCompilerStructuredLoops(originalLeaves, entryId, stateName, returnName);
    if (!collapsed) return null;
    const structuredLeaves = collapsed.leaves;
    // Terminal-repeat recovery exists specifically for the Prometheus shape where
    // an all-terminal body suppresses the bottom-check edge and leaves dead final
    // states outside the root-reachable region. Once that terminal-repeat proof has
    // succeeded, render only the proven root-reachable invocation states. Other loop
    // shapes retain the stricter all-block accounting unless their caller explicitly
    // requested root-reachable recovery (for example transactional closure recovery).
    const terminalRepeatProven = collapsed.matches.some(item => item?.type === "repeat-terminal");
    const structuredRootReachableOnly = options.rootReachableOnly === true || terminalRepeatProven;
    const program = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, {
        ...options,
        allowConditionalIf: true,
        rootReachableOnly: structuredRootReachableOnly,
        normalizedLeaves: structuredLeaves,
        loopBranchIds: collapsed.loopBranchIds,
        loopBodyJoinIds: collapsed.loopBodyJoinIds,
        loopBackedgeCountsByJoin: collapsed.loopBackedgeCountsByJoin,
        repeatBranchIds: collapsed.repeatBranchIds,
        repeatBodyStarts: collapsed.repeatBodyStarts,
        terminalRepeatBodyStarts: collapsed.terminalRepeatBodyStarts,
        numericForBranchIds: collapsed.numericForBranchIds,
        numericForMetaByBranchId: collapsed.numericForMetaByBranchId,
        numericForBodyStarts: collapsed.numericForBodyStarts,
        genericForBranchIds: collapsed.genericForBranchIds,
        genericForMetaByBranchId: collapsed.genericForMetaByBranchId,
        genericForBodyStarts: collapsed.genericForBodyStarts,
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
        numericForLoopCount: collapsed.numericForLoopCount,
        genericForLoopCount: collapsed.genericForLoopCount,
        removedCompilerConditionStatementCount: collapsed.removedCompilerConditionStatementCount,
        loopMatches: collapsed.matches,
    };
}

module.exports = { collapseCompilerStructuredLoops, matchCompilerStructuredLoopProgram };
