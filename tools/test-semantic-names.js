const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { renameSemanticBindings } = require("../passes/semantic-names");

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
    "return (function(...)",
    "    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, X, vm, createClosure2, createClosure, createUpvalueProxy, releaseUpvalues, upvalueRefCounts, upvalueValues)",
    "        vm = function(state, args, upvalues, gcProxy)",
    "            local Spill = {}",
    "            local r1, ReturnVal",
    "            while state do",
    "                Spill[1] = args",
    "                ReturnVal = {}",
    "                state = nil",
    "            end",
    "            state = #gcProxy",
    "            return unpack(ReturnVal)",
    "        end",
    "        createClosure2 = function(entryId, captures)",
    "            local P = createUpvalueProxy(captures)",
    "            local C = function(a, b)",
    "                return vm(entryId, {a, b}, captures, P)",
    "            end",
    "            return C",
    "        end",
    "        createClosure = function(entryId, captures)",
    "            local P = createUpvalueProxy(captures)",
    "            local C = function(...)",
    "                return vm(entryId, {...}, captures, P)",
    "            end",
    "            return C",
    "        end",
    "        releaseUpvalues = function(captures)",
    "            local j, u = 1, captures[1]",
    "            while u do",
    "                upvalueRefCounts[u], j = upvalueRefCounts[u] - 1, j + 1",
    "                if upvalueRefCounts[u] == 0 then",
    "                    upvalueRefCounts[u], upvalueValues[u] = nil, nil",
    "                end",
    "                u = captures[j]",
    "            end",
    "        end",
    "        createUpvalueProxy = function(captures)",
    "            for k = 1, #captures, 1 do",
    "                upvalueRefCounts[captures[k]] = upvalueRefCounts[captures[k]] + 1",
    "            end",
    "            if newproxy then",
    "                local p = newproxy(true)",
    "                local m = getmetatable(p)",
    "                m[\"__index\"], m[\"__gc\"], m[\"__len\"] = captures, releaseUpvalues, function() return 1 end",
    "                return p",
    "            else",
    "                return setmetatable({}, {})",
    "            end",
    "        end",
    "        return (createClosure(1, {}))(unpack(X))",
    "    end)(getfenv and getfenv() or _ENV, unpack or table.unpack, newproxy, setmetatable, getmetatable, select, {...})",
    "end)(...)",
].join("\n");

const result = renameSemanticBindings(source, parse(source), (text) => parse(text));
assert.strictEqual(result.applied, true);
assert.ok(result.source.includes("InitialArgs"));
assert.ok(result.source.includes("unpack(InitialArgs)"));
assert.ok(result.source.includes("local RegisterOverflow = {}"));
assert.ok(result.source.includes("RegisterOverflow[1] = args"));
assert.ok(result.source.includes("local gcProxy = createUpvalueProxy(captures)"));
assert.ok(result.source.includes("local closure = function(arg1, arg2)"));
assert.ok(result.source.includes("{arg1, arg2}"));
assert.ok(result.source.includes("captures, gcProxy"));
assert.ok(result.source.includes("local captureIndex, upvalueId = 1, captures[1]"));
assert.ok(result.source.includes("for captureIndex = 1, #captures, 1 do"));
assert.ok(result.source.includes("local proxy = newproxy(true)"));
assert.ok(result.source.includes("local proxyMetatable = getmetatable(proxy)"));
assert.ok(result.source.includes("proxyMetatable[\"__index\"]"));
assert.strictEqual(result.skipped.length, 0);

console.log("semantic naming regression: ok");
