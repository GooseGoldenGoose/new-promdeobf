"use strict";
const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");
const ast = parseLua("return (function(...) return 1 end)(...)", "<numeric-for-temp-wrapper>");

function solve({ start = "1", final = "3", step = "1", order = ["start", "final", "step"], extraStartUse = false, directLoopBinding = false, mutateDirect = false, removedCleanup = false }) {
    const values = { start, final, step };
    const pre = order.map(name => ({
        kind: "version-define", emittedTarget: name, rhs: values[name], emittedText: `local ${name} = ${values[name]}`, reads: [],
    }));
    if (extraStartUse) pre.push({ kind: "statement", emittedText: "observe(start)", originalText: "observe(start)", reads: ["start"] });
    pre.push(
        { kind: "version-define", emittedTarget: "zero", rhs: "0", emittedText: "local zero = 0", reads: [] },
        { kind: "version-define", emittedTarget: "neg", rhs: "step < zero", emittedText: "local neg = step < zero", reads: ["step", "zero"] },
        { kind: "epoch-mutate", emittedTarget: "current", rhs: "start - step", emittedText: "current = start - step", reads: ["start", "step"] },
        { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
    );
    return solveBetaControlFlow(ast, { applied: true, graph: {
        cfgComplete: true, stateName: "state", entries: [1], states: [
            { id: 1, predecessors: [], successors: [2], operations: pre },
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
            { id: 3, predecessors: [2], successors: [2], operations: directLoopBinding ? [
                ...(mutateDirect ? [{ kind: "epoch-mutate", emittedTarget: "current", rhs: "99", emittedText: "current = 99", reads: [] }] : []),
                { kind: "statement", emittedText: "consume(current)", originalText: "consume(current)", reads: ["current"] },
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] : [
                { kind: "epoch-start", originalTarget: "loopPhysical", emittedTarget: "loopVar", rhs: "current", emittedText: "local loopVar = current", reads: ["current"], registerEpoch: "loop:1" },
                { kind: "statement", emittedText: "consume(loopVar)", originalText: "consume(loopVar)", reads: ["loopVar"] },
                ...(!removedCleanup ? [{ kind: "epoch-kill", originalTarget: "loopPhysical", emittedTarget: "deadLoopCleanup", rhs: "nil", emittedText: "local deadLoopCleanup = nil", reads: [], registerEpoch: "loop:1" }] : []),
                { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    }});
}

let r = solve({});
assert.equal(r.applied, true); assert.equal(r.numericForLoopCount, 1);
assert(r.source.includes("for loopVar = 1, 3 do"), r.source);
assert(!r.source.includes("local start =") && !r.source.includes("local final =") && !r.source.includes("local step ="));

r = solve({ start: "3", final: "1", step: "-1" });
assert(r.source.includes("for loopVar = 3, 1, -1 do"), r.source);


r = solve({ removedCleanup: true });
assert.equal(r.numericForLoopCount, 1);
assert(r.source.includes("for loopVar = 1, 3 do"), r.source);

r = solve({ directLoopBinding: true });
assert.equal(r.numericForLoopCount, 1);
assert.equal(r.whileLoopCount, 0);
assert(r.source.includes("for current = 1, 3 do"), r.source);
assert(r.source.includes("consume(current)"), r.source);

r = solve({ start: "10", final: "1", step: "-1", directLoopBinding: true });
assert(r.source.includes("for current = 10, 1, -1 do"), r.source);

r = solve({ directLoopBinding: true, mutateDirect: true });
assert.equal(r.applied, false);
assert(r.reason.includes("loop/backedge"));

r = solve({ start: "S()", final: "F()", step: "P()" });
assert(r.source.includes("for loopVar = S(), F(), P() do"), r.source);
assert(r.source.indexOf("S()") < r.source.indexOf("F()") && r.source.indexOf("F()") < r.source.indexOf("P()"));

r = solve({ start: "S()", final: "F()", step: "P()", order: ["final", "start", "step"] });
assert(r.source.includes("for loopVar = start, final, step do"), r.source);
assert(r.source.includes("local start = S()") && r.source.includes("local final = F()"));

r = solve({ start: "S()", final: "F()", step: "P()", extraStartUse: true });
assert(r.source.includes("for loopVar = start, final, step do"), r.source);
assert(r.source.includes("observe(start)"));

for (const [name, result] of [["default", solve({})], ["negative", solve({ start:"3",final:"1",step:"-1" })]]) parseLua(result.source, `<numeric-for-${name}>`);
console.log("beta CF numeric-for temps: PASS");