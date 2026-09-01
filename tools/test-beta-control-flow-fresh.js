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

console.log("fresh beta direct-global-call regression: ok");
