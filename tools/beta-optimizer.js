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
    console.log(`Full parses: ${result.stats.parseRounds}`);
    console.log(`Fixed point: ${!result.stats.parseLimitHit}`);
    console.log(`Global folds: ${result.stats.globalFolds}`);
    console.log(`Global alias inlines: ${result.stats.globalAliasInlines}`);
    console.log(`Single-use inlines: ${result.stats.singleUseInlines}`);
    console.log(`Small function inlines: ${result.stats.smallFunctionInlines}`);
    console.log(`Direct nil cleanup writes removed: ${result.stats.directNilCleanupWritesRemoved}`);
    console.log(`Adjacent copy chains folded: ${result.stats.adjacentCopyChainsFolded}`);
    console.log(`Adjacent index base aliases folded: ${result.stats.adjacentIndexBaseAliasesFolded}`);
    console.log(`Adjacent index keys inlined: ${result.stats.adjacentIndexKeyInlines}`);
    console.log(`Adjacent assignment keys inlined: ${result.stats.adjacentAssignmentKeyInlines}`);
    console.log(`Adjacent call arguments inlined: ${result.stats.adjacentCallArgumentInlines}`);
    console.log(`Adjacent assignment values inlined: ${result.stats.adjacentAssignmentValueInlines}`);
    console.log(`Repeat tail condition temps inlined: ${result.stats.repeatTailConditionTempsInlined}`);
    console.log(`Deferred local initializers folded: ${result.stats.deferredLocalInitializersFolded}`);
    console.log(`Dead locals: ${result.stats.deadLocals}`);
    console.log(`Dead call results: ${result.stats.deadCallResults}`);
    console.log(`Bare returns removed: ${result.stats.bareReturnsRemoved}`);
    console.log(`Multi-return tables collapsed: ${result.stats.multiReturnTableCollapses}`);
    console.log(`Multi-return forwarders collapsed: ${result.stats.multiReturnForwardersCollapsed}`);
    console.log(`Multi-return slots recovered: ${result.stats.multiReturnSlotsRecovered}`);
    console.log(`Multi-return placeholders: ${result.stats.multiReturnPlaceholders}`);
    console.log(`Multi-return unused targets: ${result.stats.multiReturnUnusedTargets}`);
    console.log(`Generic-for tuples inlined: ${result.stats.genericForTupleInlines}`);
    console.log(`Generic-for tuple locals removed: ${result.stats.genericForTupleLocalsRemoved}`);
    console.log(`Short-circuit ladders collapsed: ${result.stats.shortCircuitLaddersCollapsed}`);
    console.log(`Value short-circuit ladders collapsed: ${result.stats.valueShortCircuitLaddersCollapsed}`);
    console.log(`While conditions collapsed: ${result.stats.whileConditionsCollapsed}`);
    console.log(`Repeat conditions collapsed: ${result.stats.repeatConditionsCollapsed}`);
    console.log(`Repeat discarded prechecks removed: ${result.stats.repeatPrechecksRemoved}`);
    console.log(`Output: ${outputPath}`);
    return result;
}

if (require.main === module) main();
module.exports = { defaultOutputPath, main };
