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

function isVmRegisterName(name) {
    return typeof name === "string" && /^(?:r|o)\d+$/.test(name);
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
    const INIT_READ = 1;
    const INDEX_DEST_READ = 2;
    const WRITE = 4;
    const NIL_WRITE = 8;
    function collectIdentifierUses(node, out) {
        if (!node || typeof node !== "object") return;
        if (isIdentifier(node)) {
            out.add(node.name);
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                for (const item of value) collectIdentifierUses(item, out);
            } else if (value && typeof value === "object") collectIdentifierUses(value, out);
        }
    }
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

    const futureEvents = new Map();
    function addFutureEvent(name, index, flags) {
        let events = futureEvents.get(name);
        if (!events) futureEvents.set(name, events = []);
        const last = events[events.length - 1];
        if (last?.index === index) last.flags |= flags;
        else events.push({ index, flags });
    }
    function findNextFutureEvent(name, startIndex, mask) {
        const events = futureEvents.get(name);
        if (!events) return null;
        let low = 0, high = events.length;
        while (low < high) {
            const middle = (low + high) >>> 1;
            if (events[middle].index <= startIndex) low = middle + 1;
            else high = middle;
        }
        for (let index = low; index < events.length; index++) {
            if ((events[index].flags & mask) !== 0) return events[index];
        }
        return null;
    }

    const cleanupRegs = new Set();
    const nonNilDefinitionCount = new Map();
    const nilDefinitionCount = new Map();
    const firstNilDefinitionIndex = new Map();
    for (let scanIndex = 0; scanIndex < leaf.length; scanIndex++) {
        const statement = leaf[scanIndex];
        const initUses = new Set();
        collectIdentifierUses(statement?.init, initUses);
        for (const name of initUses) addFutureEvent(name, scanIndex, INIT_READ);
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (dest?.type === "IndexExpression") {
            const destinationUses = new Set();
            collectIdentifierUses(dest, destinationUses);
            for (const name of destinationUses) addFutureEvent(name, scanIndex, INDEX_DEST_READ);
        }
        if (isIdentifier(dest)) addFutureEvent(dest.name, scanIndex, WRITE | (rhs?.type === "NilLiteral" ? NIL_WRITE : 0));
        if (!isIdentifier(dest) || dest.name === stateName || dest.name === returnName) continue;
        if (rhs?.type === "NilLiteral") {
            cleanupRegs.add(dest.name);
            nilDefinitionCount.set(dest.name, (nilDefinitionCount.get(dest.name) || 0) + 1);
            if (!firstNilDefinitionIndex.has(dest.name)) firstNilDefinitionIndex.set(dest.name, scanIndex);
        } else {
            nonNilDefinitionCount.set(dest.name, (nonNilDefinitionCount.get(dest.name) || 0) + 1);
        }
    }
    // Prometheus may compile a local initializer into an ordinary TEMP register
    // and then promote that exact physical register into VAR ownership. Its
    // copyRegisters(varReg, exprReg) emits nothing when both ids are equal, so
    // the VM contains no explicit TEMP -> VAR handoff. Recover only the
    // unambiguous no-reassignment shape: a direct non-copy definition whose
    // very next write to that physical register is its nil lifetime cleanup.
    // A plain TEMP free never emits that cleanup, while an already-active VAR
    // cannot be selected by allocRegister(false) for this direct definition.
    const directPromotionStartIndices = new Set();
    const directPromotionStartsByRegister = new Map();
    for (let scanIndex = 0; scanIndex < leaf.length; scanIndex++) {
        const statement = leaf[scanIndex];
        if (!isSingleAssignment(statement)) continue;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest) || !cleanupRegs.has(dest.name) || rhs?.type === "NilLiteral" || isIdentifier(rhs)) continue;
        const nextWrite = findNextFutureEvent(dest.name, scanIndex, WRITE);
        if (!nextWrite || (nextWrite.flags & NIL_WRITE) === 0) continue;
        const cleanup = leaf[nextWrite.index];
        if (!isSingleAssignment(cleanup, dest.name) || cleanup.init[0]?.type !== "NilLiteral") continue;
        directPromotionStartIndices.add(scanIndex);
        let starts = directPromotionStartsByRegister.get(dest.name);
        if (!starts) directPromotionStartsByRegister.set(dest.name, starts = []);
        starts.push(scanIndex);
    }
    function hasFutureDirectPromotionStart(startIndex, name) {
        const starts = directPromotionStartsByRegister.get(name);
        if (!starts) return false;
        for (const index of starts) if (index > startIndex) return true;
        return false;
    }

    if (cleanupRegs.size === 0 && options.allowNoLocals !== true) return null;

    const expr = new Map(), exprKinds = new Map(), exprMeta = new Map();
    const locals = new Set(), localNames = new Map(), out = [];
    let declaredCount = 0, valueLocalCount = 0, tableLocalCount = 0, nextPackOrder = 0;
    const pendingPacks = new Map(), packCreationOrder = new Map();
    let sawReturnReset = false, sawStop = false;
    let terminalReturnLine = null;
    const consumedPackRegs = new Set();
    const upvalueCells = new Map();
    const predeclaredNilLocals = new Set();
    const deferredStorageCopies = new Map();
    const deferredTerminalClosureCopies = new Map();
    const deferredTerminalUnusedCopies = new Map();
    const deferredUpvalueClosureStores = new Map();
    const deferredLiveTableCopies = new Map();
    const terminalClosureLocals = new Set();
    const terminalUnusedLocals = new Set();
    const terminalAliasLocals = new Set();
    const terminalTableLocals = new Set();
    const terminalNilLocals = new Set();
    const plainTableLocals = new Set();
    const deferredSourceLines = [];
    const deferredLocalBarriers = new Map();

    function localName(name) { return localNames.get(name) || name; }
    function emitSourceLine(line, registers = []) {
        let barrier = 0;
        for (const reg of registers) barrier = Math.max(barrier, deferredLocalBarriers.get(reg) || 0);
        if (barrier > 0) deferredSourceLines.push({ line, afterPackOrder: barrier });
        else out.push(line);
    }
    function valueUsedBeforeOverwrite(startIndex, name) {
        const event = findNextFutureEvent(name, startIndex, INIT_READ | WRITE);
        return event !== null && (event.flags & INIT_READ) !== 0;
    }
    function hasLaterNilAssignment(startIndex, name) {
        return findNextFutureEvent(name, startIndex, NIL_WRITE) !== null;
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
    function isTerminalUnreadEpoch(startIndex, name) {
        return findNextFutureEvent(name, startIndex, INIT_READ | INDEX_DEST_READ | WRITE) === null;
    }
    function nodeUsesAsCallBase(node, name) {
        if (!node || typeof node !== "object") return false;
        if (node.type === "CallExpression" && isIdentifier(node.base, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeUsesAsCallBase(item, name))) return true;
            } else if (value && typeof value === "object" && nodeUsesAsCallBase(value, name)) return true;
        }
        return false;
    }
    function isTerminalStableUsedEpoch(startIndex, name) {
        let useCount = 0;
        let firstUseIndex = -1;
        let soleUseIsCallBase = false;
        let soleUseIsLogical = false;
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, name)) {
                    useCount++;
                    if (firstUseIndex < 0) firstUseIndex = cursor;
                }
                continue;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest, name)) return false;
            if (isIdentifier(dest, stateName) && isIdentifier(rhs, name)) return false;
            if (nodeUsesIdentifier(rhs, name) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, name))) {
                useCount++;
                if (firstUseIndex < 0) {
                    firstUseIndex = cursor;
                    soleUseIsCallBase = nodeUsesAsCallBase(rhs, name);
                    soleUseIsLogical = rhs?.type === "LogicalExpression" && nodeUsesIdentifier(rhs, name);
                }
            }
        }
        // One-use callables and immediately-consumed operands are compiler TEMP shapes too.
        // A terminal source alias needs either repeated use, or one delayed non-call use.
        return useCount > 1 || (useCount === 1 && firstUseIndex > startIndex + 1 && !soleUseIsCallBase && !soleUseIsLogical);
    }
    function findFutureTerminalUnusedCopy(startIndex, tempReg) {
        const event = findNextFutureEvent(tempReg, startIndex, INIT_READ | INDEX_DEST_READ | WRITE);
        if (!event) return null;
        const statement = leaf[event.index];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest) || !isIdentifier(rhs, tempReg) || !isVmRegisterName(dest.name) || cleanupRegs.has(dest.name)) return null;
        return isTerminalUnreadEpoch(event.index, dest.name) ? dest.name : null;
    }

    function findFutureTerminalClosureCopy(startIndex, tempReg) {
        const event = findNextFutureEvent(tempReg, startIndex, INIT_READ | INDEX_DEST_READ | WRITE);
        if (!event) return null;
        const statement = leaf[event.index];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (!isIdentifier(dest) || !isIdentifier(rhs, tempReg) || dest.name === stateName || dest.name === returnName || cleanupRegs.has(dest.name)) return null;
        const laterEvents = futureEvents.get(dest.name) || [];
        let sawUse = false;
        for (const later of laterEvents) {
            if (later.index <= event.index) continue;
            if ((later.flags & (INIT_READ | INDEX_DEST_READ)) !== 0) sawUse = true;
            if ((later.flags & WRITE) !== 0) return null;
        }
        return sawUse ? dest.name : null;
    }

    function findFutureUpvalueClosureStore(startIndex, tempReg) {
        const event = findNextFutureEvent(tempReg, startIndex, INIT_READ | INDEX_DEST_READ | WRITE);
        if (!event) return null;
        const statement = leaf[event.index];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        if (dest?.type !== "IndexExpression" || !isIdentifier(dest.base, "upvalueValues") || !isIdentifier(dest.index) || !isIdentifier(rhs, tempReg)) return null;
        return upvalueCells.has(dest.index.name) && upvalueCells.get(dest.index.name) === null ? dest.index.name : null;
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
    function rhsDependsOnPendingPack(node) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node)) {
            if (exprKinds.get(node.name) === "return-pack" && pendingPacks.has(node.name)) return true;
            if (exprKinds.get(node.name) === "pack-slot") {
                const meta = exprMeta.get(node.name);
                if (meta?.packReg && pendingPacks.has(meta.packReg)) return true;
            }
            return false;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => rhsDependsOnPendingPack(item))) return true;
            } else if (value && typeof value === "object" && rhsDependsOnPendingPack(value)) return true;
        }
        return false;
    }
    function rhsUsesPendingPackSourceLocal(node) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node) && exprKinds.get(node.name) === "pack-slot") {
            const meta = exprMeta.get(node.name);
            const pendingPack = meta?.packReg ? pendingPacks.get(meta.packReg) : null;
            const slotInfo = pendingPack && meta ? pendingPack.slots.get(meta.slot) : null;
            return !!(slotInfo?.localReg && locals.has(slotInfo.localReg));
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => rhsUsesPendingPackSourceLocal(item))) return true;
            } else if (value && typeof value === "object" && rhsUsesPendingPackSourceLocal(value)) return true;
        }
        return false;
    }

    function hasFuturePendingPackSlotBeforeStateTouch(startIndex) {
        if (pendingPacks.size !== 1) return false;
        const pendingPack = [...pendingPacks.values()][0];
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, stateName)) return false;
                continue;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest, stateName) || nodeUsesIdentifier(rhs, stateName) ||
                (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, stateName))) return false;
            if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base, pendingPack.packReg) &&
                rhs.index?.type === "NumericLiteral") {
                const slot = Number(rhs.index.value);
                return Number.isInteger(slot) && slot > 0 && !pendingPack.slots.has(slot);
            }
            if (isIdentifier(dest, pendingPack.packReg)) return false;
        }
        return false;
    }

    function isDeadPurePendingTemp(index, name, rhs) {
        if (!isPurePendingTempRhs(rhs)) return false;
        if (rhsDependsOnPendingPack(rhs)) return false;
        return hasOnlyDeadCopyUses(index, name);
    }

    function hasFutureReassignedLocalUse(startIndex, name) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, name)) return true;
                continue;
            }
            const dest = statement.variables[0];
            const value = statement.init[0];
            if (nodeUsesIdentifier(value, name) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, name))) return true;
            if (isIdentifier(dest, name)) {
                if (!isIdentifier(value) || value.name === name) return false;
            }
        }
        return false;
    }

    function findFutureLiveTableCopy(startIndex, tempReg, rhs) {
        if (rhs?.type !== "TableConstructorExpression" || !isPurePendingTempRhs(rhs)) return null;
        if (rhsDependsOnPendingPack(rhs)) return null;
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, tempReg)) return null;
                continue;
            }
            const dest = statement.variables[0];
            const value = statement.init[0];
            if (isIdentifier(dest) && isIdentifier(value, tempReg)) {
                for (let probe = startIndex + 1; probe < cursor; probe++) {
                    const between = leaf[probe];
                    if (nodeUsesIdentifier(between?.init, dest.name)) return null;
                    const betweenDest = isSingleAssignment(between) ? between.variables[0] : null;
                    if (betweenDest?.type === "IndexExpression" && nodeUsesIdentifier(betweenDest, dest.name)) return null;
                }
                if (locals.has(dest.name)) return dest.name;
                if (dest.name !== stateName && dest.name !== returnName && !cleanupRegs.has(dest.name) &&
                    (valueUsedBeforeOverwrite(cursor, dest.name) || hasFutureReassignedLocalUse(cursor, dest.name))) return dest.name;
                return null;
            }
            if (nodeUsesIdentifier(value, tempReg) || (dest?.type === "IndexExpression" && nodeUsesIdentifier(dest, tempReg))) return null;
            if (isIdentifier(dest, tempReg)) return null;
        }
        return null;
    }

    function isDeadPlainTableIndexRead(index, name, rhs) {
        if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base) || !plainTableLocals.has(rhs.base.name)) return false;
        if (rhsDependsOnPendingPack(rhs)) return false;
        return hasOnlyDeadCopyUses(index, name);
    }

    function countIdentifierUses(node, name) {
        if (!node || typeof node !== "object") return 0;
        if (isIdentifier(node, name)) return 1;
        let count = 0;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) for (const item of value) count += countIdentifierUses(item, name);
            else if (value && typeof value === "object") count += countIdentifierUses(value, name);
        }
        return count;
    }
    function isUniqueFutureTableOperand(startIndex, tempReg) {
        for (let cursor = startIndex + 1; cursor < leaf.length; cursor++) {
            const statement = leaf[cursor];
            if (!isSingleAssignment(statement)) {
                if (nodeUsesIdentifier(statement?.init, tempReg)) return false;
                continue;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            const uses = countIdentifierUses(rhs, tempReg) + ((dest?.type === "IndexExpression") ? countIdentifierUses(dest, tempReg) : 0);
            if (uses > 0) return rhs?.type === "TableConstructorExpression" && uses === 1;
            if (isIdentifier(dest, tempReg)) return false;
        }
        return false;
    }

    function isPlainTableMethodLoad(index, name, rhs) {
        if (rhs?.type !== "IndexExpression" || !isIdentifier(rhs.base) || !plainTableLocals.has(rhs.base.name)) return false;
        const next = leaf[index + 1];
        if (!isSingleAssignment(next, name)) return false;
        const call = next.init[0];
        return call?.type === "CallExpression" && isIdentifier(call.base, name) && (call.arguments || []).length > 0 && isIdentifier(call.arguments[0], rhs.base.name);
    }

    function findFutureCleanupCopy(startIndex, tempReg) {
        const event = findNextFutureEvent(tempReg, startIndex, INIT_READ | INDEX_DEST_READ | WRITE);
        if (!event) return null;
        const statement = leaf[event.index];
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0];
        const rhs = statement.init[0];
        return isIdentifier(dest) && cleanupRegs.has(dest.name) && isIdentifier(rhs, tempReg) ? dest.name : null;
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
    function reservePendingPackDisplayNamesThrough(targetPack, targetSlot) {
        const packs = [...pendingPacks.values()].sort((a, b) => a.order - b.order);
        for (const pendingPack of packs) {
            if (pendingPack.order > targetPack.order) break;
            const slots = [...pendingPack.slots.keys()].sort((a, b) => a - b);
            for (const slotNumber of slots) {
                if (pendingPack.order === targetPack.order && slotNumber > targetSlot) break;
                const slotInfo = pendingPack.slots.get(slotNumber);
                if (!slotInfo?.localReg || typeof slotInfo.displayName === "string") continue;
                if (localNames.has(slotInfo.localReg)) slotInfo.displayName = localName(slotInfo.localReg);
                else {
                    slotInfo.displayName = `v${++valueLocalCount}`;
                    declaredCount++;
                }
            }
        }
        return targetPack.slots.get(targetSlot)?.displayName ?? null;
    }
    function flushPendingPacks() {
        if (!pendingPacks.size) return true;
        const packs = [...pendingPacks.values()].sort((a, b) => a.order - b.order);
        for (const pendingPack of packs) {
            const slots = [...pendingPack.slots.keys()].sort((a, b) => a - b);
            if (!slots.length || slots[0] !== 1) { return false; }
            for (let i = 0; i < slots.length; i++) if (slots[i] !== i + 1) { return false; }
            const slotInfos = slots.map(i => pendingPack.slots.get(i));
            const hasAnyLocal = slotInfos.some(slot => !!slot?.localReg);
            if (!hasAnyLocal) {
                if (!slotInfos.every(slot => slot && hasOnlyDeadCopyUses(slot.extractionIndex, slot.tempReg))) { return false; }
                out.push(pendingPack.call);
                consumedPackRegs.add(pendingPack.packReg);
            } else {
                for (const slot of slotInfos) {
                    if (!slot?.localReg) { return false; }
                    if (typeof slot.displayName !== "string") {
                        if (locals.has(slot.localReg)) slot.displayName = allocateLocal(slot.localReg, "value");
                        else { slot.displayName = `v${++valueLocalCount}`; declaredCount++; }
                    }
                }
                const names = slotInfos.map(slot => slot.displayName);
                for (const slot of slotInfos) {
                    if (!locals.has(slot.localReg)) continue;
                    localNames.set(slot.localReg, slot.displayName);
                    expr.set(slot.localReg, slot.displayName);
                    exprKinds.set(slot.localReg, "value");
                    exprMeta.delete(slot.localReg);
                }
                out.push(`local ${names.join(", ")} = ${pendingPack.call}`);
                consumedPackRegs.add(pendingPack.packReg);
            }
            for (let i = 0; i < deferredSourceLines.length;) {
                if (deferredSourceLines[i].afterPackOrder <= pendingPack.order) {
                    const deferred = deferredSourceLines[i];
                    out.push(deferred.line);
                    if (deferred.declaresReg) deferredLocalBarriers.delete(deferred.declaresReg);
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
        if (rhs?.type === "LogicalExpression" && rhs.freshCompilerLogical === true && typeof rhs.operator === "string") {
            const left = renderRhs(rhs.left);
            const right = renderRhs(rhs.right);
            if (typeof left !== "string" || typeof right !== "string") return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "LogicalExpression" && isIdentifier(rhs.left)) {
            const rightIsIdentifier = isIdentifier(rhs.right);
            const rightIsCompilerUpvalueRead = rhs.right?.type === "IndexExpression" &&
                isIdentifier(rhs.right.base, "upvalueValues") && isIdentifier(rhs.right.index);
            if (!rightIsIdentifier && !rightIsCompilerUpvalueRead) return null;
            const left = expr.get(rhs.left.name) ?? (locals.has(rhs.left.name) ? localName(rhs.left.name) : null);
            const right = renderRhs(rhs.right);
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
            emitSourceLine(`${target} = ${value}`, [dest.base.name]);
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
        const isDeferredTerminalUnusedCopy = isIdentifier(rhs) && deferredTerminalUnusedCopies.get(name) === rhs.name;
        const isDeadRegisterCopy = isIdentifier(rhs) && name !== stateName && name !== returnName && !cleanupRegs.has(name) && hasOnlyDeadCopyUses(index, name);
        const isKnownUpvalueRead = rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index) && typeof upvalueCells.get(rhs.index.name) === "string";
        const isStableGlobalLoad = pendingPacks.size > 0 && isVmRegisterName(name) && rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index) && typeof expr.get(rhs.index.name) === "string" && !rhsDependsOnPendingPack(rhs.index);
        const isBorrowedStateGlobalLoadBeforePackSlot = pendingPacks.size > 0 && name === stateName && rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index) && typeof expr.get(rhs.index.name) === "string" && !rhsDependsOnPendingPack(rhs.index) && hasFuturePendingPackSlotBeforeStateTouch(index);
        const isUpvalueAllocation = rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0 && name !== stateName && name !== returnName && !upvalueCells.has(name);
        const releaseArgs = rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue") ? (rhs.arguments || []) : null;
        const isKnownUpvalueRelease = releaseArgs?.length === 1 && isIdentifier(releaseArgs[0], name) && name !== stateName && name !== returnName && upvalueCells.has(name);
        const isCallExpression = rhs?.type === "CallExpression";
        const isClosureCreation = isCallExpression && isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name);
        const cleanupFutureLocal = isCallExpression ? findFutureCleanupCopy(index, name) : null;
        const terminalClosureFutureLocal = isClosureCreation && !cleanupFutureLocal ? findFutureTerminalClosureCopy(index, name) : null;
        const upvalueClosureFutureCell = isClosureCreation && !cleanupFutureLocal && !terminalClosureFutureLocal ? findFutureUpvalueClosureStore(index, name) : null;
        const terminalUnusedFutureLocal = !cleanupFutureLocal && !terminalClosureFutureLocal && !upvalueClosureFutureCell ? findFutureTerminalUnusedCopy(index, name) : null;
        const callFutureLocal = cleanupFutureLocal || terminalClosureFutureLocal || terminalUnusedFutureLocal;
        const terminalUnusedValueFutureLocal = !isCallExpression && !isPackIndex && !isPackSlotCopy && isPurePendingTempRhs(rhs) && !isReturnPackCreation ? findFutureTerminalUnusedCopy(index, name) : null;
        const directTerminalUnusedValue = !isCallExpression && !isPackIndex && !isPackSlotCopy && !terminalUnusedValueFutureLocal && isVmRegisterName(name) && !cleanupRegs.has(name) && isPurePendingTempRhs(rhs) && !isReturnPackCreation && isTerminalUnreadEpoch(index, name);
        const isTerminalUsedTransportAlias = isVmRegisterName(name) && !cleanupRegs.has(name) && !locals.has(name) && isIdentifier(rhs) &&
            (rhs.name === stateName || rhs.name === returnName) && !isPackSlotCopy && isTerminalStableUsedEpoch(index, name);
        const terminalUsedAliasPackBarrier = isTerminalUsedTransportAlias && pendingPacks.size ? Math.max(...[...pendingPacks.values()].map(pack => pack.order)) : 0;
        const isDeferredTerminalUsedAlias = isTerminalUsedTransportAlias && terminalUsedAliasPackBarrier > 0;
        const callResultIsDiscarded = isCallExpression && hasOnlyDeadCopyUses(index, name);
        const callPackBarrier = isCallExpression && pendingPacks.size ? Math.max(...[...pendingPacks.values()].map(pack => pack.order)) : 0;
        const hasTrackedPackBarrier = callPackBarrier > 0;
        const isClosureTableOperand = isClosureCreation && isUniqueFutureTableOperand(index, name);
        const callUsesPendingPackSourceLocal = isCallExpression && rhsUsesPendingPackSourceLocal(rhs);
        const isDeferredClosureCreation = isClosureCreation && !callUsesPendingPackSourceLocal && (!!callFutureLocal || !!upvalueClosureFutureCell || isClosureTableOperand) && hasTrackedPackBarrier;
        const isDeferredOrdinaryCall = isCallExpression && !isClosureCreation && !callUsesPendingPackSourceLocal && hasTrackedPackBarrier && (!!callFutureLocal || callResultIsDiscarded);
        const terminalUnusedValuePackBarrier = terminalUnusedValueFutureLocal && pendingPacks.size ? Math.max(...[...pendingPacks.values()].map(pack => pack.order)) : 0;
        const isDeferredTerminalUnusedValue = !!terminalUnusedValueFutureLocal && terminalUnusedValuePackBarrier > 0;
        // Table source-storage ownership is independent of pending return packs.
        // A pending pack only changes when the recovered source line may be emitted.
        const liveTableFutureLocal = findFutureLiveTableCopy(index, name, rhs);
        const isLiveTableHandoff = !!liveTableFutureLocal;
        const isDeadPureTemp = pendingPacks.size > 0 && !isLiveTableHandoff && isDeadPurePendingTemp(index, name, rhs);
        const isStablePrimitiveTemp = pendingPacks.size > 0 && isPrimitiveLiteral(rhs) && name !== stateName && !cleanupRegs.has(name);
        const isUnusedPlainTableReadLocal = rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && plainTableLocals.has(rhs.base.name) && isVmRegisterName(name) && !cleanupRegs.has(name) && isTerminalUnreadEpoch(index, name) && !rhsDependsOnPendingPack(rhs);
        const isDeadPlainTableRead = pendingPacks.size > 0 && !isUnusedPlainTableReadLocal && isDeadPlainTableIndexRead(index, name, rhs);
        const isPlainTableNamecallLoad = pendingPacks.size > 0 && isPlainTableMethodLoad(index, name, rhs);
        const liveTablePackBarrier = isLiveTableHandoff && pendingPacks.size > 0 ? Math.max(...[...pendingPacks.values()].map(pack => pack.order)) : 0;
        const isDeferredLiveTable = isLiveTableHandoff && liveTablePackBarrier > 0;
        const isDeferredLiveTableCopy = isIdentifier(rhs) && deferredLiveTableCopies.get(rhs.name) === name;
        const isPendingNeutralBookkeeping =
            (isIdentifier(rhs, "args") && name !== stateName && name !== returnName) ||
            (rhs?.type === "NilLiteral" && cleanupRegs.has(name)) ||
            isKnownUpvalueRead ||
            isStableGlobalLoad ||
            isBorrowedStateGlobalLoadBeforePackSlot ||
            isUpvalueAllocation ||
            isKnownUpvalueRelease ||
            isDeferredClosureCreation ||
            isDeferredOrdinaryCall ||
            isDeferredTerminalUnusedValue ||
            directTerminalUnusedValue ||
            isTerminalUsedTransportAlias ||
            isDeadPureTemp ||
            isStablePrimitiveTemp ||
            isUnusedPlainTableReadLocal ||
            isDeadPlainTableRead ||
            isPlainTableNamecallLoad ||
            isDeferredLiveTable ||
            isDeferredLiveTableCopy ||
            isDeadRegisterCopy ||
            isDeferredStorageCopy ||
            isDeferredTerminalClosureCopy ||
            isDeferredTerminalUnusedCopy;
        if (pendingPacks.size && !isPackIndex && !isPackSlotCopy && !isReturnPackCreation && !isPendingNeutralBookkeeping && !flushPendingPacks()) return null;

        if (directPromotionStartIndices.has(index) && !locals.has(name) && !isPackIndex) {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const kind = rhs?.type === "TableConstructorExpression" ? "table" : "value";
            const displayName = allocateLocal(name, kind);
            out.push(`local ${displayName} = ${value}`);
            if (kind === "table") plainTableLocals.add(name);
            continue;
        }

        if (isUnusedPlainTableReadLocal) {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const displayName = allocateLocal(name, "value");
            emitSourceLine(`local ${displayName} = ${value}`, [rhs.base.name]);
            terminalUnusedLocals.add(name);
            continue;
        }

        if (isDeadPlainTableRead) {
            expr.delete(name); exprKinds.delete(name); exprMeta.delete(name);
            continue;
        }

        if (isDeferredLiveTableCopy) {
            deferredLiveTableCopies.delete(rhs.name);
            expr.set(name, localName(name));
            exprKinds.set(name, "table");
            continue;
        }

        if (isDeferredStorageCopy || isDeferredTerminalClosureCopy || isDeferredTerminalUnusedCopy) {
            if (isDeferredStorageCopy) deferredStorageCopies.delete(name);
            else if (isDeferredTerminalClosureCopy) deferredTerminalClosureCopies.delete(name);
            else deferredTerminalUnusedCopies.delete(name);
            if (!locals.has(name)) return null;
            let displayName = localName(name);
            if (isDeferredStorageCopy && isPackSlotCopy) {
                const meta = exprMeta.get(rhs.name);
                const pendingPack = meta ? pendingPacks.get(meta.packReg) : null;
                if (pendingPack && meta) {
                    const slotInfo = pendingPack.slots.get(meta.slot);
                    if (!slotInfo || slotInfo.localReg !== name) return null;
                    if (meta.slot === 1) {
                        displayName = reservePendingPackDisplayNamesThrough(pendingPack, meta.slot);
                        if (typeof displayName !== "string") return null;
                        localNames.set(name, displayName);
                    }
                }
            }
            expr.set(name, displayName);
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
        if (name === returnName && rhs?.type === "TableConstructorExpression" && (rhs.fields || []).length > 0) {
            const next = leaf[index + 1];
            if (index === leaf.length - 1 || (isSingleAssignment(next, stateName) && next.init[0]?.type === "NilLiteral")) {
                const values = [];
                for (const field of rhs.fields || []) {
                    if (field?.type !== "TableValue") return null;
                    const value = renderRhs(field.value);
                    if (typeof value !== "string") return null;
                    values.push(value);
                }
                terminalReturnLine = values.length ? `return ${values.join(", ")}` : "return";
                sawReturnReset = true;
                if (index === leaf.length - 1) sawStop = true;
                continue;
            }
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
                    if (nonNilDefs === 0 && (nilDefinitionCount.get(name) || 0) === 1 && isVmRegisterName(name) && isTerminalUnreadEpoch(index, name)) {
                        const displayName = allocateLocal(name, "value");
                        out.push(`local ${displayName}`);
                        terminalUnusedLocals.add(name);
                        continue;
                    }
                    // Multiple meaningful definitions before cleanup cannot prove where VAR ownership began.
                    if (nonNilDefs > 1) return null;
                    // Unowned nil bookkeeping remains removable only when it cannot prove a source lifetime.
                    continue;
                }
                const displayName = allocateLocal(name, "value");
                out.push(`local ${displayName}`);
                if ((nonNilDefinitionCount.get(name) || 0) === 0 && !hasLaterNilAssignment(index, name)) {
                    let futureReads = 0;
                    for (let probe = index + 1; probe < leaf.length; probe++) {
                        const later = leaf[probe];
                        futureReads += countIdentifierUses(later?.init, name);
                        const laterDest = isSingleAssignment(later) ? later.variables[0] : null;
                        if (laterDest?.type === "IndexExpression") futureReads += countIdentifierUses(laterDest, name);
                        if (isIdentifier(laterDest, name)) break;
                    }
                    if (futureReads >= 2) terminalNilLocals.add(name);
                }
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
            const slotInfo = { tempReg: name, localReg: null, displayName: null, extractionIndex: index };
            pendingPack.slots.set(rendered.slot, slotInfo);
            expr.set(name, rendered.call); exprKinds.set(name, "pack-slot"); exprMeta.set(name, { packReg: rendered.packReg, slot: rendered.slot });
            if (cleanupRegs.has(name)) {
                // The slot can already be the source VAR register. Reserve its
                // local ownership without erasing pack-slot provenance; later
                // consumers must still know this value depends on the pending
                // compiler return pack until flushPendingPacks() maps the slot
                // to its recovered local display name.
                reserveLocal(name, true);
                slotInfo.localReg = name;
            } else {
                const futureLocal = findFutureCleanupCopy(index, name);
                const terminalFutureLocal = !futureLocal ? findFutureTerminalUnusedCopy(index, name) : null;
                if (futureLocal) {
                    reserveLocal(futureLocal, futureLocal === rendered.packReg);
                    slotInfo.localReg = futureLocal;
                    deferredStorageCopies.set(futureLocal, name);
                } else if (terminalFutureLocal) {
                    reserveLocal(terminalFutureLocal, terminalFutureLocal === rendered.packReg);
                    terminalUnusedLocals.add(terminalFutureLocal);
                    slotInfo.localReg = terminalFutureLocal;
                    deferredTerminalUnusedCopies.set(terminalFutureLocal, name);
                } else if (isVmRegisterName(name) && isTerminalUnreadEpoch(index, name)) {
                    reserveLocal(name, true);
                    terminalUnusedLocals.add(name);
                    slotInfo.localReg = name;
                }
            }
            continue;
        }

        if (cleanupRegs.has(name) && !hasFutureDirectPromotionStart(index, name) && !locals.has(name) && isPackSlotCopy) {
            const meta = exprMeta.get(rhs.name);
            const pendingPack = meta ? pendingPacks.get(meta.packReg) : null;
            if (!meta || !pendingPack) return null;
            const slotInfo = pendingPack.slots.get(meta.slot);
            if (!slotInfo || slotInfo.localReg) return null;
            reserveLocal(name); slotInfo.localReg = name; continue;
        }

        if (cleanupRegs.has(name) && !hasFutureDirectPromotionStart(index, name) && !locals.has(name) && isPosPreservationCopy(index, name, rhs)) {
            const value = expr.get(stateName);
            if (typeof value !== "string") return null;
            expr.set(name, value);
            exprKinds.set(name, "value");
            continue;
        }

        if (cleanupRegs.has(name) && !hasFutureDirectPromotionStart(index, name) && !locals.has(name) && isIdentifier(rhs) && rhs.name !== name) {
            const value = expr.get(rhs.name) ?? (locals.has(rhs.name) ? localName(rhs.name) : null);
            if (typeof value !== "string") return null;
            const kind = exprKinds.get(rhs.name) || "value";
            const displayName = allocateLocal(name, kind);
            out.push(value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`); continue;
        }

        if (cleanupRegs.has(name) && !hasFutureDirectPromotionStart(index, name) && !locals.has(name) && nonNilDefinitionCount.get(name) === 1) {
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
            emitSourceLine(`${localName(name)} = ${value}`, [name]); expr.set(name, localName(name));
            exprKinds.set(name, rhs?.type === "TableConstructorExpression" ? "table" : "value"); continue;
        }

        if (isTerminalUsedTransportAlias) {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const kind = exprKinds.get(rhs.name) === "table" ? "table" : "value";
            const displayName = allocateLocal(name, kind);
            const sourceLine = value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`;
            if (isDeferredTerminalUsedAlias) deferredSourceLines.push({ line: sourceLine, afterPackOrder: terminalUsedAliasPackBarrier });
            else out.push(sourceLine);
            terminalAliasLocals.add(name);
            continue;
        }

        if (terminalUnusedValueFutureLocal || directTerminalUnusedValue) {
            const futureLocal = terminalUnusedValueFutureLocal || name;
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const kind = rhs?.type === "TableConstructorExpression" ? "table" : "value";
            const displayName = allocateLocal(futureLocal, kind);
            const sourceLine = value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`;
            if (isDeferredTerminalUnusedValue) deferredSourceLines.push({ line: sourceLine, afterPackOrder: terminalUnusedValuePackBarrier });
            else out.push(sourceLine);
            terminalUnusedLocals.add(futureLocal);
            if (terminalUnusedValueFutureLocal) deferredTerminalUnusedCopies.set(futureLocal, name);
            expr.set(name, displayName);
            exprKinds.set(name, kind);
            continue;
        }

        if (isLiveTableHandoff) {
            const value = renderRhs(rhs);
            if (typeof value !== "string") return null;
            const wasLocal = locals.has(liveTableFutureLocal);
            const displayName = wasLocal ? localName(liveTableFutureLocal) : allocateLocal(liveTableFutureLocal, "table");
            const sourceLine = wasLocal ? `${displayName} = ${value}` : `local ${displayName} = ${value}`;
            if (!wasLocal) terminalTableLocals.add(liveTableFutureLocal);
            plainTableLocals.add(liveTableFutureLocal);
            if (isDeferredLiveTable) {
                if (!wasLocal) deferredLocalBarriers.set(liveTableFutureLocal, liveTablePackBarrier);
                deferredSourceLines.push({ line: sourceLine, afterPackOrder: liveTablePackBarrier, declaresReg: wasLocal ? null : liveTableFutureLocal });
            } else {
                out.push(sourceLine);
            }
            deferredLiveTableCopies.set(name, liveTableFutureLocal);
            expr.set(name, displayName);
            exprKinds.set(name, "table");
            continue;
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
                else if (terminalUnusedFutureLocal === futureLocal) { deferredTerminalUnusedCopies.set(futureLocal, name); terminalUnusedLocals.add(futureLocal); }
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
    if (deferredTerminalUnusedCopies.size !== 0) { if (options.diagnostics) options.diagnostics.reason = "terminal unused-local handoff copy was not consumed"; return null; }
    if (deferredUpvalueClosureStores.size !== 0) { if (options.diagnostics) options.diagnostics.reason = "upvalue closure handoff store was not consumed"; return null; }
    if (deferredLiveTableCopies.size !== 0) { if (options.diagnostics) options.diagnostics.reason = "live table handoff copy was not consumed"; return null; }
    for (const reg of terminalClosureLocals) locals.delete(reg);
    for (const reg of terminalUnusedLocals) locals.delete(reg);
    for (const reg of terminalAliasLocals) locals.delete(reg);
    for (const reg of terminalTableLocals) locals.delete(reg);
    for (const reg of terminalNilLocals) locals.delete(reg);
    if (locals.size !== 0) { if (options.diagnostics) options.diagnostics.reason = `recovered locals still live at terminal: ${[...locals].join(",")}`; return null; }
    if (terminalReturnLine !== null) out.push(terminalReturnLine);
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
    function allocateClosureBindingName() {
        while (reservedParamNames.has(`v${nextParamSuffix}`)) nextParamSuffix++;
        const name = `v${nextParamSuffix++}`;
        reservedParamNames.add(name);
        return name;
    }
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
            if (isIdentifier(node.base, "upvalueValues") && isIdentifier(node.index)) {
                const localName = localCells.get(node.index.name);
                return typeof localName === "string" ? localName : null;
            }
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
                while (paramNames.length < index) paramNames.push(allocateClosureBindingName());
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
                if (typeof value !== "string") return null;
                const existingName = localCells.get(dest.index.name);
                if (typeof existingName === "string") {
                    body.push(`${existingName} = ${value}`);
                    continue;
                }
                const capturedParameterInit = rhs?.type === "IndexExpression" &&
                    isIdentifier(rhs.base, "args") && rhs.index?.type === "NumericLiteral";
                if (capturedParameterInit) {
                    if (!isLuaIdentifier(value)) return null;
                    localCells.set(dest.index.name, value);
                    continue;
                }
                const localName = allocateClosureBindingName();
                localCells.set(dest.index.name, localName);
                body.push(`local ${localName} = ${value}`);
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

function flattenLogicalRootLeaf(leaves, entryId, stateName, returnName, diagnostics = null, options = {}) {
    let currentForDiagnostics = entryId;
    function fail(reason, state = currentForDiagnostics) {
        if (diagnostics && !diagnostics.reason) { diagnostics.reason = reason; diagnostics.state = state; }
        return null;
    }
    const consumed = new Set();
    const out = [];

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

    function successorsOf(id) {
        const body = leaves.get(id);
        if (!body) return [];
        const transition = findTransition(body);
        if (!transition) return [];
        if (transition.kind === "jump") return [transition.target];
        if (transition.kind === "branch") return [transition.onTrue, transition.onFalse];
        return [];
    }

    function canReach(start, target) {
        if (start === target) return true;
        const seen = new Set();
        const queue = [start];
        while (queue.length) {
            const id = queue.shift();
            if (seen.has(id)) continue;
            seen.add(id);
            for (const next of successorsOf(id)) {
                if (next === target) return true;
                if (!seen.has(next)) queue.push(next);
            }
        }
        return false;
    }

    function findPrimaryResultAssignment(body, transition) {
        for (let i = body.length - 1; i >= 0; i--) {
            if (i === transition.index || !isSingleAssignment(body[i])) continue;
            const dest = body[i].variables[0];
            const rhs = body[i].init[0];
            if (!isIdentifier(dest) || dest.name === stateName) continue;
            if (isIdentifier(rhs, transition.conditionRegister)) return { index: i, resultReg: dest.name };
        }
        return null;
    }

    function mergeDeps(into, from) {
        for (const dep of from || []) into.add(dep);
    }

    function resolvePathNode(node, env) {
        if (!node || typeof node !== "object") return null;
        if (isIdentifier(node)) {
            const known = env.get(node.name);
            return known ? { node: known.node, deps: new Set(known.deps) } : { node, deps: new Set() };
        }
        if (isPrimitiveLiteral(node)) return { node, deps: new Set() };
        if (node.type === "UnaryExpression") {
            const argument = resolvePathNode(node.argument, env);
            if (!argument) return null;
            return { node: { ...node, argument: argument.node }, deps: argument.deps };
        }
        if (node.type === "BinaryExpression" || node.type === "LogicalExpression") {
            const left = resolvePathNode(node.left, env);
            const right = resolvePathNode(node.right, env);
            if (!left || !right) return null;
            const deps = new Set(left.deps); mergeDeps(deps, right.deps);
            return { node: { ...node, left: left.node, right: right.node }, deps };
        }
        if (node.type === "IndexExpression") {
            const base = resolvePathNode(node.base, env);
            const index = resolvePathNode(node.index, env);
            if (!base || !index) return null;
            const deps = new Set(base.deps); mergeDeps(deps, index.deps);
            return { node: { ...node, base: base.node, index: index.node }, deps };
        }
        if (node.type === "CallExpression") {
            const base = resolvePathNode(node.base, env);
            if (!base) return null;
            const args = [];
            const deps = new Set(base.deps);
            for (const arg of node.arguments || []) {
                const resolved = resolvePathNode(arg, env);
                if (!resolved) return null;
                args.push(resolved.node);
                mergeDeps(deps, resolved.deps);
            }
            return { node: { ...node, base: base.node, arguments: args }, deps };
        }
        if (node.type === "TableConstructorExpression") {
            const fields = [];
            const deps = new Set();
            for (const field of node.fields || []) {
                if (field?.type === "TableValue") {
                    const value = resolvePathNode(field.value, env);
                    if (!value) return null;
                    fields.push({ ...field, value: value.node }); mergeDeps(deps, value.deps); continue;
                }
                if (field?.type === "TableKey") {
                    const key = resolvePathNode(field.key, env);
                    const value = resolvePathNode(field.value, env);
                    if (!key || !value) return null;
                    fields.push({ ...field, key: key.node, value: value.node });
                    mergeDeps(deps, key.deps); mergeDeps(deps, value.deps); continue;
                }
                if (field?.type === "TableKeyString") {
                    const value = resolvePathNode(field.value, env);
                    if (!value) return null;
                    fields.push({ ...field, value: value.node }); mergeDeps(deps, value.deps); continue;
                }
                return null;
            }
            return { node: { ...node, fields }, deps };
        }
        return null;
    }

    function resolvePathResult(statements, resultReg) {
        const env = new Map();
        const defs = [];
        for (let i = 0; i < statements.length; i++) {
            const statement = statements[i];
            if (!isSingleAssignment(statement)) return null;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (!isIdentifier(dest)) return null;
            const resolved = resolvePathNode(rhs, env);
            if (!resolved) return null;
            const deps = new Set(resolved.deps);
            deps.add(i);
            env.set(dest.name, { node: resolved.node, deps });
            defs.push({ index: i, dest: dest.name, rhs });
        }
        const result = env.get(resultReg);
        if (!result) return null;
        for (const def of defs) {
            if (result.deps.has(def.index)) continue;
            if (def.dest === stateName || isIdentifier(def.rhs, stateName)) continue;
            return null;
        }
        return result.node;
    }

    function nodeReadsName(node, name) {
        if (!node || typeof node !== "object") return false;
        if (isIdentifier(node, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeReadsName(item, name))) return true;
            } else if (value && typeof value === "object" && nodeReadsName(value, name)) return true;
        }
        return false;
    }

    function valueReadBeforeOverwriteInBody(body, name) {
        for (const statement of body || []) {
            if (!isSingleAssignment(statement)) return true;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (nodeReadsName(rhs, name) || (dest?.type === "IndexExpression" && nodeReadsName(dest, name))) return true;
            if (isIdentifier(dest, name)) return false;
        }
        return false;
    }
    function flattenPath(startId, stopId, targetOut) {
        let current = startId;
        while (stopId == null || current !== stopId) {
            currentForDiagnostics = current;
            if (consumed.has(current)) return fail("root revisits an already-consumed state", current);
            const body = leaves.get(current);
            if (!body) return fail("root references a missing state leaf", current);
            const transition = findTransition(body);
            if (!transition) return fail("root state has no recognized terminal state transition", current);

            if (transition.kind === "branch") {
                const primary = findPrimaryResultAssignment(body, transition);
                if (!primary) return fail("logical branch has no compiler result copy", current);
                const trueReachesFalse = canReach(transition.onTrue, transition.onFalse);
                const falseReachesTrue = canReach(transition.onFalse, transition.onTrue);
                if (trueReachesFalse === falseReachesTrue) return fail("logical branch successors do not form a proven lazy-RHS/join pair", current);

                const operator = trueReachesFalse ? "and" : "or";
                const rhsStart = trueReachesFalse ? transition.onTrue : transition.onFalse;
                const joinId = trueReachesFalse ? transition.onFalse : transition.onTrue;
                if (stopId != null && joinId !== stopId && !canReach(joinId, stopId)) {
                    return fail("nested logical join escapes its enclosing lazy path", current);
                }

                const rhsStatements = [];
                if (!flattenPath(rhsStart, joinId, rhsStatements)) return null;
                const fallback = resolvePathResult(rhsStatements, primary.resultReg);
                if (!fallback) return fail("logical lazy RHS does not reduce to the compiler result register", current);
                const joinBody = leaves.get(joinId);
                const rhsWritten = new Set();
                for (const statement of rhsStatements) {
                    if (!isSingleAssignment(statement)) return fail("logical lazy RHS contains a non-assignment statement", current);
                    const dest = statement.variables[0];
                    if (isIdentifier(dest)) rhsWritten.add(dest.name);
                }
                for (const name of rhsWritten) {
                    if (name === primary.resultReg || name === stateName) continue;
                    if (valueReadBeforeOverwriteInBody(joinBody, name)) {
                        return fail("logical lazy RHS leaves a path-dependent temporary live at the join", current);
                    }
                }

                consumed.add(current);
                for (let i = 0; i < body.length; i++) {
                    if (i === transition.index) continue;
                    if (i === primary.index) {
                        const statement = body[i];
                        targetOut.push({
                            ...statement,
                            init: [{
                                type: "LogicalExpression",
                                freshCompilerLogical: true,
                                operator,
                                left: statement.init[0],
                                right: fallback,
                            }],
                        });
                    } else {
                        targetOut.push(body[i]);
                    }
                }
                current = joinId;
                continue;
            }

            consumed.add(current);
            for (let i = 0; i < body.length; i++) {
                if (i !== transition.index) targetOut.push(body[i]);
            }
            if (transition.kind === "stop") {
                if (stopId != null) return fail("logical lazy RHS stopped before its proven join", current);
                return true;
            }
            current = transition.target;
        }
        return true;
    }

    const stopId = Number.isInteger(options.stopId) ? options.stopId : null;
    if (!flattenPath(entryId, stopId, out)) return null;
    return { leaf: out, consumed };
}

function reduceCompilerLogicalStateGraph(leaves, entryId, stateName, returnName) {
    const working = new Map([...leaves].map(([id, body]) => [id, [...body]]));

    function transitionOf(body) {
        for (let i = body.length - 1; i >= 0; i--) {
            if (!isSingleAssignment(body[i], stateName)) continue;
            const rhs = body[i].init[0];
            if (rhs?.type === "NilLiteral") return { index: i, kind: "stop" };
            if (rhs?.type === "NumericLiteral" && Number.isInteger(Number(rhs.value))) return { index: i, kind: "jump", target: Number(rhs.value) };
            const branch = decodeLogicalStateTransition(rhs);
            if (branch) return { index: i, kind: "branch", ...branch };
        }
        return null;
    }

    function buildGraph() {
        const successors = new Map([...working.keys()].map(id => [id, []]));
        const predecessors = new Map([...working.keys()].map(id => [id, []]));
        for (const [id, body] of working) {
            const tr = transitionOf(body);
            if (!tr) continue;
            const targets = tr.kind === "jump" ? [tr.target] : tr.kind === "branch" ? [tr.onTrue, tr.onFalse] : [];
            for (const target of targets) {
                if (!working.has(target)) continue;
                successors.get(id).push(target);
                predecessors.get(target).push(id);
            }
        }
        return { successors, predecessors };
    }

    function reachableFrom(start, successors) {
        const seen = new Set();
        const queue = [start];
        while (queue.length) {
            const id = queue.shift();
            if (seen.has(id) || !working.has(id)) continue;
            seen.add(id);
            for (const next of successors.get(id) || []) queue.push(next);
        }
        return seen;
    }

    function canReach(start, target, successors) {
        if (start === target) return true;
        const seen = new Set();
        const queue = [start];
        while (queue.length) {
            const id = queue.shift();
            if (seen.has(id)) continue;
            seen.add(id);
            for (const next of successors.get(id) || []) {
                if (next === target) return true;
                if (!seen.has(next)) queue.push(next);
            }
        }
        return false;
    }

    function logicalJoinFor(id, successors) {
        const body = working.get(id);
        const tr = body ? transitionOf(body) : null;
        if (!tr || tr.kind !== "branch") return null;
        let hasPrimaryCopy = false;
        for (let i = body.length - 1; i >= 0; i--) {
            if (i === tr.index || !isSingleAssignment(body[i])) continue;
            const dest = body[i].variables[0];
            const rhs = body[i].init[0];
            if (isIdentifier(dest) && dest.name !== stateName && isIdentifier(rhs, tr.conditionRegister)) {
                hasPrimaryCopy = true;
                break;
            }
        }
        if (!hasPrimaryCopy) return null;
        const trueReachesFalse = canReach(tr.onTrue, tr.onFalse, successors);
        const falseReachesTrue = canReach(tr.onFalse, tr.onTrue, successors);
        if (trueReachesFalse === falseReachesTrue) return null;
        return trueReachesFalse ? tr.onFalse : tr.onTrue;
    }

    const initialGraph = buildGraph();
    const originalReachableStateIds = reachableFrom(entryId, initialGraph.successors);
    let changed = true;
    while (changed) {
        changed = false;
        const { successors, predecessors } = buildGraph();
        const reachable = reachableFrom(entryId, successors);
        for (const id of reachable) {
            const joinId = logicalJoinFor(id, successors);
            if (!Number.isInteger(joinId) || joinId === id || !working.has(joinId)) continue;
            const flattened = flattenLogicalRootLeaf(working, id, stateName, returnName, null, { stopId: joinId });
            if (!flattened || !flattened.consumed.has(id) || flattened.consumed.has(joinId)) continue;
            let closed = true;
            for (const consumedId of flattened.consumed) {
                if (consumedId !== id) {
                    for (const pred of predecessors.get(consumedId) || []) {
                        if (!flattened.consumed.has(pred)) { closed = false; break; }
                    }
                    if (!closed) break;
                }
                for (const next of successors.get(consumedId) || []) {
                    if (next !== joinId && !flattened.consumed.has(next)) { closed = false; break; }
                }
                if (!closed) break;
            }
            if (!closed) continue;

            const originalBody = working.get(id);
            const originalTransition = transitionOf(originalBody);
            if (!originalTransition) continue;
            const transitionStatement = originalBody[originalTransition.index];
            const jumpStatement = {
                ...transitionStatement,
                init: [{ type: "NumericLiteral", value: joinId, raw: String(joinId) }],
            };
            working.set(id, [...flattened.leaf, jumpStatement]);
            for (const consumedId of flattened.consumed) {
                if (consumedId === id) continue;
                working.delete(consumedId);
            }
            changed = true;
            break;
        }
    }

    return { leaves: working, originalReachableStateIds };
}
function matchClosureEntryProgram(source, stateWhile, stateName, returnName, diagnostics = null) {
    const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!leaves || leaves.size < 2 || !leaves.has(1)) return null;
    const consumedEntries = new Set();

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

    // Mixed root CFGs may contain logical-value regions feeding real
    // if/elseif/else branches. Recover them with the structural multi-state
    // solver instead of requiring the whole closure root to flatten into one
    // logical leaf. Only root-reachable states participate in its lifetime
    // proof; createClosureN calls render/consume separate child entries.
    const structuredProgram = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, {
        allowConditionalIf: true,
        rootReachableOnly: true,
        renderSpecialCall: renderClosureCall,
    });
    if (structuredProgram && consumedEntries.size > 0) {
        const accounted = new Set([...(structuredProgram.reachableStateIds || []), ...consumedEntries]);
        if (accounted.size === leaves.size && [...leaves.keys()].every(id => accounted.has(id))) {
            return { ...structuredProgram, stateCount: leaves.size, closureCount: consumedEntries.size };
        }
    }

    // Legacy closure path remains for roots that are entirely reducible to a
    // flattened logical/register-local leaf, including existing capture cases.
    consumedEntries.clear();
    const rootDiagnostics = {};
    const flattenedRoot = flattenLogicalRootLeaf(leaves, 1, stateName, returnName, rootDiagnostics);
    for (const id of (flattenedRoot ? flattenedRoot.consumed : [1])) consumedEntries.add(id);
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

function matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, options = {}) {
    const allowConditionalIf = options.allowConditionalIf === true;
    const rootReachableOnly = options.rootReachableOnly === true;
    const originalLeaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!originalLeaves || originalLeaves.size < 2 || !originalLeaves.has(1)) return null;
    const logicalReduction = allowConditionalIf
        ? reduceCompilerLogicalStateGraph(originalLeaves, 1, stateName, returnName)
        : { leaves: originalLeaves, originalReachableStateIds: new Set(originalLeaves.keys()) };
    const leaves = logicalReduction.leaves;

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
    if (!rootReachableOnly && reachable.size !== blocks.size) return null;

    // Lifetime/storage proof belongs to one VM invocation root. Child closure
    // entry states reuse the same physical register names but execute in a
    // separate invocation, so unreachable child states must never contribute
    // cleanup/definition evidence to the root program.
    const cleanupRegs = new Set();
    for (const id of reachable) {
        const body = blocks.get(id)?.body || [];
        for (const statement of body) {
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (isIdentifier(dest) && dest.name !== stateName && dest.name !== returnName && rhs?.type === "NilLiteral") cleanupRegs.add(dest.name);
        }
    }
    if (!cleanupRegs.size && !allowConditionalIf) return null;

    const nonNilDefinitionCount = new Map([...cleanupRegs].map(name => [name, 0]));
    for (const id of reachable) {
        const body = blocks.get(id)?.body || [];
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

    function hasLinearRootContinuation(fromId, toId) {
        if (!Number.isInteger(fromId) || !Number.isInteger(toId)) return false;
        let current = fromId;
        const seen = new Set();
        while (true) {
            if (current === toId) return true;
            if (seen.has(current)) return false;
            seen.add(current);
            const next = successors.get(current) || [];
            if (next.length !== 1) return false;
            current = next[0];
        }
    }

    function recordRootConditional(startId, joinId) {
        const anchor = lastRootConditionalJoinId === null ? 1 : lastRootConditionalJoinId;
        if (!hasLinearRootContinuation(anchor, startId)) return false;
        lastRootConditionalJoinId = joinId;
        conditionalIfCount++;
        return true;
    }

    const indegree = new Map();
    for (const id of reachable) indegree.set(id, (predecessors.get(id) || []).filter(p => reachable.has(p)).length);
    const ready = [1];
    const incoming = new Map([[1, [{ env: new Map(), markers: [], effects: [] }]]]);
    const processed = new Set();
    const locals = new Set();
    const localNames = new Map();
    const terminalLiveLocals = new Set();
    // Branch-local source bindings are path-scoped. Their generated source
    // names live in the candidate environment instead of the global physical-
    // register local map, so sibling CFG paths may safely reuse one VM register.
    const pathLocalBindingNames = new Set();
    // A source value may be held in a register until one terminal cleanup,
    // even though its last real use is an earlier call.  Remember those
    // already-emitted epochs so the eventual compiler nil write does not
    // append a duplicate declaration or reorder it after the call.
    const earlyCleanupPending = new Set();
    // In conditional recovery, some cleanup-backed registers are source
    // storage rather than compiler value accumulators. They are proven below
    // only when multiple definitions converge and the merged storage is read
    // as an ordinary value after the join.
    const persistentStorageRegs = new Set();
    const out = [];
    const terminalCandidates = [];
    let valueCount = 0;
    let tableCount = 0;
    let conditionalIfCount = 0;
    let lastRootConditionalJoinId = null;

    function displayLocal(reg) { return localNames.get(reg) || reg; }
    function activeLocalDisplay(name, env) {
        const value = env.get(name);
        if (typeof value === "string" && pathLocalBindingNames.has(value)) return value;
        if (locals.has(name)) {
            const display = displayLocal(name);
            if (value === display) return display;
        }
        return null;
    }
    function hasActiveLocal(name, env) { return activeLocalDisplay(name, env) !== null; }
    function resolveId(name, env) {
        const active = activeLocalDisplay(name, env);
        if (active !== null) return active;
        return env.get(name) ?? null;
    }
    function render(rhs, env, provenRecursive = false) {
        if (isPrimitiveLiteral(rhs) || isEmptyTable(rhs)) return sourceOf(source, rhs);
        if (rhs?.type === "TableConstructorExpression") return renderTableFields(rhs.fields || [], node => render(node, env, provenRecursive));
        if (isIdentifier(rhs)) return resolveId(rhs.name, env);
        if (rhs?.type === "IndexExpression" && isIdentifier(rhs.base)) {
            const key = isIdentifier(rhs.index) ? resolveId(rhs.index.name, env)
                : (provenRecursive && isPrimitiveLiteral(rhs.index) ? sourceOf(source, rhs.index) : null);
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
            const argument = provenRecursive ? render(rhs.argument, env, true)
                : (isIdentifier(rhs.argument) ? resolveId(rhs.argument.name, env) : (isPrimitiveLiteral(rhs.argument) ? sourceOf(source, rhs.argument) : null));
            return renderUnary(rhs.operator, argument);
        }
        if ((provenRecursive || (rhs?.type === "LogicalExpression" && rhs.freshCompilerLogical === true)) &&
            (rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
            const left = render(rhs.left, env, true);
            const right = render(rhs.right, env, true);
            if (left == null || right == null) return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if ((rhs?.type === "BinaryExpression" || rhs?.type === "LogicalExpression") && rhs.operator) {
            const left = isIdentifier(rhs.left) ? resolveId(rhs.left.name, env) : (isPrimitiveLiteral(rhs.left) ? sourceOf(source, rhs.left) : null);
            const right = isIdentifier(rhs.right) ? resolveId(rhs.right.name, env) : (isPrimitiveLiteral(rhs.right) ? sourceOf(source, rhs.right) : null);
            if (left == null || right == null) return null;
            return `(${left} ${rhs.operator} ${right})`;
        }
        if (rhs?.type === "CallExpression") {
            if (typeof options.renderSpecialCall === "function") {
                const special = options.renderSpecialCall(rhs);
                if (typeof special === "string") return special;
            }
            const base = isIdentifier(rhs.base) ? resolveId(rhs.base.name, env)
                : (provenRecursive ? render(rhs.base, env, true) : null);
            if (base == null) return null;
            const args = [];
            for (const arg of rhs.arguments || []) {
                const value = provenRecursive ? render(arg, env, true)
                    : (isIdentifier(arg) ? resolveId(arg.name, env) : (isPrimitiveLiteral(arg) ? sourceOf(source, arg) : null));
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

    function nodeUsesAsCallBaseMulti(node, name) {
        if (!node || typeof node !== "object") return false;
        if (node.type === "CallExpression" && isIdentifier(node.base, name)) return true;
        for (const [key, value] of Object.entries(node)) {
            if (key === "range" || key === "loc" || key === "variables") continue;
            if (Array.isArray(value)) {
                if (value.some(item => nodeUsesAsCallBaseMulti(item, name))) return true;
            } else if (value && typeof value === "object" && nodeUsesAsCallBaseMulti(value, name)) return true;
        }
        return false;
    }

    function terminalStableUsedEpoch(startBlockId, startIndex, name) {
        const uses = new Map();
        const seen = new Set();
        const stack = [{ blockId: startBlockId, index: startIndex + 1 }];
        let invalid = false;
        while (stack.length && !invalid) {
            const cursor = stack.pop();
            const visitKey = `${cursor.blockId}:${cursor.index}`;
            if (seen.has(visitKey)) continue;
            seen.add(visitKey);
            const block = blocks.get(cursor.blockId);
            if (!block) return false;
            for (let i = cursor.index; i < block.body.length; i++) {
                if (i === block.transitionIndex) continue;
                const statement = block.body[i];
                if (!isSingleAssignment(statement)) return false;
                const dest = statement.variables[0];
                const rhs = statement.init[0];
                if (isIdentifier(dest, name)) { invalid = true; break; }
                if (isIdentifier(dest, stateName) && isIdentifier(rhs, name)) { invalid = true; break; }
                const ordinaryUse = nodeReadsIdentifier(rhs, name) ||
                    (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name));
                if (ordinaryUse) {
                    uses.set(`${cursor.blockId}:${i}`, {
                        delayed: cursor.blockId !== startBlockId || i > startIndex + 1,
                        callBase: nodeUsesAsCallBaseMulti(rhs, name),
                        logical: rhs?.type === "LogicalExpression" && nodeReadsIdentifier(rhs, name),
                    });
                }
            }
            if (invalid) break;
            if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
                uses.set(`${cursor.blockId}:branch`, { delayed: cursor.blockId !== startBlockId, callBase: false, logical: true });
            }
            for (const next of successors.get(cursor.blockId) || []) stack.push({ blockId: next, index: 0 });
        }
        if (invalid || uses.size === 0) return false;
        if (uses.size > 1) return true;
        const only = [...uses.values()][0];
        return only.delayed && !only.callBase && !only.logical;
    }

    function transportSourceKind(block, statementIndex, transportName) {
        for (let i = statementIndex - 1; i >= 0; i--) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement, transportName)) continue;
            return statement.init[0]?.type === "TableConstructorExpression" ? "table" : "value";
        }
        return "value";
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

    // Persistent source storage spans the whole recovered conditional region.
    // Physical registers are reusable, so cleanup evidence on only one sibling
    // path is insufficient: every reachable path from the root must eventually
    // hit the register's nil cleanup. Intermediate non-nil writes are allowed
    // because they are source assignments to the same storage binding.
    const eventualCleanupCache = new Map();
    function eventualCleanupOnAllPaths(blockId, statementIndex, name, visiting = new Set()) {
        const cacheKey = blockId + ":" + statementIndex + ":" + name;
        if (eventualCleanupCache.has(cacheKey)) return eventualCleanupCache.get(cacheKey);
        const visitKey = blockId + ":" + statementIndex + ":" + name;
        if (visiting.has(visitKey)) return false;
        const block = blocks.get(blockId);
        if (!block) return false;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(visitKey);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            if (!isIdentifier(dest, name)) continue;
            if (statement.init[0]?.type === "NilLiteral") {
                eventualCleanupCache.set(cacheKey, true);
                return true;
            }
            // A non-nil write may be another source assignment to the same
            // persistent binding; keep following this path to its cleanup.
        }
        const next = successors.get(blockId) || [];
        if (next.length === 0) {
            eventualCleanupCache.set(cacheKey, false);
            return false;
        }
        const result = next.every(target => eventualCleanupOnAllPaths(target, -1, name, nextVisiting));
        eventualCleanupCache.set(cacheKey, result);
        return result;
    }

    if (allowConditionalIf && accumulatorRegs.size) {
        for (const name of accumulatorRegs) {
            const inDefs = new Map([...reachable].map(id => [id, new Set()]));
            const outDefs = new Map([...reachable].map(id => [id, new Set()]));
            let convergedRead = false;
            let changed = true;
            let rounds = 0;
            while (changed && rounds++ <= reachable.size + 1) {
                changed = false;
                for (const id of reachable) {
                    const incomingDefs = new Set();
                    for (const pred of predecessors.get(id) || []) {
                        if (!reachable.has(pred)) continue;
                        for (const def of outDefs.get(pred) || []) incomingDefs.add(def);
                    }
                    const oldIn = inDefs.get(id);
                    if (oldIn.size !== incomingDefs.size || [...oldIn].some(def => !incomingDefs.has(def))) {
                        inDefs.set(id, incomingDefs);
                        changed = true;
                    }
                    let current = new Set(incomingDefs);
                    const block = blocks.get(id);
                    for (let i = 0; i < block.body.length; i++) {
                        if (i === block.transitionIndex) continue;
                        const statement = block.body[i];
                        if (!isSingleAssignment(statement)) continue;
                        const dest = statement.variables[0];
                        const rhs = statement.init[0];
                        const ordinaryRead = nodeReadsIdentifier(rhs, name) ||
                            (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name));
                        if (ordinaryRead && current.size >= 2) convergedRead = true;
                        if (isIdentifier(dest, name)) {
                            if (rhs?.type === "NilLiteral") current = new Set();
                            else current = new Set([id + ":" + i]);
                        }
                    }
                    const oldOut = outDefs.get(id);
                    if (oldOut.size !== current.size || [...oldOut].some(def => !current.has(def))) {
                        outDefs.set(id, current);
                        changed = true;
                    }
                }
            }
            if (convergedRead && eventualCleanupOnAllPaths(1, -1, name)) persistentStorageRegs.add(name);
        }
    }

    // A call-result temporary can be overwritten on the same block or on a
    // later CFG path.  Unlike pure compiler copies, the call itself is a
    // source-level side effect and must not disappear merely because its
    // return value is dead.  Keep this query path-aware so a call is emitted
    // only when every path discards the value before any read.
    const valueReadAfterCache = new Map();
    function valueMayBeReadAfter(blockId, statementIndex, name, visiting = new Set()) {
        const visitKey = `${blockId}:${statementIndex}`;
        if (visiting.has(visitKey)) return true;
        const cacheKey = `${blockId}:${statementIndex}:${name}`;
        if (valueReadAfterCache.has(cacheKey)) return valueReadAfterCache.get(cacheKey);
        const block = blocks.get(blockId);
        if (!block) return true;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(visitKey);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) {
                valueReadAfterCache.set(cacheKey, true);
                return true;
            }
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (nodeReadsIdentifier(rhs, name) || (dest?.type === "IndexExpression" && nodeReadsIdentifier(dest, name))) {
                valueReadAfterCache.set(cacheKey, true);
                return true;
            }
            if (isIdentifier(dest, name)) {
                valueReadAfterCache.set(cacheKey, false);
                return false;
            }
        }
        if (block.transition.kind === "branch" && block.transition.conditionRegister === name) {
            valueReadAfterCache.set(cacheKey, true);
            return true;
        }
        for (const next of successors.get(blockId) || []) {
            if (valueMayBeReadAfter(next, -1, name, nextVisiting)) {
                valueReadAfterCache.set(cacheKey, true);
                return true;
            }
        }
        valueReadAfterCache.set(cacheKey, false);
        return false;
    }

    const futureNonNilWriteCache = new Map();
    function hasFutureNonNilWrite(blockId, statementIndex, name, visiting = new Set()) {
        const cacheKey = blockId + ":" + statementIndex + ":" + name;
        if (futureNonNilWriteCache.has(cacheKey)) return futureNonNilWriteCache.get(cacheKey);
        const visitKey = blockId + ":" + statementIndex;
        if (visiting.has(visitKey)) return true;
        const block = blocks.get(blockId);
        if (!block) return true;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(visitKey);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            const rhs = statement.init[0];
            if (!isIdentifier(dest, name)) continue;
            const result = rhs?.type !== "NilLiteral";
            futureNonNilWriteCache.set(cacheKey, result);
            return result;
        }
        for (const next of successors.get(blockId) || []) {
            if (hasFutureNonNilWrite(next, -1, name, nextVisiting)) {
                futureNonNilWriteCache.set(cacheKey, true);
                return true;
            }
        }
        futureNonNilWriteCache.set(cacheKey, false);
        return false;
    }

    const cleanupPathCache = new Map();
    function cleanupReachedOnAllPaths(blockId, statementIndex, name, visiting = new Set()) {
        const cacheKey = blockId + ":" + statementIndex + ":" + name;
        if (cleanupPathCache.has(cacheKey)) return cleanupPathCache.get(cacheKey);
        const visitKey = blockId + ":" + statementIndex + ":" + name;
        if (visiting.has(visitKey)) return false;
        const block = blocks.get(blockId);
        if (!block) return false;
        const nextVisiting = new Set(visiting);
        nextVisiting.add(visitKey);
        for (let i = statementIndex + 1; i < block.body.length; i++) {
            if (i === block.transitionIndex) continue;
            const statement = block.body[i];
            if (!isSingleAssignment(statement)) continue;
            const dest = statement.variables[0];
            if (!isIdentifier(dest, name)) continue;
            const result = statement.init[0]?.type === "NilLiteral";
            cleanupPathCache.set(cacheKey, result);
            return result;
        }
        const next = successors.get(blockId) || [];
        if (next.length === 0) {
            cleanupPathCache.set(cacheKey, false);
            return false;
        }
        const result = next.every(target => cleanupReachedOnAllPaths(target, -1, name, nextVisiting));
        cleanupPathCache.set(cacheKey, result);
        return result;
    }

    function mergeElseIfCandidates(candidates, joinId) {
        if (!allowConditionalIf || candidates.length < 3) return null;
        const markerLists = candidates.map(candidate => candidate.markers || []);
        let sharedPrefix = 0;
        while (true) {
            const first = markerLists[0][sharedPrefix];
            if (!first) break;
            if (!markerLists.every(markers => {
                const marker = markers[sharedPrefix];
                return marker && marker.condition === first.condition && marker.truth === first.truth && marker.effectCount === first.effectCount && marker.branchId === first.branchId;
            })) break;
            sharedPrefix++;
        }

        const chainLength = candidates.length - 1;
        const branchByDepth = new Map();
        let finalElse = null;
        let baseEffectCount = null;

        for (let candidateIndex = 0; candidateIndex < candidates.length; candidateIndex++) {
            const candidate = candidates[candidateIndex];
            const markers = markerLists[candidateIndex];
            const suffix = markers.slice(sharedPrefix);
            if (suffix.length < 1 || suffix.length > chainLength) return null;
            for (let depth = 0; depth < suffix.length - 1; depth++) {
                if (suffix[depth].truth !== false) return null;
            }
            const leaf = suffix[suffix.length - 1];
            if (!leaf || !Number.isInteger(leaf.effectCount)) return null;
            if (baseEffectCount === null) baseEffectCount = leaf.effectCount;
            if (leaf.effectCount !== baseEffectCount) return null;
            for (const marker of suffix) {
                if (!Number.isInteger(marker.effectCount) || marker.effectCount !== baseEffectCount) return null;
            }
            if (leaf.truth === true) {
                const depth = suffix.length;
                if (branchByDepth.has(depth)) return null;
                branchByDepth.set(depth, candidate);
            } else {
                if (suffix.length !== chainLength || finalElse) return null;
                finalElse = candidate;
            }
        }
        if (!finalElse || branchByDepth.size !== chainLength) return null;
        for (let depth = 1; depth <= chainLength; depth++) if (!branchByDepth.has(depth)) return null;

        const conditions = [];
        const conditionBranchIds = [];
        for (let depth = 1; depth <= chainLength; depth++) {
            const candidate = branchByDepth.get(depth);
            const suffix = (candidate.markers || []).slice(sharedPrefix);
            for (let i = 0; i < depth - 1; i++) {
                if (suffix[i].condition !== conditions[i] || suffix[i].truth !== false || suffix[i].branchId !== conditionBranchIds[i]) return null;
            }
            const marker = suffix[depth - 1];
            if (!marker || marker.truth !== true) return null;
            conditions.push(marker.condition);
            conditionBranchIds.push(marker.branchId);
        }
        const elseSuffix = (finalElse.markers || []).slice(sharedPrefix);
        for (let i = 0; i < chainLength; i++) {
            if (elseSuffix[i].condition !== conditions[i] || elseSuffix[i].truth !== false || elseSuffix[i].branchId !== conditionBranchIds[i]) return null;
        }

        const ordered = [];
        for (let depth = 1; depth <= chainLength; depth++) ordered.push(branchByDepth.get(depth));
        ordered.push(finalElse);
        const env = new Map();
        const keys = new Set();
        for (const candidate of ordered) for (const key of candidate.env.keys()) keys.add(key);
        keys.delete(stateName);
        for (const key of keys) {
            const values = ordered.map(candidate => candidate.env.get(key));
            const first = values[0];
            if (values.every(value => value === first)) {
                if (first !== undefined) env.set(key, first);
                continue;
            }
            if (!valueMayBeReadFrom(joinId, key)) continue;
            return null;
        }

        const commonEffects = (ordered[0].effects || []).slice(0, baseEffectCount);
        for (const candidate of ordered) {
            const effects = candidate.effects || [];
            if (effects.length < baseEffectCount) return null;
            for (let i = 0; i < baseEffectCount; i++) if (effects[i] !== commonEffects[i]) return null;
        }
        const bodies = ordered.map(candidate => (candidate.effects || []).slice(baseEffectCount));
        if (bodies.slice(0, chainLength).some(body => body.length === 0)) return null;
        const lines = [];
        for (let depth = 0; depth < chainLength; depth++) {
            lines.push(`${depth === 0 ? "if" : "elseif"} ${conditions[depth]} then`);
            for (const effect of bodies[depth]) lines.push(indentConditionalEffect(effect));
        }
        if (bodies[chainLength].length > 0) {
            lines.push("else");
            for (const effect of bodies[chainLength]) lines.push(indentConditionalEffect(effect));
        }
        lines.push("end");
        const structured = lines.join("\n");
        if (sharedPrefix === 0) {
            if (!recordRootConditional(conditionBranchIds[0], joinId)) return null;
            out.push(structured);
            return { env, markers: [], effects: commonEffects };
        }
        return {
            env,
            markers: markerLists[0].slice(0, sharedPrefix),
            effects: [...commonEffects, structured],
        };
    }

    function indentConditionalEffect(text, prefix = "    ") {
        return String(text).split("\n").map(line => prefix + line).join("\n");
    }

    function markersSharePrefix(aMarkers, bMarkers, length) {
        if (aMarkers.length < length || bMarkers.length < length) return false;
        for (let i = 0; i < length; i++) {
            const a = aMarkers[i], b = bMarkers[i];
            if (!a || !b || a.condition !== b.condition || a.truth !== b.truth || a.effectCount !== b.effectCount || a.branchId !== b.branchId) return false;
        }
        return true;
    }

    function terminalSiblingMatch(a, b) {
        const am = a.markers || [], bm = b.markers || [];
        if (am.length === 0 || am.length !== bm.length || !markersSharePrefix(am, bm, am.length - 1)) return null;
        const al = am[am.length - 1], bl = bm[bm.length - 1];
        if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth || al.effectCount !== bl.effectCount || al.branchId !== bl.branchId) return null;
        const effectPrefix = al.effectCount;
        const ae = a.effects || [], be = b.effects || [];
        if (!Number.isInteger(effectPrefix) || effectPrefix > ae.length || effectPrefix > be.length) return null;
        for (let i = 0; i < effectPrefix; i++) if (ae[i] !== be[i]) return null;
        return { al, bl, effectPrefix };
    }

    function guardLine(condition, truth, bodyEffects) {
        if (!Array.isArray(bodyEffects) || bodyEffects.length === 0) return null;
        const test = truth ? condition : `(not ${condition})`;
        const body = bodyEffects.map(line => indentConditionalEffect(line)).join("\n");
        return `if ${test} then\n${body}\nend`;
    }

    function collapseTerminalCandidates() {
        let changed = true;
        while (changed) {
            changed = false;
            outer: for (let i = 0; i < terminalCandidates.length; i++) {
                for (let j = i + 1; j < terminalCandidates.length; j++) {
                    const a = terminalCandidates[i], b = terminalCandidates[j];
                    const match = terminalSiblingMatch(a, b);
                    if (!match) continue;
                    const trueCandidate = match.al.truth ? a : b;
                    const falseCandidate = match.al.truth ? b : a;
                    const guard = guardLine(match.al.condition, true, (trueCandidate.effects || []).slice(match.effectPrefix));
                    if (!guard) return false;
                    const merged = {
                        env: new Map(falseCandidate.env),
                        markers: (falseCandidate.markers || []).slice(0, -1),
                        effects: [
                            ...(falseCandidate.effects || []).slice(0, match.effectPrefix),
                            guard,
                            ...(falseCandidate.effects || []).slice(match.effectPrefix),
                        ],
                        terminal: true,
                    };
                    terminalCandidates.splice(j, 1);
                    terminalCandidates.splice(i, 1, merged);
                    changed = true;
                    break outer;
                }
            }
        }
        return true;
    }

    function foldTerminalGuards(candidate) {
        let current = {
            env: new Map(candidate.env),
            markers: [...(candidate.markers || [])],
            effects: [...(candidate.effects || [])],
        };
        while (current.markers.length > 0) {
            let matchIndex = -1;
            let match = null;
            for (let i = 0; i < terminalCandidates.length; i++) {
                const terminal = terminalCandidates[i];
                const candidateMatch = terminalSiblingMatch(current, terminal);
                if (!candidateMatch) continue;
                matchIndex = i;
                match = candidateMatch;
                break;
            }
            if (matchIndex < 0) break;
            const terminal = terminalCandidates[matchIndex];
            const terminalMarker = terminal.markers[terminal.markers.length - 1];
            const guard = guardLine(terminalMarker.condition, terminalMarker.truth, (terminal.effects || []).slice(match.effectPrefix));
            if (!guard) return null;
            const prefixEffects = current.effects.slice(0, match.effectPrefix);
            current = {
                env: new Map(current.env),
                markers: current.markers.slice(0, -1),
                effects: [...prefixEffects, guard, ...current.effects.slice(match.effectPrefix)],
            };
            terminalCandidates.splice(matchIndex, 1);
            if (!collapseTerminalCandidates()) return null;
        }
        return current;
    }

    function mergeCandidates(candidates, joinId) {
        if (candidates.length === 1) return {
            env: new Map(candidates[0].env),
            markers: [...(candidates[0].markers || [])],
            effects: [...(candidates[0].effects || [])],
        };
        if (candidates.length > 2) return mergeElseIfCandidates(candidates, joinId);
        if (candidates.length !== 2) return null;
        const a = candidates[0], b = candidates[1];
        const am = a.markers || [], bm = b.markers || [];
        let prefix = 0;
        while (prefix < am.length && prefix < bm.length && am[prefix].condition === bm[prefix].condition && am[prefix].truth === bm[prefix].truth && am[prefix].branchId === bm[prefix].branchId) prefix++;
        if (am.length !== prefix + 1 || bm.length !== prefix + 1) return null;
        const al = am[prefix], bl = bm[prefix];
        if (!al || !bl || al.condition !== bl.condition || al.truth === bl.truth || al.branchId !== bl.branchId) return null;
        const t = al.truth ? a : b;
        const f = al.truth ? b : a;
        const cond = al.condition;
        const te = t.effects || [], fe = f.effects || [];
        if (!Number.isInteger(al.effectCount) || al.effectCount !== bl.effectCount) return null;
        const effectPrefix = al.effectCount;
        if (effectPrefix > te.length || effectPrefix > fe.length) return null;
        for (let i = 0; i < effectPrefix; i++) if (te[i] !== fe[i]) return null;
        const trueEffects = te.slice(effectPrefix), falseEffects = fe.slice(effectPrefix);
        const hasConditionalEffects = trueEffects.length > 0 || falseEffects.length > 0;
        if (hasConditionalEffects && !allowConditionalIf) return null;
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
            // A path-dependent compiler TEMP that is overwritten before any
            // later read does not participate in source semantics at this
            // join. Drop it before considering logical result-carrier shapes.
            if (!valueMayBeReadFrom(joinId, key)) continue;
            if (fv === cond && tv != null) {
                if (hasConditionalEffects) return null;
                env.set(key, `(${cond} and ${tv})`);
            }
            else if (tv === cond && fv != null) {
                if (hasConditionalEffects) return null;
                env.set(key, `(${cond} or ${fv})`);
            }
            else return null;
        }
        if (hasConditionalEffects) {
            let structured;
            if (trueEffects.length > 0 && falseEffects.length > 0) {
                const trueBody = trueEffects.map(line => indentConditionalEffect(line)).join("\n");
                const falseBody = falseEffects.map(line => indentConditionalEffect(line)).join("\n");
                structured = `if ${cond} then\n${trueBody}\nelse\n${falseBody}\nend`;
            } else {
                const bodyEffects = trueEffects.length > 0 ? trueEffects : falseEffects;
                const condition = trueEffects.length > 0 ? cond : `(not ${cond})`;
                const body = bodyEffects.map(line => indentConditionalEffect(line)).join("\n");
                structured = `if ${condition} then\n${body}\nend`;
            }
            if (prefix === 0) {
                if (!recordRootConditional(al.branchId, joinId)) return null;
                out.push(structured);
            } else {
                return {
                    env,
                    markers: am.slice(0, prefix),
                    effects: [...te.slice(0, effectPrefix), structured],
                };
            }
        }
        return { env, markers: am.slice(0, prefix), effects: te.slice(0, effectPrefix) };
    }

    while (ready.length) {
        const id = ready.shift();
        if (processed.has(id)) continue;
        const candidates = incoming.get(id) || [];
        if (!collapseTerminalCandidates()) return null;
        const normalizedCandidates = [];
        for (const candidate of candidates) {
            const folded = foldTerminalGuards(candidate);
            if (!folded) return null;
            normalizedCandidates.push(folded);
        }
        const merged = mergeCandidates(normalizedCandidates, id);
        if (!merged) return null;
        let env = merged.env;
        let markers = merged.markers;
        let effects = merged.effects || [];
        if (markers.length === 0 && effects.length > 0) {
            out.push(...effects);
            effects = [];
        }
        const block = blocks.get(id);
        let terminalReturnIndex = -1;
        let terminalReturnLine = null;
        const terminalPackExprs = new Map();
        if (block.transition.kind === "stop") {
            for (let i = block.transitionIndex - 1; i >= 0; i--) {
                if (!isSingleAssignment(block.body[i], returnName)) continue;
                if (block.body[i].init[0]?.type !== "TableConstructorExpression") continue;
                terminalReturnIndex = i;
                break;
            }
            if (terminalReturnIndex < 0) return null;
        }
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

            if (dest?.type === "IndexExpression") {
                if (!isIdentifier(dest.base) || !hasActiveLocal(dest.base.name, env)) return null;
                const base = resolveId(dest.base.name, env);
                const key = isIdentifier(dest.index) ? resolveId(dest.index.name, env)
                    : (isPrimitiveLiteral(dest.index) ? sourceOf(source, dest.index) : null);
                const value = render(rhs, env);
                if (base == null || key == null || value == null) return null;
                const member = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
                const target = member && isLuaIdentifier(member) ? base + "." + member : base + "[" + key + "]";
                const line = target + " = " + value;
                if (markers.length !== 0) {
                    if (!allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    out.push(line);
                }
                continue;
            }
            if (!isIdentifier(dest)) return null;
            const name = dest.name;

            if (i !== terminalReturnIndex) {
                const packFields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
                if (packFields.length === 1 && packFields[0]?.type === "TableValue" && packFields[0].value?.type === "CallExpression") {
                    const packed = render(packFields[0].value, env, true);
                    if (typeof packed === "string") terminalPackExprs.set(name, packed);
                    else terminalPackExprs.delete(name);
                } else {
                    terminalPackExprs.delete(name);
                }
            }

            // A physical register can be reused after an early source epoch
            // was emitted.  The later definition owns the next cleanup epoch;
            // do not let the old marker suppress that new value.
            if (rhs?.type !== "NilLiteral" && !hasActiveLocal(name, env)) earlyCleanupPending.delete(name);

            if (isIdentifier(rhs, "args") && name !== stateName && name !== returnName) {
                env.set(name, "args");
                continue;
            }
            if (i === terminalReturnIndex) {
                const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
                const values = [];
                for (const field of fields) {
                    if (field?.type !== "TableValue") return null;
                    let value = null;
                    const node = field.value;
                    if (node?.type === "CallExpression" && isIdentifier(node.base, "unpack") && (node.arguments || []).length === 1 && isIdentifier(node.arguments[0])) {
                        const packReg = node.arguments[0].name;
                        if (terminalPackExprs.has(packReg)) value = terminalPackExprs.get(packReg);
                        else if (resolveId(packReg, env) === "args") value = "...";
                    }
                    if (value === null) value = render(node, env, true);
                    if (typeof value !== "string") return null;
                    values.push(value);
                }
                terminalReturnLine = values.length ? `return ${values.join(", ")}` : "return";
                continue;
            }
            if (name === returnName && isEmptyTable(rhs)) continue;

            const terminalUsedTransportAlias = allowConditionalIf && isVmRegisterName(name) && !cleanupRegs.has(name) &&
                !hasActiveLocal(name, env) && isIdentifier(rhs) && (rhs.name === stateName || rhs.name === returnName) &&
                terminalStableUsedEpoch(id, i, name);
            if (terminalUsedTransportAlias) {
                const value = render(rhs, env);
                if (typeof value !== "string") return null;
                const kind = transportSourceKind(block, i, rhs.name);
                const display = kind === "table" ? `t${++tableCount}` : `v${++valueCount}`;
                const declaration = value === "nil" ? `local ${display}` : `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    pathLocalBindingNames.add(display);
                    effects = [...effects, declaration];
                } else {
                    localNames.set(name, display);
                    locals.add(name);
                    terminalLiveLocals.add(name);
                    out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            if (cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
                const activeDisplay = activeLocalDisplay(name, env);
                if (activeDisplay !== null && pathLocalBindingNames.has(activeDisplay)) {
                    env.delete(name);
                    continue;
                }
                if (earlyCleanupPending.has(name)) {
                    earlyCleanupPending.delete(name);
                    locals.delete(name);
                    localNames.delete(name);
                    env.delete(name);
                    continue;
                }
                if (accumulatorRegs.has(name)) {
                    if (persistentStorageRegs.has(name) && locals.has(name)) {
                        locals.delete(name);
                        localNames.delete(name);
                        env.delete(name);
                        continue;
                    }
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

            // Function-call statements are represented by a write to a VM
            // temporary (often ReturnVal).  If that result is overwritten
            // without a read, preserve the call itself.  A path-dependent
            // call cannot be represented as a bare source statement here, so
            // fail closed instead of moving it out of its branch.
            if (rhs?.type === "CallExpression" && (!cleanupRegs.has(name) || !valueMayBeReadAfter(id, i, name))) {
                const promotedArguments = [];
                if (markers.length === 0) {
                    for (const argument of rhs.arguments || []) {
                        if (!isIdentifier(argument) || !cleanupRegs.has(argument.name) || locals.has(argument.name) || earlyCleanupPending.has(argument.name)) continue;
                        if (valueMayBeReadAfter(id, i, argument.name)) continue;
                        const argumentValue = env.get(argument.name);
                        if (typeof argumentValue !== "string") return null;
                        const display = `v${++valueCount}`;
                        localNames.set(argument.name, display);
                        locals.add(argument.name);
                        out.push(`local ${display} = ${argumentValue}`);
                        env.set(argument.name, display);
                        earlyCleanupPending.add(argument.name);
                        promotedArguments.push(argument.name);
                    }
                }
                const value = render(rhs, env);
                if (value == null) return null;
                if (!valueMayBeReadAfter(id, i, name)) {
                    if (markers.length !== 0) {
                        if (!allowConditionalIf) return null;
                        effects = [...effects, value];
                    } else {
                        out.push(value);
                    }
                    env.delete(name);
                } else {
                    env.set(name, value);
                }
                for (const argumentName of promotedArguments) {
                    locals.delete(argumentName);
                    localNames.delete(argumentName);
                    env.delete(argumentName);
                }
                continue;
            }

            const value = render(rhs, env);
            if (value == null) {
                // Borrowed state/temp writes may be dead before overwrite; only allow
                // an immediate same-register overwrite inside this block.
                const next = block.body[i + 1];
                if (name !== stateName && !hasActiveLocal(name, env) && isSingleAssignment(next, name)) continue;
                return null;
            }

            const stableStorageEpoch = allowConditionalIf && cleanupRegs.has(name) && !locals.has(name) &&
                valueMayBeReadAfter(id, i, name) && !hasFutureNonNilWrite(id, i, name) &&
                cleanupReachedOnAllPaths(id, i, name);
            // A storage binding that survives a conditional join must already
            // exist before entering that conditional. If the same physical
            // register is written on a branch before any active binding exists,
            // that write belongs to an earlier/later TEMP epoch, not to this
            // persistent source lifetime. Only a marker-free definition may
            // start the persistent binding; stable branch-local epochs retain
            // their separate path-scoped proof.
            const startsPersistentStorage = persistentStorageRegs.has(name) && markers.length === 0;
            if ((startsPersistentStorage || stableStorageEpoch) && !hasActiveLocal(name, env)) {
                const display = `v${++valueCount}`;
                accumulatorRegs.delete(name);
                const declaration = `local ${display} = ${value}`;
                if (markers.length !== 0) {
                    pathLocalBindingNames.add(display);
                    effects = [...effects, declaration];
                } else {
                    localNames.set(name, display);
                    locals.add(name);
                    out.push(declaration);
                }
                env.set(name, display);
                continue;
            }

            const conditionalIfLocalHandoff = allowConditionalIf && cleanupRegs.has(name) && !hasActiveLocal(name, env) &&
                isIdentifier(rhs, stateName) && block.transition.kind === "branch" && block.transition.conditionRegister === name;
            if (conditionalIfLocalHandoff) accumulatorRegs.delete(name);
            if (cleanupRegs.has(name) && !accumulatorRegs.has(name) && !hasActiveLocal(name, env) && isIdentifier(rhs) && rhs.name !== name) {
                const display = rhs?.type === "TableConstructorExpression" ? `t${++tableCount}` : `v${++valueCount}`;
                localNames.set(name, display);
                locals.add(name);
                out.push(`local ${display} = ${value}`);
                env.set(name, display);
            } else if (hasActiveLocal(name, env)) {
                const line = `${activeLocalDisplay(name, env)} = ${value}`;
                if (markers.length !== 0) {
                    if (!allowConditionalIf) return null;
                    effects = [...effects, line];
                } else {
                    out.push(line);
                }
                env.set(name, activeLocalDisplay(name, env));
            } else {
                env.set(name, value);
            }
        }

        processed.add(id);
        const tr = block.transition;
        const sends = [];
        if (tr.kind === "stop") {
            if (terminalReturnLine === null) return null;
            terminalCandidates.push({
                env: new Map(env),
                markers: [...markers],
                effects: [...effects, terminalReturnLine],
                terminal: true,
            });
            if (!collapseTerminalCandidates()) return null;
        } else if (tr.kind === "jump") sends.push({ target: tr.target, env, markers, effects });
        else if (tr.kind === "branch") {
            const condition = resolveId(tr.conditionRegister, env);
            if (condition == null) return null;
            const effectCount = effects.length;
            sends.push({ target: tr.onTrue, env, markers: [...markers, { condition, truth: true, effectCount, branchId: id }], effects });
            sends.push({ target: tr.onFalse, env, markers: [...markers, { condition, truth: false, effectCount, branchId: id }], effects });
        }
        for (const send of sends) {
            if (!incoming.has(send.target)) incoming.set(send.target, []);
            incoming.get(send.target).push({
                env: new Map(send.env),
                markers: [...(send.markers || [])],
                effects: [...(send.effects || [])],
            });
            indegree.set(send.target, indegree.get(send.target) - 1);
            if (indegree.get(send.target) === 0) ready.push(send.target);
        }
    }

    if (!collapseTerminalCandidates()) return null;
    if (terminalCandidates.length !== 1 || (terminalCandidates[0].markers || []).length !== 0) return null;
    const terminalEffects = [...(terminalCandidates[0].effects || [])];
    // Compiler fallthrough and an explicit empty return share the same final VM
    // bookkeeping.  At root terminal scope a trailing bare return is therefore
    // not provably source-authored; omit only that final redundant marker.
    if (terminalEffects[terminalEffects.length - 1] === "return") terminalEffects.pop();
    for (const effect of terminalEffects) out.push(effect);
    for (const name of terminalLiveLocals) {
        locals.delete(name);
        localNames.delete(name);
    }
    if (processed.size !== reachable.size || locals.size !== 0 || out.length === 0) return null;
    if (allowConditionalIf && conditionalIfCount < 1) {
        if (!out.some(line => /^if\s/.test(line))) return null;
        conditionalIfCount = 1;
    }
    return {
        source: out.join("\n") + "\n",
        statementCount: out.length,
        localCount: valueCount + tableCount,
        stateCount: rootReachableOnly ? logicalReduction.originalReachableStateIds.size : originalLeaves.size,
        reachableStateIds: [...logicalReduction.originalReachableStateIds],
        conditionalIfCount,
    };
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

    const simpleIf = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, { allowConditionalIf: true });
    if (simpleIf) {
        return {
            applied: true,
            mode: "fresh-simple-if",
            source: simpleIf.source,
            stateCount: simpleIf.stateCount,
            statementCount: simpleIf.statementCount,
            branchCount: 1,
            localCount: simpleIf.localCount,
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
