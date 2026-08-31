"use strict";
const assert = require("assert");
const { finalizePreCfCallSetupChains } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ baseRhs = "pcall", argRhs = "print", extraUse = false, captured = false } = {}) {
    const operations = [
        { kind: "version-define", emittedTarget: "base_v", originalTarget: "r1", rhs: baseRhs, reads: [], emittedText: `local base_v = ${baseRhs}` },
        { kind: "version-define", emittedTarget: "arg_v", originalTarget: "r2", rhs: argRhs, reads: [], emittedText: `local arg_v = ${argRhs}` },
        ...(extraUse ? [{ kind: "statement", emittedText: "observe(arg_v)", originalText: "observe(arg_v)", reads: ["arg_v"] }] : []),
        { kind: "epoch-start", emittedTarget: "actual_v", originalTarget: "r3", registerEpoch: "r3:epoch:1", rhs: "base_v(arg_v)", reads: ["base_v", "arg_v"], emittedText: "local actual_v = base_v(arg_v)" },
        { kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((op, i) => op.index = i + 1);
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: captured ? ["arg_v"] : [], states: [{ id: 1, successors: [], operations }] },
    };
}

// Ordered pure setup reads collapse together; the call stays at its original point.
{
    const beta = makeBeta();
    finalizePreCfCallSetupChains(beta);
    assert.equal(beta.preCfCallSetupChains.safe, true);
    assert.equal(beta.preCfCallSetupChains.folds, 2, beta.source);
    assert(beta.source.includes("local actual_v = pcall(print)"), beta.source);
    assert(!beta.source.includes("local base_v ="), beta.source);
    assert(!beta.source.includes("local arg_v ="), beta.source);
}
// Literal setup is also side-effect free.
{
    const beta = makeBeta({ argRhs: "1" });
    finalizePreCfCallSetupChains(beta);
    assert.equal(beta.preCfCallSetupChains.folds, 2, beta.source);
    assert(beta.source.includes("local actual_v = pcall(1)"), beta.source);
}
// Effectful setup, extra semantic use, or capture refuses the group.
for (const beta of [
    makeBeta({ baseRhs: "getBase()" }),
    makeBeta({ extraUse: true }),
    makeBeta({ captured: true }),
]) {
    finalizePreCfCallSetupChains(beta);
    assert.equal(beta.preCfCallSetupChains.folds, 0, beta.source);
}

// A compiler-decoded global living in a physical epoch may be a genuine source alias.
// Keep it unless stronger compiler-scratch provenance exists.
{
    const beta = makeBeta();
    const base = beta.graph.states[0].operations[0];
    base.compilerGlobalLookupRecovered = "pcall";
    base.registerEpoch = "r1:epoch:1";
    base.compilerSourceLifetimeProven = true;
    finalizePreCfCallSetupChains(beta);
    assert.equal(beta.preCfCallSetupChains.folds, 0, beta.source);
    assert(beta.source.includes("local base_v = pcall"), beta.source);
}
console.log("pre-CF call setup chains: PASS");
