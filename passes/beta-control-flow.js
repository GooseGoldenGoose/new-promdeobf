"use strict";

// Public compatibility facade for the modular Fresh beta control-flow solver.
const { solveBetaControlFlow } = require("./beta-cf/solve");
const { matchDirectGlobalCallLeaf } = require("./beta-cf/direct-calls");
const { matchLocalRegisterProgram } = require("./beta-cf/linear/solver");
const { normalizeRegisterOverflowGraph } = require("./beta-cf/normalize");
const { collapseCompilerWhileLoops, matchCompilerWhileConditionRegion } = require("./beta-cf/control/while");
const { unsupported } = require("./beta-cf/diagnostics");

module.exports = {
    solveBetaControlFlow,
    matchDirectGlobalCallLeaf,
    matchLocalRegisterProgram,
    displayEnvironmentProvider: unsupported("displayEnvironmentProvider"),
    sinkTerminalReturnPayload: unsupported("sinkTerminalReturnPayload"),
    lowerTerminalReturn: unsupported("lowerTerminalReturn"),
    collapseCompilerNumericForLoops: unsupported("collapseCompilerNumericForLoops"),
    collapseCompilerGenericForLoops: unsupported("collapseCompilerGenericForLoops"),
    collapseCompilerWhileLoops,
    matchCompilerWhileConditionRegion,
    collapseCompilerRepeatLoops: unsupported("collapseCompilerRepeatLoops"),
    matchCompilerRepeatConditionRegion: unsupported("matchCompilerRepeatConditionRegion"),
    removeDuplicatedRepeatConditionRegions: unsupported("removeDuplicatedRepeatConditionRegions"),
    collapseCompilerStructuredLoops: unsupported("collapseCompilerStructuredLoops"),
    forwardControlOnlyJoinBranches: unsupported("forwardControlOnlyJoinBranches"),
    removeCompilerPosPreservationOperations: unsupported("removeCompilerPosPreservationOperations"),
    normalizeRegisterOverflowGraph,
};
