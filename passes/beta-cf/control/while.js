"use strict";

const { isIdentifier, isSingleAssignment, isVmRegisterName } = require("../ast");
const { createStateGraph } = require("../cfg");
const { extractNormalizedStateLeaves } = require("../normalize");
const { matchMultiStateLogicalLocals } = require("../structured/solver");

function transitionTargets(transition) {
    if (transition?.kind === "jump") return [transition.target];
    if (transition?.kind === "branch") return [transition.onTrue, transition.onFalse];
    return [];
}

function nodeReadsName(node, name) {
    if (!node || typeof node !== "object") return false;
    if (isIdentifier(node, name)) return true;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => nodeReadsName(item, name))) return true;
        } else if (value && typeof value === "object" && nodeReadsName(value, name)) {
            return true;
        }
    }
    return false;
}

function statementReadsName(statement, name) {
    if (!statement || typeof statement !== "object") return false;
    if (statement.type === "AssignmentStatement") {
        for (const rhs of statement.init || []) if (nodeReadsName(rhs, name)) return true;
        for (const dest of statement.variables || []) {
            if (dest?.type === "IndexExpression" && nodeReadsName(dest, name)) return true;
        }
        return false;
    }
    return nodeReadsName(statement, name);
}

function computeDominators(graph) {
    const nodes = [...graph.reachable];
    const all = new Set(nodes);
    const dominators = new Map();
    for (const id of nodes) dominators.set(id, id === graph.entryId ? new Set([id]) : new Set(all));

    let changed = true;
    let rounds = 0;
    while (changed && rounds++ <= nodes.length + 1) {
        changed = false;
        for (const id of nodes) {
            if (id === graph.entryId) continue;
            const preds = (graph.predecessors.get(id) || []).filter(pred => graph.reachable.has(pred));
            if (!preds.length) return null;
            let next = null;
            for (const pred of preds) {
                const predDom = dominators.get(pred);
                if (!predDom) return null;
                if (next === null) next = new Set(predDom);
                else for (const value of [...next]) if (!predDom.has(value)) next.delete(value);
            }
            next.add(id);
            const previous = dominators.get(id);
            if (previous.size !== next.size || [...previous].some(value => !next.has(value))) {
                dominators.set(id, next);
                changed = true;
            }
        }
    }
    return changed ? null : dominators;
}

function naturalLoopForHeader(graph, headerId, backedgeSources) {
    const ids = new Set([headerId]);
    const stack = [];
    for (const source of backedgeSources) {
        if (!ids.has(source)) {
            ids.add(source);
            stack.push(source);
        }
    }
    while (stack.length) {
        const id = stack.pop();
        for (const pred of graph.predecessors.get(id) || []) {
            if (!graph.reachable.has(pred) || ids.has(pred)) continue;
            ids.add(pred);
            if (pred !== headerId) stack.push(pred);
        }
    }
    return ids;
}

function findNaturalLoops(graph) {
    const dominators = computeDominators(graph);
    if (!dominators) return null;
    const sourcesByHeader = new Map();
    for (const source of graph.reachable) {
        for (const target of graph.successors.get(source) || []) {
            if (!graph.reachable.has(target)) continue;
            if (!dominators.get(source)?.has(target)) continue;
            if (!sourcesByHeader.has(target)) sourcesByHeader.set(target, new Set());
            sourcesByHeader.get(target).add(source);
        }
    }
    const loops = [];
    for (const [headerId, sources] of sourcesByHeader) {
        loops.push({ headerId, backedgeSources: new Set(sources), coreIds: naturalLoopForHeader(graph, headerId, sources) });
    }
    return { dominators, loops };
}

function loopsAreNestedOrDisjoint(loops) {
    for (let i = 0; i < loops.length; i++) {
        for (let j = i + 1; j < loops.length; j++) {
            const a = loops[i].coreIds;
            const b = loops[j].coreIds;
            const overlap = [...a].some(id => b.has(id));
            if (!overlap) continue;
            const aInsideB = [...a].every(id => b.has(id));
            const bInsideA = [...b].every(id => a.has(id));
            if (!aInsideB && !bInsideA) return false;
        }
    }
    return true;
}

function looksLikeCompilerGenericFor(block) {
    if (!block) return false;
    for (let i = 0; i < block.transitionIndex; i++) {
        const statement = block.body[i];
        if (statement?.type !== "AssignmentStatement") continue;
        if ((statement.variables || []).length < 2 || (statement.init || []).length !== 1) continue;
        if (statement.init[0]?.type === "CallExpression") return true;
    }
    return false;
}

function looksLikeCompilerNumericFor(block) {
    if (!block) return false;
    let hasSelfAdd = false;
    let hasNot = false;
    let hasLessEqual = false;
    let hasGreaterEqual = false;
    for (let i = 0; i < block.transitionIndex; i++) {
        const statement = block.body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) continue;
        const dest = statement.variables[0].name;
        const rhs = statement.init[0];
        if (rhs?.type === "BinaryExpression" && rhs.operator === "+" && isIdentifier(rhs.left, dest) && isIdentifier(rhs.right)) hasSelfAdd = true;
        if (rhs?.type === "UnaryExpression" && rhs.operator === "not") hasNot = true;
        if (rhs?.type === "BinaryExpression" && rhs.operator === "<=") hasLessEqual = true;
        if (rhs?.type === "BinaryExpression" && rhs.operator === ">=") hasGreaterEqual = true;
    }
    return hasSelfAdd && hasNot && hasLessEqual && hasGreaterEqual;
}

function isCompilerTerminalReturnBlock(block, returnName) {
    if (!block || block.transition?.kind !== "stop" || typeof returnName !== "string") return false;
    for (let i = block.transitionIndex - 1; i >= 0; i--) {
        const statement = block.body[i];
        if (!isSingleAssignment(statement, returnName)) continue;
        return statement.init[0]?.type === "TableConstructorExpression";
    }
    return false;
}

function collectTerminalReturnRegion(graph, startId, coreIds, returnName, forbiddenExitId = null) {
    if (startId === forbiddenExitId || coreIds.has(startId) || !graph.blocks.has(startId)) return null;
    const ids = new Set();
    const visiting = new Set();
    let invalid = false;

    function visit(id) {
        if (invalid || ids.has(id)) return;
        if (id === forbiddenExitId || coreIds.has(id) || visiting.has(id)) { invalid = true; return; }
        const block = graph.blocks.get(id);
        if (!block) { invalid = true; return; }
        visiting.add(id);
        if (block.transition?.kind === "stop") {
            if (!isCompilerTerminalReturnBlock(block, returnName)) invalid = true;
        } else {
            const targets = transitionTargets(block.transition);
            if (!targets.length) invalid = true;
            for (const target of targets) {
                if (invalid) break;
                if (coreIds.has(target)) { invalid = true; break; }
                visit(target);
            }
        }
        visiting.delete(id);
        ids.add(id);
    }

    visit(startId);
    if (invalid || !ids.size) return null;
    for (const id of ids) {
        for (const pred of graph.predecessors.get(id) || []) {
            if (coreIds.has(pred) || ids.has(pred)) continue;
            return null;
        }
    }
    return { ids };
}

function collectBreakRegion(graph, startId, coreIds, exitId) {
    if (startId === exitId || coreIds.has(startId) || !graph.blocks.has(startId)) return null;
    const ids = new Set();
    const terminalIds = new Set();
    const visiting = new Set();
    let invalid = false;

    function visit(id) {
        if (invalid || ids.has(id)) return;
        if (id === exitId || coreIds.has(id) || visiting.has(id)) {
            invalid = true;
            return;
        }
        const block = graph.blocks.get(id);
        if (!block || block.transition?.kind === "stop") {
            invalid = true;
            return;
        }
        visiting.add(id);
        const targets = transitionTargets(block.transition);
        if (!targets.length) {
            invalid = true;
        } else {
            for (const target of targets) {
                if (target === exitId) {
                    terminalIds.add(id);
                    continue;
                }
                if (coreIds.has(target)) {
                    invalid = true;
                    break;
                }
                visit(target);
                if (invalid) break;
            }
        }
        visiting.delete(id);
        ids.add(id);
    }

    visit(startId);
    if (invalid || !ids.size || !terminalIds.size) return null;
    for (const id of ids) {
        for (const pred of graph.predecessors.get(id) || []) {
            if (coreIds.has(pred) || ids.has(pred)) continue;
            return null;
        }
    }
    return { ids, terminalIds };
}

function collectMixedAbruptRegion(graph, startId, coreIds, exitId, returnName) {
    if (startId === exitId || coreIds.has(startId) || !graph.blocks.has(startId)) return null;
    const ids = new Set();
    const breakTerminalIds = new Set();
    const returnTerminalIds = new Set();
    const visiting = new Set();
    let invalid = false;

    function visit(id) {
        if (invalid || ids.has(id)) return;
        if (id === exitId || coreIds.has(id) || visiting.has(id)) { invalid = true; return; }
        const block = graph.blocks.get(id);
        if (!block) { invalid = true; return; }
        visiting.add(id);

        if (block.transition?.kind === "stop") {
            if (!isCompilerTerminalReturnBlock(block, returnName)) invalid = true;
            else returnTerminalIds.add(id);
        } else if (block.transition?.kind === "jump" && block.transition.target === exitId) {
            breakTerminalIds.add(id);
        } else {
            const targets = transitionTargets(block.transition);
            if (!targets.length) invalid = true;
            for (const target of targets) {
                if (invalid) break;
                // Prometheus break cleanup is a dedicated jump block. A direct
                // conditional edge to the loop final has not proven source break.
                if (target === exitId || coreIds.has(target)) { invalid = true; break; }
                visit(target);
            }
        }

        visiting.delete(id);
        ids.add(id);
    }

    visit(startId);
    if (invalid || !ids.size || !breakTerminalIds.size || !returnTerminalIds.size) return null;
    for (const id of ids) {
        for (const pred of graph.predecessors.get(id) || []) {
            if (coreIds.has(pred) || ids.has(pred)) continue;
            return null;
        }
    }
    return { ids, breakTerminalIds, returnTerminalIds };
}

function matchCompilerWhileConditionRegion(graph, loopInfo, dominators, returnName = null) {
    if (!loopInfo?.coreIds?.size || !loopInfo.backedgeSources?.size) return null;
    const coreIds = loopInfo.coreIds;
    const headerId = loopInfo.headerId;

    const outsideHeaderPreds = (graph.predecessors.get(headerId) || []).filter(id => graph.reachable.has(id) && !coreIds.has(id));
    if (outsideHeaderPreds.length !== 1) return null;
    const preheaderId = outsideHeaderPreds[0];
    const preheader = graph.blocks.get(preheaderId);
    if (!preheader || preheader.transition?.kind !== "jump" || preheader.transition.target !== headerId) return null;

    const decisions = [];
    for (const id of coreIds) {
        const block = graph.blocks.get(id);
        const tr = block?.transition;
        if (!tr || tr.kind !== "branch") continue;
        if (!coreIds.has(tr.onTrue) || coreIds.has(tr.onFalse)) continue;
        if (![...loopInfo.backedgeSources].every(source => dominators.get(source)?.has(id))) continue;
        decisions.push(block);
    }
    if (decisions.length !== 1) return null;
    const decision = decisions[0];
    if (looksLikeCompilerNumericFor(decision) || looksLikeCompilerGenericFor(decision)) return null;
    const exitId = decision.transition.onFalse;
    if (!graph.blocks.has(exitId)) return null;

    const breakRegionIds = new Set();
    const breakTerminalIds = new Set();
    const terminalReturnRegionIds = new Set();
    for (const id of coreIds) {
        const block = graph.blocks.get(id);
        for (const target of transitionTargets(block?.transition)) {
            if (coreIds.has(target)) continue;
            if (id === decision.id && target === exitId) continue;
            const breakRegion = collectBreakRegion(graph, target, coreIds, exitId);
            if (breakRegion) {
                for (const member of breakRegion.ids) breakRegionIds.add(member);
                for (const terminal of breakRegion.terminalIds) breakTerminalIds.add(terminal);
                continue;
            }
            const returnRegion = collectTerminalReturnRegion(graph, target, coreIds, returnName, exitId);
            if (returnRegion) {
                for (const member of returnRegion.ids) terminalReturnRegionIds.add(member);
                continue;
            }
            const mixedAbruptRegion = collectMixedAbruptRegion(graph, target, coreIds, exitId, returnName);
            if (!mixedAbruptRegion) return null;
            for (const terminal of mixedAbruptRegion.breakTerminalIds) breakTerminalIds.add(terminal);
            for (const terminal of mixedAbruptRegion.returnTerminalIds) terminalReturnRegionIds.add(terminal);
        }
    }

    // Every proven body -> check edge ends the current iteration. Prometheus
    // does not always preserve which one was lexical fallthrough versus an
    // explicit source continue. Mark them uniformly; the renderer removes only
    // a redundant final top-level continue at the loop tail. This keeps branch
    // continues explicit without guessing a unique physical latch.
    const backedgeSources = [...loopInfo.backedgeSources];

    return {
        coreIds,
        breakRegionIds,
        breakTerminalIds,
        terminalReturnRegionIds,
        backedgeSources: new Set(backedgeSources),
        continueIds: new Set(backedgeSources),
        normalLatchId: null,
        preheaderId,
        headerId,
        decisionId: decision.id,
        bodyId: decision.transition.onTrue,
        exitId,
    };
}

function cloneLeaves(leaves) {
    return new Map([...leaves].map(([id, body]) => [id, [...body]]));
}

function rewriteJumpTarget(leaves, graph, blockId, targetId) {
    const block = graph.blocks.get(blockId);
    const body = leaves.get(blockId);
    if (!block || !body || block.transition?.kind !== "jump" || block.transitionIndex < 0 || block.transitionIndex >= body.length) return false;
    const original = body[block.transitionIndex];
    if (!isSingleAssignment(original) || !isIdentifier(original.variables[0])) return false;
    const nextBody = [...body];
    nextBody[block.transitionIndex] = {
        ...original,
        init: [{ type: "NumericLiteral", value: targetId, raw: String(targetId) }],
    };
    leaves.set(blockId, nextBody);
    return true;
}

function syntheticJump(stateName, targetId) {
    return {
        type: "AssignmentStatement",
        variables: [{ type: "Identifier", name: stateName }],
        init: [{ type: "NumericLiteral", value: targetId, raw: String(targetId) }],
    };
}

function candidateLoopCarriedRegisters(graph, matches) {
    const candidates = new Set();
    const starts = new Map();
    for (const match of matches) {
        const preheader = graph.blocks.get(match.preheaderId);
        if (!preheader) continue;
        // One physical register may serve as several compiler TEMPs before
        // its final preheader value becomes the loop-carried source binding.
        // Record the exact last non-nil definition that reaches the header so
        // earlier same-block TEMP epochs can never be promoted as that local.
        const preheaderDefinitions = new Map();
        for (let i = 0; i < preheader.transitionIndex; i++) {
            const statement = preheader.body[i];
            if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) continue;
            const name = statement.variables[0].name;
            if (!isVmRegisterName(name) || statement.init[0]?.type === "NilLiteral") continue;
            preheaderDefinitions.set(name, i);
        }
        for (const [name, definitionIndex] of preheaderDefinitions) {
            let hasLoopWrite = false;
            let readsInitialBeforeOverwrite = false;
            const seen = new Set();
            const queue = [{ id: match.headerId, live: true }];
            while (queue.length) {
                const cursor = queue.shift();
                const key = cursor.id + ":" + (cursor.live ? "1" : "0");
                if (seen.has(key)) continue;
                seen.add(key);
                const block = graph.blocks.get(cursor.id);
                if (!block) continue;
                let live = cursor.live;
                for (let i = 0; i < block.body.length; i++) {
                    if (i === block.transitionIndex) continue;
                    const statement = block.body[i];
                    if (live && statementReadsName(statement, name)) readsInitialBeforeOverwrite = true;
                    if (isSingleAssignment(statement) && isIdentifier(statement.variables[0], name)) {
                        if (statement.init[0]?.type !== "NilLiteral") hasLoopWrite = true;
                        live = false;
                    }
                }
                if (live && block.transition?.kind === "branch" && block.transition.conditionRegister === name) readsInitialBeforeOverwrite = true;
                for (const target of transitionTargets(block.transition)) {
                    if (target === match.headerId || !match.coreIds.has(target)) continue;
                    queue.push({ id: target, live });
                }
            }
            if (hasLoopWrite && readsInitialBeforeOverwrite) {
                candidates.add(name);
                if (!starts.has(name)) starts.set(name, new Set());
                starts.get(name).add(match.preheaderId + ":" + definitionIndex);
            }
        }
    }
    return { registers: candidates, starts };
}

function collapseCompilerWhileLoops(leaves, entryId, stateName, returnName = null) {
    if (!(leaves instanceof Map) || !Number.isInteger(entryId) || typeof stateName !== "string") return null;
    const graph = createStateGraph(leaves, entryId, stateName);
    if (!graph || graph.reachable.size < 3) return null;
    const natural = findNaturalLoops(graph);
    if (!natural || !natural.loops.length || !loopsAreNestedOrDisjoint(natural.loops)) return null;

    const matches = [];
    for (const loopInfo of natural.loops) {
        const match = matchCompilerWhileConditionRegion(graph, loopInfo, natural.dominators, returnName);
        if (!match) return null;
        matches.push(match);
    }

    const transformed = cloneLeaves(leaves);
    const controlByBlockId = new Map();
    const loopBranchIds = new Set();
    const loopBodyJoinIds = new Set();
    const loopBackedgeCountsByJoin = new Map();
    let nextSyntheticId = -1;
    while (transformed.has(nextSyntheticId)) nextSyntheticId--;

    // Inner loop body joins must be introduced before their enclosing loop
    // joins so the structured solver sees a normal acyclic nesting order.
    const ordered = [...matches].sort((a, b) => a.coreIds.size - b.coreIds.size);
    for (const match of ordered) {
        const bodyJoinId = nextSyntheticId--;
        match.bodyJoinId = bodyJoinId;
        loopBackedgeCountsByJoin.set(bodyJoinId, match.backedgeSources.size);
        loopBranchIds.add(match.decisionId);
        loopBodyJoinIds.add(bodyJoinId);

        for (const source of match.backedgeSources) {
            if (!rewriteJumpTarget(transformed, graph, source, bodyJoinId)) return null;
            if (match.continueIds.has(source)) controlByBlockId.set(source, "continue");
        }
        for (const source of match.breakTerminalIds) {
            if (!rewriteJumpTarget(transformed, graph, source, bodyJoinId)) return null;
            controlByBlockId.set(source, "break");
        }
        transformed.set(bodyJoinId, [syntheticJump(stateName, match.exitId)]);
    }

    const loopCarried = candidateLoopCarriedRegisters(graph, matches);
    return {
        leaves: transformed,
        matches,
        loopBranchIds,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        controlByBlockId,
        loopCarriedStorageRegs: loopCarried.registers,
        loopCarriedStorageStarts: loopCarried.starts,
    };
}

function matchCompilerWhileProgram(source, stateWhile, stateName, returnName, options = {}) {
    const originalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!originalLeaves || originalLeaves.size < 4) return null;
    const entryId = Number.isInteger(options.entryId) ? options.entryId : 1;
    const originalGraph = createStateGraph(originalLeaves, entryId, stateName);
    if (!originalGraph) return null;
    const originalReachableStateIds = [...originalGraph.reachable];
    const collapsed = collapseCompilerWhileLoops(originalLeaves, entryId, stateName, returnName);
    if (!collapsed) return null;

    const program = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, {
        ...options,
        allowConditionalIf: true,
        normalizedLeaves: collapsed.leaves,
        loopBranchIds: collapsed.loopBranchIds,
        loopBodyJoinIds: collapsed.loopBodyJoinIds,
        loopBackedgeCountsByJoin: collapsed.loopBackedgeCountsByJoin,
        loopControlByBlockId: collapsed.controlByBlockId,
        forcedPersistentStorageRegs: collapsed.loopCarriedStorageRegs,
        forcedPersistentStorageStarts: collapsed.loopCarriedStorageStarts,
        suppressFutureWriteCallArgumentPromotion: true,
    });
    if (!program) return null;
    return {
        ...program,
        stateCount: originalReachableStateIds.length,
        reachableStateIds: originalReachableStateIds,
        loopCount: collapsed.matches.length,
        loopMatches: collapsed.matches,
    };
}

module.exports = {
    collapseCompilerWhileLoops,
    matchCompilerWhileConditionRegion,
    matchCompilerWhileProgram,
};
