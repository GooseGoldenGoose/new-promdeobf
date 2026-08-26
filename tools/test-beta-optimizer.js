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

const envCapturedButOuterFold = optimize(`local _env = getfenv()
local f = function()
    return _env["warn"]
end
local p = _env["print"]
p("x")
print(f ~= nil)`);
assert(!envCapturedButOuterFold.source.includes('local _env = getfenv()'));
assert(!envCapturedButOuterFold.source.includes('_env["warn"]'));
assert(envCapturedButOuterFold.source.includes('return warn'));
assert(envCapturedButOuterFold.source.includes('print("x")'));
assert(!envCapturedButOuterFold.source.includes('local p = _env["print"]'));

const envCapturedNestedSetfenvBarrier = optimize(`local _env = getfenv()
local f = function()
    setfenv(1, other)
    return _env["print"]
end
return f`);
assert(envCapturedNestedSetfenvBarrier.source.includes('local _env = getfenv()'));
assert(envCapturedNestedSetfenvBarrier.source.includes('_env["print"]'));

const envCapturedNestedWriteBarrier = optimize(`local _env = getfenv()
local f = function()
    _env = other
    return _env["print"]
end
return f`);
assert(envCapturedNestedWriteBarrier.source.includes('local _env = getfenv()'));
assert(envCapturedNestedWriteBarrier.source.includes('_env["print"]'));

const envCapturedNestedShadowBarrier = optimize(`local _env = getfenv()
local f = function()
    local _env = other
    return _env["print"]
end
return f`);
assert(envCapturedNestedShadowBarrier.source.includes('local _env = other'));
assert(envCapturedNestedShadowBarrier.source.includes('_env["print"]'));

const envCapturedDeepFold = optimize(`local _env = getfenv()
local f = function()
    local g = function()
        return _env["warn"]
    end
    return g
end
return f`);
assert(!envCapturedDeepFold.source.includes('local _env = getfenv()'));
assert(!envCapturedDeepFold.source.includes('_env["warn"]'));
assert(envCapturedDeepFold.source.includes('return warn'));
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

const tinyFunctionWithNoise = optimize(`local fn = function(...)
${Array.from({ length: 140 }, (_, index) => index % 2 === 0 ? "    -- generated comment" : "").join("\n")}
    return 1, 2, 3
end
print(pcall(fn))`);
assert(!tinyFunctionWithNoise.source.includes("local fn = function"));
assert(tinyFunctionWithNoise.source.includes("pcall(function(...)"));
assert(tinyFunctionWithNoise.source.includes("return 1, 2, 3"));
assert.equal(tinyFunctionWithNoise.stats.smallFunctionInlines, 1);

const exactLimitFunctionBody = Array.from({ length: 97 }, (_, index) => `    touch(${index})`).join("\n");
const exactLimitFunction = optimize(`local fn = function()
${exactLimitFunctionBody}
    return 1
end
consume(fn)`);
assert(!exactLimitFunction.source.includes("local fn = function"));
assert(exactLimitFunction.source.includes("function()"));
assert.equal(exactLimitFunction.stats.smallFunctionInlines, 1);

const oversizedFunctionBody = Array.from({ length: 100 }, (_, index) => `    touch(${index})`).join("\n");
const oversizedFunction = optimize(`local fn = function()
${oversizedFunctionBody}
    return 1
end
consume(fn)`);
assert(oversizedFunction.source.includes("local fn = function"));
assert.equal(oversizedFunction.stats.smallFunctionInlines, 0);

const nonAdjacentFunction = optimize(`local fn = function()
    return 1
end
sideEffect()
consume(fn)`);
assert(!nonAdjacentFunction.source.includes("local fn = function"));
assert(nonAdjacentFunction.source.includes("function()"));
assert.equal(nonAdjacentFunction.stats.smallFunctionInlines, 1);

const nonAdjacentCapturedLocalFunction = optimize(`local flag = true
local fn = function()
    flag = true
end
local unrelated = 1
flag = false
local ok = pcall(fn)
print(ok, flag, unrelated)`);
assert(!nonAdjacentCapturedLocalFunction.source.includes("local fn = function"));
assert(nonAdjacentCapturedLocalFunction.source.includes("pcall(function()"));
assert.equal(nonAdjacentCapturedLocalFunction.stats.smallFunctionInlines, 1);

const nonAdjacentLocalShadowBarrier = optimize(`local value = 1
local fn = function()
    return value
end
local value = 2
print(value)
consume(fn, value)`);
assert(nonAdjacentLocalShadowBarrier.source.includes("local fn = function"));
assert.equal(nonAdjacentLocalShadowBarrier.stats.smallFunctionInlines, 0);

const nonAdjacentGlobalBindingBarrier = optimize(`local fn = function()
    return globalValue
end
sideEffect()
consume(fn)`);
assert(nonAdjacentGlobalBindingBarrier.source.includes("local fn = function"));
assert.equal(nonAdjacentGlobalBindingBarrier.stats.smallFunctionInlines, 0);

const zeroReturnPackedIifeForward = optimize(`local t = { (function()
    while true do
        if stop then break end
        tick()
    end
end)() }
return unpack(t)`);
assert(!zeroReturnPackedIifeForward.source.includes("local t ="));
assert(!zeroReturnPackedIifeForward.source.includes("unpack(t)"));
assert(zeroReturnPackedIifeForward.source.includes("return (function()"));
assert.equal(zeroReturnPackedIifeForward.stats.packedReturnForwardersCollapsed, 1);

const bareReturnPackedIifeForward = optimize(`local t = { (function()
    if flag then return end
end)() }
return unpack(t)`);
assert(!bareReturnPackedIifeForward.source.includes("local t ="));
assert.equal(bareReturnPackedIifeForward.stats.packedReturnForwardersCollapsed, 1);

const nilReturnPackedIifeBarrier = optimize(`local t = { (function()
    return nil
end)() }
return unpack(t)`);
assert(nilReturnPackedIifeBarrier.source.includes("local t ="));
assert(nilReturnPackedIifeBarrier.source.includes("return unpack(t)"));
assert.equal(nilReturnPackedIifeBarrier.stats.packedReturnForwardersCollapsed, 0);

const valueReturnPackedIifeBarrier = optimize(`local t = { (function()
    return 1
end)() }
return unpack(t)`);
assert(valueReturnPackedIifeBarrier.source.includes("local t ="));
assert.equal(valueReturnPackedIifeBarrier.stats.packedReturnForwardersCollapsed, 0);

const prometheusPackedReturnForward = optimize(`local callee = source
local t = { callee() }
return unpack(t)`);
assert(!prometheusPackedReturnForward.source.includes("local t ="));
assert(!prometheusPackedReturnForward.source.includes("return unpack(t)"));
assert(prometheusPackedReturnForward.source.includes("return source()"));
assert.equal(prometheusPackedReturnForward.stats.packedReturnForwardersCollapsed, 1);

const prometheusPackedReturnLocalUnpackBarrier = optimize(`local callee = source
local unpack = customUnpack
local t = { callee() }
return unpack(t)`);
assert(prometheusPackedReturnLocalUnpackBarrier.source.includes("local t ="));
assert(prometheusPackedReturnLocalUnpackBarrier.source.includes("return unpack(t)"));

const adjacentReturnedCallBaseInline = optimize(`local maker = source
local callee = maker()
local t = { callee() }
return unpack(t)`);
assert(!adjacentReturnedCallBaseInline.source.includes("local callee ="));
assert(!adjacentReturnedCallBaseInline.source.includes("local t ="));
assert(adjacentReturnedCallBaseInline.source.includes("return (source())()"));
assert.equal(adjacentReturnedCallBaseInline.stats.packedReturnForwardersCollapsed, 1);
assert.equal(adjacentReturnedCallBaseInline.stats.returnedCallBaseInlines, 1);

const packedUnpackForward = optimize(`local sink = print
local fn = function() return 1, 2, 3 end
local t = { pcall(fn) }
sink(unpack(t))`);
assert(!packedUnpackForward.source.includes("local t ="));
assert(!packedUnpackForward.source.includes("unpack(t)"));
assert(packedUnpackForward.source.includes("pcall(function()"));
assert(!packedUnpackForward.source.includes("{ pcall("));
assert.equal(packedUnpackForward.stats.multiReturnForwardersCollapsed, 1);
assert.equal(packedUnpackForward.stats.multiReturnTableCollapses, 1);

const packedUnpackDeadResultForward = optimize(`local sink = print
local fn = function() return 1, 2, 3 end
local t = { pcall(fn) }
local dead = sink(unpack(t))`);
assert(!packedUnpackDeadResultForward.source.includes("local t ="));
assert(!packedUnpackDeadResultForward.source.includes("unpack(t)"));
assert(packedUnpackDeadResultForward.source.includes("pcall(function()"));
assert.equal(packedUnpackDeadResultForward.stats.multiReturnForwardersCollapsed, 1);

const packedNestedLastArgumentForward = optimize(`local sink = consume
local middle = wrap
local inner = produce
local a = first
local b = second
local t1 = { inner() }
local t2 = { middle(unpack(t1)) }
sink(a, b, unpack(t2))`);
assert(!packedNestedLastArgumentForward.source.includes("local t1 ="));
assert(!packedNestedLastArgumentForward.source.includes("local t2 ="));
assert(!packedNestedLastArgumentForward.source.includes("unpack(t1)"));
assert(!packedNestedLastArgumentForward.source.includes("unpack(t2)"));
assert.equal(packedNestedLastArgumentForward.stats.multiReturnForwardersCollapsed, 2);
assert.equal(packedNestedLastArgumentForward.stats.multiReturnTableCollapses, 2);

const prometheusNamecallRecovery = optimize(`local obj = makeObject()
local method = obj["SetAttribute"]
local value = compute()
method(obj, "Key", value)`);
assert(!prometheusNamecallRecovery.source.includes("local method ="));
assert(prometheusNamecallRecovery.source.includes('obj:SetAttribute("Key", value)'));
assert.equal(prometheusNamecallRecovery.stats.namecallRecoveries, 1);

const prometheusNamecallWrongSelfBarrier = optimize(`local obj = makeObject()
local other = makeObject()
local method = obj["SetAttribute"]
method(other, "Key", 1)`);
assert(prometheusNamecallWrongSelfBarrier.source.includes("local method ="));
assert.equal(prometheusNamecallWrongSelfBarrier.stats.namecallRecoveries, 0);

const prometheusNamecallBaseRebindBarrier = optimize(`local obj = makeObject()
local method = obj["SetAttribute"]
obj = other
method(obj, "Key", 1)`);
assert(prometheusNamecallBaseRebindBarrier.source.includes("local method ="));
assert.equal(prometheusNamecallBaseRebindBarrier.stats.namecallRecoveries, 0);

const prometheusNamecallInvalidMethodBarrier = optimize(`local obj = makeObject()
local method = obj["not valid"]
method(obj, 1)`);
assert(prometheusNamecallInvalidMethodBarrier.source.includes("local method ="));
assert.equal(prometheusNamecallInvalidMethodBarrier.stats.namecallRecoveries, 0);

const prometheusNamecallCapturedBaseBarrier = optimize(`local obj = makeObject()
local method = obj["SetAttribute"]
local mutate = function() obj = other end
mutate()
method(obj, "Key", 1)`);
assert(prometheusNamecallCapturedBaseBarrier.source.includes("local method ="));
assert.equal(prometheusNamecallCapturedBaseBarrier.stats.namecallRecoveries, 0);

const packedFinalArgumentEffectfulPrefixBarrier = optimize(`local sink = consume
local t = { produce() }
sink(before(), unpack(t))`);
assert(packedFinalArgumentEffectfulPrefixBarrier.source.includes("unpack(t)"));
assert.equal(packedFinalArgumentEffectfulPrefixBarrier.stats.multiReturnForwardersCollapsed, 0);

const packedUnpackSelfAssignmentForward = optimize(`local outer = consume
local inner = produce
local t = { inner() }
t = outer(unpack(t))
print(t)`);
assert(!packedUnpackSelfAssignmentForward.source.includes("{ inner() }"));
assert(!packedUnpackSelfAssignmentForward.source.includes("unpack(t)"));
assert(packedUnpackSelfAssignmentForward.source.includes("local t = consume(produce())"));
assert.equal(packedUnpackSelfAssignmentForward.stats.multiReturnSelfAssignmentForwardersCollapsed, 1);

const packedUnpackSelfAssignmentExtraArgBarrier = optimize(`local outer = consume
local inner = produce
local t = { inner() }
t = outer(unpack(t), after())
print(t)`);
assert(packedUnpackSelfAssignmentExtraArgBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackSelfAssignmentExtraArgBarrier.stats.multiReturnSelfAssignmentForwardersCollapsed, 0);

const packedUnpackSelfAssignmentLocalUnpackBarrier = optimize(`local outer = consume
local inner = produce
local unpack = customUnpack
local t = { inner() }
t = outer(unpack(t))
print(t)`);
assert(packedUnpackSelfAssignmentLocalUnpackBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackSelfAssignmentLocalUnpackBarrier.stats.multiReturnSelfAssignmentForwardersCollapsed, 0);

const packedUnpackSelfAssignmentSelfTargetBarrier = optimize(`local inner = produce
local t = { inner() }
t = t(unpack(t))
print(t)`);
assert(packedUnpackSelfAssignmentSelfTargetBarrier.source.includes("t = t(unpack(t))"));
assert.equal(packedUnpackSelfAssignmentSelfTargetBarrier.stats.multiReturnSelfAssignmentForwardersCollapsed, 0);

const packedUnpackSelfAssignmentCapturedTargetBarrier = optimize(`local outer = consume
local mutate = function() outer = other end
local inner = function() mutate(); return 1 end
local t = { inner() }
t = outer(unpack(t))
print(t)`);
assert(packedUnpackSelfAssignmentCapturedTargetBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackSelfAssignmentCapturedTargetBarrier.stats.multiReturnSelfAssignmentForwardersCollapsed, 0);

const packedUnpackExtraArgumentBarrier = optimize(`local sink = print
local t = { f() }
sink(unpack(t), after())`);
assert(packedUnpackExtraArgumentBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackExtraArgumentBarrier.stats.multiReturnForwardersCollapsed, 0);

const packedUnpackEscapeBarrier = optimize(`local sink = print
local t = { f() }
use(t)
sink(unpack(t))`);
assert(packedUnpackEscapeBarrier.source.includes("use(t)"));
assert(packedUnpackEscapeBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackEscapeBarrier.stats.multiReturnForwardersCollapsed, 0);

const packedUnpackCapturedTargetBarrier = optimize(`local sink = print
local mutate = function() sink = warn end
local t = { f(mutate) }
sink(unpack(t))`);
assert(packedUnpackCapturedTargetBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackCapturedTargetBarrier.stats.multiReturnForwardersCollapsed, 0);

const packedUnpackLocalHelperBarrier = optimize(`local sink = print
local unpack = customUnpack
local t = { f() }
sink(unpack(t))`);
assert(packedUnpackLocalHelperBarrier.source.includes("unpack(t)"));
assert.equal(packedUnpackLocalHelperBarrier.stats.multiReturnForwardersCollapsed, 0);

const packedPcall = optimize(`local fn = function() return 1 / "hejsks" end
local t = { pcall(fn) }
local ok = t[1]
local err = t[2]
print(ok, err)`);
assert(packedPcall.source.includes("local ok, err = pcall(function()"));
assert(!packedPcall.source.includes("{ pcall("));
assert(!packedPcall.source.includes("t[1]"));
assert(!packedPcall.source.includes("t[2]"));

const packedPcallOnlySecond = optimize(`local fn = function() return 1 / "hejsks" end
local t = { pcall(fn) }
local err = t[2]
print(err)`);
assert(/local __beta_unused_return_\d+, err = pcall\(function\(\)/.test(packedPcallOnlySecond.source));
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


const genericImmediateGlobalAlias = optimize(`local iterator = next
for k, v in iterator, t, nil do
    print(k, v)
end`);
assert(/for k, v in next, t, nil do/.test(genericImmediateGlobalAlias.source));
assert(!genericImmediateGlobalAlias.source.includes("local iterator = next"));

const genericGlobalAliasGap = optimize(`local iterator = next
sideEffect()
for k, v in iterator, t, nil do
    print(k, v)
end`);
assert(genericGlobalAliasGap.source.includes("local iterator = next"));

const genericPairsTuple = optimize(`local f, s, c = pairs(t)
for k, v in f, s, c do
    print(k, v)
end`);
assert(/for k, v in pairs\(t\) do/.test(genericPairsTuple.source));
assert(!genericPairsTuple.source.includes("local f, s, c"));
assert.equal(genericPairsTuple.stats.genericForTupleInlines, 1);
assert.equal(genericPairsTuple.stats.genericForTupleLocalsRemoved, 3);

const genericNextTuple = optimize(`local f, s, c = next, t, nil
for k, v in f, s, c do
    print(k, v)
end`);
assert(/for k, v in next, t, nil do/.test(genericNextTuple.source));
assert(!genericNextTuple.source.includes("local f, s, c"));

const genericNextImplicitNil = optimize(`local f, s, c = next, t
for k, v in f, s, c do
    print(k, v)
end`);
assert(/for k, v in next, t do/.test(genericNextImplicitNil.source));

const genericCustomFactory = optimize(`local f, s, c = makeIterator(source)
for k, v in f, s, c do
    consume(k, v)
end`);
assert(/for k, v in makeIterator\(source\) do/.test(genericCustomFactory.source));

const genericMethodFactory = optimize(`local f, s, c = object:iterator()
for k, v in f, s, c do
    consume(k, v)
end`);
assert(/for k, v in object:iterator\(\) do/.test(genericMethodFactory.source));

const genericUsedAfterBarrier = optimize(`local f, s, c = makeIterator(source)
for k, v in f, s, c do
    consume(k, v)
end
print(f)`);
assert.equal(genericUsedAfterBarrier.stats.genericForTupleInlines, 0);
assert(genericUsedAfterBarrier.source.includes("local f, s, c = makeIterator(source)"));

const genericBodyUsesTuple = optimize(`local f, s, c = makeIterator(source)
for k, v in f, s, c do
    consume(f, k, v)
end`);
assert.equal(genericBodyUsesTuple.stats.genericForTupleInlines, 0);

const genericReorderedTuple = optimize(`local f, s, c = makeIterator(source)
for k, v in s, f, c do
    consume(k, v)
end`);
assert.equal(genericReorderedTuple.stats.genericForTupleInlines, 0);

const genericEffectGap = optimize(`local f, s, c = makeIterator(source)
sideEffect()
for k, v in f, s, c do
    consume(k, v)
end`);
assert.equal(genericEffectGap.stats.genericForTupleInlines, 0);
assert(genericEffectGap.source.indexOf("makeIterator(source)") < genericEffectGap.source.indexOf("sideEffect()"));

const genericCapturedTuple = optimize(`local f, s, c = makeIterator(source)
for k, v in f, s, c do
    local closure = function() return s end
    consume(closure, k, v)
end`);
assert.equal(genericCapturedTuple.stats.genericForTupleInlines, 0);

const genericFourRhsBarrier = optimize(`local f, s, c = next, t, nil, sideEffect()
for k, v in f, s, c do
    consume(k, v)
end`);
assert.equal(genericFourRhsBarrier.stats.genericForTupleInlines, 0);

const genericTwoLocalBarrier = optimize(`local f, s = makeIterator(source)
for k, v in f, s, nil do
    consume(k, v)
end`);
assert.equal(genericTwoLocalBarrier.stats.genericForTupleInlines, 0);

const whileSnapshotAlias = optimize(`local x = 1
local a = x
while check(a) do
    x = 2
end`);
assert(whileSnapshotAlias.source.includes("local a = x"));
assert(whileSnapshotAlias.source.includes("while check(a) do"));

const repeatSnapshotAlias = optimize(`local x = 1
local a = x
repeat
    x = x + 1
until done(a)`);
assert(repeatSnapshotAlias.source.includes("local a = x"));
assert(repeatSnapshotAlias.source.includes("until done(a)"));

const whileGlobalSnapshot = optimize(`local p = print
while again() do
    p("x")
end`);
assert(whileGlobalSnapshot.source.includes("local p = print"));
assert(whileGlobalSnapshot.source.includes('p("x")'));

const whileLiteralSnapshot = optimize(`local a = 3
while check(a) do
    tick()
end`);
assert(whileLiteralSnapshot.source.includes("local a = 3"));
assert(whileLiteralSnapshot.source.includes("while check(a) do"));

const innerLoopIterationAlias = optimize(`while again() do
    local x = current
    local a = x
    consume(a)
end`);
assert(!innerLoopIterationAlias.source.includes("local a = x"));
assert(innerLoopIterationAlias.source.includes("consume(x)"));

const naturalWhileLogical = optimize(`while A() and (B() or C()) do
    body()
end`);
assert(naturalWhileLogical.source.includes("while A() and (B() or C()) do"));
assert.equal(naturalWhileLogical.stats.whileConditionsCollapsed, 0);

const naturalRepeatLogical = optimize(`repeat
    body()
until A() or (B() and C())`);
assert(naturalRepeatLogical.source.includes("until A() or (B() and C())"));
assert.equal(naturalRepeatLogical.stats.repeatConditionsCollapsed, 0);

const deadCleanupBottomUpChain = optimize(`local a = sideEffect()
local b = a
local c = b`);
assert(deadCleanupBottomUpChain.source.includes("sideEffect()"));
assert(!deadCleanupBottomUpChain.source.includes("local a"));
assert(!deadCleanupBottomUpChain.source.includes("local b"));
assert(!deadCleanupBottomUpChain.source.includes("local c"));
assert.equal(deadCleanupBottomUpChain.stats.deadCallResults >= 1, true);

const nestedIfBlockCleanup = optimize(`if gate then
    local a = 3
    local b = a
    print(b)
end`);
assert(!nestedIfBlockCleanup.source.includes("local a = 3"));
assert(!nestedIfBlockCleanup.source.includes("local b"));
assert(nestedIfBlockCleanup.source.includes("print(3)"));

const whileLogicalLadder = optimize(`while true do
    local out
    local a = A()
    out = a
    if a then
        local inner
        local b = B()
        inner = b
        if not b then
            local c = C()
            inner = c
        end
        out = inner
    end
    if not out then
        break
    end
    body()
end`);
assert(whileLogicalLadder.source.includes("while (A()) and ((B()) or (C())) do"));
assert(!whileLogicalLadder.source.includes("while true do"));
assert.equal(whileLogicalLadder.stats.whileConditionsCollapsed, 1);

const repeatLogicalLadder = optimize(`repeat
    body()
    local out
    local a = A()
    out = a
    if a then
        local inner
        local b = B()
        inner = b
        if not b then
            local c = C()
            inner = c
        end
        out = inner
    end
until out`);
assert(repeatLogicalLadder.source.includes("until (A()) and ((B()) or (C()))"));
assert(!repeatLogicalLadder.source.includes("local out"));
assert.equal(repeatLogicalLadder.stats.repeatConditionsCollapsed, 1);

const whileLogicalAliasLeaf = optimize(`while true do
    local out
    local a = A()
    out = a
    if a then
        local inner
        local b = B()
        inner = b
        if not b then
            local snapshot = x
            local c = snapshot == 1
            inner = c
        end
        out = inner
    end
    if not out then break end
    x = x + 1
end`);
assert(whileLogicalAliasLeaf.source.includes("while (A()) and ((B()) or ((x) == 1)) do"));

const whileLogicalNearMiss = optimize(`while true do
    local out
    local a = A()
    out = a
    if a then
        local b = B()
        out = b
    end
    if not out then break end
    print(out)
end`);
assert(whileLogicalNearMiss.source.includes("while true do"));
assert.equal(whileLogicalNearMiss.stats.whileConditionsCollapsed, 0);

const repeatDiscardedAndPrecheck = optimize(`local right
local first = A()
right = B
if first then
    right()
end
repeat
    body()
until A() and right()`);
assert(!repeatDiscardedAndPrecheck.source.includes("local first = A()"));
assert(!repeatDiscardedAndPrecheck.source.includes("if first then"));
assert(repeatDiscardedAndPrecheck.source.includes("right = B"));
assert(repeatDiscardedAndPrecheck.source.includes("until A() and right()"));
assert.equal(repeatDiscardedAndPrecheck.stats.repeatPrechecksRemoved, 1);

const repeatDiscardedNestedPrecheck = optimize(`local first = A()
if first then
    local out
    local b = B()
    out = b
    if not b then
        local c = C()
        out = c
    end
end
repeat
    body()
until A() and (B() or C())`);
assert(!repeatDiscardedNestedPrecheck.source.includes("local first = A()"));
assert(!repeatDiscardedNestedPrecheck.source.includes("if first then"));
assert(repeatDiscardedNestedPrecheck.source.includes("until A() and (B() or C())"));
assert.equal(repeatDiscardedNestedPrecheck.stats.repeatPrechecksRemoved, 1);

const repeatPrecheckMismatch = optimize(`local first = A()
if first then
    C()
end
repeat
    body()
until A() and B()`);
assert(repeatPrecheckMismatch.source.includes("local first = A()"));
assert(repeatPrecheckMismatch.source.includes("if first then"));
assert.equal(repeatPrecheckMismatch.stats.repeatPrechecksRemoved, 0);

const whileLongLogicalLadder = optimize(`while true do
    local out
    local a = A()
    out = a
    if a then
        local chain
        local or1
        local b = B()
        or1 = b
        if not b then
            local or2
            local c = C()
            or2 = c
            if not c then
                local d = D()
                or2 = d
            end
            or1 = or2
        end
        chain = or1
        if or1 then
            local or3
            local e = E()
            or3 = e
            if not e then
                local f = F()
                or3 = f
            end
            chain = or3
        end
        out = chain
    end
    if not out then break end
    body()
end`);
assert(!whileLongLogicalLadder.source.includes("while true do"));
assert(whileLongLogicalLadder.source.includes("A()"));
assert(whileLongLogicalLadder.source.includes("B()"));
assert(whileLongLogicalLadder.source.includes("F()"));
assert.equal(whileLongLogicalLadder.stats.whileConditionsCollapsed, 1);

const deadUninitializedRepeatLocal = optimize(`local x = 0
repeat
    local unused
    local step = x + 1
    x = step
until x >= 2`);
assert(!deadUninitializedRepeatLocal.source.includes("local unused"));
assert(!deadUninitializedRepeatLocal.source.includes("local step"));
assert(/x\s*=\s*\(?x \+ 1\)?/.test(deadUninitializedRepeatLocal.source));

const nestedCapturedAliasCleanup = optimize(`local x = 1
local f = function()
    local snapshot = x
    local result = snapshot + 1
    return result
end
print(f())`);
assert(!nestedCapturedAliasCleanup.source.includes("local snapshot"));
assert(!nestedCapturedAliasCleanup.source.includes("local result"));
assert(/return\s+\(.*x.*\+ 1.*\)/.test(nestedCapturedAliasCleanup.source));

const nestedWriteOnlyCaptureBarrier = optimize(`local x = 1
local f = function()
    x = 2
end
f()
return x`);
assert(nestedWriteOnlyCaptureBarrier.source.includes("local x = 1"));
assert(nestedWriteOnlyCaptureBarrier.source.includes("x = 2"));
assert(!nestedWriteOnlyCaptureBarrier.source.includes("return 1"));

const scalarLoopSnapshotBarrier = optimize(`local x = 1
local snapshot = x + 1
while check(snapshot) do
    x = x + 1
end`);
assert(scalarLoopSnapshotBarrier.source.includes("local snapshot = x + 1"));
assert(scalarLoopSnapshotBarrier.source.includes("while check(snapshot) do"));

const scalarNonLeadingReadBarrier = optimize(`local temp = x + 1
local result = other + temp
print(result)`);
assert(scalarNonLeadingReadBarrier.source.includes("local temp = x + 1"));

const scalarShortCircuitRightBarrier = optimize(`local temp = x + 1
local result = false and temp
print(result)`);
assert(scalarShortCircuitRightBarrier.source.includes("local temp = x + 1"));
assert(scalarShortCircuitRightBarrier.source.includes("false and temp"));

const deferredLocalBasic = optimize(`local value = makeValue()
local x
sideEffect()
x = value
use(x, x)`);
assert(!/^local x\s*$/m.test(deferredLocalBasic.source));
assert(deferredLocalBasic.source.includes("local x = value"));
assert(deferredLocalBasic.source.indexOf("sideEffect()") < deferredLocalBasic.source.indexOf("local x = value"));
assert.equal(deferredLocalBasic.stats.deferredLocalInitializersFolded, 1);

const deferredLocalReadBarrier = optimize(`local x
print(x)
x = value
use(x)`);
assert(/^local x\s*$/m.test(deferredLocalReadBarrier.source));
assert(deferredLocalReadBarrier.source.includes("x = value"));

const deferredLocalCaptureBarrier = optimize(`local x
local f = function() return x end
x = value
print(f())`);
assert(!/^local x\s*$/m.test(deferredLocalCaptureBarrier.source));
assert(deferredLocalCaptureBarrier.source.includes("local x = value"));
assert(deferredLocalCaptureBarrier.source.includes("function() return x end"));
assert.equal(deferredLocalCaptureBarrier.stats.smallFunctionInlines, 1);
assert.equal(deferredLocalCaptureBarrier.stats.deferredLocalInitializersFolded, 1);

const deferredLocalSelfReadBarrier = optimize(`local x
x = x or fallback
print(x)`);
assert(/^local x\s*$/m.test(deferredLocalSelfReadBarrier.source));
assert(deferredLocalSelfReadBarrier.source.includes("x = x or fallback"));

const deferredLocalGotoBarrier = optimize(`local x
goto ready
::ready::
x = value
print(x)`);
assert(/^local x\s*$/m.test(deferredLocalGotoBarrier.source));
assert(deferredLocalGotoBarrier.source.includes("x = value"));

const repeatConditionLocalUse = optimize(`local x = 0
repeat
    x = x + 1
    local done
    done = x >= 2
until done
print(x)`);
assert(!repeatConditionLocalUse.source.includes("local done"));
assert(repeatConditionLocalUse.source.includes("until x >= 2"));
assert.equal(repeatConditionLocalUse.stats.deferredLocalInitializersFolded >= 1, true);
assert.equal(repeatConditionLocalUse.stats.repeatTailConditionTempsInlined, 1);


const directNilCleanupBeforeFold = optimize(`local temp = makeValue()
local real = temp
use(real)
real = nil`);
assert(!directNilCleanupBeforeFold.source.includes("real = nil"));
assert(directNilCleanupBeforeFold.source.includes("local real = makeValue()"));
assert(!directNilCleanupBeforeFold.source.includes("local temp"));
assert.equal(directNilCleanupBeforeFold.stats.directNilCleanupWritesRemoved, 1);
assert.equal(directNilCleanupBeforeFold.stats.adjacentCopyChainsFolded, 1);

const observedDirectNilMustStay = optimize(`local x = 1
x = nil
print(x)`);
assert(observedDirectNilMustStay.source.includes("x = nil"));

const capturedDirectNilMustStay = optimize(`local x = 1
local f = function() return x end
x = nil
return f`);
assert(capturedDirectNilMustStay.source.includes("x = nil"));

const nestedDirectNilFailsClosed = optimize(`local x = 1
if cond then
    x = nil
end
print(x)`);
assert(nestedDirectNilFailsClosed.source.includes("x = nil"));

const terminalNestedDirectNilCleanup = optimize(`if cond then
    local x = 1
    x = nil
    return
end`);
assert(!terminalNestedDirectNilCleanup.source.includes("x = nil"));
assert.equal(terminalNestedDirectNilCleanup.stats.directNilCleanupWritesRemoved, 1);

const terminalNestedCapturedNilMustStay = optimize(`if cond then
    local x = 1
    local f = function() return x end
    x = nil
    return f
end`);
assert(terminalNestedCapturedNilMustStay.source.includes("x = nil"));
assert.equal(terminalNestedCapturedNilMustStay.stats.directNilCleanupWritesRemoved, 0);

const ancestorTerminalRegisterRelease = optimize(`local x = makeValue()
if cond then
    use(x)
    x = nil
    return
end`);
assert(!ancestorTerminalRegisterRelease.source.includes("x = nil"));
assert.equal(ancestorTerminalRegisterRelease.stats.directNilCleanupWritesRemoved, 1);

const ancestorAcyclicRegisterRelease = optimize(`local x = makeValue()
if cond then
    use(x)
    x = nil
    sideEffect()
end`);
assert(!ancestorAcyclicRegisterRelease.source.includes("x = nil"));
assert.equal(ancestorAcyclicRegisterRelease.stats.directNilCleanupWritesRemoved, 1);

const ancestorRegisterReleaseLaterReadMustStay = optimize(`local x = makeValue()
if cond then
    x = nil
end
print(x)`);
assert(ancestorRegisterReleaseLaterReadMustStay.source.includes("x = nil"));
assert.equal(ancestorRegisterReleaseLaterReadMustStay.stats.directNilCleanupWritesRemoved, 0);

const loopRegisterReleaseMustStay = optimize(`local x = makeValue()
while cond do
    use(x)
    if again then
        x = nil
    end
end`);
assert(loopRegisterReleaseMustStay.source.includes("x = nil"));
assert.equal(loopRegisterReleaseMustStay.stats.directNilCleanupWritesRemoved, 0);

const upvalueDirectNilMustStay = optimize(`local x = 1
local f = function()
    x = nil
end
f()
print(x)`);
assert(upvalueDirectNilMustStay.source.includes("x = nil"));
assert.equal(upvalueDirectNilMustStay.stats.directNilCleanupWritesRemoved, 0);

const sourceStyleNilTransferStaysNil = optimize(`local temp = nil
local real = temp
print(real)`);
assert(sourceStyleNilTransferStaysNil.source.includes("print(nil)"));
assert(!sourceStyleNilTransferStaysNil.source.includes("local temp"));
assert.equal(sourceStyleNilTransferStaysNil.stats.directNilCleanupWritesRemoved, 0);

const adjacentCallCopyChain = optimize(`local temp = makeValue()
local real = temp
consume(real)`);
assert(adjacentCallCopyChain.source.includes("local real = makeValue()"));
assert(!adjacentCallCopyChain.source.includes("local temp"));
assert.equal(adjacentCallCopyChain.stats.adjacentCopyChainsFolded, 1);

const adjacentClosureCopyChain = optimize(`local temp = function() return 7 end
local real = temp
print(real())`);
assert(!adjacentClosureCopyChain.source.includes("local real = function() return 7 end"));
assert(!adjacentClosureCopyChain.source.includes("local temp"));
assert(adjacentClosureCopyChain.source.includes("function() return 7 end"));
assert.equal(adjacentClosureCopyChain.stats.adjacentCopyChainsFolded, 1);
assert.equal(adjacentClosureCopyChain.stats.smallFunctionInlines, 1);

const copyChainLaterTempUseBarrier = optimize(`local temp = thing
local real = temp
print(temp, real)`);
assert(copyChainLaterTempUseBarrier.source.includes("local temp = thing"));
assert(copyChainLaterTempUseBarrier.source.includes("print(temp, temp)"));
assert.equal(copyChainLaterTempUseBarrier.stats.adjacentCopyChainsFolded, 0);

const copyChainCaptureBarrier = optimize(`local temp = thing
local real = temp
local f = function() return temp end
print(real, f())`);
assert(copyChainCaptureBarrier.source.includes("local temp = thing"));
assert(copyChainCaptureBarrier.source.includes("function() return temp end"));
assert.equal(copyChainCaptureBarrier.stats.adjacentCopyChainsFolded, 0);

const nestedBareReturnMustStay = optimize(`local x = 1
if cond then
    print(x)
    return
end
x = 3
print(x)`);
assert(nestedBareReturnMustStay.source.includes("return"));
assert.equal(nestedBareReturnMustStay.stats.bareReturnsRemoved, 0);

const genericCrossBlockReadBarrier = optimize(`local x = 1
local snapshot = x
if cond then
    print(snapshot)
end`);
assert(/local snapshot = /.test(genericCrossBlockReadBarrier.source));
assert(genericCrossBlockReadBarrier.source.includes("print(snapshot)"));
assert(!genericCrossBlockReadBarrier.source.includes("print(x)"));

const genericDoBlockReadBarrier = optimize(`local x = 1
local snapshot = x
do
    print(snapshot)
end`);
assert(/local snapshot = /.test(genericDoBlockReadBarrier.source));
assert(genericDoBlockReadBarrier.source.includes("print(snapshot)"));
assert(!genericDoBlockReadBarrier.source.includes("print(x)"));

const valueShortCircuitFallback = optimize(`local seed = table
local first = seed
if seed then
    local member = table["unpack"]
    first = member
end
local chosen = first
if not first then
    local fallback = unpack
    chosen = fallback
end
consume(chosen)`);
assert(!valueShortCircuitFallback.source.includes("if seed"));
assert(!valueShortCircuitFallback.source.includes("if not first"));
assert(!valueShortCircuitFallback.source.includes("local seed ="));
assert(!valueShortCircuitFallback.source.includes("local first ="));
assert(valueShortCircuitFallback.source.includes('table["unpack"]'));
assert(valueShortCircuitFallback.source.includes(" and "));
assert(valueShortCircuitFallback.source.includes(" or "));
assert.equal(valueShortCircuitFallback.stats.valueShortCircuitLaddersCollapsed, 2);

const valueShortCircuitGlobalSeedBarrier = optimize(`local chosen = globalValue
if globalValue then
    chosen = rhs()
end
consume(chosen)`);
assert(valueShortCircuitGlobalSeedBarrier.source.includes("if globalValue then"));
assert.equal(valueShortCircuitGlobalSeedBarrier.stats.valueShortCircuitLaddersCollapsed, 0);

const valueShortCircuitSelfReferenceBarrier = optimize(`local seed = left()
local chosen = seed
if seed then
    chosen = combine(chosen)
end
consume(chosen)`);
assert(valueShortCircuitSelfReferenceBarrier.source.includes("if seed then"));
assert.equal(valueShortCircuitSelfReferenceBarrier.stats.valueShortCircuitLaddersCollapsed, 0);

const valueShortCircuitSeedUseKeepsSnapshot = optimize(`local seed = left()
local chosen = seed
if seed then
    chosen = combine(seed)
end
consume(chosen)`);
assert(valueShortCircuitSeedUseKeepsSnapshot.source.includes("local seed = left()"));
assert(!valueShortCircuitSeedUseKeepsSnapshot.source.includes("if seed then"));
assert(valueShortCircuitSeedUseKeepsSnapshot.source.includes("seed) and (combine(seed))"));
assert.equal(valueShortCircuitSeedUseKeepsSnapshot.stats.valueShortCircuitLaddersCollapsed, 1);

const numericForConstantHeader = optimize(`local limit = getLimit()
local step = 1
local start = 1
for i = start, limit, step do
    consume(i)
end`);
assert(!numericForConstantHeader.source.includes("local step ="));
assert(!numericForConstantHeader.source.includes("local start ="));
assert(numericForConstantHeader.source.includes("for i = 1, limit do"));
assert.equal(numericForConstantHeader.stats.numericForConstantInlines, 2);
assert.equal(numericForConstantHeader.stats.numericForDefaultStepsRemoved, 1);

const numericForNonDefaultStep = optimize(`local limit = getLimit()
local step = 2
local start = 1
for i = start, limit, step do
    consume(i)
end`);
assert(!numericForNonDefaultStep.source.includes("local step ="));
assert(!numericForNonDefaultStep.source.includes("local start ="));
assert(numericForNonDefaultStep.source.includes("for i = 1, limit, 2 do"));
assert.equal(numericForNonDefaultStep.stats.numericForConstantInlines, 2);
assert.equal(numericForNonDefaultStep.stats.numericForDefaultStepsRemoved, 0);

const numericForConstantUseBarrier = optimize(`local limit = getLimit()
local step = 1
local start = 1
print(step)
for i = start, limit, step do
    consume(i)
end`);
assert(numericForConstantUseBarrier.source.includes("local step = 1"));
assert(numericForConstantUseBarrier.source.includes("for i = 1, limit, step do"));
assert.equal(numericForConstantUseBarrier.stats.numericForDefaultStepsRemoved, 0);

const adjacentIndexBaseAliasInline = optimize(`local temp = math
local real = temp["random"]
consume(real)`);
assert(!adjacentIndexBaseAliasInline.source.includes("local temp ="));
assert(adjacentIndexBaseAliasInline.source.includes('local real = math["random"]'));
assert.equal(adjacentIndexBaseAliasInline.stats.adjacentIndexBaseAliasesFolded, 1);

const adjacentIndexBaseAliasUseBarrier = optimize(`local temp = math
local real = temp["random"]
consume(temp, real)`);
assert(adjacentIndexBaseAliasUseBarrier.source.includes("local temp = math"));
assert.equal(adjacentIndexBaseAliasUseBarrier.stats.adjacentIndexBaseAliasesFolded, 0);

const adjacentIndexKeyInline = optimize(`local cache = {}
local key = decode("x")
local value = cache[key]
consume(value)`);
assert(!adjacentIndexKeyInline.source.includes("local key ="));
assert(adjacentIndexKeyInline.source.includes('local value = cache[decode("x")]'));
assert.equal(adjacentIndexKeyInline.stats.adjacentIndexKeyInlines, 1);

const adjacentIndexKeyNestedWriterBarrier = optimize(`local cache = {}
local mutate = function()
    cache = {}
end
local key = decode("x")
local value = cache[key]
consume(value, mutate)`);
assert(adjacentIndexKeyNestedWriterBarrier.source.includes('local key = decode("x")'));
assert(adjacentIndexKeyNestedWriterBarrier.source.includes("local value = cache[key]"));
assert.equal(adjacentIndexKeyNestedWriterBarrier.stats.adjacentIndexKeyInlines, 0);

const adjacentAssignmentKeyInline = optimize(`local source = {}
local target = {}
local key = source[decode("x")]
target[key] = true`);
assert(!adjacentAssignmentKeyInline.source.includes("local key ="));
assert(adjacentAssignmentKeyInline.source.includes('target[source[decode("x")]] = true'));
assert.equal(adjacentAssignmentKeyInline.stats.adjacentAssignmentKeyInlines, 1);

const adjacentAssignmentKeyGlobalBaseBarrier = optimize(`local source = {}
local key = source[decode("x")]
target[key] = true`);
assert(adjacentAssignmentKeyGlobalBaseBarrier.source.includes('local key = source[decode("x")]'));
assert(adjacentAssignmentKeyGlobalBaseBarrier.source.includes("target[key] = true"));
assert.equal(adjacentAssignmentKeyGlobalBaseBarrier.stats.adjacentAssignmentKeyInlines, 0);

const adjacentAssignmentKeyNestedWriterBarrier = optimize(`local source = {}
local target = {}
local mutate = function()
    target = {}
end
local key = source[decode(mutate)]
target[key] = true
consume(mutate)`);
assert(adjacentAssignmentKeyNestedWriterBarrier.source.includes("local key = source[decode(mutate)]"));
assert(adjacentAssignmentKeyNestedWriterBarrier.source.includes("target[key] = true"));
assert.equal(adjacentAssignmentKeyNestedWriterBarrier.stats.adjacentAssignmentKeyInlines, 0);

const adjacentAssignmentKeyComplexBaseBarrier = optimize(`local source = {}
local holder = { target = {} }
local key = source[decode("x")]
holder.target[key] = true`);
assert(adjacentAssignmentKeyComplexBaseBarrier.source.includes('local key = source[decode("x")]'));
assert(adjacentAssignmentKeyComplexBaseBarrier.source.includes("holder.target[key] = true"));
assert.equal(adjacentAssignmentKeyComplexBaseBarrier.stats.adjacentAssignmentKeyInlines, 0);


const dependencySafeAssignmentKeyInline = optimize(`local source = {}
local target = {}
local other = {}
local touch = function()
    other[1] = 2
end
local key = source[1]
touch()
target[key] = true`);
assert(!dependencySafeAssignmentKeyInline.source.includes("local key ="));
assert(dependencySafeAssignmentKeyInline.source.includes("target[source[1]] = true"));
assert.equal(dependencySafeAssignmentKeyInline.stats.dependencySafeAssignmentKeyInlines, 1);

const dependencySafeAssignmentKeyMutationBarrier = optimize(`local source = {}
local target = {}
local key = source[1]
source[1] = 2
target[key] = true`);
assert(dependencySafeAssignmentKeyMutationBarrier.source.includes("local key = source[1]"));
assert.equal(dependencySafeAssignmentKeyMutationBarrier.stats.dependencySafeAssignmentKeyInlines, 0);

const dependencySafeAssignmentKeyFunctionPassBarrier = optimize(`local source = {}
local target = {}
local mutate = function(t)
    t[1] = 2
end
local key = source[1]
mutate(source)
target[key] = true`);
assert(dependencySafeAssignmentKeyFunctionPassBarrier.source.includes("local key = source[1]"));
assert.equal(dependencySafeAssignmentKeyFunctionPassBarrier.stats.dependencySafeAssignmentKeyInlines, 0);

const dependencySafeAssignmentKeyAliasBarrier = optimize(`local source = {}
local alias = source
local target = {}
local key = source[1]
alias[1] = 2
target[key] = true
print(alias)`);
assert(dependencySafeAssignmentKeyAliasBarrier.source.includes("local key = source[1]"));
assert.equal(dependencySafeAssignmentKeyAliasBarrier.stats.dependencySafeAssignmentKeyInlines, 0);

const dependencySafeAssignmentKeyCaptureBarrier = optimize(`local source = {}
local target = {}
local mutate = function()
    source[1] = 2
end
local key = source[1]
mutate()
target[key] = true`);
assert(dependencySafeAssignmentKeyCaptureBarrier.source.includes("local key = source[1]"));
assert.equal(dependencySafeAssignmentKeyCaptureBarrier.stats.dependencySafeAssignmentKeyInlines, 0);

const dependencySafeAssignmentKeyIndexWriteBarrier = optimize(`local source = {}
local target = {}
local i = 1
local key = source[i]
i = 2
target[key] = true`);
assert(dependencySafeAssignmentKeyIndexWriteBarrier.source.includes("local key = source[i]"));
assert.equal(dependencySafeAssignmentKeyIndexWriteBarrier.stats.dependencySafeAssignmentKeyInlines, 0);

const dependencySafeAssignmentKeyCallIndexBarrier = optimize(`local source = {}
local target = {}
local decode = function()
    return 1
end
local key = source[decode()]
unrelated()
target[key] = true`);
assert(dependencySafeAssignmentKeyCallIndexBarrier.source.includes("local key = source["));
assert.equal(dependencySafeAssignmentKeyCallIndexBarrier.stats.dependencySafeAssignmentKeyInlines, 0);

const adjacentTableConstructorKeyInline = optimize(`local cache = {}
local decode = function() return "K" end
local key = cache[decode()]
local built = { [key] = 0.5 }
consume(built)`);
assert(!adjacentTableConstructorKeyInline.source.includes("local key ="));
assert(adjacentTableConstructorKeyInline.source.includes('local built = { [cache['));
assert(adjacentTableConstructorKeyInline.source.includes('] = 0.5 }'));
assert.equal(adjacentTableConstructorKeyInline.stats.adjacentTableConstructorKeyInlines, 1);

const adjacentTableConstructorKeyEffectValueBarrier = optimize(`local cache = {}
local key = cache[1]
local built = { [key] = makeValue() }
consume(built)`);
assert(adjacentTableConstructorKeyEffectValueBarrier.source.includes("local key = cache[1]"));
assert.equal(adjacentTableConstructorKeyEffectValueBarrier.stats.adjacentTableConstructorKeyInlines, 0);

const adjacentTableConstructorKeyMultipleFieldBarrier = optimize(`local cache = {}
local key = cache[1]
local built = { [key] = 0.5, other = 1 }
consume(built)`);
assert(adjacentTableConstructorKeyMultipleFieldBarrier.source.includes("local key = cache[1]"));
assert.equal(adjacentTableConstructorKeyMultipleFieldBarrier.stats.adjacentTableConstructorKeyInlines, 0);

const adjacentTableConstructorKeyLaterUseBarrier = optimize(`local cache = {}
local key = cache[1]
local built = { [key] = 0.5 }
consume(built, key)`);
assert(adjacentTableConstructorKeyLaterUseBarrier.source.includes("local key = cache[1]"));
assert.equal(adjacentTableConstructorKeyLaterUseBarrier.stats.adjacentTableConstructorKeyInlines, 0);

const adjacentTableConstructorKeyGapBarrier = optimize(`local cache = {}
local key = cache[1]
unrelated()
local built = { [key] = 0.5 }
consume(built)`);
assert(adjacentTableConstructorKeyGapBarrier.source.includes("local key = cache[1]"));
assert.equal(adjacentTableConstructorKeyGapBarrier.stats.adjacentTableConstructorKeyInlines, 0);

const adjacentTableCallArgumentInline = optimize(`local r_v21_8 = existing
local r_v24_11 = {}
local r_v25_5 = {
    ["__index"] = r_v21_8,
    ["__metatable"] = nil
}
local r_v4_3
r_v4_3 = setmetatable(r_v24_11, r_v25_5)
return r_v4_3`);
assert(!adjacentTableCallArgumentInline.source.includes("local r_v24_11 ="));
assert(!adjacentTableCallArgumentInline.source.includes("local r_v25_5 ="));
assert(adjacentTableCallArgumentInline.source.includes("setmetatable({}, {"));
assert.equal(adjacentTableCallArgumentInline.stats.adjacentTableCallArgumentInlines, 2);

const adjacentTableCallArgumentEffectBarrier = optimize(`local packed = { build() }
local out = consume(packed)
print(out)`);
assert(adjacentTableCallArgumentEffectBarrier.source.includes("local packed = { build() }"));
assert.equal(adjacentTableCallArgumentEffectBarrier.stats.adjacentTableCallArgumentInlines, 0);

const adjacentTableCallArgumentGlobalFieldBarrier = optimize(`local packed = { currentValue }
local out = consume(packed)
print(out)`);
assert(adjacentTableCallArgumentGlobalFieldBarrier.source.includes("local packed = { currentValue }"));
assert.equal(adjacentTableCallArgumentGlobalFieldBarrier.stats.adjacentTableCallArgumentInlines, 0);

const adjacentScalarCallArgumentInline = optimize(`local callee = consume
local values = {}
local n = #values
local out = callee(1, n)
print(out)`);
assert(!adjacentScalarCallArgumentInline.source.includes("local n ="));
assert(adjacentScalarCallArgumentInline.source.includes("(1, #values)"));
assert.equal(adjacentScalarCallArgumentInline.stats.adjacentCallArgumentInlines, 1);

const adjacentCallArgumentSingleResult = optimize(`local inner = make
local outer = consume
local state = {}
local temp = inner()
local out = outer(state, temp)
print(out)`);
assert(!adjacentCallArgumentSingleResult.source.includes("local temp ="));
assert(adjacentCallArgumentSingleResult.source.includes("state, ("));
assert(adjacentCallArgumentSingleResult.source.includes("(make())"));
assert.equal(adjacentCallArgumentSingleResult.stats.adjacentCallArgumentInlines, 1);

const adjacentCallArgumentWriterBarrier = optimize(`local inner = make
local outer = consume
local mutate = function()
    outer = warn
end
local temp = inner(mutate)
local out = outer(temp)
print(out, mutate)`);
assert(adjacentCallArgumentWriterBarrier.source.includes("local temp ="));
assert(adjacentCallArgumentWriterBarrier.source.includes("outer(temp)"));
assert.equal(adjacentCallArgumentWriterBarrier.stats.adjacentCallArgumentInlines, 0);

const adjacentCallArgumentPriorWriterBarrier = optimize(`local inner = make
local outer = consume
local state = {}
local mutate = function()
    state = {}
end
local temp = inner(mutate)
local out = outer(state, temp)
print(out, mutate)`);
assert(adjacentCallArgumentPriorWriterBarrier.source.includes("local temp ="));
assert.equal(adjacentCallArgumentPriorWriterBarrier.stats.adjacentCallArgumentInlines, 0);

const adjacentCallArgumentExpressionInline = optimize(`local callee = assert
local fn = foo
local value = fn(1)
callee(value == nil)`);
assert(!adjacentCallArgumentExpressionInline.source.includes("local callee = assert"));
assert(!adjacentCallArgumentExpressionInline.source.includes("local value ="));
assert(adjacentCallArgumentExpressionInline.source.includes("assert((foo(1)) == nil)"));
assert.equal(adjacentCallArgumentExpressionInline.stats.adjacentCallArgumentInlines, 1);

const adjacentCallArgumentExpressionLogicalBarrier = optimize(`local callee = consume
local fn = make
local value = fn()
callee(false and value)`);
assert(adjacentCallArgumentExpressionLogicalBarrier.source.includes("local value ="));
assert.equal(adjacentCallArgumentExpressionLogicalBarrier.stats.adjacentCallArgumentInlines, 0);

const adjacentCallArgumentExpressionWriterBarrier = optimize(`local callee = consume
local fn = make
local mutate = function()
    callee = warn
end
local value = fn(mutate)
callee(value == nil)`);
assert(adjacentCallArgumentExpressionWriterBarrier.source.includes("local value ="));
assert(adjacentCallArgumentExpressionWriterBarrier.source.includes("callee(value == nil)"));

const adjacentCallArgumentExpressionPrefixBarrier = optimize(`local callee = consume
local fn = make
local value = fn()
callee(other(), value == nil)`);
assert(adjacentCallArgumentExpressionPrefixBarrier.source.includes("local value ="));
assert.equal(adjacentCallArgumentExpressionPrefixBarrier.stats.adjacentCallArgumentInlines, 0);
assert(adjacentCallArgumentExpressionPrefixBarrier.source.includes("callee(other(), value == nil)"));

const adjacentIfCallTempIndexedAlias = optimize(`local r_v2_1 = 9
local r_v5_3 = math["random"]
local r_v4_5 = r_v5_3(2, 3)
if r_v4_5 == 3 then
    print(r_v2_1)
    return
end`);
assert(!adjacentIfCallTempIndexedAlias.source.includes("local r_v5_3 ="));
assert(!adjacentIfCallTempIndexedAlias.source.includes("local r_v4_5 ="));
assert(adjacentIfCallTempIndexedAlias.source.includes('if math["random"](2, 3) == 3 then'));
assert.equal(adjacentIfCallTempIndexedAlias.stats.adjacentIndexBaseAliasesFolded, 1);
assert.equal(adjacentIfCallTempIndexedAlias.stats.singleUseInlines, 1);

const adjacentIfCallTempOrderBarrier = optimize(`local fn = make
local value = fn()
if other() == value then
    print(value)
end`);
assert(adjacentIfCallTempOrderBarrier.source.includes("local value ="));

const adjacentIndexedIfCallLogicalBarrier = optimize(`local f = math["random"]
if false and f(2, 3) then
    print("bad")
end`);
assert(adjacentIndexedIfCallLogicalBarrier.source.includes('local f = math["random"]'));

const adjacentAssignmentValueInline = optimize(`local target = {}
local key = 1
local temp = makeValue()
target[key] = temp
print(target[key])`);
assert(!adjacentAssignmentValueInline.source.includes("local temp ="));
assert(adjacentAssignmentValueInline.source.includes("target[key] = makeValue()"));
assert.equal(adjacentAssignmentValueInline.stats.adjacentAssignmentValueInlines, 1);

const repeatTailConditionTempInline = optimize(`repeat
    body()
    local done = check()
until done`);
assert(!repeatTailConditionTempInline.source.includes("local done ="));
assert(repeatTailConditionTempInline.source.includes("until check()"));
assert.equal(repeatTailConditionTempInline.stats.repeatTailConditionTempsInlined, 1);

const repeatTailNilCleanup = optimize(`repeat
    local value = makeValue()
    use(value)
    value = nil
until done()`);
assert(!repeatTailNilCleanup.source.includes("value = nil"));
assert.equal(repeatTailNilCleanup.stats.directNilCleanupWritesRemoved, 1);

const repeatTailNilCaptureBarrier = optimize(`local keep
repeat
    local value = makeValue()
    keep = function() return value end
    value = nil
until done()
print(keep())`);
assert(repeatTailNilCaptureBarrier.source.includes("value = nil"));

const independentDeferredBatch = optimize(`local a
local b
a = 1
b = 2
print(a, b)`);
assert(independentDeferredBatch.source.includes("print(1, 2)"));
assert.equal(independentDeferredBatch.stats.deferredLocalInitializersFolded, 2);

const deferredBatchScopeDependencyBarrier = optimize(`local a
local b
b = a
a = 2
print(a, b)`);
assert(deferredBatchScopeDependencyBarrier.source.includes("local a"));
assert(deferredBatchScopeDependencyBarrier.source.includes("local b = a"));
assert(!deferredBatchScopeDependencyBarrier.source.includes("local a = 2"));

const independentInlineBatch = optimize(`local a = 1
local b = 2
local c = 3
local d = 4
local e = 5
local f = 6
local g = 7
local h = 8
print(a)
print(b)
print(c)
print(d)
print(e)
print(f)
print(g)
print(h)`);
assert(independentInlineBatch.source.includes("print(1)"));
assert(independentInlineBatch.source.includes("print(8)"));
assert.equal(independentInlineBatch.stats.singleUseInlines, 8);
assert(independentInlineBatch.stats.parseRounds < independentInlineBatch.stats.rounds);

const dependentInlineChainBatchBarrier = optimize(`local a = 1
local b = a
print(b)`);
assert(dependentInlineChainBatchBarrier.source.includes("print(1)"));
assert.equal(dependentInlineChainBatchBarrier.stats.singleUseInlines, 2);
assert(dependentInlineChainBatchBarrier.stats.parseRounds >= 2);


const parseBudgetBatchSource = `local a = 1
local b = 2
local c = 3
local d = 4
local e = 5
local f = 6
local g = 7
local h = 8
print(a)
print(b)
print(c)
print(d)
print(e)
print(f)
print(g)
print(h)`;
const parseBudgetBatch = optimizeBetaSource(parseBudgetBatchSource, { maxParseRounds: 4 });
parseLuaStructural(parseBudgetBatch.source, "<beta-optimizer-parse-budget-batch>");
assert.equal(parseBudgetBatch.stats.singleUseInlines, 8);
assert(parseBudgetBatch.stats.rounds > parseBudgetBatch.stats.parseRounds);
assert.equal(parseBudgetBatch.stats.parseRounds, 4);
assert.equal(parseBudgetBatch.stats.parseLimitHit, false);
assert(parseBudgetBatch.source.includes("print(1)"));
assert(parseBudgetBatch.source.includes("print(8)"));

const parseBudgetLimit = optimizeBetaSource(`local a = 1\nprint(a)`, { maxParseRounds: 1 });
assert.equal(parseBudgetLimit.stats.parseRounds, 1);
assert.equal(parseBudgetLimit.stats.parseLimitHit, true);
assert(parseBudgetLimit.source.includes("local a = 1"));

// Swap snapshots must remain unless a dedicated proof can preserve both global
// read order and global write order (globals may have environment metamethods).
const globalSwapSnapshot = optimize(`local a = l2
local b = l1
l1 = a
l2 = b`);
assert(globalSwapSnapshot.source.includes("local a = l2"));
assert(globalSwapSnapshot.source.includes("local b = l1"));
assert(globalSwapSnapshot.source.includes("l1 = a"));
assert(globalSwapSnapshot.source.includes("l2 = b"));

console.log("beta optimizer tests passed");
