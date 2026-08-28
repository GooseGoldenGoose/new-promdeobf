"use strict";
const assert = require("assert");
const { finalizePreCfMultiReturnTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ packRhs = "{ f() }", extracts = [["a_v", 1], ["b_v", 2]], extraRead = false, localExtracts = true }) {
    const lines = [
        `            local pack_v = ${packRhs}`,
        ...extracts.map(([name, slot]) => `${localExtracts ? "            local " : "            "}${name} = pack_v[${slot}]`),
        ...(extraRead ? ["            sink_v = use(pack_v)"] : []),
        "            state = nil",
    ];
    const operations = [
        { index: 1, kind: "version-define", emittedTarget: "pack_v", rhs: packRhs, reads: ["f"], emittedText: `local pack_v = ${packRhs}` },
        ...extracts.map(([name, slot], i) => ({ index: i + 2, kind: "version-define", emittedTarget: name, rhs: `pack_v[${slot}]`, reads: ["pack_v"], emittedText: `${localExtracts ? "local " : ""}${name} = pack_v[${slot}]` })),
        ...(extraRead ? [{ index: 0, kind: "version-define", emittedTarget: "sink_v", rhs: "use(pack_v)", reads: ["use", "pack_v"], emittedText: "sink_v = use(pack_v)" }] : []),
        { index: 0, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((op, i) => op.index = i + 1);
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${lines.join("\n")}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, successors: [], operations }] },
    };
}

{
    const beta = makeBeta({});
    finalizePreCfMultiReturnTemps(beta);
    assert.equal(beta.preCfMultiReturnTemps.safe, true);
    assert.equal(beta.preCfMultiReturnTemps.folds, 1);
    assert(beta.source.includes("local a_v, b_v = f()"), beta.source);
    assert(!beta.source.includes("pack_v"));
    assert.equal(beta.graph.states[0].operations[0].kind, "multi-call-write");
    assert.deepEqual(beta.graph.states[0].operations[0].emittedTargets, ["a_v", "b_v"]);
}

{
    const beta = makeBeta({ packRhs: "{ obj:Pair(1) }" });
    beta.graph.states[0].operations[0].reads = ["obj"];
    finalizePreCfMultiReturnTemps(beta);
    assert.equal(beta.preCfMultiReturnTemps.folds, 1);
    assert(beta.source.includes("local a_v, b_v = obj:Pair(1)"), beta.source);
}

for (const beta of [
    makeBeta({ extracts: [["b_v", 2]] }),
    makeBeta({ extracts: [["a_v", 1], ["c_v", 3]] }),
    makeBeta({ extraRead: true }),
    makeBeta({ localExtracts: false }),
    makeBeta({ packRhs: "{ f(), 1 }" }),
]) {
    finalizePreCfMultiReturnTemps(beta);
    assert.equal(beta.preCfMultiReturnTemps.folds, 0, beta.source);
    assert(beta.source.includes("pack_v"));
}

console.log("pre-CF multi-return temps: PASS");