const { applyTextEdits } = require("./text-edits");
const { findVmFunction } = require("./vm-state");
const { findVmReturnRegister, findRegisterOverflowBinding } = require("./vm-register-names");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isPrimitiveLiteral(node) {
    return ["StringLiteral", "NumericLiteral", "BooleanLiteral", "NilLiteral"].includes(node?.type);
}

function numericValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = typeof node.value === "number" ? node.value : Number(node.raw);
    return Number.isInteger(value) ? value : null;
}

function overflowSlotIdentity(node, overflowName) {
    if (!overflowName || node?.type !== "IndexExpression" || !isIdentifier(node.base, overflowName)) return null;
    const index = numericValue(node.index);
    if (index === null || index < 1) return null;
    return "@overflow:" + index;
}

function registerIdentity(node, overflowName) {
    if (isIdentifier(node)) return node.name;
    return overflowSlotIdentity(node, overflowName);
}

function isDelayableAssignment(statement, stateName, overflowName = null) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1) return false;

    const destination = registerIdentity(variables[0], overflowName);
    if (!destination) return false;
    if (isIdentifier(variables[0]) && [stateName, "args", "upvalues", "gcProxy"].includes(destination)) return false;

    const rhs = init[0];
    return isPrimitiveLiteral(rhs) || registerIdentity(rhs, overflowName) !== null;
}

const READS_CACHE = new WeakMap();
const WRITES_CACHE = new WeakMap();

function cachedSet(cache, statement, overflowName, compute) {
    if (!statement || typeof statement !== "object") return new Set();
    const key = overflowName || "";
    let entry = cache.get(statement);
    if (!entry) {
        const value = compute();
        cache.set(statement, { key, value, extra: null });
        return value;
    }
    if (entry.key === key) return entry.value;
    if (entry.extra?.has(key)) return entry.extra.get(key);
    const value = compute();
    if (!entry.extra) entry.extra = new Map();
    entry.extra.set(key, value);
    return value;
}

function collectExpressionReads(node, out, overflowName) {
    if (!isNode(node) || node.type === "FunctionDeclaration") return;
    const overflowIdentity = overflowSlotIdentity(node, overflowName);
    if (overflowIdentity) {
        out.add(overflowIdentity);
        return;
    }
    if (node.type === "Identifier") {
        out.add(node.name);
        return;
    }
    if (node.type === "MemberExpression") {
        collectExpressionReads(node.base, out, overflowName);
        return;
    }
    if (node.type === "TableKeyString") {
        collectExpressionReads(node.value, out, overflowName);
        return;
    }
    for (const key of Object.keys(node)) {
        const value = node[key];
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectExpressionReads(child, out, overflowName);
        } else if (isNode(value)) {
            collectExpressionReads(value, out, overflowName);
        }
    }
}

function statementReads(statement, overflowName = null) {
    return cachedSet(READS_CACHE, statement, overflowName, () => {
        const out = new Set();
        if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
            for (const variable of statement.variables || []) {
                if (registerIdentity(variable, overflowName)) continue;
                collectExpressionReads(variable, out, overflowName);
            }
            for (const rhs of statement.init || []) collectExpressionReads(rhs, out, overflowName);
        } else {
            collectExpressionReads(statement, out, overflowName);
        }
        return out;
    });
}

function statementWrites(statement, overflowName = null) {
    return cachedSet(WRITES_CACHE, statement, overflowName, () => {
        const out = new Set();
        if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
            for (const variable of statement.variables || []) {
                const identity = registerIdentity(variable, overflowName);
                if (identity) out.add(identity);
            }
        }
        return out;
    });
}

function intersects(a, b) {
    for (const value of a) if (b.has(value)) return true;
    return false;
}

function canSwapRightAssignmentWithLeftStatement(delayable, current, stateName, overflowName = null) {
    if (!isDelayableAssignment(delayable, stateName, overflowName)) return false;

    const delayReads = statementReads(delayable, overflowName);
    const delayWrites = statementWrites(delayable, overflowName);
    const currentReads = statementReads(current, overflowName);
    const currentWrites = statementWrites(current, overflowName);

    if (intersects(delayWrites, currentReads)) return false;
    if (intersects(delayReads, currentWrites)) return false;
    if (intersects(delayWrites, currentWrites)) return false;
    return true;
}

function getSingleWrittenRegister(statement, overflowName = null) {
    if (statement?.type !== "AssignmentStatement") return null;
    const variables = statement.variables || [];
    if (variables.length !== 1) return null;
    return registerIdentity(variables[0], overflowName);
}

function appendScheduleIndex(map, name, statement) {
    let list = map.get(name);
    if (!list) map.set(name, list = []);
    list.push(statement);
}

function buildScheduleIndex(statements, overflowName = null) {
    const indexByStatement = new Map();
    const readersByName = new Map();
    const writersByName = new Map();
    for (let index = 0; index < statements.length; index++) {
        const statement = statements[index];
        indexByStatement.set(statement, index);
        for (const name of statementReads(statement, overflowName)) appendScheduleIndex(readersByName, name, statement);
        for (const name of statementWrites(statement, overflowName)) appendScheduleIndex(writersByName, name, statement);
    }
    return { indexByStatement, readersByName, writersByName };
}

function refreshScheduleIndex(scheduleIndex, statements, fromIndex, toIndex) {
    if (!scheduleIndex) return;
    const start = Math.max(0, Math.min(fromIndex, toIndex));
    const end = Math.min(statements.length - 1, Math.max(fromIndex, toIndex));
    for (let index = start; index <= end; index++) {
        scheduleIndex.indexByStatement.set(statements[index], index);
    }
}

function moveScheduledStatement(statements, fromIndex, toIndex, scheduleIndex = null) {
    if (fromIndex === toIndex) return;
    const [statement] = statements.splice(fromIndex, 1);
    statements.splice(toIndex, 0, statement);
    refreshScheduleIndex(scheduleIndex, statements, fromIndex, toIndex);
}

function indexedNearestAfter(list, afterIndex, indexByStatement) {
    let bestStatement = null;
    let bestIndex = Number.MAX_SAFE_INTEGER;
    for (const statement of list || []) {
        const index = indexByStatement.get(statement);
        if (index > afterIndex && index < bestIndex) {
            bestIndex = index;
            bestStatement = statement;
        }
    }
    return bestStatement ? { statement: bestStatement, index: bestIndex } : null;
}

function findNextRegisterTouch(statements, index, name, overflowName = null, scheduleIndex = null) {
    if (scheduleIndex) {
        const read = indexedNearestAfter(scheduleIndex.readersByName.get(name), index, scheduleIndex.indexByStatement);
        const write = indexedNearestAfter(scheduleIndex.writersByName.get(name), index, scheduleIndex.indexByStatement);
        if (!read) return write ? { index: write.index, kind: "write" } : null;
        if (!write || read.index <= write.index) return { index: read.index, kind: "read" };
        return { index: write.index, kind: "write" };
    }
    for (let i = index + 1; i < statements.length; i++) {
        if (statementReads(statements[i], overflowName).has(name)) return { index: i, kind: "read" };
        if (statementWrites(statements[i], overflowName).has(name)) return { index: i, kind: "write" };
    }
    return null;
}

function findPreviousRegisterWrite(statements, index, name, overflowName = null, scheduleIndex = null) {
    if (scheduleIndex) {
        let bestIndex = -1;
        for (const statement of scheduleIndex.writersByName.get(name) || []) {
            const candidateIndex = scheduleIndex.indexByStatement.get(statement);
            if (candidateIndex < index && candidateIndex > bestIndex) bestIndex = candidateIndex;
        }
        return bestIndex;
    }
    for (let i = index - 1; i >= 0; i--) {
        if (statementWrites(statements[i], overflowName).has(name)) return i;
    }
    return -1;
}

function isPrimitiveSourceAssignment(statement, stateName, overflowName = null) {
    if (!isDelayableAssignment(statement, stateName, overflowName)) return false;
    const init = statement.init || [];
    return init.length === 1 && isPrimitiveLiteral(init[0]);
}

function isCanonicalNilStop(statement, stateName) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    return variables.length === 1 && init.length === 1 &&
        isIdentifier(variables[0], stateName) && init[0]?.type === "NilLiteral";
}

function isDirectNumericStateTransition(statement, stateName) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    return variables.length === 1 && init.length === 1 &&
        isIdentifier(variables[0], stateName) && numericValue(init[0]) !== null;
}

function canonicalizeDirectNumericStateTransition(statements, stateName, overflowName = null) {
    if (statements.length < 2) return { swaps: 0, moved: 0 };

    let transitionIndex = -1;
    for (let index = statements.length - 1; index >= 0; index--) {
        if (!statementWrites(statements[index], overflowName).has(stateName)) continue;
        transitionIndex = index;
        break;
    }
    if (transitionIndex < 0 || transitionIndex === statements.length - 1) return { swaps: 0, moved: 0 };

    const transition = statements[transitionIndex];
    if (!isDirectNumericStateTransition(transition, stateName)) return { swaps: 0, moved: 0 };

    const crossed = statements.slice(transitionIndex + 1);
    if (crossed.some(statement =>
        statementReads(statement, overflowName).has(stateName) ||
        statementWrites(statement, overflowName).has(stateName)
    )) {
        return { swaps: 0, moved: 0 };
    }

    statements.splice(transitionIndex, 1);
    statements.push(transition);
    return { swaps: crossed.length, moved: 1 };
}

function isCompilerReturnRegisterRead(node) {
    if (isIdentifier(node)) return true;
    if (node?.type !== "CallExpression" || !isIdentifier(node.base, "unpack")) return false;
    const args = node.arguments || [];
    return args.length === 1 && isIdentifier(args[0]);
}

function isCompilerReturnPayloadAssignment(statement, returnName) {
    if (!returnName || statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0], returnName)) return false;
    const table = init[0];
    if (table?.type !== "TableConstructorExpression") return false;
    return (table.fields || []).every(field =>
        field?.type === "TableValue" && isCompilerReturnRegisterRead(field.value)
    );
}

function isPureTerminalTailBookkeeping(statement, stateName, returnName, overflowName, payloadReads) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1) return false;

    const rhs = init[0];
    const simpleRegisterRead = isPrimitiveLiteral(rhs) || registerIdentity(rhs, overflowName) !== null;
    const fixedArgumentRead = rhs?.type === "IndexExpression" &&
        isIdentifier(rhs.base, "args") && numericValue(rhs.index) !== null;

    // Captured source arguments/locals are initialized through the proven
    // Prometheus upvalueValues table. This write is compiler bookkeeping that
    // must complete before the VM returns, but moving the return payload table
    // construction after it does not move or duplicate the write itself.
    const upvalueCellWrite = variables[0]?.type === "IndexExpression" &&
        isIdentifier(variables[0].base, "upvalueValues") &&
        (simpleRegisterRead || fixedArgumentRead);
    if (upvalueCellWrite) {
        const reads = statementReads(statement, overflowName);
        return !returnName || !reads.has(returnName);
    }

    const target = registerIdentity(variables[0], overflowName);
    if (!target) return false;
    if (isIdentifier(variables[0]) && [returnName, "args", "upvalues", "gcProxy"].includes(target)) return false;
    // Inside a Step-3-normalized terminal leaf, any earlier write to the state
    // register is proven non-terminating POS-register reuse. It may participate
    // in compiler bookkeeping, but never cross the return payload when that
    // payload itself reads the temporary state value.
    if (payloadReads.has(target)) return false;
    if (!simpleRegisterRead && !fixedArgumentRead) return false;

    const reads = statementReads(statement, overflowName);
    if (returnName && reads.has(returnName)) return false;
    return true;
}

function canonicalizeTerminalReturnPayload(statements, stateName, returnName, overflowName = null) {
    if (!returnName || statements.length < 2) return { swaps: 0, moved: 0 };
    const stopIndex = statements.length - 1;
    if (!isCanonicalNilStop(statements[stopIndex], stateName)) return { swaps: 0, moved: 0 };

    let payloadIndex = -1;
    for (let index = stopIndex - 1; index >= 0; index--) {
        if (!statementWrites(statements[index], overflowName).has(returnName)) continue;
        if (!isCompilerReturnPayloadAssignment(statements[index], returnName)) return { swaps: 0, moved: 0 };
        payloadIndex = index;
        break;
    }
    if (payloadIndex < 0 || payloadIndex === stopIndex - 1) return { swaps: 0, moved: 0 };

    const payload = statements[payloadIndex];
    const payloadReads = statementReads(payload, overflowName);
    const crossed = statements.slice(payloadIndex + 1, stopIndex);
    if (!crossed.every(statement =>
        isPureTerminalTailBookkeeping(statement, stateName, returnName, overflowName, payloadReads)
    )) {
        return { swaps: 0, moved: 0 };
    }

    statements.splice(payloadIndex, 1);
    statements.splice(statements.length - 1, 0, payload);
    return { swaps: stopIndex - payloadIndex - 1, moved: 1 };
}

function sinkPureAssignmentsTowardNextTouch(statements, stateName, overflowName = null, scheduleIndex = null) {
    const originalOrder = [...statements];
    let swaps = 0;
    let moved = 0;

    for (const producer of originalOrder) {
        const fromIndex = scheduleIndex
            ? (scheduleIndex.indexByStatement.get(producer) ?? -1)
            : statements.indexOf(producer);
        if (fromIndex < 0 || !isPrimitiveSourceAssignment(producer, stateName, overflowName)) continue;
        const name = getSingleWrittenRegister(producer, overflowName);
        if (!name) continue;

        const touch = findNextRegisterTouch(statements, fromIndex, name, overflowName, scheduleIndex);
        if (!touch || touch.index <= fromIndex + 1) continue;
        if (!canMoveDelayableRightAcrossRange(statements, fromIndex, touch.index - 1, stateName, overflowName)) continue;

        const targetIndex = touch.index - 1;
        const distance = targetIndex - fromIndex;
        moveScheduledStatement(statements, fromIndex, targetIndex, scheduleIndex);
        swaps += distance;
        moved++;
    }

    return { swaps, moved };
}

function pullIdentifierCopiesTowardProducer(statements, stateName, overflowName = null, scheduleIndex = null) {
    const originalOrder = [...statements];
    let swaps = 0;
    let moved = 0;

    for (const consumer of originalOrder) {
        let currentIndex = scheduleIndex
            ? (scheduleIndex.indexByStatement.get(consumer) ?? -1)
            : statements.indexOf(consumer);
        if (currentIndex <= 0 || !isDelayableAssignment(consumer, stateName, overflowName)) continue;
        const init = consumer.init || [];
        if (init.length !== 1) continue;

        const producerName = registerIdentity(init[0], overflowName);
        if (!producerName) continue;
        const producerIndex = findPreviousRegisterWrite(statements, currentIndex, producerName, overflowName, scheduleIndex);
        if (producerIndex < 0 || currentIndex === producerIndex + 1) continue;

        let didMove = false;
        while (currentIndex > producerIndex + 1) {
            const previous = statements[currentIndex - 1];
            if (hasRegisterHazard(previous, consumer, overflowName)) break;
            statements[currentIndex - 1] = consumer;
            statements[currentIndex] = previous;
            if (scheduleIndex) {
                scheduleIndex.indexByStatement.set(consumer, currentIndex - 1);
                scheduleIndex.indexByStatement.set(previous, currentIndex);
            }
            currentIndex--;
            swaps++;
            didMove = true;
        }
        if (didMove) moved++;
    }

    return { swaps, moved };
}

function sinkUnreadPureAssignmentsToStateTail(statements, stateName, overflowName = null, scheduleIndex = null) {
    const originalOrder = [...statements];
    let swaps = 0;
    let moved = 0;

    for (const candidate of originalOrder) {
        const fromIndex = scheduleIndex
            ? (scheduleIndex.indexByStatement.get(candidate) ?? -1)
            : statements.indexOf(candidate);
        if (fromIndex < 0 || !isDelayableAssignment(candidate, stateName, overflowName)) continue;
        const name = getSingleWrittenRegister(candidate, overflowName);
        if (!name) continue;

        const touch = findNextRegisterTouch(statements, fromIndex, name, overflowName, scheduleIndex);
        if (touch?.kind === "read") continue;
        const nextWrite = touch?.kind === "write" ? touch.index : -1;
        let targetIndex = nextWrite >= 0 ? nextWrite : statements.length;

        if (nextWrite < 0 && statements.length > 0) {
            const tail = statements[statements.length - 1];
            const tailVars = tail?.type === "AssignmentStatement" ? (tail.variables || []) : [];
            const tailInit = tail?.type === "AssignmentStatement" ? (tail.init || []) : [];
            if (tailVars.length === 1 && tailInit.length === 1 &&
                isIdentifier(tailVars[0], stateName) && tailInit[0]?.type === "NilLiteral") {
                targetIndex = statements.length - 1;
            }
        }

        if (targetIndex <= fromIndex + 1) continue;
        if (!canMoveDelayableRightAcrossRange(statements, fromIndex, targetIndex - 1, stateName, overflowName)) continue;

        const finalIndex = targetIndex - 1;
        const distance = finalIndex - fromIndex;
        moveScheduledStatement(statements, fromIndex, finalIndex, scheduleIndex);
        swaps += distance;
        moved++;
    }

    return { swaps, moved };
}

function findDirectProducerStatements(statements, index, overflowName = null, scheduleIndex = null) {
    const reads = statementReads(statements[index], overflowName);
    const producers = new Set();
    for (const name of reads) {
        const producerIndex = findPreviousRegisterWrite(statements, index, name, overflowName, scheduleIndex);
        if (producerIndex >= 0) producers.add(statements[producerIndex]);
    }
    return producers;
}

function canMoveDelayableRightAcrossRange(statements, fromIndex, throughIndex, stateName, overflowName = null) {
    const delayable = statements[fromIndex];
    if (!isDelayableAssignment(delayable, stateName, overflowName)) return false;

    for (let i = fromIndex + 1; i <= throughIndex; i++) {
        if (!canSwapRightAssignmentWithLeftStatement(delayable, statements[i], stateName, overflowName)) {
            return false;
        }
    }
    return true;
}

function compactConsumerGap(statements, currentIndex, stateName, overflowName = null, scheduleIndex = null) {
    const producers = findDirectProducerStatements(statements, currentIndex, overflowName, scheduleIndex);
    if (producers.size === 0) return { currentIndex, swaps: 0 };

    let earliestProducerIndex = currentIndex;
    for (const producer of producers) {
        const index = scheduleIndex
            ? (scheduleIndex.indexByStatement.get(producer) ?? -1)
            : statements.indexOf(producer);
        if (index >= 0) earliestProducerIndex = Math.min(earliestProducerIndex, index);
    }

    let swaps = 0;
    let index = earliestProducerIndex + 1;
    while (index < currentIndex) {
        const candidate = statements[index];
        if (producers.has(candidate)) {
            index++;
            continue;
        }
        if (!canMoveDelayableRightAcrossRange(statements, index, currentIndex, stateName, overflowName)) {
            index++;
            continue;
        }

        const distance = currentIndex - index;
        moveScheduledStatement(statements, index, currentIndex, scheduleIndex);
        currentIndex--;
        swaps += distance;
        // Re-check the statement that shifted into this gap position.
    }

    return { currentIndex, swaps };
}

function hasRegisterHazard(left, right, overflowName = null) {
    const leftReads = statementReads(left, overflowName);
    const leftWrites = statementWrites(left, overflowName);
    const rightReads = statementReads(right, overflowName);
    const rightWrites = statementWrites(right, overflowName);

    return (
        intersects(leftWrites, rightReads) ||
        intersects(leftReads, rightWrites) ||
        intersects(leftWrites, rightWrites)
    );
}

function validateScheduledOrder(original, scheduled, stateName, overflowName = null, finalIndexOverride = null) {
    if (original.length !== scheduled.length) return false;
    const finalIndex = finalIndexOverride || new Map(scheduled.map((statement, index) => [statement, index]));
    if (finalIndex.size !== original.length) return false;
    for (const statement of original) if (!finalIndex.has(statement)) return false;

    const originalAnchors = original.filter(statement => !isDelayableAssignment(statement, stateName, overflowName));
    const scheduledAnchors = scheduled.filter(statement => !isDelayableAssignment(statement, stateName, overflowName));
    if (originalAnchors.length !== scheduledAnchors.length) return false;
    for (let i = 0; i < originalAnchors.length; i++) {
        if (originalAnchors[i] !== scheduledAnchors[i]) return false;
    }

    // Any inverted pair must be reproducible by moving at least one pure
    // delayable assignment across the other statement, with no RAW, WAR, or
    // WAW dependency. Two non-movable/effectful statements may never invert.
    for (let i = 0; i < original.length; i++) {
        for (let j = i + 1; j < original.length; j++) {
            const left = original[i];
            const right = original[j];
            if (finalIndex.get(left) < finalIndex.get(right)) continue;
            if (!isDelayableAssignment(left, stateName, overflowName) && !isDelayableAssignment(right, stateName, overflowName)) return false;
            if (hasRegisterHazard(left, right, overflowName)) return false;
        }
    }
    return true;
}

function scheduleStatementList(statements, stateName, overflowName = null, returnName = null) {
    const scheduled = [...statements];
    const schedulingBaseline = statements;
    const originalOrder = statements;
    const scheduleIndex = buildScheduleIndex(scheduled, overflowName);
    let swaps = 0;

    const sunk = sinkPureAssignmentsTowardNextTouch(scheduled, stateName, overflowName, scheduleIndex);
    swaps += sunk.swaps;

    const pulled = pullIdentifierCopiesTowardProducer(scheduled, stateName, overflowName, scheduleIndex);
    swaps += pulled.swaps;

    for (const current of originalOrder) {
        const currentIndex = scheduleIndex.indexByStatement.get(current) ?? -1;
        if (currentIndex <= 0) continue;
        const result = compactConsumerGap(scheduled, currentIndex, stateName, overflowName, scheduleIndex);
        swaps += result.swaps;
    }

    const unread = sinkUnreadPureAssignmentsToStateTail(scheduled, stateName, overflowName, scheduleIndex);
    swaps += unread.swaps;

    // No move means the scheduled list is still the original order. If anything
    // moved, keep the full independent safety validator.
    if (swaps > 0 && !validateScheduledOrder(
        schedulingBaseline,
        scheduled,
        stateName,
        overflowName,
        scheduleIndex.indexByStatement
    )) {
        return {
            statements: [...statements],
            swaps: 0,
            producerSinks: 0,
            producerPulls: 0,
            unreadSinks: 0,
            safetyRejected: true,
        };
    }

    const directStateTransition = canonicalizeDirectNumericStateTransition(scheduled, stateName, overflowName);
    swaps += directStateTransition.swaps;

    const terminalReturn = canonicalizeTerminalReturnPayload(scheduled, stateName, returnName, overflowName);
    swaps += terminalReturn.swaps;

    return {
        statements: scheduled,
        swaps,
        producerSinks: sunk.moved,
        producerPulls: pulled.moved,
        unreadSinks: unread.moved,
        directStateTransitionMoves: directStateTransition.moved,
        safetyRejected: false,
    };
}

function findStateWhile(vmFunction, stateName) {
    let found = null;
    function walk(node) {
        if (!isNode(node) || found) return;
        if (node.type === "FunctionDeclaration" && node !== vmFunction) return;
        if (node.type === "WhileStatement" && isIdentifier(node.condition, stateName)) {
            found = node;
            return;
        }
        for (const key of Object.keys(node)) {
            const value = node[key];
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) walk(child);
            } else if (isNode(value)) {
                walk(value);
            }
        }
    }
    for (const statement of vmFunction.body || []) walk(statement);
    return found;
}

function isNumericLiteral(node) {
    return node?.type === "NumericLiteral";
}

function isStateDecisionCondition(node, stateName) {
    if (node?.type !== "BinaryExpression") return false;
    if (!["==", "<", "<=", ">", ">="].includes(node.operator)) return false;
    return (
        (isIdentifier(node.left, stateName) && isNumericLiteral(node.right)) ||
        (isNumericLiteral(node.left) && isIdentifier(node.right, stateName))
    );
}

function isDispatcherIf(statement, stateName) {
    if (statement?.type !== "IfStatement") return false;
    const clauses = statement.clauses || [];
    if (clauses.length === 0) return false;
    for (const clause of clauses) {
        if (clause.type === "ElseClause") continue;
        if (!isStateDecisionCondition(clause.condition, stateName)) return false;
    }
    return true;
}

function collectDispatcherLeaves(body, stateName, out = []) {
    const significant = (body || []).filter(statement => statement?.type !== "CommentStatement");
    if (significant.length === 1 && isDispatcherIf(significant[0], stateName)) {
        for (const clause of significant[0].clauses || []) {
            collectDispatcherLeaves(clause.body || [], stateName, out);
        }
        return out;
    }
    out.push(body || []);
    return out;
}

function sourceOf(source, node) {
    if (!Array.isArray(node?.range)) return "";
    return source.slice(node.range[0], node.range[1]);
}

function lineIndentAt(source, offset) {
    const lineStart = source.lastIndexOf("\n", Math.max(0, offset - 1)) + 1;
    const prefix = source.slice(lineStart, offset);
    const match = prefix.match(/^[\t ]*/);
    return match ? match[0] : "";
}

function hasOnlyWhitespaceBetween(source, statements) {
    for (let i = 1; i < statements.length; i++) {
        const gap = source.slice(statements[i - 1].range[1], statements[i].range[0]);
        if (!/^\s*$/.test(gap)) return false;
    }
    return true;
}

function renderScheduledBody(source, original, scheduled) {
    const indent = lineIndentAt(source, original[0].range[0]);
    const newline = source.includes("\r\n") ? "\r\n" : "\n";
    return scheduled.map(statement => sourceOf(source, statement)).join(newline + indent);
}

function applyEdits(source, edits) {
    return applyTextEdits(source, edits);
}

function scheduleVmRegisterUses(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) {
        return { source, found: false, applied: false, reason: "No semantically named vm function was found", blocksChanged: 0, swaps: 0 };
    }

    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) {
        return { source, found: false, applied: false, reason: "VM state parameter is not an identifier", blocksChanged: 0, swaps: 0 };
    }

    const stateName = stateParam.name;
    const returnRegister = findVmReturnRegister(vm.functionNode);
    const returnName = returnRegister?.name || null;
    const overflow = findRegisterOverflowBinding(vm.functionNode);
    const overflowName = overflow?.name || null;
    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) {
        return { source, found: false, applied: false, reason: "No while <state> dispatcher was found", blocksChanged: 0, swaps: 0 };
    }

    const leaves = collectDispatcherLeaves(stateWhile.body || [], stateName);
    const edits = [];
    let blocksChanged = 0;
    let swaps = 0;
    let safetyRejectedSegments = 0;
    let producerSinks = 0;
    let producerPulls = 0;
    let unreadSinks = 0;
    let directStateTransitionMoves = 0;

    for (const body of leaves) {
        const segments = [];
        let segment = [];
        for (const statement of body) {
            if (statement?.type === "CommentStatement") {
                if (segment.length) segments.push(segment);
                segment = [];
                continue;
            }
            segment.push(statement);
        }
        if (segment.length) segments.push(segment);

        for (const statements of segments) {
            if (statements.length < 2) continue;
            if (!statements.every(statement => Array.isArray(statement.range))) continue;
            if (!hasOnlyWhitespaceBetween(source, statements)) continue;

            const scheduled = scheduleStatementList(statements, stateName, overflowName, returnName);
            if (scheduled.safetyRejected) safetyRejectedSegments++;
            producerSinks += scheduled.producerSinks || 0;
            producerPulls += scheduled.producerPulls || 0;
            unreadSinks += scheduled.unreadSinks || 0;
            directStateTransitionMoves += scheduled.directStateTransitionMoves || 0;
            if (scheduled.swaps === 0) continue;

            edits.push({
                start: statements[0].range[0],
                end: statements[statements.length - 1].range[1],
                text: renderScheduledBody(source, statements, scheduled.statements),
            });
            blocksChanged++;
            swaps += scheduled.swaps;
        }
    }

    if (edits.length === 0) {
        return { source, found: true, applied: false, blocksChanged: 0, swaps: 0, producerSinks, producerPulls, unreadSinks, directStateTransitionMoves, safetyRejectedSegments, overflowRegisterBank: overflowName, overflowRegisterSlots: overflow?.indices?.size || 0 };
    }

    return {
        source: applyEdits(source, edits),
        found: true,
        applied: true,
        blocksChanged,
        swaps,
        producerSinks,
        producerPulls,
        unreadSinks,
        directStateTransitionMoves,
        safetyRejectedSegments,
        overflowRegisterBank: overflowName,
        overflowRegisterSlots: overflow?.indices?.size || 0,
    };
}

module.exports = {
    scheduleVmRegisterUses,
    scheduleStatementList,
    canSwapRightAssignmentWithLeftStatement,
};
