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

function vmStatesSource(states) {
    const lines = [
        "vm = function(state, args, upvalues, gcProxy)",
        "    local r1, r2, r3, r4, ReturnVal",
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
    const source = vmStatesSource({
        1: ['r1 = "flag"', 'state = _env[r1]', 'state = state and 2 or 3', 'r2 = args'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = true', 'ReturnVal = state(r1)', 'state = 3'],
        3: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, "if flag then\n    print(true)\nend\n");
}

{
    // r1 is reused as a TEMP before becoming the cleanup-backed source local
    // that owns the if condition. This guards the real Medium handoff shape.
    const source = vmStatesSource({
        1: [
            'r2 = "flag"', 'r1 = _env[r2]', 'ReturnVal = true',
            'state = r1 == ReturnVal', 'r1 = state', 'state = r1 and 2 or 3',
        ],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = true', 'ReturnVal = state(r2)', 'state = 3'],
        3: ['r1 = nil', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, "local v1 = (flag == true)\nif v1 then\n    print(true)\nend\n");
}

{
    // TESTSET/logical merge must remain owned by the existing logical matcher.
    const source = vmStatesSource({
        1: ['r1 = "b"', 'r2 = _env[r1]', 'state = r2 and 2 or 3', 'ReturnVal = r2'],
        2: ['r2 = ReturnVal', 'r2 = nil', 'ReturnVal = {}', 'state = nil'],
        3: ['r1 = "c"', 'r2 = _env[r1]', 'ReturnVal = r2', 'state = 2'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-multistate-logical");
    assert.strictEqual(result.source, "local v1 = (b or c)\n");
}

{
    // Both branch paths contain proven source effects and converge at state 4.
    const source = vmStatesSource({
        1: ['r1 = "flag"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = true', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = false', 'ReturnVal = state(r1)', 'state = 4'],
        4: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, "if flag then\n    print(true)\nelse\n    print(false)\nend\n");
}

{
    // Cleanup-backed local condition must remain before the if/else and clean at join.
    const source = vmStatesSource({
        1: [
            'r2 = "flag"', 'r1 = _env[r2]', 'ReturnVal = true',
            'state = r1 == ReturnVal', 'r1 = state', 'state = r1 and 2 or 3',
        ],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = true', 'ReturnVal = state(r2)', 'state = 4'],
        3: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = false', 'ReturnVal = state(r2)', 'state = 4'],
        4: ['r1 = nil', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, "local v1 = (flag == true)\nif v1 then\n    print(true)\nelse\n    print(false)\nend\n");
}

{
    // Identical-looking effects on both sides still belong to their branches;
    // they must not be mistaken for work that happened before the branch.
    const source = vmStatesSource({
        1: ['r1 = "flag"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = true', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = true', 'ReturnVal = state(r1)', 'state = 4'],
        4: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, "if flag then\n    print(true)\nelse\n    print(true)\nend\n");
}

{
    // `elseif` is the same-join chain shape: outer true body and both second
    // condition leaves jump directly to the same final join.
    const source = vmStatesSource({
        1: ['r1 = "a"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "b"', 'state = _env[r1]', 'state = state and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 4'],
        6: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "C"', 'ReturnVal = state(r1)', 'state = 4'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if a then\n    print("A")\nelseif b then\n    print("B")\nelse\n    print("C")\nend\n');
}

{
    // Multiple elseif clauses are recovered by marker depth, not a fixed state ID/count.
    const source = vmStatesSource({
        1: ['r1 = "a"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 7'],
        3: ['r1 = "b"', 'state = _env[r1]', 'state = state and 4 or 5'],
        4: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 7'],
        5: ['r1 = "c"', 'state = _env[r1]', 'state = state and 6 or 8'],
        6: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "C"', 'ReturnVal = state(r1)', 'state = 7'],
        7: ['ReturnVal = {}', 'state = nil'],
        8: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "D"', 'ReturnVal = state(r1)', 'state = 7'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if a then\n    print("A")\nelseif b then\n    print("B")\nelseif c then\n    print("C")\nelse\n    print("D")\nend\n');
}

{
    // Explicit `else { if ... }` has an inner join before the outer join and
    // must not be flattened into elseif.
    const source = vmStatesSource({
        1: ['r1 = "a"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "b"', 'state = _env[r1]', 'state = state and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 7'],
        6: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "C"', 'ReturnVal = state(r1)', 'state = 7'],
        7: ['state = 4'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, false, "nested else-if was flattened into elseif");
}

console.log("fresh beta simple-if regression: ok");
