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

console.log("pre-CF call argument temps: PASS");
