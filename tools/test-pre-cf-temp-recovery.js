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