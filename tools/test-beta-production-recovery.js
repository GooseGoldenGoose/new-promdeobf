"use strict";
const assert = require("assert");
const { spawnSync } = require("child_process");
const { parseLuaStructural } = require("../main");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");
const { candidateLoopCarriedRegisters } = require("../passes/beta-cf/control/loop-storage");

function recover(states) {
    const source = `vm = function(state, args, upvalues, gcProxy)
local r1,r2,r3,r4,r5,r6,ReturnVal
while state do
${Object.entries(states).map(([id, body], i) => `${i ? "elseif" : "if"} state == ${id} then\n${body.join("\n")}`).join("\n")}
end
end
state = #gcProxy
return unpack(ReturnVal)
end`;
    const result = solveBetaControlFlow(source, parseLuaStructural(source));
    assert(result.applied, result.reason);
    parseLuaStructural(result.source);
    return result.source;
}
function run(source, expected, prelude = "") {
    const result = spawnSync("luajit.exe", ["-e", `${prelude}\nprint((function()\n${source}\nend)())`], {
        encoding: "utf8", timeout: 5000, windowsHide: true,
    });
    assert.strictEqual(result.status, 0, result.stderr || result.error?.message);
    assert.strictEqual(result.stdout.trim(), expected, source);
}

const recursive = recover({
    1: ["r1 = allocUpvalue()", "r2 = createClosure1(4, {r1})", "upvalueValues[r1] = r2", "r3 = upvalueValues[r1]", "r4 = 3", "r5 = r3(r4)", "r1 = releaseUpvalue(r1)", "ReturnVal = {r5}", "state = nil"],
    4: ["r1 = args[1]", "r2 = 0", "r3 = r1 <= r2", "state = r3 and 5 or 6"],
    5: ["ReturnVal = {0}", "state = nil"],
    6: ["r2 = upvalueValues[upvalues[1]]", "r3 = r1 - 1", "r4 = r2(r3)", "r5 = r4 + 1", "ReturnVal = {r5}", "state = nil"],
});
assert.match(recursive, /local (v\d+)\n\1 = function/);
run(recursive, "3");

const unused = recover({
    1: ['r1 = "values"', "r2 = _env[r1]", "r3 = {r2()}", "r4 = r3[2]", "r5 = r3[1]", "state = 2"],
    2: ["ReturnVal = {r4}", "r4 = nil", "r5 = nil", "state = nil"],
});
assert.match(unused, /local v\d+, v\d+ = values\(\)/);
run(unused, "42", "function values() return nil, 42 end");

const capturedMulti = recover({
    1: ['r1 = "values"', 'r2 = _env[r1]', 'r3 = {r2()}', 'r4 = r3[2]', 'r5 = r3[1]', 'r6 = allocUpvalue()', 'upvalueValues[r6] = r5', 'r2 = createClosure0(4, {r6})', 'r3 = r2()', 'ReturnVal = {r3, r4}', 'r4 = nil', 'r6 = releaseUpvalue(r6)', 'state = nil'],
    4: ['r1 = upvalueValues[upvalues[1]]', 'ReturnVal = {r1}', 'state = nil'],
});
assert.strictEqual((capturedMulti.match(/values\(\)/g) || []).length, 1);
run(capturedMulti, "11\t42", "function values() return 11, 42 end");

const expandedTable = recover({
    1: ['r1 = "values"', "r2 = _env[r1]", "r3 = {r2()}", "state = {9, unpack(r3)}", "r4 = state", "state = 2"],
    2: ["r5 = r4[2]", "r6 = r4[3]", "ReturnVal = {r5, r6}", "r4 = nil", "state = nil"],
});
assert.strictEqual((expandedTable.match(/values\(\)/g) || []).length, 1);
run(expandedTable, "11\t42", "function values() return 11, 42 end");

function terminalGeneric(body) {
    return recover({
        1: ['r1 = {1}', 'r2 = "ipairs"', 'r3 = _env[r2]', 'r4 = {r3(r1)}', 'r2 = r4[1]', 'r3 = r4[2]', 'r5 = r4[3]', 'state = 2'],
        2: ['r5, r4 = r2(r3, r5)', 'state = r5 and 3 or 4'],
        3: ['r6 = r5', ...body],
        4: ['r1 = nil', 'ReturnVal = {}', 'state = nil'],
    });
}
const breakLoop = terminalGeneric(['ReturnVal = "print"', 'state = _env[ReturnVal]', 'ReturnVal = state(r6, r4)', 'r6 = nil', 'r4 = nil', 'state = 4']);
assert.match(breakLoop, /for .* in ipairs\(/);
assert.match(breakLoop, /\bbreak\b/);
run(breakLoop, "1\t1");
const returnLoop = terminalGeneric(['ReturnVal = {r4}', 'r6 = nil', 'r4 = nil', 'state = nil']);
assert.match(returnLoop, /for .* in ipairs\(/);
run(returnLoop, "1");

// Forty reconverging diamonds represent over a trillion paths but only 120
// blocks. The incoming value is identical at joins; its reads must be queried
// once per block. Also exercise kill-before-read and a read after a cycle.
const assign = text => parseLuaStructural(text).body[0];
function diamondGraph(tail) {
    const blocks = new Map([
        [1, { body: [assign("r1 = nil")], transitionIndex: 1, transition: { kind: "jump", target: 2 } }],
        [2, { body: [], transitionIndex: 0, transition: { kind: "branch", conditionRegister: "r2", onTrue: 3, onFalse: 4 } }],
        [3, { body: [assign("r1 = 1")], transitionIndex: 1, transition: { kind: "jump", target: 2 } }],
    ]);
    let id = 4;
    for (let n = 0; n < 40; n++, id += 3) {
        blocks.set(id, { body: [], transitionIndex: 0, transition: { kind: "branch", conditionRegister: "r2", onTrue: id + 1, onFalse: id + 2 } });
        for (const arm of [id + 1, id + 2]) blocks.set(arm, { body: [], transitionIndex: 0, transition: { kind: "jump", target: id + 3 } });
    }
    blocks.set(id, { body: tail.map(assign), transitionIndex: tail.length, transition: { kind: "stop" } });
    return { blocks };
}
const matches = [{ preheaderId: 1, headerId: 2, coreIds: new Set([2, 3]) }];
assert(!candidateLoopCarriedRegisters(diamondGraph([]), matches).registers.has("r1"));
assert(candidateLoopCarriedRegisters(diamondGraph(["r3 = r1"]), matches).registers.has("r1"));
assert(!candidateLoopCarriedRegisters(diamondGraph(["r1 = 2", "r3 = r1"]), matches).registers.has("r1"));
console.log("production recovery regressions passed");
