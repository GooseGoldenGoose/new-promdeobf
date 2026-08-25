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

const packedTwo = optimize(`local t = { f() }
local a = t[1]
local b = t[2]
print(a, b)`);
assert(packedTwo.source.includes("local a, b = f()"));
assert(!packedTwo.source.includes("{ f() }"));
assert(!packedTwo.source.includes("t[1]"));
assert(!packedTwo.source.includes("t[2]"));
assert.equal(packedTwo.stats.multiReturnTableCollapses, 1);
assert.equal(packedTwo.stats.multiReturnSlotsRecovered, 2);
assert.equal(packedTwo.stats.multiReturnPlaceholders, 0);

const packedOnlySecond = optimize(`local t = { f() }
local b = t[2]
print(b)`);
assert(/local __beta_unused_return_\d+, b = f\(\)/.test(packedOnlySecond.source));
assert(!packedOnlySecond.source.includes("t[2]"));
assert.equal(packedOnlySecond.stats.multiReturnTableCollapses, 1);
assert.equal(packedOnlySecond.stats.multiReturnSlotsRecovered, 1);
assert.equal(packedOnlySecond.stats.multiReturnPlaceholders, 1);

const packedOnlyThird = optimize(`local t = { f() }
local c = t[3]
print(c)`);
assert(/local __beta_unused_return_\d+, __beta_unused_return_\d+, c = f\(\)/.test(packedOnlyThird.source));
assert.equal(packedOnlyThird.stats.multiReturnPlaceholders, 2);

const packedSparse = optimize(`local t = { f() }
local a = t[1]
local c = t[3]
print(a, c)`);
assert(/local a, __beta_unused_return_\d+, c = f\(\)/.test(packedSparse.source));
assert(!packedSparse.source.includes("t[1]"));
assert(!packedSparse.source.includes("t[3]"));

const packedOutOfOrder = optimize(`local t = { f() }
local b = t[2]
local a = t[1]
print(a, b)`);
assert(packedOutOfOrder.source.includes("local a, b = f()"));
assert(!packedOutOfOrder.source.includes("local a = t[1]"));
assert(!packedOutOfOrder.source.includes("local b = t[2]"));

const packedAcrossEffect = optimize(`local t = { f() }
g()
local a = t[1]
print(a)`);
assert(packedAcrossEffect.source.includes("local a = f()"));
assert(packedAcrossEffect.source.indexOf("f()") < packedAcrossEffect.source.indexOf("g()"));
assert(packedAcrossEffect.source.indexOf("g()") < packedAcrossEffect.source.indexOf("print(a)"));

const packedPcall = optimize(`local fn = function() return 1 / "hejsks" end
local t = { pcall(fn) }
local ok = t[1]
local err = t[2]
print(ok, err)`);
assert(packedPcall.source.includes("local ok, err = pcall(fn)"));
assert(!packedPcall.source.includes("{ pcall(fn) }"));
assert(!packedPcall.source.includes("t[1]"));
assert(!packedPcall.source.includes("t[2]"));

const packedPcallOnlySecond = optimize(`local fn = function() return 1 / "hejsks" end
local t = { pcall(fn) }
local err = t[2]
print(err)`);
assert(/local __beta_unused_return_\d+, err = pcall\(fn\)/.test(packedPcallOnlySecond.source));
assert(!packedPcallOnlySecond.source.includes("t[2]"));

const packedMethodCall = optimize(`local t = { obj:run() }
local second = t[2]
print(second)`);
assert(/local __beta_unused_return_\d+, second = obj:run\(\)/.test(packedMethodCall.source));

const placeholderCollision = optimize(`local __beta_unused_return_1 = "keep"
local t = { f() }
local b = t[2]
print(__beta_unused_return_1, b)`);
assert(!placeholderCollision.source.includes("local __beta_unused_return_1, b = f()"));
assert(/local __beta_unused_return_2, b = f\(\)/.test(placeholderCollision.source));

const packedShadowBarrier = optimize(`local a = "outer"
local t = { f() }
print(a)
local a = t[1]
print(a)`);
assert.equal(packedShadowBarrier.stats.multiReturnTableCollapses, 0);
assert(packedShadowBarrier.source.includes("local t = { f() }"));
assert(packedShadowBarrier.source.includes("local a = t[1]"));

const packedCaptureBarrier = optimize(`local t = { f() }
local g = function() return a end
local a = t[1]
print(g(), a)`);
assert.equal(packedCaptureBarrier.stats.multiReturnTableCollapses, 0);
assert(packedCaptureBarrier.source.includes("local a = t[1]"));

const packedEscapeBarrier = optimize(`local t = { f() }
use(t)
local a = t[1]
print(a)`);
assert.equal(packedEscapeBarrier.stats.multiReturnTableCollapses, 0);
assert(packedEscapeBarrier.source.includes("use(t)"));

const packedDynamicBarrier = optimize(`local t = { f() }
local a = t[i]
print(a)`);
assert.equal(packedDynamicBarrier.stats.multiReturnTableCollapses, 0);
assert(packedDynamicBarrier.source.includes("t[i]"));

const packedDuplicateSlotBarrier = optimize(`local t = { f() }
local a = t[1]
local b = t[1]
print(a, b)`);
assert.equal(packedDuplicateSlotBarrier.stats.multiReturnTableCollapses, 0);
assert(packedDuplicateSlotBarrier.source.includes("t[1]"));

const packedWriteBarrier = optimize(`local t = { f() }
t[1] = 9
local a = t[1]
print(a)`);
assert.equal(packedWriteBarrier.stats.multiReturnTableCollapses, 0);
assert(packedWriteBarrier.source.includes("t[1] = 9"));

const packedLengthBarrier = optimize(`local t = { f() }
local n = #t
local a = t[1]
print(n, a)`);
assert.equal(packedLengthBarrier.stats.multiReturnTableCollapses, 0);
assert(packedLengthBarrier.source.includes("#t"));

const packedExtractedButUnusedFirst = optimize(`local t = { f() }
local a = t[1]
local b = t[2]
print(b)`);
assert(/local __beta_unused_return_\d+, b = f\(\)/.test(packedExtractedButUnusedFirst.source));
assert(!packedExtractedButUnusedFirst.source.includes("local a, b = f()"));
assert.equal(packedExtractedButUnusedFirst.stats.multiReturnUnusedTargets, 1);

const packedExtractedButUnusedFirstTwo = optimize(`local t = { f() }
local a = t[1]
local b = t[2]
local c = t[3]
print(c)`);
assert(/local __beta_unused_return_\d+, __beta_unused_return_\d+, c = f\(\)/.test(packedExtractedButUnusedFirstTwo.source));
assert.equal(packedExtractedButUnusedFirstTwo.stats.multiReturnUnusedTargets, 2);

console.log("beta optimizer tests passed");
