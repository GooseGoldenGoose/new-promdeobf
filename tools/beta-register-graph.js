const fs = require("fs");
const path = require("path");
const childProcess = require("child_process");
const { parseLua } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions-old");

function defaultBasePath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta.graph`);
}

function oneLine(text) {
    return String(text || "").replace(/\s+/g, " ").trim();
}

function renderText(graph) {
    const lines = [];
    lines.push("BETA REGISTER FLOW GRAPH");
    lines.push(`entries: ${graph.entries.join(", ") || "none"}`);
    lines.push(`states: ${graph.states.length}`);
    lines.push(`epochs: ${graph.epochs.length}`);
    if (graph.analysis) {
        lines.push(`analysis: defs=${graph.analysis.definitionCount}, uses=${graph.analysis.useCount}, provenance=${graph.analysis.provenanceEdgeCount}`);
        lines.push(`analysis: merged=${graph.analysis.mergedDefinitionCount}, cleanups=${graph.analysis.attachedCleanupCount}/${graph.analysis.provenCleanupCount}`);
    }
    lines.push("");
    lines.push("CFG");
    for (const entry of graph.entries) lines.push(`  ENTRY -> S${entry}`);
    for (const state of graph.states) {
        const successors = state.successors;
        if (!Array.isArray(successors)) {
            lines.push(`  S${state.id} -> ?`);
        } else if (successors.length === 0) {
            lines.push(`  S${state.id} -> STOP`);
        } else if (successors.length === 1) {
            lines.push(`  S${state.id} -> S${successors[0]}`);
        } else {
            lines.push(`  S${state.id} -> S${successors[0]} [true]`);
            lines.push(`  S${state.id} -> S${successors[1]} [false]`);
            for (let index = 2; index < successors.length; index++) {
                lines.push(`  S${state.id} -> S${successors[index]} [${index + 1}]`);
            }
        }
    }

    lines.push("");
    lines.push("REGISTER EPOCHS");
    if (graph.epochs.length === 0) lines.push("  none");
    for (const epoch of graph.epochs) {
        lines.push(`  ${epoch.originalRegister} => ${epoch.name}`);
        for (const event of epoch.events) {
            lines.push(`    ${event.kind.toUpperCase()} S${event.state}#${event.operation}: ${oneLine(event.text)}`);
        }
    }

    lines.push("");
    lines.push("STATES");
    for (const state of graph.states) {
        const tags = [];
        if (state.entry) tags.push("ENTRY");
        if (Array.isArray(state.successors) && state.successors.length === 0) tags.push("STOP");
        lines.push(`  STATE ${state.id}${tags.length ? ` [${tags.join(", ")}]` : ""}`);
        lines.push(`    predecessors: ${state.predecessors.length ? state.predecessors.map(id => `S${id}`).join(", ") : "none"}`);
        lines.push(`    successors: ${Array.isArray(state.successors) ? (state.successors.length ? state.successors.map(id => `S${id}`).join(", ") : "STOP") : "unknown"}`);
        if (state.transition) lines.push(`    transition: ${oneLine(state.transition)}`);
        for (const operation of state.operations) {
            const reads = operation.reads?.length ? ` reads=[${operation.reads.join(", ")}]` : "";
            const text = operation.emittedText || operation.originalText || `${operation.emittedTarget || "?"} = ${operation.rhs || "?"}`;
            lines.push(`    #${operation.index} ${operation.kind}${reads}: ${oneLine(text)}`);
        }
        lines.push("");
    }
    return lines.join("\n");
}

function dotEscape(text) {
    return oneLine(text)
        .replace(/\\/g, "\\\\")
        .replace(/"/g, '\\"')
        .replace(/\{/g, "\\{")
        .replace(/\}/g, "\\}")
        .replace(/\|/g, "\\|")
        .replace(/</g, "\\<")
        .replace(/>/g, "\\>");
}

function renderDot(graph) {
    const lines = [];
    lines.push("digraph BetaRegisterFlow {");
    lines.push("  rankdir=LR;");
    lines.push("  graph [fontname=\"Consolas\", nodesep=0.5, ranksep=0.9];");
    lines.push("  node [shape=record, fontname=\"Consolas\", fontsize=10];");
    lines.push("  edge [fontname=\"Consolas\", fontsize=9];");
    lines.push('  entry [shape=oval, label="ENTRY"];');
    lines.push('  stop [shape=oval, label="STOP"];');

    for (const state of graph.states) {
        const fields = [`State ${state.id}${state.entry ? " [entry]" : ""}`];
        for (const operation of state.operations) {
            const reads = operation.reads?.length ? ` | reads ${operation.reads.join(",")}` : "";
            const text = operation.emittedText || operation.originalText || `${operation.emittedTarget || "?"} = ${operation.rhs || "?"}`;
            fields.push(`#${operation.index} ${operation.kind}: ${oneLine(text)}${reads}`);
        }
        lines.push(`  s${state.id} [label="${fields.map(dotEscape).join(" | ")}"];`);
    }

    for (const entry of graph.entries) lines.push(`  entry -> s${entry};`);
    for (const state of graph.states) {
        if (!Array.isArray(state.successors)) continue;
        if (state.successors.length === 0) {
            lines.push(`  s${state.id} -> stop;`);
        } else if (state.successors.length === 1) {
            lines.push(`  s${state.id} -> s${state.successors[0]};`);
        } else {
            lines.push(`  s${state.id} -> s${state.successors[0]} [label="true"];`);
            lines.push(`  s${state.id} -> s${state.successors[1]} [label="false"];`);
            for (let index = 2; index < state.successors.length; index++) {
                lines.push(`  s${state.id} -> s${state.successors[index]} [label="${index + 1}"];`);
            }
        }
    }

    if (graph.epochs.length) {
        lines.push("  subgraph cluster_epochs {");
        lines.push('    label="Proven register epochs";');
        lines.push("    style=dashed;");
        for (let index = 0; index < graph.epochs.length; index++) {
            const epoch = graph.epochs[index];
            lines.push(`    life${index} [shape=ellipse, label="${dotEscape(`${epoch.originalRegister} => ${epoch.name}`)}"];`);
            const grouped = new Map();
            for (const event of epoch.events) {
                let kinds = grouped.get(event.state);
                if (!kinds) grouped.set(event.state, kinds = []);
                kinds.push(event.kind);
            }
            for (const [stateId, kinds] of grouped) {
                lines.push(`    life${index} -> s${stateId} [style=dashed, label="${dotEscape(kinds.join("/"))}"];`);
            }
        }
        lines.push("  }");
    }

    lines.push("}");
    return lines.join("\n");
}

function mermaidEscape(text) {
    return oneLine(text).replace(/"/g, "'").replace(/[<>]/g, "");
}

function renderMermaid(graph) {
    const lines = ["flowchart LR", "  ENTRY([ENTRY])", "  STOP([STOP])"];
    for (const state of graph.states) {
        const ops = state.operations.map(op => {
            const text = op.emittedText || op.originalText || `${op.emittedTarget || "?"} = ${op.rhs || "?"}`;
            return `#${op.index} ${op.kind}: ${mermaidEscape(text)}`;
        });
        lines.push(`  S${state.id}["State ${state.id}${state.entry ? " [entry]" : ""}<br/>${ops.join("<br/>")}"]`);
    }
    for (const entry of graph.entries) lines.push(`  ENTRY --> S${entry}`);
    for (const state of graph.states) {
        if (!Array.isArray(state.successors)) continue;
        if (state.successors.length === 0) lines.push(`  S${state.id} --> STOP`);
        else if (state.successors.length === 1) lines.push(`  S${state.id} --> S${state.successors[0]}`);
        else {
            lines.push(`  S${state.id} -->|true| S${state.successors[0]}`);
            lines.push(`  S${state.id} -->|false| S${state.successors[1]}`);
            for (let index = 2; index < state.successors.length; index++) lines.push(`  S${state.id} -->|${index + 1}| S${state.successors[index]}`);
        }
    }
    for (let index = 0; index < graph.epochs.length; index++) {
        const epoch = graph.epochs[index];
        lines.push(`  L${index}(["${mermaidEscape(`${epoch.originalRegister} => ${epoch.name}`)}"])`);
        const grouped = new Map();
        for (const event of epoch.events) {
            let kinds = grouped.get(event.state);
            if (!kinds) grouped.set(event.state, kinds = []);
            kinds.push(event.kind);
        }
        for (const [stateId, kinds] of grouped) lines.push(`  L${index} -. ${kinds.join("/")} .-> S${stateId}`);
    }
    return lines.join("\n");
}

function tryRenderSvg(dotPath, svgPath) {
    const result = childProcess.spawnSync("dot", ["-Tsvg", dotPath, "-o", svgPath], {
        encoding: "utf8",
        windowsHide: true,
    });
    if (result.error?.code === "ENOENT") return { rendered: false, reason: "Graphviz dot is not installed" };
    if (result.status !== 0) return { rendered: false, reason: oneLine(result.stderr || `dot exited ${result.status}`) };
    return { rendered: true };
}

function generateGraph(inputPath, basePath = null) {
    const resolvedInput = path.resolve(inputPath);
    const resolvedBase = path.resolve(basePath || defaultBasePath(resolvedInput));
    const source = fs.readFileSync(resolvedInput, "utf8");
    const result = versionVmBlockRegisters(source, parseLua(source, resolvedInput));
    if (!result.found || !result.applied || !result.graph) {
        throw new Error(result.reason || "Beta graph analysis did not apply");
    }

    fs.mkdirSync(path.dirname(resolvedBase), { recursive: true });
    const paths = {
        text: `${resolvedBase}.txt`,
        json: `${resolvedBase}.json`,
        dot: `${resolvedBase}.dot`,
        mermaid: `${resolvedBase}.mmd`,
        svg: `${resolvedBase}.svg`,
    };
    fs.writeFileSync(paths.text, renderText(result.graph), "utf8");
    fs.writeFileSync(paths.json, JSON.stringify(result.graph, null, 2) + "\n", "utf8");
    fs.writeFileSync(paths.dot, renderDot(result.graph), "utf8");
    fs.writeFileSync(paths.mermaid, renderMermaid(result.graph), "utf8");
    const svg = tryRenderSvg(paths.dot, paths.svg);

    return { result, paths, svg };
}

function main() {
    const inputArg = process.argv[2];
    if (!inputArg) throw new Error("Usage: node tools/beta-register-graph.js <output.lua> [output-base]");
    const generated = generateGraph(inputArg, process.argv[3] || null);
    console.log(`States: ${generated.result.graph.states.length}`);
    console.log(`Epochs: ${generated.result.graph.epochs.length}`);
    console.log(`Text: ${generated.paths.text}`);
    console.log(`JSON: ${generated.paths.json}`);
    console.log(`DOT: ${generated.paths.dot}`);
    console.log(`Mermaid: ${generated.paths.mermaid}`);
    if (generated.svg.rendered) console.log(`SVG: ${generated.paths.svg}`);
    else console.log(`SVG: skipped (${generated.svg.reason})`);
    return generated;
}

if (require.main === module) main();

module.exports = {
    defaultBasePath,
    renderText,
    renderDot,
    renderMermaid,
    generateGraph,
    main,
};
