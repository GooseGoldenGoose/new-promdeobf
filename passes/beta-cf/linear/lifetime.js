"use strict";

const { isIdentifier, isSingleAssignment, isPrimitiveLiteral, isEmptyTable, isVmRegisterName, sourceOf, renderTableFields, renderUnary, isLuaIdentifier } = require("../ast");
function nodeUsesIdentifier(ctx, node, name) {
    if (!node || typeof node !== "object") return false;
    if (isIdentifier(node, name)) return true;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => nodeUsesIdentifier(ctx, item, name))) return true;
        } else if (value && typeof value === "object" && nodeUsesIdentifier(ctx, value, name)) return true;
    }
    return false;
}

function valueUsedBeforeOverwrite(ctx, startIndex, name) {
    const event = ctx.findNextFutureEvent(name, startIndex, ctx.INIT_READ | ctx.WRITE);
    return event !== null && (event.flags & ctx.INIT_READ) !== 0;
}

function hasLaterNilAssignment(ctx, startIndex, name) {
    return ctx.findNextFutureEvent(name, startIndex, ctx.NIL_WRITE) !== null;
}

function hasOnlyDeadCopyUses(ctx, startIndex, name, seen = new Set()) {
    if (seen.has(name)) return false;
    const nextSeen = new Set(seen);
    nextSeen.add(name);
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, name)) return false;
            continue;
        }
        const dest = statement.variables[0];
        const value = statement.init[0];
        const rhsUses = nodeUsesIdentifier(ctx, value, name) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, dest, name));
        if (rhsUses) {
            if (!isIdentifier(value, name) || !isIdentifier(dest) || dest.name === name || ctx.cleanupRegs.has(dest.name) || !hasOnlyDeadCopyUses(ctx, cursor, dest.name, nextSeen)) return false;
            continue;
        }
        if (isIdentifier(dest, name)) return true;
    }
    return true;
}

function isTerminalUnreadEpoch(ctx, startIndex, name) {
    return ctx.findNextFutureEvent(name, startIndex, ctx.INIT_READ | ctx.INDEX_DEST_READ | ctx.WRITE) === null;
}

function nodeUsesAsCallBase(ctx, node, name) {
    if (!node || typeof node !== "object") return false;
    if (node.type === "CallExpression" && isIdentifier(node.base, name)) return true;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => nodeUsesAsCallBase(ctx, item, name))) return true;
        } else if (value && typeof value === "object" && nodeUsesAsCallBase(ctx, value, name)) return true;
    }
    return false;
}

function isTerminalStableUsedEpoch(ctx, startIndex, name) {
    let useCount = 0;
    let firstUseIndex = -1;
    let soleUseIsCallBase = false;
    let soleUseIsLogical = false;
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, name)) {
                useCount++;
                if (firstUseIndex < 0) firstUseIndex = cursor;
            }
            continue;
        }
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (isIdentifier(dest, name)) return false;
        if (isIdentifier(dest, ctx.stateName) && isIdentifier(rhs, name)) return false;
        if (nodeUsesIdentifier(ctx, rhs, name) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, dest, name))) {
            useCount++;
            if (firstUseIndex < 0) {
                firstUseIndex = cursor;
                soleUseIsCallBase = nodeUsesAsCallBase(ctx, rhs, name);
                soleUseIsLogical = rhs?.type === "LogicalExpression" && nodeUsesIdentifier(ctx, rhs, name);
            }
        }
    }
    // One-use callables and immediately-consumed operands are compiler TEMP shapes too.
    // A terminal ctx.source alias needs either repeated use, or one delayed non-call use.
    return useCount > 1 || (useCount === 1 && firstUseIndex > startIndex + 1 && !soleUseIsCallBase && !soleUseIsLogical);
}

function findFutureTerminalUnusedCopy(ctx, startIndex, tempReg) {
    const event = ctx.findNextFutureEvent(tempReg, startIndex, ctx.INIT_READ | ctx.INDEX_DEST_READ | ctx.WRITE);
    if (!event) return null;
    const statement = ctx.leaf[event.index];
    if (!isSingleAssignment(statement)) return null;
    const dest = statement.variables[0];
    const rhs = statement.init[0];
    if (!isIdentifier(dest) || !isIdentifier(rhs, tempReg) || !isVmRegisterName(dest.name) || ctx.cleanupRegs.has(dest.name)) return null;
    return isTerminalUnreadEpoch(ctx, event.index, dest.name) ? dest.name : null;
}

function findFutureTerminalClosureCopy(ctx, startIndex, tempReg) {
    const event = ctx.findNextFutureEvent(tempReg, startIndex, ctx.INIT_READ | ctx.INDEX_DEST_READ | ctx.WRITE);
    if (!event) return null;
    const statement = ctx.leaf[event.index];
    if (!isSingleAssignment(statement)) return null;
    const dest = statement.variables[0];
    const rhs = statement.init[0];
    if (!isIdentifier(dest) || !isIdentifier(rhs, tempReg) || dest.name === ctx.stateName || dest.name === ctx.returnName || ctx.cleanupRegs.has(dest.name)) return null;
    const laterEvents = ctx.futureEvents.get(dest.name) || [];
    let sawUse = false;
    for (const later of laterEvents) {
        if (later.index <= event.index) continue;
        if ((later.flags & (ctx.INIT_READ | ctx.INDEX_DEST_READ)) !== 0) sawUse = true;
        if ((later.flags & ctx.WRITE) !== 0) return null;
    }
    return sawUse ? dest.name : null;
}

function findFutureUpvalueClosureStore(ctx, startIndex, tempReg) {
    const event = ctx.findNextFutureEvent(tempReg, startIndex, ctx.INIT_READ | ctx.INDEX_DEST_READ | ctx.WRITE);
    if (!event) return null;
    const statement = ctx.leaf[event.index];
    if (!isSingleAssignment(statement)) return null;
    const dest = statement.variables[0];
    const rhs = statement.init[0];
    if (dest?.type !== "IndexExpression" || !isIdentifier(dest.base, "upvalueValues") || !isIdentifier(dest.index) || !isIdentifier(rhs, tempReg)) return null;
    return ctx.upvalueCells.has(dest.index.name) && ctx.upvalueCells.get(dest.index.name) === null ? dest.index.name : null;
}

function isPurePendingTempRhs(ctx, rhs) {
    if (!rhs || typeof rhs !== "object") return false;
    if (rhs.type === "CallExpression" || rhs.type === "IndexExpression" || rhs.type === "FunctionDeclaration" || rhs.type === "FunctionExpression") return false;
    if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs) || isIdentifier(rhs)) return true;
    if (rhs.type === "UnaryExpression") return isPurePendingTempRhs(ctx, rhs.argument);
    if (rhs.type === "BinaryExpression" || rhs.type === "LogicalExpression") return isPurePendingTempRhs(ctx, rhs.left) && isPurePendingTempRhs(ctx, rhs.right);
    if (rhs.type === "TableConstructorExpression") {
        for (const field of rhs.fields || []) {
            if (field?.type === "TableValue") { if (!isPurePendingTempRhs(ctx, field.value)) return false; continue; }
            if (field?.type === "TableKey") { if (!isPurePendingTempRhs(ctx, field.key) || !isPurePendingTempRhs(ctx, field.value)) return false; continue; }
            if (field?.type === "TableKeyString") { if (!isPurePendingTempRhs(ctx, field.value)) return false; continue; }
            return false;
        }
        return true;
    }
    return false;
}

function rhsDependsOnPendingPack(ctx, node) {
    if (!node || typeof node !== "object") return false;
    if (isIdentifier(node)) {
        if (ctx.exprKinds.get(node.name) === "return-pack" && ctx.pendingPacks.has(node.name)) return true;
        if (ctx.exprKinds.get(node.name) === "pack-slot") {
            const meta = ctx.exprMeta.get(node.name);
            if (meta?.packReg && ctx.pendingPacks.has(meta.packReg)) return true;
        }
        return false;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => rhsDependsOnPendingPack(ctx, item))) return true;
        } else if (value && typeof value === "object" && rhsDependsOnPendingPack(ctx, value)) return true;
    }
    return false;
}

function rhsUsesPendingPackSourceLocal(ctx, node) {
    if (!node || typeof node !== "object") return false;
    if (isIdentifier(node) && ctx.exprKinds.get(node.name) === "pack-slot") {
        const meta = ctx.exprMeta.get(node.name);
        const pendingPack = meta?.packReg ? ctx.pendingPacks.get(meta.packReg) : null;
        const slotInfo = pendingPack && meta ? pendingPack.slots.get(meta.slot) : null;
        return !!(slotInfo?.localReg && ctx.locals.has(slotInfo.localReg));
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => rhsUsesPendingPackSourceLocal(ctx, item))) return true;
        } else if (value && typeof value === "object" && rhsUsesPendingPackSourceLocal(ctx, value)) return true;
    }
    return false;
}

function hasFuturePendingPackSlotBeforeStateTouch(ctx, startIndex) {
    if (ctx.pendingPacks.size !== 1) return false;
    const pendingPack = [...ctx.pendingPacks.values()][0];
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, ctx.stateName)) return false;
            continue;
        }
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (isIdentifier(dest, ctx.stateName) || nodeUsesIdentifier(ctx, rhs, ctx.stateName) ||
            (dest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, dest, ctx.stateName))) return false;
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, pendingPack.packReg) &&
            rhs.index?.type === "NumericLiteral") {
            const slot = Number(rhs.index.value);
            return Number.isInteger(slot) && slot > 0 && !pendingPack.slots.has(slot);
        }
        if (isIdentifier(dest, pendingPack.packReg)) return false;
    }
    return false;
}

function isDeadPurePendingTemp(ctx, index, name, rhs) {
    if (!isPurePendingTempRhs(ctx, rhs)) return false;
    if (rhsDependsOnPendingPack(ctx, rhs)) return false;
    return hasOnlyDeadCopyUses(ctx, index, name);
}

function hasFutureReassignedLocalUse(ctx, startIndex, name) {
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, name)) return true;
            continue;
        }
        const dest = statement.variables[0];
        const value = statement.init[0];
        if (nodeUsesIdentifier(ctx, value, name) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, dest, name))) return true;
        if (isIdentifier(dest, name)) {
            if (!isIdentifier(value) || value.name === name) return false;
        }
    }
    return false;
}

function findFutureLiveTableCopy(ctx, startIndex, tempReg, rhs) {
    if (rhs?.type !== "TableConstructorExpression" || !isPurePendingTempRhs(ctx, rhs)) return null;
    if (rhsDependsOnPendingPack(ctx, rhs)) return null;
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, tempReg)) return null;
            continue;
        }
        const dest = statement.variables[0];
        const value = statement.init[0];
        if (isIdentifier(dest) && isIdentifier(value, tempReg)) {
            for (let probe = startIndex + 1; probe < cursor; probe++) {
                const between = ctx.leaf[probe];
                if (nodeUsesIdentifier(ctx, between?.init, dest.name)) return null;
                const betweenDest = isSingleAssignment(between) ? between.variables[0] : null;
                if (betweenDest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, betweenDest, dest.name)) return null;
            }
            if (ctx.locals.has(dest.name)) return dest.name;
            if (dest.name !== ctx.stateName && dest.name !== ctx.returnName && !ctx.cleanupRegs.has(dest.name) &&
                (valueUsedBeforeOverwrite(ctx, cursor, dest.name) || hasFutureReassignedLocalUse(ctx, cursor, dest.name))) return dest.name;
            return null;
        }
        if (nodeUsesIdentifier(ctx, value, tempReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, dest, tempReg))) return null;
        if (isIdentifier(dest, tempReg)) return null;
    }
    return null;
}

function isDeadPlainTableIndexRead(ctx, index, name, rhs) {
    if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base) || !ctx.plainTableLocals.has(rhs.base.name)) return false;
    if (rhsDependsOnPendingPack(ctx, rhs)) return false;
    return hasOnlyDeadCopyUses(ctx, index, name);
}

function countIdentifierUses(ctx, node, name) {
    if (!node || typeof node !== "object") return 0;
    if (isIdentifier(node, name)) return 1;
    let count = 0;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) for (const item of value) count += countIdentifierUses(ctx, item, name);
        else if (value && typeof value === "object") count += countIdentifierUses(ctx, value, name);
    }
    return count;
}

function isUniqueFutureTableOperand(ctx, startIndex, tempReg) {
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, tempReg)) return false;
            continue;
        }
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        const uses = countIdentifierUses(ctx, rhs, tempReg) + ((dest?.type === "IndexExpression") ? countIdentifierUses(ctx, dest, tempReg) : 0);
        if (uses > 0) return rhs?.type === "TableConstructorExpression" && uses === 1;
        if (isIdentifier(dest, tempReg)) return false;
    }
    return false;
}

function isPlainTableMethodLoad(ctx, index, name, rhs) {
    if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base) || !ctx.plainTableLocals.has(rhs.base.name)) return false;
    const next = ctx.leaf[index + 1];
    if (!isSingleAssignment(next, name)) return false;
    const call = next.init[0];
    return call?.type === "CallExpression" && isIdentifier(call.base, name) && (call.arguments || []).length > 0 && isIdentifier(call.arguments[0], rhs.base.name);
}

function findFutureCleanupCopy(ctx, startIndex, tempReg) {
    const event = ctx.findNextFutureEvent(tempReg, startIndex, ctx.INIT_READ | ctx.INDEX_DEST_READ | ctx.WRITE);
    if (!event) return null;
    const statement = ctx.leaf[event.index];
    if (!isSingleAssignment(statement)) return null;
    const dest = statement.variables[0];
    const rhs = statement.init[0];
    return isIdentifier(dest) && ctx.cleanupRegs.has(dest.name) && isIdentifier(rhs, tempReg) ? dest.name : null;
}

function isPosPreservationCopy(ctx, startIndex, destReg, rhs) {
    if (!isIdentifier(rhs, ctx.stateName) || (ctx.nonNilDefinitionCount.get(destReg) || 0) <= 1) return false;
    for (let cursor = startIndex + 1; cursor < ctx.leaf.length; cursor++) {
        const statement = ctx.leaf[cursor];
        if (!isSingleAssignment(statement)) {
            if (nodeUsesIdentifier(ctx, statement?.init, destReg)) return false;
            continue;
        }
        const dest = statement.variables[0];
        const value = statement.init[0];
        if (isIdentifier(dest, destReg)) return false;
        if (nodeUsesIdentifier(ctx, value, destReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(ctx, dest, destReg))) {
            return isIdentifier(dest, ctx.stateName) && isIdentifier(value, destReg);
        }
    }
    return false;
}

module.exports = { nodeUsesIdentifier, valueUsedBeforeOverwrite, hasLaterNilAssignment, hasOnlyDeadCopyUses, isTerminalUnreadEpoch, nodeUsesAsCallBase, isTerminalStableUsedEpoch, findFutureTerminalUnusedCopy, findFutureTerminalClosureCopy, findFutureUpvalueClosureStore, isPurePendingTempRhs, rhsDependsOnPendingPack, rhsUsesPendingPackSourceLocal, hasFuturePendingPackSlotBeforeStateTouch, isDeadPurePendingTemp, hasFutureReassignedLocalUse, findFutureLiveTableCopy, isDeadPlainTableIndexRead, countIdentifierUses, isUniqueFutureTableOperand, isPlainTableMethodLoad, findFutureCleanupCopy, isPosPreservationCopy };
