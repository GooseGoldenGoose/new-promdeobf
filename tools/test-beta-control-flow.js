const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

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
assert.equal(unsafeSink.terminalReturnPayloadSunk, false);
assert.equal(unsafeSink.terminalReturnLowered, false);
assert(unsafeSink.source.indexOf("ReturnVal = { r_v1_1 }") < unsafeSink.source.indexOf("mark(\"after\")"));

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

console.log("beta control-flow tests passed");
