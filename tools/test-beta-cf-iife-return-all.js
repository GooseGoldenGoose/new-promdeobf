"use strict";
const assert = require("assert");
const { parseLua } = require("../main");
const {
    recoverStructuredCompilerClosureTemps,
    recoverStructuredCompilerReturnAllForwarding,
} = require("../passes/beta-control-flow");

function raw(operation) {
    return { type: "raw", stateId: 1, operation, text: operation.emittedText, reads: [...(operation.reads || [])] };
}
function closure(name, functionText, { captures = 0, entry = 2, factoryName = "createClosure" } = {}) {
    return raw({
        kind: "version-define",
        emittedTarget: name,
        rhs: functionText,
        emittedText: `local ${name} = ${functionText}`,
        reads: [],
        compilerClosureFactoryRecovered: { factoryName, entry, captureCount: captures },
    });
}

{
    const nodes = [
        closure("inner_v", "function() return 1 end", { factoryName: "createClosure1" }),
        raw({
            kind: "version-define",
            emittedTarget: "pack_v",
            rhs: "{ pcall(inner_v) }",
            emittedText: "local pack_v = { pcall(inner_v) }",
            reads: ["inner_v"],
            compilerStructuredGlobalAliasesRecovered: [{ globalName: "pcall" }],
        }),
        closure("outer_v", "function(...) return end", { entry: 3 }),
        raw({
            kind: "effect-call",
            rhs: "outer_v(unpack(pack_v))",
            emittedText: "outer_v(unpack(pack_v))",
            reads: ["outer_v", "pack_v"],
        }),
    ];
    assert.equal(recoverStructuredCompilerClosureTemps(nodes, { recoveredUpvalueBindings: [] }), 2);
    assert.equal(nodes.length, 2);
    assert(nodes[0].text.includes("pcall(function() return 1 end)"), nodes[0].text);
    assert(nodes[1].text.startsWith("(function(...) return end)(unpack(pack_v))"), nodes[1].text);
    assert.equal(nodes[1].operation.compilerInlineClosureBaseRecovered, true);
    assert.equal(recoverStructuredCompilerReturnAllForwarding(nodes, { recoveredUpvalueBindings: [] }), 1);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].text, "(function(...) return end)(pcall(function() return 1 end))");
    parseLua(nodes[0].text, "<iife-return-all-positive>");
}

{
    const nodes = [
        closure("captured_v", "function() return 1 end", { captures: 1 }),
        raw({ kind: "effect-call", rhs: "captured_v()", emittedText: "captured_v()", reads: ["captured_v"] }),
    ];
    assert.equal(recoverStructuredCompilerClosureTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 2);
}

{
    const sourceClosure = raw({
        kind: "version-define",
        emittedTarget: "source_v",
        rhs: "function() return 1 end",
        emittedText: "local source_v = function() return 1 end",
        reads: [],
    });
    const nodes = [sourceClosure, raw({ kind: "effect-call", rhs: "source_v()", emittedText: "source_v()", reads: ["source_v"] })];
    assert.equal(recoverStructuredCompilerClosureTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
}

{
    const nodes = [
        closure("multi_v", "function() return 1 end"),
        raw({ kind: "effect-call", rhs: "sink_v(multi_v)", emittedText: "sink_v(multi_v)", reads: ["sink_v", "multi_v"] }),
        raw({ kind: "effect-call", rhs: "multi_v()", emittedText: "multi_v()", reads: ["multi_v"] }),
    ];
    assert.equal(recoverStructuredCompilerClosureTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
}

{
    const nodes = [
        closure("arg_v", "function() return 1 end"),
        raw({ kind: "effect-call", rhs: "unknown_v(arg_v)", emittedText: "unknown_v(arg_v)", reads: ["unknown_v", "arg_v"] }),
    ];
    assert.equal(recoverStructuredCompilerClosureTemps(nodes, { recoveredUpvalueBindings: [] }), 0);
}

{
    const nodes = [
        raw({ kind: "version-define", emittedTarget: "pack_v", rhs: "{ pcall(work_v) }", emittedText: "local pack_v = { pcall(work_v) }", reads: ["work_v"] }),
        raw({ kind: "effect-call", rhs: "sink_v(unpack(pack_v))", emittedText: "sink_v(unpack(pack_v))", reads: ["sink_v", "pack_v"] }),
    ];
    assert.equal(recoverStructuredCompilerReturnAllForwarding(nodes, { recoveredUpvalueBindings: [] }), 0);
}

{
    const nodes = [
        raw({ kind: "version-define", emittedTarget: "pack_v", rhs: "{ pcall(work_v) }", emittedText: "local pack_v = { pcall(work_v) }", reads: ["work_v"] }),
        raw({ kind: "effect-call", rhs: "(function(...) return end)(unpack(pack_v), 1)", emittedText: "(function(...) return end)(unpack(pack_v), 1)", reads: ["pack_v"], compilerInlineClosureBaseRecovered: true }),
    ];
    assert.equal(recoverStructuredCompilerReturnAllForwarding(nodes, { recoveredUpvalueBindings: [] }), 0);
}

console.log("beta CF IIFE RETURN_ALL recovery: PASS");
