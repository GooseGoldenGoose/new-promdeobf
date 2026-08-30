"use strict";

const assert = require("assert");
const { collapseCompilerRepeatLoops } = require("../passes/beta-control-flow");

function transition(rhs, successorsRead = []) {
    return { kind: "state-transition", emittedTarget: "state", rhs, emittedText: `state = ${rhs}`, originalTarget: "state", originalText: `state = ${rhs}`, reads: successorsRead };
}
function def(kind, emittedTarget, rhs, originalTarget, reads = [], extra = {}) {
    return {
        kind,
        emittedTarget,
        rhs,
        emittedText: `${kind === "epoch-mutate" ? "" : "local "}${emittedTarget} = ${rhs}`,
        originalTarget,
        originalText: `${originalTarget} = ${rhs}`,
        reads,
        ...extra,
    };
}

function graph(flagKey = "Flag") {
    return {
        cfgComplete: true,
        stateName: "state",
        entries: [1],
        states: [
            { id: 1, predecessors: [], successors: [2, 3], operations: [
                { kind: "statement", emittedText: "beforeRepeat()", originalText: "beforeRepeat()", reads: [] },
                def("epoch-start", "dupGame", "game", "r5"),
                def("epoch-start", "dupA", 'dupGame["IsLoaded"](dupGame)', "r12", ["dupGame"]),
                def("epoch-start", "setup", "args", "r6", [], { returnSinkSafe: true }),
                def("version-define", "dupResult", "dupA", "ReturnVal", ["dupA"], { returnSinkSafe: true }),
                transition("dupA and 2 or 3", ["dupA"]),
            ] },
            { id: 2, predecessors: [1], successors: [3], operations: [
                def("epoch-start", "dupG", "_G", "r12"),
                def("version-define", "dupFlag", `dupG["${flagKey}"]`, "ReturnVal", ["dupG"], { returnSinkSafe: true }),
                transition("3"),
            ] },
            { id: 3, predecessors: [1, 2], successors: [4], operations: [transition("4")] },
            { id: 4, predecessors: [3, 7], successors: [5], operations: [
                { kind: "effect-call", rhs: "body()", emittedText: "body()", originalText: "body()", reads: [], returnSinkSafe: false },
                transition("5"),
            ] },
            { id: 5, predecessors: [4], successors: [6, 7], operations: [
                def("epoch-start", "realGame", "game", "r5"),
                def("epoch-start", "realA", 'realGame["IsLoaded"](realGame)', "r12", ["realGame"]),
                def("epoch-start", "realResult", "realA", "ReturnVal", ["realA"], { returnSinkSafe: true }),
                transition("realA and 6 or 7", ["realA"]),
            ] },
            { id: 6, predecessors: [5], successors: [7], operations: [
                def("epoch-start", "realG", "_G", "r12"),
                def("epoch-start", "realFlag", 'realG["Flag"]', "r5", ["realG"]),
                def("epoch-mutate", "realResult", "realFlag", "ReturnVal", ["realFlag"], { returnSinkSafe: true }),
                transition("7"),
            ] },
            { id: 7, predecessors: [5, 6], successors: [8, 4], operations: [
                transition("realResult and 8 or 4", ["realResult"]),
            ] },
            { id: 8, predecessors: [7], successors: [], operations: [
                { kind: "effect-call", rhs: "afterRepeat()", emittedText: "afterRepeat()", originalText: "afterRepeat()", reads: [] },
            ] },
        ],
    };
}

{
    const result = collapseCompilerRepeatLoops(graph());
    assert.equal(result.loopCount, 1);
    assert(result.removedCompilerConditionOperationCount > 0);
    const ids = result.graph.states.map(state => state.id);
    assert.deepEqual(ids, [1, 8]);
    const entry = result.graph.states[0];
    assert.deepEqual(entry.successors, [8]);
    assert.equal(entry.operations[0].emittedText, "beforeRepeat()");
    const repeat = entry.operations.find(operation => operation.kind === "structured-repeat");
    assert(repeat);
    assert(repeat.emittedText.includes("repeat"));
    assert(repeat.emittedText.includes("body()"));
    assert(repeat.emittedText.includes("until"));
    assert(!repeat.emittedText.includes("dupGame"));
}

{
    const result = collapseCompilerRepeatLoops(graph("DifferentFlag"));
    assert.equal(result.loopCount, 0);
    assert(result.graph.states.some(state => state.id === 1));
    assert(result.graph.states.some(state => state.id === 7));
}

console.log("beta CF multi-state repeat precheck: PASS");
