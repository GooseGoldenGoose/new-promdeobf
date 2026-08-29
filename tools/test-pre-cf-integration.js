"use strict";
const assert = require("assert");
const fs = require("fs");
const path = require("path");
const { parseLuaStructural } = require("../main");
const { generateBetaControlFlowFromSource } = require("./beta-control-flow");

const fixture = path.resolve(__dirname, "../sample/pre-cf/11-integration.normal.lua");
const output = path.resolve(__dirname, "../tmp/pre-cf-11-integration.beta.cf.lua");
const source = fs.readFileSync(fixture, "utf8");
const result = generateBetaControlFlowFromSource(source, parseLuaStructural(source, fixture), output);

assert.equal(result.beta.preCfTempRecovery.safe, true);
assert.equal(result.beta.preCfTempRecovery.applied, true);
assert.equal(result.beta.preCfTempRecovery.folds, 2);
assert.equal(result.beta.preCfScalarTemps.folds, 1);
assert.equal(result.beta.preCfReturnTemps.folds, 1);
assert.deepEqual(result.beta.preCfTempRecovery.stages, [
    "finalizePreCfCopyTemps",
    "finalizePreCfClosureTemps",
    "finalizePreCfCallResultDestinations",
    "finalizePreCfScalarTemps",
    "finalizePreCfGlobalLookups",
    "finalizePreCfLookupTemps",
    "finalizePreCfCallArgumentTemps",
    "finalizePreCfCallBaseTemps",
    "finalizePreCfNamecalls",
    "finalizePreCfReturnTemps",
    "finalizePreCfReturnAllTemps",
    "finalizePreCfMultiReturnTemps",
]);
assert.equal(result.controlFlow.applied, true);
assert.equal(result.controlFlow.stateCount, 1);
assert.equal(result.controlFlow.terminalReturnLowered, true);
parseLuaStructural(result.controlFlow.source, "<pre-cf-integration-output>");
console.log("canonical PRE-CF integration: PASS");