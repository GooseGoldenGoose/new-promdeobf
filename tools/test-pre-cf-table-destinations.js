"use strict";
const assert = require("assert");
const { finalizePreCfTableDestinations } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ producerOriginal = "state", consumerKind = "epoch-start", extraRead = false, captured = false, gapTarget = null }) {
    const producer = { index: 1, kind: "version-define", emittedTarget: "temp_v", originalTarget: producerOriginal, registerEpoch: null, rhs: "{ 1, 2 }", reads: [], emittedText: "local temp_v = { 1, 2 }" };
    const gap = gapTarget ? { index: 2, kind: "version-define", emittedTarget: gapTarget, originalTarget: "r9", registerEpoch: "r9:epoch:1", rhs: "x_v", reads: ["x_v"], emittedText: `local ${gapTarget} = x_v` } : null;
    const consumer = { index: 0, kind: consumerKind, emittedTarget: "actual_v", originalTarget: "r4", registerEpoch: "r4:epoch:2", rhs: "temp_v", reads: ["temp_v"], emittedText: `${consumerKind === "epoch-start" ? "local " : ""}actual_v = temp_v` };
    const extra = extraRead ? { index: 0, kind: "version-define", emittedTarget: "sink_v", originalTarget: "state", rhs: "use(temp_v)", reads: ["use", "temp_v"], emittedText: "local sink_v = use(temp_v)" } : null;
    const operations = [producer, ...(gap ? [gap] : []), consumer, ...(extra ? [extra] : []), { index: 0, kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" }];
    operations.forEach((op, i) => op.index = i + 1);
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return { source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`, graph: { cfgComplete: true, stateName: "state", returnName: "ReturnVal", recoveredUpvalueBindings: captured ? ["temp_v"] : [], states: [{ id: 1, successors: [], operations }] } };
}

for (const consumerKind of ["epoch-start", "epoch-mutate"]) {
    const beta = makeBeta({ consumerKind });
    finalizePreCfTableDestinations(beta);
    assert.equal(beta.preCfTableDestinations.folds, 1, beta.source);
    assert(beta.source.includes(`${consumerKind === "epoch-start" ? "local " : ""}actual_v = { 1, 2 }`), beta.source);
    assert(!beta.source.includes("actual_v = temp_v"), beta.source);
}

for (const beta of [
    makeBeta({ producerOriginal: "r8" }),
    makeBeta({ extraRead: true }),
    makeBeta({ captured: true }),
    makeBeta({ gapTarget: "actual_v" }),
]) {
    finalizePreCfTableDestinations(beta);
    assert.equal(beta.preCfTableDestinations.folds, 0, beta.source);
}
console.log("pre-CF table destinations: PASS");
