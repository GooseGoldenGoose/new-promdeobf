"use strict";

const {
    canonicalizeInitialSimpleLocals,
    isEmptyTable,
    isIdentifier,
    isLuaIdentifier,
    isPrimitiveLiteral,
    isSingleAssignment,
    isVmRegisterName,
    renderTableFields,
    renderUnary,
    sourceOf,
} = require("../ast");

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

module.exports = { matchLocalRegisterProgram };
