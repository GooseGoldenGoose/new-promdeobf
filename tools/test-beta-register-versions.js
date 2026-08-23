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
            ReturnVal = 1
            state = r1 == ReturnVal
            state = state and 2 or 3
        end
        if state == 2 then
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end`;

const result = versionVmBlockRegisters(source, parseLua(source, "<beta-register-test>"));
assert.equal(result.found, true);
assert.equal(result.applied, true);
assert.equal(result.blockCount, 2);
assert.equal(result.versionedAssignmentCount, 7);
assert.equal(result.preservedFinalWrites, 3);
assert.equal(result.skippedAssignments, 0);
assert.deepEqual(result.mapping, [
    { originalName: "ReturnVal", baseName: "r_v1" },
    { originalName: "state", baseName: "r_v2" },
    { originalName: "r1", baseName: "r_v3" },
    { originalName: "r2", baseName: "r_v4" },
]);
assert(result.source.includes('local r_v1_1 = "warn"'));
assert(result.source.includes("local r_v2_1 = _env[r_v1_1]"));
assert(result.source.includes('local r_v3_1 = "gg"'));
assert(result.source.includes("local r_v1_2 = r_v2_1(r_v3_1)"));
assert(result.source.includes("local r_v4_1 = args"));
assert(result.source.includes("local r_v1_3 = 1"));
assert(result.source.includes("local r_v2_2 = r_v3_1 == r_v1_3"));
assert(result.source.includes("state = r_v2_2 and 2 or 3"));
assert(result.source.includes("ReturnVal = {}"));
assert(result.source.includes("state = nil"));
assert(!result.source.includes("local r_v1_4 = {}"));
parseLua(result.source, "<beta-register-test-output>");

const crossStateSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r2 = 3123
            state = flag and 2 or 3
        end
        if state == 2 then
            ReturnVal = consume(r2)
            r2 = 3
            state = 3
        end
        if state == 3 then
            ReturnVal = consume2(r2)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const crossStateResult = versionVmBlockRegisters(
    crossStateSource,
    parseLua(crossStateSource, "<beta-cross-state-test>")
);
assert.equal(crossStateResult.found, true);
assert.equal(crossStateResult.applied, true);
assert.equal(crossStateResult.cfgComplete, true);
assert.equal(crossStateResult.crossBlockVersionCount, 1);
assert(crossStateResult.source.includes("local r_v1_1 = 3123"));
assert.equal((crossStateResult.source.match(/local r_v1_1/g) || []).length, 1);
assert(crossStateResult.source.includes("consume(r_v1_1)"));
assert(crossStateResult.source.includes("consume2(r2)"));
assert(!crossStateResult.source.includes("consume2(r_v1_1)"));
assert(!crossStateResult.source.includes("consume2(r_v1_2)"));
parseLua(crossStateResult.source, "<beta-cross-state-test-output>");
const lifetimeSource = `vm = function(state, args, upvalues, gcProxy)
    local r2, ReturnVal
    while state do
        if state == 1 then
            r2 = 10
            state = 2
        end
        if state == 2 then
            ReturnVal = consume(r2)
            r2 = 20
            state = 3
        end
        if state == 3 then
            ReturnVal = consume2(r2)
            r2 = nil
            state = 4
        end
        if state == 4 then
            r2 = 30
            ReturnVal = consume3(r2)
            r2 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const lifetimeResult = versionVmBlockRegisters(
    lifetimeSource,
    parseLua(lifetimeSource, "<beta-lifetime-test>")
);
assert.equal(lifetimeResult.found, true);
assert.equal(lifetimeResult.applied, true);
assert.equal(lifetimeResult.cfgComplete, true);
const r2Base = lifetimeResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(r2Base);
assert(lifetimeResult.source.includes(`local ${r2Base}_1 = 10`));
assert(lifetimeResult.source.includes(`consume(${r2Base}_1)`));
assert(lifetimeResult.source.includes(`${r2Base}_1 = 20`));
assert(lifetimeResult.source.includes(`consume2(${r2Base}_1)`));
assert(lifetimeResult.source.includes(`${r2Base}_1 = nil`));
assert(lifetimeResult.source.includes(`local ${r2Base}_2 = 30`));
assert(lifetimeResult.source.includes(`consume3(${r2Base}_2)`));
assert(lifetimeResult.source.includes(`${r2Base}_2 = nil`));
assert(!lifetimeResult.source.includes(`local ${r2Base}_1 = 20`));
parseLua(lifetimeResult.source, "<beta-lifetime-test-output>");

console.log("beta register versioning tests passed");
