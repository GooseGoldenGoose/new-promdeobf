const assert = require("assert");
const { recoverBetaUpvalues } = require("../passes/beta-upvalues");

function terminalOps() {
    return [
        {
            kind: "return-payload",
            terminalCompilerReturnPayload: true,
            returnExpressions: [],
            emittedTarget: "ReturnVal",
            emittedText: "ReturnVal = {}",
            rhs: "{}",
            reads: [],
        },
        {
            kind: "state-transition",
            emittedTarget: "state",
            emittedText: "state = nil",
            rhs: "nil",
            reads: [],
        },
    ];
}

const simple = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "epoch-start", emittedTarget: "r_v1_1", emittedText: "local r_v1_1 = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                    { kind: "version-define", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = 123", rhs: "123", reads: [] },
                    { kind: "unsupported", emittedText: "upvalueValues[r_v1_1] = r_v2_1", reads: ["r_v1_1", "r_v2_1"] },
                    { kind: "version-define", emittedTarget: "r_v3_1", emittedText: "local r_v3_1 = createClosure4(2, { r_v1_1 })", rhs: "createClosure4(2, { r_v1_1 })", reads: ["r_v1_1"] },
                    { kind: "version-define", emittedTarget: "r_v4_1", emittedText: "local r_v4_1 = upvalueValues[r_v1_1]", rhs: "upvalueValues[r_v1_1]", reads: ["r_v1_1"] },
                    { kind: "epoch-mutate", emittedTarget: "r_v1_1", emittedText: "r_v1_1 = releaseUpvalue(r_v1_1)", rhs: "releaseUpvalue(r_v1_1)", reads: ["r_v1_1"] },
                    ...terminalOps(),
                ],
            },
            {
                id: 2,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v5_1", emittedText: "local r_v5_1 = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                    { kind: "version-define", emittedTarget: "r_v6_1", emittedText: "local r_v6_1 = r_v5_1 + 1", rhs: "r_v5_1 + 1", reads: ["r_v5_1"] },
                    { kind: "unsupported", emittedText: "upvalueValues[upvalues[1]] = r_v6_1", reads: ["r_v6_1"] },
                    ...terminalOps(),
                ],
            },
        ],
    },
});

assert.equal(simple.safe, true);
assert.equal(simple.applied, true);
assert.equal(simple.stats.recoveredCellCount, 1);
assert.equal(simple.stats.captureCount, 1);
const simpleRoot = simple.graph.states.find(state => state.id === 1).operations;
const simpleChild = simple.graph.states.find(state => state.id === 2).operations;
assert(!simpleRoot.some(op => String(op.emittedText || "").includes("allocUpvalue(")));
assert(!simpleRoot.some(op => String(op.emittedText || "").includes("releaseUpvalue(")));
assert(!simpleRoot.some(op => String(op.emittedText || "").includes("upvalueValues[")));
assert(simpleRoot.some(op => op.rhs === "createClosure4(2, {})"));
assert(simpleRoot.some(op => op.rhs === "r_v2_1" && op.emittedTarget === "r_v4_1"));
assert(simpleChild.some(op => op.rhs === "r_v2_1" && op.emittedTarget === "r_v5_1"));
assert(simpleChild.some(op => op.kind === "upvalue-write" && op.emittedText === "r_v2_1 = r_v6_1"));

const relay = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2, 3],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "epoch-start", emittedTarget: "r_v1_1", emittedText: "local r_v1_1 = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                    { kind: "version-define", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = 10", rhs: "10", reads: [] },
                    { kind: "unsupported", emittedText: "upvalueValues[r_v1_1] = r_v2_1", reads: ["r_v1_1", "r_v2_1"] },
                    { kind: "version-define", emittedTarget: "r_v3_1", emittedText: "local r_v3_1 = createClosure3(2, { r_v1_1 })", rhs: "createClosure3(2, { r_v1_1 })", reads: ["r_v1_1"] },
                    { kind: "epoch-mutate", emittedTarget: "r_v1_1", emittedText: "r_v1_1 = releaseUpvalue(r_v1_1)", rhs: "releaseUpvalue(r_v1_1)", reads: ["r_v1_1"] },
                    ...terminalOps(),
                ],
            },
            {
                id: 2,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v4_1", emittedText: "local r_v4_1 = createClosure2(3, { upvalues[1] })", rhs: "createClosure2(3, { upvalues[1] })", reads: [] },
                    ...terminalOps(),
                ],
            },
            {
                id: 3,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v5_1", emittedText: "local r_v5_1 = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                    { kind: "version-define", emittedTarget: "r_v6_1", emittedText: "local r_v6_1 = r_v5_1 + 2", rhs: "r_v5_1 + 2", reads: ["r_v5_1"] },
                    { kind: "unsupported", emittedText: "upvalueValues[upvalues[1]] = r_v6_1", reads: ["r_v6_1"] },
                    ...terminalOps(),
                ],
            },
        ],
    },
});

assert.equal(relay.safe, true);
assert.equal(relay.applied, true);
assert.equal(relay.stats.recoveredCellCount, 1);
assert.equal(relay.stats.captureCount, 2);
const relayOuter = relay.graph.states.find(state => state.id === 2).operations;
const relayInner = relay.graph.states.find(state => state.id === 3).operations;
assert(relayOuter.some(op => op.rhs === "createClosure2(3, {})"));
assert(relayInner.some(op => op.rhs === "r_v2_1" && op.emittedTarget === "r_v5_1"));
assert(relayInner.some(op => op.emittedText === "r_v2_1 = r_v6_1"));

const liveInitializationTemporary = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "epoch-start", emittedTarget: "r_v1_1", emittedText: "local r_v1_1 = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                    { kind: "version-define", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = produce()", rhs: "produce()", reads: [] },
                    { kind: "unsupported", emittedText: "upvalueValues[r_v1_1] = r_v2_1", reads: ["r_v1_1", "r_v2_1"] },
                    { kind: "version-define", emittedTarget: "r_v7_1", emittedText: "local r_v7_1 = observe(r_v2_1)", rhs: "observe(r_v2_1)", reads: ["r_v2_1"] },
                    { kind: "version-define", emittedTarget: "r_v3_1", emittedText: "local r_v3_1 = createClosure2(2, { r_v1_1 })", rhs: "createClosure2(2, { r_v1_1 })", reads: ["r_v1_1"] },
                    ...terminalOps(),
                ],
            },
            {
                id: 2,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v4_1", emittedText: "local r_v4_1 = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                    { kind: "unsupported", emittedText: "upvalueValues[upvalues[1]] = 9", reads: [] },
                    ...terminalOps(),
                ],
            },
        ],
    },
});
assert.equal(liveInitializationTemporary.safe, true);
const liveCell = liveInitializationTemporary.cells[0];
assert.equal(liveCell.bindingMode, "cell-register-binding");
assert.equal(liveCell.bindingName, "r_v1_1");
const liveRoot = liveInitializationTemporary.graph.states.find(state => state.id === 1).operations;
const liveChild = liveInitializationTemporary.graph.states.find(state => state.id === 2).operations;
assert(liveRoot.some(op => op.emittedText === "local r_v1_1 = r_v2_1"));
assert(liveRoot.some(op => op.rhs === "observe(r_v2_1)"));
assert(liveChild.some(op => op.emittedText === "r_v1_1 = 9"));

const escaped = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            {
                id: 1,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "epoch-start", emittedTarget: "r_v1_1", emittedText: "local r_v1_1 = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                    { kind: "version-define", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = 1", rhs: "1", reads: [] },
                    { kind: "unsupported", emittedText: "upvalueValues[r_v1_1] = r_v2_1", reads: ["r_v1_1", "r_v2_1"] },
                    { kind: "statement", emittedText: "consume(r_v1_1)", originalText: "consume(r_v1_1)", reads: ["r_v1_1"] },
                    { kind: "version-define", emittedTarget: "r_v3_1", emittedText: "local r_v3_1 = createClosure2(2, { r_v1_1 })", rhs: "createClosure2(2, { r_v1_1 })", reads: ["r_v1_1"] },
                    ...terminalOps(),
                ],
            },
            { id: 2, predecessors: [], successors: [], operations: [...terminalOps()] },
        ],
    },
});
assert.equal(escaped.safe, false);
assert(escaped.reason.includes("escapes recognized upvalue machinery"));

console.log("beta upvalue recovery tests passed");
