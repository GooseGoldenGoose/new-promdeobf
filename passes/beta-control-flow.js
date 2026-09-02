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

function canonicalizeInitialSimpleLocals(lines) {
    const records = [];
    let prefixLength = 0;
    for (const line of lines) {
        const match = line.match(/^local\s+([vt]\d+)(?:\s*=\s*(.+))?$/);
        if (!match) break;
        const name = match[1], rhs = match[2] ?? null;
        let kind = null, sortKey = "";
        const deps = new Set();
        if (rhs === null) { kind = 3; sortKey = name; }
        else if (/^(?:true|false)$/.test(rhs)) { kind = 2; sortKey = rhs === "true" ? "0:true" : "1:false"; }
        else if (/^"(?:[^"\\]|\\.)*"$/.test(rhs)) { kind = 2; sortKey = `2:${rhs}`; }
        else if (/^-?(?:\d+(?:\.\d*)?|\.\d+)$/.test(rhs)) { kind = 2; sortKey = `3:${Number(rhs)}`; }
        else if (/^[A-Za-z_][A-Za-z0-9_]*$/.test(rhs) && !/^[vt]\d+$/.test(rhs)) { kind = 0; sortKey = rhs; }
        else {
            const member = rhs.match(/^([vt]\d+)(?:\.[A-Za-z_][A-Za-z0-9_]*)+$/);
            if (!member) break;
            kind = 1; deps.add(member[1]); sortKey = rhs.replace(/^[vt]\d+/, "");
        }
        records.push({ line, name, kind, sortKey, deps, originalIndex: records.length });
        prefixLength++;
    }
    if (records.length < 2 || !records.some(record => record.kind === 3)) return lines;
    const names = new Set(records.map(record => record.name));
    for (const record of records) for (const dep of [...record.deps]) if (!names.has(dep)) record.deps.delete(dep);
    const fanout = new Map(records.map(record => [record.name, 0]));
    for (const record of records) for (const dep of record.deps) fanout.set(dep, (fanout.get(dep) || 0) + 1);
    const remaining = new Map(records.map(record => [record.name, record]));
    const emitted = new Set(), ordered = [];
    while (remaining.size > 0) {
        const ready = [...remaining.values()].filter(record => [...record.deps].every(dep => emitted.has(dep)));
        if (ready.length === 0) return lines;
        ready.sort((a, b) => {
            if (a.kind !== b.kind) return a.kind - b.kind;
            if (a.kind === 0) {
                const fanoutDiff = (fanout.get(b.name) || 0) - (fanout.get(a.name) || 0);
                if (fanoutDiff) return fanoutDiff;
            }
            if (a.kind === 2 && /^3:/.test(a.sortKey) && /^3:/.test(b.sortKey)) return Number(a.sortKey.slice(2)) - Number(b.sortKey.slice(2));
            if (a.kind === 3) return Number(a.name.slice(1)) - Number(b.name.slice(1));
            const keyCompare = a.sortKey.localeCompare(b.sortKey);
            return keyCompare || a.originalIndex - b.originalIndex;
        });
        const next = ready[0];
        ordered.push(next.line); emitted.add(next.name); remaining.delete(next.name);
    }
    return [...ordered, ...lines.slice(prefixLength)];
}

function renderUnary(operator, argument) {
    if (typeof argument !== "string") return null;
    if (operator === "not") return `(not ${argument})`;
    if (operator === "-" || operator === "#") return `(${operator}${argument})`;
    return null;
}

function renderTableFields(fields, resolve) {
    const rendered = [];
    for (const field of fields || []) {
        if (field?.type === "TableValue") {
            const value = resolve(field.value);
            if (typeof value !== "string") return null;
            rendered.push(value);
            continue;
        }
        if (field?.type === "TableKey") {
            const key = resolve(field.key);
            const value = resolve(field.value);
            if (typeof key !== "string" || typeof value !== "string") return null;
            const fieldName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            rendered.push(fieldName && isLuaIdentifier(fieldName) ? `${fieldName} = ${value}` : `[${key}] = ${value}`);
            continue;
        }
        return null;
    }
    return `{ ${rendered.join(", ")} }`;
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
    const nonNilDefinitionCount = new Map();
    const nilDefinitionCount = new Map();
    const firstNilDefinitionIndex = new Map();
    for (let scanIndex = 0; scanIndex < leaf.length; scanIndex++) {
        const statement = leaf[scanIndex];
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest) || dest.name === stateName || dest.name === returnName) continue;
        if (rhs?.type === "NilLiteral") {
            cleanupRegs.add(dest.name);
            nilDefinitionCount.set(dest.name, (nilDefinitionCount.get(dest.name) || 0) + 1);
            if (!firstNilDefinitionIndex.has(dest.name)) firstNilDefinitionIndex.set(dest.name, scanIndex);
        } else {
            nonNilDefinitionCount.set(dest.name, (nonNilDefinitionCount.get(dest.name) || 0) + 1);
        }
    }
    if (cleanupRegs.size === 0 && options.allowNoLocals !== true) return null;

    const expr = new Map(), exprKinds = new Map(), exprMeta = new Map();
    const locals = new Set(), localNames = new Map(), out = [];
    let declaredCount = 0, valueLocalCount = 0, tableLocalCount = 0, nextPackOrder = 0;
    const pendingPacks = new Map(), packCreationOrder = new Map();
    let sawReturnReset = false, sawStop = false;
    const consumedPackRegs = new Set();
    const upvalueCells = new Map();
    const predeclaredNilLocals = new Set();
    const deferredStorageCopies = new Map();
    const deferredTerminalClosureCopies = new Map();
    const deferredUpvalueClosureStores = new Map();
    const terminalClosureLocals = new Set();
    const deferredSourceLines = [];

    function localName(name) { return localNames.get(name) || name; }
    function nodeUsesIdentifier(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeUsesIdentifier(item, name))) return true;
            } else if (value && typeof value === "object" && nodeUsesIdentifier(value, name)) return true;
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
    function hasLaterNilAssignment(startIndex, name) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (isSingleAssignment(statement, name) && statement.init[0]?.type === "NilLiteral") return true;
        }
        return false;
    }
    function hasOnlyDeadCopyUses(startIndex, name, seen = new Set()) {
        if (seen.has(name)) return false;
        const nextSeen = new Set(seen);
        nextSeen.add(name);
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, name)) return false;
                continue;
            }
            const dest = statement.variables[0];
            const value = statement.init[0];
            const rhsUses = nodeUsesIdentifier(value, name) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, name));
            if (rhsUses) {
                if (!isIdentifier(value, name) || !isIdentifier(dest) || dest.name === name || cleanupRegs.has(dest.name) || !hasOnlyDeadCopyUses(cursor, dest.name, nextSeen)) return false;
                continue;
            }
            if (isIdentifier(dest, name)) return true;
        }
        return true;
    }
    function findFutureTerminalClosureCopy(startIndex, tempReg) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, tempReg)) return null;
                continue;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && isIdentifier(rhs, tempReg) && dest.name !== stateName && dest.name !== returnName && !cleanupRegs.has(dest.name)) {
                let sawUse = false;
                for (let probe = cursor + 1; probe < leaf.length; probe++) {
                    const later = leaf[probe];
                    if (!isSingleAssignment(later)) {
                        if (nodeUsesIdentifier(later?.init, dest.name)) sawUse = true;
                        continue;
                    }
                    const laterDest = later.variables[0];
                    const laterRhs = later.init[0];
                    if (nodeUsesIdentifier(laterRhs, dest.name) || (laterDest?.type === "IndexExpression" && nodeUsesIdentifier(laterDest, dest.name))) sawUse = true;
                    if (isIdentifier(laterDest, dest.name)) return null;
                }
                return sawUse ? dest.name : null;
            }
            if (nodeUsesIdentifier(rhs, tempReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, tempReg))) return null;
            if (isIdentifier(dest, tempReg)) return null;
        }
        return null;
    }

    function findFutureUpvalueClosureStore(startIndex, tempReg) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, tempReg)) return null;
                continue;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (dest?.type === "IndexExpression" && isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index) && isIdentifier(rhs, tempReg)) {
                return upvalueCells.has(dest.index.name) && upvalueCells.get(dest.index.name) === null ? dest.index.name : null;
            }
            if (nodeUsesIdentifier(rhs, tempReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, tempReg))) return null;
            if (isIdentifier(dest, tempReg)) return null;
        }
        return null;
    }

    function isPurePendingTempRhs(rhs) {
        if (!rhs || typeof rhs !== "object") return false;
        if (rhs.type === "CallExpression" || rhs.type === "IndexExpression" || rhs.type === "FunctionDeclaration" || rhs.type === "FunctionExpression") return false;
        if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs) || isIdentifier(rhs)) return true;
        if (rhs.type === "UnaryExpression") return isPurePendingTempRhs(rhs.argument);
        if (rhs.type === "BinaryExpression" || rhs.type === "LogicalExpression") return isPurePendingTempRhs(rhs.left) && isPurePendingTempRhs(rhs.right);
        if (rhs.type === "TableConstructorExpression") {
            for (const field of rhs.fields || []) {
                if (field?.type === "TableValue") { if (!isPurePendingTempRhs(field.value)) return false; continue; }
                if (field?.type === "TableKey") { if (!isPurePendingTempRhs(field.key) || !isPurePendingTempRhs(field.value)) return false; continue; }
                if (field?.type === "TableKeyString") { if (!isPurePendingTempRhs(field.value)) return false; continue; }
                return false;
            }
            return true;
        }
        return false;
    }
    function isDeadPurePendingTemp(index, name, rhs) {
        if (!isPurePendingTempRhs(rhs)) return false;
        for (const packReg of pendingPacks.keys()) if (nodeUsesIdentifier(rhs, packReg)) return false;
        return hasOnlyDeadCopyUses(index, name);
    }

    function findFutureCleanupCopy(startIndex, tempReg) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, tempReg)) return null;
                continue;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && cleanupRegs.has(dest.name) && isIdentifier(rhs, tempReg)) return dest.name;
            if (nodeUsesIdentifier(rhs, tempReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, tempReg))) return null;
            if (isIdentifier(dest, tempReg)) return null;
        }
        return null;
    }
    function isPosPreservationCopy(startIndex, destReg, rhs) {
        if (!isIdentifier(rhs, stateName) || (nonNilDefinitionCount.get(destReg) || 0) <= 1) return false;
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, destReg)) return false;
                continue;
            }
            const dest = statement.variables[0];
            const value = statement.init[0];
            if (isIdentifier(dest, destReg)) return false;
            if (nodeUsesIdentifier(value, destReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, destReg))) {
                return isIdentifier(dest, stateName) && isIdentifier(value, destReg);
            }
        }
        return false;
    }
    function allocateLocal(reg, kind = "value") {
        if (localNames.has(reg)) return localName(reg);
        const displayName = kind === "table" ? `t${++tableLocalCount}` : `v${++valueLocalCount}`;
        localNames.set(reg, displayName); locals.add(reg); expr.set(reg, displayName); exprKinds.set(reg, kind); declaredCount++;
        return displayName;
    }
    function reserveLocal(reg, preserveExpression = false) {
        locals.add(reg);
        if (!preserveExpression) exprKinds.set(reg, "value");
    }
    function canPredeclareNilLocal(name, index) {
        return cleanupRegs.has(name) &&
            (nonNilDefinitionCount.get(name) || 0) === 0 &&
            (nilDefinitionCount.get(name) || 0) >= 2 &&
            (firstNilDefinitionIndex.get(name) ?? -1) > index &&
            !locals.has(name) && !expr.has(name);
    }
    function predeclareNilReads(node, index) {
        if (!node || typeof node !== "object") return;
        if (Array.isArray(node)) {
            for (const item of node) predeclareNilReads(item, index);
            return;
        }
        if (isIdentifier(node)) {
            if (canPredeclareNilLocal(node.name, index)) {
                const displayName = allocateLocal(node.name, "value");
                out.push(`local ${displayName}`);
                predeclaredNilLocals.add(node.name);
            }
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            predeclareNilReads(value, index);
        }
    }
    function flushPendingPacks() {
        if (!pendingPacks.size) return true;
        const packs = [...pendingPacks.values()].sort((a, b) => a.order - b.order);
        for (const pendingPack of packs) {
            const slots = [...pendingPack.slots.keys()].sort((a, b) => a - b);
            if (!slots.length || slots[0] !== 1) return false;
            for (let i = 0; i < slots.length; i++) {
                if (slots[i] !== i + 1) return false;
                const slot = pendingPack.slots.get(slots[i]);
                if (!slot?.localReg) return false;
                if (typeof slot.displayName !== "string") {
                    if (locals.has(slot.localReg)) {
                        slot.displayName = allocateLocal(slot.localReg, "value");
                    } else {
                        slot.displayName = `v${++valueLocalCount}`;
                        declaredCount++;
                    }
                }
            }
            const names = slots.map(i => pendingPack.slots.get(i).displayName);
            out.push(`local ${names.join(", ")} = ${pendingPack.call}`);
            consumedPackRegs.add(pendingPack.packReg);
            for (let i = 0; i < deferredSourceLines.length;) {
                if (deferredSourceLines[i].afterPackOrder <= pendingPack.order) {
                    out.push(deferredSourceLines[i].line);
                    deferredSourceLines.splice(i, 1);
                } else i++;
            }
        }
        pendingPacks.clear();
        return deferredSourceLines.length === 0;
    }
    function memberMeta(rhs) {
        if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base) || !isIdentifier(rhs.index) || rhs.base.name === "_env") return null;
        const key = expr.get(rhs.index.name) ?? (locals.has(rhs.index.name) ? localName(rhs.index.name) : null);
        const base = expr.get(rhs.base.name) ?? (locals.has(rhs.base.name) ? localName(rhs.base.name) : null);
        if (typeof key !== "string" || typeof base !== "string") return null;
        const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
        return member && isLuaIdentifier(member) ? { kind: "member", base, member } : null;
    }
    function renderCallArg(arg) {
        if (isPrimitiveLiteral(arg) || isEmptyTable(arg)) return sourceOf(source, arg);
        if (isIdentifier(arg)) return expr.get(arg.name) ?? (locals.has(arg.name) ? localName(arg.name) : null);
        if (arg?.type === "CallExpression" && isIdentifier(arg.base, "unpack") && (arg.arguments || []).length === 1 && isIdentifier(arg.arguments[0])) {
            const packReg = arg.arguments[0].name;
            if (exprKinds.get(packReg) === "return-pack") return expr.get(packReg) ?? null;
        }
        return renderRhs(arg);
    }
    function renderRhs(rhs) {
        if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(source, rhs);
        if (rhs?.type === "TableConstructorExpression") {
            const fields = rhs.fields || [];
            if (fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression") return renderRhs(fields[0].value);
            return renderTableFields(fields, renderRhs);
        }
        if (isIdentifier(rhs)) return expr.get(rhs.name) ?? (locals.has(rhs.name) ? localName(rhs.name) : null);
        if (rhs?.type === "UnaryExpression") {
            const argument = renderRhs(rhs.argument);
            return renderUnary(rhs.operator, argument);
        }
        if (rhs?.type === "BinaryExpression" && typeof rhs.operator === "string") {
            const left = renderRhs(rhs.left);
            const right = renderRhs(rhs.right);
            if (typeof left !== "string" || typeof right !== "string") return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "LogicalExpression" && isIdentifier(rhs.left) && isIdentifier(rhs.right)) {
            const left = expr.get(rhs.left.name) ?? (locals.has(rhs.left.name) ? localName(rhs.left.name) : null);
            const right = expr.get(rhs.right.name) ?? (locals.has(rhs.right.name) ? localName(rhs.right.name) : null);
            if (left == null || right == null || typeof rhs.operator !== "string") return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base)) {
            if (rhs.base.name === "upvalueValues" && isIdentifier(rhs.index)) {
                const captureName = upvalueCells.get(rhs.index.name);
                return typeof captureName === "string" ? captureName : null;
            }
            if (exprKinds.get(rhs.base.name) === "return-pack" && rhs.index?.type === "NumericLiteral") {
                const slot = Number(rhs.index.value);
                if (!Number.isInteger(slot) || slot < 1) return null;
                return { packSlot: true, packReg: rhs.base.name, slot, call: expr.get(rhs.base.name) };
            }
            if (!isIdentifier(rhs.index)) return null;
            const key = expr.get(rhs.index.name);
            if (key == null) return null;
            if (rhs.base.name === "_env") {
                const globalName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                return globalName && isLuaIdentifier(globalName) ? globalName : `_env[${key}]`;
            }
            const base = expr.get(rhs.base.name) ?? (locals.has(rhs.base.name) ? localName(rhs.base.name) : null);
            if (base == null) return null;
            const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            return member && isLuaIdentifier(member) ? `${base}.${member}` : `${base}[${key}]`;
        }
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base)) {
            if (/^createClosure\d*$/.test(rhs.base.name) && typeof options.renderCapturedCall === "function") {
                const args = rhs.arguments || [];
                const fields = args[1]?.type === "TableConstructorExpression" ? args[1].fields || [] : [];
                if (args.length === 2 && args[0]?.type === "NumericLiteral" && fields.length > 0) {
                    const captureNames = new Map();
                    for (let i = 0; i < fields.length; i++) {
                        const field = fields[i];
                        if (field?.type !== "TableValue" || !isIdentifier(field.value)) return null;
                        const captureName = upvalueCells.get(field.value.name);
                        if (typeof captureName !== "string") return null;
                        captureNames.set(i + 1, captureName);
                    }
                    const special = options.renderCapturedCall(rhs, captureNames);
                    if (special != null) return special;
                }
            }
            if (typeof options.renderSpecialCall === "function") {
                const special = options.renderSpecialCall(rhs);
                if (special != null) return special;
            }
            if (rhs.base.name === "unpack" && (rhs.arguments || []).length === 1 && isIdentifier(rhs.arguments[0])) {
                const packReg = rhs.arguments[0].name;
                if (exprKinds.get(packReg) === "return-pack") return expr.get(packReg) ?? null;
            }
            const base = expr.get(rhs.base.name) ?? (locals.has(rhs.base.name) ? localName(rhs.base.name) : null);
            if (!base) return null;
            const args = [];
            for (const arg of rhs.arguments || []) {
                const value = renderCallArg(arg);
                if (typeof value !== "string") return null;
                args.push(value);
            }
            const member = exprMeta.get(rhs.base.name);
            if (member?.kind === "member" && args.length > 0 && args[0] === member.base) {
                return `${member.base}:${member.member}(${args.slice(1).join(", ")})`;
            }
            return `${base}(${args.join(", ")})`;
        }
        return null;
    }

    for (let index = 0; index < leaf.length; index++) {
        const statement = leaf[index];
        if (options.diagnostics) { options.diagnostics.statementIndex = index; options.diagnostics.statement = sourceOf(source, statement) || statement?.type || "unknown"; }
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0], rhs = statement.init[0];
        predeclareNilReads(rhs, index);
        if (dest?.type === "IndexExpression" && isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index)) {
            if (!upvalueCells.has(dest.index.name)) return null;
            const deferredTemp = deferredUpvalueClosureStores.get(dest.index.name);
            if (deferredTemp != null) {
                if (!isIdentifier(rhs, deferredTemp) || typeof upvalueCells.get(dest.index.name) !== "string") return null;
                deferredUpvalueClosureStores.delete(dest.index.name);
                continue;
            }
            const value = renderRhs(rhs);
            if (typeof value !== "string" || typeof upvalueCells.get(dest.index.name) === "string") return null;
            const displayName = `v${++valueLocalCount}`;
            upvalueCells.set(dest.index.name, displayName);
            out.push(`local ${displayName} = ${value}`);
            declaredCount++;
            continue;
        }
        if (dest?.type === "IndexExpression" && isIdentifier(dest.base) && isIdentifier(dest.index)) {
            const key = renderRhs(dest.index);
            const value = renderRhs(rhs);
            if (typeof key !== "string" || typeof value !== "string") return null;
            const fieldName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            if (dest.base.name === "_env") {
                if (!fieldName || !isLuaIdentifier(fieldName)) return null;
                out.push(`${fieldName} = ${value}`);
                continue;
            }
            const base = renderRhs(dest.base);
            const baseMeta = exprMeta.get(dest.base.name);
            const stableBase = locals.has(dest.base.name) || exprKinds.get(dest.base.name) === "table" || baseMeta?.kind === "member";
            if (typeof base !== "string" || !stableBase) return null;
            const target = fieldName && isLuaIdentifier(fieldName) ? `${base}.${fieldName}` : `${base}[${key}]`;
            out.push(`${target} = ${value}`);
            continue;
        }
        if (!isIdentifier(dest)) return null;
        const name = dest.name;
        const isPackIndex = rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && exprKinds.get(rhs.base.name) === "return-pack" && rhs.index?.type === "NumericLiteral";
        const isPackSlotCopy = isIdentifier(rhs) && exprKinds.get(rhs.name) === "pack-slot";
        const returnPackFields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
        const isReturnPackCreation = returnPackFields.length === 1 && returnPackFields[0]?.type === "TableValue" && returnPackFields[0].value?.type === "CallExpression";
        const isDeferredStorageCopy = isIdentifier(rhs) && deferredStorageCopies.get(name) === rhs.name;
        const isDeferredTerminalClosureCopy = isIdentifier(rhs) && deferredTerminalClosureCopies.get(name) === rhs.name;
        const isDeadRegisterCopy = isIdentifier(rhs) && name !== stateName && name !== returnName && !cleanupRegs.has(name) && hasOnlyDeadCopyUses(index, name);
        const isKnownUpvalueRead = rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index) && typeof upvalueCells.get(rhs.index.name) === "string";
        const isUpvalueAllocation = rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0 && name !== stateName && name !== returnName && !upvalueCells.has(name);
        const releaseArgs = rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue") ? (rhs.arguments || []) : null;
        const isKnownUpvalueRelease = releaseArgs?.length === 1 && isIdentifier(releaseArgs[0], name) && name !== stateName && name !== returnName && upvalueCells.has(name);
        const isCallExpression = rhs?.type === "CallExpression";
        const isClosureCreation = isCallExpression && isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name);
        const cleanupFutureLocal = isCallExpression ? findFutureCleanupCopy(index, name) : null;
        const terminalClosureFutureLocal = isClosureCreation && !cleanupFutureLocal ? findFutureTerminalClosureCopy(index, name) : null;
        const upvalueClosureFutureCell = isClosureCreation && !cleanupFutureLocal && !terminalClosureFutureLocal ? findFutureUpvalueClosureStore(index, name) : null;
        const callFutureLocal = cleanupFutureLocal || terminalClosureFutureLocal;
        const callResultIsDiscarded = isCallExpression && hasOnlyDeadCopyUses(index, name);
        const callPackBarrier = isCallExpression && pendingPacks.size ? Math.max(...[...pendingPacks.values()].map(pack => pack.order)) : 0;
        const hasTrackedPackBarrier = callPackBarrier > 0;
        const isDeferredClosureCreation = isClosureCreation && (!!callFutureLocal || !!upvalueClosureFutureCell) && hasTrackedPackBarrier;
        const isDeferredOrdinaryCall = isCallExpression && !isClosureCreation && hasTrackedPackBarrier && (!!callFutureLocal || callResultIsDiscarded);
        const isDeadPureTemp = pendingPacks.size > 0 && isDeadPurePendingTemp(index, name, rhs);
        const isPendingNeutralBookkeeping =
            (isIdentifier(rhs, "args") && name !== stateName && name !== returnName) ||
            (rhs?.type === "NilLiteral" && cleanupRegs.has(name)) ||
            isKnownUpvalueRead ||
            isUpvalueAllocation ||
            isKnownUpvalueRelease ||
            isDeferredClosureCreation ||
            isDeferredOrdinaryCall ||
            isDeadPureTemp ||
            isDeadRegisterCopy ||
            isDeferredStorageCopy ||
            isDeferredTerminalClosureCopy;
        if (pendingPacks.size && !isPackIndex && !isPackSlotCopy && !isReturnPackCreation && !isPendingNeutralBookkeeping && !flushPendingPacks()) return null;

        if (isDeferredStorageCopy || isDeferredTerminalClosureCopy) {
            if (isDeferredStorageCopy) deferredStorageCopies.delete(name);
            else deferredTerminalClosureCopies.delete(name);
            if (!locals.has(name)) return null;
            expr.set(name, localName(name));
            exprKinds.set(name, "value");
            continue;
        }

        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0) {
            if (name === stateName || name === returnName || upvalueCells.has(name)) return null;
            upvalueCells.set(name, null);
            continue;
        }
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue")) {
            const args = rhs.arguments || [];
            if (args.length !== 1 || !isIdentifier(args[0]) || args[0].name !== name || !upvalueCells.has(name)) return null;
            upvalueCells.delete(name);
            continue;
        }
        if (isIdentifier(rhs, "args") && name !== stateName && name !== returnName && !locals.has(name)) {
            expr.set(name, "args"); exprKinds.set(name, "value"); continue;
        }
        if (name === returnName && isEmptyTable(rhs) && !valueUsedBeforeOverwrite(index, returnName)) { sawReturnReset = true; continue; }
        if (name === stateName && rhs?.type === "NilLiteral") {
            if (valueUsedBeforeOverwrite(index, stateName)) {
                expr.set(stateName, "nil"); exprKinds.set(stateName, "value"); continue;
            }
            sawStop = true; continue;
        }
        if (cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
            if (!locals.has(name)) {
                // Prometheus uses nil for both semantic source values and dead/temporary register state.
                // Preserve a nil lifetime only when this exact definition reaches a read before overwrite.
                // Otherwise the definition is unobservable and may be dropped; a later meaningful write can
                // still establish the source lifetime through the normal cleanup-backed promotion rules.
                if (!valueUsedBeforeOverwrite(index, name)) {
                    const nonNilDefs = nonNilDefinitionCount.get(name) || 0;
                    // A nil-only VAR lifetime has a compiler-emitted nil value plus a later scope-end nil.
                    // Ordinary TEMP registers are freed internally and do not receive that cleanup write.
                    if (nonNilDefs === 0 && hasLaterNilAssignment(index, name)) {
                        const displayName = allocateLocal(name, "value");
                        out.push(`local ${displayName}`);
                        continue;
                    }
                    // Multiple meaningful definitions before cleanup cannot prove where VAR ownership began.
                    if (nonNilDefs > 1) return null;
                    // Single unobserved nil (or nil overwritten by one meaningful definition) is dead.
                    continue;
                }
                const displayName = allocateLocal(name, "value");
                out.push(`local ${displayName}`);
                continue;
            }
            if (predeclaredNilLocals.has(name) && hasLaterNilAssignment(index, name)) continue;
            predeclaredNilLocals.delete(name);
            locals.delete(name); expr.delete(name); exprKinds.delete(name); exprMeta.delete(name); localNames.delete(name); continue;
        }

        if (isPackIndex) {
            const rendered = renderRhs(rhs);
            if (!rendered?.packSlot) { if (options.diagnostics) options.diagnostics.reason = `pack index lost provenance at statement ${index}`; return null; }
            if (consumedPackRegs.has(rendered.packReg)) { if (options.diagnostics) options.diagnostics.reason = `pack ${rendered.packReg} was already consumed before slot ${rendered.slot}`; return null; }
            let pendingPack = pendingPacks.get(rendered.packReg);
            if (!pendingPack) {
                pendingPack = { packReg: rendered.packReg, call: rendered.call, slots: new Map(), order: packCreationOrder.get(rendered.packReg) ?? ++nextPackOrder };
                pendingPacks.set(rendered.packReg, pendingPack);
            }
            if (pendingPack.call !== rendered.call) { if (options.diagnostics) options.diagnostics.reason = `pack ${rendered.packReg} call provenance changed`; return null; }
            if (pendingPack.slots.has(rendered.slot)) { if (options.diagnostics) options.diagnostics.reason = `pack ${rendered.packReg} slot ${rendered.slot} was extracted twice`; return null; }
            const slotInfo = { tempReg: name, localReg: null, displayName: null };
            pendingPack.slots.set(rendered.slot, slotInfo);
            expr.set(name, rendered.call); exprKinds.set(name, "pack-slot"); exprMeta.set(name, { packReg: rendered.packReg, slot: rendered.slot });
            if (cleanupRegs.has(name)) {
                reserveLocal(name, name === rendered.packReg);
                slotInfo.localReg = name;
            } else {
                const futureLocal = findFutureCleanupCopy(index, name);
                if (futureLocal) {
                    reserveLocal(futureLocal, futureLocal === rendered.packReg);
                    slotInfo.localReg = futureLocal;
                    deferredStorageCopies.set(futureLocal, name);
                }
            }
            continue;
        }

        if (cleanupRegs.has(name) && !locals.has(name) && isPackSlotCopy) {
            const meta = exprMeta.get(rhs.name);
            const pendingPack = meta ? pendingPacks.get(meta.packReg) : null;
            if (!meta || !pendingPack) return null;
            const slotInfo = pendingPack.slots.get(meta.slot);
            if (!slotInfo || slotInfo.localReg) return null;
            reserveLocal(name); slotInfo.localReg = name; continue;
        }

        if (cleanupRegs.has(name) && !locals.has(name) && isPosPreservationCopy(index, name, rhs)) {
            const value = expr.get(stateName);
            if (typeof value !== "string") return null;
            expr.set(name, value);
            exprKinds.set(name, "value");
            continue;
        }

        if (cleanupRegs.has(name) && !locals.has(name) && isIdentifier(rhs) && rhs.name !== name) {
            const value = expr.get(rhs.name) ?? (locals.has(rhs.name) ? localName(rhs.name) : null);
            if (typeof value !== "string") return null;
            const kind = exprKinds.get(rhs.name) || "value";
            const displayName = allocateLocal(name, kind);
            out.push(value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`); continue;
        }

        if (cleanupRegs.has(name) && !locals.has(name) && nonNilDefinitionCount.get(name) === 1) {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const kind = rhs?.type === "TableConstructorExpression" ? "table" : "value";
            const displayName = allocateLocal(name, kind);
            out.push(`local ${displayName} = ${value}`);
            continue;
        }

        if (locals.has(name)) {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            out.push(`${localName(name)} = ${value}`); expr.set(name, localName(name));
            exprKinds.set(name, rhs?.type === "TableConstructorExpression" ? "table" : "value"); continue;
        }

        if (rhs?.type === "CallExpression") {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const futureLocal = callFutureLocal;
            if (upvalueClosureFutureCell) {
                if (upvalueCells.get(upvalueClosureFutureCell) !== null) return null;
                const displayName = `v${++valueLocalCount}`;
                upvalueCells.set(upvalueClosureFutureCell, displayName);
                const sourceLine = `local ${displayName} = ${value}`;
                if (isDeferredClosureCreation && pendingPacks.size) deferredSourceLines.push({ line: sourceLine, afterPackOrder: callPackBarrier });
                else out.push(sourceLine);
                deferredUpvalueClosureStores.set(upvalueClosureFutureCell, name);
                declaredCount++;
            } else if (futureLocal) {
                const sourceLine = locals.has(futureLocal)
                    ? `${allocateLocal(futureLocal, "value")} = ${value}`
                    : `local ${allocateLocal(futureLocal, "value")} = ${value}`;
                if ((isDeferredClosureCreation || isDeferredOrdinaryCall) && pendingPacks.size) deferredSourceLines.push({ line: sourceLine, afterPackOrder: callPackBarrier });
                else out.push(sourceLine);
                if (cleanupRegs.has(futureLocal)) deferredStorageCopies.set(futureLocal, name);
                else if (terminalClosureFutureLocal === futureLocal) { deferredTerminalClosureCopies.set(futureLocal, name); terminalClosureLocals.add(futureLocal); }
            } else if (callResultIsDiscarded) {
                if (isDeferredOrdinaryCall && pendingPacks.size) deferredSourceLines.push({ line: value, afterPackOrder: callPackBarrier });
                else out.push(value);
            }
            expr.set(name, value); exprKinds.set(name, "value"); continue;
        }

        const value = renderRhs(rhs);
        if (value === null) {
            const next = leaf[index + 1];
            if (!locals.has(name) && !cleanupRegs.has(name) && isSingleAssignment(next, name)) {
                expr.delete(name); exprKinds.delete(name); exprMeta.delete(name); continue;
            }
            return null;
        }
        if (typeof value !== "string") return null;
        const member = memberMeta(rhs);
        expr.set(name, value);
        if (member) exprMeta.set(name, member); else exprMeta.delete(name);
        const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
        const isReturnPack = fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression";
        exprKinds.set(name, isReturnPack ? "return-pack" : (rhs?.type === "TableConstructorExpression" ? "table" : "value"));
        if (isReturnPack && !packCreationOrder.has(name)) packCreationOrder.set(name, ++nextPackOrder);
    }

    if (!flushPendingPacks()) { if (options.diagnostics) options.diagnostics.reason = "final pending multi-return pack flush failed"; return null; }
    if (options.allowNoLocals !== true && declaredCount === 0) { if (options.diagnostics) options.diagnostics.reason = "no proven source locals were recovered"; return null; }
    if (options.allowNoLocals === true && (!sawReturnReset || !sawStop)) { if (options.diagnostics) options.diagnostics.reason = `terminal bookkeeping incomplete: return=${sawReturnReset}, stop=${sawStop}`; return null; }
    if (deferredTerminalClosureCopies.size !== 0) { if (options.diagnostics) options.diagnostics.reason = "terminal closure handoff copy was not consumed"; return null; }
    if (deferredUpvalueClosureStores.size !== 0) { if (options.diagnostics) options.diagnostics.reason = "upvalue closure handoff store was not consumed"; return null; }
    for (const reg of terminalClosureLocals) locals.delete(reg);
    if (locals.size !== 0) { if (options.diagnostics) options.diagnostics.reason = `recovered locals still live at terminal: ${[...locals].join(",")}`; return null; }
    if (out.length === 0) { if (options.diagnostics) options.diagnostics.reason = "recovered program emitted no source statements"; return null; }
    const canonicalOut = canonicalizeInitialSimpleLocals(out);
    return { source: canonicalOut.join("\n") + "\n", statementCount: canonicalOut.length, localCount: declaredCount };
}

function renderSimpleClosureLeaf(source, leaf, stateName, returnName, options = {}) {
    const env = new Map();
    const envMeta = new Map();
    const paramNames = [];
    const body = [];
    const localCells = new Map();
    const reservedParamNames = new Set();
    if (options.captureNames instanceof Map) {
        for (const value of options.captureNames.values()) {
            if (typeof value === "string" && isLuaIdentifier(value)) reservedParamNames.add(value);
        }
    }
    let nextParamSuffix = 1;
    let sawReturn = false;
    let sawVarargs = false;

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
    let sawStop = false;

    function resolveNode(node) {
        if (isPrimitiveLiteral(node) || isEmptyTable(node)) return sourceOf(source, node);
        if (node?.type === "TableConstructorExpression") return renderTableFields(node.fields || [], resolveNode);
        if (isIdentifier(node)) {
            const value = env.get(node.name);
            if (value?.kind === "captured-closure") {
                if (typeof options.renderCapturedCall !== "function") return null;
                const captureNames = new Map();
                for (let i = 0; i < value.captureRefs.length; i++) {
                    const ref = value.captureRefs[i];
                    const captureName = typeof ref === "string" ? ref : localCells.get(ref.localCell);
                    if (typeof captureName !== "string") return null;
                    captureNames.set(i + 1, captureName);
                }
                return options.renderCapturedCall(value.call, captureNames);
            }
            return typeof value === "string" ? value : null;
        }
        if (node?.type === "IndexExpression") {
            if (isIdentifier(node.base, "upvalueValues") && node.index?.type === "IndexExpression" &&
                isIdentifier(node.index.base, "upvalues") && node.index.index?.type === "NumericLiteral" &&
                options.captureNames instanceof Map) {
                const slot = Number(node.index.index.value);
                if (!Number.isInteger(slot) || slot < 1) return null;
                return options.captureNames.get(slot) ?? null;
            }
            if (isIdentifier(node.base, "args") && node.index?.type === "NumericLiteral") {
                const index = Number(node.index.value);
                if (!Number.isInteger(index) || index < 1) return null;
                while (paramNames.length < index) {
                    while (reservedParamNames.has(`v${nextParamSuffix}`)) nextParamSuffix++;
                    const paramName = `v${nextParamSuffix++}`;
                    reservedParamNames.add(paramName);
                    paramNames.push(paramName);
                }
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
        if (node?.type === "UnaryExpression") {
            const argument = resolveNode(node.argument);
            return renderUnary(node.operator, argument);
        }
        if ((node?.type === "BinaryExpression" || node?.type === "LogicalExpression") && node.operator) {
            const left = resolveNode(node.left);
            const right = resolveNode(node.right);
            if (left == null || right == null) return null;
            return `(${left} ${node.operator} ${right})`;
        }
        if (node?.type === "CallExpression" && isIdentifier(node.base)) {
            if (node.base.name === "select" && (node.arguments || []).length === 2 &&
                node.arguments[0]?.type === "NumericLiteral" && Number(node.arguments[0].value) === 1 &&
                node.arguments[1]?.type === "CallExpression" && isIdentifier(node.arguments[1].base, "unpack") &&
                (node.arguments[1].arguments || []).length === 1 && isIdentifier(node.arguments[1].arguments[0], "args")) {
                sawVarargs = true;
                return "...";
            }
            if (node.base.name === "unpack" && (node.arguments || []).length === 1 && isIdentifier(node.arguments[0])) {
                const packed = envMeta.get(node.arguments[0].name);
                if (packed?.kind === "return-pack") return packed.call;
                if (packed?.kind === "vararg-pack") { sawVarargs = true; return "..."; }
            }
            if (typeof options.renderSpecialCall === "function") {
                const special = options.renderSpecialCall(node);
                if (special != null) return special;
            }
            const base = env.get(node.base.name);
            if (base == null) return null;
            const args = [];
            for (const arg of node.arguments || []) {
                const value = resolveNode(arg);
                if (value == null) return null;
                args.push(value);
            }
            const member = envMeta.get(node.base.name);
            if (member?.kind === "member" && args.length > 0 && args[0] === member.base) {
                return `${member.base}:${member.member}(${args.slice(1).join(", ")})`;
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

        if (dest?.type === "IndexExpression" && isIdentifier(dest.base, "upvalueValues")) {
            if (isIdentifier(dest.index)) {
                const cell = env.get(dest.index.name);
                if (cell?.kind !== "upvalue-cell") return null;
                const value = resolveNode(rhs);
                if (typeof value !== "string" || localCells.has(dest.index.name)) return null;
                localCells.set(dest.index.name, value);
                continue;
            }
            if (dest.index?.type === "IndexExpression" && isIdentifier(dest.index.base, "upvalues") &&
                dest.index.index?.type === "NumericLiteral" && options.captureNames instanceof Map) {
                const slot = Number(dest.index.index.value);
                if (!Number.isInteger(slot) || slot < 1) return null;
                const captureName = options.captureNames.get(slot);
                const value = resolveNode(rhs);
                if (typeof captureName !== "string" || typeof value !== "string") return null;
                body.push(captureName + " = " + value);
                continue;
            }
            return null;
        }

        if (dest?.type === "IndexExpression" && isIdentifier(dest.base) && isIdentifier(dest.index)) {
            const key = resolveNode(dest.index);
            const value = resolveNode(rhs);
            if (typeof key !== "string" || typeof value !== "string") return null;
            const fieldName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            if (dest.base.name === "_env") {
                if (!fieldName || !isLuaIdentifier(fieldName)) return null;
                body.push(`${fieldName} = ${value}`);
                continue;
            }
            const base = resolveNode(dest.base);
            const baseMeta = envMeta.get(dest.base.name);
            const stableBase = baseMeta?.kind === "table" || baseMeta?.kind === "member" || baseMeta?.kind === "stable-ref";
            if (typeof base !== "string" || !stableBase) return null;
            const target = fieldName && isLuaIdentifier(fieldName) ? `${base}.${fieldName}` : `${base}[${key}]`;
            body.push(`${target} = ${value}`);
            continue;
        }
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
            const fields = rhs.fields || [];
            const isSingleCallPack = fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression";
            if (isSingleCallPack && valueUsedBeforeOverwrite(index, returnName)) {
                env.set(returnName, values[0]);
                envMeta.set(returnName, { kind: "return-pack", call: values[0] });
                continue;
            }
            if (values.length > 0) body.push(`return ${values.join(", ")}`);
            sawReturn = true;
            continue;
        }
        if (rhs?.type === "NilLiteral" && name !== stateName && name !== returnName) {
            env.delete(name);
            envMeta.delete(name);
            continue;
        }

        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0) {
            env.set(name, { kind: "upvalue-cell" });
            continue;
        }

        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name)) {
            const args = rhs.arguments || [];
            const fields = args[1]?.type === "TableConstructorExpression" ? args[1].fields || [] : [];
            if (fields.length > 0) {
                const captureRefs = [];
                for (const field of fields) {
                    if (field?.type !== "TableValue") return null;
                    if (isIdentifier(field.value)) {
                        const cell = env.get(field.value.name);
                        if (cell?.kind !== "upvalue-cell") return null;
                        const captureName = localCells.get(field.value.name);
                        captureRefs.push(captureName ?? { localCell: field.value.name });
                        continue;
                    }
                    if (field.value?.type === "IndexExpression" && isIdentifier(field.value.base, "upvalues") && field.value.index?.type === "NumericLiteral" && options.captureNames instanceof Map) {
                        const slot = Number(field.value.index.value);
                        const captureName = options.captureNames.get(slot);
                        if (typeof captureName !== "string") return null;
                        captureRefs.push(captureName);
                        continue;
                    }
                    return null;
                }
                env.set(name, { kind: "captured-closure", call: rhs, captureRefs });
                continue;
            }
        }

        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index) && !env.has(rhs.index.name)) {
            const next = leaf[index + 1];
            if (isSingleAssignment(next, rhs.index.name)) {
                const globalName = decodeJsonStringLiteral(next.init[0]);
                if (globalName && isLuaIdentifier(globalName)) {
                    env.set(name, globalName);
                    continue;
                }
            }
        }

        let member = null;
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && isIdentifier(rhs.index) && rhs.base.name !== "_env") {
            const key = env.get(rhs.index.name);
            const baseValue = env.get(rhs.base.name);
            const memberName = typeof key === "string" && /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            if (typeof baseValue === "string" && memberName && isLuaIdentifier(memberName)) member = { kind: "member", base: baseValue, member: memberName };
        }
        const value = resolveNode(rhs);
        if (value == null) return null;
        if (rhs?.type === "CallExpression" && !valueUsedBeforeOverwrite(index, name)) body.push(value);
        env.set(name, value);
        const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
        if (fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression") {
            const call = resolveNode(fields[0].value);
            if (typeof call !== "string") return null;
            envMeta.set(name, call === "..." ? { kind: "vararg-pack" } : { kind: "return-pack", call });
        } else if (member) {
            envMeta.set(name, member);
        } else if (rhs?.type === "TableConstructorExpression") {
            envMeta.set(name, { kind: "table" });
        } else if (rhs?.type === "IndexExpression" && (
            (isIdentifier(rhs.base, "args") && rhs.index?.type === "NumericLiteral") ||
            isIdentifier(rhs.base, "upvalueValues")
        )) {
            envMeta.set(name, { kind: "stable-ref" });
        } else if (isIdentifier(rhs) && envMeta.has(rhs.name)) {
            envMeta.set(name, envMeta.get(rhs.name));
        } else {
            envMeta.delete(name);
        }
    }

    if (!sawReturn || !sawStop) return null;
    const lines = body.length ? body.map(line => line.split("\n").map(part => `    ${part}`).join("\n")).join("\n") : "";
    const params = [...paramNames];
    if (sawVarargs) params.push("...");
    return `function(${params.join(", ")})${lines ? `\n${lines}\n` : ""}end`;
}

function flattenLogicalRootLeaf(leaves, entryId, stateName, returnName, diagnostics = null) {
    function fail(reason, state = current) {
        if (diagnostics && !diagnostics.reason) { diagnostics.reason = reason; diagnostics.state = state; }
        return null;
    }
    const consumed = new Set();
    const out = [];
    let current = entryId;

    function findTransition(body) {
        for (let i = body.length - 1; i >= 0; i--) {
            if (!isSingleAssignment(body[i], stateName)) continue;
            const rhs = body[i].init[0];
            if (rhs?.type === "NilLiteral") return { index: i, kind: "stop" };
            if (rhs?.type === "NumericLiteral" && Number.isInteger(Number(rhs.value))) {
                return { index: i, kind: "jump", target: Number(rhs.value) };
            }
            const branch = decodeLogicalStateTransition(rhs);
            if (branch) return { index: i, kind: "branch", ...branch };
        }
        return null;
    }

    while (true) {
        if (consumed.has(current)) return fail("root revisits an already-consumed state");
        const body = leaves.get(current);
        if (!body) return fail("root references a missing state leaf");
        const transition = findTransition(body);
        if (!transition) return fail("root state has no recognized terminal state transition");
        consumed.add(current);

        if (transition.kind === "branch") {
            const trueBody = leaves.get(transition.onTrue);
            const falseBody = leaves.get(transition.onFalse);
            if (!trueBody || !falseBody) return null;
            const trueTransition = findTransition(trueBody);
            const falseTransition = findTransition(falseBody);

            let joinId = null;
            let alternateId = null;
            let alternateBody = null;
            let primaryOnTrue = false;
            if (falseTransition?.kind === "jump" && falseTransition.target === transition.onTrue) {
                joinId = transition.onTrue;
                alternateId = transition.onFalse;
                alternateBody = falseBody;
                primaryOnTrue = true;
            } else if (trueTransition?.kind === "jump" && trueTransition.target === transition.onFalse) {
                joinId = transition.onFalse;
                alternateId = transition.onTrue;
                alternateBody = trueBody;
                primaryOnTrue = false;
            } else {
                return null;
            }
            if (consumed.has(alternateId)) return null;

            const alternateTransition = findTransition(alternateBody);
            const alternateStatements = alternateBody.filter((_, index) => index !== alternateTransition.index);
            if (alternateStatements.length !== 1 || !isSingleAssignment(alternateStatements[0], returnName)) return null;
            const fallback = alternateStatements[0].init[0];
            if (!(isIdentifier(fallback) || isPrimitiveLiteral(fallback))) return null;

            let primaryAssignmentIndex = -1;
            for (let i = body.length - 1; i >= 0; i--) {
                if (i === transition.index || !isSingleAssignment(body[i], returnName)) continue;
                const rhs = body[i].init[0];
                if (isIdentifier(rhs, transition.conditionRegister)) {
                    primaryAssignmentIndex = i;
                    break;
                }
            }
            if (primaryAssignmentIndex < 0) return null;

            for (let i = 0; i < body.length; i++) {
                if (i === transition.index) continue;
                if (i === primaryAssignmentIndex) {
                    const statement = body[i];
                    out.push({
                        ...statement,
                        init: [{
                            type: "LogicalExpression",
                            operator: primaryOnTrue ? "or" : "and",
                            left: statement.init[0],
                            right: fallback,
                        }],
                    });
                } else {
                    out.push(body[i]);
                }
            }
            consumed.add(alternateId);
            current = joinId;
            continue;
        }

        for (let i = 0; i < body.length; i++) {
            if (i !== transition.index) out.push(body[i]);
        }
        if (transition.kind === "stop") return { leaf: out, consumed };
        current = transition.target;
    }
}

function matchClosureEntryProgram(source, stateWhile, stateName, returnName, diagnostics = null) {
    const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!leaves || leaves.size < 2 || !leaves.has(1)) return null;
    const rootDiagnostics = {};
    const flattenedRoot = flattenLogicalRootLeaf(leaves, 1, stateName, returnName, rootDiagnostics);
    const consumedEntries = new Set(flattenedRoot ? flattenedRoot.consumed : [1]);

    function renderClosureCall(call, captureNames = null) {
        if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !/^createClosure\d*$/.test(call.base.name)) return null;
        const args = call.arguments || [];
        if (args.length !== 2 || args[0]?.type !== "NumericLiteral" || args[1]?.type !== "TableConstructorExpression") return null;
        const fields = args[1].fields || [];
        if (captureNames === null && fields.length !== 0) return null;
        if (captureNames instanceof Map && fields.length !== captureNames.size) return null;
        const entryId = Number(args[0].value);
        if (!Number.isInteger(entryId) || entryId === 1 || consumedEntries.has(entryId)) return null;
        const childLeaf = leaves.get(entryId);
        if (!childLeaf) return null;
        consumedEntries.add(entryId);
        const rendered = renderSimpleClosureLeaf(source, childLeaf, stateName, returnName, {
            renderSpecialCall: renderClosureCall,
            renderCapturedCall: renderClosureCall,
            captureNames: captureNames instanceof Map ? captureNames : undefined,
        });
        if (!rendered) {
            consumedEntries.delete(entryId);
            return null;
        }
        return rendered;
    }

    const root = flattenedRoot?.leaf || leaves.get(1);
    const rootProgramDiagnostics = {};
    const program = matchLocalRegisterProgram(source, root, stateName, returnName, { renderSpecialCall: renderClosureCall, renderCapturedCall: renderClosureCall, diagnostics: rootProgramDiagnostics });
    if (!program) {
        if (diagnostics && !diagnostics.reason) {
            diagnostics.reason = flattenedRoot ? "flattened root is not a proven register-local program" : (rootDiagnostics.reason || "root is not a proven register-local program");
            diagnostics.state = rootDiagnostics.state || 1;
            diagnostics.statementIndex = rootProgramDiagnostics.statementIndex;
            diagnostics.statement = rootProgramDiagnostics.statement;
        }
        return null;
    }
    const rootStateCount = flattenedRoot ? flattenedRoot.consumed.size : 1;
    if (consumedEntries.size === rootStateCount) { if (diagnostics) diagnostics.reason = "root recovered but no child closure entry was consumed"; return null; }
    if (consumedEntries.size !== leaves.size) {
        if (diagnostics) { diagnostics.reason = "not all normalized state leaves were consumed"; diagnostics.unconsumed = [...leaves.keys()].filter(id => !consumedEntries.has(id)); }
        return null;
    }
    return { ...program, stateCount: leaves.size, closureCount: consumedEntries.size - rootStateCount };
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
        if (rhs?.type === "TableConstructorExpression") return renderTableFields(rhs.fields || [], node => render(node, env));
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
        if (rhs?.type === "UnaryExpression") {
            const argument = isIdentifier(rhs.argument) ? resolveId(rhs.argument.name, env) : (isPrimitiveLiteral(rhs.argument) ? sourceOf(source, rhs.argument) : null);
            return renderUnary(rhs.operator, argument);
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

    function nodeReadsIdentifier(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeReadsIdentifier(item, name))) return true;
            } else if (value && typeof value === "object" && nodeReadsIdentifier(value, name)) return true;
        }
        return false;
    }

    function valueMayBeReadFrom(blockId, name, visiting = new Set()) {
        if (visiting.has(blockId)) return true;
        const block = blocks.get(blockId);
        if (!block) return true;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(blockId);
        for (let i = 0; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) return true;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (nodeReadsIdentifier(rhs, name)) return true;
            if (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name)) return true;
            if (isIdentifier(dest, name)) return false;
        }
        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) return true;
        for (const next of successors.get(blockId) || []) {
            if (valueMayBeReadFrom(next, name, nextVisiting)) return true;
        }
        return false;
    }

    function mergeCandidates(candidates, joinId) {
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
            else if (!valueMayBeReadFrom(joinId, key)) continue;
            else return null;
        }
        return { env, markers: am.slice(0, prefix) };
    }

    while (ready.length) {
        const id = ready.shift();
        if (processed.has(id)) continue;
        const candidates = incoming.get(id) || [];
        const merged = mergeCandidates(candidates, id);
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
            if (name === returnName && isEmptyTable(rhs)) { sawReturnReset = true; continue; }
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

function normalizeRegisterOverflowGraph(root) {
    let applied = 0;
    let unsupported = 0;

    function visit(value, parent = null, key = null) {
        if (!value || typeof value !== "object") return;
        if (Array.isArray(value)) {
            for (let i = 0; i < value.length; i++) visit(value[i], value, i);
            return;
        }
        if (value.type === "IndexExpression" && isIdentifier(value.base, "RegisterOverflow")) {
            const slot = value.index?.type === "NumericLiteral" ? Number(value.index.value) : NaN;
            if (!Number.isInteger(slot) || slot < 0) {
                unsupported++;
                return;
            }
            const replacement = {
                type: "Identifier",
                name: `o${slot}`,
                range: value.range,
                loc: value.loc,
            };
            if (parent !== null) parent[key] = replacement;
            applied++;
            return;
        }
        for (const [childKey, child] of Object.entries(value)) {
            if (childKey === "range" || childKey === "loc") continue;
            visit(child, value, childKey);
        }
    }

    visit(root);
    return { applied: applied > 0, count: applied, unsupported };
}

function solveFreshSource(source, ast) {
    if (typeof source !== "string" || !ast) return { applied: false, reason: "Fresh beta CF requires normal output source and AST", mode: "fresh" };
    const vm = findVmFunction(ast);
    if (!vm) return { applied: false, reason: "Fresh beta CF: no semantically named vm function", mode: "fresh" };
    const overflow = normalizeRegisterOverflowGraph(vm.functionNode);
    if (overflow.unsupported > 0) return { applied: false, reason: "Fresh beta CF: dynamic RegisterOverflow index is unsupported", mode: "fresh" };
    const stateParam = (vm.functionNode.parameters || [])[0];
    if (!isIdentifier(stateParam)) return { applied: false, reason: "Fresh beta CF: VM state parameter is not an identifier", mode: "fresh" };
    const stateName = stateParam.name;
    const returnName = findVmReturnRegister(vm.functionNode)?.name || null;
    const stateWhile = findStateWhile(vm.functionNode, stateName);
    if (!stateWhile) return { applied: false, reason: "Fresh beta CF: no while <state> dispatcher", mode: "fresh" };

    const closureDiagnostics = {};
    const closureProgram = matchClosureEntryProgram(source, stateWhile, stateName, returnName, closureDiagnostics);
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

    const logicalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (logicalLeaves && logicalLeaves.size > 1 && logicalLeaves.has(1)) {
        const flattenedLogical = flattenLogicalRootLeaf(logicalLeaves, 1, stateName, returnName);
        if (flattenedLogical && flattenedLogical.consumed.size === logicalLeaves.size) {
            const flattenedProgram = matchLocalRegisterProgram(source, flattenedLogical.leaf, stateName, returnName);
            if (flattenedProgram) {
                return {
                    applied: true,
                    mode: "fresh-multistate-logical",
                    source: flattenedProgram.source,
                    stateCount: logicalLeaves.size,
                    statementCount: flattenedProgram.statementCount,
                    branchCount: logicalLeaves.size - 1,
                    localCount: flattenedProgram.localCount,
                };
            }
        }
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
    if (!leaf) {
        const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
        const count = leaves?.size || 0;
        const detail = closureDiagnostics.reason ? `; closure recovery: ${closureDiagnostics.reason}` : "";
        const stateDetail = closureDiagnostics.state != null ? ` at state ${closureDiagnostics.state}` : "";
        const statementDetail = closureDiagnostics.statementIndex != null ? `; root statement ${closureDiagnostics.statementIndex}: ${String(closureDiagnostics.statement || "unknown").replace(/\s+/g, " ").slice(0, 180)}` : "";
        const unconsumed = Array.isArray(closureDiagnostics.unconsumed) && closureDiagnostics.unconsumed.length ? `; unconsumed states: ${closureDiagnostics.unconsumed.join(",")}` : "";
        return { applied: false, reason: `Fresh beta CF: unsupported multi-state control flow (${count} normalized states)${detail}${stateDetail}${statementDetail}${unconsumed}`, mode: "fresh" };
    }

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
    if (!directCalls) {
        const callResultProgram = matchLocalRegisterProgram(source, leaf, stateName, returnName, { allowNoLocals: true });
        if (callResultProgram) {
            return {
                applied: true,
                mode: "fresh-call-results",
                source: callResultProgram.source,
                stateCount: 1,
                statementCount: callResultProgram.statementCount,
                branchCount: 0,
                localCount: callResultProgram.localCount,
            };
        }
        return { applied: false, reason: "Fresh beta CF: one-state leaf is not a proven direct global-call/register-local program", mode: "fresh" };
    }

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
    normalizeRegisterOverflowGraph,
};
