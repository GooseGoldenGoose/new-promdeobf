const { findVmFunction } = require("./vm-state");
const { findRegisterOverflowBinding } = require("./vm-register-names");
const { applyTextEdits } = require("./text-edits");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = typeof node.value === "number" ? node.value : Number(node.raw);
    return Number.isInteger(value) ? value : null;
}

function normalizeVmRegisterOverflow(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) return { source, found: false, applied: false, slots: 0, references: 0, reason: "No semantically named vm function was found" };

    const overflow = findRegisterOverflowBinding(vm.functionNode);
    if (!overflow) return { source, found: false, applied: false, slots: 0, references: 0, reason: "No proven static RegisterOverflow bank was found" };

    const overflowName = overflow.name;
    const targetNames = new Set([...overflow.indices].map(index => `o${index}`));
    let collision = null;

    function scanCollisions(node, parent = null, parentKey = null) {
        if (!isNode(node) || collision) return;
        if (node.type === "Identifier" && targetNames.has(node.name)) {
            const isOverflowIndexBase = parent?.type === "IndexExpression" && parentKey === "base" && isIdentifier(node, overflowName);
            if (!isOverflowIndexBase) collision = node.name;
        }
        for (const key of Object.keys(node)) {
            if (key === "loc" || key === "range") continue;
            const value = node[key];
            if (Array.isArray(value)) {
                for (const child of value) scanCollisions(child, node, key);
            } else if (isNode(value)) {
                scanCollisions(value, node, key);
            }
        }
    }
    scanCollisions(vm.functionNode);
    if (collision) {
        return { source, found: true, applied: false, slots: overflow.indices.size, references: 0, reason: `Overflow scalar name collision: ${collision}` };
    }

    const edits = [];
    let references = 0;
    let unsupported = 0;

    function walk(node) {
        if (!isNode(node)) return;
        if (node.type === "IndexExpression" && isIdentifier(node.base, overflowName)) {
            const slot = numericValue(node.index);
            if (slot === null || slot < 1 || !Array.isArray(node.range)) {
                unsupported++;
                return;
            }
            edits.push({ start: node.range[0], end: node.range[1], text: `o${slot}` });
            references++;
            return;
        }
        for (const key of Object.keys(node)) {
            if (key === "loc" || key === "range") continue;
            const value = node[key];
            if (Array.isArray(value)) {
                for (const child of value) walk(child);
            } else if (isNode(value)) {
                walk(value);
            }
        }
    }
    walk(vm.functionNode);

    if (unsupported > 0) {
        return { source, found: true, applied: false, slots: overflow.indices.size, references, reason: "RegisterOverflow contains a non-static or invalid slot access" };
    }
    if (references === 0) {
        return { source, found: true, applied: false, slots: overflow.indices.size, references: 0, reason: "RegisterOverflow bank had no replaceable slot references" };
    }

    if (Array.isArray(overflow.declaration?.range)) {
        edits.push({ start: overflow.declaration.range[0], end: overflow.declaration.range[1], text: "" });
    }

    return {
        source: applyTextEdits(source, edits),
        found: true,
        applied: true,
        slots: overflow.indices.size,
        references,
        reason: null,
    };
}

module.exports = {
    normalizeVmRegisterOverflow,
};
