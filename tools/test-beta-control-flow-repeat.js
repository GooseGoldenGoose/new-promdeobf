"use strict";

const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parse(source) {
    return luaparse.parse(source, { luaVersion: "luau", ranges: true });
}

function vmStatesSource(states, registers = "r1, r2, r3, r4, r5, r6, r7, r8, r9") {
    const lines = [
        "vm = function(state, args, upvalues, gcProxy)",
        `    local ${registers}, ReturnVal`,
        "    while state do",
    ];
    const ids = Object.keys(states).map(Number).sort((a, b) => a - b);
    ids.forEach((id, index) => {
        lines.push(`        ${index === 0 ? "if" : "elseif"} state == ${id} then`);
        for (const line of states[id]) lines.push(`            ${line}`);
    });
    lines.push(
        "        end",
        "    end",
        "    state = #gcProxy",
        "    return unpack(ReturnVal)",
        "end",
    );
    return lines.join("\n");
}

{
    // Prometheus RepeatStatement evaluates the condition once before the body
    // and again at the real bottom test. Fresh CF must remove only the proven
    // compiler duplicate while preserving the loop-carried source binding.
    const source = vmStatesSource({
        1: ["state = 0", "r2 = state", "ReturnVal = 3", "state = r2 >= ReturnVal", "r1 = args", "state = 2"],
        2: ['ReturnVal = "print"', "state = _env[ReturnVal]", "ReturnVal = state(r2)", "ReturnVal = 1", "state = r2 + ReturnVal", "r2 = state", "state = 3"],
        3: ["r4 = 3", "ReturnVal = r2 >= r4", "state = ReturnVal and (4) or (2)"],
        4: ['r4 = "print"', "ReturnVal = _env[r4]", 'r3 = "DONE"', "r4 = ReturnVal(r3, r2)", "r2 = nil", "ReturnVal = {}", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-repeat");
    assert.strictEqual(result.loopCount, 1);
    assert.strictEqual(result.repeatLoopCount, 1);
    assert.ok(result.removedCompilerConditionStatementCount > 0);
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "repeat\n" +
        "    print(v1)\n" +
        "    v1 = (v1 + 1)\n" +
        "until (v1 >= 3)\n" +
        'print("DONE", v1)\n');
}

{
    // A side exit is source break only when it is the compiler cleanup/jump
    // region to the same repeat final. Ordinary side exits remain fail-closed.
    const source = vmStatesSource({
        1: ["state = 0", "r2 = state", "ReturnVal = 5", "state = r2 >= ReturnVal", "r4 = args", "state = 2"],
        2: ["ReturnVal = 1", "state = r2 + ReturnVal", "r2 = state", "r1 = 2", "ReturnVal = r2 == r1", "state = ReturnVal and (3) or (4)"],
        3: ["state = 5"],
        4: ['r1 = "print"', "ReturnVal = _env[r1]", 'r3 = "BODY"', "r1 = ReturnVal(r3, r2)", "state = 6"],
        5: ['r1 = "print"', "ReturnVal = _env[r1]", 'r3 = "DONE"', "r1 = ReturnVal(r3, r2)", "r2 = nil", "ReturnVal = {}", "state = nil"],
        6: ["r1 = 5", "ReturnVal = r2 >= r1", "state = ReturnVal and (5) or (2)"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-repeat");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "repeat\n" +
        "    v1 = (v1 + 1)\n" +
        "    if (v1 == 2) then\n" +
        "        break\n" +
        "    else\n" +
        '        print("BODY", v1)\n' +
        "    end\n" +
        "until (v1 >= 5)\n" +
        'print("DONE", v1)\n');
}

{
    // Nested short-circuit repeat conditions contain dispatcher POS save/restore
    // transport at multiple logical depths. It must be ignored only when every
    // CFG path proves an exclusive state round-trip for that TEMP.
    const source = vmStatesSource({
        1: ["state = 0", "r6 = state", "state = 0", "r1 = 3", "r7 = r6 >= r1", "r2 = state", "r8 = state", "state = r7 and (2) or (3)", "r3 = args", "r4 = r7"],
        2: ["r1 = 6", "r7 = r2 >= r1", "r4 = r7", "state = 3"],
        3: ["state = r8", "state = r4 and (4) or (5)", "ReturnVal = r4"],
        4: ["state = 6"],
        5: ["r8 = 99", "r4 = r6 == r8", "ReturnVal = r4", "state = 4"],
        6: ["ReturnVal = 1", "state = r6 + ReturnVal", "r6 = state", "r4 = 2", "ReturnVal = r2 + r4", "r2 = ReturnVal", "state = 7"],
        7: ["r5 = 3", "r9 = r6 >= r5", "r8 = state", "r1 = state", "state = r9 and (8) or (9)", "r7 = r9"],
        8: ["r5 = 6", "r9 = r2 >= r5", "r7 = r9", "state = 9"],
        9: ["state = r1", "state = r7 and (10) or (11)", "r4 = r7"],
        10: ["state = r8", "state = r4 and (12) or (6)"],
        11: ["r1 = 99", "r7 = r6 == r1", "r4 = r7", "state = 10"],
        12: ["ReturnVal = {}", 'r8 = "print"', "r4 = _env[r8]", 'r7 = "DONE"', "r8 = r4(r7, r6, r2)", "r6 = nil", "r2 = nil", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-repeat");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "local v2 = 0\n" +
        "repeat\n" +
        "    v1 = (v1 + 1)\n" +
        "    v2 = (v2 + 2)\n" +
        "until (((v1 >= 3) and (v2 >= 6)) or (v1 == 99))\n" +
        'print("DONE", v1, v2)\n');
}

{
    // Natural loops are classified and collapsed inner-first, so nested repeat
    // bodies reuse the same structured statement engine rather than a nested
    // repeat-specific solver.
    const source = vmStatesSource({
        1: ["state = 0", "r4 = state", "ReturnVal = 2", "state = r4 >= ReturnVal", "r1 = args", "state = 2"],
        2: ["ReturnVal = 1", "state = r4 + ReturnVal", "r4 = state", "ReturnVal = 0", "r6 = ReturnVal", "r2 = 2", "ReturnVal = r6 >= r2", "state = 3"],
        3: ["r2 = 1", "ReturnVal = r6 + r2", "r6 = ReturnVal", 'r5 = "print"', "r2 = _env[r5]", 'r3 = "INNER"', "r5 = r2(r3, r4, r6)", "state = 4"],
        4: ["r5 = 2", "r2 = r6 >= r5", "state = r2 and (5) or (3)"],
        5: ["r6 = nil", "state = 6"],
        6: ["r2 = 2", "r6 = r4 >= r2", "state = r6 and (7) or (2)"],
        7: ["ReturnVal = {}", 'r2 = "print"', "r6 = _env[r2]", 'r5 = "DONE"', "r2 = r6(r5, r4)", "r4 = nil", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-repeat");
    assert.strictEqual(result.loopCount, 2);
    assert.strictEqual(result.repeatLoopCount, 2);
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "repeat\n" +
        "    v1 = (v1 + 1)\n" +
        "    local v2 = 0\n" +
        "    repeat\n" +
        "        v2 = (v2 + 1)\n" +
        '        print("INNER", v1, v2)\n' +
        "    until (v2 >= 2)\n" +
        "until (v1 >= 2)\n" +
        'print("DONE", v1)\n');
}

console.log("beta control-flow repeat tests passed");