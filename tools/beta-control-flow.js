const fs = require("fs");
const path = require("path");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parseLuaStructural(source, filename = "<input>") {
    try {
        return luaparse.parse(source, { luaVersion: "luau", comments: false, scope: false, locations: false, ranges: true });
    } catch (error) {
        error.message = `${filename}: ${error.message}`;
        throw error;
    }
}

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta.cf${parsed.ext || ".lua"}`);
}

function generateBetaControlFlowFromSource(source, ast, outputPath) {
    const resolvedOutput = path.resolve(outputPath);
    const controlFlow = solveBetaControlFlow(source, ast);
    if (!controlFlow.applied) throw new Error(controlFlow.reason || "Fresh beta control-flow solving did not apply");
    parseLuaStructural(controlFlow.source, `${resolvedOutput} <fresh beta control flow>`);
    fs.mkdirSync(path.dirname(resolvedOutput), { recursive: true });
    fs.writeFileSync(resolvedOutput, controlFlow.source, "utf8");
    return { controlFlow, outputPath: resolvedOutput };
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
    if (!inputArg) throw new Error("Usage: node tools/beta-control-flow.js <normal-output.lua> [output.beta.cf.lua]");
    const generated = generateBetaControlFlow(inputArg, process.argv[3] || null);
    console.log(`Mode: ${generated.controlFlow.mode}`);
    console.log(`States: ${generated.controlFlow.stateCount}`);
    console.log(`Statements: ${generated.controlFlow.statementCount}`);
    console.log(`Global: ${generated.controlFlow.globalName}`);
    console.log(`Arguments: ${generated.controlFlow.argumentCount}`);
    console.log(`Output: ${generated.outputPath}`);
}

if (require.main === module) main();

module.exports = { defaultOutputPath, generateBetaControlFlowFromSource, generateBetaControlFlow };
