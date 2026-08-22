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

function returnedCallFromVarargClosure(fn, entryName, capturesName) {
    if (fn?.type !== "FunctionDeclaration") return null;
    const params = fn.parameters || [];
    if (params.length !== 1 || params[0]?.type !== "VarargLiteral") return null;
    if ((fn.body || []).length !== 1 || fn.body[0]?.type !== "ReturnStatement") return null;

    const values = fn.body[0].arguments || [];
    if (values.length !== 1 || values[0]?.type !== "CallExpression") return null;

    const call = values[0];
    const args = call.arguments || [];
    if (args.length < 4) return null;
    if (!isIdentifier(args[0], entryName)) return null;
    if (!tableContainsVararg(args[1])) return null;
    if (!isIdentifier(args[2], capturesName)) return null;
    if (!isIdentifier(call.base)) return null;

    return call;
}

function analyzeVarargClosureFactory(fn) {
    if (fn?.type !== "FunctionDeclaration") return null;
    const params = fn.parameters || [];
    if (params.length !== 2 || !isIdentifier(params[0]) || !isIdentifier(params[1])) return null;

    const entryName = params[0].name;
    const capturesName = params[1].name;
    let proxyLocal = null;
    let closureLocal = null;
    let nestedClosure = null;
    let vmCall = null;

    for (const statement of fn.body || []) {
        if (statement?.type === "LocalStatement" &&
            (statement.variables || []).length === 1 &&
            (statement.init || []).length === 1) {
            const variable = statement.variables[0];
            const init = statement.init[0];

            if (isIdentifier(variable) && init?.type === "CallExpression" &&
                isIdentifier(init.base) && (init.arguments || []).length === 1 &&
                isIdentifier(init.arguments[0], capturesName)) {
                proxyLocal = variable.name;
                continue;
            }

            if (isIdentifier(variable) && init?.type === "FunctionDeclaration") {
                const call = returnedCallFromVarargClosure(init, entryName, capturesName);
                if (call) {
                    closureLocal = variable.name;
                    nestedClosure = init;
                    vmCall = call;
                }
            }
        }
    }

    if (!proxyLocal || !closureLocal || !nestedClosure || !vmCall) return null;
    if (!isIdentifier(vmCall.arguments[3], proxyLocal)) return null;

    const finalStatement = (fn.body || [])[fn.body.length - 1];
    if (finalStatement?.type !== "ReturnStatement" ||
        (finalStatement.arguments || []).length !== 1 ||
        !isIdentifier(finalStatement.arguments[0], closureLocal)) {
        return null;
    }

    return {
        entryParameter: params[0],
        capturesParameter: params[1],
        proxyLocal,
        closureLocal,
        nestedClosure,
        vmCall,
        vmIdentifier: vmCall.base,
    };
}

function findCreateClosureBinding(ast) {
    const candidates = [];

    function walkFunction(fn) {
        const parameters = fn.parameters || [];
        const parameterByName = new Map(
            parameters.filter(parameter => isIdentifier(parameter)).map(parameter => [parameter.name, parameter])
        );

        for (const statement of fn.body || []) {
            if (statement?.type !== "AssignmentStatement") continue;
            const variables = statement.variables || [];
            const values = statement.init || [];
            const count = Math.min(variables.length, values.length);

            for (let index = 0; index < count; index++) {
                const lhs = variables[index];
                const value = values[index];
                if (!isIdentifier(lhs) || value?.type !== "FunctionDeclaration") continue;

                const parameter = parameterByName.get(lhs.name);
                if (!parameter) continue;

                const analysis = analyzeVarargClosureFactory(value);
                if (!analysis) continue;

                candidates.push({
                    fn,
                    parameter,
                    assignment: statement,
                    assignmentVariable: lhs,
                    factoryFunction: value,
                    assignmentIndex: index,
                    ...analysis,
                });
            }
        }

        for (const statement of fn.body || []) walkNode(statement);
    }

    function walkNode(node) {
        if (!isNode(node)) return;
        if (node.type === "FunctionDeclaration") {
            walkFunction(node);
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) walkNode(child);
            } else if (isNode(value)) {
                walkNode(value);
            }
        }
    }

    walkNode(ast);
    if (candidates.length === 0) return null;
    if (candidates.length > 1) {
        return {
            ambiguous: true,
            candidates,
        };
    }
    return candidates[0];
}

function renameCreateClosureBinding(source, ast, replacementName = "createClosure") {
    const candidate = findCreateClosureBinding(ast);
    if (!candidate) {
        return {
            source,
            found: false,
            renamed: false,
            reason: "No structurally valid Prometheus vararg closure factory was found",
        };
    }

    if (candidate.ambiguous) {
        return {
            source,
            found: false,
            renamed: false,
            ambiguous: true,
            candidateCount: candidate.candidates.length,
            reason: "Multiple structurally valid vararg closure factories were found",
        };
    }

    const renamed = renameFunctionParameterBinding(source, candidate, replacementName);
    return {
        ...renamed,
        found: true,
        renamed: !renamed.collision && !renamed.alreadyNamed,
        factoryRange: candidate.factoryFunction.range,
        assignmentRange: candidate.assignment.range,
        vmName: candidate.vmIdentifier.name,
        kind: "vararg",
    };
}

module.exports = {
    analyzeVarargClosureFactory,
    findCreateClosureBinding,
    renameCreateClosureBinding,
};
