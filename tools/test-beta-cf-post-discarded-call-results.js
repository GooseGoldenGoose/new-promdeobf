"use strict";
const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

const ast = parseLua("return 1", "<post-cf-source-local-call-result>");
const result = solveBetaControlFlow(ast, {
    applied: true,
    graph: {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        recoveredUpvalueBindings: [],
        states: [{
            id: 1, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "sink", rhs: "consume(value)", emittedText: "local sink = consume(value)", reads: ["consume", "value"] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ],
        }],
    },
});
assert.equal(result.applied, true);
assert(result.source.includes("local sink = consume(value)"), result.source);
console.log("beta CF preserves genuine unused source call locals: PASS");
