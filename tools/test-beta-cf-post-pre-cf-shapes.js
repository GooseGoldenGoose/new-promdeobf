"use strict";
const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

const ast = parseLua("return 1", "<post-pre-cf-shapes-wrapper>");

function terminal(id, predecessors) {
    return { id, predecessors, successors: [], operations: [
        { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
        { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
    ] };
}

const numeric = solveBetaControlFlow(ast, { applied: true, graph: {
    cfgComplete: true, stateName: "state", entries: [1], recoveredUpvalueBindings: [], states: [
        { id: 1, predecessors: [], successors: [2], operations: [
            { kind: "version-define", emittedTarget: "final", rhs: "10", emittedText: "local final = 10", reads: [] },
            { kind: "version-define", emittedTarget: "step", rhs: "1", emittedText: "local step = 1", reads: [] },
            { kind: "version-define", emittedTarget: "zero", rhs: "0", emittedText: "local zero = 0", reads: [] },
            { kind: "version-define", emittedTarget: "neg", rhs: "step < zero", emittedText: "local neg = step < zero", reads: ["step", "zero"] },
            { kind: "version-define", emittedTarget: "start", rhs: "1", emittedText: "local start = 1", reads: [] },
            { kind: "epoch-start", emittedTarget: "current", rhs: "start - step", emittedText: "local current = start - step", reads: ["start", "step"] },
            { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
        ] },
        { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
            { kind: "epoch-mutate", emittedTarget: "current", rhs: "current + step", emittedText: "current = current + step", reads: ["current", "step"] },
            { kind: "version-define", emittedTarget: "notneg", rhs: "not neg", emittedText: "local notneg = not neg", reads: ["neg"] },
            { kind: "version-define", emittedTarget: "le", rhs: "current <= final", emittedText: "local le = current <= final", reads: ["current", "final"] },
            { kind: "version-define", emittedTarget: "pos", rhs: "notneg and le", emittedText: "local pos = notneg and le", reads: ["notneg", "le"] },
            { kind: "version-define", emittedTarget: "ge", rhs: "current >= final", emittedText: "local ge = current >= final", reads: ["current", "final"] },
            { kind: "version-define", emittedTarget: "negarm", rhs: "neg and ge", emittedText: "local negarm = neg and ge", reads: ["neg", "ge"] },
            { kind: "version-define", emittedTarget: "cond", rhs: "negarm or pos", emittedText: "local cond = negarm or pos", reads: ["negarm", "pos"] },
            { kind: "version-define", emittedTarget: "bodyId", rhs: "3", emittedText: "local bodyId = 3", reads: [] },
            { kind: "version-define", emittedTarget: "stateTmp", rhs: "cond and bodyId", emittedText: "local stateTmp = cond and bodyId", reads: ["cond", "bodyId"] },
            { kind: "version-define", emittedTarget: "exitId", rhs: "4", emittedText: "local exitId = 4", reads: [] },
            { kind: "state-transition", emittedTarget: "state", rhs: "stateTmp or exitId", emittedText: "state = stateTmp or exitId", reads: ["stateTmp", "exitId"] },
        ] },
        { id: 3, predecessors: [2], successors: [2], operations: [
            { kind: "effect-call", rhs: "consume(current)", emittedText: "consume(current)", reads: ["current"] },
            { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
        ] },
        terminal(4, [2]),
    ],
} });
assert.equal(numeric.applied, true);
assert.equal(numeric.numericForLoopCount, 1);
assert.equal(numeric.whileLoopCount, 0);
assert(numeric.source.includes("for current = 1, 10 do"), numeric.source);

const wh = solveBetaControlFlow(ast, { applied: true, graph: {
    cfgComplete: true, stateName: "state", entries: [1], recoveredUpvalueBindings: [], states: [
        { id: 1, predecessors: [], successors: [2], operations: [
            { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
        ] },
        { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
            { kind: "version-define", emittedTarget: "limit", rhs: "3", emittedText: "local limit = 3", reads: [] },
            { kind: "version-define", emittedTarget: "cond", rhs: "x < limit", emittedText: "local cond = x < limit", reads: ["x", "limit"] },
            { kind: "state-transition", emittedTarget: "state", rhs: "cond and 3 or 4", emittedText: "state = cond and 3 or 4", reads: ["cond"] },
        ] },
        { id: 3, predecessors: [2], successors: [2], operations: [
            { kind: "effect-call", rhs: "work()", emittedText: "work()", reads: [] },
            { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
        ] },
        terminal(4, [2]),
    ],
} });
assert.equal(wh.applied, true);
assert.equal(wh.whileLoopCount, 1);
assert(wh.source.includes("while x < (3) do"), wh.source);
assert(!wh.source.includes("while true do"), wh.source);
assert(!wh.source.includes("local limit = 3"), wh.source);

const iff = solveBetaControlFlow(ast, { applied: true, graph: {
    cfgComplete: true, stateName: "state", entries: [1], recoveredUpvalueBindings: [], states: [
        { id: 1, predecessors: [], successors: [2, 3], operations: [
            { kind: "version-define", emittedTarget: "zero", rhs: "0", emittedText: "local zero = 0", reads: [] },
            { kind: "version-define", emittedTarget: "cond", rhs: "x == zero", emittedText: "local cond = x == zero", reads: ["x", "zero"] },
            { kind: "version-define", emittedTarget: "dead", rhs: "9", emittedText: "local dead = 9", reads: [] },
            { kind: "state-transition", emittedTarget: "state", rhs: "cond and 2 or 3", emittedText: "state = cond and 2 or 3", reads: ["cond"] },
        ] },
        { id: 2, predecessors: [1], successors: [4], operations: [
            { kind: "effect-call", rhs: "yes()", emittedText: "yes()", reads: [] },
            { kind: "state-transition", emittedTarget: "state", rhs: "4", emittedText: "state = 4", reads: [] },
        ] },
        { id: 3, predecessors: [1], successors: [4], operations: [
            { kind: "effect-call", rhs: "no()", emittedText: "no()", reads: [] },
            { kind: "state-transition", emittedTarget: "state", rhs: "4", emittedText: "state = 4", reads: [] },
        ] },
        terminal(4, [2, 3]),
    ],
} });
assert.equal(iff.applied, true);
assert(iff.source.includes("if x == (0) then"), iff.source);
assert(!iff.source.includes("local zero = 0"), iff.source);
assert(!iff.source.includes("local dead = 9"), iff.source);

for (const [name, result] of [["numeric", numeric], ["while", wh], ["if", iff]]) parseLua(result.source, `<post-pre-cf-${name}>`);
console.log("beta CF post-PRE-CF shape contract: PASS");
