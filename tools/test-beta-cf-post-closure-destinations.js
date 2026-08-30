"use strict";
const assert = require("assert");
const { recoverStructuredPostCfClosureDestinationTemps } = require("../passes/beta-control-flow");

function raw(operation) {
    return { type: "raw", operation, text: operation.emittedText, reads: [...(operation.reads || [])] };
}

function makeNodes({ target = "g", extraUse = false, captured = false, intervening = false, producerText = "local closure_v = function(a) return a end" } = {}) {
    const producer = { kind: "version-define", emittedTarget: "closure_v", rhs: producerText.slice(producerText.indexOf("=") + 1).trim(), emittedText: producerText, reads: [] };
    const nodes = [raw(producer)];
    if (intervening) nodes.push(raw({ kind: "effect-call", emittedText: "tick()", reads: ["tick"] }));
    nodes.push(raw({ kind: "effect-write", emittedText: `${target} = closure_v`, rhs: "closure_v", reads: ["closure_v", ...(target.startsWith("table_v") ? ["table_v"] : [])] }));
    if (extraUse) nodes.push(raw({ kind: "effect-call", emittedText: "observe(closure_v)", reads: ["observe", "closure_v"] }));
    return { nodes, graph: { recoveredUpvalueBindings: captured ? ["closure_v"] : [] } };
}

for (const target of ["g", "table_v.m", 'table_v["m"]']) {
    const { nodes, graph } = makeNodes({ target });
    const folds = recoverStructuredPostCfClosureDestinationTemps(nodes, graph);
    assert.equal(folds, 1, target);
    assert.equal(nodes.length, 1, target);
    assert(nodes[0].text.includes(`${target} = function(a) return a end`), nodes[0].text);
    assert(!nodes[0].text.includes("closure_v"), nodes[0].text);
}

for (const options of [
    { intervening: true },
    { extraUse: true },
    { captured: true },
    { producerText: "local closure_v = other_v" },
]) {
    const { nodes, graph } = makeNodes(options);
    const before = nodes.map(node => node.text).join("\n");
    const folds = recoverStructuredPostCfClosureDestinationTemps(nodes, graph);
    assert.equal(folds, 0, JSON.stringify(options));
    assert.equal(nodes.map(node => node.text).join("\n"), before);
}

console.log("beta CF post-CF closure destinations: PASS");
