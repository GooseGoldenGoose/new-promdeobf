const fs = require("fs");
const path = require("path");
const { parseLua } = require("../main");
const { resolveEntryStateGraphBeta } = require("../passes/entry-state-beta");

const ROOT = path.resolve(__dirname, "..");
const inputPath = path.resolve(process.argv[2] || path.join(ROOT, "output", "1.lua"));
const outputPath = path.resolve(process.argv[3] || path.join(ROOT, "output", "1.beta.lua"));

const source = fs.readFileSync(inputPath, "utf8");
const ast = parseLua(source, `${inputPath} <beta input>`);
const result = resolveEntryStateGraphBeta(source, ast);
if (!result.found) throw new Error(result.reason || "Unable to resolve beta entry-state graph");

parseLua(result.source, `${outputPath} <beta output>`);
fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, result.source, "utf8");

function termText(term) {
    if (!term) return "unknown";
    if (term.kind === "jump") return `jump -> ${term.target}`;
    if (term.kind === "branch") return `branch (${term.condition}) ? ${term.onTrue} : ${term.onFalse}`;
    if (term.kind === "stop") return `stop (${term.expression})`;
    return term.kind;
}

console.log(`Beta input: ${inputPath}`);
console.log(`Root entry state: ${result.rootEntryId}`);
console.log(`Dispatcher leaves: ${result.resolvedLeafCount}/${result.dispatcherLeafCount}`);
console.log(`Complete explicit dispatcher: ${result.complete}`);
for (const root of result.graphRoots) {
    console.log(`Graph root: ${root.kind} ${root.factory}(${root.entryId})`);
    for (const id of root.graph.order) {
        const block = root.graph.blocks.get(id);
        console.log(`  state ${id}: ${termText(block?.terminator)}`);
        if (block?.path?.length) console.log(`    dispatch path: ${block.path.join(" | ")}`);
    }
}
console.log(`Beta output: ${outputPath}`);
