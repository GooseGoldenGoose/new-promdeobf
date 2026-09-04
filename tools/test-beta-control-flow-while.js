const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parse(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        ranges: true,
    });
}

function vmStatesSource(states, registers = "r1, r2, r3, r4, r5, r6") {
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
    // Canonical Prometheus pre-test while: preheader -> check -> body/exit,
    // with the body latch returning to the check.
    const source = vmStatesSource({
        1: ["r1 = args", "state = 2"],
        2: ["state = true", "state = state and 3 or 4"],
        3: ["state = 2"],
        4: ["ReturnVal = {}", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.loopCount, 1);
    assert.strictEqual(result.source, "while true do\nend\n");
}

{
    // The compiler's short-circuit TESTSET region belongs to the while
    // condition, not to the loop body or a source if statement.
    const source = vmStatesSource({
        1: ["r2 = args", "state = 2"],
        2: ['r3 = "a"', "r1 = _env[r3]", "state = r1 and 3 or 4", "ReturnVal = r1"],
        3: ['r3 = "b"', "r1 = _env[r3]", "ReturnVal = r1", "state = 4"],
        4: ["state = ReturnVal and 5 or 6"],
        5: ["state = 2"],
        6: ["ReturnVal = {}", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source, "while (a and b) do\nend\n");
}

{
    // A source binding established before the loop must stay one binding
    // across condition checks, body mutation, and the post-loop continuation.
    const source = vmStatesSource({
        1: ["state = 0", "r3 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 3", "state = r3 < ReturnVal", "state = state and 3 or 4"],
        3: [
            'ReturnVal = "print"',
            "state = _env[ReturnVal]",
            "ReturnVal = state(r3)",
            "ReturnVal = 1",
            "state = r3 + ReturnVal",
            "r3 = state",
            "state = 2",
        ],
        4: [
            'r4 = "print"',
            "ReturnVal = _env[r4]",
            'r1 = "done"',
            "r4 = ReturnVal(r1, r3)",
            "r3 = nil",
            "ReturnVal = {}",
            "state = nil",
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "while (v1 < 3) do\n" +
        "    print(v1)\n" +
        "    v1 = (v1 + 1)\n" +
        "end\n" +
        'print("done", v1)\n');
}

{
    // Extra body-to-exit control flow is break-like. The canonical while
    // matcher must reject it until break reconstruction has its own proof.
    const source = vmStatesSource({
        1: ["r1 = args", "state = 2"],
        2: ['r2 = "keepGoing"', "r1 = _env[r2]", "state = r1 and 3 or 4"],
        3: ['r2 = "stopNow"', "r1 = _env[r2]", "state = r1 and 4 or 5"],
        4: ["ReturnVal = {}", "state = nil"],
        5: ["state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.notStrictEqual(result.mode, "fresh-while");
}


{
    // Supported source if/else inside a while body must structure inside the
    // loop rather than being confused with the outer loop condition.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 4", "state = r1 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 2", "state = r1 == ReturnVal", "state = state and 5 or 6"],
        4: ["r1 = nil", "ReturnVal = {}", "state = nil"],
        5: ['ReturnVal = "print"', "state = _env[ReturnVal]", 'r3 = "two"', "ReturnVal = state(r3)", "state = 7"],
        6: ['ReturnVal = "print"', "state = _env[ReturnVal]", "ReturnVal = state(r1)", "state = 7"],
        7: ["ReturnVal = 1", "state = r1 + ReturnVal", "r1 = state", "state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "while (v1 < 4) do\n" +
        "    if (v1 == 2) then\n" +
        "        print(\"two\")\n" +
        "    else\n" +
        "        print(v1)\n" +
        "    end\n" +
        "    v1 = (v1 + 1)\n" +
        "end\n");
}

{
    // Prometheus break lowering targets the loop final block. Once the path
    // and loop exit are proven, emit source break and preserve the other arm.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 5", "state = r1 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 2", "state = r1 == ReturnVal", "state = state and 5 or 6"],
        4: ["r1 = nil", "ReturnVal = {}", "state = nil"],
        5: ["state = 4"],
        6: ['ReturnVal = "print"', "state = _env[ReturnVal]", "ReturnVal = state(r1)", "ReturnVal = 1", "state = r1 + ReturnVal", "r1 = state", "state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.match(result.source, /while \(v1 < 5\) do/);
    assert.match(result.source, /break/);
    assert.match(result.source, /print\(v1\)/);
}

{
    // Prometheus continue lowering targets the loop check block. A second
    // proven back-edge beside the normal latch is therefore source continue.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 4", "state = r1 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 1", "state = r1 + ReturnVal", "r1 = state", "r3 = 2", "ReturnVal = r1 == r3", "state = ReturnVal and 5 or 6"],
        4: ["r1 = nil", "ReturnVal = {}", "state = nil"],
        5: ["state = 2"],
        6: ['r3 = "print"', "ReturnVal = _env[r3]", "r3 = ReturnVal(r1)", "state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.match(result.source, /continue/);
    assert.match(result.source, /print\(v1\)/);
}

{
    // Nested source whiles are recovered inner-first. The inner source local
    // starts under the outer loop path, cleans up at the inner exit, and must
    // not be restarted later when that physical register is reused as a TEMP.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "r4 = args", "state = 2"],
        2: ["ReturnVal = 3", "state = r1 < ReturnVal", "state = state and 3 or 4"],
        3: ["state = 0", "r2 = state", "state = 5"],
        4: ["ReturnVal = {}", 'r5 = "print"', "r2 = _env[r5]", 'r3 = "done"', "r5 = r2(r3, r1)", "r1 = nil", "state = nil"],
        5: ["ReturnVal = 2", "state = r2 < ReturnVal", "state = state and 6 or 7"],
        6: ['ReturnVal = "print"', "state = _env[ReturnVal]", "ReturnVal = state(r1, r2)", "ReturnVal = 1", "state = r2 + ReturnVal", "r2 = state", "state = 5"],
        7: ["r5 = 1", "r2 = nil", "ReturnVal = r1 + r5", "r1 = ReturnVal", "state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.loopCount, 2);
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "while (v1 < 3) do\n" +
        "    local v2 = 0\n" +
        "    while (v2 < 2) do\n" +
        "        print(v1, v2)\n" +
        "        v2 = (v2 + 1)\n" +
        "    end\n" +
        "    v1 = (v1 + 1)\n" +
        "end\n" +
        "print(\"done\", v1)\n");
}

console.log("beta control-flow while tests passed");
