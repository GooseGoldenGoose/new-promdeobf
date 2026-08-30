"use strict";
const assert = require("assert");
const { finalizePreCfDiscardedCallResults } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ rhs = "callee_v(arg_v)", reads = ["callee_v", "arg_v"], originalTarget = "ReturnVal", resultReads = 0, captured = false, registerEpoch = null, kind = "version-define", compilerCallResultRetargeted = false }) {
    const producer = { index: 1, kind, emittedTarget: "temp_v", originalTarget, registerEpoch, compilerCallResultRetargeted, rhs, reads, emittedText: `local temp_v = ${rhs}` };
    const operations = [producer];
    for (let i = 0; i < resultReads; i++) operations.push({ index: 0, kind: "version-define", emittedTarget: `sink_${i}`, originalTarget: `r${10+i}`, registerEpoch: `r${10+i}:epoch:1`, rhs: "temp_v", reads: ["temp_v"], emittedText: `local sink_${i} = temp_v` });
    operations.push({ index: 0, kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" });
    operations.forEach((op, i) => op.index = i + 1);
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", returnName: "ReturnVal", recoveredUpvalueBindings: captured ? ["temp_v"] : [], states: [{ id: 1, successors: [], operations }] },
    };
}

for (const beta of [
    makeBeta({}),
    makeBeta({ rhs: "obj_v:m(1)", reads: ["obj_v"] }),
    makeBeta({ originalTarget: "r6", registerEpoch: "r6:epoch:1", kind: "epoch-start" }),
]) {
    finalizePreCfDiscardedCallResults(beta);
    assert.equal(beta.preCfDiscardedCallResults.safe, true);
    assert.equal(beta.preCfDiscardedCallResults.folds, 1);
    assert(!beta.source.includes("local temp_v ="), beta.source);
    assert(beta.source.includes(beta.graph.states[0].operations[0].rhs), beta.source);
    assert.equal(beta.graph.states[0].operations[0].kind, "effect-call");
    assert.equal(beta.graph.states[0].operations[0].emittedTarget, null);
}

for (const beta of [
    makeBeta({ resultReads: 1 }),
    makeBeta({ captured: true }),
    makeBeta({ originalTarget: "r1" }),
    makeBeta({ registerEpoch: "r1:epoch:1", originalTarget: "r1" }),
    makeBeta({ registerEpoch: "r1:epoch:1", originalTarget: "r1", kind: "epoch-start", compilerCallResultRetargeted: true }),
    makeBeta({ rhs: "createClosure2(2, {})", reads: [] }),
]) {
    if (beta.source.includes("createClosure2")) beta.graph.entries = [1, 2];
    finalizePreCfDiscardedCallResults(beta);
    assert.equal(beta.preCfDiscardedCallResults.folds, 0, beta.source);
    assert(beta.source.includes("local temp_v ="), beta.source);
}

console.log("pre-CF discarded call results: PASS");
