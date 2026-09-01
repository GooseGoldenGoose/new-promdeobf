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
        "    local r1, r2, r3, r4, r5, r6, r7, ReturnVal",
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
    assert.strictEqual(result.mode, "fresh-captured-closure");
    assert.strictEqual(result.captureCount, 1);
    assert.strictEqual(result.source, 'local v1 = 123\nlocal v2 = function()\n    print(v1)\nend\nv2()\n');
}

console.log("fresh beta direct-global-call regression: ok");
