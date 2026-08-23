const assert = require("assert");
const { parseLua } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");

const source = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            ReturnVal = "warn"
            state = _env[ReturnVal]
            r1 = "gg"
            ReturnVal = state(r1)
            r2 = args
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end`;

const result = versionVmBlockRegisters(source, parseLua(source, "<beta-register-test>"));
assert.equal(result.found, true);
assert.equal(result.applied, true);
assert.equal(result.blockCount, 1);
assert.equal(result.versionedAssignmentCount, 2);
assert.equal(result.skippedAssignments, 0);
assert.deepEqual(result.mapping, [
    { originalName: "r1", baseName: "r_v1" },
    { originalName: "r2", baseName: "r_v2" },
]);
assert(result.source.includes('ReturnVal = "warn"'));
assert(result.source.includes("state = _env[ReturnVal]"));
assert(result.source.includes('local r_v1_1 = "gg"'));
assert(result.source.includes("ReturnVal = state(r_v1_1)"));
assert(result.source.includes("local r_v2_1 = args"));
assert(!result.mapping.some(item => item.originalName === "state" || item.originalName === "ReturnVal"));
parseLua(result.source, "<beta-register-test-output>");
console.log("beta register versioning tests passed");
