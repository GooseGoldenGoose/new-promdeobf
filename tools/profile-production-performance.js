"use strict";

const fs = require("fs");
const path = require("path");
const inspector = require("inspector");
const crypto = require("crypto");
const { performance } = require("perf_hooks");
const { runDeobfuscator } = require("../main");
const { generateBetaControlFlowFromSource } = require("./beta-control-flow");

function post(session, method, params = {}) {
    return new Promise((resolve, reject) => {
        session.post(method, params, (error, result) => error ? reject(error) : resolve(result));
    });
}

function sha256(file) {
    return crypto.createHash("sha256").update(fs.readFileSync(file)).digest("hex");
}

function summarizeCpuProfile(profile, limit = 30) {
    const byId = new Map((profile.nodes || []).map(node => [node.id, node]));
    const ownMicros = new Map();
    const samples = profile.samples || [];
    const deltas = profile.timeDeltas || [];
    for (let i = 0; i < samples.length; i++) {
        const id = samples[i];
        ownMicros.set(id, (ownMicros.get(id) || 0) + Number(deltas[i] || 0));
    }
    const rows = [];
    for (const [id, micros] of ownMicros) {
        const node = byId.get(id);
        if (!node) continue;
        const frame = node.callFrame || {};
        rows.push({
            function: frame.functionName || "(anonymous)",
            file: frame.url ? path.relative(process.cwd(), frame.url.replace(/^file:\/\//, "")) : "",
            line: Number(frame.lineNumber || 0) + 1,
            selfMs: micros / 1000,
        });
    }
    rows.sort((a, b) => b.selfMs - a.selfMs);
    return rows.slice(0, limit);
}

async function main() {
    const root = path.resolve(__dirname, "..");
    const input = path.resolve(process.argv[2] || path.join(root, "sample", "spacial6.txt"));
    const outDir = path.resolve(process.argv[3] || path.join(root, "tmp", "performance-profile"));
    fs.mkdirSync(outDir, { recursive: true });
    const base = path.parse(input).name;
    const normalPath = path.join(outDir, `${base}.normal.lua`);
    const finalPath = path.join(outDir, `${base}.final.lua`);
    const cpuPath = path.join(outDir, `${base}.cpuprofile`);
    const summaryPath = path.join(outDir, `${base}.summary.json`);

    const session = new inspector.Session();
    session.connect();
    await post(session, "Profiler.enable");
    await post(session, "Profiler.start");

    const totalStart = performance.now();
    const normalStart = performance.now();
    const normal = runDeobfuscator(input, normalPath, {
        analyzeBindings: false,
        structuralIntermediateAsts: true,
        structuralOutputAst: true,
    });
    const normalMs = performance.now() - normalStart;

    const betaStart = performance.now();
    const generated = generateBetaControlFlowFromSource(normal.outputSource, normal.outputAst, finalPath);
    const betaCfMs = performance.now() - betaStart;
    const totalMs = performance.now() - totalStart;

    const { profile } = await post(session, "Profiler.stop");
    session.disconnect();
    fs.writeFileSync(cpuPath, JSON.stringify(profile));

    const summary = {
        input,
        normalPath,
        finalPath,
        cpuProfilePath: cpuPath,
        normalMs,
        betaCfMs,
        totalMs,
        states: generated.controlFlow.stateCount,
        closures: generated.controlFlow.closureRegionCount || 0,
        outputBytes: fs.statSync(finalPath).size,
        outputSha256: sha256(finalPath),
        topSelfTime: summarizeCpuProfile(profile),
    };
    fs.writeFileSync(summaryPath, JSON.stringify(summary, null, 2));

    console.log(`Normal: ${(normalMs / 1000).toFixed(3)} s`);
    console.log(`Beta+CF: ${(betaCfMs / 1000).toFixed(3)} s`);
    console.log(`Total: ${(totalMs / 1000).toFixed(3)} s`);
    console.log(`States: ${summary.states}`);
    console.log(`Closures: ${summary.closures}`);
    console.log(`Final: ${finalPath}`);
    console.log(`CPU profile: ${cpuPath}`);
    console.log(`Summary: ${summaryPath}`);
    console.log("Top self-time:");
    for (const row of summary.topSelfTime.slice(0, 15)) {
        console.log(`${row.selfMs.toFixed(1).padStart(9)} ms  ${row.function}  ${row.file}:${row.line}`);
    }
}

main().catch(error => {
    console.error(error?.stack || error);
    process.exitCode = 1;
});
