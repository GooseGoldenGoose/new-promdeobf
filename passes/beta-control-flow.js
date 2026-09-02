// Fresh beta control-flow solver.
// Previous implementation is preserved unchanged in beta-control-flow-old.js.
// No fallback to legacy register-version or CF recovery.

const { findVmFunction } = require("./vm-state");
const { findVmReturnRegister } = require("./vm-register-names");

function unsupported(name) {
    return function () {
        return { applied: false, reason: `Fresh beta CF solver: ${name} is not implemented yet` };
    };
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function isSingleAssignment(statement, destination = null) {
    if (statement?.type !== "AssignmentStatement") return false;
    const variables = statement.variables || [];
    const init = statement.init || [];
    if (variables.length !== 1 || init.length !== 1) return false;
    return destination === null || isIdentifier(variables[0], destination);
}

function isPrimitiveLiteral(node) {
    return ["StringLiteral", "NumericLiteral", "BooleanLiteral", "NilLiteral"].includes(node?.type);
}

function significant(body) {
    return (body || []).filter(statement => statement?.type !== "CommentStatement");
}

function findStateWhile(vmFunction, stateName) {
    for (const statement of vmFunction.body || []) {
        if (statement?.type === "WhileStatement" && isIdentifier(statement.condition, stateName)) return statement;
    }
    return null;
}

function unwrapSingleStateLeaf(stateWhile, stateName) {
    let body = significant(stateWhile?.body);
    if (body.length !== 1 || body[0]?.type !== "IfStatement") return null;
    const clauses = body[0].clauses || [];
    if (clauses.length !== 1) return null;
    const clause = clauses[0];
    if (clause?.type !== "IfClause") return null;
    const condition = clause.condition;
    if (condition?.type !== "BinaryExpression" || condition.operator !== "==") return null;
    const stateOnLeft = isIdentifier(condition.left, stateName) && condition.right?.type === "NumericLiteral";
    const stateOnRight = isIdentifier(condition.right, stateName) && condition.left?.type === "NumericLiteral";
    if (!stateOnLeft && !stateOnRight) return null;
    return significant(clause.body);
}

function decodeJsonStringLiteral(node) {
    if (node?.type !== "StringLiteral" || typeof node.raw !== "string" || !node.raw.startsWith('"')) return null;
    try {
        const value = JSON.parse(node.raw);
        return typeof value === "string" ? value : null;
    } catch {
        return null;
    }
}

const LUA_KEYWORDS = new Set([
    "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in",
    "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "continue",
]);

function isLuaIdentifier(name) {
    return typeof name === "string" && /^[A-Za-z_][A-Za-z0-9_]*$/.test(name) && !LUA_KEYWORDS.has(name);
}

function sourceOf(source, node) {
    if (!Array.isArray(node?.range)) return null;
    return source.slice(node.range[0], node.range[1]);
}

function matchDirectGlobalCallLeaf(source, leaf, stateName, returnName) {
    if (!returnName || leaf.length < 4) return null;
    let index = 0;

    // Compiler GETGLOBAL key load: ReturnVal = "name"
    const keyLoad = leaf[index++];
    if (!isSingleAssignment(keyLoad, returnName)) return null;
    const globalName = decodeJsonStringLiteral(keyLoad.init[0]);
    if (!isLuaIdentifier(globalName)) return null;

    // Compiler GETGLOBAL environment read: state = _env[ReturnVal]
    const globalLoad = leaf[index++];
    if (!isSingleAssignment(globalLoad, stateName)) return null;
    const globalIndex = globalLoad.init[0];
    if (globalIndex?.type !== "IndexExpression" || !isIdentifier(globalIndex.base, "_env") || !isIdentifier(globalIndex.index, returnName)) return null;

    // Scheduler canonicalizes primitive argument producers immediately before
    // the call. Track each producer once; no search/backtracking is required.
    const argByRegister = new Map();
    while (index < leaf.length) {
        const statement = leaf[index];
        if (!isSingleAssignment(statement)) break;
        const destination = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(destination) || destination.name === stateName || destination.name === returnName || !isPrimitiveLiteral(rhs)) break;
        if (argByRegister.has(destination.name)) return null;
        const text = sourceOf(source, rhs);
        if (text === null) return null;
        argByRegister.set(destination.name, text);
        index++;
    }

    // Discarded source call result: ReturnVal = state(arg1, ...)
    const callStatement = leaf[index++];
    if (!isSingleAssignment(callStatement, returnName)) return null;
    const call = callStatement.init[0];
    if (call?.type !== "CallExpression" || !isIdentifier(call.base, stateName)) return null;
    const args = call.arguments || [];
    const renderedArgs = [];
    const used = new Set();
    for (const arg of args) {
        if (!isIdentifier(arg) || !argByRegister.has(arg.name) || used.has(arg.name)) return null;
        used.add(arg.name);
        renderedArgs.push(argByRegister.get(arg.name));
    }
    if (used.size !== argByRegister.size) return null;

    // Root VM terminal bookkeeping. It is accepted only in the exact proven
    // shapes and must consume the remainder of the leaf.
    let sawReturnReset = false;
    let sawStop = false;
    for (; index < leaf.length; index++) {
        const statement = leaf[index];
        if (!isSingleAssignment(statement)) return null;
        const destination = statement.variables[0];
        const rhs = statement.init[0];

        if (isIdentifier(destination, returnName) && rhs?.type === "TableConstructorExpression" && (rhs.fields || []).length === 0 && !sawReturnReset) {
            sawReturnReset = true;
            continue;
        }
        if (isIdentifier(destination, stateName) && rhs?.type === "NilLiteral" && sawReturnReset && !sawStop) {
            sawStop = true;
            continue;
        }
        if (isIdentifier(destination) && destination.name !== stateName && destination.name !== returnName && isIdentifier(rhs, "args") && !sawReturnReset && !sawStop) {
            continue;
        }
        return null;
    }
    if (!sawReturnReset || !sawStop) return null;

    return {
        source: `${globalName}(${renderedArgs.join(", ")})\n`,
        globalName,
        argumentCount: renderedArgs.length,
    };
}


function isEmptyTable(node) {
    return node?.type === "TableConstructorExpression" && (node.fields || []).length === 0;
}

function renderTableFields(fields, resolve) {
    const parts = [];
    for (const field of fields || []) {
        if (field?.type === "TableValue") {
            const value = resolve(field.value);
            if (typeof value !== "string") return null;
            parts.push(value);
            continue;
        }
        if (field?.type === "TableKey") {
            const key = resolve(field.key);
            const value = resolve(field.value);
            if (typeof key !== "string" || typeof value !== "string") return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            parts.push(member && isLuaIdentifier(member) ? member + " = " + value : "[" + key + "] = " + value);
            continue;
        }
        return null;
    }
    return "{ " + parts.join(", ") + " }";
}

function extractNormalizedStateLeaves(stateWhile, stateName) {
    const leaves = new Map();
    function walk(node) {
        if (!node || node.type !== "IfStatement") return true;
        for (const clause of node.clauses || []) {
            if (clause?.type === "IfClause" || clause?.type === "ElseifClause") {
                const c = clause.condition;
                const left = isIdentifier(c?.left, stateName) && c?.right?.type === "NumericLiteral";
                const right = isIdentifier(c?.right, stateName) && c?.left?.type === "NumericLiteral";
                if (c?.type === "BinaryExpression" && c.operator === "==" && (left || right)) {
                    const id = Number(left ? c.right.value : c.left.value);
                    if (!Number.isInteger(id) || leaves.has(id)) return false;
                    leaves.set(id, significant(clause.body));
                    continue;
                }
            }
            for (const statement of significant(clause?.body)) {
                if (statement?.type === "IfStatement" && !walk(statement)) return false;
            }
        }
        return true;
    }
    for (const statement of significant(stateWhile?.body)) {
        if (statement?.type === "IfStatement" && !walk(statement)) return null;
    }
    return leaves.size ? leaves : null;
}

function matchOwnedLocalTableProgram(source, stateWhile, stateName, returnName) {
    const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!leaves || !leaves.has(1)) return null;

    const root = leaves.get(1);
    const cleanupRegs = new Set();
    for (const statement of root) {
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (isIdentifier(dest) && dest.name !== stateName && dest.name !== returnName && rhs?.type === "NilLiteral") cleanupRegs.add(dest.name);
    }
    if (cleanupRegs.size !== 1) return null;
    const localReg = [...cleanupRegs][0];

    let firstLocalWrite = -1;
    for (let i = 0; i < root.length; i++) {
        if (isSingleAssignment(root[i], localReg) && root[i].init[0]?.type !== "NilLiteral") { firstLocalWrite = i; break; }
    }
    if (firstLocalWrite < 0) return null;
    for (let i = 0; i < firstLocalWrite; i++) if (isSingleAssignment(root[i], localReg)) return null;

    const firstRhs = root[firstLocalWrite].init[0];
    const copiedTransport = isIdentifier(firstRhs, stateName) || isIdentifier(firstRhs, returnName);
    const directPromotion = firstRhs?.type === "TableConstructorExpression" || isPrimitiveLiteral(firstRhs);
    if (!copiedTransport && !directPromotion) return null;

    const temps = new Map();
    const tempMeta = new Map();
    const out = [];
    let localDeclared = false;
    const localName = "t1";
    let sawCleanup = false, sawReturnReset = false, sawStop = false;
    const consumedClosures = new Set([1]);

    function renderClosureCall(call) {
        if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !/^createClosure\d*$/.test(call.base.name)) return null;
        const args = call.arguments || [];
        if (args.length !== 2 || args[0]?.type !== "NumericLiteral" || !isEmptyTable(args[1])) return null;
        const entryId = Number(args[0].value);
        if (!Number.isInteger(entryId) || consumedClosures.has(entryId)) return null;
        const child = leaves.get(entryId);
        if (!child) return null;
        let childReset = false, childStop = false;
        for (const statement of child) {
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0], rhs = statement.init[0];
            if (isIdentifier(dest, returnName) && isEmptyTable(rhs) && !childReset) { childReset = true; continue; }
            if (isIdentifier(dest, stateName) && rhs?.type === "NilLiteral" && childReset && !childStop) { childStop = true; continue; }
            return null;
        }
        if (!childReset || !childStop) return null;
        consumedClosures.add(entryId);
        return "function() end";
    }

    function resolve(node) {
        if (isPrimitiveLiteral(node) || isEmptyTable(node)) return sourceOf(source, node);
        if (node?.type === "TableConstructorExpression") return renderTableFields(node.fields || [], resolve);
        if (isIdentifier(node)) {
            if (node.name === localReg) return localDeclared ? localName : null;
            return temps.get(node.name) ?? null;
        }
        if (node?.type === "CallExpression") {
            const closure = renderClosureCall(node);
            if (closure) return closure;
        }
        return null;
    }

    function establishOrAssign(value) {
        if (typeof value !== "string") return false;
        if (!localDeclared) {
            localDeclared = true;
            out.push("local " + localName + " = " + value);
        } else out.push(localName + " = " + value);
        temps.set(localReg, localName);
        return true;
    }

    for (let i = 0; i < root.length; i++) {
        const statement = root[i];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0], rhs = statement.init[0];
        if (!isIdentifier(dest)) return null;
        const name = dest.name;

        if (name === localReg && rhs?.type === "NilLiteral") {
            if (!localDeclared || sawCleanup) return null;
            sawCleanup = true;
            temps.delete(localReg);
            continue;
        }
        if (name === returnName && isEmptyTable(rhs)) { sawReturnReset = true; continue; }
        if (name === stateName && rhs?.type === "NilLiteral") { sawStop = true; continue; }
        if (isIdentifier(rhs, "args") && name !== stateName && name !== returnName) continue;

        if (name === localReg) {
            const tableOwnedValue = rhs?.type === "TableConstructorExpression" ||
                (isIdentifier(rhs) && tempMeta.get(rhs.name)?.kind === "table");
            if (!tableOwnedValue) return null;
            let value = resolve(rhs);
            if (value == null && isIdentifier(rhs, stateName)) value = temps.get(stateName) ?? null;
            if (value == null && isIdentifier(rhs, returnName)) value = temps.get(returnName) ?? null;
            if (!establishOrAssign(value)) return null;
            tempMeta.set(localReg, { kind: "table" });
            continue;
        }

        if (rhs?.type === "CallExpression") {
            const closure = renderClosureCall(rhs);
            if (closure) { temps.set(name, closure); tempMeta.set(name, { kind: "closure" }); continue; }
        }
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && isIdentifier(rhs.index)) {
            const base = rhs.base.name === localReg ? localName : temps.get(rhs.base.name);
            const key = temps.get(rhs.index.name);
            if (typeof base !== "string" || typeof key !== "string") return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            const value = member && isLuaIdentifier(member) ? base + "." + member : base + "[" + key + "]";
            temps.set(name, value);
            tempMeta.set(name, member ? { kind: "member", base, member } : null);
            continue;
        }
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base)) {
            const base = temps.get(rhs.base.name);
            if (typeof base !== "string") return null;
            const args = [];
            for (const arg of rhs.arguments || []) {
                const value = isIdentifier(arg, localReg) ? localName : resolve(arg);
                if (typeof value !== "string") return null;
                args.push(value);
            }
            const meta = tempMeta.get(rhs.base.name);
            if (meta?.kind === "member" && args[0] === meta.base) {
                out.push(meta.base + ":" + meta.member + "(" + args.slice(1).join(", ") + ")");
                temps.set(name, "nil");
                continue;
            }
            return null;
        }
        const value = resolve(rhs);
        if (typeof value !== "string") return null;
        temps.set(name, value);
        if (rhs?.type === "TableConstructorExpression") tempMeta.set(name, { kind: "table" });
        else tempMeta.delete(name);
    }

    if (!localDeclared || !sawCleanup || !sawReturnReset || !sawStop) return null;
    if (consumedClosures.size !== leaves.size) return null;
    return { source: out.join("\n") + "\n", stateCount: leaves.size, statementCount: out.length, localCount: 1, closureCount: leaves.size - 1 };
}

function solveFreshSource(source, ast) {
    if (typeof source !== "string" || !ast) return { applied: false, reason: "Fresh beta CF requires normal output source and AST", mode: "fresh" };
    const vm = findVmFunction(ast);
    if (!vm) return { applied: false, reason: "Fresh beta CF: no semantically named vm function", mode: "fresh" };
    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) return { applied: false, reason: "Fresh beta CF: VM state parameter is not an identifier", mode: "fresh" };
    const stateName = stateParam.name;
    const returnName = findVmReturnRegister(vm.functionNode)?.name || null;
    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) return { applied: false, reason: "Fresh beta CF: no while <state> dispatcher", mode: "fresh" };
    const ownedLocalProgram = matchOwnedLocalTableProgram(source, stateWhile, stateName, returnName);
    if (ownedLocalProgram) return { applied: true, mode: "fresh-owned-local-table", ...ownedLocalProgram, branchCount: 0 };

    const leaf = unwrapSingleStateLeaf(stateWhile, stateName);
    if (!leaf) return { applied: false, reason: "Fresh beta CF: direct-call solver requires exactly one VM state", mode: "fresh" };

    const directCall = matchDirectGlobalCallLeaf(source, leaf, stateName, returnName);
    if (!directCall) return { applied: false, reason: "Fresh beta CF: one-state leaf is not a proven direct global call", mode: "fresh" };

    return {
        applied: true,
        mode: "fresh-direct-global-call",
        source: directCall.source,
        stateCount: 1,
        statementCount: 1,
        branchCount: 0,
        globalName: directCall.globalName,
        argumentCount: directCall.argumentCount,
    };
}

function solveBetaControlFlow(sourceOrAst, astOrBeta) {
    // New active API: solveBetaControlFlow(normalOutputSource, normalOutputAst)
    if (typeof sourceOrAst === "string") return solveFreshSource(sourceOrAst, astOrBeta);

    // Compatibility only: never revive the retired beta register pipeline.
    return {
        applied: false,
        reason: "Fresh beta CF no longer consumes beta register-version analysis; pass normal output source + AST",
        mode: "fresh",
    };
}

module.exports = {
    solveBetaControlFlow,
    matchDirectGlobalCallLeaf,
    matchOwnedLocalTableProgram,
    displayEnvironmentProvider: unsupported("displayEnvironmentProvider"),
    sinkTerminalReturnPayload: unsupported("sinkTerminalReturnPayload"),
    lowerTerminalReturn: unsupported("lowerTerminalReturn"),
    collapseCompilerNumericForLoops: unsupported("collapseCompilerNumericForLoops"),
    collapseCompilerGenericForLoops: unsupported("collapseCompilerGenericForLoops"),
    collapseCompilerWhileLoops: unsupported("collapseCompilerWhileLoops"),
    matchCompilerWhileConditionRegion: unsupported("matchCompilerWhileConditionRegion"),
    collapseCompilerRepeatLoops: unsupported("collapseCompilerRepeatLoops"),
    matchCompilerRepeatConditionRegion: unsupported("matchCompilerRepeatConditionRegion"),
    removeDuplicatedRepeatConditionRegions: unsupported("removeDuplicatedRepeatConditionRegions"),
    collapseCompilerStructuredLoops: unsupported("collapseCompilerStructuredLoops"),
    forwardControlOnlyJoinBranches: unsupported("forwardControlOnlyJoinBranches"),
    removeCompilerPosPreservationOperations: unsupported("removeCompilerPosPreservationOperations"),
    normalizeRegisterOverflowGraph: unsupported("normalizeRegisterOverflowGraph"),
};
