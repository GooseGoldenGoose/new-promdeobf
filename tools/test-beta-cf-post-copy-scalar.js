"use strict";
const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

const ast = parseLua("return 1", "<step19-wrapper>");

function solve(options = {}) {
    const source = "sourceValue";
    const copy = "copyTemp";
    const out = "outValue";
    const consumerRhs = options.consumerRhs || `${copy} + 1`;
    const producerRhs = options.producerRhs || source;
    const producerReads = options.producerReads || (producerRhs === source ? [source] : []);
    const operations = [
        { kind: "version-define", emittedTarget: source, rhs: "10", emittedText: `local ${source} = 10`, reads: [] },
        { kind: "version-define", emittedTarget: copy, rhs: producerRhs, emittedText: `local ${copy} = ${producerRhs}`, reads: producerReads },
    ];
    if (options.intervening) operations.push({ kind: "statement", emittedText: "tick()", originalText: "tick()", reads: [] });
    if (options.extraUse) operations.push({ kind: "statement", emittedText: `observe(${copy})`, originalText: `observe(${copy})`, reads: [copy] });
    operations.push(
        { kind: "version-define", emittedTarget: out, rhs: consumerRhs, emittedText: `local ${out} = ${consumerRhs}`, reads: options.consumerReads || [copy] },
        { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [out], emittedText: `ReturnVal = { ${out} }`, rhs: `{ ${out} }`, reads: [out] },
        { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
    );
    return solveBetaControlFlow(ast, {
        applied: true,
        graph: {
            cfgComplete: true,
            stateName: "state",
            entries: [1],
            recoveredUpvalueBindings: options.captured ? [copy] : [],
            states: [{ id: 1, predecessors: [], successors: [], operations }],
        },
    });
}

const direct = solve();
assert.equal(direct.applied, true);
assert.equal(direct.postCfCopyScalarRecoveryCount, 1);
assert(direct.source.includes("local outValue = (sourceValue) + 1"));
assert(!direct.source.includes("local copyTemp = sourceValue"));

const nonLeading = solve({ consumerRhs: "otherValue + copyTemp", consumerReads: ["otherValue", "copyTemp"] });
assert.equal(nonLeading.postCfCopyScalarRecoveryCount, 0);
assert(nonLeading.source.includes("local copyTemp = sourceValue"));

const callRhs = solve({ consumerRhs: "consume(copyTemp)", consumerReads: ["consume", "copyTemp"] });
assert.equal(callRhs.postCfCopyScalarRecoveryCount, 0);
assert(callRhs.source.includes("local copyTemp = sourceValue"));

const logicalRhs = solve({ consumerRhs: "flag and copyTemp", consumerReads: ["flag", "copyTemp"] });
assert.equal(logicalRhs.postCfCopyScalarRecoveryCount, 0);
assert(logicalRhs.source.includes("local copyTemp = sourceValue"));

const intervening = solve({ intervening: true });
assert.equal(intervening.postCfCopyScalarRecoveryCount, 0);
assert(intervening.source.includes("local copyTemp = sourceValue"));

const extraUse = solve({ extraUse: true });
assert.equal(extraUse.postCfCopyScalarRecoveryCount, 0);
assert(extraUse.source.includes("local copyTemp = sourceValue"));

const captured = solve({ captured: true });
assert.equal(captured.postCfCopyScalarRecoveryCount, 0);
assert(captured.source.includes("local copyTemp = sourceValue"));

const logicalChain = solve({
    producerRhs: "sourceValue == 10",
    producerReads: ["sourceValue"],
    consumerRhs: 'copyTemp and "wasd"',
    consumerReads: ["copyTemp"],
});
assert.equal(logicalChain.postCfCopyScalarRecoveryCount, 1);
assert(logicalChain.source.includes('local outValue = (sourceValue == 10) and "wasd"'));
assert(!logicalChain.source.includes("local copyTemp = sourceValue == 10"));

const callProducer = solve({
    producerRhs: "makeValue()",
    producerReads: ["makeValue"],
    consumerRhs: 'copyTemp and "wasd"',
    consumerReads: ["copyTemp"],
});
assert.equal(callProducer.postCfCopyScalarRecoveryCount, 0);
assert(callProducer.source.includes("local copyTemp = makeValue()"));

function solveSelfLogical() {
    const operations = [
        { kind: "version-define", emittedTarget: "x", rhs: 'flag and "wasd"', emittedText: 'local x = flag and "wasd"', reads: ["flag"] },
        { kind: "epoch-mutate", emittedTarget: "x", rhs: 'x or "ee"', emittedText: 'x = x or "ee"', reads: ["x"] },
        { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["x"], emittedText: "ReturnVal = { x }", rhs: "{ x }", reads: ["x"] },
        { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
    ];
    return solveBetaControlFlow(ast, {
        applied: true,
        graph: {
            cfgComplete: true,
            stateName: "state",
            entries: [1],
            recoveredUpvalueBindings: [],
            states: [{ id: 1, predecessors: [], successors: [], operations }],
        },
    });
}

const selfLogical = solveSelfLogical();
assert.equal(selfLogical.applied, true);
assert(selfLogical.source.includes('local x = (flag and "wasd") or "ee"'));
assert(!selfLogical.source.includes('x = x or "ee"'));

console.log("beta CF post-CF copy scalar temps: PASS");
