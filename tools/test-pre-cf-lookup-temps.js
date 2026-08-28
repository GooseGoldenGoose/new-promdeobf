"use strict";
const assert = require("assert");
const { finalizePreCfLookupTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta(rhs, reads = []) {
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local obj_v = args
            local key_v = "field"
            local temp_v = ${rhs}
            local sink_v = temp_v
            state = nil
        end
    end
    return ReturnVal
end`;
    return {
        source,
        graph: {
            cfgComplete: true,
            stateName: "state",
            recoveredUpvalueBindings: [],
            states: [{ id: 1, successors: [], operations: [
                { index: 1, kind: "version-define", emittedTarget: "obj_v", rhs: "args", reads: [], emittedText: "local obj_v = args" },
                { index: 2, kind: "version-define", emittedTarget: "key_v", rhs: '"field"', reads: [], emittedText: 'local key_v = "field"' },
                { index: 3, kind: "version-define", emittedTarget: "temp_v", rhs, reads, emittedText: `local temp_v = ${rhs}` },
                { index: 4, kind: "version-define", emittedTarget: "sink_v", rhs: "temp_v", reads: ["temp_v"], emittedText: "local sink_v = temp_v" },
                { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
            ] }],
        },
    };
}

for (const [rhs, reads] of [["obj_v.field", ["obj_v"]], ['obj_v["field"]', ["obj_v"]], ["obj_v[1]", ["obj_v"]]]) {
    const beta = makeBeta(rhs, reads);
    finalizePreCfLookupTemps(beta);
    assert.equal(beta.preCfLookupTemps.safe, true);
    assert.equal(beta.preCfLookupTemps.folds, 1, rhs);
    assert(!beta.source.includes(`local temp_v = ${rhs}`), rhs);
    assert(beta.source.includes(`local sink_v = ${rhs}`), rhs);
}

for (const [rhs, reads] of [["obj_v[key_v]", ["obj_v", "key_v"]], ["obj_v[f()]", ["obj_v"]], ["getObj().field", []], ["obj_v.inner.field", ["obj_v"]]]) {
    const beta = makeBeta(rhs, reads);
    finalizePreCfLookupTemps(beta);
    assert.equal(beta.preCfLookupTemps.safe, true);
    assert.equal(beta.preCfLookupTemps.folds, 0, rhs);
    assert(beta.source.includes(`local temp_v = ${rhs}`), rhs);
}

console.log("pre-CF static lookup temps: PASS");
