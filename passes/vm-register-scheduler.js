const { applyTextEdits } = require("./text-edits");
const { findVmFunction } = require("./vm-state");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isPrimitiveLiteral(node) {
    return ["StringLiteral", "NumericLiteral", "BooleanLiteral", "NilLiteral"].includes(node?.type);
}

function isDelayableAssignment(statement, stateName) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) return false;

    const name = variables[0].name;
    if ([stateName, "args", "upvalues", "gcProxy"].includes(name)) return false;

    const rhs = init[0];
    return isPrimitiveLiteral(rhs) || isIdentifier(rhs);
}

const READS_CACHE = new WeakMap();
const WRITES_CACHE = new WeakMap();

function collectExpressionReads(node, out) {
    if (!isNode(node) || node.type === "FunctionDeclaration") return;
    if (node.type === "Identifier") {
        out.add(node.name);
        return;
    }
    if (node.type === "MemberExpression") {
        collectExpressionReads(node.base, out);
        return;
    }
    if (node.type === "TableKeyString") {
        collectExpressionReads(node.value, out);
        return;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectExpressionReads(child, out);
        } else if (isNode(value)) {
            collectExpressionReads(value, out);
        }
    }
}

function statementReads(statement) {
    if (!statement || typeof statement !== "object") return new Set();
    const cached = READS_CACHE.get(statement);
    if (cached) return cached;
    const out = new Set();
    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (!isIdentifier(variable)) collectExpressionReads(variable, out);
        }
        for (const rhs of statement.init || []) collectExpressionReads(rhs, out);
    } else {
        collectExpressionReads(statement, out);
    }
    READS_CACHE.set(statement, out);
    return out;
}

function statementWrites(statement) {
    if (!statement || typeof statement !== "object") return new Set();
    const cached = WRITES_CACHE.get(statement);
    if (cached) return cached;
    const out = new Set();
    if (statement?.type === "AssignmentStatement" || statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (isIdentifier(variable)) out.add(variable.name);
        }
    }
    WRITES_CACHE.set(statement, out);
    return out;
}

function intersects(a, b) {
    for (const value of a) if (b.has(value)) return true;
    return false;
}

function canSwapRightAssignmentWithLeftStatement(delayable, current, stateName) {
    if (!isDelayableAssignment(delayable, stateName)) return false;

    const delayReads = statementReads(delayable);
    const delayWrites = statementWrites(delayable);
    const currentReads = statementReads(current);
    const currentWrites = statementWrites(current);

    if (intersects(delayWrites, currentReads)) return false;
    if (intersects(delayReads, currentWrites)) return false;
    if (intersects(delayWrites, currentWrites)) return false;
    return true;
}

function getSingleWrittenIdentifier(statement) {
    if (statement?.type !== "AssignmentStatement") return null;
    const variables = statement.variables || [];
    if (variables.length !== 1 || !isIdentifier(variables[0])) return null;
    return variables[0].name;
}

function findNextRegisterTouch(statements, index, name) {
    for (let i = index + 1; i < statements.length; i++) {
        if (statementReads(statements[i]).has(name)) {
            return { index: i, kind: "read" };
        }
        if (statementWrites(statements[i]).has(name)) {
            return { index: i, kind: "write" };
        }
    }
    return null;
}

function isPrimitiveSourceAssignment(statement, stateName) {
    if (!isDelayableAssignment(statement, stateName)) return false;
    const init = statement.init || [];
    return init.length === 1 && isPrimitiveLiteral(init[0]);
}

function sinkPureAssignmentsTowardNextTouch(statements, stateName) {
    const originalOrder = [...statements];
    let swaps = 0;
    let moved = 0;

    for (const producer of originalOrder) {
        const fromIndex = statements.indexOf(producer);
        // Literal/nil loads have no producer of their own, so place them near
        // the next read or overwrite of the destination register. Identifier
        // copies are handled in the opposite direction below so they stay near
        // the value that produced their RHS.
        if (fromIndex < 0 || !isPrimitiveSourceAssignment(producer, stateName)) continue;
        const name = getSingleWrittenIdentifier(producer);
        if (!name) continue;

        const touch = findNextRegisterTouch(statements, fromIndex, name);
        if (!touch || touch.index <= fromIndex + 1) continue;

        if (!canMoveDelayableRightAcrossRange(statements, fromIndex, touch.index - 1, stateName)) continue;

        const distance = touch.index - fromIndex - 1;
        statements.splice(fromIndex, 1);
        statements.splice(touch.index - 1, 0, producer);
        swaps += distance;
        moved++;
    }

    return { swaps, moved };
}

function pullIdentifierCopiesTowardProducer(statements, stateName) {
    const originalOrder = [...statements];
    let swaps = 0;
    let moved = 0;

    for (const consumer of originalOrder) {
        let currentIndex = statements.indexOf(consumer);
        if (currentIndex <= 0 || !isDelayableAssignment(consumer, stateName)) continue;
        const init = consumer.init || [];
        if (init.length !== 1 || !isIdentifier(init[0])) continue;

        const producerName = init[0].name;
        let producerIndex = -1;
        for (let i = currentIndex - 1; i >= 0; i--) {
            if (statementWrites(statements[i]).has(producerName)) {
                producerIndex = i;
                break;
            }
        }
        if (producerIndex < 0 || currentIndex === producerIndex + 1) continue;

        let didMove = false;
        while (currentIndex > producerIndex + 1) {
            const previous = statements[currentIndex - 1];
            if (hasRegisterHazard(previous, consumer)) break;
            statements[currentIndex - 1] = consumer;
            statements[currentIndex] = previous;
            currentIndex--;
            swaps++;
            didMove = true;
        }
        if (didMove) moved++;
    }

    return { swaps, moved };
}

function sinkUnreadPureAssignmentsToStateTail(statements, stateName) {
    const originalOrder = [...statements];
    let swaps = 0;
    let moved = 0;

    for (const candidate of originalOrder) {
        let fromIndex = statements.indexOf(candidate);
        if (fromIndex < 0 || !isDelayableAssignment(candidate, stateName)) continue;
        const name = getSingleWrittenIdentifier(candidate);
        if (!name) continue;

        let nextRead = -1;
        let nextWrite = -1;
        for (let i = fromIndex + 1; i < statements.length; i++) {
            if (statementReads(statements[i]).has(name)) {
                nextRead = i;
                break;
            }
            if (statementWrites(statements[i]).has(name)) {
                nextWrite = i;
                break;
            }
        }

        // A read before any overwrite means this definition is active in the
        // current state and should stay near that use.
        if (nextRead >= 0) continue;

        // If the value is overwritten without being read, keep both writes but
        // group them. If the value is not touched again in this state, sink it
        // to the actual end of the dispatcher leaf. Prometheus may write the
        // next POS/state value early and still execute later statements, so a
        // state assignment is not a textual end-of-block boundary.
        let targetIndex = nextWrite >= 0 ? nextWrite : statements.length;

        // After Step 3, a proven Prometheus stop is canonicalized to a final
        // state = nil. Keep that structural stop as the last statement and sink
        // unread pure writes immediately before it, not past it.
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

        if (!canMoveDelayableRightAcrossRange(statements, fromIndex, targetIndex - 1, stateName)) continue;

        const distance = targetIndex - fromIndex - 1;
        statements.splice(fromIndex, 1);
        statements.splice(targetIndex - 1, 0, candidate);
        swaps += distance;
        moved++;
    }

    return { swaps, moved };
}

function findDirectProducerStatements(statements, index) {
    const reads = statementReads(statements[index]);
    const producers = new Set();

    for (const name of reads) {
        for (let i = index - 1; i >= 0; i--) {
            if (statementWrites(statements[i]).has(name)) {
                producers.add(statements[i]);
                break;
            }
        }
    }

    return producers;
}

function canMoveDelayableRightAcrossRange(statements, fromIndex, throughIndex, stateName) {
    const delayable = statements[fromIndex];
    if (!isDelayableAssignment(delayable, stateName)) return false;

    for (let i = fromIndex + 1; i <= throughIndex; i++) {
        if (!canSwapRightAssignmentWithLeftStatement(delayable, statements[i], stateName)) {
            return false;
        }
    }
    return true;
}

function compactConsumerGap(statements, currentIndex, stateName) {
    const current = statements[currentIndex];
    const producers = findDirectProducerStatements(statements, currentIndex);
    if (producers.size === 0) return { currentIndex, swaps: 0 };

    let earliestProducerIndex = currentIndex;
    for (let i = 0; i < currentIndex; i++) {
        if (producers.has(statements[i])) {
            earliestProducerIndex = Math.min(earliestProducerIndex, i);
        }
    }

    let swaps = 0;
    let index = earliestProducerIndex + 1;
    while (index < currentIndex) {
        const candidate = statements[index];
        if (producers.has(candidate)) {
            index++;
            continue;
        }

        if (!canMoveDelayableRightAcrossRange(statements, index, currentIndex, stateName)) {
            index++;
            continue;
        }

        const distance = currentIndex - index;
        statements.splice(index, 1);
        currentIndex--;
        statements.splice(currentIndex + 1, 0, candidate);
        swaps += distance;
        // Re-check the statement that shifted into this gap position.
    }

    return { currentIndex, swaps };
}

function hasRegisterHazard(left, right) {
    const leftReads = statementReads(left);
    const leftWrites = statementWrites(left);
    const rightReads = statementReads(right);
    const rightWrites = statementWrites(right);

    return (
        intersects(leftWrites, rightReads) ||
        intersects(leftReads, rightWrites) ||
        intersects(leftWrites, rightWrites)
    );
}

function validateScheduledOrder(original, scheduled, stateName) {
    if (original.length !== scheduled.length) return false;
    const finalIndex = new Map(scheduled.map((statement, index) => [statement, index]));
    if (finalIndex.size !== original.length) return false;
    for (const statement of original) if (!finalIndex.has(statement)) return false;

    const originalAnchors = original.filter(statement => !isDelayableAssignment(statement, stateName));
    const scheduledAnchors = scheduled.filter(statement => !isDelayableAssignment(statement, stateName));
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
            if (!isDelayableAssignment(left, stateName) && !isDelayableAssignment(right, stateName)) return false;
            if (hasRegisterHazard(left, right)) return false;
        }
    }
    return true;
}

function scheduleStatementList(statements, stateName) {
    const scheduled = [...statements];
    const schedulingBaseline = [...scheduled];
    const originalOrder = [...scheduled];
    let swaps = 0;

    // First move pure register assignments toward the next semantic touch of
    // the same register. This covers both producer -> read and write -> write
    // compaction while preserving every assignment.
    const sunk = sinkPureAssignmentsTowardNextTouch(scheduled, stateName);
    swaps += sunk.swaps;

    // Identifier-copy assignments are consumers too. Pull them left toward the
    // nearest producer of their RHS when every crossed statement is register-
    // independent. This handles chains such as z = D + G; ...; D = z.
    const pulled = pullIdentifierCopiesTowardProducer(scheduled, stateName);
    swaps += pulled.swaps;

    // Then compact producer -> consumer gaps by pushing only independent pure
    // loads out of the gap. Each move is still equivalent to dependency-safe
    // adjacent swaps.
    for (const current of originalOrder) {
        const currentIndex = scheduled.indexOf(current);
        if (currentIndex <= 0) continue;
        const result = compactConsumerGap(scheduled, currentIndex, stateName);
        swaps += result.swaps;
    }

    // Finally, definitions that are never read again in this state are moved
    // out of active chains. They are kept (never deleted): overwritten values
    // are grouped with the next write, while live-out/unused values are placed
    // at the actual end of the current dispatcher leaf.
    const unread = sinkUnreadPureAssignmentsToStateTail(scheduled, stateName);
    swaps += unread.swaps;

    if (!validateScheduledOrder(schedulingBaseline, scheduled, stateName)) {
        return {
            statements: [...statements],
            swaps: 0,
            producerSinks: 0,
            producerPulls: 0,
            unreadSinks: 0,
            safetyRejected: true,
        };
    }

    return {
        statements: scheduled,
        swaps,
        producerSinks: sunk.moved,
        producerPulls: pulled.moved,
        unreadSinks: unread.moved,
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
        for (const [key, value] of Object.entries(node)) {
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

            const scheduled = scheduleStatementList(statements, stateName);
            if (scheduled.safetyRejected) safetyRejectedSegments++;
            producerSinks += scheduled.producerSinks || 0;
            producerPulls += scheduled.producerPulls || 0;
            unreadSinks += scheduled.unreadSinks || 0;
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
        return { source, found: true, applied: false, blocksChanged: 0, swaps: 0, producerSinks, producerPulls, unreadSinks, safetyRejectedSegments };
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
        safetyRejectedSegments,
    };
}

module.exports = {
    scheduleVmRegisterUses,
    scheduleStatementList,
    canSwapRightAssignmentWithLeftStatement,
};
