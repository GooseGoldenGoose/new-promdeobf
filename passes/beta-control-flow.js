// Fresh beta control-flow solver.
//
// The previous implementation is preserved unchanged in beta-control-flow-old.js.
// Do not silently fall back to it: this solver is rebuilt from proven compiler/CFG
// patterns and must fail closed until a case is implemented here.

function unsupported(name) {
    return function () {
        return { applied: false, reason: `Fresh beta CF solver: ${name} is not implemented yet` };
    };
}

function solveBetaControlFlow(originalAst, betaResult) {
    if (!betaResult?.graph || !betaResult.applied) {
        return { applied: false, reason: "Beta register analysis is unavailable" };
    }
    return {
        applied: false,
        reason: "Fresh beta CF solver has no recovery cases implemented yet",
        mode: "fresh",
    };
}

module.exports = {
    solveBetaControlFlow,
    displayEnvironmentProvider: unsupported("displayEnvironmentProvider"),
    sinkTerminalReturnPayload: unsupported("sinkTerminalReturnPayload"),
    lowerTerminalReturn: unsupported("lowerTerminalReturn"),
    collapseCompilerNumericForLoops: unsupported("collapseCompilerNumericForLoops"),
    collapseCompilerGenericForLoops: unsupported("collapseCompilerGenericForLoops"),
    collapseCompilerWhileLoops: unsupported("collapseCompilerWhileLoops"),
    matchCompilerWhileConditionRegion: unsupported("matchCompilerWhileConditionRegion"),
    collapseCompilerRepeatLoops: unsupported("collapseCompilerRepeatLoops"),
    matchCompilerRepeatConditionRegion: unsupported("matchCompilerRepeatConditionRegion"),
    removeDuplicatedRepeatConditionRegions: unsupported("removeDuplicatedRepeatConditionRegions"),
    collapseCompilerStructuredLoops: unsupported("collapseCompilerStructuredLoops"),
    forwardControlOnlyJoinBranches: unsupported("forwardControlOnlyJoinBranches"),
    removeCompilerPosPreservationOperations: unsupported("removeCompilerPosPreservationOperations"),
    normalizeRegisterOverflowGraph: unsupported("normalizeRegisterOverflowGraph"),
};
