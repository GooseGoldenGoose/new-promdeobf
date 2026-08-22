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
    "                state = nil",
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

console.log("vm state reachability regression: ok");
