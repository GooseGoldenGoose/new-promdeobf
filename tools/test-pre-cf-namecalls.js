"use strict";
const assert = require("assert");
const { finalizePreCfNamecalls } = require("../passes/pre-cf-temp-recovery");

function makeBeta(methodLiteral, callRhs, callReads, extraSource = "", extraOps = []) {
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local base_v = args
${extraSource}            local key_v = ${JSON.stringify(methodLiteral)}
            local method_v = base_v[key_v]
            local out_v = ${callRhs}
            state = nil
        end
    end
    return ReturnVal
end`;
    const operations = [
        { index: 1, kind: "version-define", emittedTarget: "base_v", rhs: "args", reads: [], emittedText: "local base_v = args" },
        ...extraOps,
        { index: 0, kind: "version-define", emittedTarget: "key_v", rhs: JSON.stringify(methodLiteral), reads: [], emittedText: `local key_v = ${JSON.stringify(methodLiteral)}` },
        { index: 0, kind: "version-define", emittedTarget: "method_v", rhs: "base_v[key_v]", reads: ["base_v", "key_v"], emittedText: "local method_v = base_v[key_v]" },
        { index: 0, kind: "version-define", emittedTarget: "out_v", rhs: callRhs, reads: callReads, emittedText: `local out_v = ${callRhs}` },
        { index: 0, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((op, i) => op.index = i + 1);
    return { source, graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, successors: [], operations }] } };
}

for (const [method, call, reads, expected] of [
    ["Foo", "method_v(base_v)", ["method_v", "base_v"], "local out_v = base_v:Foo()"],
    ["SetAttribute", 'method_v(base_v, "x", 1)', ["method_v", "base_v"], 'local out_v = base_v:SetAttribute("x", 1)'],
]) {
    const beta = makeBeta(method, call, reads);
    finalizePreCfNamecalls(beta);
    assert.equal(beta.preCfNamecalls.safe, true);
    assert.equal(beta.preCfNamecalls.folds, 1, method);
    assert(!beta.source.includes("local key_v"));
    assert(!beta.source.includes("local method_v"));
    assert(beta.source.includes(expected), beta.source);
    assert.equal(beta.graph.states[0].operations.length, 3);
}

for (const [method, call, reads] of [
    ["not-valid", "method_v(base_v)", ["method_v", "base_v"]],
    ["end", "method_v(base_v)", ["method_v", "base_v"]],
    ["Foo", "method_v(other_v)", ["method_v", "other_v"]],
    ["Foo", "method_v(base_v, method_v)", ["method_v", "base_v"]],
]) {
    const beta = makeBeta(method, call, reads);
    finalizePreCfNamecalls(beta);
    assert.equal(beta.preCfNamecalls.folds, 0, `${method}: ${call}`);
    assert(beta.source.includes("local key_v"));
    assert(beta.source.includes("local method_v"));
}

const gapSource = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local base_v = args
            local key_v = "Foo"
            local gap_v = 1
            local method_v = base_v[key_v]
            local out_v = method_v(base_v)
            state = nil
        end
    end
    return ReturnVal
end`;
const gap = {
    source: gapSource,
    graph: {
        cfgComplete: true,
        stateName: "state",
        recoveredUpvalueBindings: [],
        states: [{ id: 1, successors: [], operations: [
            { index: 1, kind: "version-define", emittedTarget: "base_v", rhs: "args", reads: [], emittedText: "local base_v = args" },
            { index: 2, kind: "version-define", emittedTarget: "key_v", rhs: '"Foo"', reads: [], emittedText: 'local key_v = "Foo"' },
            { index: 3, kind: "version-define", emittedTarget: "gap_v", rhs: "1", reads: [], emittedText: "local gap_v = 1" },
            { index: 4, kind: "version-define", emittedTarget: "method_v", rhs: "base_v[key_v]", reads: ["base_v", "key_v"], emittedText: "local method_v = base_v[key_v]" },
            { index: 5, kind: "version-define", emittedTarget: "out_v", rhs: "method_v(base_v)", reads: ["method_v", "base_v"], emittedText: "local out_v = method_v(base_v)" },
            { index: 6, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
        ] }],
    },
};
finalizePreCfNamecalls(gap);
assert.equal(gap.preCfNamecalls.folds, 0);

console.log("pre-CF namecall recovery: PASS");