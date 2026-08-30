const assert = require("assert");
const fs = require("fs");
const os = require("os");
const path = require("path");
const { parseLua, parseLuaStructural, runDeobfuscator } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");
const { solveBetaControlFlow, removeCompilerPosPreservationOperations } = require("../passes/beta-control-flow");
const { solveBetaControlFlow: solveExperimentalBetaControlFlow } = require("../passes/beta-control-flow-overflow-experimental");

const wrapperSource = `return (function(_env)
    return 1
end)(getfenv and getfenv() or _ENV)`;
const ast = parseLua(wrapperSource, "<beta-cf-wrapper>");

const betaResult = {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1,
            predecessors: [],
            successors: [],
            operations: [
                { kind: "version-define", emittedText: 'local r_v1_1 = "print"', rhs: '"print"' },
                { kind: "version-define", emittedText: "local r_v2_1 = _env[r_v1_1]", rhs: "_env[r_v1_1]" },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "epoch-kill", emittedText: "r_v3_1 = nil", rhs: "nil", returnSinkSafe: true, emittedTarget: "r_v3_1" },
                { kind: "state-transition", emittedText: "state = nil", rhs: "nil" },
            ],
        }],
    },
};

const result = solveBetaControlFlow(ast, betaResult);
assert.equal(result.applied, true);
assert.equal(result.mode, "single-state");
assert.equal(result.environmentHeader, "local _env = getfenv()");
assert.equal(result.terminalReturnPayloadSunk, true);
assert.equal(result.terminalReturnLowered, true);
assert.equal(result.terminalReturnText, "return");
assert(result.source.startsWith("local _env = getfenv()\n\n"));
assert(!result.source.includes("--headers"));
assert(!result.source.includes("--body"));
assert(!result.source.includes("local args = { ... }"));
assert(!result.source.includes("while state do"));
assert(!result.source.includes("if state =="));
assert(result.source.includes("r_v3_1 = nil\n\nreturn"));
assert(!result.source.includes("ReturnVal ="));
assert(!result.source.includes("state = nil"));
parseLua(result.source, "<beta-cf-output>");

const effectfulPayload = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedText: 'local r_v1_1 = "x"', rhs: '"x"' },
                { kind: "return-payload", terminalCompilerReturnPayload: false, emittedText: 'ReturnVal = { mark("table") }', rhs: '{ mark("table") }' },
                { kind: "statement", originalText: 'mark("after")' },
                { kind: "state-transition", emittedText: "state = nil", rhs: "nil" },
            ],
        }],
    },
});
assert.equal(effectfulPayload.applied, true);
assert.equal(effectfulPayload.terminalReturnPayloadSunk, false);
assert(effectfulPayload.source.indexOf('ReturnVal = { mark("table") }') < effectfulPayload.source.indexOf('mark("after")'));

const multiReturn = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedText: "local r_v1_1 = 1", rhs: "1", returnSinkSafe: true, emittedTarget: "r_v1_1" },
                { kind: "version-define", emittedText: "local r_v2_1 = 2", rhs: "2", returnSinkSafe: true, emittedTarget: "r_v2_1" },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["r_v1_1", "r_v2_1", "unpack(r_v3_1)"], emittedText: "ReturnVal = { r_v1_1, r_v2_1, unpack(r_v3_1) }", rhs: "{ r_v1_1, r_v2_1, unpack(r_v3_1) }", reads: ["r_v1_1", "r_v2_1", "r_v3_1"] },
                { kind: "state-transition", emittedText: "state = nil", rhs: "nil" },
            ],
        }],
    },
});
assert.equal(multiReturn.applied, true);
assert.equal(multiReturn.terminalReturnLowered, true);
assert.equal(multiReturn.terminalReturnText, "return r_v1_1, r_v2_1, unpack(r_v3_1)");
assert(multiReturn.source.includes("return r_v1_1, r_v2_1, unpack(r_v3_1)"));
assert(!multiReturn.source.includes("ReturnVal ="));
assert(!multiReturn.source.includes("state = nil"));
parseLua(multiReturn.source, "<beta-cf-multi-return-output>");

const unsafeSink = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedText: "local r_v1_1 = 1", rhs: "1", returnSinkSafe: true, emittedTarget: "r_v1_1" },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["r_v1_1"], emittedText: "ReturnVal = { r_v1_1 }", rhs: "{ r_v1_1 }", reads: ["r_v1_1"] },
                { kind: "statement", originalText: "mark(\"after\")" },
                { kind: "state-transition", emittedText: "state = nil", rhs: "nil" },
            ],
        }],
    },
});
assert.equal(unsafeSink.applied, true);
assert.equal(unsafeSink.terminalReturnPayloadSunk, true);
assert.equal(unsafeSink.terminalReturnLowered, true);
assert(!unsafeSink.source.includes("ReturnVal ="));
assert(!unsafeSink.source.includes("state = nil"));
assert(unsafeSink.source.indexOf("mark(\"after\")") < unsafeSink.source.indexOf("return r_v1_1"));

const splitBranchStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2, 3], operations: [
                { kind: "version-define", emittedTarget: "cond", rhs: "check()", emittedText: "local cond = check()", reads: [] },
                { kind: "version-define", emittedTarget: "trueId", rhs: "2", emittedText: "local trueId = 2", reads: [], returnSinkSafe: true },
                { kind: "version-define", emittedTarget: "trueArm", rhs: "cond and trueId", emittedText: "local trueArm = cond and trueId", reads: ["cond", "trueId"] },
                { kind: "version-define", emittedTarget: "falseId", rhs: "3", emittedText: "local falseId = 3", reads: [], returnSinkSafe: true },
                { kind: "state-transition", emittedTarget: "state", rhs: "trueArm or falseId", emittedText: "state = trueArm or falseId", reads: ["trueArm", "falseId"] },
            ] },
            { id: 2, predecessors: [1], successors: [], operations: [
                { kind: "statement", emittedText: "onTrue()", originalText: "onTrue()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
            { id: 3, predecessors: [1], successors: [], operations: [
                { kind: "statement", emittedText: "onFalse()", originalText: "onFalse()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(splitBranchStructured.applied, true);
assert.equal(splitBranchStructured.branchCount, 1);
assert(splitBranchStructured.source.includes("if cond then"));
assert(!splitBranchStructured.source.includes("state ="));
parseLua(splitBranchStructured.source, "<beta-cf-split-branch-output>");

const acyclicStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [2, 3],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v1_1", emittedText: "local r_v1_1 = 1", rhs: "1", reads: [] },
                    { kind: "epoch-start", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = r_v1_1", rhs: "r_v1_1", reads: ["r_v1_1"] },
                    { kind: "version-define", emittedTarget: "r_v3_1", emittedText: "local r_v3_1 = flag()", rhs: "flag()", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v3_1 and 2 or 3", rhs: "r_v3_1 and 2 or 3", reads: ["r_v3_1"] },
                ],
            },
            {
                id: 2,
                predecessors: [1],
                successors: [3],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v4_1", emittedText: "local r_v4_1 = 2", rhs: "2", reads: [] },
                    { kind: "epoch-mutate", emittedTarget: "r_v2_1", emittedText: "r_v2_1 = r_v4_1", rhs: "r_v4_1", reads: ["r_v4_1"] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = 3", rhs: "3", reads: [] },
                ],
            },
            {
                id: 3,
                predecessors: [1, 2],
                successors: [4, 5],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v5_1", emittedText: "local r_v5_1 = flag2()", rhs: "flag2()", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v5_1 and 4 or 5", rhs: "r_v5_1 and 4 or 5", reads: ["r_v5_1"] },
                ],
            },
            {
                id: 4,
                predecessors: [3],
                successors: [],
                operations: [
                    { kind: "statement", originalText: "emit(r_v2_1)", reads: ["r_v2_1"] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
            {
                id: 5,
                predecessors: [3],
                successors: [],
                operations: [
                    { kind: "statement", originalText: "emit2(r_v2_1)", reads: ["r_v2_1"] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
        ],
    },
});
assert.equal(acyclicStructured.applied, true);
assert.equal(acyclicStructured.mode, "acyclic-structured");
assert.equal(acyclicStructured.stateCount, 5);
assert.equal(acyclicStructured.branchCount, 2);
assert.equal(acyclicStructured.joinCount, 1);
assert.equal(acyclicStructured.guardBranchCount, 1);
assert.equal(acyclicStructured.terminalReturnCount, 2);
assert(acyclicStructured.source.includes("if (flag()) then"));
assert(!acyclicStructured.source.includes("local r_v3_1 = flag()"));
assert(acyclicStructured.source.includes("if (flag2()) then"));
assert(!acyclicStructured.source.includes("local r_v5_1 = flag2()"));
assert(acyclicStructured.source.includes("r_v2_1 = r_v4_1"));
assert(acyclicStructured.source.indexOf("r_v2_1 = r_v4_1") < acyclicStructured.source.indexOf("if (flag2()) then"));
assert(acyclicStructured.source.indexOf("emit(r_v2_1)") < acyclicStructured.source.indexOf("emit2(r_v2_1)"));
assert.equal((acyclicStructured.source.match(/\breturn\b/g) || []).length, 2);
assert(!acyclicStructured.source.includes("ReturnVal ="));
assert(!acyclicStructured.source.includes("state ="));
assert(!acyclicStructured.source.includes("while state do"));
parseLua(acyclicStructured.source, "<beta-cf-acyclic-output>");

const diamond = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [10],
        states: [
            { id: 10, predecessors: [], successors: [20, 30], operations: [
                { kind: "version-define", emittedTarget: "r_v9_1", emittedText: "local r_v9_1 = choose()", rhs: "choose()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v9_1 and 20 or 30", rhs: "r_v9_1 and 20 or 30", reads: ["r_v9_1"] },
            ] },
            { id: 20, predecessors: [10], successors: [40], operations: [
                { kind: "statement", originalText: "left()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 40", rhs: "40", reads: [] },
            ] },
            { id: 30, predecessors: [10], successors: [40], operations: [
                { kind: "statement", originalText: "right()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 40", rhs: "40", reads: [] },
            ] },
            { id: 40, predecessors: [20, 30], successors: [], operations: [
                { kind: "statement", originalText: "joined()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(diamond.applied, true);
assert.equal(diamond.joinCount, 1);
assert(diamond.source.includes("if (choose()) then"));
assert(!diamond.source.includes("local r_v9_1 = choose()"));
assert(diamond.source.includes("else"));
assert(diamond.source.indexOf("left()") < diamond.source.indexOf("else"));
assert(diamond.source.indexOf("else") < diamond.source.indexOf("right()"));
assert(diamond.source.indexOf("right()") < diamond.source.indexOf("joined()"));
assert(!diamond.source.includes("state ="));
parseLua(diamond.source, "<beta-cf-diamond-output>");


const sharedContinuationEarlyReturn = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [100],
        states: [
            { id: 100, predecessors: [], successors: [110, 120], operations: [
                { kind: "version-define", emittedTarget: "r_v20_1", emittedText: "local r_v20_1 = chooseA()", rhs: "chooseA()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v20_1 and 110 or 120", rhs: "r_v20_1 and 110 or 120", reads: ["r_v20_1"] },
            ] },
            { id: 110, predecessors: [100], successors: [130], operations: [
                { kind: "statement", originalText: "markC()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 130", rhs: "130", reads: [] },
            ] },
            { id: 120, predecessors: [100], successors: [125, 130], operations: [
                { kind: "version-define", emittedTarget: "r_v21_1", emittedText: "local r_v21_1 = chooseB()", rhs: "chooseB()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v21_1 and 125 or 130", rhs: "r_v21_1 and 125 or 130", reads: ["r_v21_1"] },
            ] },
            { id: 125, predecessors: [120], successors: [130], operations: [
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 130", rhs: "130", reads: [] },
                { kind: "statement", originalText: "markG()", reads: [] },
            ] },
            { id: 130, predecessors: [110, 120, 125], successors: [140, 150], operations: [
                { kind: "version-define", emittedTarget: "r_v22_1", emittedText: "local r_v22_1 = chooseC()", rhs: "chooseC()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v22_1 and 140 or 150", rhs: "r_v22_1 and 140 or 150", reads: ["r_v22_1"] },
            ] },
            { id: 140, predecessors: [130], successors: [160], operations: [
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 160", rhs: "160", reads: [] },
                { kind: "statement", originalText: "markW()", reads: [] },
            ] },
            { id: 150, predecessors: [130], successors: [170, 160], operations: [
                { kind: "version-define", emittedTarget: "r_v23_1", emittedText: "local r_v23_1 = chooseD()", rhs: "chooseD()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = r_v23_1 and 170 or 160", rhs: "r_v23_1 and 170 or 160", reads: ["r_v23_1"] },
            ] },
            { id: 170, predecessors: [150], successors: [], operations: [
                { kind: "statement", originalText: "markL()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
            { id: 160, predecessors: [140, 150], successors: [], operations: [
                { kind: "statement", originalText: "finish()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(sharedContinuationEarlyReturn.applied, true);
assert.equal(sharedContinuationEarlyReturn.mode, "acyclic-structured");
assert(sharedContinuationEarlyReturn.source.includes("if (chooseA()) then"));
assert(sharedContinuationEarlyReturn.source.includes("if (chooseB()) then"));
assert(sharedContinuationEarlyReturn.source.includes("if (chooseC()) then"));
assert(sharedContinuationEarlyReturn.source.includes("if (chooseD()) then"));
assert.equal((sharedContinuationEarlyReturn.source.match(/finish\(\)/g) || []).length, 1);
assert.equal((sharedContinuationEarlyReturn.source.match(/markL\(\)/g) || []).length, 1);
assert(sharedContinuationEarlyReturn.source.indexOf("markG()") < sharedContinuationEarlyReturn.source.indexOf("if (chooseC()) then"));
assert(sharedContinuationEarlyReturn.source.indexOf("markW()") < sharedContinuationEarlyReturn.source.indexOf("finish()"));
assert(!sharedContinuationEarlyReturn.source.includes("state ="));
parseLua(sharedContinuationEarlyReturn.source, "<beta-cf-shared-continuation-output>");


const nestedClosureRegions = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 20],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    {
                        kind: "version-define",
                        emittedTarget: "r_v1_1",
                        emittedText: "local r_v1_1 = createClosure7(20, {})",
                        rhs: "createClosure7(20, {})",
                        reads: [],
                    },
                    {
                        kind: "version-define",
                        emittedTarget: "r_v2_1",
                        emittedText: "local r_v2_1 = r_v1_1(3, 4)",
                        rhs: "r_v1_1(3, 4)",
                        reads: ["r_v1_1"],
                    },
                    {
                        kind: "return-payload",
                        terminalCompilerReturnPayload: true,
                        returnExpressions: [],
                        emittedText: "ReturnVal = {}",
                        rhs: "{}",
                        reads: [],
                    },
                    {
                        kind: "state-transition",
                        emittedTarget: "state",
                        emittedText: "state = nil",
                        rhs: "nil",
                        reads: [],
                    },
                ],
            },
            {
                id: 20,
                predecessors: [],
                successors: [21],
                operations: [
                    {
                        kind: "version-define",
                        emittedTarget: "r_v3_1",
                        emittedText: "local r_v3_1 = args[1]",
                        rhs: "args[1]",
                        reads: [],
                    },
                    {
                        kind: "version-define",
                        emittedTarget: "r_v4_1",
                        emittedText: "local r_v4_1 = args[2]",
                        rhs: "args[2]",
                        reads: [],
                    },
                    {
                        kind: "state-transition",
                        emittedTarget: "state",
                        emittedText: "state = 21",
                        rhs: "21",
                        reads: [],
                    },
                ],
            },
            {
                id: 21,
                predecessors: [20],
                successors: [],
                operations: [
                    {
                        kind: "version-define",
                        emittedTarget: "r_v5_1",
                        emittedText: "local r_v5_1 = r_v3_1 + r_v4_1",
                        rhs: "r_v3_1 + r_v4_1",
                        reads: ["r_v3_1", "r_v4_1"],
                    },
                    {
                        kind: "return-payload",
                        terminalCompilerReturnPayload: true,
                        returnExpressions: ["r_v5_1"],
                        emittedText: "ReturnVal = { r_v5_1 }",
                        rhs: "{ r_v5_1 }",
                        reads: ["r_v5_1"],
                    },
                    {
                        kind: "state-transition",
                        emittedTarget: "state",
                        emittedText: "state = nil",
                        rhs: "nil",
                        reads: [],
                    },
                ],
            },
        ],
    },
});
assert.equal(nestedClosureRegions.applied, true);
assert.equal(nestedClosureRegions.mode, "closure-regions");
assert.equal(nestedClosureRegions.entryState, 1);
assert.equal(nestedClosureRegions.stateCount, 3);
assert.equal(nestedClosureRegions.closureRegionCount, 2);
assert.equal(nestedClosureRegions.inlinedClosureFactoryCount, 1);
assert(!nestedClosureRegions.source.includes("--headers"));
assert(!nestedClosureRegions.source.includes("--body"));
assert(nestedClosureRegions.source.includes("local r_v1_1 = function(r_v3_1, r_v4_1)"));
assert(!nestedClosureRegions.source.includes("function(r_v3_1, r_v4_1)\n\n"));
assert(!nestedClosureRegions.source.includes("local r_v3_1 = args[1]"));
assert(!nestedClosureRegions.source.includes("local r_v4_1 = args[2]"));
assert(nestedClosureRegions.source.includes("return r_v5_1"));
assert(!nestedClosureRegions.source.includes("createClosure7("));
assert(!nestedClosureRegions.source.includes("state ="));
assert(!nestedClosureRegions.source.includes("ReturnVal ="));
parseLua(nestedClosureRegions.source, "<beta-cf-nested-closure-output>");

const nestedVarargClosureRegions = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 30],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "fn", emittedText: "local fn = createClosure(30, {})", rhs: "createClosure(30, {})", reads: [] },
                    { kind: "version-define", emittedTarget: "result", emittedText: "local result = fn(\"x\", 1, 2)", rhs: "fn(\"x\", 1, 2)", reads: ["fn"] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
            {
                id: 30,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "tail", emittedText: "local tail = { select(2, unpack(args)) }", rhs: "{ select(2, unpack(args)) }", reads: [] },
                    { kind: "version-define", emittedTarget: "head", emittedText: "local head = args[1]", rhs: "args[1]", reads: [] },
                    { kind: "version-define", emittedTarget: "count", emittedText: "local count = select(\"#\", unpack(tail))", rhs: "select(\"#\", unpack(tail))", reads: ["tail"] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["head", "count"], emittedText: "ReturnVal = { head, count }", rhs: "{ head, count }", reads: ["head", "count"] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
        ],
    },
});
assert.equal(nestedVarargClosureRegions.applied, true);
assert(nestedVarargClosureRegions.source.includes("local fn = function(head, ...)"));
assert(!nestedVarargClosureRegions.source.includes("local head = args[1]"));
assert(!nestedVarargClosureRegions.source.includes("local tail ="));
assert(nestedVarargClosureRegions.source.includes('local count = select("#", ...)'));
parseLua(nestedVarargClosureRegions.source, "<beta-cf-nested-vararg-closure-output>");

const capturedClosureRejected = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    {
                        kind: "version-define",
                        emittedTarget: "r_v1_1",
                        emittedText: "local r_v1_1 = createClosure4(2, { r_v9_1 })",
                        rhs: "createClosure4(2, { r_v9_1 })",
                        reads: ["r_v9_1"],
                    },
                    {
                        kind: "return-payload",
                        terminalCompilerReturnPayload: true,
                        returnExpressions: [],
                        emittedText: "ReturnVal = {}",
                        rhs: "{}",
                        reads: [],
                    },
                    {
                        kind: "state-transition",
                        emittedTarget: "state",
                        emittedText: "state = nil",
                        rhs: "nil",
                        reads: [],
                    },
                ],
            },
            {
                id: 2,
                predecessors: [],
                successors: [],
                operations: [
                    {
                        kind: "return-payload",
                        terminalCompilerReturnPayload: true,
                        returnExpressions: [],
                        emittedText: "ReturnVal = {}",
                        rhs: "{}",
                        reads: [],
                    },
                    {
                        kind: "state-transition",
                        emittedTarget: "state",
                        emittedText: "state = nil",
                        rhs: "nil",
                        reads: [],
                    },
                ],
            },
        ],
    },
});
assert.equal(capturedClosureRejected.applied, false);
assert(capturedClosureRejected.reason.includes("does not resolve to a proven upvalue cell"));

const indexedEffectPassthrough = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "r_v1_1", emittedText: 'local r_v1_1 = "concat"', rhs: '"concat"', reads: [] },
                { kind: "version-define", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = function() return 1 end", rhs: "function() return 1 end", reads: [] },
                { kind: "effect-write", emittedText: "_env[r_v1_1] = r_v2_1", originalText: "_env[r1] = state", reads: ["r_v1_1", "r_v2_1"] },
                { kind: "statement", originalText: "mark()", reads: [] },
                { kind: "effect-write", emittedText: "r_v1_1.value = r_v2_1", originalText: "r1.value = state", reads: ["r_v1_1", "r_v2_1"] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ],
        }],
    },
});
assert.equal(indexedEffectPassthrough.applied, true);
assert(indexedEffectPassthrough.source.includes("_env[r_v1_1] = r_v2_1"));
assert(indexedEffectPassthrough.source.includes("r_v1_1.value = r_v2_1"));
assert(
    indexedEffectPassthrough.source.indexOf("_env[r_v1_1] = r_v2_1") <
    indexedEffectPassthrough.source.indexOf("mark()")
);
assert(
    indexedEffectPassthrough.source.indexOf("mark()") <
    indexedEffectPassthrough.source.indexOf("r_v1_1.value = r_v2_1")
);
assert(!indexedEffectPassthrough.source.includes("state = nil"));
parseLua(indexedEffectPassthrough.source, "<beta-cf-indexed-effect-output>");

const unsafeUnsupportedWrite = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "unsupported", emittedText: "r_v1_1 = mystery()", originalText: "r1 = mystery()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ],
        }],
    },
});
assert.equal(unsafeUnsupportedWrite.applied, false);
assert(unsafeUnsupportedWrite.reason.includes("unsupported beta operations"));

const unloweredNestedClosureRejected = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 20],
        states: [
            {
                id: 1, predecessors: [], successors: [], operations: [
                    { kind: "version-define", emittedTarget: "r_v1_1", emittedText: "local r_v1_1 = createClosure7(20, {})", rhs: "createClosure7(20, {})", reads: [] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
            {
                id: 20, predecessors: [], successors: [], operations: [
                    { kind: "statement", originalText: "mark()", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
        ],
    },
});
assert.equal(unloweredNestedClosureRejected.applied, false);
assert(unloweredNestedClosureRejected.reason.includes("terminal VM return was not fully lowered"));

const numericForStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "tmpLimit", rhs: "10", emittedText: "local tmpLimit = 10", reads: [] },
                { kind: "version-define", emittedTarget: "final", rhs: "tmpLimit", emittedText: "local final = tmpLimit", reads: ["tmpLimit"] },
                { kind: "version-define", emittedTarget: "tmpStep", rhs: "-2", emittedText: "local tmpStep = -2", reads: [] },
                { kind: "version-define", emittedTarget: "step", rhs: "tmpStep", emittedText: "local step = tmpStep", reads: ["tmpStep"] },
                { kind: "version-define", emittedTarget: "zero", rhs: "0", emittedText: "local zero = 0", reads: [] },
                { kind: "version-define", emittedTarget: "neg", rhs: "step < zero", emittedText: "local neg = step < zero", reads: ["step", "zero"] },
                { kind: "version-define", emittedTarget: "start", rhs: "5", emittedText: "local start = 5", reads: [] },
                { kind: "epoch-mutate", emittedTarget: "current", rhs: "start - step", emittedText: "current = start - step", reads: ["start", "step"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                { kind: "version-define", emittedTarget: "notneg", rhs: "not neg", emittedText: "local notneg = not neg", reads: ["neg"] },
                { kind: "epoch-mutate", emittedTarget: "current", rhs: "current + step", emittedText: "current = current + step", reads: ["current", "step"] },
                { kind: "version-define", emittedTarget: "le", rhs: "current <= final", emittedText: "local le = current <= final", reads: ["current", "final"] },
                { kind: "version-define", emittedTarget: "pos", rhs: "notneg and le", emittedText: "local pos = notneg and le", reads: ["notneg", "le"] },
                { kind: "epoch-start", emittedTarget: "ge", rhs: "current >= final", emittedText: "local ge = current >= final", reads: ["current", "final"], registerEpoch: "ge:1" },
                { kind: "epoch-mutate", emittedTarget: "ge", rhs: "neg and ge", emittedText: "ge = neg and ge", reads: ["neg", "ge"], registerEpoch: "ge:1" },
                { kind: "version-define", emittedTarget: "cond", rhs: "ge or pos", emittedText: "local cond = ge or pos", reads: ["ge", "pos"] },
                { kind: "version-define", emittedTarget: "bodyId", rhs: "3", emittedText: "local bodyId = 3", reads: [] },
                { kind: "version-define", emittedTarget: "stateTmp", rhs: "cond and bodyId", emittedText: "local stateTmp = cond and bodyId", reads: ["cond", "bodyId"] },
                { kind: "version-define", emittedTarget: "exitId", rhs: "4", emittedText: "local exitId = 4", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "stateTmp or exitId", emittedText: "state = stateTmp or exitId", reads: ["stateTmp", "exitId"] },
            ] },
            { id: 3, predecessors: [2], successors: [2], operations: [
                { kind: "epoch-start", originalTarget: "loopPhysical", emittedTarget: "loopVar", rhs: "current", emittedText: "local loopVar = current", reads: ["current"], registerEpoch: "loop:1" },
                { kind: "version-define", emittedTarget: "sink", rhs: "consume(loopVar)", emittedText: "local sink = consume(loopVar)", reads: ["loopVar"] },
                { kind: "epoch-kill", originalTarget: "loopPhysical", emittedTarget: "deadLoopCleanup", rhs: "nil", emittedText: "local deadLoopCleanup = nil", reads: [], registerEpoch: "loop:1" },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(numericForStructured.applied, true);
assert.equal(numericForStructured.numericForLoopCount, 1);
assert.equal(numericForStructured.stateCount, 4);
assert(numericForStructured.source.includes("for loopVar = start, final, step do"));
assert(numericForStructured.source.includes("local sink = consume(loopVar)"));
assert(!numericForStructured.source.includes("current = current + step"));
assert(!numericForStructured.source.includes("state ="));
parseLua(numericForStructured.source, "<beta-cf-numeric-for-output>");

const numericForMutatedVariable = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "final", rhs: "2", emittedText: "local final = 2", reads: [] },
                { kind: "version-define", emittedTarget: "step", rhs: "1", emittedText: "local step = 1", reads: [] },
                { kind: "version-define", emittedTarget: "zero", rhs: "0", emittedText: "local zero = 0", reads: [] },
                { kind: "version-define", emittedTarget: "neg", rhs: "step < zero", emittedText: "local neg = step < zero", reads: ["step", "zero"] },
                { kind: "version-define", emittedTarget: "start", rhs: "1", emittedText: "local start = 1", reads: [] },
                { kind: "epoch-mutate", emittedTarget: "current", rhs: "start - step", emittedText: "current = start - step", reads: ["start", "step"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                { kind: "version-define", emittedTarget: "notneg", rhs: "not neg", emittedText: "local notneg = not neg", reads: ["neg"] },
                { kind: "epoch-mutate", emittedTarget: "current", rhs: "current + step", emittedText: "current = current + step", reads: ["current", "step"] },
                { kind: "version-define", emittedTarget: "le", rhs: "current <= final", emittedText: "local le = current <= final", reads: ["current", "final"] },
                { kind: "version-define", emittedTarget: "pos", rhs: "notneg and le", emittedText: "local pos = notneg and le", reads: ["notneg", "le"] },
                { kind: "epoch-start", emittedTarget: "ge", rhs: "current >= final", emittedText: "local ge = current >= final", reads: ["current", "final"], registerEpoch: "ge:1" },
                { kind: "epoch-mutate", emittedTarget: "ge", rhs: "neg and ge", emittedText: "ge = neg and ge", reads: ["neg", "ge"], registerEpoch: "ge:1" },
                { kind: "version-define", emittedTarget: "cond", rhs: "ge or pos", emittedText: "local cond = ge or pos", reads: ["ge", "pos"] },
                { kind: "version-define", emittedTarget: "bodyId", rhs: "3", emittedText: "local bodyId = 3", reads: [] },
                { kind: "version-define", emittedTarget: "stateTmp", rhs: "cond and bodyId", emittedText: "local stateTmp = cond and bodyId", reads: ["cond", "bodyId"] },
                { kind: "version-define", emittedTarget: "exitId", rhs: "4", emittedText: "local exitId = 4", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "stateTmp or exitId", emittedText: "state = stateTmp or exitId", reads: ["stateTmp", "exitId"] },
            ] },
            { id: 3, predecessors: [2], successors: [2], operations: [
                { kind: "epoch-start", emittedTarget: "loopVar", rhs: "current", emittedText: "local loopVar = current", reads: ["current"], registerEpoch: "loop:1" },
                { kind: "version-define", emittedTarget: "next", rhs: "loopVar + 10", emittedText: "local next = loopVar + 10", reads: ["loopVar"] },
                { kind: "epoch-mutate", emittedTarget: "loopVar", rhs: "next", emittedText: "loopVar = next", reads: ["next"], registerEpoch: "loop:1" },
                { kind: "version-define", emittedTarget: "sink", rhs: "consume(loopVar)", emittedText: "local sink = consume(loopVar)", reads: ["loopVar"] },
                { kind: "epoch-kill", emittedTarget: "loopVar", rhs: "nil", emittedText: "loopVar = nil", reads: [], registerEpoch: "loop:1" },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(numericForMutatedVariable.applied, true);
assert.equal(numericForMutatedVariable.numericForLoopCount, 1);
assert(numericForMutatedVariable.source.includes("loopVar = next"));
assert(numericForMutatedVariable.source.includes("consume(loopVar)"));
assert(!numericForMutatedVariable.source.includes("current = current + step"));
parseLua(numericForMutatedVariable.source, "<beta-cf-numeric-for-mutated-variable-output>");

const numericForBranchBody = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "tmpLimit", rhs: "5", emittedText: "local tmpLimit = 5", reads: [] },
                { kind: "version-define", emittedTarget: "final", rhs: "tmpLimit", emittedText: "local final = tmpLimit", reads: ["tmpLimit"] },
                { kind: "version-define", emittedTarget: "tmpStep", rhs: "1", emittedText: "local tmpStep = 1", reads: [] },
                { kind: "version-define", emittedTarget: "step", rhs: "tmpStep", emittedText: "local step = tmpStep", reads: ["tmpStep"] },
                { kind: "version-define", emittedTarget: "zero", rhs: "0", emittedText: "local zero = 0", reads: [] },
                { kind: "version-define", emittedTarget: "neg", rhs: "step < zero", emittedText: "local neg = step < zero", reads: ["step", "zero"] },
                { kind: "version-define", emittedTarget: "start", rhs: "1", emittedText: "local start = 1", reads: [] },
                { kind: "epoch-mutate", emittedTarget: "current", rhs: "start - step", emittedText: "current = start - step", reads: ["start", "step"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 7], successors: [3, 4], operations: [
                { kind: "version-define", emittedTarget: "notneg", rhs: "not neg", emittedText: "local notneg = not neg", reads: ["neg"] },
                { kind: "epoch-mutate", emittedTarget: "current", rhs: "current + step", emittedText: "current = current + step", reads: ["current", "step"] },
                { kind: "version-define", emittedTarget: "le", rhs: "current <= final", emittedText: "local le = current <= final", reads: ["current", "final"] },
                { kind: "version-define", emittedTarget: "pos", rhs: "notneg and le", emittedText: "local pos = notneg and le", reads: ["notneg", "le"] },
                { kind: "epoch-start", emittedTarget: "ge", rhs: "current >= final", emittedText: "local ge = current >= final", reads: ["current", "final"], registerEpoch: "ge:1" },
                { kind: "epoch-mutate", emittedTarget: "ge", rhs: "neg and ge", emittedText: "ge = neg and ge", reads: ["neg", "ge"], registerEpoch: "ge:1" },
                { kind: "version-define", emittedTarget: "cond", rhs: "ge or pos", emittedText: "local cond = ge or pos", reads: ["ge", "pos"] },
                { kind: "version-define", emittedTarget: "bodyId", rhs: "3", emittedText: "local bodyId = 3", reads: [] },
                { kind: "version-define", emittedTarget: "stateTmp", rhs: "cond and bodyId", emittedText: "local stateTmp = cond and bodyId", reads: ["cond", "bodyId"] },
                { kind: "version-define", emittedTarget: "exitId", rhs: "4", emittedText: "local exitId = 4", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "stateTmp or exitId", emittedText: "state = stateTmp or exitId", reads: ["stateTmp", "exitId"] },
            ] },
            { id: 3, predecessors: [2], successors: [5, 6], operations: [
                { kind: "epoch-start", emittedTarget: "loopVar", rhs: "current", emittedText: "local loopVar = current", reads: ["current"], registerEpoch: "loop:1" },
                { kind: "version-define", emittedTarget: "branchCond", rhs: "predicate(loopVar)", emittedText: "local branchCond = predicate(loopVar)", reads: ["loopVar"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "branchCond and 5 or 6", emittedText: "state = branchCond and 5 or 6", reads: ["branchCond"] },
            ] },
            { id: 5, predecessors: [3], successors: [7], operations: [
                { kind: "version-define", emittedTarget: "evenSink", rhs: "markEven(loopVar)", emittedText: "local evenSink = markEven(loopVar)", reads: ["loopVar"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "7", emittedText: "state = 7", reads: [] },
            ] },
            { id: 6, predecessors: [3], successors: [7], operations: [
                { kind: "version-define", emittedTarget: "oddSink", rhs: "markOdd(loopVar)", emittedText: "local oddSink = markOdd(loopVar)", reads: ["loopVar"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "7", emittedText: "state = 7", reads: [] },
            ] },
            { id: 7, predecessors: [5, 6], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "afterSink", rhs: "afterBranch(loopVar)", emittedText: "local afterSink = afterBranch(loopVar)", reads: ["loopVar"] },
                { kind: "epoch-kill", emittedTarget: "loopVar", rhs: "nil", emittedText: "loopVar = nil", reads: [], registerEpoch: "loop:1" },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(numericForBranchBody.applied, true);
assert.equal(numericForBranchBody.numericForLoopCount, 1);
assert.equal(numericForBranchBody.branchCount, 1);
assert.equal(numericForBranchBody.joinCount, 1);
assert(numericForBranchBody.source.includes("for loopVar = start, final, step do"));
assert(numericForBranchBody.source.includes("if (predicate(loopVar)) then"));
assert(!numericForBranchBody.source.includes("local branchCond = predicate(loopVar)"));
assert(numericForBranchBody.source.includes("markEven(loopVar)"));
assert(numericForBranchBody.source.includes("markOdd(loopVar)"));
assert(numericForBranchBody.source.includes("afterBranch(loopVar)"));
assert(!numericForBranchBody.source.includes("state ="));
parseLua(numericForBranchBody.source, "<beta-cf-numeric-for-branch-body-output>");

const whileGuardStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "setup", rhs: "args", emittedText: "local setup = args", reads: ["args"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                { kind: "version-define", emittedTarget: "cond", rhs: "predicate()", emittedText: "local cond = predicate()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "cond and 3 or 4", emittedText: "state = cond and 3 or 4", reads: ["cond"] },
            ] },
            { id: 3, predecessors: [2], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "sink", rhs: "consume()", emittedText: "local sink = consume()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(whileGuardStructured.applied, true);
assert.equal(whileGuardStructured.whileLoopCount, 1);
assert.equal(whileGuardStructured.numericForLoopCount, 0);
assert(whileGuardStructured.source.includes("while (predicate()) do"));
assert(!whileGuardStructured.source.includes("if not (cond) then"));
assert(!whileGuardStructured.source.includes("local cond = predicate()"));
assert(whileGuardStructured.source.includes("local sink = consume()"));
assert(!whileGuardStructured.source.includes("state ="));
const whileIndex = whileGuardStructured.source.indexOf("while (predicate()) do");


const bodyIndex = whileGuardStructured.source.indexOf("local sink = consume()");
assert(whileIndex >= 0 && whileIndex < bodyIndex);
parseLua(whileGuardStructured.source, "<beta-cf-while-guard-output>");


const repeatUntilStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "statement", emittedText: "beforeRepeat()", originalText: "beforeRepeat()", reads: [] },
                { kind: "version-define", emittedTarget: "junkFn", rhs: "getPredicate()", emittedText: "local junkFn = getPredicate()", originalText: "r1 = getPredicate()", reads: [] },
                { kind: "epoch-kill", emittedTarget: "deadScratch", rhs: "nil", emittedText: "deadScratch = nil", originalText: "r9 = nil", reads: [] },
                { kind: "version-define", emittedTarget: "junkCond", rhs: "junkFn()", emittedText: "local junkCond = junkFn()", originalText: "state = r1()", reads: ["junkFn"] },
                { kind: "version-define", emittedTarget: "setup", rhs: "args", emittedText: "local setup = args", originalText: "r2 = args", reads: ["args"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", originalText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3], operations: [
                { kind: "statement", emittedText: "consume()", originalText: "consume()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "3", emittedText: "state = 3", originalText: "state = 3", reads: [] },
            ] },
            { id: 3, predecessors: [2], successors: [4, 2], operations: [
                { kind: "version-define", emittedTarget: "realFn", rhs: "getPredicate()", emittedText: "local realFn = getPredicate()", originalText: "r1 = getPredicate()", reads: [] },
                { kind: "version-define", emittedTarget: "realCond", rhs: "realFn()", emittedText: "local realCond = realFn()", originalText: "state = r1()", reads: ["realFn"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "realCond and 4 or 2", emittedText: "state = realCond and 4 or 2", originalText: "state = state and 4 or 2", reads: ["realCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(repeatUntilStructured.applied, true);
assert.equal(repeatUntilStructured.repeatLoopCount, 1);
assert.equal(repeatUntilStructured.numericForLoopCount, 0);
assert.equal(repeatUntilStructured.whileLoopCount, 0);
assert.equal(repeatUntilStructured.removedRepeatCompilerConditionOperationCount, 2);
assert(repeatUntilStructured.source.includes("beforeRepeat()"));
assert(repeatUntilStructured.source.includes("deadScratch = nil"));
assert(repeatUntilStructured.source.includes("local setup = args"));
assert(repeatUntilStructured.source.includes("repeat"));
assert(repeatUntilStructured.source.includes("consume()"));
assert(repeatUntilStructured.source.includes("until (realFn())"));
assert(!repeatUntilStructured.source.includes("local realCond = realFn()"));
assert(!repeatUntilStructured.source.includes("junkFn"));
assert(!repeatUntilStructured.source.includes("junkCond"));
assert(!repeatUntilStructured.source.includes("state ="));
parseLua(repeatUntilStructured.source, "<beta-cf-repeat-until-output>");

const reorderedRepeatCondition = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "junkB", rhs: '"key"', emittedText: 'local junkB = "key"', originalTarget: "r2", originalText: 'r2 = "key"', reads: [], returnSinkSafe: true },
                { kind: "version-define", emittedTarget: "junkA", rhs: "7", emittedText: "local junkA = 7", originalTarget: "r1", originalText: "r1 = 7", reads: [], returnSinkSafe: true },
                { kind: "version-define", emittedTarget: "junkFn", rhs: "combine(junkA, junkB)", emittedText: "local junkFn = combine(junkA, junkB)", originalTarget: "r3", originalText: "r3 = combine(r1, r2)", reads: ["junkA", "junkB"] },
                { kind: "version-define", emittedTarget: "junkCond", rhs: "junkFn()", emittedText: "local junkCond = junkFn()", originalTarget: "state", originalText: "state = r3()", reads: ["junkFn"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", originalText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3], operations: [
                { kind: "statement", emittedText: "body()", originalText: "body()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "3", emittedText: "state = 3", originalText: "state = 3", reads: [] },
            ] },
            { id: 3, predecessors: [2], successors: [4, 2], operations: [
                { kind: "version-define", emittedTarget: "realA", rhs: "7", emittedText: "local realA = 7", originalTarget: "r1", originalText: "r1 = 7", reads: [], returnSinkSafe: true },
                { kind: "version-define", emittedTarget: "realB", rhs: '"key"', emittedText: 'local realB = "key"', originalTarget: "r2", originalText: 'r2 = "key"', reads: [], returnSinkSafe: true },
                { kind: "version-define", emittedTarget: "realFn", rhs: "combine(realA, realB)", emittedText: "local realFn = combine(realA, realB)", originalTarget: "r3", originalText: "r3 = combine(r1, r2)", reads: ["realA", "realB"] },
                { kind: "version-define", emittedTarget: "realCond", rhs: "realFn()", emittedText: "local realCond = realFn()", originalTarget: "state", originalText: "state = r3()", reads: ["realFn"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "realCond and 4 or 2", emittedText: "state = realCond and 4 or 2", originalText: "state = state and 4 or 2", reads: ["realCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(reorderedRepeatCondition.applied, true);
assert.equal(reorderedRepeatCondition.repeatLoopCount, 1);
assert.equal(reorderedRepeatCondition.removedRepeatCompilerConditionOperationCount, 4);
assert(!reorderedRepeatCondition.source.includes("junkA"));
assert(!reorderedRepeatCondition.source.includes("junkB"));
assert(reorderedRepeatCondition.source.includes("until (realFn())"));
assert(!reorderedRepeatCondition.source.includes("local realCond = realFn()"));
parseLua(reorderedRepeatCondition.source, "<beta-cf-reordered-repeat-output>");

const effectfulReorderedRepeatRejected = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "junkB", rhs: "bar()", emittedText: "local junkB = bar()", originalTarget: "r2", originalText: "r2 = bar()", reads: [] },
                { kind: "version-define", emittedTarget: "junkA", rhs: "foo()", emittedText: "local junkA = foo()", originalTarget: "r1", originalText: "r1 = foo()", reads: [] },
                { kind: "version-define", emittedTarget: "junkCond", rhs: "test(junkA, junkB)", emittedText: "local junkCond = test(junkA, junkB)", originalTarget: "state", originalText: "state = test(r1, r2)", reads: ["junkA", "junkB"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", originalText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3], operations: [
                { kind: "statement", emittedText: "body()", originalText: "body()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "3", emittedText: "state = 3", originalText: "state = 3", reads: [] },
            ] },
            { id: 3, predecessors: [2], successors: [4, 2], operations: [
                { kind: "version-define", emittedTarget: "realA", rhs: "foo()", emittedText: "local realA = foo()", originalTarget: "r1", originalText: "r1 = foo()", reads: [] },
                { kind: "version-define", emittedTarget: "realB", rhs: "bar()", emittedText: "local realB = bar()", originalTarget: "r2", originalText: "r2 = bar()", reads: [] },
                { kind: "version-define", emittedTarget: "realCond", rhs: "test(realA, realB)", emittedText: "local realCond = test(realA, realB)", originalTarget: "state", originalText: "state = test(r1, r2)", reads: ["realA", "realB"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "realCond and 4 or 2", emittedText: "state = realCond and 4 or 2", originalText: "state = state and 4 or 2", reads: ["realCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(effectfulReorderedRepeatRejected.applied, false);
assert(effectfulReorderedRepeatRejected.reason.includes("loop/backedge"));

const dependentRepeatJunkRejected = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", emittedTarget: "junkFn", rhs: "getPredicate()", emittedText: "local junkFn = getPredicate()", originalText: "r1 = getPredicate()", reads: [] },
                { kind: "version-define", emittedTarget: "dependent", rhs: "junkFn", emittedText: "local dependent = junkFn", originalText: "r9 = r1", reads: ["junkFn"] },
                { kind: "version-define", emittedTarget: "junkCond", rhs: "junkFn()", emittedText: "local junkCond = junkFn()", originalText: "state = r1()", reads: ["junkFn"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", originalText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3], operations: [
                { kind: "statement", emittedText: "consume()", originalText: "consume()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "3", emittedText: "state = 3", originalText: "state = 3", reads: [] },
            ] },
            { id: 3, predecessors: [2], successors: [4, 2], operations: [
                { kind: "version-define", emittedTarget: "realFn", rhs: "getPredicate()", emittedText: "local realFn = getPredicate()", originalText: "r1 = getPredicate()", reads: [] },
                { kind: "version-define", emittedTarget: "realCond", rhs: "realFn()", emittedText: "local realCond = realFn()", originalText: "state = r1()", reads: ["realFn"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "realCond and 4 or 2", emittedText: "state = realCond and 4 or 2", originalText: "state = state and 4 or 2", reads: ["realCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(dependentRepeatJunkRejected.applied, false);
assert(dependentRepeatJunkRejected.reason.includes("loop/backedge"));


const whileBreakStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true, stateName: "state", entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 4], successors: [3, 5], operations: [
                { kind: "version-define", emittedTarget: "loopCond", rhs: "looping()", emittedText: "local loopCond = looping()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "loopCond and 3 or 5", emittedText: "state = loopCond and 3 or 5", reads: ["loopCond"] },
            ] },
            { id: 3, predecessors: [2], successors: [5, 4], operations: [
                { kind: "version-define", emittedTarget: "breakCond", rhs: "shouldBreak()", emittedText: "local breakCond = shouldBreak()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "breakCond and 5 or 4", emittedText: "state = breakCond and 5 or 4", reads: ["breakCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [2], operations: [
                { kind: "statement", emittedText: "work()", originalText: "work()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 5, predecessors: [2, 3], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(whileBreakStructured.applied, true);
assert.equal(whileBreakStructured.whileLoopCount, 1);
assert(whileBreakStructured.source.includes("if (shouldBreak()) then"));
assert(!whileBreakStructured.source.includes("local breakCond = shouldBreak()"));
assert(whileBreakStructured.source.includes("break"));
assert(whileBreakStructured.source.includes("work()"));
parseLua(whileBreakStructured.source, "<beta-cf-while-break-output>");

const whileContinueStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true, stateName: "state", entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3, 4], successors: [3, 5], operations: [
                { kind: "version-define", emittedTarget: "loopCond", rhs: "looping()", emittedText: "local loopCond = looping()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "loopCond and 3 or 5", emittedText: "state = loopCond and 3 or 5", reads: ["loopCond"] },
            ] },
            { id: 3, predecessors: [2], successors: [2, 4], operations: [
                { kind: "version-define", emittedTarget: "continueCond", rhs: "shouldContinue()", emittedText: "local continueCond = shouldContinue()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "continueCond and 2 or 4", emittedText: "state = continueCond and 2 or 4", reads: ["continueCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [2], operations: [
                { kind: "statement", emittedText: "work()", originalText: "work()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 5, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(whileContinueStructured.applied, true);
assert.equal(whileContinueStructured.whileLoopCount, 1);
assert(whileContinueStructured.source.includes("if (shouldContinue()) then"));
assert(!whileContinueStructured.source.includes("local continueCond = shouldContinue()"));
assert(whileContinueStructured.source.includes("continue"));
assert(whileContinueStructured.source.includes("work()"));
parseLua(whileContinueStructured.source, "<beta-cf-while-continue-output>");

const whileReturnStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true, stateName: "state", entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 5], operations: [
                { kind: "version-define", emittedTarget: "loopCond", rhs: "looping()", emittedText: "local loopCond = looping()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "loopCond and 3 or 5", emittedText: "state = loopCond and 3 or 5", reads: ["loopCond"] },
            ] },
            { id: 3, predecessors: [2], successors: [4, 2], operations: [
                { kind: "version-define", emittedTarget: "returnCond", rhs: "shouldReturn()", emittedText: "local returnCond = shouldReturn()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "returnCond and 4 or 2", emittedText: "state = returnCond and 4 or 2", reads: ["returnCond"] },
            ] },
            { id: 4, predecessors: [3], successors: [], operations: [
                { kind: "version-define", emittedTarget: "ret", rhs: "42", emittedText: "local ret = 42", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["ret"], emittedText: "ReturnVal = { ret }", rhs: "{ ret }", reads: ["ret"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
            { id: 5, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(whileReturnStructured.applied, true);
assert.equal(whileReturnStructured.whileLoopCount, 1);
assert(whileReturnStructured.source.includes("if (shouldReturn()) then"));
assert(!whileReturnStructured.source.includes("local returnCond = shouldReturn()"));
assert(whileReturnStructured.source.includes("return ret"));
assert(!whileReturnStructured.source.includes("continue"));
parseLua(whileReturnStructured.source, "<beta-cf-while-return-output>");

const cyclic = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [
            { id: 1, predecessors: [2], successors: [2], operations: [
                { kind: "state-transition", emittedText: "state = 2", rhs: "2", reads: [] },
            ] },
            { id: 2, predecessors: [1], successors: [1], operations: [
                { kind: "state-transition", emittedText: "state = 1", rhs: "1", reads: [] },
            ] },
        ],
    },
});
assert.equal(cyclic.applied, false);
assert(cyclic.reason.includes("loop/backedge"));


const genericForStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        recoveredUpvalueBindings: ["capturedCopy"],
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "version-define", originalTarget: "r7", emittedTarget: "iter", rhs: "pairs", emittedText: "local iter = pairs", reads: [] },
                { kind: "version-define", originalTarget: "r1", emittedTarget: "invariant", rhs: "items", emittedText: "local invariant = items", reads: [] },
                { kind: "version-define", originalTarget: "r2", emittedTarget: "controlEpoch", rhs: "nil", emittedText: "local controlEpoch = nil", reads: [] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                { kind: "multi-call-write", originalTargets: ["r2", "r4"], emittedTargets: ["controlEpoch", "valueEpoch"], callBaseOriginal: "r7", callArgumentOriginals: ["r1", "r2"], rhs: "iter(invariant, controlEpoch)", originalText: "r2, r4 = r7(r1, r2)", emittedText: "controlEpoch, valueEpoch = iter(invariant, controlEpoch)", reads: ["iter", "invariant", "controlEpoch"] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "controlEpoch and 3 or 4", emittedText: "state = controlEpoch and 3 or 4", reads: ["controlEpoch"] },
            ] },
            { id: 3, predecessors: [2], successors: [2], operations: [
                { kind: "epoch-start", originalTarget: "r3", emittedTarget: "i", rhs: "controlEpoch", originalText: "r3 = r2", emittedText: "local i = controlEpoch", reads: ["controlEpoch"] },
                { kind: "upvalue-binding-start", originalTarget: "capturedCopy", emittedTarget: "capturedCopy", rhs: "valueEpoch", originalText: "capturedCopy = r4", emittedText: "local capturedCopy = valueEpoch", reads: ["valueEpoch"] },
                { kind: "statement", originalText: "consume(i, r4, capturedCopy)", emittedText: "consume(i, valueEpoch, capturedCopy)", reads: ["i", "valueEpoch", "capturedCopy"] },
                { kind: "epoch-kill", originalTarget: "r3", emittedTarget: "i", rhs: "nil", emittedText: "i = nil", reads: [] },
                { kind: "epoch-kill", originalTarget: "r4", emittedTarget: "valueEpoch", rhs: "nil", emittedText: "valueEpoch = nil", reads: [] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(genericForStructured.applied, true);
assert.equal(genericForStructured.genericForLoopCount, 1);
assert.equal(genericForStructured.numericForLoopCount, 0);
assert.equal(genericForStructured.whileLoopCount, 0);
assert(genericForStructured.source.includes("for i, valueEpoch in iter, invariant, controlEpoch do"));
assert(genericForStructured.source.includes("consume(i, valueEpoch, capturedCopy)"));
assert(genericForStructured.source.includes("local capturedCopy = valueEpoch"));
assert(!genericForStructured.source.includes("controlEpoch, valueEpoch ="));
assert(!genericForStructured.source.includes("state ="));
parseLua(genericForStructured.source, "<beta-cf-generic-for-output>");

const capturedGenericForStructured = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        recoveredUpvalueBindings: ["capturedKey", "capturedValue"],
        entries: [101],
        states: [
            { id: 101, predecessors: [], successors: [202], operations: [
                { kind: "version-define", originalTarget: "iterReg", emittedTarget: "iter", rhs: "next", emittedText: "local iter = next", reads: [] },
                { kind: "version-define", originalTarget: "stateReg", emittedTarget: "iterState", rhs: "items", emittedText: "local iterState = items", reads: [] },
                { kind: "version-define", originalTarget: "controlReg", emittedTarget: "initialControl", rhs: "nil", emittedText: "local initialControl = nil", reads: [] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "202", emittedText: "state = 202", reads: [] },
            ] },
            { id: 202, predecessors: [101, 303], successors: [303, 404], operations: [
                { kind: "multi-call-write", originalTargets: ["controlReg", "valueReg"], emittedTargets: ["controlReg", "valueReg"], callBaseOriginal: "iterReg", callArgumentOriginals: ["stateReg", "controlReg"], rhs: "iter(iterState, controlReg)", emittedText: "controlReg, valueReg = iter(iterState, controlReg)", reads: ["iter", "iterState"] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "controlReg and 303 or 404", emittedText: "state = controlReg and 303 or 404", reads: [] },
            ] },
            { id: 303, predecessors: [202], successors: [202], operations: [
                { kind: "epoch-start", originalTarget: "keyReg", emittedTarget: "capturedKey", rhs: "controlReg", emittedText: "local capturedKey = controlReg", reads: [] },
                { kind: "upvalue-binding-start", originalTarget: "capturedValue", emittedTarget: "capturedValue", rhs: "valueReg", emittedText: "local capturedValue = valueReg", reads: [] },
                { kind: "statement", originalText: "consume(capturedKey, capturedValue)", emittedText: "consume(capturedKey, capturedValue)", reads: ["capturedKey", "capturedValue"] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "202", emittedText: "state = 202", reads: [] },
            ] },
            { id: 404, predecessors: [202], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(capturedGenericForStructured.applied, true);
assert.equal(capturedGenericForStructured.genericForLoopCount, 1);
assert.equal(capturedGenericForStructured.whileLoopCount, 0);
assert(capturedGenericForStructured.source.includes("for capturedKey, capturedValue in iter, iterState, initialControl do"));
assert(capturedGenericForStructured.source.includes("consume(capturedKey, capturedValue)"));
assert(!capturedGenericForStructured.source.includes("local capturedValue = valueReg"));
assert(!capturedGenericForStructured.source.includes("controlReg, valueReg ="));
assert(!capturedGenericForStructured.source.includes("state ="));
parseLua(capturedGenericForStructured.source, "<beta-cf-captured-generic-for-output>");

const siblingLoopVariableReuse = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "structured-generic-for", structuredNode: { type: "generic-for", variables: ["a", "sharedLoopValue"], expressions: ["iterA", "stateA", "controlA"], body: [], reads: ["iterA", "stateA", "controlA"] }, emittedText: "for a, sharedLoopValue in iterA, stateA, controlA do end", reads: ["iterA", "stateA", "controlA"] },
                { kind: "structured-generic-for", structuredNode: { type: "generic-for", variables: ["b", "sharedLoopValue"], expressions: ["iterB", "stateB", "controlB"], body: [], reads: ["iterB", "stateB", "controlB"] }, emittedText: "for b, sharedLoopValue in iterB, stateB, controlB do end", reads: ["iterB", "stateB", "controlB"] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ],
        }],
    },
});
assert.equal(siblingLoopVariableReuse.applied, true);
assert(siblingLoopVariableReuse.source.includes("for a, sharedLoopValue in iterA, stateA, controlA do"));
assert(siblingLoopVariableReuse.source.includes("for b, sharedLoopValue in iterB, stateB, controlB do"));
parseLua(siblingLoopVariableReuse.source, "<beta-cf-sibling-loop-variable-output>");

const posPreservationGraph = {
    stateName: "state",
    states: [
        { id: 1, operations: [
            { kind: "epoch-start", originalTarget: "tmpReg", emittedTarget: "savedPos", rhs: "state", emittedText: "local savedPos = state", reads: [] },
            { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
        ] },
        { id: 2, operations: [
            { kind: "version-define", originalTarget: "state", emittedTarget: "deadRestoredPos", rhs: "savedPos", emittedText: "local deadRestoredPos = savedPos", reads: ["savedPos"] },
            { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "3", emittedText: "state = 3", reads: [] },
        ] },
        { id: 3, operations: [
            { kind: "epoch-start", originalTarget: "orphanTmp", emittedTarget: "orphanSavedPos", rhs: "state", emittedText: "local orphanSavedPos = state", reads: [] },
            { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
        ] },
    ],
};
const posPreservationRemoved = removeCompilerPosPreservationOperations(posPreservationGraph);
assert.deepEqual(posPreservationRemoved, { removed: 3, saveCount: 2, restoreCount: 1, orphanSaveCount: 1 });
assert(!posPreservationGraph.states.some(state => state.operations.some(operation => String(operation.emittedText || "").includes("savedPos"))));

const usedPosPreservationGraph = {
    stateName: "state",
    states: [
        { id: 1, operations: [
            { kind: "epoch-start", originalTarget: "tmpReg", emittedTarget: "savedPos", rhs: "state", emittedText: "local savedPos = state", reads: [] },
            { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
        ] },
        { id: 2, operations: [
            { kind: "version-define", originalTarget: "state", emittedTarget: "deadRestoredPos", rhs: "savedPos", emittedText: "local deadRestoredPos = savedPos", reads: ["savedPos"] },
            { kind: "statement", emittedText: "consume(savedPos)", reads: ["savedPos"] },
            { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
        ] },
    ],
};
const usedPosPreservationKept = removeCompilerPosPreservationOperations(usedPosPreservationGraph);
assert.deepEqual(usedPosPreservationKept, { removed: 0, saveCount: 0, restoreCount: 0, orphanSaveCount: 0 });
assert(usedPosPreservationGraph.states[0].operations.some(operation => operation.emittedTarget === "savedPos"));


const overflowNormalized = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "effect-write", emittedText: "RegisterOverflow[91] = 1", reads: [] },
                { kind: "version-define", emittedTarget: "overflowValue", emittedText: "local overflowValue = RegisterOverflow[7]", rhs: "RegisterOverflow[7]", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["overflowValue"], emittedText: "ReturnVal = { overflowValue }", rhs: "{ overflowValue }", reads: ["overflowValue"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ],
        }],
    },
});
assert.equal(overflowNormalized.applied, true);
assert.equal(overflowNormalized.registerOverflowUsed, true);
assert.equal(overflowNormalized.registerOverflowSlotCount, 2);
assert(overflowNormalized.source.includes("local RegisterOverflow = {}"));
assert(overflowNormalized.source.includes("RegisterOverflow.v2 = 1"));
assert(overflowNormalized.source.includes("local overflowValue = RegisterOverflow.v1"));
assert(!overflowNormalized.source.includes("RegisterOverflow["));
parseLua(overflowNormalized.source, "<beta-cf-overflow-normalized>");

const nestedOverflowNormalized = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "child", emittedText: "local child = createClosure2(2, {})", rhs: "createClosure2(2, {})", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["child"], emittedText: "ReturnVal = { child }", rhs: "{ child }", reads: ["child"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "effect-write", emittedText: "RegisterOverflow[44] = 5", reads: [] },
                { kind: "version-define", emittedTarget: "value", emittedText: "local value = RegisterOverflow[44]", rhs: "RegisterOverflow[44]", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["value"], emittedText: "ReturnVal = { value }", rhs: "{ value }", reads: ["value"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(nestedOverflowNormalized.applied, true);
assert.equal((nestedOverflowNormalized.source.match(/local RegisterOverflow = \{\}/g) || []).length, 1);
assert(nestedOverflowNormalized.source.includes("RegisterOverflow.v1 = 5"));
assert(nestedOverflowNormalized.source.includes("local value = RegisterOverflow.v1"));
assert(!nestedOverflowNormalized.source.includes("RegisterOverflow["));
parseLua(nestedOverflowNormalized.source, "<beta-cf-nested-overflow-normalized>");

const overflowFactoryNormalized = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "effect-write", emittedText: "RegisterOverflow[44] = createClosure2(2, {})", rhs: "createClosure2(2, {})", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["RegisterOverflow[44]"], emittedText: "ReturnVal = { RegisterOverflow[44] }", rhs: "{ RegisterOverflow[44] }", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(overflowFactoryNormalized.applied, true);
assert(overflowFactoryNormalized.source.includes("function RegisterOverflow.v1()"));
assert(!overflowFactoryNormalized.source.includes("createClosure2("));
assert(!overflowFactoryNormalized.source.includes("RegisterOverflow["));
parseLua(overflowFactoryNormalized.source, "<beta-cf-overflow-factory-normalized>");

const escapingEpochHoisted = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2, 3], operations: [
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "cond and 2 or 3", emittedText: "state = cond and 2 or 3", reads: ["cond"] },
            ] },
            { id: 2, predecessors: [1], successors: [4], operations: [
                { kind: "epoch-start", originalTarget: "r1", emittedTarget: "joinedValue", rhs: "1", emittedText: "local joinedValue = 1", reads: [], registerEpoch: "r1:epoch:1" },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "4", emittedText: "state = 4", reads: [] },
            ] },
            { id: 3, predecessors: [1], successors: [4], operations: [
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "4", emittedText: "state = 4", reads: [] },
            ] },
            { id: 4, predecessors: [2, 3], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["joinedValue"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { joinedValue }", rhs: "{ joinedValue }", reads: ["joinedValue"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(escapingEpochHoisted.applied, true);
assert.equal(escapingEpochHoisted.hoistedEpochDeclarationCount, 1);
assert(escapingEpochHoisted.source.includes("local joinedValue\n"));
assert(escapingEpochHoisted.source.includes("joinedValue = 1"));
assert(!escapingEpochHoisted.source.includes("local joinedValue = 1"));
assert(escapingEpochHoisted.source.includes("return joinedValue"));
parseLua(escapingEpochHoisted.source, "<beta-cf-escaping-epoch-hoist>");

const dynamicOverflowRejected = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "effect-write", emittedText: "RegisterOverflow[index] = 1", reads: ["index"] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ],
        }],
    },
});
assert.equal(dynamicOverflowRejected.applied, false);
assert(dynamicOverflowRejected.reason.includes("non-static"));

// Regression: a nested branch may have a local shared join that is itself a
// proven terminal return, even when that join cannot reach the surrounding
// partial continuation. Keep that terminal join local so it is emitted once.
const terminalLocalJoinGraph = {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2, 8], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "condOuter and 2 or 8", emittedText: "state = condOuter and 2 or 8", reads: ["condOuter"] },
            ] },
            { id: 2, predecessors: [1], successors: [3, 6], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "condMiddle and 3 or 6", emittedText: "state = condMiddle and 3 or 6", reads: ["condMiddle"] },
            ] },
            { id: 3, predecessors: [2], successors: [4, 5], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "condInner and 4 or 5", emittedText: "state = condInner and 4 or 5", reads: ["condInner"] },
            ] },
            { id: 4, predecessors: [3], successors: [5], operations: [
                { kind: "statement", emittedText: "mark()", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "5", emittedText: "state = 5", reads: [] },
            ] },
            { id: 5, predecessors: [3, 4], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["1"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { 1 }", rhs: "{ 1 }", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
            { id: 6, predecessors: [2], successors: [9], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "9", emittedText: "state = 9", reads: [] },
            ] },
            { id: 8, predecessors: [1], successors: [9], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "9", emittedText: "state = 9", reads: [] },
            ] },
            { id: 9, predecessors: [6, 8], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["2"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { 2 }", rhs: "{ 2 }", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
};
const terminalLocalJoinProduction = solveBetaControlFlow(ast, terminalLocalJoinGraph);
assert.equal(terminalLocalJoinProduction.applied, true);
assert(terminalLocalJoinProduction.source.includes("mark()"));
assert.equal((terminalLocalJoinProduction.source.match(/return 1/g) || []).length, 1);
const terminalLocalJoinExperimental = solveExperimentalBetaControlFlow(ast, terminalLocalJoinGraph);
assert.equal(terminalLocalJoinExperimental.applied, true);
assert.equal((terminalLocalJoinExperimental.source.match(/return 1/g) || []).length, 1);
parseLua(terminalLocalJoinProduction.source, "<beta-cf-terminal-local-join>");
// Regression: scalar VM compound writes stay native through beta-CF once
// lifetime analysis proves the read-modify-write belongs to one beta epoch.
const nativeCompoundCfSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = 2
            r1 -= r2
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const nativeCompoundCfAst = parseLuaStructural(nativeCompoundCfSource, "<beta-cf-native-compound>");
const nativeCompoundCfBeta = versionVmBlockRegisters(nativeCompoundCfSource, nativeCompoundCfAst);
assert.equal(nativeCompoundCfBeta.nativeCompoundWriteCount, 1);
const nativeCompoundCfResult = solveBetaControlFlow(nativeCompoundCfAst, nativeCompoundCfBeta);
assert.equal(nativeCompoundCfResult.applied, true);
assert(nativeCompoundCfResult.source.includes("-="));
assert(!/\br1\s*-=/.test(nativeCompoundCfResult.source));
parseLua(nativeCompoundCfResult.source, "<beta-cf-native-compound-output>");

// Regression: Prometheus may compile a repeat condition once before the body and
// again as the real post-test. A short-circuit condition can create nested suffix
// matches inside the full duplicated region; recover only the unique maximal copy.
const repeatShortCircuitInput = path.join(__dirname, "..", "sample", "36.txt");
const repeatShortCircuitTemp = path.join(os.tmpdir(), `beta-cf-repeat-short-circuit-${process.pid}.lua`);
try {
    const normal = runDeobfuscator(repeatShortCircuitInput, repeatShortCircuitTemp, { analyzeBindings: false });
    const normalAst = parseLuaStructural(normal.outputSource, "<beta-cf-repeat-short-circuit-normal>");
    const beta = versionVmBlockRegisters(normal.outputSource, normalAst);
    assert.equal(beta.applied, true);

    const production = solveBetaControlFlow(normalAst, beta);
    assert.equal(production.applied, true);
    assert.equal(production.repeatLoopCount, 1);
    assert.equal(production.removedRepeatCompilerConditionRegionCount, 1);
    assert.equal(production.removedRepeatCompilerConditionStateCount, 4);
    assert(production.source.includes('"short-repeat-body"'));

    const experimental = solveExperimentalBetaControlFlow(normalAst, beta);
    assert.equal(experimental.applied, true);
    assert.equal(experimental.repeatLoopCount, 1);
    assert.equal(experimental.removedRepeatCompilerConditionRegionCount, 1);
    assert.equal(experimental.removedRepeatCompilerConditionStateCount, 4);
} finally {
    if (fs.existsSync(repeatShortCircuitTemp)) fs.unlinkSync(repeatShortCircuitTemp);
}


const parallelAtomicCfSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = 20
            r1, r2 = r2, r1
            ReturnVal = consume(r1, r2)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const parallelAtomicCfAst = parseLua(parallelAtomicCfSource, "<beta-cf-parallel-atomic-input>");
const parallelAtomicCfBeta = versionVmBlockRegisters(parallelAtomicCfSource, parallelAtomicCfAst);
const parallelAtomicCfOp = parallelAtomicCfBeta.graph.states[0].operations.find(operation => operation.kind === "multi-write");
assert(parallelAtomicCfOp);
const parallelAtomicCf = solveBetaControlFlow(parallelAtomicCfAst, parallelAtomicCfBeta);
assert.equal(parallelAtomicCf.applied, true);
assert(parallelAtomicCf.source.includes(parallelAtomicCfOp.emittedText));
assert(parallelAtomicCf.source.includes(`consume(${parallelAtomicCfOp.emittedTargets[0]},${parallelAtomicCfOp.emittedTargets[1]})`) ||
    parallelAtomicCf.source.includes(`consume(${parallelAtomicCfOp.emittedTargets[0]}, ${parallelAtomicCfOp.emittedTargets[1]})`));
parseLua(parallelAtomicCf.source, "<beta-cf-parallel-atomic-output>");

const complexCompoundCfSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, ReturnVal
    while state do
        if state == 1 then
            r1 = bucket
            r2 = indexValue
            r3 = delta
            r1[getIndex(r2)] += r3
            r1.value *= r2
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const complexCompoundCfAst = parseLua(complexCompoundCfSource, "<beta-cf-complex-compound-input>");
const complexCompoundCfBeta = versionVmBlockRegisters(complexCompoundCfSource, complexCompoundCfAst);
const complexCompoundCf = solveBetaControlFlow(complexCompoundCfAst, complexCompoundCfBeta);
assert.equal(complexCompoundCf.applied, true);
assert.equal((complexCompoundCf.source.match(/getIndex\(/g) || []).length, 1);
assert(complexCompoundCf.source.includes("+="));
assert(complexCompoundCf.source.includes("*="));
parseLua(complexCompoundCf.source, "<beta-cf-complex-compound-output>");

console.log("beta control-flow tests passed");
