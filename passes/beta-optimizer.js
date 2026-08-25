const { parseLuaStructural } = require("../main");
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
        if (isIdentifier(value, name) && !isNonReadIdentifier(value, parent, key)) {
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

function scanLaterReferences(block, declarationIndex, name) {
    const result = { reads: [], writes: [], captured: false, redeclared: false };
    for (let index = declarationIndex + 1; index < block.length; index++) {
        scanNameInNode(block[index], name, result, index, null, null, true);
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
    if (refs.writes.length || refs.redeclared || refs.captured) return null;
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
        if (key === "range" || key === "loc") continue;
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

function findEnvFold(source, block) {
    const env = findEnvContext(block);
    if (!env) return null;
    let found = null;
    function visit(node, parent = null, key = null) {
        if (found || !node) return;
        if (Array.isArray(node)) {
            for (const child of node) visit(child, parent, key);
            return;
        }
        if (!isNode(node)) return;
        if (node.type === "FunctionDeclaration") return;
        const globalName = globalNameFromEnvIndex(source, node, env.name);
        if (globalName && Array.isArray(node.range)) {
            found = { start: node.range[0], end: node.range[1], replacement: globalName, kind: "global-fold" };
            return;
        }
        for (const childKey of Object.keys(node)) {
            if (childKey === "range" || childKey === "loc") continue;
            visit(node[childKey], node, childKey);
        }
    }
    for (let index = env.declarationIndex + 1; index < block.length && !found; index++) visit(block[index]);
    return found;
}

function isRepeatedEvaluationStatement(statement) {
    return statement?.type === "WhileStatement" ||
        statement?.type === "RepeatStatement" ||
        statement?.type === "ForNumericStatement" ||
        statement?.type === "ForGenericStatement";
}

function tryOptimizeLocal(source, block, index, stats, mode = "inline") {
    const statement = block[index];
    const info = directLocalInfo(statement);
    if (!info) return null;
    const refs = scanLaterReferences(block, index, info.name);
    if (refs.captured || refs.redeclared || refs.writes.length) return null;

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
    if (refs.reads.length !== 1) return null;
    const read = refs.reads[0];
    if (!Array.isArray(read.node.range)) return null;
    const readTopStatement = block[read.topIndex];

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
    if (isIdentifier(info.init) && directLocals.has(info.init.name)) {
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

    // A global lookup may have a metatable effect. Move it only across effect-free
    // sibling statements and only into call-base position, where it is evaluated
    // before call arguments just like the original declaration was.
    if (isIdentifier(info.init) && !directLocals.has(info.init.name)) {
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

function findFunctionBlocks(ast) {
    const roots = [ast.body || []];
    function visit(node) {
        if (!node) return;
        if (Array.isArray(node)) {
            for (const child of node) visit(child);
            return;
        }
        if (!isNode(node)) return;
        if (node.type === "FunctionDeclaration") {
            if (Array.isArray(node.body)) roots.push(node.body);
            for (const statement of node.body || []) visit(statement);
            return;
        }
        for (const key of Object.keys(node)) {
            if (key === "range" || key === "loc") continue;
            visit(node[key]);
        }
    }
    visit(ast.body || []);
    return roots;
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

function findTransformEdit(source, ast, stats) {
    const functionRoots = findFunctionBlocks(ast);
    for (const functionBody of functionRoots) {
        for (const block of allBlocksForFunction(functionBody)) {
            const repeatPrecheckEdit = findDiscardedRepeatPrecheck(source, block, stats);
            if (repeatPrecheckEdit) return repeatPrecheckEdit;
            const loopConditionEdit = findLoopConditionCollapse(source, block, stats);
            if (loopConditionEdit) return loopConditionEdit;
            const multiReturnEdit = findMultiReturnTableCollapse(source, block, stats);
            if (multiReturnEdit) return multiReturnEdit;
            const unusedReturnEdit = findUnusedMultiReturnTargetRename(source, block, stats);
            if (unusedReturnEdit) return unusedReturnEdit;
            const genericForEdit = findGenericForTupleInline(source, block, stats);
            if (genericForEdit) return genericForEdit;
        }
        const envEdit = findEnvFold(source, functionBody);
        if (envEdit) {
            stats.globalFolds++;
            return envEdit;
        }
        for (const block of allBlocksForFunction(functionBody)) {
            for (let index = 0; index < block.length; index++) {
                const edit = tryOptimizeLocal(source, block, index, stats, "inline");
                if (edit) return edit;
            }
        }
    }
    return null;
}

function findDeadCleanupEdit(source, ast, stats) {
    // Cleanup deliberately runs after every structural/inline transform has
    // reached a fixed point. Scan nested/later code first and statements from
    // bottom to top so removing dead compiler storage cannot hide a structure
    // that an earlier recovery pass still needs.
    const functionRoots = findFunctionBlocks(ast);
    for (let rootIndex = functionRoots.length - 1; rootIndex >= 0; rootIndex--) {
        const blocks = allBlocksForFunction(functionRoots[rootIndex]);
        for (let blockIndex = blocks.length - 1; blockIndex >= 0; blockIndex--) {
            const block = blocks[blockIndex];
            for (let index = block.length - 1; index >= 0; index--) {
                const edit = tryOptimizeLocal(source, block, index, stats, "dead");
                if (edit) return edit;
            }
            const last = block[block.length - 1];
            if (last?.type === "ReturnStatement" && (last.arguments || []).length === 0 && Array.isArray(last.range)) {
                stats.bareReturnsRemoved++;
                return { start: last.range[0], end: last.range[1], replacement: "", kind: "bare-return" };
            }
        }
    }
    return null;
}

function optimizeBetaSource(source, options = {}) {
    const maxRounds = Number.isInteger(options.maxRounds) ? options.maxRounds : 1000;
    const stats = {
        rounds: 0,
        globalFolds: 0,
        globalAliasInlines: 0,
        singleUseInlines: 0,
        deadLocals: 0,
        deadCallResults: 0,
        bareReturnsRemoved: 0,
        multiReturnTableCollapses: 0,
        multiReturnSlotsRecovered: 0,
        multiReturnPlaceholders: 0,
        multiReturnUnusedTargets: 0,
        genericForTupleInlines: 0,
        genericForTupleLocalsRemoved: 0,
        shortCircuitLaddersCollapsed: 0,
        whileConditionsCollapsed: 0,
        repeatConditionsCollapsed: 0,
        repeatPrechecksRemoved: 0,
    };
    let current = source;
    let round = 0;

    // Phase 1: structural recovery and safe inlining to a fixed point.
    for (; round < maxRounds; round++) {
        const ast = parseLuaStructural(current, `<beta-optimizer-transform-${round + 1}>`);
        const edit = findTransformEdit(current, ast, stats);
        if (!edit) break;
        const edits = edit.compound ? edit.edits : [edit];
        current = applyTextEdits(current, edits);
        stats.rounds++;
    }

    // Phase 2: unused/dead cleanup only, bottom-to-top. Do not return to the
    // transform phase after cleanup; dead storage is intentionally the last pass.
    for (; round < maxRounds; round++) {
        const ast = parseLuaStructural(current, `<beta-optimizer-dead-${round + 1}>`);
        const edit = findDeadCleanupEdit(current, ast, stats);
        if (!edit) break;
        const edits = edit.compound ? edit.edits : [edit];
        current = applyTextEdits(current, edits);
        stats.rounds++;
    }

    parseLuaStructural(current, "<beta-optimizer-final>");
    return { source: current, applied: current !== source, stats };
}

module.exports = {
    optimizeBetaSource,
};
