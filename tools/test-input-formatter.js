const assert = require("assert");
const fs = require("fs");
const os = require("os");
const path = require("path");
const { loadAst } = require("../main");

const tempDir = fs.mkdtempSync(path.join(os.tmpdir(), "promdeobf-format-test-"));
const inputPath = path.join(tempDir, "input.lua");
const cacheDir = path.join(tempDir, "cache");

try {
    const raw = "local a=1\nif a==1 then print(a) end\n";
    fs.writeFileSync(inputPath, raw, "utf8");

    const first = loadAst(inputPath, { formatter: { cacheDir } });
    assert.strictEqual(first.formatted, true);
    assert.strictEqual(first.alreadyFormatted, false);
    assert.strictEqual(first.formatterCacheHit, false);
    assert.strictEqual(first.ast.type, "Chunk");
    assert.match(first.source, /local a = 1/);
    assert.match(first.source, /if a == 1 then/);

    // Same raw bytes must reuse the cached formatted output without invoking the
    // formatter again.
    const second = loadAst(inputPath, { formatter: { cacheDir } });
    assert.strictEqual(second.formatted, true);
    assert.strictEqual(second.alreadyFormatted, false);
    assert.strictEqual(second.formatterCacheHit, true);
    assert.strictEqual(second.source, first.source);

    // A formatted file has a different content hash. Prove that its marker is
    // cached independently too.
    fs.writeFileSync(inputPath, first.source, "utf8");
    const third = loadAst(inputPath, { formatter: { cacheDir } });
    assert.strictEqual(third.formatted, false);
    assert.strictEqual(third.alreadyFormatted, true);
    assert.strictEqual(third.formatterCacheHit, false);
    assert.strictEqual(third.source, first.source);

    const fourth = loadAst(inputPath, { formatter: { cacheDir } });
    assert.strictEqual(fourth.formatted, false);
    assert.strictEqual(fourth.alreadyFormatted, true);
    assert.strictEqual(fourth.formatterCacheHit, true);
    assert.strictEqual(fourth.source, first.source);

    console.log("input formatter regression: ok");
} finally {
    fs.rmSync(tempDir, { recursive: true, force: true });
}