const crypto = require("crypto");
const fs = require("fs");
const os = require("os");
const path = require("path");
const { spawnSync } = require("child_process");

const DEFAULT_FORMATTER = path.resolve(__dirname, "..", "formater", "luau-format.exe");
const CACHE_VERSION = "luraph-v1";
const MAX_CACHED_FORMATTED_BYTES = 64 * 1024 * 1024;
let nextTempId = 1;

function defaultCacheDir() {
    const base = process.env.LOCALAPPDATA || os.tmpdir();
    return path.join(base, "promdeobf", "formatter-cache-v1");
}

function formatterSignature(formatterPath) {
    const stat = fs.statSync(formatterPath);
    return `${path.resolve(formatterPath)}\0${stat.size}\0${stat.mtimeMs}\0--luraph`;
}

function inputCacheKey(originalBuffer, formatterPath) {
    const hash = crypto.createHash("sha256");
    hash.update(CACHE_VERSION);
    hash.update("\0");
    hash.update(formatterSignature(formatterPath));
    hash.update("\0");
    hash.update(originalBuffer);
    return hash.digest("hex");
}

function readFormatterCache(cacheDir, cacheKey, originalBuffer) {
    const metadataPath = path.join(cacheDir, `${cacheKey}.json`);
    let metadata;
    try {
        metadata = JSON.parse(fs.readFileSync(metadataPath, "utf8"));
    } catch {
        return null;
    }
    if (metadata?.version !== CACHE_VERSION || metadata?.key !== cacheKey) return null;

    if (metadata.alreadyFormatted === true) {
        return {
            buffer: originalBuffer,
            alreadyFormatted: true,
        };
    }
    if (metadata.alreadyFormatted !== false || typeof metadata.formattedFile !== "string") return null;

    const formattedPath = path.join(cacheDir, metadata.formattedFile);
    try {
        return {
            buffer: fs.readFileSync(formattedPath),
            alreadyFormatted: false,
        };
    } catch {
        return null;
    }
}

function writeAtomic(filePath, data) {
    fs.mkdirSync(path.dirname(filePath), { recursive: true });
    const tempPath = `${filePath}.${process.pid}.${Date.now()}.${nextTempId++}.tmp`;
    try {
        fs.writeFileSync(tempPath, data);
        fs.renameSync(tempPath, filePath);
    } finally {
        try {
            fs.unlinkSync(tempPath);
        } catch (error) {
            if (error?.code !== "ENOENT") throw error;
        }
    }
}

function writeFormatterCache(cacheDir, cacheKey, alreadyFormatted, formattedBuffer) {
    const metadata = {
        version: CACHE_VERSION,
        key: cacheKey,
        alreadyFormatted,
    };

    if (!alreadyFormatted && formattedBuffer.length <= MAX_CACHED_FORMATTED_BYTES) {
        const formattedFile = `${cacheKey}.lua`;
        writeAtomic(path.join(cacheDir, formattedFile), formattedBuffer);
        metadata.formattedFile = formattedFile;
    }

    // For an unformatted input that is too large to cache, do not store a marker
    // that cannot reproduce the formatted source on the next run.
    if (!alreadyFormatted && !metadata.formattedFile) return;
    writeAtomic(path.join(cacheDir, `${cacheKey}.json`), JSON.stringify(metadata));
}

function formatInputBeforeParse(inputPath, options = {}) {
    const absoluteInput = path.resolve(inputPath);
    const formatterPath = path.resolve(options.formatterPath || DEFAULT_FORMATTER);
    if (!fs.existsSync(formatterPath)) {
        throw new Error(`Luau formatter not found: ${formatterPath}`);
    }

    const originalBuffer = fs.readFileSync(absoluteInput);
    const cacheEnabled = options.cache !== false;
    const cacheDir = path.resolve(options.cacheDir || defaultCacheDir());
    const cacheKey = cacheEnabled ? inputCacheKey(originalBuffer, formatterPath) : null;

    if (cacheEnabled) {
        const cached = readFormatterCache(cacheDir, cacheKey, originalBuffer);
        if (cached) {
            return {
                inputPath: absoluteInput,
                source: cached.buffer.toString("utf8"),
                alreadyFormatted: cached.alreadyFormatted,
                formatted: !cached.alreadyFormatted,
                formatterPath,
                formatterWarnings: "",
                formatterCacheHit: true,
                formatterCacheKey: cacheKey,
                formatterCacheDir: cacheDir,
            };
        }
    }

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
        if (cacheEnabled) {
            writeFormatterCache(cacheDir, cacheKey, alreadyFormatted, formattedBuffer);
        }
        return {
            inputPath: absoluteInput,
            source: selectedBuffer.toString("utf8"),
            alreadyFormatted,
            formatted: !alreadyFormatted,
            formatterPath,
            formatterWarnings: String(result.stderr || "").trim(),
            formatterCacheHit: false,
            formatterCacheKey: cacheKey,
            formatterCacheDir: cacheEnabled ? cacheDir : null,
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
    CACHE_VERSION,
    DEFAULT_FORMATTER,
    defaultCacheDir,
    formatInputBeforeParse,
};