const fs = require("fs");
const path = require("path");
const luaparse = require("./parser/luaparse");
const { inlinePrometheusConstantArray } = require("./passes/constant-array");

const ROOT = __dirname;
const DEFAULT_INPUT = path.join(ROOT, "sample", "1.txt");
const DEFAULT_OUTPUT = path.join(ROOT, "output", "01-constant-table.lua");
const DEFAULT_AST_OUTPUT = path.join(ROOT, "output", "ast.json");

function parseLua(source, filename = "<input>") {
    try {
        return luaparse.parse(source, {
            luaVersion: "luau",
            comments: true,
            scope: true,
            locations: true,
            ranges: true,
        });
    } catch (error) {
        error.message = `Failed to parse ${filename}: ${error.message}`;
        throw error;
    }
}

function loadAst(inputPath = DEFAULT_INPUT) {
    const absoluteInput = path.resolve(inputPath);
    const source = fs.readFileSync(absoluteInput, "utf8");
    const ast = parseLua(source, absoluteInput);
    return { inputPath: absoluteInput, source, ast };
}

function writeAst(ast, outputPath = DEFAULT_AST_OUTPUT) {
    const absoluteOutput = path.resolve(outputPath);
    fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
    fs.writeFileSync(absoluteOutput, JSON.stringify(ast, null, 2), "utf8");
    return absoluteOutput;
}

function writeSource(source, outputPath = DEFAULT_OUTPUT) {
    const absoluteOutput = path.resolve(outputPath);
    fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
    fs.writeFileSync(absoluteOutput, source, "utf8");
    return absoluteOutput;
}

function runDeobfuscator(inputPath = DEFAULT_INPUT, outputPath = DEFAULT_OUTPUT) {
    const loaded = loadAst(inputPath);
    const constants = inlinePrometheusConstantArray(loaded.source, loaded.ast);
    if (!constants.found) throw new Error(constants.reason);

    const outputAst = parseLua(constants.source, outputPath);
    const resolvedOutput = writeSource(constants.source, outputPath);

    return {
        ...loaded,
        outputAst,
        outputPath: resolvedOutput,
        outputSource: constants.source,
        constantArray: constants,
    };
}

function main() {
    const inputPath = process.argv[2] || DEFAULT_INPUT;
    const outputPath = process.argv[3] || DEFAULT_OUTPUT;
    const result = runDeobfuscator(inputPath, outputPath);
    const info = result.constantArray;

    console.log(`Input: ${result.inputPath}`);
    console.log(`AST root: ${result.ast.type}`);
    console.log(`Constant entries: ${info.constants.length}`);
    console.log(`Constant references inlined: ${info.replacements.length}`);
    console.log(`Array rotated: ${info.rotated}`);
    console.log(`Strings decoded: ${info.decoded}`);
    console.log(`Prelude removed: ${info.removedPrelude}`);
    console.log(`Unresolved wrapper uses: ${info.unresolvedWrapperUses}`);
    console.log(`Unresolved array uses: ${info.unresolvedArrayUses}`);
    console.log(`Output: ${result.outputPath}`);
    return result;
}

if (require.main === module) main();

module.exports = {
    parseLua,
    loadAst,
    writeAst,
    writeSource,
    runDeobfuscator,
    main,
};
