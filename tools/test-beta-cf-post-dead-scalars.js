"use strict";
const assert = require("assert");
const { recoverStructuredPostCfDeadScalarLocals } = require("../passes/beta-control-flow");

function raw(operation) {
    return { type: "raw", operation, text: operation.emittedText, reads: [...(operation.reads || [])] };
}

function run(nodes, captured = [], options = {}) {
    return recoverStructuredPostCfDeadScalarLocals(nodes, { recoveredUpvalueBindings: captured }, options);
}

{
    const nodes = [raw({ kind: "version-define", emittedTarget: "x", rhs: "nil", emittedText: "local x = nil", reads: [] })];
    assert.equal(run(nodes), 1);
    assert.equal(nodes.length, 0);
}
{
    const nodes = [
        raw({ kind: "version-define", emittedTarget: "src", rhs: "1", emittedText: "local src = 1", reads: [] }),
        raw({ kind: "version-define", emittedTarget: "x", rhs: "src", emittedText: "local x = src", reads: ["src"] }),
    ];
    assert.equal(run(nodes), 2);
    assert.equal(nodes.length, 0);
}
{
    const nodes = [raw({ kind: "version-define", emittedTarget: "x", rhs: "1", emittedText: "local x = 1", reads: [] })];
    assert.equal(run(nodes, ["x"]), 0);
    assert.equal(nodes.length, 1);
}
{
    const nodes = [
        raw({ kind: "version-define", emittedTarget: "x", rhs: "nil", emittedText: "local x = nil", reads: [] }),
        raw({ kind: "statement", emittedText: "use(x)", reads: ["use", "x"] }),
    ];
    assert.equal(run(nodes), 0);
    assert.equal(nodes.length, 2);
}
{
    const nodes = [
        raw({ kind: "version-define", emittedTarget: "x", rhs: "nil", emittedText: "local x = nil", reads: [] }),
        raw({ kind: "epoch-mutate", emittedTarget: "x", rhs: "1", emittedText: "x = 1", reads: [] }),
    ];
    assert.equal(run(nodes), 0);
    assert.equal(nodes.length, 2);
}
{
    const nodes = [raw({ kind: "version-define", emittedTarget: "x", rhs: "globalName", emittedText: "local x = globalName", reads: ["globalName"] })];
    assert.equal(run(nodes), 0);
    assert.equal(nodes.length, 1);
}
{
    const nodes = [raw({ kind: "version-define", emittedTarget: "x", rhs: "f()", emittedText: "local x = f()", reads: ["f"] })];
    assert.equal(run(nodes), 0);
    assert.equal(nodes.length, 1);
}

{
    const nodes = [raw({ kind: "version-define", emittedTarget: "x", rhs: "args", emittedText: "local x = args", reads: ["args"] })];
    assert.equal(run(nodes), 0);
    assert.equal(nodes.length, 1);
}
{
    const nodes = [raw({ kind: "epoch-start", emittedTarget: "x", originalTarget: "r8", registerEpoch: "r8:epoch:1", rhs: "args", emittedText: "local x = args", reads: ["args"] })];
    assert.equal(run(nodes, [], { syntheticLocals: ["args"] }), 1);
    assert.equal(nodes.length, 0);
}
{
    const nodes = [raw({ kind: "version-define", emittedTarget: "setup", rhs: "args", emittedText: "local setup = args", reads: ["args"] })];
    assert.equal(run(nodes, [], { syntheticLocals: ["args"] }), 0);
    assert.equal(nodes.length, 1);
}

console.log("beta CF post-CF dead scalar locals: PASS");
