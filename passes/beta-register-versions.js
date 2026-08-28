const { findVmFunction, analyzeBlockTerminator } = require("./vm-state");
const { findVmReturnRegister, findRegisterDeclaration } = require("./vm-register-names");
const { applyTextEdits } = require("./text-edits");
const { analyzeBetaRegisterLifetimes } = require("./beta-register-lifetimes");
const { recoverBetaUpvalues } = require("./beta-upvalues");

const NUMERIC_NAME_COLLATOR = new Intl.Collator(undefined, { numeric: true });
const luaparse = require("../parser/luaparse");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isIndexedWriteTarget(node) {
    return node?.type === "IndexExpression" || node?.type === "MemberExpression";
}

function isOrderedEffectAssignment(statement) {
    if (!Array.isArray(statement?.range)) return false;
    if (statement.type === "AssignmentStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        return variables.length === 1 && init.length === 1 && isIndexedWriteTarget(variables[0]) &&
            Array.isArray(variables[0]?.range) && Array.isArray(init[0]?.range);
    }
    if (statement.type === "CompoundAssignmentStatement") {
        return isIndexedWriteTarget(statement.variable) &&
            Array.isArray(statement.variable?.range) && Array.isArray(statement.value?.range);
    }
    return false;
}

function isAtomicMultiCallAssignment(statement, candidateNames) {
    if (statement?.type !== "AssignmentStatement" || !Array.isArray(statement.range)) return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length < 2 || init.length !== 1 || init[0]?.type !== "CallExpression" || !Array.isArray(init[0]?.range)) return false;
    if (!variables.every(variable => isIdentifier(variable) && candidateNames.has(variable.name) && Array.isArray(variable.range))) return false;
    return true;
}

function isAtomicParallelAssignment(statement, candidateNames) {
    if (statement?.type !== "AssignmentStatement" || !Array.isArray(statement.range)) return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length === 0 || init.length === 0) return false;
    if (variables.length === 1 && init.length === 1) return false;
    if (!variables.every(variable =>
        Array.isArray(variable?.range) && (isIdentifier(variable) || isIndexedWriteTarget(variable))
    )) return false;
    if (!init.every(value => Array.isArray(value?.range))) return false;
    return variables.some(variable => isIdentifier(variable) && candidateNames.has(variable.name));
}

const SIMPLE_REGISTER_COMPOUND_OPERATORS = new Set(["+", "-", "*", "/", "//", "%", "^", ".."]);

function isSimpleRegisterCompoundAssignment(statement, candidateNames, specialNames = null) {
    return statement?.type === "CompoundAssignmentStatement" &&
        isIdentifier(statement.variable) &&
        candidateNames.has(statement.variable.name) &&
        (!specialNames || !specialNames.has(statement.variable.name)) &&
        SIMPLE_REGISTER_COMPOUND_OPERATORS.has(statement.op) &&
        Array.isArray(statement.range) &&
        Array.isArray(statement.variable.range) &&
        Array.isArray(statement.value?.range);
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
    for (const key of Object.keys(node)) {
        const value = node[key];
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

    for (const key of Object.keys(node)) {
        const value = node[key];
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

function rewriteUnsupportedAssignmentReads(source, statement, latestVersions, usedVersions = null) {
    if (!Array.isArray(statement?.range)) return null;
    const edits = [];

    if (statement.type === "AssignmentStatement") {
        // Plain identifier targets are writes, not reads. Complex assignment targets
        // still evaluate their base/index expressions, so beta versions must flow into
        // addresses such as table[index] as well as into every RHS expression.
        for (const variable of statement.variables || []) {
            if (isIdentifier(variable)) continue;
            collectIdentifierReadEdits(variable, latestVersions, edits);
        }
        for (const value of statement.init || []) {
            collectIdentifierReadEdits(value, latestVersions, edits);
        }
    } else if (statement.type === "CompoundAssignmentStatement") {
        // Compound assignment reads the indexed/member target and RHS before writing
        // the target back, so both sides must consume the reaching beta versions.
        collectIdentifierReadEdits(statement.variable, latestVersions, edits);
        collectIdentifierReadEdits(statement.value, latestVersions, edits);
    } else {
        return null;
    }

    if (usedVersions) {
        for (const edit of edits) usedVersions.add(edit.replacement);
    }

    const start = statement.range[0];
    const end = statement.range[1];
    return {
        text: applyTextEdits(source.slice(start, end), edits, start),
        edits,
    };
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

function isReturnSinkSafeExpression(node) {
    return isIdentifier(node) ||
        node?.type === "NilLiteral" ||
        node?.type === "BooleanLiteral" ||
        node?.type === "NumericLiteral" ||
        node?.type === "StringLiteral";
}

function isCompilerReturnRegisterRead(node, candidateNames) {
    if (isIdentifier(node)) return candidateNames.has(node.name);
    if (node?.type !== "CallExpression" || !isIdentifier(node.base, "unpack")) return false;
    const args = node.arguments || [];
    return args.length === 1 && isIdentifier(args[0]) && candidateNames.has(args[0].name);
}

function isCompilerReturnPayload(node, candidateNames) {
    if (node?.type !== "TableConstructorExpression") return false;
    return (node.fields || []).every(field =>
        field?.type === "TableValue" && isCompilerReturnRegisterRead(field.value, candidateNames)
    );
}

function canSinkTerminalReturnAcross(payload, operation) {
    const expressions = payload?.returnExpressions;
    if (!Array.isArray(expressions)) return false;
    if (expressions.length === 0) return true;
    if (operation?.returnSinkSafe !== true) return false;
    const returnedReads = new Set(payload.reads || []);
    return !returnedReads.has(operation.emittedTarget);
}

function canonicalizeTerminalReturnOperations(operations) {
    const result = [...operations];
    const finalTransitionIndex = result.findLastIndex(operation => operation.kind === "state-transition");
    if (finalTransitionIndex < 0 || finalTransitionIndex !== result.length - 1) {
        return { operations: result, moved: false };
    }
    const transition = result[finalTransitionIndex];
    if (String(transition.rhs || "").trim() !== "nil") return { operations: result, moved: false };

    const payloadIndexes = [];
    for (let index = 0; index < finalTransitionIndex; index++) {
        if (result[index].kind === "return-payload" && result[index].terminalCompilerReturnPayload === true) {
            payloadIndexes.push(index);
        }
    }
    if (payloadIndexes.length !== 1) return { operations: result, moved: false };

    const payloadIndex = payloadIndexes[0];
    if (payloadIndex === finalTransitionIndex - 1) return { operations: result, moved: false };
    const payload = result[payloadIndex];
    const crossed = result.slice(payloadIndex + 1, finalTransitionIndex);
    if (!crossed.every(operation => canSinkTerminalReturnAcross(payload, operation))) {
        return { operations: result, moved: false };
    }

    result.splice(payloadIndex, 1);
    result.splice(result.length - 1, 0, payload);
    for (let index = 0; index < result.length; index++) result[index].index = index + 1;
    return { operations: result, moved: true };
}

function parseBetaSource(source) {
    return luaparse.parse(source, {
        luaVersion: "luau",
        comments: false,
        scope: false,
        locations: false,
        ranges: true,
    });
}

function lineStart(source, offset) {
    const previous = source.lastIndexOf("\n", Math.max(0, offset - 1));
    return previous < 0 ? 0 : previous + 1;
}

function lineEnd(source, offset) {
    const next = source.indexOf("\n", offset);
    return next < 0 ? source.length : next + 1;
}

function canonicalizeTerminalReturnSource(source, stateName, returnName, movedStateIds) {
    if (!movedStateIds.size) return source;
    const ast = parseBetaSource(source);
    const vm = findVmFunction(ast);
    if (!vm) return source;
    const leaves = collectStateLeafClauses(vm.functionNode, stateName, []);
    const edits = [];

    for (const leaf of leaves) {
        const stateId = numericValue(leaf.condition.left) ?? numericValue(leaf.condition.right);
        if (!movedStateIds.has(stateId)) continue;
        const statements = (leaf.body || []).filter(statement => statement?.type !== "CommentStatement");
        if (!statements.length) continue;
        const writes = findLastSingleWrites(statements, new Set([stateName, returnName]));
        const stateWrite = writes.get(stateName);
        const returnWrite = writes.get(returnName);
        if (!stateWrite || !returnWrite) continue;
        if (!isNilLiteral(stateWrite.value) || stateWrite.index !== statements.length - 1) continue;
        if (returnWrite.index >= stateWrite.index) continue;
        if (!Array.isArray(returnWrite.statement.range) || !Array.isArray(stateWrite.statement.range)) continue;

        const returnLineStart = lineStart(source, returnWrite.statement.range[0]);
        const returnLineEnd = lineEnd(source, returnWrite.statement.range[1]);
        const stateLineStart = lineStart(source, stateWrite.statement.range[0]);
        if (returnLineStart >= returnLineEnd || returnLineEnd > stateLineStart) continue;

        const returnChunk = source.slice(returnLineStart, returnLineEnd);
        const between = source.slice(returnLineEnd, stateLineStart);
        edits.push({
            start: returnLineStart,
            end: stateLineStart,
            replacement: between + returnChunk,
        });
    }

    return edits.length ? applyTextEdits(source, edits) : source;
}

function collectPhysicalRegisterUses(node, candidateNames, declarationNodes, counts = new Map(), parent = null, parentKey = null) {
    if (!isNode(node)) return counts;
    if (node.type === "Identifier") {
        if (declarationNodes.has(node)) return counts;
        const isProperty =
            (parent?.type === "MemberExpression" && parentKey === "identifier") ||
            (parent?.type === "TableKeyString" && parentKey === "key");
        if (!isProperty && candidateNames.has(node.name)) {
            counts.set(node.name, (counts.get(node.name) || 0) + 1);
        }
        return counts;
    }
    for (const key of Object.keys(node)) {
        const value = node[key];
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectPhysicalRegisterUses(child, candidateNames, declarationNodes, counts, node, key);
        } else if (isNode(value)) {
            collectPhysicalRegisterUses(value, candidateNames, declarationNodes, counts, node, key);
        }
    }
    return counts;
}

function pruneUnusedPhysicalRegisterDeclaration(source) {
    const ast = parseBetaSource(source);
    const vm = findVmFunction(ast);
    if (!vm) return { source, pruned: 0 };
    const returnRegister = findVmReturnRegister(vm.functionNode);
    if (!returnRegister) return { source, pruned: 0 };
    const declaration = findRegisterDeclaration(vm.functionNode, returnRegister.name);
    if (!declaration || !Array.isArray(declaration.statement.range)) return { source, pruned: 0 };

    const candidateNames = new Set(declaration.variables.map(variable => variable.name));
    const declarationNodes = new Set(declaration.variables);
    const counts = collectPhysicalRegisterUses(vm.functionNode, candidateNames, declarationNodes);
    const retained = declaration.variables.filter(variable => (counts.get(variable.name) || 0) > 0);
    const pruned = declaration.variables.length - retained.length;
    if (pruned <= 0) return { source, pruned: 0 };

    const replacement = retained.length ? `local ${retained.map(variable => variable.name).join(", ")}` : "";
    return {
        source: applyTextEdits(source, [{
            start: declaration.statement.range[0],
            end: declaration.statement.range[1],
            replacement,
        }]),
        pruned,
    };
}

function collectClosureEntryStates(rootNode) {
    const entries = new Set();
    function walk(node) {
        if (!isNode(node)) return;
        if (node.type === "CallExpression" && isIdentifier(node.base) && /^createClosure(?:\d+)?$/.test(node.base.name)) {
            const entry = numericValue((node.arguments || [])[0]);
            if (entry !== null) entries.add(entry);
        }
        for (const key of Object.keys(node)) {
            const value = node[key];
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

function successorsFromTerminator(terminator) {
    if (terminator?.kind === "jump") return [terminator.target];
    if (terminator?.kind === "branch") return [terminator.onTrue, terminator.onFalse];
    if (terminator?.kind === "stop") return [];
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
    // Definition sets are immutable after publication; writes replace an entry's
    // whole Set, so reaching maps can use copy-on-write instead of deep cloning.
    return new Map(map || []);
}

function mergeDefinitionMaps(maps, entryState, candidateNames, singletonDefinitionSet = null) {
    const merged = maps.length ? new Map(maps[0] || []) : new Map();
    const owned = new Set();
    for (let mapIndex = 1; mapIndex < maps.length; mapIndex++) {
        for (const [name, defs] of maps[mapIndex] || []) {
            const existing = merged.get(name);
            if (!existing) {
                merged.set(name, defs);
                continue;
            }
            if (existing === defs) continue;
            let needsUnion = false;
            for (const def of defs) {
                if (!existing.has(def)) { needsUnion = true; break; }
            }
            if (!needsUnion) continue;
            let target = existing;
            if (!owned.has(name)) {
                target = new Set(existing);
                merged.set(name, target);
                owned.add(name);
            }
            for (const def of defs) target.add(def);
        }
    }
    if (entryState !== null) {
        for (const name of candidateNames) {
            const entryDefinition = `u:entry:${entryState}:${name}`;
            let target = merged.get(name);
            if (!target) {
                if (singletonDefinitionSet) {
                    merged.set(name, singletonDefinitionSet(entryDefinition));
                    continue;
                }
                target = new Set();
                merged.set(name, target);
                owned.add(name);
            } else if (!owned.has(name)) {
                if (target.has(entryDefinition)) continue;
                target = new Set(target);
                merged.set(name, target);
                owned.add(name);
            }
            target.add(entryDefinition);
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
    let orderedEffectWriteCount = 0;
    let nativeCompoundWriteCount = 0;

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
            isCompilerReturnPayload(finalReturnWrite.value, candidateNames) &&
            isNilLiteral(finalStateWrite.value) &&
            finalReturnWrite.index < finalStateWrite.index;

        const plans = new Map();
        const lastDefinitions = new Map();

        for (let statementIndex = 0; statementIndex < statements.length; statementIndex++) {
            const statement = statements[statementIndex];
            if (isOrderedEffectAssignment(statement)) {
                plans.set(statement, { kind: "effect-write" });
                orderedEffectWriteCount++;
                continue;
            }
            if (isSimpleRegisterCompoundAssignment(statement, candidateNames, specialFinalNames)) {
                const originalName = statement.variable.name;
                const baseId = ensureBase(originalName);
                const version = (versionCounts.get(originalName) || 0) + 1;
                versionCounts.set(originalName, version);
                const newName = `r_v${baseId}_${version}`;
                plans.set(statement, {
                    kind: "compound-write",
                    originalName,
                    newName,
                    baseId,
                    version,
                    compoundOperator: statement.op,
                });
                lastDefinitions.set(originalName, `v:${newName}`);
                versions.push({ blockState: stateId, originalName, baseId, version, newName });
                nativeCompoundWriteCount++;
                continue;
            }
            if (statement?.type === "CompoundAssignmentStatement") {
                plans.set(statement, { kind: "effect-write" });
                orderedEffectWriteCount++;
                continue;
            }
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const init = statement.init || [];

            if (isAtomicMultiCallAssignment(statement, candidateNames)) {
                const targetPlans = [];
                for (const variable of variables) {
                    const originalName = variable.name;
                    if (specialFinalNames.has(originalName)) {
                        const rawDefinition = `u:${stateId}:${statement.range?.[0] ?? statementIndex}:${originalName}`;
                        lastDefinitions.set(originalName, rawDefinition);
                        targetPlans.push({ originalName, newName: originalName, preservePhysical: true });
                        continue;
                    }
                    const baseId = ensureBase(originalName);
                    const version = (versionCounts.get(originalName) || 0) + 1;
                    versionCounts.set(originalName, version);
                    const newName = `r_v${baseId}_${version}`;
                    targetPlans.push({ originalName, newName, baseId, version });
                    lastDefinitions.set(originalName, `v:${newName}`);
                    versions.push({ blockState: stateId, originalName, baseId, version, newName });
                }
                plans.set(statement, { kind: "multi-call-write", targets: targetPlans });
                continue;
            }

            if (isAtomicParallelAssignment(statement, candidateNames)) {
                const targetPlans = [];
                const planByRegister = new Map();
                for (const variable of variables) {
                    if (!isIdentifier(variable) || !candidateNames.has(variable.name)) {
                        targetPlans.push(null);
                        continue;
                    }
                    const originalName = variable.name;
                    let targetPlan = planByRegister.get(originalName);
                    if (!targetPlan) {
                        if (specialFinalNames.has(originalName)) {
                            const rawDefinition = `u:${stateId}:${statement.range?.[0] ?? statementIndex}:${originalName}`;
                            lastDefinitions.set(originalName, rawDefinition);
                            targetPlan = { originalName, newName: originalName, preservePhysical: true };
                        } else {
                            const baseId = ensureBase(originalName);
                            const version = (versionCounts.get(originalName) || 0) + 1;
                            versionCounts.set(originalName, version);
                            const newName = `r_v${baseId}_${version}`;
                            targetPlan = { originalName, newName, baseId, version };
                            lastDefinitions.set(originalName, `v:${newName}`);
                            versions.push({ blockState: stateId, originalName, baseId, version, newName });
                        }
                        planByRegister.set(originalName, targetPlan);
                    }
                    targetPlans.push(targetPlan);
                }
                plans.set(statement, { kind: "multi-write", targets: targetPlans });
                continue;
            }

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

        const terminator = analyzeBlockTerminator(statements, stateName, source);
        const successors = successorsFromTerminator(terminator);
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

    const lifetimeAnalysis = cfgComplete
        ? analyzeBetaRegisterLifetimes({
            blocks,
            candidateNames,
            stateName,
            returnName,
            closureEntries,
        })
        : null;

    if (cfgComplete) {
        const epochByStatement = lifetimeAnalysis?.converged ? lifetimeAnalysis.epochByStatement : new Map();
        const epochByStatementAndName = lifetimeAnalysis?.converged ? lifetimeAnalysis.epochByStatementAndName : new Map();
        const epochNames = new Map();
        const oldVersionInfo = new Map();
        versionCounts.clear();
        versions.length = 0;

        function statementEpoch(statement, originalName, allowStatementFallback = false) {
            const key = `${statement?.range?.[0] ?? "?"}\0${originalName}`;
            return epochByStatementAndName?.get(key) || (allowStatementFallback ? epochByStatement.get(statement) : null);
        }

        function remapVersionPlan(targetPlan, statement, blockState, allowStatementFallback = false) {
            if (!targetPlan || targetPlan.preservePhysical) return;
            const oldName = targetPlan.newName;
            const epoch = statementEpoch(statement, targetPlan.originalName, allowStatementFallback);
            let newName;
            let version;
            let declareVersion = true;

            const isReturnJoinEpoch = epoch?.kind === "return-join";
            if (epoch && targetPlan.originalName !== stateName && (targetPlan.originalName !== returnName || isReturnJoinEpoch)) {
                const epochKey = targetPlan.originalName + "\0" + epoch.key;
                let existing = epochNames.get(epochKey);
                if (!existing) {
                    version = (versionCounts.get(targetPlan.originalName) || 0) + 1;
                    versionCounts.set(targetPlan.originalName, version);
                    const baseId = ensureBase(targetPlan.originalName);
                    existing = { newName: `r_v${baseId}_${version}`, version, declared: false };
                    epochNames.set(epochKey, existing);
                }
                newName = existing.newName;
                version = existing.version;
                if (isReturnJoinEpoch) {
                    declareVersion = epoch.declareHere === true;
                    if (declareVersion) existing.declared = true;
                } else {
                    declareVersion = !existing.declared;
                    existing.declared = true;
                }
                targetPlan.isLifetimeKill = epoch.isKill;
                targetPlan.registerEpoch = epoch.key;
            } else {
                version = (versionCounts.get(targetPlan.originalName) || 0) + 1;
                versionCounts.set(targetPlan.originalName, version);
                const baseId = ensureBase(targetPlan.originalName);
                newName = `r_v${baseId}_${version}`;
            }

            targetPlan.oldName = oldName;
            targetPlan.newName = newName;
            targetPlan.version = version;
            targetPlan.declareVersion = declareVersion;
            oldVersionInfo.set(oldName, { newName, isKill: targetPlan.isLifetimeKill === true });
            versions.push({
                blockState,
                originalName: targetPlan.originalName,
                baseId: ensureBase(targetPlan.originalName),
                version,
                newName,
            });
        }

        for (const block of blocks) {
            for (const statement of block.statements) {
                const plan = block.plans.get(statement);
                if (plan?.kind === "versioned" || plan?.kind === "compound-write") {
                    remapVersionPlan(plan, statement, block.stateId, true);
                    continue;
                }
                if (plan?.kind === "multi-call-write" || plan?.kind === "multi-write") {
                    for (const targetPlan of new Set((plan.targets || []).filter(Boolean))) {
                        remapVersionPlan(targetPlan, statement, block.stateId, false);
                    }
                }
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
                        ? `u:epoch-kill:${block.stateId}:${name}`
                        : `v:${info.newName}`
                );
            }
        }
    } else {
        for (const block of blocks) {
            for (const statement of block.statements) {
                const plan = block.plans.get(statement);
                if (plan?.kind === "versioned" || plan?.kind === "compound-write") plan.declareVersion = true;
                if (plan?.kind === "multi-call-write" || plan?.kind === "multi-write") {
                    for (const targetPlan of new Set((plan.targets || []).filter(Boolean))) {
                        if (!targetPlan.preservePhysical) targetPlan.declareVersion = true;
                    }
                }
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
    const emptyDefinitions = new Map();

    // Definition Sets are immutable once published. Cache every singleton once
    // and precompute each block's final transfer map so worklist revisits do not
    // allocate the same one-element Sets repeatedly.
    const singletonDefinitionSets = new Map();
    function singletonDefinitionSet(definition) {
        let set = singletonDefinitionSets.get(definition);
        if (!set) {
            set = new Set([definition]);
            singletonDefinitionSets.set(definition, set);
        }
        return set;
    }
    const transferDefinitionsByState = new Map();
    for (const block of blocks) {
        if (!block.lastDefinitions?.size) continue;
        const transfer = new Map();
        for (const [name, definition] of block.lastDefinitions) {
            transfer.set(name, singletonDefinitionSet(definition));
        }
        transferDefinitionsByState.set(block.stateId, transfer);
    }

    const entryDefinitionMaps = new Map();
    function entryDefinitionMap(stateId) {
        let map = entryDefinitionMaps.get(stateId);
        if (map) return map;
        map = new Map();
        for (const name of candidateNames) {
            map.set(name, singletonDefinitionSet(`u:entry:${stateId}:${name}`));
        }
        entryDefinitionMaps.set(stateId, map);
        return map;
    }

    if (cfgComplete) {
        // Worklist reaching definitions. A version can cross a state boundary only
        // when every incoming path reaches that state with exactly the same version.
        const queue = [...blocks];
        const queued = new Set(queue.map(block => block.stateId));
        let cursor = 0;
        while (cursor < queue.length) {
            const block = queue[cursor++];
            queued.delete(block.stateId);
            const predBlocks = predecessors.get(block.stateId) || [];
            const isEntry = closureEntries.has(block.stateId) || predBlocks.length === 0;
            let nextIn;
            if (isEntry && predBlocks.length === 0) {
                nextIn = entryDefinitionMap(block.stateId);
            } else if (!isEntry && predBlocks.length === 1) {
                nextIn = outDefinitions.get(predBlocks[0].stateId) || emptyDefinitions;
            } else {
                const predMaps = predBlocks.map(pred => outDefinitions.get(pred.stateId));
                if (isEntry) predMaps.push(entryDefinitionMap(block.stateId));
                nextIn = mergeDefinitionMaps(predMaps, null, candidateNames, singletonDefinitionSet);
            }
            const transfer = transferDefinitionsByState.get(block.stateId);
            let nextOut = nextIn;
            if (transfer?.size) {
                nextOut = cloneSetMap(nextIn);
                for (const [name, set] of transfer) nextOut.set(name, set);
            }

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
    // metadata so developer tools can visualize CFG + register-epoch flow without re-deriving it.
    const edits = [];
    const graphStates = [];
    const uniqueVersionBaseCache = new WeakMap();
    function initialUniqueVersions(definitions) {
        let base = uniqueVersionBaseCache.get(definitions);
        if (!base) {
            base = uniqueVersionMap(definitions);
            uniqueVersionBaseCache.set(definitions, base);
        }
        // The per-block map is mutated while statements are replayed. Clone only
        // the compact unique-version map, not the full reaching-definition map.
        return new Map(base);
    }
    for (const block of blocks) {
        const graphOperations = [];
        const latestVersions = cfgComplete
            ? initialUniqueVersions(inDefinitions.get(block.stateId) || emptyDefinitions)
            : new Map();
        const incomingVersionNames = new Set(latestVersions.values());

        for (const statement of block.statements) {
            const plan = block.plans.get(statement);
            if (plan?.kind === "effect-write") {
                const usedVersions = new Set();
                const rewritten = rewriteUnsupportedAssignmentReads(source, statement, latestVersions, usedVersions);
                if (!rewritten) {
                    graphOperations.push({
                        index: graphOperations.length + 1,
                        kind: "unsupported",
                        originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                        emittedText: source.slice(statement.range[0], statement.range[1]).trim(),
                        reads: [],
                    });
                    continue;
                }
                for (const edit of rewritten.edits) edits.push(edit);
                for (const versionName of usedVersions) {
                    if (incomingVersionNames.has(versionName)) crossBlockUsedVersions.add(versionName);
                }
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "effect-write",
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: rewritten.text.trim(),
                    reads: [...usedVersions],
                });
                continue;
            }

            if (plan?.kind === "compound-write") {
                const usedVersions = new Set();
                const rhs = rewriteExpression(source, statement.value, latestVersions, usedVersions);
                const priorName = latestVersions.get(plan.originalName) || null;
                if (priorName) usedVersions.add(priorName);
                for (const versionName of usedVersions) {
                    if (incomingVersionNames.has(versionName)) crossBlockUsedVersions.add(versionName);
                }

                if (rhs !== null && priorName && priorName === plan.newName && plan.declareVersion === false) {
                    const emittedText = `${plan.newName} ${plan.compoundOperator}= ${rhs}`;
                    edits.push({ start: statement.range[0], end: statement.range[1], replacement: emittedText });
                    graphOperations.push({
                        index: graphOperations.length + 1,
                        kind: "epoch-mutate",
                        originalTarget: plan.originalName,
                        emittedTarget: plan.newName,
                        rhs,
                        compoundOperator: plan.compoundOperator,
                        reads: [...usedVersions],
                        returnSinkSafe: false,
                        originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                        emittedText,
                        registerEpoch: plan.registerEpoch || null,
                    });
                    latestVersions.set(plan.originalName, plan.newName);
                    continue;
                }

                if (rhs !== null && priorName) {
                    const declarationPrefix = plan.declareVersion === false ? "" : "local ";
                    const emittedText = `${declarationPrefix}${plan.newName} = ${priorName} ${plan.compoundOperator} (${rhs})`;
                    edits.push({ start: statement.range[0], end: statement.range[1], replacement: emittedText });
                    graphOperations.push({
                        index: graphOperations.length + 1,
                        kind: plan.registerEpoch ? (plan.declareVersion === false ? "epoch-mutate" : "epoch-start") : "version-define",
                        originalTarget: plan.originalName,
                        emittedTarget: plan.newName,
                        rhs: `${priorName} ${plan.compoundOperator} (${rhs})`,
                        compoundOperator: plan.compoundOperator,
                        reads: [...usedVersions],
                        returnSinkSafe: false,
                        originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                        emittedText,
                        registerEpoch: plan.registerEpoch || null,
                    });
                    latestVersions.set(plan.originalName, plan.newName);
                    continue;
                }

                const rewritten = rewriteUnsupportedAssignmentReads(source, statement, latestVersions, usedVersions);
                if (rewritten) {
                    for (const edit of rewritten.edits) edits.push(edit);
                }
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "unsupported",
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: rewritten?.text?.trim() || source.slice(statement.range[0], statement.range[1]).trim(),
                    reads: [...usedVersions],
                });
                latestVersions.delete(plan.originalName);
                continue;
            }

            if (statement?.type !== "AssignmentStatement") {
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "statement",
                    originalText: Array.isArray(statement?.range) ? source.slice(statement.range[0], statement.range[1]).trim() : String(statement?.type || "unknown"),
                    reads: [],
                });
                continue;
            }
            const variables = statement.variables || [];
            const init = statement.init || [];

            if (plan?.kind === "multi-write") {
                const usedVersions = new Set();
                const rewritten = rewriteUnsupportedAssignmentReads(source, statement, latestVersions, usedVersions);
                if (!rewritten) {
                    graphOperations.push({
                        index: graphOperations.length + 1,
                        kind: "unsupported",
                        originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                        emittedText: source.slice(statement.range[0], statement.range[1]).trim(),
                        reads: [],
                    });
                    for (const targetPlan of new Set((plan.targets || []).filter(Boolean))) {
                        latestVersions.delete(targetPlan.originalName);
                    }
                    continue;
                }

                const targetPlans = plan.targets || [];
                const targetEdits = [...rewritten.edits];
                const candidateOriginalTargets = [];
                const candidateEmittedTargets = [];
                const candidateEpochs = [];
                const candidateDeclarations = [];
                const declarationNames = [];
                const declared = new Set();
                for (let index = 0; index < variables.length; index++) {
                    const targetPlan = targetPlans[index];
                    if (!targetPlan) continue;
                    targetEdits.push({
                        start: variables[index].range[0],
                        end: variables[index].range[1],
                        replacement: targetPlan.newName,
                    });
                    candidateOriginalTargets.push(targetPlan.originalName);
                    candidateEmittedTargets.push(targetPlan.newName);
                    candidateEpochs.push(targetPlan.registerEpoch || null);
                    const shouldDeclare = !targetPlan.preservePhysical && targetPlan.declareVersion !== false;
                    candidateDeclarations.push(shouldDeclare);
                    if (shouldDeclare && !declared.has(targetPlan.newName)) {
                        declared.add(targetPlan.newName);
                        declarationNames.push(targetPlan.newName);
                    }
                }
                for (const versionName of usedVersions) {
                    if (incomingVersionNames.has(versionName)) crossBlockUsedVersions.add(versionName);
                }
                const assignmentText = applyTextEdits(
                    source.slice(statement.range[0], statement.range[1]),
                    targetEdits,
                    statement.range[0]
                ).trim();
                const declarationText = declarationNames.length ? `local ${declarationNames.join(", ")}\n` : "";
                edits.push({
                    start: statement.range[0],
                    end: statement.range[1],
                    replacement: declarationText + assignmentText,
                });
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "multi-write",
                    originalTargets: candidateOriginalTargets,
                    emittedTargets: candidateEmittedTargets,
                    targetRegisterEpochs: candidateEpochs,
                    targetDeclarations: candidateDeclarations,
                    reads: [...usedVersions],
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: assignmentText,
                    returnSinkSafe: false,
                });
                for (const targetPlan of new Set(targetPlans.filter(Boolean))) {
                    if (targetPlan.preservePhysical) latestVersions.delete(targetPlan.originalName);
                    else latestVersions.set(targetPlan.originalName, targetPlan.newName);
                }
                continue;
            }

            if (plan?.kind === "multi-call-write") {
                const usedVersions = new Set();
                const rhs = rewriteExpression(source, init[0], latestVersions, usedVersions);
                if (rhs === null) {
                    graphOperations.push({
                        index: graphOperations.length + 1,
                        kind: "unsupported",
                        originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                        emittedText: source.slice(statement.range[0], statement.range[1]).trim(),
                        reads: [],
                    });
                    for (const variable of variables) latestVersions.delete(variable.name);
                    continue;
                }
                for (const versionName of usedVersions) {
                    if (incomingVersionNames.has(versionName)) crossBlockUsedVersions.add(versionName);
                }
                const call = init[0];
                const callBaseOriginal = isIdentifier(call.base) ? call.base.name : null;
                const callArgumentOriginals = (call.arguments || []).map(argument => isIdentifier(argument) ? argument.name : null);
                const originalTargets = variables.map(variable => variable.name);
                const targetPlans = plan.targets || [];
                const emittedTargets = targetPlans.map((targetPlan, index) => targetPlan?.newName || originalTargets[index]);
                const declarations = targetPlans
                    .filter(targetPlan => targetPlan && !targetPlan.preservePhysical && targetPlan.declareVersion !== false)
                    .map(targetPlan => targetPlan.newName);
                let emittedSource;
                if (declarations.length === emittedTargets.length && targetPlans.every(targetPlan => !targetPlan?.preservePhysical)) {
                    emittedSource = `local ${emittedTargets.join(", ")} = ${rhs}`;
                } else {
                    const declarationText = declarations.length ? `local ${declarations.join(", ")}\n` : "";
                    emittedSource = `${declarationText}${emittedTargets.join(", ")} = ${rhs}`;
                }
                edits.push({ start: statement.range[0], end: statement.range[1], replacement: emittedSource });
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "multi-call-write",
                    originalTargets: [...originalTargets],
                    emittedTargets: [...emittedTargets],
                    targetRegisterEpochs: targetPlans.map(targetPlan => targetPlan?.registerEpoch || null),
                    targetDeclarations: targetPlans.map(targetPlan => Boolean(targetPlan && !targetPlan.preservePhysical && targetPlan.declareVersion !== false)),
                    callBaseOriginal,
                    callArgumentOriginals,
                    rhs,
                    reads: [...usedVersions],
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: `${emittedTargets.join(", ")} = ${rhs}`,
                    returnSinkSafe: false,
                });
                for (let index = 0; index < originalTargets.length; index++) {
                    const targetPlan = targetPlans[index];
                    if (!targetPlan || targetPlan.preservePhysical) latestVersions.delete(originalTargets[index]);
                    else latestVersions.set(originalTargets[index], targetPlan.newName);
                }
                continue;
            }

            if (!plan || plan.kind === "unsupported") {
                const usedVersions = new Set();
                const rewritten = rewriteUnsupportedAssignmentReads(source, statement, latestVersions, usedVersions);
                if (rewritten) {
                    for (const edit of rewritten.edits) edits.push(edit);
                    for (const versionName of usedVersions) {
                        if (incomingVersionNames.has(versionName)) crossBlockUsedVersions.add(versionName);
                    }
                }
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: "unsupported",
                    originalText: Array.isArray(statement.range) ? source.slice(statement.range[0], statement.range[1]).trim() : "",
                    emittedText: rewritten?.text?.trim() || (Array.isArray(statement.range) ? source.slice(statement.range[0], statement.range[1]).trim() : ""),
                    reads: [...usedVersions],
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
                    returnSinkSafe: isReturnSinkSafeExpression(init[0]),
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText: `${variables[0].name} = ${rhs}`,
                });
                continue;
            }

            if (plan.kind === "preserved") {
                const originalRhs = source.slice(init[0].range[0], init[0].range[1]);
                if (rhs !== originalRhs) edits.push({ start: init[0].range[0], end: init[0].range[1], replacement: rhs });
                const terminalCompilerReturnPayload =
                    plan.originalName === returnName && isCompilerReturnPayload(init[0], candidateNames);
                const returnExpressions = terminalCompilerReturnPayload
                    ? (init[0].fields || []).map(field => rewriteExpression(source, field.value, latestVersions))
                    : null;
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: plan.originalName === stateName ? "state-transition" : "return-payload",
                    terminalCompilerReturnPayload,
                    returnExpressions,
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
                const isRegisterEpoch = Boolean(plan.registerEpoch);
                graphOperations.push({
                    index: graphOperations.length + 1,
                    kind: plan.isLifetimeKill
                        ? "epoch-kill"
                        : (isRegisterEpoch ? (plan.declareVersion === false ? "epoch-mutate" : "epoch-start") : "version-define"),
                    originalTarget: plan.originalName,
                    emittedTarget: plan.newName,
                    rhs,
                    reads: [...usedVersions],
                    returnSinkSafe: isReturnSinkSafeExpression(init[0]),
                    originalText: source.slice(statement.range[0], statement.range[1]).trim(),
                    emittedText,
                    registerEpoch: plan.registerEpoch || null,
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

    let output = applyTextEdits(source, edits);
    const movedTerminalReturnStates = new Set();
    for (const state of graphStates) {
        const canonical = canonicalizeTerminalReturnOperations(state.operations);
        state.operations = canonical.operations;
        if (canonical.moved) movedTerminalReturnStates.add(state.id);
    }
    output = canonicalizeTerminalReturnSource(output, stateName, returnName, movedTerminalReturnStates);
    const physicalRegisterCleanup = pruneUnusedPhysicalRegisterDeclaration(output);
    output = physicalRegisterCleanup.source;

    const registerEpochNames = new Set();
    for (const state of graphStates) {
        for (const operation of state.operations) {
            if (operation.registerEpoch && operation.emittedTarget) registerEpochNames.add(operation.emittedTarget);
        }
    }
    const epochByName = new Map();
    for (const name of registerEpochNames) epochByName.set(name, { name, originalRegister: null, events: [] });
    for (const state of graphStates) {
        for (const operation of state.operations) {
            if (operation.registerEpoch && operation.emittedTarget && epochByName.has(operation.emittedTarget)) {
                const epochInfo = epochByName.get(operation.emittedTarget);
                epochInfo.originalRegister ||= operation.originalTarget;
                epochInfo.events.push({
                    state: state.id,
                    operation: operation.index,
                    kind: operation.kind === "epoch-start" ? "start" : operation.kind === "epoch-mutate" ? "mutate" : "kill",
                    text: operation.emittedText || `${operation.emittedTarget} = ${operation.rhs}`,
                });
            }
            for (const read of operation.reads || []) {
                const epochInfo = epochByName.get(read);
                if (!epochInfo) continue;
                epochInfo.events.push({
                    state: state.id,
                    operation: operation.index,
                    kind: "read",
                    text: operation.emittedText || operation.originalText || `${operation.emittedTarget || "?"} = ${operation.rhs || "?"}`,
                });
            }
        }
    }
    const kindOrder = { start: 0, read: 1, mutate: 2, kill: 3 };
    for (const epochInfo of epochByName.values()) {
        epochInfo.events.sort((left, right) => left.state - right.state || left.operation - right.operation || kindOrder[left.kind] - kindOrder[right.kind]);
    }
    const graph = {
        stateName,
        returnName,
        cfgComplete,
        entries: [...closureEntries].sort((left, right) => left - right),
        states: graphStates.sort((left, right) => left.id - right.id),
        analysis: lifetimeAnalysis?.stats || null,
        epochs: [...epochByName.values()].sort((left, right) => NUMERIC_NAME_COLLATOR.compare(left.name, right.name)),
    };

    return {
        source: output,
        found: true,
        applied: output !== source,
        blockCount: leaves.length,
        versionedAssignmentCount: versions.length,
        preservedFinalWrites,
        orderedEffectWriteCount,
        nativeCompoundWriteCount,
        skippedAssignments,
        cfgComplete,
        crossBlockVersionCount: crossBlockUsedVersions.size,
        terminalReturnPlacementMoves: movedTerminalReturnStates.size,
        prunedPhysicalRegisterDeclarations: physicalRegisterCleanup.pruned,
        mapping: [...baseIds.entries()].map(([originalName, baseId]) => ({ originalName, baseName: `r_v${baseId}` })),
        versions,
        edits,
        graph,
        lifetimeAnalysisStats: lifetimeAnalysis?.stats || null,
    };
}

function betaOperationSourceStatementCount(operation) {
    if (operation?.kind !== "multi-write" && operation?.kind !== "multi-call-write") return 1;
    const declarations = (operation.targetDeclarations || []).filter(Boolean).length;
    if (!declarations) return 1;
    if (
        operation.kind === "multi-call-write" &&
        declarations === (operation.emittedTargets || []).length &&
        (operation.targetDeclarations || []).every(Boolean)
    ) return 1;
    return 2;
}

function renderRecoveredBetaOperation(operation) {
    const text = String(operation?.emittedText || "").trim();
    if (!text) return "";
    if (operation.kind !== "multi-write" && operation.kind !== "multi-call-write") return text;
    const targets = operation.emittedTargets || [];
    const declarationNames = targets.filter((_, index) => operation.targetDeclarations?.[index]);
    if (!declarationNames.length) return text;
    if (
        operation.kind === "multi-call-write" &&
        declarationNames.length === targets.length &&
        (operation.targetDeclarations || []).every(Boolean)
    ) return `local ${text}`;
    return `local ${[...new Set(declarationNames)].join(", ")}\n${text}`;
}

function assignBetaSourceOperationIds(graph) {
    for (const state of graph.states || []) {
        for (let index = 0; index < (state.operations || []).length; index++) {
            state.operations[index].betaSourceOperationId = `${state.id}:${index + 1}`;
        }
    }
}

function mapBetaSourceOperationRanges(betaResult) {
    const source = betaResult.source;
    let ast;
    try {
        ast = parseBetaSource(source);
    } catch (error) {
        return { safe: false, reason: `Beta upvalue source parse failed: ${error.message}` };
    }
    const vm = findVmFunction(ast);
    if (!vm) return { safe: false, reason: "Beta upvalue source VM function not found" };
    const leaves = collectStateLeafClauses(vm.functionNode, betaResult.graph.stateName, []);
    const statementsByState = new Map();
    for (const leaf of leaves) {
        const stateId = numericValue(leaf.condition.left) ?? numericValue(leaf.condition.right);
        if (!Number.isInteger(stateId) || statementsByState.has(stateId)) {
            return { safe: false, reason: `Beta upvalue source has ambiguous state leaf ${stateId}` };
        }
        statementsByState.set(stateId, (leaf.body || []).filter(statement => statement?.type !== "CommentStatement"));
    }

    const ranges = new Map();
    for (const state of betaResult.graph.states || []) {
        const statements = statementsByState.get(state.id);
        if (!statements) return { safe: false, reason: `Beta upvalue source is missing state ${state.id}` };
        let statementIndex = 0;
        for (const operation of state.operations || []) {
            const count = betaOperationSourceStatementCount(operation);
            const first = statements[statementIndex];
            const last = statements[statementIndex + count - 1];
            if (!operation.betaSourceOperationId || !Array.isArray(first?.range) || !Array.isArray(last?.range)) {
                return { safe: false, reason: `Beta upvalue source state ${state.id} lost operation ownership at ${operation.index}` };
            }
            ranges.set(operation.betaSourceOperationId, [first.range[0], last.range[1]]);
            statementIndex += count;
        }
        if (statementIndex !== statements.length) {
            return { safe: false, reason: `Beta upvalue source state ${state.id} statement/operation mismatch ${statements.length}/${statementIndex}` };
        }
    }
    return { safe: true, ranges };
}

function finalizeBetaRegisterUpvalues(betaResult) {
    if (!betaResult?.graph || !betaResult.applied) return betaResult;
    assignBetaSourceOperationIds(betaResult.graph);
    const ownership = mapBetaSourceOperationRanges(betaResult);
    if (!ownership.safe) {
        betaResult.upvalueRecovery = { completed: true, applied: false, safe: false, reason: ownership.reason };
        return betaResult;
    }

    const recovered = recoverBetaUpvalues(betaResult);
    const recovery = {
        completed: true,
        applied: Boolean(recovered.applied),
        safe: Boolean(recovered.safe),
        reason: recovered.reason || null,
        stats: recovered.stats || null,
        cells: recovered.cells || [],
        captures: recovered.captures || [],
        sourceEditCount: 0,
    };
    if (!recovered.safe) {
        betaResult.upvalueRecovery = recovery;
        return betaResult;
    }
    if (!recovered.applied) {
        betaResult.upvalueRecovery = recovery;
        return betaResult;
    }

    const recoveredById = new Map();
    for (const state of recovered.graph.states || []) {
        for (const operation of state.operations || []) {
            if (!operation.betaSourceOperationId || recoveredById.has(operation.betaSourceOperationId)) {
                recovery.safe = false;
                recovery.reason = `Recovered beta upvalue graph has ambiguous operation ownership in state ${state.id}`;
                betaResult.upvalueRecovery = recovery;
                return betaResult;
            }
            recoveredById.set(operation.betaSourceOperationId, operation);
        }
    }

    const edits = [];
    for (const state of betaResult.graph.states || []) {
        for (const operation of state.operations || []) {
            const id = operation.betaSourceOperationId;
            const range = ownership.ranges.get(id);
            const next = recoveredById.get(id);
            if (!range) {
                recovery.safe = false;
                recovery.reason = `Recovered beta upvalue source lost operation ${id}`;
                betaResult.upvalueRecovery = recovery;
                return betaResult;
            }
            if (!next) {
                edits.push({ start: range[0], end: range[1], replacement: "" });
                continue;
            }
            const before = renderRecoveredBetaOperation(operation);
            const after = renderRecoveredBetaOperation(next);
            if (before !== after) edits.push({ start: range[0], end: range[1], replacement: after });
        }
    }

    let output = applyTextEdits(betaResult.source, edits);
    const cleanup = pruneUnusedPhysicalRegisterDeclaration(output);
    output = cleanup.source;
    try {
        parseBetaSource(output);
    } catch (error) {
        recovery.safe = false;
        recovery.reason = `Recovered beta upvalue source reparse failed: ${error.message}`;
        betaResult.upvalueRecovery = recovery;
        return betaResult;
    }

    recovery.sourceEditCount = edits.length;
    betaResult.source = output;
    betaResult.graph = recovered.graph;
    betaResult.upvalueRecovery = recovery;
    betaResult.prunedPhysicalRegisterDeclarations =
        (betaResult.prunedPhysicalRegisterDeclarations || 0) + (cleanup.pruned || 0);
    return betaResult;
}

module.exports = {
    versionVmBlockRegisters,
    finalizeBetaRegisterUpvalues,
};
