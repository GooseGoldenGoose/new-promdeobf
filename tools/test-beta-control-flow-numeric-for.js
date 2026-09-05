"use strict";

const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parse(source) {
    return luaparse.parse(source, { luaVersion: "luau", ranges: true });
}

function vmStatesSource(states, registers = "r1, r2, r3, r4, r5, r6, r7") {
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

function numericForBase(start, final, step) {
    return {
        1: [
            `r7 = ${final}`,
            "r2 = r7",
            `r7 = ${step}`,
            "r1 = r7",
            "r7 = 0",
            "r3 = r1 < r7",
            `ReturnVal = ${start}`,
            "r7 = ReturnVal - r1",
            "r4 = args",
            "state = 2",
        ],
        2: [
            "r5 = not r3",
            "r7 = r7 + r1",
            "ReturnVal = r7 <= r2",
            "ReturnVal = r5 and ReturnVal",
            "r5 = r7 >= r2",
            "r5 = r3 and r5",
            "ReturnVal = r5 or ReturnVal",
            "r5 = 3",
            "state = ReturnVal and r5",
            "ReturnVal = 4",
            "state = state or ReturnVal",
        ],
        3: [
            "r5 = r7",
            'ReturnVal = "print"',
            "state = _env[ReturnVal]",
            "ReturnVal = state(r5)",
            "r5 = nil",
            "state = 2",
        ],
        4: ["ReturnVal = {}", "state = nil"],
    };
}

{
    // Explicit step 1 and omitted step compile to the same Prometheus VM
    // pattern. Fresh CF therefore canonicalizes the proven step-1 loop to the
    // normal two-bound source form.
    const source = vmStatesSource(numericForBase(1, 10, 1));
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-numeric-for");
    assert.strictEqual(result.numericForLoopCount, 1);
    assert.strictEqual(result.stateCount, 4);
    assert.strictEqual(result.source,
        "for v1 = 1, 10 do\n" +
        "    print(v1)\n" +
        "end\n");
}

{
    // Negative step uses the same compiler sign flag but must retain the
    // recovered negative increment in the source header.
    const source = vmStatesSource(numericForBase(10, 1, -1));
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-numeric-for");
    assert.strictEqual(result.numericForLoopCount, 1);
    assert.strictEqual(result.source,
        "for v1 = 10, 1, -1 do\n" +
        "    print(v1)\n" +
        "end\n");
}

{
    // Non-unit increments are recovered from the compiler's persistent step
    // register rather than hardcoded around +/-1.
    const source = vmStatesSource(numericForBase(1, 7, 2));
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-numeric-for");
    assert.strictEqual(result.source,
        "for v1 = 1, 7, 2 do\n" +
        "    print(v1)\n" +
        "end\n");
}

{
    // Continue is another proven body->numeric-check backedge. The loop tail
    // continue is omitted as fallthrough while the branch-local continue stays.
    const states = numericForBase(1, 6, 1);
    states[3] = [
        "r5 = r7",
        "ReturnVal = 3",
        "state = r5 == ReturnVal",
        "state = state and 5 or 6",
    ];
    states[5] = ["r5 = nil", "state = 2"];
    states[6] = [
        'ReturnVal = "print"',
        "state = _env[ReturnVal]",
        "ReturnVal = state(r5)",
        "r5 = nil",
        "state = 2",
    ];
    const source = vmStatesSource(states);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-numeric-for");
    assert.strictEqual(result.source,
        "for v1 = 1, 6 do\n" +
        "    if (v1 == 3) then\n" +
        "        continue\n" +
        "    end\n" +
        "    print(v1)\n" +
        "end\n");
}

{
    // Break is accepted only through the compiler cleanup/jump region to the
    // numeric-for final block, using the same abrupt-region proof as while.
    const states = numericForBase(1, 10, 1);
    states[3] = [
        "r5 = r7",
        "ReturnVal = 4",
        "state = r5 == ReturnVal",
        "state = state and 5 or 6",
    ];
    states[5] = ["r5 = nil", "state = 4"];
    states[6] = [
        'ReturnVal = "print"',
        "state = _env[ReturnVal]",
        "ReturnVal = state(r5)",
        "r5 = nil",
        "state = 2",
    ];
    const source = vmStatesSource(states);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-numeric-for");
    assert.strictEqual(result.source,
        "for v1 = 1, 10 do\n" +
        "    if (v1 == 4) then\n" +
        "        break\n" +
        "    end\n" +
        "    print(v1)\n" +
        "end\n");
}

console.log("beta control-flow numeric-for tests passed");
