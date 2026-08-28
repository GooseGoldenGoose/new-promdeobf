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
assert.match(liveCell.bindingName, /^u_v\d+$/);
const liveRoot = liveInitializationTemporary.graph.states.find(state => state.id === 1).operations;
const liveChild = liveInitializationTemporary.graph.states.find(state => state.id === 2).operations;
assert(liveRoot.some(op => op.emittedText === `local ${liveCell.bindingName} = r_v2_1`));
assert(liveRoot.some(op => op.rhs === "observe(r_v2_1)"));
assert(liveChild.some(op => op.emittedText === `${liveCell.bindingName} = 9`));

const captureBeforeInitialization = recoverBetaUpvalues({
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
                    { kind: "version-define", emittedTarget: "r_v2_1", emittedText: "local r_v2_1 = createClosure2(2, { r_v1_1 })", rhs: "createClosure2(2, { r_v1_1 })", reads: ["r_v1_1"] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["r_v2_1"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { r_v2_1 }", rhs: "{ r_v2_1 }", reads: ["r_v2_1"] },
                    { kind: "unsupported", emittedText: "upvalueValues[r_v1_1] = args[1]", reads: ["r_v1_1"] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
            {
                id: 2,
                predecessors: [],
                successors: [],
                operations: [
                    { kind: "version-define", emittedTarget: "r_v3_1", emittedText: "local r_v3_1 = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["r_v3_1"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { r_v3_1 }", rhs: "{ r_v3_1 }", reads: ["r_v3_1"] },
                    { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
                ],
            },
        ],
    },
});
assert.equal(captureBeforeInitialization.safe, true);
assert.equal(captureBeforeInitialization.applied, true);
const captureBeforeRoot = captureBeforeInitialization.graph.states.find(state => state.id === 1).operations;
const captureBeforeCell = captureBeforeInitialization.cells[0];
assert.equal(captureBeforeCell.bindingMode, "hoisted-cell-binding");
assert.match(captureBeforeCell.bindingName, /^u_v\d+$/);
assert.equal(captureBeforeRoot[0].emittedText, `local ${captureBeforeCell.bindingName}`);
assert(captureBeforeRoot.some(op => op.emittedText === `${captureBeforeCell.bindingName} = args[1]`));
assert(captureBeforeRoot.some(op => op.rhs === "createClosure2(2, {})"));


const dominatedMultiStateCell = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 5],
        states: [
            { id: 1, predecessors: [], successors: [2], operations: [
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 2", rhs: "2", reads: [] },
            ] },
            { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = cond and 3 or 4", rhs: "cond and 3 or 4", reads: ["cond"] },
            ] },
            { id: 3, predecessors: [2], successors: [2], operations: [
                { kind: "epoch-start", emittedTarget: "cell", emittedText: "local cell = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "version-define", emittedTarget: "closure", emittedText: "local closure = createClosure2(5, { cell })", rhs: "createClosure2(5, { cell })", reads: ["cell"] },
                { kind: "unsupported", emittedText: "upvalueValues[cell] = current", reads: ["cell", "current"] },
                { kind: "epoch-mutate", emittedTarget: "cell", emittedText: "cell = releaseUpvalue(cell)", rhs: "releaseUpvalue(cell)", reads: ["cell"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = 2", rhs: "2", reads: [] },
            ] },
            { id: 4, predecessors: [2], successors: [], operations: [...terminalOps()] },
            { id: 5, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "captured", emittedText: "local captured = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["captured"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { captured }", rhs: "{ captured }", reads: ["captured"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(dominatedMultiStateCell.safe, true);
assert.equal(dominatedMultiStateCell.applied, true);
const dominatedCell = dominatedMultiStateCell.cells[0];
assert.equal(dominatedCell.bindingMode, "hoisted-cell-binding");
assert.match(dominatedCell.bindingName, /^u_v\d+$/);
const dominatedBody = dominatedMultiStateCell.graph.states.find(state => state.id === 3).operations;
assert(dominatedBody.some(op => op.emittedText === `local ${dominatedCell.bindingName}`));
assert(dominatedBody.some(op => op.emittedText === `${dominatedCell.bindingName} = current`));
assert(dominatedBody.some(op => op.rhs === "createClosure2(5, {})"));
assert(!dominatedBody.some(op => String(op.emittedText || "").includes("releaseUpvalue")));

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

const forInCellAlias = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [101, 205],
        states: [
            { id: 101, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "loopValue", emittedText: "local loopValue = current()", rhs: "current()", reads: [] },
                { kind: "version-define", emittedTarget: "cellTemp", emittedText: "local cellTemp = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[cellTemp] = loopValue", reads: ["cellTemp", "loopValue"] },
                { kind: "epoch-start", emittedTarget: "loopCell", emittedText: "local loopCell = cellTemp", rhs: "cellTemp", reads: ["cellTemp"] },
                { kind: "version-define", emittedTarget: "closure", emittedText: "local closure = createClosure2(205, { loopCell })", rhs: "createClosure2(205, { loopCell })", reads: ["loopCell"] },
                { kind: "version-define", emittedTarget: "seen", emittedText: "local seen = upvalueValues[loopCell]", rhs: "upvalueValues[loopCell]", reads: ["loopCell"] },
                { kind: "epoch-start", emittedTarget: "deadRelease", emittedText: "local deadRelease = releaseUpvalue(loopCell)", rhs: "releaseUpvalue(loopCell)", reads: ["loopCell"] },
                ...terminalOps(),
            ] },
            { id: 205, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "captured", emittedText: "local captured = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["captured"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { captured }", rhs: "{ captured }", reads: ["captured"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(forInCellAlias.safe, true);
assert.equal(forInCellAlias.applied, true);
assert.equal(forInCellAlias.stats.recoveredCellCount, 1);
assert.equal(forInCellAlias.stats.captureCount, 1);
assert.equal(forInCellAlias.stats.releaseRemovalCount, 1);
const forInAliasRoot = forInCellAlias.graph.states.find(state => state.id === 101).operations;
const forInAliasChild = forInCellAlias.graph.states.find(state => state.id === 205).operations;
assert(!forInAliasRoot.some(op => op.emittedTarget === "loopCell"));
assert(!forInAliasRoot.some(op => String(op.emittedText || "").includes("releaseUpvalue")));
assert(!forInAliasRoot.some(op => op.emittedTarget === "deadRelease"));
assert(forInAliasRoot.some(op => op.rhs === "createClosure2(205, {})"));
assert(forInAliasRoot.some(op => op.emittedTarget === "seen" && op.rhs === "loopValue"));
assert(forInAliasChild.some(op => op.emittedTarget === "captured" && op.rhs === "loopValue"));
assert(forInCellAlias.graph.recoveredUpvalueBindings.includes("loopValue"));


const compoundCapturedWrite = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "epoch-start", emittedTarget: "cell", emittedText: "local cell = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[cell] = 0", reads: ["cell"] },
                { kind: "version-define", emittedTarget: "delta", emittedText: "local delta = 1", rhs: "1", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[cell] += delta", reads: ["cell", "delta"] },
                { kind: "version-define", emittedTarget: "closure", emittedText: "local closure = createClosure2(2, { cell })", rhs: "createClosure2(2, { cell })", reads: ["cell"] },
                { kind: "epoch-mutate", emittedTarget: "cell", emittedText: "cell = releaseUpvalue(cell)", rhs: "releaseUpvalue(cell)", reads: ["cell"] },
                ...terminalOps(),
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "captured", emittedText: "local captured = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: ["captured"], emittedTarget: "ReturnVal", emittedText: "ReturnVal = { captured }", rhs: "{ captured }", reads: ["captured"] },
                { kind: "state-transition", emittedTarget: "state", emittedText: "state = nil", rhs: "nil", reads: [] },
            ] },
        ],
    },
});
assert.equal(compoundCapturedWrite.safe, true);
assert.equal(compoundCapturedWrite.applied, true);
assert.equal(compoundCapturedWrite.stats.writeRewriteCount, 1);
const compoundCapturedRoot = compoundCapturedWrite.graph.states.find(state => state.id === 1).operations;
const compoundCapturedChild = compoundCapturedWrite.graph.states.find(state => state.id === 2).operations;
const compoundBinding = compoundCapturedWrite.cells[0].bindingName;
assert.match(compoundBinding, /^u_v\d+$/);
assert(compoundCapturedRoot.some(op => op.emittedText === `${compoundBinding} += delta` && op.reads.includes(compoundBinding)));
assert(compoundCapturedRoot.some(op => op.rhs === "createClosure2(2, {})"));
assert(!compoundCapturedRoot.some(op => String(op.emittedText || "").includes("releaseUpvalue")));
assert(compoundCapturedChild.some(op => op.emittedTarget === "captured" && op.rhs === compoundBinding));

const effectWriteCapturedRead = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "epoch-start", emittedTarget: "cell", emittedText: "local cell = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "version-define", emittedTarget: "value", emittedText: "local value = 42", rhs: "42", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[cell] = value", reads: ["cell", "value"] },
                { kind: "version-define", emittedTarget: "closure", emittedText: "local closure = createClosure2(2, { cell })", rhs: "createClosure2(2, { cell })", reads: ["cell"] },
                { kind: "effect-write", emittedText: "RegisterOverflow[3] = upvalueValues[cell]", reads: ["cell"] },
                { kind: "epoch-mutate", emittedTarget: "cell", emittedText: "cell = releaseUpvalue(cell)", rhs: "releaseUpvalue(cell)", reads: ["cell"] },
                ...terminalOps(),
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "captured", emittedText: "local captured = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                ...terminalOps(),
            ] },
        ],
    },
});
assert.equal(effectWriteCapturedRead.safe, true);
assert.equal(effectWriteCapturedRead.applied, true);
const effectWriteCapturedRoot = effectWriteCapturedRead.graph.states.find(state => state.id === 1).operations;
assert(effectWriteCapturedRoot.some(op => op.emittedText === "RegisterOverflow[3] = value" && op.reads.includes("value")));
assert(!effectWriteCapturedRoot.some(op => String(op.emittedText || "").includes("upvalueValues[")));
const overflowCellReuse = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2, 3],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "effect-write", emittedText: "RegisterOverflow[3] = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "version-define", emittedTarget: "value", emittedText: "local value = 7", rhs: "7", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[RegisterOverflow[3]] = value", reads: ["value"] },
                { kind: "version-define", emittedTarget: "closureA", emittedText: "local closureA = createClosure2(2, { RegisterOverflow[3] })", rhs: "createClosure2(2, { RegisterOverflow[3] })", reads: [] },
                { kind: "effect-write", emittedText: "RegisterOverflow[3] = releaseUpvalue(RegisterOverflow[3])", rhs: "releaseUpvalue(RegisterOverflow[3])", reads: [] },
                { kind: "effect-write", emittedText: "RegisterOverflow[3] = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "version-define", emittedTarget: "other", emittedText: "local other = 9", rhs: "9", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[RegisterOverflow[3]] = other", reads: ["other"] },
                { kind: "version-define", emittedTarget: "closureB", emittedText: "local closureB = createClosure2(3, { RegisterOverflow[3] })", rhs: "createClosure2(3, { RegisterOverflow[3] })", reads: [] },
                { kind: "effect-write", emittedText: "RegisterOverflow[3] = releaseUpvalue(RegisterOverflow[3])", rhs: "releaseUpvalue(RegisterOverflow[3])", reads: [] },
                ...terminalOps(),
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "capturedA", emittedText: "local capturedA = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                ...terminalOps(),
            ] },
            { id: 3, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "capturedB", emittedText: "local capturedB = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                ...terminalOps(),
            ] },
        ],
    },
});
assert.equal(overflowCellReuse.safe, true);
assert.equal(overflowCellReuse.applied, true);
assert.equal(overflowCellReuse.stats.recoveredCellCount, 2);
assert.equal(overflowCellReuse.stats.captureCount, 2);
assert.equal(overflowCellReuse.stats.releaseRemovalCount, 2);
assert.equal(new Set(overflowCellReuse.cells.map(cell => cell.id)).size, 2);
assert.deepEqual(overflowCellReuse.cells.map(cell => cell.bindingName), ["value", "other"]);
const overflowReuseRoot = overflowCellReuse.graph.states.find(state => state.id === 1).operations;
const overflowReuseChildA = overflowCellReuse.graph.states.find(state => state.id === 2).operations;
const overflowReuseChildB = overflowCellReuse.graph.states.find(state => state.id === 3).operations;
assert(overflowReuseRoot.some(op => op.rhs === "createClosure2(2, {})"));
assert(overflowReuseRoot.some(op => op.rhs === "createClosure2(3, {})"));
assert(overflowReuseChildA.some(op => op.emittedTarget === "capturedA" && op.rhs === "value"));
assert(overflowReuseChildB.some(op => op.emittedTarget === "capturedB" && op.rhs === "other"));
assert(!overflowReuseRoot.some(op => /allocUpvalue|releaseUpvalue|upvalueValues\[/.test(String(op.emittedText || ""))));


const residualPrivateRelease = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "epoch-start", emittedTarget: "cell", emittedText: "local cell = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "version-define", emittedTarget: "value", emittedText: "local value = 5", rhs: "5", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[cell] = value", reads: ["cell", "value"] },
                { kind: "version-define", emittedTarget: "closure", emittedText: "local closure = createClosure2(2, { cell })", rhs: "createClosure2(2, { cell })", reads: ["cell"] },
                { kind: "epoch-mutate", emittedTarget: "cellReleased", emittedText: "local cellReleased = releaseUpvalue(cell)", rhs: "releaseUpvalue(cell)", reads: ["cell"] },
                { kind: "epoch-start", emittedTarget: "privateId", emittedText: "local privateId = 6", rhs: "6", reads: [] },
                { kind: "epoch-start", emittedTarget: "privateRelease", emittedText: "local privateRelease = releaseUpvalue(privateId)", rhs: "releaseUpvalue(privateId)", reads: ["privateId"] },
                ...terminalOps(),
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "captured", emittedText: "local captured = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                ...terminalOps(),
            ] },
        ],
    },
});
assert.equal(residualPrivateRelease.safe, true);
assert.equal(residualPrivateRelease.applied, true);
assert.equal(residualPrivateRelease.stats.releaseRemovalCount, 2);
assert(!residualPrivateRelease.graph.states.some(state =>
    state.operations.some(op => String(op.emittedText || "").includes("releaseUpvalue("))
));

const liveResidualPrivateRelease = recoverBetaUpvalues({
    applied: true,
    graph: {
        cfgComplete: true,
        entries: [1, 2],
        states: [
            { id: 1, predecessors: [], successors: [], operations: [
                { kind: "epoch-start", emittedTarget: "cell", emittedText: "local cell = allocUpvalue()", rhs: "allocUpvalue()", reads: [] },
                { kind: "version-define", emittedTarget: "value", emittedText: "local value = 5", rhs: "5", reads: [] },
                { kind: "effect-write", emittedText: "upvalueValues[cell] = value", reads: ["cell", "value"] },
                { kind: "version-define", emittedTarget: "closure", emittedText: "local closure = createClosure2(2, { cell })", rhs: "createClosure2(2, { cell })", reads: ["cell"] },
                { kind: "epoch-mutate", emittedTarget: "cellReleased", emittedText: "local cellReleased = releaseUpvalue(cell)", rhs: "releaseUpvalue(cell)", reads: ["cell"] },
                { kind: "epoch-start", emittedTarget: "privateId", emittedText: "local privateId = 6", rhs: "6", reads: [] },
                { kind: "epoch-start", emittedTarget: "privateRelease", emittedText: "local privateRelease = releaseUpvalue(privateId)", rhs: "releaseUpvalue(privateId)", reads: ["privateId"] },
                { kind: "statement", emittedText: "consume(privateRelease)", reads: ["privateRelease"] },
                ...terminalOps(),
            ] },
            { id: 2, predecessors: [], successors: [], operations: [
                { kind: "version-define", emittedTarget: "captured", emittedText: "local captured = upvalueValues[upvalues[1]]", rhs: "upvalueValues[upvalues[1]]", reads: [] },
                ...terminalOps(),
            ] },
        ],
    },
});
assert.equal(liveResidualPrivateRelease.applied, false);
assert(liveResidualPrivateRelease.reason.includes("retains unresolved VM upvalue machinery"));

console.log("beta upvalue recovery tests passed");
