"use strict";

// Diagnostic-only instrumentation in memory; source modules are never rewritten.
const fs = require("fs");
const path = require("path");
const Module = require("module");
const original = Module._extensions[".js"];
const seen = new Set();
global.__freshFailure = (line, state, ctx, entry = 1) => {
    entry = ctx?.options?.entryId || entry;
    const key = `${entry}:${state}:${line}`;
    if (!seen.has(key)) {
        seen.add(key);
        console.error(JSON.stringify({ entry, state, line, statement: ctx?.diagnosticStatement,
            ...(process.env.FRESH_TRACE_FULL ? { env: ctx?.diagnosticEnv, packs: ctx?.structuredPacks ? [...ctx.structuredPacks].map(([id, pack]) => [id, {...pack, slots: [...pack.slots].map(([slot, info]) => [slot, {...info, tempRegs: [...info.tempRegs]}])}]) : null,
                forcedRegs: ctx?.options?.forcedPersistentStorageRegs ? [...ctx.options.forcedPersistentStorageRegs] : null,
                forcedStarts: ctx?.options?.forcedPersistentStorageStarts ? [...ctx.options.forcedPersistentStorageStarts].map(([k,v]) => [k,[...v]]) : null,
                output: ctx?.out?.slice(-3) } : {}) }));
    }
    return null;
};
global.__freshMergeFailure = (state, candidates, ctx, entry = 1) => {
    entry = ctx?.options?.entryId || entry;
    const simplifyEnv = env => [...(env || [])].filter(([key]) => typeof key === "string" && !key.startsWith("\0"));
    console.error(JSON.stringify({
        mergeFailure: true,
        entry,
        state,
        candidates: (candidates || []).map(candidate => ({
            markers: candidate.markers,
            effects: candidate.effects,
            env: simplifyEnv(candidate.env),
        })),
        loopBranchIds: ctx?.options?.loopBranchIds ? [...ctx.options.loopBranchIds] : [],
        repeatBranchIds: ctx?.options?.repeatBranchIds ? [...ctx.options.repeatBranchIds] : [],
        genericForBranchIds: ctx?.options?.genericForBranchIds ? [...ctx.options.genericForBranchIds] : [],
        loopBodyJoinIds: ctx?.options?.loopBodyJoinIds ? [...ctx.options.loopBodyJoinIds] : [],
    }));
};
global.__freshGraphFailure = (leaves, entryId, stateName) => {
    const { decodeLogicalStateTransition } = require("../passes/beta-cf/normalize");
    const { isSingleAssignment } = require("../passes/beta-cf/ast");
    const bad = [];
    const transitions = new Map();
    for (const [id, body] of leaves || []) {
        let transition = null;
        for (let i = body.length - 1; i >= 0; i--) {
            if (!isSingleAssignment(body[i], stateName)) continue;
            const rhs = body[i].init[0];
            if (rhs?.type === "NilLiteral") transition = { kind: "stop" };
            else if (rhs?.type === "NumericLiteral") transition = { kind: "jump", targets: [Number(rhs.value)] };
            else {
                const branch = decodeLogicalStateTransition(rhs);
                if (branch) transition = { kind: "branch", targets: [branch.onTrue, branch.onFalse] };
            }
            break;
        }
        if (!transition) bad.push({ id, reason: "no-transition" });
        else for (const target of transition.targets || []) if (!leaves.has(target)) bad.push({ id, reason: "missing-target", target });
        transitions.set(id, transition);
    }
    const reachable = new Set(), queue = [entryId];
    while (queue.length) {
        const id = queue.shift();
        if (reachable.has(id)) continue;
        reachable.add(id);
        for (const target of transitions.get(id)?.targets || []) queue.push(target);
    }
    console.error(JSON.stringify({ graphFailure: true, entryId, leafCount: leaves?.size,
        reachableCount: reachable.size, bad: bad.filter(item => reachable.has(item.id)).slice(0, 20).map(item => ({
            ...item, body: leaves.get(item.id),
        })) }));
};
global.__freshLoopFailure = (line, entryId) => {
    console.error(JSON.stringify({ loopFailure: true, line, entryId }));
    return null;
};
global.__freshLoopUnmatched = (entryId, ordered, matches) => {
    console.error(JSON.stringify({ loopUnmatched: true, entryId, existing: matches.map(item => item.type),
        candidates: ordered.map(item => ({ headerId: item.headerId, coreIds: [...item.coreIds], backedges: [...(item.backedgeSources || [])], terminal: !!item.terminalBody })) }));
    return null;
};
global.__freshGenericFailure = line => { console.error(JSON.stringify({ genericFailure: true, line })); return null; };
Module._extensions[".js"] = (module, filename) => {
    if (filename.endsWith(path.join("structured", "context.js"))) {
        const source = fs.readFileSync(filename, "utf8").split("\n").map((line, index) => {
            if (line.includes("if (!graph) return null;")) return line.replace("if (!graph) return null;", "if (!graph) { global.__freshGraphFailure(leaves, entryId, stateName); return null; }");
            return line.replace(/return null;/g, `return global.__freshFailure("context:${index + 1}", null, null, options.entryId || 1);`);
        }).join("\n");
        return module._compile(source, filename);
    }
    if (process.env.FRESH_TRACE_LOOPS && filename.endsWith(path.join("control", "loops.js"))) {
        const source = fs.readFileSync(filename, "utf8").split("\n").map((line, index) => {
            if (line.includes("if (!applied) return null;")) return line.replace("return null;", "return global.__freshLoopUnmatched(entryId, ordered, matches);");
            return line.replace(/return null;/g, `return global.__freshLoopFailure(${index + 1}, entryId);`);
        }).join("\n");
        return module._compile(source, filename);
    }
    if (process.env.FRESH_TRACE_LOOPS && filename.endsWith(path.join("control", "generic-for.js"))) {
        const source = fs.readFileSync(filename, "utf8").split("\n").map((line, index) =>
            line.replace(/return null;/g, `return global.__freshGenericFailure(${index + 1});`)).join("\n");
        return module._compile(source, filename);
    }
    if (!filename.endsWith(path.join("structured", "solver.js"))) return original(module, filename);
    let active = false;
    const source = fs.readFileSync(filename, "utf8").split("\n").map((line, index) => {
        if (line.startsWith("function matchMultiStateLogicalLocals(")) {
            active = true;
            return line + "\nlet diagnosticState = null;";
        }
        if (!active) return line;
        if (line.includes("const ctx = createStructuredContext")) line += ` console.error(JSON.stringify({contextCall:true,created:!!ctx,entry:options.entryId||1,allowConditionalIf:options.allowConditionalIf, normalizedSize:options.normalizedLeaves?.size, rootReachableOnly:options.rootReachableOnly, loops:{while:options.loopBranchIds?.size,repeat:options.repeatBranchIds?.size,numeric:options.numericForBranchIds?.size,generic:options.genericForBranchIds?.size}}));`;
        if (line.includes("const id = ctx.processingQueue.shift();")) line += " diagnosticState = id;";
        if (line.includes("const statement = block.body[i];")) line += " ctx.diagnosticStatement = sourceOf(source, statement); ctx.diagnosticEnv = [...env];";
        if (line.includes("if (!merged) return null;")) line = line.replace("if (!merged) return null;", "if (!merged) { global.__freshMergeFailure(diagnosticState, normalizedCandidates, ctx, options.entryId || 1); return null; }");
        return line.replace(/return null;/g, `return global.__freshFailure(${index + 1}, diagnosticState, ctx, options.entryId || 1);`);
    }).join("\n");
    module._compile(source, filename);
};
const { parseLuaStructural } = require("../main");
const { solveFreshSource } = require("../passes/beta-cf/solve");
const file = path.resolve(process.argv[2]);
const source = fs.readFileSync(file, "utf8");
if (process.argv[3]) {
    const { findVmFunction } = require("../passes/vm-state");
    const { findStateWhile, extractNormalizedStateLeaves } = require("../passes/beta-cf/normalize");
    const { createStateGraph } = require("../passes/beta-cf/cfg");
    const { canonicalizeCompilerNumericForChecks } = require("../passes/beta-cf/control/numeric-for");
    const ast = parseLuaStructural(source);
    const vm = findVmFunction(ast).functionNode;
    const state = vm.parameters[0].name;
    const leaves = extractNormalizedStateLeaves(findStateWhile(vm, state), state);
    if (process.argv[3] === "loops") {
        const { collapseCompilerStructuredLoops } = require("../passes/beta-cf/control/loops");
        const loopEntry = Number(process.argv[4]) || 1;
        const collapsed = collapseCompilerStructuredLoops(leaves, loopEntry, state, "ReturnVal");
        const { createStructuredContext } = require("../passes/beta-cf/structured/context");
        const directContext = collapsed && createStructuredContext(source, findStateWhile(vm, state), state, "ReturnVal", {
            allowConditionalIf: true, rootReachableOnly: true, entryId: loopEntry, normalizedLeaves: collapsed.leaves,
        });
        console.log(JSON.stringify(collapsed ? {
            applied: true, directContext: !!directContext, loopCount: collapsed.loopCount, matches: collapsed.matches.map(match => ({ type: match.type, headerId: match.headerId, bodyId: match.bodyId, exitId: match.exitId,
                decisionId: match.decisionId, checkId: match.checkId, coreIds: match.coreIds ? [...match.coreIds] : undefined })),
            state8: collapsed.leaves.get(8),
        } : { applied: false }, null, 2));
        process.exit(0);
    }
    canonicalizeCompilerNumericForChecks(leaves, state);
    const graph = createStateGraph(leaves, Number(process.argv[3]), state, { reachableOnly: true });
    if (!graph) throw new Error("Unresolved graph");
    for (const id of graph.reachable) {
        const block = graph.blocks.get(id);
        console.log("STATE", id, JSON.stringify(block.transition));
        for (const statement of block.body) console.log(statement.range ? source.slice(...statement.range) : JSON.stringify(statement));
    }
    process.exit(0);
}
const result = solveFreshSource(source, parseLuaStructural(source));
console.log(JSON.stringify({ ...result, source: result.source?.slice(0, 500) }, null, 2));
