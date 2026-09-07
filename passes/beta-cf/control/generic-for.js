"use strict";

const { isIdentifier, isLuaIdentifier, isSingleAssignment, isVmRegisterName } = require("../ast");
const { createStateGraph } = require("../cfg");
const {
    collectBreakRegion,
    collectMixedAbruptRegion,
    collectTerminalReturnRegion,
    findNaturalLoops,
    loopsAreNestedOrDisjoint,
} = require("./while");

function identifier(name) {
    return { type: "Identifier", name };
}

function numericLiteral(value) {
    return { type: "NumericLiteral", value, raw: String(value) };
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

function transitionTargets(transition) {
    if (transition?.kind === "jump") return [transition.target];
    if (transition?.kind === "branch") return [transition.onTrue, transition.onFalse];
    return [];
}

function statementWritesName(statement, name) {
    if (statement?.type !== "AssignmentStatement") return false;
    return (statement.variables || []).some(variable => isIdentifier(variable, name));
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

function collectIdentifierReads(node, out = new Set()) {
    if (!node || typeof node !== "object") return out;
    if (isIdentifier(node)) { out.add(node.name); return out; }
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            for (const item of value) collectIdentifierReads(item, out);
        } else if (value && typeof value === "object") {
            collectIdentifierReads(value, out);
        }
    }
    return out;
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

function nearestDefinition(body, beforeIndex, name) {
    for (let i = beforeIndex - 1; i >= 0; i--) {
        const statement = body[i];
        if (!statementWritesName(statement, name)) continue;
        if (!isSingleAssignment(statement, name)) return { index: i, statement, ambiguous: true };
        return { index: i, statement, rhs: statement.init[0], ambiguous: false };
    }
    return null;
}

function collectCleanupRegs(graph) {
    const cleanup = new Set();
    for (const id of graph.reachable) {
        const block = graph.blocks.get(id);
        for (const statement of block?.body || []) {
            if (!isSingleAssignment(statement) || statement.init[0]?.type !== "NilLiteral") continue;
            const dest = statement.variables[0];
            if (isIdentifier(dest) && isVmRegisterName(dest.name)) cleanup.add(dest.name);
        }
    }
    return cleanup;
}

function literalString(node) {
    if (node?.type !== "StringLiteral") return null;
    if (typeof node.value === "string") return node.value;
    if (typeof node.raw !== "string") return null;
    try {
        const parsed = JSON.parse(node.raw);
        return typeof parsed === "string" ? parsed : null;
    } catch {
        return null;
    }
}

function makeTracer(body, boundaryRegs, forcedTraceRegs) {
    const memo = new Map();

    function external(name) {
        return { kind: "expr", expression: identifier(name), consumed: new Set(), rootIndex: -1 };
    }

    function mergeConsumed(...values) {
        const out = new Set();
        for (const value of values) for (const index of value?.consumed || []) out.add(index);
        return out;
    }

    function traceReg(name, beforeIndex, stack = new Set()) {
        const memoKey = `${name}:${beforeIndex}`;
        if (memo.has(memoKey)) return memo.get(memoKey);
        if (stack.has(memoKey)) return null;
        if (boundaryRegs.has(name) && !forcedTraceRegs.has(name)) return external(name);
        const def = nearestDefinition(body, beforeIndex, name);
        if (!def) return external(name);
        if (def.ambiguous) return null;
        const nextStack = new Set(stack);
        nextStack.add(memoKey);
        const value = traceNode(def.rhs, def.index, nextStack);
        if (!value) return null;
        value.consumed.add(def.index);
        value.rootIndex = Math.max(value.rootIndex ?? -1, def.index);
        if (value.kind === "pack" && typeof value.packKey !== "string") value.packKey = `${name}@${def.index}`;
        memo.set(memoKey, value);
        return value;
    }

    function traceMethodCall(node, beforeIndex, stack) {
        if (!isIdentifier(node?.base) || (node.arguments || []).length < 1 || !isIdentifier(node.arguments[0])) return null;
        const calleeDef = nearestDefinition(body, beforeIndex, node.base.name);
        if (!calleeDef || calleeDef.ambiguous || calleeDef.rhs?.type !== "IndexExpression" ||
            !isIdentifier(calleeDef.rhs.base, node.arguments[0].name)) return null;
        const keyNode = calleeDef.rhs.index;
        let memberName = null;
        const consumed = new Set([calleeDef.index]);
        if (keyNode?.type === "StringLiteral") {
            memberName = literalString(keyNode);
        } else if (isIdentifier(keyNode)) {
            const keyValue = traceReg(keyNode.name, calleeDef.index, stack);
            if (!keyValue || keyValue.kind !== "expr" || keyValue.expression?.type !== "StringLiteral") return null;
            memberName = literalString(keyValue.expression);
            for (const index of keyValue.consumed) consumed.add(index);
        }
        if (!isLuaIdentifier(memberName)) return null;
        const receiver = traceReg(node.arguments[0].name, calleeDef.index, stack);
        if (!receiver || receiver.kind !== "expr") return null;
        for (const index of receiver.consumed) consumed.add(index);
        const args = [];
        for (const arg of (node.arguments || []).slice(1)) {
            const value = traceNode(arg, beforeIndex, stack);
            if (!value || value.kind !== "expr") return null;
            args.push(value.expression);
            for (const index of value.consumed) consumed.add(index);
        }
        return {
            kind: "expr",
            expression: {
                type: "FreshGenericMethodCallExpression",
                receiver: receiver.expression,
                member: memberName,
                arguments: args,
            },
            consumed,
            rootIndex: Math.max(calleeDef.index, receiver.rootIndex ?? -1),
        };
    }

    function traceNode(node, beforeIndex, stack) {
        if (!node || typeof node !== "object") return null;
        if (["StringLiteral", "NumericLiteral", "BooleanLiteral", "NilLiteral"].includes(node.type)) {
            return { kind: "expr", expression: node, consumed: new Set(), rootIndex: -1 };
        }
        if (isIdentifier(node)) return traceReg(node.name, beforeIndex, stack);
        if (node.type === "UnaryExpression") {
            const argument = traceNode(node.argument, beforeIndex, stack);
            if (!argument || argument.kind !== "expr") return null;
            return {
                kind: "expr",
                expression: { ...node, argument: argument.expression },
                consumed: mergeConsumed(argument),
                rootIndex: argument.rootIndex ?? -1,
            };
        }
        if (node.type === "BinaryExpression" || node.type === "LogicalExpression") {
            const left = traceNode(node.left, beforeIndex, stack);
            const right = traceNode(node.right, beforeIndex, stack);
            if (!left || !right || left.kind !== "expr" || right.kind !== "expr") return null;
            return {
                kind: "expr",
                expression: { ...node, left: left.expression, right: right.expression, freshCompilerLogical: node.type === "LogicalExpression" ? true : node.freshCompilerLogical },
                consumed: mergeConsumed(left, right),
                rootIndex: Math.max(left.rootIndex ?? -1, right.rootIndex ?? -1),
            };
        }
        if (node.type === "TableConstructorExpression") {
            const fields = node.fields || [];
            if (fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression") {
                const call = traceNode(fields[0].value, beforeIndex, stack);
                if (!call || call.kind !== "expr") return null;
                return { kind: "pack", expression: call.expression, consumed: mergeConsumed(call), rootIndex: call.rootIndex ?? -1 };
            }
            const nextFields = [];
            const parts = [];
            for (const field of fields) {
                if (field?.type === "TableValue") {
                    const value = traceNode(field.value, beforeIndex, stack);
                    if (!value || value.kind !== "expr") return null;
                    nextFields.push({ ...field, value: value.expression });
                    parts.push(value);
                } else if (field?.type === "TableKey") {
                    const key = traceNode(field.key, beforeIndex, stack);
                    const value = traceNode(field.value, beforeIndex, stack);
                    if (!key || !value || key.kind !== "expr" || value.kind !== "expr") return null;
                    nextFields.push({ ...field, key: key.expression, value: value.expression });
                    parts.push(key, value);
                } else return null;
            }
            return {
                kind: "expr",
                expression: { ...node, fields: nextFields },
                consumed: mergeConsumed(...parts),
                rootIndex: Math.max(-1, ...parts.map(part => part.rootIndex ?? -1)),
            };
        }
        if (node.type === "IndexExpression") {
            const base = traceNode(node.base, beforeIndex, stack);
            if (!base) return null;
            if (base.kind === "pack" && node.index?.type === "NumericLiteral") {
                const slot = Number(node.index.value);
                if (!Number.isInteger(slot) || slot < 1) return null;
                return {
                    kind: "slot",
                    pack: base,
                    slot,
                    consumed: mergeConsumed(base),
                    rootIndex: base.rootIndex ?? -1,
                };
            }
            if (base.kind !== "expr") return null;
            const index = traceNode(node.index, beforeIndex, stack);
            if (!index || index.kind !== "expr") return null;
            return {
                kind: "expr",
                expression: { ...node, base: base.expression, index: index.expression },
                consumed: mergeConsumed(base, index),
                rootIndex: Math.max(base.rootIndex ?? -1, index.rootIndex ?? -1),
            };
        }
        if (node.type === "CallExpression") {
            if (isIdentifier(node.base, "unpack") && (node.arguments || []).length === 1 && isIdentifier(node.arguments[0])) {
                const packed = traceReg(node.arguments[0].name, beforeIndex, stack);
                if (packed?.kind === "pack") {
                    return {
                        kind: "expr",
                        expression: packed.expression,
                        consumed: mergeConsumed(packed),
                        rootIndex: packed.rootIndex ?? -1,
                    };
                }
            }
            const method = traceMethodCall(node, beforeIndex, stack);
            if (method) return method;
            const base = traceNode(node.base, beforeIndex, stack);
            if (!base || base.kind !== "expr") return null;
            const args = [];
            const parts = [base];
            for (const arg of node.arguments || []) {
                const value = traceNode(arg, beforeIndex, stack);
                if (!value || value.kind !== "expr") return null;
                args.push(value.expression);
                parts.push(value);
            }
            return {
                kind: "expr",
                expression: { ...node, base: base.expression, arguments: args },
                consumed: mergeConsumed(...parts),
                rootIndex: Math.max(...parts.map(part => part.rootIndex ?? -1)),
            };
        }
        return null;
    }

    return { traceReg };
}

function samePackSlot(value, pack, slot) {
    return value?.kind === "slot" && typeof value.pack?.packKey === "string" &&
        value.pack.packKey === pack?.packKey && value.slot === slot;
}

function inferHeaderExpressions(iteratorValue, invariantValue, controlValue) {
    if (!iteratorValue || !invariantValue || !controlValue) return null;
    if (iteratorValue.kind === "slot" && iteratorValue.slot === 1) {
        const pack = iteratorValue.pack;
        if (samePackSlot(invariantValue, pack, 2) && samePackSlot(controlValue, pack, 3)) {
            return [{ expression: pack.expression, values: [iteratorValue, invariantValue, controlValue] }];
        }
    }
    if (invariantValue.kind === "slot" && invariantValue.slot === 1) {
        const pack = invariantValue.pack;
        if (samePackSlot(controlValue, pack, 2) && iteratorValue.kind === "expr") {
            return [
                { expression: iteratorValue.expression, values: [iteratorValue] },
                { expression: pack.expression, values: [invariantValue, controlValue] },
            ];
        }
    }
    if (iteratorValue.kind !== "expr" || invariantValue.kind !== "expr" || controlValue.kind !== "expr") return null;
    if (controlValue.expression?.type === "NilLiteral") {
        return [
            { expression: iteratorValue.expression, values: [iteratorValue] },
            { expression: invariantValue.expression, values: [invariantValue, controlValue] },
        ];
    }
    return [
        { expression: iteratorValue.expression, values: [iteratorValue] },
        { expression: invariantValue.expression, values: [invariantValue] },
        { expression: controlValue.expression, values: [controlValue] },
    ];
}

function matchCompilerGenericForCheck(block) {
    if (!block || block.transition?.kind !== "branch" || block.transitionIndex !== 1) return null;
    const statement = block.body[0];
    if (statement?.type !== "AssignmentStatement" || (statement.init || []).length !== 1) return null;
    const variables = (statement.variables || []).filter(Boolean);
    if (variables.length < 1 || variables.length > 2 || variables.some(variable => !isIdentifier(variable))) return null;
    const call = statement.init[0];
    if (call?.type !== "CallExpression" || !isIdentifier(call.base) || (call.arguments || []).length !== 2 ||
        !isIdentifier(call.arguments[0]) || !isIdentifier(call.arguments[1])) return null;
    const controlReg = variables[0].name;
    if (block.transition.conditionRegister !== controlReg || call.arguments[1].name !== controlReg) return null;
    const iteratorReg = call.base.name;
    const invariantReg = call.arguments[0].name;
    if (![iteratorReg, invariantReg, controlReg].every(isVmRegisterName)) return null;
    const secondVarReg = variables[1]?.name || null;
    if (secondVarReg !== null && (!isVmRegisterName(secondVarReg) || secondVarReg === controlReg)) return null;
    return {
        checkId: block.id,
        decisionId: block.id,
        bodyId: block.transition.onTrue,
        exitId: block.transition.onFalse,
        iteratorReg,
        invariantReg,
        controlReg,
        secondVarReg,
        checkStatement: statement,
    };
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

function closureCapturesCell(statement, cellReg) {
    if (!isSingleAssignment(statement)) return false;
    const rhs = statement.init[0];
    if (rhs?.type !== "CallExpression" || !isIdentifier(rhs.base) || !/^createClosure\d*$/.test(rhs.base.name)) return false;
    const args = rhs.arguments || [];
    if (args.length !== 2 || args[1]?.type !== "TableConstructorExpression") return false;
    return (args[1].fields || []).some(field => field?.type === "TableValue" && isIdentifier(field.value, cellReg));
}

function matchCapturedLoopVariable(graph, loopInfo, body, varReg) {
    const candidates = [];
    for (let initIndex = 0; initIndex < body.transitionIndex; initIndex++) {
        const initStatement = body.body[initIndex];
        const dest = initStatement?.variables?.[0];
        if (dest?.type !== "IndexExpression" || !isIdentifier(dest.base, "upvalueValues") || !isIdentifier(dest.index) ||
            !isIdentifier(initStatement.init?.[0], varReg)) continue;
        const allocCellReg = dest.index.name;
        if (!isVmRegisterName(allocCellReg) || allocCellReg === varReg) continue;
        const allocDef = nearestDefinition(body.body, initIndex, allocCellReg);
        if (!allocDef || allocDef.ambiguous || !isAllocUpvalueCall(allocDef.rhs)) continue;

        let handoffStatement = null;
        let handoffIndex = -1;
        let invalid = false;
        for (let i = initIndex + 1; i < body.transitionIndex; i++) {
            const statement = body.body[i];
            if (statementWritesName(statement, allocCellReg) && !isSingleAssignment(statement, varReg)) {
                invalid = true;
                break;
            }
            if (!statementWritesName(statement, varReg)) continue;
            if (isSingleAssignment(statement, varReg) && isIdentifier(statement.init[0], allocCellReg) && handoffStatement === null) {
                handoffStatement = statement;
                handoffIndex = i;
                break;
            }
            invalid = true;
            break;
        }
        if (invalid || !handoffStatement) continue;

        const bookkeepingStatements = new Set([allocDef.statement, initStatement, handoffStatement]);
        let captureCount = 0;
        let releaseCount = 0;
        for (const id of loopInfo.coreIds) {
            const blockInfo = graph.blocks.get(id);
            if (!blockInfo) return null;
            for (let i = 0; i < blockInfo.body.length; i++) {
                if (i === blockInfo.transitionIndex) continue;
                const statement = blockInfo.body[i];
                if (closureCapturesCell(statement, varReg)) captureCount++;
                if (isReleaseUpvalueCallFor(statement, varReg)) {
                    bookkeepingStatements.add(statement);
                    releaseCount++;
                }
            }
        }
        if (captureCount < 1 || releaseCount < 1) continue;
        candidates.push({
            kind: "captured-cell",
            reg: varReg,
            handleReg: varReg,
            allocationCellReg: allocCellReg,
            initStatement,
            handoffStatement,
            handoffIndex,
            bookkeepingStatements,
        });
    }
    return candidates.length === 1 ? candidates[0] : null;
}

function loopValueReadBeforeOverwrite(graph, loopInfo, startBlockId, startIndex, name) {
    const queue = [{ blockId: startBlockId, index: startIndex + 1 }];
    const seen = new Set();
    while (queue.length) {
        const cursor = queue.shift();
        const key = cursor.blockId + ":" + cursor.index;
        if (seen.has(key)) continue;
        seen.add(key);
        const block = graph.blocks.get(cursor.blockId);
        if (!block) return true;
        let killed = false;
        for (let i = cursor.index; i < block.body.length; i++) {
            const statement = block.body[i];
            if (statementReadsName(statement, name)) return true;
            if (statementWritesName(statement, name)) { killed = true; break; }
        }
        if (killed) continue;
        for (const next of graph.successors.get(cursor.blockId) || []) {
            if (!loopInfo.coreIds.has(next)) continue;
            queue.push({ blockId: next, index: 0 });
        }
    }
    return false;
}

function matchBodyVariables(graph, loopInfo, raw) {
    const body = graph.blocks.get(raw.bodyId);
    if (!body) return null;
    const firstHandoffs = [];
    for (let i = 0; i < body.body.length; i++) {
        if (i === body.transitionIndex) continue;
        const statement = body.body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0]) || !isIdentifier(statement.init[0], raw.controlReg)) continue;
        const name = statement.variables[0].name;
        if (!isVmRegisterName(name) || name === raw.controlReg) continue;
        firstHandoffs.push({ statement, index: i, name });
    }
    if (firstHandoffs.length !== 1) return null;
    const first = firstHandoffs[0];
    const loopVarRegs = [first.name];
    if (raw.secondVarReg !== null) loopVarRegs.push(raw.secondVarReg);
    if (new Set(loopVarRegs).size !== loopVarRegs.length) return null;

    const loopVarBookkeepingStatements = new Set([first.statement]);
    const loopVarBindings = [];
    for (const name of loopVarRegs) {
        const captured = matchCapturedLoopVariable(graph, loopInfo, body, name);
        if (captured) {
            loopVarBindings.push(captured);
            for (const statement of captured.bookkeepingStatements) loopVarBookkeepingStatements.add(statement);
            continue;
        }
        let cleanupCount = 0;
        const bookkeepingStatements = new Set();
        for (const id of loopInfo.coreIds) {
            const blockInfo = graph.blocks.get(id);
            if (!blockInfo) return null;
            for (let i = 0; i < blockInfo.body.length; i++) {
                if (i === blockInfo.transitionIndex) continue;
                const statement = blockInfo.body[i];
                if (isSingleAssignment(statement, name) && statement.init[0]?.type === "NilLiteral") {
                    cleanupCount++;
                    bookkeepingStatements.add(statement);
                }
                if (isReleaseUpvalueCallFor(statement, name)) return null;
            }
        }
        if (cleanupCount < 1) return null;
        loopVarBindings.push({ kind: "register", reg: name, bookkeepingStatements });
        for (const statement of bookkeepingStatements) loopVarBookkeepingStatements.add(statement);
    }

    // Prometheus only assigns the first two generic-for variables in the
    // iterator call. Variables 3+ are injected as semantic nil writes at body
    // entry, which is indistinguishable from a real source local initialized to
    // nil. If such a non-loop register nil is observed before overwrite, fail
    // closed instead of guessing a wider generic-for header or a body local.
    for (let i = 0; i < body.body.length; i++) {
        if (i === body.transitionIndex) continue;
        const statement = body.body[i];
        if (loopVarBookkeepingStatements.has(statement) || statement === raw.checkStatement) continue;
        if (!isSingleAssignment(statement) || statement.init[0]?.type !== "NilLiteral" || !isIdentifier(statement.variables[0])) continue;
        const name = statement.variables[0].name;
        if (loopVarRegs.includes(name)) continue;
        if (loopValueReadBeforeOverwrite(graph, loopInfo, raw.bodyId, i, name)) return null;
    }

    for (const id of loopInfo.coreIds) {
        const blockInfo = graph.blocks.get(id);
        if (!blockInfo) return null;
        for (let i = 0; i < blockInfo.body.length; i++) {
            if (i === blockInfo.transitionIndex) continue;
            const statement = blockInfo.body[i];
            if (loopVarBookkeepingStatements.has(statement) || statement === raw.checkStatement) continue;
            if (nodeReadsName(statement, raw.iteratorReg) || nodeReadsName(statement, raw.invariantReg) ||
                (id !== raw.checkId && nodeReadsName(statement, raw.controlReg))) return null;
        }
    }
    return {
        firstVarReg: first.name,
        firstHandoffStatement: first.statement,
        loopVarRegs,
        loopVarBindings,
        loopVarBookkeepingStatements,
    };
}

function matchPreheaderHeader(graph, preheaderId, raw, preBodyTempRegs = new Set()) {
    const block = graph.blocks.get(preheaderId);
    if (!block || block.transition?.kind !== "jump" || block.transition.target !== raw.checkId) return null;
    const cleanupRegs = collectCleanupRegs(graph);
    cleanupRegs.delete(raw.iteratorReg);
    cleanupRegs.delete(raw.invariantReg);
    cleanupRegs.delete(raw.controlReg);
    const transitionStatement = block.body[block.transitionIndex];
    const stateReg = isSingleAssignment(transitionStatement) && isIdentifier(transitionStatement.variables[0])
        ? transitionStatement.variables[0].name : null;
    const forced = new Set([raw.iteratorReg, raw.invariantReg, raw.controlReg, ...preBodyTempRegs]);
    if (typeof stateReg === "string") forced.add(stateReg);
    const tracer = makeTracer(block.body, cleanupRegs, forced);
    const iteratorValue = tracer.traceReg(raw.iteratorReg, block.transitionIndex);
    const invariantValue = tracer.traceReg(raw.invariantReg, block.transitionIndex);
    const controlValue = tracer.traceReg(raw.controlReg, block.transitionIndex);
    const inferred = inferHeaderExpressions(iteratorValue, invariantValue, controlValue);
    if (!inferred || inferred.length < 1 || inferred.length > 3) return null;

    const consumed = new Set();
    for (const item of inferred) for (const value of item.values) for (const index of value.consumed || []) consumed.add(index);
    if (!consumed.size) return null;
    const consumedNames = new Set();
    for (const index of consumed) {
        if (index < 0 || index >= block.transitionIndex) return null;
        const statement = block.body[index];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) return null;
        consumedNames.add(statement.variables[0].name);
    }
    for (let i = 0; i < block.transitionIndex; i++) {
        if (consumed.has(i)) continue;
        const statement = block.body[i];
        for (const name of consumedNames) {
            if (!statementReadsName(statement, name)) continue;
            const reaching = nearestDefinition(block.body, i, name);
            if (reaching && consumed.has(reaching.index)) return null;
        }
    }

    const capturePrefix = `__fresh_generic_for_${raw.checkId}`;
    const captures = inferred.map((item, index) => {
        const itemConsumed = new Set();
        for (const value of item.values || []) {
            for (const statementIndex of value.consumed || []) itemConsumed.add(statementIndex);
        }
        if (!itemConsumed.size) return null;
        let insertionIndex = Math.min(...itemConsumed);
        // Some registers inside the traced header expression are intentionally
        // left external because they are proven source storage (or are not safe
        // to inline). If such a value is defined in this preheader, the synthetic
        // header capture must stay after that reaching definition. Otherwise loop
        // collapse can move the expression before its dependency and make an old
        // physical-register epoch appear live across an earlier branch join.
        const evaluationEnd = Math.max(...[...itemConsumed, ...(item.values || []).map(value => value.rootIndex ?? -1)]) + 1;
        for (const name of collectIdentifierReads(item.expression)) {
            const reaching = nearestDefinition(block.body, evaluationEnd, name);
            if (!reaching || reaching.ambiguous || itemConsumed.has(reaching.index)) continue;
            insertionIndex = Math.max(insertionIndex, reaching.index + 1);
        }
        return {
            name: `${capturePrefix}_expr_${index + 1}`,
            expression: item.expression,
            insertionIndex,
        };
    });
    if (captures.some(capture => capture === null)) return null;
    return { consumed, captures };
}

function matchCompilerGenericForNaturalLoop(graph, loopInfo, returnName = null) {
    if (!graph || !loopInfo?.coreIds?.size || !loopInfo.backedgeSources?.size) return null;
    const raw = matchCompilerGenericForCheck(graph.blocks.get(loopInfo.headerId));
    if (!raw) return null;
    if (!loopInfo.coreIds.has(raw.bodyId) || loopInfo.coreIds.has(raw.exitId) || !graph.blocks.has(raw.exitId)) return null;
    const outsideHeaderPreds = (graph.predecessors.get(raw.checkId) || []).filter(id => graph.reachable.has(id) && !loopInfo.coreIds.has(id));
    if (outsideHeaderPreds.length !== 1) return null;
    const preheaderId = outsideHeaderPreds[0];
    const variables = matchBodyVariables(graph, loopInfo, raw);
    if (!variables) return null;
    const header = matchPreheaderHeader(graph, preheaderId, raw, new Set(variables.loopVarRegs));
    if (!header) return null;

    const breakRegionIds = new Set();
    const breakTerminalIds = new Set();
    const terminalReturnRegionIds = new Set();
    for (const id of loopInfo.coreIds) {
        const block = graph.blocks.get(id);
        if (!block) return null;
        for (const target of transitionTargets(block.transition)) {
            if (loopInfo.coreIds.has(target)) continue;
            if (id === raw.checkId && target === raw.exitId) continue;
            const breakRegion = collectBreakRegion(graph, target, loopInfo.coreIds, raw.exitId);
            if (breakRegion) {
                for (const member of breakRegion.ids) breakRegionIds.add(member);
                for (const terminal of breakRegion.terminalIds) breakTerminalIds.add(terminal);
                continue;
            }
            const returnRegion = collectTerminalReturnRegion(graph, target, loopInfo.coreIds, returnName, raw.exitId);
            if (returnRegion) {
                for (const member of returnRegion.ids) terminalReturnRegionIds.add(member);
                continue;
            }
            const mixed = collectMixedAbruptRegion(graph, target, loopInfo.coreIds, raw.exitId, returnName);
            if (!mixed) return null;
            for (const member of mixed.ids) breakRegionIds.add(member);
            for (const terminal of mixed.breakTerminalIds) breakTerminalIds.add(terminal);
            for (const terminal of mixed.returnTerminalIds) terminalReturnRegionIds.add(terminal);
        }
    }

    return {
        ...raw,
        ...header,
        ...variables,
        coreIds: loopInfo.coreIds,
        preheaderId,
        headerId: raw.checkId,
        backedgeSources: new Set(loopInfo.backedgeSources),
        continueIds: new Set(loopInfo.backedgeSources),
        breakRegionIds,
        breakTerminalIds,
        terminalReturnRegionIds,
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

function applyCompilerGenericForMatch(transformed, graph, match, stateName, bodyJoinId, metadata) {
    if (!(transformed instanceof Map) || !graph || !match || !Number.isInteger(bodyJoinId) || !metadata) return false;
    const {
        genericForBranchIds,
        genericForMetaByBranchId,
        genericForBodyStarts,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        loopControlByBlockId,
    } = metadata;
    if (!(genericForBranchIds instanceof Set) || !(genericForMetaByBranchId instanceof Map) ||
        !(genericForBodyStarts instanceof Map) || !(loopBodyJoinIds instanceof Set) ||
        !(loopBackedgeCountsByJoin instanceof Map) || !(loopControlByBlockId instanceof Map)) return false;

    const preheaderBody = transformed.get(match.preheaderId);
    if (!Array.isArray(preheaderBody)) return false;
    const capturesByInsertion = new Map();
    for (const capture of match.captures) {
        if (!Number.isInteger(capture.insertionIndex) || capture.insertionIndex < 0 || capture.insertionIndex >= preheaderBody.length) return false;
        if (!capturesByInsertion.has(capture.insertionIndex)) capturesByInsertion.set(capture.insertionIndex, []);
        capturesByInsertion.get(capture.insertionIndex).push(capture);
    }
    const nextPreheader = [];
    for (let i = 0; i < preheaderBody.length; i++) {
        for (const capture of capturesByInsertion.get(i) || []) {
            nextPreheader.push(syntheticAssignment(capture.name, {
                type: "FreshGenericForExpression",
                expression: capture.expression,
            }));
        }
        if (match.consumed.has(i)) continue;
        nextPreheader.push(preheaderBody[i]);
    }
    transformed.set(match.preheaderId, nextPreheader);

    // Rewrite original backedges before mutating body/check arrays because the
    // graph transition indexes refer to those original arrays.
    for (const source of match.backedgeSources) {
        if (!rewriteJumpTarget(transformed, graph, source, bodyJoinId)) return false;
        loopControlByBlockId.set(source, "continue");
    }
    for (const source of match.breakTerminalIds || []) {
        if (!rewriteJumpTarget(transformed, graph, source, bodyJoinId)) return false;
        loopControlByBlockId.set(source, "break");
    }

    const body = transformed.get(match.bodyId);
    if (!Array.isArray(body) || !body.includes(match.firstHandoffStatement) || !(match.loopVarBookkeepingStatements instanceof Set)) return false;
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

    const conditionName = `__fresh_generic_for_${match.checkId}_condition`;
    match.conditionName = conditionName;
    const checkBody = transformed.get(match.checkId);
    if (!Array.isArray(checkBody) || !checkBody.includes(match.checkStatement)) return false;
    const transition = checkBody.find(statement => isSingleAssignment(statement, stateName));
    if (!transition) return false;
    transformed.set(match.checkId, [
        syntheticAssignment(conditionName, identifier(match.captures[0].name)),
        syntheticBranch(stateName, conditionName, match.bodyId, match.exitId),
    ]);

    transformed.set(bodyJoinId, [syntheticJump(stateName, match.exitId)]);
    match.bodyJoinId = bodyJoinId;
    loopBodyJoinIds.add(bodyJoinId);
    loopBackedgeCountsByJoin.set(bodyJoinId, match.backedgeSources.size);
    genericForBranchIds.add(match.decisionId);
    genericForMetaByBranchId.set(match.decisionId, match);
    genericForBodyStarts.set(match.bodyId, match);
    return true;
}

function collapseCompilerGenericForLoops(leaves, entryId, stateName, returnName = null) {
    if (!(leaves instanceof Map) || !Number.isInteger(entryId) || typeof stateName !== "string") return null;
    const transformed = cloneLeaves(leaves);
    const genericForBranchIds = new Set();
    const genericForMetaByBranchId = new Map();
    const genericForBodyStarts = new Map();
    const loopBodyJoinIds = new Set();
    const loopBackedgeCountsByJoin = new Map();
    const loopControlByBlockId = new Map();
    const matches = [];
    let nextSyntheticId = -1;
    while (transformed.has(nextSyntheticId)) nextSyntheticId--;
    let rounds = 0;
    while (true) {
        if (rounds++ > leaves.size * 3 + 16) return null;
        const graph = createStateGraph(transformed, entryId, stateName);
        if (!graph) return null;
        const natural = findNaturalLoops(graph);
        if (!natural || !loopsAreNestedOrDisjoint(natural.loops)) return null;
        if (!natural.loops.length) break;
        const ordered = [...natural.loops].sort((a, b) => a.coreIds.size - b.coreIds.size || a.headerId - b.headerId);
        let applied = false;
        for (const loopInfo of ordered) {
            const match = matchCompilerGenericForNaturalLoop(graph, loopInfo, returnName);
            if (!match) continue;
            const bodyJoinId = nextSyntheticId--;
            while (transformed.has(nextSyntheticId)) nextSyntheticId--;
            if (!applyCompilerGenericForMatch(transformed, graph, match, stateName, bodyJoinId, {
                genericForBranchIds,
                genericForMetaByBranchId,
                genericForBodyStarts,
                loopBodyJoinIds,
                loopBackedgeCountsByJoin,
                loopControlByBlockId,
            })) return null;
            matches.push(match);
            applied = true;
            break;
        }
        if (!applied) return null;
    }
    if (!matches.length) return null;
    return {
        leaves: transformed,
        matches,
        genericForBranchIds,
        genericForMetaByBranchId,
        genericForBodyStarts,
        loopBodyJoinIds,
        loopBackedgeCountsByJoin,
        loopControlByBlockId,
    };
}

module.exports = {
    applyCompilerGenericForMatch,
    collapseCompilerGenericForLoops,
    matchCompilerGenericForCheck,
    matchCompilerGenericForNaturalLoop,
};
