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

function epochsFor(result, name) {
    return result.ordinaryRegisterEpochs.filter(epoch => epoch.registerName === name);
}

{
    const result = recoverVmBindings("", null, makeVmState([{
        id: 1,
        source: `
            r1 = 1
            r1 = 2
            r2 = _env["print"]
            r3 = r2
            r4 = args
        `,
    }]));

    assert.strictEqual(epochsFor(result, "r1").length, 2, "sequential unrelated values must not merge");
    assert.strictEqual(epochsFor(result, "r2").length, 0, "environment references are not ordinary register epochs");
    assert.strictEqual(epochsFor(result, "r3").length, 0, "environment-reference copies stay excluded");
    assert.strictEqual(epochsFor(result, "r4").length, 0, "external references stay excluded");
}

{
    const result = recoverVmBindings("", null, makeVmState([{
        id: 1,
        source: `
            r1 = 1
            r2 = r1 + 1
            r1 = r2
            r3 = r1
        `,
    }]));

    const r1 = epochsFor(result, "r1");
    assert.strictEqual(r1.length, 1, "transitive mutation chain should merge same-register definitions");
    assert.strictEqual(r1[0].definitionIds.length, 2);
    assert.strictEqual(result.ordinaryRegisterEpochStats.mutationMergeCount, 1);
    assert.strictEqual(r1[0].sourceBindingProven, false, "epoch analysis must not claim lexical source binding recovery");
}

{
    const result = recoverVmBindings("", null, makeVmState([
        { id: 1, source: "", terminator: { kind: "branch", condition: null, onTrue: 2, onFalse: 3 } },
        { id: 2, source: "r1 = 10", terminator: { kind: "jump", target: 4 } },
        { id: 3, source: "r1 = 20", terminator: { kind: "jump", target: 4 } },
        { id: 4, source: "r2 = r1", terminator: { kind: "stop" } },
    ]));

    const r1 = epochsFor(result, "r1");
    assert.strictEqual(r1.length, 1, "join-observable definitions should share one storage epoch");
    assert.strictEqual(r1[0].definitionIds.length, 2);
    assert.strictEqual(result.ordinaryRegisterEpochStats.joinMergeCount, 1);
}

{
    const result = recoverVmBindings("", null, makeVmState([{
        id: 1,
        source: `
            r1 = 1
            r2 = r1
            r1 = nil
            r1 = r2
            r3 = r1
        `,
    }]));

    const r1 = epochsFor(result, "r1");
    assert.strictEqual(r1.length, 2, "cleanup/reuse handoff must split epochs");
    assert.strictEqual(r1[0].cleanupDefinitionIds.length, 1);
    assert.strictEqual(r1[0].ownershipHandoffAfter, true);
    assert.strictEqual(r1[1].cleanupDefinitionIds.length, 0);
}

console.log("vm binding epoch tests passed");
