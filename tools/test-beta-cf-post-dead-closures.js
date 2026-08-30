"use strict";
const assert = require("assert");
const { recoverStructuredPostCfDeadClosureTemps } = require("../passes/beta-control-flow");

function raw(operation) {
    return { type: "raw", operation, text: operation.emittedText, reads: [...(operation.reads || [])] };
}

function fn(name) {
    return raw({ kind: "version-define", emittedTarget: name, emittedText: `local ${name} = function(a) return a end`, rhs: "function(a) return a end", reads: [] });
}

// Exact dead closure: no reads, no capture.
{
    const nodes = [fn("dead_v"), raw({ kind: "effect-call", emittedText: "tick()", reads: ["tick"] })];
    const folds = recoverStructuredPostCfDeadClosureTemps(nodes, { recoveredUpvalueBindings: [] });
    assert.equal(folds, 1);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].text, "tick()");
}

// Dead local transport chain may cross unrelated effects because nothing is moved or re-evaluated.
{
    const nodes = [
        raw({ kind: "version-define", emittedTarget: "dst_v", emittedText: "local dst_v = nil", rhs: "nil", reads: [] }),
        fn("closure_v"),
        raw({ kind: "effect-call", emittedText: "tick()", reads: ["tick"] }),
        raw({ kind: "epoch-mutate", emittedTarget: "dst_v", emittedText: "dst_v = closure_v", rhs: "closure_v", reads: ["closure_v"] }),
    ];
    const folds = recoverStructuredPostCfDeadClosureTemps(nodes, { recoveredUpvalueBindings: [] });
    assert.equal(folds, 2);
    assert(!nodes.some(node => node.text.includes("closure_v")), nodes.map(node => node.text).join("\n"));
    assert(nodes.some(node => node.text === "local dst_v = nil"));
    assert(nodes.some(node => node.text === "tick()"));
}

// A local declaration destination that is itself dead is removable with its closure.
{
    const nodes = [fn("closure_v"), raw({ kind: "version-define", emittedTarget: "dst_v", emittedText: "local dst_v = closure_v", rhs: "closure_v", reads: ["closure_v"] })];
    const folds = recoverStructuredPostCfDeadClosureTemps(nodes, { recoveredUpvalueBindings: [] });
    assert.equal(folds, 2);
    assert.equal(nodes.length, 0);
}

// Captures, live closure values, live destinations, and global writes remain.
for (const { nodes, graph } of [
    { nodes: [fn("closure_v")], graph: { recoveredUpvalueBindings: ["closure_v"] } },
    { nodes: [fn("closure_v"), raw({ kind: "effect-call", emittedText: "observe(closure_v)", reads: ["observe", "closure_v"] })], graph: { recoveredUpvalueBindings: [] } },
    { nodes: [fn("closure_v"), raw({ kind: "effect-write", emittedText: "g = closure_v", rhs: "closure_v", reads: ["closure_v"] })], graph: { recoveredUpvalueBindings: [] } },
    { nodes: [fn("closure_v"), raw({ kind: "version-define", emittedTarget: "dst_v", emittedText: "local dst_v = closure_v", rhs: "closure_v", reads: ["closure_v"] }), raw({ kind: "effect-call", emittedText: "observe(dst_v)", reads: ["observe", "dst_v"] })], graph: { recoveredUpvalueBindings: [] } },
]) {
    const before = nodes.map(node => node.text).join("\n");
    assert.equal(recoverStructuredPostCfDeadClosureTemps(nodes, graph), 0);
    assert.equal(nodes.map(node => node.text).join("\n"), before);
}

console.log("beta CF post-CF dead closure temps: PASS");
