"use strict";
const assert = require("assert");
const { finalizePreCfScalarTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta(rhs, producerReads = []) {
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local a_v = args
            local b_v = args
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
                { index: 1, kind: "version-define", emittedTarget: "a_v", rhs: "args", reads: [], emittedText: "local a_v = args" },
                { index: 2, kind: "version-define", emittedTarget: "b_v", rhs: "args", reads: [], emittedText: "local b_v = args" },
                { index: 3, kind: "version-define", emittedTarget: "temp_v", rhs, reads: producerReads, emittedText: `local temp_v = ${rhs}` },
                { index: 4, kind: "version-define", emittedTarget: "sink_v", rhs: "temp_v", reads: ["temp_v"], emittedText: "local sink_v = temp_v" },
                { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
            ] }],
        },
    };
}

for (const [rhs, reads] of [["1", []], ["-a_v", ["a_v"]], ["a_v + b_v", ["a_v", "b_v"]], ["a_v == b_v", ["a_v", "b_v"]]]) {
    const beta = makeBeta(rhs, reads);
    finalizePreCfScalarTemps(beta);
    assert.equal(beta.preCfScalarTemps.safe, true);
    assert.equal(beta.preCfScalarTemps.folds, 1, rhs);
    assert(!beta.source.includes(`local temp_v = ${rhs}`), rhs);
    assert(beta.source.includes(`local sink_v = ${rhs}`), rhs);
}

for (const [rhs, reads] of [["f()", []], ["obj[k]", []], ["a_v and b_v", ["a_v", "b_v"]], ["{}", []], ["function() return 1 end", []]]) {
    const beta = makeBeta(rhs, reads);
    finalizePreCfScalarTemps(beta);
    assert.equal(beta.preCfScalarTemps.safe, true);
    assert.equal(beta.preCfScalarTemps.folds, 0, rhs);
    assert(beta.source.includes(`local temp_v = ${rhs}`), rhs);
}

console.log("pre-CF scalar temps: PASS");
