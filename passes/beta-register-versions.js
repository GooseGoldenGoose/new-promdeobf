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
    // earlier in the same block.
    const edits = [];
    for (const block of blocks) {
        const latestVersions = cfgComplete
            ? uniqueVersionMap(inDefinitions.get(block.stateId) || new Map())
            : new Map();
        const incomingVersionNames = new Set(latestVersions.values());

        for (const statement of block.statements) {
            if (statement?.type !== "AssignmentStatement") continue;
            const plan = block.plans.get(statement);
            const variables = statement.variables || [];
            const init = statement.init || [];

            if (!plan || plan.kind === "unsupported") {
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
                continue;
            }

            if (plan.kind === "preserved") {
                const originalRhs = source.slice(init[0].range[0], init[0].range[1]);
                if (rhs !== originalRhs) edits.push({ start: init[0].range[0], end: init[0].range[1], replacement: rhs });
                latestVersions.delete(plan.originalName);
                continue;
            }

            if (plan.kind === "versioned") {
                edits.push({
                    start: statement.range[0],
                    end: statement.range[1],
                    replacement: `local ${plan.newName} = ${rhs}`,
                });
                latestVersions.set(plan.originalName, plan.newName);
                continue;
            }
        }

    }

    if (edits.length === 0) {
        return { source, found: true, applied: false, reason: "No supported VM register assignments were found" };
    }

    const output = applyTextEdits(source, edits);
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
    };
}

module.exports = {
    versionVmBlockRegisters,
};
