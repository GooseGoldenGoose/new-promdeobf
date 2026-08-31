"use strict";
const assert = require("assert");
const {
    recoverStructuredCompilerValueTemps,
    recoverStructuredCompilerLogicalCarriers,
    recoverStructuredAdjacentLocalInitializers,
    recoverStructuredSourcePackUnpackForwarding,
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


// Compiler-owned return transport peels right-to-left without touching source returns.
{
    const nodes = [
        raw("copy", "index", ["index"], { registerEpoch: "r1:epoch:1" }),
        raw("base", "tbl", ["tbl"], { registerEpoch: "r2:epoch:1" }),
        raw("key", "index", ["index"], { registerEpoch: "r3:epoch:1" }),
        raw("value", "base[key]", ["base", "key"], { registerEpoch: "r4:epoch:1" }),
        {
            type: "raw",
            text: "return copy, value",
            reads: ["copy", "value"],
            operation: { kind: "return", emittedText: "return copy, value", returnExpressions: ["copy", "value"], reads: ["copy", "value"] },
        },
    ];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 4);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].text, "return index, tbl[index]");
}

{
    const nodes = [
        raw("sourceValue", "left + right", ["left", "right"], { registerEpoch: null }),
        {
            type: "raw",
            text: "return sourceValue",
            reads: ["sourceValue"],
            operation: { kind: "return", emittedText: "return sourceValue", returnExpressions: ["sourceValue"], reads: ["sourceValue"] },
        },
    ];
    assert.equal(recoverStructuredCompilerValueTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 2);
}

// Exact compiler OR carrier reconstruction preserves one-time evaluation.
{
    const resultEpoch = "r5:epoch:1";
    const fallback = {
        type: "raw",
        text: "result = rhs()",
        reads: ["rhs"],
        operation: { kind: "epoch-mutate", emittedTarget: "result", rhs: "rhs()", reads: ["rhs"], emittedText: "result = rhs()", registerEpoch: resultEpoch },
    };
    const nodes = [
        raw("cond", "lhs()", ["lhs"], { registerEpoch: "r4:epoch:1" }),
        raw("result", "cond", ["cond"], { registerEpoch: resultEpoch }),
        { type: "if", condition: "not cond", reads: ["cond"], thenBody: [fallback], elseBody: null },
        { type: "if", condition: "result", reads: ["result"], thenBody: [], elseBody: null },
    ];
    assert.equal(recoverStructuredCompilerLogicalCarriers(nodes, { recoveredUpvalueBindings: [] }), 3);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].condition, "(lhs()) or (rhs())");
    assert.deepEqual(nodes[0].reads.sort(), ["lhs", "rhs"].sort());
}

// Adjacent declaration initialization is presentation-only and refuses args/self reads.
{
    const declaration = {
        type: "raw", text: "local carrier", reads: [],
        operation: { kind: "phi-declare", emittedTarget: "carrier", emittedText: "local carrier", reads: [] },
    };
    const assignment = {
        type: "raw", text: "carrier = source", reads: ["source"],
        operation: { kind: "epoch-mutate", emittedTarget: "carrier", rhs: "source", emittedText: "carrier = source", reads: ["source"] },
    };
    const nodes = [declaration, assignment];
    assert.equal(recoverStructuredAdjacentLocalInitializers(nodes), 1);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].text, "local carrier = source");
}

for (const assignment of [
    { text: "carrier = args[1]", rhs: "args[1]", reads: ["args"] },
    { text: "carrier = use(carrier)", rhs: "use(carrier)", reads: ["use", "carrier"] },
]) {
    const nodes = [
        { type: "raw", text: "local carrier", reads: [], operation: { kind: "phi-declare", emittedTarget: "carrier", emittedText: "local carrier", reads: [] } },
        { type: "raw", text: assignment.text, reads: [...assignment.reads], operation: { kind: "epoch-mutate", emittedTarget: "carrier", rhs: assignment.rhs, emittedText: assignment.text, reads: [...assignment.reads] } },
    ];
    assert.equal(recoverStructuredAdjacentLocalInitializers(nodes), 0);
    assert.equal(nodes.length, 2);
}


// Source-owned single-use { call() } forwarded into final unpack consumer.
{
    const pack = raw("packed", "{ returnsMany(\"A\", \"B\", \"C\") }", ["returnsMany"], { compilerSourceLifetimeProven: true });
    const use = { type: "raw", text: 'print("PACKED", unpack(packed))', reads: ["print", "unpack", "packed"], operation: { kind: "effect-call", rhs: 'print("PACKED", unpack(packed))', emittedText: 'print("PACKED", unpack(packed))', reads: ["print", "unpack", "packed"] } };
    const nodes = [pack, use];
    assert.equal(recoverStructuredSourcePackUnpackForwarding(nodes, { recoveredUpvalueBindings: [] }), 1);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].text, 'print("PACKED", returnsMany("A", "B", "C"))');
}

for (const nodes of [
    [raw("packed", "{ f() }", ["f"]), { type: "raw", text: "sink(unpack(packed))", reads: ["sink", "unpack", "packed"], operation: { kind: "effect-call", rhs: "sink(unpack(packed))", emittedText: "sink(unpack(packed))", reads: ["sink", "unpack", "packed"] } }],
    [raw("packed", "{ f() }", ["f"], { compilerSourceLifetimeProven: true }), { type: "raw", text: "touch(packed)", reads: ["touch", "packed"], operation: { kind: "effect-call", rhs: "touch(packed)", emittedText: "touch(packed)", reads: ["touch", "packed"] } }, { type: "raw", text: "sink(unpack(packed))", reads: ["sink", "unpack", "packed"], operation: { kind: "effect-call", rhs: "sink(unpack(packed))", emittedText: "sink(unpack(packed))", reads: ["sink", "unpack", "packed"] } }],
    [raw("packed", "{ f() }", ["f"], { compilerSourceLifetimeProven: true }), { type: "raw", text: "sink(unpack(packed), 1)", reads: ["sink", "unpack", "packed"], operation: { kind: "effect-call", rhs: "sink(unpack(packed), 1)", emittedText: "sink(unpack(packed), 1)", reads: ["sink", "unpack", "packed"] } }],
]) {
    assert.equal(recoverStructuredSourcePackUnpackForwarding(nodes, { recoveredUpvalueBindings: [] }), 0);
}

console.log("beta CF post-CF compiler value temps: PASS");