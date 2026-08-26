const { parseLua, parseLuaStructural } = require("../main");
const { applyTextEdits } = require("./text-edits");

const LUA_KEYWORDS = new Set([
    "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto",
    "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while",
    "continue", "type", "export"
]);

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function sourceOf(source, node) {
    return Array.isArray(node?.range) ? source.slice(node.range[0], node.range[1]) : "";
}

function isLiteral(node) {
    return node?.type === "StringLiteral" ||
        node?.type === "NumericLiteral" ||
        node?.type === "BooleanLiteral" ||
        node?.type === "NilLiteral";
}

function isNoEffectExpression(node) {
    if (!isNode(node)) return true;
    if (isLiteral(node) || node.type === "Identifier" || node.type === "VarargLiteral") return true;
    if (node.type === "UnaryExpression") return isNoEffectExpression(node.argument);
    if (node.type === "BinaryExpression" || node.type === "LogicalExpression") {
        return isNoEffectExpression(node.left) && isNoEffectExpression(node.right);
    }
    if (node.type === "TableConstructorExpression") {
        return (node.fields || []).every(field => {
            if (field.type === "TableKey") return isNoEffectExpression(field.key) && isNoEffectExpression(field.value);
            return isNoEffectExpression(field.value);
        });
    }
    // Creating a closure does not execute its body.
    if (node.type === "FunctionDeclaration" && !node.identifier) return true;
    return false;
}

function isStandaloneCall(node) {
    return node?.type === "CallExpression" || node?.type === "TableCallExpression" || node?.type === "StringCallExpression";
}

function directLocalInfo(statement) {
    if (statement?.type !== "LocalStatement") return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0]) || !Array.isArray(statement.range)) return null;
    return { name: variables[0].name, variable: variables[0], init: init[0] };
}

function directLocalOrUninitializedInfo(statement) {
    const initialized = directLocalInfo(statement);
    if (initialized) return initialized;
    if (statement?.type !== "LocalStatement") return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 0 || !isIdentifier(variables[0]) || !Array.isArray(statement.range)) return null;
    return { name: variables[0].name, variable: variables[0], init: null };
}

function isDirectWriteIdentifier(node, parent, key) {
    if (!isIdentifier(node) || !parent) return false;
    if ((parent.type === "AssignmentStatement" || parent.type === "LocalStatement") && key === "variables") return true;
    if (parent.type === "CompoundAssignmentStatement" && key === "variable" && isIdentifier(parent.variable)) return true;
    if ((parent.type === "ForNumericStatement" || parent.type === "ForGenericStatement") && key === "variable") return true;
    return false;
}

function isNonReadIdentifier(node, parent, key) {
    if (!isIdentifier(node) || !parent) return false;
    if (parent.type === "MemberExpression" && key === "identifier") return true;
    if (parent.type === "TableKeyString" && key === "key") return true;
    if ((parent.type === "LocalStatement" || parent.type === "AssignmentStatement") && key === "variables") return true;
    if (parent.type === "CompoundAssignmentStatement" && key === "variable" && isIdentifier(parent.variable)) return false;
    if ((parent.type === "FunctionDeclaration") && (key === "identifier" || key === "parameters")) return true;
    if ((parent.type === "ForNumericStatement" || parent.type === "ForGenericStatement") && (key === "variable" || key === "variables")) return true;
    return false;
}

function containsNameRaw(node, name) {
    let found = false;
    function visit(value, parent = null, key = null) {
        if (found || !value) return;
        if (Array.isArray(value)) {
            for (const child of value) visit(child, parent, key);
            return;
        }
        if (!isNode(value)) return;
        if (isIdentifier(value, name) && (!isNonReadIdentifier(value, parent, key) || (parent?.type === "AssignmentStatement" && key === "variables"))) {
            found = true;
            return;
        }
        for (const childKey of Object.keys(value)) {
            if (childKey === "range" || childKey === "loc") continue;
            visit(value[childKey], value, childKey);
        }
    }
    visit(node);
    return found;
}

function scanNameInNode(node, name, result, topIndex, parent = null, key = null, root = true) {
    if (!node) return;
    if (Array.isArray(node)) {
        for (const child of node) scanNameInNode(child, name, result, topIndex, parent, key, false);
        return;
    }
    if (!isNode(node)) return;

    if (!root && node.type === "FunctionDeclaration") {
        if (containsNameRaw(node, name)) result.captured = true;
        return;
    }

    if (isIdentifier(node, name)) {
        if (isDirectWriteIdentifier(node, parent, key)) {
            result.writes.push({ node, parent, key, topIndex });
            if (parent?.type === "LocalStatement") result.redeclared = true;
            return;
        }
        if (!isNonReadIdentifier(node, parent, key)) {
            result.reads.push({ node, parent, key, topIndex });
        }
        return;
    }

    for (const childKey of Object.keys(node)) {
        if (childKey === "range" || childKey === "loc") continue;
        const value = node[childKey];
        if (Array.isArray(value)) {
            for (const child of value) scanNameInNode(child, name, result, topIndex, node, childKey, false);
        } else if (isNode(value)) {
            scanNameInNode(value, name, result, topIndex, node, childKey, false);
        }
    }
}

function scanLaterReferences(block, declarationIndex, name, tailNode = null) {
    const result = { reads: [], writes: [], captured: false, redeclared: false };
    for (let index = declarationIndex + 1; index < block.length; index++) {
        scanNameInNode(block[index], name, result, index, null, null, true);
    }
    if (tailNode) scanNameInNode(tailNode, name, result, block.length, null, null, true);
    return result;
}

function scanNameInSameBlockNode(node, name, result, topIndex, parent = null, key = null, root = true) {
    if (!node) return;
    if (Array.isArray(node)) {
        if (!root && node.some(child => isNode(child) && /Statement$/.test(child.type))) return;
        for (const child of node) scanNameInSameBlockNode(child, name, result, topIndex, parent, key, false);
        return;
    }
    if (!isNode(node)) return;
    if (!root && node.type === "FunctionDeclaration") return;

    if (isIdentifier(node, name)) {
        if (isDirectWriteIdentifier(node, parent, key)) {
            result.writes.push({ node, parent, key, topIndex });
            if (parent?.type === "LocalStatement") result.redeclared = true;
            return;
        }
        if (!isNonReadIdentifier(node, parent, key)) result.reads.push({ node, parent, key, topIndex });
        return;
    }

    for (const childKey of Object.keys(node)) {
        if (childKey === "range" || childKey === "loc") continue;
        const value = node[childKey];
        if (Array.isArray(value)) {
            if (value.some(child => isNode(child) && /Statement$/.test(child.type))) continue;
            for (const child of value) scanNameInSameBlockNode(child, name, result, topIndex, node, childKey, false);
        } else if (isNode(value)) {
            scanNameInSameBlockNode(value, name, result, topIndex, node, childKey, false);
        }
    }
}

function scanLaterReferencesSameBlock(block, declarationIndex, name) {
    const result = { reads: [], writes: [], captured: false, redeclared: false };
    for (let index = declarationIndex + 1; index < block.length; index++) {
        scanNameInSameBlockNode(block[index], name, result, index, null, null, true);
    }
    return result;
}

function statementHasEffect(statement) {
    if (!statement) return false;
    if (statement.type === "LocalStatement") return !(statement.init || []).every(isNoEffectExpression);
    if (statement.type === "EmptyStatement" || statement.type === "CommentStatement") return false;
    return true;
}

function barrierFree(block, fromIndex, toIndex) {
    for (let index = fromIndex + 1; index < toIndex; index++) {
        if (statementHasEffect(block[index])) return false;
    }
    return true;
}

function scanWritesInStatements(block, fromIndex, toIndex, name) {
    for (let index = fromIndex + 1; index < toIndex; index++) {
        const result = { reads: [], writes: [], captured: false, redeclared: false };
        scanNameInNode(block[index], name, result, index, null, null, true);
        if (result.writes.length || result.redeclared || result.captured) return true;
    }
    return false;
}

function collectDirectLocalNames(block) {
    const names = new Set();
    for (const statement of block) {
        if (statement?.type !== "LocalStatement") continue;
        for (const variable of statement.variables || []) if (isIdentifier(variable)) names.add(variable.name);
    }
    return names;
}

function globalNameFromEnvIndex(source, node, envName) {
    if (node?.type !== "IndexExpression" || !isIdentifier(node.base, envName) || node.index?.type !== "StringLiteral") return null;
    const raw = sourceOf(source, node.index).trim();
    const match = raw.match(/^(?:"([A-Za-z_][A-Za-z0-9_]*)"|'([A-Za-z_][A-Za-z0-9_]*)')$/);
    const name = match?.[1] || match?.[2] || null;
    if (!name || LUA_KEYWORDS.has(name)) return null;
    return name;
}

function isEnvHeader(info) {
    const call = info?.init;
    return info?.name === "_env" && call?.type === "CallExpression" && isIdentifier(call.base, "getfenv") && (call.arguments || []).length === 0;
}

function functionHasSetfenv(node) {
    let found = false;
    function visit(value, root = false) {
        if (found || !value) return;
        if (Array.isArray(value)) {
            for (const child of value) visit(child, false);
            return;
        }
        if (!isNode(value)) return;
        if (!root && value.type === "FunctionDeclaration") return;
        if (value.type === "CallExpression" && isIdentifier(value.base, "setfenv")) {
            found = true;
            return;
        }
        for (const key of Object.keys(value)) {
            if (key === "range" || key === "loc") continue;
            visit(value[key], false);
        }
    }
    visit(node, true);
    return found;
}

function findEnvContext(block) {
    let envIndex = -1;
    for (let index = 0; index < block.length; index++) {
        const info = directLocalInfo(block[index]);
        if (isEnvHeader(info)) {
            envIndex = index;
            break;
        }
    }
    if (envIndex < 0) return null;
    const refs = scanLaterReferences(block, envIndex, "_env");
    if (refs.writes.length || refs.redeclared) return null;
    const fakeFunction = { type: "Chunk", body: block };
    if (functionHasSetfenv(fakeFunction)) return null;
    return { name: "_env", declarationIndex: envIndex };
}

function staticPositiveIndex(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = Number(node.value);
    return Number.isSafeInteger(value) && value >= 1 ? value : null;
}

function packedCallFromTable(node) {
    if (node?.type !== "TableConstructorExpression") return null;
    const fields = node.fields || [];
    if (fields.length !== 1 || fields[0]?.type !== "TableValue") return null;
    const call = fields[0].value;
    return isStandaloneCall(call) ? call : null;
}

function collectIdentifierNames(node, out = new Set()) {
    function visit(value) {
        if (!value) return;
        if (Array.isArray(value)) {
            for (const child of value) visit(child);
            return;
        }
        if (!isNode(value)) return;
        if (isIdentifier(value)) out.add(value.name);
        for (const key of Object.keys(value)) {
            if (key === "range" || key === "loc") continue;
            visit(value[key]);
        }
    }
    visit(node);
    return out;
}

function directPackedSlotExtraction(statement, tempName) {
    const info = directLocalInfo(statement);
    if (!info || info.name === tempName) return null;
    const index = info.init;
    if (index?.type !== "IndexExpression" || !isIdentifier(index.base, tempName)) return null;
    const slot = staticPositiveIndex(index.index);
    if (slot === null) return null;
    return { ...info, slot, index };
}

function nameIsObservedBeforeDeclaration(block, packIndex, extractionIndex, name) {
    for (let index = packIndex + 1; index < extractionIndex; index++) {
        const result = { reads: [], writes: [], captured: false, redeclared: false };
        scanNameInNode(block[index], name, result, index, null, null, true);
        if (result.reads.length || result.writes.length || result.captured || result.redeclared) return true;
    }
    return false;
}

function uniqueUnusedReturnName(usedNames, ordinal) {
    let suffix = ordinal;
    while (true) {
        const name = `__beta_unused_return_${suffix}`;
        if (!usedNames.has(name)) {
            usedNames.add(name);
            return name;
        }
        suffix++;
    }
}

function isUnusedReturnPlaceholder(name) {
    return /^__beta_unused_return_\d+$/.test(name || "");
}

function findUnusedMultiReturnTargetRename(source, block, stats) {
    for (let statementIndex = 0; statementIndex < block.length; statementIndex++) {
        const statement = block[statementIndex];
        if (statement?.type !== "LocalStatement" || !Array.isArray(statement.range)) continue;
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (variables.length < 2 || init.length !== 1 || !isStandaloneCall(init[0])) continue;
        if (!variables.every(variable => isIdentifier(variable) && Array.isArray(variable.range))) continue;

        const seen = new Set();
        if (variables.some(variable => seen.has(variable.name) || !seen.add(variable.name))) continue;

        const usedNames = collectIdentifierNames({ type: "Chunk", body: block });
        for (const variable of variables) {
            if (isUnusedReturnPlaceholder(variable.name)) continue;
            const refs = scanLaterReferences(block, statementIndex, variable.name);
            if (refs.reads.length || refs.writes.length || refs.captured || refs.redeclared) continue;
            const placeholder = uniqueUnusedReturnName(usedNames, 1);
            stats.multiReturnUnusedTargets++;
            return {
                start: variable.range[0],
                end: variable.range[1],
                replacement: placeholder,
                kind: "multi-return-unused-target",
            };
        }
    }
    return null;
}

function findMultiReturnTableCollapse(source, block, stats) {
    for (let packIndex = 0; packIndex < block.length; packIndex++) {
        const packStatement = block[packIndex];
        const packInfo = directLocalInfo(packStatement);
        if (!packInfo) continue;
        const call = packedCallFromTable(packInfo.init);
        if (!call || !Array.isArray(call.range)) continue;

        const refs = scanLaterReferences(block, packIndex, packInfo.name);
        if (refs.captured || refs.redeclared || refs.writes.length || refs.reads.length === 0) continue;

        const bySlot = new Map();
        let valid = true;

        for (const read of refs.reads) {
            const index = read.parent;
            if (read.key !== "base" || index?.type !== "IndexExpression" || index.base !== read.node) {
                valid = false;
                break;
            }
            const slot = staticPositiveIndex(index.index);
            if (slot === null || bySlot.has(slot)) {
                valid = false;
                break;
            }
            const statement = block[read.topIndex];
            const extraction = directPackedSlotExtraction(statement, packInfo.name);
            if (!extraction || extraction.index !== index || extraction.slot !== slot) {
                valid = false;
                break;
            }
            if (nameIsObservedBeforeDeclaration(block, packIndex, read.topIndex, extraction.name)) {
                valid = false;
                break;
            }
            bySlot.set(slot, { ...extraction, statement, statementIndex: read.topIndex });
        }

        if (!valid || bySlot.size !== refs.reads.length) continue;

        const targetNames = new Set();
        for (const extraction of bySlot.values()) {
            if (targetNames.has(extraction.name)) {
                valid = false;
                break;
            }
            targetNames.add(extraction.name);
        }
        if (!valid) continue;

        const maxSlot = Math.max(...bySlot.keys());
        const usedNames = collectIdentifierNames({ type: "Chunk", body: block });
        const targets = [];
        let placeholderOrdinal = 1;
        let placeholderCount = 0;
        for (let slot = 1; slot <= maxSlot; slot++) {
            const extraction = bySlot.get(slot);
            if (extraction) {
                targets.push(extraction.name);
            } else {
                targets.push(uniqueUnusedReturnName(usedNames, placeholderOrdinal));
                placeholderOrdinal++;
                placeholderCount++;
            }
        }

        const replacement = `local ${targets.join(", ")} = ${sourceOf(source, call)}`;
        const edits = [
            { start: packStatement.range[0], end: packStatement.range[1], replacement },
        ];
        for (const extraction of [...bySlot.values()].sort((a, b) => a.statementIndex - b.statementIndex)) {
            edits.push({ start: extraction.statement.range[0], end: extraction.statement.range[1], replacement: "" });
        }

        stats.multiReturnTableCollapses++;
        stats.multiReturnSlotsRecovered += bySlot.size;
        stats.multiReturnPlaceholders += placeholderCount;
        return {
            compound: true,
            edits,
            kind: "multi-return-table-collapse",
        };
    }
    return null;
}

function functionNameIsCaptured(functionBody, name) {
    const refs = { reads: [], writes: [], captured: false, redeclared: false };
    for (let index = 0; index < functionBody.length; index++) {
        scanNameInNode(functionBody[index], name, refs, index, null, null, true);
        if (refs.captured) return true;
    }
    return false;
}

function findPackedCallUnpackForwarding(source, block, functionBody, stats) {
    for (let packIndex = 0; packIndex + 1 < block.length; packIndex++) {
        const packStatement = block[packIndex];
        const packInfo = directLocalInfo(packStatement);
        if (!packInfo) continue;
        const call = packedCallFromTable(packInfo.init);
        if (!call || !Array.isArray(call.range)) continue;

        const nextStatement = block[packIndex + 1];
        if (!Array.isArray(nextStatement?.range)) continue;
        let outerCall = null;
        if (nextStatement.type === "CallStatement") {
            outerCall = nextStatement.expression;
        } else {
            const nextLocal = directLocalInfo(nextStatement);
            if (nextLocal && isStandaloneCall(nextLocal.init)) outerCall = nextLocal.init;
        }
        if (!isStandaloneCall(outerCall) || !Array.isArray(outerCall.range)) continue;
        if (!isIdentifier(outerCall.base) || outerCall.base.isLocal !== true) continue;
        const outerArgs = outerCall.arguments || [];
        if (outerArgs.length !== 1) continue;

        const unpackCall = outerArgs[0];
        if (!isStandaloneCall(unpackCall) || !Array.isArray(unpackCall.range)) continue;
        if (!isIdentifier(unpackCall.base, "unpack") || unpackCall.base.isLocal === true) continue;
        const unpackArgs = unpackCall.arguments || [];
        if (unpackArgs.length !== 1) continue;
        const packUse = unpackArgs[0];
        if (!isIdentifier(packUse, packInfo.name) || packUse.isLocal !== true) continue;

        const refs = scanLaterReferences(block, packIndex, packInfo.name);
        if (refs.captured || refs.redeclared || refs.writes.length || refs.reads.length !== 1) continue;
        const onlyRead = refs.reads[0];
        if (onlyRead.topIndex !== packIndex + 1 || onlyRead.node !== packUse) continue;

        // Moving the packed call into the outer call makes the local call target
        // get read before the inner call instead of after it. That is equivalent
        // only when the target binding cannot be mutated through a closure called
        // by the inner expression.
        if (functionNameIsCaptured(functionBody, outerCall.base.name)) continue;

        stats.multiReturnTableCollapses++;
        stats.multiReturnForwardersCollapsed++;
        return {
            compound: true,
            edits: [
                { start: packStatement.range[0], end: packStatement.range[1], replacement: "" },
                { start: unpackCall.range[0], end: unpackCall.range[1], replacement: sourceOf(source, call) },
            ],
            kind: "multi-return-unpack-forwarding",
        };
    }
    return null;
}

function findGenericForTupleInline(source, block, stats) {
    for (let declarationIndex = 0; declarationIndex + 1 < block.length; declarationIndex++) {
        const declaration = block[declarationIndex];
        const loop = block[declarationIndex + 1];
        if (declaration?.type !== "LocalStatement" || loop?.type !== "ForGenericStatement") continue;
        if (!Array.isArray(declaration.range) || !Array.isArray(loop.range)) continue;

        const variables = declaration.variables || [];
        const init = declaration.init || [];
        const iterators = loop.iterators || [];
        if (variables.length !== 3 || iterators.length !== 3 || init.length < 1 || init.length > 3) continue;
        if (!variables.every(variable => isIdentifier(variable) && Array.isArray(variable.range))) continue;
        if (!iterators.every(iterator => isIdentifier(iterator) && Array.isArray(iterator.range))) continue;

        const names = variables.map(variable => variable.name);
        if (new Set(names).size !== names.length) continue;
        if (!iterators.every((iterator, index) => iterator.name === names[index])) continue;

        let valid = true;
        for (let index = 0; index < names.length; index++) {
            const refs = scanLaterReferences(block, declarationIndex, names[index]);
            if (refs.writes.length || refs.captured || refs.redeclared || refs.reads.length !== 1) {
                valid = false;
                break;
            }
            const read = refs.reads[0];
            if (read.topIndex !== declarationIndex + 1 || read.node !== iterators[index]) {
                valid = false;
                break;
            }
        }
        if (!valid) continue;

        const iteratorSource = init.map(expression => sourceOf(source, expression)).join(", ");
        if (!iteratorSource) continue;
        const firstIterator = iterators[0].range[0];
        const lastIterator = iterators[iterators.length - 1].range[1];

        stats.genericForTupleInlines++;
        stats.genericForTupleLocalsRemoved += variables.length;
        return {
            compound: true,
            edits: [
                { start: declaration.range[0], end: declaration.range[1], replacement: "" },
                { start: firstIterator, end: lastIterator, replacement: iteratorSource },
            ],
            kind: "generic-for-tuple-inline",
        };
    }
    return null;
}

function singleAssignmentInfo(statement, targetName = null) {
    if (statement?.type !== "AssignmentStatement") return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) return null;
    if (targetName !== null && variables[0].name !== targetName) return null;
    return { target: variables[0].name, value: init[0] };
}

function singleIfClause(statement) {
    if (statement?.type !== "IfStatement") return null;
    const clauses = statement.clauses || [];
    if (clauses.length !== 1 || clauses[0]?.type !== "IfClause") return null;
    return clauses[0];
}

function uninitializedLocalName(statement) {
    if (statement?.type !== "LocalStatement") return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 0 || !isIdentifier(variables[0])) return null;
    return variables[0].name;
}

function isNotIdentifier(node, name) {
    return node?.type === "UnaryExpression" && node.operator === "not" && isIdentifier(node.argument, name);
}

function renderExpressionWithSimpleDefs(source, node, defs, useCounts, stack = new Set()) {
    if (!Array.isArray(node?.range)) return null;
    const edits = [];
    function visit(value, parent = null, key = null) {
        if (!isNode(value)) return true;
        if (isIdentifier(value) && !isNonReadIdentifier(value, parent, key) && defs.has(value.name)) {
            if (stack.has(value.name)) return false;
            useCounts.set(value.name, (useCounts.get(value.name) || 0) + 1);
            const def = defs.get(value.name);
            const nextStack = new Set(stack);
            nextStack.add(value.name);
            const rendered = renderExpressionWithSimpleDefs(source, def, defs, useCounts, nextStack);
            if (rendered === null) return false;
            edits.push({ start: value.range[0], end: value.range[1], replacement: `(${rendered})` });
            return true;
        }
        for (const childKey of Object.keys(value)) {
            if (childKey === "range" || childKey === "loc") continue;
            const child = value[childKey];
            if (Array.isArray(child)) {
                for (const item of child) if (isNode(item) && !visit(item, value, childKey)) return false;
            } else if (isNode(child) && !visit(child, value, childKey)) {
                return false;
            }
        }
        return true;
    }
    if (!visit(node)) return null;
    try {
        return applyTextEdits(sourceOf(source, node), edits, node.range[0]);
    } catch {
        return null;
    }
}

function buildLeafExpression(source, localStatements, resultTempName) {
    if (!localStatements.length) return null;
    const defs = new Map();
    const order = [];
    for (const statement of localStatements) {
        const info = directLocalInfo(statement);
        if (!info || !info.init || defs.has(info.name)) return null;
        defs.set(info.name, info.init);
        order.push(info.name);
    }
    if (!defs.has(resultTempName)) return null;

    // Only the final leaf may itself be effectful. Earlier compiler temps are
    // restricted to literals / one-read aliases so folding cannot change call
    // count, short-circuit behavior, or object identity.
    for (const name of order) {
        if (name === resultTempName) continue;
        const def = defs.get(name);
        if (!isLiteral(def) && !isIdentifier(def)) return null;
    }

    const useCounts = new Map();
    const rendered = renderExpressionWithSimpleDefs(source, defs.get(resultTempName), defs, useCounts, new Set([resultTempName]));
    if (rendered === null) return null;
    for (const name of order) {
        if (name === resultTempName) continue;
        const count = useCounts.get(name) || 0;
        if (count !== 1 && !isLiteral(defs.get(name))) return null;
        if (count === 0) return null;
    }
    return { expression: rendered, names: new Set(order) };
}

function parseProgramProducer(source, statements, startIndex, resultName) {
    for (let assignIndex = startIndex + 1; assignIndex < statements.length; assignIndex++) {
        const assign = singleAssignmentInfo(statements[assignIndex], resultName);
        if (!assign || !isIdentifier(assign.value)) continue;
        const truthName = assign.value.name;
        const prefix = statements.slice(startIndex, assignIndex);
        if (!prefix.length) continue;

        const leaf = buildLeafExpression(source, prefix, truthName);
        if (leaf) {
            return {
                expression: leaf.expression,
                truthName,
                names: leaf.names,
                nextIndex: assignIndex + 1,
            };
        }

        const nested = parseShortCircuitProgram(source, prefix, truthName);
        if (nested) {
            return {
                expression: nested.expression,
                truthName,
                names: nested.names,
                nextIndex: assignIndex + 1,
            };
        }
    }
    return null;
}

function parseShortCircuitProgram(source, statements, expectedResultName = null) {
    if (!Array.isArray(statements) || statements.length < 2) return null;
    let cursor = 0;
    let resultName = expectedResultName;
    const names = new Set();

    const declaredResult = uninitializedLocalName(statements[0]);
    if (declaredResult && (expectedResultName === null || declaredResult === expectedResultName)) {
        resultName = declaredResult;
        names.add(declaredResult);
        cursor++;
    }
    if (!resultName) return null;

    const producer = parseProgramProducer(source, statements, cursor, resultName);
    if (!producer) return null;
    for (const name of producer.names) names.add(name);
    cursor = producer.nextIndex;

    if (cursor === statements.length) {
        return { resultName, expression: producer.expression, names };
    }
    if (cursor + 1 !== statements.length) return null;

    const clause = singleIfClause(statements[cursor]);
    if (!clause) return null;
    let operator = null;
    if (isIdentifier(clause.condition, producer.truthName)) operator = "and";
    else if (isNotIdentifier(clause.condition, producer.truthName)) operator = "or";
    else return null;

    const right = parseShortCircuitProgram(source, clause.body || [], resultName);
    if (!right) return null;
    for (const name of right.names) names.add(name);

    return {
        resultName,
        expression: `(${producer.expression}) ${operator} (${right.expression})`,
        names,
    };
}

function buildAssignedBranchExpression(source, body, resultName) {
    if (!Array.isArray(body) || body.length === 0) return null;
    const assignment = singleAssignmentInfo(body[body.length - 1], resultName);
    if (!assignment || !Array.isArray(assignment.value?.range)) return null;
    if (containsNameRaw(assignment.value, resultName)) return null;

    if (body.length === 1) {
        return { expression: sourceOf(source, assignment.value), names: new Set() };
    }

    const prefix = body.slice(0, -1);
    for (const statement of prefix) {
        if (statementMentionsName(statement, resultName)) return null;
    }
    if (!isIdentifier(assignment.value)) return null;
    return buildLeafExpression(source, prefix, assignment.value.name);
}

function findValueShortCircuitCollapse(source, block, stats) {
    const directLocals = collectDirectLocalNames(block);
    for (let resultIndex = 0; resultIndex + 1 < block.length; resultIndex++) {
        const resultStatement = block[resultIndex];
        const result = directLocalInfo(resultStatement);
        if (!result || !isIdentifier(result.init) || result.variable.typeAnnotation) continue;
        const seedName = result.init.name;
        if (result.init.isLocal !== true || !directLocals.has(seedName)) continue;

        const clause = singleIfClause(block[resultIndex + 1]);
        if (!clause) continue;

        let operator = null;
        let conditionIdentifier = null;
        if (isIdentifier(clause.condition, seedName)) {
            operator = "and";
            conditionIdentifier = clause.condition;
        } else if (isNotIdentifier(clause.condition, seedName)) {
            operator = "or";
            conditionIdentifier = clause.condition.argument;
        } else {
            continue;
        }
        if (conditionIdentifier.isLocal !== true) continue;

        const right = buildAssignedBranchExpression(source, clause.body || [], result.name);
        if (!right) continue;

        let startStatement = resultStatement;
        let leftExpression = seedName;
        if (resultIndex > 0) {
            const producerStatement = block[resultIndex - 1];
            const producer = directLocalInfo(producerStatement);
            if (producer && producer.name === seedName && !producer.variable.typeAnnotation && Array.isArray(producer.init?.range)) {
                const refs = scanLaterReferences(block, resultIndex - 1, seedName);
                const expectedReads = new Set([result.init, conditionIdentifier]);
                const exactProducerUse = !refs.captured && !refs.redeclared && refs.writes.length === 0 &&
                    refs.reads.length === 2 && refs.reads.every(read => expectedReads.has(read.node));
                if (exactProducerUse) {
                    startStatement = producerStatement;
                    leftExpression = sourceOf(source, producer.init);
                }
            }
        }

        stats.shortCircuitLaddersCollapsed++;
        stats.valueShortCircuitLaddersCollapsed++;
        return {
            start: startStatement.range[0],
            end: block[resultIndex + 1].range[1],
            replacement: `local ${result.name} = (${leftExpression}) ${operator} (${right.expression})`,
            kind: "value-short-circuit-collapse",
        };
    }
    return null;
}

function namesUsedInStatements(statements, names) {
    for (let index = 0; index < statements.length; index++) {
        for (const name of names) {
            const result = { reads: [], writes: [], captured: false, redeclared: false };
            scanNameInNode(statements[index], name, result, index, null, null, true);
            if (result.reads.length || result.writes.length || result.captured || result.redeclared) return true;
        }
    }
    return false;
}

function isBreakGuard(statement, resultName) {
    const clause = singleIfClause(statement);
    if (!clause || !isNotIdentifier(clause.condition, resultName)) return false;
    const body = clause.body || [];
    return body.length === 1 && body[0]?.type === "BreakStatement";
}

function astShape(node) {
    if (Array.isArray(node)) return node.map(astShape);
    if (!node || typeof node !== "object") return node;
    const out = {};
    for (const key of Object.keys(node).sort()) {
        if (key === "range" || key === "loc" || key === "isLocal") continue;
        out[key] = astShape(node[key]);
    }
    return out;
}

function expressionSignature(node) {
    return JSON.stringify(astShape(node));
}

function parseExpressionText(text) {
    try {
        const ast = parseLuaStructural(`local __beta_condition_probe = ${text}`, "<beta-condition-probe>");
        return ast.body?.[0]?.init?.[0] || null;
    } catch {
        return null;
    }
}

function discardedBranchMatches(source, body, expressionNode) {
    if (!Array.isArray(body) || body.length === 0 || !expressionNode) return false;
    const wanted = expressionSignature(expressionNode);

    if (body.length === 1 && body[0]?.type === "CallStatement") {
        return expressionSignature(body[0].expression) === wanted;
    }
    if (body.length === 1) {
        const info = directLocalInfo(body[0]);
        if (info?.init && expressionSignature(info.init) === wanted) return true;
    }

    const parsed = parseShortCircuitProgram(source, body);
    if (!parsed) return false;
    const parsedExpression = parseExpressionText(parsed.expression);
    return parsedExpression !== null && expressionSignature(parsedExpression) === wanted;
}

function statementMentionsName(statement, name) {
    const result = { reads: [], writes: [], captured: false, redeclared: false };
    scanNameInNode(statement, name, result, 0, null, null, true);
    return result.reads.length || result.writes.length || result.captured || result.redeclared;
}

function findDiscardedRepeatPrecheck(source, block, stats) {
    for (let repeatIndex = 0; repeatIndex < block.length; repeatIndex++) {
        const repeat = block[repeatIndex];
        if (repeat?.type !== "RepeatStatement" || repeat.condition?.type !== "LogicalExpression") continue;
        if (repeat.condition.operator !== "and" && repeat.condition.operator !== "or") continue;

        const left = repeat.condition.left;
        const right = repeat.condition.right;
        for (let ifIndex = repeatIndex - 1; ifIndex >= 1; ifIndex--) {
            const clause = singleIfClause(block[ifIndex]);
            if (!clause) continue;

            let tempName = null;
            if (repeat.condition.operator === "and" && isIdentifier(clause.condition)) tempName = clause.condition.name;
            if (repeat.condition.operator === "or" && clause.condition?.type === "UnaryExpression" && clause.condition.operator === "not" && isIdentifier(clause.condition.argument)) {
                tempName = clause.condition.argument.name;
            }
            if (!tempName || !discardedBranchMatches(source, clause.body || [], right)) continue;

            for (let leftIndex = ifIndex - 1; leftIndex >= 0; leftIndex--) {
                const info = directLocalInfo(block[leftIndex]);
                if (!info || info.name !== tempName || !info.init) continue;
                if (expressionSignature(info.init) !== expressionSignature(left)) continue;

                let safeGap = true;
                for (let index = leftIndex + 1; index < ifIndex; index++) {
                    if (statementMentionsName(block[index], tempName)) {
                        safeGap = false;
                        break;
                    }
                }
                if (!safeGap) continue;
                for (let index = ifIndex + 1; index < repeatIndex; index++) {
                    if (statementMentionsName(block[index], tempName)) {
                        safeGap = false;
                        break;
                    }
                }
                if (!safeGap) continue;

                stats.repeatPrechecksRemoved++;
                return {
                    compound: true,
                    edits: [
                        { start: block[leftIndex].range[0], end: block[leftIndex].range[1], replacement: "" },
                        { start: block[ifIndex].range[0], end: block[ifIndex].range[1], replacement: "" },
                    ],
                    kind: "repeat-discarded-precheck",
                };
            }
        }
    }
    return null;
}

function findLoopConditionCollapse(source, block, stats) {
    for (const statement of block) {
        if (statement?.type === "WhileStatement" && statement.condition?.type === "BooleanLiteral" && statement.condition.value === true) {
            const body = statement.body || [];
            for (let split = 2; split < body.length; split++) {
                const parsed = parseShortCircuitProgram(source, body.slice(0, split));
                if (!parsed || !isBreakGuard(body[split], parsed.resultName)) continue;
                if (namesUsedInStatements(body.slice(split + 1), parsed.names)) continue;
                stats.whileConditionsCollapsed++;
                stats.shortCircuitLaddersCollapsed++;
                return {
                    compound: true,
                    edits: [
                        { start: statement.condition.range[0], end: statement.condition.range[1], replacement: parsed.expression },
                        { start: body[0].range[0], end: body[split].range[1], replacement: "" },
                    ],
                    kind: "while-short-circuit-collapse",
                };
            }
        }

        if (statement?.type === "RepeatStatement" && isIdentifier(statement.condition)) {
            const body = statement.body || [];
            for (let start = 0; start < body.length; start++) {
                const suffix = body.slice(start);
                const parsed = parseShortCircuitProgram(source, suffix, statement.condition.name);
                if (!parsed) continue;
                stats.repeatConditionsCollapsed++;
                stats.shortCircuitLaddersCollapsed++;
                return {
                    compound: true,
                    edits: [
                        { start: body[start].range[0], end: body[body.length - 1].range[1], replacement: "" },
                        { start: statement.condition.range[0], end: statement.condition.range[1], replacement: parsed.expression },
                    ],
                    kind: "repeat-short-circuit-collapse",
                };
            }
        }
    }
    return null;
}

function inheritedEnvContext(block, envName) {
    if (!envName) return null;
    const refs = { reads: [], writes: [], captured: false, redeclared: false };
    for (let index = 0; index < block.length; index++) {
        scanNameInNode(block[index], envName, refs, index, null, null, true);
    }
    // Any binding/write in this function can shadow or mutate the captured env.
    // Captures by deeper closures are fine; those closures are checked separately.
    if (refs.writes.length || refs.redeclared) return null;
    const fakeFunction = { type: "Chunk", body: block };
    if (functionHasSetfenv(fakeFunction)) return null;
    return { name: envName, declarationIndex: -1, inherited: true };
}

function resolveEnvContext(block, inheritedEnvName = null) {
    const own = findEnvContext(block);
    if (own) return own;
    return inheritedEnvContext(block, inheritedEnvName);
}

function findEnvFold(source, block, inheritedEnvName = null, limit = 128) {
    const env = resolveEnvContext(block, inheritedEnvName);
    if (!env || limit <= 0) return null;
    const edits = [];
    function visit(node, parent = null, key = null) {
        if (edits.length >= limit || !node) return;
        if (Array.isArray(node)) {
            for (const child of node) {
                visit(child, parent, key);
                if (edits.length >= limit) break;
            }
            return;
        }
        if (!isNode(node)) return;
        if (node.type === "FunctionDeclaration") return;
        const globalName = globalNameFromEnvIndex(source, node, env.name);
        if (globalName && Array.isArray(node.range)) {
            edits.push({ start: node.range[0], end: node.range[1], replacement: globalName, kind: "global-fold" });
            return;
        }
        for (const childKey of Object.keys(node)) {
            if (childKey === "range" || childKey === "loc") continue;
            visit(node[childKey], node, childKey);
            if (edits.length >= limit) break;
        }
    }
    for (let index = env.declarationIndex + 1; index < block.length && edits.length < limit; index++) visit(block[index]);
    if (!edits.length) return null;
    return { compound: true, edits, transformCount: edits.length, kind: edits.length === 1 ? "global-fold" : "global-fold-batch" };
}

function isRepeatedEvaluationStatement(statement) {
    return statement?.type === "WhileStatement" ||
        statement?.type === "RepeatStatement" ||
        statement?.type === "ForNumericStatement" ||
        statement?.type === "ForGenericStatement";
}

function directAssignmentInfo(statement) {
    if (statement?.type !== "AssignmentStatement" || !Array.isArray(statement.range)) return null;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1 || !isIdentifier(variables[0])) return null;
    return { name: variables[0].name, variable: variables[0], init: init[0] };
}

function directNilAssignmentInfo(statement) {
    const info = directAssignmentInfo(statement);
    if (!info || info.init?.type !== "NilLiteral" || info.variable.isLocal !== true) return null;
    return info;
}

function isScopeTransferBarrier(statement) {
    return statement?.type === "GotoStatement" || statement?.type === "LabelStatement";
}

function functionHasScopeTransfer(functionBody) {
    let found = false;
    function visit(value) {
        if (found || !value) return;
        if (Array.isArray(value)) {
            for (const child of value) visit(child);
            return;
        }
        if (!isNode(value)) return;
        if (value.type === "FunctionDeclaration") return;
        if (isScopeTransferBarrier(value)) {
            found = true;
            return;
        }
        for (const key of Object.keys(value)) {
            if (key === "range" || key === "loc") continue;
            visit(value[key]);
        }
    }
    for (const statement of functionBody) visit(statement);
    return found;
}

function functionCapturesName(functionBody, name) {
    let captured = false;
    function visit(value) {
        if (captured || !value) return;
        if (Array.isArray(value)) {
            for (const child of value) visit(child);
            return;
        }
        if (!isNode(value)) return;
        if (value.type === "FunctionDeclaration") {
            if (containsNameRaw(value, name)) captured = true;
            return;
        }
        for (const key of Object.keys(value)) {
            if (key === "range" || key === "loc") continue;
            visit(value[key]);
        }
    }
    for (const statement of functionBody) visit(statement);
    return captured;
}

function hasPriorDirectLocalDeclaration(functionBody, beforeIndex, name) {
    for (let index = 0; index < beforeIndex; index++) {
        const statement = functionBody[index];
        if (statement?.type !== "LocalStatement") continue;
        for (const variable of statement.variables || []) {
            if (isIdentifier(variable, name)) return true;
        }
    }
    return false;
}

function findPreFoldDeadNilAssignment(source, functionBody, stats, limit = 128) {
    // This is intentionally a pre-fold-only cleanup. A direct `x = nil` emitted
    // as compiler lifetime cleanup can be deleted when its value is never observed.
    // Root-block writes use ordinary later-reference proof. Nested blocks are only
    // eligible when they terminate the function with a direct return; other nested
    // control flow still fails closed.
    if (functionHasScopeTransfer(functionBody) || limit <= 0) return null;

    const edits = [];
    const blocks = allBlocksForFunction(functionBody);
    for (const block of blocks) {
        if (edits.length >= limit) break;
        const isFunctionRoot = block === functionBody;
        const last = block[block.length - 1];
        const isTerminalNestedBlock = !isFunctionRoot && last?.type === "ReturnStatement";
        if (!isFunctionRoot && !isTerminalNestedBlock) continue;

        for (let index = block.length - 1; index >= 0 && edits.length < limit; index--) {
            const statement = block[index];
            const info = directNilAssignmentInfo(statement);
            if (!info) continue;

            // `isLocal` also covers upvalues. Require a prior declaration in this
            // exact lexical block. This proves same-function ownership without
            // treating an outer captured binding as disposable cleanup.
            if (!hasPriorDirectLocalDeclaration(block, index, info.name)) continue;
            if (functionCapturesName(functionBody, info.name)) continue;

            const refs = scanLaterReferences(block, index, info.name);
            if (refs.reads.length || refs.captured || refs.redeclared) continue;

            edits.push({ start: statement.range[0], end: statement.range[1], replacement: "", kind: "dead-direct-nil-cleanup" });
        }
    }
    if (!edits.length) return null;
    stats.directNilCleanupWritesRemoved += edits.length;
    return { compound: true, edits, transformCount: edits.length, kind: edits.length === 1 ? "dead-direct-nil-cleanup" : "dead-direct-nil-cleanup-batch" };
}

function findAdjacentCopyChainFold(source, block, stats, startIndex = 0) {
    for (let index = startIndex; index + 1 < block.length; index++) {
        const producerStatement = block[index];
        const consumerStatement = block[index + 1];
        const producer = directLocalInfo(producerStatement);
        const consumer = directLocalInfo(consumerStatement);
        if (!producer || !consumer || !isIdentifier(consumer.init, producer.name)) continue;
        // Let the existing literal/identifier alias rules keep their established
        // loop-snapshot behavior. This copy-chain pass is for opaque producer
        // values (calls/tables/closures/indexing/etc.) that cannot otherwise inline.
        if (isLiteral(producer.init) || isIdentifier(producer.init)) continue;
        if (consumer.init.isLocal !== true) continue;
        if (producer.variable.typeAnnotation || consumer.variable.typeAnnotation) continue;
        if (!Array.isArray(producer.variable.range) || !Array.isArray(consumerStatement.range)) continue;

        // The temporary must exist only to transfer this exact value into the next
        // local. Renaming the producer binding keeps arbitrary RHS evaluation at the
        // original position, so calls/tables/closures retain timing and identity.
        const refs = scanLaterReferences(block, index, producer.name);
        if (refs.captured || refs.redeclared || refs.writes.length || refs.reads.length !== 1) continue;
        const read = refs.reads[0];
        if (read.topIndex !== index + 1 || read.node !== consumer.init) continue;

        stats.adjacentCopyChainsFolded++;
        return {
            compound: true,
            edits: [
                {
                    start: producer.variable.range[0],
                    end: producer.variable.range[1],
                    replacement: consumer.name,
                },
                { start: consumerStatement.range[0], end: consumerStatement.range[1], replacement: "" },
            ],
            kind: "adjacent-copy-chain",
            statementIndex: index,
        };
    }
    return null;
}

function nestedFunctionWritesName(functionBody, name) {
    let found = false;
    function visit(value) {
        if (found || !value) return;
        if (Array.isArray(value)) {
            for (const child of value) visit(child);
            return;
        }
        if (!isNode(value)) return;
        if (value.type === "FunctionDeclaration") {
            const refs = { reads: [], writes: [], captured: false, redeclared: false };
            for (let index = 0; index < (value.body || []).length; index++) {
                scanNameInNode(value.body[index], name, refs, index, null, null, true);
            }
            if (refs.writes.some(write => write.parent?.type !== "LocalStatement")) {
                found = true;
                return;
            }
            for (const statement of value.body || []) visit(statement);
            return;
        }
        for (const childKey of Object.keys(value)) {
            if (childKey === "range" || childKey === "loc") continue;
            visit(value[childKey]);
        }
    }
    for (const statement of functionBody) visit(statement);
    return found;
}

function findAdjacentIndexBaseAliasInline(source, block, stats, startIndex = 0) {
    for (let index = startIndex; index + 1 < block.length; index++) {
        const producerStatement = block[index];
        const consumerStatement = block[index + 1];
        const producer = directLocalInfo(producerStatement);
        const consumer = directLocalInfo(consumerStatement);
        if (!producer || !consumer || !isIdentifier(producer.init)) continue;
        const lookup = consumer.init;
        if (lookup?.type !== "IndexExpression" || !isIdentifier(lookup.base, producer.name)) continue;
        if (!Array.isArray(producerStatement.range) || !Array.isArray(lookup.base.range)) continue;

        // This is an exact adjacent snapshot transfer:
        //   local t = math
        //   local f = t["random"]
        // -> local f = math["random"]
        // No statement executes between the two reads, and the temporary must have
        // exactly this one same-block use with no write/capture/redeclaration.
        const refs = scanLaterReferences(block, index, producer.name);
        const sameBlockRefs = scanLaterReferencesSameBlock(block, index, producer.name);
        if (refs.captured || refs.redeclared || refs.writes.length || refs.reads.length !== 1) continue;
        if (sameBlockRefs.reads.length !== 1 || sameBlockRefs.reads[0].node !== lookup.base || sameBlockRefs.reads[0].topIndex !== index + 1) continue;

        stats.adjacentIndexBaseAliasesFolded++;
        return {
            compound: true,
            edits: [
                { start: producerStatement.range[0], end: producerStatement.range[1], replacement: "" },
                { start: lookup.base.range[0], end: lookup.base.range[1], replacement: sourceOf(source, producer.init) },
            ],
            kind: "adjacent-index-base-alias-inline",
            statementIndex: index,
        };
    }
    return null;
}

function findAdjacentIndexKeyInline(source, block, functionBody, stats, startIndex = 0) {
    for (let index = startIndex; index + 1 < block.length; index++) {
        const producerStatement = block[index];
        const consumerStatement = block[index + 1];
        const producer = directLocalInfo(producerStatement);
        const consumer = directLocalInfo(consumerStatement);
        if (!producer || !consumer || !isStandaloneCall(producer.init)) continue;
        const lookup = consumer.init;
        if (lookup?.type !== "IndexExpression" || !isIdentifier(lookup.index, producer.name)) continue;
        if (!isIdentifier(lookup.base) || lookup.base.isLocal !== true) continue;
        if (!Array.isArray(producerStatement.range) || !Array.isArray(lookup.index.range)) continue;

        const refs = scanLaterReferences(block, index, producer.name);
        const sameBlockRefs = scanLaterReferencesSameBlock(block, index, producer.name);
        if (refs.captured || refs.redeclared || refs.writes.length || refs.reads.length !== 1) continue;
        if (sameBlockRefs.reads.length !== 1 || sameBlockRefs.reads[0].node !== lookup.index || sameBlockRefs.reads[0].topIndex !== index + 1) continue;

        // `base[keyCall()]` reads the local base binding before evaluating the key.
        // The split compiler form evaluates the key call first. This is equivalent
        // only when no nested closure in this function can rebind that local base.
        if (nestedFunctionWritesName(functionBody, lookup.base.name)) continue;

        stats.adjacentIndexKeyInlines++;
        return {
            compound: true,
            edits: [
                { start: producerStatement.range[0], end: producerStatement.range[1], replacement: "" },
                { start: lookup.index.range[0], end: lookup.index.range[1], replacement: sourceOf(source, producer.init) },
            ],
            kind: "adjacent-index-key-inline",
            statementIndex: index,
        };
    }
    return null;
}

function findAdjacentIndexBaseAliasBatch(source, block, stats, limit = 128) {
    const edits = [];
    let transformCount = 0;
    let cursor = 0;
    while (transformCount < limit) {
        const trialStats = { adjacentIndexBaseAliasesFolded: 0 };
        const candidate = findAdjacentIndexBaseAliasInline(source, block, trialStats, cursor);
        if (!candidate) break;
        edits.push(...editParts(candidate));
        stats.adjacentIndexBaseAliasesFolded += trialStats.adjacentIndexBaseAliasesFolded;
        transformCount++;
        cursor = candidate.statementIndex + 2;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "adjacent-index-base-alias-inline" : "adjacent-index-base-alias-batch" };
}

function findAdjacentIndexKeyBatch(source, block, functionBody, stats, limit = 128) {
    const edits = [];
    let transformCount = 0;
    let cursor = 0;
    while (transformCount < limit) {
        const trialStats = { adjacentIndexKeyInlines: 0 };
        const candidate = findAdjacentIndexKeyInline(source, block, functionBody, trialStats, cursor);
        if (!candidate) break;
        edits.push(...editParts(candidate));
        stats.adjacentIndexKeyInlines += trialStats.adjacentIndexKeyInlines;
        transformCount++;
        cursor = candidate.statementIndex + 2;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "adjacent-index-key-inline" : "adjacent-index-key-batch" };
}

function findAdjacentAssignmentKeyInline(source, block, functionBody, stats, startIndex = 0) {
    for (let index = startIndex; index + 1 < block.length; index++) {
        const producerStatement = block[index];
        const consumerStatement = block[index + 1];
        const producer = directLocalInfo(producerStatement);
        if (!producer || producer.init?.type !== "IndexExpression" || !Array.isArray(producer.init.range)) continue;
        if (consumerStatement?.type !== "AssignmentStatement" || !Array.isArray(consumerStatement.range)) continue;

        const variables = consumerStatement.variables || [];
        const init = consumerStatement.init || [];
        if (variables.length !== 1 || init.length !== 1) continue;
        const target = variables[0];
        if (target?.type !== "IndexExpression" || !isIdentifier(target.index, producer.name)) continue;
        if (!isIdentifier(target.base) || target.base.isLocal !== true) continue;
        if (!Array.isArray(target.index.range)) continue;

        const refs = scanLaterReferences(block, index, producer.name);
        const sameBlockRefs = scanLaterReferencesSameBlock(block, index, producer.name);
        if (refs.captured || refs.redeclared || refs.writes.length || refs.reads.length !== 1) continue;
        if (sameBlockRefs.reads.length !== 1 || sameBlockRefs.reads[0].node !== target.index || sameBlockRefs.reads[0].topIndex !== index + 1) continue;

        // The split form finishes the producer lookup before reading the assignment
        // destination local. In the inlined form Lua reads the destination base
        // before evaluating its index expression. That is equivalent only when a
        // nested closure reached by the producer cannot rebind the destination.
        if (nestedFunctionWritesName(functionBody, target.base.name)) continue;

        stats.adjacentAssignmentKeyInlines++;
        return {
            compound: true,
            edits: [
                { start: producerStatement.range[0], end: producerStatement.range[1], replacement: "" },
                { start: target.index.range[0], end: target.index.range[1], replacement: sourceOf(source, producer.init) },
            ],
            kind: "adjacent-assignment-key-inline",
            statementIndex: index,
        };
    }
    return null;
}

function findAdjacentAssignmentKeyBatch(source, block, functionBody, stats, limit = 128) {
    const edits = [];
    let transformCount = 0;
    let cursor = 0;
    while (transformCount < limit) {
        const trialStats = { adjacentAssignmentKeyInlines: 0 };
        const candidate = findAdjacentAssignmentKeyInline(source, block, functionBody, trialStats, cursor);
        if (!candidate) break;
        edits.push(...editParts(candidate));
        stats.adjacentAssignmentKeyInlines += trialStats.adjacentAssignmentKeyInlines;
        transformCount++;
        cursor = candidate.statementIndex + 2;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "adjacent-assignment-key-inline" : "adjacent-assignment-key-batch" };
}

function findDeferredLocalInitialization(source, block, stats, startIndex = 0) {
    for (let declarationIndex = startIndex; declarationIndex < block.length; declarationIndex++) {
        const declaration = block[declarationIndex];
        const info = directLocalOrUninitializedInfo(declaration);
        if (!info || info.init !== null) continue;

        const declarationText = sourceOf(source, declaration).trim();
        const escapedName = info.name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
        if (!new RegExp(`^local\\s+${escapedName}\\s*;?$`).test(declarationText)) continue;

        for (let index = declarationIndex + 1; index < block.length; index++) {
            const statement = block[index];
            if (isScopeTransferBarrier(statement)) break;

            const assignment = directAssignmentInfo(statement);
            if (assignment && assignment.name === info.name) {
                if (assignment.variable.isLocal !== true || !Array.isArray(assignment.init?.range)) break;
                // `local x; x = x or y` cannot become `local x = x or y`: the
                // initializer would resolve `x` to an outer/global binding instead
                // of the already-declared nil local. Recursive closure RHS has the
                // same problem, so reject any RHS reference to the moved local.
                if (containsNameRaw(assignment.init, info.name)) break;

                stats.deferredLocalInitializersFolded++;
                return {
                    compound: true,
                    edits: [
                        { start: declaration.range[0], end: declaration.range[1], replacement: "" },
                        {
                            start: statement.range[0],
                            end: statement.range[1],
                            replacement: `local ${info.name} = ${sourceOf(source, assignment.init)}`
                        }
                    ],
                    kind: "deferred-local-initialization",
                    statementIndex: declarationIndex,
                    assignmentIndex: index,
                };
            }

            const refs = { reads: [], writes: [], captured: false, redeclared: false };
            scanNameInNode(statement, info.name, refs, index, null, null, true);
            if (refs.reads.length || refs.writes.length || refs.captured || refs.redeclared) break;
        }
    }
    return null;
}

function findAdjacentCopyChainBatch(source, block, stats, limit = 128) {
    const edits = [];
    let transformCount = 0;
    let cursor = 0;
    while (transformCount < limit) {
        const trialStats = { adjacentCopyChainsFolded: 0 };
        const candidate = findAdjacentCopyChainFold(source, block, trialStats, cursor);
        if (!candidate) break;
        edits.push(...editParts(candidate));
        stats.adjacentCopyChainsFolded += trialStats.adjacentCopyChainsFolded;
        transformCount++;
        cursor = candidate.statementIndex + 2;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "adjacent-copy-chain" : "adjacent-copy-chain-batch" };
}

function findDeferredLocalInitializationBatch(source, block, stats, limit = 128) {
    const edits = [];
    let transformCount = 0;
    let cursor = 0;
    while (transformCount < limit) {
        const trialStats = { deferredLocalInitializersFolded: 0 };
        const candidate = findDeferredLocalInitialization(source, block, trialStats, cursor);
        if (!candidate) break;
        const parts = editParts(candidate);
        if (!parts.some(part => edits.some(selected => textEditRangesOverlap(part, selected)))) {
            edits.push(...parts);
            stats.deferredLocalInitializersFolded += trialStats.deferredLocalInitializersFolded;
            transformCount++;
        }
        cursor = candidate.statementIndex + 1;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "deferred-local-initialization" : "deferred-local-initialization-batch" };
}

const MAX_INLINE_FUNCTION_CODE_LINES = 100;

function collectCommentRanges(node, out = []) {
    if (!node) return out;
    if (Array.isArray(node)) {
        for (const child of node) collectCommentRanges(child, out);
        return out;
    }
    if (!isNode(node)) return out;
    if (node.type === "CommentStatement") {
        if (Array.isArray(node.range)) out.push(node.range);
        return out;
    }
    for (const key of Object.keys(node)) {
        if (key === "range" || key === "loc") continue;
        collectCommentRanges(node[key], out);
    }
    return out;
}

function effectiveFunctionCodeLines(source, functionNode) {
    if (functionNode?.type !== "FunctionDeclaration" || !Array.isArray(functionNode.range)) return Infinity;
    const [start, end] = functionNode.range;
    const chars = [...source.slice(start, end)];
    for (const range of collectCommentRanges(functionNode)) {
        const from = Math.max(start, range[0]) - start;
        const to = Math.min(end, range[1]) - start;
        for (let index = from; index < to; index++) {
            if (chars[index] !== "\n" && chars[index] !== "\r") chars[index] = " ";
        }
    }
    return chars.join("").split(/\r?\n/).reduce((count, line) => count + (line.trim() ? 1 : 0), 0);
}

function functionInlineReplacement(source, functionNode, read) {
    const text = sourceOf(source, functionNode);
    // Anonymous functions are already valid as ordinary call arguments. Keep that
    // common recovered-source form clean: pcall(function(...) ... end).
    if (read.parent?.type === "CallExpression" && read.key === "arguments") return text;
    return `(${text})`;
}

function isScalarTempExpression(node) {
    if (isLiteral(node) || isIdentifier(node)) return true;
    if (node?.type === "UnaryExpression") return isScalarTempExpression(node.argument);
    if (node?.type === "BinaryExpression" || node?.type === "LogicalExpression") {
        return isScalarTempExpression(node.left) && isScalarTempExpression(node.right);
    }
    return false;
}

function isLeadingScalarUse(node, target) {
    if (node === target) return true;
    if (!isNode(node)) return false;
    if (node.type === "UnaryExpression") return isLeadingScalarUse(node.argument, target);
    if (node.type === "LogicalExpression") {
        // A temp evaluated before the statement cannot move into the conditional
        // right arm of and/or: that arm may not execute at all.
        return isLeadingScalarUse(node.left, target);
    }
    if (node.type === "BinaryExpression") {
        if (isLeadingScalarUse(node.left, target)) return true;
        return isLiteral(node.left) && isLeadingScalarUse(node.right, target);
    }
    return false;
}

function immediateScalarConsumerIsSafe(statement, readNode) {
    if (statement?.type === "ReturnStatement") {
        const args = statement.arguments || [];
        return args.length === 1 && isLeadingScalarUse(args[0], readNode);
    }
    if (statement?.type === "LocalStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        return variables.length === 1 && init.length === 1 && isLeadingScalarUse(init[0], readNode);
    }
    if (statement?.type === "AssignmentStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        return variables.length === 1 && isIdentifier(variables[0]) && init.length === 1 && isLeadingScalarUse(init[0], readNode);
    }
    if (statement?.type === "IfStatement") {
        const clauses = statement.clauses || [];
        return clauses.length >= 1 && clauses[0]?.condition && isLeadingScalarUse(clauses[0].condition, readNode);
    }
    return false;
}

function tryOptimizeLocal(source, block, index, stats, mode = "inline", tailNode = null) {
    const statement = block[index];
    const info = mode === "dead" ? directLocalOrUninitializedInfo(statement) : directLocalInfo(statement);
    if (!info) return null;
    const refs = scanLaterReferences(block, index, info.name, tailNode);
    if (refs.captured || refs.redeclared || refs.writes.length) return null;
    const inlineMode = mode === "inline" || mode === "function-inline";
    const sameBlockRefs = inlineMode ? scanLaterReferencesSameBlock(block, index, info.name) : refs;
    if (inlineMode && sameBlockRefs.reads.length !== refs.reads.length) return null;

    if (refs.reads.length === 0) {
        if (mode !== "dead") return null;
        if (isEnvHeader(info)) {
            stats.deadLocals++;
            return { start: statement.range[0], end: statement.range[1], replacement: "", kind: "dead-env" };
        }
        if (isNoEffectExpression(info.init)) {
            stats.deadLocals++;
            return { start: statement.range[0], end: statement.range[1], replacement: "", kind: "dead-local" };
        }
        if (isStandaloneCall(info.init)) {
            stats.deadCallResults++;
            return {
                start: statement.range[0],
                end: statement.range[1],
                replacement: sourceOf(source, info.init),
                kind: "dead-call-result"
            };
        }
        return null;
    }

    if (mode === "dead") return null;
    if (sameBlockRefs.reads.length !== 1) return null;
    const read = sameBlockRefs.reads[0];
    if (!Array.isArray(read.node.range)) return null;
    const readTopStatement = block[read.topIndex];

    if (info.init?.type === "FunctionDeclaration" && !info.init.identifier) {
        if (effectiveFunctionCodeLines(source, info.init) > MAX_INLINE_FUNCTION_CODE_LINES) return null;
        // Keep closure creation in the same statement boundary. This avoids moving
        // the function across declarations/effects that could change lexical name
        // resolution or allocation timing. A loop header would recreate it per
        // iteration, so repeated-evaluation statements remain a hard barrier.
        if (read.topIndex !== index + 1) return null;
        if (isRepeatedEvaluationStatement(readTopStatement)) return null;
        stats.singleUseInlines++;
        stats.smallFunctionInlines++;
        return {
            compound: true,
            edits: [
                { start: statement.range[0], end: statement.range[1], replacement: "" },
                { start: read.node.range[0], end: read.node.range[1], replacement: functionInlineReplacement(source, info.init, read) }
            ],
            kind: "small-function-inline"
        };
    }
    if (mode === "function-inline") return null;

    // A source local declared outside a loop is a one-time snapshot even when the
    // value is literal. Keep that source shape instead of moving it into repeated
    // evaluation. Compiler-specific loop recovery is handled by dedicated passes.
    if (isLiteral(info.init)) {
        if (isRepeatedEvaluationStatement(readTopStatement)) return null;
        stats.singleUseInlines++;
        return {
            compound: true,
            edits: [
                { start: statement.range[0], end: statement.range[1], replacement: "" },
                { start: read.node.range[0], end: read.node.range[1], replacement: sourceOf(source, info.init) }
            ],
            kind: "literal-inline"
        };
    }

    const directLocals = collectDirectLocalNames(block);
    const sourceIsLexicalLocal = isIdentifier(info.init) && (info.init.isLocal === true || directLocals.has(info.init.name));
    if (sourceIsLexicalLocal) {
        // A declaration outside a loop is a one-time snapshot. Replacing its one
        // AST read inside a loop would re-read the source value every iteration.
        if (isRepeatedEvaluationStatement(readTopStatement)) return null;
        if (scanWritesInStatements(block, index, read.topIndex, info.init.name)) return null;
        stats.singleUseInlines++;
        return {
            compound: true,
            edits: [
                { start: statement.range[0], end: statement.range[1], replacement: "" },
                { start: read.node.range[0], end: read.node.range[1], replacement: info.init.name }
            ],
            kind: "local-alias-inline"
        };
    }

    // Compiler scalar temporaries can be folded into the immediately following
    // statement only when the use is in the leading evaluation position. This
    // keeps arithmetic/comparison metamethod timing and mutable-read order intact.
    if (!isIdentifier(info.init) && isScalarTempExpression(info.init) && read.topIndex === index + 1) {
        if (isRepeatedEvaluationStatement(readTopStatement)) return null;
        if (!immediateScalarConsumerIsSafe(readTopStatement, read.node)) return null;
        stats.singleUseInlines++;
        return {
            compound: true,
            edits: [
                { start: statement.range[0], end: statement.range[1], replacement: "" },
                { start: read.node.range[0], end: read.node.range[1], replacement: `(${sourceOf(source, info.init)})` }
            ],
            kind: "scalar-temp-inline"
        };
    }

    // A global lookup may have a metatable effect. Move it only across effect-free
    // sibling statements and only into call-base position, where it is evaluated
    // before call arguments just like the original declaration was.
    if (isIdentifier(info.init) && !sourceIsLexicalLocal) {
        const callBaseUse = read.parent?.type === "CallExpression" && read.key === "base";
        const immediateGenericIteratorUse = read.parent?.type === "ForGenericStatement" &&
            read.key === "iterators" && read.topIndex === index + 1;
        if (!callBaseUse && !immediateGenericIteratorUse) return null;
        // Direct globals are also snapshots when assigned to a local. Do not turn
        // one lookup before a loop into a fresh global lookup on every iteration.
        if (callBaseUse && isRepeatedEvaluationStatement(readTopStatement)) return null;
        if (callBaseUse && !barrierFree(block, index, read.topIndex)) return null;
        stats.globalAliasInlines++;
        return {
            compound: true,
            edits: [
                { start: statement.range[0], end: statement.range[1], replacement: "" },
                { start: read.node.range[0], end: read.node.range[1], replacement: info.init.name }
            ],
            kind: "global-alias-inline"
        };
    }

    return null;
}

function childStatementBlocks(node) {
    const blocks = [];
    if (!isNode(node)) return blocks;
    if (node.type === "FunctionDeclaration") return blocks;
    for (const key of Object.keys(node)) {
        if (key === "range" || key === "loc") continue;
        const value = node[key];
        if (Array.isArray(value)) {
            const nodes = value.filter(isNode);
            if (nodes.length && nodes.some(item => /Statement$/.test(item.type))) {
                blocks.push(value);
            } else {
                for (const child of nodes) blocks.push(...childStatementBlocks(child));
            }
        } else if (isNode(value)) {
            blocks.push(...childStatementBlocks(value));
        }
    }
    return blocks;
}

function findFunctionRecords(ast) {
    const root = { body: ast.body || [], parent: null };
    const records = [root];
    function visit(node, owner) {
        if (!node) return;
        if (Array.isArray(node)) {
            for (const child of node) visit(child, owner);
            return;
        }
        if (!isNode(node)) return;
        if (node.type === "FunctionDeclaration") {
            const record = { body: node.body || [], parent: owner };
            records.push(record);
            for (const statement of node.body || []) visit(statement, record);
            return;
        }
        for (const key of Object.keys(node)) {
            if (key === "range" || key === "loc") continue;
            visit(node[key], owner);
        }
    }
    for (const statement of root.body) visit(statement, root);
    return records;
}

function findFunctionBlocks(ast) {
    return findFunctionRecords(ast).map(record => record.body);
}

function repeatConditionByBody(functionBody) {
    const conditions = new Map();
    function visit(node) {
        if (!node) return;
        if (Array.isArray(node)) {
            for (const child of node) visit(child);
            return;
        }
        if (!isNode(node) || node.type === "FunctionDeclaration") return;
        if (node.type === "RepeatStatement" && Array.isArray(node.body) && node.condition) {
            conditions.set(node.body, node.condition);
        }
        for (const key of Object.keys(node)) {
            if (key === "range" || key === "loc") continue;
            visit(node[key]);
        }
    }
    visit(functionBody);
    return conditions;
}

function allBlocksForFunction(functionBody) {
    const out = [functionBody];
    const seen = new Set([functionBody]);
    function visitBlock(block) {
        for (const statement of block) {
            for (const child of childStatementBlocks(statement)) {
                if (seen.has(child)) continue;
                seen.add(child);
                out.push(child);
                visitBlock(child);
            }
        }
    }
    visitBlock(functionBody);
    return out;
}

function localOptimizationDeltaStats() {
    return {
        globalAliasInlines: 0,
        singleUseInlines: 0,
        smallFunctionInlines: 0,
        deadLocals: 0,
        deadCallResults: 0,
    };
}

function mergeLocalOptimizationStats(stats, delta) {
    stats.globalAliasInlines += delta.globalAliasInlines;
    stats.singleUseInlines += delta.singleUseInlines;
    stats.smallFunctionInlines += delta.smallFunctionInlines;
    stats.deadLocals += delta.deadLocals;
    stats.deadCallResults += delta.deadCallResults;
}

function editParts(edit) {
    return edit?.compound ? (edit.edits || []) : (edit ? [edit] : []);
}

function textEditRangesOverlap(left, right) {
    return left.start < right.end && right.start < left.end;
}

function findLocalOptimizationBatch(source, block, stats, limit = 128) {
    if (limit <= 0) return null;
    const selectedEdits = [];
    let transformCount = 0;

    for (let index = 0; index < block.length && transformCount < limit; index++) {
        const trialStats = localOptimizationDeltaStats();
        const candidate = tryOptimizeLocal(source, block, index, trialStats, "inline");
        if (!candidate) continue;
        const parts = editParts(candidate);
        if (!parts.length) continue;

        // All candidates were proven against this exact AST. Batch only source-
        // disjoint edits. Dependency chains overlap because one candidate edits
        // text inside a statement another candidate deletes, so those still force
        // a reparse before the dependent optimization is considered.
        if (parts.some(part => selectedEdits.some(selected => textEditRangesOverlap(part, selected)))) continue;

        selectedEdits.push(...parts);
        mergeLocalOptimizationStats(stats, trialStats);
        transformCount++;
    }

    if (!transformCount) return null;
    return {
        compound: true,
        edits: selectedEdits,
        transformCount,
        kind: transformCount === 1 ? "local-inline" : "local-inline-batch",
    };
}

function findLocalOptimizationBatchAcrossBlocks(source, blocks, stats, limit = 128) {
    if (limit <= 0) return null;
    const edits = [];
    let transformCount = 0;
    for (const block of blocks) {
        if (transformCount >= limit) break;
        const batch = findLocalOptimizationBatch(source, block, stats, limit - transformCount);
        if (!batch) continue;
        edits.push(...editParts(batch));
        transformCount += batch.transformCount || 1;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "local-inline" : "local-inline-cross-block-batch" };
}

function findSmallFunctionInlineBatch(source, block, stats, limit = 128) {
    if (limit <= 0) return null;
    const selectedEdits = [];
    let transformCount = 0;
    for (let index = 0; index < block.length && transformCount < limit; index++) {
        const trialStats = localOptimizationDeltaStats();
        const candidate = tryOptimizeLocal(source, block, index, trialStats, "function-inline");
        if (!candidate) continue;
        const parts = editParts(candidate);
        if (!parts.length || parts.some(part => selectedEdits.some(selected => textEditRangesOverlap(part, selected)))) continue;
        selectedEdits.push(...parts);
        mergeLocalOptimizationStats(stats, trialStats);
        transformCount++;
    }
    if (!transformCount) return null;
    return { compound: true, edits: selectedEdits, transformCount, kind: transformCount === 1 ? "small-function-inline" : "small-function-inline-batch" };
}

function findSmallFunctionInlineBatchAcrossBlocks(source, ast, stats, limit = 128) {
    const edits = [];
    let transformCount = 0;
    for (const functionBody of findFunctionBlocks(ast)) {
        for (const block of allBlocksForFunction(functionBody)) {
            if (transformCount >= limit) break;
            const batch = findSmallFunctionInlineBatch(source, block, stats, limit - transformCount);
            if (!batch) continue;
            edits.push(...editParts(batch));
            transformCount += batch.transformCount || 1;
        }
        if (transformCount >= limit) break;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "small-function-inline-final" : "small-function-inline-final-batch" };
}

function findTransformEdit(source, ast, stats, budget = 1) {
    const functionRecords = findFunctionRecords(ast);
    const effectiveEnvNames = new Map();
    for (const record of functionRecords) {
        const functionBody = record.body;
        const inheritedEnvName = record.parent ? (effectiveEnvNames.get(record.parent) || null) : null;
        const envContext = resolveEnvContext(functionBody, inheritedEnvName);
        effectiveEnvNames.set(record, envContext?.name || null);
        for (const block of allBlocksForFunction(functionBody)) {
            const repeatPrecheckEdit = findDiscardedRepeatPrecheck(source, block, stats);
            if (repeatPrecheckEdit) return repeatPrecheckEdit;
            const loopConditionEdit = findLoopConditionCollapse(source, block, stats);
            if (loopConditionEdit) return loopConditionEdit;
            const valueShortCircuitEdit = findValueShortCircuitCollapse(source, block, stats);
            if (valueShortCircuitEdit) return valueShortCircuitEdit;
            const multiReturnEdit = findMultiReturnTableCollapse(source, block, stats);
            if (multiReturnEdit) return multiReturnEdit;
            const multiReturnForwardEdit = findPackedCallUnpackForwarding(source, block, functionBody, stats);
            if (multiReturnForwardEdit) return multiReturnForwardEdit;
            const unusedReturnEdit = findUnusedMultiReturnTargetRename(source, block, stats);
            if (unusedReturnEdit) return unusedReturnEdit;
            const genericForEdit = findGenericForTupleInline(source, block, stats);
            if (genericForEdit) return genericForEdit;
            const deferredLocalEdit = findDeferredLocalInitializationBatch(source, block, stats, Math.min(128, budget));
            if (deferredLocalEdit) return deferredLocalEdit;
            const copyChainEdit = findAdjacentCopyChainBatch(source, block, stats, Math.min(128, budget));
            if (copyChainEdit) return copyChainEdit;
            const indexBaseAliasEdit = findAdjacentIndexBaseAliasBatch(source, block, stats, Math.min(128, budget));
            if (indexBaseAliasEdit) return indexBaseAliasEdit;
            const indexKeyEdit = findAdjacentIndexKeyBatch(source, block, functionBody, stats, Math.min(128, budget));
            if (indexKeyEdit) return indexKeyEdit;
            const assignmentKeyEdit = findAdjacentAssignmentKeyBatch(source, block, functionBody, stats, Math.min(128, budget));
            if (assignmentKeyEdit) return assignmentKeyEdit;
        }
        const envEdit = findEnvFold(source, functionBody, inheritedEnvName, Math.min(128, budget));
        if (envEdit) {
            stats.globalFolds += envEdit.transformCount || 1;
            return envEdit;
        }
        const inlineEdit = findLocalOptimizationBatchAcrossBlocks(source, allBlocksForFunction(functionBody), stats, Math.min(128, budget));
        if (inlineEdit) return inlineEdit;
    }
    return null;
}

function findPreFoldCleanupEdit(source, ast, stats, budget = 1) {
    const functionRoots = findFunctionBlocks(ast);
    const edits = [];
    let transformCount = 0;
    for (const functionBody of functionRoots) {
        if (transformCount >= budget) break;
        const edit = findPreFoldDeadNilAssignment(source, functionBody, stats, Math.min(128, budget - transformCount));
        if (!edit) continue;
        edits.push(...editParts(edit));
        transformCount += edit.transformCount || 1;
    }
    if (!transformCount) return null;
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "dead-direct-nil-cleanup" : "dead-direct-nil-cleanup-global-batch" };
}

function findDeadCleanupBatch(source, ast, stats, limit = 128) {
    // Cleanup deliberately runs after every structural/inline transform has
    // reached a fixed point. Candidates are all proven against the same AST;
    // only source-disjoint edits are batched. Dependency chains therefore wait
    // for the next parse, preserving the original bottom-to-top fixed point.
    if (limit <= 0) return null;
    const functionRoots = findFunctionBlocks(ast);
    const edits = [];
    let transformCount = 0;
    for (let rootIndex = functionRoots.length - 1; rootIndex >= 0 && transformCount < limit; rootIndex--) {
        const functionBody = functionRoots[rootIndex];
        const repeatConditions = repeatConditionByBody(functionBody);
        const blocks = allBlocksForFunction(functionBody);
        for (let blockIndex = blocks.length - 1; blockIndex >= 0 && transformCount < limit; blockIndex--) {
            const block = blocks[blockIndex];
            const tailNode = repeatConditions.get(block) || null;
            for (let index = block.length - 1; index >= 0 && transformCount < limit; index--) {
                const trialStats = localOptimizationDeltaStats();
                const candidate = tryOptimizeLocal(source, block, index, trialStats, "dead", tailNode);
                if (!candidate) continue;
                const parts = editParts(candidate);
                if (parts.some(part => edits.some(selected => textEditRangesOverlap(part, selected)))) continue;
                edits.push(...parts);
                mergeLocalOptimizationStats(stats, trialStats);
                transformCount++;
            }
            const last = block[block.length - 1];
            if (transformCount < limit && block === functionBody && last?.type === "ReturnStatement" && (last.arguments || []).length === 0 && Array.isArray(last.range)) {
                const candidate = { start: last.range[0], end: last.range[1], replacement: "", kind: "bare-return" };
                if (!edits.some(selected => textEditRangesOverlap(candidate, selected))) {
                    edits.push(candidate);
                    stats.bareReturnsRemoved++;
                    transformCount++;
                }
            }
        }
    }
    if (!transformCount) {
        // Dead cleanup may remove compiler storage between a tiny closure and its
        // sole use. Once no dead edit remains in this AST, allow only the dedicated
        // adjacent tiny-function inline; do not return to general transforms.
        return findSmallFunctionInlineBatchAcrossBlocks(source, ast, stats, limit);
    }
    return { compound: true, edits, transformCount, kind: transformCount === 1 ? "dead-cleanup" : "dead-cleanup-batch" };
}

function optimizeBetaSource(source, options = {}) {
    // `maxRounds` historically capped logical edits. With batching that made the
    // result depend on file size: one parse can safely apply 100+ edits and burn
    // the whole budget. Keep it as a backward-compatible alias for the actual
    // safety boundary: expensive full scoped parses. Logical transforms are stats.
    const maxParseRounds = Number.isInteger(options.maxParseRounds)
        ? Math.max(1, options.maxParseRounds)
        : (Number.isInteger(options.maxRounds) ? Math.max(1, options.maxRounds) : 1000);
    const batchLimit = Number.isInteger(options.batchLimit) ? Math.max(1, options.batchLimit) : 128;
    const stats = {
        rounds: 0,
        parseRounds: 0,
        parseLimitHit: false,
        globalFolds: 0,
        globalAliasInlines: 0,
        singleUseInlines: 0,
        smallFunctionInlines: 0,
        directNilCleanupWritesRemoved: 0,
        adjacentCopyChainsFolded: 0,
        adjacentIndexBaseAliasesFolded: 0,
        adjacentIndexKeyInlines: 0,
        adjacentAssignmentKeyInlines: 0,
        deferredLocalInitializersFolded: 0,
        deadLocals: 0,
        deadCallResults: 0,
        bareReturnsRemoved: 0,
        multiReturnTableCollapses: 0,
        multiReturnForwardersCollapsed: 0,
        multiReturnSlotsRecovered: 0,
        multiReturnPlaceholders: 0,
        multiReturnUnusedTargets: 0,
        genericForTupleInlines: 0,
        genericForTupleLocalsRemoved: 0,
        shortCircuitLaddersCollapsed: 0,
        valueShortCircuitLaddersCollapsed: 0,
        whileConditionsCollapsed: 0,
        repeatConditionsCollapsed: 0,
        repeatPrechecksRemoved: 0,
    };
    let current = source;

    function runPhase(label, findEdit) {
        for (let pass = 0; stats.parseRounds < maxParseRounds; pass++) {
            stats.parseRounds++;
            const ast = parseLua(current, `<beta-optimizer-${label}-${pass + 1}>`);
            const edit = findEdit(ast);
            if (!edit) return true;
            current = applyTextEdits(current, editParts(edit));
            const transformCount = Number.isInteger(edit.transformCount) && edit.transformCount > 0 ? edit.transformCount : 1;
            stats.rounds += transformCount;
        }
        return false;
    }

    // Phase 0: remove only proven dead direct-nil lifetime cleanup before any
    // folding. Do not revisit this phase later: a source-style `local t = nil;
    // local x = t` may legitimately fold to `local x = nil` and must remain.
    const preCleanupFixed = runPhase("pre-cleanup", ast => findPreFoldCleanupEdit(current, ast, stats, batchLimit));
    if (!preCleanupFixed) stats.parseLimitHit = true;

    // Phase 1: structural recovery and safe inlining to a fixed point.
    let transformFixed = false;
    if (!stats.parseLimitHit) {
        transformFixed = runPhase("transform", ast => findTransformEdit(current, ast, stats, batchLimit));
        if (!transformFixed) stats.parseLimitHit = true;
    }

    // Phase 2: unused/dead cleanup only, bottom-to-top. Do not return to the
    // transform phase after cleanup; dead storage is intentionally the last pass.
    if (!stats.parseLimitHit) {
        const deadFixed = runPhase("dead", ast => findDeadCleanupBatch(current, ast, stats, batchLimit));
        if (!deadFixed) stats.parseLimitHit = true;
    }

    parseLuaStructural(current, "<beta-optimizer-final>");
    return { source: current, applied: current !== source, stats };
}

module.exports = {
    optimizeBetaSource,
};
