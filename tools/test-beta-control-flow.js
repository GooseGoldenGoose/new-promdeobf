const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow, removeCompilerPosPreservationOperations } = require("../passes/beta-control-flow");

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
assert(result.source.startsWith("--headers\n\nlocal _env = getfenv()\nlocal args = { ... }\n\n--body\n\n"));
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
assert(acyclicStructured.source.includes("if r_v3_1 then"));
assert(acyclicStructured.source.includes("if r_v5_1 then"));
assert(acyclicStructured.source.includes("r_v2_1 = r_v4_1"));
assert(acyclicStructured.source.indexOf("r_v2_1 = r_v4_1") < acyclicStructured.source.indexOf("local r_v5_1 = flag2()"));
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
assert(diamond.source.includes("if r_v9_1 then"));
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
assert(sharedContinuationEarlyReturn.source.includes("if r_v20_1 then"));
assert(sharedContinuationEarlyReturn.source.includes("if r_v21_1 then"));
assert(sharedContinuationEarlyReturn.source.includes("if r_v22_1 then"));
assert(sharedContinuationEarlyReturn.source.includes("if r_v23_1 then"));
assert.equal((sharedContinuationEarlyReturn.source.match(/finish\(\)/g) || []).length, 1);
assert.equal((sharedContinuationEarlyReturn.source.match(/markL\(\)/g) || []).length, 1);
assert(sharedContinuationEarlyReturn.source.indexOf("markG()") < sharedContinuationEarlyReturn.source.indexOf("local r_v22_1 = chooseC()"));
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
assert(nestedClosureRegions.source.includes("local r_v1_1 = function(...)"));
assert(nestedClosureRegions.source.includes("local args = { ... }"));
assert(nestedClosureRegions.source.includes("local r_v3_1 = args[1]"));
assert(nestedClosureRegions.source.includes("local r_v4_1 = args[2]"));
assert(nestedClosureRegions.source.includes("return r_v5_1"));
assert(!nestedClosureRegions.source.includes("createClosure7("));
assert(!nestedClosureRegions.source.includes("state ="));
assert(!nestedClosureRegions.source.includes("ReturnVal ="));
parseLua(nestedClosureRegions.source, "<beta-cf-nested-closure-output>");

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
assert(numericForBranchBody.source.includes("if branchCond then"));
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
assert(whileGuardStructured.source.includes("while true do"));
assert(whileGuardStructured.source.includes("if not (cond) then"));
assert(whileGuardStructured.source.includes("break"));
assert(whileGuardStructured.source.includes("local sink = consume()"));
assert(!whileGuardStructured.source.includes("state ="));
const whileIndex = whileGuardStructured.source.indexOf("while true do");
const conditionIndex = whileGuardStructured.source.indexOf("local cond = predicate()");
const guardIndex = whileGuardStructured.source.indexOf("if not (cond) then");
const bodyIndex = whileGuardStructured.source.indexOf("local sink = consume()");
assert(whileIndex >= 0 && whileIndex < conditionIndex && conditionIndex < guardIndex && guardIndex < bodyIndex);
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
assert(repeatUntilStructured.source.includes("until realCond"));
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
assert(reorderedRepeatCondition.source.includes("until realCond"));
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
assert(whileBreakStructured.source.includes("if breakCond then"));
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
assert(whileContinueStructured.source.includes("if continueCond then"));
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
assert(whileReturnStructured.source.includes("if returnCond then"));
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
                { kind: "version-define", originalTarget: "r2", emittedTarget: "initialControl", rhs: "nil", emittedText: "local initialControl = nil", reads: [] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                { kind: "multi-call-write", originalTargets: ["r2", "r4"], emittedTargets: ["r2", "r4"], callBaseOriginal: "r7", callArgumentOriginals: ["r1", "r2"], rhs: "iter(invariant, r2)", emittedText: "r2, r4 = iter(invariant, r2)", reads: ["iter", "invariant"] },
                { kind: "state-transition", originalTarget: "state", emittedTarget: "state", rhs: "r2 and 3 or 4", emittedText: "state = r2 and 3 or 4", reads: [] },
            ] },
            { id: 3, predecessors: [2], successors: [2], operations: [
                { kind: "epoch-start", originalTarget: "r3", emittedTarget: "i", rhs: "r2", emittedText: "local i = r2", reads: [] },
                { kind: "upvalue-binding-start", originalTarget: "capturedCopy", emittedTarget: "capturedCopy", rhs: "r4", emittedText: "local capturedCopy = r4", reads: ["r4"] },
                { kind: "statement", originalText: "consume(i, r4, capturedCopy)", emittedText: "consume(i, r4, capturedCopy)", reads: ["i", "r4", "capturedCopy"] },
                { kind: "epoch-kill", originalTarget: "r3", emittedTarget: "i", rhs: "nil", emittedText: "i = nil", reads: [] },
                { kind: "version-define", originalTarget: "r4", emittedTarget: "deadSecond", rhs: "nil", emittedText: "local deadSecond = nil", reads: [] },
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
assert(genericForStructured.source.includes("for i, r4 in iter, invariant, initialControl do"));
assert(genericForStructured.source.includes("consume(i, r4, capturedCopy)"));
assert(genericForStructured.source.includes("local capturedCopy = r4"));
assert(!genericForStructured.source.includes("r2, r4 ="));
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

console.log("beta control-flow tests passed");
