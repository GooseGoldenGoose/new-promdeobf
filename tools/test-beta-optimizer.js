const assert = require("assert");
const { parseLuaStructural } = require("../main");
const { optimizeBetaSource } = require("../passes/beta-optimizer");

function optimize(source) {
    const result = optimizeBetaSource(source);
    parseLuaStructural(result.source, "<beta-optimizer-test-output>");
    return result;
}

const printHi = `--headers
local _env = getfenv()
local args = { ... }
--body
local r_v1_1 = "print"
local r_v2_1 = _env[r_v1_1]
local r_v3_1 = "hi"
local r_v1_2 = r_v2_1(r_v3_1)
local r_v4_1 = args
return`;
const printResult = optimize(printHi);
assert(printResult.applied);
assert(printResult.source.includes('print("hi")'));
assert(!printResult.source.includes("local _env"));
assert(!printResult.source.includes("local args"));
assert(!/\br_v\d+_\d+\b/.test(printResult.source));
assert.equal(printResult.stats.globalFolds, 1);
assert.equal(printResult.stats.deadCallResults, 1);

const effectOrder = optimize(`local a = f()\ng()\nprint(a)`);
assert(effectOrder.source.includes("local a = f()"));
assert(effectOrder.source.indexOf("f()") < effectOrder.source.indexOf("g()"));

const deadCall = optimize(`local a = f()\nreturn`);
assert(deadCall.source.includes("f()"));
assert(!deadCall.source.includes("local a"));

const literalMove = optimize(`local a = "x"\ng()\nprint(a)`);
assert(literalMove.source.includes('print("x")'));
assert(!literalMove.source.includes("local a"));

const aliasMutation = optimize(`local x = 1\nlocal a = x\nx = 2\nprint(a)`);
assert(aliasMutation.source.includes("local a = x"));

const globalBarrier = optimize(`local p = print\ng()\np("x")`);
assert(globalBarrier.source.includes("local p = print"));

const envSetfenv = optimize(`local _env = getfenv()\nlocal p = _env["print"]\nsetfenv(1, other)\np("x")`);
assert(envSetfenv.source.includes('_env["print"]'));

const deadTable = optimize(`local args = { ... }\nprint("x")`);
assert(!deadTable.source.includes("local args"));
assert(deadTable.source.includes('print("x")'));

console.log("beta optimizer tests passed");