"use strict";
const assert = require("assert");
const { finalizePreCfCallBaseTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta(producerRhs, producerReads, consumerRhs, consumerReads, extraSource = "", extraOps = []) {
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local source_v = args
            local obj_v = args
${extraSource}            local temp_v = ${producerRhs}
            local out_v = ${consumerRhs}
            state = nil
        end
    end
    return ReturnVal
end`;
    const operations = [
        { index: 1, kind: "version-define", emittedTarget: "source_v", rhs: "args", reads: [], emittedText: "local source_v = args" },
        { index: 2, kind: "version-define", emittedTarget: "obj_v", rhs: "args", reads: [], emittedText: "local obj_v = args" },
        ...extraOps,
        { index: 0, kind: "version-define", emittedTarget: "temp_v", rhs: producerRhs, reads: producerReads, emittedText: `local temp_v = ${producerRhs}` },
        { index: 0, kind: "version-define", emittedTarget: "out_v", rhs: consumerRhs, reads: consumerReads, emittedText: `local out_v = ${consumerRhs}` },
        { index: 0, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((op, i) => op.index = i + 1);
    return { source, graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, successors: [], operations }] } };
}

for (const [producer, reads, consumer, consumerReads, expected] of [
    ["source_v", ["source_v"], "temp_v(1)", ["temp_v"], "local out_v = source_v(1)"],
    ["obj_v.field", ["obj_v"], "temp_v(2)", ["temp_v"], "local out_v = obj_v.field(2)"],
    ['obj_v["field"]', ["obj_v"], "temp_v(3)", ["temp_v"], 'local out_v = obj_v["field"](3)'],
]) {
    const beta = makeBeta(producer, reads, consumer, consumerReads);
    finalizePreCfCallBaseTemps(beta);
    assert.equal(beta.preCfCallBaseTemps.safe, true);
    assert.equal(beta.preCfCallBaseTemps.folds, 1, producer);
    assert(!beta.source.includes(`local temp_v = ${producer}`), producer);
    assert(beta.source.includes(expected), beta.source);
}

for (const [producer, reads, consumer, consumerReads] of [
    ["globalFn", [], "temp_v(1)", ["temp_v"]],
    ["make_v()", ["make_v"], "temp_v(1)", ["temp_v"]],
    ["obj_v[key_v]", ["obj_v", "key_v"], "temp_v(1)", ["temp_v"]],
    ["source_v", ["source_v"], "other_v(temp_v)", ["other_v", "temp_v"]],
]) {
    const beta = makeBeta(producer, reads, consumer, consumerReads);
    finalizePreCfCallBaseTemps(beta);
    assert.equal(beta.preCfCallBaseTemps.folds, 0, `${producer} -> ${consumer}`);
    assert(beta.source.includes(`local temp_v = ${producer}`));
}

console.log("pre-CF call base temps: PASS");
