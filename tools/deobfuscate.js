"use strict";

const fs = require("fs");
const path = require("path");
const { generateDeobfuscatedControlFlow } = require("./deobfuscate-beta-control-flow");

function defaultProductionPaths(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    const root = path.resolve(__dirname, "..");
    const baseName = parsed.name.replace(/\.txt$/i, "");
    return {
        output: path.join(root, "output", `${baseName}.lua`),
        intermediate: path.join(root, "tmp", "production", `${baseName}.normal.lua`),
    };
}

function generateDeobfuscatedSource(inputPath, outputPath = null, intermediatePath = null) {
    const defaults = defaultProductionPaths(inputPath);
    const finalPath = path.resolve(outputPath || defaults.output);
    const normalPath = path.resolve(intermediatePath || defaults.intermediate);
    fs.mkdirSync(path.dirname(finalPath), { recursive: true });
    fs.mkdirSync(path.dirname(normalPath), { recursive: true });
    const result = generateDeobfuscatedControlFlow(inputPath, normalPath, finalPath);
    return { ...result, outputPath: finalPath, intermediateOutputPath: normalPath };
}

function main() {
    const inputPath = process.argv[2];
    if (!inputPath) throw new Error("Usage: node tools/deobfuscate.js <sample.txt> [output.lua] [intermediate.normal.lua]");
    const result = generateDeobfuscatedSource(inputPath, process.argv[3] || null, process.argv[4] || null);
    if (!result.normal.formatterSkipped) console.log(`Input formatted before parse: ${result.normal.formatted}`);
    console.log(`Output: ${result.outputPath}`);
    console.log(`States: ${result.controlFlow.stateCount}`);
    console.log(`Closures: ${result.controlFlow.closureRegionCount || 0}`);
}

if (require.main === module) main();

module.exports = {
    defaultProductionPaths,
    generateDeobfuscatedSource,
};