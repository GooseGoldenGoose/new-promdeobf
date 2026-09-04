"use strict";

const {
    isEmptyTable,
    isIdentifier,
    isLuaIdentifier,
    isPrimitiveLiteral,
    isSingleAssignment,
    isVmRegisterName,
    renderTableFields,
    renderUnary,
    sourceOf,
} = require("../ast");
const { extractNormalizedStateLeaves, decodeLogicalStateTransition } = require("../normalize");
const { reduceCompilerLogicalStateGraph } = require("../logical");
const { createStateGraph, hasLinearPath } = require("../cfg");

function matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, options = {}) {
    const allowConditionalIf = options.allowConditionalIf === true;
    const rootReachableOnly = options.rootReachableOnly === true;
    const entryId = Number.isInteger(options.entryId) ? options.entryId : 1;
    const captureNames = options.captureNames instanceof Map ? options.captureNames : null;
    const renderAsFunction = options.renderAsFunction === true;
    const originalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!originalLeaves || originalLeaves.size < 2 || !originalLeaves.has(entryId)) return null;
    const logicalReduction = allowConditionalIf
        ? reduceCompilerLogicalStateGraph(originalLeaves, entryId, stateName, returnName)
        : { leaves: originalLeaves, originalReachableStateIds: new Set(originalLeaves.keys()) };
    const leaves = logicalReduction.leaves;

    const graph = createStateGraph(leaves, entryId, stateName);
    if (!graph) return null;
    const { blocks, successors, predecessors, reachable } = graph;
    if (!rootReachableOnly && reachable.size !== blocks.size) return null;

    // Lifetime/storage proof belongs to one VM invocation root. Child closure
    // entry states reuse the same physical register names but execute in a
    // separate invocation, so unreachable child states must never contribute
    // cleanup/definition evidence to the root program.
    const cleanupRegs = new Set();
    for (const id of reachable) {
        const body = blocks.get(id)?.body || [];
        for (const statement of body) {
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && dest.name !== stateName && dest.name !== returnName && rhs?.type === "NilLiteral") cleanupRegs.add(dest.name);
        }
    }
    if (!cleanupRegs.size && !allowConditionalIf) return null;

    const nonNilDefinitionCount = new Map([...cleanupRegs].map(name => [name, 0]));
    for (const id of reachable) {
        const body = blocks.get(id)?.body || [];
        for (const statement of body) {
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && cleanupRegs.has(dest.name) && rhs?.type !== "NilLiteral") {
                nonNilDefinitionCount.set(dest.name, nonNilDefinitionCount.get(dest.name) + 1);
            }
        }
    }
    const accumulatorRegs = new Set([...cleanupRegs].filter(name => nonNilDefinitionCount.get(name) > 1));

    function hasLinearRootContinuation(fromId, toId) {
        return hasLinearPath(graph, fromId, toId);
    }

    function recordRootConditional(startId, joinId) {
        const anchor = lastRootConditionalJoinId === null ? entryId : lastRootConditionalJoinId;
        if (!hasLinearRootContinuation(anchor, startId)) return false;
        lastRootConditionalJoinId = joinId;
        conditionalIfCount++;
        return true;
    }

    const indegree = new Map();
    for (const id of reachable) indegree.set(id, (predecessors.get(id) || []).filter(p => reachable.has(p)).length);
    const ready = [entryId];
    const incoming = new Map([[entryId, [{ env: new Map(), markers: [], effects: [] }]]]);
    const processed = new Set();
    const locals = new Set();
    const localNames = new Map();
    const terminalLiveLocals = new Set();
    // Branch-local source bindings are path-scoped. Their generated source
    // names live in the candidate environment instead of the global physical-
    // register local map, so sibling CFG paths may safely reuse one VM register.
    const pathLocalBindingNames = new Set();
    // Root-local upvalue cells are compiler binding-identity transport. Keep
    // their recovered source bindings separate from ordinary VM register
    // locals so captured aliases can be rendered across conditional states.
    const upvalueCells = new Set();
    const upvalueCellBindings = new Map();
    const upvalueAliasPrefix = "\0freshUpvalueAlias:";
    function upvalueAliasKey(name) { return upvalueAliasPrefix + name; }
    // Structured multi-return packs are kept as provenance tokens until every
    // compiler-extracted slot has been proven to belong to source storage.
    // The token never escapes a block: it is flushed into one source multi-local
    // declaration before control-flow propagation.
    const structuredPackPrefix = "\0freshStructuredPack:";
    const structuredPackSlotPrefix = "\0freshStructuredPackSlot:";
    const structuredPacks = new Map();
    const structuredPackFutureOwnerCopies = new Map();
    const structuredPackFutureExtractions = new Map();
    let nextStructuredPackId = 0;
    const varargPackMarker = "\0freshVarargPack";
    function structuredPackId(value) {
        return typeof value === "string" && value.startsWith(structuredPackPrefix)
            ? value.slice(structuredPackPrefix.length) : null;
    }
    function structuredPackSlot(value) {
        if (typeof value !== "string" || !value.startsWith(structuredPackSlotPrefix)) return null;
        const rest = value.slice(structuredPackSlotPrefix.length);
        const split = rest.lastIndexOf(":");
        if (split < 1) return null;
        const packId = rest.slice(0, split);
        const slot = Number(rest.slice(split + 1));
        return Number.isInteger(slot) && slot > 0 ? { packId, slot } : null;
    }
    function structuredPackSlotToken(packId, slot) { return structuredPackSlotPrefix + packId + ":" + slot; }
    function isCompilerVarargPack(node) {
        const fields = node?.type === "TableConstructorExpression" ? (node.fields || []) : [];
        if (fields.length !== 1 || fields[0]?.type !== "TableValue") return false;
        const selectCall = fields[0].value;
        if (selectCall?.type !== "CallExpression" || !isIdentifier(selectCall.base, "select") || (selectCall.arguments || []).length !== 2) return false;
        if (selectCall.arguments[0]?.type !== "NumericLiteral" || Number(selectCall.arguments[0].value) !== 1) return false;
        const unpackCall = selectCall.arguments[1];
        return unpackCall?.type === "CallExpression" && isIdentifier(unpackCall.base, "unpack") &&
            (unpackCall.arguments || []).length === 1 && isIdentifier(unpackCall.arguments[0], "args");
    }
    function isVarargUnpack(node, env) {
        return node?.type === "CallExpression" && isIdentifier(node.base, "unpack") &&
            (node.arguments || []).length === 1 && isIdentifier(node.arguments[0]) &&
            resolveId(node.arguments[0].name, env) === varargPackMarker;
    }
    // A source value may be held in a register until one terminal cleanup,
    // even though its last real use is an earlier call.  Remember those
    // already-emitted epochs so the eventual compiler nil write does not
    // append a duplicate declaration or reorder it after the call.
    const earlyCleanupPending = new Set();
    // In conditional recovery, some cleanup-backed registers are source
    // storage rather than compiler value accumulators. They are proven below
    // only when multiple definitions converge and the merged storage is read
    // as an ordinary value after the join.
    const persistentStorageRegs = new Set();
    const out = [];
    const terminalCandidates = [];
    const parameterNames = [];
    const reservedBindingNames = new Set();
    if (captureNames) {
        for (const value of captureNames.values()) if (typeof value === "string" && isLuaIdentifier(value)) reservedBindingNames.add(value);
    }
    let nextValueSuffix = 1;
    let nextTableSuffix = 1;
    let valueCount = 0;
    let tableCount = 0;
    let conditionalIfCount = 0;
    let lastRootConditionalJoinId = null;
    let sawVarargs = false;

    function allocateValueDisplay() {
        let display;
        do display = `v${nextValueSuffix++}`; while (reservedBindingNames.has(display));
        reservedBindingNames.add(display);
        valueCount++;
        return display;
    }
    function allocateTableDisplay() {
        let display;
        do display = `t${nextTableSuffix++}`; while (reservedBindingNames.has(display));
        reservedBindingNames.add(display);
        tableCount++;
        return display;
    }
    function parameterName(index) {
        if (!renderAsFunction || !Number.isInteger(index) || index < 1) return null;
        while (parameterNames.length < index) {
            let display;
            do display = `v${nextValueSuffix++}`; while (reservedBindingNames.has(display));
            reservedBindingNames.add(display);
            parameterNames.push(display);
        }
        return parameterNames[index - 1];
    }
    function capturedSlotName(node) {
        if (!captureNames || node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalueValues")) return null;
        const slotExpr = node.index;
        if (slotExpr?.type !== "IndexExpression" || !isIdentifier(slotExpr.base, "upvalues") || slotExpr.index?.type !== "NumericLiteral") return null;
        const slot = Number(slotExpr.index.value);
        if (!Number.isInteger(slot) || slot < 1) return null;
        return captureNames.get(slot) ?? null;
    }
    function forwardedCaptureName(node) {
        if (!captureNames || node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalues") || node.index?.type !== "NumericLiteral") return null;
        const slot = Number(node.index.value);
        if (!Number.isInteger(slot) || slot < 1) return null;
        return captureNames.get(slot) ?? null;
    }

    function displayLocal(reg) { return localNames.get(reg) || reg; }
    function activeLocalDisplay(name, env) {
        const value = env.get(name);
        if (typeof value === "string" && pathLocalBindingNames.has(value)) return value;
        if (locals.has(name)) {
            const display = displayLocal(name);
            if (value === display) return display;
        }
        return null;
    }
    function hasActiveLocal(name, env) { return activeLocalDisplay(name, env) !== null; }
    function resolveId(name, env) {
        const active = activeLocalDisplay(name, env);
        if (active !== null) return active;
        return env.get(name) ?? null;
    }
    function resolveRenderableId(name, env) {
        const value = resolveId(name, env);
        if (structuredPackId(value) || structuredPackSlot(value) || value === varargPackMarker) return null;
        return value;
    }
    function render(rhs, env, provenRecursive = false) {
        if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(source, rhs);
        if (rhs?.type === "TableConstructorExpression") return renderTableFields(rhs.fields || [], node => render(node, env, provenRecursive));
        if (isIdentifier(rhs)) return resolveRenderableId(rhs.name, env);
        const capturedSlot = capturedSlotName(rhs);
        if (typeof capturedSlot === "string") return capturedSlot;
        if (renderAsFunction && rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "args") && rhs.index?.type === "NumericLiteral") {
            return parameterName(Number(rhs.index.value));
        }
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index)) {
            return upvalueCellBindings.get(rhs.index.name) ?? null;
        }
        if (provenRecursive && rhs?.type === "IndexExpression" && !isIdentifier(rhs.base)) {
            const base = render(rhs.base, env, true);
            const key = isIdentifier(rhs.index) ? resolveRenderableId(rhs.index.name, env)
                : (isPrimitiveLiteral(rhs.index) ? sourceOf(source, rhs.index) : render(rhs.index, env, true));
            if (typeof base !== "string" || typeof key !== "string" || structuredPackId(base) || structuredPackSlot(base) || base === varargPackMarker) return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
        }
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base)) {
            const key = isIdentifier(rhs.index) ? resolveRenderableId(rhs.index.name, env)
                : (provenRecursive && isPrimitiveLiteral(rhs.index) ? sourceOf(source, rhs.index) : null);
            if (key == null) return null;
            if (rhs.base.name === "_env") {
                const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
            }
            const base = resolveRenderableId(rhs.base.name, env);
            if (base == null) return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
        }
        if (rhs?.type === "UnaryExpression") {
            const argument = provenRecursive ? render(rhs.argument, env, true)
                : (isIdentifier(rhs.argument) ? resolveRenderableId(rhs.argument.name, env) : (isPrimitiveLiteral(rhs.argument) ? sourceOf(source, rhs.argument) : null));
            return renderUnary(rhs.operator, argument);
        }
        if ((provenRecursive || (rhs?.type === "LogicalExpression" && rhs.freshCompilerLogical === true)) &&
            (rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
            const left = render(rhs.left, env, true);
            const right = render(rhs.right, env, true);
            if (left == null || right == null) return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if ((rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
            const left = isIdentifier(rhs.left) ? resolveRenderableId(rhs.left.name, env) : (isPrimitiveLiteral(rhs.left) ? sourceOf(source, rhs.left) : null);
            const right = isIdentifier(rhs.right) ? resolveRenderableId(rhs.right.name, env) : (isPrimitiveLiteral(rhs.right) ? sourceOf(source, rhs.right) : null);
            if (left == null || right == null) return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "CallExpression") {
            if (renderAsFunction && isVarargUnpack(rhs, env)) {
                sawVarargs = true;
                return "...";
            }
            if (renderAsFunction && isIdentifier(rhs.base, "select") && (rhs.arguments || []).length === 2 &&
                rhs.arguments[0]?.type === "NumericLiteral" && Number(rhs.arguments[0].value) === 1 &&
                rhs.arguments[1]?.type === "CallExpression" && isIdentifier(rhs.arguments[1].base, "unpack") &&
                (rhs.arguments[1].arguments || []).length === 1 && isIdentifier(rhs.arguments[1].arguments[0], "args")) {
                sawVarargs = true;
                return "...";
            }
            if (renderAsFunction && isIdentifier(rhs.base, "unpack") && (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0], "args")) {
                sawVarargs = true;
                return "...";
            }
            if (isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name) && typeof options.renderCapturedCall === "function") {
                const args = rhs.arguments || [];
                const fields = args[1]?.type === "TableConstructorExpression" ? (args[1].fields || []) : [];
                if (fields.length > 0) {
                    const captureNames = new Map();
                    for (let i = 0; i < fields.length; i++) {
                        const field = fields[i];
                        if (field?.type !== "TableValue") return null;
                        let captureName = null;
                        if (isIdentifier(field.value)) captureName = upvalueCellBindings.get(field.value.name) ?? null;
                        else captureName = forwardedCaptureName(field.value);
                        if (typeof captureName !== "string") return null;
                        captureNames.set(i + 1, captureName);
                    }
                    const captured = options.renderCapturedCall(rhs, captureNames);
                    if (typeof captured === "string") return captured;
                    return null;
                }
            }
            if (typeof options.renderSpecialCall === "function") {
                const special = options.renderSpecialCall(rhs);
                if (typeof special === "string") return special;
            }
            const base = isIdentifier(rhs.base) ? resolveRenderableId(rhs.base.name, env)
                : (provenRecursive ? render(rhs.base, env, true) : null);
            if (base == null) return null;
            const args = [];
            for (const arg of rhs.arguments || []) {
                let value = null;
                if (renderAsFunction && isVarargUnpack(arg, env)) {
                    sawVarargs = true;
                    value = "...";
                } else {
                    value = provenRecursive ? render(arg, env, true)
                        : (isIdentifier(arg) ? resolveRenderableId(arg.name, env) : (isPrimitiveLiteral(arg) ? sourceOf(source, arg) : null));
                }
                if (value == null || structuredPackId(value) || structuredPackSlot(value) || value === varargPackMarker) return null;
                args.push(value);
            }
            const callable = /^function\b/.test(base.trim()) ? "(" + base + ")" : base;
            return callable + "(" + args.join(", ") + ")";
        }
        return null;
    }

    function nodeReadsIdentifier(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeReadsIdentifier(item, name))) return true;
            } else if (value && typeof value === "object" && nodeReadsIdentifier(value, name)) return true;
        }
        return false;
    }

    function nodeUsesAsCallBaseMulti(node, name) {
        if (!node || typeof node !== "object") return false;
        if (node.type === "CallExpression" && isIdentifier(node.base, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeUsesAsCallBaseMulti(item, name))) return true;
            } else if (value && typeof value === "object" && nodeUsesAsCallBaseMulti(value, name)) return true;
        }
        return false;
    }

    function terminalStableUsedEpoch(startBlockId, startIndex, name) {
        const uses = new Map();
        const seen = new Set();
        const stack = [{ blockId: startBlockId, index: startIndex + 1 }];
        let invalid = false;
        while (stack.length && !invalid) {
            const cursor = stack.pop();
            const visitKey = `${cursor.blockId}:${cursor.index}`;
            if (seen.has(visitKey)) continue;
            seen.add(visitKey);
            const block = blocks.get(cursor.blockId);
            if (!block) return false;
            for (let i = cursor.index; i < block.body.length; i++) {
                if (i === block.transitionIndex) continue;
                const statement = block.body[i];
                if (!isSingleAssignment(statement)) return false;
                const dest = statement.variables[0];
                const rhs = statement.init[0];
                if (isIdentifier(dest, name)) { invalid = true; break; }
                if (isIdentifier(dest, stateName) && isIdentifier(rhs, name)) { invalid = true; break; }
                const ordinaryUse = nodeReadsIdentifier(rhs, name) ||
                    (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name));
                if (ordinaryUse) {
                    uses.set(`${cursor.blockId}:${i}`, {
                        delayed: cursor.blockId !== startBlockId || i > startIndex + 1,
                        callBase: nodeUsesAsCallBaseMulti(rhs, name),
                        logical: rhs?.type === "LogicalExpression" && nodeReadsIdentifier(rhs, name),
                    });
                }
            }
            if (invalid) break;
            if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
                uses.set(`${cursor.blockId}:branch`, { delayed: cursor.blockId !== startBlockId, callBase: false, logical: true });
            }
            for (const next of successors.get(cursor.blockId) || []) stack.push({ blockId: next, index: 0 });
        }
        if (invalid || uses.size === 0) return false;
        if (uses.size > 1) return true;
        const only = [...uses.values()][0];
        return only.delayed && !only.callBase && !only.logical;
    }

    function expectedPackSlotsInBlock(block, creationIndex, packReg) {
        const slots = new Set();
        for (let cursor = creationIndex + 1; cursor < block.body.length; cursor++) {
            if (cursor === block.transitionIndex) continue;
            const statement = block.body[cursor];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest, packReg)) break;
            if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, packReg) && rhs.index?.type === "NumericLiteral") {
                const slot = Number(rhs.index.value);
                if (!Number.isInteger(slot) || slot < 1 || slots.has(slot)) return null;
                slots.add(slot);
            }
        }
        if (!slots.size) return null;
        const ordered = [...slots].sort((a,b) => a-b);
        for (let i = 0; i < ordered.length; i++) if (ordered[i] !== i + 1) return null;
        return ordered;
    }

    function cleanupOrTerminalEpoch(blockId, statementIndex, name, visiting = new Set()) {
        const visitKey = blockId + ":" + statementIndex + ":" + name;
        if (visiting.has(visitKey)) return { valid: false, sawCleanup: false };
        const block = blocks.get(blockId);
        if (!block) return { valid: false, sawCleanup: false };
        const nextVisiting = new Set(visiting);
        nextVisiting.add(visitKey);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return { valid: false, sawCleanup: false };
            const dest = statement.variables[0];
            if (!isIdentifier(dest, name)) continue;
            if (statement.init[0]?.type === "NilLiteral") return { valid: true, sawCleanup: true };
            return { valid: false, sawCleanup: false };
        }
        const next = successors.get(blockId) || [];
        if (next.length === 0) return { valid: block.transition.kind === "stop", sawCleanup: false };
        let sawCleanup = false;
        for (const target of next) {
            const child = cleanupOrTerminalEpoch(target, -1, name, nextVisiting);
            if (!child.valid) return { valid: false, sawCleanup: false };
            sawCleanup = sawCleanup || child.sawCleanup;
        }
        return { valid: true, sawCleanup };
    }

    function maybeOwnStructuredPackSlot(pack, slot, reg, blockId, statementIndex) {
        if (!pack || !Number.isInteger(slot) || !isVmRegisterName(reg) || reg === stateName || reg === returnName) return;
        const epochEnd = cleanupOrTerminalEpoch(blockId, statementIndex, reg);
        if (!epochEnd.valid || !valueMayBeReadAfter(blockId, statementIndex, reg)) return;
        const terminalOwned = terminalStableUsedEpoch(blockId, statementIndex, reg);
        const mixedCleanupOwned = epochEnd.sawCleanup;
        if (!mixedCleanupOwned && !terminalOwned) return;
        const info = pack.slots.get(slot);
        if (!info) return;
        if (info.ownerReg && info.ownerReg !== reg) { info.ambiguous = true; return; }
        info.ownerReg = reg;
        info.terminalLive = terminalOwned && !epochEnd.sawCleanup;
    }

    // The scheduler may delay a compiler source-storage handoff until after an
    // earlier semantic use of the same extracted return slot. Prove the first
    // future same-block copy from the still-live carrier into valid source
    // storage so the source multi-local can be emitted before that use.
    function preclaimFutureStructuredPackOwner(pack, slot, carrierReg, blockId, statementIndex) {
        const info = pack?.slots.get(slot);
        const block = blocks.get(blockId);
        if (!info || info.ownerReg || info.ambiguous || !block ||
            !(isVmRegisterName(carrierReg) || carrierReg === stateName || carrierReg === returnName)) return;
        const carriers = new Set([carrierReg]);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            const copiedCarrier = isIdentifier(rhs) && carriers.has(rhs.name);
            if (copiedCarrier && isIdentifier(dest)) {
                maybeOwnStructuredPackSlot(pack, slot, dest.name, blockId, i);
                if (info.ambiguous) return;
                carriers.add(dest.name);
                if (info.ownerReg === dest.name) {
                    info.ownerDeferred = true;
                    structuredPackFutureOwnerCopies.set(blockId + ":" + i, {
                        packId: pack.id,
                        slot,
                        ownerReg: dest.name,
                        carrierReg: rhs.name,
                    });
                    return;
                }
            }
            if (isIdentifier(dest) && carriers.has(dest.name) && !copiedCarrier) carriers.delete(dest.name);
            if (carriers.size === 0) return;
        }
    }

    // Prometheus may delay some pack-slot extraction statements until after
    // a semantic use of an earlier slot. The call has already happened; these
    // static rPack[N] reads and their proven source-storage handoffs are
    // compiler transport. Pre-prove them inside the same block so one source
    // multi-local declaration can exist at the original call position.
    function preclaimFutureStructuredPackSlots(pack, blockId, creationIndex) {
        const block = blocks.get(blockId);
        if (!pack || !block) return false;
        const seen = new Set();
        for (let i = creationIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return false;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest, pack.packReg)) break;
            if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base, pack.packReg) || rhs.index?.type !== "NumericLiteral") continue;
            const slot = Number(rhs.index.value);
            if (!pack.slots.has(slot) || seen.has(slot) || !isIdentifier(dest)) return false;
            seen.add(slot);
            const info = pack.slots.get(slot);
            info.tempRegs.add(dest.name);
            structuredPackFutureExtractions.set(blockId + ":" + i, {
                packId: pack.id,
                slot,
                carrierReg: dest.name,
                packReg: pack.packReg,
            });
            maybeOwnStructuredPackSlot(pack, slot, dest.name, blockId, i);
            if (info.ambiguous) return false;
            if (info.ownerReg === dest.name) info.ownerDeferred = true;
            if (!info.ownerReg) preclaimFutureStructuredPackOwner(pack, slot, dest.name, blockId, i);
            if (info.ambiguous) return false;
        }
        return pack.expectedSlots.every(slot => seen.has(slot));
    }

    function flushStructuredPack(packId, env, markers, effects) {
        const pack = structuredPacks.get(packId);
        if (!pack || pack.emitted) return effects;
        const slots = pack.expectedSlots.map(slot => pack.slots.get(slot));
        if (slots.some(info => !info || info.ambiguous || !info.ownerReg)) return null;
        const ownerRegs = slots.map(info => info.ownerReg);
        if (new Set(ownerRegs).size !== ownerRegs.length) return null;
        const names = [];
        for (const info of slots) {
            let display = info.ownerDeferred ? null : activeLocalDisplay(info.ownerReg, env);
            if (display === null) display = allocateValueDisplay();
            info.display = display;
            names.push(display);
        }
        const line = `local ${names.join(", ")} = ${pack.call}`;
        if (markers.length !== 0) {
            for (const info of slots) pathLocalBindingNames.add(info.display);
            effects = [...effects, line];
        } else {
            out.push(line);
            for (const info of slots) {
                localNames.set(info.ownerReg, info.display);
                locals.add(info.ownerReg);
                if (info.terminalLive) terminalLiveLocals.add(info.ownerReg);
            }
        }
        for (const [reg, value] of [...env.entries()]) {
            if (structuredPackId(value) === packId) {
                env.delete(reg);
                continue;
            }
            const meta = structuredPackSlot(value);
            if (!meta || meta.packId !== packId) continue;
            const info = pack.slots.get(meta.slot);
            if (!info?.display) return null;
            env.set(reg, info.display);
        }
        for (const info of slots) {
            const current = structuredPackSlot(env.get(info.ownerReg));
            if (current?.packId === packId && current.slot === info.slot) env.set(info.ownerReg, info.display);
        }
        pack.emitted = true;
        return effects;
    }

    function flushReadyStructuredPacks(env, markers, effects, requireAll = false) {
        for (const [packId, pack] of structuredPacks) {
            if (pack.emitted) continue;
            const present = [...env.values()].some(value => structuredPackId(value) === packId || structuredPackSlot(value)?.packId === packId);
            if (!present) continue;
            const ready = pack.expectedSlots.every(slot => {
                const info = pack.slots.get(slot);
                return info && !info.ambiguous && !!info.ownerReg;
            });
            if (!ready) { if (requireAll) return null; continue; }
            effects = flushStructuredPack(packId, env, markers, effects);
            if (effects === null) return null;
        }
        return effects;
    }

    function transportSourceKind(block, statementIndex, transportName) {
        for (let i = statementIndex - 1; i >= 0; i--) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement, transportName)) continue;
            return statement.init[0]?.type === "TableConstructorExpression" ? "table" : "value";
        }
        return "value";
    }

    function valueMayBeReadFrom(blockId, name, visiting = new Set()) {
        if (visiting.has(blockId)) return true;
        const block = blocks.get(blockId);
        if (!block) return true;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(blockId);
        for (let i = 0; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return true;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (nodeReadsIdentifier(rhs, name)) return true;
            if (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name)) return true;
            if (isIdentifier(dest, name)) return false;
        }
        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) return true;
        for (const next of successors.get(blockId) || []) {
            if (valueMayBeReadFrom(next, name, nextVisiting)) return true;
        }
        return false;
    }

    // Persistent source storage spans the whole recovered conditional region.
    // Physical registers are reusable, so cleanup evidence on only one sibling
    // path is insufficient: every reachable path from the root must eventually
    // hit the register's nil cleanup. Intermediate non-nil writes are allowed
    // because they are source assignments to the same storage binding.
    const eventualCleanupCache = new Map();
    function eventualCleanupOnAllPaths(blockId, statementIndex, name, visiting = new Set()) {
        const cacheKey = blockId + ":" + statementIndex + ":" + name;
        if (eventualCleanupCache.has(cacheKey)) return eventualCleanupCache.get(cacheKey);
        const visitKey = blockId + ":" + statementIndex + ":" + name;
        if (visiting.has(visitKey)) return false;
        const block = blocks.get(blockId);
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
                eventualCleanupCache.set(cacheKey, true);
                return true;
            }
            // A non-nil write may be another source assignment to the same
            // persistent binding; keep following this path to its cleanup.
        }
        const next = successors.get(blockId) || [];
        if (next.length === 0) {
            eventualCleanupCache.set(cacheKey, false);
            return false;
        }
        const result = next.every(target => eventualCleanupOnAllPaths(target, -1, name, nextVisiting));
        eventualCleanupCache.set(cacheKey, result);
        return result;
    }

    if (allowConditionalIf && accumulatorRegs.size) {
        for (const name of accumulatorRegs) {
            const inDefs = new Map([...reachable].map(id => [id, new Set()]));
            const outDefs = new Map([...reachable].map(id => [id, new Set()]));
            let convergedRead = false;
            let changed = true;
            let rounds = 0;
            while (changed && rounds++ <= reachable.size + 1) {
                changed = false;
                for (const id of reachable) {
                    const incomingDefs = new Set();
                    for (const pred of predecessors.get(id) || []) {
                        if (!reachable.has(pred)) continue;
                        for (const def of outDefs.get(pred) || []) incomingDefs.add(def);
                    }
                    const oldIn = inDefs.get(id);
                    if (oldIn.size !== incomingDefs.size || [...oldIn].some(def => !incomingDefs.has(def))) {
                        inDefs.set(id, incomingDefs);
                        changed = true;
                    }
                    let current = new Set(incomingDefs);
                    const block = blocks.get(id);
                    for (let i = 0; i < block.body.length; i++) {
                        if (i === block.transitionIndex) continue;
                        const statement = block.body[i];
                        if (!isSingleAssignment(statement)) continue;
                        const dest = statement.variables[0];
                        const rhs = statement.init[0];
                        const ordinaryRead = nodeReadsIdentifier(rhs, name) ||
                            (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name));
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
            if (convergedRead && eventualCleanupOnAllPaths(entryId, -1, name)) persistentStorageRegs.add(name);
        }
    }

    // A call-result temporary can be overwritten on the same block or on a
    // later CFG path.  Unlike pure compiler copies, the call itself is a
    // source-level side effect and must not disappear merely because its
    // return value is dead.  Keep this query path-aware so a call is emitted
    // only when every path discards the value before any read.
    const valueReadAfterCache = new Map();
    function valueMayBeReadAfter(blockId, statementIndex, name, visiting = new Set()) {
        const visitKey = `${blockId}:${statementIndex}`;
        if (visiting.has(visitKey)) return true;
        const cacheKey = `${blockId}:${statementIndex}:${name}`;
        if (valueReadAfterCache.has(cacheKey)) return valueReadAfterCache.get(cacheKey);
        const block = blocks.get(blockId);
        if (!block) return true;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(visitKey);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) {
                valueReadAfterCache.set(cacheKey, true);
                return true;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (nodeReadsIdentifier(rhs, name) || (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name))) {
                valueReadAfterCache.set(cacheKey, true);
                return true;
            }
            if (isIdentifier(dest, name)) {
                valueReadAfterCache.set(cacheKey, false);
                return false;
            }
        }
        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
            valueReadAfterCache.set(cacheKey, true);
            return true;
        }
        for (const next of successors.get(blockId) || []) {
            if (valueMayBeReadAfter(next, -1, name, nextVisiting)) {
                valueReadAfterCache.set(cacheKey, true);
                return true;
            }
        }
        valueReadAfterCache.set(cacheKey, false);
        return false;
    }

    const futureNonNilWriteCache = new Map();
    function hasFutureNonNilWrite(blockId, statementIndex, name, visiting = new Set()) {
        const cacheKey = blockId + ":" + statementIndex + ":" + name;
        if (futureNonNilWriteCache.has(cacheKey)) return futureNonNilWriteCache.get(cacheKey);
        const visitKey = blockId + ":" + statementIndex;
        if (visiting.has(visitKey)) return true;
        const block = blocks.get(blockId);
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
            futureNonNilWriteCache.set(cacheKey, result);
            return result;
        }
        for (const next of successors.get(blockId) || []) {
            if (hasFutureNonNilWrite(next, -1, name, nextVisiting)) {
                futureNonNilWriteCache.set(cacheKey, true);
                return true;
            }
        }
        futureNonNilWriteCache.set(cacheKey, false);
        return false;
    }

    const cleanupPathCache = new Map();
    function cleanupReachedOnAllPaths(blockId, statementIndex, name, visiting = new Set()) {
        const cacheKey = blockId + ":" + statementIndex + ":" + name;
        if (cleanupPathCache.has(cacheKey)) return cleanupPathCache.get(cacheKey);
        const visitKey = blockId + ":" + statementIndex + ":" + name;
        if (visiting.has(visitKey)) return false;
        const block = blocks.get(blockId);
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
            cleanupPathCache.set(cacheKey, result);
            return result;
        }
        const next = successors.get(blockId) || [];
        if (next.length === 0) {
            cleanupPathCache.set(cacheKey, false);
            return false;
        }
        const result = next.every(target => cleanupReachedOnAllPaths(target, -1, name, nextVisiting));
        cleanupPathCache.set(cacheKey, result);
        return result;
    }

    function mergeElseIfCandidates(candidates, joinId) {
        if (!allowConditionalIf || candidates.length < 3) return null;
        const markerLists = candidates.map(candidate => candidate.markers || []);
        let sharedPrefix = 0;
        while (true) {
            const first = markerLists[0][sharedPrefix];
            if (!first) break;
            if (!markerLists.every(markers => {
                const marker = markers[sharedPrefix];
                return marker && marker.condition === first.condition && marker.truth === first.truth && marker.effectCount === first.effectCount && marker.branchId === first.branchId;
            })) break;
            sharedPrefix++;
        }

        const chainLength = candidates.length - 1;
        const branchByDepth = new Map();
        let finalElse = null;
        let baseEffectCount = null;

        for (let candidateIndex = 0; candidateIndex < candidates.length; candidateIndex++) {
            const candidate = candidates[candidateIndex];
            const markers = markerLists[candidateIndex];
            const suffix = markers.slice(sharedPrefix);
            if (suffix.length < 1 || suffix.length > chainLength) return null;
            for (let depth = 0; depth < suffix.length - 1; depth++) {
                if (suffix[depth].truth !== false) return null;
            }
            const leaf = suffix[suffix.length - 1];
            if (!leaf || !Number.isInteger(leaf.effectCount)) return null;
            if (baseEffectCount === null) baseEffectCount = leaf.effectCount;
            if (leaf.effectCount !== baseEffectCount) return null;
            for (const marker of suffix) {
                if (!Number.isInteger(marker.effectCount) || marker.effectCount !== baseEffectCount) return null;
            }
            if (leaf.truth === true) {
                const depth = suffix.length;
                if (branchByDepth.has(depth)) return null;
                branchByDepth.set(depth, candidate);
            } else {
                if (suffix.length !== chainLength || finalElse) return null;
                finalElse = candidate;
            }
        }
        if (!finalElse || branchByDepth.size !== chainLength) return null;
        for (let depth = 1; depth <= chainLength; depth++) if (!branchByDepth.has(depth)) return null;

        const conditions = [];
        const conditionBranchIds = [];
        for (let depth = 1; depth <= chainLength; depth++) {
            const candidate = branchByDepth.get(depth);
            const suffix = (candidate.markers || []).slice(sharedPrefix);
            for (let i = 0; i < depth - 1; i++) {
                if (suffix[i].condition !== conditions[i] || suffix[i].truth !== false || suffix[i].branchId !== conditionBranchIds[i]) return null;
            }
            const marker = suffix[depth - 1];
            if (!marker || marker.truth !== true) return null;
            conditions.push(marker.condition);
            conditionBranchIds.push(marker.branchId);
        }
        const elseSuffix = (finalElse.markers || []).slice(sharedPrefix);
        for (let i = 0; i < chainLength; i++) {
            if (elseSuffix[i].condition !== conditions[i] || elseSuffix[i].truth !== false || elseSuffix[i].branchId !== conditionBranchIds[i]) return null;
        }

        const ordered = [];
        for (let depth = 1; depth <= chainLength; depth++) ordered.push(branchByDepth.get(depth));
        ordered.push(finalElse);
        const env = new Map();
        const keys = new Set();
        for (const candidate of ordered) for (const key of candidate.env.keys()) keys.add(key);
        keys.delete(stateName);
        for (const key of keys) {
            const values = ordered.map(candidate => candidate.env.get(key));
            const first = values[0];
            if (values.every(value => value === first)) {
                if (first !== undefined) env.set(key, first);
                continue;
            }
            if (!valueMayBeReadFrom(joinId, key)) continue;
            return null;
        }

        const commonEffects = (ordered[0].effects || []).slice(0, baseEffectCount);
        for (const candidate of ordered) {
            const effects = candidate.effects || [];
            if (effects.length < baseEffectCount) return null;
            for (let i = 0; i < baseEffectCount; i++) if (effects[i] !== commonEffects[i]) return null;
        }
        const bodies = ordered.map(candidate => (candidate.effects || []).slice(baseEffectCount));
        // Empty source clauses are valid. Once the elseif marker chain and join are
        // structurally proven, preserve the empty clause so condition evaluation is kept.
        const lines = [];
        for (let depth = 0; depth < chainLength; depth++) {
            lines.push(`${depth === 0 ? "if" : "elseif"} ${conditions[depth]} then`);
            for (const effect of bodies[depth]) lines.push(indentConditionalEffect(effect));
        }
        const finalBranch = blocks.get(conditionBranchIds[chainLength - 1]);
        const explicitElse = finalBranch?.transition?.kind === "branch" && finalBranch.transition.onFalse !== joinId;
        if (explicitElse || bodies[chainLength].length > 0) {
            lines.push("else");
            for (const effect of bodies[chainLength]) lines.push(indentConditionalEffect(effect));
        }
        lines.push("end");
        const structured = lines.join("\n");
        if (sharedPrefix === 0) {
            if (!recordRootConditional(conditionBranchIds[0], joinId)) return null;
            out.push(structured);
            return { env, markers: [], effects: commonEffects };
        }
        return {
            env,
            markers: markerLists[0].slice(0, sharedPrefix),
            effects: [...commonEffects, structured],
        };
    }

    function indentConditionalEffect(text, prefix = "    ") {
        return String(text).split("\n").map(line => prefix + line).join("\n");
    }

    function markersSharePrefix(aMarkers, bMarkers, length) {
        if (aMarkers.length < length || bMarkers.length < length) return false;
        for (let i = 0; i < length; i++) {
            const a = aMarkers[i], b = bMarkers[i];
            if (!a || !b || a.condition !== b.condition || a.truth !== b.truth || a.effectCount !== b.effectCount || a.branchId !== b.branchId) return false;
        }
        return true;
    }

    function terminalSiblingMatch(a, b) {
        const am = a.markers || [], bm = b.markers || [];
        if (am.length === 0 || am.length !== bm.length || !markersSharePrefix(am, bm, am.length - 1)) return null;
        const al = am[am.length - 1], bl = bm[bm.length - 1];
        if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth || al.effectCount !== bl.effectCount || al.branchId !== bl.branchId) return null;
        const effectPrefix = al.effectCount;
        const ae = a.effects || [], be = b.effects || [];
        if (!Number.isInteger(effectPrefix) || effectPrefix > ae.length || effectPrefix > be.length) return null;
        for (let i = 0; i < effectPrefix; i++) if (ae[i] !== be[i]) return null;
        return { al, bl, effectPrefix };
    }

    function guardLine(condition, truth, bodyEffects) {
        if (!Array.isArray(bodyEffects) || bodyEffects.length === 0) return null;
        const test = truth ? condition : `(not ${condition})`;
        const body = bodyEffects.map(line => indentConditionalEffect(line)).join("\n");
        return `if ${test} then\n${body}\nend`;
    }

    function collapseTerminalCandidates() {
        let changed = true;
        while (changed) {
            changed = false;
            outer: for (let i = 0; i < terminalCandidates.length; i++) {
                for (let j = i + 1; j < terminalCandidates.length; j++) {
                    const a = terminalCandidates[i], b = terminalCandidates[j];
                    const match = terminalSiblingMatch(a, b);
                    if (!match) continue;
                    const trueCandidate = match.al.truth ? a : b;
                    const falseCandidate = match.al.truth ? b : a;
                    const guard = guardLine(match.al.condition, true, (trueCandidate.effects || []).slice(match.effectPrefix));
                    if (!guard) return false;
                    const merged = {
                        env: new Map(falseCandidate.env),
                        markers: (falseCandidate.markers || []).slice(0, -1),
                        effects: [
                            ...(falseCandidate.effects || []).slice(0, match.effectPrefix),
                            guard,
                            ...(falseCandidate.effects || []).slice(match.effectPrefix),
                        ],
                        terminal: true,
                    };
                    terminalCandidates.splice(j, 1);
                    terminalCandidates.splice(i, 1, merged);
                    changed = true;
                    break outer;
                }
            }
        }
        return true;
    }

    function foldTerminalGuards(candidate) {
        let current = {
            env: new Map(candidate.env),
            markers: [...(candidate.markers || [])],
            effects: [...(candidate.effects || [])],
        };
        while (current.markers.length > 0) {
            let matchIndex = -1;
            let match = null;
            for (let i = 0; i < terminalCandidates.length; i++) {
                const terminal = terminalCandidates[i];
                const candidateMatch = terminalSiblingMatch(current, terminal);
                if (!candidateMatch) continue;
                matchIndex = i;
                match = candidateMatch;
                break;
            }
            if (matchIndex < 0) break;
            const terminal = terminalCandidates[matchIndex];
            const terminalMarker = terminal.markers[terminal.markers.length - 1];
            const guard = guardLine(terminalMarker.condition, terminalMarker.truth, (terminal.effects || []).slice(match.effectPrefix));
            if (!guard) return null;
            const prefixEffects = current.effects.slice(0, match.effectPrefix);
            current = {
                env: new Map(current.env),
                markers: current.markers.slice(0, -1),
                effects: [...prefixEffects, guard, ...current.effects.slice(match.effectPrefix)],
            };
            terminalCandidates.splice(matchIndex, 1);
            if (!collapseTerminalCandidates()) return null;
        }
        return current;
    }

    function mergeCandidates(candidates, joinId) {
        if (candidates.length === 1) return {
            env: new Map(candidates[0].env),
            markers: [...(candidates[0].markers || [])],
            effects: [...(candidates[0].effects || [])],
        };
        if (candidates.length > 2) return mergeElseIfCandidates(candidates, joinId);
        if (candidates.length !== 2) return null;
        const a = candidates[0], b = candidates[1];
        const am = a.markers || [], bm = b.markers || [];
        let prefix = 0;
        while (prefix < am.length && prefix < bm.length && am[prefix].condition === bm[prefix].condition && am[prefix].truth === bm[prefix].truth && am[prefix].branchId === bm[prefix].branchId) prefix++;
        if (am.length !== prefix + 1 || bm.length !== prefix + 1) return null;
        const al = am[prefix], bl = bm[prefix];
        if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth || al.branchId !== bl.branchId) return null;
        const t = al.truth ? a : b;
        const f = al.truth ? b : a;
        const cond = al.condition;
        const te = t.effects || [], fe = f.effects || [];
        if (!Number.isInteger(al.effectCount) || al.effectCount !== bl.effectCount) return null;
        const effectPrefix = al.effectCount;
        if (effectPrefix > te.length || effectPrefix > fe.length) return null;
        for (let i = 0; i < effectPrefix; i++) if (te[i] !== fe[i]) return null;
        const trueEffects = te.slice(effectPrefix), falseEffects = fe.slice(effectPrefix);
        const hasConditionalEffects = trueEffects.length > 0 || falseEffects.length > 0;
        if (hasConditionalEffects && !allowConditionalIf) return null;
        const branchBlock = blocks.get(al.branchId);
        const branchTransition = branchBlock?.transition;
        const branchCarriesLogicalResult = !!(branchBlock && branchTransition?.kind === "branch" &&
            branchBlock.body.some((statement, index) => {
                if (index === branchBlock.transitionIndex || !isSingleAssignment(statement)) return false;
                const dest = statement.variables[0];
                const rhs = statement.init[0];
                return isIdentifier(dest) && dest.name !== stateName && isIdentifier(rhs, branchTransition.conditionRegister);
            }));
        const trueDirectJoin = branchTransition?.kind === "branch" && branchTransition.onTrue === joinId;
        const falseDirectJoin = branchTransition?.kind === "branch" && branchTransition.onFalse === joinId;
        const explicitTrueArm = branchTransition?.kind === "branch" && !trueDirectJoin;
        const explicitFalseArm = branchTransition?.kind === "branch" && !falseDirectJoin;
        const preserveEmptyStatementBranch = allowConditionalIf && !hasConditionalEffects && !branchCarriesLogicalResult &&
            (explicitTrueArm || explicitFalseArm);
        const keys = new Set([...t.env.keys(), ...f.env.keys()]);
        keys.delete(stateName);
        const env = new Map();
        for (const key of keys) {
            const tv = t.env.get(key);
            const fv = f.env.get(key);
            if (tv === fv) {
                if (tv !== undefined) env.set(key, tv);
                continue;
            }
            if (tv === undefined || fv === undefined) {
                // Path-local TEMP: keep it unknown at the join. A later read
                // before redefinition will still fail closed.
                continue;
            }
            // A path-dependent compiler TEMP that is overwritten before any
            // later read does not participate in source semantics at this
            // join. Drop it before considering logical result-carrier shapes.
            if (!valueMayBeReadFrom(joinId, key)) continue;
            if (fv === cond && tv != null) {
                if (hasConditionalEffects) return null;
                env.set(key, `(${cond} and ${tv})`);
            }
            else if (tv === cond && fv != null) {
                if (hasConditionalEffects) return null;
                env.set(key, `(${cond} or ${fv})`);
            }
            else return null;
        }
        if (hasConditionalEffects || preserveEmptyStatementBranch) {
            let structured;
            if (explicitTrueArm && explicitFalseArm) {
                const trueBody = trueEffects.map(line => indentConditionalEffect(line)).join("\n");
                const falseBody = falseEffects.map(line => indentConditionalEffect(line)).join("\n");
                structured = `if ${cond} then\n${trueBody ? trueBody + "\n" : ""}else\n${falseBody ? falseBody + "\n" : ""}end`;
            } else {
                const useTrueArm = explicitTrueArm || (!explicitFalseArm && trueEffects.length > 0);
                const bodyEffects = useTrueArm ? trueEffects : falseEffects;
                const condition = useTrueArm ? cond : `(not ${cond})`;
                const body = bodyEffects.map(line => indentConditionalEffect(line)).join("\n");
                structured = `if ${condition} then\n${body ? body + "\n" : ""}end`;
            }
            if (prefix === 0) {
                if (!recordRootConditional(al.branchId, joinId)) return null;
                out.push(structured);
            } else {
                return {
                    env,
                    markers: am.slice(0, prefix),
                    effects: [...te.slice(0, effectPrefix), structured],
                };
            }
        }
        return { env, markers: am.slice(0, prefix), effects: te.slice(0, effectPrefix) };
    }

    while (ready.length) {
        const id = ready.shift();
        if (processed.has(id)) continue;
        const candidates = incoming.get(id) || [];
        if (!collapseTerminalCandidates()) return null;
        const normalizedCandidates = [];
        for (const candidate of candidates) {
            const folded = foldTerminalGuards(candidate);
            if (!folded) return null;
            normalizedCandidates.push(folded);
        }
        const merged = mergeCandidates(normalizedCandidates, id);
        if (!merged) return null;
        let env = merged.env;
        let markers = merged.markers;
        let effects = merged.effects || [];
        if (markers.length === 0 && effects.length > 0) {
            out.push(...effects);
            effects = [];
        }
        const block = blocks.get(id);
        let terminalReturnIndex = -1;
        let terminalReturnLine = null;
        const terminalPackExprs = new Map();
        if (block.transition.kind === "stop") {
            for (let i = block.transitionIndex - 1; i >= 0; i--) {
                if (!isSingleAssignment(block.body[i], returnName)) continue;
                if (block.body[i].init[0]?.type !== "TableConstructorExpression") continue;
                terminalReturnIndex = i;
                break;
            }
            if (terminalReturnIndex < 0) return null;
        }
        // Normalized dispatcher invariant: entering this leaf proves state == id.
        // The compiler may borrow/copy POS as an ordinary temporary before the
        // real transition at the end of the block.
        env.set(stateName, String(id));
        env.delete(upvalueAliasKey(stateName));

        for (let i = 0; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];

            if (dest?.type === "IndexExpression") {
                const capturedDestination = capturedSlotName(dest);
                if (typeof capturedDestination === "string") {
                    const value = render(rhs, env);
                    if (typeof value !== "string") return null;
                    const line = capturedDestination + " = " + value;
                    if (markers.length !== 0) {
                        if (!allowConditionalIf) return null;
                        effects = [...effects, line];
                    } else {
                        out.push(line);
                    }
                    continue;
                }
                if (isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index) && upvalueCells.has(dest.index.name)) {
                    const value = render(rhs, env);
                    if (typeof value !== "string") return null;
                    const existing = upvalueCellBindings.get(dest.index.name);
                    if (typeof existing === "string") {
                        const line = existing + " = " + value;
                        if (markers.length !== 0) {
                            if (!allowConditionalIf) return null;
                            effects = [...effects, line];
                        } else {
                            out.push(line);
                        }
                        continue;
                    }
                    // A source local captured by a child closure must have one
                    // dominating initialization before conditional routing.
                    if (markers.length !== 0) return null;
                    const display = allocateValueDisplay();
                    upvalueCellBindings.set(dest.index.name, display);
                    out.push("local " + display + " = " + value);
                    continue;
                }
                if (!isIdentifier(dest.base)) return null;
                const base = resolveId(dest.base.name, env);
                const stableBase = hasActiveLocal(dest.base.name, env) ||
                    (typeof base === "string" && env.get(upvalueAliasKey(dest.base.name)) === base);
                if (!stableBase) return null;
                const key = isIdentifier(dest.index) ? resolveId(dest.index.name, env)
                    : (isPrimitiveLiteral(dest.index) ? sourceOf(source, dest.index) : null);
                const value = render(rhs, env);
                if (base == null || key == null || value == null) return null;
                const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                const target = member && isLuaIdentifier(member) ? base + "." + member : base + "[" + key + "]";
                const line = target + " = " + value;
                if (markers.length !== 0) {
                    if (!allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    out.push(line);
                }
                continue;
            }
            if (!isIdentifier(dest)) return null;
            const name = dest.name;
            const capturedRhsAlias = capturedSlotName(rhs);
            const inheritedUpvalueAlias = typeof capturedRhsAlias === "string"
                ? capturedRhsAlias
                : (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index)
                    ? (upvalueCellBindings.get(rhs.index.name) ?? null)
                    : (isIdentifier(rhs) ? (env.get(upvalueAliasKey(rhs.name)) ?? null) : null));
            env.delete(upvalueAliasKey(name));

            const reservedPackExtraction = structuredPackFutureExtractions.get(id + ":" + i);
            if (reservedPackExtraction) {
                const reservedPack = structuredPacks.get(reservedPackExtraction.packId);
                const reservedInfo = reservedPack?.slots.get(reservedPackExtraction.slot);
                if (reservedPack?.emitted && reservedInfo?.display && name === reservedPackExtraction.carrierReg &&
                    rhs?.type === "IndexExpression" && isIdentifier(rhs.base, reservedPackExtraction.packReg) &&
                    rhs.index?.type === "NumericLiteral" && Number(rhs.index.value) === reservedPackExtraction.slot) {
                    env.set(name, reservedInfo.display);
                    continue;
                }
            }

            const reservedPackOwnerCopy = structuredPackFutureOwnerCopies.get(id + ":" + i);
            if (reservedPackOwnerCopy) {
                const reservedPack = structuredPacks.get(reservedPackOwnerCopy.packId);
                const reservedInfo = reservedPack?.slots.get(reservedPackOwnerCopy.slot);
                if (reservedPack?.emitted && reservedInfo?.display && reservedInfo.ownerReg === name &&
                    isIdentifier(rhs, reservedPackOwnerCopy.carrierReg) && resolveId(rhs.name, env) === reservedInfo.display) {
                    env.set(name, reservedInfo.display);
                    reservedInfo.ownerDeferred = false;
                    continue;
                }
            }

            if (renderAsFunction && isCompilerVarargPack(rhs)) {
                if (name === stateName || name === returnName || hasActiveLocal(name, env)) return null;
                sawVarargs = true;
                env.set(name, varargPackMarker);
                continue;
            }

            if (i !== terminalReturnIndex) {
                const packFields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
                if (packFields.length === 1 && packFields[0]?.type === "TableValue" && packFields[0].value?.type === "CallExpression") {
                    const packed = render(packFields[0].value, env, true);
                    if (typeof packed === "string") terminalPackExprs.set(name, packed);
                    else terminalPackExprs.delete(name);
                } else {
                    terminalPackExprs.delete(name);
                }
            }

            const packFieldsForStructured = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
            const structuredPackCallNode = packFieldsForStructured.length === 1 && packFieldsForStructured[0]?.type === "TableValue" &&
                packFieldsForStructured[0].value?.type === "CallExpression" ? packFieldsForStructured[0].value : null;
            if (structuredPackCallNode && !isCompilerVarargPack(rhs)) {
                const expectedSlots = expectedPackSlotsInBlock(block, i, name);
                if (expectedSlots) {
                    const call = render(structuredPackCallNode, env, true);
                    if (typeof call !== "string") return null;
                    const packId = String(++nextStructuredPackId);
                    const pack = { id: packId, packReg: name, call, expectedSlots, slots: new Map(), emitted: false };
                    for (const slot of expectedSlots) pack.slots.set(slot, { slot, tempRegs: new Set(), ownerReg: null, display: null, ambiguous: false, ownerDeferred: false });
                    structuredPacks.set(packId, pack);
                    if (!preclaimFutureStructuredPackSlots(pack, id, i)) return null;
                    env.set(name, structuredPackPrefix + packId);
                    effects = flushReadyStructuredPacks(env, markers, effects, false);
                    if (effects === null) return null;
                    continue;
                }
            }

            const packIndexMeta = rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && rhs.index?.type === "NumericLiteral"
                ? { packId: structuredPackId(resolveId(rhs.base.name, env)), slot: Number(rhs.index.value) } : null;
            if (packIndexMeta?.packId) {
                const pack = structuredPacks.get(packIndexMeta.packId);
                const info = pack?.slots.get(packIndexMeta.slot);
                if (!pack || !info || pack.emitted) return null;
                info.tempRegs.add(name);
                maybeOwnStructuredPackSlot(pack, packIndexMeta.slot, name, id, i);
                env.set(name, structuredPackSlotToken(packIndexMeta.packId, packIndexMeta.slot));
                if (!info.ownerReg && !info.ambiguous) preclaimFutureStructuredPackOwner(pack, packIndexMeta.slot, name, id, i);
                effects = flushReadyStructuredPacks(env, markers, effects, false);
                if (effects === null) return null;
                continue;
            }

            const copiedPackSlot = isIdentifier(rhs) ? structuredPackSlot(resolveId(rhs.name, env)) : null;
            if (copiedPackSlot) {
                const pack = structuredPacks.get(copiedPackSlot.packId);
                const info = pack?.slots.get(copiedPackSlot.slot);
                if (!pack || !info || pack.emitted) return null;
                info.tempRegs.add(name);
                maybeOwnStructuredPackSlot(pack, copiedPackSlot.slot, name, id, i);
                env.set(name, structuredPackSlotToken(copiedPackSlot.packId, copiedPackSlot.slot));
                if (!info.ownerReg && !info.ambiguous) preclaimFutureStructuredPackOwner(pack, copiedPackSlot.slot, name, id, i);
                effects = flushReadyStructuredPacks(env, markers, effects, false);
                if (effects === null) return null;
                continue;
            }

            // A physical register can be reused after an early source epoch
            // was emitted.  The later definition owns the next cleanup epoch;
            // do not let the old marker suppress that new value.
            if (rhs?.type !== "NilLiteral" && !hasActiveLocal(name, env)) earlyCleanupPending.delete(name);

            if (isIdentifier(rhs, "args") && name !== stateName && name !== returnName) {
                env.set(name, "args");
                continue;
            }
            if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0) {
                if (markers.length !== 0 || upvalueCells.has(name) || hasActiveLocal(name, env)) return null;
                upvalueCells.add(name);
                upvalueCellBindings.delete(name);
                env.delete(name);
                continue;
            }
            if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue") &&
                (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0], name) && upvalueCells.has(name)) {
                upvalueCells.delete(name);
                upvalueCellBindings.delete(name);
                env.delete(name);
                continue;
            }
            if (i === terminalReturnIndex) {
                const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
                const values = [];
                for (const field of fields) {
                    if (field?.type !== "TableValue") return null;
                    let value = null;
                    const node = field.value;
                    if (node?.type === "CallExpression" && isIdentifier(node.base, "unpack") && (node.arguments || []).length === 1 && isIdentifier(node.arguments[0])) {
                        const packReg = node.arguments[0].name;
                        if (terminalPackExprs.has(packReg)) value = terminalPackExprs.get(packReg);
                        else if (resolveId(packReg, env) === "args" || resolveId(packReg, env) === varargPackMarker) { value = "..."; sawVarargs = true; }
                    }
                    if (value === null) value = render(node, env, true);
                    if (typeof value !== "string") return null;
                    values.push(value);
                }
                terminalReturnLine = values.length ? `return ${values.join(", ")}` : "return";
                continue;
            }
            if (name === returnName && isEmptyTable(rhs)) continue;

            const terminalUsedTransportAlias = allowConditionalIf && isVmRegisterName(name) && !cleanupRegs.has(name) &&
                !hasActiveLocal(name, env) && isIdentifier(rhs) && (rhs.name === stateName || rhs.name === returnName) &&
                terminalStableUsedEpoch(id, i, name);
            if (terminalUsedTransportAlias) {
                const value = render(rhs, env);
                if (typeof value !== "string") return null;
                const kind = transportSourceKind(block, i, rhs.name);
                const display = kind === "table" ? allocateTableDisplay() : allocateValueDisplay();
                const declaration = value === "nil" ? `local ${display}` : `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    pathLocalBindingNames.add(display);
                    effects = [...effects, declaration];
                } else {
                    localNames.set(name, display);
                    locals.add(name);
                    terminalLiveLocals.add(name);
                    out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            if (cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
                const activeDisplay = activeLocalDisplay(name, env);
                if (activeDisplay !== null && pathLocalBindingNames.has(activeDisplay)) {
                    env.delete(name);
                    continue;
                }
                if (earlyCleanupPending.has(name)) {
                    earlyCleanupPending.delete(name);
                    locals.delete(name);
                    localNames.delete(name);
                    env.delete(name);
                    continue;
                }
                if (accumulatorRegs.has(name)) {
                    if (persistentStorageRegs.has(name) && locals.has(name)) {
                        locals.delete(name);
                        localNames.delete(name);
                        env.delete(name);
                        continue;
                    }
                    const value = env.get(name);
                    if (value == null) return null;
                    const display = allocateValueDisplay();
                    out.push(`local ${display} = ${value}`);
                    env.delete(name);
                    continue;
                }
                if (!locals.has(name)) return null;
                locals.delete(name);
                localNames.delete(name);
                env.delete(name);
                continue;
            }

            // Function-call statements are represented by a write to a VM
            // temporary (often ReturnVal).  If that result is overwritten
            // without a read, preserve the call itself.  A path-dependent
            // call cannot be represented as a bare source statement here, so
            // fail closed instead of moving it out of its branch.
            if (rhs?.type === "CallExpression" && (!cleanupRegs.has(name) || !valueMayBeReadAfter(id, i, name))) {
                const promotedArguments = [];
                if (markers.length === 0) {
                    for (const argument of rhs.arguments || []) {
                        if (!isIdentifier(argument) || !cleanupRegs.has(argument.name) || locals.has(argument.name) || earlyCleanupPending.has(argument.name)) continue;
                        if (valueMayBeReadAfter(id, i, argument.name)) continue;
                        const argumentValue = env.get(argument.name);
                        if (typeof argumentValue !== "string") return null;
                        const display = allocateValueDisplay();
                        localNames.set(argument.name, display);
                        locals.add(argument.name);
                        out.push(`local ${display} = ${argumentValue}`);
                        env.set(argument.name, display);
                        earlyCleanupPending.add(argument.name);
                        promotedArguments.push(argument.name);
                    }
                }
                const value = render(rhs, env);
                if (value == null) return null;
                if (!valueMayBeReadAfter(id, i, name)) {
                    if (markers.length !== 0) {
                        if (!allowConditionalIf) return null;
                        effects = [...effects, value];
                    } else {
                        out.push(value);
                    }
                    env.delete(name);
                } else {
                    env.set(name, value);
                }
                for (const argumentName of promotedArguments) {
                    locals.delete(argumentName);
                    localNames.delete(argumentName);
                    env.delete(argumentName);
                }
                continue;
            }

            const value = render(rhs, env);
            if (value == null) {
                // Borrowed state/temp writes may be dead before overwrite; only allow
                // an immediate same-register overwrite inside this block.
                const next = block.body[i + 1];
                if (name !== stateName && !hasActiveLocal(name, env) && isSingleAssignment(next, name)) continue;
                return null;
            }

            const stableStorageEpoch = allowConditionalIf && cleanupRegs.has(name) && !locals.has(name) &&
                valueMayBeReadAfter(id, i, name) && !hasFutureNonNilWrite(id, i, name) &&
                cleanupReachedOnAllPaths(id, i, name);
            // A storage binding that survives a conditional join must already
            // exist before entering that conditional. If the same physical
            // register is written on a branch before any active binding exists,
            // that write belongs to an earlier/later TEMP epoch, not to this
            // persistent source lifetime. Only a marker-free definition may
            // start the persistent binding; stable branch-local epochs retain
            // their separate path-scoped proof.
            const startsPersistentStorage = persistentStorageRegs.has(name) && markers.length === 0;
            if ((startsPersistentStorage || stableStorageEpoch) && !hasActiveLocal(name, env)) {
                const display = allocateValueDisplay();
                accumulatorRegs.delete(name);
                const declaration = `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    pathLocalBindingNames.add(display);
                    effects = [...effects, declaration];
                } else {
                    localNames.set(name, display);
                    locals.add(name);
                    out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            const conditionalIfLocalHandoff = allowConditionalIf && cleanupRegs.has(name) && !hasActiveLocal(name, env) &&
                isIdentifier(rhs, stateName) && block.transition.kind === "branch" && block.transition.conditionRegister === name;
            if (conditionalIfLocalHandoff) accumulatorRegs.delete(name);
            if (cleanupRegs.has(name) && !accumulatorRegs.has(name) && !hasActiveLocal(name, env) && isIdentifier(rhs) && rhs.name !== name) {
                const display = rhs?.type === "TableConstructorExpression" ? allocateTableDisplay() : allocateValueDisplay();
                localNames.set(name, display);
                locals.add(name);
                out.push(`local ${display} = ${value}`);
                env.set(name, display);
            } else if (hasActiveLocal(name, env)) {
                const line = `${activeLocalDisplay(name, env)} = ${value}`;
                if (markers.length !== 0) {
                    if (!allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    out.push(line);
                }
                env.set(name, activeLocalDisplay(name, env));
            } else {
                env.set(name, value);
                if (typeof inheritedUpvalueAlias === "string" && value === inheritedUpvalueAlias) {
                    env.set(upvalueAliasKey(name), inheritedUpvalueAlias);
                }
            }
        }

        effects = flushReadyStructuredPacks(env, markers, effects, true);
        if (effects === null) return null;
        for (const value of env.values()) {
            if (structuredPackId(value) || structuredPackSlot(value)) return null;
        }

        processed.add(id);
        const tr = block.transition;
        const sends = [];
        if (tr.kind === "stop") {
            if (terminalReturnLine === null) return null;
            terminalCandidates.push({
                env: new Map(env),
                markers: [...markers],
                effects: [...effects, terminalReturnLine],
                terminal: true,
            });
            if (!collapseTerminalCandidates()) return null;
        } else if (tr.kind === "jump") sends.push({ target: tr.target, env, markers, effects });
        else if (tr.kind === "branch") {
            const condition = resolveId(tr.conditionRegister, env);
            if (condition == null) return null;
            const effectCount = effects.length;
            sends.push({ target: tr.onTrue, env, markers: [...markers, { condition, truth: true, effectCount, branchId: id }], effects });
            sends.push({ target: tr.onFalse, env, markers: [...markers, { condition, truth: false, effectCount, branchId: id }], effects });
        }
        for (const send of sends) {
            if (!incoming.has(send.target)) incoming.set(send.target, []);
            incoming.get(send.target).push({
                env: new Map(send.env),
                markers: [...(send.markers || [])],
                effects: [...(send.effects || [])],
            });
            indegree.set(send.target, indegree.get(send.target) - 1);
            if (indegree.get(send.target) === 0) ready.push(send.target);
        }
    }

    if (!collapseTerminalCandidates()) return null;
    if (terminalCandidates.length !== 1 || (terminalCandidates[0].markers || []).length !== 0) return null;
    const terminalEffects = [...(terminalCandidates[0].effects || [])];
    // Compiler fallthrough and an explicit empty return share the same final VM
    // bookkeeping.  At root terminal scope a trailing bare return is therefore
    // not provably source-authored; omit only that final redundant marker.
    if (terminalEffects[terminalEffects.length - 1] === "return") terminalEffects.pop();
    for (const effect of terminalEffects) out.push(effect);
    for (const name of terminalLiveLocals) {
        locals.delete(name);
        localNames.delete(name);
    }
    if (processed.size !== reachable.size || locals.size !== 0 || out.length === 0) return null;
    if (allowConditionalIf && conditionalIfCount < 1) {
        if (!out.some(line => /^if\s/.test(line))) return null;
        conditionalIfCount = 1;
    }
    let outputSource = out.join("\n") + "\n";
    if (renderAsFunction) {
        const params = [...parameterNames];
        if (sawVarargs) params.push("...");
        const body = out.map(line => String(line).split("\n").map(part => "    " + part).join("\n")).join("\n");
        outputSource = `function(${params.join(", ")})${body ? "\n" + body + "\n" : ""}end`;
    }
    return {
        source: outputSource,
        statementCount: out.length,
        localCount: valueCount + tableCount,
        stateCount: rootReachableOnly ? logicalReduction.originalReachableStateIds.size : originalLeaves.size,
        reachableStateIds: [...logicalReduction.originalReachableStateIds],
        conditionalIfCount,
    };
}

module.exports = { matchMultiStateLogicalLocals };
