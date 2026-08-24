const { findEnvironmentBinding, renameFunctionParameterBinding } = require("./environment");
const { analyzeClosureFactory } = require("./closure-factory");
const { renameFunctionParameterBindingsBatch } = require("./batch-parameter-rename");

function isNode(value) { return value && typeof value === "object" && typeof value.type === "string"; }
function isIdentifier(node, name = null) { return node?.type === "Identifier" && (name === null || node.name === name); }
function numericValue(node) { if (node?.type !== "NumericLiteral") return null; if (typeof node.value === "number") return node.value; const value = Number(String(node.raw ?? "").replace(/[()]/g, "")); return Number.isFinite(value) ? value : null; }
function stringValue(node) { if (node?.type !== "StringLiteral") return null; const raw = String(node.raw ?? ""); if (raw.length < 2) return null; const quote = raw[0]; if ((quote !== '"' && quote !== "'") || raw[raw.length - 1] !== quote) return null; try { if (quote === '"') return JSON.parse(raw); } catch {} return raw.slice(1, -1).replace(/\\(['"\\])/g, "$1").replace(/\\n/g, "\n").replace(/\\r/g, "\r").replace(/\\t/g, "\t"); }
function walk(node, visitor) {
    if (!isNode(node)) return;
    visitor(node);
    for (const key of Object.keys(node)) {
        if (key === "loc" || key === "range") continue;
        const value = node[key];
        if (Array.isArray(value)) {
            for (const child of value) walk(child, visitor);
        } else if (isNode(value)) {
            walk(value, visitor);
        }
    }
}
function collectIdentifierNames(node) { const names = new Set(); walk(node, child => { if (isIdentifier(child)) names.add(child.name); }); return names; }
function indexBaseName(node) { return node?.type === "IndexExpression" && isIdentifier(node.base) ? node.base.name : null; }
function indexStringKey(node) { return node?.type === "IndexExpression" ? stringValue(node.index) : null; }

function findHelperAssignment(wrapperFn) {
    const parameterByName = new Map((wrapperFn.parameters || []).filter(parameter => isIdentifier(parameter)).map(parameter => [parameter.name, parameter]));
    const candidates = [];
    for (const statement of wrapperFn.body || []) {
        if (statement?.type !== "AssignmentStatement") continue;
        const variables = statement.variables || [], values = statement.init || [];
        if (variables.length < 4 || values.length < 4) continue;
        const entries = []; let closureFactoryCount = 0;
        for (let index = 0; index < Math.min(variables.length, values.length); index++) {
            const lhs = variables[index], value = values[index];
            if (!isIdentifier(lhs)) continue;
            const parameter = parameterByName.get(lhs.name); if (!parameter) continue;
            const closure = value?.type === "FunctionDeclaration" ? analyzeClosureFactory(value) : null;
            if (closure) closureFactoryCount++;
            entries.push({ name: lhs.name, parameter, value, index, closure });
        }
        if (closureFactoryCount > 0 && entries.length >= 4) candidates.push({ statement, entries, parameterByName });
    }
    return candidates.length === 1 ? candidates[0] : null;
}

function findGcCallbackName(proxyFn) {
    const names = new Set();
    walk(proxyFn, node => {
        if (node.type === "AssignmentStatement") {
            const variables = node.variables || [], values = node.init || [];
            for (let i = 0; i < Math.min(variables.length, values.length); i++) if (indexStringKey(variables[i]) === "__gc" && isIdentifier(values[i])) names.add(values[i].name);
        }
        if (node.type === "TableKey" && stringValue(node.key) === "__gc" && isIdentifier(node.value)) names.add(node.value.name);
    });
    return names.size === 1 ? [...names][0] : null;
}
function sameIndexBase(node, name) { return node?.type === "IndexExpression" && isIdentifier(node.base, name); }
function findIncrementedTableName(fn) {
    const candidates = new Set();
    walk(fn, node => {
        if (node.type !== "AssignmentStatement") return;
        const vars = node.variables || [], init = node.init || [];
        if (vars.length !== 1 || init.length !== 1) return;
        const baseName = indexBaseName(vars[0]); if (!baseName) return;
        const expression = init[0]; if (expression?.type !== "BinaryExpression" || expression.operator !== "+") return;
        const leftIsSame = sameIndexBase(expression.left, baseName), rightIsSame = sameIndexBase(expression.right, baseName);
        const leftOne = numericValue(expression.left) === 1, rightOne = numericValue(expression.right) === 1;
        if ((leftIsSame && rightOne) || (rightIsSame && leftOne)) candidates.add(baseName);
    });
    return candidates.size === 1 ? [...candidates][0] : null;
}
function findNilClearedTables(fn) {
    const names = new Set();
    walk(fn, node => {
        if (node.type !== "AssignmentStatement") return;
        const vars = node.variables || [], init = node.init || [];
        if (vars.length !== init.length || vars.length < 2 || !init.every(value => value?.type === "NilLiteral")) return;
        for (const variable of vars) { const baseName = indexBaseName(variable); if (baseName) names.add(baseName); }
    });
    return names;
}
function functionHasSubtractOne(fn, tableName) { let found = false; walk(fn, node => { if (found || node.type !== "BinaryExpression" || node.operator !== "-") return; if ((sameIndexBase(node.left, tableName) && numericValue(node.right) === 1) || (sameIndexBase(node.right, tableName) && numericValue(node.left) === 1)) found = true; }); return found; }
function findReleaseUpvalueEntry(entries, refCountsName, valuesName, excludedNames) {
    const candidates = entries.filter(entry => { if (excludedNames.has(entry.name) || entry.value?.type !== "FunctionDeclaration" || (entry.value.parameters || []).length !== 1) return false; const names = collectIdentifierNames(entry.value); if (!names.has(refCountsName) || !names.has(valuesName) || !functionHasSubtractOne(entry.value, refCountsName)) return false; const cleared = findNilClearedTables(entry.value); return cleared.has(refCountsName) && cleared.has(valuesName); });
    return candidates.length === 1 ? candidates[0] : null;
}
function analyzeAllocator(fn, refCountsName) {
    if (fn?.type !== "FunctionDeclaration" || (fn.parameters || []).length !== 0) return null;
    const returnNames = new Set();
    for (const statement of fn.body || []) if (statement?.type === "ReturnStatement" && (statement.arguments || []).length === 1 && isIdentifier(statement.arguments[0])) returnNames.add(statement.arguments[0].name);
    if (returnNames.size !== 1) return null;
    const idName = [...returnNames][0]; let incrementsId = false, initializesRefCount = false;
    walk(fn, node => {
        if (node.type !== "AssignmentStatement") return;
        const vars = node.variables || [], init = node.init || [];
        for (let i = 0; i < Math.min(vars.length, init.length); i++) {
            const variable = vars[i], value = init[i];
            if (isIdentifier(variable, idName) && value?.type === "BinaryExpression" && value.operator === "+" && ((isIdentifier(value.left, idName) && numericValue(value.right) === 1) || (isIdentifier(value.right, idName) && numericValue(value.left) === 1))) incrementsId = true;
            if (variable?.type === "IndexExpression" && isIdentifier(variable.base, refCountsName) && isIdentifier(variable.index, idName) && numericValue(value) === 1) initializesRefCount = true;
        }
    });
    return incrementsId && initializesRefCount ? { idName } : null;
}
function findAllocatorEntry(entries, refCountsName, excludedNames) { const candidates = []; for (const entry of entries) { if (excludedNames.has(entry.name) || entry.value?.type !== "FunctionDeclaration") continue; const analysis = analyzeAllocator(entry.value, refCountsName); if (analysis) candidates.push({ entry, ...analysis }); } return candidates.length === 1 ? candidates[0] : null; }

function builtinArgumentKind(node) {
    if (isIdentifier(node)) { if (["newproxy", "setmetatable", "getmetatable", "select", "unpack"].includes(node.name) && node.isLocal !== true) return node.name; return null; }
    if (node?.type !== "LogicalExpression" || node.operator !== "or") return null;
    const isGlobalUnpack = part => isIdentifier(part, "unpack") && part.isLocal !== true;
    const isTableUnpack = part => (part?.type === "IndexExpression" && isIdentifier(part.base, "table") && part.base.isLocal !== true && stringValue(part.index) === "unpack") || (part?.type === "MemberExpression" && isIdentifier(part.base, "table") && part.base.isLocal !== true && isIdentifier(part.identifier, "unpack"));
    return ((isGlobalUnpack(node.left) && isTableUnpack(node.right)) || (isTableUnpack(node.left) && isGlobalUnpack(node.right))) ? "unpack" : null;
}

function analyzeVmHelperBindings(ast) {
    const envCandidate = findEnvironmentBinding(ast);
    if (!envCandidate || envCandidate.ambiguous) return { found: false, reason: "No unique Prometheus environment wrapper was found" };
    const wrapperFn = envCandidate.fn, helperAssignment = findHelperAssignment(wrapperFn);
    if (!helperAssignment) return { found: false, reason: "No unique Prometheus VM helper assignment was found" };
    const entries = helperAssignment.entries, entryByName = new Map(entries.map(entry => [entry.name, entry])), closureEntries = entries.filter(entry => entry.closure);
    if (closureEntries.length === 0) return { found: false, reason: "No closure factories were found in the VM helper assignment" };
    const vmNames = new Set(closureEntries.map(entry => entry.closure.vmIdentifier.name)), proxyNames = new Set(closureEntries.map(entry => entry.closure.proxyFactoryIdentifier.name));
    if (vmNames.size !== 1 || proxyNames.size !== 1) return { found: false, reason: "Closure factories do not agree on VM/proxy helper bindings" };
    const vmName = [...vmNames][0], proxyName = [...proxyNames][0], vmEntry = entryByName.get(vmName), proxyEntry = entryByName.get(proxyName);
    if (vmEntry?.value?.type !== "FunctionDeclaration" || proxyEntry?.value?.type !== "FunctionDeclaration") return { found: false, reason: "VM or upvalue proxy helper is not initialized by a function" };
    const releaseUpvaluesName = findGcCallbackName(proxyEntry.value), releaseUpvaluesEntry = releaseUpvaluesName ? entryByName.get(releaseUpvaluesName) : null, refCountsName = findIncrementedTableName(proxyEntry.value);
    let valuesName = null;
    if (releaseUpvaluesEntry?.value?.type === "FunctionDeclaration" && refCountsName) { const cleared = findNilClearedTables(releaseUpvaluesEntry.value); const others = [...cleared].filter(name => name !== refCountsName); if (others.length === 1) valuesName = others[0]; }
    const excluded = new Set([vmName, proxyName, ...(releaseUpvaluesName ? [releaseUpvaluesName] : []), ...closureEntries.map(entry => entry.name)]);
    const releaseUpvalueEntry = refCountsName && valuesName ? findReleaseUpvalueEntry(entries, refCountsName, valuesName, excluded) : null;
    if (releaseUpvalueEntry) excluded.add(releaseUpvalueEntry.name);
    const allocator = refCountsName ? findAllocatorEntry(entries, refCountsName, excluded) : null;
    const roles = new Map();
    const addRole = (role, entry, extra = {}) => { if (entry?.parameter) roles.set(role, { role, fn: wrapperFn, parameter: entry.parameter, assignmentEntry: entry, ...extra }); };
    addRole("vm", vmEntry); addRole("createUpvalueProxy", proxyEntry); if (releaseUpvaluesEntry) addRole("releaseUpvalues", releaseUpvaluesEntry); if (releaseUpvalueEntry) addRole("releaseUpvalue", releaseUpvalueEntry); if (allocator) addRole("allocUpvalue", allocator.entry, { upvalueIdName: allocator.idName });
    if (refCountsName) addRole("upvalueRefCounts", entryByName.get(refCountsName));
    if (valuesName) addRole("upvalueValues", entryByName.get(valuesName));
    if (allocator?.idName) addRole("currentUpvalueId", entryByName.get(allocator.idName));
    const vmParams = vmEntry.value.parameters || [];
    if (vmParams.length >= 4 && vmParams.slice(0, 4).every(parameter => isIdentifier(parameter))) {
        roles.set("state", { role: "state", fn: vmEntry.value, parameter: vmParams[0] });
        roles.set("args", { role: "args", fn: vmEntry.value, parameter: vmParams[1] });
        roles.set("upvalues", { role: "upvalues", fn: vmEntry.value, parameter: vmParams[2] });
        roles.set("gcProxy", { role: "gcProxy", fn: vmEntry.value, parameter: vmParams[3] });
    }
    for (const entry of closureEntries) if (entry.closure.kind === "vararg") addRole("createClosure", entry, { arity: null }); else addRole(`createClosure${entry.closure.arity}`, entry, { arity: entry.closure.arity });
    const args = envCandidate.call.arguments || [], params = wrapperFn.parameters || [];
    for (let index = 0; index < Math.min(args.length, params.length); index++) { const parameter = params[index]; if (!isIdentifier(parameter)) continue; const kind = builtinArgumentKind(args[index]); if (kind) roles.set(kind, { role: kind, fn: wrapperFn, parameter, argumentIndex: index }); }
    return { found: true, wrapperFn, helperAssignment, roles, vmName, proxyName, releaseUpvaluesName, refCountsName, valuesName, allocatorIdName: allocator?.idName ?? null };
}

const ROLE_ORDER = ["unpack", "newproxy", "setmetatable", "getmetatable", "select", "vm", "createUpvalueProxy", "releaseUpvalues", "releaseUpvalue", "allocUpvalue", "upvalueRefCounts", "upvalueValues", "currentUpvalueId", "state", "args", "upvalues", "gcProxy"];
function renameVmHelperBindingsSequential(source, ast, parseSource) {
    let currentSource = source, currentAst = ast; const renamedRoles = [], renamedParameters = [], skippedRoles = [];
    const first = analyzeVmHelperBindings(currentAst);
    if (!first.found) return { source, ast: currentAst, found: false, renamedRoles, renamedParameters, skippedRoles, reason: first.reason };
    const initialClosureRoles = [...first.roles.keys()].filter(role => /^createClosure\d+$/.test(role)).sort((a, b) => Number(a.slice("createClosure".length)) - Number(b.slice("createClosure".length)));
    for (const role of [...ROLE_ORDER, ...initialClosureRoles]) {
        const analysis = analyzeVmHelperBindings(currentAst);
        if (!analysis.found) { skippedRoles.push({ role, reason: analysis.reason }); continue; }
        const candidate = analysis.roles.get(role); if (!candidate || candidate.parameter.name === role) continue;
        const result = renameFunctionParameterBinding(currentSource, candidate, role);
        if (result.collision) { skippedRoles.push({ role, oldName: candidate.parameter.name, reason: result.reason }); continue; }
        currentSource = result.source; renamedRoles.push({ role, oldName: result.oldName, newName: result.newName, referencesRenamed: result.referencesRenamed }); currentAst = parseSource(currentSource, `<after ${role} rename>`);
    }
    function renameRoleParameter(role, index, replacement) {
        const analysis = analyzeVmHelperBindings(currentAst);
        if (!analysis.found) { skippedRoles.push({ role: `${role}.${replacement}`, reason: analysis.reason }); return; }
        const roleInfo = analysis.roles.get(role);
        const fn = roleInfo?.assignmentEntry?.value;
        const parameter = fn?.parameters?.[index];
        if (!isIdentifier(parameter) || parameter.name === replacement) return;
        const result = renameFunctionParameterBinding(currentSource, { fn, parameter }, replacement);
        if (result.collision) { skippedRoles.push({ role: `${role}.${replacement}`, oldName: parameter.name, reason: result.reason }); return; }
        currentSource = result.source;
        renamedParameters.push({ role, index, oldName: result.oldName, newName: result.newName, referencesRenamed: result.referencesRenamed });
        currentAst = parseSource(currentSource, `<after ${role} ${replacement} parameter rename>`);
    }

    renameRoleParameter("releaseUpvalue", 0, "upvalueId");
    renameRoleParameter("createUpvalueProxy", 0, "captures");
    renameRoleParameter("releaseUpvalues", 0, "captures");

    const parameterAnalysis = analyzeVmHelperBindings(currentAst);
    const closureParameterRoles = parameterAnalysis.found
        ? [...parameterAnalysis.roles.keys()].filter(role => role === "createClosure" || /^createClosure\d+$/.test(role))
        : [];
    for (const role of closureParameterRoles) {
        renameRoleParameter(role, 0, "entryId");
        renameRoleParameter(role, 1, "captures");
    }

    const finalAnalysis = analyzeVmHelperBindings(currentAst);
    return { source: currentSource, ast: currentAst, found: true, renamed: renamedRoles.length > 0 || renamedParameters.length > 0, renamedRoles, renamedParameters, skippedRoles, detectedRoles: finalAnalysis.found ? [...finalAnalysis.roles.keys()] : [], refCountsName: finalAnalysis.refCountsName ?? first.refCountsName, valuesName: finalAnalysis.valuesName ?? first.valuesName, allocatorIdName: finalAnalysis.allocatorIdName ?? first.allocatorIdName };
}

function renameVmHelperBindings(source, ast, parseSource, options = {}) {
    let currentSource = source;
    let currentAst = ast;
    const renamedRoles = [];
    const renamedParameters = [];
    const skippedRoles = [];

    const first = analyzeVmHelperBindings(currentAst);
    if (!first.found) {
        return { source, ast: currentAst, found: false, renamedRoles, renamedParameters, skippedRoles, reason: first.reason };
    }

    const initialClosureRoles = [...first.roles.keys()]
        .filter(role => /^createClosure\d+$/.test(role))
        .sort((a, b) => Number(a.slice("createClosure".length)) - Number(b.slice("createClosure".length)));
    const phaseOneRoles = [...ROLE_ORDER, ...initialClosureRoles];
    const requests = [];

    for (const role of phaseOneRoles) {
        const candidate = first.roles.get(role);
        if (!candidate || candidate.parameter.name === role) continue;
        requests.push({
            fn: candidate.fn,
            parameter: candidate.parameter,
            replacementName: role,
            meta: { kind: "role", role },
        });
    }

    const closureParameterRoles = [...first.roles.keys()]
        .filter(role => role === "createClosure" || /^createClosure\d+$/.test(role));
    function requestRoleParameter(role, index, replacement) {
        const roleInfo = first.roles.get(role);
        const fn = roleInfo?.assignmentEntry?.value;
        const parameter = fn?.parameters?.[index];
        if (!isIdentifier(parameter) || parameter.name === replacement) return;
        requests.push({
            fn,
            parameter,
            replacementName: replacement,
            meta: { kind: "parameter", role, index, replacement },
        });
    }

    requestRoleParameter("releaseUpvalue", 0, "upvalueId");
    requestRoleParameter("createUpvalueProxy", 0, "captures");
    requestRoleParameter("releaseUpvalues", 0, "captures");
    for (const role of closureParameterRoles) {
        requestRoleParameter(role, 0, "entryId");
        requestRoleParameter(role, 1, "captures");
    }

    // All role identities and their helper-function parameters are known from the
    // same structural analysis. Rename them in one lexical traversal/source edit
    // batch instead of reparsing between two independent batches.
    const batch = renameFunctionParameterBindingsBatch(currentSource, requests, currentAst);
    if (batch.batchConflict || batch.results.some(result => result.collision)) {
        return renameVmHelperBindingsSequential(source, ast, parseSource);
    }

    for (const result of batch.results) {
        if (result.alreadyNamed || result.edits.length === 0) continue;
        if (result.meta.kind === "role") {
            renamedRoles.push({
                role: result.meta.role,
                oldName: result.oldName,
                newName: result.newName,
                referencesRenamed: result.referencesRenamed,
            });
        } else {
            renamedParameters.push({
                role: result.meta.role,
                index: result.meta.index,
                oldName: result.oldName,
                newName: result.newName,
                referencesRenamed: result.referencesRenamed,
            });
        }
    }

    if (batch.changed) {
        currentSource = batch.source;
        currentAst = options.deferParse === true
            ? null
            : parseSource(currentSource, "<after VM helper rename batch>");
    }

    return {
        source: currentSource,
        ast: currentAst,
        found: true,
        renamed: renamedRoles.length > 0 || renamedParameters.length > 0,
        renamedRoles,
        renamedParameters,
        skippedRoles,
        detectedRoles: [...first.roles.keys()],
        refCountsName: first.roles.has("upvalueRefCounts") ? "upvalueRefCounts" : first.refCountsName,
        valuesName: first.roles.has("upvalueValues") ? "upvalueValues" : first.valuesName,
        allocatorIdName: first.roles.has("currentUpvalueId") ? "currentUpvalueId" : first.allocatorIdName,
        batched: true,
        parseDeferred: options.deferParse === true && batch.changed,
        edits: batch.edits || [],
    };
}

module.exports = { analyzeVmHelperBindings, renameVmHelperBindings };
