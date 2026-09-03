const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");
const { generateDeobfuscatedControlFlow } = require("./deobfuscate-beta-control-flow");

const ROOT = path.resolve(__dirname, "..");
const PROMETHEUS_ROOT = path.resolve(ROOT, "..", "wearedev obf");
const PROMETHEUS_CLI = path.join(PROMETHEUS_ROOT, "cli.lua");
const OUTPUT_ROOT = path.join(ROOT, "output");

function elapsedMs(start) {
    return Number(process.hrtime.bigint() - start) / 1e6;
}

function fmtMs(ms) {
    return ms >= 1000 ? `${(ms / 1000).toFixed(3)} s` : `${ms.toFixed(1)} ms`;
}

function runProcess(executable, args, cwd) {
    const result = spawnSync(executable, args, {
        cwd,
        encoding: "utf8",
        windowsHide: true,
        maxBuffer: 64 * 1024 * 1024,
    });

    if (result.error) throw result.error;
    return result;
}

function assertSuccess(label, result) {
    if (result.status === 0) return;
    const stdout = (result.stdout || "").trim();
    const stderr = (result.stderr || "").trim();
    const details = [stdout, stderr].filter(Boolean).join("\n");
    throw new Error(`${label} failed with exit code ${result.status}${details ? `\n${details}` : ""}`);
}

function runtimeSnapshot(filePath) {
    const result = runProcess("luajit.exe", [filePath], ROOT);
    return {
        status: result.status,
        stdout: result.stdout || "",
        stderr: result.stderr || "",
    };
}

function sameRuntime(a, b) {
    return a.status === b.status && a.stdout === b.stdout && a.stderr === b.stderr;
}

function parseArgs(argv) {
    const options = {
        preset: "Medium",
        runtime: false,
        sources: [],
    };

    for (let i = 0; i < argv.length; i += 1) {
        const arg = argv[i];
        if (arg === "--runtime" || arg === "--run") {
            options.runtime = true;
            continue;
        }
        if (arg === "--preset") {
            if (!argv[i + 1]) throw new Error("--preset requires a value");
            options.preset = argv[++i];
            continue;
        }
        if (arg === "--help" || arg === "-h") {
            options.help = true;
            continue;
        }
        if (arg.startsWith("--")) throw new Error(`Unknown option: ${arg}`);
        options.sources.push(arg);
    }

    return options;
}

function printUsage() {
    console.log("Usage: node tools/fast-obf-deobf.js <source.lua> [more.lua ...] [--runtime] [--preset Medium]");
    console.log("");
    console.log("Runs in one command:");
    console.log("  source -> Prometheus obfuscate -> normal deobf -> Fresh CF");
    console.log("");
    console.log("--runtime  Also run source/obfuscated/recovered with LuaJIT and require exact output/status parity.");
}

function runOne(sourceArg, options) {
    const sourcePath = path.resolve(sourceArg);
    if (!fs.existsSync(sourcePath)) throw new Error(`Source not found: ${sourcePath}`);
    if (!fs.existsSync(PROMETHEUS_CLI)) throw new Error(`Prometheus CLI not found: ${PROMETHEUS_CLI}`);

    fs.mkdirSync(OUTPUT_ROOT, { recursive: true });

    const parsed = path.parse(sourcePath);
    const stem = parsed.name;
    const obfuscatedPath = path.join(OUTPUT_ROOT, `${stem}.obfuscated.lua`);
    const normalPath = path.join(OUTPUT_ROOT, `${stem}.normal.lua`);
    const freshPath = path.join(OUTPUT_ROOT, `${stem}.beta.cf.lua`);

    const totalStart = process.hrtime.bigint();

    const obfStart = process.hrtime.bigint();
    const obf = runProcess(
        "luajit.exe",
        [PROMETHEUS_CLI, "--preset", options.preset, sourcePath, "--out", obfuscatedPath, "--nocolors"],
        PROMETHEUS_ROOT,
    );
    assertSuccess("Prometheus obfuscation", obf);
    const obfMs = elapsedMs(obfStart);

    const deobfStart = process.hrtime.bigint();
    const result = generateDeobfuscatedControlFlow(obfuscatedPath, normalPath, freshPath);
    const deobfMs = elapsedMs(deobfStart);

    let runtimeMs = 0;
    let runtimeResult = null;
    if (options.runtime) {
        const runtimeStart = process.hrtime.bigint();
        const sourceRun = runtimeSnapshot(sourcePath);
        const obfuscatedRun = runtimeSnapshot(obfuscatedPath);
        const recoveredRun = runtimeSnapshot(freshPath);
        runtimeMs = elapsedMs(runtimeStart);

        runtimeResult = {
            sourceRun,
            obfuscatedRun,
            recoveredRun,
            sourceVsObfuscated: sameRuntime(sourceRun, obfuscatedRun),
            sourceVsRecovered: sameRuntime(sourceRun, recoveredRun),
        };

        if (!runtimeResult.sourceVsObfuscated || !runtimeResult.sourceVsRecovered) {
            throw new Error(
                `Runtime parity failed for ${sourcePath}\n` +
                `source vs obfuscated: ${runtimeResult.sourceVsObfuscated}\n` +
                `source vs recovered: ${runtimeResult.sourceVsRecovered}`,
            );
        }
    }

    const totalMs = elapsedMs(totalStart);

    console.log(`PASS ${path.basename(sourcePath)}`);
    console.log(`  Obfuscate: ${fmtMs(obfMs)}`);
    console.log(`  Deobf+CF:  ${fmtMs(deobfMs)}`);
    if (options.runtime) console.log(`  Runtime:   ${fmtMs(runtimeMs)} (exact parity)`);
    console.log(`  Total:     ${fmtMs(totalMs)}`);
    console.log(`  States:    ${result.controlFlow.stateCount}`);
    console.log(`  Closures:  ${result.controlFlow.closureRegionCount || 0}`);
    console.log(`  Obf:       ${obfuscatedPath}`);
    console.log(`  Normal:    ${normalPath}`);
    console.log(`  Fresh CF:  ${freshPath}`);

    return { sourcePath, obfuscatedPath, normalPath, freshPath, result, runtimeResult, obfMs, deobfMs, runtimeMs, totalMs };
}

function main() {
    const options = parseArgs(process.argv.slice(2));
    if (options.help || options.sources.length === 0) {
        printUsage();
        if (!options.help && options.sources.length === 0) process.exitCode = 1;
        return;
    }

    const batchStart = process.hrtime.bigint();
    for (let i = 0; i < options.sources.length; i += 1) {
        if (i > 0) console.log("");
        runOne(options.sources[i], options);
    }

    if (options.sources.length > 1) {
        console.log("");
        console.log(`Batch total: ${fmtMs(elapsedMs(batchStart))} for ${options.sources.length} files`);
    }
}

if (require.main === module) {
    try {
        main();
    } catch (error) {
        console.error(`[ERROR] ${error && error.stack ? error.stack : error}`);
        process.exitCode = 1;
    }
}

module.exports = { parseArgs, runOne };
