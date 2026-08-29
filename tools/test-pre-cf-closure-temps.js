"use strict";
const assert = require("assert");
const { finalizePreCfClosureTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ factory = "createClosure2", entry = 2, localConsumer = true, extraRead = false, captured = false, gap = null, crossState = false }) {
    const producer = { index: 1, kind: "version-define", emittedTarget: "temp_v", rhs: `${factory}(${entry}, {})`, reads: [], emittedText: `local temp_v = ${factory}(${entry}, {})` };
    const consumer = { index: 0, kind: "version-define", emittedTarget: "actual_v", rhs: "temp_v", reads: ["temp_v"], emittedText: `${localConsumer ? "local " : ""}actual_v = temp_v` };
    const gapOp = gap ? { index: 0, kind: "version-define", emittedTarget: gap.target, rhs: gap.rhs, reads: gap.reads || [], emittedText: `local ${gap.target} = ${gap.rhs}` } : null;
    const extra = extraRead ? { index: 0, kind: "version-define", emittedTarget: "sink_v", rhs: "use(temp_v)", reads: ["use", "temp_v"], emittedText: "local sink_v = use(temp_v)" } : null;
    const state1Ops = [producer, ...(gapOp ? [gapOp] : []), ...(crossState ? [] : [consumer]), ...(extra ? [extra] : []), { index: 0, kind: "state-transition", emittedTarget: "state", rhs: crossState ? "2" : "nil", reads: [], emittedText: `state = ${crossState ? "2" : "nil"}` }];
    const states = [{ id: 1, successors: crossState ? [2] : [], operations: state1Ops }];
    if (crossState) states.push({ id: 2, successors: [], operations: [consumer, { index: 0, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" }] });
    for (const state of states) state.operations.forEach((op, i) => op.index = i + 1);
    const body1 = state1Ops.map(op => `            ${op.emittedText}`).join("\n");
    const body2 = crossState ? `        elseif state == 2 then\n${states[1].operations.map(op => `            ${op.emittedText}`).join("\n")}` : "";
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body1}\n${body2}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", entries: [1, 2], recoveredUpvalueBindings: captured ? ["temp_v"] : [], states },
    };
}

{
    const beta = makeBeta({});
    finalizePreCfClosureTemps(beta);
    assert.equal(beta.preCfClosureTemps.folds, 1);
    assert(beta.source.includes("local actual_v = createClosure2(2, {})"), beta.source);
    assert(!beta.source.includes("actual_v = temp_v"), beta.source);
    assert.equal(beta.graph.states[0].operations[0].emittedTarget, "actual_v");
}

{
    const beta = makeBeta({ localConsumer: false, factory: "createClosure", entry: 1 });
    finalizePreCfClosureTemps(beta);
    assert.equal(beta.preCfClosureTemps.folds, 1);
    assert(beta.source.includes("actual_v = createClosure(1, {})"), beta.source);
}

{
    const beta = makeBeta({ gap: { target: "keep_v", rhs: "source_v", reads: ["source_v"] } });
    finalizePreCfClosureTemps(beta);
    assert.equal(beta.preCfClosureTemps.folds, 1);
    assert(beta.source.indexOf("actual_v = createClosure2") < beta.source.indexOf("local keep_v = source_v"), beta.source);
}

for (const beta of [
    makeBeta({ extraRead: true }),
    makeBeta({ captured: true }),
    makeBeta({ entry: 999 }),
    makeBeta({ crossState: true }),
    makeBeta({ gap: { target: "probe_v", rhs: "use(actual_v)", reads: ["use", "actual_v"] } }),
    makeBeta({ gap: { target: "actual_v", rhs: "x_v", reads: ["x_v"] } }),
]) {
    finalizePreCfClosureTemps(beta);
    assert.equal(beta.preCfClosureTemps.folds, 0, beta.source);
    assert(beta.source.includes("temp_v"), beta.source);
}

console.log("pre-CF closure temps: PASS");
