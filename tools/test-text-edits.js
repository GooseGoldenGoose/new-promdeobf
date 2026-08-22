const assert = require("assert");
const { applyTextEdits } = require("../passes/text-edits");

{
    const source = "abcdef";
    const output = applyTextEdits(source, [
        { start: 1, end: 3, replacement: "XX" },
        { start: 4, end: 5, text: "Y" },
    ]);
    assert.strictEqual(output, "aXXdYf");
}

{
    const source = "0123456789";
    const output = applyTextEdits(source.slice(2, 8), [
        { start: 3, end: 5, replacement: "AB" },
        { start: 6, end: 7, replacement: "C" },
    ], 2);
    assert.strictEqual(output, "2AB5C7");
}

assert.throws(() => applyTextEdits("abcdef", [
    { start: 1, end: 4, replacement: "x" },
    { start: 3, end: 5, replacement: "y" },
]), /Overlapping source edits/);

console.log("text edit regression: ok");