"use strict";

const {
    decodeJsonStringLiteral,
    isEmptyTable,
    isIdentifier,
    isLuaIdentifier,
    isPrimitiveLiteral,
    isSingleAssignment,
    renderTableFields,
    renderUnary,
    sourceOf,
} = require("./ast");
const { extractNormalizedStateLeaves } = require("./normalize");
const { flattenLogicalRootLeaf } = require("./logical");
const { matchLocalRegisterProgram } = require("./linear/solver");
const { matchMultiStateLogicalLocals } = require("./structured/solver");
const { matchCompilerWhileProgram } = require("./control/while");

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

        // A captured closure may be created before the compiler writes the
        // first value into one of its freshly allocated cells. Prometheus can
        // then hand that closure through state/ReturnVal into an ordinary TEMP.
        // Preserve the deferred closure object across that compiler transport;
        // resolve it only at its first semantic use, after the cell binding has
        // been initialized. This is not a source alias promotion.
        if (isIdentifier(rhs) && (rhs.name === stateName || rhs.name === returnName)) {
            const deferredClosure = env.get(rhs.name);
            if (deferredClosure?.kind === "captured-closure") {
                env.set(name, deferredClosure);
                envMeta.delete(name);
                continue;
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

function matchClosureEntryProgram(source, stateWhile, stateName, returnName, diagnostics = null) {
    const leaves = extractNormalizedStateLeaves(stateWhile, stateName);
    if (!leaves || leaves.size < 2 || !leaves.has(1)) return null;
    const consumedEntries = new Set();
    const renderedClosureEntries = new Set();
    const renderingEntries = new Set();

    function restoreConsumedEntries(stateSnapshot, closureSnapshot) {
        for (const id of [...consumedEntries]) if (!stateSnapshot.has(id)) consumedEntries.delete(id);
        for (const id of [...renderedClosureEntries]) if (!closureSnapshot.has(id)) renderedClosureEntries.delete(id);
    }

    function renderClosureCall(call, captureNames = null) {
        if (call?.type !== "CallExpression" || !isIdentifier(call.base) || !/^createClosure\d*$/.test(call.base.name)) return null;
        const args = call.arguments || [];
        if (args.length !== 2 || args[0]?.type !== "NumericLiteral" || args[1]?.type !== "TableConstructorExpression") return null;
        const fields = args[1].fields || [];
        if (captureNames === null && fields.length !== 0) return null;
        if (captureNames instanceof Map && fields.length !== captureNames.size) return null;
        const entryId = Number(args[0].value);
        if (!Number.isInteger(entryId) || entryId === 1 || consumedEntries.has(entryId) || renderingEntries.has(entryId)) return null;
        const childLeaf = leaves.get(entryId);
        if (!childLeaf) return null;

        const snapshot = new Set(consumedEntries);
        const closureSnapshot = new Set(renderedClosureEntries);
        renderingEntries.add(entryId);
        let rendered = renderSimpleClosureLeaf(source, childLeaf, stateName, returnName, {
            renderSpecialCall: renderClosureCall,
            renderCapturedCall: renderClosureCall,
            captureNames: captureNames instanceof Map ? captureNames : undefined,
        });
        if (rendered) {
            consumedEntries.add(entryId);
            renderedClosureEntries.add(entryId);
            renderingEntries.delete(entryId);
            return rendered;
        }

        restoreConsumedEntries(snapshot, closureSnapshot);
        const childOptions = {
            allowConditionalIf: true,
            rootReachableOnly: true,
            entryId,
            captureNames: captureNames instanceof Map ? captureNames : undefined,
            renderAsFunction: true,
            renderSpecialCall: renderClosureCall,
            renderCapturedCall: renderClosureCall,
        };
        const loopStructured = matchCompilerWhileProgram(source, stateWhile, stateName, returnName, childOptions);
        if (loopStructured) {
            const childStates = loopStructured.reachableStateIds || [];
            const overlaps = childStates.some(id => snapshot.has(id));
            if (!overlaps && childStates.includes(entryId)) {
                for (const id of childStates) consumedEntries.add(id);
                renderedClosureEntries.add(entryId);
                renderingEntries.delete(entryId);
                return loopStructured.source;
            }
        }

        restoreConsumedEntries(snapshot, closureSnapshot);
        const structured = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, childOptions);
        if (structured) {
            const childStates = structured.reachableStateIds || [];
            const overlaps = childStates.some(id => snapshot.has(id));
            if (!overlaps && childStates.includes(entryId)) {
                for (const id of childStates) consumedEntries.add(id);
                renderedClosureEntries.add(entryId);
                renderingEntries.delete(entryId);
                return structured.source;
            }
        }

        restoreConsumedEntries(snapshot, closureSnapshot);
        renderingEntries.delete(entryId);
        return null;
    }

    // Root CFGs that contain both a proven while region and child closures
    // must use the same transactional closure renderer as child-entry while
    // recovery. Otherwise createClosureN calls inside the loop body are seen
    // as ordinary calls and the while path fails before child states can be
    // consumed. Keep this attempt isolated so a failed loop proof cannot
    // contaminate the ordinary structured/legacy closure paths below.
    const rootSnapshot = new Set(consumedEntries);
    const rootClosureSnapshot = new Set(renderedClosureEntries);
    const loopProgram = matchCompilerWhileProgram(source, stateWhile, stateName, returnName, {
        allowConditionalIf: true,
        rootReachableOnly: true,
        renderSpecialCall: renderClosureCall,
        renderCapturedCall: renderClosureCall,
    });
    if (loopProgram && consumedEntries.size > 0) {
        const accounted = new Set([...(loopProgram.reachableStateIds || []), ...consumedEntries]);
        if (accounted.size === leaves.size && [...leaves.keys()].every(id => accounted.has(id))) {
            return { ...loopProgram, stateCount: leaves.size, closureCount: renderedClosureEntries.size };
        }
    }
    restoreConsumedEntries(rootSnapshot, rootClosureSnapshot);

    // Mixed root CFGs may contain logical-value regions feeding real
    // if/elseif/else branches. Recover them with the structural multi-state
    // solver instead of requiring the whole closure root to flatten into one
    // logical leaf. Only root-reachable states participate in its lifetime
    // proof; createClosureN calls render/consume separate child entries.
    const structuredProgram = matchMultiStateLogicalLocals(source, stateWhile, stateName, returnName, {
        allowConditionalIf: true,
        rootReachableOnly: true,
        renderSpecialCall: renderClosureCall,
        renderCapturedCall: renderClosureCall,
    });
    if (structuredProgram && consumedEntries.size > 0) {
        const accounted = new Set([...(structuredProgram.reachableStateIds || []), ...consumedEntries]);
        if (accounted.size === leaves.size && [...leaves.keys()].every(id => accounted.has(id))) {
            return { ...structuredProgram, stateCount: leaves.size, closureCount: renderedClosureEntries.size };
        }
    }

    // Legacy closure path remains for roots that are entirely reducible to a
    // flattened logical/register-local leaf, including existing capture cases.
    consumedEntries.clear();
    renderedClosureEntries.clear();
    const rootDiagnostics = {};
    const flattenedRoot = flattenLogicalRootLeaf(leaves, 1, stateName, returnName, rootDiagnostics);
    for (const id of (flattenedRoot ? flattenedRoot.consumed : [1])) consumedEntries.add(id);
    const root = flattenedRoot?.leaf || leaves.get(1);
    const rootProgramDiagnostics = {};
    const program = matchLocalRegisterProgram(source, root, stateName, returnName, { renderSpecialCall: renderClosureCall, renderCapturedCall: renderClosureCall, diagnostics: rootProgramDiagnostics, allowNoLocals: true });
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
    return { ...program, stateCount: leaves.size, closureCount: renderedClosureEntries.size };
}

module.exports = { renderSimpleClosureLeaf, matchClosureEntryProgram };
