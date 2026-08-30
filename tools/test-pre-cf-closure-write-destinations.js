"use strict";
const assert = require("assert");
const { finalizePreCfClosureWriteDestinations } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ key = '"m"', producerRhs = 'createClosure3(11, captures)', extraUse = false, captured = false } = {}) {
    const closure = { index: 1, kind: "epoch-start", emittedTarget: "closure_v", originalTarget: "r1", registerEpoch: "r1:epoch:1", rhs: producerRhs, reads: ["captures"], emittedText: `local closure_v = ${producerRhs}` };
    const write = { index: 2, kind: "effect-write", emittedText: `table_v[${key}] = closure_v`, originalText: `table_v[${key}] = closure_v`, reads: ["table_v", "closure_v"] };
    const extra = extraUse ? { index: 3, kind: "statement", emittedText: "observe(closure_v)", originalText: "observe(closure_v)", reads: ["observe", "closure_v"] } : null;
    const transition = { index: extraUse ? 4 : 3, kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" };
    const operations = [closure, write, ...(extra ? [extra] : []), transition];
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", returnName: "ReturnVal", entries: [11], recoveredUpvalueBindings: captured ? ["closure_v"] : [], states: [{ id: 1, successors: [], operations }] },
    };
}

// Prometheus compiler member closure write: keep closure allocation where it is, recover only static member destination.
{
    const beta = makeBeta();
    finalizePreCfClosureWriteDestinations(beta);
    assert.equal(beta.preCfClosureWriteDestinations.folds, 1, beta.source);
    assert(beta.source.includes("local closure_v = createClosure3(11, captures)"), beta.source);
    assert(beta.source.includes("table_v.m = closure_v"), beta.source);
    assert(!beta.source.includes('table_v["m"] = closure_v'), beta.source);
    assert(beta.source.indexOf("createClosure3") < beta.source.indexOf("table_v.m = closure_v"), beta.source);
}

// Invalid member syntax, non-closure values, extra uses, and captured closure temps stay unchanged.
for (const beta of [
    makeBeta({ key: '"hello-world"' }),
    makeBeta({ producerRhs: "other_v" }),
    makeBeta({ extraUse: true }),
    makeBeta({ captured: true }),
]) {
    const before = beta.source;
    finalizePreCfClosureWriteDestinations(beta);
    assert.equal(beta.preCfClosureWriteDestinations.folds, 0, beta.source);
    assert.equal(beta.source, before);
}

console.log("pre-CF closure write destinations: PASS");
