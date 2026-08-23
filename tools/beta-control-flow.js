const fs = require("fs");
const path = require("path");
const { parseLua } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta.cf${parsed.ext || ".lua"}`);
}

function generateBetaControlFlow(inputPath, outputPath = null) {
    const resolvedInput = path.resolve(inputPath);
    const resolvedOutput = path.resolve(outputPath || defaultOutputPath(resolvedInput));
    const source = fs.readFileSync(resolvedInput, "utf8");
    const ast = parseLua(source, resolvedInput);
    const beta = versionVmBlockRegisters(source, ast);
    if (!beta.found || !beta.applied) {
        throw new Error(beta.reason || "Beta register analysis did not apply");
    }

    const controlFlow = solveBetaControlFlow(ast, beta);
    if (!controlFlow.applied) throw new Error(controlFlow.reason || "Beta control-flow solving did not apply");

    parseLua(controlFlow.source, `${resolvedOutput} <beta control flow>`);
    fs.mkdirSync(path.dirname(resolvedOutput), { recursive: true });
    fs.writeFileSync(resolvedOutput, controlFlow.source, "utf8");
    return { beta, controlFlow, outputPath: resolvedOutput };
}

function main() {
    const inputArg = process.argv[2];
    if (!inputArg) throw new Error("Usage: node tools/beta-control-flow.js <output.lua> [output.beta.cf.lua]");
    const generated = generateBetaControlFlow(inputArg, process.argv[3] || null);
    console.log(`Mode: ${generated.controlFlow.mode}`);
    console.log(`Entry state: ${generated.controlFlow.entryState}`);
    console.log(`Statements: ${generated.controlFlow.statementCount}`);
    console.log(`Return payload sunk: ${generated.controlFlow.terminalReturnPayloadSunk}`);
    console.log(`Terminal return lowered: ${generated.controlFlow.terminalReturnLowered}`);
    if (generated.controlFlow.environmentHeader) console.log(`Header: ${generated.controlFlow.environmentHeader}`);
    console.log(`Output: ${generated.outputPath}`);
}

if (require.main === module) main();

module.exports = {
    defaultOutputPath,
    generateBetaControlFlow,
};
