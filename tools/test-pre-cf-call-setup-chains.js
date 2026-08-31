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

function makeArgumentOnlyBeta({ tablePack = false } = {}) {
    const consumer = tablePack
        ? { kind: "version-define", emittedTarget: "pack_v", originalTarget: "r4", registerEpoch: "r4:epoch:1", rhs: "{ f_v(a_v, b_v, c_v) }", reads: ["f_v", "a_v", "b_v", "c_v"], emittedText: "local pack_v = { f_v(a_v, b_v, c_v) }" }
        : { kind: "multi-call-write", emittedTargets: ["x_v", "y_v", "z_v"], targetDeclarations: [true, true, true], targetRegisterEpochs: ["r4:epoch:1", "r5:epoch:1", "r6:epoch:1"], rhs: "f_v(a_v, b_v, c_v)", reads: ["f_v", "a_v", "b_v", "c_v"], emittedText: "local x_v, y_v, z_v = f_v(a_v, b_v, c_v)" };
    const operations = [
        { kind: "version-define", emittedTarget: "a_v", originalTarget: "r1", rhs: "1", reads: [], emittedText: "local a_v = 1" },
        { kind: "version-define", emittedTarget: "b_v", originalTarget: "r2", rhs: "2", reads: [], emittedText: "local b_v = 2" },
        { kind: "version-define", emittedTarget: "c_v", originalTarget: "r3", rhs: "3", reads: [], emittedText: "local c_v = 3" },
        consumer,
        { kind: "state-transition", emittedTarget: "state", originalTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
    ];
    operations.forEach((op, i) => op.index = i + 1);
    const body = operations.map(op => `            ${op.emittedText}`).join("\n");
    return {
        source: `vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,
        graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, successors: [], operations }] },
    };
}

// Argument-only compiler literals can feed an atomic multi-return call without
// inventing a call-base temp.
{
    const beta = makeArgumentOnlyBeta();
    finalizePreCfCallSetupChains(beta);
    assert.equal(beta.preCfCallSetupChains.folds, 3, beta.source);
    assert(beta.source.includes("local x_v, y_v, z_v = f_v(1, 2, 3)"), beta.source);
    assert(!beta.source.includes("local a_v =") && !beta.source.includes("local b_v =") && !beta.source.includes("local c_v ="), beta.source);
}

// Same proof applies when the call is the sole table field; the source table
// binding itself is preserved.
{
    const beta = makeArgumentOnlyBeta({ tablePack: true });
    finalizePreCfCallSetupChains(beta);
    assert.equal(beta.preCfCallSetupChains.folds, 3, beta.source);
    assert(beta.source.includes("local pack_v = { f_v(1, 2, 3) }"), beta.source);
    assert(beta.source.includes("local pack_v ="), beta.source);
}

console.log("pre-CF call setup chains: PASS");
