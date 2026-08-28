"use strict";

function operationWrites(operation) {
    if (!operation || typeof operation !== "object") return [];
    if (typeof operation.emittedTarget === "string") return [operation.emittedTarget];
    if (Array.isArray(operation.emittedTargets)) return operation.emittedTargets.filter(name => typeof name === "string");
    return [];
}

function graphReachable(stateById, fromId, targetId) {
    if (fromId === targetId) return true;
    const queue = [fromId];
    const seen = new Set([fromId]);
    while (queue.length) {
        const id = queue.shift();
        const state = stateById.get(id);
        for (const next of state?.successors || []) {
            if (next === targetId) return true;
            if (!seen.has(next) && stateById.has(next)) {
                seen.add(next);
                queue.push(next);
            }
        }
    }
    return false;
}

function buildPreCfTempProofIndex(betaResult) {
    const graph = betaResult?.graph;
    if (!graph || !Array.isArray(graph.states)) {
        return { safe: false, reason: "Missing beta graph", byBinding: new Map(), stateById: new Map() };
    }

    const stateById = new Map(graph.states.map(state => [state.id, state]));
    const writes = new Map();
    const reads = new Map();
    const locations = new Map();

    for (const state of graph.states) {
        const operations = Array.isArray(state.operations) ? state.operations : [];
        for (let offset = 0; offset < operations.length; offset++) {
            const operation = operations[offset];
            const location = { stateId: state.id, offset, operation };
            locations.set(operation, location);
            for (const name of operationWrites(operation)) {
                if (!writes.has(name)) writes.set(name, []);
                writes.get(name).push(location);
            }
            for (const name of operation.reads || []) {
                if (typeof name !== "string") continue;
                if (!reads.has(name)) reads.set(name, []);
                reads.get(name).push(location);
            }
        }
    }

    const captured = new Set(graph.recoveredUpvalueBindings || []);
    const byBinding = new Map();
    const names = new Set([...writes.keys(), ...reads.keys()]);
    for (const name of names) {
        const producers = writes.get(name) || [];
        const consumers = reads.get(name) || [];
        const producer = producers.length === 1 ? producers[0] : null;
        const consumer = consumers.length === 1 ? consumers[0] : null;
        const sameState = Boolean(producer && consumer && producer.stateId === consumer.stateId);
        const adjacent = Boolean(sameState && consumer.offset === producer.offset + 1);
        const crossesCycle = Boolean(
            producer && consumer && producer.stateId !== consumer.stateId &&
            graphReachable(stateById, consumer.stateId, producer.stateId)
        );
        const facts = {
            name,
            producer,
            consumer,
            definitionCount: producers.length,
            readCount: consumers.length,
            singleDefinition: producers.length === 1,
            singleUse: consumers.length === 1,
            captured: captured.has(name),
            sameState,
            adjacent,
            crossesCycle,
            cfgComplete: graph.cfgComplete === true,
        };
        facts.safeSameStateTransport = Boolean(
            facts.cfgComplete && facts.singleDefinition && facts.singleUse &&
            !facts.captured && facts.sameState && !facts.crossesCycle
        );
        byBinding.set(name, facts);
    }

    return { safe: true, byBinding, stateById, locations };
}

function provePreCfTempUse(betaResult, bindingName) {
    const index = buildPreCfTempProofIndex(betaResult);
    if (!index.safe) return { safe: false, reason: index.reason };
    const facts = index.byBinding.get(bindingName);
    if (!facts) return { safe: false, reason: `Unknown beta binding ${bindingName}` };
    return { safe: facts.safeSameStateTransport, ...facts };
}

const luaparse = require("../parser/luaparse");
const { findVmFunction } = require("./vm-state");

function parsePreCfSource(source) {
    return luaparse.parse(source, { luaVersion: "luau", comments: false, scope: false, locations: false, ranges: true });
}
function isAstNode(value) { return value && typeof value === "object" && typeof value.type === "string"; }
function numericLiteralValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = typeof node.value === "number" ? node.value : Number(node.raw);
    return Number.isInteger(value) ? value : null;
}
function collectStateLeaves(node, stateName, out = []) {
    if (!isAstNode(node)) return out;
    if (node.type === "IfStatement") {
        for (const clause of node.clauses || []) {
            const c = clause?.condition;
            if (clause?.type !== "IfClause" || c?.type !== "BinaryExpression" || c.operator !== "==") continue;
            const ls = c.left?.type === "Identifier" && c.left.name === stateName;
            const rs = c.right?.type === "Identifier" && c.right.name === stateName;
            if ((ls && numericLiteralValue(c.right) !== null) || (rs && numericLiteralValue(c.left) !== null)) out.push(clause);
        }
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) for (const child of value) collectStateLeaves(child, stateName, out);
        else if (isAstNode(value)) collectStateLeaves(value, stateName, out);
    }
    return out;
}
function mapPreCfOperationRanges(betaResult) {
    let ast;
    try { ast = parsePreCfSource(betaResult.source); } catch (error) { return { safe: false, reason: `PRE-CF source parse failed: ${error.message}` }; }
    const vm = findVmFunction(ast);
    if (!vm) return { safe: false, reason: "PRE-CF VM function not found" };
    const statementsByState = new Map();
    for (const leaf of collectStateLeaves(vm.functionNode, betaResult.graph.stateName, [])) {
        const id = numericLiteralValue(leaf.condition.left) ?? numericLiteralValue(leaf.condition.right);
        if (!Number.isInteger(id) || statementsByState.has(id)) return { safe: false, reason: `PRE-CF ambiguous state leaf ${id}` };
        statementsByState.set(id, (leaf.body || []).filter(statement => statement?.type !== "CommentStatement"));
    }
    const ranges = new Map();
    for (const state of betaResult.graph.states || []) {
        const statements = statementsByState.get(state.id);
        if (!statements || statements.length !== (state.operations || []).length) return { safe: false, reason: `PRE-CF state ${state.id} statement/operation mismatch` };
        for (let i = 0; i < state.operations.length; i++) {
            if (!Array.isArray(statements[i]?.range)) return { safe: false, reason: `PRE-CF state ${state.id} lost statement range` };
            ranges.set(state.operations[i], statements[i].range);
        }
    }
    return { safe: true, ranges };
}
function applySourceEdits(source, edits) {
    let output = source;
    for (const edit of [...edits].sort((a, b) => b.start - a.start)) output = output.slice(0, edit.start) + edit.replacement + output.slice(edit.end);
    return output;
}
function isCopyOperation(operation) { return operation && (operation.kind === "version-define" || operation.kind === "epoch-start"); }
function finalizePreCfCopyTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfCopyTemps = { applied: false, safe: false, reason: "PRE-CF copy recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation, consumer = facts.consumer.operation;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            if (!/^[A-Za-z_][A-Za-z0-9_]*$/.test(String(producer.rhs || ""))) continue;
            if (!Array.isArray(producer.reads) || producer.reads.length !== 1 || producer.reads[0] !== producer.rhs) continue;
            candidate = { facts, producer, consumer };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) { betaResult.preCfCopyTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds }; return betaResult; }
        const pr = ownership.ranges.get(candidate.producer), cr = ownership.ranges.get(candidate.consumer);
        if (!pr || !cr) { betaResult.preCfCopyTemps = { applied: folds > 0, safe: false, reason: "PRE-CF copy recovery lost exact source ownership", folds }; return betaResult; }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.producer.rhs}`;
        const output = applySourceEdits(betaResult.source, [{ start: pr[0], end: pr[1], replacement: "" }, { start: cr[0], end: cr[1], replacement: emittedText }]);
        try { parsePreCfSource(output); } catch (error) { betaResult.preCfCopyTemps = { applied: folds > 0, safe: false, reason: `PRE-CF copy recovery reparse failed: ${error.message}`, folds }; return betaResult; }
        betaResult.source = output;
        const state = betaResult.graph.states.find(item => item.id === candidate.facts.producer.stateId);
        state.operations.splice(candidate.facts.producer.offset, 1);
        candidate.consumer.rhs = candidate.producer.rhs;
        candidate.consumer.reads = [...candidate.producer.reads];
        candidate.consumer.emittedText = emittedText;
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfCopyTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
function parsePreCfRhs(rhs) {
    try {
        const ast = parsePreCfSource(`return ${rhs}`);
        const statement = ast.body?.[0];
        return statement?.type === "ReturnStatement" && statement.arguments?.length === 1 ? statement.arguments[0] : null;
    } catch { return null; }
}

function isSafePreCfScalarExpression(node) {
    if (!node) return false;
    if (["Identifier", "NumericLiteral", "StringLiteral", "BooleanLiteral", "NilLiteral"].includes(node.type)) return true;
    if (node.type === "UnaryExpression") return isSafePreCfScalarExpression(node.argument);
    if (node.type === "BinaryExpression") return isSafePreCfScalarExpression(node.left) && isSafePreCfScalarExpression(node.right);
    return false;
}

function finalizePreCfScalarTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfScalarTemps = { applied: false, safe: false, reason: "PRE-CF scalar recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            const expression = parsePreCfRhs(producer.rhs);
            if (!expression || expression.type === "Identifier" || !isSafePreCfScalarExpression(expression)) continue;
            candidate = { facts, producer, consumer };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfScalarTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRange = ownership.ranges.get(candidate.producer);
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (!producerRange || !consumerRange) {
            betaResult.preCfScalarTemps = { applied: folds > 0, safe: false, reason: "PRE-CF scalar recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.producer.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: producerRange[0], end: producerRange[1], replacement: "" },
            { start: consumerRange[0], end: consumerRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfScalarTemps = { applied: folds > 0, safe: false, reason: `PRE-CF scalar recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const state = betaResult.graph.states.find(item => item.id === candidate.facts.producer.stateId);
        state.operations.splice(candidate.facts.producer.offset, 1);
        candidate.consumer.rhs = candidate.producer.rhs;
        candidate.consumer.reads = [...(candidate.producer.reads || [])];
        candidate.consumer.emittedText = emittedText;
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfScalarTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
function isStaticLookupExpression(node) {
    if (node?.type === "MemberExpression") {
        return node.base?.type === "Identifier" && node.identifier?.type === "Identifier";
    }
    if (node?.type === "IndexExpression") {
        return node.base?.type === "Identifier" && ["StringLiteral", "NumericLiteral", "BooleanLiteral"].includes(node.index?.type);
    }
    return false;
}

function finalizePreCfLookupTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfLookupTemps = { applied: false, safe: false, reason: "PRE-CF lookup recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            const expression = parsePreCfRhs(producer.rhs);
            if (!isStaticLookupExpression(expression)) continue;
            candidate = { facts, producer, consumer };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfLookupTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRange = ownership.ranges.get(candidate.producer);
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (!producerRange || !consumerRange) {
            betaResult.preCfLookupTemps = { applied: folds > 0, safe: false, reason: "PRE-CF lookup recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.producer.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: producerRange[0], end: producerRange[1], replacement: "" },
            { start: consumerRange[0], end: consumerRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfLookupTemps = { applied: folds > 0, safe: false, reason: `PRE-CF lookup recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const state = betaResult.graph.states.find(item => item.id === candidate.facts.producer.stateId);
        state.operations.splice(candidate.facts.producer.offset, 1);
        candidate.consumer.rhs = candidate.producer.rhs;
        candidate.consumer.reads = [...(candidate.producer.reads || [])];
        candidate.consumer.emittedText = emittedText;
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfLookupTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
function collectIdentifierCount(node, name) {
    if (!isAstNode(node)) return 0;
    let count = node.type === "Identifier" && node.name === name ? 1 : 0;
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) for (const child of value) count += collectIdentifierCount(child, name);
        else if (isAstNode(value)) count += collectIdentifierCount(value, name);
    }
    return count;
}

function isStableCallPrefixExpression(node) {
    return ["Identifier", "NumericLiteral", "StringLiteral", "BooleanLiteral", "NilLiteral"].includes(node?.type);
}

function rewriteDirectCallArgument(rhs, tempName, replacement) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "CallExpression" || expression.base?.type !== "Identifier") return null;
    if (collectIdentifierCount(expression, tempName) !== 1) return null;
    const args = expression.arguments || [];
    const argIndex = args.findIndex(arg => arg?.type === "Identifier" && arg.name === tempName);
    if (argIndex < 0) return null;
    for (let i = 0; i < argIndex; i++) if (!isStableCallPrefixExpression(args[i])) return null;
    const arg = args[argIndex];
    if (!Array.isArray(arg.range)) return null;
    const prefixLength = "return ".length;
    const start = arg.range[0] - prefixLength;
    const end = arg.range[1] - prefixLength;
    if (start < 0 || end < start || rhs.slice(start, end) !== tempName) return null;
    return {
        rhs: rhs.slice(0, start) + replacement + rhs.slice(end),
        baseName: expression.base.name,
        argIndex,
    };
}

function finalizePreCfCallArgumentTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfCallArgumentTemps = { applied: false, safe: false, reason: "PRE-CF call-argument recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer)) continue;
            const producerExpr = parsePreCfRhs(producer.rhs);
            if (producerExpr?.type !== "CallExpression") continue;
            const rewritten = rewriteDirectCallArgument(consumer.rhs, facts.name, `(${producer.rhs})`);
            if (!rewritten) continue;
            if (!Array.isArray(consumer.reads) || !consumer.reads.includes(rewritten.baseName)) continue;
            candidate = { facts, producer, consumer, rewritten };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRange = ownership.ranges.get(candidate.producer);
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (!producerRange || !consumerRange) {
            betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: false, reason: "PRE-CF call-argument recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.rewritten.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: producerRange[0], end: producerRange[1], replacement: "" },
            { start: consumerRange[0], end: consumerRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: false, reason: `PRE-CF call-argument recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const state = betaResult.graph.states.find(item => item.id === candidate.facts.producer.stateId);
        state.operations.splice(candidate.facts.producer.offset, 1);
        candidate.consumer.rhs = candidate.rewritten.rhs;
        candidate.consumer.reads = [...new Set([...(candidate.consumer.reads || []).filter(name => name !== candidate.facts.name), ...(candidate.producer.reads || [])])];
        candidate.consumer.emittedText = emittedText;
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
function rewriteDirectCallBase(rhs, tempName, replacement) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "CallExpression" || expression.base?.type !== "Identifier" || expression.base.name !== tempName) return null;
    if (collectIdentifierCount(expression, tempName) !== 1 || !Array.isArray(expression.base.range)) return null;
    const prefixLength = "return ".length;
    const start = expression.base.range[0] - prefixLength;
    const end = expression.base.range[1] - prefixLength;
    if (start < 0 || rhs.slice(start, end) !== tempName) return null;
    return rhs.slice(0, start) + replacement + rhs.slice(end);
}

function isSafeCallBaseProducer(operation) {
    const expression = parsePreCfRhs(operation?.rhs);
    if (!expression) return false;
    if (expression.type === "Identifier") {
        return Array.isArray(operation.reads) && operation.reads.length === 1 && operation.reads[0] === expression.name;
    }
    if (isStaticLookupExpression(expression)) {
        return Array.isArray(operation.reads) && operation.reads.length >= 1;
    }
    return false;
}

function finalizePreCfCallBaseTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfCallBaseTemps = { applied: false, safe: false, reason: "PRE-CF call-base recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || !isSafeCallBaseProducer(producer)) continue;
            const rewrittenRhs = rewriteDirectCallBase(consumer.rhs, facts.name, producer.rhs);
            if (!rewrittenRhs) continue;
            candidate = { facts, producer, consumer, rewrittenRhs };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRange = ownership.ranges.get(candidate.producer);
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (!producerRange || !consumerRange) {
            betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: false, reason: "PRE-CF call-base recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.rewrittenRhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: producerRange[0], end: producerRange[1], replacement: "" },
            { start: consumerRange[0], end: consumerRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: false, reason: `PRE-CF call-base recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const state = betaResult.graph.states.find(item => item.id === candidate.facts.producer.stateId);
        state.operations.splice(candidate.facts.producer.offset, 1);
        candidate.consumer.rhs = candidate.rewrittenRhs;
        candidate.consumer.reads = [...new Set([...(candidate.consumer.reads || []).filter(name => name !== candidate.facts.name), ...(candidate.producer.reads || [])])];
        candidate.consumer.emittedText = emittedText;
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
const LUA_KEYWORDS = new Set(["and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while","continue"]);

function luaStringLiteralValue(rhs) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "StringLiteral") return null;
    if (typeof expression.value === "string") return expression.value;
    const raw = String(expression.raw || "");
    const match = raw.match(/^(["'])([A-Za-z_][A-Za-z0-9_]*)\1$/);
    return match ? match[2] : null;
}

function isValidNamecallMethod(name) {
    return typeof name === "string" && /^[A-Za-z_][A-Za-z0-9_]*$/.test(name) && !LUA_KEYWORDS.has(name);
}

function sourceForExpressionNode(rhs, node) {
    if (!Array.isArray(node?.range)) return null;
    const offset = "return ".length;
    const start = node.range[0] - offset;
    const end = node.range[1] - offset;
    if (start < 0 || end < start || end > rhs.length) return null;
    return rhs.slice(start, end);
}

function matchNamecallTriple(state, offset, proof) {
    const operations = state.operations || [];
    const keyOp = operations[offset];
    const methodOp = operations[offset + 1];
    const callOp = operations[offset + 2];
    if (!isCopyOperation(keyOp) || !isCopyOperation(methodOp) || !isCopyOperation(callOp)) return null;
    const keyName = keyOp.emittedTarget;
    const methodNameBinding = methodOp.emittedTarget;
    if (!keyName || !methodNameBinding) return null;
    const keyFacts = proof.byBinding.get(keyName);
    const methodFacts = proof.byBinding.get(methodNameBinding);
    if (!keyFacts?.safeSameStateTransport || !methodFacts?.safeSameStateTransport) return null;
    if (keyFacts.consumer?.operation !== methodOp || methodFacts.consumer?.operation !== callOp) return null;
    if (keyFacts.producer?.offset !== offset || methodFacts.producer?.offset !== offset + 1) return null;
    const method = luaStringLiteralValue(keyOp.rhs);
    if (!isValidNamecallMethod(method) || (keyOp.reads || []).length !== 0) return null;

    const lookup = parsePreCfRhs(methodOp.rhs);
    if (lookup?.type !== "IndexExpression" || lookup.base?.type !== "Identifier" || lookup.index?.type !== "Identifier") return null;
    if (lookup.index.name !== keyName) return null;
    const baseName = lookup.base.name;
    if (!(methodOp.reads || []).includes(baseName) || !(methodOp.reads || []).includes(keyName)) return null;

    const call = parsePreCfRhs(callOp.rhs);
    if (call?.type !== "CallExpression" || call.base?.type !== "Identifier" || call.base.name !== methodNameBinding) return null;
    if (collectIdentifierCount(call, methodNameBinding) !== 1) return null;
    const args = call.arguments || [];
    if (args.length < 1 || args[0]?.type !== "Identifier" || args[0].name !== baseName) return null;
    const renderedArgs = [];
    for (let i = 1; i < args.length; i++) {
        const text = sourceForExpressionNode(callOp.rhs, args[i]);
        if (text === null) return null;
        renderedArgs.push(text);
    }
    return { keyOp, methodOp, callOp, keyName, methodNameBinding, baseName, method, rhs: `${baseName}:${method}(${renderedArgs.join(", ")})` };
}

function finalizePreCfNamecalls(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfNamecalls = { applied: false, safe: false, reason: "PRE-CF namecall recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const state of betaResult.graph.states || []) {
            for (let offset = 0; offset + 2 < (state.operations || []).length; offset++) {
                const match = matchNamecallTriple(state, offset, proof);
                if (match) { candidate = { state, offset, ...match }; break; }
            }
            if (candidate) break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfNamecalls = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const keyRange = ownership.ranges.get(candidate.keyOp);
        const methodRange = ownership.ranges.get(candidate.methodOp);
        const callRange = ownership.ranges.get(candidate.callOp);
        if (!keyRange || !methodRange || !callRange) {
            betaResult.preCfNamecalls = { applied: folds > 0, safe: false, reason: "PRE-CF namecall recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.callOp.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.callOp.emittedTarget} = ${candidate.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: keyRange[0], end: keyRange[1], replacement: "" },
            { start: methodRange[0], end: methodRange[1], replacement: "" },
            { start: callRange[0], end: callRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfNamecalls = { applied: folds > 0, safe: false, reason: `PRE-CF namecall recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        candidate.state.operations.splice(candidate.offset, 2);
        candidate.callOp.rhs = candidate.rhs;
        candidate.callOp.reads = [...new Set((candidate.callOp.reads || []).filter(name => name !== candidate.keyName && name !== candidate.methodNameBinding))];
        candidate.callOp.emittedText = emittedText;
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfNamecalls = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
function renderReturnTransportExpression(producer) {
    const expression = parsePreCfRhs(producer?.rhs);
    if (!expression) return null;
    if (expression.type === "CallExpression") return `(${producer.rhs})`;
    if (isSafePreCfScalarExpression(expression)) return producer.rhs;
    if (isStaticLookupExpression(expression)) return producer.rhs;
    return null;
}

function finalizePreCfReturnTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfReturnTemps = { applied: false, safe: false, reason: "PRE-CF return recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const payload = facts.consumer.operation;
            if (!isCopyOperation(producer) || payload?.kind !== "return-payload" || payload.terminalCompilerReturnPayload !== true) continue;
            if (!Array.isArray(payload.returnExpressions) || payload.returnExpressions.length !== 1 || payload.returnExpressions[0] !== facts.name) continue;
            if (!Array.isArray(payload.reads) || payload.reads.length !== 1 || payload.reads[0] !== facts.name) continue;
            const replacement = renderReturnTransportExpression(producer);
            if (!replacement) continue;
            candidate = { facts, producer, payload, replacement };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfReturnTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRange = ownership.ranges.get(candidate.producer);
        const payloadRange = ownership.ranges.get(candidate.payload);
        if (!producerRange || !payloadRange) {
            betaResult.preCfReturnTemps = { applied: folds > 0, safe: false, reason: "PRE-CF return recovery lost exact source ownership", folds };
            return betaResult;
        }
        const emittedText = `${candidate.payload.emittedTarget || betaResult.graph.returnName || "ReturnVal"} = { ${candidate.replacement} }`;
        const output = applySourceEdits(betaResult.source, [
            { start: producerRange[0], end: producerRange[1], replacement: "" },
            { start: payloadRange[0], end: payloadRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfReturnTemps = { applied: folds > 0, safe: false, reason: `PRE-CF return recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const state = betaResult.graph.states.find(item => item.id === candidate.facts.producer.stateId);
        state.operations.splice(candidate.facts.producer.offset, 1);
        candidate.payload.rhs = `{ ${candidate.replacement} }`;
        candidate.payload.returnExpressions = [candidate.replacement];
        candidate.payload.reads = [...new Set(candidate.producer.reads || [])];
        candidate.payload.emittedText = emittedText;
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfReturnTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}
module.exports = {
    buildPreCfTempProofIndex,
    provePreCfTempUse,
    finalizePreCfCopyTemps,
    finalizePreCfScalarTemps,
    finalizePreCfLookupTemps,
    finalizePreCfCallArgumentTemps,
    finalizePreCfCallBaseTemps,
    finalizePreCfNamecalls,
    finalizePreCfReturnTemps,
};