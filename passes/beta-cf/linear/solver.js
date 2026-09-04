"use strict";

const { createLinearContext } = require("./context");
const { nodeUsesIdentifier, valueUsedBeforeOverwrite, hasLaterNilAssignment, hasOnlyDeadCopyUses, isTerminalUnreadEpoch, nodeUsesAsCallBase, isTerminalStableUsedEpoch, findFutureTerminalUnusedCopy, findFutureTerminalClosureCopy, findFutureUpvalueClosureStore, isPurePendingTempRhs, rhsDependsOnPendingPack, rhsUsesPendingPackSourceLocal, hasFuturePendingPackSlotBeforeStateTouch, isDeadPurePendingTemp, hasFutureReassignedLocalUse, findFutureLiveTableCopy, isDeadPlainTableIndexRead, countIdentifierUses, isUniqueFutureTableOperand, isPlainTableMethodLoad, findFutureCleanupCopy, isPosPreservationCopy } = require("./lifetime");
const { localName, emitSourceLine, allocateLocal, reserveLocal, canPredeclareNilLocal, predeclareNilReads } = require("./bindings");
const { reservePendingPackDisplayNamesThrough, flushPendingPacks } = require("./packs");
const { memberMeta, renderCallArg, renderRhs } = require("./render");
const { canonicalizeInitialSimpleLocals, isEmptyTable, isIdentifier, isLuaIdentifier, isPrimitiveLiteral, isSingleAssignment, isVmRegisterName, sourceOf } = require("../ast");

function matchLocalRegisterProgram(source, leaf, stateName, returnName, options = {}) {
    const ctx = createLinearContext(source, leaf, stateName, returnName, options);
    if (!ctx) return null;
    for (let index = 0; index < ctx.leaf.length; index++) {
        const statement = ctx.leaf[index];
        if (ctx.options.diagnostics) { ctx.options.diagnostics.statementIndex = index; ctx.options.diagnostics.statement = sourceOf(ctx.source, statement) || statement?.type || "unknown"; }
        if (!isSingleAssignment(statement)) return null;
        const dest = statement.variables[0], rhs = statement.init[0];
        predeclareNilReads(ctx, rhs, index);
        if (dest?.type === "IndexExpression" && isIdentifier(dest.base, "upvalueValues") && isIdentifier(dest.index)) {
            if (!ctx.upvalueCells.has(dest.index.name)) return null;
            const deferredTemp = ctx.deferredUpvalueClosureStores.get(dest.index.name);
            if (deferredTemp != null) {
                if (!isIdentifier(rhs, deferredTemp) || typeof ctx.upvalueCells.get(dest.index.name) !== "string") return null;
                ctx.deferredUpvalueClosureStores.delete(dest.index.name);
                continue;
            }
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string" || typeof ctx.upvalueCells.get(dest.index.name) === "string") return null;
            const displayName = `v${++ctx.valueLocalCount}`;
            ctx.upvalueCells.set(dest.index.name, displayName);
            ctx.out.push(`local ${displayName} = ${value}`);
            ctx.declaredCount++;
            continue;
        }
        if (dest?.type === "IndexExpression" && isIdentifier(dest.base) && isIdentifier(dest.index)) {
            const key = renderRhs(ctx, dest.index);
            const value = renderRhs(ctx, rhs);
            if (typeof key !== "string" || typeof value !== "string") return null;
            const fieldName = /^"[A-Za-z_][A-Za-z0-9_]*"$/.test(key) ? key.slice(1, -1) : null;
            if (dest.base.name === "_env") {
                if (!fieldName || !isLuaIdentifier(fieldName)) return null;
                ctx.out.push(`${fieldName} = ${value}`);
                continue;
            }
            const base = renderRhs(ctx, dest.base);
            const baseMeta = ctx.exprMeta.get(dest.base.name);
            const stableBase = ctx.locals.has(dest.base.name) || ctx.exprKinds.get(dest.base.name) === "table" || baseMeta?.kind === "member";
            if (typeof base !== "string" || !stableBase) return null;
            const target = fieldName && isLuaIdentifier(fieldName) ? `${base}.${fieldName}` : `${base}[${key}]`;
            emitSourceLine(ctx, `${target} = ${value}`, [dest.base.name]);
            continue;
        }
        if (!isIdentifier(dest)) return null;
        const name = dest.name;
        const isPackIndex = rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && ctx.exprKinds.get(rhs.base.name) === "return-pack" && rhs.index?.type === "NumericLiteral";
        const isPackSlotCopy = isIdentifier(rhs) && ctx.exprKinds.get(rhs.name) === "pack-slot";
        const returnPackFields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
        const isReturnPackCreation = returnPackFields.length === 1 && returnPackFields[0]?.type === "TableValue" && returnPackFields[0].value?.type === "CallExpression";
        const isDeferredStorageCopy = isIdentifier(rhs) && ctx.deferredStorageCopies.get(name) === rhs.name;
        const isDeferredTerminalClosureCopy = isIdentifier(rhs) && ctx.deferredTerminalClosureCopies.get(name) === rhs.name;
        const isDeferredTerminalUnusedCopy = isIdentifier(rhs) && ctx.deferredTerminalUnusedCopies.get(name) === rhs.name;
        const isDeadRegisterCopy = isIdentifier(rhs) && name !== ctx.stateName && name !== ctx.returnName && !ctx.cleanupRegs.has(name) && hasOnlyDeadCopyUses(ctx, index, name);
        const isKnownUpvalueRead = rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "upvalueValues") && isIdentifier(rhs.index) && typeof ctx.upvalueCells.get(rhs.index.name) === "string";
        const isStableGlobalLoad = ctx.pendingPacks.size > 0 && isVmRegisterName(name) && rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index) && typeof ctx.expr.get(rhs.index.name) === "string" && !rhsDependsOnPendingPack(ctx, rhs.index);
        const isBorrowedStateGlobalLoadBeforePackSlot = ctx.pendingPacks.size > 0 && name === ctx.stateName && rhs?.type === "IndexExpression" && isIdentifier(rhs.base, "_env") && isIdentifier(rhs.index) && typeof ctx.expr.get(rhs.index.name) === "string" && !rhsDependsOnPendingPack(ctx, rhs.index) && hasFuturePendingPackSlotBeforeStateTouch(ctx, index);
        const isUpvalueAllocation = rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0 && name !== ctx.stateName && name !== ctx.returnName && !ctx.upvalueCells.has(name);
        const releaseArgs = rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue") ? (rhs.arguments || []) : null;
        const isKnownUpvalueRelease = releaseArgs?.length === 1 && isIdentifier(releaseArgs[0], name) && name !== ctx.stateName && name !== ctx.returnName && ctx.upvalueCells.has(name);
        const isCallExpression = rhs?.type === "CallExpression";
        const isClosureCreation = isCallExpression && isIdentifier(rhs.base) && /^createClosure\d*$/.test(rhs.base.name);
        const cleanupFutureLocal = isCallExpression ? findFutureCleanupCopy(ctx, index, name) : null;
        const terminalClosureFutureLocal = isClosureCreation && !cleanupFutureLocal ? findFutureTerminalClosureCopy(ctx, index, name) : null;
        const upvalueClosureFutureCell = isClosureCreation && !cleanupFutureLocal && !terminalClosureFutureLocal ? findFutureUpvalueClosureStore(ctx, index, name) : null;
        const terminalUnusedFutureLocal = !cleanupFutureLocal && !terminalClosureFutureLocal && !upvalueClosureFutureCell ? findFutureTerminalUnusedCopy(ctx, index, name) : null;
        const callFutureLocal = cleanupFutureLocal || terminalClosureFutureLocal || terminalUnusedFutureLocal;
        const terminalUnusedValueFutureLocal = !isCallExpression && !isPackIndex && !isPackSlotCopy && isPurePendingTempRhs(ctx, rhs) && !isReturnPackCreation ? findFutureTerminalUnusedCopy(ctx, index, name) : null;
        const directTerminalUnusedValue = !isCallExpression && !isPackIndex && !isPackSlotCopy && !terminalUnusedValueFutureLocal && isVmRegisterName(name) && !ctx.cleanupRegs.has(name) && isPurePendingTempRhs(ctx, rhs) && !isReturnPackCreation && isTerminalUnreadEpoch(ctx, index, name);
        const isTerminalUsedTransportAlias = isVmRegisterName(name) && !ctx.cleanupRegs.has(name) && !ctx.locals.has(name) && isIdentifier(rhs) &&
            (rhs.name === ctx.stateName || rhs.name === ctx.returnName) && !isPackSlotCopy && isTerminalStableUsedEpoch(ctx, index, name);
        const terminalUsedAliasPackBarrier = isTerminalUsedTransportAlias && ctx.pendingPacks.size ? Math.max(...[...ctx.pendingPacks.values()].map(pack => pack.order)) : 0;
        const isDeferredTerminalUsedAlias = isTerminalUsedTransportAlias && terminalUsedAliasPackBarrier > 0;
        const callResultIsDiscarded = isCallExpression && hasOnlyDeadCopyUses(ctx, index, name);
        const callPackBarrier = isCallExpression && ctx.pendingPacks.size ? Math.max(...[...ctx.pendingPacks.values()].map(pack => pack.order)) : 0;
        const hasTrackedPackBarrier = callPackBarrier > 0;
        const isClosureTableOperand = isClosureCreation && isUniqueFutureTableOperand(ctx, index, name);
        const callUsesPendingPackSourceLocal = isCallExpression && rhsUsesPendingPackSourceLocal(ctx, rhs);
        const isDeferredClosureCreation = isClosureCreation && !callUsesPendingPackSourceLocal && (!!callFutureLocal || !!upvalueClosureFutureCell || isClosureTableOperand) && hasTrackedPackBarrier;
        const isDeferredOrdinaryCall = isCallExpression && !isClosureCreation && !callUsesPendingPackSourceLocal && hasTrackedPackBarrier && (!!callFutureLocal || callResultIsDiscarded);
        const terminalUnusedValuePackBarrier = terminalUnusedValueFutureLocal && ctx.pendingPacks.size ? Math.max(...[...ctx.pendingPacks.values()].map(pack => pack.order)) : 0;
        const isDeferredTerminalUnusedValue = !!terminalUnusedValueFutureLocal && terminalUnusedValuePackBarrier > 0;
        // Table ctx.source-storage ownership is independent of pending return packs.
        // A pending pack only changes when the recovered source line may be emitted.
        const liveTableFutureLocal = findFutureLiveTableCopy(ctx, index, name, rhs);
        const isLiveTableHandoff = !!liveTableFutureLocal;
        const isDeadPureTemp = ctx.pendingPacks.size > 0 && !isLiveTableHandoff && isDeadPurePendingTemp(ctx, index, name, rhs);
        const isStablePrimitiveTemp = ctx.pendingPacks.size > 0 && isPrimitiveLiteral(rhs) && name !== ctx.stateName && !ctx.cleanupRegs.has(name);
        const isUnusedPlainTableReadLocal = rhs?.type === "IndexExpression" && isIdentifier(rhs.base) && ctx.plainTableLocals.has(rhs.base.name) && isVmRegisterName(name) && !ctx.cleanupRegs.has(name) && isTerminalUnreadEpoch(ctx, index, name) && !rhsDependsOnPendingPack(ctx, rhs);
        const isDeadPlainTableRead = ctx.pendingPacks.size > 0 && !isUnusedPlainTableReadLocal && isDeadPlainTableIndexRead(ctx, index, name, rhs);
        const isPlainTableNamecallLoad = ctx.pendingPacks.size > 0 && isPlainTableMethodLoad(ctx, index, name, rhs);
        const liveTablePackBarrier = isLiveTableHandoff && ctx.pendingPacks.size > 0 ? Math.max(...[...ctx.pendingPacks.values()].map(pack => pack.order)) : 0;
        const isDeferredLiveTable = isLiveTableHandoff && liveTablePackBarrier > 0;
        const isDeferredLiveTableCopy = isIdentifier(rhs) && ctx.deferredLiveTableCopies.get(rhs.name) === name;
        const isPendingNeutralBookkeeping =
            (isIdentifier(rhs, "args") && name !== ctx.stateName && name !== ctx.returnName) ||
            (rhs?.type === "NilLiteral" && ctx.cleanupRegs.has(name)) ||
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
        if (ctx.pendingPacks.size && !isPackIndex && !isPackSlotCopy && !isReturnPackCreation && !isPendingNeutralBookkeeping && !flushPendingPacks(ctx)) return null;

        if (ctx.directPromotionStartIndices.has(index) && !ctx.locals.has(name) && !isPackIndex) {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const kind = rhs?.type === "TableConstructorExpression" ? "table" : "value";
            const displayName = allocateLocal(ctx, name, kind);
            ctx.out.push(`local ${displayName} = ${value}`);
            if (kind === "table") ctx.plainTableLocals.add(name);
            continue;
        }

        if (isUnusedPlainTableReadLocal) {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const displayName = allocateLocal(ctx, name, "value");
            emitSourceLine(ctx, `local ${displayName} = ${value}`, [rhs.base.name]);
            ctx.terminalUnusedLocals.add(name);
            continue;
        }

        if (isDeadPlainTableRead) {
            ctx.expr.delete(name); ctx.exprKinds.delete(name); ctx.exprMeta.delete(name);
            continue;
        }

        if (isDeferredLiveTableCopy) {
            ctx.deferredLiveTableCopies.delete(rhs.name);
            ctx.expr.set(name, localName(ctx, name));
            ctx.exprKinds.set(name, "table");
            continue;
        }

        if (isDeferredStorageCopy || isDeferredTerminalClosureCopy || isDeferredTerminalUnusedCopy) {
            if (isDeferredStorageCopy) ctx.deferredStorageCopies.delete(name);
            else if (isDeferredTerminalClosureCopy) ctx.deferredTerminalClosureCopies.delete(name);
            else ctx.deferredTerminalUnusedCopies.delete(name);
            if (!ctx.locals.has(name)) return null;
            let displayName = localName(ctx, name);
            if (isDeferredStorageCopy && isPackSlotCopy) {
                const meta = ctx.exprMeta.get(rhs.name);
                const pendingPack = meta ? ctx.pendingPacks.get(meta.packReg) : null;
                if (pendingPack && meta) {
                    const slotInfo = pendingPack.slots.get(meta.slot);
                    if (!slotInfo || slotInfo.localReg !== name) return null;
                    if (meta.slot === 1) {
                        displayName = reservePendingPackDisplayNamesThrough(ctx, pendingPack, meta.slot);
                        if (typeof displayName !== "string") return null;
                        ctx.localNames.set(name, displayName);
                    }
                }
            }
            ctx.expr.set(name, displayName);
            ctx.exprKinds.set(name, "value");
            continue;
        }

        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "allocUpvalue") && (rhs.arguments || []).length === 0) {
            if (name === ctx.stateName || name === ctx.returnName || ctx.upvalueCells.has(name)) return null;
            ctx.upvalueCells.set(name, null);
            continue;
        }
        if (rhs?.type === "CallExpression" && isIdentifier(rhs.base, "releaseUpvalue")) {
            const args = rhs.arguments || [];
            if (args.length !== 1 || !isIdentifier(args[0]) || args[0].name !== name || !ctx.upvalueCells.has(name)) return null;
            ctx.upvalueCells.delete(name);
            continue;
        }
        if (isIdentifier(rhs, "args") && name !== ctx.stateName && name !== ctx.returnName && !ctx.locals.has(name)) {
            ctx.expr.set(name, "args"); ctx.exprKinds.set(name, "value"); continue;
        }
        if (name === ctx.returnName && rhs?.type === "TableConstructorExpression" && (rhs.fields || []).length > 0) {
            const next = ctx.leaf[index + 1];
            if (index === ctx.leaf.length - 1 || (isSingleAssignment(next, ctx.stateName) && next.init[0]?.type === "NilLiteral")) {
                const values = [];
                for (const field of rhs.fields || []) {
                    if (field?.type !== "TableValue") return null;
                    const value = renderRhs(ctx, field.value);
                    if (typeof value !== "string") return null;
                    values.push(value);
                }
                ctx.terminalReturnLine = values.length ? `return ${values.join(", ")}` : "return";
                ctx.sawReturnReset = true;
                if (index === ctx.leaf.length - 1) ctx.sawStop = true;
                continue;
            }
        }
        if (name === ctx.returnName && isEmptyTable(rhs) && !valueUsedBeforeOverwrite(ctx, index, ctx.returnName)) { ctx.sawReturnReset = true; continue; }
        if (name === ctx.stateName && rhs?.type === "NilLiteral") {
            if (valueUsedBeforeOverwrite(ctx, index, ctx.stateName)) {
                ctx.expr.set(ctx.stateName, "nil"); ctx.exprKinds.set(ctx.stateName, "value"); continue;
            }
            ctx.sawStop = true; continue;
        }
        if (ctx.cleanupRegs.has(name) && rhs?.type === "NilLiteral") {
            if (!ctx.locals.has(name)) {
                // Prometheus uses nil for both semantic ctx.source values and dead/temporary register state.
                // Preserve a nil lifetime only when this exact definition reaches a read before overwrite.
                // Otherwise the definition is unobservable and may be dropped; a later meaningful write can
                // still establish the ctx.source lifetime through the normal cleanup-backed promotion rules.
                if (!valueUsedBeforeOverwrite(ctx, index, name)) {
                    const nonNilDefs = ctx.nonNilDefinitionCount.get(name) || 0;
                    // A nil-only VAR lifetime has a compiler-emitted nil value plus a later scope-end nil.
                    // Ordinary TEMP registers are freed internally and do not receive that cleanup write.
                    if (nonNilDefs === 0 && hasLaterNilAssignment(ctx, index, name)) {
                        const displayName = allocateLocal(ctx, name, "value");
                        ctx.out.push(`local ${displayName}`);
                        continue;
                    }
                    if (nonNilDefs === 0 && (ctx.nilDefinitionCount.get(name) || 0) === 1 && isVmRegisterName(name) && isTerminalUnreadEpoch(ctx, index, name)) {
                        const displayName = allocateLocal(ctx, name, "value");
                        ctx.out.push(`local ${displayName}`);
                        ctx.terminalUnusedLocals.add(name);
                        continue;
                    }
                    // Multiple meaningful definitions before cleanup cannot prove where VAR ownership began.
                    if (nonNilDefs > 1) return null;
                    // Unowned nil bookkeeping remains removable only when it cannot prove a ctx.source lifetime.
                    continue;
                }
                const displayName = allocateLocal(ctx, name, "value");
                ctx.out.push(`local ${displayName}`);
                if ((ctx.nonNilDefinitionCount.get(name) || 0) === 0 && !hasLaterNilAssignment(ctx, index, name)) {
                    let futureReads = 0;
                    for (let probe = index + 1; probe < ctx.leaf.length; probe++) {
                        const later = ctx.leaf[probe];
                        futureReads += countIdentifierUses(ctx, later?.init, name);
                        const laterDest = isSingleAssignment(later) ? later.variables[0] : null;
                        if (laterDest?.type === "IndexExpression") futureReads += countIdentifierUses(ctx, laterDest, name);
                        if (isIdentifier(laterDest, name)) break;
                    }
                    if (futureReads >= 2) ctx.terminalNilLocals.add(name);
                }
                continue;
            }
            if (ctx.predeclaredNilLocals.has(name) && hasLaterNilAssignment(ctx, index, name)) continue;
            ctx.predeclaredNilLocals.delete(name);
            ctx.locals.delete(name); ctx.expr.delete(name); ctx.exprKinds.delete(name); ctx.exprMeta.delete(name); ctx.localNames.delete(name); continue;
        }

        if (isPackIndex) {
            const rendered = renderRhs(ctx, rhs);
            if (!rendered?.packSlot) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = `pack index lost provenance at statement ${index}`; return null; }
            if (ctx.consumedPackRegs.has(rendered.packReg)) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = `pack ${rendered.packReg} was already consumed before slot ${rendered.slot}`; return null; }
            let pendingPack = ctx.pendingPacks.get(rendered.packReg);
            if (!pendingPack) {
                pendingPack = { packReg: rendered.packReg, call: rendered.call, slots: new Map(), order: ctx.packCreationOrder.get(rendered.packReg) ?? ++ctx.nextPackOrder };
                ctx.pendingPacks.set(rendered.packReg, pendingPack);
            }
            if (pendingPack.call !== rendered.call) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = `pack ${rendered.packReg} call provenance changed`; return null; }
            if (pendingPack.slots.has(rendered.slot)) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = `pack ${rendered.packReg} slot ${rendered.slot} was extracted twice`; return null; }
            const slotInfo = { tempReg: name, localReg: null, displayName: null, extractionIndex: index };
            pendingPack.slots.set(rendered.slot, slotInfo);
            ctx.expr.set(name, rendered.call); ctx.exprKinds.set(name, "pack-slot"); ctx.exprMeta.set(name, { packReg: rendered.packReg, slot: rendered.slot });
            if (ctx.cleanupRegs.has(name)) {
                // The slot can already be the ctx.source VAR register. Reserve its
                // local ownership without erasing pack-slot provenance; later
                // consumers must still know this value depends on the pending
                // compiler return pack until flushPendingPacks(ctx) maps the slot
                // to its recovered local display name.
                reserveLocal(ctx, name, true);
                slotInfo.localReg = name;
            } else {
                const futureLocal = findFutureCleanupCopy(ctx, index, name);
                const terminalFutureLocal = !futureLocal ? findFutureTerminalUnusedCopy(ctx, index, name) : null;
                if (futureLocal) {
                    reserveLocal(ctx, futureLocal, futureLocal === rendered.packReg);
                    slotInfo.localReg = futureLocal;
                    ctx.deferredStorageCopies.set(futureLocal, name);
                } else if (terminalFutureLocal) {
                    reserveLocal(ctx, terminalFutureLocal, terminalFutureLocal === rendered.packReg);
                    ctx.terminalUnusedLocals.add(terminalFutureLocal);
                    slotInfo.localReg = terminalFutureLocal;
                    ctx.deferredTerminalUnusedCopies.set(terminalFutureLocal, name);
                } else if (isVmRegisterName(name) && isTerminalUnreadEpoch(ctx, index, name)) {
                    reserveLocal(ctx, name, true);
                    ctx.terminalUnusedLocals.add(name);
                    slotInfo.localReg = name;
                }
            }
            continue;
        }

        if (ctx.cleanupRegs.has(name) && !ctx.hasFutureDirectPromotionStart(index, name) && !ctx.locals.has(name) && isPackSlotCopy) {
            const meta = ctx.exprMeta.get(rhs.name);
            const pendingPack = meta ? ctx.pendingPacks.get(meta.packReg) : null;
            if (!meta || !pendingPack) return null;
            const slotInfo = pendingPack.slots.get(meta.slot);
            if (!slotInfo || slotInfo.localReg) return null;
            reserveLocal(ctx, name); slotInfo.localReg = name; continue;
        }

        if (ctx.cleanupRegs.has(name) && !ctx.hasFutureDirectPromotionStart(index, name) && !ctx.locals.has(name) && isPosPreservationCopy(ctx, index, name, rhs)) {
            const value = ctx.expr.get(ctx.stateName);
            if (typeof value !== "string") return null;
            ctx.expr.set(name, value);
            ctx.exprKinds.set(name, "value");
            continue;
        }

        if (ctx.cleanupRegs.has(name) && !ctx.hasFutureDirectPromotionStart(index, name) && !ctx.locals.has(name) && isIdentifier(rhs) && rhs.name !== name) {
            const value = ctx.expr.get(rhs.name) ?? (ctx.locals.has(rhs.name) ? localName(ctx, rhs.name) : null);
            if (typeof value !== "string") return null;
            const kind = ctx.exprKinds.get(rhs.name) || "value";
            const displayName = allocateLocal(ctx, name, kind);
            ctx.out.push(value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`); continue;
        }

        if (ctx.cleanupRegs.has(name) && !ctx.hasFutureDirectPromotionStart(index, name) && !ctx.locals.has(name) && ctx.nonNilDefinitionCount.get(name) === 1) {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const kind = rhs?.type === "TableConstructorExpression" ? "table" : "value";
            const displayName = allocateLocal(ctx, name, kind);
            ctx.out.push(`local ${displayName} = ${value}`);
            continue;
        }

        if (ctx.locals.has(name)) {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            emitSourceLine(ctx, `${localName(ctx, name)} = ${value}`, [name]); ctx.expr.set(name, localName(ctx, name));
            ctx.exprKinds.set(name, rhs?.type === "TableConstructorExpression" ? "table" : "value"); continue;
        }

        if (isTerminalUsedTransportAlias) {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const kind = ctx.exprKinds.get(rhs.name) === "table" ? "table" : "value";
            const displayName = allocateLocal(ctx, name, kind);
            const sourceLine = value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`;
            if (isDeferredTerminalUsedAlias) ctx.deferredSourceLines.push({ line: sourceLine, afterPackOrder: terminalUsedAliasPackBarrier });
            else ctx.out.push(sourceLine);
            ctx.terminalAliasLocals.add(name);
            continue;
        }

        if (terminalUnusedValueFutureLocal || directTerminalUnusedValue) {
            const futureLocal = terminalUnusedValueFutureLocal || name;
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const kind = rhs?.type === "TableConstructorExpression" ? "table" : "value";
            const displayName = allocateLocal(ctx, futureLocal, kind);
            const sourceLine = value === "nil" ? `local ${displayName}` : `local ${displayName} = ${value}`;
            if (isDeferredTerminalUnusedValue) ctx.deferredSourceLines.push({ line: sourceLine, afterPackOrder: terminalUnusedValuePackBarrier });
            else ctx.out.push(sourceLine);
            ctx.terminalUnusedLocals.add(futureLocal);
            if (terminalUnusedValueFutureLocal) ctx.deferredTerminalUnusedCopies.set(futureLocal, name);
            ctx.expr.set(name, displayName);
            ctx.exprKinds.set(name, kind);
            continue;
        }

        if (isLiveTableHandoff) {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const wasLocal = ctx.locals.has(liveTableFutureLocal);
            const displayName = wasLocal ? localName(ctx, liveTableFutureLocal) : allocateLocal(ctx, liveTableFutureLocal, "table");
            const sourceLine = wasLocal ? `${displayName} = ${value}` : `local ${displayName} = ${value}`;
            if (!wasLocal) ctx.terminalTableLocals.add(liveTableFutureLocal);
            ctx.plainTableLocals.add(liveTableFutureLocal);
            if (isDeferredLiveTable) {
                if (!wasLocal) ctx.deferredLocalBarriers.set(liveTableFutureLocal, liveTablePackBarrier);
                ctx.deferredSourceLines.push({ line: sourceLine, afterPackOrder: liveTablePackBarrier, declaresReg: wasLocal ? null : liveTableFutureLocal });
            } else {
                ctx.out.push(sourceLine);
            }
            ctx.deferredLiveTableCopies.set(name, liveTableFutureLocal);
            ctx.expr.set(name, displayName);
            ctx.exprKinds.set(name, "table");
            continue;
        }

        if (rhs?.type === "CallExpression") {
            const value = renderRhs(ctx, rhs);
            if (typeof value !== "string") return null;
            const futureLocal = callFutureLocal;
            if (upvalueClosureFutureCell) {
                if (ctx.upvalueCells.get(upvalueClosureFutureCell) !== null) return null;
                const displayName = `v${++ctx.valueLocalCount}`;
                ctx.upvalueCells.set(upvalueClosureFutureCell, displayName);
                const sourceLine = `local ${displayName} = ${value}`;
                if (isDeferredClosureCreation && ctx.pendingPacks.size) ctx.deferredSourceLines.push({ line: sourceLine, afterPackOrder: callPackBarrier });
                else ctx.out.push(sourceLine);
                ctx.deferredUpvalueClosureStores.set(upvalueClosureFutureCell, name);
                ctx.declaredCount++;
            } else if (futureLocal) {
                const sourceLine = ctx.locals.has(futureLocal)
                    ? `${allocateLocal(ctx, futureLocal, "value")} = ${value}`
                    : `local ${allocateLocal(ctx, futureLocal, "value")} = ${value}`;
                if ((isDeferredClosureCreation || isDeferredOrdinaryCall) && ctx.pendingPacks.size) ctx.deferredSourceLines.push({ line: sourceLine, afterPackOrder: callPackBarrier });
                else ctx.out.push(sourceLine);
                if (ctx.cleanupRegs.has(futureLocal)) ctx.deferredStorageCopies.set(futureLocal, name);
                else if (terminalClosureFutureLocal === futureLocal) { ctx.deferredTerminalClosureCopies.set(futureLocal, name); ctx.terminalClosureLocals.add(futureLocal); }
                else if (terminalUnusedFutureLocal === futureLocal) { ctx.deferredTerminalUnusedCopies.set(futureLocal, name); ctx.terminalUnusedLocals.add(futureLocal); }
            } else if (callResultIsDiscarded) {
                if (isDeferredOrdinaryCall && ctx.pendingPacks.size) ctx.deferredSourceLines.push({ line: value, afterPackOrder: callPackBarrier });
                else ctx.out.push(value);
            }
            ctx.expr.set(name, value); ctx.exprKinds.set(name, "value"); continue;
        }

        const value = renderRhs(ctx, rhs);
        if (value === null) {
            const next = ctx.leaf[index + 1];
            if (!ctx.locals.has(name) && !ctx.cleanupRegs.has(name) && isSingleAssignment(next, name)) {
                ctx.expr.delete(name); ctx.exprKinds.delete(name); ctx.exprMeta.delete(name); continue;
            }
            return null;
        }
        if (typeof value !== "string") return null;
        const member = memberMeta(ctx, rhs);
        ctx.expr.set(name, value);
        if (member) ctx.exprMeta.set(name, member); else ctx.exprMeta.delete(name);
        const fields = rhs?.type === "TableConstructorExpression" ? (rhs.fields || []) : [];
        const isReturnPack = fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "CallExpression";
        ctx.exprKinds.set(name, isReturnPack ? "return-pack" : (rhs?.type === "TableConstructorExpression" ? "table" : "value"));
        if (isReturnPack && !ctx.packCreationOrder.has(name)) ctx.packCreationOrder.set(name, ++ctx.nextPackOrder);
    }

    if (!flushPendingPacks(ctx)) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "final pending multi-return pack flush failed"; return null; }
    if (ctx.options.allowNoLocals !== true && ctx.declaredCount === 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "no proven source locals were recovered"; return null; }
    if (ctx.options.allowNoLocals === true && (!ctx.sawReturnReset || !ctx.sawStop)) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = `terminal bookkeeping incomplete: return=${ctx.sawReturnReset}, stop=${ctx.sawStop}`; return null; }
    if (ctx.deferredTerminalClosureCopies.size !== 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "terminal closure handoff copy was not consumed"; return null; }
    if (ctx.deferredTerminalUnusedCopies.size !== 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "terminal unused-local handoff copy was not consumed"; return null; }
    if (ctx.deferredUpvalueClosureStores.size !== 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "upvalue closure handoff store was not consumed"; return null; }
    if (ctx.deferredLiveTableCopies.size !== 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "live table handoff copy was not consumed"; return null; }
    for (const reg of ctx.terminalClosureLocals) ctx.locals.delete(reg);
    for (const reg of ctx.terminalUnusedLocals) ctx.locals.delete(reg);
    for (const reg of ctx.terminalAliasLocals) ctx.locals.delete(reg);
    for (const reg of ctx.terminalTableLocals) ctx.locals.delete(reg);
    for (const reg of ctx.terminalNilLocals) ctx.locals.delete(reg);
    if (ctx.locals.size !== 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = `recovered locals still live at terminal: ${[...ctx.locals].join(",")}`; return null; }
    if (ctx.terminalReturnLine !== null) ctx.out.push(ctx.terminalReturnLine);
    if (ctx.out.length === 0) { if (ctx.options.diagnostics) ctx.options.diagnostics.reason = "recovered program emitted no source statements"; return null; }
    const canonicalOut = canonicalizeInitialSimpleLocals(ctx.out);
    return { source: canonicalOut.join("\n") + "\n", statementCount: canonicalOut.length, localCount: ctx.declaredCount };
}

module.exports = { matchLocalRegisterProgram };
