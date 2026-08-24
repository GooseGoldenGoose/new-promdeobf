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
    const nextAst = parseLuaStructural(nextSource, "<experimental overflow scalarization>");
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
    if (!prepared.applied) return { ...beta, experimentalOverflow: { applied: false, slots: [] } };

    const oldToNew = new Map();
    const rows = [];
    for (const info of prepared.slots) {
        const versions = (beta.versions || []).filter(item => item.originalName === info.physical);
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
    const physicalNames = new Set(prepared.slots.map(item => item.physical));
    function remapOperation(operation) {
        const next = { ...operation };
        if (typeof next.emittedTarget === "string") next.emittedTarget = oldToNew.get(next.emittedTarget) || next.emittedTarget;
        if (Array.isArray(next.emittedTargets)) next.emittedTargets = next.emittedTargets.map(name => oldToNew.get(name) || name);
        if (Array.isArray(next.reads)) next.reads = next.reads.map(name => oldToNew.get(name) || name);
        if (typeof next.rhs === "string") next.rhs = rewrite(next.rhs);
        if (typeof next.emittedText === "string") next.emittedText = rewrite(next.emittedText);
        if (Array.isArray(next.returnExpressions)) next.returnExpressions = next.returnExpressions.map(rewrite);
        if (physicalNames.has(next.originalTarget)) {
            next.originalTarget = `o_phys${prepared.byPhysical.get(next.originalTarget).dense}`;
        }
        return next;
    }

    const graph = {
        ...beta.graph,
        states: (beta.graph.states || []).map(state => ({ ...state, operations: (state.operations || []).map(remapOperation) })),
        epochs: (beta.graph.epochs || []).map(epoch => ({
            ...epoch,
            name: oldToNew.get(epoch.name) || epoch.name,
            originalRegister: physicalNames.has(epoch.originalRegister)
                ? `o_phys${prepared.byPhysical.get(epoch.originalRegister).dense}`
                : epoch.originalRegister,
            events: (epoch.events || []).map(event => ({ ...event, text: rewrite(event.text) })),
        })),
        experimentalOverflowScalarVersions: true,
        experimentalOverflowSlots: Object.fromEntries(prepared.slots.map(item => [item.slot, item.dense])),
    };

    return {
        ...beta,
        source: rewrite(beta.source),
        graph,
        versions: (beta.versions || []).map(version => ({ ...version, newName: oldToNew.get(version.newName) || version.newName })),
        mapping: (beta.mapping || []).map(item => {
            const info = prepared.byPhysical.get(item.originalName);
            return info ? { ...item, originalName: `RegisterOverflow[${info.slot}]`, baseName: `o_v${info.dense}` } : item;
        }),
        experimentalOverflow: { applied: true, slots: prepared.slots, rows },
    };
}

module.exports = { prepareOverflowAsScalarRegisters, remapOverflowBetaVersions };
