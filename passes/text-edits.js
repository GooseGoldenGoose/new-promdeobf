function editReplacement(edit) {
    if (Object.prototype.hasOwnProperty.call(edit, "replacement")) return String(edit.replacement);
    if (Object.prototype.hasOwnProperty.call(edit, "text")) return String(edit.text);
    return "";
}

function applyTextEdits(source, edits, baseOffset = 0) {
    if (!edits || edits.length === 0) return source;
    const endOffset = baseOffset + source.length;
    const ordered = [];
    for (const edit of edits) {
        if (!Number.isInteger(edit?.start) || !Number.isInteger(edit?.end)) continue;
        if (edit.start < baseOffset || edit.end > endOffset || edit.end < edit.start) continue;
        ordered.push(edit);
    }
    if (ordered.length === 0) return source;
    ordered.sort((a, b) => a.start - b.start || a.end - b.end);

    const chunks = [];
    let cursor = 0;
    for (const edit of ordered) {
        const start = edit.start - baseOffset;
        const end = edit.end - baseOffset;
        if (start < cursor) throw new Error("Overlapping source edits are not safe to apply");
        chunks.push(source.slice(cursor, start), editReplacement(edit));
        cursor = end;
    }
    chunks.push(source.slice(cursor));
    return chunks.join("");
}

module.exports = {
    applyTextEdits,
};