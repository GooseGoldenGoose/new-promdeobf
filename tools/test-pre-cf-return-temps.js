"use strict";
const assert = require("assert");
const { finalizePreCfReturnTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta(producerRhs, producerReads, returnExpressions, payloadReads, payloadRhs = null) {
    const payload = payloadRhs || `{ ${returnExpressions.join(", ")} }`;
    const source = `vm = function(state, args, upvalues, gcProxy)
    local ReturnVal
    while state do
        if state == 1 then
            local temp_v = ${producerRhs}
            ReturnVal = ${payload}
            state = nil
        end
    end
    return unpack(ReturnVal)
end`;
    return {
        source,
        graph: {
            cfgComplete: true,
            stateName: "state",
            returnName: "ReturnVal",
            recoveredUpvalueBindings: [],
            states: [{
                id: 1,
                successors: [],
                operations: [
                    { index: 1, kind: "version-define", emittedTarget: "temp_v", rhs: producerRhs, reads: producerReads, emittedText: `local temp_v = ${producerRhs}` },
                    { index: 2, kind: "return-payload", emittedTarget: "ReturnVal", terminalCompilerReturnPayload: true, returnExpressions, rhs: payload, reads: payloadReads, emittedText: `ReturnVal = ${payload}` },
                    { index: 3, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
                ],
            }],
        },
    };
}

for (const [rhs, reads, expected] of [
    ["1 + 2", [], "ReturnVal = { 1 + 2 }"],
    ["-value_v", ["value_v"], "ReturnVal = { -value_v }"],
    ['object_v["field"]', ["object_v"], 'ReturnVal = { object_v["field"] }'],
]) {
    const beta = makeBeta(rhs, reads, ["temp_v"], ["temp_v"]);
    finalizePreCfReturnTemps(beta);
    assert.equal(beta.preCfReturnTemps.safe, true);
    assert.equal(beta.preCfReturnTemps.folds, 1, rhs);
    assert(!beta.source.includes("local temp_v"));
    assert(beta.source.includes(expected), beta.source);
    assert.deepEqual(beta.graph.states[0].operations[0].returnExpressions, [rhs]);
}

{
    const beta = makeBeta("f_v()", ["f_v"], ["temp_v"], ["temp_v"]);
    finalizePreCfReturnTemps(beta);
    assert.equal(beta.preCfReturnTemps.folds, 1);
    assert(beta.source.includes("ReturnVal = { (f_v()) }"), beta.source);
    assert.deepEqual(beta.graph.states[0].operations[0].returnExpressions, ["(f_v())"]);
}

for (const beta of [
    makeBeta("{ f_v() }", ["f_v"], ["temp_v"], ["temp_v"]),
    makeBeta("f_v()", ["f_v"], ["temp_v", "other_v"], ["temp_v", "other_v"]),
    makeBeta("f_v()", ["f_v"], ["unpack(temp_v)"], ["temp_v"]),
]) {
    finalizePreCfReturnTemps(beta);
    assert.equal(beta.preCfReturnTemps.folds, 0);
    assert(beta.source.includes("local temp_v"));
}

const closureFactory = makeBeta("createClosure4(40, {})", [], ["temp_v"], ["temp_v"]);
closureFactory.graph.entries = [1, 40];
finalizePreCfReturnTemps(closureFactory);
assert.equal(closureFactory.preCfReturnTemps.folds, 0);
assert(closureFactory.source.includes("local temp_v = createClosure4(40, {})"));

console.log("pre-CF return temps: PASS");