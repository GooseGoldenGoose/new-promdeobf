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

function solveFreshSource(source, ast) {
    if (typeof source !== "string" || !ast) return { applied: false, reason: "Fresh beta CF requires normal output source and AST", mode: "fresh" };
    const vm = findVmFunction(ast);
    if (!vm) return { applied: false, reason: "Fresh beta CF: no semantically named vm function", mode: "fresh" };
    const overflow = normalizeRegisterOverflowGraph(vm.functionNode);
    if (overflow.unsupported > 0) return { applied: false, reason: "Fresh beta CF: dynamic RegisterOverflow index is unsupported", mode: "fresh" };
    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) return { applied: false, reason: "Fresh beta CF: VM state parameter is not an identifier", mode: "fresh" };
    const stateName = stateParam.name;
    const returnName = findVmReturnRegister(vm.functionNode)?.name || null;
    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) return { applied: false, reason: "Fresh beta CF: no while <state> dispatcher", mode: "fresh" };

    const closureDiagnostics = {};
    const closureProgram = matchClosureEntryProgram(source, stateWhile, stateName, returnName, closureDiagnostics);
    if (closureProgram) {
        return {
            applied: true,
            mode: "fresh-closure-entry",
            source: closureProgram.source,
            stateCount: closureProgram.stateCount,
            statementCount: closureProgram.statementCount,
            branchCount: 0,
            localCount: closureProgram.localCount,
            closureCount: closureProgram.closureCount,
        };
    }

    const logicalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (logicalLeaves && logicalLeaves.size > 1 && logicalLeaves.has(1)) {
        const flattenedLogical = flattenLogicalRootLeaf(logicalLeaves, 1, stateName, returnName);
        if (flattenedLogical && flattenedLogical.consumed.size === logicalLeaves.size) {
            const flattenedProgram = matchLocalRegisterProgram(source, flattenedLogical.leaf, stateName, returnName);
            if (flattenedProgram) {
                return {
                    applied: true,
                    mode: "fresh-multistate-logical",
                    source: flattenedProgram.source,
                    stateCount: logicalLeaves.size,
                    statementCount: flattenedProgram.statementCount,
                    branchCount: logicalLeaves.size - 1,
                    localCount: flattenedProgram.localCount,
                };
            }
        }
    }

    const multiLogical = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName);
    if (multiLogical) {
        return {
            applied: true,
            mode: "fresh-multistate-logical",
            source: multiLogical.source,
            stateCount: multiLogical.stateCount,
            statementCount: multiLogical.statementCount,
            branchCount: multiLogical.stateCount - 1,
            localCount: multiLogical.localCount,
        };
    }

    const simpleIf = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, { allowConditionalIf: true });
    if (simpleIf) {
        return {
            applied: true,
            mode: "fresh-simple-if",
            source: simpleIf.source,
            stateCount: simpleIf.stateCount,
            statementCount: simpleIf.statementCount,
            branchCount: 1,
            localCount: simpleIf.localCount,
        };
    }

    const leaf = unwrapSingleStateLeaf(stateWhile, stateName);
    if (!leaf) {
        const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
        const count = leaves?.size || 0;
        const detail = closureDiagnostics.reason ? `; closure recovery: ${closureDiagnostics.reason}` : "";
        const stateDetail = closureDiagnostics.state != null ? ` at state ${closureDiagnostics.state}` : "";
        const statementDetail = closureDiagnostics.statementIndex != null ? `; root statement ${closureDiagnostics.statementIndex}: ${String(closureDiagnostics.statement || "unknown").replace(/\s+/g, " ").slice(0, 180)}` : "";
        const unconsumed = Array.isArray(closureDiagnostics.unconsumed) && closureDiagnostics.unconsumed.length ? `; unconsumed states: ${closureDiagnostics.unconsumed.join(",")}` : "";
        return { applied: false, reason: `Fresh beta CF: unsupported multi-state control flow (${count} normalized states)${detail}${stateDetail}${statementDetail}${unconsumed}`, mode: "fresh" };
    }

    const localProgram = matchLocalRegisterProgram(source, leaf, stateName, returnName);
    if (localProgram) {
        return {
            applied: true,
            mode: "fresh-register-locals",
            source: localProgram.source,
            stateCount: 1,
            statementCount: localProgram.statementCount,
            branchCount: 0,
            localCount: localProgram.localCount,
        };
    }

    const directCalls = matchDirectGlobalCallLeaf(source, leaf, stateName, returnName);
    if (!directCalls) {
        const callResultProgram = matchLocalRegisterProgram(source, leaf, stateName, returnName, { allowNoLocals: true });
        if (callResultProgram) {
            return {
                applied: true,
                mode: "fresh-call-results",
                source: callResultProgram.source,
                stateCount: 1,
                statementCount: callResultProgram.statementCount,
                branchCount: 0,
                localCount: callResultProgram.localCount,
            };
        }
        return { applied: false, reason: "Fresh beta CF: one-state leaf is not a proven direct global-call/register-local program", mode: "fresh" };
    }

    return {
        applied: true,
        mode: "fresh-direct-global-call",
        source: directCalls.source,
        stateCount: 1,
        statementCount: directCalls.callCount,
        branchCount: 0,
        globalName: directCalls.globalName,
        argumentCount: directCalls.argumentCount,
        callCount: directCalls.callCount,
    };
}

function solveBetaControlFlow(sourceOrAst, astOrBeta) {
    if (typeof sourceOrAst === "string") return solveFreshSource(sourceOrAst, astOrBeta);
    return {
        applied: false,
        reason: "Fresh beta CF no longer consumes beta register-version analysis; pass normal output source + AST",
        mode: "fresh",
    };
}

module.exports = { solveBetaControlFlow, solveFreshSource };
