"use strict";

const { indentConditionalEffect } = require("./branches");
function markersSharePrefix(ctx, aMarkers, bMarkers, length) {
    if (aMarkers.length < length || bMarkers.length < length) return false;
    for (let i = 0; i < length; i++) {
        const a = aMarkers[i], b = bMarkers[i];
        if (!a || !b || a.condition !== b.condition || a.truth !== b.truth || a.effectCount !== b.effectCount || a.branchId !== b.branchId) return false;
    }
    return true;
}

function terminalSiblingMatch(ctx, a, b) {
    const am = a.markers || [], bm = b.markers || [];
    if (am.length === 0 || am.length !== bm.length || !markersSharePrefix(ctx, am, bm, am.length - 1)) return null;
    const al = am[am.length - 1], bl = bm[bm.length - 1];
    if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth || al.effectCount !== bl.effectCount || al.branchId !== bl.branchId) return null;
    const effectPrefix = al.effectCount;
    const ae = a.effects || [], be = b.effects || [];
    if (!Number.isInteger(effectPrefix) || effectPrefix > ae.length || effectPrefix > be.length) return null;
    for (let i = 0; i < effectPrefix; i++) if (ae[i] !== be[i]) return null;
    return { al, bl, effectPrefix };
}

function guardLine(ctx, condition, truth, bodyEffects) {
    if (!Array.isArray(bodyEffects) || bodyEffects.length === 0) return null;
    const test = truth ? condition : `(not ${condition})`;
    const body = bodyEffects.map(line => indentConditionalEffect(ctx, line)).join("\n");
    return `if ${test} then\n${body}\nend`;
}

function collapseTerminalCandidates(ctx) {
    let changed = true;
    while (changed) {
        changed = false;
        outer: for (let i = 0; i < ctx.terminalCandidates.length; i++) {
            for (let j = i + 1; j < ctx.terminalCandidates.length; j++) {
                const a = ctx.terminalCandidates[i], b = ctx.terminalCandidates[j];
                const match = terminalSiblingMatch(ctx, a, b);
                if (!match) continue;
                const trueCandidate = match.al.truth ? a : b;
                const falseCandidate = match.al.truth ? b : a;
                const guard = guardLine(ctx, match.al.condition, true, (trueCandidate.effects || []).slice(match.effectPrefix));
                if (!guard) return false;
                const merged = {
                    env: new Map(falseCandidate.env),
                    markers: (falseCandidate.markers || []).slice(0, -1),
                    effects: [
                        ...(falseCandidate.effects || []).slice(0, match.effectPrefix),
                        guard,
                        ...(falseCandidate.effects || []).slice(match.effectPrefix),
                    ],
                    terminal: true,
                };
                ctx.terminalCandidates.splice(j, 1);
                ctx.terminalCandidates.splice(i, 1, merged);
                changed = true;
                break outer;
            }
        }
    }
    return true;
}

function foldTerminalGuards(ctx, candidate) {
    let current = {
        env: new Map(candidate.env),
        markers: [...(candidate.markers || [])],
        effects: [...(candidate.effects || [])],
    };
    while (current.markers.length > 0) {
        let matchIndex = -1;
        let match = null;
        for (let i = 0; i < ctx.terminalCandidates.length; i++) {
            const terminal = ctx.terminalCandidates[i];
            const candidateMatch = terminalSiblingMatch(ctx, current, terminal);
            if (!candidateMatch) continue;
            matchIndex = i;
            match = candidateMatch;
            break;
        }
        if (matchIndex < 0) break;
        const terminal = ctx.terminalCandidates[matchIndex];
        const terminalMarker = terminal.markers[terminal.markers.length - 1];
        const guard = guardLine(ctx, terminalMarker.condition, terminalMarker.truth, (terminal.effects || []).slice(match.effectPrefix));
        if (!guard) return null;
        const prefixEffects = current.effects.slice(0, match.effectPrefix);
        current = {
            env: new Map(current.env),
            markers: current.markers.slice(0, -1),
            effects: [...prefixEffects, guard, ...current.effects.slice(match.effectPrefix)],
        };
        ctx.terminalCandidates.splice(matchIndex, 1);
        if (!collapseTerminalCandidates(ctx)) return null;
    }
    return current;
}

module.exports = { markersSharePrefix, terminalSiblingMatch, guardLine, collapseTerminalCandidates, foldTerminalGuards };
