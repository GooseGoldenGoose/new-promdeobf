const { findEnvironmentBinding } = require("./environment");
const { analyzeClosureFactory } = require("./closure-factory");
const { findVmFunction } = require("./vm-state");
const { findRegisterOverflowBinding } = require("./vm-register-names");
const { renameFunctionParameterBindingsBatch } = require("./batch-parameter-rename");
const { applyTextEdits } = require("./text-edits");

function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function isIdentifier(node, name = null) {
    return node?.type === "Identifier" && (name === null || node.name === name);
}

function numericValue(node) {
    if (node?.type !== "NumericLiteral") return null;
    if (typeof node.value === "number") return node.value;
    const value = Number(node.raw);
    return Number.isFinite(value) ? value : null;
}

function isEmptyTable(node) {
    return node?.type === "TableConstructorExpression" && (node.fields || []).length === 0;
}

function isVarargTable(node) {
    if (node?.type !== "TableConstructorExpression") return false;
    const fields = node.fields || [];
    return fields.length === 1 && fields[0]?.type === "TableValue" && fields[0].value?.type === "VarargLiteral";
}

function walk(node, visitor, parent = null, parentKey = null) {
    if (!isNode(node)) return;
    visitor(node, parent, parentKey);
    for (const [key, value] of Object.entries(node)) {
        if (key === "loc" || key === "range") continue;
        if (Array.isArray(value)) {
            for (const child of value) walk(child, visitor, node, key);
        } else if (isNode(value)) {
            walk(value, visitor, node, key);
        }
    }
}

function findNamedFunctionAssignments(ast) {
    const found = new Map();
    const ambiguous = new Set();
    walk(ast, node => {
        if (node.type !== "AssignmentStatement") return;
        const variables = node.variables || [];
        const init = node.init || [];
        const count = Math.min(variables.length, init.length);
        for (let index = 0; index < count; index++) {
            if (!isIdentifier(variables[index]) || init[index]?.type !== "FunctionDeclaration") continue;
            const name = variables[index].name;
            if (found.has(name) && found.get(name) !== init[index]) ambiguous.add(name);
            else found.set(name, init[index]);
        }
    });
    return { found, ambiguous };
}

function findInitialArgsRequest(ast) {
    const env = findEnvironmentBinding(ast);
    if (!env?.fn || !env.call) return null;
    const parameters = env.fn.parameters || [];
    const args = env.call.arguments || [];
    const matches = [];
    for (let index = 0; index < Math.min(parameters.length, args.length); index++) {
        if (!isIdentifier(parameters[index]) || !isVarargTable(args[index])) continue;
        matches.push({ fn: env.fn, parameter: parameters[index], argument: args[index], index });
    }
    return matches.length === 1 ? matches[0] : null;
}

function buildParameterRequests(ast, named = findNamedFunctionAssignments(ast)) {
    const requests = [];
    const initialArgs = findInitialArgsRequest(ast);
    if (initialArgs && initialArgs.parameter.name !== "InitialArgs") {
        requests.push({
            fn: initialArgs.fn,
            parameter: initialArgs.parameter,
            replacementName: "InitialArgs",
            meta: { role: "InitialArgs", kind: "wrapper-args" },
        });
    }

    for (const [name, fn] of named.found) {
        if (!/^createClosure(?:\d+)?$/.test(name) || named.ambiguous.has(name)) continue;
        const analysis = analyzeClosureFactory(fn);
        if (!analysis || analysis.kind !== "fixed") continue;
        const parameters = analysis.nestedClosure.parameters || [];
        for (let index = 0; index < parameters.length; index++) {
            const parameter = parameters[index];
            if (!isIdentifier(parameter)) continue;
            const replacementName = `arg${index + 1}`;
            if (parameter.name === replacementName) continue;
            requests.push({
                fn: analysis.nestedClosure,
                parameter,
                replacementName,
                meta: { role: `${name}.arg${index + 1}`, kind: "closure-arg" },
            });
        }
    }
    return requests;
}

function identifierIsProperty(parent, parentKey) {
    return (parent?.type === "MemberExpression" && parentKey === "identifier") ||
        (parent?.type === "TableKeyString" && parentKey === "key");
}

function collectIdentifierEdits(node, oldName, newName, out = []) {
    walk(node, (current, parent, parentKey) => {
        if (!isIdentifier(current, oldName) || identifierIsProperty(parent, parentKey)) return;
        if (!Array.isArray(current.range)) return;
        out.push({ start: current.range[0], end: current.range[1], replacement: newName });
    });
    return out;
}

function collectDeclarationNames(node, out = []) {
    walk(node, current => {
        if (current.type === "LocalStatement") {
            for (const variable of current.variables || []) if (isIdentifier(variable)) out.push({ name: variable.name, node: variable });
        }
        if (current.type === "FunctionDeclaration") {
            for (const parameter of current.parameters || []) if (isIdentifier(parameter)) out.push({ name: parameter.name, node: parameter });
            if (current.isLocal && isIdentifier(current.identifier)) out.push({ name: current.identifier.name, node: current.identifier });
        }
        if (current.type === "ForNumericStatement" && isIdentifier(current.variable)) out.push({ name: current.variable.name, node: current.variable });
        if (current.type === "ForGenericStatement") {
            for (const variable of current.variables || []) if (isIdentifier(variable)) out.push({ name: variable.name, node: variable });
        }
    });
    return out;
}

function statementsAfter(body, statement) {
    const index = body.indexOf(statement);
    return index < 0 ? null : body.slice(index + 1);
}

function collectLocalBindingRename(body, declarationStatement, declarationIdentifier, newName, role) {
    if (!isIdentifier(declarationIdentifier) || !Array.isArray(declarationIdentifier.range)) return { skipped: true, role, reason: "missing declaration identifier" };
    const oldName = declarationIdentifier.name;
    if (oldName === newName) return { skipped: true, role, alreadyNamed: true, oldName, newName };
    const after = statementsAfter(body, declarationStatement);
    if (!after) return { skipped: true, role, reason: "declaration is not in expected body" };

    const declarations = [];
    for (const statement of after) collectDeclarationNames(statement, declarations);
    if (declarations.some(item => item.name === oldName)) {
        return { skipped: true, role, oldName, newName, reason: `${oldName} is shadowed after its declaration` };
    }
    if (declarations.some(item => item.name === newName)) {
        return { skipped: true, role, oldName, newName, reason: `${newName} collides with a later declaration` };
    }

    const edits = [{ start: declarationIdentifier.range[0], end: declarationIdentifier.range[1], replacement: newName }];
    for (const statement of after) collectIdentifierEdits(statement, oldName, newName, edits);
    return { skipped: false, role, oldName, newName, edits, referencesRenamed: edits.length - 1 };
}

function collectLoopBindingRename(loop, newName, role) {
    if (loop?.type !== "ForNumericStatement" || !isIdentifier(loop.variable) || !Array.isArray(loop.variable.range)) {
        return { skipped: true, role, reason: "not a numeric-for binding" };
    }
    const oldName = loop.variable.name;
    if (oldName === newName) return { skipped: true, role, alreadyNamed: true, oldName, newName };
    const declarations = [];
    for (const statement of loop.body || []) collectDeclarationNames(statement, declarations);
    if (declarations.some(item => item.name === oldName || item.name === newName)) {
        return { skipped: true, role, oldName, newName, reason: "loop binding is shadowed or replacement collides" };
    }
    const edits = [{ start: loop.variable.range[0], end: loop.variable.range[1], replacement: newName }];
    for (const statement of loop.body || []) collectIdentifierEdits(statement, oldName, newName, edits);
    return { skipped: false, role, oldName, newName, edits, referencesRenamed: edits.length - 1 };
}

function findLocalByCall(body, calleeName) {
    const matches = [];
    for (const statement of body || []) {
        if (statement?.type !== "LocalStatement" || (statement.variables || []).length !== 1 || (statement.init || []).length !== 1) continue;
        const variable = statement.variables[0];
        const init = statement.init[0];
        if (!isIdentifier(variable) || init?.type !== "CallExpression" || !isIdentifier(init.base, calleeName)) continue;
        matches.push({ statement, variable, call: init });
    }
    return matches.length === 1 ? matches[0] : null;
}

function collectCreateClosureLocalRenames(fn, helperName, out) {
    const analysis = analyzeClosureFactory(fn);
    if (!analysis) return;
    const body = fn.body || [];
    const proxyDecl = body.find(statement =>
        statement?.type === "LocalStatement" &&
        (statement.variables || []).length === 1 && isIdentifier(statement.variables[0], analysis.proxyLocal) &&
        (statement.init || []).length === 1 && statement.init[0]?.type === "CallExpression" &&
        isIdentifier(statement.init[0].base, "createUpvalueProxy")
    );
    if (proxyDecl) out.push(collectLocalBindingRename(body, proxyDecl, proxyDecl.variables[0], "gcProxy", `${helperName}.gcProxy`));

    const closureDecl = body.find(statement =>
        statement?.type === "LocalStatement" &&
        (statement.variables || []).length === 1 && isIdentifier(statement.variables[0], analysis.closureLocal) &&
        (statement.init || []).length === 1 && statement.init[0] === analysis.nestedClosure
    );
    if (closureDecl) out.push(collectLocalBindingRename(body, closureDecl, closureDecl.variables[0], "closure", `${helperName}.closure`));
}

function collectReleaseUpvaluesRenames(fn, out) {
    const body = fn.body || [];
    const first = body[0];
    const loop = body[1];
    if (first?.type !== "LocalStatement" || (first.variables || []).length !== 2 || (first.init || []).length !== 2) return;
    const [indexVar, upvalueVar] = first.variables;
    const [one, firstCapture] = first.init;
    if (!isIdentifier(indexVar) || !isIdentifier(upvalueVar) || numericValue(one) !== 1) return;
    if (firstCapture?.type !== "IndexExpression" || !isIdentifier(firstCapture.base, "captures") || numericValue(firstCapture.index) !== 1) return;
    if (loop?.type !== "WhileStatement" || !isIdentifier(loop.condition, upvalueVar.name)) return;
    out.push(collectLocalBindingRename(body, first, indexVar, "captureIndex", "releaseUpvalues.captureIndex"));
    out.push(collectLocalBindingRename(body, first, upvalueVar, "upvalueId", "releaseUpvalues.upvalueId"));
}

function collectCreateUpvalueProxyRenames(fn, out) {
    const body = fn.body || [];
    const loop = body.find(statement =>
        statement?.type === "ForNumericStatement" &&
        numericValue(statement.start) === 1 &&
        statement.end?.type === "UnaryExpression" && statement.end.operator === "#" &&
        isIdentifier(statement.end.argument, "captures")
    );
    if (loop) out.push(collectLoopBindingRename(loop, "captureIndex", "createUpvalueProxy.captureIndex"));

    const ifStatement = body.find(statement => statement?.type === "IfStatement" &&
        (statement.clauses || []).some(clause => clause.type !== "ElseClause" && isIdentifier(clause.condition, "newproxy")));
    if (!ifStatement) return;
    const clause = (ifStatement.clauses || []).find(item => item.type !== "ElseClause" && isIdentifier(item.condition, "newproxy"));
    if (!clause) return;
    const clauseBody = clause.body || [];
    const proxy = findLocalByCall(clauseBody, "newproxy");
    if (!proxy || (proxy.call.arguments || []).length !== 1 || proxy.call.arguments[0]?.type !== "BooleanLiteral" || proxy.call.arguments[0].value !== true) return;
    const metatable = findLocalByCall(clauseBody, "getmetatable");
    if (!metatable || (metatable.call.arguments || []).length !== 1 || !isIdentifier(metatable.call.arguments[0], proxy.variable.name)) return;
    out.push(collectLocalBindingRename(clauseBody, proxy.statement, proxy.variable, "proxy", "createUpvalueProxy.proxy"));
    out.push(collectLocalBindingRename(clauseBody, metatable.statement, metatable.variable, "proxyMetatable", "createUpvalueProxy.proxyMetatable"));
}

function collectRegisterOverflowRename(ast, out, named = null) {
    const fn = named?.found?.get("vm") || findVmFunction(ast)?.functionNode;
    if (!fn) return;
    const overflow = findRegisterOverflowBinding(fn);
    if (!overflow) return;
    out.push(collectLocalBindingRename(fn.body || [], overflow.declaration, overflow.identifier, "RegisterOverflow", "vm.RegisterOverflow"));
}

function applyLocalRenameResults(source, results) {
    const edits = [];
    const mapping = [];
    const skipped = [];
    for (const result of results) {
        if (!result || result.skipped) {
            if (result && !result.alreadyNamed) skipped.push(result);
            continue;
        }
        for (const edit of result.edits || []) edits.push(edit);
        mapping.push({
            role: result.role,
            oldName: result.oldName,
            newName: result.newName,
            referencesRenamed: result.referencesRenamed || 0,
        });
    }
    if (!edits.length) return { source, changed: false, mapping, skipped, edits: [] };

    const unique = new Map();
    for (const edit of edits) {
        const key = `${edit.start}:${edit.end}`;
        const previous = unique.get(key);
        if (previous && previous.replacement !== edit.replacement) {
            return { source, changed: false, mapping: [], skipped: [...skipped, { reason: "semantic rename edit conflict" }], edits: [] };
        }
        unique.set(key, edit);
    }
    return { source: applyTextEdits(source, [...unique.values()]), changed: true, mapping, skipped, edits: [...unique.values()] };
}

function renameSemanticBindings(source, ast, parseSource) {
    const mapping = [];
    const skipped = [];
    const named = findNamedFunctionAssignments(ast);

    const parameterRequests = buildParameterRequests(ast, named);
    let parameterEdits = [];
    if (parameterRequests.length) {
        const batch = renameFunctionParameterBindingsBatch(source, parameterRequests, ast);
        if (!batch.batchConflict) {
            parameterEdits = batch.edits || [];
            for (const result of batch.results) {
                if (result.collision) {
                    skipped.push({ role: result.meta?.role || "parameter", oldName: result.oldName, newName: result.newName, reason: result.reason });
                    continue;
                }
                if (!result.alreadyNamed && result.edits.length) {
                    mapping.push({ role: result.meta?.role || "parameter", oldName: result.oldName, newName: result.newName, referencesRenamed: result.referencesRenamed });
                }
            }
        } else {
            skipped.push({ role: "parameter-batch", reason: batch.reason });
        }
    }

    const localResults = [];
    for (const [name, fn] of named.found) {
        if (named.ambiguous.has(name)) continue;
        if (/^createClosure(?:\d+)?$/.test(name)) collectCreateClosureLocalRenames(fn, name, localResults);
        else if (name === "releaseUpvalues") collectReleaseUpvaluesRenames(fn, localResults);
        else if (name === "createUpvalueProxy") collectCreateUpvalueProxyRenames(fn, localResults);
    }
    collectRegisterOverflowRename(ast, localResults, named);

    const localEdits = [];
    for (const result of localResults) {
        if (!result || result.skipped) {
            if (result && !result.alreadyNamed) skipped.push(result);
            continue;
        }
        for (const edit of result.edits || []) localEdits.push(edit);
        mapping.push({
            role: result.role,
            oldName: result.oldName,
            newName: result.newName,
            referencesRenamed: result.referencesRenamed || 0,
        });
    }

    const combined = new Map();
    let conflict = false;
    for (const edit of [...parameterEdits, ...localEdits]) {
        const key = `${edit.start}:${edit.end}`;
        const previous = combined.get(key);
        if (previous && previous.replacement !== edit.replacement) {
            conflict = true;
            break;
        }
        combined.set(key, edit);
    }
    if (conflict) {
        return {
            source,
            found: parameterRequests.length > 0 || localResults.length > 0,
            applied: false,
            mapping: [],
            skipped: [...skipped, { role: "semantic-edits", reason: "semantic rename edit conflict" }],
            initialArgsRenamed: false,
            closureArgumentRenameCount: 0,
            helperLocalRenameCount: 0,
            registerOverflowRenamed: false,
            edits: [],
        };
    }

    const edits = [...combined.values()];
    const output = edits.length ? applyTextEdits(source, edits) : source;
    return {
        source: output,
        found: parameterRequests.length > 0 || localResults.length > 0,
        applied: output !== source,
        mapping,
        skipped,
        initialArgsRenamed: mapping.some(item => item.role === "InitialArgs"),
        closureArgumentRenameCount: mapping.filter(item => /^createClosure(?:\d+)?\.arg\d+$/.test(item.role)).length,
        helperLocalRenameCount: mapping.filter(item => item.role !== "InitialArgs" && !/^createClosure(?:\d+)?\.arg\d+$/.test(item.role) && item.role !== "vm.RegisterOverflow").length,
        registerOverflowRenamed: mapping.some(item => item.role === "vm.RegisterOverflow"),
        edits,
    };
}
module.exports = {
    findInitialArgsRequest,
    renameSemanticBindings,
};



