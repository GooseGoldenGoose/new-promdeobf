const assert = require("assert");
const { parseLua } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

const ast = parseLua("return 1", "<step17-wrapper>");

function makeGraph(kind, extraUse = false) {
    const isBreak = kind === "break";
    const controlTarget = isBreak ? 5 : 2;
    const otherTarget = 4;
    const condName = isBreak ? "breakCond" : "continueCond";
    const condCall = isBreak ? "shouldBreak()" : "shouldContinue()";
    const bodyOps = [
        { kind: "version-define", emittedTarget: condName, rhs: condCall, emittedText: `local ${condName} = ${condCall}`, reads: [] },
    ];
    if (extraUse) bodyOps.push({ kind: "statement", emittedText: `observe(${condName})`, originalText: `observe(${condName})`, reads: [condName] });
    bodyOps.push({ kind: "state-transition", emittedTarget: "state", rhs: `${condName} and ${controlTarget} or ${otherTarget}`, emittedText: `state = ${condName} and ${controlTarget} or ${otherTarget}`, reads: [condName] });
    return {
        applied: true,
        graph: {
            cfgComplete: true, stateName: "state", entries: [1],
            states: [
                { id: 1, predecessors: [], successors: [2], operations: [{ kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] }] },
                { id: 2, predecessors: isBreak ? [1,4] : [1,3,4], successors: [3,5], operations: [
                    { kind: "version-define", emittedTarget: "loopCond", rhs: "looping()", emittedText: "local loopCond = looping()", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", rhs: "loopCond and 3 or 5", emittedText: "state = loopCond and 3 or 5", reads: ["loopCond"] },
                ] },
                { id: 3, predecessors: [2], successors: [controlTarget, otherTarget], operations: bodyOps },
                { id: 4, predecessors: [3], successors: [2], operations: [
                    { kind: "statement", emittedText: "work()", originalText: "work()", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", rhs: "2", emittedText: "state = 2", reads: [] },
                ] },
                { id: 5, predecessors: isBreak ? [2,3] : [2], successors: [], operations: [
                    { kind: "return-payload", terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: "ReturnVal = {}", rhs: "{}", reads: [] },
                    { kind: "state-transition", emittedTarget: "state", rhs: "nil", emittedText: "state = nil", reads: [] },
                ] },
            ],
        },
    };
}

const breakResult = solveBetaControlFlow(ast, makeGraph("break"));
assert.equal(breakResult.applied, true);
assert(breakResult.source.includes("if (shouldBreak()) then"));
assert(breakResult.source.includes("break"));
assert(!breakResult.source.includes("local breakCond = shouldBreak()"));

const continueResult = solveBetaControlFlow(ast, makeGraph("continue"));
assert.equal(continueResult.applied, true);
assert(continueResult.source.includes("if (shouldContinue()) then"));
assert(continueResult.source.includes("continue"));
assert(!continueResult.source.includes("local continueCond = shouldContinue()"));

const extraUse = solveBetaControlFlow(ast, makeGraph("break", true));
assert.equal(extraUse.applied, true);
assert(extraUse.source.includes("local breakCond = shouldBreak()"));
assert(extraUse.source.includes("observe(breakCond)"));
assert(extraUse.source.includes("if breakCond then"));

console.log("beta CF loop-control temps: PASS");
