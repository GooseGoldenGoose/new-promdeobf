const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { normalizeVmRegisterOverflow } = require("../passes/vm-register-overflow");

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
    const source = `
vm = function(state, args, upvalues, gcProxy)
    local RegisterOverflow = {}
    local ReturnVal, r1
    while state do
        if state == 1 then
            RegisterOverflow[1] = 1
            RegisterOverflow[2] = RegisterOverflow[1]
            r1 = RegisterOverflow[2]
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
`;
    const result = normalizeVmRegisterOverflow(source, parse(source));
    assert.strictEqual(result.applied, true);
    assert.strictEqual(result.slots, 2);
    assert.strictEqual(result.references, 4);
    assert.ok(!result.source.includes("RegisterOverflow"), result.source);
    assert.ok(result.source.includes("o1 = 1"), result.source);
    assert.ok(result.source.includes("o2 = o1"), result.source);
    assert.ok(result.source.includes("r1 = o2"), result.source);
}

{
    const source = `
vm = function(state, args, upvalues, gcProxy)
    local RegisterOverflow = {}
    local ReturnVal, r1, o1
    while state do
        if state == 1 then
            RegisterOverflow[1] = 1
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
`;
    const result = normalizeVmRegisterOverflow(source, parse(source));
    assert.strictEqual(result.applied, false);
    assert.match(result.reason, /collision/i);
}

console.log("vm register overflow scalarization regression: ok");
