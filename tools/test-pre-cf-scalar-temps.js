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

// Compiler assignment RHS scratch feeding an existing local mutation may fold.
{
    const beta = makeBeta("2", []);
    const consumer = beta.graph.states[0].operations[3];
    consumer.kind = "epoch-mutate";
    consumer.emittedText = "sink_v = temp_v";
    beta.source = beta.source.replace("local sink_v = temp_v", "sink_v = temp_v");
    finalizePreCfScalarTemps(beta);
    assert.equal(beta.preCfScalarTemps.folds, 1, beta.source);
    assert(beta.source.includes("sink_v = 2"), beta.source);
    assert(!beta.source.includes("local temp_v = 2"), beta.source);
}

// Identifier RHS remains a source-value copy barrier even for an existing-local mutation.
{
    const beta = makeBeta("a_v", ["a_v"]);
    const consumer = beta.graph.states[0].operations[3];
    consumer.kind = "epoch-mutate";
    consumer.emittedText = "sink_v = temp_v";
    beta.source = beta.source.replace("local sink_v = temp_v", "sink_v = temp_v");
    finalizePreCfScalarTemps(beta);
    assert.equal(beta.preCfScalarTemps.folds, 0, beta.source);
    assert(beta.source.includes("local temp_v = a_v"), beta.source);
}

// Captured-local assignment uses the same compiler RHS scratch before an upvalue write.
{
    const beta = makeBeta("3", []);
    const consumer = beta.graph.states[0].operations[3];
    consumer.kind = "upvalue-write";
    consumer.originalTarget = "sink_v";
    consumer.emittedText = "sink_v = temp_v";
    beta.source = beta.source.replace("local sink_v = temp_v", "sink_v = temp_v");
    finalizePreCfScalarTemps(beta);
    assert.equal(beta.preCfScalarTemps.folds, 1, beta.source);
    assert(beta.source.includes("sink_v = 3"), beta.source);
    assert(!beta.source.includes("local temp_v = 3"), beta.source);
}

// Captured-local assignment from a source identifier remains a copy barrier.
{
    const beta = makeBeta("a_v", ["a_v"]);
    const consumer = beta.graph.states[0].operations[3];
    consumer.kind = "upvalue-write";
    consumer.originalTarget = "sink_v";
    consumer.emittedText = "sink_v = temp_v";
    beta.source = beta.source.replace("local sink_v = temp_v", "sink_v = temp_v");
    finalizePreCfScalarTemps(beta);
    assert.equal(beta.preCfScalarTemps.folds, 0, beta.source);
    assert(beta.source.includes("local temp_v = a_v"), beta.source);
}

console.log("pre-CF scalar temps: PASS");
