"use strict";

const { isIdentifier, isPrimitiveLiteral, isSingleAssignment } = require("./ast");
const { decodeLogicalStateTransition } = require("./normalize");
const { canReach: graphCanReach, createStateGraph, reachableFrom, transitionOfBody } = require("./cfg");

function statementWritesIdentifier(statement, name) {
    if (!statement || typeof statement !== "object") return false;
    if (Array.isArray(statement.variables) && statement.variables.some(variable => isIdentifier(variable, name))) return true;
    return isIdentifier(statement.variable, name);
}

function hasInterveningWrite(body, fromIndex, toIndex, name) {
    for (let i = fromIndex + 1; i < toIndex; i++) {
        if (statementWritesIdentifier(body[i], name)) return true;
    }
    return false;
}

function compilerSingleCallPackDefinitionBefore(body, beforeIndex, packReg) {
    for (let i = beforeIndex - 1; i >= 0; i--) {
        if (!isSingleAssignment(body[i])) continue;
        const dest = body[i].variables[0];
        if (!isIdentifier(dest, packReg)) continue;
        const rhs = body[i].init[0];
        const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
        return fields.length === 1 && fields[0]?.type === "TableValue" &&
            fields[0].value?.type === "CallExpression" &&
            !hasInterveningWrite(body, i, beforeIndex, packReg);
    }
    return false;
}

function findPrimaryLogicalResultAssignment(body, transition, stateName, returnName) {
    for (let i = body.length - 1; i >= 0; i--) {
        if (i === transition.index || !isSingleAssignment(body[i])) continue;
        const dest = body[i].variables[0];
        const rhs = body[i].init[0];
        if (!isIdentifier(dest) || dest.name === stateName) continue;

        if (isIdentifier(rhs, transition.conditionRegister) &&
            !hasInterveningWrite(body, i, transition.index, transition.conditionRegister)) {
            return { index: i, resultReg: dest.name };
        }

        // A compiler multi-return pack may feed the branch condition directly
        // from slot 1, with later slots scheduled after the state transition.
        // Accept only a proven single-call pack definition so arbitrary source
        // table indexing cannot be mistaken for TESTSET/logical transport.
        if (i < transition.index && dest.name === transition.conditionRegister &&
            rhs?.type === "IndexExpression" && isIdentifier(rhs.base) &&
            rhs.index?.type === "NumericLiteral" && Number(rhs.index.value) === 1 &&
            compilerSingleCallPackDefinitionBefore(body, i, rhs.base.name) &&
            !hasInterveningWrite(body, i, transition.index, dest.name)) {
            return { index: i, resultReg: dest.name, requiresLiveJoin: true };
        }

        // Prometheus can evaluate the left logical operand directly into the
        // TESTSET/result register instead of copying through state/ReturnVal.
        // This is only a primary candidate; the caller must still prove that
        // exactly one successor is the lazy RHS path and that it resolves back
        // into this same result register at the join.
        if (i < transition.index && dest.name === transition.conditionRegister &&
            rhs && rhs.type !== "NilLiteral" &&
            !isIdentifier(rhs, stateName) && !isIdentifier(rhs, returnName) &&
            !hasInterveningWrite(body, i, transition.index, dest.name)) {
            return { index: i, resultReg: dest.name, requiresLiveJoin: true };
        }

        // Current Prometheus reserves POS/state while compiling lazy and/or operands,
        // so a state -> ordinary-register handoff cannot be compiler TESTSET result
        // transport. That shape is source VAR ownership (or otherwise ambiguous) and
        // must remain for structured lifetime recovery. ReturnVal may still be borrowed
        // as the semantic lhs and copied into the logical result carrier.
        if (dest.name !== transition.conditionRegister || !isIdentifier(rhs, returnName) ||
            hasInterveningWrite(body, i, transition.index, dest.name)) continue;

        let specialDefinitionIndex = -1;
        for (let probe = i - 1; probe >= 0; probe--) {
            if (!isSingleAssignment(body[probe])) continue;
            const priorDest = body[probe].variables[0];
            if (!isIdentifier(priorDest, rhs.name)) continue;
            specialDefinitionIndex = probe;
            break;
        }
        if (specialDefinitionIndex < 0 || hasInterveningWrite(body, specialDefinitionIndex, i, rhs.name)) continue;
        return { index: i, resultReg: dest.name };
    }
    return null;
}
function canReachWithoutReentering(graph, start, target, blockedId) {
    if (!graph?.successors || start === blockedId) return false;
    const seen = new Set([start]);
    const work = [start];
    while (work.length) {
        const id = work.pop();
        for (const next of graph.successors.get(id) || []) {
            if (next === target) return true;
            if (next === blockedId || seen.has(next)) continue;
            seen.add(next);
            work.push(next);
        }
    }
    return false;
}

function flattenLogicalRootLeaf(leaves, entryId, stateName, returnName, diagnostics = null, options = {}) {
    const graph = createStateGraph(leaves, entryId, stateName, {
        strictTargets: false,
        reachableOnly: options.reachableOnly === true,
    });
    if (!graph) return null;
    let currentForDiagnostics = entryId;
    function fail(reason, state = currentForDiagnostics) {
        if (diagnostics && !diagnostics.reason) { diagnostics.reason = reason; diagnostics.state = state; }
        return null;
    }
    const consumed = new Set();
    const out = [];

    function findTransition(body) {
        return transitionOfBody(body, stateName);
    }

    function successorsOf(id) {
        return graph.successors.get(id) || [];
    }

    function canReach(start, target) {
        return graphCanReach(graph, start, target);
    }

    function mergeDeps(into, from) {
        for (const dep of from || []) into.add(dep);
    }

    function resolvePathNode(node, env) {
        if (!node || typeof node !== "object") return null;
        if (isIdentifier(node)) {
            const known = env.get(node.name);
            return known ? { node: known.node, deps: new Set(known.deps) } : { node, deps: new Set() };
        }
        if (isPrimitiveLiteral(node)) return { node, deps: new Set() };
        if (node.type === "UnaryExpression") {
            const argument = resolvePathNode(node.argument, env);
            if (!argument) return null;
            return { node: { ...node, argument: argument.node }, deps: argument.deps };
        }
        if (node.type === "BinaryExpression" || node.type === "LogicalExpression") {
            const left = resolvePathNode(node.left, env);
            const right = resolvePathNode(node.right, env);
            if (!left || !right) return null;
            const deps = new Set(left.deps); mergeDeps(deps, right.deps);
            return { node: { ...node, left: left.node, right: right.node }, deps };
        }
        if (node.type === "IndexExpression") {
            const base = resolvePathNode(node.base, env);
            const index = resolvePathNode(node.index, env);
            if (!base || !index) return null;
            const deps = new Set(base.deps); mergeDeps(deps, index.deps);
            return { node: { ...node, base: base.node, index: index.node }, deps };
        }
        if (node.type === "CallExpression") {
            const base = resolvePathNode(node.base, env);
            if (!base) return null;
            const args = [];
            const deps = new Set(base.deps);
            for (const arg of node.arguments || []) {
                const resolved = resolvePathNode(arg, env);
                if (!resolved) return null;
                args.push(resolved.node);
                mergeDeps(deps, resolved.deps);
            }
            return { node: { ...node, base: base.node, arguments: args }, deps };
        }
        if (node.type === "TableConstructorExpression") {
            const fields = [];
            const deps = new Set();
            for (const field of node.fields || []) {
                if (field?.type === "TableValue") {
                    const value = resolvePathNode(field.value, env);
                    if (!value) return null;
                    fields.push({ ...field, value: value.node }); mergeDeps(deps, value.deps); continue;
                }
                if (field?.type === "TableKey") {
                    const key = resolvePathNode(field.key, env);
                    const value = resolvePathNode(field.value, env);
                    if (!key || !value) return null;
                    fields.push({ ...field, key: key.node, value: value.node });
                    mergeDeps(deps, key.deps); mergeDeps(deps, value.deps); continue;
                }
                if (field?.type === "TableKeyString") {
                    const value = resolvePathNode(field.value, env);
                    if (!value) return null;
                    fields.push({ ...field, value: value.node }); mergeDeps(deps, value.deps); continue;
                }
                return null;
            }
            return { node: { ...node, fields }, deps };
        }
        return null;
    }

    function resolvePathResult(statements, resultReg) {
        const env = new Map();
        const defs = [];
        for (let i = 0; i < statements.length; i++) {
            const statement = statements[i];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (!isIdentifier(dest)) return null;
            const resolved = resolvePathNode(rhs, env);
            if (!resolved) return null;
            const deps = new Set(resolved.deps);
            deps.add(i);
            env.set(dest.name, { node: resolved.node, deps });
            defs.push({ index: i, dest: dest.name, rhs });
        }
        const result = env.get(resultReg);
        if (!result) return null;
        for (const def of defs) {
            if (result.deps.has(def.index)) continue;
            if (def.dest === stateName || isIdentifier(def.rhs, stateName)) continue;
            return null;
        }
        return result.node;
    }

    function nodeReadsName(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeReadsName(item, name))) return true;
            } else if (value && typeof value === "object" && nodeReadsName(value, name)) return true;
        }
        return false;
    }

    function valueReadBeforeOverwriteInBody(body, name) {
        for (const statement of body || []) {
            if (!isSingleAssignment(statement)) return true;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (nodeReadsName(rhs, name) || (dest?.type === "IndexExpression" && nodeReadsName(dest, name))) return true;
            if (isIdentifier(dest, name)) return false;
        }
        return false;
    }
    function resultReadAfterJoin(startId, name) {
        const seen = new Set();
        const pending = [startId];
        while (pending.length) {
            const id = pending.pop();
            if (seen.has(id)) continue;
            seen.add(id);
            const body = leaves.get(id);
            if (!body) return false;
            let killed = false;
            for (const statement of body) {
                if (!isSingleAssignment(statement)) return false;
                const dest = statement.variables[0];
                if (nodeReadsName(statement.init[0], name) || (dest?.type === "IndexExpression" && nodeReadsName(dest, name))) return true;
                if (isIdentifier(dest, name)) { killed = true; break; }
            }
            if (!killed) pending.push(...(graph.successors.get(id) || []));
        }
        return false;
    }
    function flattenPath(startId, stopId, targetOut) {
        let current = startId;
        while (stopId == null || current !== stopId) {
            currentForDiagnostics = current;
            if (consumed.has(current)) return fail("root revisits an already-consumed state", current);
            const body = leaves.get(current);
            if (!body) return fail("root references a missing state leaf", current);
            const transition = findTransition(body);
            if (!transition) return fail("root state has no recognized terminal state transition", current);

            if (transition.kind === "branch") {
                const primary = findPrimaryLogicalResultAssignment(body, transition, stateName, returnName);
                if (!primary) return fail("logical branch has no compiler result copy", current);
                const trueReachesFalse = canReachWithoutReentering(graph, transition.onTrue, transition.onFalse, current);
                const falseReachesTrue = canReachWithoutReentering(graph, transition.onFalse, transition.onTrue, current);
                if (trueReachesFalse === falseReachesTrue) return fail("logical branch successors do not form a proven lazy-RHS/join pair", current);

                const operator = trueReachesFalse ? "and" : "or";
                const rhsStart = trueReachesFalse ? transition.onTrue : transition.onFalse;
                const joinId = trueReachesFalse ? transition.onFalse : transition.onTrue;
                // A direct condition definition alone also occurs in source ifs.
                // It is not value-producing logical transport when the candidate
                // result is dead at the join; folding that shape can erase calls.
                if (primary.requiresLiveJoin && !resultReadAfterJoin(joinId, primary.resultReg)) {
                    return fail("logical direct result is not consumed after the join", current);
                }
                if (stopId != null && joinId !== stopId && !canReach(joinId, stopId)) {
                    return fail("nested logical join escapes its enclosing lazy path", current);
                }

                const rhsStatements = [];
                if (!flattenPath(rhsStart, joinId, rhsStatements)) return null;
                const fallback = resolvePathResult(rhsStatements, primary.resultReg);
                if (!fallback) return fail("logical lazy RHS does not reduce to the compiler result register", current);
                const joinBody = leaves.get(joinId);
                const rhsWritten = new Set();
                for (const statement of rhsStatements) {
                    if (!isSingleAssignment(statement)) return fail("logical lazy RHS contains a non-assignment statement", current);
                    const dest = statement.variables[0];
                    if (isIdentifier(dest)) rhsWritten.add(dest.name);
                }
                for (const name of rhsWritten) {
                    if (name === primary.resultReg || name === stateName) continue;
                    if (valueReadBeforeOverwriteInBody(joinBody, name)) {
                        return fail("logical lazy RHS leaves a path-dependent temporary live at the join", current);
                    }
                }

                // The compiler may place transport/extraction statements after the
                // state transition and primary result copy. A flattened lazy RHS can
                // legitimately depend on one of those later definitions (for example
                // the second slot of a pcall result pack). In that case, replacing the
                // primary copy in-place would read the dependency before it exists.
                // Preserve the primary copy as the captured left operand, keep all
                // remaining current-leaf evaluation in order, then combine with the
                // inlined lazy RHS before jumping to the proven join.
                let delayedLogicalCombine = false;
                for (let i = primary.index + 1; i < body.length; i++) {
                    if (i === transition.index || !isSingleAssignment(body[i])) continue;
                    const dest = body[i].variables[0];
                    if (!isIdentifier(dest)) continue;
                    if (nodeReadsName(fallback, dest.name)) delayedLogicalCombine = true;
                }
                if (delayedLogicalCombine) {
                    for (let i = primary.index + 1; i < body.length; i++) {
                        if (i === transition.index || !isSingleAssignment(body[i])) continue;
                        const dest = body[i].variables[0];
                        if (isIdentifier(dest, primary.resultReg)) {
                            return fail("logical delayed combine overwrites the captured left result", current);
                        }
                    }
                }

                consumed.add(current);
                for (let i = 0; i < body.length; i++) {
                    if (i === transition.index) continue;
                    if (i === primary.index && !delayedLogicalCombine) {
                        const statement = body[i];
                        targetOut.push({
                            ...statement,
                            init: [{
                                type: "LogicalExpression",
                                freshCompilerLogical: true,
                                operator,
                                left: statement.init[0],
                                right: fallback,
                            }],
                        });
                    } else {
                        targetOut.push(body[i]);
                    }
                }
                if (delayedLogicalCombine) {
                    const statement = body[primary.index];
                    targetOut.push({
                        ...statement,
                        range: undefined,
                        init: [{
                            type: "LogicalExpression",
                            freshCompilerLogical: true,
                            operator,
                            left: { type: "Identifier", name: primary.resultReg },
                            right: fallback,
                        }],
                    });
                }
                current = joinId;
                continue;
            }

            consumed.add(current);
            for (let i = 0; i < body.length; i++) {
                if (i !== transition.index) targetOut.push(body[i]);
            }
            if (transition.kind === "stop") {
                if (stopId != null) return fail("logical lazy RHS stopped before its proven join", current);
                return true;
            }
            current = transition.target;
        }
        return true;
    }

    const stopId = Number.isInteger(options.stopId) ? options.stopId : null;
    if (!flattenPath(entryId, stopId, out)) return null;
    return { leaf: out, consumed };
}

function reduceCompilerLogicalStateGraph(leaves, entryId, stateName, returnName) {
    const working = new Map([...leaves].map(([id, body]) => [id, [...body]]));

    function transitionOf(body) {
        return transitionOfBody(body, stateName);
    }

    function buildGraph() {
        return createStateGraph(working, entryId, stateName, { strictTargets: false, reachableOnly: true });
    }

    function canReach(start, target, successors) {
        return graphCanReach({ successors }, start, target);
    }

    // Canonical semantic fallback chain:
    //   value = lhs
    //   if value then value = rhs1 end
    //   if not value then value = rhs2 end
    // becomes `(lhs and rhs1) or rhs2` only when both conditional paths are
    // pure value-production regions and the carrier is consumed after the join.
    // This is deliberately separate from compiler TESTSET recognition because
    // current Prometheus emits a different carrier shape for native and/or.
    function resolveFallbackNode(node, env) {
        if (!node || typeof node !== "object") return null;
        if (isIdentifier(node)) {
            const known = env.get(node.name);
            return known ? { node: known.node, deps: new Set(known.deps) } : { node, deps: new Set() };
        }
        if (isPrimitiveLiteral(node)) return { node, deps: new Set() };
        if (node.type === "UnaryExpression") {
            const argument = resolveFallbackNode(node.argument, env);
            return argument ? { node: { ...node, argument: argument.node }, deps: argument.deps } : null;
        }
        if (node.type === "BinaryExpression" || node.type === "LogicalExpression") {
            const left = resolveFallbackNode(node.left, env);
            const right = resolveFallbackNode(node.right, env);
            if (!left || !right) return null;
            const deps = new Set(left.deps);
            for (const dep of right.deps) deps.add(dep);
            return { node: { ...node, left: left.node, right: right.node }, deps };
        }
        if (node.type === "IndexExpression") {
            const base = resolveFallbackNode(node.base, env);
            const index = resolveFallbackNode(node.index, env);
            if (!base || !index) return null;
            const deps = new Set(base.deps);
            for (const dep of index.deps) deps.add(dep);
            return { node: { ...node, base: base.node, index: index.node }, deps };
        }
        if (node.type === "CallExpression") {
            const base = resolveFallbackNode(node.base, env);
            if (!base) return null;
            const args = [];
            const deps = new Set(base.deps);
            for (const arg of node.arguments || []) {
                const resolved = resolveFallbackNode(arg, env);
                if (!resolved) return null;
                args.push(resolved.node);
                for (const dep of resolved.deps) deps.add(dep);
            }
            return { node: { ...node, base: base.node, arguments: args }, deps };
        }
        if (node.type === "TableConstructorExpression") {
            const fields = [];
            const deps = new Set();
            for (const field of node.fields || []) {
                if (field?.type === "TableValue") {
                    const value = resolveFallbackNode(field.value, env);
                    if (!value) return null;
                    fields.push({ ...field, value: value.node });
                    for (const dep of value.deps) deps.add(dep);
                    continue;
                }
                if (field?.type === "TableKey") {
                    const key = resolveFallbackNode(field.key, env);
                    const value = resolveFallbackNode(field.value, env);
                    if (!key || !value) return null;
                    fields.push({ ...field, key: key.node, value: value.node });
                    for (const dep of key.deps) deps.add(dep);
                    for (const dep of value.deps) deps.add(dep);
                    continue;
                }
                if (field?.type === "TableKeyString") {
                    const value = resolveFallbackNode(field.value, env);
                    if (!value) return null;
                    fields.push({ ...field, value: value.node });
                    for (const dep of value.deps) deps.add(dep);
                    continue;
                }
                return null;
            }
            return { node: { ...node, fields }, deps };
        }
        return null;
    }

    function resolveFallbackResult(statements, resultReg) {
        const env = new Map();
        const defs = [];
        for (let i = 0; i < statements.length; i++) {
            const statement = statements[i];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (!isIdentifier(dest)) return null;
            const resolved = resolveFallbackNode(rhs, env);
            if (!resolved) return null;
            const deps = new Set(resolved.deps);
            deps.add(i);
            env.set(dest.name, { node: resolved.node, deps });
            defs.push({ index: i, dest: dest.name, rhs });
        }
        const result = env.get(resultReg);
        if (!result) return null;
        for (const def of defs) {
            if (result.deps.has(def.index)) continue;
            if (def.dest === stateName || isIdentifier(def.rhs, stateName)) continue;
            return null;
        }
        return result.node;
    }

    function nodeReadsFallbackName(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeReadsFallbackName(item, name))) return true;
            } else if (value && typeof value === "object" && nodeReadsFallbackName(value, name)) return true;
        }
        return false;
    }

    function collectPureJumpPath(startId, stopId) {
        const ids = [];
        const statements = [];
        const seen = new Set();
        let current = startId;
        while (current !== stopId) {
            if (seen.has(current)) return null;
            seen.add(current);
            const body = working.get(current);
            const tr = body ? transitionOf(body) : null;
            if (!body || !tr || tr.kind !== "jump") return null;
            ids.push(current);
            for (let i = 0; i < body.length; i++) {
                if (i !== tr.index) statements.push(body[i]);
            }
            current = tr.target;
        }
        return { ids, statements };
    }

    function resultReadFromJoin(graph, startId, name) {
        const seen = new Set();
        const pending = [startId];
        while (pending.length) {
            const id = pending.pop();
            if (seen.has(id)) continue;
            seen.add(id);
            const body = working.get(id);
            if (!body) return false;
            for (const statement of body) {
                if (!isSingleAssignment(statement)) return false;
                const dest = statement.variables[0];
                const rhs = statement.init[0];
                if (nodeReadsFallbackName(rhs, name) || (dest?.type === "IndexExpression" && nodeReadsFallbackName(dest, name))) return true;
                if (isIdentifier(dest, name)) break;
            }
            for (const next of graph.successors.get(id) || []) pending.push(next);
        }
        return false;
    }

    function matchSemanticFallbackChain(id, graph) {
        const body = working.get(id);
        const first = body ? transitionOf(body) : null;
        if (!body || !first || first.kind !== "branch") return null;

        // First branch must use an ordinary carrier initialized from borrowed
        // state/ReturnVal immediately after that special register was computed.
        let carrierIndex = -1;
        let carrierReg = null;
        for (let i = first.index - 1; i >= 0; i--) {
            if (!isSingleAssignment(body[i])) continue;
            const dest = body[i].variables[0];
            const rhs = body[i].init[0];
            if (!isIdentifier(dest, first.conditionRegister)) continue;
            if (!isIdentifier(rhs) || (rhs.name !== stateName && rhs.name !== returnName)) return null;
            carrierIndex = i;
            carrierReg = dest.name;
            break;
        }
        if (carrierIndex < 0 || !carrierReg) return null;
        for (let i = carrierIndex + 1; i < body.length; i++) {
            if (i !== first.index) return null;
        }
        const left = resolveFallbackResult(body.slice(0, carrierIndex + 1), carrierReg);
        if (!left || nodeReadsFallbackName(left, carrierReg)) return null;

        // Positive first guard: true path computes the second operand, false
        // path is the first join.
        const trueReachesFalse = canReachWithoutReentering(graph, first.onTrue, first.onFalse, id);
        const falseReachesTrue = canReachWithoutReentering(graph, first.onFalse, first.onTrue, id);
        if (!trueReachesFalse || falseReachesTrue) return null;
        const firstRhsPath = collectPureJumpPath(first.onTrue, first.onFalse);
        if (!firstRhsPath) return null;
        const firstRhs = resolveFallbackResult(firstRhsPath.statements, carrierReg);
        if (!firstRhs || nodeReadsFallbackName(firstRhs, carrierReg)) return null;

        const middleId = first.onFalse;
        const middleBody = working.get(middleId);
        const middle = middleBody ? transitionOf(middleBody) : null;
        if (!middleBody || !middle || middle.kind !== "branch") return null;
        const middlePrefix = middleBody.filter((_, index) => index !== middle.index);
        const guard = resolveFallbackResult(middlePrefix, middle.conditionRegister);
        if (!guard || guard.type !== "UnaryExpression" || guard.operator !== "not" || !isIdentifier(guard.argument, carrierReg)) return null;

        // `not carrier` true path computes the fallback; false path is final join.
        const fallbackReachesJoin = canReachWithoutReentering(graph, middle.onTrue, middle.onFalse, middleId);
        const joinReachesFallback = canReachWithoutReentering(graph, middle.onFalse, middle.onTrue, middleId);
        if (!fallbackReachesJoin || joinReachesFallback) return null;
        const secondRhsPath = collectPureJumpPath(middle.onTrue, middle.onFalse);
        if (!secondRhsPath) return null;
        const secondRhs = resolveFallbackResult(secondRhsPath.statements, carrierReg);
        if (!secondRhs || nodeReadsFallbackName(secondRhs, carrierReg)) return null;
        const finalJoin = middle.onFalse;
        if (!resultReadFromJoin(graph, finalJoin, carrierReg)) return null;

        const consumed = new Set([id, middleId, ...firstRhsPath.ids, ...secondRhsPath.ids]);
        for (const member of consumed) {
            if (member !== id) {
                for (const pred of graph.predecessors.get(member) || []) {
                    if (!consumed.has(pred)) return null;
                }
            }
            for (const next of graph.successors.get(member) || []) {
                if (next !== finalJoin && !consumed.has(next)) return null;
            }
        }
        return { carrierIndex, carrierReg, left, firstRhs, secondRhs, finalJoin, consumed };
    }

    function applySemanticFallbackChain(id, match) {
        const body = working.get(id);
        const tr = transitionOf(body);
        const original = body[match.carrierIndex];
        const combined = {
            ...original,
            range: undefined,
            init: [{
                type: "LogicalExpression",
                freshSemanticFallbackLogical: true,
                operator: "or",
                left: {
                    type: "LogicalExpression",
                    freshSemanticFallbackLogical: true,
                    operator: "and",
                    left: match.left,
                    right: match.firstRhs,
                },
                right: match.secondRhs,
            }],
        };
        const jump = {
            ...body[tr.index],
            range: undefined,
            init: [{ type: "NumericLiteral", value: match.finalJoin, raw: String(match.finalJoin) }],
        };
        working.set(id, [combined, jump]);
        for (const consumedId of match.consumed) {
            if (consumedId !== id) working.delete(consumedId);
        }
    }

    function logicalJoinFor(id, successors) {
        const body = working.get(id);
        const tr = body ? transitionOf(body) : null;
        if (!tr || tr.kind !== "branch") return null;
        if (!findPrimaryLogicalResultAssignment(body, tr, stateName, returnName)) return null;
        const trueReachesFalse = canReachWithoutReentering({ successors }, tr.onTrue, tr.onFalse, id);
        const falseReachesTrue = canReachWithoutReentering({ successors }, tr.onFalse, tr.onTrue, id);
        if (trueReachesFalse === falseReachesTrue) return null;
        return trueReachesFalse ? tr.onFalse : tr.onTrue;
    }

    const initialGraph = buildGraph();
    if (!initialGraph) return { leaves: working, originalReachableStateIds: new Set() };
    const originalReachableStateIds = initialGraph.reachable;
    let changed = true;
    while (changed) {
        changed = false;
        const currentGraph = buildGraph();
        if (!currentGraph) break;
        const { successors, predecessors, reachable } = currentGraph;
        let semanticFallbackApplied = false;
        for (const id of reachable) {
            const fallback = matchSemanticFallbackChain(id, currentGraph);
            if (!fallback) continue;
            applySemanticFallbackChain(id, fallback);
            changed = true;
            semanticFallbackApplied = true;
            break;
        }
        if (semanticFallbackApplied) continue;

        for (const id of reachable) {
            const joinId = logicalJoinFor(id, successors);
            if (!Number.isInteger(joinId) || joinId === id || !working.has(joinId)) continue;
            const flattened = flattenLogicalRootLeaf(working, id, stateName, returnName, null, { stopId: joinId, reachableOnly: true });
            if (!flattened || !flattened.consumed.has(id) || flattened.consumed.has(joinId)) continue;
            let closed = true;
            for (const consumedId of flattened.consumed) {
                if (consumedId !== id) {
                    for (const pred of predecessors.get(consumedId) || []) {
                        if (!flattened.consumed.has(pred)) { closed = false; break; }
                    }
                    if (!closed) break;
                }
                for (const next of successors.get(consumedId) || []) {
                    if (next !== joinId && !flattened.consumed.has(next)) { closed = false; break; }
                }
                if (!closed) break;
            }
            if (!closed) continue;

            const originalBody = working.get(id);
            const originalTransition = transitionOf(originalBody);
            if (!originalTransition) continue;
            const transitionStatement = originalBody[originalTransition.index];
            const jumpStatement = {
                ...transitionStatement,
                init: [{ type: "NumericLiteral", value: joinId, raw: String(joinId) }],
            };
            working.set(id, [...flattened.leaf, jumpStatement]);
            for (const consumedId of flattened.consumed) {
                if (consumedId === id) continue;
                working.delete(consumedId);
            }
            changed = true;
            break;
        }
    }

    return { leaves: working, originalReachableStateIds };
}

module.exports = { flattenLogicalRootLeaf, reduceCompilerLogicalStateGraph };
