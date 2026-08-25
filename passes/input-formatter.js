const fs = require("fs");
const os = require("os");
const path = require("path");
const { spawnSync } = require("child_process");

const DEFAULT_FORMATTER = path.resolve(__dirname, "..", "formater", "luau-format.exe");
let nextTempId = 1;

function formatInputBeforeParse(inputPath, options = {}) {
    const absoluteInput = path.resolve(inputPath);
    const formatterPath = path.resolve(options.formatterPath || DEFAULT_FORMATTER);
    if (!fs.existsSync(formatterPath)) {
        throw new Error(`Luau formatter not found: ${formatterPath}`);
    }

    const originalBuffer = fs.readFileSync(absoluteInput);
    const tempOutput = path.join(
        os.tmpdir(),
        `promdeobf-format-${process.pid}-${Date.now()}-${nextTempId++}.lua`
    );

    try {
        const result = spawnSync(
            formatterPath,
            [absoluteInput, "--luraph", `--output=${tempOutput}`],
            {
                encoding: "utf8",
                windowsHide: true,
                maxBuffer: 16 * 1024 * 1024,
            }
        );

        if (result.error) {
            throw new Error(`Luau formatter failed for ${absoluteInput}: ${result.error.message}`);
        }
        if (result.status !== 0) {
            const detail = String(result.stderr || result.stdout || "").trim();
            throw new Error(
                `Luau formatter failed for ${absoluteInput} with exit code ${result.status}` +
                (detail ? `: ${detail}` : "")
            );
        }
        if (!fs.existsSync(tempOutput)) {
            throw new Error(`Luau formatter produced no output for ${absoluteInput}`);
        }

        const formattedBuffer = fs.readFileSync(tempOutput);
        const alreadyFormatted = originalBuffer.equals(formattedBuffer);
        const selectedBuffer = alreadyFormatted ? originalBuffer : formattedBuffer;
        return {
            inputPath: absoluteInput,
            source: selectedBuffer.toString("utf8"),
            alreadyFormatted,
            formatted: !alreadyFormatted,
            formatterPath,
            formatterWarnings: String(result.stderr || "").trim(),
        };
    } finally {
        try {
            fs.unlinkSync(tempOutput);
        } catch (error) {
            if (error?.code !== "ENOENT") throw error;
        }
    }
}

module.exports = {
    DEFAULT_FORMATTER,
    formatInputBeforeParse,
};
