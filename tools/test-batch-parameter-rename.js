const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { renameFunctionParameterBindingsBatch } = require("../passes/batch-parameter-rename");

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
    "local function outer(a, b)",
    "    print(a, b)",
    "    local function inner(a)",
    "        print(a, b)",
    "    end",
    "    local f = function(c)",
    "        return a + b + c",
    "    end",
    "end",
].join("\n");
const ast = parse(source);
const outer = ast.body[0];
const inner = outer.body.find(statement => statement.type === "FunctionDeclaration");
const result = renameFunctionParameterBindingsBatch(source, [
    { fn: outer, parameter: outer.parameters[0], replacementName: "alpha" },
    { fn: outer, parameter: outer.parameters[1], replacementName: "beta" },
    { fn: inner, parameter: inner.parameters[0], replacementName: "innerA" },
], ast);
assert.strictEqual(result.batchConflict, false);
assert.ok(result.results.every(item => !item.collision));
assert.ok(result.source.includes("local function outer(alpha, beta)"));
assert.ok(result.source.includes("print(alpha, beta)"));
assert.ok(result.source.includes("local function inner(innerA)"));
assert.ok(result.source.includes("print(innerA, beta)"));
assert.ok(result.source.includes("return alpha + beta + c"));

const collisionSource = [
    "local function outer(a)",
    "    local alpha = 1",
    "    print(a)",
    "end",
].join("\n");
const collisionAst = parse(collisionSource);
const collisionOuter = collisionAst.body[0];
const collision = renameFunctionParameterBindingsBatch(collisionSource, [
    { fn: collisionOuter, parameter: collisionOuter.parameters[0], replacementName: "alpha" },
], collisionAst);
assert.strictEqual(collision.results[0].collision, true);
assert.strictEqual(collision.source, collisionSource);

console.log("batch parameter rename regression: ok");