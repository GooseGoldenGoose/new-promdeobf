const { findVmFunction } = require("./vm-state");
const { findVmReturnRegister, findRegisterDeclaration } = require("./vm-register-names");
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

function isExactStateLeafClause(clause, stateName) {
    if (clause?.type !== "IfClause") return false;
    const condition = clause.condition;
    if (condition?.type !== "BinaryExpression" || condition.operator !== "==") return false;
    return (
        (isIdentifier(condition.left, stateName) && numericValue(condition.right) !== null) ||
        (isIdentifier(condition.right, stateName) && numericValue(condition.left) !== null)
    );
}

function collectStateLeafClauses(node, stateName, out = []) {
    if (!isNode(node)) return out;
    if (node.type === "IfStatement") {
        for (const clause of node.clauses || []) {
            if (isExactStateLeafClause(clause, stateName)) out.push(clause);
        }
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectStateLeafClauses(child, stateName, out);
        } else if (isNode(value)) {
            collectStateLeafClauses(value, stateName, out);
        }
    }
    return out;
}

function collectIdentifierReadEdits(node, latestVersions, out = [], parent = null, parentKey = null) {
    if (!isNode(node)) return out;
    if (node.type === "Identifier") {
        const isProperty =
            (parent?.type === "MemberExpression" && parentKey === "identifier") ||
            (parent?.type === "TableKeyString" && parentKey === "key");
        const replacement = latestVersions.get(node.name);
        if (!isProperty && replacement && Array.isArray(node.range)) {
            out.push({ start: node.range[0], end: node.range[1], replacement });
        }
        return out;
    }

    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectIdentifierReadEdits(child, latestVersions, out, node, key);
        } else if (isNode(value)) {
            collectIdentifierReadEdits(value, latestVersions, out, node, key);
        }
    }
    return out;
}

function rewriteExpression(source, expression, latestVersions, usedVersions = null) {
    if (!expression || !Array.isArray(expression.range)) return null;
    const start = expression.range[0];
    const end = expression.range[1];
    const text = source.slice(start, end);
    const edits = collectIdentifierReadEdits(expression, latestVersions, []);
    if (usedVersions) {
        for (const edit of edits) usedVersions.add(edit.replacement);
    }
    return applyTextEdits(text, edits, start);
}

function findLastSingleWrites(statements, names) {
    const last = new Map();
    for (let index = 0; index < statements.length; index++) {
        const statement = statements[index];
        if (statement?.type !== "AssignmentStatement") continue;
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) continue;
        if (names.has(variables[0].name)) last.set(variables[0].name, { index, statement, value: init[0] });
    }
    return last;
}

function isNilLiteral(node) {
    return node?.type === "NilLiteral";
}

function isTableConstructor(node) {
    return node?.type === "TableConstructorExpression";
}

function collectClosureEntryStates(rootNode) {
    const entries = new Set();
    function walk(node) {
        if (!isNode(node)) return;
        if (node.type === "CallExpression" && isIdentifier(node.base) && /^createClosure(?:\d+)?$/.test(node.base.name)) {
            const entry = numericValue((node.arguments || [])[0]);
            if (entry !== null) entries.add(entry);
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) walk(child);
            } else if (isNode(value)) {
                walk(value);
            }
        }
    }
    walk(rootNode);
    return entries;
}

function stateTargets(node) {
    const direct = numericValue(node);
    if (direct !== null) return [direct];
    if (isNilLiteral(node)) return [];
    if (node?.type === "LogicalExpression" && node.operator === "or") {
        const left = node.left;
        const onFalse = numericValue(node.right);
        if (left?.type === "LogicalExpression" && left.operator === "and") {
            const onTrue = numericValue(left.right);
            if (onTrue !== null && onFalse !== null) return [onTrue, onFalse];
        }
    }
    return null;
}

function setEquals(a, b) {
    if (a === b) return true;
    if (!a || !b || a.size !== b.size) return false;
    for (const item of a) if (!b.has(item)) return false;
    return true;
}

function mapOfSetsEquals(a, b) {
    if (a === b) return true;
    if (a.size !== b.size) return false;
    for (const [key, value] of a) {
        if (!setEquals(value, b.get(key))) return false;
    }
    return true;
}

function cloneSetMap(map) {
    const out = new Map();
    for (const [key, value] of map) out.set(key, new Set(value));
    return out;
}

function mergeDefinitionMaps(maps, entryState, candidateNames) {
    const merged = new Map();
    for (const map of maps) {
        for (const [name, defs] of map) {
            let target = merged.get(name);
            if (!target) merged.set(name, target = new Set());
            for (const def of defs) target.add(def);
        }
    }
    if (entryState !== null) {
        for (const name of candidateNames) {
            let target = merged.get(name);
            if (!target) merged.set(name, target = new Set());
            target.add(`u:entry:${entryState}:${name}`);
        }
    }
    return merged;
}

function uniqueVersionMap(definitions) {
    const result = new Map();
    for (const [name, defs] of definitions) {
        if (defs.size !== 1) continue;
        const only = defs.values().next().value;
        if (typeof only === "string" && only.startsWith("v:")) result.set(name, only.slice(2));
    }
    return result;
}

function unionSets(sets) {
    const out = new Set();
    for (const set of sets) for (const value of set || []) out.add(value);
    return out;
}

function uniqueConcreteKill(set, noKill) {
    if (!set || set.size !== 1 || set.has(noKill)) return null;
    return set.values().next().value;
}

function computeCleanupDelimitedEpochs(blocks, candidateNames, stateName, returnName) {
    const ordinaryNames = new Set([...candidateNames].filter(name => name !== stateName && name !== returnName));
    const noKill = "<no-kill>";
    const killIdByStatement = new Map();

    for (const block of blocks) {
        for (const statement of block.statements) {
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const init = statement.init || [];
            if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) continue;
            const name = variables[0].name;
            if (!ordinaryNames.has(name) || !isNilLiteral(init[0])) continue;
            killIdByStatement.set(statement, `kill:${block.stateId}:${statement.range?.[0] ?? 0}:${name}`);
        }
    }

    const blockByState = new Map(blocks.map(block => [block.stateId, block]));
    const entry = new Map(blocks.map(block => [block.stateId, new Map()]));

    let changed = true;
    let rounds = 0;
    while (changed && rounds++ < blocks.length * 4 + 8) {
        changed = false;
        for (let blockIndex = blocks.length - 1; blockIndex >= 0; blockIndex--) {
            const block = blocks[blockIndex];
            const current = new Map();
            for (const name of ordinaryNames) {
                if (!Array.isArray(block.successors)) {
                    current.set(name, new Set([noKill]));
                    continue;
                }
                if (block.successors.length === 0) {
                    current.set(name, new Set([noKill]));
                    continue;
                }
                const successorSets = block.successors.map(target => entry.get(target)?.get(name) || new Set());
                const merged = unionSets(successorSets);
                if (merged.size === 0 && block.successors.some(target => !blockByState.has(target))) merged.add(noKill);
                current.set(name, merged);
            }

            for (let statementIndex = block.statements.length - 1; statementIndex >= 0; statementIndex--) {
                const statement = block.statements[statementIndex];
                const killId = killIdByStatement.get(statement);
                if (!killId) continue;
                const variable = statement.variables?.[0];
                if (isIdentifier(variable)) current.set(variable.name, new Set([killId]));
            }

            const previous = entry.get(block.stateId);
            if (!mapOfSetsEquals(previous, current)) {
                entry.set(block.stateId, current);
                changed = true;
            }
        }
    }

    if (changed) return { epochByStatement: new Map(), killIdByStatement, converged: false };

    const epochByStatement = new Map();
    for (const block of blocks) {
        const current = new Map();
        for (const name of ordinaryNames) {
            if (!Array.isArray(block.successors) || block.successors.length === 0) {
                current.set(name, new Set([noKill]));
            } else {
                current.set(name, unionSets(block.successors.map(target => entry.get(target)?.get(name) || new Set())));
            }
        }

        for (let statementIndex = block.statements.length - 1; statementIndex >= 0; statementIndex--) {
            const statement = block.statements[statementIndex];
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const init = statement.init || [];
            if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) continue;
            const name = variables[0].name;
            if (!ordinaryNames.has(name)) continue;

            const killId = killIdByStatement.get(statement);
            if (killId) {
                current.set(name, new Set([killId]));
                epochByStatement.set(statement, { key: killId, isKill: true });
                continue;
            }

            const key = uniqueConcreteKill(current.get(name), noKill);
            if (key) epochByStatement.set(statement, { key, isKill: false });
        }
    }

    return { epochByStatement, killIdByStatement, converged: true };
}

function versionVmBlockRegisters(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) {
        return { source, found: false, applied: false, reason: "No semantically named VM function was found" };
    }

    const vmFunction = vm.functionNode;
    const stateParameter = vmFunction.parameters?.[0];
    if (!isIdentifier(stateParameter)) {
        return { source, found: true, applied: false, reason: "VM state parameter is not an identifier" };
    }

    const returnRegister = findVmReturnRegister(vmFunction);
    if (!returnRegister) {
        return { source, found: true, applied: false, reason: "VM return register could not be identified" };
    }

    const registerDeclaration = findRegisterDeclaration(vmFunction, returnRegister.name);
    if (!registerDeclaration) {
        return { source, found: true, applied: false, reason: "VM scalar register declaration could not be identified" };
    }

    const stateName = stateParameter.name;
    const returnName = returnRegister.name;
    const specialFinalNames = new Set([stateName, returnName]);
    const candidateNames = new Set(registerDeclaration.variables.map(variable => variable.name));
    candidateNames.add(stateName);

    const leaves = collectStateLeafClauses(vmFunction, stateName, [])
        .sort((a, b) => a.range[0] - b.range[0]);
    if (leaves.length === 0) {
        return { source, found: true, applied: false, reason: "No exact normalized VM state leaves were found" };
    }

    const baseIds = new Map();
    const versionCounts = new Map();
    const versions = [];
    const blocks = [];
    let nextBaseId = 1;
    let skippedAssignments = 0;
    let preservedFinalWrites = 0;

    function ensureBase(name) {
        if (!baseIds.has(name)) baseIds.set(name, nextBaseId++);
        return baseIds.get(name);
    }

    // Phase 1: assign stable version identities to every supported write and build
    // block transfer metadata. No read is rewritten until CFG reaching definitions
    // are known.
    for (const leaf of leaves) {
        const stateId = numericValue(leaf.condition.left) ?? numericValue(leaf.condition.right);
        const statements = (leaf.body || []).filter(statement => statement?.type !== "CommentStatement");
        const lastSpecialWrites = findLastSingleWrites(statements, specialFinalNames);
        const finalStateWrite = lastSpecialWrites.get(stateName);
        const finalReturnWrite = lastSpecialWrites.get(returnName);
        const preservesReturnValue =
            finalReturnWrite &&
            finalStateWrite &&
            isTableConstructor(finalReturnWrite.value) &&
            isNilLiteral(finalStateWrite.value) &&
            finalReturnWrite.index < finalStateWrite.index;

        const plans = new Map();
        const lastDefinitions = new Map();

        for (let statementIndex = 0; statementIndex < statements.length; statementIndex++) {
            const statement = statements[statementIndex];
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const init = statement.init || [];

            if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) {
                for (const variable of variables) {
                    if (!isIdentifier(variable) || !candidateNames.has(variable.name)) continue;
                    const rawDefinition = `u:${stateId}:${statement.range?.[0] ?? statementIndex}:${variable.name}`;
                    lastDefinitions.set(variable.name, rawDefinition);
                }
                skippedAssignments++;
                plans.set(statement, { kind: "unsupported" });
                continue;
            }

            const originalName = variables[0].name;
            if (!candidateNames.has(originalName)) {
                plans.set(statement, { kind: "other", originalName });
                continue;
            }

            const lastWrite = lastSpecialWrites.get(originalName);
            const isPreservedFinalWrite =
                (originalName === stateName && lastWrite?.index === statementIndex) ||
                (originalName === returnName && preservesReturnValue && lastWrite?.index === statementIndex);

            if (isPreservedFinalWrite) {
                const rawDefinition = `u:${stateId}:${statement.range?.[0] ?? statementIndex}:${originalName}`;
                plans.set(statement, { kind: "preserved", originalName });
                lastDefinitions.set(originalName, rawDefinition);
                preservedFinalWrites++;
                continue;
            }

            if (!Array.isArray(statement.range) || !Array.isArray(init[0]?.range)) {
                const rawDefinition = `u:${stateId}:${statementIndex}:${originalName}`;
                plans.set(statement, { kind: "unsupported", originalName });
                lastDefinitions.set(originalName, rawDefinition);
                skippedAssignments++;
                continue;
            }

            const baseId = ensureBase(originalName);
            const version = (versionCounts.get(originalName) || 0) + 1;
            versionCounts.set(originalName, version);
            const newName = `r_v${baseId}_${version}`;
            plans.set(statement, { kind: "versioned", originalName, newName, baseId, version });
            lastDefinitions.set(originalName, `v:${newName}`);
            versions.push({ blockState: stateId, originalName, baseId, version, newName });
        }

        const successors = finalStateWrite ? stateTargets(finalStateWrite.value) : null;
        blocks.push({
            leaf,
            stateId,
            statements,
            plans,
            lastDefinitions,
            successors,
        });
    }

    const blockByState = new Map(blocks.map(block => [block.stateId, block]));
    let cfgComplete = blocks.every(block =>
        Array.isArray(block.successors) && block.successors.every(target => blockByState.has(target))
    );
    const closureEntries = collectClosureEntryStates(ast);
    if (closureEntries.size === 0 || [...closureEntries].some(entry => !blockByState.has(entry))) cfgComplete = false;

    if (cfgComplete) {
        const { epochByStatement } = computeCleanupDelimitedEpochs(
            blocks,
            candidateNames,
            stateName,
            returnName
        );
        const epochNames = new Map();
        const oldVersionInfo = new Map();
        versionCounts.clear();
        versions.length = 0;

        for (const block of blocks) {
            for (const statement of block.statements) {
                const plan = block.plans.get(statement);
                if (plan?.kind !== "versioned") continue;

                const oldName = plan.newName;
                const epoch = epochByStatement.get(statement);
                let newName;
                let version;
                let declareVersion = true;

                if (epoch && plan.originalName !== stateName && plan.originalName !== returnName) {
                    const epochKey = plan.originalName + "\0" + epoch.key;
                    let existing = epochNames.get(epochKey);
                    if (!existing) {
                        version = (versionCounts.get(plan.originalName) || 0) + 1;
                        versionCounts.set(plan.originalName, version);
                        const baseId = ensureBase(plan.originalName);
                        existing = { newName: `r_v${baseId}_${version}`, version, declared: false };
                        epochNames.set(epochKey, existing);
                    }
                    newName = existing.newName;
                    version = existing.version;
                    declareVersion = !existing.declared;
                    existing.declared = true;
                    plan.isLifetimeKill = epoch.isKill;
                    plan.lifetimeEpoch = epoch.key;
                } else {
                    version = (versionCounts.get(plan.originalName) || 0) + 1;
                    versionCounts.set(plan.originalName, version);
                    const baseId = ensureBase(plan.originalName);
                    newName = `r_v${baseId}_${version}`;
                }

                plan.oldName = oldName;
                plan.newName = newName;
                plan.version = version;
                plan.declareVersion = declareVersion;
                oldVersionInfo.set(oldName, { newName, isKill: plan.isLifetimeKill === true });
                versions.push({
                    blockState: block.stateId,
                    originalName: plan.originalName,
                    baseId: plan.baseId,
                    version,
                    newName,
                });
            }
        }

        for (const block of blocks) {
            for (const [name, definition] of block.lastDefinitions) {
                if (typeof definition !== "string" || !definition.startsWith("v:")) continue;
                const info = oldVersionInfo.get(definition.slice(2));
                if (!info) continue;
                block.lastDefinitions.set(
                    name,
                    info.isKill
                        ? `u:lifetime-kill:${block.stateId}:${name}`
                        : `v:${info.newName}`
                );
            }
        }
    } else {
        for (const block of blocks) {
            for (const statement of block.statements) {
                const plan = block.plans.get(statement);
                if (plan?.kind === "versioned") plan.declareVersion = true;
            }
        }
    }

    const predecessors = new Map(blocks.map(block => [block.stateId, []]));
    if (cfgComplete) {
        for (const block of blocks) {
            for (const target of block.successors) predecessors.get(target).push(block);
        }
    }

    const inDefinitions = new Map(blocks.map(block => [block.stateId, new Map()]));
    const outDefinitions = new Map(blocks.map(block => [block.stateId, new Map()]));
    const crossBlockUsedVersions = new Set();

    if (cfgComplete) {
        // Worklist reaching definitions. A version can cross a state boundary only
        // when every incoming path reaches that state with exactly the same version.
        const queue = [...blocks];
        const queued = new Set(queue.map(block => block.stateId));
        let cursor = 0;
        while (cursor < queue.length) {
            const block = queue[cursor++];
            queued.delete(block.stateId);
            const predMaps = (predecessors.get(block.stateId) || []).map(pred => outDefinitions.get(pred.stateId));
            const isEntry = closureEntries.has(block.stateId) || predMaps.length === 0;
            const nextIn = mergeDefinitionMaps(predMaps, isEntry ? block.stateId : null, candidateNames);
            const nextOut = cloneSetMap(nextIn);
            for (const [name, def] of block.lastDefinitions) nextOut.set(name, new Set([def]));

            const inChanged = !mapOfSetsEquals(nextIn, inDefinitions.get(block.stateId));
            const outChanged = !mapOfSetsEquals(nextOut, outDefinitions.get(block.stateId));
            if (inChanged) inDefinitions.set(block.stateId, nextIn);
            if (outChanged) {
                outDefinitions.set(block.stateId, nextOut);
                for (const successor of block.successors) {
                    if (!queued.has(successor)) {
                        queued.add(successor);
                        queue.push(blockByState.get(successor));
                    }
                }
            }
        }
    }

    // Phase 2: rewrite reads using the proven incoming definition plus writes seen
    // earlier in the same block. Capture the exact presentation decisions as graph
    // metadata so developer tools can visualize CFG + lifetime flow without re-deriving it.
    const edits = [];
    const graphStates = [];
    for (const block of blocks) {
        const graphOperations = [];
        const latestVersions = cfgComplete
            ? uniqueVersionMap(inDefinitions.get(block.stateId) || new Map())
            : new Map();
        const incomingVersionNames = new Set(latestVersions.values());

        for (const statement of block.statements) {
            if (statement?.type !== "AssignmentStatement") {
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "statement",
                    originalText: Array.isArray(statement?.range) ? source.slice(statement.range[0], statement.range[1]).trim() : String(statement?.type || "unknown"),
                    reads: [],
                });
                continue;
            }
            const plan = block.plans.get(statement);
            const variables = statement.variables || [];
            const init = statement.init || [];

            if (!plan || plan.kind === "unsupported") {
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "unsupported",
                    originalText: Array.isArray(statement.range) ? source.slice(statement.range[0], statement.range[1]).trim() : "",
                    reads: [],
                });
                for (const variable of variables) {
                    if (isIdentifier(variable) && candidateNames.has(variable.name)) latestVersions.delete(variable.name);
                }
                continue;
            }

            if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) continue;
            const usedVersions = new Set();
            const rhs = rewriteExpression(source, init[0], latestVersions, usedVersions);
            for (const versionName of usedVersions) {
                if (incomingVersionNames.has(versionName)) crossBlockUsedVersions.add(versionName);
            }
            if (rhs === null) {
                if (candidateNames.has(variables[0].name)) latestVersions.delete(variables[0].name);
                continue;
            }

            if (plan.kind === "other") {
                const originalRhs = source.slice(init[0].range[0], init[0].range[1]);
                if (rhs !== originalRhs) edits.push({ start: init[0].range[0], end: init[0].range[1], replacement: rhs });
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "other",
                    originalTarget: variables[0].name,
                    emittedTarget: variables[0].name,
                    rhs,
                    reads: [...usedVersions],
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: `${variables[0].name} = ${rhs}`,
                });
                continue;
            }

            if (plan.kind === "preserved") {
                const originalRhs = source.slice(init[0].range[0], init[0].range[1]);
                if (rhs !== originalRhs) edits.push({ start: init[0].range[0], end: init[0].range[1], replacement: rhs });
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: plan.originalName === stateName ? "state-transition" : "return-payload",
                    originalTarget: plan.originalName,
                    emittedTarget: plan.originalName,
                    rhs,
                    reads: [...usedVersions],
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: `${plan.originalName} = ${rhs}`,
                });
                latestVersions.delete(plan.originalName);
                continue;
            }

            if (plan.kind === "versioned") {
                const declarationPrefix = plan.declareVersion === false ? "" : "local ";
                const emittedText = `${declarationPrefix}${plan.newName} = ${rhs}`;
                edits.push({
                    start: statement.range[0],
                    end: statement.range[1],
                    replacement: emittedText,
                });
                const isCleanupLifetime = Boolean(plan.lifetimeEpoch);
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: plan.isLifetimeKill
                        ? "lifetime-kill"
                        : (isCleanupLifetime ? (plan.declareVersion === false ? "lifetime-mutate" : "lifetime-start") : "version-define"),
                    originalTarget: plan.originalName,
                    emittedTarget: plan.newName,
                    rhs,
                    reads: [...usedVersions],
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText,
                    lifetimeEpoch: plan.lifetimeEpoch || null,
                });
                if (plan.isLifetimeKill) latestVersions.delete(plan.originalName);
                else latestVersions.set(plan.originalName, plan.newName);
                continue;
            }
        }

        const predecessorStates = (predecessors.get(block.stateId) || []).map(item => item.stateId);
        const finalStateWrite = findLastSingleWrites(block.statements, new Set([stateName])).get(stateName);
        graphStates.push({
            id: block.stateId,
            entry: closureEntries.has(block.stateId),
            predecessors: predecessorStates,
            successors: Array.isArray(block.successors) ? [...block.successors] : null,
            transition: graphOperations.find(operation => operation.kind === "state-transition")?.rhs ||
                (finalStateWrite?.value && Array.isArray(finalStateWrite.value.range)
                    ? source.slice(finalStateWrite.value.range[0], finalStateWrite.value.range[1]).trim()
                    : null),
            operations: graphOperations,
        });
    }

    if (edits.length === 0) {
        return { source, found: true, applied: false, reason: "No supported VM register assignments were found" };
    }

    const output = applyTextEdits(source, edits);

    const cleanupLifetimeNames = new Set();
    for (const state of graphStates) {
        for (const operation of state.operations) {
            if (operation.lifetimeEpoch && operation.emittedTarget) cleanupLifetimeNames.add(operation.emittedTarget);
        }
    }
    const lifetimeByName = new Map();
    for (const name of cleanupLifetimeNames) lifetimeByName.set(name, { name, originalRegister: null, events: [] });
    for (const state of graphStates) {
        for (const operation of state.operations) {
            if (operation.lifetimeEpoch && operation.emittedTarget && lifetimeByName.has(operation.emittedTarget)) {
                const lifetime = lifetimeByName.get(operation.emittedTarget);
                lifetime.originalRegister ||= operation.originalTarget;
                lifetime.events.push({
                    state: state.id,
                    operation: operation.index,
                    kind: operation.kind === "lifetime-start" ? "start" : operation.kind === "lifetime-mutate" ? "mutate" : "kill",
                    text: operation.emittedText || `${operation.emittedTarget} = ${operation.rhs}`,
                });
            }
            for (const read of operation.reads || []) {
                const lifetime = lifetimeByName.get(read);
                if (!lifetime) continue;
                lifetime.events.push({
                    state: state.id,
                    operation: operation.index,
                    kind: "read",
                    text: operation.emittedText || operation.originalText || `${operation.emittedTarget || "?"} = ${operation.rhs || "?"}`,
                });
            }
        }
    }
    const kindOrder = { start: 0, read: 1, mutate: 2, kill: 3 };
    for (const lifetime of lifetimeByName.values()) {
        lifetime.events.sort((left, right) => left.state - right.state || left.operation - right.operation || kindOrder[left.kind] - kindOrder[right.kind]);
    }
    const graph = {
        stateName,
        returnName,
        cfgComplete,
        entries: [...closureEntries].sort((left, right) => left - right),
        states: graphStates.sort((left, right) => left.id - right.id),
        lifetimes: [...lifetimeByName.values()].sort((left, right) => left.name.localeCompare(right.name, undefined, { numeric: true })),
    };

    return {
        source: output,
        found: true,
        applied: output !== source,
        blockCount: leaves.length,
        versionedAssignmentCount: versions.length,
        preservedFinalWrites,
        skippedAssignments,
        cfgComplete,
        crossBlockVersionCount: crossBlockUsedVersions.size,
        mapping: [...baseIds.entries()].map(([originalName, baseId]) => ({ originalName, baseName: `r_v${baseId}` })),
        versions,
        edits,
        graph,
    };
}

module.exports = {
    versionVmBlockRegisters,
};
