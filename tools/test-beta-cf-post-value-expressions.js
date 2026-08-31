"use strict";
const assert = require("assert");
const {
    recoverStructuredCompilerValueTemps,
    recoverStructuredPostCfStaticMembers,
} = require("../passes/beta-control-flow");

function raw(target, rhs, reads = [], extra = {}) {
    return {
        type: "raw",
        text: `local ${target} = ${rhs}`,
        reads: [...reads],
        operation: {
            kind: "epoch-start",
            emittedTarget: target,
            rhs,
            reads: [...reads],
            emittedText: `local ${target} = ${rhs}`,
            ...extra,
        },
    };
}

{
    const nodes = [
        raw("players", "game.Players", ["game"]),
        raw("localPlayer", "players.LocalPlayer", ["players"]),
        {
            type: "generic-for",
            variables: ["i", "v"],
            expressions: ["pairs(localPlayer:GetChildren())"],
            reads: ["pairs", "localPlayer"],
            body: [],
            compilerIteratorRecovered: true,
        },
    ];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 2);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].expressions[0], "pairs(game.Players.LocalPlayer:GetChildren())");
}

{
    const nodes = [
        raw("players", "game.Players", ["game"]),
        raw("localPlayer", "players.LocalPlayer", ["players"]),
        {
            type: "generic-for",
            variables: ["i", "v"],
            expressions: ["pairs(localPlayer:GetChildren())"],
            reads: ["pairs", "localPlayer"],
            body: [],
            compilerIteratorRecovered: false,
        },
    ];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 3);
}

{
    const nodes = [{
        type: "repeat-until",
        condition: "result == 1",
        reads: ["result"],
        conditionBody: [],
        body: [
            raw("random", "math.random", ["math"]),
            raw("two", "2", [], { returnSinkSafe: true }),
            raw("one", "1", [], { returnSinkSafe: true }),
            raw("result", "random(one, two)", ["random", "one", "two"]),
        ],
    }];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 4);
    assert.equal(nodes[0].body.length, 0);
    assert.equal(nodes[0].condition, "math.random(1, 2) == 1");
}

{
    const nodes = [{
        type: "while-guard",
        condition: 'waitFn["wait"]()',
        reads: ["waitFn"],
        conditionBody: [raw("waitFn", "task", [])],
        body: [],
    }];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 1);
    assert.equal(nodes[0].conditionBody.length, 0);
    assert.equal(nodes[0].condition, 'task["wait"]()');
    recoverStructuredPostCfStaticMembers(nodes);
    assert.equal(nodes[0].condition, "task.wait()");
}

{
    const nodes = [
        raw("localPlayer", "game.Players.LocalPlayer", ["game"]),
        { type: "raw", text: "tick()", reads: [], operation: { kind: "effect-call", emittedText: "tick()", reads: [] } },
        {
            type: "generic-for",
            variables: ["i", "v"],
            expressions: ["pairs(localPlayer:GetChildren())"],
            reads: ["pairs", "localPlayer"],
            body: [],
            compilerIteratorRecovered: true,
        },
    ];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 3);
}

{
    const nodes = [{
        type: "while-guard",
        condition: "value()",
        reads: ["value"],
        conditionBody: [raw("value", "task.wait", ["task"])],
        body: [],
    }];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: ["value"] }), 0);
    assert.equal(nodes[0].conditionBody.length, 1);
}

{
    const nodes = [{
        type: "repeat-until",
        condition: "result == 1",
        reads: ["result"],
        conditionBody: [],
        body: [
            raw("result", "math.random(1, 2)", ["math"]),
            { type: "raw", text: "observe(result)", reads: ["result"], operation: { kind: "effect-call", emittedText: "observe(result)", reads: ["result"] } },
        ],
    }];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
}

{
    const keep = raw("keepLocal", "sourceValue", ["sourceValue"], { returnSinkSafe: true });
    const nodes = [
        raw("root", "game", [], { compilerGlobalLookupRecovered: "game" }),
        keep,
        raw("storage", "root.ReplicatedStorage", ["root"]),
        {
            type: "generic-for",
            variables: ["i", "v"],
            expressions: ["pairs(storage:GetChildren())"],
            reads: ["pairs", "storage"],
            body: [],
            compilerIteratorRecovered: true,
        },
    ];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 2);
    assert.equal(nodes.length, 2);
    assert.strictEqual(nodes[0], keep);
    assert.equal(nodes[1].expressions[0], "pairs(game.ReplicatedStorage:GetChildren())");
}
console.log("beta CF post-CF compiler value temps: PASS");