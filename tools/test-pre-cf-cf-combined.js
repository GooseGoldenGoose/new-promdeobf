"use strict";

const assert = require("assert");
const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");
const { parseLuaStructural } = require("../main");
const { generateDeobfuscatedControlFlow } = require("./deobfuscate-beta-control-flow");

const root = path.resolve(__dirname, "..");
const focused = [
    "test-pre-cf-temp-recovery.js",
    "test-pre-cf-closure-temps.js",
    "test-pre-cf-call-result-destinations.js",
    "test-pre-cf-table-destinations.js",
    "test-pre-cf-table-entry-temps.js",
    "test-pre-cf-index-key-temps.js",
    "test-pre-cf-global-writes.js",
    "test-pre-cf-indexed-write-temps.js",
    "test-pre-cf-closure-write-destinations.js",
    "test-pre-cf-discarded-call-results.js",
    "test-pre-cf-scalar-temps.js",
    "test-pre-cf-global-lookups.js",
    "test-pre-cf-lookup-temps.js",
    "test-pre-cf-call-setup-chains.js",
    "test-pre-cf-call-argument-temps.js",
    "test-pre-cf-call-base-temps.js",
    "test-pre-cf-namecalls.js",
    "test-pre-cf-return-temps.js",
    "test-pre-cf-return-all-temps.js",
    "test-pre-cf-return-literal-temps.js",
    "test-pre-cf-multi-return-temps.js",
    "test-pre-cf-integration.js",
    "test-beta-cf-condition-temps.js",
    "test-beta-cf-global-aliases.js",
    "test-beta-cf-iife-return-all.js",
    "test-beta-cf-repeat-multistate-precheck.js",
    "test-beta-cf-numeric-for-temps.js",
    "test-beta-cf-generic-for-temps.js",
    "test-beta-cf-loop-control-temps.js",
    "test-beta-cf-post-pre-cf-shapes.js",
    "test-beta-cf-post-copy-scalar.js",
    "test-beta-cf-post-closure-destinations.js",
    "test-beta-cf-post-dead-closures.js",
    "test-beta-cf-post-namecalls.js",
    "test-beta-cf-expression-presentation.js",
    "test-beta-cf-post-static-members.js",
    "test-beta-cf-post-function-declarations.js",
    "test-beta-cf-post-dead-scalars.js",
    "test-beta-cf-post-discarded-call-results.js",
    "test-beta-cf-closure-signatures.js",
    "test-beta-control-flow.js",
    "test-production-pipeline.js",
];

for (const file of focused) {
    const result = spawnSync(process.execPath, [path.join(__dirname, file)], {
        cwd: root,
        encoding: "utf8",
        stdio: "pipe",
    });
    if (result.status !== 0) {
        process.stdout.write(result.stdout || "");
        process.stderr.write(result.stderr || "");
        throw new Error(`focused regression failed: ${file}`);
    }
}

const tmpRoot = path.join(root, "tmp", "pre-cf-cf-combined");
fs.mkdirSync(tmpRoot, { recursive: true });
let generated = 0;
for (let sample = 1; sample <= 66; sample++) {
    const input = path.join(root, "sample", `${sample}.txt`);
    assert(fs.existsSync(input), `missing canonical sample ${sample}.txt`);
    const normal = path.join(tmpRoot, `${sample}.normal.lua`);
    const finalCf = path.join(tmpRoot, `${sample}.cf.lua`);
    const result = generateDeobfuscatedControlFlow(input, normal, finalCf);
    assert.equal(result.controlFlow.applied, true, `sample ${sample}: CF did not apply`);
    assert.equal(result.beta.preCfTempRecovery?.safe, true, `sample ${sample}: PRE-CF did not finish safely`);
    parseLuaStructural(result.controlFlow.source, `<combined-${sample}-cf>`);
    generated++;
}

assert.equal(generated, 66);
console.log(`PRE-CF + CF combined regression: PASS (${focused.length} focused suites, ${generated}/66 canonical samples)`);
