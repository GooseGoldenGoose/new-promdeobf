"use strict";
const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

const wrapper = parseLua("return (function(...) return 1 end)(...)", "<cf-condition-wrapper>");

function terminal(id, label) {
    return { id, predecessors: [1], successors: [], operations: [
        { kind: "statement", emittedText: `${label}()`, originalText: `${label}()`, reads: [] },
        { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
        { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
    ] };
}

function solve({ rhs, reads = [], gap = [], captured = [], extraReads = [] }) {
    const operations = [
        { kind: "version-define", emittedTarget: "cond_v", rhs, emittedText: `local cond_v = ${rhs}`, reads },
        ...gap,
        { kind: "state-transition", emittedTarget: "state", rhs: "cond_v and 2 or 3", emittedText: "state = cond_v and 2 or 3", reads: ["cond_v", ...extraReads] },
    ];
    return solveBetaControlFlow(wrapper, {
        applied: true,
        graph: {
            cfgComplete: true,
            stateName: "state",
            entries: [1],
            recoveredUpvalueBindings: captured,
            states: [
                { id: 1, predecessors: [], successors: [2, 3], operations },
                terminal(2, "yes"),
                terminal(3, "no"),
            ],
        },
    });
}

for (const probe of [
    { rhs: "check()", reads: ["check"], expected: "if (check()) then" },
    { rhs: "A() and B()", reads: ["A", "B"], expected: "if (A() and B()) then" },
    { rhs: "not flag_v", reads: ["flag_v"], expected: "if (not flag_v) then" },
    { rhs: "obj_v[field_v] == 3", reads: ["obj_v", "field_v"], expected: "if (obj_v[field_v] == 3) then" },
]) {
    const result = solve(probe);
    assert.equal(result.applied, true, result.reason);
    assert.equal(result.ifConditionTempRecoveryCount, 1, probe.rhs);
    assert(result.source.includes(probe.expected), result.source);
    assert(!result.source.includes(`local cond_v = ${probe.rhs}`), result.source);
    parseLua(result.source, `<cf-condition-${probe.rhs}>`);
}

const gap = solve({
    rhs: "check()",
    reads: ["check"],
    gap: [{ kind: "statement", emittedText: "mark()", originalText: "mark()", reads: [] }],
});
assert.equal(gap.applied, true);
assert.equal(gap.ifConditionTempRecoveryCount, 0);
assert(gap.source.includes("local cond_v = check()"));
assert(gap.source.indexOf("check()") < gap.source.indexOf("mark()"));
assert(gap.source.indexOf("mark()") < gap.source.indexOf("if cond_v then"));

const captured = solve({ rhs: "check()", reads: ["check"], captured: ["cond_v"] });
assert.equal(captured.applied, true);
assert.equal(captured.ifConditionTempRecoveryCount, 0);
assert(captured.source.includes("local cond_v = check()"));

const extraUse = solve({
    rhs: "check()",
    reads: ["check"],
    gap: [{ kind: "statement", emittedText: "observe(cond_v)", originalText: "observe(cond_v)", reads: ["cond_v"] }],
});
assert.equal(extraUse.applied, true);
assert.equal(extraUse.ifConditionTempRecoveryCount, 0);
assert(extraUse.source.includes("local cond_v = check()"));

console.log("beta CF if condition temps: PASS");
