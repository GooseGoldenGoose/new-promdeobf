"use strict";
const assert = require("assert");
const { finalizePreCfIndexKeyTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ keyRhs = '"key"', consumerRhs = 'table_v[key_v]', extraRead = false, captured = false, gapWrite = false, successors = [] } = {}) {
    const key = { index: 1, kind: "epoch-start", emittedTarget: "key_v", originalTarget: "r1", registerEpoch: "r1:epoch:1", rhs: keyRhs, reads: [], emittedText: `local key_v = ${keyRhs}` };
    const gap = gapWrite ? { index: 2, kind: "epoch-mutate", emittedTarget: "key_v", originalTarget: "r1", registerEpoch: "r1:epoch:1", rhs: 'other_v', reads: ['other_v'], emittedText: 'key_v = other_v' } : null;
    const read = { index: 0, kind: "epoch-start", emittedTarget: "value_v", originalTarget: "r2", registerEpoch: "r2:epoch:1", rhs: consumerRhs, reads: ['table_v', 'key_v'], emittedText: `local value_v = ${consumerRhs}` };
    const extra = extraRead ? { index: 0, kind: "version-define", emittedTarget: "sink_v", originalTarget: "state", registerEpoch: null, rhs: 'use(key_v)', reads: ['use', 'key_v'], emittedText: 'local sink_v = use(key_v)' } : null;
    const transition = { index: 0, kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" };
    const operations = [key, ...(gap ? [gap] : []), read, ...(extra ? [extra] : []), transition];
    operations.forEach((op, i) => op.index = i + 1);
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", returnName: "ReturnVal", recoveredUpvalueBindings: captured ? ['key_v'] : [], states: [{ id: 1, successors, operations }] },
    };
}

for (const [keyRhs, expected] of [["1", "table_v[1]"], ['"key"', 'table_v["key"]'], ["true", "table_v[true]"]]) {
    const beta = makeBeta({ keyRhs });
    finalizePreCfIndexKeyTemps(beta);
    assert.equal(beta.preCfIndexKeyTemps.folds, 1, beta.source);
    assert(beta.source.includes(`local value_v = ${expected}`), beta.source);
    assert(!beta.source.includes('local key_v ='), beta.source);
}

for (const beta of [
    makeBeta({ keyRhs: 'makeKey()' }),
    makeBeta({ consumerRhs: 'table_v[key_v + 1]' }),
    makeBeta({ consumerRhs: 'key_v[table_v]' }),
    makeBeta({ extraRead: true }),
    makeBeta({ captured: true }),
    makeBeta({ gapWrite: true }),
]) {
    finalizePreCfIndexKeyTemps(beta);
    assert.equal(beta.preCfIndexKeyTemps.folds, 0, beta.source);
}

console.log("pre-CF index key temps: PASS");
