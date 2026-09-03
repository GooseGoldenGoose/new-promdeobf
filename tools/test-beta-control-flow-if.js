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
    // Explicit `else { if ... }` has an inner join before the outer join.
    // Recover the nested structure and do not flatten it into elseif.
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
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if a then\n    print("A")\nelse\n    if b then\n        print("B")\n    else\n        print("C")\n    end\nend\n');
    assert.doesNotMatch(result.source, /elseif b/);
}

{
    // User shape: top-level if/elseif with call conditions and an explicit
    // nested one-sided if in the final else. The inner join (state 8) must
    // survive as nested structure before reaching outer join state 4.
    const source = vmStatesSource({
        1: ['state = true', 'state = state and 2 or 3', 'r1 = args'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "E"', 'ReturnVal = state(r2)', 'state = 4'],
        3: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "ASDAS"', 'ReturnVal = state(r2)', 'state = ReturnVal and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "W"', 'ReturnVal = state(r2)', 'state = 4'],
        6: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "ADS"', 'ReturnVal = state(r2)', 'state = ReturnVal and 7 or 8'],
        7: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "GG"', 'ReturnVal = state(r2)', 'state = 8'],
        8: ['state = 4'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if true then\n    print("E")\nelseif print("ASDAS") then\n    print("W")\nelse\n    if print("ADS") then\n        print("GG")\n    end\nend\n');
}


{
    // Nested elseif chain: all inner chain leaves share the outer false marker
    // and converge at their own inner join before the outer join.
    const source = vmStatesSource({
        1: ['r1 = "root"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "ROOT"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "a"', 'state = _env[r1]', 'state = state and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 7'],
        6: ['r1 = "b"', 'state = _env[r1]', 'state = state and 8 or 9'],
        7: ['state = 4'],
        8: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 7'],
        9: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "C"', 'ReturnVal = state(r1)', 'state = 7'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if root then\n    print("ROOT")\nelse\n    if a then\n        print("A")\n    elseif b then\n        print("B")\n    else\n        print("C")\n    end\nend\n');
}

{
    // Nested elseif whose final else contains another distinct-join if/else.
    // This proves recursive composition rather than one fixed nesting depth.
    const source = vmStatesSource({
        1: ['r1 = "root"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "ROOT"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "a"', 'state = _env[r1]', 'state = state and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 7'],
        6: ['r1 = "b"', 'state = _env[r1]', 'state = state and 8 or 9'],
        7: ['state = 4'],
        8: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 7'],
        9: ['r1 = "deep"', 'state = _env[r1]', 'state = state and 10 or 11'],
        10: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "D1"', 'ReturnVal = state(r1)', 'state = 12'],
        11: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "D2"', 'ReturnVal = state(r1)', 'state = 12'],
        12: ['state = 7'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if root then\n    print("ROOT")\nelse\n    if a then\n        print("A")\n    elseif b then\n        print("B")\n    else\n        if deep then\n            print("D1")\n        else\n            print("D2")\n        end\n    end\nend\n');
}


{
    // Same generalized nested-elseif proof on the outer true branch. The
    // shared marker prefix polarity must not matter.
    const source = vmStatesSource({
        1: ['r1 = "root"', 'state = _env[r1]', 'state = state and 3 or 2'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "ROOT-FALSE"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "a"', 'state = _env[r1]', 'state = state and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 7'],
        6: ['r1 = "b"', 'state = _env[r1]', 'state = state and 8 or 9'],
        7: ['state = 4'],
        8: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 7'],
        9: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "C"', 'ReturnVal = state(r1)', 'state = 7'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if root then\n    if a then\n        print("A")\n    elseif b then\n        print("B")\n    else\n        print("C")\n    end\nelse\n    print("ROOT-FALSE")\nend\n');
}


{
    // Top-level elseif chain without a final else: the final false path reaches
    // the join with no branch effects and should emit no else clause.
    const source = vmStatesSource({
        1: ['r1 = "a"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "b"', 'state = _env[r1]', 'state = state and 5 or 4'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 4'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if a then\n    print("A")\nelseif b then\n    print("B")\nend\n');
}

{
    // Same no-final-else chain nested under an outer false branch.
    const source = vmStatesSource({
        1: ['r1 = "root"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "ROOT"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['r1 = "a"', 'state = _env[r1]', 'state = state and 5 or 6'],
        4: ['ReturnVal = {}', 'state = nil'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 7'],
        6: ['r1 = "b"', 'state = _env[r1]', 'state = state and 8 or 7'],
        7: ['state = 4'],
        8: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 7'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if root then\n    print("ROOT")\nelse\n    if a then\n        print("A")\n    elseif b then\n        print("B")\n    end\nend\n');
}

{
    // A cleanup-backed register with multiple branch definitions is one
    // persistent source binding when every path reaches its cleanup and the
    // merged binding is read after the join.
    const source = vmStatesSource({
        1: ['r1 = 0', 'ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "COND"', 'ReturnVal = state(r2)', 'state = ReturnVal and 2 or 3', 'r3 = args'],
        2: ['r1 = 1', 'state = 4'],
        3: ['r1 = 2', 'state = 4'],
        4: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "X"', 'ReturnVal = state(r2, r1)', 'r1 = nil', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'local v1 = 0\nif print("COND") then\n    v1 = 1\nelse\n    v1 = 2\nend\nprint("X", v1)\n');
}

{
    // Persistent table identity survives the join while each branch mutates a
    // field. The table must not be versioned or duplicated per path.
    const source = vmStatesSource({
        1: ['r2 = 0', 'ReturnVal = "x"', 'state = { [ReturnVal] = r2 }', 'r1 = state', 'ReturnVal = "print"', 'state = _env[ReturnVal]', 'r3 = "COND"', 'ReturnVal = state(r3)', 'state = ReturnVal and 2 or 3', 'r4 = args'],
        2: ['ReturnVal = 1', 'state = "x"', 'r1[state] = ReturnVal', 'state = 4'],
        3: ['ReturnVal = 2', 'state = "x"', 'r1[state] = ReturnVal', 'state = 4'],
        4: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "x"', 'r3 = r1[r2]', 'r2 = "T"', 'ReturnVal = state(r2, r3)', 'r1 = nil', 'ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'local v1 = { x = 0 }\nif print("COND") then\n    v1.x = 1\nelse\n    v1.x = 2\nend\nprint("T", v1.x)\n');
}

{
    // A branch-local binding and a sibling condition reuse the same physical
    // register. Source scope must live in the path environment, not in a
    // process-global physical-register local set.
    const source = vmStatesSource({
        1: ['r2 = "root"', 'r3 = _env[r2]', 'state = r3 and 2 or 3', 'r4 = args'],
        2: ['r1 = 10', 'ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "A"', 'ReturnVal = state(r2, r1)', 'state = 4'],
        3: ['r2 = "b"', 'r1 = _env[r2]', 'state = r1 and 5 or 6'],
        4: ['r1 = nil', 'state = 7'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "B"', 'ReturnVal = state(r2)', 'state = 8'],
        6: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "C"', 'ReturnVal = state(r2)', 'state = 8'],
        7: ['ReturnVal = {}', 'state = nil'],
        8: ['state = 7'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if root then\n    local v1 = 10\n    print("A", v1)\nelse\n    if b then\n        print("B")\n    else\n        print("C")\n    end\nend\n');
}

{
    // A cleanup-backed table created inside one branch remains one branch-local
    // object across multiple member reads before its cleanup.
    const source = vmStatesSource({
        1: ['r2 = "root"', 'r3 = _env[r2]', 'state = r3 and 2 or 3', 'r4 = args'],
        2: ['r1 = { 1, 2 }', 'r2 = 1', 'r3 = r1[r2]', 'r2 = 2', 'r4 = r1[r2]', 'ReturnVal = "print"', 'state = _env[ReturnVal]', 'ReturnVal = state(r3, r4)', 'r1 = nil', 'state = 4'],
        3: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r2 = "skip"', 'ReturnVal = state(r2)', 'state = 4'],
        4: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if root then\n    local v1 = { 1, 2 }\n    print(v1[1], v1[2])\nelse\n    print("skip")\nend\n');
}


{
    // Two independent root conditionals are a proven source sequence only when
    // the second branch starts on the unique non-branching continuation from
    // the first root join. A straight-line effect between them stays in order.
    const source = vmStatesSource({
        1: ['r1 = "a"', 'state = _env[r1]', 'state = state and 2 or 3'],
        2: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "A"', 'ReturnVal = state(r1)', 'state = 4'],
        3: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "B"', 'ReturnVal = state(r1)', 'state = 4'],
        4: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "MID"', 'ReturnVal = state(r1)', 'r1 = "c"', 'state = _env[r1]', 'state = state and 5 or 6'],
        5: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "C"', 'ReturnVal = state(r1)', 'state = 7'],
        6: ['ReturnVal = "print"', 'state = _env[ReturnVal]', 'r1 = "D"', 'ReturnVal = state(r1)', 'state = 7'],
        7: ['ReturnVal = {}', 'state = nil'],
    });
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.mode, "fresh-simple-if");
    assert.strictEqual(result.source, 'if a then\n    print("A")\nelse\n    print("B")\nend\nprint("MID")\nif c then\n    print("C")\nelse\n    print("D")\nend\n');
}

console.log("fresh beta simple-if regression: ok");
