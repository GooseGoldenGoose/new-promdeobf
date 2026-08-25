const fs = require("fs");
const path = require("path");
const { parseLuaStructural } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");
const { solveBetaControlFlow } = require("../passes/beta-control-flow-legacy");

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta.legacy.cf${parsed.ext || ".lua"}`);
}

function generateBetaControlFlowFromSource(source, ast, outputPath) {
    const resolvedOutput = path.resolve(outputPath);
    const beta = versionVmBlockRegisters(source, ast);
    if (!beta.found || !beta.applied) {
        throw new Error(beta.reason || "Beta register analysis did not apply");
    }

    const controlFlow = solveBetaControlFlow(ast, beta);
    if (!controlFlow.applied) throw new Error(controlFlow.reason || "Beta control-flow solving did not apply");

    parseLuaStructural(controlFlow.source, `${resolvedOutput} <beta control flow>`);
    fs.mkdirSync(path.dirname(resolvedOutput), { recursive: true });
    fs.writeFileSync(resolvedOutput, controlFlow.source, "utf8");
    return { beta, controlFlow, outputPath: resolvedOutput };
}

function generateBetaControlFlow(inputPath, outputPath = null) {
    const resolvedInput = path.resolve(inputPath);
    const resolvedOutput = path.resolve(outputPath || defaultOutputPath(resolvedInput));
    const source = fs.readFileSync(resolvedInput, "utf8");
    const ast = parseLuaStructural(source, resolvedInput);
    return generateBetaControlFlowFromSource(source, ast, resolvedOutput);
}

function main() {
    const inputArg = process.argv[2];
    if (!inputArg) throw new Error("Usage: node tools/beta-control-flow-legacy.js <output.lua> [output.beta.legacy.cf.lua]");
    const generated = generateBetaControlFlow(inputArg, process.argv[3] || null);
    console.log(`Mode: ${generated.controlFlow.mode}`);
    console.log(`Entry state: ${generated.controlFlow.entryState}`);
    console.log(`States: ${generated.controlFlow.stateCount}`);
    console.log(`Statements: ${generated.controlFlow.statementCount}`);
    console.log(`Branches: ${generated.controlFlow.branchCount || 0}`);
    if (generated.controlFlow.joinCount !== undefined) console.log(`Branch joins: ${generated.controlFlow.joinCount}`);
    if (generated.controlFlow.guardBranchCount !== undefined) console.log(`Guard-return branches: ${generated.controlFlow.guardBranchCount}`);
    if (generated.controlFlow.numericForLoopCount !== undefined) console.log(`Numeric for loops: ${generated.controlFlow.numericForLoopCount}`);
    if (generated.controlFlow.genericForLoopCount !== undefined) console.log(`Generic for loops: ${generated.controlFlow.genericForLoopCount}`);
    if (generated.controlFlow.whileLoopCount !== undefined) console.log(`While loops: ${generated.controlFlow.whileLoopCount}`);
    if (generated.controlFlow.repeatLoopCount !== undefined) console.log(`Repeat loops: ${generated.controlFlow.repeatLoopCount}`);
    if (generated.controlFlow.removedRepeatCompilerConditionOperationCount) console.log(`Repeat compiler-junk condition operations removed: ${generated.controlFlow.removedRepeatCompilerConditionOperationCount}`);
    if (generated.controlFlow.posPreservationRemoval?.removed) console.log(`POS preservation operations removed: ${generated.controlFlow.posPreservationRemoval.removed}`);
    if (generated.controlFlow.terminalReturnCount !== undefined) console.log(`Terminal returns: ${generated.controlFlow.terminalReturnCount}`);
    if (generated.controlFlow.closureRegionCount !== undefined) console.log(`Closure regions: ${generated.controlFlow.closureRegionCount}`);
    if (generated.controlFlow.inlinedClosureFactoryCount !== undefined) console.log(`Inlined closure factories: ${generated.controlFlow.inlinedClosureFactoryCount}`);
    if (generated.controlFlow.upvalueRecoveryApplied) {
        console.log(`Recovered upvalue cells: ${generated.controlFlow.recoveredUpvalueCellCount}`);
        console.log(`Recovered capture slots: ${generated.controlFlow.recoveredCaptureCount}`);
        console.log(`Upvalue reads/writes rewritten: ${generated.controlFlow.upvalueReadRewriteCount}/${generated.controlFlow.upvalueWriteRewriteCount}`);
        console.log(`Upvalue releases removed: ${generated.controlFlow.upvalueReleaseRemovalCount}`);
    }
    console.log(`Return payload sunk: ${generated.controlFlow.terminalReturnPayloadSunk}`);
    console.log(`Terminal return lowered: ${generated.controlFlow.terminalReturnLowered}`);
    if (generated.controlFlow.environmentHeader) console.log(`Header: ${generated.controlFlow.environmentHeader}`);
    console.log(`Output: ${generated.outputPath}`);
}

if (require.main === module) main();

module.exports = {
    defaultOutputPath,
    generateBetaControlFlowFromSource,
    generateBetaControlFlow,
};
