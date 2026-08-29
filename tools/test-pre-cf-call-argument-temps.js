"use strict";
const assert = require("assert");
const { finalizePreCfCallArgumentTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta(consumerRhs, consumerReads, extraOps = [], extraSource = "") {
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local make_v = args
            local sink_v = args
${extraSource}            local temp_v = make_v()
            local out_v = ${consumerRhs}
            state = nil
        end
    end
    return ReturnVal
end`;
    const operations = [
        { index: 1, kind: "version-define", emittedTarget: "make_v", rhs: "args", reads: [], emittedText: "local make_v = args" },
        { index: 2, kind: "version-define", emittedTarget: "sink_v", rhs: "args", reads: [], emittedText: "local sink_v = args" },
        ...extraOps,
        { index: 0, kind: "version-define", emittedTarget: "temp_v", rhs: "make_v()", reads: ["make_v"], emittedText: "local temp_v = make_v()" },
        { index: 0, kind: "version-define", emittedTarget: "out_v", rhs: consumerRhs, reads: consumerReads, emittedText: `local out_v = ${consumerRhs}` },
        { index: 0, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((operation, index) => { operation.index = index + 1; });
    return { source, graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, successors: [], operations }] } };
}

for (const [rhs, reads, expected] of [
    ["sink_v(temp_v)", ["sink_v", "temp_v"], "local out_v = sink_v((make_v()))"],
    ["sink_v(1, temp_v)", ["sink_v", "temp_v"], "local out_v = sink_v(1, (make_v()))"],
]) {
    const beta = makeBeta(rhs, reads);
    finalizePreCfCallArgumentTemps(beta);
    assert.equal(beta.preCfCallArgumentTemps.safe, true);
    assert.equal(beta.preCfCallArgumentTemps.folds, 1, rhs);
    assert(!beta.source.includes("local temp_v = make_v()"), rhs);
    assert(beta.source.includes(expected), beta.source);
}

const effectPrefix = makeBeta(
    "sink_v(other_v(), temp_v)",
    ["sink_v", "other_v", "temp_v"],
    [{ index: 3, kind: "version-define", emittedTarget: "other_v", rhs: "args", reads: [], emittedText: "local other_v = args" }],
    "            local other_v = args\n"
);
finalizePreCfCallArgumentTemps(effectPrefix);
assert.equal(effectPrefix.preCfCallArgumentTemps.folds, 0);
assert(effectPrefix.source.includes("local temp_v = make_v()"));

const unstableBase = makeBeta("globalSink(temp_v)", ["temp_v"]);
finalizePreCfCallArgumentTemps(unstableBase);
assert.equal(unstableBase.preCfCallArgumentTemps.folds, 0);

const doubleUse = makeBeta("sink_v(temp_v, temp_v)", ["sink_v", "temp_v"]);
finalizePreCfCallArgumentTemps(doubleUse);
assert.equal(doubleUse.preCfCallArgumentTemps.folds, 0);

const closureFactory = makeBeta("sink_v(temp_v)", ["sink_v", "temp_v"]);
closureFactory.source = closureFactory.source.replace("local temp_v = make_v()", "local temp_v = createClosure3(148, {})");
const closureProducer = closureFactory.graph.states[0].operations.find(operation => operation.emittedTarget === "temp_v");
closureProducer.rhs = "createClosure3(148, {})";
closureProducer.reads = [];
closureProducer.emittedText = "local temp_v = createClosure3(148, {})";
closureFactory.graph.entries = [1, 148];
finalizePreCfCallArgumentTemps(closureFactory);
assert.equal(closureFactory.preCfCallArgumentTemps.folds, 0);
assert(closureFactory.source.includes("local temp_v = createClosure3(148, {})"));


{
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local sink_v = args
            local arg2_v = 2
            local arg1_v = 1
            local out_v = sink_v(arg1_v, arg2_v)
            state = nil
        end
    end
    return ReturnVal
end`;
    const operations = [
        { index: 1, kind: "version-define", emittedTarget: "sink_v", rhs: "args", reads: [], emittedText: "local sink_v = args" },
        { index: 2, kind: "version-define", emittedTarget: "arg2_v", rhs: "2", reads: [], emittedText: "local arg2_v = 2" },
        { index: 3, kind: "version-define", emittedTarget: "arg1_v", rhs: "1", reads: [], emittedText: "local arg1_v = 1" },
        { index: 4, kind: "version-define", emittedTarget: "out_v", rhs: "sink_v(arg1_v, arg2_v)", reads: ["sink_v", "arg1_v", "arg2_v"], emittedText: "local out_v = sink_v(arg1_v, arg2_v)" },
        { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    const beta = { source, graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, successors: [], operations }] } };
    finalizePreCfCallArgumentTemps(beta);
    assert.equal(beta.preCfCallArgumentTemps.safe, true);
    assert.equal(beta.preCfCallArgumentTemps.folds, 2);
    assert(!beta.source.includes("local arg2_v = 2"));
    assert(!beta.source.includes("local arg1_v = 1"));
    assert(beta.source.includes("local out_v = sink_v(1, 2)"), beta.source);
}

console.log("pre-CF call argument temps: PASS");
