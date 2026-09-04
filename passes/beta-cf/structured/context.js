"use strict";

const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { createStateGraph } = require("../cfg");
const { extractNormalizedStateLeaves } = require("../normalize");
const { reduceCompilerLogicalStateGraph } = require("../logical");

function createStructuredContext(source, stateWhile, stateName, returnName, options = {}) {
    const allowConditionalIf = options.allowConditionalIf === true;
    const rootReachableOnly = options.rootReachableOnly === true;
    const entryId = Number.isInteger(options.entryId) ? options.entryId : 1;
    const captureNames = options.captureNames instanceof Map ? options.captureNames : null;
    const renderAsFunction = options.renderAsFunction === true;
    const originalLeaves = options.normalizedLeaves instanceof Map
        ? new Map([...options.normalizedLeaves].map(([id, body]) => [id, [...body]]))
        : extractNormalizedStateLeaves(stateWhile, stateName);
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

    const indegree = new Map();
    for (const id of reachable) indegree.set(id, (predecessors.get(id) || []).filter(p => reachable.has(p)).length);
    const processingQueue = [entryId];
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
    // A source value may be held in a register until one terminal cleanup,
    // even though its last real use is an earlier call.  Remember those
    // already-emitted epochs so the eventual compiler nil write does not
    // append a duplicate declaration or reorder it after the call.
    const earlyCleanupPending = new Set();
    // In conditional recovery, some cleanup-backed registers are source
    // storage rather than compiler value accumulators. The ordinary proof
    // discovers them from converged definitions/read-after-join. Loop recovery
    // can additionally prove a binding from the original back-edge before the
    // graph is made acyclic; only cleanup-backed accumulator epochs are accepted.
    const persistentStorageRegs = new Set();
    const forcedPersistentStorageRegs = options.forcedPersistentStorageRegs instanceof Set
        ? options.forcedPersistentStorageRegs : null;
    if (forcedPersistentStorageRegs) {
        for (const name of forcedPersistentStorageRegs) {
            if (cleanupRegs.has(name) && accumulatorRegs.has(name)) persistentStorageRegs.add(name);
        }
    }
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

    const eventualCleanupCache = new Map();
    // A call-result temporary can be overwritten on the same block or on a
    // later CFG path.  Unlike pure compiler copies, the call itself is a
    // source-level side effect and must not disappear merely because its
    // return value is dead.  Keep this query path-aware so a call is emitted
    // only when every path discards the value before any read.
    const valueReadAfterCache = new Map();
    const futureNonNilWriteCache = new Map();
    const cleanupPathCache = new Map();
    // Every mutable solver concern is carried explicitly across module boundaries.
    return {
        structuredPackFutureOwnerCopies,
        structuredPackFutureExtractions,
        lastRootConditionalJoinId,
        structuredPackSlotPrefix,
        futureNonNilWriteCache,
        nonNilDefinitionCount,
        pathLocalBindingNames,
        persistentStorageRegs,
        structuredPackPrefix,
        nextStructuredPackId,
        reservedBindingNames,
        eventualCleanupCache,
        upvalueCellBindings,
        earlyCleanupPending,
        valueReadAfterCache,
        allowConditionalIf,
        terminalLiveLocals,
        upvalueAliasPrefix,
        terminalCandidates,
        conditionalIfCount,
        rootReachableOnly,
        renderAsFunction,
        logicalReduction,
        varargPackMarker,
        cleanupPathCache,
        accumulatorRegs,
        processingQueue,
        structuredPacks,
        nextValueSuffix,
        nextTableSuffix,
        originalLeaves,
        parameterNames,
        captureNames,
        predecessors,
        upvalueCells,
        cleanupRegs,
        stateWhile,
        returnName,
        successors,
        localNames,
        valueCount,
        tableCount,
        sawVarargs,
        stateName,
        reachable,
        processed,
        indegree,
        incoming,
        options,
        entryId,
        source,
        leaves,
        blocks,
        locals,
        graph,
        out
    };
}

module.exports = { createStructuredContext };
