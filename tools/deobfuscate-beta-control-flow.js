const path = require("path");
const { runDeobfuscator } = require("../main");
const { generateBetaControlFlowFromSource } = require("./beta-control-flow");

function defaultPaths(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    const outputDir = path.resolve(__dirname, "..", "output");
    const baseName = parsed.name.replace(/\.txt$/i, "");
    return {
        normal: path.join(outputDir, `${baseName}.lua`),
        controlFlow: path.join(outputDir, `${baseName}.beta.cf.lua`),
    };
}

function generateDeobfuscatedControlFlow(inputPath, normalOutputPath = null, controlFlowOutputPath = null) {
    const defaults = defaultPaths(inputPath);
    const normalPath = path.resolve(normalOutputPath || defaults.normal);
    const controlFlowPath = path.resolve(controlFlowOutputPath || defaults.controlFlow);

    // VM binding recovery is diagnostic-only for normal output. The beta pipeline
    // rebuilds its own register/lifetime/capture proof, so skip that duplicate
    // analysis when normal output is immediately handed to beta-CF in-process.
    const normal = runDeobfuscator(inputPath, normalPath, {
        analyzeBindings: false,
        structuralIntermediateAsts: true,
        structuralOutputAst: true,
    });
    const generated = generateBetaControlFlowFromSource(
        normal.outputSource,
        normal.outputAst,
        controlFlowPath,
    );
    return { normal, ...generated, normalOutputPath: normalPath };
}

function main() {
    const inputPath = process.argv[2];
    if (!inputPath) {
        throw new Error("Usage: node tools/deobfuscate-beta-control-flow.js <sample.txt> [normal.lua] [output.beta.cf.lua]");
    }
    const result = generateDeobfuscatedControlFlow(inputPath, process.argv[3] || null, process.argv[4] || null);
    if (!result.normal.formatterSkipped) console.log(`Input formatted before parse: ${result.normal.formatted}`);
    console.log(`Normal output: ${result.normalOutputPath}`);
    console.log(`Beta-CF output: ${result.outputPath}`);
    console.log(`States: ${result.controlFlow.stateCount}`);
    console.log(`Closures: ${result.controlFlow.closureRegionCount || 0}`);
}

if (require.main === module) main();

module.exports = {
    defaultPaths,
    generateDeobfuscatedControlFlow,
};
