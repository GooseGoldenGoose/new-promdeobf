function isNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function numberValue(node) {
    if (!isNode(node)) return null;
    if (node.type === "NumericLiteral" && Number.isFinite(node.value)) return node.value;
    if (node.type === "UnaryExpression" && node.operator === "-") {
        const value = numberValue(node.argument);
        return value === null ? null : -value;
    }
    if (node.type !== "BinaryExpression") return null;
    const left = numberValue(node.left);
    const right = numberValue(node.right);
    if (left === null || right === null) return null;
    switch (node.operator) {
        case "+": return left + right;
        case "-": return left - right;
        case "*": return left * right;
        case "/": return right === 0 ? null : left / right;
        case "//": return right === 0 ? null : Math.floor(left / right);
        case "%": return right === 0 ? null : left - Math.floor(left / right) * right;
        case "^": {
            const value = left ** right;
            return Number.isFinite(value) ? value : null;
        }
        default: return null;
    }
}

function decodeLuaString(raw) {
    if (typeof raw !== "string" || raw.length < 2) return null;
    const quote = raw[0];
    if ((quote !== '"' && quote !== "'") || raw.at(-1) !== quote) return null;

    let out = "";
    for (let i = 1; i < raw.length - 1; i++) {
        const ch = raw[i];
        if (ch !== "\\") {
            out += ch;
            continue;
        }

        const esc = raw[++i];
        if (esc === undefined || i >= raw.length) return null;
        const simple = {
            a: "\x07", b: "\b", f: "\f", n: "\n",
            r: "\r", t: "\t", v: "\x0b",
            "\\": "\\", '"': '"', "'": "'",
        };
        if (Object.prototype.hasOwnProperty.call(simple, esc)) {
            out += simple[esc];
            continue;
        }

        if (esc === "x") {
            const hex = raw.slice(i + 1, i + 3);
            if (!/^[0-9a-fA-F]{2}$/.test(hex)) return null;
            out += String.fromCharCode(parseInt(hex, 16));
            i += 2;
            continue;
        }

        if (/[0-9]/.test(esc)) {
            let digits = esc;
            while (digits.length < 3 && /[0-9]/.test(raw[i + 1] || "")) digits += raw[++i];
            const value = Number(digits);
            if (value > 255) return null;
            out += String.fromCharCode(value);
            continue;
        }

        if (esc === "z") {
            while (/\s/.test(raw[i + 1] || "")) i++;
            continue;
        }

        if (esc === "\n") {
            out += "\n";
            continue;
        }

        if (esc === "\r") {
            if (raw[i + 1] === "\n") i++;
            out += "\n";
            continue;
        }

        out += esc;
    }
    return out;
}

function quoteLuaString(value) {
    let out = '"';
    for (let i = 0; i < value.length; i++) {
        const ch = value[i];
        const code = value.charCodeAt(i);
        if (ch === "\\") out += "\\\\";
        else if (ch === '"') out += '\\"';
        else if (ch === "\n") out += "\\n";
        else if (ch === "\r") out += "\\r";
        else if (ch === "\t") out += "\\t";
        else if (code >= 32 && code <= 126) out += ch;
        else if (code <= 255) out += "\\" + String(code).padStart(3, "0");
        else out += ch;
    }
    return out + '"';
}

function literalValue(node) {
    if (!isNode(node)) return null;
    if (node.type === "StringLiteral") {
        const value = decodeLuaString(node.raw);
        return value === null ? null : { kind: "string", value };
    }
    if (node.type === "NumericLiteral" && Number.isFinite(node.value)) {
        return { kind: "number", value: node.value };
    }
    if (node.type === "BooleanLiteral") return { kind: "boolean", value: node.value };
    return null;
}

function printLiteral(literal) {
    if (literal.kind === "string") return quoteLuaString(literal.value);
    if (literal.kind === "number") return Object.is(literal.value, -0) ? "-0" : String(literal.value);
    if (literal.kind === "boolean") return literal.value ? "true" : "false";
    throw new Error(`Unsupported constant kind: ${literal.kind}`);
}

function walk(node, visit) {
    if (!isNode(node)) return;
    visit(node);
    for (const [key, value] of Object.entries(node)) {
        if (["loc", "range"].includes(key)) continue;
        if (Array.isArray(value)) {
            for (const child of value) walk(child, visit);
        } else {
            walk(value, visit);
        }
    }
}

function tableArray(statement) {
    if (
        statement?.type !== "LocalStatement" ||
        statement.variables?.length !== 1 ||
        statement.variables[0]?.type !== "Identifier" ||
        statement.init?.length !== 1 ||
        statement.init[0]?.type !== "TableConstructorExpression"
    ) return null;

    const values = [];
    for (const field of statement.init[0].fields || []) {
        if (field.type !== "TableValue") return null;
        const value = literalValue(field.value);
        if (!value) return null;
        values.push(value);
    }
    return values.length ? {
        name: statement.variables[0].name,
        values,
        statement,
    } : null;
}

function affineIndex(node, parameter) {
    if (node?.type === "Identifier" && node.name === parameter) return { coeff: 1, bias: 0 };
    const constant = numberValue(node);
    if (constant !== null) return { coeff: 0, bias: constant };
    if (node?.type !== "BinaryExpression" || !["+", "-"].includes(node.operator)) return null;
    const left = affineIndex(node.left, parameter);
    const right = affineIndex(node.right, parameter);
    if (!left || !right) return null;
    const sign = node.operator === "+" ? 1 : -1;
    return {
        coeff: left.coeff + sign * right.coeff,
        bias: left.bias + sign * right.bias,
    };
}

function wrapperFunction(statement, arrayName) {
    if (
        statement?.type !== "FunctionDeclaration" ||
        !statement.isLocal ||
        statement.identifier?.type !== "Identifier" ||
        statement.parameters?.length !== 1 ||
        statement.parameters[0]?.type !== "Identifier" ||
        statement.body?.length !== 1 ||
        statement.body[0]?.type !== "ReturnStatement" ||
        statement.body[0].arguments?.length !== 1
    ) return null;

    const access = statement.body[0].arguments[0];
    if (
        access?.type !== "IndexExpression" ||
        access.base?.type !== "Identifier" ||
        access.base.name !== arrayName
    ) return null;

    const index = affineIndex(access.index, statement.parameters[0].name);
    if (!index || index.coeff !== 1 || !Number.isInteger(index.bias)) return null;
    return {
        name: statement.identifier.name,
        offset: index.bias,
        statement,
    };
}

function rotation(statement, arrayName) {
    if (
        statement?.type !== "ForGenericStatement" ||
        statement.iterators?.length !== 1 ||
        statement.iterators[0]?.type !== "CallExpression" ||
        statement.iterators[0].base?.type !== "Identifier" ||
        statement.iterators[0].base.name !== "ipairs" ||
        statement.iterators[0].base.isLocal ||
        statement.iterators[0].arguments?.length !== 1 ||
        statement.iterators[0].arguments[0]?.type !== "TableConstructorExpression"
    ) return null;

    let touchesArray = false;
    walk(statement, node => {
        if (node.type === "IndexExpression" && node.base?.type === "Identifier" && node.base.name === arrayName) {
            touchesArray = true;
        }
    });
    if (!touchesArray) return null;

    const ranges = [];
    for (const field of statement.iterators[0].arguments[0].fields || []) {
        if (field.type !== "TableValue" || field.value?.type !== "TableConstructorExpression") return null;
        const pair = field.value.fields || [];
        if (pair.length !== 2 || pair.some(item => item.type !== "TableValue")) return null;
        const start = numberValue(pair[0].value);
        const end = numberValue(pair[1].value);
        if (!Number.isInteger(start) || !Number.isInteger(end)) return null;
        ranges.push([start, end]);
    }
    return ranges.length ? { ranges, statement } : null;
}

function base64Lookup(node) {
    if (node?.type !== "TableConstructorExpression" || node.fields?.length !== 64) return null;
    const lookup = new Map();

    for (const field of node.fields) {
        let key = null;
        if (field.type === "TableKeyString" && field.key?.type === "Identifier") key = field.key.name;
        else if (field.type === "TableKey" && field.key?.type === "StringLiteral") key = decodeLuaString(field.key.raw);
        else return null;

        const value = numberValue(field.value);
        if (typeof key !== "string" || key.length !== 1 || !Number.isInteger(value) || value < 0 || value > 63) {
            return null;
        }
        if (lookup.has(key)) return null;
        lookup.set(key, value);
    }

    const values = [...lookup.values()].sort((a, b) => a - b);
    if (values.some((value, index) => value !== index)) return null;
    return lookup;
}

function decoderLookup(statement, arrayName) {
    if (statement?.type !== "DoStatement") return null;

    let aliasName = null;
    const candidates = [];
    for (const child of statement.body || []) {
        if (
            child.type === "LocalStatement" &&
            child.variables?.length === 1 &&
            child.variables[0]?.type === "Identifier" &&
            child.init?.length === 1
        ) {
            if (child.init[0]?.type === "Identifier" && child.init[0].name === arrayName) {
                aliasName = child.variables[0].name;
            }
            const lookup = base64Lookup(child.init[0]);
            if (lookup) candidates.push(lookup);
        }
    }
    if (!aliasName || candidates.length !== 1) return null;

    let loopsOverAlias = false;
    let writesAlias = false;
    let hasPadding = false;
    walk(statement, node => {
        if (
            node.type === "ForNumericStatement" &&
            numberValue(node.start) === 1 &&
            node.end?.type === "UnaryExpression" &&
            node.end.operator === "#" &&
            node.end.argument?.type === "Identifier" &&
            node.end.argument.name === aliasName
        ) loopsOverAlias = true;

        if (
            node.type === "AssignmentStatement" &&
            node.variables?.some(variable =>
                variable.type === "IndexExpression" &&
                variable.base?.type === "Identifier" &&
                variable.base.name === aliasName
            )
        ) writesAlias = true;

        if (node.type === "StringLiteral" && decodeLuaString(node.raw) === "=") hasPadding = true;
    });

    return loopsOverAlias && writesAlias && hasPadding ? candidates[0] : null;
}

function applyRotation(values, ranges) {
    for (const [start, end] of ranges) {
        if (start < 1 || end > values.length || start > end) return false;
        let left = start - 1;
        let right = end - 1;
        while (left < right) {
            [values[left], values[right]] = [values[right], values[left]];
            left++;
            right--;
        }
    }
    return true;
}

function decodePrometheusBase64(input, lookup) {
    let out = "";
    let value = 0;
    let count = 0;

    for (let index = 0; index < input.length; index++) {
        const code = lookup.get(input[index]);
        if (code !== undefined) {
            value += code * (64 ** (3 - count));
            count++;
            if (count === 4) {
                count = 0;
                out += String.fromCharCode(
                    Math.floor(value / 65536),
                    Math.floor((value % 65536) / 256),
                    value % 256
                );
                value = 0;
            }
        } else if (input[index] === "=") {
            out += String.fromCharCode(Math.floor(value / 65536));
            if (index >= input.length - 1 || input[index + 1] !== "=") {
                out += String.fromCharCode(Math.floor((value % 65536) / 256));
            }
            break;
        } else {
            return null;
        }
    }
    return out;
}

function allBodies(ast) {
    const bodies = [];
    walk(ast, node => {
        if (Array.isArray(node.body)) bodies.push(node.body);
    });
    return bodies;
}

function findCandidate(ast) {
    let best = null;
    for (const body of allBodies(ast)) {
        for (let i = 0; i < body.length; i++) {
            const array = tableArray(body[i]);
            if (!array) continue;

            let rotate = null;
            let wrapper = null;
            let decoder = null;
            let rotateIndex = -1;
            let wrapperIndex = -1;
            let decoderIndex = -1;

            for (let j = i + 1; j < Math.min(body.length, i + 6); j++) {
                if (!rotate) {
                    const match = rotation(body[j], array.name);
                    if (match) {
                        rotate = match;
                        rotateIndex = j;
                        continue;
                    }
                }
                if (!wrapper) {
                    const match = wrapperFunction(body[j], array.name);
                    if (match) {
                        wrapper = match;
                        wrapperIndex = j;
                        continue;
                    }
                }
                if (!decoder) {
                    const match = decoderLookup(body[j], array.name);
                    if (match) {
                        decoder = match;
                        decoderIndex = j;
                    }
                }
            }

            if (!wrapper) continue;
            const indices = [i, wrapperIndex];
            if (rotate) indices.push(rotateIndex);
            if (decoder) indices.push(decoderIndex);
            const start = Math.min(...indices);
            const end = Math.max(...indices);
            const contiguous = indices.length === end - start + 1;
            const score = 3 + (rotate ? 2 : 0) + (decoder ? 4 : 0) + (contiguous ? 2 : 0);

            if (!best || score > best.score) {
                best = { score, body, array, rotate, wrapper, decoder, start, end, contiguous };
            }
        }
    }
    return best;
}

function namesDeclared(statement) {
    const names = [];
    if (statement?.type === "LocalStatement") {
        for (const variable of statement.variables || []) {
            if (variable.type === "Identifier") names.push(variable.name);
        }
    }
    if (statement?.type === "FunctionDeclaration" && statement.isLocal && statement.identifier?.type === "Identifier") {
        names.push(statement.identifier.name);
    }
    return names;
}

function collectReplacements(statements, targetName, offset, constants) {
    const TARGET = Symbol("constant-wrapper");
    const root = new Map([[targetName, TARGET]]);
    const replacements = [];
    let unresolved = 0;

    function expression(node, env) {
        if (!isNode(node)) return;

        if (node.type === "CallExpression" && node.base?.type === "Identifier") {
            const binding = env.get(node.base.name);
            if (binding === TARGET) {
                if (node.arguments?.length === 1) {
                    const argument = numberValue(node.arguments[0]);
                    const index = argument === null ? null : argument + offset;
                    if (Number.isInteger(index) && index >= 1 && index <= constants.length) {
                        replacements.push({
                            start: node.range[0],
                            end: node.range[1],
                            replacement: printLiteral(constants[index - 1]),
                            index,
                        });
                        return;
                    }
                }
                unresolved++;
            }
        }

        if (node.type === "Identifier" && env.get(node.name) === TARGET) {
            unresolved++;
            return;
        }

        if (node.type === "FunctionDeclaration") {
            const child = new Map(env);
            for (const parameter of node.parameters || []) {
                if (parameter.type === "Identifier") child.set(parameter.name, Symbol(parameter.name));
            }
            block(node.body || [], child);
            return;
        }

        for (const [key, value] of Object.entries(node)) {
            if (["loc", "range", "type", "name", "raw", "value", "isLocal"].includes(key)) continue;
            if (Array.isArray(value)) for (const child of value) expression(child, env);
            else expression(value, env);
        }
    }

    function statement(node, env) {
        switch (node.type) {
            case "LocalStatement":
                for (const init of node.init || []) expression(init, env);
                for (const name of namesDeclared(node)) env.set(name, Symbol(name));
                return;

            case "FunctionDeclaration": {
                if (node.isLocal && node.identifier?.type === "Identifier") {
                    env.set(node.identifier.name, Symbol(node.identifier.name));
                } else if (node.identifier) {
                    expression(node.identifier, env);
                }
                const child = new Map(env);
                for (const parameter of node.parameters || []) {
                    if (parameter.type === "Identifier") child.set(parameter.name, Symbol(parameter.name));
                }
                block(node.body || [], child);
                return;
            }

            case "ForNumericStatement": {
                expression(node.start, env);
                expression(node.end, env);
                if (node.step) expression(node.step, env);
                const child = new Map(env);
                if (node.variable?.type === "Identifier") child.set(node.variable.name, Symbol(node.variable.name));
                block(node.body || [], child);
                return;
            }

            case "ForGenericStatement": {
                for (const iterator of node.iterators || []) expression(iterator, env);
                const child = new Map(env);
                for (const variable of node.variables || []) {
                    if (variable.type === "Identifier") child.set(variable.name, Symbol(variable.name));
                }
                block(node.body || [], child);
                return;
            }

            case "DoStatement":
            case "WhileStatement": {
                if (node.condition) expression(node.condition, env);
                block(node.body || [], new Map(env));
                return;
            }

            case "RepeatStatement": {
                const child = new Map(env);
                block(node.body || [], child);
                expression(node.condition, child);
                return;
            }

            case "IfStatement":
                for (const clause of node.clauses || []) {
                    if (clause.condition) expression(clause.condition, env);
                    block(clause.body || [], new Map(env));
                }
                return;

            default:
                expression(node, env);
        }
    }

    function block(body, env) {
        for (const node of body) statement(node, env);
    }

    block(statements, root);
    return { replacements, unresolved };
}

function containsUnshadowedArray(statements, arrayName) {
    let count = 0;
    const TARGET = Symbol("constant-array");
    const root = new Map([[arrayName, TARGET]]);

    function expr(node, env) {
        if (!isNode(node)) return;
        if (node.type === "Identifier") {
            if (env.get(node.name) === TARGET) count++;
            return;
        }
        if (node.type === "FunctionDeclaration") {
            const child = new Map(env);
            for (const parameter of node.parameters || []) {
                if (parameter.type === "Identifier") child.set(parameter.name, Symbol(parameter.name));
            }
            block(node.body || [], child);
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (["loc", "range", "type", "name", "raw", "value", "isLocal"].includes(key)) continue;
            if (Array.isArray(value)) for (const child of value) expr(child, env);
            else expr(value, env);
        }
    }

    function stmt(node, env) {
        if (node.type === "LocalStatement") {
            for (const init of node.init || []) expr(init, env);
            for (const name of namesDeclared(node)) env.set(name, Symbol(name));
            return;
        }
        if (node.type === "FunctionDeclaration") {
            if (node.isLocal && node.identifier?.type === "Identifier") env.set(node.identifier.name, Symbol(node.identifier.name));
            const child = new Map(env);
            for (const parameter of node.parameters || []) if (parameter.type === "Identifier") child.set(parameter.name, Symbol(parameter.name));
            block(node.body || [], child);
            return;
        }
        if (node.type === "ForNumericStatement" || node.type === "ForGenericStatement") {
            if (node.type === "ForNumericStatement") {
                expr(node.start, env); expr(node.end, env); if (node.step) expr(node.step, env);
            } else for (const iterator of node.iterators || []) expr(iterator, env);
            const child = new Map(env);
            const variables = node.type === "ForNumericStatement" ? [node.variable] : node.variables;
            for (const variable of variables || []) if (variable?.type === "Identifier") child.set(variable.name, Symbol(variable.name));
            block(node.body || [], child);
            return;
        }
        if (node.type === "DoStatement" || node.type === "WhileStatement" || node.type === "RepeatStatement") {
            if (node.condition && node.type !== "RepeatStatement") expr(node.condition, env);
            const child = new Map(env);
            block(node.body || [], child);
            if (node.type === "RepeatStatement") expr(node.condition, child);
            return;
        }
        if (node.type === "IfStatement") {
            for (const clause of node.clauses || []) {
                if (clause.condition) expr(clause.condition, env);
                block(clause.body || [], new Map(env));
            }
            return;
        }
        expr(node, env);
    }

    function block(body, env) {
        for (const node of body) stmt(node, env);
    }

    block(statements, root);
    return count;
}

function inlinePrometheusConstantArray(source, ast) {
    const candidate = findCandidate(ast);
    if (!candidate) return {
        source, found: false, replacements: [], removedPrelude: false,
        reason: "No Prometheus ConstantArray structure found",
    };

    const constants = candidate.array.values.map(value => ({ ...value }));

    if (candidate.rotate && !applyRotation(constants, candidate.rotate.ranges)) {
        return {
            source, found: true, replacements: [], removedPrelude: false,
            reason: "ConstantArray rotation was not safe to evaluate",
        };
    }

    if (candidate.decoder) {
        for (const constant of constants) {
            if (constant.kind !== "string") continue;
            const decoded = decodePrometheusBase64(constant.value, candidate.decoder);
            if (decoded === null) return {
                source, found: true, replacements: [], removedPrelude: false,
                reason: "ConstantArray string decoder was not safe to evaluate",
            };
            constant.value = decoded;
        }
    }

    const payload = candidate.body.slice(candidate.end + 1);
    const analysis = collectReplacements(
        payload,
        candidate.wrapper.name,
        candidate.wrapper.offset,
        constants
    );
    const arrayUses = containsUnshadowedArray(payload, candidate.array.name);

    const canRemovePrelude =
        candidate.contiguous &&
        candidate.start === 0 &&
        analysis.unresolved === 0 &&
        arrayUses === 0;

    const edits = analysis.replacements.map(replacement => ({ ...replacement }));
    if (canRemovePrelude) {
        edits.push({
            start: candidate.body[candidate.start].range[0],
            end: candidate.body[candidate.end].range[1],
            replacement: "",
            prelude: true,
        });
    }

    edits.sort((a, b) => b.start - a.start);
    let output = source;
    for (const edit of edits) {
        output = output.slice(0, edit.start) + edit.replacement + output.slice(edit.end);
    }

    return {
        source: output,
        found: true,
        constants,
        replacements: analysis.replacements,
        arrayName: candidate.array.name,
        wrapperName: candidate.wrapper.name,
        wrapperOffset: candidate.wrapper.offset,
        rotated: Boolean(candidate.rotate),
        decoded: Boolean(candidate.decoder),
        removedPrelude: canRemovePrelude,
        unresolvedWrapperUses: analysis.unresolved,
        unresolvedArrayUses: arrayUses,
    };
}

module.exports = {
    numberValue,
    decodeLuaString,
    findCandidate,
    inlinePrometheusConstantArray,
};
