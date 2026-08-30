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
const { proveEnvironmentBinding } = require("./environment");

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
function preCfOperationSourceStatementCount(operation) {
    if (operation?.kind !== "multi-write" && operation?.kind !== "multi-call-write") return 1;
    const declarations = (operation.targetDeclarations || []).filter(Boolean).length;
    if (!declarations) return 1;
    if (operation.kind === "multi-call-write" && declarations === (operation.emittedTargets || []).length && (operation.targetDeclarations || []).every(Boolean)) return 1;
    return 2;
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
        if (!statements) return { safe: false, reason: `PRE-CF state ${state.id} statement/operation mismatch` };
        let statementIndex = 0;
        for (const operation of state.operations || []) {
            const count = preCfOperationSourceStatementCount(operation);
            const first = statements[statementIndex];
            const last = statements[statementIndex + count - 1];
            if (!Array.isArray(first?.range) || !Array.isArray(last?.range)) return { safe: false, reason: `PRE-CF state ${state.id} lost statement range` };
            ranges.set(operation, [first.range[0], last.range[1]]);
            statementIndex += count;
        }
        if (statementIndex !== statements.length) return { safe: false, reason: `PRE-CF state ${state.id} statement/operation mismatch ${statements.length}/${statementIndex}` };
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
    let parseRounds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        const candidates = [];
        const claimed = new Set();
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation, consumer = facts.consumer.operation;
            if (claimed.has(producer) || claimed.has(consumer)) continue;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            if (!/^[A-Za-z_][A-Za-z0-9_]*$/.test(String(producer.rhs || ""))) continue;
            if (!Array.isArray(producer.reads) || producer.reads.length !== 1 || producer.reads[0] !== producer.rhs) continue;
            candidates.push({ facts, producer, consumer });
            claimed.add(producer); claimed.add(consumer);
        }
        if (!candidates.length) break;
        const ownership = mapPreCfOperationRanges(betaResult); parseRounds++;
        if (!ownership.safe) { betaResult.preCfCopyTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds, parseRounds }; return betaResult; }
        const edits=[];
        for (const candidate of candidates) {
            const pr=ownership.ranges.get(candidate.producer), cr=ownership.ranges.get(candidate.consumer);
            if(!pr||!cr){ betaResult.preCfCopyTemps={applied:folds>0,safe:false,reason:"PRE-CF copy recovery lost exact source ownership",folds,parseRounds}; return betaResult; }
            const prefix=String(candidate.consumer.emittedText||"").trim().startsWith("local ")?"local ":"";
            candidate.emittedText=`${prefix}${candidate.consumer.emittedTarget} = ${candidate.producer.rhs}`;
            edits.push({start:pr[0],end:pr[1],replacement:""},{start:cr[0],end:cr[1],replacement:candidate.emittedText});
        }
        const output=applySourceEdits(betaResult.source,edits);
        try{ parsePreCfSource(output); parseRounds++; } catch(error){ betaResult.preCfCopyTemps={applied:folds>0,safe:false,reason:`PRE-CF copy recovery reparse failed: ${error.message}`,folds,parseRounds}; return betaResult; }
        betaResult.source=output;
        const byState=new Map();
        for(const candidate of candidates){ candidate.consumer.rhs=candidate.producer.rhs; candidate.consumer.reads=[...candidate.producer.reads]; candidate.consumer.emittedText=candidate.emittedText; if(!byState.has(candidate.facts.producer.stateId))byState.set(candidate.facts.producer.stateId,[]); byState.get(candidate.facts.producer.stateId).push(candidate.facts.producer.offset); }
        for(const [stateId,offsets] of byState){ const state=betaResult.graph.states.find(item=>item.id===stateId); for(const offset of offsets.sort((a,b)=>b-a))state.operations.splice(offset,1); for(let i=0;i<state.operations.length;i++)state.operations[i].index=i+1; }
        folds+=candidates.length;
    }
    betaResult.preCfCopyTemps={applied:folds>0,safe:true,folds,parseRounds};
    return betaResult;
}

function finalizePreCfClosureTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfClosureTemps = { applied: false, safe: false, reason: "PRE-CF closure temp recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.singleDefinition || !facts.singleUse || facts.captured || !facts.sameState) continue;
            const producer = facts.producer?.operation, consumer = facts.consumer?.operation;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            const expression = parsePreCfRhs(producer.rhs);
            if (!isPreCfClosureFactoryCall(expression, betaResult.graph)) continue;
            const state = betaResult.graph.states.find(item => item.id === facts.producer.stateId);
            if (!state) continue;
            const producerOffset = facts.producer.offset, consumerOffset = facts.consumer.offset;
            if (!(consumerOffset > producerOffset)) continue;
            const actualTarget = consumer.emittedTarget;
            if (!actualTarget || betaResult.graph.recoveredUpvalueBindings?.includes(actualTarget)) continue;
            let targetVisibleTooEarly = false;
            for (let i = producerOffset + 1; i < consumerOffset; i++) {
                const op = state.operations[i];
                if ((op.reads || []).includes(actualTarget) || operationWrites(op).includes(actualTarget)) { targetVisibleTooEarly = true; break; }
            }
            if (targetVisibleTooEarly) continue;
            candidate = { facts, state, producer, consumer, producerOffset, consumerOffset, actualTarget };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) { betaResult.preCfClosureTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds }; return betaResult; }
        const pr = ownership.ranges.get(candidate.producer), cr = ownership.ranges.get(candidate.consumer);
        if (!pr || !cr) { betaResult.preCfClosureTemps = { applied: folds > 0, safe: false, reason: "PRE-CF closure temp recovery lost exact source ownership", folds }; return betaResult; }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.actualTarget} = ${candidate.producer.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: pr[0], end: pr[1], replacement: emittedText },
            { start: cr[0], end: cr[1], replacement: "" },
        ]);
        try { parsePreCfSource(output); } catch (error) {
            betaResult.preCfClosureTemps = { applied: folds > 0, safe: false, reason: `PRE-CF closure temp recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        candidate.producer.emittedTarget = candidate.actualTarget;
        candidate.producer.emittedText = emittedText;
        candidate.state.operations.splice(candidate.consumerOffset, 1);
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfClosureTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}

function isCompilerCallResultOperation(operation, graph) {
    if (!operation || operation.kind !== "version-define" || operation.registerEpoch) return false;
    if (operation.originalTarget !== graph?.stateName && operation.originalTarget !== graph?.returnName) return false;
    const expression = parsePreCfRhs(operation.rhs);
    if (expression?.type !== "CallExpression") return false;
    if (isPreCfClosureFactoryCall(expression, graph)) return false;
    return true;
}

function finalizePreCfCallResultDestinations(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfCallResultDestinations = { applied: false, safe: false, reason: "PRE-CF call-result destination recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.singleDefinition || !facts.singleUse || facts.captured || !facts.sameState) continue;
            const producer = facts.producer?.operation, consumer = facts.consumer?.operation;
            if (!isCompilerCallResultOperation(producer, betaResult.graph)) continue;
            if (!["version-define", "epoch-start", "epoch-mutate"].includes(consumer?.kind) || consumer.rhs !== facts.name) continue;
            if (!consumer.registerEpoch || !/^(?:r\d+|__overflow_phys_\d+)$/.test(String(consumer.originalTarget || ""))) continue;
            const state = betaResult.graph.states.find(item => item.id === facts.producer.stateId);
            if (!state) continue;
            const producerOffset = facts.producer.offset, consumerOffset = facts.consumer.offset;
            if (!(consumerOffset > producerOffset)) continue;
            const actualTarget = consumer.emittedTarget;
            if (!actualTarget || betaResult.graph.recoveredUpvalueBindings?.includes(actualTarget)) continue;
            let unsafeGap = false;
            for (let i = producerOffset + 1; i < consumerOffset; i++) {
                const op = state.operations[i];
                if ((op.reads || []).includes(actualTarget) || operationWrites(op).includes(actualTarget) || (op.reads || []).includes(facts.name) || operationWrites(op).includes(facts.name)) {
                    unsafeGap = true;
                    break;
                }
            }
            if (unsafeGap) continue;
            candidate = { facts, state, producer, consumer, producerOffset, consumerOffset, actualTarget };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfCallResultDestinations = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRange = ownership.ranges.get(candidate.producer);
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (!producerRange || !consumerRange) {
            betaResult.preCfCallResultDestinations = { applied: folds > 0, safe: false, reason: "PRE-CF call-result destination recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.actualTarget} = ${candidate.producer.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: producerRange[0], end: producerRange[1], replacement: emittedText },
            { start: consumerRange[0], end: consumerRange[1], replacement: "" },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfCallResultDestinations = { applied: folds > 0, safe: false, reason: `PRE-CF call-result destination recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        candidate.producer.emittedTarget = candidate.actualTarget;
        candidate.producer.originalTarget = candidate.consumer.originalTarget;
        candidate.producer.registerEpoch = candidate.consumer.registerEpoch;
        candidate.producer.kind = candidate.consumer.kind;
        candidate.producer.emittedText = emittedText;
        candidate.state.operations.splice(candidate.consumerOffset, 1);
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfCallResultDestinations = { applied: folds > 0, safe: true, folds };
    return betaResult;
}



function isCompilerTableResultOperation(operation, graph) {
    if (!operation || operation.kind !== "version-define" || operation.registerEpoch) return false;
    if (operation.originalTarget !== graph?.stateName && operation.originalTarget !== graph?.returnName) return false;
    return parsePreCfRhs(operation.rhs)?.type === "TableConstructorExpression";
}

function canDeclareRetargetedTableDestination(candidate) {
    if (candidate.consumer?.kind === "epoch-start") return true;
    if (candidate.consumer?.kind !== "epoch-mutate") return false;

    // A reused physical register can hold a short-lived table-entry value before
    // the compiler allocates that same register as the new source local. In that
    // shape beta sees an epoch mutation even though the recovered constructor is
    // the declaration point. Shadowing the prior beta local is safe only inside a
    // terminal state: the constructor initializer still reads the old local, and
    // every later use in the state resolves to the new local. Cross-state users
    // remain conservative because a new lexical local would not escape the block.
    if ((candidate.state?.successors || []).length !== 0) return false;
    const operations = candidate.state.operations || [];
    const producerOffset = operations.indexOf(candidate.producer);
    const consumerOffset = candidate.consumerOffset;
    if (producerOffset < 0 || !(consumerOffset > producerOffset)) return false;

    let priorDeclaration = null;
    for (let i = producerOffset - 1; i >= 0; i--) {
        const op = operations[i];
        if (!operationWrites(op).includes(candidate.actualTarget)) continue;
        priorDeclaration = { op, offset: i };
        break;
    }
    if (!priorDeclaration) return false;
    if (!String(priorDeclaration.op.emittedText || "").trim().startsWith("local ")) return false;
    if (!candidate.producer.reads?.includes(candidate.actualTarget)) return false;

    for (let i = priorDeclaration.offset + 1; i < consumerOffset; i++) {
        const op = operations[i];
        if (op === candidate.producer) continue;
        if (operationWrites(op).includes(candidate.actualTarget)) return false;
    }
    return true;
}

function finalizePreCfTableDestinations(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfTableDestinations = { applied: false, safe: false, reason: "PRE-CF table destination recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const facts of proof.byBinding.values()) {
            if (!facts.singleDefinition || !facts.singleUse || facts.captured || !facts.sameState) continue;
            const producer = facts.producer?.operation, consumer = facts.consumer?.operation;
            if (!isCompilerTableResultOperation(producer, betaResult.graph)) continue;
            if (!["version-define", "epoch-start", "epoch-mutate"].includes(consumer?.kind) || consumer.rhs !== facts.name) continue;
            if (!consumer.registerEpoch || !/^(?:r\d+|__overflow_phys_\d+)$/.test(String(consumer.originalTarget || ""))) continue;
            const state = betaResult.graph.states.find(item => item.id === facts.producer.stateId);
            if (!state) continue;
            const producerOffset = facts.producer.offset, consumerOffset = facts.consumer.offset;
            if (!(consumerOffset > producerOffset)) continue;
            const actualTarget = consumer.emittedTarget;
            if (!actualTarget || betaResult.graph.recoveredUpvalueBindings?.includes(actualTarget)) continue;
            let unsafeGap = false;
            for (let i = producerOffset + 1; i < consumerOffset; i++) {
                const op = state.operations[i];
                if ((op.reads || []).includes(actualTarget) || operationWrites(op).includes(actualTarget) || (op.reads || []).includes(facts.name) || operationWrites(op).includes(facts.name)) { unsafeGap = true; break; }
            }
            if (unsafeGap) continue;
            candidate = { facts, state, producer, consumer, consumerOffset, actualTarget };
            break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) { betaResult.preCfTableDestinations = { applied: folds > 0, safe: false, reason: ownership.reason, folds }; return betaResult; }
        const pr = ownership.ranges.get(candidate.producer), cr = ownership.ranges.get(candidate.consumer);
        if (!pr || !cr) { betaResult.preCfTableDestinations = { applied: folds > 0, safe: false, reason: "PRE-CF table destination recovery lost exact source ownership", folds }; return betaResult; }
        const declareDestination = canDeclareRetargetedTableDestination(candidate);
        const prefix = declareDestination ? "local " : "";
        const emittedText = `${prefix}${candidate.actualTarget} = ${candidate.producer.rhs}`;
        const output = applySourceEdits(betaResult.source, [{ start: pr[0], end: pr[1], replacement: emittedText }, { start: cr[0], end: cr[1], replacement: "" }]);
        try { parsePreCfSource(output); } catch (error) { betaResult.preCfTableDestinations = { applied: folds > 0, safe: false, reason: `PRE-CF table destination recovery reparse failed: ${error.message}`, folds }; return betaResult; }
        betaResult.source = output;
        candidate.producer.emittedTarget = candidate.actualTarget;
        candidate.producer.originalTarget = candidate.consumer.originalTarget;
        candidate.producer.registerEpoch = candidate.consumer.registerEpoch;
        candidate.producer.kind = declareDestination ? "epoch-start" : candidate.consumer.kind;
        candidate.producer.emittedText = emittedText;
        candidate.state.operations.splice(candidate.consumerOffset, 1);
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfTableDestinations = { applied: folds > 0, safe: true, folds };
    return betaResult;
}

function isLiteralOnlyPreCfScalarExpression(node) {
    if (!node) return false;
    if (["NumericLiteral", "StringLiteral", "BooleanLiteral", "NilLiteral"].includes(node.type)) return true;
    if (node.type === "UnaryExpression") return isLiteralOnlyPreCfScalarExpression(node.argument);
    if (node.type === "BinaryExpression") return isLiteralOnlyPreCfScalarExpression(node.left) && isLiteralOnlyPreCfScalarExpression(node.right);
    return false;
}

function directTableEntryIdentifierUses(tableExpression) {
    const uses = [];
    for (const field of tableExpression?.fields || []) {
        if (field?.type === "TableValue" && field.value?.type === "Identifier") uses.push(field.value);
        else if (field?.type === "TableKey") {
            if (field.key?.type === "Identifier") uses.push(field.key);
            if (field.value?.type === "Identifier") uses.push(field.value);
        } else if (field?.type === "TableKeyString" && field.value?.type === "Identifier") uses.push(field.value);
    }
    return uses;
}

function finalizePreCfTableEntryTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfTableEntryTemps = { applied: false, safe: false, reason: "PRE-CF table entry recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const captured = new Set(betaResult.graph.recoveredUpvalueBindings || []);
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        let candidate = null;
        for (const state of betaResult.graph.states || []) {
            const operations = state.operations || [];
            for (let tableOffset = 0; tableOffset < operations.length; tableOffset++) {
                const tableOp = operations[tableOffset];
                if (!["version-define", "epoch-start", "epoch-mutate"].includes(tableOp?.kind) || !tableOp.emittedTarget) continue;
                const tableExpression = parsePreCfRhs(tableOp.rhs);
                if (tableExpression?.type !== "TableConstructorExpression" || !Array.isArray(tableExpression.range)) continue;
                const directUses = directTableEntryIdentifierUses(tableExpression);
                if (!directUses.length) continue;
                const occurrenceCounts = new Map();
                for (const use of directUses) occurrenceCounts.set(use.name, (occurrenceCounts.get(use.name) || 0) + 1);
                const replacements = [];
                const producers = new Set();
                for (const use of directUses) {
                    const name = use.name;
                    if (occurrenceCounts.get(name) !== 1 || captured.has(name) || !Array.isArray(use.range)) continue;
                    let producerOffset = -1;
                    for (let i = tableOffset - 1; i >= 0; i--) {
                        if (operationWrites(operations[i]).includes(name)) { producerOffset = i; break; }
                    }
                    if (producerOffset < 0) continue;
                    const producer = operations[producerOffset];
                    if (!isCopyOperation(producer) || !String(producer.emittedText || "").trim().startsWith("local ")) continue;
                    const producerExpression = parsePreCfRhs(producer.rhs);
                    if (!isLiteralOnlyPreCfScalarExpression(producerExpression)) continue;
                    let blocked = false;
                    for (let i = producerOffset + 1; i < tableOffset; i++) {
                        const op = operations[i];
                        if ((op.reads || []).includes(name) || operationWrites(op).includes(name)) { blocked = true; break; }
                    }
                    if (blocked) continue;
                    if (!operationWrites(tableOp).includes(name)) {
                        let killed = false;
                        for (let i = tableOffset + 1; i < operations.length; i++) {
                            const op = operations[i];
                            if ((op.reads || []).includes(name)) { blocked = true; break; }
                            if (operationWrites(op).includes(name)) { killed = true; break; }
                        }
                        if (blocked || (!killed && (state.successors || []).length !== 0)) continue;
                    }
                    replacements.push({
                        name,
                        producer,
                        producerOffset,
                        start: use.range[0] - tableExpression.range[0],
                        end: use.range[1] - tableExpression.range[0],
                        replacement: producer.rhs,
                    });
                    producers.add(producer);
                }
                if (!replacements.length) continue;
                let rhs = tableOp.rhs;
                for (const edit of [...replacements].sort((a, b) => b.start - a.start)) rhs = rhs.slice(0, edit.start) + edit.replacement + rhs.slice(edit.end);
                const prefix = String(tableOp.emittedText || "").trim().startsWith("local ") ? "local " : "";
                const emittedText = `${prefix}${tableOp.emittedTarget} = ${rhs}`;
                candidate = { state, tableOp, tableOffset, replacements, producers, rhs, emittedText };
                break;
            }
            if (candidate) break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) { betaResult.preCfTableEntryTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds }; return betaResult; }
        const tableRange = ownership.ranges.get(candidate.tableOp);
        const producerRanges = [...candidate.producers].map(op => ownership.ranges.get(op));
        if (!tableRange || producerRanges.some(range => !range)) {
            betaResult.preCfTableEntryTemps = { applied: folds > 0, safe: false, reason: "PRE-CF table entry recovery lost exact source ownership", folds };
            return betaResult;
        }
        const edits = [
            { start: tableRange[0], end: tableRange[1], replacement: candidate.emittedText },
            ...producerRanges.map(range => ({ start: range[0], end: range[1], replacement: "" })),
        ];
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfTableEntryTemps = { applied: folds > 0, safe: false, reason: `PRE-CF table entry recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        candidate.tableOp.rhs = candidate.rhs;
        const removedNames = new Set(candidate.replacements.map(item => item.name));
        candidate.tableOp.reads = (candidate.tableOp.reads || []).filter(name => !removedNames.has(name));
        candidate.tableOp.emittedText = candidate.emittedText;
        candidate.state.operations = candidate.state.operations.filter(op => !candidate.producers.has(op));
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds += candidate.replacements.length;
    }
    betaResult.preCfTableEntryTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}

function finalizePreCfDiscardedCallResults(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfDiscardedCallResults = { applied: false, safe: false, reason: "PRE-CF discarded call-result recovery requires a complete beta graph" };
        return betaResult;
    }
    const proof = buildPreCfTempProofIndex(betaResult);
    if (!proof.safe) {
        betaResult.preCfDiscardedCallResults = { applied: false, safe: false, reason: proof.reason || "PRE-CF discarded call-result proof failed" };
        return betaResult;
    }
    const candidates = [];
    for (const facts of proof.byBinding.values()) {
        if (!facts.singleDefinition || facts.readCount !== 0 || facts.captured) continue;
        const producer = facts.producer?.operation;
        if (!isCompilerCallResultOperation(producer, betaResult.graph)) continue;
        const expression = parsePreCfRhs(producer.rhs);
        if (expression?.type !== "CallExpression") continue;
        candidates.push({ facts, producer });
    }
    if (!candidates.length) {
        betaResult.preCfDiscardedCallResults = { applied: false, safe: true, folds: 0 };
        return betaResult;
    }
    const ownership = mapPreCfOperationRanges(betaResult);
    if (!ownership.safe) {
        betaResult.preCfDiscardedCallResults = { applied: false, safe: false, reason: ownership.reason, folds: 0 };
        return betaResult;
    }
    const edits = [];
    for (const candidate of candidates) {
        const range = ownership.ranges.get(candidate.producer);
        if (!range) {
            betaResult.preCfDiscardedCallResults = { applied: false, safe: false, reason: "PRE-CF discarded call-result recovery lost exact source ownership", folds: 0 };
            return betaResult;
        }
        edits.push({ start: range[0], end: range[1], replacement: candidate.producer.rhs });
    }
    const output = applySourceEdits(betaResult.source, edits);
    try { parsePreCfSource(output); }
    catch (error) {
        betaResult.preCfDiscardedCallResults = { applied: false, safe: false, reason: `PRE-CF discarded call-result recovery reparse failed: ${error.message}`, folds: 0 };
        return betaResult;
    }
    betaResult.source = output;
    for (const candidate of candidates) {
        candidate.producer.kind = "effect-call";
        candidate.producer.emittedTarget = null;
        candidate.producer.originalTarget = null;
        candidate.producer.registerEpoch = null;
        candidate.producer.emittedText = candidate.producer.rhs;
        candidate.producer.returnSinkSafe = false;
    }
    betaResult.preCfDiscardedCallResults = { applied: true, safe: true, folds: candidates.length };
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
    let parseRounds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        const candidates = [];
        const claimed = new Set();
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (claimed.has(producer) || claimed.has(consumer)) continue;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            const expression = parsePreCfRhs(producer.rhs);
            if (!expression || expression.type === "Identifier" || !isSafePreCfScalarExpression(expression)) continue;
            candidates.push({ facts, producer, consumer });
            claimed.add(producer); claimed.add(consumer);
        }
        if (!candidates.length) break;
        const ownership = mapPreCfOperationRanges(betaResult); parseRounds++;
        if (!ownership.safe) {
            betaResult.preCfScalarTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds, parseRounds };
            return betaResult;
        }
        const edits = [];
        const accepted = [];
        for (const candidate of candidates) {
            const producerRange = ownership.ranges.get(candidate.producer);
            const consumerRange = ownership.ranges.get(candidate.consumer);
            if (!producerRange || !consumerRange) {
                betaResult.preCfScalarTemps = { applied: folds > 0, safe: false, reason: "PRE-CF scalar recovery lost exact source ownership", folds, parseRounds };
                return betaResult;
            }
            const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
            candidate.emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.producer.rhs}`;
            edits.push({ start: producerRange[0], end: producerRange[1], replacement: "" }, { start: consumerRange[0], end: consumerRange[1], replacement: candidate.emittedText });
            accepted.push(candidate);
        }
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); parseRounds++; }
        catch (error) {
            betaResult.preCfScalarTemps = { applied: folds > 0, safe: false, reason: `PRE-CF scalar recovery reparse failed: ${error.message}`, folds, parseRounds };
            return betaResult;
        }
        betaResult.source = output;
        const byState = new Map();
        for (const candidate of accepted) {
            candidate.consumer.rhs = candidate.producer.rhs;
            candidate.consumer.reads = [...(candidate.producer.reads || [])];
            candidate.consumer.emittedText = candidate.emittedText;
            if (!byState.has(candidate.facts.producer.stateId)) byState.set(candidate.facts.producer.stateId, []);
            byState.get(candidate.facts.producer.stateId).push(candidate.facts.producer.offset);
        }
        for (const [stateId, offsets] of byState) {
            const state = betaResult.graph.states.find(item => item.id === stateId);
            for (const offset of offsets.sort((a,b)=>b-a)) state.operations.splice(offset, 1);
            for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        }
        folds += accepted.length;
    }
    betaResult.preCfScalarTemps = { applied: folds > 0, safe: true, folds, parseRounds };
    return betaResult;
}
const LUA_KEYWORDS = new Set(["and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while","continue"]);
function isValidGlobalIdentifierName(name) {
    return /^[A-Za-z_][A-Za-z0-9_]*$/.test(String(name || "")) && !LUA_KEYWORDS.has(String(name));
}
function parseScopedPreCfSource(source) {
    return luaparse.parse(source, { luaVersion: "luau", comments: false, scope: true, locations: false, ranges: true });
}
function stringLiteralIdentifierValue(node) {
    if (node?.type !== "StringLiteral") return null;
    if (typeof node.value === "string") return node.value;
    const raw = String(node.raw || "");
    const match = raw.match(/^(["\'])([A-Za-z_][A-Za-z0-9_]*)\1$/);
    return match ? match[2] : null;
}
function hasEnvironmentShadowBinding(environment, expectedName = "_env") {
    let shadowed = false;
    function walk(node) {
        if (shadowed || !isAstNode(node)) return;
        if (node.type === "LocalStatement") {
            for (const variable of node.variables || []) {
                if (variable?.type === "Identifier" && variable.name === expectedName && variable !== environment.parameter) { shadowed = true; return; }
            }
        } else if (node.type === "FunctionDeclaration") {
            if (node.isLocal && node.identifier?.type === "Identifier" && node.identifier.name === expectedName) { shadowed = true; return; }
            for (const parameter of node.parameters || []) {
                if (parameter?.type === "Identifier" && parameter.name === expectedName && parameter !== environment.parameter) { shadowed = true; return; }
            }
        } else if (node.type === "ForNumericStatement") {
            if (node.variable?.type === "Identifier" && node.variable.name === expectedName) { shadowed = true; return; }
        } else if (node.type === "ForGenericStatement") {
            for (const variable of node.variables || []) {
                if (variable?.type === "Identifier" && variable.name === expectedName) { shadowed = true; return; }
            }
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) for (const child of value) walk(child);
            else if (isAstNode(value)) walk(value);
            if (shadowed) return;
        }
    }
    walk(environment.functionNode);
    return shadowed;
}
function globalLookupInfo(operation) {
    const expression = parsePreCfRhs(operation?.rhs);
    if (!expression) return null;
    if (expression.type === "MemberExpression" && expression.base?.type === "Identifier" && expression.base.name === "_env" && expression.identifier?.type === "Identifier") {
        return { globalName: expression.identifier.name, keyBinding: null };
    }
    if (expression.type !== "IndexExpression" || expression.base?.type !== "Identifier" || expression.base.name !== "_env") return null;
    if (expression.index?.type === "StringLiteral") return { globalName: stringLiteralIdentifierValue(expression.index), keyBinding: null };
    if (expression.index?.type === "Identifier") return { globalName: null, keyBinding: expression.index.name };
    return null;
}
function finalizePreCfGlobalLookups(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfGlobalLookups = { applied: false, safe: false, reason: "PRE-CF global lookup recovery requires a complete beta graph" };
        return betaResult;
    }
    let scopedAst;
    try { scopedAst = parseScopedPreCfSource(betaResult.source); }
    catch (error) {
        betaResult.preCfGlobalLookups = { applied: false, safe: false, reason: `PRE-CF global lookup source parse failed: ${error.message}` };
        return betaResult;
    }
    const environment = proveEnvironmentBinding(scopedAst, "_env");
    if (!environment.proven) {
        betaResult.preCfGlobalLookups = { applied: false, safe: true, folds: 0, keyTempsRemoved: 0, refused: 0, environmentProven: false };
        return betaResult;
    }
    if (hasEnvironmentShadowBinding(environment, "_env")) {
        betaResult.preCfGlobalLookups = { applied: false, safe: true, folds: 0, keyTempsRemoved: 0, refused: 0, environmentProven: true, environmentShadowed: true, sourceKind: environment.sourceKind };
        return betaResult;
    }
    const proof = buildPreCfTempProofIndex(betaResult);
    const ownership = mapPreCfOperationRanges(betaResult);
    if (!ownership.safe) {
        betaResult.preCfGlobalLookups = { applied: false, safe: false, reason: ownership.reason };
        return betaResult;
    }
    const candidates = [];
    const claimed = new Set();
    let refused = 0;
    for (const state of betaResult.graph.states || []) {
        for (let offset = 0; offset < (state.operations || []).length; offset++) {
            const operation = state.operations[offset];
            if (!operation || !["version-define","epoch-start","epoch-mutate"].includes(operation.kind) || !operation.emittedTarget) continue;
            const info = globalLookupInfo(operation);
            if (!info) continue;
            let globalName = info.globalName;
            let keyProducer = null;
            let keyFacts = null;
            if (info.keyBinding) {
                keyFacts = proof.byBinding.get(info.keyBinding);
                if (!keyFacts?.cfgComplete || !keyFacts.singleDefinition || !keyFacts.singleUse || keyFacts.captured || !keyFacts.sameState || keyFacts.producer.offset >= keyFacts.consumer.offset) { refused++; continue; }
                keyProducer = keyFacts.producer.operation;
                const keyName = luaStringLiteralValue(keyProducer?.rhs);
                if (!keyProducer || !["version-define","epoch-start"].includes(keyProducer.kind) || !keyName) { refused++; continue; }
                globalName = keyName;
            }
            if (!isValidGlobalIdentifierName(globalName)) { refused++; continue; }
            if (claimed.has(operation) || (keyProducer && claimed.has(keyProducer))) continue;
            const opRange = ownership.ranges.get(operation);
            const keyRange = keyProducer ? ownership.ranges.get(keyProducer) : null;
            if (!opRange || (keyProducer && !keyRange)) {
                betaResult.preCfGlobalLookups = { applied: false, safe: false, reason: "PRE-CF global lookup recovery lost exact source ownership" };
                return betaResult;
            }
            const prefix = String(operation.emittedText || "").trim().startsWith("local ") ? "local " : "";
            candidates.push({ state, operation, offset, globalName, keyProducer, keyFacts, opRange, keyRange, emittedText: `${prefix}${operation.emittedTarget} = ${globalName}` });
            claimed.add(operation);
            if (keyProducer) claimed.add(keyProducer);
        }
    }
    if (!candidates.length) {
        betaResult.preCfGlobalLookups = { applied: false, safe: true, folds: 0, keyTempsRemoved: 0, refused, environmentProven: true, sourceKind: environment.sourceKind };
        return betaResult;
    }
    const edits = [];
    for (const candidate of candidates) {
        if (candidate.keyRange) edits.push({ start: candidate.keyRange[0], end: candidate.keyRange[1], replacement: "" });
        edits.push({ start: candidate.opRange[0], end: candidate.opRange[1], replacement: candidate.emittedText });
    }
    const output = applySourceEdits(betaResult.source, edits);
    try { parsePreCfSource(output); }
    catch (error) {
        betaResult.preCfGlobalLookups = { applied: false, safe: false, reason: `PRE-CF global lookup recovery reparse failed: ${error.message}` };
        return betaResult;
    }
    betaResult.source = output;
    const removalsByState = new Map();
    let keyTempsRemoved = 0;
    for (const candidate of candidates) {
        candidate.operation.rhs = candidate.globalName;
        candidate.operation.reads = (candidate.operation.reads || []).filter(name => name !== "_env" && name !== candidate.keyFacts?.name);
        candidate.operation.emittedText = candidate.emittedText;
        if (candidate.keyProducer) {
            const location = proof.locations.get(candidate.keyProducer);
            if (location) {
                if (!removalsByState.has(location.stateId)) removalsByState.set(location.stateId, []);
                removalsByState.get(location.stateId).push(location.offset);
                keyTempsRemoved++;
            }
        }
    }
    for (const [stateId, offsets] of removalsByState) {
        const state = betaResult.graph.states.find(item => item.id === stateId);
        for (const offset of [...new Set(offsets)].sort((a,b)=>b-a)) state.operations.splice(offset, 1);
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
    }
    betaResult.preCfGlobalLookups = { applied: true, safe: true, folds: candidates.length, keyTempsRemoved, refused, environmentProven: true, sourceKind: environment.sourceKind };
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
    let parseRounds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        const candidates = [];
        const claimed = new Set();
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (claimed.has(producer) || claimed.has(consumer)) continue;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || consumer.rhs !== facts.name) continue;
            const expression = parsePreCfRhs(producer.rhs);
            if (!isStaticLookupExpression(expression)) continue;
            candidates.push({ facts, producer, consumer });
            claimed.add(producer); claimed.add(consumer);
        }
        if (!candidates.length) break;
        const ownership = mapPreCfOperationRanges(betaResult); parseRounds++;
        if (!ownership.safe) {
            betaResult.preCfLookupTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds, parseRounds };
            return betaResult;
        }
        const edits = [];
        const accepted = [];
        for (const candidate of candidates) {
            const producerRange = ownership.ranges.get(candidate.producer);
            const consumerRange = ownership.ranges.get(candidate.consumer);
            if (!producerRange || !consumerRange) {
                betaResult.preCfLookupTemps = { applied: folds > 0, safe: false, reason: "PRE-CF lookup recovery lost exact source ownership", folds, parseRounds };
                return betaResult;
            }
            const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
            candidate.emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.producer.rhs}`;
            edits.push({ start: producerRange[0], end: producerRange[1], replacement: "" }, { start: consumerRange[0], end: consumerRange[1], replacement: candidate.emittedText });
            accepted.push(candidate);
        }
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); parseRounds++; }
        catch (error) {
            betaResult.preCfLookupTemps = { applied: folds > 0, safe: false, reason: `PRE-CF lookup recovery reparse failed: ${error.message}`, folds, parseRounds };
            return betaResult;
        }
        betaResult.source = output;
        const byState = new Map();
        for (const candidate of accepted) {
            candidate.consumer.rhs = candidate.producer.rhs;
            candidate.consumer.reads = [...(candidate.producer.reads || [])];
            candidate.consumer.emittedText = candidate.emittedText;
            if (!byState.has(candidate.facts.producer.stateId)) byState.set(candidate.facts.producer.stateId, []);
            byState.get(candidate.facts.producer.stateId).push(candidate.facts.producer.offset);
        }
        for (const [stateId, offsets] of byState) {
            const state = betaResult.graph.states.find(item => item.id === stateId);
            for (const offset of offsets.sort((a,b)=>b-a)) state.operations.splice(offset, 1);
            for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        }
        folds += accepted.length;
    }
    betaResult.preCfLookupTemps = { applied: folds > 0, safe: true, folds, parseRounds };
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

function isPreCfClosureFactoryCall(expression, graph) {
    if (expression?.type !== "CallExpression" || expression.base?.type !== "Identifier") return false;
    if (!/^createClosure(?:\d+)?$/.test(expression.base.name)) return false;
    const entry = numericLiteralValue((expression.arguments || [])[0]);
    return Number.isInteger(entry) && new Set(graph?.entries || []).has(entry);
}

function isMovableCallArgumentScalarExpression(node) {
    if (!node) return false;
    if (["NumericLiteral", "StringLiteral", "BooleanLiteral", "NilLiteral"].includes(node.type)) return true;
    if (node.type === "UnaryExpression") return isMovableCallArgumentScalarExpression(node.argument);
    if (node.type === "BinaryExpression") {
        return isMovableCallArgumentScalarExpression(node.left) && isMovableCallArgumentScalarExpression(node.right);
    }
    return false;
}

function rewriteDirectCallArguments(rhs, replacements) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "CallExpression" || expression.base?.type !== "Identifier") return null;
    const edits = [];
    const consumed = [];
    const prefixLength = "return ".length;
    for (const arg of expression.arguments || []) {
        if (arg?.type !== "Identifier" || !replacements.has(arg.name)) continue;
        if (collectIdentifierCount(expression, arg.name) !== 1 || !Array.isArray(arg.range)) return null;
        const start = arg.range[0] - prefixLength;
        const end = arg.range[1] - prefixLength;
        if (start < 0 || end < start || rhs.slice(start, end) !== arg.name) return null;
        edits.push({ start, end, replacement: replacements.get(arg.name) });
        consumed.push(arg.name);
    }
    if (!consumed.length) return null;
    let rewritten = rhs;
    for (const edit of edits.sort((a, b) => b.start - a.start)) {
        rewritten = rewritten.slice(0, edit.start) + edit.replacement + rewritten.slice(edit.end);
    }
    return { rhs: rewritten, baseName: expression.base.name, consumed };
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
            if (producerExpr?.type !== "CallExpression" || isPreCfClosureFactoryCall(producerExpr, betaResult.graph)) continue;
            const rewritten = rewriteDirectCallArgument(consumer.rhs, facts.name, `(${producer.rhs})`);
            if (!rewritten) continue;
            if (!Array.isArray(consumer.reads) || !consumer.reads.includes(rewritten.baseName)) continue;
            candidate = { consumer, producerItems: [{ facts, producer }], rewritten };
            break;
        }

        if (!candidate) {
            for (const state of betaResult.graph.states || []) {
                const operations = state.operations || [];
                for (let consumerOffset = 0; consumerOffset < operations.length; consumerOffset++) {
                    const consumer = operations[consumerOffset];
                    if (!isCopyOperation(consumer)) continue;
                    const consumerExpr = parsePreCfRhs(consumer.rhs);
                    if (consumerExpr?.type !== "CallExpression" || consumerExpr.base?.type !== "Identifier") continue;
                    if (!Array.isArray(consumer.reads) || !consumer.reads.includes(consumerExpr.base.name)) continue;

                    const replacements = new Map();
                    const producerItems = [];
                    for (let producerOffset = consumerOffset - 1; producerOffset >= 0; producerOffset--) {
                        const producer = operations[producerOffset];
                        if (!isCopyOperation(producer)) break;
                        const facts = proof.byBinding.get(producer.emittedTarget);
                        if (!facts || !facts.safeSameStateTransport) break;
                        if (facts.producer.operation !== producer || facts.consumer.operation !== consumer) break;
                        const producerExpr = parsePreCfRhs(producer.rhs);
                        if (!isMovableCallArgumentScalarExpression(producerExpr)) break;
                        replacements.set(facts.name, producer.rhs);
                        producerItems.push({ facts, producer });
                    }
                    if (!producerItems.length) continue;
                    const rewritten = rewriteDirectCallArguments(consumer.rhs, replacements);
                    if (!rewritten || rewritten.consumed.length !== producerItems.length) continue;
                    candidate = { consumer, producerItems, rewritten };
                    break;
                }
                if (candidate) break;
            }
        }

        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const producerRanges = candidate.producerItems.map(item => ownership.ranges.get(item.producer));
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (producerRanges.some(range => !range) || !consumerRange) {
            betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: false, reason: "PRE-CF call-argument recovery lost exact source ownership", folds };
            return betaResult;
        }
        const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
        const emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.rewritten.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            ...producerRanges.map(range => ({ start: range[0], end: range[1], replacement: "" })),
            { start: consumerRange[0], end: consumerRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfCallArgumentTemps = { applied: folds > 0, safe: false, reason: `PRE-CF call-argument recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const stateId = candidate.producerItems[0].facts.producer.stateId;
        const state = betaResult.graph.states.find(item => item.id === stateId);
        const removedNames = new Set(candidate.producerItems.map(item => item.facts.name));
        const addedReads = candidate.producerItems.flatMap(item => item.producer.reads || []);
        candidate.consumer.rhs = candidate.rewritten.rhs;
        candidate.consumer.reads = [...new Set([...(candidate.consumer.reads || []).filter(name => !removedNames.has(name)), ...addedReads])];
        candidate.consumer.emittedText = emittedText;
        for (const offset of candidate.producerItems.map(item => item.facts.producer.offset).sort((a, b) => b - a)) {
            state.operations.splice(offset, 1);
        }
        for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        folds += candidate.producerItems.length;
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
    let parseRounds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        const candidates = [];
        const claimed = new Set();
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const consumer = facts.consumer.operation;
            if (claimed.has(producer) || claimed.has(consumer)) continue;
            if (!isCopyOperation(producer) || !isCopyOperation(consumer) || !isSafeCallBaseProducer(producer)) continue;
            const rewrittenRhs = rewriteDirectCallBase(consumer.rhs, facts.name, producer.rhs);
            if (!rewrittenRhs) continue;
            candidates.push({ facts, producer, consumer, rewrittenRhs });
            claimed.add(producer); claimed.add(consumer);
        }
        if (!candidates.length) break;
        const ownership = mapPreCfOperationRanges(betaResult); parseRounds++;
        if (!ownership.safe) {
            betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds, parseRounds };
            return betaResult;
        }
        const edits = [];
        const accepted = [];
        for (const candidate of candidates) {
            const producerRange = ownership.ranges.get(candidate.producer);
            const consumerRange = ownership.ranges.get(candidate.consumer);
            if (!producerRange || !consumerRange) {
                betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: false, reason: "PRE-CF call-base recovery lost exact source ownership", folds, parseRounds };
                return betaResult;
            }
            const prefix = String(candidate.consumer.emittedText || "").trim().startsWith("local ") ? "local " : "";
            candidate.emittedText = `${prefix}${candidate.consumer.emittedTarget} = ${candidate.rewrittenRhs}`;
            edits.push({ start: producerRange[0], end: producerRange[1], replacement: "" }, { start: consumerRange[0], end: consumerRange[1], replacement: candidate.emittedText });
            accepted.push(candidate);
        }
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); parseRounds++; }
        catch (error) {
            betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: false, reason: `PRE-CF call-base recovery reparse failed: ${error.message}`, folds, parseRounds };
            return betaResult;
        }
        betaResult.source = output;
        const byState = new Map();
        for (const candidate of accepted) {
            candidate.consumer.rhs = candidate.rewrittenRhs;
            candidate.consumer.reads = [...new Set([...(candidate.consumer.reads || []).filter(name => name !== candidate.facts.name), ...(candidate.producer.reads || [])])];
            candidate.consumer.emittedText = candidate.emittedText;
            if (!byState.has(candidate.facts.producer.stateId)) byState.set(candidate.facts.producer.stateId, []);
            byState.get(candidate.facts.producer.stateId).push(candidate.facts.producer.offset);
        }
        for (const [stateId, offsets] of byState) {
            const state = betaResult.graph.states.find(item => item.id === stateId);
            for (const offset of offsets.sort((a,b)=>b-a)) state.operations.splice(offset, 1);
            for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        }
        folds += accepted.length;
    }
    betaResult.preCfCallBaseTemps = { applied: folds > 0, safe: true, folds, parseRounds };
    return betaResult;
}


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
    let parseRounds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        const candidates = [];
        const claimed = new Set();
        for (const state of betaResult.graph.states || []) {
            for (let offset = 0; offset + 2 < (state.operations || []).length; offset++) {
                const match = matchNamecallTriple(state, offset, proof);
                if (!match) continue;
                if (claimed.has(match.keyOp) || claimed.has(match.methodOp) || claimed.has(match.callOp)) continue;
                candidates.push({ state, offset, ...match });
                claimed.add(match.keyOp); claimed.add(match.methodOp); claimed.add(match.callOp);
                offset += 2;
            }
        }
        if (!candidates.length) break;
        const ownership = mapPreCfOperationRanges(betaResult); parseRounds++;
        if (!ownership.safe) {
            betaResult.preCfNamecalls = { applied: folds > 0, safe: false, reason: ownership.reason, folds, parseRounds };
            return betaResult;
        }
        const edits = [];
        for (const candidate of candidates) {
            const keyRange = ownership.ranges.get(candidate.keyOp);
            const methodRange = ownership.ranges.get(candidate.methodOp);
            const callRange = ownership.ranges.get(candidate.callOp);
            if (!keyRange || !methodRange || !callRange) {
                betaResult.preCfNamecalls = { applied: folds > 0, safe: false, reason: "PRE-CF namecall recovery lost exact source ownership", folds, parseRounds };
                return betaResult;
            }
            const prefix = String(candidate.callOp.emittedText || "").trim().startsWith("local ") ? "local " : "";
            candidate.emittedText = `${prefix}${candidate.callOp.emittedTarget} = ${candidate.rhs}`;
            edits.push({ start: keyRange[0], end: keyRange[1], replacement: "" }, { start: methodRange[0], end: methodRange[1], replacement: "" }, { start: callRange[0], end: callRange[1], replacement: candidate.emittedText });
        }
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); parseRounds++; }
        catch (error) {
            betaResult.preCfNamecalls = { applied: folds > 0, safe: false, reason: `PRE-CF namecall recovery reparse failed: ${error.message}`, folds, parseRounds };
            return betaResult;
        }
        betaResult.source = output;
        const byState = new Map();
        for (const candidate of candidates) {
            candidate.callOp.rhs = candidate.rhs;
            candidate.callOp.reads = [...new Set((candidate.callOp.reads || []).filter(name => name !== candidate.keyName && name !== candidate.methodNameBinding))];
            candidate.callOp.emittedText = candidate.emittedText;
            if (!byState.has(candidate.state.id)) byState.set(candidate.state.id, []);
            byState.get(candidate.state.id).push(candidate.offset);
        }
        for (const [stateId, offsets] of byState) {
            const state = betaResult.graph.states.find(item => item.id === stateId);
            for (const offset of offsets.sort((a,b)=>b-a)) state.operations.splice(offset, 2);
            for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        }
        folds += candidates.length;
    }
    betaResult.preCfNamecalls = { applied: folds > 0, safe: true, folds, parseRounds };
    return betaResult;
}
function renderReturnTransportExpression(producer, graph) {
    const expression = parsePreCfRhs(producer?.rhs);
    if (!expression) return null;
    if (expression.type === "CallExpression") {
        if (isPreCfClosureFactoryCall(expression, graph)) return null;
        return `(${producer.rhs})`;
    }
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
    let parseRounds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        const candidates = [];
        const claimed = new Set();
        for (const facts of proof.byBinding.values()) {
            if (!facts.safeSameStateTransport || !facts.adjacent) continue;
            const producer = facts.producer.operation;
            const payload = facts.consumer.operation;
            if (claimed.has(producer) || claimed.has(payload)) continue;
            if (!isCopyOperation(producer) || payload?.kind !== "return-payload" || payload.terminalCompilerReturnPayload !== true) continue;
            if (!Array.isArray(payload.returnExpressions) || payload.returnExpressions.length !== 1 || payload.returnExpressions[0] !== facts.name) continue;
            if (!Array.isArray(payload.reads) || payload.reads.length !== 1 || payload.reads[0] !== facts.name) continue;
            const replacement = renderReturnTransportExpression(producer, betaResult.graph);
            if (!replacement) continue;
            candidates.push({ facts, producer, payload, replacement });
            claimed.add(producer); claimed.add(payload);
        }
        if (!candidates.length) break;
        const ownership = mapPreCfOperationRanges(betaResult); parseRounds++;
        if (!ownership.safe) {
            betaResult.preCfReturnTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds, parseRounds };
            return betaResult;
        }
        const edits = [];
        for (const candidate of candidates) {
            const producerRange = ownership.ranges.get(candidate.producer);
            const payloadRange = ownership.ranges.get(candidate.payload);
            if (!producerRange || !payloadRange) {
                betaResult.preCfReturnTemps = { applied: folds > 0, safe: false, reason: "PRE-CF return recovery lost exact source ownership", folds, parseRounds };
                return betaResult;
            }
            candidate.emittedText = `${candidate.payload.emittedTarget || betaResult.graph.returnName || "ReturnVal"} = { ${candidate.replacement} }`;
            edits.push({ start: producerRange[0], end: producerRange[1], replacement: "" }, { start: payloadRange[0], end: payloadRange[1], replacement: candidate.emittedText });
        }
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); parseRounds++; }
        catch (error) {
            betaResult.preCfReturnTemps = { applied: folds > 0, safe: false, reason: `PRE-CF return recovery reparse failed: ${error.message}`, folds, parseRounds };
            return betaResult;
        }
        betaResult.source = output;
        const byState = new Map();
        for (const candidate of candidates) {
            candidate.payload.rhs = `{ ${candidate.replacement} }`;
            candidate.payload.returnExpressions = [candidate.replacement];
            candidate.payload.reads = [...new Set(candidate.producer.reads || [])];
            candidate.payload.emittedText = candidate.emittedText;
            if (!byState.has(candidate.facts.producer.stateId)) byState.set(candidate.facts.producer.stateId, []);
            byState.get(candidate.facts.producer.stateId).push(candidate.facts.producer.offset);
        }
        for (const [stateId, offsets] of byState) {
            const state = betaResult.graph.states.find(item => item.id === stateId);
            for (const offset of offsets.sort((a,b)=>b-a)) state.operations.splice(offset, 1);
            for (let i = 0; i < state.operations.length; i++) state.operations[i].index = i + 1;
        }
        folds += candidates.length;
    }
    betaResult.preCfReturnTemps = { applied: folds > 0, safe: true, folds, parseRounds };
    return betaResult;
}
function parsePackedSingleCall(rhs) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "TableConstructorExpression" || expression.fields?.length !== 1) return null;
    const field = expression.fields[0];
    if (field?.type !== "TableValue" || field.value?.type !== "CallExpression") return null;
    return sourceForExpressionNode(rhs, field.value);
}

function rewriteReturnAllFinalCallArgument(rhs, packName, replacement) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "CallExpression" || expression.base?.type !== "Identifier") return null;
    if (collectIdentifierCount(expression, packName) !== 1) return null;
    const args = expression.arguments || [];
    if (!args.length) return null;
    const tail = args[args.length - 1];
    if (tail?.type !== "CallExpression" || tail.base?.type !== "Identifier" || tail.base.name !== "unpack") return null;
    if ((tail.arguments || []).length !== 1 || tail.arguments[0]?.type !== "Identifier" || tail.arguments[0].name !== packName) return null;
    if (!Array.isArray(tail.range)) return null;
    const prefixLength = "return ".length;
    const start = tail.range[0] - prefixLength;
    const end = tail.range[1] - prefixLength;
    if (start < 0 || end < start) return null;
    return {
        rhs: rhs.slice(0, start) + replacement + rhs.slice(end),
        baseName: expression.base.name,
    };
}

function isExactReturnAllUnpackExpression(expression, packName) {
    return expression?.type === "CallExpression" &&
        expression.base?.type === "Identifier" && expression.base.name === "unpack" &&
        (expression.arguments || []).length === 1 &&
        expression.arguments[0]?.type === "Identifier" && expression.arguments[0].name === packName;
}

function rewriteReturnAllReturnPayload(payload, packName, replacement) {
    if (payload?.kind !== "return-payload" || payload.terminalCompilerReturnPayload !== true) return null;
    if (!Array.isArray(payload.returnExpressions) || payload.returnExpressions.length === 0) return null;
    if (!Array.isArray(payload.reads) || payload.reads.filter(name => name === packName).length !== 1) return null;
    const expressions = [...payload.returnExpressions];
    const tail = parsePreCfRhs(expressions[expressions.length - 1]);
    if (!isExactReturnAllUnpackExpression(tail, packName)) return null;
    for (let i = 0; i + 1 < expressions.length; i++) {
        const expression = parsePreCfRhs(expressions[i]);
        if (!expression || collectIdentifierCount(expression, packName) !== 0) return null;
    }
    expressions[expressions.length - 1] = replacement;
    return {
        returnExpressions: expressions,
        rhs: `{ ${expressions.join(", ")} }`,
    };
}

function finalizePreCfReturnAllTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfReturnAllTemps = { applied: false, safe: false, reason: "PRE-CF RETURN_ALL recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const state of betaResult.graph.states || []) {
            const ops = state.operations || [];
            for (let offset = 0; offset + 1 < ops.length; offset++) {
                const packOp = ops[offset];
                const consumer = ops[offset + 1];
                if (!isCopyOperation(packOp) || !packOp.emittedTarget) continue;
                const packName = packOp.emittedTarget;
                if (betaResult.graph.recoveredUpvalueBindings?.includes(packName)) continue;
                const packFacts = proof.byBinding.get(packName);
                if (!packFacts?.singleDefinition || packFacts.captured || packFacts.readCount !== 1 || packFacts.producer?.operation !== packOp || packFacts.consumer?.operation !== consumer) continue;
                if (!packFacts.safeSameStateTransport || !packFacts.adjacent) continue;
                const innerCall = parsePackedSingleCall(packOp.rhs);
                if (!innerCall) continue;
                let rewritten = null;
                let consumerKind = null;
                if (isCopyOperation(consumer) && consumer.emittedTarget) {
                    rewritten = rewriteReturnAllFinalCallArgument(consumer.rhs, packName, innerCall);
                    consumerKind = rewritten ? "call-argument" : null;
                } else if (consumer?.kind === "return-payload") {
                    rewritten = rewriteReturnAllReturnPayload(consumer, packName, innerCall);
                    consumerKind = rewritten ? "return-payload" : null;
                }
                if (!rewritten || !consumerKind) continue;
                candidate = { state, offset, packOp, consumer, packName, rewritten, consumerKind };
                break;
            }
            if (candidate) break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfReturnAllTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const packRange = ownership.ranges.get(candidate.packOp);
        const consumerRange = ownership.ranges.get(candidate.consumer);
        if (!packRange || !consumerRange) {
            betaResult.preCfReturnAllTemps = { applied: folds > 0, safe: false, reason: "PRE-CF RETURN_ALL recovery lost exact source ownership", folds };
            return betaResult;
        }
        const isLocal = String(candidate.consumer.emittedText || "").trim().startsWith("local ");
        const emittedText = candidate.consumerKind === "return-payload"
            ? `${candidate.consumer.emittedTarget || betaResult.graph.returnName || "ReturnVal"} = ${candidate.rewritten.rhs}`
            : `${isLocal ? "local " : ""}${candidate.consumer.emittedTarget} = ${candidate.rewritten.rhs}`;
        const output = applySourceEdits(betaResult.source, [
            { start: packRange[0], end: packRange[1], replacement: "" },
            { start: consumerRange[0], end: consumerRange[1], replacement: emittedText },
        ]);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfReturnAllTemps = { applied: folds > 0, safe: false, reason: `PRE-CF RETURN_ALL recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        candidate.consumer.rhs = candidate.rewritten.rhs;
        if (candidate.consumerKind === "return-payload") candidate.consumer.returnExpressions = candidate.rewritten.returnExpressions;
        candidate.consumer.emittedText = emittedText;
        const rewrittenExpression = parsePreCfRhs(candidate.rewritten.rhs);
        const stillReadsUnpack = collectIdentifierCount(rewrittenExpression, "unpack") > 0;
        candidate.consumer.reads = [...new Set([
            ...(candidate.consumer.reads || []).filter(name => name !== candidate.packName && (name !== "unpack" || stillReadsUnpack)),
            ...(candidate.packOp.reads || []),
        ])];
        candidate.state.operations.splice(candidate.offset, 1);
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfReturnAllTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}

function parseStaticPackSlot(rhs, packName) {
    const expression = parsePreCfRhs(rhs);
    if (expression?.type !== "IndexExpression" || expression.base?.type !== "Identifier" || expression.base.name !== packName) return null;
    const slot = numericLiteralValue(expression.index);
    return Number.isInteger(slot) && slot >= 1 ? slot : null;
}

function finalizePreCfMultiReturnTemps(betaResult) {
    if (!betaResult?.graph || typeof betaResult.source !== "string" || betaResult.graph.cfgComplete !== true) {
        betaResult.preCfMultiReturnTemps = { applied: false, safe: false, reason: "PRE-CF multi-return recovery requires a complete beta graph" };
        return betaResult;
    }
    let folds = 0;
    const maxRounds = (betaResult.graph.states || []).reduce((n, state) => n + (state.operations || []).length, 0) + 1;
    for (let round = 0; round < maxRounds; round++) {
        const proof = buildPreCfTempProofIndex(betaResult);
        let candidate = null;
        for (const state of betaResult.graph.states || []) {
            const ops = state.operations || [];
            for (let offset = 0; offset < ops.length; offset++) {
                const packOp = ops[offset];
                if (!isCopyOperation(packOp) || !packOp.emittedTarget) continue;
                if (betaResult.graph.recoveredUpvalueBindings?.includes(packOp.emittedTarget)) continue;
                const call = parsePackedSingleCall(packOp.rhs);
                if (!call) continue;
                const packName = packOp.emittedTarget;
                const packFacts = proof.byBinding.get(packName);
                if (!packFacts?.singleDefinition || packFacts.captured || packFacts.producer?.operation !== packOp || packFacts.readCount === 0) continue;

                const extracts = [];
                let invalidPackRead = false;
                for (const state2 of betaResult.graph.states || []) {
                    const ops2 = state2.operations || [];
                    for (let offset2 = 0; offset2 < ops2.length; offset2++) {
                        const op2 = ops2[offset2];
                        if (!(op2.reads || []).includes(packName)) continue;
                        if (state2 !== state || offset2 <= offset || !isCopyOperation(op2) || !op2.emittedTarget || !String(op2.emittedText || "").trim().startsWith("local ")) {
                            invalidPackRead = true;
                            break;
                        }
                        const slot = parseStaticPackSlot(op2.rhs, packName);
                        if (slot === null) {
                            invalidPackRead = true;
                            break;
                        }
                        extracts.push({ op: op2, slot, offset: offset2 });
                    }
                    if (invalidPackRead) break;
                }
                if (invalidPackRead || extracts.length !== packFacts.readCount || extracts.length === 0) continue;

                const slots = extracts.map(item => item.slot);
                const uniqueSlots = new Set(slots);
                if (uniqueSlots.size !== slots.length) continue;
                const sortedSlots = [...slots].sort((a, b) => a - b);
                if (sortedSlots.some((slot, index) => slot !== index + 1)) continue;
                if (extracts.some(item => {
                    const facts = proof.byBinding.get(item.op.emittedTarget);
                    return !facts?.singleDefinition || facts.producer?.operation !== item.op || facts.captured;
                })) continue;

                const targetNames = new Set(extracts.map(item => item.op.emittedTarget));
                const lastExtractOffset = Math.max(...extracts.map(item => item.offset));
                const extractOps = new Set(extracts.map(item => item.op));
                let targetVisibleTooEarly = false;
                for (let gapOffset = offset + 1; gapOffset <= lastExtractOffset; gapOffset++) {
                    const gapOp = ops[gapOffset];
                    if (extractOps.has(gapOp)) continue;
                    if ((gapOp.reads || []).some(name => targetNames.has(name)) || operationWrites(gapOp).some(name => targetNames.has(name))) {
                        targetVisibleTooEarly = true;
                        break;
                    }
                }
                if (targetVisibleTooEarly) continue;

                candidate = { state, offset, packOp, call, extracts };
                break;
            }
            if (candidate) break;
        }
        if (!candidate) break;
        const ownership = mapPreCfOperationRanges(betaResult);
        if (!ownership.safe) {
            betaResult.preCfMultiReturnTemps = { applied: folds > 0, safe: false, reason: ownership.reason, folds };
            return betaResult;
        }
        const packRange = ownership.ranges.get(candidate.packOp);
        const extractRanges = candidate.extracts.map(item => ownership.ranges.get(item.op));
        if (!packRange || extractRanges.some(range => !range)) {
            betaResult.preCfMultiReturnTemps = { applied: folds > 0, safe: false, reason: "PRE-CF multi-return recovery lost exact source ownership", folds };
            return betaResult;
        }
        const orderedExtracts = [...candidate.extracts].sort((a, b) => a.slot - b.slot);
        const targets = orderedExtracts.map(item => item.op.emittedTarget);
        const emittedText = `local ${targets.join(", ")} = ${candidate.call}`;
        const edits = [
            { start: packRange[0], end: packRange[1], replacement: emittedText },
            ...extractRanges.map(range => ({ start: range[0], end: range[1], replacement: "" })),
        ];
        const output = applySourceEdits(betaResult.source, edits);
        try { parsePreCfSource(output); }
        catch (error) {
            betaResult.preCfMultiReturnTemps = { applied: folds > 0, safe: false, reason: `PRE-CF multi-return recovery reparse failed: ${error.message}`, folds };
            return betaResult;
        }
        betaResult.source = output;
        const reads = [...new Set(candidate.packOp.reads || [])];
        const multiOp = {
            index: candidate.offset + 1,
            kind: "multi-call-write",
            emittedTargets: targets,
            targetDeclarations: targets.map(() => true),
            targetRegisterEpochs: orderedExtracts.map(item => item.op.registerEpoch || null),
            rhs: candidate.call,
            reads,
            emittedText,
            returnSinkSafe: false,
        };
        candidate.state.operations[candidate.offset] = multiOp;
        const extractOps = new Set(candidate.extracts.map(item => item.op));
        candidate.state.operations = candidate.state.operations.filter(operation => !extractOps.has(operation));
        for (let i = 0; i < candidate.state.operations.length; i++) candidate.state.operations[i].index = i + 1;
        folds++;
    }
    betaResult.preCfMultiReturnTemps = { applied: folds > 0, safe: true, folds };
    return betaResult;
}

function finalizePreCfTempRecovery(betaResult) {
    const stages = [
        finalizePreCfCopyTemps,
        finalizePreCfClosureTemps,
        finalizePreCfCallResultDestinations,
        finalizePreCfTableDestinations,
        finalizePreCfTableEntryTemps,
        finalizePreCfScalarTemps,
        finalizePreCfGlobalLookups,
        finalizePreCfLookupTemps,
        finalizePreCfCallArgumentTemps,
        finalizePreCfCallBaseTemps,
        finalizePreCfNamecalls,
        finalizePreCfDiscardedCallResults,
        finalizePreCfReturnTemps,
        finalizePreCfReturnAllTemps,
        finalizePreCfMultiReturnTemps,
    ];
    const stageNames = [];
    for (const stage of stages) {
        betaResult = stage(betaResult);
        const failedKey = Object.keys(betaResult).find(name => name.startsWith("preCf") && name !== "preCfTempRecovery" && betaResult[name]?.safe === false);
        if (failedKey) {
            betaResult.preCfTempRecovery = { applied: stageNames.length > 0, safe: false, failedStage: stage.name, reason: betaResult[failedKey]?.reason || "PRE-CF stage failed closed", stages: stageNames };
            return betaResult;
        }
        stageNames.push(stage.name);
    }
    const foldKeys = ["preCfCopyTemps", "preCfClosureTemps", "preCfCallResultDestinations", "preCfTableDestinations", "preCfTableEntryTemps", "preCfScalarTemps", "preCfGlobalLookups", "preCfLookupTemps", "preCfCallArgumentTemps", "preCfCallBaseTemps", "preCfNamecalls", "preCfDiscardedCallResults", "preCfReturnTemps", "preCfReturnAllTemps", "preCfMultiReturnTemps"];
    const folds = foldKeys.reduce((sum, key) => sum + Number(betaResult[key]?.folds || 0), 0);
    betaResult.preCfTempRecovery = { applied: folds > 0, safe: true, folds, stages: stageNames };
    return betaResult;
}
module.exports = {
    buildPreCfTempProofIndex,
    provePreCfTempUse,
    finalizePreCfCopyTemps,
    finalizePreCfClosureTemps,
    finalizePreCfCallResultDestinations,
    finalizePreCfTableDestinations,
    finalizePreCfTableEntryTemps,
    finalizePreCfScalarTemps,
    finalizePreCfGlobalLookups,
    finalizePreCfLookupTemps,
    finalizePreCfCallArgumentTemps,
    finalizePreCfCallBaseTemps,
    finalizePreCfNamecalls,
    finalizePreCfDiscardedCallResults,
    finalizePreCfReturnTemps,
    finalizePreCfReturnAllTemps,
    finalizePreCfMultiReturnTemps,
    finalizePreCfTempRecovery,
};
