"use strict";
const assert = require("assert");
const { recoverStructuredCompilerGlobalAliases, normalizeRecoveredLogicalExpression } = require("../passes/beta-control-flow");

function raw(operation) {
    return { type: "raw", stateId: 1, operation, text: operation.emittedText, reads: [...(operation.reads || [])] };
}
function alias(name, globalName) {
    return raw({
        kind: "version-define",
        emittedTarget: name,
        rhs: globalName,
        emittedText: `local ${name} = ${globalName}`,
        reads: [],
        compilerGlobalLookupRecovered: globalName,
    });
}
function argsSnapshot(name, slot) {
    return raw({
        kind: "version-define",
        emittedTarget: name,
        rhs: `args[${slot}]`,
        emittedText: `local ${name} = args[${slot}]`,
        reads: ["args"],
    });
}

{
    const nodes = [
        alias("call_v", "pcall"),
        alias("text_v", "tostring"),
        argsSnapshot("param_v", 3),
        { type: "if", condition: "not call_v(text_v, param_v)", reads: ["call_v", "text_v", "param_v"], thenBody: [], elseBody: null },
    ];
    assert.equal(recoverStructuredCompilerGlobalAliases(nodes, { recoveredUpvalueBindings: [] }), 2);
    assert.equal(nodes.length, 2);
    assert.equal(nodes[0].text, "local param_v = args[3]");
    assert.equal(nodes[1].condition, "not pcall(tostring, param_v)");
}

{
    const nodes = [
        alias("xc_v", "xpcall"),
        alias("print_v", "print"),
        raw({ kind: "effect-call", rhs: "sink_v(xc_v(work_v, print_v))", emittedText: "sink_v(xc_v(work_v, print_v))", reads: ["sink_v", "xc_v", "work_v", "print_v"] }),
    ];
    assert.equal(recoverStructuredCompilerGlobalAliases(nodes, { recoveredUpvalueBindings: [] }), 2);
    assert.equal(nodes.length, 1);
    assert.equal(nodes[0].text, "sink_v(xpcall(work_v, print))");
}

{
    const nodes = [
        alias("first_v", "pcall"),
        alias("second_v", "print"),
        raw({ kind: "effect-call", rhs: "sink_v(second_v, first_v)", emittedText: "sink_v(second_v, first_v)", reads: ["sink_v", "second_v", "first_v"] }),
    ];
    assert.equal(recoverStructuredCompilerGlobalAliases(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 3);
}

{
    const sourceAlias = raw({ kind: "version-define", emittedTarget: "f_v", rhs: "print", emittedText: "local f_v = print", reads: [] });
    const nodes = [sourceAlias, raw({ kind: "effect-call", rhs: "f_v(1)", emittedText: "f_v(1)", reads: ["f_v"] })];
    assert.equal(recoverStructuredCompilerGlobalAliases(nodes, { recoveredUpvalueBindings: [] }), 0);
    assert.equal(nodes.length, 2);
}

{
    const nodes = [alias("f_v", "print"), raw({ kind: "effect-call", rhs: "f_v(1)", emittedText: "f_v(1)", reads: ["f_v"] })];
    assert.equal(recoverStructuredCompilerGlobalAliases(nodes, { recoveredUpvalueBindings: ["f_v"] }), 0);
    assert.equal(nodes.length, 2);
}

assert.equal(
    normalizeRecoveredLogicalExpression("((not (A()))) or (((not (B()))) or ((not (C()))))"),
    "not A() or not B() or not C()"
);
assert.equal(normalizeRecoveredLogicalExpression("A() and (B() or C())"), "A() and (B() or C())");
assert.equal(normalizeRecoveredLogicalExpression("not (A() or B())"), "not (A() or B())");
assert.equal(normalizeRecoveredLogicalExpression("(A() or B()) and C()"), "(A() or B()) and C()");

console.log("beta CF compiler global aliases: PASS");
