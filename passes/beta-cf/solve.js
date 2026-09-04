"use strict";

const { findVmFunction } = require("../vm-state");
const { findVmReturnRegister } = require("../vm-register-names");
const { isIdentifier } = require("./ast");
const {
    extractNormalizedStateLeaves,
    findStateWhile,
    normalizeRegisterOverflowGraph,
    unwrapSingleStateLeaf,
} = require("./normalize");
const { matchClosureEntryProgram } = require("./closures");
const { matchDirectGlobalCallLeaf } = require("./direct-calls");
const { matchLocalRegisterProgram } = require("./linear/solver");
const { flattenLogicalRootLeaf } = require("./logical");
const { matchMultiStateLogicalLocals } = require("./structured/solver");
const { failure, unsupportedMultiState } = require("./diagnostics");

function recoverClosure(ctx) {
    const program = matchClosureEntryProgram(ctx.source, ctx.stateWhile, ctx.stateName, ctx.returnName, ctx.closureDiagnostics);
    if (!program) return null;
    return {
        applied: true,
        mode: "fresh-closure-entry",
        source: program.source,
        stateCount: program.stateCount,
        statementCount: program.statementCount,
        branchCount: 0,
        localCount: program.localCount,
        closureCount: program.closureCount,
    };
}

function recoverFlattenedLogical(ctx) {
    const leaves = ctx.logicalLeaves;
    if (!leaves || leaves.size <= 1 || !leaves.has(1)) return null;
    const flattened = flattenLogicalRootLeaf(leaves, 1, ctx.stateName, ctx.returnName);
    if (!flattened || flattened.consumed.size !== leaves.size) return null;
    const program = matchLocalRegisterProgram(ctx.source, flattened.leaf, ctx.stateName, ctx.returnName);
    if (!program) return null;
    return {
        applied: true,
        mode: "fresh-multistate-logical",
        source: program.source,
        stateCount: leaves.size,
        statementCount: program.statementCount,
        branchCount: leaves.size - 1,
        localCount: program.localCount,
    };
}

function recoverStructuredLogical(ctx) {
    const program = matchMultiStateLogicalLocals(ctx.source, ctx.stateWhile, ctx.stateName, ctx.returnName);
    if (!program) return null;
    return {
        applied: true,
        mode: "fresh-multistate-logical",
        source: program.source,
        stateCount: program.stateCount,
        statementCount: program.statementCount,
        branchCount: program.stateCount - 1,
        localCount: program.localCount,
    };
}

function recoverConditional(ctx) {
    const program = matchMultiStateLogicalLocals(ctx.source, ctx.stateWhile, ctx.stateName, ctx.returnName, { allowConditionalIf: true });
    if (!program) return null;
    return {
        applied: true,
        mode: "fresh-simple-if",
        source: program.source,
        stateCount: program.stateCount,
        statementCount: program.statementCount,
        branchCount: 1,
        localCount: program.localCount,
    };
}

function recoverLinear(ctx) {
    const program = matchLocalRegisterProgram(ctx.source, ctx.leaf, ctx.stateName, ctx.returnName);
    return program && { applied: true, mode: "fresh-register-locals", source: program.source, stateCount: 1, statementCount: program.statementCount, branchCount: 0, localCount: program.localCount };
}

function recoverDirectCalls(ctx) {
    const calls = matchDirectGlobalCallLeaf(ctx.source, ctx.leaf, ctx.stateName, ctx.returnName);
    return calls && {
        applied: true,
        mode: "fresh-direct-global-call",
        source: calls.source,
        stateCount: 1,
        statementCount: calls.callCount,
        branchCount: 0,
        globalName: calls.globalName,
        argumentCount: calls.argumentCount,
        callCount: calls.callCount,
    };
}

function recoverCallResults(ctx) {
    const program = matchLocalRegisterProgram(ctx.source, ctx.leaf, ctx.stateName, ctx.returnName, { allowNoLocals: true });
    return program && { applied: true, mode: "fresh-call-results", source: program.source, stateCount: 1, statementCount: program.statementCount, branchCount: 0, localCount: program.localCount };
}

const MULTI_STATE_RECOVERERS = [recoverClosure, recoverFlattenedLogical, recoverStructuredLogical, recoverConditional];
const LINEAR_RECOVERERS = [recoverLinear, recoverDirectCalls, recoverCallResults];

function solveFreshSource(source, ast) {
    if (typeof source !== "string" || !ast) return failure("Fresh beta CF requires normal output source and AST");
    const vm = findVmFunction(ast);
    if (!vm) return failure("Fresh beta CF: no semantically named vm function");
    const overflow = normalizeRegisterOverflowGraph(vm.functionNode);
    if (overflow.unsupported > 0) return failure("Fresh beta CF: dynamic RegisterOverflow index is unsupported");
    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) return failure("Fresh beta CF: VM state parameter is not an identifier");
    const stateName = stateParam.name;
    const returnName = findVmReturnRegister(vm.functionNode)?.name || null;
    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) return failure("Fresh beta CF: no while <state> dispatcher");

    const ctx = {
        source, stateWhile, stateName, returnName,
        closureDiagnostics: {},
        logicalLeaves: extractNormalizedStateLeaves(stateWhile, stateName),
    };
    for (const recover of MULTI_STATE_RECOVERERS) {
        const result = recover(ctx);
        if (result) return result;
    }

    const leaf = unwrapSingleStateLeaf(stateWhile, stateName);
    if (!leaf) {
        return unsupportedMultiState(ctx.logicalLeaves?.size || 0, ctx.closureDiagnostics);
    }
    ctx.leaf = leaf;
    for (const recover of LINEAR_RECOVERERS) {
        const result = recover(ctx);
        if (result) return result;
    }
    return failure("Fresh beta CF: one-state leaf is not a proven direct global-call/register-local program");
}

function solveBetaControlFlow(sourceOrAst, astOrBeta) {
    if (typeof sourceOrAst === "string") return solveFreshSource(sourceOrAst, astOrBeta);
    return failure("Fresh beta CF no longer consumes beta register-version analysis; pass normal output source + AST");
}

module.exports = { solveBetaControlFlow, solveFreshSource };
