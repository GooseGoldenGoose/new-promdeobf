const path = require("path");
const { loadAst } = require("../main");

const ROOT = path.resolve(__dirname, "..");
const DEFAULT_INPUT = path.join(ROOT, "formater", "out.txt");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function walk(root, visit, parent = null, key = null) {
    if (!root || typeof root !== "object") return;
    if (Array.isArray(root)) {
        for (let i = 0; i < root.length; i++) walk(root[i], visit, parent, key);
        return;
    }

    if (isNode(root)) visit(root, parent, key);

    for (const [childKey, value] of Object.entries(root)) {
        if (childKey === "loc" || childKey === "range" || childKey === "raw" || childKey === "comments") continue;
        if (!value || typeof value !== "object") continue;
        if (Array.isArray(value)) {
            for (const child of value) walk(child, visit, root, childKey);
        } else {
            walk(value, visit, root, childKey);
        }
    }
}

function sourceOf(node, source, max = 180) {
    if (!node || !Array.isArray(node.range)) return "";
    const text = source.slice(node.range[0], node.range[1]).replace(/\s+/g, " ").trim();
    return text.length > max ? text.slice(0, max - 1) + "…" : text;
}

function locationOf(node) {
    if (!node?.loc?.start) return "?";
    return `${node.loc.start.line}:${node.loc.start.column + 1}`;
}

function identifierName(node) {
    return node?.type === "Identifier" ? node.name : null;
}

function memberPath(node) {
    if (!node) return null;
    if (node.type === "Identifier") return node.name;
    if (node.type === "MemberExpression") {
        const base = memberPath(node.base);
        const id = identifierName(node.identifier);
        if (base && id) return `${base}${node.indexer || "."}${id}`;
    }
    if (node.type === "IndexExpression") {
        const base = memberPath(node.base);
        if (base && node.index?.type === "StringLiteral") return `${base}[${JSON.stringify(node.index.value)}]`;
    }
    return null;
}

function callName(node) {
    if (node?.type !== "CallExpression" && node?.type !== "TableCallExpression" && node?.type !== "StringCallExpression") return null;
    return memberPath(node.base) || `<${node.base?.type || "unknown"}>`;
}

function functionName(node, parent, key) {
    if (node.identifier?.type === "Identifier") return node.identifier.name;
    if (parent?.type === "LocalStatement" && key === "init") {
        const index = parent.init.indexOf(node);
        if (index >= 0 && parent.variables[index]?.type === "Identifier") return parent.variables[index].name;
    }
    if (parent?.type === "AssignmentStatement" && key === "init") {
        const index = parent.init.indexOf(node);
        if (index >= 0) return memberPath(parent.variables[index]) || "<assignment>";
    }
    return "<anonymous>";
}

function analyze(ast, source) {
    const nodeCounts = new Map();
    const calls = new Map();
    const functions = [];
    const controls = [];
    const localNames = new Set();
    const globalReads = new Map();
    const globalWrites = new Map();
    const literals = { strings: new Set(), numbers: new Set() };

    const controlTypes = new Set([
        "IfStatement", "WhileStatement", "RepeatStatement",
        "ForNumericStatement", "ForGenericStatement", "DoStatement"
    ]);

    walk(ast, (node, parent, key) => {
        nodeCounts.set(node.type, (nodeCounts.get(node.type) || 0) + 1);

        if (node.type === "LocalStatement") {
            for (const variable of node.variables || []) {
                if (variable.type === "Identifier") localNames.add(variable.name);
            }
        }

        if (node.type === "FunctionDeclaration") {
            functions.push({
                name: functionName(node, parent, key),
                at: locationOf(node),
                params: (node.parameters || []).map(p => p.type === "Identifier" ? p.name : p.type),
                statements: node.body?.length || 0,
                preview: sourceOf(node, source, 220),
            });
        }

        if (controlTypes.has(node.type)) {
            controls.push({ type: node.type, at: locationOf(node), preview: sourceOf(node, source, 220) });
        }

        if (node.type === "CallExpression" || node.type === "TableCallExpression" || node.type === "StringCallExpression") {
            const name = callName(node);
            calls.set(name, (calls.get(name) || 0) + 1);
        }

        if (node.type === "Identifier" && node.isLocal === false) {
            const isWrite = (parent?.type === "AssignmentStatement" && key === "variables") ||
                (parent?.type === "FunctionDeclaration" && key === "identifier");
            const map = isWrite ? globalWrites : globalReads;
            map.set(node.name, (map.get(node.name) || 0) + 1);
        }

        if (node.type === "StringLiteral" && typeof node.value === "string") literals.strings.add(node.value);
        if (node.type === "NumericLiteral") literals.numbers.add(node.value);
    });

    const sortedEntries = map => [...map.entries()].sort((a, b) => b[1] - a[1] || String(a[0]).localeCompare(String(b[0])));

    return {
        summary: {
            root: ast.type,
            sourceBytes: Buffer.byteLength(source, "utf8"),
            topLevelStatements: ast.body?.length || 0,
            totalNodes: [...nodeCounts.values()].reduce((a, b) => a + b, 0),
            functionCount: functions.length,
            controlCount: controls.length,
        },
        nodeCounts: sortedEntries(nodeCounts),
        calls: sortedEntries(calls),
        locals: [...localNames].sort(),
        globals: {
            reads: sortedEntries(globalReads),
            writes: sortedEntries(globalWrites),
        },
        functions,
        controls,
        literals: {
            strings: [...literals.strings],
            numbers: [...literals.numbers],
        },
    };
}

function printTable(title, rows, limit = 20) {
    console.log(`\n== ${title} ==`);
    if (!rows.length) {
        console.log("(none)");
        return;
    }
    for (const [name, count] of rows.slice(0, limit)) console.log(`${String(count).padStart(5)}  ${name}`);
    if (rows.length > limit) console.log(`... ${rows.length - limit} more`);
}

function printReport(report) {
    const s = report.summary;
    console.log(`AST: ${s.root}`);
    console.log(`Source bytes: ${s.sourceBytes}`);
    console.log(`Top-level statements: ${s.topLevelStatements}`);
    console.log(`Total AST nodes: ${s.totalNodes}`);
    console.log(`Functions: ${s.functionCount}`);
    console.log(`Control-flow nodes: ${s.controlCount}`);

    printTable("Node types", report.nodeCounts, 25);
    printTable("Calls", report.calls, 30);
    printTable("Global reads", report.globals.reads, 30);
    printTable("Global writes", report.globals.writes, 30);

    console.log("\n== Functions ==");
    for (const fn of report.functions.slice(0, 30)) {
        console.log(`${fn.at}  ${fn.name}(${fn.params.join(", ")})  body=${fn.statements}`);
        console.log(`  ${fn.preview}`);
    }
    if (report.functions.length > 30) console.log(`... ${report.functions.length - 30} more`);

    console.log("\n== Control flow ==");
    for (const item of report.controls.slice(0, 40)) {
        console.log(`${item.at}  ${item.type}  ${item.preview}`);
    }
    if (report.controls.length > 40) console.log(`... ${report.controls.length - 40} more`);
}

function findMatches(ast, source, { type, name }) {
    const matches = [];
    walk(ast, node => {
        if (type && node.type !== type) return;
        if (name) {
            const names = [
                node.type === "Identifier" ? node.name : null,
                memberPath(node),
                callName(node),
            ].filter(Boolean);
            if (!names.some(n => n === name || n.includes(name))) return;
        }
        matches.push({ type: node.type, at: locationOf(node), preview: sourceOf(node, source, 500), node });
    });
    return matches;
}

function parseArgs(argv) {
    const options = { input: DEFAULT_INPUT, json: false, type: null, name: null };
    const args = [...argv];
    if (args[0] && !args[0].startsWith("--")) options.input = args.shift();
    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        if (arg === "--json") options.json = true;
        else if (arg === "--type") options.type = args[++i];
        else if (arg === "--name") options.name = args[++i];
        else if (arg === "--help") options.help = true;
        else throw new Error(`Unknown option: ${arg}`);
    }
    return options;
}

function main() {
    const options = parseArgs(process.argv.slice(2));
    if (options.help) {
        console.log("Usage: node tools/inspect-lua.js [input.lua] [--json] [--type NodeType] [--name text]");
        return;
    }

    const { ast, source, inputPath } = loadAst(options.input);
    const report = analyze(ast, source);

    if (options.type || options.name) {
        const matches = findMatches(ast, source, options);
        if (options.json) console.log(JSON.stringify(matches, null, 2));
        else {
            console.log(`Input: ${inputPath}`);
            console.log(`Matches: ${matches.length}`);
            for (const match of matches.slice(0, 100)) console.log(`${match.at}  ${match.type}  ${match.preview}`);
            if (matches.length > 100) console.log(`... ${matches.length - 100} more`);
        }
        return;
    }

    if (options.json) console.log(JSON.stringify(report, null, 2));
    else {
        console.log(`Input: ${inputPath}`);
        printReport(report);
    }
}

if (require.main === module) main();

module.exports = { walk, analyze, findMatches, memberPath, callName, sourceOf };
