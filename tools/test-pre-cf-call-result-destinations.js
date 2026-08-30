"use strict";
const assert = require("assert");
const { finalizePreCfCallResultDestinations } = require("../passes/pre-cf-temp-recovery");

function makeBeta({
    producerOriginal = "ReturnVal",
    localConsumer = true,
    extraRead = false,
    captured = false,
    gap = null,
    crossState = false,
    closure = false,
    consumerOriginal = "r4",
} = {}) {
    const callRhs = closure ? "createClosure2(2, {})" : "callee_v(arg_v)";
    const producer = {
        index: 1,
        kind: "version-define",
        emittedTarget: "temp_v",
        originalTarget: producerOriginal,
        registerEpoch: null,
        rhs: callRhs,
        reads: closure ? [] : ["callee_v", "arg_v"],
        emittedText: `local temp_v = ${callRhs}`,
    };
    const consumer = {
        index: 0,
        kind: localConsumer ? "epoch-start" : "epoch-mutate",
        emittedTarget: "actual_v",
        originalTarget: consumerOriginal,
        registerEpoch: `${consumerOriginal}:epoch:2`,
        rhs: "temp_v",
        reads: ["temp_v"],
        emittedText: `${localConsumer ? "local " : ""}actual_v = temp_v`,
    };
    const gapOp = gap ? {
        index: 0,
        kind: "version-define",
        emittedTarget: gap.target,
        originalTarget: gap.originalTarget || "r9",
        registerEpoch: gap.registerEpoch || "r9:epoch:1",
        rhs: gap.rhs,
        reads: gap.reads || [],
        emittedText: `local ${gap.target} = ${gap.rhs}`,
    } : null;
    const extra = extraRead ? {
        index: 0,
        kind: "version-define",
        emittedTarget: "sink_v",
        originalTarget: "r8",
        registerEpoch: "r8:epoch:1",
        rhs: "use_v(temp_v)",
        reads: ["use_v", "temp_v"],
        emittedText: "local sink_v = use_v(temp_v)",
    } : null;
    const state1Ops = [producer, ...(gapOp ? [gapOp] : []), ...(crossState ? [] : [consumer]), ...(extra ? [extra] : []), {
        index: 0, kind: "state-transition", emittedTarget: "state", originalTarget: "state", registerEpoch: null,
        rhs: crossState ? "2" : "nil", reads: [], emittedText: `state = ${crossState ? "2" : "nil"}`,
    }];
    const states = [{ id: 1, successors: crossState ? [2] : [], operations: state1Ops }];
    if (crossState) states.push({ id: 2, successors: [], operations: [consumer, {
        index: 0, kind: "state-transition", emittedTarget: "state", originalTarget: "state", registerEpoch: null,
        rhs: "nil", reads: [], emittedText: "state = nil",
    }] });
    for (const state of states) state.operations.forEach((op, i) => { op.index = i + 1; });
    const body1 = state1Ops.map(op => `            ${op.emittedText}`).join("\n");
    const body2 = crossState ? `        elseif state == 2 then\n${states[1].operations.map(op => `            ${op.emittedText}`).join("\n")}` : "";
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body1}\n${body2}\n        end\n    end\n    return ReturnVal\nend`,
        graph: {
            cfgComplete: true,
            stateName: "state",
            returnName: "ReturnVal",
            entries: [1, 2],
            recoveredUpvalueBindings: captured ? ["temp_v"] : [],
            states,
        },
    };
}

for (const beta of [
    makeBeta({ producerOriginal: "ReturnVal" }),
    makeBeta({ producerOriginal: "state", localConsumer: false }),
]) {
    finalizePreCfCallResultDestinations(beta);
    assert.equal(beta.preCfCallResultDestinations.safe, true);
    assert.equal(beta.preCfCallResultDestinations.folds, 1, beta.source);
    assert(beta.source.includes("actual_v = callee_v(arg_v)"), beta.source);
    assert(!beta.source.includes("actual_v = temp_v"), beta.source);
    assert.equal(beta.graph.states[0].operations[0].emittedTarget, "actual_v");
    assert.equal(beta.graph.states[0].operations[0].originalTarget, "r4");
    assert.equal(beta.graph.states[0].operations[0].registerEpoch, "r4:epoch:2");
    assert.equal(beta.graph.states[0].operations[0].compilerCallResultRetargeted, true);
}

{
    const beta = makeBeta({ gap: { target: "keep_v", rhs: "source_v", reads: ["source_v"] } });
    finalizePreCfCallResultDestinations(beta);
    assert.equal(beta.preCfCallResultDestinations.folds, 1, beta.source);
    assert(beta.source.indexOf("actual_v = callee_v(arg_v)") < beta.source.indexOf("local keep_v = source_v"), beta.source);
}

for (const beta of [
    makeBeta({ producerOriginal: "r1" }),
    makeBeta({ extraRead: true }),
    makeBeta({ captured: true }),
    makeBeta({ crossState: true }),
    makeBeta({ closure: true }),
    makeBeta({ consumerOriginal: "ReturnVal" }),
    makeBeta({ gap: { target: "probe_v", rhs: "use_v(actual_v)", reads: ["use_v", "actual_v"] } }),
    makeBeta({ gap: { target: "actual_v", rhs: "x_v", reads: ["x_v"] } }),
]) {
    finalizePreCfCallResultDestinations(beta);
    assert.equal(beta.preCfCallResultDestinations.folds, 0, beta.source);
    assert(beta.source.includes("temp_v"), beta.source);
}

console.log("pre-CF call-result destinations: PASS");
