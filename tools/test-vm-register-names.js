const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { renameVmRegisterBindings } = require("../passes/vm-register-names");

function parse(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        comments: true,
        scope: true,
        locations: true,
        ranges: true,
    });
}

{
    const source = [
        "local vm, unpack",
        "vm = function(state, args, upvalues, gcProxy)",
        "    local q, R, V",
        "    while state do",
        "        q = 1",
        "        R = {q}",
        "        V = obj.q",
        "        state = nil",
        "    end",
        "    state = #gcProxy",
        "    return unpack(R)",
        "end",
        "local R = 99",
        "return outer(unpack(R), unpack(q))",
    ].join("\n");

    const result = renameVmRegisterBindings(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.returnRegisterOldName, "R");
    assert.strictEqual(result.returnRegisterName, "ReturnVal");
    assert.deepStrictEqual(
        result.mapping.map(item => [item.oldName, item.newName]),
        [["q", "r1"], ["R", "ReturnVal"], ["V", "r2"]],
    );
    assert.ok(result.source.includes("local r1, ReturnVal, r2"));
    assert.ok(result.source.includes("ReturnVal = {r1}"));
    assert.ok(result.source.includes("r2 = obj.q"), "member key was renamed as a register");
    assert.ok(result.source.includes("return unpack(ReturnVal)"));
    assert.ok(result.source.includes("local R = 99"), "unrelated outer R binding was renamed");
    assert.ok(result.source.includes("return outer(unpack(R), unpack(q))"), "unpack outside vm was modified");
}

{
    const source = [
        "local vm, unpack",
        "vm = function(state, args, upvalues, gcProxy)",
        "    local q, R",
        "    while state do",
        "        do",
        "            local q = 2",
        "            print(q)",
        "        end",
        "        R = {}",
        "        state = nil",
        "    end",
        "    state = #gcProxy",
        "    return unpack(R)",
        "end",
    ].join("\n");
    const result = renameVmRegisterBindings(source, parse(source));
    assert.strictEqual(result.applied, false);
    assert.ok(/shadowed/.test(result.reason));
}

console.log("vm register naming regression: ok");
