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

console.log("fresh beta direct-global-call regression: ok");
