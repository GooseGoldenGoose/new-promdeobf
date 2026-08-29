"use strict";
const assert = require("assert");
const { finalizePreCfReturnAllTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ consumerRhs = "outer_v(unpack(pack_v))", extraRead = false, captured = false }) {
    const lines = [
        "            local pack_v = { inner_v() }",
        `            local out_v = ${consumerRhs}`,
        ...(extraRead ? ["            local extra_v = use_v(pack_v)"] : []),
        "            state = nil",
    ];
    const operations = [
        { index: 1, kind: "version-define", emittedTarget: "pack_v", rhs: "{ inner_v() }", reads: ["inner_v"], emittedText: "local pack_v = { inner_v() }" },
        { index: 2, kind: "version-define", emittedTarget: "out_v", rhs: consumerRhs, reads: ["outer_v", "unpack", "pack_v"], emittedText: `local out_v = ${consumerRhs}` },
        ...(extraRead ? [{ index: 3, kind: "version-define", emittedTarget: "extra_v", rhs: "use_v(pack_v)", reads: ["use_v", "pack_v"], emittedText: "local extra_v = use_v(pack_v)" }] : []),
        { index: 0, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((op, i) => op.index = i + 1);
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${lines.join("\n")}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: captured ? ["pack_v"] : [], states: [{ id: 1, successors: [], operations }] },
    };
}

{
    const beta = makeBeta({});
    finalizePreCfReturnAllTemps(beta);
    assert.equal(beta.preCfReturnAllTemps.safe, true);
    assert.equal(beta.preCfReturnAllTemps.folds, 1);
    assert(beta.source.includes("local out_v = outer_v(inner_v())"), beta.source);
    assert(!beta.source.includes("local pack_v ="));
    assert.deepEqual(beta.graph.states[0].operations[0].reads.sort(), ["inner_v", "outer_v"].sort());
}

{
    const beta = makeBeta({ consumerRhs: "outer_v(1, unpack(pack_v))" });
    finalizePreCfReturnAllTemps(beta);
    assert.equal(beta.preCfReturnAllTemps.folds, 1);
    assert(beta.source.includes("local out_v = outer_v(1, inner_v())"), beta.source);
}

for (const beta of [
    makeBeta({ consumerRhs: "outer_v(unpack(pack_v), 1)" }),
    makeBeta({ consumerRhs: "outer_v(pack_v)" }),
    makeBeta({ extraRead: true }),
    makeBeta({ captured: true }),
]) {
    finalizePreCfReturnAllTemps(beta);
    assert.equal(beta.preCfReturnAllTemps.folds, 0, beta.source);
    assert(beta.source.includes("local pack_v = { inner_v() }"));
}

console.log("pre-CF RETURN_ALL temps: PASS");
