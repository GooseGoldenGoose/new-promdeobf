"use strict";
const assert = require("assert");
const { finalizePreCfTableEntryTemps } = require("../passes/pre-cf-temp-recovery");

// Prometheus compiler.lua:2304-2329 evaluates table entry keys/values into
// registers before emitting the constructor. Recover only literal-only scalar
// producers whose exact reaching definition is consumed by one table field.
function makeBeta({ callValue = false, extraRead = false, captured = false, repeated = false, successors = [], selfShadow = false } = {}) {
    const operations = [];
    function add(op) { op.index = operations.length + 1; operations.push(op); return op; }
    if (selfShadow) {
        add({ kind: "epoch-start", emittedTarget: "actual_v", originalTarget: "r4", registerEpoch: "r4:epoch:1", rhs: "2", reads: [], emittedText: "local actual_v = 2" });
        add({ kind: "epoch-start", emittedTarget: "actual_v", originalTarget: "r4", registerEpoch: "r4:epoch:2", rhs: "{ actual_v }", reads: ["actual_v"], emittedText: "local actual_v = { actual_v }" });
    } else {
        add({ kind: "epoch-start", emittedTarget: "a_v", originalTarget: "r1", registerEpoch: "r1:epoch:1", rhs: "1", reads: [], emittedText: "local a_v = 1" });
        add({ kind: "epoch-start", emittedTarget: "b_v", originalTarget: "r2", registerEpoch: "r2:epoch:1", rhs: "2", reads: [], emittedText: "local b_v = 2" });
        add({ kind: "epoch-start", emittedTarget: "k_v", originalTarget: "r3", registerEpoch: "r3:epoch:1", rhs: '"key"', reads: [], emittedText: 'local k_v = "key"' });
        add({ kind: "epoch-start", emittedTarget: "v_v", originalTarget: "r5", registerEpoch: "r5:epoch:1", rhs: callValue ? "make()" : "3", reads: callValue ? ["make"] : [], emittedText: `local v_v = ${callValue ? "make()" : "3"}` });
        if (extraRead) add({ kind: "version-define", emittedTarget: "sink_v", originalTarget: "ReturnVal", registerEpoch: null, rhs: "use(a_v)", reads: ["use", "a_v"], emittedText: "local sink_v = use(a_v)" });
        const rhs = repeated ? "{ a_v, a_v, [k_v] = v_v }" : "{ a_v, b_v, [k_v] = v_v }";
        add({ kind: "epoch-start", emittedTarget: "table_v", originalTarget: "r6", registerEpoch: "r6:epoch:1", rhs, reads: repeated ? ["a_v", "k_v", "v_v"] : ["a_v", "b_v", "k_v", "v_v"], emittedText: `local table_v = ${rhs}` });
    }
    add({ kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: successors.length ? String(successors[0]) : "nil", reads: [], emittedText: `state = ${successors.length ? successors[0] : "nil"}` });
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", returnName: "ReturnVal", recoveredUpvalueBindings: captured ? ["b_v"] : [], states: [{ id: 1, successors, operations }] },
    };
}

{
    const beta = makeBeta();
    finalizePreCfTableEntryTemps(beta);
    assert.equal(beta.preCfTableEntryTemps.folds, 4, beta.source);
    assert(beta.source.includes('local table_v = { 1, 2, ["key"] = 3 }'), beta.source);
    assert(!beta.source.includes("local a_v ="), beta.source);
}

{
    const beta = makeBeta({ selfShadow: true });
    finalizePreCfTableEntryTemps(beta);
    assert.equal(beta.preCfTableEntryTemps.folds, 1, beta.source);
    assert(beta.source.includes("local actual_v = { 2 }"), beta.source);
    assert.equal((beta.source.match(/local actual_v/g) || []).length, 1, beta.source);
}

{
    const beta = makeBeta({ callValue: true });
    finalizePreCfTableEntryTemps(beta);
    assert(beta.source.includes("[\"key\"] = v_v"), beta.source);
    assert(beta.source.includes("local v_v = make()"), beta.source);
}

{
    const beta = makeBeta({ extraRead: true });
    finalizePreCfTableEntryTemps(beta);
    assert(beta.source.includes("local a_v = 1"), beta.source);
    assert(beta.source.includes("{ a_v,"), beta.source);
}

{
    const beta = makeBeta({ captured: true });
    finalizePreCfTableEntryTemps(beta);
    assert(beta.source.includes("local b_v = 2"), beta.source);
    assert(beta.source.includes("b_v"), beta.source);
}

{
    const beta = makeBeta({ repeated: true });
    finalizePreCfTableEntryTemps(beta);
    assert(beta.source.includes("local a_v = 1"), beta.source);
    assert(beta.source.includes("{ a_v, a_v,"), beta.source);
}

{
    const beta = makeBeta({ successors: [2] });
    finalizePreCfTableEntryTemps(beta);
    assert.equal(beta.preCfTableEntryTemps.folds, 0, beta.source);
}

console.log("pre-CF table entry temps: PASS");
