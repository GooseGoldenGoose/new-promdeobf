"use strict";

const { isIdentifier, isSingleAssignment, isPrimitiveLiteral } = require("../ast");
const { createStateGraph } = require("../cfg");
const { extractNormalizedStateLeaves } = require("../normalize");
const { matchMultiStateLogicalLocals } = require("../structured/solver");
const { candidateLoopCarriedRegisters, remapLoopCarriedStarts } = require("./loop-storage");

function transitionTargets(transition) {
    if (transition?.kind === "jump") return [transition.target];
    if (transition?.kind === "branch") return [transition.onTrue, transition.onFalse];
    return [];
}

function stronglyConnectedComponents(graph) {
    let nextIndex = 0;
    const index = new Map(), low = new Map(), stack = [], onStack = new Set(), out = [];
    function visit(id) {
        index.set(id, nextIndex); low.set(id, nextIndex); nextIndex++;
        stack.push(id); onStack.add(id);
        for (const next of graph.successors.get(id) || []) {
            if (!graph.reachable.has(next)) continue;
            if (!index.has(next)) { visit(next); low.set(id, Math.min(low.get(id), low.get(next))); }
            else if (onStack.has(next)) low.set(id, Math.min(low.get(id), index.get(next)));
        }
        if (low.get(id) !== index.get(id)) return;
        const component = [];
        while (stack.length) {
            const current = stack.pop(); onStack.delete(current); component.push(current);
            if (current === id) break;
        }
        out.push(component);
    }
    for (const id of graph.reachable) if (!index.has(id)) visit(id);
    return out;
}

function primitiveKey(node) {
    if (!isPrimitiveLiteral(node)) return null;
    if (node.type === "NilLiteral") return "nil";
    if (node.type === "StringLiteral") return `StringLiteral:${String(node.raw ?? node.value ?? "")}`;
    if (node.type === "NumericLiteral") return `NumericLiteral:${String(node.raw ?? node.value)}`;
    return `${node.type}:${JSON.stringify(node.value)}`;
}

function mergeFree(...sets) {
    const out = new Set();
    for (const set of sets) for (const value of set || []) out.add(value);
    return out;
}

function canonicalNode(node, env, blockedFree = new Set()) {
    const primitive = primitiveKey(node);
    if (primitive !== null) return { text: primitive, free: new Set() };
    if (isIdentifier(node)) {
        if (blockedFree.has(node.name) || !env.has(node.name)) return { text: `free:${node.name}`, free: new Set([node.name]) };
        const value = env.get(node.name);
        return { text: value.text, free: new Set(value.free) };
    }
    if (node?.type === "IndexExpression") {
        const base = canonicalNode(node.base, env, blockedFree), key = canonicalNode(node.index, env, blockedFree);
        if (!base || !key) return null;
        return { text: `idx(${base.text},${key.text})`, free: mergeFree(base.free, key.free) };
    }
    if (node?.type === "CallExpression") {
        const base = canonicalNode(node.base, env, blockedFree);
        if (!base) return null;
        const args = [], frees = [base.free];
        for (const arg of node.arguments || []) {
            const value = canonicalNode(arg, env, blockedFree);
            if (!value) return null;
            args.push(value.text); frees.push(value.free);
        }
        return { text: `call(${base.text};${args.join(",")})`, free: mergeFree(...frees) };
    }
    if (node?.type === "UnaryExpression") {
        const arg = canonicalNode(node.argument, env, blockedFree);
        return arg ? { text: `un(${node.operator},${arg.text})`, free: new Set(arg.free) } : null;
    }
    if ((node?.type === "BinaryExpression" || node?.type === "LogicalExpression") && typeof node.operator === "string") {
        const left = canonicalNode(node.left, env, blockedFree), right = canonicalNode(node.right, env, blockedFree);
        if (!left || !right) return null;
        return { text: `bin(${node.operator},${left.text},${right.text})`, free: mergeFree(left.free, right.free) };
    }
    if (node?.type === "TableConstructorExpression") {
        const values = [], frees = [];
        for (const field of node.fields || []) {
            if (field?.type !== "TableValue") return null;
            const value = canonicalNode(field.value, env, blockedFree);
            if (!value) return null;
            values.push(value.text); frees.push(value.free);
        }
        return { text: `table(${values.join(",")})`, free: mergeFree(...frees) };
    }
    return null;
}

function evaluateRegisterAssignments(block, blockedFree = new Set()) {
    const env = new Map(), records = [];
    for (let i = 0; i < block.transitionIndex; i++) {
        const statement = block.body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) continue;
        const value = canonicalNode(statement.init[0], env, blockedFree);
        if (!value) continue;
        const name = statement.variables[0].name;
        env.set(name, value);
        records.push({ index: i, name, value, statement });
    }
    return { env, records };
}

function identifiersRead(node, out = new Set()) {
    if (!node || typeof node !== "object") return out;
    if (isIdentifier(node)) { out.add(node.name); return out; }
    for (const [key, value] of Object.entries(node)) {
        if (key === "range" || key === "loc") continue;
        if (Array.isArray(value)) for (const item of value) identifiersRead(item, out);
        else if (value && typeof value === "object") identifiersRead(value, out);
    }
    return out;
}

function dependencySlice(block, resultIndex, blockedFree) {
    const result = block.body[resultIndex];
    if (!isSingleAssignment(result) || !isIdentifier(result.variables[0])) return null;
    const selected = new Set([resultIndex]);
    const needed = identifiersRead(result.init[0]);
    for (const name of blockedFree) needed.delete(name);
    for (let i = resultIndex - 1; i >= 0; i--) {
        const statement = block.body[i];
        if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) continue;
        const dest = statement.variables[0].name;
        if (!needed.has(dest) || blockedFree.has(dest)) continue;
        selected.add(i); needed.delete(dest);
        for (const name of identifiersRead(statement.init[0])) if (!blockedFree.has(name)) needed.add(name);
    }
    // Remaining names are external roots (_env, args, source storage, captures).
    return selected;
}

function canonicalCompilerExpression(node, latestDefinitions) {
    if (node === null || node === undefined) return node;
    if (Array.isArray(node)) return node.map(item => canonicalCompilerExpression(item, latestDefinitions));
    if (typeof node !== "object") return node;
    if (node.type === "Identifier") {
        const definition = latestDefinitions.get(node.name);
        return { type: "Identifier", binding: definition === undefined ? "external:" + node.name : "definition:" + definition };
    }
    if (node.type === "StringLiteral") return { type: "StringLiteral", raw: String(node.raw ?? node.value ?? "") };
    const output = {};
    for (const key of Object.keys(node).sort()) {
        if (key === "loc" || key === "range" || key === "raw" || key === "comments" || key === "tokens" || key === "isLocal") continue;
        output[key] = canonicalCompilerExpression(node[key], latestDefinitions);
    }
    return output;
}

function statementOperation(statement) {
    if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0])) return null;
    return { statement, target: statement.variables[0].name, rhs: statement.init[0] };
}

function collectDefinitionRefs(value, output = new Set()) {
    if (Array.isArray(value)) { for (const child of value) collectDefinitionRefs(child, output); return output; }
    if (!value || typeof value !== "object") return output;
    if (value.type === "Identifier" && typeof value.binding === "string" && value.binding.startsWith("definition:")) {
        const n = Number(value.binding.slice(11));
        if (Number.isInteger(n)) output.add(n);
    }
    for (const child of Object.values(value)) collectDefinitionRefs(child, output);
    return output;
}

function buildStatementPattern(operations) {
    const definitions = new Map(), nodes = [];
    for (let index = 0; index < operations.length; index++) {
        const op = operations[index];
        const canonical = canonicalCompilerExpression(op.rhs, definitions);
        const dependencies = collectDefinitionRefs(canonical);
        nodes.push({ index, expression: JSON.stringify(canonical), dependencies });
        definitions.set(op.target, index);
    }
    return nodes;
}

function findUniqueStatementSubsequence(operations, pattern) {
    if (!pattern.length) return null;
    const patternNodes = buildStatementPattern(pattern);
    const candidates = new Map();
    function visit(searchStart, matched, selectedIndices, selectedDefinitions) {
        if (candidates.size > 1) return;
        if (matched.size === patternNodes.length) {
            const selected = new Set(selectedIndices);
            const written = new Set(selectedIndices.map(index => operations[index].target));
            for (let index = 0; index < operations.length; index++) {
                if (selected.has(index)) continue;
                const reads = identifiersRead(operations[index].rhs);
                for (const name of written) if (reads.has(name)) return;
            }
            candidates.set(selectedIndices.join(","), [...selectedIndices]);
            return;
        }
        const ready = patternNodes.filter(node => !matched.has(node.index) && [...node.dependencies].every(dep => matched.has(dep)));
        if (!ready.length) return;
        const remaining = patternNodes.length - matched.size;
        for (let operationIndex = searchStart; operationIndex <= operations.length - remaining; operationIndex++) {
            const op = operations[operationIndex];
            const candidateExpression = JSON.stringify(canonicalCompilerExpression(op.rhs, selectedDefinitions));
            for (const node of ready) {
                if (candidateExpression !== node.expression) continue;
                const nextMatched = new Set(matched); nextMatched.add(node.index);
                const nextDefinitions = new Map(selectedDefinitions); nextDefinitions.set(op.target, node.index);
                visit(operationIndex + 1, nextMatched, [...selectedIndices, operationIndex], nextDefinitions);
                if (candidates.size > 1) return;
            }
        }
    }
    visit(0, new Set(), [], new Map());
    if (candidates.size !== 1) return null;
    const indices = [...candidates.values()][0];
    return { indices, selected: new Set(indices) };
}

function collectAcyclicRegionToExit(graph, entryId, exitId, forbidden = new Set()) {
    if (entryId === exitId || forbidden.has(entryId) || !graph.blocks.has(entryId)) return null;
    const ids = new Set(), visiting = new Set();
    let invalid = false;
    function visit(id) {
        if (invalid || id === exitId || ids.has(id)) return;
        if (forbidden.has(id) || visiting.has(id)) { invalid = true; return; }
        const block = graph.blocks.get(id);
        if (!block) { invalid = true; return; }
        const targets = transitionTargets(block.transition);
        if (!targets.length) { invalid = true; return; }
        visiting.add(id);
        for (const target of targets) {
            if (target === exitId) continue;
            if (!graph.blocks.has(target)) { invalid = true; break; }
            visit(target);
            if (invalid) break;
        }
        visiting.delete(id);
        ids.add(id);
    }
    visit(entryId);
    if (invalid || !ids.size) return null;
    const exitPreds = graph.predecessors.get(exitId) || [];
    if (!exitPreds.length || exitPreds.some(id => !ids.has(id))) return null;
    for (const id of ids) {
        if (id === entryId) continue;
        for (const pred of graph.predecessors.get(id) || []) if (!ids.has(pred)) return null;
    }
    return { ids };
}

function topologicalRegionOrder(graph, ids, entryId) {
    const indegree = new Map([...ids].map(id => [id, 0]));
    for (const id of ids) for (const next of graph.successors.get(id) || []) if (ids.has(next)) indegree.set(next, indegree.get(next) + 1);
    if (indegree.get(entryId) !== 0) return null;
    const queue = [entryId], order = [];
    for (let cursor = 0; cursor < queue.length; cursor++) {
        const id = queue[cursor]; order.push(id);
        for (const next of graph.successors.get(id) || []) {
            if (!ids.has(next)) continue;
            indegree.set(next, indegree.get(next) - 1);
            if (indegree.get(next) === 0) queue.push(next);
        }
    }
    return order.length === ids.size ? order : null;
}

function regionOperations(graph, ids, entryId) {
    const order = topologicalRegionOrder(graph, ids, entryId);
    if (!order) return null;
    const operations = [];
    for (const id of order) {
        const block = graph.blocks.get(id);
        for (let index = 0; index < block.body.length; index++) {
            if (index === block.transitionIndex) continue;
            const op = statementOperation(block.body[index]);
            if (!op) return null;
            operations.push({ ...op, blockId: id, bodyIndex: index });
        }
    }
    return operations;
}

function statementReadsName(statement, name) {
    if (!statement || typeof statement !== "object" || typeof name !== "string") return false;
    for (const rhs of statement.init || []) if (identifiersRead(rhs).has(name)) return true;
    for (const dest of statement.variables || []) {
        if (dest?.type === "IndexExpression" && identifiersRead(dest).has(name)) return true;
    }
    return false;
}

function dispatcherPositionTransport(graph, regionIds, exitBlockId, stateName) {
    if (!graph || !(regionIds instanceof Set) || typeof stateName !== "string") return { ignored: new Set() };
    const allowed = new Set(regionIds);
    if (Number.isInteger(exitBlockId) && graph.blocks.has(exitBlockId)) allowed.add(exitBlockId);
    const ignored = new Set();
    const keyOf = (blockId, bodyIndex) => `${blockId}:${bodyIndex}`;

    function proveRoundTrip(saveBlockId, saveIndex, tempName) {
        const memo = new Map(), visiting = new Set();
        function visit(blockId, startIndex) {
            const memoKey = `${blockId}:${startIndex}`;
            if (memo.has(memoKey)) return memo.get(memoKey);
            if (visiting.has(memoKey)) return null;
            visiting.add(memoKey);
            const block = graph.blocks.get(blockId);
            if (!block || !allowed.has(blockId)) { visiting.delete(memoKey); memo.set(memoKey, null); return null; }
            for (let index = startIndex; index < block.body.length; index++) {
                const statement = block.body[index];
                if (isSingleAssignment(statement, stateName) && isIdentifier(statement.init[0], tempName)) {
                    const result = new Set([keyOf(blockId, index)]);
                    visiting.delete(memoKey); memo.set(memoKey, result); return result;
                }
                if (isSingleAssignment(statement) && isIdentifier(statement.variables[0], tempName)) {
                    visiting.delete(memoKey); memo.set(memoKey, null); return null;
                }
                if (statementReadsName(statement, tempName)) {
                    visiting.delete(memoKey); memo.set(memoKey, null); return null;
                }
            }
            const targets = graph.successors.get(blockId) || [];
            if (!targets.length) { visiting.delete(memoKey); memo.set(memoKey, null); return null; }
            const restores = new Set();
            for (const target of targets) {
                if (!allowed.has(target)) { visiting.delete(memoKey); memo.set(memoKey, null); return null; }
                const result = visit(target, 0);
                if (!(result instanceof Set) || !result.size) { visiting.delete(memoKey); memo.set(memoKey, null); return null; }
                for (const value of result) restores.add(value);
            }
            visiting.delete(memoKey); memo.set(memoKey, restores); return restores;
        }
        return visit(saveBlockId, saveIndex + 1);
    }

    for (const blockId of regionIds) {
        const block = graph.blocks.get(blockId);
        if (!block) continue;
        for (let index = 0; index < block.body.length; index++) {
            if (index === block.transitionIndex) continue;
            const statement = block.body[index];
            if (!isSingleAssignment(statement) || !isIdentifier(statement.variables[0]) ||
                statement.variables[0].name === stateName || !isIdentifier(statement.init[0], stateName)) continue;
            const tempName = statement.variables[0].name;
            const restores = proveRoundTrip(blockId, index, tempName);
            if (!(restores instanceof Set) || !restores.size) continue;
            ignored.add(keyOf(blockId, index));
            for (const restore of restores) ignored.add(restore);
        }
    }
    return { ignored };
}

function normalizeConditionOperations(graph, regionIds, entryId, exitBlockId, stateName) {
    const operations = regionOperations(graph, regionIds, entryId);
    if (!operations) return null;
    const transport = dispatcherPositionTransport(graph, regionIds, exitBlockId, stateName);
    return {
        operations: operations.filter(operation => !transport.ignored.has(`${operation.blockId}:${operation.bodyIndex}`)),
        ignored: transport.ignored,
    };
}

function findRealRepeatConditionRegion(graph, coreIds, bodyId, decisionId) {
    const decision = graph.blocks.get(decisionId);
    if (!decision || decision.transition?.kind !== "branch") return null;
    for (let index = 0; index < decision.transitionIndex; index++) {
        const statement = decision.body[index];
        if (isSingleAssignment(statement, decision.transition.conditionRegister)) return null;
    }
    const stateAssignment = decision.body[decision.transitionIndex];
    const stateName = isSingleAssignment(stateAssignment) && isIdentifier(stateAssignment.variables[0])
        ? stateAssignment.variables[0].name : null;
    if (!stateName) return null;
    const candidates = [];
    const forbidden = new Set([bodyId]);
    for (const id of coreIds) {
        if (id === bodyId || id === decisionId) continue;
        const region = collectAcyclicRegionToExit(graph, id, decisionId, forbidden);
        if (!region || [...region.ids].some(member => !coreIds.has(member))) continue;
        const incoming = graph.predecessors.get(id) || [];
        if (!incoming.some(pred => coreIds.has(pred) && !region.ids.has(pred))) continue;
        const normalized = normalizeConditionOperations(graph, region.ids, id, decisionId, stateName);
        if (!normalized?.operations?.length) continue;
        candidates.push({ entryId: id, ids: region.ids, operations: normalized.operations, ignored: normalized.ignored, stateName });
    }
    candidates.sort((a, b) => b.ids.size - a.ids.size);
    if (!candidates.length) return null;
    if (candidates.length > 1 && candidates[0].ids.size === candidates[1].ids.size) return null;
    return candidates[0];
}

function findDuplicatedConditionRegion(graph, realRegion, directPreheaderId, excludedIds) {
    const matches = [];
    for (const id of graph.reachable) {
        if (excludedIds.has(id) || id === directPreheaderId) continue;
        const region = collectAcyclicRegionToExit(graph, id, directPreheaderId, excludedIds);
        if (!region) continue;
        const normalized = normalizeConditionOperations(graph, region.ids, id, directPreheaderId, realRegion.stateName);
        const operations = normalized?.operations;
        if (!operations || operations.length < realRegion.operations.length) continue;
        const match = findUniqueStatementSubsequence(operations, realRegion.operations);
        if (!match) continue;
        const selectedByBlock = new Map();
        for (const index of match.indices) {
            const op = operations[index];
            if (!selectedByBlock.has(op.blockId)) selectedByBlock.set(op.blockId, new Set());
            selectedByBlock.get(op.blockId).add(op.bodyIndex);
        }
        const ignored = normalized.ignored || new Set();
        let safe = true;
        for (const member of region.ids) {
            if (member === id) continue;
            const block = graph.blocks.get(member);
            const selected = selectedByBlock.get(member) || new Set();
            for (let bodyIndex = 0; bodyIndex < block.body.length; bodyIndex++) {
                if (bodyIndex === block.transitionIndex || ignored.has(`${member}:${bodyIndex}`)) continue;
                if (!selected.has(bodyIndex)) { safe = false; break; }
            }
            if (!safe) break;
        }
        if (!safe) continue;
        const entry = graph.blocks.get(id);
        const selectedEntry = selectedByBlock.get(id) || new Set();
        const retainedStatements = [];
        for (let bodyIndex = 0; bodyIndex < entry.body.length; bodyIndex++) {
            if (bodyIndex === entry.transitionIndex || selectedEntry.has(bodyIndex) || ignored.has(`${id}:${bodyIndex}`)) continue;
            retainedStatements.push(entry.body[bodyIndex]);
        }
        matches.push({
            entryId: id,
            ids: region.ids,
            retainedStatements,
            removedStatementCount: match.indices.length + ignored.size,
        });
    }
    return matches.length === 1 ? matches[0] : null;
}
function removeDuplicateConditionFromPreheader(graph, preheaderId, decisionId) {
    const preheader = graph.blocks.get(preheaderId), decision = graph.blocks.get(decisionId);
    if (!preheader || !decision || decision.transition?.kind !== "branch") return null;
    const real = evaluateRegisterAssignments(decision);
    const condition = real.env.get(decision.transition.conditionRegister);
    if (!condition) return null;
    const pre = evaluateRegisterAssignments(preheader, condition.free);
    const candidates = pre.records.filter(record => record.value.text === condition.text);
    if (candidates.length !== 1) return null;
    const slice = dependencySlice(preheader, candidates[0].index, condition.free);
    if (!slice || !slice.size) return null;
    const retained = preheader.body.filter((_, index) => index === preheader.transitionIndex || !slice.has(index));
    return { retainedBody: retained, condition, removedStatementCount: slice.size };
}

function cloneLeaves(leaves) {
    return new Map([...leaves].map(([id, body]) => [id, [...body]]));
}

function numericLiteral(value) { return { type: "NumericLiteral", value, raw: String(value) }; }
function syntheticJump(stateName, targetId) {
    return { type: "AssignmentStatement", variables: [{ type: "Identifier", name: stateName }], init: [numericLiteral(targetId)] };
}

function rewriteBranchFalseTarget(leaves, graph, blockId, targetId) {
    const block = graph.blocks.get(blockId), body = leaves.get(blockId);
    if (!block || !body || block.transition?.kind !== "branch") return false;
    const statement = body[block.transitionIndex], rhs = statement?.init?.[0];
    if (!isSingleAssignment(statement) || rhs?.type !== "LogicalExpression" || rhs.operator !== "or" ||
        rhs.left?.type !== "LogicalExpression" || rhs.left.operator !== "and") return false;
    const next = [...body];
    next[block.transitionIndex] = {
        ...statement,
        init: [{ ...rhs, right: numericLiteral(targetId) }],
    };
    leaves.set(blockId, next);
    return true;
}

function isCompilerTerminalReturnBlock(block, returnName) {
    if (!block || block.transition?.kind !== "stop" || typeof returnName !== "string") return false;
    for (let i = block.transitionIndex - 1; i >= 0; i--) {
        const statement = block.body[i];
        if (!isSingleAssignment(statement, returnName)) continue;
        return statement.init[0]?.type === "TableConstructorExpression";
    }
    return false;
}

function collectTerminalReturnRegion(graph, startId, coreIds, returnName, forbiddenExitId = null) {
    if (startId === forbiddenExitId || coreIds.has(startId) || !graph.blocks.has(startId)) return null;
    const ids = new Set();
    const visiting = new Set();
    let invalid = false;
    function visit(id) {
        if (invalid || ids.has(id)) return;
        if (id === forbiddenExitId || coreIds.has(id) || visiting.has(id)) { invalid = true; return; }
        const block = graph.blocks.get(id);
        if (!block) { invalid = true; return; }
        visiting.add(id);
        if (block.transition?.kind === "stop") {
            if (!isCompilerTerminalReturnBlock(block, returnName)) invalid = true;
        } else {
            const targets = transitionTargets(block.transition);
            if (!targets.length) invalid = true;
            for (const target of targets) {
                if (invalid) break;
                if (coreIds.has(target) || target === forbiddenExitId) { invalid = true; break; }
                visit(target);
            }
        }
        visiting.delete(id);
        ids.add(id);
    }
    visit(startId);
    if (invalid || !ids.size) return null;
    for (const id of ids) {
        for (const pred of graph.predecessors.get(id) || []) {
            if (coreIds.has(pred) || ids.has(pred)) continue;
            return null;
        }
    }
    return { ids };
}

function collectBreakRegion(graph, startId, coreIds, exitId) {
    if (startId === exitId || coreIds.has(startId) || !graph.blocks.has(startId)) return null;
    const ids = new Set();
    const terminalIds = new Set();
    const visiting = new Set();
    let invalid = false;
    function visit(id) {
        if (invalid || ids.has(id)) return;
        if (id === exitId || coreIds.has(id) || visiting.has(id)) { invalid = true; return; }
        const block = graph.blocks.get(id);
        if (!block || block.transition?.kind === "stop") { invalid = true; return; }
        visiting.add(id);
        const targets = transitionTargets(block.transition);
        if (!targets.length) invalid = true;
        else {
            for (const target of targets) {
                if (target === exitId) {
                    if (block.transition?.kind !== "jump") { invalid = true; break; }
                    terminalIds.add(id);
                    continue;
                }
                if (coreIds.has(target)) { invalid = true; break; }
                visit(target);
                if (invalid) break;
            }
        }
        visiting.delete(id);
        ids.add(id);
    }
    visit(startId);
    if (invalid || !ids.size || !terminalIds.size) return null;
    for (const id of ids) {
        for (const pred of graph.predecessors.get(id) || []) {
            if (coreIds.has(pred) || ids.has(pred)) continue;
            return null;
        }
    }
    return { ids, terminalIds };
}

function matchSimpleRepeatComponent(graph, component, returnName = null) {
    const core = new Set(component);
    const cyclic = component.length > 1 || (component.length === 1 && (graph.successors.get(component[0]) || []).includes(component[0]));
    if (!cyclic) return null;
    const incoming = [], outgoing = [];
    for (const id of core) {
        for (const pred of graph.predecessors.get(id) || []) if (graph.reachable.has(pred) && !core.has(pred)) incoming.push({ pred, target: id });
        for (const next of graph.successors.get(id) || []) if (graph.reachable.has(next) && !core.has(next)) outgoing.push({ source: id, target: next });
    }
    const bodyIds = [...new Set(incoming.map(edge => edge.target))];
    const preheaders = [...new Set(incoming.map(edge => edge.pred))];
    if (bodyIds.length !== 1 || preheaders.length !== 1) return null;
    const bodyId = bodyIds[0], preheaderId = preheaders[0];
    const preheader = graph.blocks.get(preheaderId);
    if (preheader?.transition?.kind !== "jump" || preheader.transition.target !== bodyId) return null;

    // Prometheus RepeatStatement is post-test: true exits, false returns to the body.
    const decisions = [...core].map(id => graph.blocks.get(id)).filter(block =>
        block?.transition?.kind === "branch" && block.transition.onFalse === bodyId && !core.has(block.transition.onTrue)
    );
    if (decisions.length !== 1) return null;
    const decision = decisions[0];
    const exitId = decision.transition.onTrue;
    if (!graph.blocks.has(exitId)) return null;

    const breakRegionIds = new Set();
    const breakTerminalIds = new Set();
    const terminalReturnRegionIds = new Set();
    for (const edge of outgoing) {
        if (edge.source === decision.id && edge.target === exitId) continue;
        const breakRegion = collectBreakRegion(graph, edge.target, core, exitId);
        if (breakRegion) {
            for (const id of breakRegion.ids) breakRegionIds.add(id);
            for (const id of breakRegion.terminalIds) breakTerminalIds.add(id);
            continue;
        }
        const returnRegion = collectTerminalReturnRegion(graph, edge.target, core, returnName, exitId);
        if (!returnRegion) return null;
        for (const id of returnRegion.ids) terminalReturnRegionIds.add(id);
    }

    const realConditionRegion = findRealRepeatConditionRegion(graph, core, bodyId, decision.id);
    let duplicate;
    let recoveredPreheaderId = preheaderId;
    if (realConditionRegion) {
        const excluded = new Set([exitId, ...core, ...breakRegionIds, ...terminalReturnRegionIds]);
        const duplicateRegion = findDuplicatedConditionRegion(graph, realConditionRegion, preheaderId, excluded);
        if (!duplicateRegion) return null;
        recoveredPreheaderId = duplicateRegion.entryId;
        const directPreheader = graph.blocks.get(preheaderId);
        if (!directPreheader) return null;
        const directPreheaderStatements = directPreheader.body.filter((_, index) => index !== directPreheader.transitionIndex);
        const removedStateIds = new Set([...duplicateRegion.ids].filter(id => id !== duplicateRegion.entryId));
        if (preheaderId !== duplicateRegion.entryId) removedStateIds.add(preheaderId);
        duplicate = {
            retainedStatements: [...duplicateRegion.retainedStatements, ...directPreheaderStatements],
            removedStatementCount: duplicateRegion.removedStatementCount,
            regionIds: duplicateRegion.ids,
            removedStateIds,
            logicalRegion: true,
        };
    } else {
        duplicate = removeDuplicateConditionFromPreheader(graph, preheaderId, decision.id);
        if (!duplicate) return null;
    }
    const continueTargetId = realConditionRegion?.entryId ?? decision.id;
    const conditionRegionIds = realConditionRegion?.ids ?? new Set();
    const conditionPreds = (graph.predecessors.get(continueTargetId) || []).filter(id => core.has(id) && !conditionRegionIds.has(id));
    const continueIds = new Set(conditionPreds.length > 1 ? conditionPreds.filter(id => graph.blocks.get(id)?.transition?.kind === "jump" && graph.blocks.get(id).transition.target === continueTargetId) : []);
    return { coreIds: core, breakRegionIds, breakTerminalIds, terminalReturnRegionIds, conditionRegion: realConditionRegion, bodyId, preheaderId: recoveredPreheaderId, directPreheaderId: preheaderId, decisionId: decision.id, exitId, continueIds, duplicate };
}

function matchCompilerRepeatNaturalLoop(graph, loopInfo, returnName = null) {
    if (!graph || !loopInfo?.coreIds?.size || !loopInfo.backedgeSources?.size) return null;
    const match = matchSimpleRepeatComponent(graph, [...loopInfo.coreIds], returnName);
    if (!match || match.bodyId !== loopInfo.headerId) return null;
    return match;
}

function applyCompilerRepeatMatch(transformed, graph, match, stateName, joinId, repeatId, metadata) {
    if (!(transformed instanceof Map) || !graph || !match || typeof stateName !== "string" || !Number.isInteger(joinId) || typeof repeatId !== "string" || !metadata) return false;
    const { repeatBranchIds, repeatBodyStarts, loopControlByBlockId } = metadata;
    if (!(repeatBranchIds instanceof Set) || !(repeatBodyStarts instanceof Map) || !(loopControlByBlockId instanceof Map)) return false;
    transformed.set(match.preheaderId, match.duplicate.retainedBody || [...(match.duplicate.retainedStatements || []), syntheticJump(stateName, match.bodyId)]);
    for (const removedId of match.duplicate.removedStateIds || []) transformed.delete(removedId);
    if (!rewriteBranchFalseTarget(transformed, graph, match.decisionId, joinId)) return false;
    transformed.set(joinId, [syntheticJump(stateName, match.exitId)]);
    repeatBranchIds.add(match.decisionId);
    repeatBodyStarts.set(match.bodyId, { repeatId, decisionId: match.decisionId });
    match.joinId = joinId;
    match.repeatId = repeatId;
    for (const id of match.continueIds) loopControlByBlockId.set(id, "continue");
    for (const id of match.breakTerminalIds || []) {
        const block = graph.blocks.get(id);
        const body = transformed.get(id);
        if (!block || !body || block.transition?.kind !== "jump" || block.transition.target !== match.exitId) return false;
        const next = [...body];
        next[block.transitionIndex] = syntheticJump(stateName, match.decisionId);
        transformed.set(id, next);
        loopControlByBlockId.set(id, "break");
    }
    return true;
}

function collapseCompilerRepeatLoops(leaves, entryId, stateName, returnName = null) {
    if (!(leaves instanceof Map) || !Number.isInteger(entryId) || typeof stateName !== "string") return null;
    const graph = createStateGraph(leaves, entryId, stateName);
    if (!graph) return null;
    const components = stronglyConnectedComponents(graph);
    const matches = [];
    for (const component of components) {
        const match = matchSimpleRepeatComponent(graph, component, returnName);
        if (match) matches.push(match);
    }
    if (!matches.length) return null;
    // Reject overlap/nesting for this first collapse pass; nested repeat is added after the base signature is certified.
    for (let i = 0; i < matches.length; i++) for (let j = i + 1; j < matches.length; j++) {
        if ([...matches[i].coreIds].some(id => matches[j].coreIds.has(id))) return null;
    }
    const transformed = cloneLeaves(leaves);
    const repeatBranchIds = new Set(), repeatBodyStarts = new Map(), loopControlByBlockId = new Map();
    let nextSyntheticId = -1;
    while (transformed.has(nextSyntheticId)) nextSyntheticId--;
    for (let repeatIndex = 0; repeatIndex < matches.length; repeatIndex++) {
        const match = matches[repeatIndex];
        const joinId = nextSyntheticId--;
        const repeatId = `repeat:${repeatIndex + 1}:${match.bodyId}:${match.decisionId}`;
        if (!applyCompilerRepeatMatch(transformed, graph, match, stateName, joinId, repeatId, {
            repeatBranchIds, repeatBodyStarts, loopControlByBlockId,
        })) return null;
    }
    for (const match of matches) match.headerId = match.bodyId;
    const loopCarried = remapLoopCarriedStarts(candidateLoopCarriedRegisters(graph, matches), transformed);
    return {
        leaves: transformed,
        matches,
        repeatBranchIds,
        repeatBodyStarts,
        loopControlByBlockId,
        loopCarriedStorageRegs: loopCarried.registers,
        loopCarriedStorageStarts: loopCarried.starts,
    };
}

function matchCompilerRepeatConditionRegion(leaves, entryId, stateName) {
    const collapsed = collapseCompilerRepeatLoops(leaves, entryId, stateName, null);
    return collapsed?.matches?.length === 1 ? collapsed.matches[0] : null;
}

function removeDuplicatedRepeatConditionRegions(leaves, entryId, stateName) {
    const collapsed = collapseCompilerRepeatLoops(leaves, entryId, stateName, null);
    if (!collapsed) return null;
    return {
        leaves: collapsed.leaves,
        removedRegionCount: collapsed.matches.length,
        removedStateCount: 0,
        removedStatementCount: collapsed.matches.reduce((n, match) => n + match.duplicate.removedStatementCount, 0),
    };
}

function matchCompilerRepeatProgram(source, stateWhile, stateName, returnName, options = {}) {
    const originalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!originalLeaves || originalLeaves.size < 4) return null;
    const entryId = Number.isInteger(options.entryId) ? options.entryId : 1;
    const originalGraph = createStateGraph(originalLeaves, entryId, stateName);
    if (!originalGraph) return null;
    const collapsed = collapseCompilerRepeatLoops(originalLeaves, entryId, stateName, returnName);
    if (!collapsed) return null;
    const program = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, {
        ...options,
        allowConditionalIf: true,
        normalizedLeaves: collapsed.leaves,
        repeatBranchIds: collapsed.repeatBranchIds,
        repeatBodyStarts: collapsed.repeatBodyStarts,
        loopControlByBlockId: collapsed.loopControlByBlockId,
        forcedPersistentStorageRegs: collapsed.loopCarriedStorageRegs,
        forcedPersistentStorageStarts: collapsed.loopCarriedStorageStarts,
        suppressFutureWriteCallArgumentPromotion: true,
    });
    if (!program) return null;
    return {
        ...program,
        stateCount: originalGraph.reachable.size,
        reachableStateIds: [...originalGraph.reachable],
        loopCount: collapsed.matches.length,
        loopMatches: collapsed.matches,
        removedCompilerConditionStatementCount: collapsed.matches.reduce((n, match) => n + match.duplicate.removedStatementCount, 0),
    };
}

module.exports = {
    applyCompilerRepeatMatch,
    matchCompilerRepeatNaturalLoop,
    collapseCompilerRepeatLoops,
    matchCompilerRepeatConditionRegion,
    removeDuplicatedRepeatConditionRegions,
    matchCompilerRepeatProgram,
};
