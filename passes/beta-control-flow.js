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

function isEmptyTable(node) {
    return node?.type === "TableConstructorExpression" && (node.fields || []).length === 0;
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
    const body = significant(stateWhile?.body);
    if (body.length !== 1 || body[0]?.type !== "IfStatement") return null;
    const clauses = body[0].clauses || [];
    if (clauses.length !== 1) return null;
    const clause = clauses[0];
    if (clause?.type !== "IfClause") return null;
    const condition = clause.condition;
    if (condition?.type !== "BinaryExpression" || condition.operator !== "==") return null;
    const left = isIdentifier(condition.left, stateName) && condition.right?.type === "NumericLiteral";
    const right = isIdentifier(condition.right, stateName) && condition.left?.type === "NumericLiteral";
    if (!left && !right) return null;
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

function matchEnvLoad(statement, destinationName, keyName) {
    if (!isSingleAssignment(statement, destinationName)) return false;
    const rhs = statement.init[0];
    return rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index, keyName);
}

function matchDirectMemberCallable(leaf, index, stateName, returnName) {
    let cursor = index;

    // Start from a proven global load: key = "game"; value = _env[key].
    const baseKeyLoad = leaf[cursor];
    if (!isSingleAssignment(baseKeyLoad)) return null;
    const baseKeyReg = baseKeyLoad.variables[0];
    if (!isIdentifier(baseKeyReg)) return null;
    const baseName = decodeJsonStringLiteral(baseKeyLoad.init[0]);
    if (!isLuaIdentifier(baseName)) return null;

    const baseLoad = leaf[cursor + 1];
    if (!isSingleAssignment(baseLoad)) return null;
    const baseDest = baseLoad.variables[0];
    if (!isIdentifier(baseDest) || !matchEnvLoad(baseLoad, baseDest.name, baseKeyReg.name)) return null;

    let expression = baseName;
    let currentRegister = baseDest.name;
    let memberCount = 0;
    cursor += 2;

    // Follow any number of compiler IndexExpression hops. Each hop is exactly:
    // key = "member"; next = current[key]. No search or backtracking.
    while (cursor + 1 < leaf.length) {
        const keyLoad = leaf[cursor];
        if (!isSingleAssignment(keyLoad)) break;
        const keyReg = keyLoad.variables[0];
        if (!isIdentifier(keyReg)) break;
        const memberName = decodeJsonStringLiteral(keyLoad.init[0]);
        if (!isLuaIdentifier(memberName)) break;

        const memberLoad = leaf[cursor + 1];
        if (!isSingleAssignment(memberLoad)) break;
        const memberDest = memberLoad.variables[0];
        const memberIndex = memberLoad.init[0];
        if (!isIdentifier(memberDest) || memberIndex?.type !== "IndexExpression" ||
            !isIdentifier(memberIndex.base, currentRegister) || !isIdentifier(memberIndex.index, keyReg.name)) break;

        expression += `.${memberName}`;
        currentRegister = memberDest.name;
        memberCount++;
        cursor += 2;
    }

    if (memberCount === 0) return null;
    return { next: cursor, globalName: expression, register: currentRegister };
}

function readTempProducer(source, leaf, index, stateName, returnName, temps) {
    const statement = leaf[index];
    if (!isSingleAssignment(statement)) return null;
    const destination = statement.variables[0];
    const rhs = statement.init[0];
    if (!isIdentifier(destination) || destination.name === stateName || destination.name === returnName) return null;
    const name = destination.name;
    if (temps.has(name) && temps.get(name) !== null) return null;

    // Prefer the proven two-statement global-expression producer over treating
    // its string key as an ordinary argument literal.
    const globalName = decodeJsonStringLiteral(rhs);
    const load = leaf[index + 1];
    if (isLuaIdentifier(globalName) && isSingleAssignment(load)) {
        const valueDest = load.variables[0];
        if (isIdentifier(valueDest) && valueDest.name !== stateName && valueDest.name !== returnName &&
            (!temps.has(valueDest.name) || temps.get(valueDest.name) === null) && matchEnvLoad(load, valueDest.name, name)) {
            temps.set(valueDest.name, globalName);
            temps.set(name, null);
            return index + 2;
        }
    }

    if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) {
        const text = sourceOf(source, rhs);
        if (text === null) return null;
        temps.set(name, text);
        return index + 1;
    }

    return null;
}

function matchOneDirectGlobalCall(source, leaf, index, stateName, returnName) {
    const temps = new Map();
    let callable = null;

    while (index < leaf.length) {
        const statement = leaf[index];

        if (!callable) {
            const memberCallable = matchDirectMemberCallable(leaf, index, stateName, returnName);
            if (memberCallable) {
                callable = { globalName: memberCallable.globalName, register: memberCallable.register };
                index = memberCallable.next;
                continue;
            }
        }

        if (isSingleAssignment(statement, returnName)) {
            const rhs = statement.init[0];

            if (rhs?.type === "CallExpression" && callable && isIdentifier(rhs.base, callable.register)) break;

            const globalName = decodeJsonStringLiteral(rhs);
            if (isLuaIdentifier(globalName) && matchEnvLoad(leaf[index + 1], stateName, returnName)) {
                if (callable) return null;
                callable = { globalName, register: stateName };
                index += 2;
                continue;
            }
        }

        const next = readTempProducer(source, leaf, index, stateName, returnName, temps);
        if (next === null) return null;
        index = next;
    }

    if (!callable) return null;

    const callStatement = leaf[index];
    if (!isSingleAssignment(callStatement, returnName)) return null;
    const call = callStatement.init[0];
    if (call?.type !== "CallExpression" || !isIdentifier(call.base, callable.register)) return null;

    const renderedArgs = [];
    const used = new Set();
    for (const arg of call.arguments || []) {
        if (!isIdentifier(arg) || !temps.has(arg.name) || temps.get(arg.name) === null || used.has(arg.name)) return null;
        used.add(arg.name);
        renderedArgs.push(temps.get(arg.name));
    }

    for (const [name, value] of temps) {
        if (value !== null && !used.has(name)) return null;
    }

    return {
        next: index + 1,
        source: `${callable.globalName}(${renderedArgs.join(", ")})`,
        globalName: callable.globalName,
        argumentCount: renderedArgs.length,
    };
}

function matchLocalRegisterProgram(source, leaf, stateName, returnName, options = {}) {
    const cleanupRegs = new Set();
    for (const statement of leaf) {
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (isIdentifier(dest) && dest.name !== stateName && dest.name !== returnName && rhs?.type === "NilLiteral") {
            cleanupRegs.add(dest.name);
        }
    }
    if (cleanupRegs.size === 0) return null;

    const expr = new Map();
    const exprKinds = new Map();
    const locals = new Set();
    const localNames = new Map();
    const out = [];
    let declaredCount = 0;
    let valueLocalCount = 0;
    let tableLocalCount = 0;

    function localName(name) {
        return localNames.get(name) || name;
    }

    function nodeUsesIdentifier(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeUsesIdentifier(item, name))) return true;
            } else if (value && typeof value === "object" && nodeUsesIdentifier(value, name)) {
                return true;
            }
        }
        return false;
    }

    function valueUsedBeforeOverwrite(startIndex, name) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (nodeUsesIdentifier(statement?.init, name)) return true;
            if (isSingleAssignment(statement, name)) return false;
        }
        return false;
    }

    function renderRhs(rhs) {
        if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(source, rhs);
        if (rhs?.type === "TableConstructorExpression") {
            const fields = [];
            for (const field of rhs.fields || []) {
                if (field?.type !== "TableKey" || !isIdentifier(field.key) || !isIdentifier(field.value)) return null;
                const key = expr.get(field.key.name) ?? (locals.has(field.key.name) ? localName(field.key.name) : null);
                const value = expr.get(field.value.name) ?? (locals.has(field.value.name) ? localName(field.value.name) : null);
                if (key === null || key === undefined || value === null || value === undefined) return null;
                const name = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                fields.push(name && isLuaIdentifier(name) ? `${name} = ${value}` : `[${key}] = ${value}`);
            }
            return `{ ${fields.join(", ")} }`;
        }
        if (isIdentifier(rhs)) return expr.get(rhs.name) ?? (locals.has(rhs.name) ? localName(rhs.name) : null);
        if ((rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && isIdentifier(rhs.left) && isIdentifier(rhs.right)) {
            const left = expr.get(rhs.left.name) ?? (locals.has(rhs.left.name) ? localName(rhs.left.name) : null);
            const right = expr.get(rhs.right.name) ?? (locals.has(rhs.right.name) ? localName(rhs.right.name) : null);
            if (left === null || left === undefined || right === null || right === undefined || typeof rhs.operator !== "string") return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && isIdentifier(rhs.index)) {
            const key = expr.get(rhs.index.name);
            if (key === null || key === undefined) return null;
            if (rhs.base.name === "_env") {
                const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
            }
            const base = expr.get(rhs.base.name) ?? (locals.has(rhs.base.name) ? localName(rhs.base.name) : null);
            if (base === null || base === undefined) return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
        }
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base)) {
            if (typeof options.renderSpecialCall === "function") {
                const special = options.renderSpecialCall(rhs);
                if (special !== null && special !== undefined) return special;
            }
            const base = expr.get(rhs.base.name) ?? (locals.has(rhs.base.name) ? localName(rhs.base.name) : null);
            if (!base) return null;
            const args = [];
            for (const arg of rhs.arguments || []) {
                if (!isIdentifier(arg)) return null;
                const value = expr.get(arg.name) ?? (locals.has(arg.name) ? localName(arg.name) : null);
                if (value === null || value === undefined) return null;
                args.push(value);
            }
            return `${base}(${args.join(", ")})`;
        }
        return null;
    }

    for (let index = 0; index < leaf.length; index++) {
        const statement = leaf[index];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest)) return null;
        const name = dest.name;

        if (isIdentifier(rhs, "args") && name !== stateName && name !== returnName && !locals.has(name)) {
            expr.set(name, "args");
            exprKinds.set(name, "value");
            continue;
        }

        if (name === returnName && isEmptyTable(rhs)) continue;
        if (name === stateName && rhs?.type === "NilLiteral") continue;

        if (cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
            if (!locals.has(name)) return null;
            locals.delete(name);
            expr.delete(name);
            exprKinds.delete(name);
            localNames.delete(name);
            continue;
        }

        // Definite source-local ownership handoff: a cleanup-backed physical
        // register receives a previously computed expression register. POS and
        // RETURN temps cannot themselves be promoted, so these copies are strong
        // declaration evidence in the proven compiler shape.
        if (cleanupRegs.has(name) && !locals.has(name) && isIdentifier(rhs) && rhs.name !== name) {
            const value = expr.get(rhs.name) ?? (locals.has(rhs.name) ? localName(rhs.name) : null);
            if (value === null || value === undefined) return null;
            const kind = exprKinds.get(rhs.name) || "value";
            const displayName = kind === "table" ? `t${++tableLocalCount}` : `v${++valueLocalCount}`;
            localNames.set(name, displayName);
            out.push(`local ${displayName} = ${value}`);
            locals.add(name);
            expr.set(name, displayName);
            exprKinds.set(name, kind);
            declaredCount++;
            continue;
        }

        if (locals.has(name)) {
            const value = renderRhs(rhs);
            if (value === null) return null;
            out.push(`${localName(name)} = ${value}`);
            expr.set(name, localName(name));
            exprKinds.set(name, rhs?.type === "TableConstructorExpression" ? "table" : "value");
            continue;
        }

        if (rhs?.type === "CallExpression") {
            const value = renderRhs(rhs);
            if (value === null) return null;
            if (!valueUsedBeforeOverwrite(index, name)) out.push(value);
            expr.set(name, value);
            exprKinds.set(name, "value");
            continue;
        }

        const value = renderRhs(rhs);
        if (value === null) {
            // Proven dead TEMP write: the very next statement overwrites the
            // same non-local register before this value can be observed. This
            // occurs when the compiler briefly borrows the POS register and the
            // scheduler preserves the dead copy beside its overwrite.
            const next = leaf[index + 1];
            if (!locals.has(name) && !cleanupRegs.has(name) && isSingleAssignment(next, name)) {
                expr.delete(name);
                exprKinds.delete(name);
                continue;
            }
            return null;
        }
        expr.set(name, value);
        exprKinds.set(name, rhs?.type === "TableConstructorExpression" ? "table" : "value");
    }

    if (declaredCount === 0 || locals.size !== 0 || out.length === 0) return null;
    return {
        source: out.join("\n") + "\n",
        statementCount: out.length,
        localCount: declaredCount,
    };
}



function renderSimpleClosureLeaf(source, leaf, stateName, returnName) {
    const env = new Map();
    const paramNames = [];
    const body = [];
    let sawReturn = false;
    let sawStop = false;

    function resolveNode(node) {
        if (isPrimitiveLiteral(node) || isEmptyTable(node)) return sourceOf(source, node);
        if (isIdentifier(node)) return env.get(node.name) ?? null;
        if (node?.type === "IndexExpression") {
            if (isIdentifier(node.base, "args") && node.index?.type === "NumericLiteral") {
                const index = Number(node.index.value);
                if (!Number.isInteger(index) || index < 1) return null;
                while (paramNames.length < index) paramNames.push(`v${paramNames.length + 1}`);
                return paramNames[index - 1];
            }
            if (!isIdentifier(node.base) || !isIdentifier(node.index)) return null;
            const key = env.get(node.index.name);
            if (key == null) return null;
            if (node.base.name === "_env") {
                const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
            }
            const base = env.get(node.base.name);
            if (base == null) return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
        }
        if ((node?.type === "BinaryExpression" || node?.type === "LogicalExpression") && node.operator) {
            const left = resolveNode(node.left);
            const right = resolveNode(node.right);
            if (left == null || right == null) return null;
            return `(${left} ${node.operator} ${right})`;
        }
        if (node?.type === "CallExpression" && isIdentifier(node.base)) {
            const base = env.get(node.base.name);
            if (base == null) return null;
            const args = [];
            for (const arg of node.arguments || []) {
                const value = resolveNode(arg);
                if (value == null) return null;
                args.push(value);
            }
            return `${base}(${args.join(", ")})`;
        }
        return null;
    }

    for (let index = 0; index < leaf.length; index++) {
        const statement = leaf[index];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest)) return null;
        const name = dest.name;

        if (name === stateName && rhs?.type === "NilLiteral") {
            sawStop = true;
            continue;
        }
        if (name === returnName && rhs?.type === "TableConstructorExpression") {
            const values = [];
            for (const field of rhs.fields || []) {
                if (field?.type !== "TableValue") return null;
                const value = resolveNode(field.value);
                if (value == null) return null;
                values.push(value);
            }
            if (values.length > 0) body.push(`return ${values.join(", ")}`);
            sawReturn = true;
            continue;
        }
        if (rhs?.type === "NilLiteral" && name !== stateName && name !== returnName) {
            env.delete(name);
            continue;
        }

        const value = resolveNode(rhs);
        if (value == null) return null;
        env.set(name, value);
    }

    if (!sawReturn || !sawStop) return null;
    const lines = body.length ? body.map(line => `    ${line}`).join("\n") : "";
    return `function(${paramNames.join(", ")})${lines ? `\n${lines}\n` : ""}end`;
}

function matchClosureEntryProgram(source, stateWhile, stateName, returnName) {
    const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!leaves || leaves.size < 2 || !leaves.has(1)) return null;
    const consumedEntries = new Set([1]);

    function renderClosureCall(call) {
        if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !/^createClosure\d*$/.test(call.base.name)) return null;
        const args = call.arguments || [];
        if (args.length !== 2 || args[0]?.type !== "NumericLiteral" || !isEmptyTable(args[1])) return null;
        const entryId = Number(args[0].value);
        if (!Number.isInteger(entryId) || entryId === 1 || consumedEntries.has(entryId)) return null;
        const childLeaf = leaves.get(entryId);
        if (!childLeaf) return null;
        const rendered = renderSimpleClosureLeaf(source, childLeaf, stateName, returnName);
        if (!rendered) return null;
        consumedEntries.add(entryId);
        return rendered;
    }

    const root = leaves.get(1);
    const program = matchLocalRegisterProgram(source, root, stateName, returnName, { renderSpecialCall: renderClosureCall });
    if (!program) return null;
    if (consumedEntries.size !== leaves.size) return null;
    return { ...program, stateCount: leaves.size, closureCount: consumedEntries.size - 1 };
}

function extractNormalizedStateLeaves(stateWhile, stateName) {
    const leaves = new Map();

    function walk(node) {
        if (!node) return true;
        if (node.type === "IfStatement") {
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
        return true;
    }

    for (const statement of significant(stateWhile?.body)) {
        if (statement?.type === "IfStatement" && !walk(statement)) return null;
    }
    return leaves.size ? leaves : null;
}

function decodeLogicalStateTransition(rhs) {
    if (rhs?.type !== "LogicalExpression" || rhs.operator !== "or") return null;
    const left = rhs.left;
    if (left?.type !== "LogicalExpression" || left.operator !== "and") return null;
    if (!isIdentifier(left.left) || left.right?.type !== "NumericLiteral" || rhs.right?.type !== "NumericLiteral") return null;
    const onTrue = Number(left.right.value);
    const onFalse = Number(rhs.right.value);
    if (!Number.isInteger(onTrue) || !Number.isInteger(onFalse)) return null;
    return { conditionRegister: left.left.name, onTrue, onFalse };
}

function matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName) {
    const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!leaves || leaves.size < 2 || !leaves.has(1)) return null;

    const cleanupRegs = new Set();
    for (const body of leaves.values()) {
        for (const statement of body) {
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && dest.name !== stateName && dest.name !== returnName && rhs?.type === "NilLiteral") cleanupRegs.add(dest.name);
        }
    }
    if (!cleanupRegs.size) return null;

    const nonNilDefinitionCount = new Map([...cleanupRegs].map(name => [name, 0]));
    for (const body of leaves.values()) {
        for (const statement of body) {
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && cleanupRegs.has(dest.name) && rhs?.type !== "NilLiteral") {
                nonNilDefinitionCount.set(dest.name, nonNilDefinitionCount.get(dest.name) + 1);
            }
        }
    }
    const accumulatorRegs = new Set([...cleanupRegs].filter(name => nonNilDefinitionCount.get(name) > 1));

    const blocks = new Map();
    for (const [id, body] of leaves) {
        let transitionIndex = -1;
        let transition = null;
        for (let i = body.length - 1; i >= 0; i--) {
            if (!isSingleAssignment(body[i], stateName)) continue;
            const rhs = body[i].init[0];
            if (rhs?.type === "NilLiteral") {
                transitionIndex = i;
                transition = { kind: "stop" };
                break;
            }
            if (rhs?.type === "NumericLiteral" && Number.isInteger(Number(rhs.value))) {
                transitionIndex = i;
                transition = { kind: "jump", target: Number(rhs.value) };
                break;
            }
            const branch = decodeLogicalStateTransition(rhs);
            if (branch) {
                transitionIndex = i;
                transition = { kind: "branch", ...branch };
                break;
            }
        }
        if (!transition) return null;
        blocks.set(id, { id, body, transitionIndex, transition });
    }

    const successors = new Map([...blocks.keys()].map(id => [id, []]));
    const predecessors = new Map([...blocks.keys()].map(id => [id, []]));
    for (const [id, block] of blocks) {
        const targets = block.transition.kind === "jump" ? [block.transition.target]
            : block.transition.kind === "branch" ? [block.transition.onTrue, block.transition.onFalse] : [];
        for (const target of targets) {
            if (!blocks.has(target)) return null;
            successors.get(id).push(target);
            predecessors.get(target).push(id);
        }
    }

    const reachable = new Set();
    const queue = [1];
    while (queue.length) {
        const id = queue.shift();
        if (reachable.has(id)) continue;
        reachable.add(id);
        for (const next of successors.get(id) || []) queue.push(next);
    }
    if (reachable.size !== blocks.size) return null;

    const indegree = new Map();
    for (const id of reachable) indegree.set(id, (predecessors.get(id) || []).filter(p => reachable.has(p)).length);
    const ready = [1];
    const incoming = new Map([[1, [{ env: new Map(), markers: [] }]]]);
    const processed = new Set();
    const locals = new Set();
    const localNames = new Map();
    const out = [];
    let valueCount = 0;
    let tableCount = 0;

    function displayLocal(reg) { return localNames.get(reg) || reg; }
    function resolveId(name, env) {
        if (locals.has(name)) return displayLocal(name);
        return env.get(name) ?? null;
    }
    function render(rhs, env) {
        if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(source, rhs);
        if (isIdentifier(rhs)) return resolveId(rhs.name, env);
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && isIdentifier(rhs.index)) {
            const key = resolveId(rhs.index.name, env);
            if (key == null) return null;
            if (rhs.base.name === "_env") {
                const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
            }
            const base = resolveId(rhs.base.name, env);
            if (base == null) return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
        }
        if ((rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
            const left = isIdentifier(rhs.left) ? resolveId(rhs.left.name, env) : (isPrimitiveLiteral(rhs.left) ? sourceOf(source, rhs.left) : null);
            const right = isIdentifier(rhs.right) ? resolveId(rhs.right.name, env) : (isPrimitiveLiteral(rhs.right) ? sourceOf(source, rhs.right) : null);
            if (left == null || right == null) return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base)) {
            const base = resolveId(rhs.base.name, env);
            if (base == null) return null;
            const args = [];
            for (const arg of rhs.arguments || []) {
                const value = isIdentifier(arg) ? resolveId(arg.name, env) : (isPrimitiveLiteral(arg) ? sourceOf(source, arg) : null);
                if (value == null) return null;
                args.push(value);
            }
            return `${base}(${args.join(", ")})`;
        }
        return null;
    }

    function mergeCandidates(candidates) {
        if (candidates.length === 1) return { env: new Map(candidates[0].env), markers: [...(candidates[0].markers || [])] };
        if (candidates.length !== 2) return null;
        const a = candidates[0], b = candidates[1];
        const am = a.markers || [], bm = b.markers || [];
        let prefix = 0;
        while (prefix < am.length && prefix < bm.length && am[prefix].condition === bm[prefix].condition && am[prefix].truth === bm[prefix].truth) prefix++;
        if (am.length !== prefix + 1 || bm.length !== prefix + 1) return null;
        const al = am[prefix], bl = bm[prefix];
        if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth) return null;
        const t = al.truth ? a : b;
        const f = al.truth ? b : a;
        const cond = al.condition;
        const keys = new Set([...t.env.keys(), ...f.env.keys()]);
        keys.delete(stateName);
        const env = new Map();
        for (const key of keys) {
            const tv = t.env.get(key);
            const fv = f.env.get(key);
            if (tv === fv) {
                if (tv !== undefined) env.set(key, tv);
                continue;
            }
            if (tv === undefined || fv === undefined) {
                // Path-local TEMP: keep it unknown at the join. A later read
                // before redefinition will still fail closed.
                continue;
            }
            if (fv === cond && tv != null) env.set(key, `(${cond} and ${tv})`);
            else if (tv === cond && fv != null) env.set(key, `(${cond} or ${fv})`);
            else return null;
        }
        return { env, markers: am.slice(0, prefix) };
    }

    while (ready.length) {
        const id = ready.shift();
        if (processed.has(id)) continue;
        const candidates = incoming.get(id) || [];
        const merged = mergeCandidates(candidates);
        if (!merged) return null;
        let env = merged.env;
        let markers = merged.markers;
        const block = blocks.get(id);
        // Normalized dispatcher invariant: entering this leaf proves state == id.
        // The compiler may borrow/copy POS as an ordinary temporary before the
        // real transition at the end of the block.
        env.set(stateName, String(id));

        for (let i = 0; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (!isIdentifier(dest)) return null;
            const name = dest.name;

            if (isIdentifier(rhs, "args") && name !== stateName && name !== returnName) {
                env.set(name, "args");
                continue;
            }
            if (name === returnName && isEmptyTable(rhs)) continue;
            if (cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
                if (accumulatorRegs.has(name)) {
                    const value = env.get(name);
                    if (value == null) return null;
                    const display = `v${++valueCount}`;
                    out.push(`local ${display} = ${value}`);
                    env.delete(name);
                    continue;
                }
                if (!locals.has(name)) return null;
                locals.delete(name);
                localNames.delete(name);
                env.delete(name);
                continue;
            }

            const value = render(rhs, env);
            if (value == null) {
                // Borrowed state/temp writes may be dead before overwrite; only allow
                // an immediate same-register overwrite inside this block.
                const next = block.body[i + 1];
                if (name !== stateName && !locals.has(name) && isSingleAssignment(next, name)) continue;
                return null;
            }

            if (cleanupRegs.has(name) && !accumulatorRegs.has(name) && !locals.has(name) && isIdentifier(rhs) && rhs.name !== name) {
                const display = rhs?.type === "TableConstructorExpression" ? `t${++tableCount}` : `v${++valueCount}`;
                localNames.set(name, display);
                locals.add(name);
                out.push(`local ${display} = ${value}`);
                env.set(name, display);
            } else if (locals.has(name)) {
                out.push(`${displayLocal(name)} = ${value}`);
                env.set(name, displayLocal(name));
            } else {
                env.set(name, value);
            }
        }

        processed.add(id);
        const tr = block.transition;
        const sends = [];
        if (tr.kind === "jump") sends.push({ target: tr.target, env, markers });
        else if (tr.kind === "branch") {
            const condition = resolveId(tr.conditionRegister, env);
            if (condition == null) return null;
            sends.push({ target: tr.onTrue, env, markers: [...markers, { condition, truth: true }] });
            sends.push({ target: tr.onFalse, env, markers: [...markers, { condition, truth: false }] });
        }
        for (const send of sends) {
            if (!incoming.has(send.target)) incoming.set(send.target, []);
            incoming.get(send.target).push({ env: new Map(send.env), markers: [...(send.markers || [])] });
            indegree.set(send.target, indegree.get(send.target) - 1);
            if (indegree.get(send.target) === 0) ready.push(send.target);
        }
    }

    if (processed.size !== reachable.size || locals.size !== 0 || out.length === 0) return null;
    return { source: out.join("\n") + "\n", statementCount: out.length, localCount: valueCount + tableCount, stateCount: leaves.size };
}

function matchTerminalBookkeeping(leaf, index, stateName, returnName) {
    let sawReturnReset = false;
    let sawStop = false;
    let argsCopies = 0;

    for (; index < leaf.length; index++) {
        const statement = leaf[index];
        if (!isSingleAssignment(statement)) return null;
        const destination = statement.variables[0];
        const rhs = statement.init[0];

        if (isIdentifier(destination, returnName) && isEmptyTable(rhs) && !sawReturnReset) {
            sawReturnReset = true;
            continue;
        }
        if (isIdentifier(destination, stateName) && rhs?.type === "NilLiteral" && sawReturnReset && !sawStop) {
            sawStop = true;
            continue;
        }
        if (isIdentifier(destination) && destination.name !== stateName && destination.name !== returnName &&
            isIdentifier(rhs, "args") && !sawReturnReset && !sawStop) {
            argsCopies++;
            if (argsCopies > 1) return null;
            continue;
        }
        return null;
    }

    return sawReturnReset && sawStop ? index : null;
}

function matchDirectGlobalCallLeaf(source, leaf, stateName, returnName) {
    if (!returnName || leaf.length < 4) return null;

    let index = 0;
    const calls = [];
    let argumentCount = 0;

    while (index < leaf.length) {
        const terminal = matchTerminalBookkeeping(leaf, index, stateName, returnName);
        if (terminal !== null) {
            index = terminal;
            break;
        }

        const matched = matchOneDirectGlobalCall(source, leaf, index, stateName, returnName);
        if (!matched) return null;
        calls.push(matched);
        argumentCount += matched.argumentCount;
        index = matched.next;
    }

    if (index !== leaf.length || calls.length === 0) return null;

    return {
        source: calls.map(call => call.source).join("\n") + "\n",
        globalName: calls.length === 1 ? calls[0].globalName : null,
        argumentCount,
        callCount: calls.length,
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

    const closureProgram = matchClosureEntryProgram(source, stateWhile, stateName, returnName);
    if (closureProgram) {
        return {
            applied: true,
            mode: "fresh-closure-entry",
            source: closureProgram.source,
            stateCount: closureProgram.stateCount,
            statementCount: closureProgram.statementCount,
            branchCount: 0,
            localCount: closureProgram.localCount,
            closureCount: closureProgram.closureCount,
        };
    }

    const multiLogical = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName);
    if (multiLogical) {
        return {
            applied: true,
            mode: "fresh-multistate-logical",
            source: multiLogical.source,
            stateCount: multiLogical.stateCount,
            statementCount: multiLogical.statementCount,
            branchCount: multiLogical.stateCount - 1,
            localCount: multiLogical.localCount,
        };
    }

    const leaf = unwrapSingleStateLeaf(stateWhile, stateName);
    if (!leaf) return { applied: false, reason: "Fresh beta CF: unsupported multi-state control flow", mode: "fresh" };

    const localProgram = matchLocalRegisterProgram(source, leaf, stateName, returnName);
    if (localProgram) {
        return {
            applied: true,
            mode: "fresh-register-locals",
            source: localProgram.source,
            stateCount: 1,
            statementCount: localProgram.statementCount,
            branchCount: 0,
            localCount: localProgram.localCount,
        };
    }

    const directCalls = matchDirectGlobalCallLeaf(source, leaf, stateName, returnName);
    if (!directCalls) return { applied: false, reason: "Fresh beta CF: one-state leaf is not a proven direct global-call/register-local program", mode: "fresh" };

    return {
        applied: true,
        mode: "fresh-direct-global-call",
        source: directCalls.source,
        stateCount: 1,
        statementCount: directCalls.callCount,
        branchCount: 0,
        globalName: directCalls.globalName,
        argumentCount: directCalls.argumentCount,
        callCount: directCalls.callCount,
    };
}

function solveBetaControlFlow(sourceOrAst, astOrBeta) {
    if (typeof sourceOrAst === "string") return solveFreshSource(sourceOrAst, astOrBeta);
    return {
        applied: false,
        reason: "Fresh beta CF no longer consumes beta register-version analysis; pass normal output source + AST",
        mode: "fresh",
    };
}

module.exports = {
    solveBetaControlFlow,
    matchDirectGlobalCallLeaf,
    matchLocalRegisterProgram,
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
