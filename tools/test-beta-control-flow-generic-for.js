"use strict";

const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parse(source) {
    return luaparse.parse(source, { luaVersion: "luau", ranges: true });
}

function vmStatesSource(states, registers = "r1, r2, r3, r4, r5, r6, r7, r8, r9, r10") {
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

function ipairsBase() {
    return {
        1: [
            "r1 = 1",
            "r2 = { r1 }",
            'r3 = "ipairs"',
            "r4 = _env[r3]",
            "r5 = { r4(r2) }",
            "r6 = r5[1]",
            "r7 = r5[2]",
            "r8 = r5[3]",
            "state = 2",
        ],
        2: [
            "r8, r9 = r6(r7, r8)",
            "state = r8 and 3 or 4",
        ],
        3: [
            "r10 = r8",
            'r1 = "print"',
            "r2 = _env[r1]",
            "r1 = r2(r10, r9)",
            "r9 = nil",
            "r10 = nil",
            "state = 2",
        ],
        4: ["ReturnVal = {}", "state = nil"],
    };
}

{
    const source = vmStatesSource(ipairsBase());
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-generic-for");
    assert.strictEqual(result.genericForLoopCount, 1);
    assert.strictEqual(result.stateCount, 4);
    assert.strictEqual(result.source,
        "for v1, v2 in ipairs({ 1 }) do\n" +
        "    print(v1, v2)\n" +
        "end\n");
}

{
    // The compiler can schedule the first loop-variable handoff after the
    // state's branch assignment inside the same dispatcher leaf. It is still
    // executed before the next dispatcher iteration and must bind the body.
    const states = ipairsBase();
    states[3] = [
        "r1 = 1",
        "state = r9 == r1",
        "state = state and 5 or 6",
        "r10 = r8",
    ];
    states[5] = [
        'r1 = "print"',
        "r2 = _env[r1]",
        'r1 = r2("one", r10, r9)',
        "state = 7",
    ];
    states[6] = [
        'r1 = "print"',
        "r2 = _env[r1]",
        'r1 = r2("other", r10, r9)',
        "state = 7",
    ];
    states[7] = ["r9 = nil", "r10 = nil", "state = 2"];
    const source = vmStatesSource(states);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-generic-for");
    assert.strictEqual(result.source,
        "for v1, v2 in ipairs({ 1 }) do\n" +
        "    if (v2 == 1) then\n" +
        "        print(\"one\", v1, v2)\n" +
        "    else\n" +
        "        print(\"other\", v1, v2)\n" +
        "    end\n" +
        "end\n");
}

{
    // Break reuses the same closed compiler cleanup/jump proof as the other
    // structured loops; only a proven route to the generic-for final block is
    // accepted as source break.
    const states = ipairsBase();
    states[3] = [
        "r10 = r8",
        "r1 = 2",
        "state = r10 == r1",
        "state = state and 5 or 6",
    ];
    states[5] = ["r9 = nil", "r10 = nil", "state = 4"];
    states[6] = [
        'r1 = "print"',
        "r2 = _env[r1]",
        "r1 = r2(r10, r9)",
        "r9 = nil",
        "r10 = nil",
        "state = 2",
    ];
    const source = vmStatesSource(states);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-generic-for");
    assert.strictEqual(result.source,
        "for v1, v2 in ipairs({ 1 }) do\n" +
        "    if (v1 == 2) then\n" +
        "        break\n" +
        "    end\n" +
        "    print(v1, v2)\n" +
        "end\n");
}

{
    // Prometheus only assigns the first two generic-for variables from the
    // iterator call. Variables 3+ are injected as body-entry nil writes, a
    // shape that is ambiguous with a real body-local nil declaration. Fresh CF
    // therefore fails closed instead of guessing a three-variable header.
    const source = vmStatesSource({
        1: [
            'ReturnVal = "ipairs"',
            "state = _env[ReturnVal]",
            "r1 = 2",
            "r5 = 3",
            "r3 = 1",
            "r2 = { r3, r1, r5 }",
            "r3 = { state(r2) }",
            "ReturnVal = r3[1]",
            "r2 = ReturnVal",
            "r6 = args",
            "r8 = r3[3]",
            "r7 = r3[2]",
            "state = 2",
        ],
        2: ["r8, r1 = r2(r7, r8)", "state = r8 and 3 or 4"],
        3: [
            "r3 = r8",
            "r5 = nil",
            'r4 = "print"',
            "state = _env[r4]",
            "r4 = state(r3, r1, r5)",
            "r3 = nil",
            "r5 = nil",
            "r1 = nil",
            "state = 2",
        ],
        4: ["ReturnVal = {}", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false);
}

{
    // allocUpvalue may borrow the dispatcher state register before the compiler
    // copies the cell handle into the loop-variable register. The alloc/init/
    // handoff/capture/release chain still proves the captured generic-for epoch.
    const source = vmStatesSource({
        1: [
            'ReturnVal = "ipairs"',
            'state = _env[ReturnVal]',
            'r8 = 3',
            'r9 = 5',
            'r10 = 8',
            'r4 = { r8, r9, r10 }',
            'r4 = { state(r4) }',
            'r1 = r4[1]',
            'r2 = r4[2]',
            'r3 = r4[3]',
            'state = 2',
        ],
        2: ['r3, r10 = r1(r2, r3)', 'state = r3 and 3 or 4'],
        3: [
            'r8 = r3',
            'state = allocUpvalue()',
            'upvalueValues[state] = r8',
            'r8 = state',
            'state = allocUpvalue()',
            'upvalueValues[state] = r10',
            'r10 = state',
            'state = createClosure5(8, { r8, r10 })',
            'r9 = state',
            'state = 5',
        ],
        4: ['ReturnVal = {}', 'state = nil'],
        5: [
            'ReturnVal = "print"',
            'state = _env[ReturnVal]',
            'r5 = { r9() }',
            'r6 = "borrowed-cell"',
            'r7 = state(r6, unpack(r5))',
            'state = 7',
        ],
        7: ['r8 = releaseUpvalue(r8)', 'r9 = nil', 'r10 = releaseUpvalue(r10)', 'state = 2'],
        8: [
            'ReturnVal = upvalueValues[upvalues[1]]',
            'r4 = upvalueValues[upvalues[2]]',
            'state = ReturnVal + r4',
            'ReturnVal = { state }',
            'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "generic-for capture with borrowed state cell carrier was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        'for v1, v2 in ipairs({ 3, 5, 8 }) do\n' +
        '    local v3 = function()\n' +
        '        return (v1 + v2)\n' +
        '    end\n' +
        '    print("borrowed-cell", v3())\n' +
        'end\n');
}

{
    // A generic-for header may consume a compiler RETURN_ALL pack from an
    // earlier call. Loop canonicalization wraps the header in
    // FreshGenericForExpression; the proven pack source must survive that
    // wrapper so unpack(pack) remains the original multi-return call.
    const source = vmStatesSource({
        1: [
            'r1 = "getItems"',
            'r2 = _env[r1]',
            'r3 = { r2() }',
            'r4 = "ipairs"',
            'r5 = _env[r4]',
            'r6 = { r5(unpack(r3)) }',
            'r1 = r6[1]',
            'r2 = r6[2]',
            'r3 = r6[3]',
            'state = 2',
        ],
        2: ['r3, r4 = r1(r2, r3)', 'state = r3 and 3 or 4'],
        3: [
            'r5 = r3',
            'r6 = "print"',
            'r7 = _env[r6]',
            'r6 = r7(r5, r4)',
            'r4 = nil',
            'r5 = nil',
            'state = 2',
        ],
        4: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "RETURN_ALL pack through synthetic generic-for header was rejected");
    assert.strictEqual(result.mode, "fresh-generic-for");
    assert.strictEqual(result.source,
        'for v1, v2 in ipairs(getItems()) do\n' +
        '    print(v1, v2)\n' +
        'end\n');
}
console.log("beta control-flow generic-for tests passed");
