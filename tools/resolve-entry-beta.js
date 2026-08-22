const fs = require("fs");
const path = require("path");
const { parseLua } = require("../main");
const { resolveFirstEntryStateBeta } = require("../passes/entry-state-beta");

const ROOT = path.resolve(__dirname, "..");
const inputPath = path.resolve(process.argv[2] || path.join(ROOT, "output", "1.lua"));
const outputPath = path.resolve(process.argv[3] || path.join(ROOT, "output", "1.beta.lua"));

const source = fs.readFileSync(inputPath, "utf8");
const ast = parseLua(source, `${inputPath} <beta input>`);
const result = resolveFirstEntryStateBeta(source, ast);

if (!result.found) {
    throw new Error(result.reason || "Unable to resolve beta entry state");
}

parseLua(result.source, `${outputPath} <beta output>`);

fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, result.source, "utf8");

console.log(`Beta input: ${inputPath}`);
console.log(`Root entry state: ${result.entryId}`);
console.log(`Dispatcher path: ${result.path.length ? result.path.join(" | ") : "direct dispatcher body"}`);
console.log(`Resolved statements: ${result.resolvedStatementCount}`);
console.log(`Beta output: ${outputPath}`);
