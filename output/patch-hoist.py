from pathlib import Path
p=Path(r'passes/beta-control-flow.js')
s=p.read_text(encoding='utf-8')
anchor='''function validateStructuredLocalScopes(nodes) {
'''
if anchor not in s: raise SystemExit('validator anchor missing')
fn=r'''function hoistEscapingEpochDeclarations(nodes) {
    let nextScopeId = 1;
    const scopes = new Map([[0, { id: 0, parentId: null, insertionBody: nodes }]]);
    const rawLocations = new Map();
    const loopVariables = new Set();

    function childScope(parentId, insertionBody) {
        const id = nextScopeId++;
        scopes.set(id, { id, parentId, insertionBody });
        return id;
    }

    function indexStructure(body, scopeId) {
        for (const node of body || []) {
            if (node.type === "raw") {
                rawLocations.set(node, { scopeId, body });
                continue;
            }
            if (node.type === "numeric-for") {
                loopVariables.add(node.variable);
                indexStructure(node.body, childScope(scopeId, node.body));
                continue;
            }
            if (node.type === "generic-for") {
                for (const variable of node.variables || []) loopVariables.add(variable);
                indexStructure(node.body, childScope(scopeId, node.body));
                continue;
            }
            if (node.type === "while-guard") {
                const scope = childScope(scopeId, node.conditionBody);
                indexStructure(node.conditionBody, scope);
                indexStructure(node.body, scope);
                continue;
            }
            if (node.type === "repeat-until") {
                const scope = childScope(scopeId, node.body);
                indexStructure(node.body, scope);
                indexStructure(node.conditionBody, scope);
                continue;
            }
            if (node.type === "if") {
                indexStructure(node.thenBody, childScope(scopeId, node.thenBody));
                if (node.elseBody) indexStructure(node.elseBody, childScope(scopeId, node.elseBody));
            }
        }
    }
    indexStructure(nodes, 0);

    const candidates = new Map();
    for (const [node, location] of rawLocations) {
        const operation = node.operation || {};
        const name = operation.emittedTarget;
        if (!name || operation.kind !== "epoch-start" || !operation.registerEpoch) continue;
        if (!String(node.text || "").trimStart().startsWith("local ")) continue;
        if (candidates.has(name)) {
            candidates.get(name).invalid = true;
            continue;
        }
        candidates.set(name, {
            name,
            epoch: operation.registerEpoch,
            declarationNode: node,
            declarationScopeId: location.scopeId,
            occurrenceScopes: new Set(),
            invalid: loopVariables.has(name),
        });
    }
    if (!candidates.size) return { applied: false, safe: true, count: 0 };

    function recordReads(reads, scopeId) {
        for (const name of reads || []) {
            const candidate = candidates.get(name);
            if (candidate) candidate.occurrenceScopes.add(scopeId);
        }
    }

    function collectOccurrences(body, scopeId) {
        for (const node of body || []) {
            if (node.type === "raw") {
                const operation = node.operation || {};
                const candidate = candidates.get(operation.emittedTarget);
                if (candidate) {
                    if (operation.registerEpoch && operation.registerEpoch !== candidate.epoch) candidate.invalid = true;
                    else candidate.occurrenceScopes.add(scopeId);
                }
                recordReads(node.reads, scopeId);
                continue;
            }
            if (node.type === "numeric-for" || node.type === "generic-for") {
                recordReads(node.reads, scopeId);
                const child = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.body);
                if (child) collectOccurrences(node.body, child.id);
                continue;
            }
            if (node.type === "while-guard") {
                const child = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.conditionBody);
                if (!child) continue;
                collectOccurrences(node.conditionBody, child.id);
                recordReads(node.reads, child.id);
                collectOccurrences(node.body, child.id);
                continue;
            }
            if (node.type === "repeat-until") {
                const child = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.body);
                if (!child) continue;
                collectOccurrences(node.body, child.id);
                collectOccurrences(node.conditionBody, child.id);
                recordReads(node.reads, child.id);
                continue;
            }
            if (node.type === "if") {
                recordReads(node.reads, scopeId);
                const thenScope = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.thenBody);
                if (thenScope) collectOccurrences(node.thenBody, thenScope.id);
                if (node.elseBody) {
                    const elseScope = [...scopes.values()].find(scope => scope.parentId === scopeId && scope.insertionBody === node.elseBody);
                    if (elseScope) collectOccurrences(node.elseBody, elseScope.id);
                }
            }
        }
    }
    collectOccurrences(nodes, 0);

    function ancestors(scopeId) {
        const result = [];
        let current = scopeId;
        while (current !== null && current !== undefined) {
            result.push(current);
            current = scopes.get(current)?.parentId ?? null;
        }
        return result;
    }

    function commonAncestor(scopeIds) {
        const ids = [...scopeIds];
        if (!ids.length) return null;
        const first = ancestors(ids[0]);
        for (const candidate of first) {
            if (ids.every(id => ancestors(id).includes(candidate))) return candidate;
        }
        return null;
    }

    let count = 0;
    for (const candidate of candidates.values()) {
        if (candidate.invalid) continue;
        candidate.occurrenceScopes.add(candidate.declarationScopeId);
        const targetScopeId = commonAncestor(candidate.occurrenceScopes);
        if (targetScopeId === null) continue;

        const declarationNode = candidate.declarationNode;
        const operation = declarationNode.operation || {};
        const rhs = operation.rhs;
        if (typeof rhs !== "string" || !rhs.trim()) continue;

        const needsHoist = targetScopeId !== candidate.declarationScopeId || candidate.occurrenceScopes.size > 1;
        if (!needsHoist) continue;

        const declarationOperation = {
            kind: "epoch-hoisted-declaration",
            originalTarget: operation.originalTarget,
            emittedTarget: candidate.name,
            registerEpoch: candidate.epoch,
            rhs: null,
            reads: [],
            emittedText: `local ${candidate.name}`,
            returnSinkSafe: false,
        };
        const targetBody = scopes.get(targetScopeId)?.insertionBody;
        if (!targetBody) continue;
        targetBody.unshift(rawNode(declarationOperation, null));

        const assignmentOperation = {
            ...operation,
            kind: "epoch-mutate",
            emittedText: `${candidate.name} = ${rhs}`,
        };
        declarationNode.operation = assignmentOperation;
        declarationNode.text = assignmentOperation.emittedText;
        declarationNode.reads = [...(assignmentOperation.reads || [])];
        count++;
    }

    return { applied: count > 0, safe: true, count };
}

'''
s=s.replace(anchor,fn+anchor,1)
old='''    const scopeError = validateStructuredLocalScopes(structured.nodes);
    if (scopeError) return { applied: false, reason: scopeError };

    const bodyText = formatStructuredNodes(structured.nodes);
'''
new='''    const epochHoisting = hoistEscapingEpochDeclarations(structured.nodes);
    if (!epochHoisting.safe) return { applied: false, reason: epochHoisting.reason || "Beta epoch declaration hoisting failed closed" };
    const scopeError = validateStructuredLocalScopes(structured.nodes);
    if (scopeError) return { applied: false, reason: scopeError };

    const bodyText = formatStructuredNodes(structured.nodes);
'''
if old not in s: raise SystemExit('solve scope anchor missing')
s=s.replace(old,new,1)
oldret='''        environmentHeader: presented.environmentHeader,
        registerOverflowUsed: graph.registerOverflowUsed === true,
'''
newret='''        environmentHeader: presented.environmentHeader,
        hoistedEpochDeclarationCount: epochHoisting.count || 0,
        registerOverflowUsed: graph.registerOverflowUsed === true,
'''
# only replace acyclic return first occurrence after solve; there may be single-state earlier. use rfind before marker? We'll replace occurrence nearest body by finding after 'mode: "acyclic-structured"'
pos=s.index('mode: "acyclic-structured"')
idx=s.index(oldret,pos)
s=s[:idx]+s[idx:].replace(oldret,newret,1)
p.write_text(s,encoding='utf-8')
print('patched structured beta epoch declaration hoisting')
