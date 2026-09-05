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


{
    // Several proven body->check edges may all be source continue sites; no
    // unique physical latch is required. The only continue omitted is the
    // redundant lexical tail/fallthrough of the reconstructed loop body.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "state = 0", "r4 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 10", "state = r1 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 1", "state = r1 + ReturnVal", "r1 = state", "r3 = 2", "ReturnVal = r1 == r3", "state = ReturnVal and 5 or 6"],
        4: ["r1 = nil", "r4 = nil", "ReturnVal = {}", "state = nil"],
        5: ["r3 = 20", "ReturnVal = r4 + r3", "r4 = ReturnVal", "state = 2"],
        6: ["r3 = 4", "ReturnVal = r1 == r3", "state = ReturnVal and 7 or 8"],
        7: ["r3 = 40", "ReturnVal = r4 + r3", "r4 = ReturnVal", "state = 2"],
        8: ["r3 = 6", "ReturnVal = r1 == r3", "state = ReturnVal and 9 or 10"],
        9: ["r3 = 60", "ReturnVal = r4 + r3", "r4 = ReturnVal", "state = 2"],
        10: ["ReturnVal = r4 + r1", "r4 = ReturnVal", "state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual((result.source.match(/\bcontinue\b/g) || []).length, 3);
    assert.match(result.source, /if \(v1 == 2\) then[\s\S]*continue/);
    assert.match(result.source, /if \(v1 == 4\) then[\s\S]*continue/);
    assert.match(result.source, /if \(v1 == 6\) then[\s\S]*continue/);
    assert.doesNotMatch(result.source, /continue\nend\n$/);
}

{
    // A loop body may terminate the whole VM invocation. The off-cycle region
    // is accepted only when it closes in a compiler ReturnVal pack + stop.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "r3 = args", "state = 2"],
        2: ["ReturnVal = 5", "state = r1 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 1", "state = r1 + ReturnVal", "r1 = state", "r2 = 3", "ReturnVal = r1 == r2", "state = ReturnVal and 5 or 6"],
        4: ['ReturnVal = "done"', "ReturnVal = { r1, ReturnVal }", "state = nil"],
        5: ['ReturnVal = "hit"', "ReturnVal = { r1, ReturnVal }", "state = nil"],
        6: ["state = 2"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "while (v1 < 5) do\n" +
        "    v1 = (v1 + 1)\n" +
        "    if (v1 == 3) then\n" +
        '        return v1, "hit"\n' +
        "    end\n" +
        "end\n" +
        'return v1, "done"\n');
}

{
    // Child closure entries may contain a recovered while. Synthetic body-join
    // IDs must not leak into reachable-state accounting or closure consumption.
    const source = vmStatesSource({
        1: [
            "state = createClosure4(2, {})",
            "r3 = state",
            'ReturnVal = "print"',
            "state = _env[ReturnVal]",
            "r2 = { r3() }",
            "r3 = nil",
            "ReturnVal = state(unpack(r2))",
            "r1 = args",
            "ReturnVal = {}",
            "state = nil",
        ],
        2: ["state = 0", "r1 = state", "state = 3"],
        3: ["ReturnVal = 3", "state = r1 < ReturnVal", "state = state and 4 or 5"],
        4: ["ReturnVal = 1", "state = r1 + ReturnVal", "r1 = state", "r3 = 2", "ReturnVal = r1 == r3", "state = ReturnVal and 6 or 7"],
        5: ['ReturnVal = "done"', "ReturnVal = { r1, ReturnVal }", "state = nil"],
        6: ['ReturnVal = "hit"', "ReturnVal = { r1, ReturnVal }", "state = nil"],
        7: ["state = 3"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.stateCount, 7);
    assert.match(result.source, /local v1 = function\(\)/);
    assert.match(result.source, /while \(v1 < 3\) do/);
    assert.match(result.source, /return v1, "hit"/);
    assert.match(result.source, /print\(v1\(\)\)/);
}

{
    // A captured closure created inside the loop body must be reconstructed at
    // iteration scope. Prometheus packs the closure call before forwarding it
    // as the final print argument; no dead closure declaration may leak to root.
    const source = vmStatesSource({
        // r5 has an earlier unrelated TEMP epoch. The later closure epoch is
        // still one source local because its own lifetime reaches r5 = nil
        // before any physical-register reuse on the next iteration.
        1: ["r1 = allocUpvalue()", 'r5 = "compiler-temp"', "state = 0", "r3 = state", "state = 10", "upvalueValues[r1] = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 3", "state = r3 < ReturnVal", "state = state and 3 or 4"],
        3: [
            "state = createClosure5(5, { r1 })",
            "r5 = state",
            'ReturnVal = "print"',
            "state = _env[ReturnVal]",
            "r4 = { r5(r3) }",
            "ReturnVal = state(unpack(r4))",
            "ReturnVal = 1",
            "state = r3 + ReturnVal",
            "r3 = state",
            "r5 = nil",
            "state = 2",
        ],
        4: ["r3 = nil", "ReturnVal = {}", "r1 = releaseUpvalue(r1)", "state = nil"],
        5: ["r2 = args[1]", "ReturnVal = upvalueValues[upvalues[1]]", "state = ReturnVal + r2", "ReturnVal = { state }", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "local v2 = 10\n" +
        "while (v1 < 3) do\n" +
        "    local v3 = function(v1)\n" +
        "        return (v2 + v1)\n" +
        "    end\n" +
        "    print(v3(v1))\n" +
        "    v1 = (v1 + 1)\n" +
        "end\n");
    const beforeWhile = result.source.slice(0, result.source.indexOf("while "));
    assert.doesNotMatch(beforeWhile, /function\s*\(/);
}

{
    // A loop-local closure remains a source binding even when one branch
    // returns from the function before the compiler emits its nil cleanup.
    // The physical register also has an earlier unrelated TEMP epoch, so
    // ownership must be proven for the current cleanup-or-terminal epoch.
    const source = vmStatesSource({
        1: ["r1 = allocUpvalue()", 'r5 = "compiler-temp"', "state = 0", "r3 = state", "state = 10", "upvalueValues[r1] = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 3", "state = r3 < ReturnVal", "state = state and 3 or 4"],
        3: ["state = createClosure5(7, { r1 })", "r5 = state", "ReturnVal = 2", "state = r3 == ReturnVal", "state = state and 5 or 6"],
        4: ["r3 = nil", "ReturnVal = {}", "r1 = releaseUpvalue(r1)", "state = nil"],
        5: ['ReturnVal = "early"', "ReturnVal = { ReturnVal }", "state = nil"],
        6: ['ReturnVal = "print"', "state = _env[ReturnVal]", "r4 = { r5(r3) }", "ReturnVal = state(unpack(r4))", "ReturnVal = 1", "state = r3 + ReturnVal", "r3 = state", "r5 = nil", "state = 2"],
        7: ["r2 = args[1]", "ReturnVal = upvalueValues[upvalues[1]]", "state = ReturnVal + r2", "ReturnVal = { state }", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "local v2 = 10\n" +
        "while (v1 < 3) do\n" +
        "    local v3 = function(v1)\n" +
        "        return (v2 + v1)\n" +
        "    end\n" +
        "    if (v1 == 2) then\n" +
        '        return "early"\n' +
        "    end\n" +
        "    print(v3(v1))\n" +
        "    v1 = (v1 + 1)\n" +
        "end\n");
}


{
    // A source local allocated/captured on each loop iteration is path-local.
    // A compiler TEMP alias may read that binding, but later physical-register
    // reuse must not be mistaken for a source assignment to the captured local.
    const source = vmStatesSource({
        1: ["state = 0", "r4 = state", "state = 0", "r7 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 4", "state = r4 < ReturnVal", "state = state and 3 or 4"],
        3: [
            "ReturnVal = 1", "state = r4 + ReturnVal", "r4 = state",
            "r5 = allocUpvalue()", "ReturnVal = r7 + r4", "upvalueValues[r5] = ReturnVal",
            "ReturnVal = createClosure6(5, { r5 })", "r3 = ReturnVal",
            "r1 = upvalueValues[r5]", "r6 = 10", "ReturnVal = r1 + r6", "upvalueValues[r5] = ReturnVal",
            "r6 = r3(r4)", "r5 = releaseUpvalue(r5)", "r3 = nil",
            "r1 = r7 + r6", "r7 = r1", "state = 2",
        ],
        4: ["ReturnVal = { r7 }", "r4 = nil", "r7 = nil", "state = nil"],
        5: ["ReturnVal = upvalueValues[upvalues[1]]", "r2 = args[1]", "state = ReturnVal + r2", "ReturnVal = { state }", "state = nil"],
    }, "r1, r2, r3, r4, r5, r6, r7, r8");
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "local v2 = 0\n" +
        "while (v1 < 4) do\n" +
        "    v1 = (v1 + 1)\n" +
        "    local v3 = (v2 + v1)\n" +
        "    local v4 = function(v1)\n" +
        "        return (v3 + v1)\n" +
        "    end\n" +
        "    v3 = (v3 + 10)\n" +
        "    v2 = (v2 + v4(v1))\n" +
        "end\n" +
        "return v2\n");
}

{
    // Prometheus may capture a newly allocated cell before writing its first
    // value. Preserve the captured-closure object across compiler transport and
    // resolve it only after the cell has acquired its source binding.
    const source = vmStatesSource({
        1: ["r3 = allocUpvalue()", "state = 10", "upvalueValues[r3] = state", "state = 0", "r8 = state", "r2 = args", "state = 2"],
        2: ["ReturnVal = 2", "state = r8 < ReturnVal", "state = state and 3 or 4"],
        3: [
            "ReturnVal = 1", "state = r8 + ReturnVal", "r8 = state",
            "ReturnVal = createClosure5(5, { r3 })", "r7 = ReturnVal", "ReturnVal = r7(r8)", "r5 = ReturnVal",
            "r4 = 2", "r6 = r5(r4)", "r1 = upvalueValues[r3]", "ReturnVal = r1 + r6", "upvalueValues[r3] = ReturnVal",
            "r5 = nil", "r7 = nil", "state = 2",
        ],
        4: ["ReturnVal = upvalueValues[r3]", "r3 = releaseUpvalue(r3)", "ReturnVal = { ReturnVal }", "r8 = nil", "state = nil"],
        5: ["r2 = allocUpvalue()", "state = createClosure6(6, { r2, upvalues[1] })", "r8 = state", "upvalueValues[r2] = args[1]", "ReturnVal = { r8 }", "state = nil"],
        6: ["r8 = upvalueValues[upvalues[1]]", "r2 = args[1]", "ReturnVal = r8 + r2", "r8 = upvalueValues[upvalues[2]]", "state = ReturnVal + r8", "ReturnVal = { state }", "state = nil"],
    }, "r1, r2, r3, r4, r5, r6, r7, r8");
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        "local v1 = 10\n" +
        "local v2 = 0\n" +
        "while (v2 < 2) do\n" +
        "    v2 = (v2 + 1)\n" +
        "    local v3 = function(v2)\n" +
        "        return function(v3)\n" +
        "            return ((v2 + v3) + v1)\n" +
        "        end\n" +
        "    end\n" +
        "    local v4 = v3(v2)\n" +
        "    v1 = (v1 + v4(2))\n" +
        "end\n" +
        "return v1\n");
}

{
    // A createClosure TEMP used directly as a callable is an anonymous function
    // expression, not a named source local. Reuse the ordinary TEMP-call path.
    const source = vmStatesSource({
        1: ["r2 = createClosure2(2, {})", "ReturnVal = r2()", "ReturnVal = { ReturnVal }", "state = nil"],
        2: ["ReturnVal = 1", "ReturnVal = { ReturnVal }", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        "return (function()\n" +
        "    return 1\n" +
        "end)()\n");
}

{
    // A loop body may have one continuation arm while the sibling enters a
    // compound short-circuit condition whose leaves all return. The compiler
    // logical restore path does not reach the synthetic loop-body join, so it
    // must not consume that queued continue candidate prematurely.
    const source = vmStatesSource({
        1: ["state = 0", "r2 = state", "r5 = args", "state = 2"],
        2: ["ReturnVal = 8", "state = r2 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 1", "state = r2 + ReturnVal", "r2 = state", "r7 = r2", 'r3 = "x"', "ReturnVal = { [r3] = r7 }", "r3 = ReturnVal", "r6 = 6", "ReturnVal = r2 == r6", "state = ReturnVal and 5 or 6", "r9 = r2"],
        4: ['ReturnVal = "done"', "ReturnVal = { ReturnVal }", "state = nil"],
        5: ["r6 = state", "r8 = r7 ~= r9", "state = r8 and 7 or 8", "ReturnVal = r8"],
        6: ["r9 = nil", "r7 = nil", "r3 = nil", "state = 2"],
        7: ["state = r6", "state = ReturnVal and 9 or 10"],
        8: ['r1 = "x"', "r4 = r3[r1]", "r8 = r4 ~= r7", "ReturnVal = r8", "state = 7"],
        9: ['ReturnVal = "bad"', "ReturnVal = { ReturnVal }", "state = nil"],
        10: ['ReturnVal = "ok"', "ReturnVal = { ReturnVal }", "state = nil"],
    }, "r1, r2, r3, r4, r5, r6, r7, r8, r9");
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "while (v1 < 8) do\n" +
        "    v1 = (v1 + 1)\n" +
        "    local v2 = v1\n" +
        "    local v3 = { x = v2 }\n" +
        "    local v4 = v1\n" +
        "    if (v1 == 6) then\n" +
        "        if ((v2 ~= v4) or (v3.x ~= v2)) then\n" +
        '            return "bad"\n' +
        "        end\n" +
        '        return "ok"\n' +
        "    end\n" +
        "end\n" +
        'return "done"\n');
}
{
    // A multi-arm loop conditional may have several continuing arms while one
    // sibling arm is a nested terminal-return chain. That terminal arm has no
    // physical edge to the continuation join, so the join must wait for the
    // ready terminal siblings before elseif convergence is reconstructed.
    const source = vmStatesSource({
        1: ["state = 0", "r4 = state", "state = 0", "r5 = state", "r3 = args", "state = 2"],
        2: ["ReturnVal = 8", "state = r4 < ReturnVal", "state = state and 3 or 4"],
        3: ["ReturnVal = 1", "state = r4 + ReturnVal", "r4 = state", "r2 = r4", 'r6 = "x"', "ReturnVal = { [r6] = r2 }", "r6 = ReturnVal", "r1 = 2", "ReturnVal = r4 == r1", "state = ReturnVal and 5 or 6", "r10 = r4"],
        4: ['r2 = "done"', "ReturnVal = { r5, r2 }", "state = nil"],
        5: ["ReturnVal = r5 + r2", "r5 = ReturnVal", "state = 7"],
        6: ["r7 = 4", "r1 = r4 == r7", "state = r1 and 8 or 9"],
        7: ["r10 = nil", "r2 = nil", "r6 = nil", "state = 2"],
        8: ["r7 = 40", "r1 = r5 + r7", "r5 = r1", "state = 7"],
        9: ["r9 = 6", "r7 = r4 == r9", "state = r7 and 10 or 11"],
        10: ["r7 = r2 ~= r10", "state = r7 and 12 or 13"],
        11: ['r8 = "x"', "r9 = r6[r8]", "r7 = r5 + r9", "r5 = r7", "state = 7"],
        12: ['r7 = "bad-a"', "ReturnVal = { r5, r7 }", "state = nil"],
        13: ['r8 = "x"', "r9 = r6[r8]", "r7 = r9 ~= r2", "state = r7 and 14 or 15"],
        14: ['r7 = "bad-b"', "ReturnVal = { r5, r7 }", "state = nil"],
        15: ["r9 = 60", "r7 = r5 + r9", 'r9 = "ok"', "ReturnVal = { r7, r9 }", "state = nil"],
    }, "r1, r2, r3, r4, r5, r6, r7, r8, r9, r10");
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        "local v1 = 0\n" +
        "local v2 = 0\n" +
        "while (v1 < 8) do\n" +
        "    v1 = (v1 + 1)\n" +
        "    local v3 = v1\n" +
        "    local v4 = { x = v3 }\n" +
        "    local v5 = v1\n" +
        "    if (v1 == 2) then\n" +
        "        v2 = (v2 + v3)\n" +
        "    elseif (v1 == 4) then\n" +
        "        v2 = (v2 + 40)\n" +
        "    else\n" +
        "        if (v1 == 6) then\n" +
        "            if (v3 ~= v5) then\n" +
        '                return v2, "bad-a"\n' +
        "            end\n" +
        "            if (v4.x ~= v3) then\n" +
        '                return v2, "bad-b"\n' +
        "            end\n" +
        '            return (v2 + 60), "ok"\n' +
        "        end\n" +
        "        v2 = (v2 + v4.x)\n" +
        "    end\n" +
        "end\n" +
        'return v2, "done"\n');
}

{
    // A loop-carried register may have unrelated TEMP epochs earlier in the
    // same preheader block. Only the final proven definition that reaches the
    // loop header may start the source binding.
    const source = vmStatesSource({
        1: ['r1 = "print"', 'r2 = _env[r1]', 'r1 = "pre"', 'ReturnVal = r2(r1)', 'state = 0', 'r1 = state', 'r3 = args', 'state = 2'],
        2: ['ReturnVal = 2', 'state = r1 < ReturnVal', 'state = state and 3 or 4'],
        3: ['ReturnVal = 1', 'state = r1 + ReturnVal', 'r1 = state', 'state = 2'],
        4: ['r1 = nil', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        'print("pre")\n' +
        'local v1 = 0\n' +
        'while (v1 < 2) do\n' +
        '    v1 = (v1 + 1)\n' +
        'end\n');
}

{
    // A proven source break may jump to the loop's normal exit even when that
    // exit block is itself a terminal function return. Do not absorb the break
    // path into a pure terminal-return region; keep the mixed break/return arm.
    const source = vmStatesSource({
        1: ["state = 0", "r1 = state", "state = 2"],
        2: ["r2 = 3", "state = r1 < r2", "state = state and 3 or 4"],
        3: ["r2 = 1", "state = r1 + r2", "r1 = state", "r2 = 2", "ReturnVal = r1 == r2", "state = ReturnVal and 5 or 6"],
        4: ['ReturnVal = "done"', "ReturnVal = { ReturnVal }", "r1 = nil", "state = nil"],
        5: ["r2 = 0", "ReturnVal = r1 > r2", "state = ReturnVal and 7 or 8"],
        6: ["state = 2"],
        7: ["state = 4"],
        8: ['ReturnVal = "bad"', "ReturnVal = { ReturnVal }", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.match(result.source, /while \(v1 < 3\) do/);
    assert.match(result.source, /if \(v1 == 2\) then/);
    assert.match(result.source, /return "bad"/);
    assert.match(result.source, /break/);
    assert.match(result.source, /return "done"/);
}


{
    // An immediately-called anonymous closure is compiler TEMP transport, not
    // a named source local. Resolve createClosureN into a callable TEMP, then
    // reuse the ordinary call path while rendering the structured child body.
    const source = vmStatesSource({
        1: ["state = createClosure2(2, {})", "ReturnVal = state()", "r1 = args", "ReturnVal = {}", "state = nil"],
        2: ["state = 3"],
        3: ["state = 1", "state = state and 4 or 5"],
        4: ['ReturnVal = "print"', "state = _env[ReturnVal]", "r1 = 1", "ReturnVal = state(r1)", "state = 3"],
        5: ["ReturnVal = {}", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source,
        "(function()\n" +
        "    while 1 do\n" +
        "        print(1)\n" +
        "    end\n" +
        "end)()\n");
}

{
    // IIFE argument evaluation is ordinary TEMP production between callable
    // creation and invocation; it must not require a special closure-call path.
    const source = vmStatesSource({
        1: ["state = createClosure2(2, {})", "r2 = 3", "ReturnVal = state(r2)", "r1 = args", "ReturnVal = {}", "state = nil"],
        2: ["r1 = args[1]", "state = 0", "r2 = state", "state = 3"],
        3: ["state = r2 < r1", "state = state and 4 or 5"],
        4: ['ReturnVal = "print"', "state = _env[ReturnVal]", "ReturnVal = state(r2)", "ReturnVal = 1", "state = r2 + ReturnVal", "r2 = state", "state = 3"],
        5: ["r1 = nil", "r2 = nil", "ReturnVal = {}", "state = nil"],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.match(result.source, /^\(function\(v1\)/);
    assert.match(result.source, /while \(v\d+ < v\d+\) do/);
    assert.match(result.source, /print\(v\d+\)/);
    assert.match(result.source, /end\)\(3\)\n$/);
}

{
    // A source global write inside a while body is still just an ordinary
    // assignment effect. Prove the static _env key, keep it in the candidate
    // effect list, and let the normal loop/branch merger place it structurally.
    const source = vmStatesSource({
        1: ['state = 2'],
        2: ['r1 = "looping"', 'state = _env[r1]', 'state = state and 3 or 4'],
        3: ['r1 = "thing"', 'r2 = 123', '_env[r1] = r2', 'state = 2'],
        4: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source, 'while looping do\n    thing = 123\nend\n');
}

{
    // The same static-global write proof must survive nested if/elseif branches
    // inside a loop; this is not a loop-specific or fixture-specific rule.
    const source = vmStatesSource({
        1: ['state = 2'],
        2: ['r1 = "looping"', 'state = _env[r1]', 'state = state and 3 or 4'],
        3: ['r1 = "a"', 'state = _env[r1]', 'state = state and 5 or 6'],
        5: ['r1 = "thing"', 'r2 = 1', '_env[r1] = r2', 'state = 8'],
        6: ['r1 = "b"', 'state = _env[r1]', 'state = state and 7 or 8'],
        7: ['r1 = "thing"', 'r2 = 2', '_env[r1] = r2', 'state = 8'],
        8: ['state = 2'],
        4: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-while");
    assert.strictEqual(result.source,
        'while looping do\n' +
        '    if a then\n' +
        '        thing = 1\n' +
        '    elseif b then\n' +
        '        thing = 2\n' +
        '    end\n' +
        'end\n');
}

console.log("beta control-flow while tests passed");
