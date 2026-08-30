"use strict";
const assert = require("assert");
const { finalizePreCfGlobalWrites } = require("../passes/pre-cf-temp-recovery");

function wrap(body, prefix = "") {
    return `return (function(_env)\n    ${prefix}local vm\n    vm = function(state)\n        if state == 1 then\n${body.split("\n").map(line => "            " + line).join("\n")}\n        end\n    end\nend)(getfenv())\n`;
}
function beta(source, operations) {
    return { source, graph: { cfgComplete: true, stateName: "state", recoveredUpvalueBindings: [], states: [{ id: 1, predecessors: [], successors: [], operations: operations.map((op,i)=>({index:i+1,...op})) }] } };
}
function def(target, rhs, reads=[]) { return { kind:"version-define", emittedTarget:target, rhs, reads, emittedText:`local ${target} = ${rhs}` }; }
function write(text, reads=[]) { return { kind:"effect-write", emittedText:text, originalText:text, reads }; }
function stmt(text, reads=[]) { return { kind:"statement", emittedText:text, originalText:text, reads }; }

// Prometheus compiler.lua global AssignmentVariable: string key temp -> _env[key] = value.
{
    const source = wrap('local key = "answer"\n_env[key] = value\nreturn');
    const result = finalizePreCfGlobalWrites(beta(source, [def("key", '"answer"'), write("_env[key] = value", ["_env","key","value"]), stmt("return")]));
    assert.equal(result.preCfGlobalWrites.folds, 1, result.source);
    assert.equal(result.preCfGlobalWrites.keyTempsRemoved, 1, result.source);
    assert(result.source.includes("answer = value"), result.source);
    assert(!result.source.includes("_env[key]"), result.source);
    assert(!result.source.includes('local key = "answer"'), result.source);
}
{
    const source = wrap('_env["direct"] = value\nreturn');
    const result = finalizePreCfGlobalWrites(beta(source, [write('_env["direct"] = value', ["_env","value"]), stmt("return")]));
    assert.equal(result.preCfGlobalWrites.folds, 1, result.source);
    assert(result.source.includes("direct = value"), result.source);
}
// A lexical collision would make direct assignment hit the local, so retain _env.
{
    const source = wrap('_env["answer"] = value\nreturn', 'local answer = 9\n    ');
    const result = finalizePreCfGlobalWrites(beta(source, [write('_env["answer"] = value', ["_env","value"]), stmt("return")]));
    assert.equal(result.preCfGlobalWrites.folds, 0, result.source);
    assert(result.source.includes('_env["answer"] = value'), result.source);
}
// Dynamic/extra-used key is not compiler-owned one-use setup.
{
    const source = wrap('local key = getName()\n_env[key] = value\nreturn');
    const result = finalizePreCfGlobalWrites(beta(source, [def("key", "getName()", ["getName"]), write("_env[key] = value", ["_env","key","value"]), stmt("return")]));
    assert.equal(result.preCfGlobalWrites.folds, 0, result.source);
}
{
    const source = wrap('local key = "answer"\nobserve(key)\n_env[key] = value\nreturn');
    const result = finalizePreCfGlobalWrites(beta(source, [def("key", '"answer"'), stmt("observe(key)",["key"]), write("_env[key] = value", ["_env","key","value"]), stmt("return")]));
    assert.equal(result.preCfGlobalWrites.folds, 0, result.source);
}
// Invalid direct identifier remains indexed.
{
    const source = wrap('_env["hello-world"] = value\nreturn');
    const result = finalizePreCfGlobalWrites(beta(source, [write('_env["hello-world"] = value', ["_env","value"]), stmt("return")]));
    assert.equal(result.preCfGlobalWrites.folds, 0, result.source);
}
console.log("PRE-CF global writes: PASS");
