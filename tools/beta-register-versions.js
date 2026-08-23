const fs = require("fs");
const path = require("path");
const { parseLua } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta${parsed.ext || ".lua"}`);
}

function main() {
    const inputArg = process.argv[2];
    if (!inputArg) throw new Error("Usage: node tools/beta-register-versions.js <output.lua> [output.beta.lua]");

    const inputPath = path.resolve(inputArg);
    const outputPath = path.resolve(process.argv[3] || defaultOutputPath(inputPath));
    const source = fs.readFileSync(inputPath, "utf8");
    const ast = parseLua(source, inputPath);
    const result = versionVmBlockRegisters(source, ast);
    if (!result.found || !result.applied) {
        throw new Error(result.reason || "Beta register versioning did not apply");
    }

    parseLua(result.source, `${outputPath} <beta register versions>`);
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
    fs.writeFileSync(outputPath, result.source, "utf8");

    console.log(`Input: ${inputPath}`);
    console.log(`VM state blocks: ${result.blockCount}`);
    console.log(`Versioned assignments: ${result.versionedAssignmentCount}`);
    console.log(`Preserved final state/return-table writes: ${result.preservedFinalWrites}`);
    console.log(`Skipped assignments: ${result.skippedAssignments}`);
    for (const item of result.mapping) console.log(`Register version base: ${item.originalName} -> ${item.baseName}`);
    console.log(`Output: ${outputPath}`);
    return result;
}

if (require.main === module) main();

module.exports = {
    defaultOutputPath,
    main,
};
