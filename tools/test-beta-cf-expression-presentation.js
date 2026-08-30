"use strict";
const assert = require("assert");
const {
    normalizeStructuredSingleValueExpression,
    recoverStructuredExpressionPresentation,
} = require("../passes/beta-control-flow");

for (const [input, expected] of [
    ["((A()))", "A()"],
    ["((A())) and (((B())))", "A() and B()"],
    ["(((a == b)))", "a == b"],
    ["((a + b))", "a + b"],
    ["(A() or B()) and C()", "(A() or B()) and C()"],
    ["not (A() or B())", "not (A() or B())"],
    ['((r_v2_6:IsLoaded())) and ((((_G)["Horst_SetDescription"])))', 'r_v2_6:IsLoaded() and (_G)["Horst_SetDescription"]'],
]) {
    assert.equal(normalizeStructuredSingleValueExpression(input), expected, input);
}

{
    const nodes = [
        { type: "if", condition: "((A())) and (((B())))", reads: [], thenBody: [], elseBody: null },
        { type: "while-guard", condition: "(((running())))", reads: [], conditionBody: [], body: [] },
        { type: "repeat-until", condition: "((done()))", reads: [], body: [], conditionBody: [] },
        { type: "numeric-for", variable: "i", initial: "((start()))", limit: "((limit()))", step: "((step()))", reads: [], body: [] },
        { type: "generic-for", variables: ["k", "v"], expressions: ["((iter()))", "state", "control"], reads: [], body: [] },
    ];
    assert.equal(recoverStructuredExpressionPresentation(nodes), 6);
    assert.equal(nodes[0].condition, "A() and B()");
    assert.equal(nodes[1].condition, "running()");
    assert.equal(nodes[2].condition, "done()");
    assert.equal(nodes[3].initial, "start()");
    assert.equal(nodes[3].limit, "limit()");
    assert.equal(nodes[3].step, "step()");
    // Generic-for expression lists are deliberately untouched: their final
    // expression participates in Lua multi-result adjustment.
    assert.equal(nodes[4].expressions[0], "((iter()))");
}

console.log("beta CF structured expression presentation: PASS");
