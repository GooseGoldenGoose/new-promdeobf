"use strict";

function isVmRegisterName(name) {
    return typeof name === "string" && /^(?:r|o)\d+$/.test(name);
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isSingleAssignment(statement, destination = null) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1) return false;
    return destination === null || isIdentifier(variables[0], destination);
}

function isPrimitiveLiteral(node) {
    return ["StringLiteral", "NumericLiteral", "BooleanLiteral", "NilLiteral"].includes(node?.type);
}

function isEmptyTable(node) {
    return node?.type === "TableConstructorExpression" && (node.fields || []).length === 0;
}

function significant(body) {
    return (body || []).filter(statement => statement?.type !== "CommentStatement");
}

function decodeJsonStringLiteral(node) {
    if (node?.type !== "StringLiteral" || typeof node.raw !== "string" || !node.raw.startsWith('"')) return null;
    try {
        const value = JSON.parse(node.raw);
        return typeof value === "string" ? value : null;
    } catch {
        return null;
    }
}

const LUA_KEYWORDS = new Set([
    "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in",
    "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "continue",
]);

function isLuaIdentifier(name) {
    return typeof name === "string" && /^[A-Za-z_][A-Za-z0-9_]*$/.test(name) && !LUA_KEYWORDS.has(name);
}

function sourceOf(source, node) {
    if (!Array.isArray(node?.range)) return null;
    return source.slice(node.range[0], node.range[1]);
}

function canonicalizeInitialSimpleLocals(lines) {
    const records = [];
    let prefixLength = 0;
    for (const line of lines) {
        const match = line.match(/^local\s+([vt]\d+)(?:\s*=\s*(.+))?$/);
        if (!match) break;
        const name = match[1], rhs = match[2] ?? null;
        let kind = null, sortKey = "";
        const deps = new Set();
        if (rhs === null) { kind = 3; sortKey = name; }
        else if (/^(?:true|false)$/.test(rhs)) { kind = 2; sortKey = rhs === "true" ? "0:true" : "1:false"; }
        else if (/^"(?:[^"\\]|\\.)*"$/.test(rhs)) { kind = 2; sortKey = `2:${rhs}`; }
        else if (/^-?(?:\d+(?:\.\d*)?|\.\d+)$/.test(rhs)) { kind = 2; sortKey = `3:${Number(rhs)}`; }
        else if (/^[A-Za-z_][A-Za-z0-9_]*$/.test(rhs) && !/^[vt]\d+$/.test(rhs)) { kind = 0; sortKey = rhs; }
        else {
            const member = rhs.match(/^([vt]\d+)(?:\.[A-Za-z_][A-Za-z0-9_]*)+$/);
            if (!member) break;
            kind = 1; deps.add(member[1]); sortKey = rhs.replace(/^[vt]\d+/, "");
        }
        records.push({ line, name, kind, sortKey, deps, originalIndex: records.length });
        prefixLength++;
    }
    if (records.length < 2 || !records.some(record => record.kind === 3)) return lines;
    const names = new Set(records.map(record => record.name));
    for (const record of records) for (const dep of [...record.deps]) if (!names.has(dep)) record.deps.delete(dep);
    const fanout = new Map(records.map(record => [record.name, 0]));
    for (const record of records) for (const dep of record.deps) fanout.set(dep, (fanout.get(dep) || 0) + 1);
    const remaining = new Map(records.map(record => [record.name, record]));
    const emitted = new Set(), ordered = [];
    while (remaining.size > 0) {
        const ready = [...remaining.values()].filter(record => [...record.deps].every(dep => emitted.has(dep)));
        if (ready.length === 0) return lines;
        ready.sort((a, b) => {
            if (a.kind !== b.kind) return a.kind - b.kind;
            if (a.kind === 0) {
                const fanoutDiff = (fanout.get(b.name) || 0) - (fanout.get(a.name) || 0);
                if (fanoutDiff) return fanoutDiff;
            }
            if (a.kind === 2 && /^3:/.test(a.sortKey) && /^3:/.test(b.sortKey)) return Number(a.sortKey.slice(2)) - Number(b.sortKey.slice(2));
            if (a.kind === 3) return Number(a.name.slice(1)) - Number(b.name.slice(1));
            const keyCompare = a.sortKey.localeCompare(b.sortKey);
            return keyCompare || a.originalIndex - b.originalIndex;
        });
        const next = ready[0];
        ordered.push(next.line); emitted.add(next.name); remaining.delete(next.name);
    }
    return [...ordered, ...lines.slice(prefixLength)];
}

function renderUnary(operator, argument) {
    if (typeof argument !== "string") return null;
    if (operator === "not") return `(not ${argument})`;
    if (operator === "-" || operator === "#") return `(${operator}${argument})`;
    return null;
}

function renderTableFields(fields, resolve) {
    const rendered = [];
    for (const field of fields || []) {
        if (field?.type === "TableValue") {
            const value = resolve(field.value);
            if (typeof value !== "string") return null;
            rendered.push(value);
            continue;
        }
        if (field?.type === "TableKey") {
            const key = resolve(field.key);
            const value = resolve(field.value);
            if (typeof key !== "string" || typeof value !== "string") return null;
            const fieldName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            rendered.push(fieldName && isLuaIdentifier(fieldName) ? `${fieldName} = ${value}` : `[${key}] = ${value}`);
            continue;
        }
        return null;
    }
    return `{ ${rendered.join(", ")} }`;
}

module.exports = {
    isVmRegisterName,
    isIdentifier,
    isSingleAssignment,
    isPrimitiveLiteral,
    isEmptyTable,
    significant,
    decodeJsonStringLiteral,
    isLuaIdentifier,
    sourceOf,
    canonicalizeInitialSimpleLocals,
    renderUnary,
    renderTableFields,
};
