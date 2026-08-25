const fs = require("fs");
const path = require("path");
const { parseLuaStructural } = require("../main");
const { optimizeBetaSource } = require("../passes/beta-optimizer");

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.optimized${parsed.ext || ".lua"}`);
}

function main() {
    const inputArg = process.argv[2];
    if (!inputArg) throw new Error("Usage: node tools/beta-optimizer.js <input.lua> [output.lua]");
    const inputPath = path.resolve(inputArg);
    const outputPath = path.resolve(process.argv[3] || defaultOutputPath(inputPath));
    const source = fs.readFileSync(inputPath, "utf8");
    const result = optimizeBetaSource(source);
    parseLuaStructural(result.source, `${outputPath} <beta optimizer>`);
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
    fs.writeFileSync(outputPath, result.source, "utf8");
    console.log(`Input: ${inputPath}`);
    console.log(`Applied: ${result.applied}`);
    console.log(`Rounds: ${result.stats.rounds}`);
    console.log(`Global folds: ${result.stats.globalFolds}`);
    console.log(`Global alias inlines: ${result.stats.globalAliasInlines}`);
    console.log(`Single-use inlines: ${result.stats.singleUseInlines}`);
    console.log(`Dead locals: ${result.stats.deadLocals}`);
    console.log(`Dead call results: ${result.stats.deadCallResults}`);
    console.log(`Bare returns removed: ${result.stats.bareReturnsRemoved}`);
    console.log(`Output: ${outputPath}`);
    return result;
}

if (require.main === module) main();
module.exports = { defaultOutputPath, main };