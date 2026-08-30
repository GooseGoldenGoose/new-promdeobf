"use strict";
const assert = require("assert");
const { recoverStructuredPostCfNamecalls, recoverStructuredGenericForGlobalMethodTemps } = require("../passes/beta-control-flow");

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

{
    const nodes = [{
        type: "repeat-until",
        condition: 'obj["Ready"](obj) and obj["Check"](obj, x)',
        reads: ["obj", "x"],
        body: [],
        conditionBody: [],
    }];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 2);
    assert.equal(nodes[0].condition, 'obj:Ready() and obj:Check(x)');
}

{
    const nodes = [{ type: "if", condition: 'obj["Check"](obj, x)', reads: ["obj", "x"], thenBody: [], elseBody: null }];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 1);
    assert.equal(nodes[0].condition, 'obj:Check(x)');
}

{
    const nodes = [{ type: "while-guard", condition: 'obj["Running"](obj)', reads: ["obj"], conditionBody: [], body: [] }];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 1);
    assert.equal(nodes[0].condition, 'obj:Running()');
}

{
    const nodes = [{ type: "numeric-for", variable: "i", initial: 'obj["Start"](obj)', limit: 'obj["Limit"](obj)', step: 'obj["Step"](obj)', reads: ["obj"], body: [] }];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 3);
    assert.equal(nodes[0].initial, 'obj:Start()');
    assert.equal(nodes[0].limit, 'obj:Limit()');
    assert.equal(nodes[0].step, 'obj:Step()');
}

{
    const nodes = [{ type: "generic-for", variables: ["k", "v"], expressions: ['obj["Iter"](obj)', "state", "control"], reads: ["obj", "state", "control"], body: [] }];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 1);
    assert.equal(nodes[0].expressions[0], 'obj:Iter()');
}

for (const condition of [
    'obj["m"](other, 1)',
    'getObj()["m"](getObj(), 1)',
    'obj["hello-world"](obj, 1)',
    'obj["end"](obj, 1)',
    'obj[key](obj, 1)',
    'obj["m"]()',
]) {
    const nodes = [{ type: "repeat-until", condition, reads: [], body: [], conditionBody: [] }];
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 0, condition);
    assert.equal(nodes[0].condition, condition);
}

{
    const nodes = [
        { type: "raw", text: "local recv = game", reads: [], operation: { kind: "version-define", emittedTarget: "recv", rhs: "game", reads: [], emittedText: "local recv = game", compilerGlobalLookupRecovered: "game" } },
        { type: "raw", text: 'local method = recv["GetChildren"]', reads: ["recv"], operation: { kind: "version-define", emittedTarget: "method", rhs: 'recv["GetChildren"]', reads: ["recv"], emittedText: 'local method = recv["GetChildren"]' } },
        { type: "raw", text: "local scratch = args", reads: [], operation: { kind: "version-define", emittedTarget: "scratch", rhs: "args", reads: [], emittedText: "local scratch = args", returnSinkSafe: true } },
        { type: "generic-for", variables: ["i", "v"], expressions: ["method(recv)"], reads: ["method", "recv"], body: [] },
    ];
    assert.equal(recoverStructuredGenericForGlobalMethodTemps(nodes, { recoveredUpvalueBindings: [] }), 2);
    assert.equal(nodes.length, 2);
    assert.equal(nodes[1].expressions[0], 'game["GetChildren"](game)');
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 1);
    assert.equal(nodes[1].expressions[0], "game:GetChildren()");
}

{
    const nodes = [
        { type: "raw", text: "local recv = sourceObj", reads: ["sourceObj"], operation: { kind: "version-define", emittedTarget: "recv", rhs: "sourceObj", reads: ["sourceObj"], emittedText: "local recv = sourceObj" } },
        { type: "raw", text: 'local method = recv["GetChildren"]', reads: ["recv"], operation: { kind: "version-define", emittedTarget: "method", rhs: 'recv["GetChildren"]', reads: ["recv"], emittedText: 'local method = recv["GetChildren"]' } },
        { type: "generic-for", variables: ["i", "v"], expressions: ["method(recv)"], reads: ["method", "recv"], body: [] },
    ];
    assert.equal(recoverStructuredGenericForGlobalMethodTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 3);
}
console.log("beta CF post-CF namecalls: PASS");
