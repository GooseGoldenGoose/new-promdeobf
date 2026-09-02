const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parse(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        comments: true,
        scope: true,
        locations: true,
        ranges: true,
    });
}

function vmSource(leaf) {
    return [
        "vm = function(state, args, upvalues, gcProxy)",
        "    local r1, r2, ReturnVal",
        "    while state do",
        "        if state == 1 then",
        ...leaf.map(line => `            ${line}`),
        "        end",
        "    end",
        "    state = #gcProxy",
        "    return unpack(ReturnVal)",
        "end",
    ].join("\n");
}

function vmStatesSource(states) {
    const lines = [
        "vm = function(state, args, upvalues, gcProxy)",
        "    local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal",
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
    const source = vmSource([
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = 1',
        'ReturnVal = state(r1)',
        'r2 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-direct-global-call");
    assert.strictEqual(result.source, "print(1)\n");
    assert.strictEqual(result.stateCount, 1);
    assert.strictEqual(result.statementCount, 1);
}

{
    const source = vmSource([
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = 1',
        'effect()',
        'ReturnVal = state(r1)',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "solver crossed an unknown/effectful statement");
}

{
    const source = vmSource([
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = 1',
        'ReturnVal = state(r1)',
        'ReturnVal = {}',
        'state = 2',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "solver accepted a non-terminal VM state transition");
}

{
    const result = solveBetaControlFlow(parse("print(1)"), { applied: true, graph: {} });
    assert.strictEqual(result.applied, false, "legacy beta-register API was revived");
}


{
    const source = vmSource([
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = 1',
        'ReturnVal = state(r1)',
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = 2',
        'ReturnVal = state(r1)',
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = 3',
        'ReturnVal = state(r1)',
        'r2 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.callCount, 3);
    assert.strictEqual(result.source, "print(1)\nprint(2)\nprint(3)\n");
}

{
    const source = vmSource([
        'r5 = {}',
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r2 = "math"',
        'r4 = _env[r2]',
        'r6 = 1',
        'r7 = "wa"',
        'r3 = nil',
        'r2 = true',
        'ReturnVal = state(r5, r6, r7, r4, r2, r3)',
        'r1 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.callCount, 1);
    assert.strictEqual(result.argumentCount, 6);
    assert.strictEqual(result.source, 'print({}, 1, "wa", math, true, nil)\n');
}

{
    const source = vmSource([
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = function() end',
        'ReturnVal = state(r1)',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "function literal support was enabled prematurely");
}


{
    const source = vmSource([
        'r1 = "math"',
        'ReturnVal = _env[r1]',
        'r1 = "random"',
        'state = ReturnVal[r1]',
        'r2 = 2',
        'r1 = 1',
        'ReturnVal = state(r1, r2)',
        'r3 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.source, "math.random(1, 2)\n");
    assert.strictEqual(result.globalName, "math.random");
}

{
    const source = vmSource([
        'ReturnVal = "math"',
        'state = _env[ReturnVal]',
        'r1 = state',
        'ReturnVal = "random"',
        'state = r1[ReturnVal]',
        'r2 = 2',
        'r3 = 1',
        'ReturnVal = state(r3, r2)',
        'r1 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, "local v1 = math\nv1.random(1, 2)\n");
}

{
    const source = vmSource([
        'r3 = "math"',
        'ReturnVal = _env[r3]',
        'r3 = "random"',
        'state = ReturnVal[r3]',
        'r3 = state',
        'r2 = 2',
        'ReturnVal = 1',
        'state = r3(ReturnVal, r2)',
        'r1 = args',
        'r3 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, "local v1 = math.random\nv1(1, 2)\n");
}


{
    const source = vmSource([
        'r5 = "game"',
        'r1 = _env[r5]',
        'r5 = "foo"',
        'r3 = r1[r5]',
        'r1 = "bar"',
        'r2 = r3[r1]',
        'r3 = "baz"',
        'ReturnVal = r2[r3]',
        'r2 = "qux"',
        'state = ReturnVal[r2]',
        'ReturnVal = state()',
        'r4 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.source, "game.foo.bar.baz.qux()\n");
    assert.strictEqual(result.globalName, "game.foo.bar.baz.qux");
}


{
    const source = vmSource([
        'r2 = args',
        'r1 = "game"',
        'ReturnVal = _env[r1]',
        'r1 = "Players"',
        'state = ReturnVal[r1]',
        'r1 = state',
        'ReturnVal = "LocalPlayer"',
        'state = r1[ReturnVal]',
        'r3 = state',
        'ReturnVal = "Character"',
        'r1 = nil',
        'state = r3[ReturnVal]',
        'r3 = state',
        'r3 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.localCount, 2);
    assert.strictEqual(result.source, "local v1 = game.Players\nlocal v2 = v1.LocalPlayer\nv2 = v2.Character\n");
}


{
    const source = vmSource([
        'r3 = 2',
        'ReturnVal = "b"',
        'state = { [ReturnVal] = r3 }',
        'r3 = state',
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r1 = "b"',
        'r2 = r3[r1]',
        'r4 = args',
        'r3 = nil',
        'ReturnVal = state(r2)',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, "local t1 = { b = 2 }\nprint(t1.b)\n");
}

{
    const source = vmSource([
        'ReturnVal = 1',
        'r1 = ReturnVal',
        'ReturnVal = "x"',
        'state = 2',
        'r2 = state',
        'state = { [ReturnVal] = r2 }',
        'r3 = state',
        'r1 = nil',
        'r3 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.source, "local v1 = 1\nlocal t1 = { x = 2 }\n");
}


{
    const source = vmSource([
        'r6 = "math"',
        'r8 = _env[r6]',
        'r6 = "random"',
        'r3 = r8[r6]',
        'r6 = 1',
        'r5 = 2',
        'r8 = r3(r6, r5)',
        'r3 = 1',
        'r1 = r8 == r3',
        'r3 = 123',
        'r2 = r1 and r3',
        'r4 = state',
        'r4 = 321',
        'ReturnVal = r2 or r4',
        'r2 = ReturnVal',
        'r2 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.statementCount, 1);
    assert.strictEqual(result.source, "local v1 = (((math.random(1, 2) == 1) and 123) or 321)\n");
}


{
    const source = vmStatesSource({
        1: [
            'ReturnVal = "game"',
            'state = _env[ReturnVal]',
            'r2 = state',
            'ReturnVal = "workspace"',
            'state = _env[ReturnVal]',
            'r4 = state',
            'state = r2 and 2 or 3',
            'r1 = args',
            'ReturnVal = r2',
        ],
        2: ['ReturnVal = r4', 'state = 3'],
        3: ['state = r2 and 4 or 5', 'r3 = ReturnVal', 'ReturnVal = r2'],
        4: ['r3 = nil', 'r2 = nil', 'r5 = ReturnVal', 'r5 = nil', 'r4 = nil', 'ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = r4', 'state = 4'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-multistate-logical");
    assert.strictEqual(result.source, "local v1 = game\nlocal v2 = workspace\nlocal v3 = (v1 and v2)\nlocal v4 = (v1 or v2)\n");
}

{
    const source = vmStatesSource({
        1: [
            'ReturnVal = "game"', 'state = _env[ReturnVal]', 'r2 = state',
            'ReturnVal = "workspace"', 'state = _env[ReturnVal]', 'r6 = state',
            'ReturnVal = "math"', 'state = _env[ReturnVal]', 'r5 = state',
            'state = r2 and 2 or 3', 'ReturnVal = r2',
        ],
        2: ['r1 = ReturnVal', 'state = r2 and 4 or 5', 'ReturnVal = r2'],
        3: ['r3 = state', 'state = r6 and 6 or 7', 'r1 = r6'],
        4: ['r4 = state', 'state = r6 and 8 or 9', 'r3 = r6'],
        5: ['r1 = nil', 'r2 = nil', 'r5 = nil', 'r3 = ReturnVal', 'r3 = nil', 'r6 = nil', 'ReturnVal = {}', 'state = nil'],
        6: ['state = r3', 'ReturnVal = r1', 'state = 2'],
        7: ['r1 = r5', 'state = 6'],
        8: ['r3 = r5', 'state = 9'],
        9: ['state = r4', 'ReturnVal = r3', 'state = 5'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-multistate-logical");
    assert.strictEqual(result.source, "local v1 = game\nlocal v2 = workspace\nlocal v3 = math\nlocal v4 = (v1 or (v2 or v3))\nlocal v5 = (v1 and (v2 and v3))\n");
}


{
    const source = vmStatesSource({
        1: ['r1 = "b"', 'r2 = _env[r1]', 'state = r2 and 2 or 3', 'r3 = args', 'ReturnVal = r2'],
        2: ['r2 = ReturnVal', 'r2 = nil', 'ReturnVal = {}', 'state = nil'],
        3: ['r1 = "c"', 'r2 = _env[r1]', 'ReturnVal = r2', 'state = 2'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-multistate-logical");
    assert.strictEqual(result.source, "local v1 = (b or c)\n");
}

{
    const source = vmStatesSource({
        1: ['r1 = "b"', 'r2 = _env[r1]', 'state = r2 and 2 or 3', 'ReturnVal = r2'],
        2: ['ReturnVal = r1', 'r2 = ReturnVal', 'r2 = nil', 'ReturnVal = {}', 'state = nil'],
        3: ['r1 = "c"', 'r2 = _env[r1]', 'ReturnVal = r2', 'state = 2'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "live differing path temporary was dropped at a logical join");
}


{
    const source = vmStatesSource({
        1: ['r2 = args', 'state = createClosure1(2, {})', 'r1 = state', 'r1 = nil', 'ReturnVal = {}', 'state = nil'],
        2: ['state = 123', 'ReturnVal = { state }', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.closureCount, 1);
    assert.strictEqual(result.source, "local v1 = function()\n    return 123\nend\n");
}

{
    const source = vmStatesSource({
        1: ['r2 = args', 'state = createClosure2(2, {})', 'r1 = state', 'r1 = nil', 'ReturnVal = {}', 'state = nil'],
        2: ['r2 = args[1]', 'r1 = args[2]', 'ReturnVal = { r2, r1 }', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, "local v1 = function(v1, v2)\n    return v1, v2\nend\n");
}

{
    const source = vmStatesSource({
        1: ['r2 = args', 'state = createClosure3(2, {})', 'r1 = state', 'r1 = nil', 'ReturnVal = {}', 'state = nil'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = 1', 'ReturnVal = state(r1)', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, "local v1 = function()\n    print(1)\nend\n");
}

{
    const source = vmSource([
        'r1 = args',
        'r4 = 1.5',
        'r2 = "math"',
        'ReturnVal = _env[r2]',
        'r2 = "modf"',
        'state = ReturnVal[r2]',
        'r3 = { state(r4) }',
        'ReturnVal = r3[1]',
        'r2 = r3[2]',
        'r4 = ReturnVal',
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'ReturnVal = state(r4, r2)',
        'r2 = nil',
        'r4 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.source, "local v1, v2 = math.modf(1.5)\nprint(v1, v2)\n");
}

{
    const source = vmSource([
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'r4 = "math"',
        'r2 = _env[r4]',
        'r4 = "modf"',
        'r1 = r2[r4]',
        'r4 = 1.5',
        'r2 = { r1(r4) }',
        'r5 = 1',
        'ReturnVal = state(r5, unpack(r2))',
        'r3 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-call-results");
    assert.strictEqual(result.source, "print(1, math.modf(1.5))\n");
}

{
    const source = vmStatesSource({
        1: [
            'state = createClosure3(2, {})',
            'r3 = state',
            'ReturnVal = "pcall"',
            'state = _env[ReturnVal]',
            'r1 = { state(r3) }',
            'ReturnVal = r1[1]',
            'r4 = r1[2]',
            'r2 = args',
            'r3 = nil',
            'r1 = ReturnVal',
            'ReturnVal = "print"',
            'state = _env[ReturnVal]',
            'ReturnVal = state(r1, r4)',
            'r1 = nil',
            'r4 = nil',
            'ReturnVal = {}',
            'state = nil',
        ],
        2: [
            'ReturnVal = "error"',
            'state = _env[ReturnVal]',
            'r2 = "231sadsa"',
            'ReturnVal = state(r2)',
            'ReturnVal = {}',
            'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "separated closure local + pcall multi-return was not recovered");
    assert.strictEqual(result.source, 'local v1 = function()\n    error("231sadsa")\nend\nlocal v2, v3 = pcall(v1)\nprint(v2, v3)\n');
}

{
    const source = vmStatesSource({
        1: [
            'r4 = 123',
            'state = 123',
            'r1 = state',
            'ReturnVal = "print"',
            'state = _env[ReturnVal]',
            'ReturnVal = state(r1, r4)',
            'r2 = args',
            'ReturnVal = "print"',
            'r6 = "print"',
            'r1 = nil',
            'state = _env[ReturnVal]',
            'r5 = "pcall"',
            'r4 = _env[r5]',
            'r3 = _env[r6]',
            'r6 = 1',
            'r5 = { r4(r3, r6) }',
            'ReturnVal = state(unpack(r5))',
            'state = createClosure3(2, {})',
            'r4 = state',
            'state = r4()',
            'r4 = nil',
            'ReturnVal = state()',
            'ReturnVal = {}',
            'state = nil',
        ],
        2: [
            'state = createClosure0(3, {})',
            'ReturnVal = { state }',
            'state = nil',
        ],
        3: [
            'ReturnVal = "print"',
            'state = _env[ReturnVal]',
            'r2 = 321',
            'ReturnVal = state(r2)',
            'ReturnVal = {}',
            'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "recursive nested closure recovery did not apply");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = 123\nprint(v1, 123)\nprint(pcall(print, 1))\nlocal v2 = function()\n    return function()\n        print(321)\n    end\nend\nv2()()\n');
}


{
    const source = vmStatesSource({
        1: [
            'r1 = args',
            'r2 = allocUpvalue()',
            'ReturnVal = {}',
            'state = 123',
            'upvalueValues[r2] = state',
            'state = createClosure1(2, { r2 })',
            'r3 = state',
            'r2 = releaseUpvalue(r2)',
            'state = r3()',
            'r3 = nil',
            'state = nil',
        ],
        2: [
            'state = _env[ReturnVal]',
            'ReturnVal = "print"',
            'r1 = upvalueValues[upvalues[1]]',
            'ReturnVal = state(r1)',
            'ReturnVal = {}',
            'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "read-only captured local was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.closureCount, 1);
    assert.strictEqual(result.source, 'local v1 = 123\nlocal v2 = function()\n    print(v1)\nend\nv2()\n');
}

{
    const source = vmStatesSource({
        1: [
            'state = createClosure4(2, {})',
            'r3 = state',
            'ReturnVal = "print"',
            'state = _env[ReturnVal]',
            'r4 = 1',
            'r2 = r3(r4)',
            'r4 = { r2() }',
            'ReturnVal = state(unpack(r4))',
            'r1 = args',
            'r3 = nil',
            'ReturnVal = {}',
            'state = nil',
        ],
        2: [
            'r1 = allocUpvalue()',
            'state = createClosure1(3, { r1 })',
            'upvalueValues[r1] = args[1]',
            'ReturnVal = { state }',
            'state = nil',
        ],
        3: [
            'state = upvalueValues[upvalues[1]]',
            'ReturnVal = { state }',
            'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "captured parameter nested closure was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = function(v1)\n    return function()\n        return v1\n    end\nend\nprint(v1(1)())\n');
}

{
    const source = vmStatesSource({
        1: [
            'r5 = allocUpvalue()', 'r4 = allocUpvalue()', 'state = 10', 'upvalueValues[r4] = state', 'state = 20', 'upvalueValues[r5] = state',
            'state = createClosure2(2, { r4, r5 })', 'r1 = state', 'ReturnVal = 40', 'state = r1(ReturnVal)', 'r2 = state', 'r3 = args', 'r1 = nil',
            'r5 = releaseUpvalue(r5)', 'ReturnVal = 50', 'state = r2(ReturnVal)', 'r6 = state', 'r4 = releaseUpvalue(r4)', 'r2 = nil',
            'ReturnVal = "print"', 'state = _env[ReturnVal]', 'r7 = { r6() }', 'r6 = nil', 'ReturnVal = state(unpack(r7))', 'ReturnVal = {}', 'state = nil',
        ],
        2: [
            'r3 = allocUpvalue()', 'r4 = allocUpvalue()', 'upvalueValues[r3] = args[1]', 'state = 30', 'upvalueValues[r4] = state',
            'state = createClosure1(3, { upvalues[1], upvalues[2], r4, r3 })', 'ReturnVal = { state }', 'state = nil',
        ],
        3: [
            'r3 = allocUpvalue()', 'upvalueValues[r3] = args[1]',
            'state = createClosure0(4, { upvalues[1], upvalues[2], upvalues[3], upvalues[4], r3 })', 'ReturnVal = { state }', 'state = nil',
        ],
        4: [
            'ReturnVal = "print"', 'state = _env[ReturnVal]',
            'r3 = upvalueValues[upvalues[1]]', 'r4 = upvalueValues[upvalues[2]]', 'r5 = upvalueValues[upvalues[3]]', 'r1 = upvalueValues[upvalues[4]]', 'r2 = upvalueValues[upvalues[5]]',
            'ReturnVal = state(r3, r4, r5, r1, r2)', 'r5 = upvalueValues[upvalues[1]]', 'r1 = upvalueValues[upvalues[2]]', 'r4 = r5 + r1',
            'r5 = upvalueValues[upvalues[3]]', 'r3 = r4 + r5', 'r4 = upvalueValues[upvalues[4]]', 'ReturnVal = r3 + r4',
            'r3 = upvalueValues[upvalues[5]]', 'state = ReturnVal + r3', 'ReturnVal = { state }', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "shared forwarded captures were not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = 10\nlocal v2 = 20\nlocal v3 = function(v3)\n    return function(v4)\n        return function()\n            print(v1, v2, 30, v3, v4)\n            return ((((v1 + v2) + 30) + v3) + v4)\n        end\n    end\nend\nlocal v4 = v3(40)\nlocal v5 = v4(50)\nprint(v5())\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = allocUpvalue()', 'state = 1', 'upvalueValues[r1] = state',
            'state = createClosure5(2, { r1 })', 'r2 = state', 'r1 = releaseUpvalue(r1)', 'r2 = nil', 'ReturnVal = {}', 'state = nil',
        ],
        2: [
            'ReturnVal = upvalueValues[upvalues[1]]', 'r3 = 1', 'state = ReturnVal + r3',
            'upvalueValues[upvalues[1]] = state', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "writable captured local was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = 1\nlocal v2 = function()\n    v1 = (v1 + 1)\nend\n');
}

{
    const source = vmStatesSource({
        1: [
            'r2 = allocUpvalue()', 'state = 1', 'upvalueValues[r2] = state',
            'state = createClosure0(2, { r2 })', 'r3 = state',
            'state = createClosure3(3, { r2 })', 'r4 = state',
            'state = r3()', 'state = r4()', 'ReturnVal = "print"', 'state = _env[ReturnVal]',
            'r1 = upvalueValues[r2]', 'ReturnVal = state(r1)',
            'r3 = nil', 'r4 = nil', 'r2 = releaseUpvalue(r2)', 'ReturnVal = {}', 'state = nil',
        ],
        2: [
            'ReturnVal = upvalueValues[upvalues[1]]', 'r5 = 1', 'state = ReturnVal + r5',
            'upvalueValues[upvalues[1]] = state', 'ReturnVal = {}', 'state = nil',
        ],
        3: [
            'ReturnVal = upvalueValues[upvalues[1]]', 'r5 = 10', 'state = ReturnVal + r5',
            'upvalueValues[upvalues[1]] = state', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "shared writable captured local was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = 1\nlocal v2 = function()\n    v1 = (v1 + 1)\nend\nlocal v3 = function()\n    v1 = (v1 + 10)\nend\nv2()\nv3()\nprint(v1)\n');
}

{
    const source = vmStatesSource({
        1: [
            'r4 = args', 'r1 = 3', 'state = 1', 'r2 = state', 'ReturnVal = 2', 'r3 = ReturnVal',
            'ReturnVal = "print"', 'state = _env[ReturnVal]', 'ReturnVal = state(r2, r3, r1)',
            'r2 = nil', 'r3 = nil', 'r1 = nil', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "promotion-only local was not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1 = 3\nlocal v2 = 1\nlocal v3 = 2\nprint(v2, v3, v1)\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = "print"', 'state = _env[r1]', 'r1 = 3', 'ReturnVal = state(r1)',
            'r1 = nil', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "ambiguous pre-lifetime TEMP reuse must fail closed");
}

{
    const source = vmStatesSource({
        1: [
            'r3 = "math"', 'ReturnVal = _env[r3]', 'r3 = "random"', 'state = ReturnVal[r3]',
            'r3 = 1', 'r2 = 2', 'ReturnVal = state(r3, r2)', 'r3 = ReturnVal',
            'state = "abc"', 'r2 = state', 'r1 = not r3', 'ReturnVal = "print"', 'state = _env[ReturnVal]',
            'r4 = -r3', 'r5 = #r2', 'r6 = args', 'r2 = nil', 'r3 = nil',
            'ReturnVal = state(r1, r4, r5)', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "unary expressions were not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1 = math.random(1, 2)\nlocal v2 = "abc"\nprint((not v1), (-v1), (#v2))\n');
}

{
    const source = vmStatesSource({
        1: [
            'state = createClosure0(2, {})', 'r1 = state', 'r1 = nil', 'ReturnVal = {}', 'state = nil',
        ],
        2: [
            'r1 = args[1]', 'r2 = not r1', 'r3 = -r1', 'r4 = "abc"', 'r5 = #r4',
            'ReturnVal = { r2, r3, r5 }', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "closure unary expressions were not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = function(v1)\n    return (not v1), (-v1), (#"abc")\nend\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = args', 'r6 = 2', 'r11 = 5', 'r7 = 7', 'r12 = 6', 'r8 = "x"',
            'r2 = { [r8] = r11, r12, r7 }', 'state = 10', 'r9 = state', 'r3 = "nested"',
            'ReturnVal = 1', 'r5 = 123', 'r4 = "name"', 'r10 = "hello"',
            'state = { ReturnVal, r6, [r4] = r10, [r9] = r5, [r3] = r2 }', 'r6 = state',
            'r2 = 10', 'r3 = "name"', 'r11 = "nested"', 'ReturnVal = "print"', 'r9 = nil', 'state = _env[ReturnVal]',
            'r10 = 1', 'r4 = r6[r10]', 'r5 = 2', 'r10 = r6[r5]', 'r5 = r6[r3]', 'r3 = r6[r2]',
            'r8 = r6[r11]', 'r11 = "x"', 'r2 = r8[r11]', 'r12 = "nested"', 'r11 = r6[r12]',
            'r6 = nil', 'r12 = 1', 'r8 = r11[r12]', 'ReturnVal = state(r4, r10, r5, r3, r2, r8)',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "mixed/nested table constructor was not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1 = 10\nlocal t1 = { 1, 2, name = "hello", [v1] = 123, nested = { x = 5, 6, 7 } }\nprint(t1[1], t1[2], t1.name, t1[10], t1.nested.x, t1.nested[1])\n');
}


{
    const source = vmStatesSource({
        1: [
            'r2 = args', 'state = "abc"', 'r4 = state', 'r1 = "sub"', 'r1 = r4[r1]',
            'ReturnVal = "print"', 'state = _env[ReturnVal]', 'r3 = 2', 'r5 = { r1(r4, r3) }',
            'r4 = nil', 'ReturnVal = state(unpack(r5))', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "local namecall was not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1 = "abc"\nprint(v1:sub(2))\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = args', 'state = "abc"', 'r4 = state', 'ReturnVal = "print"', 'state = _env[ReturnVal]',
            'r2 = "sub"', 'r2 = r4[r2]', 'r5 = 2', 'r2 = r2(r4, r5)', 'r3 = "upper"',
            'r3 = r2[r3]', 'r4 = nil', 'r5 = { r3(r2) }', 'ReturnVal = state(unpack(r5))',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "chained namecall was not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1 = "abc"\nprint(v1:sub(2):upper())\n');
}

{
    const source = vmStatesSource({
        1: [
            'r3 = args', 'state = createClosure5(2, {})', 'r2 = state', 'ReturnVal = "print"',
            'state = _env[ReturnVal]', 'r1 = "abc"', 'r4 = { r2(r1) }',
            'ReturnVal = state(unpack(r4))', 'r2 = nil', 'ReturnVal = {}', 'state = nil',
        ],
        2: [
            'r3 = args[1]', 'r2 = "sub"', 'r2 = r3[r2]', 'ReturnVal = 2',
            'state = { r2(r3, ReturnVal) }', 'ReturnVal = { unpack(state) }', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "closure namecall was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = function(v1)\n    return v1:sub(2)\nend\nprint(v1("abc"))\n');
}


{
    const source = vmStatesSource({
        1: [
            'ReturnVal = {}', 'r8 = ReturnVal', 'state = 1', 'r2 = state', 'state = 2', 'r2 = state',
            'r6 = r2', 'ReturnVal = "x"', 'r8[ReturnVal] = r6', 'ReturnVal = "y"', 'r6 = ReturnVal',
            'ReturnVal = 3', 'r8[r6] = ReturnVal', 'r1 = "print"', 'ReturnVal = _env[r1]',
            'r4 = "x"', 'r3 = r8[r4]', 'r7 = "y"', 'r4 = r8[r7]', 'r5 = args',
            'r6 = nil', 'r8 = nil', 'r1 = ReturnVal(r2, r3, r4)', 'r2 = nil', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "local assignment/field writes were not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local t1 = {}\nlocal v1 = 1\nv1 = 2\nlocal v2 = v1\nt1.x = v2\nv2 = "y"\nt1[v2] = 3\nprint(v1, t1.x, t1.y)\n');
}

{
    const source = vmStatesSource({
        1: [
            'ReturnVal = "foo"', 'state = 123', '_env[ReturnVal] = state', 'r1 = "print"',
            'ReturnVal = _env[r1]', 'r2 = "foo"', 'r4 = _env[r2]', 'r1 = ReturnVal(r4)',
            'r3 = args', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "global assignment was not recovered");
    assert.strictEqual(result.source, 'foo = 123\nprint(foo)\n');
}

{
    const source = vmStatesSource({
        1: [
            'r7 = allocUpvalue()', 'state = {}', 'upvalueValues[r7] = state', 'state = createClosure4(2, { r7 })',
            'r3 = state', 'ReturnVal = 5', 'state = r3(ReturnVal)', 'r4 = args', 'r1 = "y"', 'r3 = nil',
            'ReturnVal = "print"', 'state = _env[ReturnVal]', 'r6 = upvalueValues[r7]', 'r2 = "x"',
            'r5 = r6[r2]', 'r2 = upvalueValues[r7]', 'r6 = r2[r1]', 'ReturnVal = state(r5, r6)',
            'ReturnVal = {}', 'r7 = releaseUpvalue(r7)', 'state = nil',
        ],
        2: [
            'state = upvalueValues[upvalues[1]]', 'r4 = args[1]', 'r7 = r4', 'ReturnVal = "x"',
            'state[ReturnVal] = r7', 'state = upvalueValues[upvalues[1]]', 'r3 = 1', 'r7 = r4 + r3',
            'ReturnVal = "y"', 'state[ReturnVal] = r7', 'r4 = nil', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "captured table field writes were not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.source, 'local v1 = {}\nlocal v2 = function(v2)\n    v1.x = v2\n    v1.y = (v2 + 1)\nend\nv2(5)\nprint(v1.x, v1.y)\n');
}

{
    const source = vmStatesSource({
        1: [
            'r4 = {}', 'r1 = "make"', 'state = _env[r1]', 'r2 = state()',
            'ReturnVal = "x"', 'r3 = 1', 'r2[ReturnVal] = r3',
            'r4 = nil', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "call-derived field-write base must fail closed");
}
{
    const source = vmStatesSource({
        1: [
            'r1 = args',
            'state = nil', 'r2 = state',
            'r4 = nil',
            'ReturnVal = nil', 'r3 = ReturnVal',
            'r3 = nil', 'r2 = nil', 'r4 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "nil-only source locals were not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1\nlocal v2\nlocal v3\n');
}

{
    const source = vmStatesSource({
        1: [
            'state = true', 'r4 = state',
            'ReturnVal = "math"', 'state = _env[ReturnVal]', 'r1 = state',
            'state = nil', 'r5 = state',
            'ReturnVal = "newproxy"', 'state = _env[ReturnVal]', 'r2 = state',
            'ReturnVal = "floor"', 'state = r1[ReturnVal]', 'r3 = state',
            'r1 = nil', 'r2 = nil', 'r3 = nil', 'r4 = nil', 'r5 = nil',
            'r6 = args', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "canonical local declaration ordering did not recover");
    assert.strictEqual(result.source, 'local v2 = math\nlocal v4 = newproxy\nlocal v5 = v2.floor\nlocal v1 = true\nlocal v3\n');
}


{
    const source = vmSource([
        'r1 = nil',
        'r2 = -989881 + (194066 - (-677277 - 118539))',
        'r1 = r2',
        'r1 = nil',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "nested constant arithmetic made one-state recovery order-sensitive");
    assert.strictEqual(result.mode, "fresh-register-locals");
}

{
    const source = vmStatesSource({
        1: [
            'ReturnVal = "b"', 'state = _env[ReturnVal]', 'r1 = state',
            'ReturnVal = "c"', 'state = _env[ReturnVal]', 'r2 = state',
            'state = r1 and 2 or 3', 'ReturnVal = r1',
        ],
        2: [
            'r3 = ReturnVal', 'state = createClosure0(4, {})', 'r4 = state',
            'r3 = nil', 'r4 = nil', 'ReturnVal = {}', 'state = nil',
        ],
        3: ['ReturnVal = r2', 'state = 2'],
        4: ['ReturnVal = { 1 }', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "multi-state logical root with child closure was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.strictEqual(result.closureCount, 1);
    assert.strictEqual(result.source, 'local v1 = (b or c)\nlocal v2 = function()\n    return 1\nend\n');
}

{
    const source = vmStatesSource({
        1: [
            'ReturnVal = "f"', 'state = _env[ReturnVal]', 'r1 = state',
            'ReturnVal = "g"', 'state = _env[ReturnVal]', 'r2 = state',
            'r3 = { r1() }', 'r4 = { r2() }',
            'ReturnVal = r3[1]', 'r5 = r3[2]', 'r6 = r4[2]', 'r7 = r4[3]',
            'r3 = ReturnVal', 'ReturnVal = r4[1]', 'r4 = ReturnVal',
            'r7 = nil', 'r5 = nil', 'r6 = nil', 'r3 = nil', 'r4 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "interleaved multi-return packs were not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    const fIndex = result.source.indexOf(' = f()');
    const gIndex = result.source.indexOf(' = g()');
    assert.ok(fIndex >= 0 && gIndex > fIndex, "multi-return call creation order was not preserved");
}

{
    const source = vmStatesSource({
        1: [
            'r1 = allocUpvalue()', 'state = createClosure0(2, {})', 'upvalueValues[r1] = state',
            'state = createClosure(3, { r1 })', 'r2 = state', 'r1 = releaseUpvalue(r1)',
            'r2 = nil', 'ReturnVal = {}', 'state = nil',
        ],
        2: [
            'ReturnVal = { 1, 2 }', 'state = nil',
        ],
        3: [
            'r3 = { select(1, unpack(args)) }', 'state = upvalueValues[upvalues[1]]',
            'ReturnVal = { state(unpack(r3)) }', 'ReturnVal = { unpack(ReturnVal) }', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "captured vararg TCO/RETURN_ALL was not recovered");
    assert.strictEqual(result.mode, "fresh-closure-entry");
    assert.ok(result.source.includes('function(...)\n    return v1(...)\nend'), result.source);
}


{
    const source = vmStatesSource({
        1: [
            'RegisterOverflow[25] = "math"',
            'RegisterOverflow[26] = _env[RegisterOverflow[25]]',
            'RegisterOverflow[27] = RegisterOverflow[26]',
            'RegisterOverflow[27] = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "RegisterOverflow propagation/lifetime cleanup was not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'local v1 = math\n');
}

{
    const source = vmStatesSource({
        1: [
            'RegisterOverflow[25] = 1',
            'RegisterOverflow[26] = 2',
            'RegisterOverflow[27] = { RegisterOverflow[25], RegisterOverflow[26] }',
            'RegisterOverflow[28] = RegisterOverflow[27]',
            'RegisterOverflow[28] = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "RegisterOverflow table construction was not recovered");
    assert.strictEqual(result.source, 'local t1 = { 1, 2 }\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = 25',
            'RegisterOverflow[r1] = 1',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "dynamic RegisterOverflow indexes must fail closed");
    assert.match(result.reason, /dynamic RegisterOverflow index/);
}


{
    const source = vmStatesSource({
        1: [
            'r1 = nil',
            'r2 = 1', 'r2 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "dead single nil register state should be ignored");
    assert.strictEqual(result.source, 'local v1 = 1\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = nil', 'r1 = 123',
            'ReturnVal = "print"', 'state = _env[ReturnVal]', 'ReturnVal = state(r1)',
            'r1 = nil', 'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "dead initial nil before one meaningful source lifetime was not removed");
    assert.strictEqual(result.source, 'local v1 = 123\nprint(v1)\n');
}

{
    const source = vmStatesSource({
        1: ['r1 = nil', 'state = 2'],
        2: ['r2 = r1', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "unsupported multi-state program unexpectedly recovered");
    assert.match(result.reason, /unsupported multi-state control flow \(2 normalized states\)/);
    assert.match(result.reason, /state 1/);
    assert.match(result.reason, /root statement/);
}


{
    const source = vmStatesSource({
        1: [
            'r1 = "f"', 'r2 = _env[r1]',
            'state = r2()', 'state = r2()',
            'r4 = { r2() }', 'r5 = { r2() }',
            'ReturnVal = r4[2]', 'r6 = r5[3]',
            'r3 = state', 'state = r4[1]', 'r4 = state',
            'state = r5[1]', 'r7 = ReturnVal', 'ReturnVal = r5[2]', 'r8 = ReturnVal', 'r5 = state',
            'r6 = nil', 'r7 = nil', 'r8 = nil', 'r3 = nil', 'r4 = nil', 'r5 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "interleaved call results and multi-return packs were not recovered");
    assert.strictEqual(result.mode, "fresh-register-locals");
    assert.strictEqual(result.source, 'f()\nlocal v1 = f()\nlocal v2, v3 = f()\nlocal v4, v5, v6 = f()\n');
}

{
    const source = vmStatesSource({
        1: [
            'ReturnVal = "gbl"', 'state = _env[ReturnVal]',
            'ReturnVal = "NEW_GLOBAL"', '_env[ReturnVal] = state',
            'r4 = state', 'ReturnVal = r2', 'state = r2 and 2 or 3', 'r2 = nil',
        ],
        2: [
            'state = r4', 'r5 = state', 'r3 = not r2', 'r4 = ReturnVal',
            'state = r3 and 4 or 5', 'ReturnVal = r3',
        ],
        3: ['ReturnVal = r1', 'state = 2'],
        4: [
            'state = r5', 'r5 = ReturnVal',
            'r1 = nil', 'r2 = nil', 'r1 = nil', 'r4 = nil', 'r5 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
        5: ['ReturnVal = r1', 'state = 4'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "logical flattening with POS preservation and shuffled nil initialization was not recovered");
    assert.strictEqual(result.mode, "fresh-multistate-logical");
    assert.strictEqual(result.source, 'NEW_GLOBAL = gbl\nlocal v1\nlocal v2\nlocal v3 = (v1 or v2)\nlocal v4 = ((not v1) or v2)\n');
}

{
    const source = vmStatesSource({
        1: [
            'r1 = allocUpvalue()', 'state = nil', 'upvalueValues[r1] = state',
            'r2 = "f"', 'r3 = _env[r2]', 'r4 = { r3() }',
            'ReturnVal = r4[2]', 'r6 = ReturnVal',
            'r5 = upvalueValues[r1]',
            'state = r4[1]', 'r7 = state', 'r4 = state',
            'r6 = nil', 'r7 = nil',
            'r1 = releaseUpvalue(r1)',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "proven root upvalue read interrupted a pending multi-return pack");
    assert.ok(result.source.includes('local v1'), result.source);
    assert.ok(result.source.includes(' = f()'), result.source);
}
{
    const source = vmStatesSource({
        1: [
            'r1 = "f"', 'r2 = _env[r1]', 'r3 = { r2() }',
            'ReturnVal = r3[2]', 'r4 = ReturnVal',
            'r5 = allocUpvalue()',
            'state = r3[1]', 'r6 = state', 'r3 = state',
            'upvalueValues[r5] = r6',
            'r4 = nil', 'r6 = nil', 'r5 = releaseUpvalue(r5)',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "upvalue allocation interrupted a pending multi-return pack");
    assert.ok(result.source.includes(' = f()'), result.source);
}
{
    const source = vmStatesSource({
        1: [
            'r1 = allocUpvalue()', 'state = nil', 'upvalueValues[r1] = state',
            'r2 = "f"', 'r3 = _env[r2]', 'r4 = { r3() }',
            'ReturnVal = r4[2]', 'r5 = ReturnVal',
            'r1 = releaseUpvalue(r1)',
            'state = r4[1]', 'r6 = state', 'r4 = state',
            'r5 = nil', 'r6 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "proven upvalue release interrupted a pending multi-return pack");
    assert.ok(result.source.includes(' = f()'), result.source);
}
{
    const source = vmStatesSource({
        1: [
            'r1 = "f"', 'r2 = _env[r1]', 'r3 = { r2() }',
            'ReturnVal = r3[2]', 'r4 = ReturnVal',
            'ReturnVal = createClosure4(2, {})', 'r5 = ReturnVal',
            'state = r3[1]', 'r6 = state', 'r3 = state',
            'r4 = nil', 'r6 = nil', 'r5 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
        2: ['state = 123', 'ReturnVal = { state }', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "closure creation interrupted a pending multi-return pack");
    const callIndex = result.source.indexOf('= f()');
    const closureIndex = result.source.indexOf('function()');
    assert.ok(callIndex >= 0 && closureIndex > callIndex, result.source);
}
{
    const source = vmStatesSource({
        1: [
            'r1 = "f"', 'r2 = _env[r1]', 'r7 = "g"', 'r8 = _env[r7]',
            'r3 = { r2() }', 'ReturnVal = r3[2]', 'r4 = ReturnVal',
            'ReturnVal = createClosure4(2, {})', 'r5 = ReturnVal',
            'r9 = { r8() }', 'ReturnVal = r9[2]', 'r10 = ReturnVal',
            'state = r3[1]', 'r6 = state', 'r3 = state',
            'state = r9[1]', 'r11 = state', 'r9 = state',
            'r4 = nil', 'r6 = nil', 'r10 = nil', 'r11 = nil', 'r5 = nil',
            'ReturnVal = {}', 'state = nil',
        ],
        2: ['state = 123', 'ReturnVal = { state }', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "later pack crossed deferred closure barrier");
    const firstCall = result.source.indexOf('= f()');
    const closure = result.source.indexOf('function()');
    const secondCall = result.source.indexOf('= g()');
    assert.ok(firstCall >= 0 && closure > firstCall && secondCall > closure, result.source);
}
console.log("fresh beta direct-global-call regression: ok");
