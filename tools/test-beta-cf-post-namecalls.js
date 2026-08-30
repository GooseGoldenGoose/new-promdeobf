"use strict";
const assert = require("assert");
const { recoverStructuredPostCfNamecalls } = require("../passes/beta-control-flow");

function raw(text, kind = "effect-call") {
    const operation = { kind, emittedText: text, rhs: kind === "effect-call" ? null : text.slice(text.indexOf("=") + 1).trim(), reads: [] };
    return { type: "raw", operation, text, reads: [] };
}

for (const [input, expected] of [
    ['obj["m"](obj, 1)', 'obj:m(1)'],
    ['local out = obj["m"](obj, 1, 2)', 'local out = obj:m(1, 2)'],
]) {
    const nodes = [raw(input, input.startsWith("local ") ? "version-define" : "effect-call")];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 1, input);
    assert.equal(nodes[0].text, expected);
}

for (const input of [
    'obj["m"](other, 1)',
    'getObj()["m"](getObj(), 1)',
    'obj["hello-world"](obj, 1)',
    'obj["end"](obj, 1)',
    'obj[key](obj, 1)',
]) {
    const nodes = [raw(input)];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 0, input);
    assert.equal(nodes[0].text, input);
}

console.log("beta CF post-CF namecalls: PASS");
