"use strict";

const assert = require("assert");
const fs = require("fs");
const path = require("path");
const { parseLuaStructural } = require("../main");
const { generateDeobfuscatedSource, defaultProductionPaths } = require("./deobfuscate");
const { generateDeobfuscatedControlFlow } = require("./deobfuscate-beta-control-flow");

const root = path.resolve(__dirname, "..");
const input = path.join(root, "sample", "1.txt");
const tmp = path.join(root, "tmp", "production-pipeline-test");
fs.mkdirSync(tmp, { recursive: true });

const defaults = defaultProductionPaths(input);
assert(defaults.output.endsWith(path.join("output", "1.lua")));
assert(defaults.intermediate.endsWith(path.join("tmp", "production", "1.normal.lua")));

const productionOutput = path.join(tmp, "1.lua");
const productionNormal = path.join(tmp, "1.normal.lua");
const production = generateDeobfuscatedSource(input, productionOutput, productionNormal);
assert.equal(production.controlFlow.applied, true);
assert.equal(production.beta.preCfTempRecovery?.safe, true);
assert.equal(production.outputPath, path.resolve(productionOutput));
parseLuaStructural(production.controlFlow.source, "<production-pipeline>");

const referenceOutput = path.join(tmp, "1.reference.cf.lua");
const referenceNormal = path.join(tmp, "1.reference.normal.lua");
const reference = generateDeobfuscatedControlFlow(input, referenceNormal, referenceOutput);
assert.equal(production.controlFlow.source, reference.controlFlow.source);
assert.equal(fs.readFileSync(productionOutput, "utf8"), fs.readFileSync(referenceOutput, "utf8"));

console.log("production pipeline: PASS");