"use strict";
const assert = require("assert");
const { recoverStructuredPostCfFunctionDeclarations } = require("../passes/beta-control-flow");

function raw(text) {
    const operation = { kind: "statement", emittedText: text, reads: [] };
    return { type: "raw", operation, text, reads: [] };
}

for (const [input, expected] of [
    ["g = function(a) return a end", "function g(a) return a end"],
    ["t.m = function(a) return a end", "function t.m(a) return a end"],
    ["t.x.y = function(a) return a end", "function t.x.y(a) return a end"],
]) {
    const nodes = [raw(input)];
    assert.equal(recoverStructuredPostCfFunctionDeclarations(nodes), 1, input);
    assert.equal(nodes[0].text, expected, input);
}

for (const input of [
    "local g = function(a) return a end",
    "t[key] = function(a) return a end",
    "getT().m = function(a) return a end",
]) {
    const nodes = [raw(input)];
    assert.equal(recoverStructuredPostCfFunctionDeclarations(nodes), 0, input);
    assert.equal(nodes[0].text, input);
}

console.log("beta CF post-CF function declarations: PASS");
