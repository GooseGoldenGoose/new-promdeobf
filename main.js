const fs = require("fs");
const path = require("path");
const luaparse = require("./parser/luaparse");

const ROOT = __dirname;
const DEFAULT_INPUT = path.join(ROOT, "formater", "out.txt");
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

    return {
        inputPath: absoluteInput,
        source,
        ast,
    };
}

function writeAst(ast, outputPath = DEFAULT_AST_OUTPUT) {
    const absoluteOutput = path.resolve(outputPath);
    fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
    fs.writeFileSync(absoluteOutput, JSON.stringify(ast, null, 2), "utf8");
    return absoluteOutput;
}

function main() {
    const inputPath = process.argv[2] || DEFAULT_INPUT;
    const outputPath = process.argv[3] || DEFAULT_AST_OUTPUT;

    const { ast, source, inputPath: resolvedInput } = loadAst(inputPath);
    const resolvedOutput = writeAst(ast, outputPath);

    console.log(`Input: ${resolvedInput}`);
    console.log(`Source bytes: ${Buffer.byteLength(source, "utf8")}`);
    console.log(`AST root: ${ast.type}`);
    console.log(`Top-level statements: ${ast.body.length}`);
    console.log(`AST: ${resolvedOutput}`);

    return ast;
}

if (require.main === module) {
    main();
}

module.exports = {
    parseLua,
    loadAst,
    writeAst,
    main,
};
