const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { recoverVmBindings } = require("../passes/vm-bindings");

function parseStatements(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        comments: true,
        scope: true,
        locations: true,
        ranges: true,
    }).body;
}

function makeVmState(blocks) {
    const order = blocks.map(block => block.id);
    return {
        found: true,
        reachableClosed: true,
        normalized: true,
        graphRoots: [{
            kind: "root",
            factory: "createClosure",
            entryId: order[0],
            graph: {
                order,
                blocks: new Map(blocks.map(block => [block.id, {
                    id: block.id,
                    body: parseStatements(block.source || ""),
                    terminator: block.terminator || { kind: "stop" },
                }])),
            },
        }],
    };
}

function byName(result, name) {
    return result.definitions.filter(def => def.name === name);
}

{
    const result = recoverVmBindings("", null, makeVmState([{
        id: 1,
        source: `
            r1 = _env["print"]
            r2 = r1
            r3 = "hello"
            r4 = r3
            r5 = r2(r4)
            r6 = args
            r7 = r6
            r8 = _env["game"].Players
        `,
    }]));

    assert.strictEqual(result.found, true);
    assert.strictEqual(byName(result, "r1")[0].valueProvenance.kind, "environment-reference");
    assert.strictEqual(byName(result, "r2")[0].valueProvenance.kind, "environment-reference");
    assert.strictEqual(byName(result, "r3")[0].valueProvenance.kind, "register-value");
    assert.strictEqual(byName(result, "r4")[0].valueProvenance.kind, "register-value");
    assert.strictEqual(byName(result, "r5")[0].valueProvenance.kind, "register-value");
    assert.strictEqual(byName(result, "r6")[0].valueProvenance.kind, "external-reference");
    assert.strictEqual(byName(result, "r7")[0].valueProvenance.kind, "external-reference");
    assert.strictEqual(byName(result, "r8")[0].valueProvenance.kind, "environment-reference");
    assert.strictEqual(result.environmentReferenceDefinitions.length, 3);
    assert.strictEqual(result.registerValueDefinitions.length, 3);
    assert.strictEqual(result.externalReferenceDefinitions.length, 2);
    assert.strictEqual(result.unknownValueDefinitions.length, 0);
    assert.strictEqual(result.valueProvenanceComplete, true);
}

{
    const result = recoverVmBindings("", null, makeVmState([
        { id: 1, source: "", terminator: { kind: "branch", condition: null, onTrue: 2, onFalse: 3 } },
        { id: 2, source: 'r1 = _env["print"]', terminator: { kind: "jump", target: 4 } },
        { id: 3, source: "r1 = 5", terminator: { kind: "jump", target: 4 } },
        { id: 4, source: "r2 = r1", terminator: { kind: "stop" } },
    ]));

    const joined = byName(result, "r2")[0];
    assert.deepStrictEqual(new Set(joined.rhsReachingDefIds).size, 2);
    assert.strictEqual(joined.valueProvenance.kind, "unknown");
    assert.strictEqual(joined.valueProvenance.reason, "mixed-register-copy");
    const joinUse = result.uses.find(use => use.blockId === 4 && use.name === "r1");
    assert(joinUse);
    assert.strictEqual(joinUse.valueProvenance.kind, "unknown");
    assert.strictEqual(result.valueProvenanceComplete, false);
}

console.log("vm binding provenance tests passed");
