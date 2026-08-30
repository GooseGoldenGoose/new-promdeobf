"use strict";
const assert = require("assert");
const { recoverStructuredLogicalConditionPrograms } = require("../passes/beta-control-flow");

function scalarSafe(rhs) {
    const text = String(rhs).trim();
    return /^(?:true|false|nil|-?\d+(?:\.\d+)?)$/.test(text) || /^(?:"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*')$/.test(text);
}

function raw(target, rhs, reads = [], kind = "version-define") {
    const text = target ? `${kind === "version-define" ? "local " : ""}${target} = ${rhs}` : rhs;
    return {
        type: "raw",
        text,
        reads: [...reads],
        operation: {
            kind: target ? kind : "effect-call",
            emittedTarget: target || null,
            rhs,
            emittedText: text,
            reads: [...reads],
            returnSinkSafe: target ? scalarSafe(rhs) : false,
        },
    };
}

function assign(target, rhs, reads = []) {
    return raw(target, rhs, reads, "epoch-mutate");
}

function logicalTail() {
    return [
        raw("receiver1", "obj", ["obj"]),
        raw("method1", 'receiver1["FindFirstChild"]', ["receiver1"]),
        raw("arg1", '"loading"'),
        raw("call1", "method1(receiver1, arg1)", ["method1", "receiver1", "arg1"]),
        raw("seed1", "not call1", ["call1"]),
        raw("result", "seed1", ["seed1"]),
        {
            type: "if",
            condition: "not (seed1)",
            reads: ["seed1"],
            elseBody: null,
            thenBody: [
                raw("receiver2", "obj", ["obj"]),
                raw("method2", 'receiver2["FindFirstChild"]', ["receiver2"]),
                raw("arg2", '"loading"'),
                raw("call2", "method2(receiver2, arg2)", ["method2", "receiver2", "arg2"]),
                raw("seed2", "call2", ["call2"]),
                {
                    type: "if",
                    condition: "call2",
                    reads: ["call2"],
                    elseBody: null,
                    thenBody: [
                        raw("loading", 'obj["loading"]', ["obj"]),
                        raw("enabled", 'loading["Enabled"]', ["loading"]),
                        raw("falseValue", "false"),
                        assign("seed2", "enabled == falseValue", ["enabled", "falseValue"]),
                    ],
                },
                assign("result", "seed2", ["seed2"]),
            ],
        },
    ];
}

{
    const work = raw(null, "work()");
    const nodes = [{ type: "repeat-until", condition: "result", reads: ["result"], body: [work, ...logicalTail()], conditionBody: [] }];
    assert(recoverStructuredLogicalConditionPrograms(nodes, { recoveredUpvalueBindings: [] }) >= 1);
    assert.equal(nodes[0].body.length, 1);
    assert.equal(nodes[0].body[0].text, "work()");
    assert.equal(nodes[0].conditionBody.length, 0);
    assert(nodes[0].condition.includes("FindFirstChild"), nodes[0].condition);
    assert(nodes[0].condition.includes("Enabled"), nodes[0].condition);
    assert.equal((nodes[0].condition.match(/FindFirstChild/g) || []).length, 2);
}

{
    const nodes = [{ type: "repeat-until", condition: "result", reads: ["result"], body: [...logicalTail(), raw(null, "observe(result)", ["result"])], conditionBody: [] }];
    recoverStructuredLogicalConditionPrograms(nodes, { recoveredUpvalueBindings: [] });
    assert.equal(nodes[0].condition, "result");
    assert(nodes[0].body.some(node => node.text === "observe(result)"));
}

{
    const nodes = [{ type: "repeat-until", condition: "result", reads: ["result"], body: logicalTail(), conditionBody: [] }];
    recoverStructuredLogicalConditionPrograms(nodes, { recoveredUpvalueBindings: ["result"] });
    assert.equal(nodes[0].condition, "result");
}

console.log("beta CF repeat condition program: PASS");
