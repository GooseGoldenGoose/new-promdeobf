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
