const assert = require("assert");
const fs = require("fs");
const os = require("os");
const path = require("path");
const { loadAst } = require("../main");

const tempDir = fs.mkdtempSync(path.join(os.tmpdir(), "promdeobf-format-test-"));
const inputPath = path.join(tempDir, "input.lua");

try {
    fs.writeFileSync(inputPath, "local a=1\nif a==1 then print(a) end\n", "utf8");

    const first = loadAst(inputPath);
    assert.strictEqual(first.formatted, true);
    assert.strictEqual(first.alreadyFormatted, false);
    assert.strictEqual(first.ast.type, "Chunk");
    assert.match(first.source, /local a = 1/);
    assert.match(first.source, /if a == 1 then/);

    fs.writeFileSync(inputPath, first.source, "utf8");
    const second = loadAst(inputPath);
    assert.strictEqual(second.formatted, false);
    assert.strictEqual(second.alreadyFormatted, true);
    assert.strictEqual(second.source, first.source);

    console.log("input formatter regression: ok");
} finally {
    fs.rmSync(tempDir, { recursive: true, force: true });
}
