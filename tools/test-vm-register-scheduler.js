const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { scheduleStatementList } = require("../passes/vm-register-scheduler");

function parseStatements(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        comments: false,
        scope: true,
        locations: true,
        ranges: true,
    }).body;
}

function labels(source, statements) {
    return statements.map(statement => source.slice(statement.range[0], statement.range[1]).trim());
}

function schedule(source) {
    const statements = parseStatements(source);
    const result = scheduleStatementList(statements, "state");
    assert.strictEqual(result.safetyRejected, false);
    return labels(source, result.statements);
}

{
    const source = [
        'A = "print"',
        'X = 1',
        'B = "arg"',
        'C = _env[A]',
        'D = C(B)',
    ].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = "print"') + 1 === out.indexOf('C = _env[A]'), 'A producer not adjacent to C');
    assert.ok(out.indexOf('B = "arg"') + 1 === out.indexOf('D = C(B)'), 'B producer not adjacent to D');
}

{
    const source = ['A = 1', 'B = A', 'C = B'].join("\n");
    assert.deepStrictEqual(schedule(source), ['A = 1', 'B = A', 'C = B']);
}

{
    const source = ['A = B', 'B = 1', 'C = A'].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = B') < out.indexOf('B = 1'), 'WAR order changed');
}

{
    const source = ['A = f()', 'X = 2', 'A = 3', 'C = A'].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = f()') < out.indexOf('A = 3'), 'effectful WAW order changed');
}

{
    const source = ['A = f()', 'X = 1', 'B = g()', 'C = A', 'D = B'].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = f()') < out.indexOf('B = g()'), 'effectful call order changed');
}

{
    const source = [
        'B = "print"',
        'X = f()',
        'Y = 1',
        'G = _env[B]',
    ].join("\n");
    assert.deepStrictEqual(schedule(source), [
        'X = f()',
        'B = "print"',
        'G = _env[B]',
        'Y = 1',
    ]);
}

{
    const source = ['A = 1', 'X = 2', 'A = 3', 'C = A'].join("\n");
    assert.deepStrictEqual(schedule(source), ['A = 1', 'A = 3', 'X = 2', 'C = A']);
}

{
    const source = ['A = 1', 'B = A', 'A = 3', 'C = A'].join("\n");
    const out = schedule(source);
    assert.ok(out.includes('A = 1'), 'store read before overwrite was removed');
    assert.ok(out.indexOf('A = 1') < out.indexOf('B = A'), 'producer moved past its read');
}

{
    const source = [
        'D = 20',
        'G = 2',
        'z = D + G',
        'B = "print"',
        'G = _env[B]',
        'D = z',
        'Q = D',
    ].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('z = D + G') + 1 === out.indexOf('D = z'), 'identifier copy was not pulled next to its producer');
    assert.ok(out.indexOf('B = "print"') + 1 === out.indexOf('G = _env[B]'), 'literal producer was not sunk next to its read');
}

{
    const source = [
        'A = 1',
        'C = A',
        'X = 2',
        'B = f()',
        'state = 3',
    ].join("\n");
    const out = schedule(source);
    assert.strictEqual(out[out.length - 1], 'X = 2', 'unread pure write was not sunk to the state tail');
    assert.ok(out.indexOf('state = 3') < out.indexOf('X = 2'), 'unread write stopped at the state assignment instead of the state-body tail');
    assert.ok(out.indexOf('A = 1') < out.indexOf('C = A'), 'active producer moved past its read');
    assert.ok(out.includes('X = 2'), 'unread write was deleted instead of scheduled');
}

console.log("vm register scheduler regression: ok");
