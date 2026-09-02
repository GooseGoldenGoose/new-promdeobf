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
        'state = 1',
        'r2 = state',
        'ReturnVal = "print"',
        'state = _env[ReturnVal]',
        'ReturnVal = state(r2)',
        'r2 = nil',
        'r1 = args',
        'ReturnVal = {}',
        'state = nil',
    ]);
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "source-local VAR lifetime was mistaken for a plain call TEMP");
}

{
    const source = [
        "vm = function(state, args, upvalues, gcProxy)",
        "    local r1, r2, r3, r4, ReturnVal",
        "    while state do",
        "        if state <= 1 then",
        "            if state == 1 then",
        "                state = {}",
        "                r1 = createClosure1(2, {})",
        "                r3 = state",
        "                ReturnVal = 1",
        "                r4 = 2",
        "                state = { ReturnVal, r4 }",
        "                r3 = state",
        "                r4 = \"se\"",
        "                ReturnVal = { [r4] = r1 }",
        "                r3 = ReturnVal",
        "                ReturnVal = {}",
        "                r4 = \"se\"",
        "                r4 = r3[r4]",
        "                r4 = r4(r3)",
        "                r3 = nil",
        "                r2 = args",
        "                state = nil",
        "            end",
        "        else",
        "            if state == 2 then",
        "                ReturnVal = {}",
        "                state = nil",
        "            end",
        "        end",
        "    end",
        "    state = #gcProxy",
        "    return unpack(ReturnVal)",
        "end",
    ].join("\n");
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, "cleanup-backed table VAR with reassignment/namecall was not recovered");
    assert.strictEqual(result.mode, "fresh-owned-local-table");
    assert.strictEqual(result.source, "local t1 = {}\nt1 = { 1, 2 }\nt1 = { se = function() end }\nt1:se()\n");
}
console.log("fresh beta direct-global-call regression: ok");
