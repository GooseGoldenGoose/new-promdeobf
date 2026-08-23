const luaparse = require("../parser/luaparse");
const { applyTextEdits } = require("./text-edits");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = typeof node.value === "number" ? node.value : Number(node.raw);
    return Number.isInteger(value) ? value : null;
}

function walk(node, visit) {
    if (!isNode(node)) return;
    visit(node);
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) walk(child, visit);
        } else if (isNode(value)) {
            walk(value, visit);
        }
    }
}

function parseExpression(text) {
    const prefix = "local __beta_upvalue_expr = ";
    const source = prefix + String(text || "");
    try {
        const ast = luaparse.parse(source, {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
        const statement = ast.body?.[0];
        const expression = statement?.type === "LocalStatement" ? statement.init?.[0] : null;
        return expression ? { source, prefix, expression } : null;
    } catch {
        return null;
    }
}

function parseStatement(text) {
    const source = String(text || "");
    try {
        const ast = luaparse.parse(source, {
            luaVersion: "luau",
            comments: false,
            scope: false,
            locations: false,
            ranges: true,
        });
        if ((ast.body || []).length !== 1) return null;
        return { source, statement: ast.body[0] };
    } catch {
        return null;
    }
}

function isCall(node, name, argCount = null) {
    if (node?.type !== "CallExpression" || !isIdentifier(node.base, name)) return false;
    return argCount === null || (node.arguments || []).length === argCount;
}

function isClosureFactoryName(name) {
    return typeof name === "string" && /^createClosure(?:\d+)?$/.test(name);
}

function upvalueSlot(node) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, "upvalues")) return null;
    const slot = numericValue(node.index);
    return Number.isInteger(slot) && slot >= 1 ? slot : null;
}

function isUpvalueValuesIndex(node) {
    return node?.type === "IndexExpression" && isIdentifier(node.base, "upvalueValues");
}

function tableValues(node) {
    if (node?.type !== "TableConstructorExpression") return null;
    const values = [];
    for (const field of node.fields || []) {
        if (field?.type !== "TableValue") return null;
        values.push(field.value);
    }
    return values;
}

function partitionClosureRegions(graph) {
    const entries = [...(graph.entries || [])];
    const entrySet = new Set(entries);
    const stateById = new Map((graph.states || []).map(state => [state.id, state]));
    const ownerByState = new Map();

    for (const entry of entries) {
        const stack = [entry];
        const visited = new Set();
        while (stack.length) {
            const stateId = stack.pop();
            if (visited.has(stateId)) continue;
            visited.add(stateId);
            const state = stateById.get(stateId);
            if (!state) return { error: `Closure entry ${entry} reaches missing state ${stateId}` };
            if (stateId !== entry && entrySet.has(stateId)) {
                return { error: `Closure entry ${entry} transitions into separate closure entry ${stateId}` };
            }
            const owner = ownerByState.get(stateId);
            if (owner !== undefined && owner !== entry) {
                return { error: `State ${stateId} is reachable from closure entries ${owner} and ${entry}` };
            }
            ownerByState.set(stateId, entry);
            for (const successor of state.successors || []) stack.push(successor);
        }
    }

    if (ownerByState.size !== (graph.states || []).length) {
        return { error: `Upvalue recovery owns ${ownerByState.size}/${(graph.states || []).length} states` };
    }
    return { ownerByState, stateById };
}

function factoryCallFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);
    const call = parsed?.expression;
    if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !isClosureFactoryName(call.base.name)) return null;
    const args = call.arguments || [];
    const entry = numericValue(args[0]);
    const captures = tableValues(args[1]);
    if (entry === null || !captures) return null;
    return { parsed, call, entry, captures, factoryName: call.base.name };
}

function indexedWriteFromOperation(operation) {
    const parsed = parseStatement(operation?.emittedText);
    const statement = parsed?.statement;
    if (statement?.type !== "AssignmentStatement") return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isUpvalueValuesIndex(variables[0])) return null;
    return { parsed, statement, target: variables[0], value: init[0] };
}

function releaseCellFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);
    const expression = parsed?.expression;
    if (!isCall(expression, "releaseUpvalue", 1)) return null;
    const argument = expression.arguments[0];
    if (!isIdentifier(argument) || operation?.emittedTarget !== argument.name) return null;
    return { cellName: argument.name };
}

function allocationFromOperation(operation) {
    const parsed = parseExpression(operation?.rhs);
    const expression = parsed?.expression;
    if (!isCall(expression, "allocUpvalue", 0) || !operation?.emittedTarget) return null;
    return { cellName: operation.emittedTarget };
}

function cloneGraph(graph) {
    return {
        ...graph,
        entries: [...(graph.entries || [])],
        states: (graph.states || []).map(state => ({
            ...state,
            predecessors: Array.isArray(state.predecessors) ? [...state.predecessors] : state.predecessors,
            successors: Array.isArray(state.successors) ? [...state.successors] : state.successors,
            operations: (state.operations || []).map(operation => ({
                ...operation,
                reads: [...(operation.reads || [])],
                returnExpressions: Array.isArray(operation.returnExpressions)
                    ? [...operation.returnExpressions]
                    : operation.returnExpressions,
            })),
        })),
    };
}

function operationPositions(graph, ownerByState) {
    const positions = [];
    for (const state of graph.states || []) {
        const ownerEntry = ownerByState.get(state.id);
        for (let operationIndex = 0; operationIndex < (state.operations || []).length; operationIndex++) {
            positions.push({ state, stateId: state.id, ownerEntry, operationIndex, operation: state.operations[operationIndex] });
        }
    }
    return positions;
}

function rewriteExpressionUpvalues(text, ownerEntry, resolveCellIndex, bindingByCell) {
    const parsed = parseExpression(text);
    if (!parsed) return { error: "Expression could not be reparsed during beta upvalue recovery" };
    const edits = [];
    const bindingReads = new Set();
    let unresolved = null;

    function visit(node) {
        if (!isNode(node) || unresolved) return;
        if (isUpvalueValuesIndex(node)) {
            const cellId = resolveCellIndex(ownerEntry, node.index);
            if (!cellId) {
                unresolved = "An upvalueValues read has no uniquely resolved cell";
                return;
            }
            const bindingName = bindingByCell.get(cellId);
            if (!bindingName) {
                unresolved = `Resolved cell ${cellId} has no recovered lexical binding`;
                return;
            }
            edits.push({ start: node.range[0], end: node.range[1], replacement: bindingName });
            bindingReads.add(bindingName);
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }

    visit(parsed.expression);
    if (unresolved) return { error: unresolved };
    const rewritten = edits.length ? applyTextEdits(parsed.source, edits).slice(parsed.prefix.length) : String(text || "");
    return { text: rewritten, bindingReads };
}

function countIdentifier(node, name) {
    let count = 0;
    walk(node, current => {
        if (isIdentifier(current, name)) count++;
    });
    return count;
}

function containsVmUpvalueMachinery(text) {
    const parsed = parseStatement(text);
    if (!parsed) return true;
    let found = false;
    walk(parsed.statement, node => {
        if (found) return;
        if (isUpvalueValuesIndex(node) || upvalueSlot(node) !== null) {
            found = true;
            return;
        }
        if (node?.type === "CallExpression" && isIdentifier(node.base) &&
            (node.base.name === "allocUpvalue" || node.base.name === "releaseUpvalue")) {
            found = true;
        }
    });
    return found;
}

function recoverBetaUpvalues(betaResult) {
    const originalGraph = betaResult?.graph || betaResult;
    if (!originalGraph?.cfgComplete || !Array.isArray(originalGraph.states) || !Array.isArray(originalGraph.entries)) {
        return { applied: false, safe: false, reason: "Beta upvalue recovery requires a complete beta CFG" };
    }

    const graph = cloneGraph(originalGraph);
    const partition = partitionClosureRegions(graph);
    if (partition.error) return { applied: false, safe: false, reason: partition.error };
    const { ownerByState } = partition;
    const positions = operationPositions(graph, ownerByState);
    const regionStateCount = new Map();
    for (const state of graph.states) {
        const owner = ownerByState.get(state.id);
        regionStateCount.set(owner, (regionStateCount.get(owner) || 0) + 1);
    }

    const cells = new Map();
    for (const position of positions) {
        const allocation = allocationFromOperation(position.operation);
        if (!allocation) continue;
        if (cells.has(allocation.cellName)) {
            return { applied: false, safe: false, reason: `Beta upvalue cell register ${allocation.cellName} has multiple allocations` };
        }
        cells.set(allocation.cellName, {
            id: allocation.cellName,
            registerName: allocation.cellName,
            ownerEntry: position.ownerEntry,
            allocation: position,
            initialization: null,
            bindingName: null,
            bindingMode: null,
        });
    }

    const factorySites = [];
    for (const position of positions) {
        const factory = factoryCallFromOperation(position.operation);
        if (!factory) continue;
        factorySites.push({ ...position, ...factory });
    }

    const hasCapturedFactories = factorySites.some(site => site.captures.length > 0);
    if (!hasCapturedFactories) {
        return {
            applied: false,
            safe: true,
            graph,
            stats: { cellCount: cells.size, recoveredCellCount: 0, captureCount: 0, readRewriteCount: 0, writeRewriteCount: 0, releaseRemovalCount: 0 },
        };
    }

    const entrySet = new Set(graph.entries);
    const referencedEntries = new Set(factorySites.filter(site => entrySet.has(site.entry)).map(site => site.entry));
    const rootEntries = graph.entries.filter(entry => !referencedEntries.has(entry));
    if (rootEntries.length !== 1) {
        return { applied: false, safe: false, reason: `Beta upvalue recovery requires one root closure entry (found ${rootEntries.length})` };
    }
    const rootEntry = rootEntries[0];

    const siteByChild = new Map();
    const sitesByParent = new Map(graph.entries.map(entry => [entry, []]));
    for (const site of factorySites) {
        if (!entrySet.has(site.entry)) continue;
        if (siteByChild.has(site.entry)) {
            return { applied: false, safe: false, reason: `Closure entry ${site.entry} has multiple static factory sites; captured lexical recovery is ambiguous` };
        }
        siteByChild.set(site.entry, site);
        sitesByParent.get(site.ownerEntry)?.push(site);
    }
    for (const entry of graph.entries) {
        if (entry === rootEntry) continue;
        if (!siteByChild.has(entry)) {
            return { applied: false, safe: false, reason: `Closure entry ${entry} has no static parent factory site` };
        }
    }

    const captureCellsByEntry = new Map([[rootEntry, new Map()]]);
    const cellByRegister = new Map(cells);

    function resolveCellIndex(ownerEntry, indexNode) {
        if (isIdentifier(indexNode)) return cellByRegister.has(indexNode.name) ? indexNode.name : null;
        const slot = upvalueSlot(indexNode);
        if (slot === null) return null;
        return captureCellsByEntry.get(ownerEntry)?.get(slot) || null;
    }

    const queue = [rootEntry];
    let queueCursor = 0;
    const visitedEntries = new Set();
    let captureCount = 0;
    while (queueCursor < queue.length) {
        const parentEntry = queue[queueCursor++];
        if (visitedEntries.has(parentEntry)) continue;
        visitedEntries.add(parentEntry);
        for (const site of sitesByParent.get(parentEntry) || []) {
            const slotMap = new Map();
            for (let index = 0; index < site.captures.length; index++) {
                const capture = site.captures[index];
                const cellId = resolveCellIndex(parentEntry, capture);
                if (!cellId) {
                    return { applied: false, safe: false, reason: `Closure entry ${site.entry} capture slot ${index + 1} does not resolve to a proven upvalue cell` };
                }
                slotMap.set(index + 1, cellId);
                captureCount++;
            }
            captureCellsByEntry.set(site.entry, slotMap);
            queue.push(site.entry);
        }
    }
    if (visitedEntries.size !== graph.entries.length) {
        return { applied: false, safe: false, reason: `Beta upvalue closure graph reached ${visitedEntries.size}/${graph.entries.length} entries` };
    }

    const capturedCellIds = new Set();
    for (const slots of captureCellsByEntry.values()) {
        for (const cellId of slots.values()) capturedCellIds.add(cellId);
    }

    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        if (!cell) return { applied: false, safe: false, reason: `Captured cell ${cellId} has no allocUpvalue definition` };
        if ((regionStateCount.get(cell.ownerEntry) || 0) !== 1) {
            return { applied: false, safe: false, reason: `Captured cell ${cellId} is allocated in a multi-state owner region; lexical dominance proof is not implemented yet` };
        }

        const candidates = [];
        for (const position of positions) {
            if (position.ownerEntry !== cell.ownerEntry || position.stateId !== cell.allocation.stateId) continue;
            if (position.operationIndex <= cell.allocation.operationIndex) continue;
            const write = indexedWriteFromOperation(position.operation);
            if (!write) continue;
            const targetCell = resolveCellIndex(position.ownerEntry, write.target.index);
            if (targetCell === cellId) candidates.push({ ...position, ...write });
        }
        if (!candidates.length) {
            return { applied: false, safe: false, reason: `Captured cell ${cellId} has no compiler-shaped initialization write` };
        }
        cell.initialization = candidates[0];

        const initValue = cell.initialization.value;
        if (isIdentifier(initValue)) {
            const candidateName = initValue.name;
            const candidateWrites = positions.filter(position => position.operation?.emittedTarget === candidateName);
            const candidateDeclaration = candidateWrites.length === 1 ? candidateWrites[0] : null;
            const candidateReads = positions.filter(position => (position.operation?.reads || []).includes(candidateName));
            const onlyFeedsInitialization = candidateReads.length === 1 && candidateReads[0].operation === cell.initialization.operation;
            if (
                candidateDeclaration &&
                onlyFeedsInitialization &&
                candidateDeclaration.ownerEntry === cell.ownerEntry &&
                candidateDeclaration.stateId === cell.initialization.stateId &&
                candidateDeclaration.operationIndex < cell.initialization.operationIndex &&
                String(candidateDeclaration.operation.emittedText || "").trimStart().startsWith("local ")
            ) {
                cell.bindingName = candidateName;
                cell.bindingMode = "existing-beta-binding";
            }
        }
        if (!cell.bindingName) {
            cell.bindingName = cell.registerName;
            cell.bindingMode = "cell-register-binding";
        }

        // A closure may be created before the compiler emits the cell's first
        // value initialization (captured parameters are a real example). A Lua
        // local declared only at that later initialization point would not be in
        // lexical scope for the already-created nested function. In that case,
        // keep the recovered cell binding name but hoist only its declaration to
        // the original allocUpvalue site, then assign the value at the original
        // initialization site. Region ownership is single-state here, so the
        // operation order is a proven lexical order inside one function region.
        const firstCaptureIndex = factorySites
            .filter(site =>
                site.ownerEntry === cell.ownerEntry &&
                site.stateId === cell.allocation.stateId &&
                site.captures.some(capture => resolveCellIndex(site.ownerEntry, capture) === cellId)
            )
            .reduce((best, site) => Math.min(best, site.operationIndex), Infinity);
        if (firstCaptureIndex < cell.initialization.operationIndex) {
            cell.bindingName = cell.registerName;
            cell.bindingMode = "hoisted-cell-binding";
        }
    }

    const bindingByCell = new Map([...cells.values()].filter(cell => capturedCellIds.has(cell.id)).map(cell => [cell.id, cell.bindingName]));
    const localCellNames = new Set(capturedCellIds);

    // Validate that every direct cell-register occurrence is part of understood VM
    // cell machinery before deleting the allocation/reference-count representation.
    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        for (const position of positions) {
            const text = position.operation?.emittedText;
            if (!text || !String(text).includes(cell.registerName)) continue;
            const statementParsed = parseStatement(text);
            if (!statementParsed) {
                return { applied: false, safe: false, reason: `Cell ${cellId} appears in an unparseable beta operation` };
            }
            const totalUses = countIdentifier(statementParsed.statement, cell.registerName);
            if (totalUses === 0) continue;

            let understood = 0;
            const allocation = allocationFromOperation(position.operation);
            if (allocation?.cellName === cell.registerName) understood += totalUses;

            const release = releaseCellFromOperation(position.operation);
            if (release?.cellName === cell.registerName) understood += totalUses;

            const factory = factoryCallFromOperation(position.operation);
            if (factory) {
                for (const capture of factory.captures) {
                    if (isIdentifier(capture, cell.registerName)) understood += 1;
                }
            }

            walk(statementParsed.statement, node => {
                if (!isUpvalueValuesIndex(node)) return;
                if (isIdentifier(node.index, cell.registerName)) understood += 1;
            });

            if (understood < totalUses) {
                return { applied: false, safe: false, reason: `Cell ${cellId} escapes recognized upvalue machinery in state ${position.stateId}` };
            }
        }
    }

    const removals = new Set();
    const replacements = new Map();
    let readRewriteCount = 0;
    let writeRewriteCount = 0;
    let releaseRemovalCount = 0;
    let factoryRewriteCount = 0;

    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        if (cell.bindingMode === "hoisted-cell-binding") {
            replacements.set(cell.allocation.operation, {
                ...cell.allocation.operation,
                kind: "upvalue-binding-declaration",
                originalTarget: cell.registerName,
                emittedTarget: cell.bindingName,
                rhs: null,
                reads: [],
                emittedText: `local ${cell.bindingName}`,
                returnSinkSafe: false,
            });
        } else {
            removals.add(cell.allocation.operation);
        }

        if (cell.bindingMode === "existing-beta-binding") {
            removals.add(cell.initialization.operation);
        } else {
            const initRhsText = cell.initialization.parsed.source.slice(cell.initialization.value.range[0], cell.initialization.value.range[1]);
            const rewritten = rewriteExpressionUpvalues(initRhsText, cell.ownerEntry, resolveCellIndex, bindingByCell);
            if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
            const hoisted = cell.bindingMode === "hoisted-cell-binding";
            replacements.set(cell.initialization.operation, {
                ...cell.initialization.operation,
                kind: hoisted ? "upvalue-binding-init" : "upvalue-binding-start",
                originalTarget: cell.registerName,
                emittedTarget: cell.bindingName,
                rhs: rewritten.text,
                reads: [...new Set([...(cell.initialization.operation.reads || []).filter(name => !localCellNames.has(name)), ...rewritten.bindingReads])],
                emittedText: `${hoisted ? "" : "local "}${cell.bindingName} = ${rewritten.text}`,
                returnSinkSafe: false,
            });
        }
    }

    for (const site of factorySites) {
        if (!entrySet.has(site.entry) || site.captures.length === 0) continue;
        const source = site.parsed.source;
        const captureArg = site.call.arguments[1];
        const rewrittenSource = applyTextEdits(source, [{ start: captureArg.range[0], end: captureArg.range[1], replacement: "{}" }]);
        const rhs = rewrittenSource.slice(site.parsed.prefix.length);
        const originalText = String(site.operation.emittedText || "").trimStart();
        const localPrefix = originalText.startsWith("local ") ? "local " : "";
        replacements.set(site.operation, {
            ...site.operation,
            rhs,
            emittedText: site.operation.emittedTarget
                ? `${localPrefix}${site.operation.emittedTarget} = ${rhs}`
                : site.operation.emittedText,
            reads: (site.operation.reads || []).filter(name => !localCellNames.has(name)),
            returnSinkSafe: false,
        });
        factoryRewriteCount++;
    }

    for (const position of positions) {
        const operation = position.operation;
        if (removals.has(operation) || replacements.has(operation)) continue;

        const release = releaseCellFromOperation(operation);
        if (release && capturedCellIds.has(release.cellName)) {
            removals.add(operation);
            releaseRemovalCount++;
            continue;
        }

        const write = indexedWriteFromOperation(operation);
        if (write) {
            const cellId = resolveCellIndex(position.ownerEntry, write.target.index);
            if (cellId && capturedCellIds.has(cellId)) {
                const bindingName = bindingByCell.get(cellId);
                const rhsText = write.parsed.source.slice(write.value.range[0], write.value.range[1]);
                const rewritten = rewriteExpressionUpvalues(rhsText, position.ownerEntry, resolveCellIndex, bindingByCell);
                if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
                replacements.set(operation, {
                    ...operation,
                    kind: "upvalue-write",
                    originalTarget: bindingName,
                    emittedTarget: bindingName,
                    rhs: rewritten.text,
                    reads: [...new Set([...(operation.reads || []).filter(name => !localCellNames.has(name)), ...rewritten.bindingReads])],
                    emittedText: `${bindingName} = ${rewritten.text}`,
                    returnSinkSafe: false,
                });
                writeRewriteCount++;
                continue;
            }
        }

        if (operation.rhs && String(operation.rhs).includes("upvalueValues")) {
            const rewritten = rewriteExpressionUpvalues(operation.rhs, position.ownerEntry, resolveCellIndex, bindingByCell);
            if (rewritten.error) return { applied: false, safe: false, reason: rewritten.error };
            if (rewritten.text !== operation.rhs) {
                const originalText = String(operation.emittedText || "").trimStart();
                const localPrefix = originalText.startsWith("local ") ? "local " : "";
                replacements.set(operation, {
                    ...operation,
                    rhs: rewritten.text,
                    reads: [...new Set([...(operation.reads || []).filter(name => !localCellNames.has(name)), ...rewritten.bindingReads])],
                    emittedText: operation.emittedTarget
                        ? `${localPrefix}${operation.emittedTarget} = ${rewritten.text}`
                        : operation.emittedText,
                    returnSinkSafe: false,
                });
                readRewriteCount++;
            }
        }
    }

    for (const state of graph.states) {
        const next = [];
        for (const operation of state.operations || []) {
            if (removals.has(operation)) continue;
            next.push(replacements.get(operation) || operation);
        }
        state.operations = next;
        for (let index = 0; index < next.length; index++) next[index].index = index + 1;
    }

    // No recovered closure region may retain VM upvalue table accesses after the
    // transform. If it does, the cell graph was incomplete and we fail closed.
    for (const state of graph.states) {
        for (const operation of state.operations || []) {
            const text = String(operation.emittedText || "");
            if (containsVmUpvalueMachinery(text)) {
                return { applied: false, safe: false, reason: `State ${state.id} retains unresolved VM upvalue machinery after recovery` };
            }
        }
    }

    return {
        applied: true,
        safe: true,
        graph,
        stats: {
            cellCount: cells.size,
            recoveredCellCount: capturedCellIds.size,
            captureCount,
            readRewriteCount,
            writeRewriteCount,
            releaseRemovalCount,
            factoryRewriteCount,
        },
        cells: [...capturedCellIds].map(cellId => {
            const cell = cells.get(cellId);
            return {
                id: cell.id,
                ownerEntry: cell.ownerEntry,
                bindingName: cell.bindingName,
                bindingMode: cell.bindingMode,
            };
        }),
    };
}

module.exports = {
    recoverBetaUpvalues,
};
