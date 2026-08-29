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
    const operations = [
        { kind: "version-define", emittedTarget: source, rhs: "10", emittedText: `local ${source} = 10`, reads: [] },
        { kind: "version-define", emittedTarget: copy, rhs: source, emittedText: `local ${copy} = ${source}`, reads: [source] },
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

console.log("beta CF post-CF copy scalar temps: PASS");