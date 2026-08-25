const { findVmFunction } = require("./vm-state");
const { findVmReturnRegister, findRegisterDeclaration, findRegisterOverflowBinding } = require("./vm-register-names");
const { applyTextEdits } = require("./text-edits");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    const value = typeof node.value === "number" ? node.value : Number(node.raw);
    return Number.isInteger(value) ? value : null;
}

function prepareOverflowAsScalarRegisters(source, ast, parseLuaStructural) {
    const vm = findVmFunction(ast);
    if (!vm) return { source, ast, applied: false, slots: [], reason: "VM function not found" };

    const fn = vm.functionNode;
    const overflow = findRegisterOverflowBinding(fn);
    if (!overflow) return { source, ast, applied: false, slots: [], reason: "No proven RegisterOverflow binding" };

    const returnRegister = findVmReturnRegister(fn);
    const scalar = returnRegister ? findRegisterDeclaration(fn, returnRegister.name) : null;
    if (!scalar) return { source, ast, applied: false, slots: [], reason: "Scalar register declaration not found" };

    const slots = [...overflow.indices]
        .sort((a, b) => a - b)
        .map((slot, index) => ({ slot, dense: index + 1, physical: `__overflow_phys_${index + 1}` }));
    const bySlot = new Map(slots.map(item => [item.slot, item]));
    const byPhysical = new Map(slots.map(item => [item.physical, item]));
    const edits = [];
    let references = 0;
    let error = null;

    function walk(node) {
        if (!isNode(node) || error) return;
        if (node.type === "IndexExpression" && isIdentifier(node.base, overflow.name)) {
            const slot = numericValue(node.index);
            const info = slot === null ? null : bySlot.get(slot);
            if (!info || !Array.isArray(node.range)) {
                error = "Overflow scalarization encountered a non-static/unproven slot";
                return;
            }
            edits.push({ start: node.range[0], end: node.range[1], replacement: info.physical });
            references++;
            return;
        }
        for (const key of Object.keys(node)) {
            if (key === "loc" || key === "range") continue;
            const value = node[key];
            if (Array.isArray(value)) for (const child of value) walk(child);
            else if (isNode(value)) walk(value);
        }
    }

    const body = fn.body || [];
    const overflowIndex = body.indexOf(overflow.declaration);
    if (overflowIndex < 0) return { source, ast, applied: false, slots, reason: "Overflow declaration is not in VM body" };
    for (let i = overflowIndex + 1; i < body.length; i++) walk(body[i]);
    if (error) return { source, ast, applied: false, slots, reason: error };
    if (references !== overflow.referenceCount) {
        return { source, ast, applied: false, slots, reason: `Overflow reference mismatch ${references}/${overflow.referenceCount}` };
    }

    const scalarText = source.slice(scalar.statement.range[0], scalar.statement.range[1]);
    edits.push({
        start: scalar.statement.range[0],
        end: scalar.statement.range[1],
        replacement: `${scalarText}, ${slots.map(item => item.physical).join(", ")}`,
    });
    edits.push({
        start: overflow.declaration.range[0],
        end: overflow.declaration.range[1],
        replacement: "",
    });

    const nextSource = applyTextEdits(source, edits);
    const nextAst = parseLuaStructural(nextSource, "<overflow scalarization>");
    return { source: nextSource, ast: nextAst, applied: true, slots, bySlot, byPhysical, references };
}

function makeNameRewriter(map) {
    if (!map.size) return text => String(text || "");
    const keys = [...map.keys()].sort((a, b) => b.length - a.length);
    const escaped = keys.map(name => name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"));
    const pattern = new RegExp(`\\b(?:${escaped.join("|")})\\b`, "g");
    return text => String(text || "").replace(pattern, name => map.get(name) || name);
}

function remapOverflowBetaVersions(beta, prepared) {
    if (!prepared.applied) {
        beta.overflow = { applied: false, slots: [] };
        return beta;
    }

    const versionsByPhysical = new Map(prepared.slots.map(info => [info.physical, []]));
    for (const version of beta.versions || []) {
        const list = versionsByPhysical.get(version.originalName);
        if (list) list.push(version);
    }

    const oldToNew = new Map();
    const rows = [];
    for (const info of prepared.slots) {
        const versions = versionsByPhysical.get(info.physical) || [];
        if (!versions.length) throw new Error(`Overflow slot ${info.slot} produced no beta versions`);
        const seen = new Set();
        for (const version of versions) {
            if (seen.has(version.newName)) continue;
            seen.add(version.newName);
            const newName = `o_v${info.dense}_${version.version}`;
            const prior = oldToNew.get(version.newName);
            if (prior && prior !== newName) throw new Error(`Overflow version ${version.newName} remaps ambiguously`);
            oldToNew.set(version.newName, newName);
            rows.push({
                slot: info.slot,
                dense: info.dense,
                version: version.version,
                oldName: version.newName,
                newName,
                state: version.blockState,
            });
        }
    }

    const rewrite = makeNameRewriter(oldToNew);

    // beta is a fresh analysis result and the caller never uses the pre-remap
    // presentation again. Rewrite presentation fields in place instead of cloning
    // the whole state/operation/epoch graph. Keep analysis identity metadata such
    // as originalTarget/originalRegister unchanged: those still name the synthetic
    // physical register and are required by later structural proofs.
    for (const state of beta.graph.states || []) {
        for (const operation of state.operations || []) {
            if (typeof operation.emittedTarget === "string") operation.emittedTarget = oldToNew.get(operation.emittedTarget) || operation.emittedTarget;
            if (Array.isArray(operation.emittedTargets)) {
                for (let index = 0; index < operation.emittedTargets.length; index++) {
                    const name = operation.emittedTargets[index];
                    operation.emittedTargets[index] = oldToNew.get(name) || name;
                }
            }
            if (Array.isArray(operation.reads)) {
                for (let index = 0; index < operation.reads.length; index++) {
                    const name = operation.reads[index];
                    operation.reads[index] = oldToNew.get(name) || name;
                }
            }
            if (typeof operation.rhs === "string") operation.rhs = rewrite(operation.rhs);
            if (typeof operation.emittedText === "string") operation.emittedText = rewrite(operation.emittedText);
            if (Array.isArray(operation.returnExpressions)) {
                for (let index = 0; index < operation.returnExpressions.length; index++) {
                    operation.returnExpressions[index] = rewrite(operation.returnExpressions[index]);
                }
            }
        }
    }

    for (const epoch of beta.graph.epochs || []) {
        epoch.name = oldToNew.get(epoch.name) || epoch.name;
        for (const event of epoch.events || []) {
            if (typeof event.text === "string") event.text = rewrite(event.text);
        }
    }
    beta.graph.overflowScalarVersions = true;
    beta.graph.overflowSlots = Object.fromEntries(prepared.slots.map(item => [item.slot, item.dense]));

    beta.source = rewrite(beta.source);
    for (const version of beta.versions || []) {
        version.newName = oldToNew.get(version.newName) || version.newName;
    }
    for (const item of beta.mapping || []) {
        const info = prepared.byPhysical.get(item.originalName);
        if (!info) continue;
        item.originalName = `RegisterOverflow[${info.slot}]`;
        item.baseName = `o_v${info.dense}`;
    }
    beta.overflow = { applied: true, slots: prepared.slots, rows };
    return beta;
}

module.exports = { prepareOverflowAsScalarRegisters, remapOverflowBetaVersions };
