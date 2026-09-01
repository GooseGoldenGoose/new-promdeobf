const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { recoverVmStateGraph } = require("../passes/vm-state");

function parse(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        comments: true,
        scope: true,
        locations: true,
        ranges: true,
    });
}

const source = [
    "local createClosure, createClosure1, vm",
    "vm = function(state, args, upvalues, gcProxy)",
    "    while state do",
    "        if state <= 1 then",
    "            if state == 1 then",
    "                A = f()",
    "                state = _env[\"ABCDEFGHIJKL\"]",
    "                B = g()",
    "            else",
    "                state = nil",
    "            end",
    "        else",
    "            if state <= 99 then",
    "                if state == 99 then",
    "                    dead = createClosure1(100, {})",
    "                    state = nil",
    "                else",
    "                    state = nil",
    "                end",
    "            else",
    "                if state == 100 then",
    "                    state = nil",
    "                else",
    "                    state = nil",
    "                end",
    "            end",
    "        end",
    "    end",
    "end",
    "return (createClosure(1, {}))()",
].join("\n");

const result = recoverVmStateGraph(source, parse(source));
assert.strictEqual(result.normalized, true, "reachable root should normalize");
assert.deepStrictEqual(result.graphRoots.map(root => root.entryId), [1], "dead closure entry became a graph root");
assert.strictEqual(result.blocks.size, 1, "dead states were retained");
assert.strictEqual(result.ignoredUnreachableClosureEntryCount, 1, "dead closure entry call was not ignored");
assert.ok(result.prunedDispatcherLeafCount >= 2, "dead dispatcher leaves were not pruned");
assert.ok(!result.source.includes("state == 99"), "dead state 99 survived output");
assert.ok(!result.source.includes("createClosure1(100"), "closure call from dead state survived output");
assert.ok(!result.source.includes("invalid/unreachable VM state"), "normalized dispatcher retained invalid-state fallback scaffolding");
assert.ok(!result.source.includes('_env["ABCDEFGHIJKL"]'), "canonical stop sentinel survived normalization");
const aPos = result.source.indexOf("A = f()");
const bPos = result.source.indexOf("B = g()");
const stopPos = result.source.indexOf("state = nil", bPos);
assert.ok(aPos >= 0 && bPos > aPos && stopPos > bPos, "canonical stop was not relocated to the state-body tail");


{
    const arithmeticRootSource = [
        "local createClosure1, vm",
        "vm = function(state, args, upvalues, gcProxy)",
        "    while state do",
        "        if state <= 101 then",
        "            if state == 101 then",
        "                state = flag and (200 + 1) or (300 + 2)",
        "            else",
        "                state = nil",
        "            end",
        "        elseif state <= 201 then",
        "            if state == 201 then",
        "                state = nil",
        "            else",
        "                state = nil",
        "            end",
        "        else",
        "            if state == 302 then",
        "                state = nil",
        "            else",
        "                state = nil",
        "            end",
        "        end",
        "    end",
        "end",
        "return (createClosure1(100 + 1, {}))()",
    ].join("\n");
    const arithmeticRoot = recoverVmStateGraph(arithmeticRootSource, parse(arithmeticRootSource));
    assert.strictEqual(arithmeticRoot.normalized, true, "arithmetic/specialized root entry did not normalize");
    assert.strictEqual(arithmeticRoot.rootEntryId, 101);
    assert.deepStrictEqual(arithmeticRoot.orderedIds, [101, 201, 302]);
    assert.doesNotThrow(() => parse(arithmeticRoot.source), "normalized branch target tokenization became invalid");
    assert.ok(!arithmeticRoot.source.includes("and2"), "normalized branch target merged with 'and' token");
}

console.log("vm state reachability regression: ok");
