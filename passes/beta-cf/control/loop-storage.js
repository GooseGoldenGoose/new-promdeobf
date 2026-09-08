"use strict";

const { isIdentifier, isSingleAssignment, isVmRegisterName } = require("../ast");

function transitionTargets(transition) {
    if (transition?.kind === "jump") return [transition.target];
    if (transition?.kind === "branch") return [transition.onTrue, transition.onFalse];
    return [];
}

function nodeReadsName(node, name) {
    if (!node || typeof node !== "object") return false;
    if (isIdentifier(node, name)) return true;
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc" || key === "variables") continue;
        if (Array.isArray(value)) {
            if (value.some(item => nodeReadsName(item, name))) return true;
        } else if (value && typeof value === "object" && nodeReadsName(value, name)) {
            return true;
        }
    }
    return false;
}

function statementReadsName(statement, name) {
    if (!statement || typeof statement !== "object") return false;
    if (statement.type === "AssignmentStatement") {
        for (const rhs of statement.init || []) if (nodeReadsName(rhs, name)) return true;
        for (const dest of statement.variables || []) {
            if (dest?.type === "IndexExpression" && nodeReadsName(dest, name)) return true;
        }
        return false;
    }
    return nodeReadsName(statement, name);
}

function valueMayBeReadBeforeOverwriteFrom(graph, blockId, name) {
    // Every queued block receives the same still-live incoming value. Once a
    // write kills that value, stop that path; revisiting a join cannot add proof.
    // A per-path DFS otherwise enumerates exponentially many diamond paths.
    const seen = new Set();
    const queue = [blockId];
    while (queue.length) {
        const id = queue.pop();
        if (seen.has(id)) continue;
        seen.add(id);
        const block = graph.blocks.get(id);
        if (!block) continue;
        let killed = false;
        for (let i = 0; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (statementReadsName(statement, name)) return true;
            if (statement?.type === "AssignmentStatement" &&
                (statement.variables || []).some(dest => isIdentifier(dest, name))) { killed = true; break; }
        }
        if (killed) continue;
        if (block.transition?.kind === "branch" && block.transition.conditionRegister === name) return true;
        queue.push(...transitionTargets(block.transition));
    }
    return false;
}

function candidateLoopCarriedRegisters(graph, matches) {
    const candidates = new Set();
    const starts = new Map();
    const evidence = new Map();
    for (const match of matches) {
        const preheader = graph.blocks.get(match.preheaderId);
        if (!preheader) continue;
        const preheaderDefinitions = new Map();
        for (let i = 0; i < preheader.transitionIndex; i++) {
            const statement = preheader.body[i];
            if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) continue;
            const name = statement.variables[0].name;
            // Nil can be a real source initializer for a loop-carried binding.
            // Ownership is proved below from a loop write plus an observed live
            // incoming value, so do not discard nil definitions up front.
            if (!isVmRegisterName(name)) continue;
            preheaderDefinitions.set(name, i);
        }
        for (const [name, definitionIndex] of preheaderDefinitions) {
            let hasLoopWrite = false;
            let readsInitialBeforeOverwrite = false;
            const seen = new Set();
            const queue = [{ id: match.headerId, live: true }];
            while (queue.length) {
                const cursor = queue.shift();
                const key = cursor.id + ":" + (cursor.live ? "1" : "0");
                if (seen.has(key)) continue;
                seen.add(key);
                const block = graph.blocks.get(cursor.id);
                if (!block) continue;
                let live = cursor.live;
                for (let i = 0; i < block.body.length; i++) {
                    if (i === block.transitionIndex) continue;
                    const statement = block.body[i];
                    if (live && statementReadsName(statement, name)) readsInitialBeforeOverwrite = true;
                    if (isSingleAssignment(statement) && isIdentifier(statement.variables[0], name)) {
                        if (statement.init[0]?.type !== "NilLiteral") hasLoopWrite = true;
                        live = false;
                    }
                }
                if (live && block.transition?.kind === "branch" && block.transition.conditionRegister === name) readsInitialBeforeOverwrite = true;
                for (const target of transitionTargets(block.transition)) {
                    if (!match.coreIds.has(target)) {
                        // A loop-carried source value may be observed only after the
                        // loop exits (for example a nil-initialized "best match"
                        // updated conditionally in the body). If this exact incoming
                        // epoch reaches an exit-side read before overwrite, that is
                        // source-storage evidence just like an in-loop read.
                        if (live && valueMayBeReadBeforeOverwriteFrom(graph, target, name)) {
                            readsInitialBeforeOverwrite = true;
                        }
                        continue;
                    }
                    if (target === match.headerId) continue;
                    queue.push({ id: target, live });
                }
            }
            if (hasLoopWrite && readsInitialBeforeOverwrite) {
                candidates.add(name);
                if (!starts.has(name)) starts.set(name, new Set());
                starts.get(name).add(match.preheaderId + ":" + definitionIndex);
                if (!evidence.has(name)) evidence.set(name, []);
                evidence.get(name).push({ blockId: match.preheaderId, statement: preheader.body[definitionIndex] });
            }
        }
    }
    return { registers: candidates, starts, evidence };
}

function remapLoopCarriedStarts(candidate, leaves) {
    if (!candidate || !(leaves instanceof Map)) return { registers: new Set(), starts: new Map(), evidence: new Map() };
    const registers = new Set();
    const starts = new Map();
    const evidence = candidate.evidence instanceof Map ? candidate.evidence : new Map();
    for (const [name, items] of evidence) {
        const mapped = new Set();
        for (const item of items || []) {
            const body = leaves.get(item.blockId);
            if (!Array.isArray(body)) continue;
            const index = body.indexOf(item.statement);
            if (index >= 0) mapped.add(item.blockId + ":" + index);
        }
        if (!mapped.size) continue;
        registers.add(name);
        starts.set(name, mapped);
    }
    return { registers, starts, evidence };
}

module.exports = { candidateLoopCarriedRegisters, remapLoopCarriedStarts };
