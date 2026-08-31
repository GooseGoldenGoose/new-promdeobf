"use strict";
const assert = require("assert");
const { recoverNestedFunctionSignature } = require("../passes/beta-control-flow");

function recover(body, factory = "createClosure7") {
    return recoverNestedFunctionSignature(body, factory);
}

let r = recover("return args[1]");
assert.equal(r.recovered, true);
assert.deepEqual(r.parameters, ["arg1"]);
assert.equal(r.vararg, false);
assert(r.bodyText.includes("return arg1"), r.bodyText);
assert(!r.bodyText.includes("args[1]"), r.bodyText);

r = recover("local x = args[2]\nreturn args[1], x, args[1]");
assert.equal(r.recovered, true);
assert.deepEqual(r.parameters, ["arg1", "x"]);
assert(r.bodyText.includes("return arg1, x, arg1"), r.bodyText);
assert(!r.bodyText.includes("local x = args[2]"), r.bodyText);

r = recover("return args[2]");
assert.equal(r.recovered, true);
assert.deepEqual(r.parameters, ["arg1", "arg2"]);
assert(r.bodyText.includes("return arg2"), r.bodyText);

r = recover("local x = args[1]\nreturn x, args[2]");
assert.equal(r.recovered, true);
assert.deepEqual(r.parameters, ["x", "arg2"]);
assert(r.bodyText.includes("return x, arg2"), r.bodyText);

r = recover("local arg1 = 99\nreturn args[1], arg1");
assert.equal(r.recovered, true);
assert.deepEqual(r.parameters, ["arg1_2"]);
assert(r.bodyText.includes("return arg1_2, arg1"), r.bodyText);

r = recover("local f = function() return args[1] end\nreturn args[1]");
assert.equal(r.recovered, true);
assert.deepEqual(r.parameters, ["arg1"]);
assert(r.bodyText.includes("function() return args[1] end"), r.bodyText);
assert(r.bodyText.includes("return arg1"), r.bodyText);

for (const body of [
    "local i = 1\nreturn args[i]",
    "local x = args\nreturn x",
    "args[1] = 2\nreturn args[1]",
    "return unpack(args)",
]) {
    r = recover(body);
    assert.equal(r.recovered, false, body + "\n" + r.bodyText);
}

// Direct compiler vararg select can recover to native ... when the offset matches fixed parameters.
r = recover("return select(1, unpack(args))", "createClosure");
assert.equal(r.recovered, true, r.bodyText);
assert.deepEqual(r.parameters, []);
assert.equal(r.vararg, true);
assert(r.bodyText.includes("return ..."), r.bodyText);

r = recover("local first = args[1]\nreturn first, select(2, unpack(args))", "createClosure");
assert.equal(r.recovered, true, r.bodyText);
assert.deepEqual(r.parameters, ["first"]);
assert.equal(r.vararg, true);
assert(r.bodyText.includes("return first, ..."), r.bodyText);

// Mismatched direct vararg offsets remain ambiguous and fail closed.
r = recover("return select(1, unpack(args)), select(2, unpack(args))", "createClosure");
assert.equal(r.recovered, false, r.bodyText);

// Existing vararg tail shape stays vararg and keeps positional slots.
r = recover("local first = args[1]\nlocal rest = { select(2, unpack(args)) }\nreturn first, unpack(rest)", "createClosure");
assert.equal(r.recovered, true, r.bodyText);
assert.deepEqual(r.parameters, ["first"]);
assert.equal(r.vararg, true);
assert(r.bodyText.includes("return first, ..."), r.bodyText);

console.log("beta CF closure signatures: PASS");
