"use strict";

const { isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, renderTableFields, renderUnary, sourceOf } = require("../ast");
const { hasLinearRootContinuation, recordRootConditional, upvalueAliasKey, allocateValueDisplay, allocateTableDisplay, parameterName, capturedSlotName, forwardedCaptureName, displayLocal, activeLocalDisplay, hasActiveLocal, resolveId, resolveRenderableId } = require("./bindings");
const { nodeReadsIdentifier, nodeUsesAsCallBaseMulti, terminalStableUsedEpoch, transportSourceKind, valueMayBeReadFrom, eventualCleanupOnAllPaths, valueMayBeReadAfter, hasFutureNonNilWrite, cleanupReachedOnAllPaths, analyzePersistentStorage } = require("./lifetime");
function mergeElseIfCandidates(ctx, candidates, joinId) {
    if (!ctx.allowConditionalIf || candidates.length < 3) return null;
    const markerLists = candidates.map(candidate => candidate.markers || []);
    let sharedPrefix = 0;
    while (true) {
        const first = markerLists[0][sharedPrefix];
        if (!first) break;
        if (!markerLists.every(markers => {
            const marker = markers[sharedPrefix];
            return marker && marker.condition === first.condition && marker.truth === first.truth && marker.effectCount === first.effectCount && marker.branchId === first.branchId;
        })) break;
        sharedPrefix++;
    }

    const chainLength = candidates.length - 1;
    const branchByDepth = new Map();
    let finalElse = null;
    let baseEffectCount = null;

    for (let candidateIndex = 0; candidateIndex < candidates.length; candidateIndex++) {
        const candidate = candidates[candidateIndex];
        const markers = markerLists[candidateIndex];
        const suffix = markers.slice(sharedPrefix);
        if (suffix.length < 1 || suffix.length > chainLength) return null;
        for (let depth = 0; depth < suffix.length - 1; depth++) {
            if (suffix[depth].truth !== false) return null;
        }
        const leaf = suffix[suffix.length - 1];
        if (!leaf || !Number.isInteger(leaf.effectCount)) return null;
        if (baseEffectCount === null) baseEffectCount = leaf.effectCount;
        if (leaf.effectCount !== baseEffectCount) return null;
        for (const marker of suffix) {
            if (!Number.isInteger(marker.effectCount) || marker.effectCount !== baseEffectCount) return null;
        }
        if (leaf.truth === true) {
            const depth = suffix.length;
            if (branchByDepth.has(depth)) return null;
            branchByDepth.set(depth, candidate);
        } else {
            if (suffix.length !== chainLength || finalElse) return null;
            finalElse = candidate;
        }
    }
    if (!finalElse || branchByDepth.size !== chainLength) return null;
    for (let depth = 1; depth <= chainLength; depth++) if (!branchByDepth.has(depth)) return null;

    const conditions = [];
    const conditionBranchIds = [];
    for (let depth = 1; depth <= chainLength; depth++) {
        const candidate = branchByDepth.get(depth);
        const suffix = (candidate.markers || []).slice(sharedPrefix);
        for (let i = 0; i < depth - 1; i++) {
            if (suffix[i].condition !== conditions[i] || suffix[i].truth !== false || suffix[i].branchId !== conditionBranchIds[i]) return null;
        }
        const marker = suffix[depth - 1];
        if (!marker || marker.truth !== true) return null;
        conditions.push(marker.condition);
        conditionBranchIds.push(marker.branchId);
    }
    const elseSuffix = (finalElse.markers || []).slice(sharedPrefix);
    for (let i = 0; i < chainLength; i++) {
        if (elseSuffix[i].condition !== conditions[i] || elseSuffix[i].truth !== false || elseSuffix[i].branchId !== conditionBranchIds[i]) return null;
    }

    const ordered = [];
    for (let depth = 1; depth <= chainLength; depth++) ordered.push(branchByDepth.get(depth));
    ordered.push(finalElse);
    const env = new Map();
    const keys = new Set();
    for (const candidate of ordered) for (const key of candidate.env.keys()) keys.add(key);
    keys.delete(ctx.stateName);
    for (const key of keys) {
        const values = ordered.map(candidate => candidate.env.get(key));
        const first = values[0];
        if (values.every(value => value === first)) {
            if (first !== undefined) env.set(key, first);
            continue;
        }
        if (!valueMayBeReadFrom(ctx, joinId, key)) continue;
        return null;
    }

    const commonEffects = (ordered[0].effects || []).slice(0, baseEffectCount);
    for (const candidate of ordered) {
        const effects = candidate.effects || [];
        if (effects.length < baseEffectCount) return null;
        for (let i = 0; i < baseEffectCount; i++) if (effects[i] !== commonEffects[i]) return null;
    }
    const bodies = ordered.map(candidate => (candidate.effects || []).slice(baseEffectCount));
    // Empty source clauses are valid. Once the elseif marker chain and join are
    // structurally proven, preserve the empty clause so condition evaluation is kept.
    const lines = [];
    for (let depth = 0; depth < chainLength; depth++) {
        lines.push(`${depth === 0 ? "if" : "elseif"} ${conditions[depth]} then`);
        for (const effect of bodies[depth]) lines.push(indentConditionalEffect(ctx, effect));
    }
    const finalBranch = ctx.blocks.get(conditionBranchIds[chainLength - 1]);
    const explicitElse = finalBranch?.transition?.kind === "branch" && finalBranch.transition.onFalse !== joinId;
    if (explicitElse || bodies[chainLength].length > 0) {
        lines.push("else");
        for (const effect of bodies[chainLength]) lines.push(indentConditionalEffect(ctx, effect));
    }
    lines.push("end");
    const structured = lines.join("\n");
    if (sharedPrefix === 0) {
        if (!recordRootConditional(ctx, conditionBranchIds[0], joinId)) return null;
        ctx.out.push(structured);
        return { env, markers: [], effects: commonEffects };
    }
    return {
        env,
        markers: markerLists[0].slice(0, sharedPrefix),
        effects: [...commonEffects, structured],
    };
}

function indentConditionalEffect(ctx, text, prefix = "    ") {
    return String(text).split("\n").map(line => prefix + line).join("\n");
}

function mergeCandidates(ctx, candidates, joinId) {
    if (candidates.length === 1) return {
        env: new Map(candidates[0].env),
        markers: [...(candidates[0].markers || [])],
        effects: [...(candidates[0].effects || [])],
    };
    if (candidates.length > 2) return mergeElseIfCandidates(ctx, candidates, joinId);
    if (candidates.length !== 2) return null;
    const a = candidates[0], b = candidates[1];
    const am = a.markers || [], bm = b.markers || [];
    let prefix = 0;
    while (prefix < am.length && prefix < bm.length && am[prefix].condition === bm[prefix].condition && am[prefix].truth === bm[prefix].truth && am[prefix].branchId === bm[prefix].branchId) prefix++;
    if (am.length !== prefix + 1 || bm.length !== prefix + 1) return null;
    const al = am[prefix], bl = bm[prefix];
    if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth || al.branchId !== bl.branchId) return null;
    const t = al.truth ? a : b;
    const f = al.truth ? b : a;
    const cond = al.condition;
    const te = t.effects || [], fe = f.effects || [];
    if (!Number.isInteger(al.effectCount) || al.effectCount !== bl.effectCount) return null;
    const effectPrefix = al.effectCount;
    if (effectPrefix > te.length || effectPrefix > fe.length) return null;
    for (let i = 0; i < effectPrefix; i++) if (te[i] !== fe[i]) return null;
    const trueEffects = te.slice(effectPrefix), falseEffects = fe.slice(effectPrefix);
    const hasConditionalEffects = trueEffects.length > 0 || falseEffects.length > 0;
    if (hasConditionalEffects && !ctx.allowConditionalIf) return null;
    const branchBlock = ctx.blocks.get(al.branchId);
    const branchTransition = branchBlock?.transition;
    const branchCarriesLogicalResult = !!(branchBlock && branchTransition?.kind === "branch" &&
        branchBlock.body.some((statement, index) => {
            if (index === branchBlock.transitionIndex || !isSingleAssignment(statement)) return false;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            return isIdentifier(dest) && dest.name !== ctx.stateName && isIdentifier(rhs, branchTransition.conditionRegister);
        }));
    const trueDirectJoin = branchTransition?.kind === "branch" && branchTransition.onTrue === joinId;
    const falseDirectJoin = branchTransition?.kind === "branch" && branchTransition.onFalse === joinId;
    const explicitTrueArm = branchTransition?.kind === "branch" && !trueDirectJoin;
    const explicitFalseArm = branchTransition?.kind === "branch" && !falseDirectJoin;
    const preserveEmptyStatementBranch = ctx.allowConditionalIf && !hasConditionalEffects && !branchCarriesLogicalResult &&
        (explicitTrueArm || explicitFalseArm);
    const keys = new Set([...t.env.keys(), ...f.env.keys()]);
    keys.delete(ctx.stateName);
    const env = new Map();
    for (const key of keys) {
        const tv = t.env.get(key);
        const fv = f.env.get(key);
        if (tv === fv) {
            if (tv !== undefined) env.set(key, tv);
            continue;
        }
        if (tv === undefined || fv === undefined) {
            // Path-local TEMP: keep it unknown at the join. A later read
            // before redefinition will still fail closed.
            continue;
        }
        // A path-dependent compiler TEMP that is overwritten before any
        // later read does not participate in source semantics at this
        // join. Drop it before considering logical result-carrier shapes.
        if (!valueMayBeReadFrom(ctx, joinId, key)) continue;
        if (fv === cond && tv != null) {
            if (hasConditionalEffects) return null;
            env.set(key, `(${cond} and ${tv})`);
        }
        else if (tv === cond && fv != null) {
            if (hasConditionalEffects) return null;
            env.set(key, `(${cond} or ${fv})`);
        }
        else return null;
    }

    const loopBranchIds = ctx.options?.loopBranchIds;
    const isWhileBranch = loopBranchIds instanceof Set && loopBranchIds.has(al.branchId);
    if (isWhileBranch) {
        // Compiler WhileStatement lowering is pre-test and always routes true
        // into the body and false directly to the continuation. The loop
        // recognizer breaks only the proven body latch before this merge, so
        // any other polarity/effect shape must fail closed rather than become
        // a guessed source while.
        if (branchCarriesLogicalResult || branchTransition?.kind !== "branch" ||
            branchTransition.onTrue === joinId || branchTransition.onFalse !== joinId ||
            falseEffects.length !== 0) return null;
        const body = trueEffects.map(line => indentConditionalEffect(ctx, line)).join("\n");
        const structured = `while ${cond} do\n${body ? body + "\n" : ""}end`;
        if (prefix === 0) {
            if (!recordRootConditional(ctx, al.branchId, joinId)) return null;
            ctx.out.push(structured);
        } else {
            return {
                env,
                markers: am.slice(0, prefix),
                effects: [...te.slice(0, effectPrefix), structured],
            };
        }
        return { env, markers: am.slice(0, prefix), effects: te.slice(0, effectPrefix) };
    }

    if (hasConditionalEffects || preserveEmptyStatementBranch) {
        let structured;
        if (explicitTrueArm && explicitFalseArm) {
            const trueBody = trueEffects.map(line => indentConditionalEffect(ctx, line)).join("\n");
            const falseBody = falseEffects.map(line => indentConditionalEffect(ctx, line)).join("\n");
            structured = `if ${cond} then\n${trueBody ? trueBody + "\n" : ""}else\n${falseBody ? falseBody + "\n" : ""}end`;
        } else {
            const useTrueArm = explicitTrueArm || (!explicitFalseArm && trueEffects.length > 0);
            const bodyEffects = useTrueArm ? trueEffects : falseEffects;
            const condition = useTrueArm ? cond : `(not ${cond})`;
            const body = bodyEffects.map(line => indentConditionalEffect(ctx, line)).join("\n");
            structured = `if ${condition} then\n${body ? body + "\n" : ""}end`;
        }
        if (prefix === 0) {
            if (!recordRootConditional(ctx, al.branchId, joinId)) return null;
            ctx.out.push(structured);
        } else {
            return {
                env,
                markers: am.slice(0, prefix),
                effects: [...te.slice(0, effectPrefix), structured],
            };
        }
    }
    return { env, markers: am.slice(0, prefix), effects: te.slice(0, effectPrefix) };
}

module.exports = { mergeElseIfCandidates, indentConditionalEffect, mergeCandidates };
