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

function solve({ rhs, reads = [], gap = [], tail = [], captured = [], extraReads = [] }) {
    const operations = [
        { kind: "version-define", emittedTarget: "cond_v", rhs, emittedText: `local cond_v = ${rhs}`, reads },
        ...gap,
        { kind: "state-transition", emittedTarget: "state", rhs: "cond_v and 2 or 3", emittedText: "state = cond_v and 2 or 3", reads: ["cond_v", ...extraReads] },
        ...tail,
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
    { rhs: "check()", reads: ["check"], expected: "if check() then" },
    { rhs: "A() and B()", reads: ["A", "B"], expected: "if A() and B() then" },
    { rhs: "not flag_v", reads: ["flag_v"], expected: "if not flag_v then" },
    { rhs: "obj_v[field_v] == 3", reads: ["obj_v", "field_v"], expected: "if obj_v[field_v] == 3 then" },
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

const safeTail = solve({
    rhs: "check()",
    reads: ["check"],
    tail: [{ kind: "epoch-start", emittedTarget: "args_v", rhs: "args", emittedText: "local args_v = args", reads: [], returnSinkSafe: true }],
});
assert.equal(safeTail.applied, true);
assert.equal(safeTail.ifConditionTempRecoveryCount, 1);
assert(safeTail.source.includes("local args_v = args"));
assert(safeTail.source.includes("if check() then"));
assert(safeTail.source.indexOf("local args_v = args") < safeTail.source.indexOf("if check() then"));
assert(!safeTail.source.includes("local cond_v = check()"));

const effectfulTail = solve({
    rhs: "check()",
    reads: ["check"],
    tail: [{ kind: "statement", emittedText: "mark()", originalText: "mark()", reads: [], returnSinkSafe: false }],
});
assert.equal(effectfulTail.applied, true);
assert.equal(effectfulTail.ifConditionTempRecoveryCount, 0);
assert(effectfulTail.source.includes("local cond_v = check()"));

const dependencyTail = solve({
    rhs: "source_v == 1",
    reads: ["source_v"],
    tail: [{ kind: "epoch-mutate", emittedTarget: "source_v", rhs: "2", emittedText: "source_v = 2", reads: [], returnSinkSafe: true }],
});
assert.equal(dependencyTail.applied, true);
assert.equal(dependencyTail.ifConditionTempRecoveryCount, 0);
assert(dependencyTail.source.includes("local cond_v = source_v == 1"));

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

const logicalAnd = solveBetaControlFlow(wrapper, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        recoveredUpvalueBindings: [],
        states: [
            { id: 1, predecessors: [], successors: [2, 3], operations: [
                { kind: "version-define", emittedTarget: "seed_v", rhs: "A()", emittedText: "local seed_v = A()", reads: ["A"] },
                { kind: "epoch-start", emittedTarget: "result_v", rhs: "seed_v", emittedText: "local result_v = seed_v", reads: ["seed_v"], returnSinkSafe: true },
                { kind: "state-transition", emittedTarget: "state", rhs: "seed_v and 2 or 3", emittedText: "state = seed_v and 2 or 3", reads: ["seed_v"] },
            ] },
            { id: 2, predecessors: [1], successors: [3], operations: [
                { kind: "version-define", emittedTarget: "rhs_v", rhs: "B()", emittedText: "local rhs_v = B()", reads: ["B"] },
                { kind: "epoch-mutate", emittedTarget: "result_v", rhs: "rhs_v", emittedText: "result_v = rhs_v", reads: ["rhs_v"], returnSinkSafe: true },
                { kind: "state-transition", emittedTarget: "state", rhs: "3", emittedText: "state = 3", reads: [] },
            ] },
            { id: 3, predecessors: [1, 2], successors: [4, 5], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "result_v and 4 or 5", emittedText: "state = result_v and 4 or 5", reads: ["result_v"] },
            ] },
            { id: 4, predecessors: [3], successors: [], operations: [
                { kind: "statement", emittedText: "yes()", originalText: "yes()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
            { id: 5, predecessors: [3], successors: [], operations: [
                { kind: "statement", emittedText: "no()", originalText: "no()", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(logicalAnd.applied, true, logicalAnd.reason);
assert(logicalAnd.source.includes(" and "), logicalAnd.source);
assert(logicalAnd.source.includes("A()"), logicalAnd.source);
assert(logicalAnd.source.includes("B()"), logicalAnd.source);
assert(!logicalAnd.source.includes("if seed_v then"), logicalAnd.source);
assert(!logicalAnd.source.includes("if result_v then"), logicalAnd.source);
assert.equal((logicalAnd.source.match(/A\(\)/g) || []).length, 1);
assert.equal((logicalAnd.source.match(/B\(\)/g) || []).length, 1);
parseLua(logicalAnd.source, "<cf-condition-logical-and>");

const logicalOrWithParameterSnapshot = solveBetaControlFlow(wrapper, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        recoveredUpvalueBindings: [],
        states: [
            { id: 1, predecessors: [], successors: [4, 2], operations: [
                { kind: "version-define", emittedTarget: "seed_v", rhs: "A()", emittedText: "local seed_v = A()", reads: ["A"] },
                { kind: "version-define", emittedTarget: "param_v", rhs: "args[3]", emittedText: "local param_v = args[3]", reads: ["args"] },
                { kind: "epoch-start", emittedTarget: "result_v", rhs: "seed_v", emittedText: "local result_v = seed_v", reads: ["seed_v"], returnSinkSafe: true },
                { kind: "state-transition", emittedTarget: "state", rhs: "seed_v and 4 or 2", emittedText: "state = seed_v and 4 or 2", reads: ["seed_v"] },
            ] },
            { id: 2, predecessors: [1], successors: [4, 3], operations: [
                { kind: "version-define", emittedTarget: "rhs_v", rhs: "B()", emittedText: "local rhs_v = B()", reads: ["B"] },
                { kind: "epoch-mutate", emittedTarget: "result_v", rhs: "rhs_v", emittedText: "result_v = rhs_v", reads: ["rhs_v"], returnSinkSafe: true },
                { kind: "state-transition", emittedTarget: "state", rhs: "rhs_v and 4 or 3", emittedText: "state = rhs_v and 4 or 3", reads: ["rhs_v"] },
            ] },
            { id: 3, predecessors: [2], successors: [4], operations: [
                { kind: "version-define", emittedTarget: "tail_v", rhs: "C()", emittedText: "local tail_v = C()", reads: ["C"] },
                { kind: "epoch-mutate", emittedTarget: "result_v", rhs: "tail_v", emittedText: "result_v = tail_v", reads: ["tail_v"], returnSinkSafe: true },
                { kind: "state-transition", emittedTarget: "state", rhs: "4", emittedText: "state = 4", reads: [] },
            ] },
            { id: 4, predecessors: [1, 2, 3], successors: [5, 6], operations: [
                { kind: "state-transition", emittedTarget: "state", rhs: "result_v and 5 or 6", emittedText: "state = result_v and 5 or 6", reads: ["result_v"] },
            ] },
            terminal(5, "yes"),
            terminal(6, "no"),
        ],
    },
});
assert.equal(logicalOrWithParameterSnapshot.applied, true, logicalOrWithParameterSnapshot.reason);
assert(logicalOrWithParameterSnapshot.source.includes("A()"), logicalOrWithParameterSnapshot.source);
assert(logicalOrWithParameterSnapshot.source.includes("B()"), logicalOrWithParameterSnapshot.source);
assert(logicalOrWithParameterSnapshot.source.includes("C()"), logicalOrWithParameterSnapshot.source);
assert(logicalOrWithParameterSnapshot.source.includes(" or "), logicalOrWithParameterSnapshot.source);
assert(!logicalOrWithParameterSnapshot.source.includes("if result_v then"), logicalOrWithParameterSnapshot.source);
assert.equal((logicalOrWithParameterSnapshot.source.match(/A\(\)/g) || []).length, 1);
assert.equal((logicalOrWithParameterSnapshot.source.match(/B\(\)/g) || []).length, 1);
assert.equal((logicalOrWithParameterSnapshot.source.match(/C\(\)/g) || []).length, 1);
parseLua(logicalOrWithParameterSnapshot.source, "<cf-condition-logical-or-parameter-snapshot>");
console.log("beta CF if condition temps: PASS");
