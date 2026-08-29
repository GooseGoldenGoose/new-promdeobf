"use strict";
const assert = require("assert");
const { finalizePreCfGlobalLookups } = require("../passes/pre-cf-temp-recovery");

function wrap(body) {
    return `return (function(_env)\n    local vm\n    vm = function(state)\n        if state == 1 then\n${body.split("\n").map(line => "            " + line).join("\n")}\n        end\n    end\nend)(getfenv())\n`;
}
function beta(source, operations) {
    return {
        source,
        graph: {
            cfgComplete: true,
            stateName: "state",
            recoveredUpvalueBindings: [],
            states: [{ id: 1, predecessors: [], successors: [], operations: operations.map((op, i) => ({ index: i + 1, ...op })) }],
        },
    };
}
function def(target, rhs, reads = []) {
    return { kind: "version-define", emittedTarget: target, rhs, reads, emittedText: `local ${target} = ${rhs}` };
}
function stmt(text, reads = []) { return { kind: "statement", emittedText: text, originalText: text, reads }; }

{
    const source = wrap('local key = "print"\nlocal fn = _env[key]\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("key", '"print"'), def("fn", "_env[key]", ["_env", "key"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.safe, true);
    assert.equal(result.preCfGlobalLookups.folds, 1);
    assert.equal(result.preCfGlobalLookups.keyTempsRemoved, 1);
    assert(result.source.includes("local fn = print"));
    assert(!result.source.includes('local key = "print"'));
    assert(!result.source.includes("_env[key]"));
}
{
    const source = wrap('local fn = _env["warn"]\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["warn"]', ["_env"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 1);
    assert(result.source.includes("local fn = warn"));
}
{
    const source = `return (function(_env)\n    local print = fakePrint\n    local vm\n    vm = function(state)\n        if state == 1 then\n            local fn = _env["print"]\n            return\n        end\n    end\nend)(getfenv())\n`;
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["print"]', ["_env"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 1);
    assert(result.source.includes("local fn = print"));
}
{
    const source = wrap('local fn = _env["foo-bar"]\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["foo-bar"]', ["_env"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 0);
}
{
    const source = wrap('local key = getName()\nlocal fn = _env[key]\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("key", "getName()", ["getName"]), def("fn", "_env[key]", ["_env", "key"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 0);
}
{
    const source = wrap('local key = "print"\nobserve(key)\nlocal fn = _env[key]\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("key", '"print"'), stmt("observe(key)", ["key"]), def("fn", "_env[key]", ["_env", "key"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 0);
}
{
    const source = wrap('local fn = _env["end"]\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["end"]', ["_env"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 0);
}
{
    const source = `local _env = {}\nlocal vm\nvm = function(state)\n    if state == 1 then\n        local fn = _env["print"]\n        return\n    end\nend\n`;
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["print"]', ["_env"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.environmentProven, false);
    assert(result.source.includes('_env["print"]'));
}

{
    const source = wrap('local fn = _env["print"]\nfn("hi")\nreturn');
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["print"]', ["_env"]), stmt('fn("hi")', ["fn"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 1);
    assert(result.source.includes("local fn = print"));
    assert(result.source.includes('fn("hi")'));
    assert(!result.source.includes('print("hi")'));
}
{
    const source = `return (function(_env)\n    local vm\n    vm = function(state)\n        local _env = {}\n        if state == 1 then\n            local fn = _env["print"]\n            return\n        end\n    end\nend)(getfenv())\n`;
    const result = finalizePreCfGlobalLookups(beta(source, [def("fn", '_env["print"]', ["_env"]), stmt("return")]));
    assert.equal(result.preCfGlobalLookups.folds, 0);
    assert.equal(result.preCfGlobalLookups.environmentShadowed, true);
    assert(result.source.includes('_env["print"]'));
}

console.log("PRE-CF global lookups: PASS");
