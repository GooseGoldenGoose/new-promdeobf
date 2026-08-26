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
assert(/^local x\s*$/m.test(deferredLocalCaptureBarrier.source));
assert(deferredLocalCaptureBarrier.source.includes("x = value"));

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
assert(repeatConditionLocalUse.source.includes("local done = x >= 2"));
assert(repeatConditionLocalUse.source.includes("until done"));
assert.equal(repeatConditionLocalUse.stats.deferredLocalInitializersFolded >= 1, true);


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
assert(adjacentClosureCopyChain.source.includes("local real = function() return 7 end"));
assert(!adjacentClosureCopyChain.source.includes("local temp"));
assert.equal(adjacentClosureCopyChain.stats.adjacentCopyChainsFolded, 1);

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
assert(copyChainCaptureBarrier.source.includes("local real = temp"));

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
