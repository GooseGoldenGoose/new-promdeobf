"use strict";

// Analyze downloaded samples without executing their payloads. Each file gets a
// separate process, bounded runtime, immutable input hash, and retained evidence.
const fs = require("fs");
const path = require("path");
const crypto = require("crypto");
const { spawnSync } = require("child_process");
const ROOT = path.resolve(__dirname, "..");
const hash = file => crypto.createHash("sha256").update(fs.readFileSync(file)).digest("hex");
function engineHash() {
    const files = ["main.js"];
    for (const directory of ["passes", "parser"]) {
        for (const file of fs.readdirSync(path.join(ROOT, directory), { recursive: true })) {
            if (file.endsWith(".js") && !file.endsWith(".debug.js")) files.push(path.join(directory, file));
        }
    }
    const digest = crypto.createHash("sha256");
    for (const file of files.sort()) digest.update(file).update(fs.readFileSync(path.join(ROOT, file)));
    return digest.digest("hex");
}

function worker(input, directory) {
    const { runDeobfuscator } = require("../main");
    const { generateBetaControlFlowFromSource } = require("./beta-control-flow");
    const result = { file: path.basename(input), inputHash: hash(input), engineHash: engineHash(), stage: "normal", recovered: false, syntax: false, luauSyntax: false, compiled: false };
    const started = Date.now();
    try {
        const normal = runDeobfuscator(input, path.join(directory, "normal.lua"), {
            analyzeBindings: false, structuralIntermediateAsts: true, structuralOutputAst: true,
        });
        result.normalMs = Date.now() - started;
        result.stage = "recovery";
        const recovered = generateBetaControlFlowFromSource(normal.outputSource, normal.outputAst, path.join(directory, "recovered.lua"));
        result.recovered = true;
        result.syntax = true; // generateBetaControlFlowFromSource parses before saving.
        result.mode = recovered.controlFlow.mode;
        result.states = recovered.controlFlow.stateCount;
        result.outputHash = hash(recovered.outputPath);
        const compiler = process.env.LUAU_COMPILE || path.resolve(ROOT, "..", "luau", "build", "Release", "luau-compile2.exe");
        result.stage = "luau-syntax";
        for (const [key, flags] of [["luauSyntax", ["--only-parse"]], ["compiled", []]]) {
            const check = spawnSync(compiler, ["--null", ...flags, recovered.outputPath], { encoding: "utf8", timeout: 30000, windowsHide: true });
            fs.writeFileSync(path.join(directory, `${key}.log`), (check.stdout || "") + (check.stderr || ""));
            if (check.error || check.status !== 0) throw new Error(check.error?.message || check.stderr || `${key} exit ${check.status}`);
            result[key] = true;
            result.stage = "luau-compile";
        }
        result.stage = "complete";
    } catch (error) {
        result.error = error.message;
        result.stack = error.stack;
    }
    result.elapsedMs = Date.now() - started;
    result.inputUnchanged = result.inputHash === hash(input);
    fs.writeFileSync(path.join(directory, "result.json"), JSON.stringify(result, null, 2));
}

function main() {
    const args = process.argv.slice(2);
    if (args[0] === "--worker") return worker(path.resolve(args[1]), path.resolve(args[2]));
    const input = path.resolve(args[0] || path.join(ROOT, "prod sample"));
    const output = path.resolve(args[1] || path.join(ROOT, "output", `production-${new Date().toISOString().replace(/[:.]/g, "-")}`));
    const files = fs.readdirSync(input).filter(name => name.endsWith(".lua")).sort();
    if (!files.length) throw new Error("No Lua samples found");
    fs.mkdirSync(output, { recursive: true });
    const results = [];
    for (const name of files) {
        const file = path.join(input, name);
        const directory = path.join(output, path.parse(name).name);
        fs.mkdirSync(directory); // Never mix fresh results with stale output.
        const before = hash(file);
        const start = Date.now();
        const child = spawnSync(process.execPath, [__filename, "--worker", file, directory], {
            cwd: ROOT, windowsHide: true, encoding: "utf8", timeout: 120000, maxBuffer: 8 * 1024 * 1024,
        });
        fs.writeFileSync(path.join(directory, "process.log"), (child.stdout || "") + (child.stderr || ""));
        const resultPath = path.join(directory, "result.json");
        const result = fs.existsSync(resultPath) ? JSON.parse(fs.readFileSync(resultPath, "utf8")) : {
            file: name, inputHash: before, inputUnchanged: before === hash(file), recovered: false, syntax: false,
            stage: "process", error: child.error?.message || `Worker exit ${child.status}`, elapsedMs: Date.now() - start,
        };
        results.push(result);
        fs.writeFileSync(path.join(output, "results.json"), JSON.stringify(results, null, 2));
        const passed = result.recovered && result.syntax && result.luauSyntax && result.compiled && result.inputUnchanged;
        console.log(`${results.length}/${files.length} ${passed ? "PASS" : "FAIL"} ${name} ${result.elapsedMs} ms ${result.error || ""}`);
    }
    const passed = results.filter(r => r.recovered && r.syntax && r.luauSyntax && r.compiled && r.inputUnchanged).length;
    console.log(`Recovery + Luau compilation: ${passed}/${files.length}. Roblox runtime: not tested. Report: ${output}`);
    process.exitCode = passed === files.length ? 0 : 1;
}

if (require.main === module) main();
