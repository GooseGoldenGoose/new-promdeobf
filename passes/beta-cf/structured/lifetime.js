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
        const rhs = statement.init[0];
        if (rhs?.type === "TableConstructorExpression") return "table";
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name)) return "closure";
        return "value";
    }
    return "value";
}

function assignmentValueFlow(ctx, statement, name) {
    if (statement?.type === "CompoundAssignmentStatement") {
        // Luau compound assignment evaluates the destination address, reads the
        // destination's current value, evaluates the RHS, then writes back. It
        // only makes the queried VM value live when that value actually appears
        // in the destination expression or RHS. An unrelated compound write must
        // not conservatively make every register live across a CFG join/loop.
        return nodeReadsIdentifier(ctx, statement.variable, name) ||
            nodeReadsIdentifier(ctx, statement.value, name) ? "read" : "pass";
    }
    if (statement?.type !== "AssignmentStatement") return "unknown";
    const variables = statement.variables || [];
    const init = statement.init || [];
    // Lua evaluates every RHS before applying any LHS write. A parallel
    // assignment can therefore read the old value even when one destination
    // overwrites the same register; test all RHS/index-address reads first.
    if (nodeReadsIdentifier(ctx, init, name)) return "read";
    for (const dest of variables) {
        if (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name)) return "read";
    }
    if (variables.some(dest => isIdentifier(dest, name))) return "kill";
    return "pass";
}

function implicitLoopBodyEntryDefines(ctx, blockId, name) {
    const genericStarts = ctx.options?.genericForBodyStarts;
    const generic = genericStarts instanceof Map ? genericStarts.get(blockId) : null;
    if (generic && Array.isArray(generic.loopVarRegs) && generic.loopVarRegs.includes(name)) return true;

    const numericStarts = ctx.options?.numericForBodyStarts;
    const numeric = numericStarts instanceof Map ? numericStarts.get(blockId) : null;
    if (numeric && numeric.loopVarReg === name) return true;

    return false;
}

function valueMayBeReadFrom(ctx, blockId, name, visiting = new Set()) {
    // Proven compiler loop headers assign source iteration variables before the
    // first body statement. An incoming pre-loop TEMP epoch is therefore killed
    // at body entry even though that assignment was removed during loop collapse.
    if (implicitLoopBodyEntryDefines(ctx, blockId, name)) return false;
    // This query asks whether any CFG path can READ the current value before
    // an overwrite. Revisiting a block on the current DFS stack is not a read;
    // it only closes a cycle. Any real read reachable through an exit from that
    // cycle is explored through the other successor edges, so treating the
    // back-edge itself as live creates false liveness at loop joins.
    if (visiting.has(blockId)) return false;
    const block = ctx.blocks.get(blockId);
    if (!block) return true;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(blockId);
    for (let i = 0; i < block.body.length; i++) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        const flow = assignmentValueFlow(ctx, statement, name);
        if (flow === "unknown" || flow === "read") return true;
        if (flow === "kill") return false;
    }
    if (block.transition.kind === "branch" && block.transition.conditionRegister === name) return true;
    for (const next of ctx.successors.get(blockId) || []) {
        if (valueMayBeReadFrom(ctx, next, name, nextVisiting)) return true;
    }
    return false;
}

function isDeadNilCleanup(ctx, blockId, statementIndex, name) {
    const block = ctx.blocks.get(blockId);
    const statement = block?.body?.[statementIndex];
    if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0], name) || statement.init[0]?.type !== "NilLiteral") return false;
    // A compiler lifetime cleanup produces nil that is never observed. If this
    // exact nil definition is read before the next overwrite/terminal, it is
    // semantic source data and belongs to a new value/storage epoch instead.
    return !valueMayBeReadAfter(ctx, blockId, statementIndex, name);
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
        if (statement.init[0]?.type === "NilLiteral" && isDeadNilCleanup(ctx, blockId, i, name)) {
            ctx.eventualCleanupCache.set(cacheKey, true);
            return true;
        }
        // A non-nil write, or a semantic nil write whose value is observed,
        // may be another source assignment to the same persistent binding;
        // keep following this path to its real cleanup.
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
    if (statementIndex < 0 && implicitLoopBodyEntryDefines(ctx, blockId, name)) return false;
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
        const flow = assignmentValueFlow(ctx, statement, name);
        if (flow === "unknown" || flow === "read") {
            ctx.valueReadAfterCache.set(cacheKey, true);
            return true;
        }
        if (flow === "kill") {
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
        const result = statement.init[0]?.type === "NilLiteral" && isDeadNilCleanup(ctx, blockId, i, name);
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

function uniqueReachingDefinitionBefore(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return null;
    const block = ctx.blocks.get(blockId);
    if (!block) return null;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    const before = statementIndex < 0 ? block.body.length : statementIndex;
    for (let i = before - 1; i >= 0; i--) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        if (!isIdentifier(dest, name)) continue;
        return { blockId, index: i, statement };
    }
    const preds = (ctx.predecessors.get(blockId) || []).filter(id => ctx.reachable.has(id));
    if (preds.length !== 1) return null;
    return uniqueReachingDefinitionBefore(ctx, preds[0], -1, name, nextVisiting);
}

function countIdentifierReads(node, name) {
    if (!node || typeof node !== "object") return 0;
    if (isIdentifier(node, name)) return 1;
    let count = 0;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            for (const item of value) count += countIdentifierReads(item, name);
        } else if (value && typeof value === "object") {
            count += countIdentifierReads(value, name);
        }
    }
    return count;
}

function valueMayBeIndexWriteBaseAfter(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return false;
    const block = ctx.blocks.get(blockId);
    if (!block) return false;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    for (let i = statementIndex + 1; i < block.body.length; i++) {
        const statement = block.body[i];
        if (statement?.type !== "AssignmentStatement") return false;
        for (const dest of statement.variables || []) {
            if (dest?.type === "IndexExpression" && isIdentifier(dest.base, name)) return true;
        }
        if ((statement.variables || []).some(dest => isIdentifier(dest, name))) return false;
    }
    for (const next of ctx.successors.get(blockId) || []) {
        if (valueMayBeIndexWriteBaseAfter(ctx, next, -1, name, nextVisiting)) return true;
    }
    return false;
}

function provenSingleUseCallResultAt(ctx, blockId, statementIndex, name) {
    const def = uniqueReachingDefinitionBefore(ctx, blockId, statementIndex, name);
    if (!def || def.statement.init[0]?.type !== "CallExpression") return false;
    const targetKey = blockId + ":" + statementIndex;
    const memo = new Map();

    function walk(id, startIndex, sawTarget, stack = new Set()) {
        const memoKey = id + ":" + startIndex + ":" + (sawTarget ? 1 : 0);
        if (memo.has(memoKey)) return memo.get(memoKey);
        if (stack.has(memoKey)) return false;
        const block = ctx.blocks.get(id);
        if (!block) return false;
        const nextStack = new Set(stack);
        nextStack.add(memoKey);
        let seen = sawTarget;

        for (let i = startIndex; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (statement?.type !== "AssignmentStatement") { memo.set(memoKey, false); return false; }
            let readCount = 0;
            for (const rhs of statement.init || []) readCount += countIdentifierReads(rhs, name);
            for (const dest of statement.variables || []) {
                if (dest?.type === "IndexExpression") readCount += countIdentifierReads(dest, name);
            }
            if (readCount > 0) {
                if ((id + ":" + i) !== targetKey || seen || readCount !== 1) { memo.set(memoKey, false); return false; }
                seen = true;
            }
            if ((statement.variables || []).some(dest => isIdentifier(dest, name))) {
                memo.set(memoKey, seen);
                return seen;
            }
        }

        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
            memo.set(memoKey, false);
            return false;
        }
        const next = ctx.successors.get(id) || [];
        if (next.length === 0) {
            memo.set(memoKey, seen);
            return seen;
        }
        const result = next.every(target => walk(target, 0, seen, nextStack));
        memo.set(memoKey, result);
        return result;
    }

    return walk(def.blockId, def.index + 1, false);
}

function isCompilerArgsAliasBefore(ctx, blockId, statementIndex, name) {
    if (name === "args") return true;
    if (!isVmRegisterName(name)) return false;
    const work = [{ blockId, statementIndex }];
    const seen = new Set();
    let sawDefinition = false;
    while (work.length) {
        const cursor = work.pop();
        const visitKey = cursor.blockId + ":" + cursor.statementIndex + ":" + name;
        if (seen.has(visitKey)) continue;
        seen.add(visitKey);
        const block = ctx.blocks.get(cursor.blockId);
        if (!block) return false;
        const before = cursor.statementIndex < 0 ? block.body.length : cursor.statementIndex;
        let found = false;
        for (let i = before - 1; i >= 0; i--) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement, name)) continue;
            found = true;
            sawDefinition = true;
            if (!isIdentifier(statement.init[0], "args")) return false;
            break;
        }
        if (found) continue;
        const preds = (ctx.predecessors.get(cursor.blockId) || []).filter(id => ctx.reachable.has(id));
        if (preds.length === 0) return false;
        for (const pred of preds) work.push({ blockId: pred, statementIndex: -1 });
    }
    return sawDefinition;
}

function conditionalUpdatedStorageEpoch(ctx, startBlockId, startIndex, name) {
    const cacheKey = `${startBlockId}:${startIndex}:${name}`;
    if (ctx.conditionalStorageCache instanceof Map && ctx.conditionalStorageCache.has(cacheKey)) {
        return ctx.conditionalStorageCache.get(cacheKey);
    }
    const fail = { proven: false, terminalLive: false, joinId: null };
    const remember = result => {
        if (ctx.conditionalStorageCache instanceof Map) ctx.conditionalStorageCache.set(cacheKey, result);
        return result;
    };
    if (!ctx.allowConditionalIf || !isVmRegisterName(name) || name === ctx.stateName || name === ctx.returnName) return remember(fail);
    const startBlock = ctx.blocks.get(startBlockId);
    const startStatement = startBlock?.body?.[startIndex];
    if (!isSingleAssignment(startStatement, name)) return remember(fail);
    // A conditional update alone does not prove source ownership: compiler TEMPs
    // can also differ across branch arms and be read after the join. This special
    // terminal-live storage proof is reserved for a value loaded directly from
    // the VM argument vector. Other source bindings must be established by the
    // existing cleanup/copy/upvalue ownership proofs.
    const startRhs = startStatement.init[0];
    const compilerArgumentStart = startRhs?.type === "IndexExpression" &&
        startRhs.index?.type === "NumericLiteral" && Number.isInteger(Number(startRhs.index.value)) &&
        Number(startRhs.index.value) >= 1 && (
            isIdentifier(startRhs.base, "args") ||
            (isIdentifier(startRhs.base) && isCompilerArgsAliasBefore(ctx, startBlockId, startIndex, startRhs.base.name))
        );
    if (!compilerArgumentStart) return remember(fail);

    // ORIGINAL means the exact start definition still reaches this path.
    // UPDATED means a semantic assignment to the same source binding happened
    // after the start. A dead compiler nil cleanup terminates that path instead.
    const ORIGINAL = 1;
    const UPDATED = 2;
    const incoming = new Map();
    const queue = [{ blockId: startBlockId, index: startIndex + 1, status: ORIGINAL }];
    const seen = new Set();

    function hasSemanticWriteFrom(blockId) {
        const work = [blockId];
        const visited = new Set();
        while (work.length) {
            const id = work.pop();
            if (visited.has(id)) continue;
            visited.add(id);
            const block = ctx.blocks.get(id);
            if (!block) return true;
            for (let i = 0; i < block.body.length; i++) {
                if (i === block.transitionIndex) continue;
                const statement = block.body[i];
                if (!isSingleAssignment(statement, name)) continue;
                if (statement.init[0]?.type === "NilLiteral" && isDeadNilCleanup(ctx, id, i, name)) continue;
                return true;
            }
            for (const next of ctx.successors.get(id) || []) work.push(next);
        }
        return false;
    }

    while (queue.length) {
        const cursor = queue.shift();
        const visitKey = `${cursor.blockId}:${cursor.index}:${cursor.status}`;
        if (seen.has(visitKey)) continue;
        seen.add(visitKey);
        const block = ctx.blocks.get(cursor.blockId);
        if (!block) return remember(fail);
        let status = cursor.status;
        let alive = true;
        for (let i = cursor.index; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) continue;
            if (!isIdentifier(statement.variables[0], name)) continue;
            if (statement.init[0]?.type === "NilLiteral" && isDeadNilCleanup(ctx, cursor.blockId, i, name)) {
                alive = false;
                break;
            }
            status = UPDATED;
        }
        if (!alive) continue;
        for (const next of ctx.successors.get(cursor.blockId) || []) {
            const previous = incoming.get(next) || 0;
            const combined = previous | status;
            if (combined !== previous) incoming.set(next, combined);
            if (combined === (ORIGINAL | UPDATED) && valueMayBeReadFrom(ctx, next, name) && !hasSemanticWriteFrom(next)) {
                const terminalLive = !cleanupReachedOnAllPaths(ctx, next, -1, name);
                return remember({ proven: true, terminalLive, joinId: next });
            }
            queue.push({ blockId: next, index: 0, status });
        }
    }
    return remember(fail);
}

function allReachingDefinitionsAreDeadNilCleanup(ctx, blockId, statementIndex, name, visiting = new Set()) {
    const visitKey = blockId + ":" + statementIndex + ":" + name;
    if (visiting.has(visitKey)) return false;
    const block = ctx.blocks.get(blockId);
    if (!block) return false;
    const nextVisiting = new Set(visiting);
    nextVisiting.add(visitKey);
    const before = statementIndex < 0 ? block.body.length : statementIndex;
    for (let i = before - 1; i >= 0; i--) {
        if (i === block.transitionIndex) continue;
        const statement = block.body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0], name)) continue;
        return statement.init[0]?.type === "NilLiteral" && isDeadNilCleanup(ctx, blockId, i, name);
    }
    const preds = (ctx.predecessors.get(blockId) || []).filter(id => ctx.reachable.has(id));
    if (preds.length === 0) return false;
    return preds.every(pred => allReachingDefinitionsAreDeadNilCleanup(ctx, pred, -1, name, nextVisiting));
}

function provenCallArgumentSourceEpoch(ctx, blockId, statementIndex, name) {
    const def = uniqueReachingDefinitionBefore(ctx, blockId, statementIndex, name);
    if (!def) return false;
    const rhs = def.statement.init[0];
    if (rhs?.type === "NilLiteral") return false;
    // The normal LocalVariableDeclaration lowering is an expression TEMP ->
    // cleanup-backed VAR handoff. A copied TEMP is explicit ownership evidence.
    if (isIdentifier(rhs) && rhs.name !== name) return true;
    // Prometheus may erase that copy by promoting the expression register itself
    // to VAR ownership. Fresh CF only proves this direct form when the next write
    // on every continuation path is the compiler nil cleanup; a later non-nil
    // write means the current value could still be an ordinary TEMP epoch.
    return cleanupReachedOnAllPaths(ctx, def.blockId, def.index, name);
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
    // A compiler POS save/restore (temp = state ... state = temp) is
    // dispatcher transport, not a source read of persistent storage.  Counting
    // the restore here can merge an earlier TEMP epoch with a much later
    // cleanup-backed VAR lifetime on the same physical register.
    const compilerPosRestore = isIdentifier(dest, ctx.stateName) && isIdentifier(rhs, name);
    const ordinaryRead = !compilerPosRestore && (nodeReadsIdentifier(ctx, rhs, name) ||
        (dest?.type === "IndexExpression" && nodeReadsIdentifier(ctx, dest, name)));
    if (ordinaryRead && current.size >= 2) convergedRead = true;
    if (isIdentifier(dest, name)) {
    if (rhs?.type === "NilLiteral" && isDeadNilCleanup(ctx, id, i, name)) current = new Set();
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

module.exports = { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, cleanupReachedOnAllPaths, isDeadNilCleanup, allReachingDefinitionsAreDeadNilCleanup, conditionalUpdatedStorageEpoch, provenCallArgumentSourceEpoch, provenSingleUseCallResultAt, valueMayBeIndexWriteBaseAfter, analyzePersistentStorage };
