"use strict";
const assert = require("assert");
const { recoverStructuredPostCfStaticMembers } = require("../passes/beta-control-flow");

function raw(text) {
    const operation = { kind: "statement", emittedText: text, reads: [] };
    return { type: "raw", operation, text, reads: [] };
}

for (const [input, expected, count] of [
    ['local x = obj["field"]', 'local x = obj.field', 1],
    ['obj["field"] = value', 'obj.field = value', 1],
    ['consume(obj["field"])', 'consume(obj.field)', 1],
]) {
    const nodes = [raw(input)];
    assert.equal(recoverStructuredPostCfStaticMembers(nodes), count, input);
    assert.equal(nodes[0].text, expected, input);
}

for (const input of [
    'local x = obj["hello-world"]',
    'local x = obj["end"]',
    'local x = obj[key]',
    'local x = getObj()["field"]',
]) {
    const nodes = [raw(input)];
    assert.equal(recoverStructuredPostCfStaticMembers(nodes), 0, input);
    assert.equal(nodes[0].text, input);
}

console.log("beta CF post-CF static members: PASS");
