const { findVmFunction } = require("./vm-state");
const { applyTextEdits } = require("./text-edits");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function findVmReturnRegister(vmFunction) {
    const body = vmFunction?.body || [];
    if (body.length === 0) return null;
    const statement = body[body.length - 1];
    if (statement?.type !== "ReturnStatement") return null;
    const values = statement.arguments || [];
    if (values.length !== 1 || values[0]?.type !== "CallExpression") return null;
    const call = values[0];
    const args = call.arguments || [];
    if (!isIdentifier(call.base, "unpack") || args.length !== 1 || !isIdentifier(args[0])) return null;
    return { statement, call, identifier: args[0], name: args[0].name };
}

function findRegisterDeclaration(vmFunction, returnName) {
    const matches = [];
    const body = vmFunction?.body || [];
    for (let index = 0; index < body.length; index++) {
        const statement = body[index];
        if (statement?.type !== "LocalStatement") continue;
        if ((statement.init || []).length !== 0) continue;
        const variables = statement.variables || [];
        if (!variables.length || !variables.every(variable => isIdentifier(variable))) continue;
        if (!variables.some(variable => variable.name === returnName)) continue;
        matches.push({ statement, index, variables });
    }
    return matches.length === 1 ? matches[0] : null;
}

function collectShadowingDeclarations(node, candidateNames, candidateDeclaration, out = []) {
    if (!isNode(node)) return out;
    if (node !== candidateDeclaration) {
        if (node.type === "LocalStatement") {
            for (const variable of node.variables || []) {
                if (isIdentifier(variable) && candidateNames.has(variable.name)) {
                    out.push({ kind: "local", name: variable.name, node: variable });
                }
            }
        }
        if (node.type === "FunctionDeclaration") {
            for (const parameter of node.parameters || []) {
                if (isIdentifier(parameter) && candidateNames.has(parameter.name)) {
                    out.push({ kind: "parameter", name: parameter.name, node: parameter });
                }
            }
            if (node.isLocal && isIdentifier(node.identifier) && candidateNames.has(node.identifier.name)) {
                out.push({ kind: "local-function", name: node.identifier.name, node: node.identifier });
            }
        }
        if (node.type === "ForNumericStatement" && isIdentifier(node.variable) && candidateNames.has(node.variable.name)) {
            out.push({ kind: "for", name: node.variable.name, node: node.variable });
        }
        if (node.type === "ForGenericStatement") {
            for (const variable of node.variables || []) {
                if (isIdentifier(variable) && candidateNames.has(variable.name)) {
                    out.push({ kind: "for", name: variable.name, node: variable });
                }
            }
        }
    }

    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectShadowingDeclarations(child, candidateNames, candidateDeclaration, out);
        } else if (isNode(value)) {
            collectShadowingDeclarations(value, candidateNames, candidateDeclaration, out);
        }
    }
    return out;
}

function collectReservedNames(node, candidateNames, out = new Set(), parent = null, parentKey = null) {
    if (!isNode(node)) return out;
    if (node.type === "Identifier") {
        const isProperty =
            (parent?.type === "MemberExpression" && parentKey === "identifier") ||
            (parent?.type === "TableKeyString" && parentKey === "key");
        if (!isProperty && !candidateNames.has(node.name)) out.add(node.name);
        return out;
    }
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectReservedNames(child, candidateNames, out, node, key);
        } else if (isNode(value)) {
            collectReservedNames(value, candidateNames, out, node, key);
        }
    }
    return out;
}

function collectRenameEdits(node, mapping, minOffset, out = [], parent = null, parentKey = null) {
    if (!isNode(node)) return out;
    if (node.type === "Identifier") {
        if (!Array.isArray(node.range) || node.range[0] < minOffset) return out;
        const isProperty =
            (parent?.type === "MemberExpression" && parentKey === "identifier") ||
            (parent?.type === "TableKeyString" && parentKey === "key");
        if (!isProperty && mapping.has(node.name)) {
            out.push({
                start: node.range[0],
                end: node.range[1],
                replacement: mapping.get(node.name),
                oldName: node.name,
            });
        }
        return out;
    }

    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) collectRenameEdits(child, mapping, minOffset, out, node, key);
        } else if (isNode(value)) {
            collectRenameEdits(value, mapping, minOffset, out, node, key);
        }
    }
    return out;
}

function renameVmRegisterBindings(source, ast) {
    const vm = findVmFunction(ast);
    if (!vm) {
        return { source, found: false, applied: false, reason: "No semantically named vm function was found", mapping: [] };
    }

    const vmFunction = vm.functionNode;
    const returnRegister = findVmReturnRegister(vmFunction);
    if (!returnRegister) {
        return { source, found: true, applied: false, reason: "VM does not end with return unpack(<register>)", mapping: [] };
    }

    const declaration = findRegisterDeclaration(vmFunction, returnRegister.name);
    if (!declaration) {
        return { source, found: true, applied: false, reason: "Could not uniquely identify the scalar VM register declaration", mapping: [] };
    }

    const candidateNames = new Set(declaration.variables.map(variable => variable.name));
    if (candidateNames.size !== declaration.variables.length) {
        return { source, found: true, applied: false, reason: "VM register declaration contains duplicate names", mapping: [] };
    }

    const shadows = collectShadowingDeclarations(vmFunction, candidateNames, declaration.statement, []);
    if (shadows.length > 0) {
        return {
            source,
            found: true,
            applied: false,
            reason: `VM register binding ${shadows[0].name} is shadowed by a nested ${shadows[0].kind} declaration`,
            mapping: [],
        };
    }

    const reservedNames = collectReservedNames(vmFunction, candidateNames);
    if (reservedNames.has("ReturnVal") && returnRegister.name !== "ReturnVal") {
        return { source, found: true, applied: false, reason: "ReturnVal collides with another VM-scope identifier", mapping: [] };
    }
    if (candidateNames.has("ReturnVal") && returnRegister.name !== "ReturnVal") {
        return { source, found: true, applied: false, reason: "ReturnVal is already used by a different VM register", mapping: [] };
    }

    const mapping = new Map();
    mapping.set(returnRegister.name, "ReturnVal");

    let nextRegisterNumber = 1;
    for (const variable of declaration.variables) {
        if (variable.name === returnRegister.name) continue;
        let replacement;
        do {
            replacement = `r${nextRegisterNumber++}`;
        } while (reservedNames.has(replacement) || (candidateNames.has(replacement) && replacement !== variable.name));
        mapping.set(variable.name, replacement);
    }

    const edits = collectRenameEdits(vmFunction, mapping, declaration.statement.range[0], []);
    if (edits.length === 0) {
        return { source, found: true, applied: false, reason: "No VM register rename edits were produced", mapping: [] };
    }

    const counts = new Map();
    for (const edit of edits) counts.set(edit.oldName, (counts.get(edit.oldName) || 0) + 1);
    for (const oldName of mapping.keys()) {
        if (!counts.has(oldName)) {
            return { source, found: true, applied: false, reason: `VM register ${oldName} had no renameable occurrences`, mapping: [] };
        }
    }

    const output = applyTextEdits(source, edits);
    const mappingList = declaration.variables.map(variable => ({
        oldName: variable.name,
        newName: mapping.get(variable.name),
        kind: variable.name === returnRegister.name ? "return" : "register",
        referencesRenamed: counts.get(variable.name) || 0,
    }));

    return {
        source: output,
        found: true,
        applied: output !== source,
        returnRegisterOldName: returnRegister.name,
        returnRegisterName: "ReturnVal",
        registerCount: declaration.variables.length,
        temporaryRegisterCount: declaration.variables.length - 1,
        mapping: mappingList,
        edits,
    };
}

module.exports = {
    findVmReturnRegister,
    findRegisterDeclaration,
    renameVmRegisterBindings,
};
