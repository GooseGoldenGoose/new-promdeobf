"use strict";
const assert = require("assert");
const { buildPreCfTempProofIndex, provePreCfTempUse } = require("../passes/pre-cf-temp-recovery");

function op(index, target, reads = [], rhs = null) {
    return { index, kind: "version-define", emittedTarget: target, reads, rhs, emittedText: target ? `${target} = ${rhs || "value"}` : "use()" };
}

const beta = {
    graph: {
        cfgComplete: true,
        recoveredUpvalueBindings: ["captured_v"],
        states: [
            { id: 1, successors: [2], operations: [
                op(1, "safe_v", []),
                op(2, "sink_v", ["safe_v"]),
                op(3, "many_v", []),
                op(4, "sink2_v", ["many_v"]),
                op(5, "sink3_v", ["many_v"]),
                op(6, "captured_v", []),
                op(7, "sink4_v", ["captured_v"]),
            ] },
            { id: 2, successors: [3], operations: [
                op(1, "cross_v", []),
            ] },
            { id: 3, successors: [4], operations: [
                op(1, "sink5_v", ["cross_v"]),
                op(2, "loop_v", []),
            ] },
            { id: 4, successors: [3], operations: [
                op(1, "sink6_v", ["loop_v"]),
            ] },
        ],
    },
};

const index = buildPreCfTempProofIndex(beta);
assert.equal(index.safe, true);

const safe = provePreCfTempUse(beta, "safe_v");
assert.equal(safe.safe, true);
assert.equal(safe.singleDefinition, true);
assert.equal(safe.singleUse, true);
assert.equal(safe.sameState, true);
assert.equal(safe.adjacent, true);
assert.equal(safe.captured, false);

const many = provePreCfTempUse(beta, "many_v");
assert.equal(many.safe, false);
assert.equal(many.readCount, 2);

const captured = provePreCfTempUse(beta, "captured_v");
assert.equal(captured.safe, false);
assert.equal(captured.captured, true);

const cross = provePreCfTempUse(beta, "cross_v");
assert.equal(cross.safe, false);
assert.equal(cross.sameState, false);
assert.equal(cross.crossesCycle, false);

const loop = provePreCfTempUse(beta, "loop_v");
assert.equal(loop.safe, false);
assert.equal(loop.crossesCycle, true);

assert.equal(provePreCfTempUse(beta, "missing").safe, false);
console.log("pre-CF temp proof index: PASS");
const { finalizePreCfCopyTemps } = require("../passes/pre-cf-temp-recovery");

const copySource = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local source_v = args
            local temp_v = source_v
            local sink_v = temp_v
            state = nil
        end
    end
    return ReturnVal
end`;
const copyBeta = {
    source: copySource,
    graph: {
        cfgComplete: true,
        stateName: "state",
        recoveredUpvalueBindings: [],
        states: [{ id: 1, successors: [], operations: [
            { index: 1, kind: "version-define", emittedTarget: "source_v", rhs: "args", reads: [], emittedText: "local source_v = args" },
            { index: 2, kind: "version-define", emittedTarget: "temp_v", rhs: "source_v", reads: ["source_v"], emittedText: "local temp_v = source_v" },
            { index: 3, kind: "version-define", emittedTarget: "sink_v", rhs: "temp_v", reads: ["temp_v"], emittedText: "local sink_v = temp_v" },
            { index: 4, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
        ] }],
    },
};
finalizePreCfCopyTemps(copyBeta);
assert.equal(copyBeta.preCfCopyTemps.safe, true);
assert.equal(copyBeta.preCfCopyTemps.folds, 1);
assert(!copyBeta.source.includes("local temp_v"));
assert(copyBeta.source.includes("local sink_v = source_v"));
assert.equal(copyBeta.graph.states[0].operations.length, 3);
assert.equal(copyBeta.graph.states[0].operations[1].rhs, "source_v");

const barrierSource = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local source_v = args
            local temp_v = source_v
            local barrier_v = 1
            local sink_v = temp_v
            state = nil
        end
    end
    return ReturnVal
end`;
const barrierBeta = {
    source: barrierSource,
    graph: {
        cfgComplete: true,
        stateName: "state",
        recoveredUpvalueBindings: [],
        states: [{ id: 1, successors: [], operations: [
            { index: 1, kind: "version-define", emittedTarget: "source_v", rhs: "args", reads: [], emittedText: "local source_v = args" },
            { index: 2, kind: "version-define", emittedTarget: "temp_v", rhs: "source_v", reads: ["source_v"], emittedText: "local temp_v = source_v" },
            { index: 3, kind: "version-define", emittedTarget: "barrier_v", rhs: "1", reads: [], emittedText: "local barrier_v = 1" },
            { index: 4, kind: "version-define", emittedTarget: "sink_v", rhs: "temp_v", reads: ["temp_v"], emittedText: "local sink_v = temp_v" },
            { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
        ] }],
    },
};
finalizePreCfCopyTemps(barrierBeta);
assert.equal(barrierBeta.preCfCopyTemps.safe, true);
assert.equal(barrierBeta.preCfCopyTemps.folds, 0);
assert(barrierBeta.source.includes("local temp_v = source_v"));
console.log("pre-CF copy transport: PASS");
