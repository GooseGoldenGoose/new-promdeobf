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
    assert.equal(nodes[1].expressions[0], "game:GetChildren()");
    assert.equal(recoverStructuredPostCfNamecalls(nodes), 0);
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


{
    const nodes = [
        { type: "raw", text: "local root = game", reads: [], operation: { kind: "version-define", emittedTarget: "root", rhs: "game", reads: [], emittedText: "local root = game", compilerGlobalLookupRecovered: "game" } },
        { type: "raw", text: 'local getService = root["GetService"]', reads: ["root"], operation: { kind: "version-define", emittedTarget: "getService", rhs: 'root["GetService"]', reads: ["root"], emittedText: 'local getService = root["GetService"]' } },
        { type: "raw", text: 'local serviceName = "Workspace"', reads: [], operation: { kind: "version-define", emittedTarget: "serviceName", rhs: '"Workspace"', reads: [], emittedText: 'local serviceName = "Workspace"', returnSinkSafe: true } },
        { type: "raw", text: "local workspace = getService(root, serviceName)", reads: ["getService", "root", "serviceName"], operation: { kind: "version-define", emittedTarget: "workspace", rhs: "getService(root, serviceName)", reads: ["getService", "root", "serviceName"], emittedText: "local workspace = getService(root, serviceName)" } },
        { type: "raw", text: 'local getChildren = workspace["GetChildren"]', reads: ["workspace"], operation: { kind: "version-define", emittedTarget: "getChildren", rhs: 'workspace["GetChildren"]', reads: ["workspace"], emittedText: 'local getChildren = workspace["GetChildren"]' } },
        { type: "generic-for", variables: ["i", "v"], expressions: ["getChildren(workspace)"], reads: ["getChildren", "workspace"], body: [] },
    ];
    assert.equal(recoverStructuredGenericForGlobalMethodTemps(nodes, { recoveredUpvalueBindings: [] }), 5);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].expressions[0], 'game:GetService("Workspace"):GetChildren()');
}

{
    const nodes = [
        { type: "raw", text: "local root = game", reads: [], operation: { kind: "version-define", emittedTarget: "root", rhs: "game", reads: [], emittedText: "local root = game", compilerGlobalLookupRecovered: "game" } },
        { type: "raw", text: "local storage = root.ReplicatedStorage", reads: ["root"], operation: { kind: "version-define", emittedTarget: "storage", rhs: "root.ReplicatedStorage", reads: ["root"], emittedText: "local storage = root.ReplicatedStorage" } },
        { type: "raw", text: "local folder = storage.Folder", reads: ["storage"], operation: { kind: "version-define", emittedTarget: "folder", rhs: "storage.Folder", reads: ["storage"], emittedText: "local folder = storage.Folder" } },
        { type: "raw", text: 'local getChildren = folder["GetChildren"]', reads: ["folder"], operation: { kind: "version-define", emittedTarget: "getChildren", rhs: 'folder["GetChildren"]', reads: ["folder"], emittedText: 'local getChildren = folder["GetChildren"]' } },
        { type: "generic-for", variables: ["i", "v"], expressions: ["getChildren(folder)"], reads: ["getChildren", "folder"], body: [] },
    ];
    assert.equal(recoverStructuredGenericForGlobalMethodTemps(nodes, { recoveredUpvalueBindings: [] }), 4);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].expressions[0], "game.ReplicatedStorage.Folder:GetChildren()");
}

console.log("beta CF post-CF namecalls: PASS");
