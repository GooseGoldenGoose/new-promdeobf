"use strict";

const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
function nodeReadsIdentifier(ctx, node, name) {
    if (!node || typeof node !== "object") return false;
    if (isIdentifier(node, name)) return true;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => nodeReadsIdentifier(ctx, item, name))) return true;
        } else if (value && typeof value === "object" && nodeReadsIdentifier(ctx, value, name)) return true;
    }
    return false;
}

function nodeUsesAsCallBaseMulti(ctx, node, name) {
    if (!node || typeof node !== "object") return false;
    if (node.type === "CallExpression" && isIdentifier(node.base, name)) return true;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => nodeUsesAsCallBaseMulti(ctx, item, name))) return true;
        } else if (value && typeof value === "object" && nodeUsesAsCallBaseMulti(ctx, value, name)) return true;
    }
    return false;
}

function epochReadsOnlyAsCallBase(ctx, startBlockId, startIndex, name) {
    const seen = new Set();
    const stack = [{ blockId: startBlockId, index: startIndex + 1 }];
    let sawUse = false;
    while (stack.length) {
        const cursor = stack.pop();
        const visitKey = cursor.blockId + ":" + cursor.index;
        if (seen.has(visitKey)) continue;
        seen.add(visitKey);
        const block = ctx.blocks.get(cursor.blockId);
        if (!block) return false;
        let overwritten = false;
        for (let i = cursor.index; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return false;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest, name)) { overwritten = true; break; }
            const readsRhs = nodeReadsIdentifier(ctx, rhs, name);
            const readsDest = dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name);
            if (readsDest) return false;
            if (readsRhs) {
                sawUse = true;
                if (!nodeUsesAsCallBaseMulti(ctx, rhs, name)) return false;
                // Every occurrence must be the direct call base, not merely one
                // occurrence somewhere inside a larger expression.
                let invalidOccurrence = false;
                function verify(node, callBasePosition = false) {
                    if (!node || typeof node !== "object" || invalidOccurrence) return;
                    if (isIdentifier(node, name)) { if (!callBasePosition) invalidOccurrence = true; return; }
                    if (node.type === "CallExpression") {
                        if (isIdentifier(node.base, name)) verify(node.base, true);
                        else verify(node.base, false);
                        for (const arg of node.arguments || []) verify(arg, false);
                        return;
                    }
                    for (const [key, value] of Object.entries(node)) {
                        if (key === "range" || key === "loc" || key === "variables") continue;
                        if (Array.isArray(value)) for (const item of value) verify(item, false);
                        else if (value && typeof value === "object") verify(value, false);
                    }
                }
                verify(rhs, false);
                if (invalidOccurrence) return false;
            }
        }
        if (overwritten) continue;
        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) return false;
        for (const next of ctx.successors.get(cursor.blockId) || []) stack.push({ blockId: next, index: 0 });
    }
    return sawUse;
}

function terminalStableUsedEpoch(ctx, startBlockId, startIndex, name) {
    const uses = new Map();
    const seen = new Set();
    const stack = [{ blockId: startBlockId, index: startIndex + 1 }];
    let invalid = false;
    while (stack.length && !invalid) {
        const cursor = stack.pop();
        const visitKey = `${cursor.blockId}:${cursor.index}`;
        if (seen.has(visitKey)) continue;
        seen.add(visitKey);
        const block = ctx.blocks.get(cursor.blockId);
        if (!block) return false;
        for (let i = cursor.index; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return false;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest, name)) { invalid = true; break; }
            if (isIdentifier(dest, ctx.stateName) && isIdentifier(rhs, name)) { invalid = true; break; }
            const ordinaryUse = nodeReadsIdentifier(ctx, rhs, name) ||
                (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name));
            if (ordinaryUse) {
                uses.set(`${cursor.blockId}:${i}`, {
                    delayed: cursor.blockId !== startBlockId || i > startIndex + 1,
                    callBase: nodeUsesAsCallBaseMulti(ctx, rhs, name),
                    logical: rhs?.type === "LogicalExpression" && nodeReadsIdentifier(ctx, rhs, name),
                });
            }
        }
        if (invalid) break;
        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
            uses.set(`${cursor.blockId}:branch`, { delayed: cursor.blockId !== startBlockId, callBase: false, logical: true });
        }
        for (const next of ctx.successors.get(cursor.blockId) || []) stack.push({ blockId: next, index: 0 });
    }
    if (invalid || uses.size === 0) return false;
    if (uses.size > 1) return true;
    const only = [...uses.values()][0];
    return only.delayed && !only.callBase && !only.logical;
}

function transportSourceKind(ctx, block, statementIndex, transportName) {
    for (let i = statementIndex - 1; i >= 0; i--) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement, transportName)) continue;
        return statement.init[0]?.type === "TableConstructorExpression" ? "table" : "value";
    }
    return "value";
}

function valueMayBeReadFrom(ctx, blockId, name, visiting = new Set()) {
    if (visiting.has(blockId)) return true;
    const block = ctx.blocks.get(blockId);
    if (!block) return true;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(blockId);
    for (let i = 0; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) return true;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (nodeReadsIdentifier(ctx, rhs, name)) return true;
        if (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name)) return true;
        if (isIdentifier(dest, name)) return false;
    }
    if (block.transition.kind === "branch" && block.transition.conditionRegister === name) return true;
    for (const next of ctx.successors.get(blockId) || []) {
        if (valueMayBeReadFrom(ctx, next, name, nextVisiting)) return true;
    }
    return false;
}

function eventualCleanupOnAllPaths(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const cacheKey = blockId + ":" + statementIndex + ":" + name;
    if (ctx.eventualCleanupCache.has(cacheKey)) return ctx.eventualCleanupCache.get(cacheKey);
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return false;
    const block = ctx.blocks.get(blockId);
    if (!block) return false;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        if (!isIdentifier(dest, name)) continue;
        if (statement.init[0]?.type === "NilLiteral") {
            ctx.eventualCleanupCache.set(cacheKey, true);
            return true;
        }
        // A non-nil write may be another source assignment to the same
        // persistent binding; keep following this path to its cleanup.
    }
    const next = ctx.successors.get(blockId) || [];
    if (next.length === 0) {
        ctx.eventualCleanupCache.set(cacheKey, false);
        return false;
    }
    const result = next.every(target => eventualCleanupOnAllPaths(ctx, target, -1, name, nextVisiting));
    ctx.eventualCleanupCache.set(cacheKey, result);
    return result;
}

function valueMayBeReadAfter(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const visitKey = `${blockId}:${statementIndex}`;
    if (visiting.has(visitKey)) return true;
    const cacheKey = `${blockId}:${statementIndex}:${name}`;
    if (ctx.valueReadAfterCache.has(cacheKey)) return ctx.valueReadAfterCache.get(cacheKey);
    const block = ctx.blocks.get(blockId);
    if (!block) return true;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) {
            ctx.valueReadAfterCache.set(cacheKey, true);
            return true;
        }
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (nodeReadsIdentifier(ctx, rhs, name) || (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name))) {
            ctx.valueReadAfterCache.set(cacheKey, true);
            return true;
        }
        if (isIdentifier(dest, name)) {
            ctx.valueReadAfterCache.set(cacheKey, false);
            return false;
        }
    }
    if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
        ctx.valueReadAfterCache.set(cacheKey, true);
        return true;
    }
    for (const next of ctx.successors.get(blockId) || []) {
        if (valueMayBeReadAfter(ctx, next, -1, name, nextVisiting)) {
            ctx.valueReadAfterCache.set(cacheKey, true);
            return true;
        }
    }
    ctx.valueReadAfterCache.set(cacheKey, false);
    return false;
}

function hasFutureNonNilWrite(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const cacheKey = blockId + ":" + statementIndex + ":" + name;
    if (ctx.futureNonNilWriteCache.has(cacheKey)) return ctx.futureNonNilWriteCache.get(cacheKey);
    const visitKey = blockId + ":" + statementIndex;
    if (visiting.has(visitKey)) return true;
    const block = ctx.blocks.get(blockId);
    if (!block) return true;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest, name)) continue;
        const result = rhs?.type !== "NilLiteral";
        ctx.futureNonNilWriteCache.set(cacheKey, result);
        return result;
    }
    for (const next of ctx.successors.get(blockId) || []) {
        if (hasFutureNonNilWrite(ctx, next, -1, name, nextVisiting)) {
            ctx.futureNonNilWriteCache.set(cacheKey, true);
            return true;
        }
    }
    ctx.futureNonNilWriteCache.set(cacheKey, false);
    return false;
}

function cleanupReachedOnAllPaths(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const cacheKey = blockId + ":" + statementIndex + ":" + name;
    if (ctx.cleanupPathCache.has(cacheKey)) return ctx.cleanupPathCache.get(cacheKey);
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return false;
    const block = ctx.blocks.get(blockId);
    if (!block) return false;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        if (!isIdentifier(dest, name)) continue;
        const result = statement.init[0]?.type === "NilLiteral";
        ctx.cleanupPathCache.set(cacheKey, result);
        return result;
    }
    const next = ctx.successors.get(blockId) || [];
    if (next.length === 0) {
        ctx.cleanupPathCache.set(cacheKey, false);
        return false;
    }
    const result = next.every(target => cleanupReachedOnAllPaths(ctx, target, -1, name, nextVisiting));
    ctx.cleanupPathCache.set(cacheKey, result);
    return result;
}

function analyzePersistentStorage(ctx) {
    if (ctx.allowConditionalIf && ctx.accumulatorRegs.size) {
    for (const name of ctx.accumulatorRegs) {
    const inDefs = new Map([...ctx.reachable].map(id => [id, new Set()]));
    const outDefs = new Map([...ctx.reachable].map(id => [id, new Set()]));
    let convergedRead = false;
    let changed = true;
    let rounds = 0;
    while (changed && rounds++ <= ctx.reachable.size + 1) {
    changed = false;
    for (const id of ctx.reachable) {
    const incomingDefs = new Set();
    for (const pred of ctx.predecessors.get(id) || []) {
    if (!ctx.reachable.has(pred)) continue;
    for (const def of outDefs.get(pred) || []) incomingDefs.add(def);
    }
    const oldIn = inDefs.get(id);
    if (oldIn.size !== incomingDefs.size || [...oldIn].some(def => !incomingDefs.has(def))) {
    inDefs.set(id, incomingDefs);
    changed = true;
    }
    let current = new Set(incomingDefs);
    const block = ctx.blocks.get(id);
    for (let i = 0; i < block.body.length; i++) {
    if (i === block.transitionIndex) continue;
    const statement = block.body[i];
    if (!isSingleAssignment(statement)) continue;
    const dest = statement.variables[0];
    const rhs = statement.init[0];
    const ordinaryRead = nodeReadsIdentifier(ctx, rhs, name) ||
    (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name));
    if (ordinaryRead && current.size >= 2) convergedRead = true;
    if (isIdentifier(dest, name)) {
    if (rhs?.type === "NilLiteral") current = new Set();
    else current = new Set([id + ":" + i]);
    }
    }
    const oldOut = outDefs.get(id);
    if (oldOut.size !== current.size || [...oldOut].some(def => !current.has(def))) {
    outDefs.set(id, current);
    changed = true;
    }
    }
    }
    if (convergedRead && eventualCleanupOnAllPaths(ctx, ctx.entryId, -1, name)) ctx.persistentStorageRegs.add(name);
    }
    }
}

module.exports = { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, epochReadsOnlyAsCallBase, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, cleanupReachedOnAllPaths, analyzePersistentStorage };
