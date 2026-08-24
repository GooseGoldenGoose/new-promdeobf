const { renameFunctionParameterBinding } = require("./environment");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function tableContainsVararg(node) {
    if (node?.type !== "TableConstructorExpression") return false;
    return (node.fields || []).some(field =>
        field?.type === "TableValue" && field.value?.type === "VarargLiteral"
    );
}

function tableMatchesParameters(node, parameters) {
    if (node?.type !== "TableConstructorExpression") return false;
    const fields = node.fields || [];
    if (fields.length !== parameters.length) return false;
    for (let index = 0; index < parameters.length; index++) {
        const parameter = parameters[index];
        const field = fields[index];
        if (!isIdentifier(parameter) || field?.type !== "TableValue" || !isIdentifier(field.value, parameter.name)) return false;
    }
    return true;
}

function analyzeReturnedVmCall(fn, entryName, capturesName, proxyName) {
    if (fn?.type !== "FunctionDeclaration") return null;
    if ((fn.body || []).length !== 1 || fn.body[0]?.type !== "ReturnStatement") return null;
    const values = fn.body[0].arguments || [];
    if (values.length !== 1 || values[0]?.type !== "CallExpression") return null;
    const call = values[0];
    const args = call.arguments || [];
    if (args.length !== 4 || !isIdentifier(call.base) || !isIdentifier(args[0], entryName) || !isIdentifier(args[2], capturesName) || !isIdentifier(args[3], proxyName)) return null;
    const parameters = fn.parameters || [];
    if (parameters.length === 1 && parameters[0]?.type === "VarargLiteral") {
        if (!tableContainsVararg(args[1])) return null;
        return { call, kind: "vararg", arity: null };
    }
    if (!parameters.every(parameter => isIdentifier(parameter)) || !tableMatchesParameters(args[1], parameters)) return null;
    return { call, kind: "fixed", arity: parameters.length };
}

function analyzeClosureFactory(fn) {
    if (fn?.type !== "FunctionDeclaration") return null;
    const params = fn.parameters || [];
    if (params.length !== 2 || !isIdentifier(params[0]) || !isIdentifier(params[1])) return null;
    const entryName = params[0].name;
    const capturesName = params[1].name;
    let proxyLocal = null, proxyFactoryIdentifier = null, closureLocal = null, nestedClosure = null, vmCall = null, kind = null, arity = null;
    for (const statement of fn.body || []) {
        if (statement?.type !== "LocalStatement" || (statement.variables || []).length !== 1 || (statement.init || []).length !== 1) continue;
        const variable = statement.variables[0];
        const init = statement.init[0];
        if (isIdentifier(variable) && init?.type === "CallExpression" && isIdentifier(init.base) && (init.arguments || []).length === 1 && isIdentifier(init.arguments[0], capturesName)) {
            proxyLocal = variable.name;
            proxyFactoryIdentifier = init.base;
            continue;
        }
        if (isIdentifier(variable) && init?.type === "FunctionDeclaration" && proxyLocal) {
            const analysis = analyzeReturnedVmCall(init, entryName, capturesName, proxyLocal);
            if (analysis) {
                closureLocal = variable.name;
                nestedClosure = init;
                vmCall = analysis.call;
                kind = analysis.kind;
                arity = analysis.arity;
            }
        }
    }
    if (!proxyLocal || !proxyFactoryIdentifier || !closureLocal || !nestedClosure || !vmCall || !kind) return null;
    const finalStatement = (fn.body || [])[fn.body.length - 1];
    if (finalStatement?.type !== "ReturnStatement" || (finalStatement.arguments || []).length !== 1 || !isIdentifier(finalStatement.arguments[0], closureLocal)) return null;
    return { entryParameter: params[0], capturesParameter: params[1], proxyLocal, proxyFactoryIdentifier, closureLocal, nestedClosure, vmCall, vmIdentifier: vmCall.base, kind, arity };
}

function analyzeVarargClosureFactory(fn) {
    const analysis = analyzeClosureFactory(fn);
    return analysis?.kind === "vararg" ? analysis : null;
}

function findCreateClosureBinding(ast) {
    const candidates = [];
    function walkFunction(fn) {
        const parameters = fn.parameters || [];
        const parameterByName = new Map(parameters.filter(parameter => isIdentifier(parameter)).map(parameter => [parameter.name, parameter]));
        for (const statement of fn.body || []) {
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const values = statement.init || [];
            const count = Math.min(variables.length, values.length);
            for (let index = 0; index < count; index++) {
                const lhs = variables[index], value = values[index];
                if (!isIdentifier(lhs) || value?.type !== "FunctionDeclaration") continue;
                const parameter = parameterByName.get(lhs.name);
                if (!parameter) continue;
                const analysis = analyzeVarargClosureFactory(value);
                if (!analysis) continue;
                candidates.push({ fn, parameter, assignment: statement, assignmentVariable: lhs, factoryFunction: value, assignmentIndex: index, ...analysis });
            }
        }
        for (const statement of fn.body || []) walkNode(statement);
    }
    function walkNode(node) {
        if (!isNode(node)) return;
        if (node.type === "FunctionDeclaration") { walkFunction(node); return; }
        for (const key of Object.keys(node)) {
            const value = node[key];
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) for (const child of value) walkNode(child);
            else if (isNode(value)) walkNode(value);
        }
    }
    walkNode(ast);
    if (candidates.length === 0) return null;
    if (candidates.length > 1) return { ambiguous: true, candidates };
    return candidates[0];
}

function renameCreateClosureBinding(source, ast, replacementName = "createClosure") {
    const candidate = findCreateClosureBinding(ast);
    if (!candidate) return { source, found: false, renamed: false, reason: "No structurally valid Prometheus vararg closure factory was found" };
    if (candidate.ambiguous) return { source, found: false, renamed: false, ambiguous: true, candidateCount: candidate.candidates.length, reason: "Multiple structurally valid vararg closure factories were found" };
    const renamed = renameFunctionParameterBinding(source, candidate, replacementName);
    return { ...renamed, found: true, renamed: !renamed.collision && !renamed.alreadyNamed, factoryRange: candidate.factoryFunction.range, assignmentRange: candidate.assignment.range, vmName: candidate.vmIdentifier.name, proxyFactoryName: candidate.proxyFactoryIdentifier.name, kind: "vararg" };
}

module.exports = { analyzeClosureFactory, analyzeVarargClosureFactory, findCreateClosureBinding, renameCreateClosureBinding };
