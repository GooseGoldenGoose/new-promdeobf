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

function schedule(source, returnName = null) {
    const statements = parseStatements(source);
    const result = scheduleStatementList(statements, "state", null, returnName);
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
    assert.strictEqual(out[out.length - 1], 'state = 3', 'direct numeric state transition did not remain at the state tail');
    assert.ok(out.indexOf('X = 2') < out.indexOf('state = 3'), 'unread write was left below the direct numeric transition');
    assert.ok(out.indexOf('A = 1') < out.indexOf('C = A'), 'active producer moved past its read');
    assert.ok(out.includes('X = 2'), 'unread write was deleted instead of scheduled');
}

{
    const source = [
        'A = 1',
        'state = 3',
        'X = state',
    ].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('state = 3') < out.indexOf('X = state'), 'numeric transition crossed a later state read');
}


{
    const source = [
        'A = 1',
        'C = A',
        'X = 2',
        'state = nil',
    ].join("\n");
    const out = schedule(source);
    assert.strictEqual(out[out.length - 1], 'state = nil', 'canonical stop anchor did not remain last');
    assert.ok(out.indexOf('X = 2') < out.indexOf('state = nil'), 'unread write moved past canonical stop anchor');
}

{
    const source = [
        'B = args[2]',
        'ReturnReg = { B }',
        'A = args[1]',
        'state = nil',
    ].join("\n");
    const out = schedule(source, "ReturnReg");
    assert.deepStrictEqual(out.slice(-3), [
        'A = args[1]',
        'ReturnReg = { B }',
        'state = nil',
    ], 'terminal return payload was not canonicalized immediately before state = nil');
}

{
    const source = [
        'Cell = allocUpvalue()',
        'Closure = makeClosure()',
        'ReturnReg = { Closure }',
        'upvalueValues[Cell] = args[1]',
        'state = nil',
    ].join("\n");
    const out = schedule(source, "ReturnReg");
    assert.deepStrictEqual(out.slice(-3), [
        'upvalueValues[Cell] = args[1]',
        'ReturnReg = { Closure }',
        'state = nil',
    ], 'terminal return payload did not move after proven upvalue initialization bookkeeping');
}

{
    const source = [
        'Closure = makeClosure()',
        'ReturnReg = { Closure }',
        'state = 2',
        'upvalueValues[Cell] = state',
        'state = nil',
    ].join("\n");
    const out = schedule(source, "ReturnReg");
    assert.deepStrictEqual(out.slice(-4), [
        'state = 2',
        'upvalueValues[Cell] = state',
        'ReturnReg = { Closure }',
        'state = nil',
    ], 'terminal return payload did not move after proven non-terminal POS bookkeeping');
}

{
    const source = [
        'B = args[2]',
        'ReturnReg = { B }',
        'A = f()',
        'state = nil',
    ].join("\n");
    const out = schedule(source, "ReturnReg");
    assert.ok(out.indexOf('ReturnReg = { B }') < out.indexOf('A = f()'), 'terminal return crossed an effectful tail');
}

{
    const source = [
        'B = 1',
        'ReturnReg = { B }',
        'B = 2',
        'state = nil',
    ].join("\n");
    const out = schedule(source, "ReturnReg");
    assert.ok(out.indexOf('ReturnReg = { B }') < out.indexOf('B = 2'), 'terminal return crossed a write to a returned register');
}



{
    const source = [
        'state = 1',
        'A = "print"',
        'B = _env[A]',
        'X = state',
        'state = 3',
    ].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('state = 1') + 1 === out.indexOf('X = state'), 'borrowed POS temp was not compacted next to its read');
    assert.strictEqual(out[out.length - 1], 'state = 3', 'final state transition lost its anchor');
}

function scheduleOverflow(source, overflowName = "Overflow") {
    const statements = parseStatements(source);
    const result = scheduleStatementList(statements, "state", overflowName);
    assert.strictEqual(result.safetyRejected, false);
    return labels(source, result.statements);
}

{
    const source = [
        "Overflow[1] = 10",
        "X = 2",
        "Y = Overflow[1]",
        "Z = Y",
    ].join("\n");
    const out = scheduleOverflow(source);
    assert.ok(out.indexOf("Overflow[1] = 10") + 1 === out.indexOf("Y = Overflow[1]"), "overflow producer was not compacted next to its read");
    assert.ok(out.indexOf("Overflow[1] = 10") < out.indexOf("Y = Overflow[1]"), "overflow producer crossed its read");
}

{
    const source = [
        "Overflow[1] = 10",
        "Overflow[2] = 20",
        "A = Overflow[1]",
        "B = Overflow[2]",
    ].join("\n");
    const out = scheduleOverflow(source);
    assert.ok(out.indexOf("Overflow[1] = 10") < out.indexOf("A = Overflow[1]"));
    assert.ok(out.indexOf("Overflow[2] = 20") < out.indexOf("B = Overflow[2]"));
}

{
    const source = [
        "Overflow[1] = 10",
        "A = Overflow[1]",
        "Overflow[1] = 30",
        "B = Overflow[1]",
    ].join("\n");
    const out = scheduleOverflow(source);
    assert.ok(out.indexOf("Overflow[1] = 10") < out.indexOf("A = Overflow[1]"), "overflow producer crossed its read");
    assert.ok(out.indexOf("A = Overflow[1]") < out.indexOf("Overflow[1] = 30"), "overflow overwrite crossed prior read");
}

{
    const source = [
        "Other[1] = 10",
        "X = 2",
        "Y = Other[1]",
    ].join("\n");
    const out = scheduleOverflow(source, "Overflow");
    assert.ok(out.indexOf("Other[1] = 10") < out.indexOf("Y = Other[1]"), "ordinary table access was treated as overflow storage");
}


{
    const source = [
        'A = 1',
        'K = "print"',
        'F = _env[K]',
        'X = 2',
        'R = F(A)',
        'A = nil',
    ].join("\n");
    const out = schedule(source);
    assert.strictEqual(out[0], 'A = 1', 'source-variable producer with final nil cleanup was pulled into the call temp chain');
    assert.ok(out.indexOf('A = 1') < out.indexOf('R = F(A)'), 'source-variable definition moved past its use');
    assert.strictEqual(out[out.length - 1], 'A = nil', 'source-variable cleanup did not remain at lifetime tail');
}

{
    const source = [
        'X = 2',
        'K = "print"',
        'A = 1',
        'F = _env[K]',
        'R = F(A)',
    ].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('K = "print"') + 1 === out.indexOf('F = _env[K]'), 'GETGLOBAL temp chain was not canonicalized');
    assert.ok(out.indexOf('A = 1') + 1 === out.indexOf('R = F(A)'), 'literal argument temp was not canonicalized toward the call');
}

{
    const source = [
        'X = 2',
        'A = 1',
        'K = "print"',
        'F = _env[K]',
        'R = F(A, X)',
        'A = nil',
    ].join("\n");
    const out = schedule(source);
    assert.ok(out.indexOf('A = 1') < out.indexOf('X = 2'), 'TEMP could not cross a non-boundary source lifetime write');
    assert.ok(out.indexOf('X = 2') + 1 === out.indexOf('R = F(A, X)'), 'call-local TEMP was not compacted beside its consumer');
    assert.ok(out.indexOf('R = F(A, X)') < out.indexOf('A = nil'), 'TEMP scheduling crossed the source lifetime cleanup boundary');
}

console.log("vm register scheduler regression: ok");
