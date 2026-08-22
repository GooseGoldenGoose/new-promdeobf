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
    assert.deepStrictEqual(schedule(source), [
        'A = "print"',
        'C = _env[A]',
        'B = "arg"',
        'D = C(B)',
        'X = 1',
    ]);
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
    const source = ['A = 1', 'X = 2', 'A = 3', 'C = A'].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = 1') < out.indexOf('A = 3'), 'WAW order changed');
}

{
    const source = ['A = f()', 'X = 1', 'B = g()', 'C = A', 'D = B'].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = f()') < out.indexOf('B = g()'), 'effectful call order changed');
}

console.log("vm register scheduler regression: ok");
