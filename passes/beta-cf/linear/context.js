"use strict";

const { isIdentifier, isSingleAssignment } = require("../ast");

function createLinearContext(source, leaf, stateName, returnName, options = {}) {
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
    return {
        source, leaf, stateName, returnName, options,
        INIT_READ, INDEX_DEST_READ, WRITE, NIL_WRITE,
        findNextFutureEvent, hasFutureDirectPromotionStart,
        futureEvents, cleanupRegs, nonNilDefinitionCount, nilDefinitionCount, firstNilDefinitionIndex,
        directPromotionStartIndices, directPromotionStartsByRegister,
        expr, exprKinds, exprMeta, locals, localNames, out,
        declaredCount, valueLocalCount, tableLocalCount, nextPackOrder,
        pendingPacks, packCreationOrder, sawReturnReset, sawStop, terminalReturnLine,
        consumedPackRegs, upvalueCells, predeclaredNilLocals,
        deferredStorageCopies, deferredTerminalClosureCopies, deferredTerminalUnusedCopies,
        deferredUpvalueClosureStores, deferredLiveTableCopies,
        terminalClosureLocals, terminalUnusedLocals, terminalAliasLocals,
        terminalTableLocals, terminalNilLocals, plainTableLocals,
        deferredSourceLines, deferredLocalBarriers,
    };
}

module.exports = { createLinearContext };
