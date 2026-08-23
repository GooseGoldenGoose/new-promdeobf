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
