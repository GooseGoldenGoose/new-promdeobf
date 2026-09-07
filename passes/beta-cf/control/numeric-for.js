"use strict";

const { isIdentifier, isSingleAssignment, isVmRegisterName } = require("../ast");
const { createStateGraph } = require("../cfg");
const { collectBreakRegion, collectMixedAbruptRegion, collectTerminalReturnRegion, findNaturalLoops, loopsAreNestedOrDisjoint } = require("./while");

function numericLiteral(value) {
    return { type: "NumericLiteral", value, raw: String(value) };
}


function identifier(name) {
    return { type: "Identifier", name };
}

function syntheticAssignment(name, value) {
    return {
        type: "AssignmentStatement",
        variables: [identifier(name)],
        init: [value],
    };
}

function syntheticJump(stateName, targetId) {
    return syntheticAssignment(stateName, numericLiteral(targetId));
}

function syntheticBranch(stateName, conditionName, onTrue, onFalse) {
    return syntheticAssignment(stateName, {
        type: "LogicalExpression",
        operator: "or",
        left: {
            type: "LogicalExpression",
            operator: "and",
            left: identifier(conditionName),
            right: numericLiteral(onTrue),
        },
        right: numericLiteral(onFalse),
    });
}

function cloneLeaves(leaves) {
    return new Map([...leaves].map(([id, body]) => [id, [...body]]));
}

function nearestDefinition(body, beforeIndex, name) {
    for (let i = beforeIndex - 1; i >= 0; i--) {
        const statement = body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0], name)) continue;
        return { index: i, statement, rhs: statement.init[0] };
    }
    return null;
}

function identifierOperands(node) {
    if (!node || !isIdentifier(node.left) || !isIdentifier(node.right)) return null;
    return [node.left.name, node.right.name];
}

function classifyAndValue(body, beforeIndex, name) {
    const andDef = nearestDefinition(body, beforeIndex, name);
    if (!andDef || andDef.rhs?.type !== "LogicalExpression" || andDef.rhs.operator !== "and") return null;
    const operands = identifierOperands(andDef.rhs);
    if (!operands) return null;

    let comparison = null;
    let polarity = null;
    const matched = new Set([andDef.index]);

    for (const operandName of operands) {
        const def = nearestDefinition(body, andDef.index, operandName);
        const rhs = def?.rhs;
        if (rhs?.type === "BinaryExpression" && (rhs.operator === "<=" || rhs.operator === ">=") &&
            isIdentifier(rhs.left) && isIdentifier(rhs.right)) {
            if (comparison) return null;
            comparison = {
                operator: rhs.operator,
                currentReg: rhs.left.name,
                finalReg: rhs.right.name,
            };
            matched.add(def.index);
            continue;
        }
        if (rhs?.type === "UnaryExpression" && rhs.operator === "not" && isIdentifier(rhs.argument)) {
            if (polarity) return null;
            polarity = { kind: "not", negFlagReg: rhs.argument.name };
            matched.add(def.index);
            continue;
        }
        // The compiler's negative-step flag is defined in the preheader and
        // remains live through the check block. It therefore has no reaching
        // definition inside this block.
        if (def) return null;
        if (polarity) return null;
        polarity = { kind: "direct", negFlagReg: operandName };
    }

    if (!comparison || !polarity) return null;
    if (comparison.operator === "<=" && polarity.kind !== "not") return null;
    if (comparison.operator === ">=" && polarity.kind !== "direct") return null;
    return {
        kind: comparison.operator === "<=" ? "nonnegative" : "negative",
        currentReg: comparison.currentReg,
        finalReg: comparison.finalReg,
        negFlagReg: polarity.negFlagReg,
        matched,
    };
}

function matchRawCompilerNumericForCheck(body, stateName, checkId) {
    if (!Array.isArray(body) || body.length < 8) return null;
    const stateWrites = [];
    for (let i = 0; i < body.length; i++) {
        if (isSingleAssignment(body[i], stateName)) stateWrites.push(i);
    }
    if (stateWrites.length !== 2) return null;
    const firstStateIndex = stateWrites[0];
    const finalStateIndex = stateWrites[1];
    if (finalStateIndex !== body.length - 1) return null;

    const firstState = body[firstStateIndex].init[0];
    if (firstState?.type !== "LogicalExpression" || firstState.operator !== "and" ||
        !isIdentifier(firstState.left) || !isIdentifier(firstState.right)) return null;
    const conditionReg = firstState.left.name;
    const bodyTargetReg = firstState.right.name;

    const finalState = body[finalStateIndex].init[0];
    if (finalState?.type !== "LogicalExpression" || finalState.operator !== "or" ||
        !isIdentifier(finalState.left, stateName) || !isIdentifier(finalState.right)) return null;
    const exitTargetReg = finalState.right.name;

    const bodyTargetDef = nearestDefinition(body, firstStateIndex, bodyTargetReg);
    const exitTargetDef = nearestDefinition(body, finalStateIndex, exitTargetReg);
    if (!bodyTargetDef || bodyTargetDef.rhs?.type !== "NumericLiteral" ||
        !exitTargetDef || exitTargetDef.rhs?.type !== "NumericLiteral") return null;
    const bodyId = Number(bodyTargetDef.rhs.value);
    const exitId = Number(exitTargetDef.rhs.value);
    if (!Number.isInteger(bodyId) || !Number.isInteger(exitId) || bodyId === exitId) return null;

    const orDef = nearestDefinition(body, firstStateIndex, conditionReg);
    if (!orDef || orDef.rhs?.type !== "LogicalExpression" || orDef.rhs.operator !== "or") return null;
    const orOperands = identifierOperands(orDef.rhs);
    if (!orOperands) return null;
    const leftAnd = classifyAndValue(body, orDef.index, orOperands[0]);
    const rightAnd = classifyAndValue(body, orDef.index, orOperands[1]);
    if (!leftAnd || !rightAnd || leftAnd.kind === rightAnd.kind) return null;
    const nonnegative = leftAnd.kind === "nonnegative" ? leftAnd : rightAnd;
    const negative = leftAnd.kind === "negative" ? leftAnd : rightAnd;
    if (nonnegative.currentReg !== negative.currentReg || nonnegative.finalReg !== negative.finalReg ||
        nonnegative.negFlagReg !== negative.negFlagReg) return null;

    const currentReg = nonnegative.currentReg;
    const finalReg = nonnegative.finalReg;
    const negFlagReg = nonnegative.negFlagReg;
    const currentAdd = nearestDefinition(body, Math.min(...[...nonnegative.matched, ...negative.matched]), currentReg) ||
        nearestDefinition(body, orDef.index, currentReg);
    if (!currentAdd || currentAdd.rhs?.type !== "BinaryExpression" || currentAdd.rhs.operator !== "+" ||
        !isIdentifier(currentAdd.rhs.left, currentReg) || !isIdentifier(currentAdd.rhs.right)) return null;
    const incrementReg = currentAdd.rhs.right.name;

    const matched = new Set([
        firstStateIndex,
        finalStateIndex,
        bodyTargetDef.index,
        exitTargetDef.index,
        orDef.index,
        currentAdd.index,
        ...nonnegative.matched,
        ...negative.matched,
    ]);
    if (matched.size !== body.length || [...matched].some(index => index < 0 || index >= body.length)) return null;

    return {
        checkId,
        bodyId,
        exitId,
        conditionReg,
        currentReg,
        finalReg,
        incrementReg,
        negFlagReg,
    };
}

function canonicalizeCompilerNumericForChecks(leaves, stateName) {
    if (!(leaves instanceof Map) || typeof stateName !== "string") return null;
    const signatures = new Map();
    for (const [id, body] of leaves) {
        const match = matchRawCompilerNumericForCheck(body, stateName, id);
        if (!match) continue;
        if (!leaves.has(match.bodyId) || !leaves.has(match.exitId)) return null;
        const conditionName = `__fresh_numeric_for_${id}_condition`;
        match.conditionName = conditionName;
        signatures.set(id, match);
        leaves.set(id, [
            syntheticAssignment(conditionName, identifier(`__fresh_numeric_for_${id}_final`)),
            syntheticBranch(stateName, conditionName, match.bodyId, match.exitId),
        ]);
    }
    return signatures;
}

function matchPreheaderSetup(block, raw) {
    if (!block || block.transition?.kind !== "jump" || block.transition.target !== raw.checkId) return null;
    const before = block.transitionIndex;
    const currentDef = nearestDefinition(block.body, before, raw.currentReg);
    if (!currentDef || currentDef.rhs?.type !== "BinaryExpression" || currentDef.rhs.operator !== "-" ||
        !isIdentifier(currentDef.rhs.left) || !isIdentifier(currentDef.rhs.right, raw.incrementReg)) return null;
    const initialSourceReg = currentDef.rhs.left.name;

    const negDef = nearestDefinition(block.body, before, raw.negFlagReg);
    if (!negDef || negDef.rhs?.type !== "BinaryExpression" || negDef.rhs.operator !== "<" ||
        !isIdentifier(negDef.rhs.left, raw.incrementReg) || !isIdentifier(negDef.rhs.right)) return null;
    const zeroReg = negDef.rhs.right.name;
    const zeroDef = nearestDefinition(block.body, negDef.index, zeroReg);
    if (!zeroDef || zeroDef.rhs?.type !== "NumericLiteral" || Number(zeroDef.rhs.value) !== 0) return null;

    const incrementDef = nearestDefinition(block.body, negDef.index, raw.incrementReg);
    if (!incrementDef || !isIdentifier(incrementDef.rhs)) return null;
    const incrementSourceReg = incrementDef.rhs.name;

    const finalDef = nearestDefinition(block.body, before, raw.finalReg);
    if (!finalDef || !isIdentifier(finalDef.rhs)) return null;
    const finalSourceReg = finalDef.rhs.name;

    const setupStatements = new Set([
        currentDef.statement,
        negDef.statement,
        zeroDef.statement,
        incrementDef.statement,
        finalDef.statement,
    ]);
    if (setupStatements.size !== 5) return null;

    const prefix = `__fresh_numeric_for_${raw.checkId}`;
    return {
        currentDef,
        negDef,
        zeroDef,
        incrementDef,
        finalDef,
        setupStatements,
        initialSourceReg,
        finalSourceReg,
        incrementSourceReg,
        initialCapture: `${prefix}_initial`,
        finalCapture: `${prefix}_final`,
        stepCapture: `${prefix}_step`,
    };
}

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
        } else if (value && typeof value === "object" && nodeReadsName(value, name)) return true;
    }
    return false;
}


function isAllocUpvalueCall(node) {
    return node?.type === "CallExpression" && isIdentifier(node.base, "allocUpvalue") && (node.arguments || []).length === 0;
}

function isReleaseUpvalueCallFor(statement, cellReg) {
    if (!isSingleAssignment(statement, cellReg)) return false;
    const rhs = statement.init[0];
    return rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue") &&
        (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0], cellReg);
}

function isCapturedCellWriteFrom(statement, cellReg, valueReg) {
    if (statement?.type !== "AssignmentStatement" || (statement.variables || []).length !== 1 || (statement.init || []).length !== 1) return false;
    const dest = statement.variables[0];
    return dest?.type === "IndexExpression" && isIdentifier(dest.base, "upvalueValues") &&
        isIdentifier(dest.index, cellReg) && isIdentifier(statement.init[0], valueReg);
}

function closureCapturesCell(statement, cellReg) {
    if (!isSingleAssignment(statement)) return false;
    const rhs = statement.init[0];
    if (rhs?.type !== "CallExpression" || !isIdentifier(rhs.base) || !/^createClosure\d*$/.test(rhs.base.name)) return false;
    const args = rhs.arguments || [];
    if (args.length !== 2 || args[1]?.type !== "TableConstructorExpression") return false;
    return (args[1].fields || []).some(field => field?.type === "TableValue" && isIdentifier(field.value, cellReg));
}

function matchLoopVariableHandoff(graph, loopInfo, raw) {
    const body = graph.blocks.get(raw.bodyId);
    if (!body) return null;
    const handoffs = [];
    for (let i = 0; i < body.transitionIndex; i++) {
        const statement = body.body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0]) || !isIdentifier(statement.init[0], raw.currentReg)) continue;
        const loopVarReg = statement.variables[0].name;
        if (!isVmRegisterName(loopVarReg) || loopVarReg === raw.currentReg) continue;
        handoffs.push({ kind: "register", statement, index: i, loopVarReg, loopVarCellReg: null, bookkeepingStatements: new Set([statement]) });
    }
    if (handoffs.length > 1) return null;
    if (handoffs.length === 1) {
        const handoff = handoffs[0];
        let cleanupCount = 0;
        for (const id of loopInfo.coreIds) {
            const block = graph.blocks.get(id);
            if (!block) return null;
            for (let i = 0; i < block.body.length; i++) {
                if (i === block.transitionIndex) continue;
                const statement = block.body[i];
                if (statement === handoff.statement) continue;
                if (isSingleAssignment(statement, handoff.loopVarReg) && statement.init[0]?.type === "NilLiteral") {
                    handoff.bookkeepingStatements.add(statement);
                    cleanupCount++;
                    continue;
                }
                if (nodeReadsName(statement, raw.currentReg)) return null;
            }
        }
        if (cleanupCount < 1) return null;
        return handoff;
    }

    // Captured numeric-for variables are lowered directly into a fresh upvalue
    // cell for each iteration instead of receiving an ordinary VAR-register
    // handoff. Prove the exact alloc -> current-value cell write -> closure
    // capture -> release bookkeeping before treating the cell as the source
    // loop-variable binding.
    const capturedCandidates = [];
    for (let initIndex = 0; initIndex < body.transitionIndex; initIndex++) {
        const initStatement = body.body[initIndex];
        const dest = initStatement?.variables?.[0];
        if (dest?.type !== "IndexExpression" || !isIdentifier(dest.base, "upvalueValues") || !isIdentifier(dest.index) ||
            !isIdentifier(initStatement.init?.[0], raw.currentReg)) continue;
        const cellReg = dest.index.name;
        let allocStatement = null;
        let captureCount = 0;
        for (let i = 0; i < body.transitionIndex; i++) {
            const statement = body.body[i];
            if (i < initIndex && isSingleAssignment(statement, cellReg) && isAllocUpvalueCall(statement.init[0])) allocStatement = statement;
            if (closureCapturesCell(statement, cellReg)) captureCount++;
        }
        if (!allocStatement || captureCount < 1) continue;
        const bookkeepingStatements = new Set([allocStatement, initStatement]);
        let releaseCount = 0;
        let invalidCurrentRead = false;
        for (const id of loopInfo.coreIds) {
            const blockInfo = graph.blocks.get(id);
            if (!blockInfo) return null;
            for (let i = 0; i < blockInfo.body.length; i++) {
                if (i === blockInfo.transitionIndex) continue;
                const statement = blockInfo.body[i];
                if (statement === initStatement) continue;
                if (isReleaseUpvalueCallFor(statement, cellReg)) {
                    bookkeepingStatements.add(statement);
                    releaseCount++;
                    continue;
                }
                if (nodeReadsName(statement, raw.currentReg)) invalidCurrentRead = true;
            }
        }
        if (invalidCurrentRead || releaseCount < 1) continue;
        capturedCandidates.push({
            kind: "captured-cell",
            statement: initStatement,
            index: initIndex,
            loopVarReg: null,
            loopVarCellReg: cellReg,
            bookkeepingStatements,
        });
    }
    return capturedCandidates.length === 1 ? capturedCandidates[0] : null;
}

function matchCompilerNumericForNaturalLoop(graph, loopInfo, raw, returnName = null) {
    if (!graph || !loopInfo?.coreIds?.size || !raw || loopInfo.headerId !== raw.checkId) return null;
    const coreIds = loopInfo.coreIds;
    if (!coreIds.has(raw.bodyId) || coreIds.has(raw.exitId)) return null;
    const header = graph.blocks.get(raw.checkId);
    if (!header || header.transition?.kind !== "branch" ||
        header.transition.onTrue !== raw.bodyId || header.transition.onFalse !== raw.exitId) return null;

    const outsideHeaderPreds = (graph.predecessors.get(raw.checkId) || []).filter(id => graph.reachable.has(id) && !coreIds.has(id));
    if (outsideHeaderPreds.length !== 1) return null;
    const preheaderId = outsideHeaderPreds[0];
    const preheader = graph.blocks.get(preheaderId);
    const setup = matchPreheaderSetup(preheader, raw);
    if (!setup) return null;

    const breakRegionIds = new Set();
    const breakTerminalIds = new Set();
    const terminalReturnRegionIds = new Set();
    for (const id of coreIds) {
        const block = graph.blocks.get(id);
        if (!block) return null;
        for (const target of transitionTargets(block.transition)) {
            if (coreIds.has(target)) continue;
            if (id === raw.checkId && target === raw.exitId) continue;
            const breakRegion = collectBreakRegion(graph, target, coreIds, raw.exitId);
            if (breakRegion) {
                for (const member of breakRegion.ids) breakRegionIds.add(member);
                for (const terminal of breakRegion.terminalIds) breakTerminalIds.add(terminal);
                continue;
            }
            const returnRegion = collectTerminalReturnRegion(graph, target, coreIds, returnName, raw.exitId);
            if (returnRegion) {
                for (const member of returnRegion.ids) terminalReturnRegionIds.add(member);
                continue;
            }
            const mixedAbruptRegion = collectMixedAbruptRegion(graph, target, coreIds, raw.exitId, returnName);
            if (!mixedAbruptRegion) return null;
            for (const member of mixedAbruptRegion.ids) breakRegionIds.add(member);
            for (const terminal of mixedAbruptRegion.breakTerminalIds) breakTerminalIds.add(terminal);
            for (const terminal of mixedAbruptRegion.returnTerminalIds) terminalReturnRegionIds.add(terminal);
        }
    }

    const handoff = matchLoopVariableHandoff(graph, loopInfo, raw);
    if (!handoff) return null;

    // The compiler may reuse the future source loop-variable register as the
    // TEMP that evaluates the numeric-for initial expression. If that exact
    // TEMP feeds only current = initial - step before the loop, keep evaluation
    // at its original statement position and remove the transport epoch.
    let initialTransportDef = null;
    if (handoff.loopVarReg && setup.initialSourceReg === handoff.loopVarReg) {
        const def = nearestDefinition(preheader.body, setup.currentDef.index, setup.initialSourceReg);
        if (!def || setup.setupStatements.has(def.statement)) return null;
        for (let i = def.index + 1; i < setup.currentDef.index; i++) {
            if (nodeReadsName(preheader.body[i], setup.initialSourceReg)) return null;
        }
        initialTransportDef = def;
    }

    return {
        ...raw,
        ...setup,
        coreIds,
        breakRegionIds,
        breakTerminalIds,
        terminalReturnRegionIds,
        preheaderId,
        headerId: raw.checkId,
        decisionId: raw.checkId,
        backedgeSources: new Set(loopInfo.backedgeSources),
        continueIds: new Set(loopInfo.backedgeSources),
        loopVarReg: handoff.loopVarReg,
        loopVarCellReg: handoff.loopVarCellReg,
        initialTransportDef,
        loopVarHandoffStatement: handoff.statement,
        loopVarBookkeepingStatements: handoff.bookkeepingStatements,
    };
}

function rewriteJumpTarget(leaves, graph, blockId, targetId) {
    const block = graph.blocks.get(blockId);
    const body = leaves.get(blockId);
    if (!block || !body || block.transition?.kind !== "jump" || block.transitionIndex < 0 || block.transitionIndex >= body.length) return false;
    const original = body[block.transitionIndex];
    if (!isSingleAssignment(original) || !isIdentifier(original.variables[0])) return false;
    const next = [...body];
    next[block.transitionIndex] = syntheticJump(original.variables[0].name, targetId);
    leaves.set(blockId, next);
    return true;
}

function applyCompilerNumericForMatch(transformed, graph, match, stateName, bodyJoinId, metadata) {
    if (!(transformed instanceof Map) || !graph || !match || !metadata || !Number.isInteger(bodyJoinId)) return false;
    const {
        numericForBranchIds,
        numericForMetaByBranchId,
        numericForBodyStarts,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        loopControlByBlockId,
    } = metadata;
    if (!(numericForBranchIds instanceof Set) || !(numericForMetaByBranchId instanceof Map) ||
        !(numericForBodyStarts instanceof Map) || !(loopBodyJoinIds instanceof Set) ||
        !(loopBackedgeCountsByJoin instanceof Map) || !(loopControlByBlockId instanceof Map)) return false;

    const preheaderBody = transformed.get(match.preheaderId);
    if (!Array.isArray(preheaderBody)) return false;
    const nextPreheader = [];
    for (const statement of preheaderBody) {
        if (match.initialTransportDef && statement === match.initialTransportDef.statement) {
            nextPreheader.push(syntheticAssignment(match.initialCapture, match.initialTransportDef.rhs));
            continue;
        }
        if (statement === match.finalDef.statement) {
            nextPreheader.push(syntheticAssignment(match.finalCapture, identifier(match.finalSourceReg)));
            continue;
        }
        if (statement === match.incrementDef.statement) {
            nextPreheader.push(syntheticAssignment(match.stepCapture, identifier(match.incrementSourceReg)));
            continue;
        }
        if (statement === match.currentDef.statement) {
            if (!match.initialTransportDef) {
                nextPreheader.push(syntheticAssignment(match.initialCapture, identifier(match.initialSourceReg)));
            }
            continue;
        }
        if (statement === match.zeroDef.statement || statement === match.negDef.statement) continue;
        nextPreheader.push(statement);
    }
    transformed.set(match.preheaderId, nextPreheader);

    const body = transformed.get(match.bodyId);
    if (!Array.isArray(body) || !body.includes(match.loopVarHandoffStatement) ||
        !(match.loopVarBookkeepingStatements instanceof Set)) return false;

    // Rewrite backedges while the graph's transition indexes still refer to
    // the unmodified loop-body arrays. Remove the compiler loop-variable
    // handoff only after those control edges are rewritten.
    for (const source of match.backedgeSources) {
        if (!rewriteJumpTarget(transformed, graph, source, bodyJoinId)) return false;
        loopControlByBlockId.set(source, "continue");
    }
    for (const source of match.breakTerminalIds || []) {
        if (!rewriteJumpTarget(transformed, graph, source, bodyJoinId)) return false;
        loopControlByBlockId.set(source, "break");
    }
    // Remove only the proven source-loop-variable compiler bookkeeping. For a
    // captured loop variable this includes its per-iteration cell allocation,
    // current-value initialization, and release(s); the closure capture itself
    // remains and resolves through the seeded source binding at body entry.
    const cleanupBlockIds = new Set([
        ...match.coreIds,
        ...(match.breakRegionIds || []),
        ...(match.terminalReturnRegionIds || []),
    ]);
    for (const blockId of cleanupBlockIds) {
        const blockBody = transformed.get(blockId);
        if (!Array.isArray(blockBody)) continue;
        transformed.set(blockId, blockBody.filter(statement => !match.loopVarBookkeepingStatements.has(statement)));
    }
    transformed.set(bodyJoinId, [syntheticJump(stateName, match.exitId)]);

    match.bodyJoinId = bodyJoinId;
    loopBodyJoinIds.add(bodyJoinId);
    loopBackedgeCountsByJoin.set(bodyJoinId, match.backedgeSources.size);
    numericForBranchIds.add(match.decisionId);
    numericForMetaByBranchId.set(match.decisionId, match);
    numericForBodyStarts.set(match.bodyId, match);
    return true;
}

function collapseCompilerNumericForLoops(leaves, entryId, stateName, returnName = null) {
    if (!(leaves instanceof Map) || !Number.isInteger(entryId) || typeof stateName !== "string") return null;
    const transformed = cloneLeaves(leaves);
    const signatures = canonicalizeCompilerNumericForChecks(transformed, stateName);
    if (!signatures || signatures.size === 0) return null;
    const graph = createStateGraph(transformed, entryId, stateName);
    if (!graph) return null;
    const natural = findNaturalLoops(graph);
    if (!natural || !natural.loops.length || !loopsAreNestedOrDisjoint(natural.loops)) return null;

    const matches = [];
    for (const loopInfo of natural.loops) {
        const raw = signatures.get(loopInfo.headerId);
        if (!raw) return null;
        const match = matchCompilerNumericForNaturalLoop(graph, loopInfo, raw, returnName);
        if (!match) return null;
        matches.push(match);
    }

    const numericForBranchIds = new Set();
    const numericForMetaByBranchId = new Map();
    const numericForBodyStarts = new Map();
    const loopBodyJoinIds = new Set();
    const loopBackedgeCountsByJoin = new Map();
    const loopControlByBlockId = new Map();
    let nextSyntheticId = -1;
    while (transformed.has(nextSyntheticId)) nextSyntheticId--;
    for (const match of [...matches].sort((a, b) => a.coreIds.size - b.coreIds.size)) {
        const bodyJoinId = nextSyntheticId--;
        if (!applyCompilerNumericForMatch(transformed, graph, match, stateName, bodyJoinId, {
            numericForBranchIds,
            numericForMetaByBranchId,
            numericForBodyStarts,
            loopBodyJoinIds,
            loopBackedgeCountsByJoin,
            loopControlByBlockId,
        })) return null;
    }
    return {
        leaves: transformed,
        matches,
        numericForBranchIds,
        numericForMetaByBranchId,
        numericForBodyStarts,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        loopControlByBlockId,
    };
}

module.exports = {
    applyCompilerNumericForMatch,
    canonicalizeCompilerNumericForChecks,
    collapseCompilerNumericForLoops,
    matchCompilerNumericForNaturalLoop,
    matchRawCompilerNumericForCheck,
};
