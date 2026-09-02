const fs = require("fs");
const os = require("os");
const path = require("path");
const { spawnSync } = require("child_process");

const ROOT = path.resolve(__dirname, "..");
const DEFAULT_FORMATTER = path.join(ROOT, "formater", "luau-format.exe");

function formatInputBeforeParse(inputPath, options = {}) {
    const absoluteInput = path.resolve(inputPath);
    const formatterPath = path.resolve(options.formatterPath || DEFAULT_FORMATTER);
    const originalSource = fs.readFileSync(absoluteInput, "utf8");
    if (!fs.existsSync(formatterPath)) throw new Error(`Input formatter was not found: ${formatterPath}`);

    const tempOutput = path.join(os.tmpdir(), `promdeobf-format-${process.pid}-${Date.now()}-${Math.random().toString(16).slice(2)}.lua`);
    try {
        const result = spawnSync(formatterPath, [absoluteInput, "--luraph", `--output=${tempOutput}`], {
            cwd: path.dirname(formatterPath), windowsHide: true, encoding: "utf8",
        });
        if (result.error) throw result.error;
        if (result.status !== 0) {
            const detail = String(result.stderr || result.stdout || "").trim();
            throw new Error(`Input formatter failed with exit code ${result.status}${detail ? `: ${detail}` : ""}`);
        }
        if (!fs.existsSync(tempOutput)) throw new Error("Input formatter completed without producing output");
        const source = fs.readFileSync(tempOutput, "utf8");
        return {
            inputPath: absoluteInput, source, originalSource,
            alreadyFormatted: source === originalSource,
            formatted: source !== originalSource,
            formatterPath, formatterSkipped: false,
        };
    } finally {
        fs.rmSync(tempOutput, { force: true });
    }
}

module.exports = { formatInputBeforeParse };
