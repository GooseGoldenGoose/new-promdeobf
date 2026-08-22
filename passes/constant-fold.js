function isAstNode(value) {
    return value && typeof value === "object" && typeof value.type === "string";
}

function luaTruthy(value) {
    return value.kind !== "nil" && !(value.kind === "boolean" && value.value === false);
}

function constant(kind, value) {
    return { constant: true, kind, value };
}

const NOT_CONSTANT = Object.freeze({ constant: false });

function evaluateConstant(node) {
    if (!isAstNode(node)) return NOT_CONSTANT;

    switch (node.type) {
        case "NumericLiteral": return constant("number", node.value);
        case "StringLiteral": return constant("string", node.value);
        case "BooleanLiteral": return constant("boolean", node.value);
        case "NilLiteral": return constant("nil", null);
        case "UnaryExpression": {
            const argument = evaluateConstant(node.argument);
            if (!argument.constant) return NOT_CONSTANT;
            if (node.operator === "-") {
                const value = -argument.value;
                return argument.kind === "number" && Number.isFinite(value)
                    ? constant("number", value)
                    : NOT_CONSTANT;
            }
            if (node.operator === "not") return constant("boolean", !luaTruthy(argument));
            if (node.operator === "#" && argument.kind === "string") {
                return constant("number", Buffer.byteLength(argument.value, "utf8"));
            }
            return NOT_CONSTANT;
        }
        case "LogicalExpression":
        case "BinaryExpression": {
            const left = evaluateConstant(node.left);
            const right = evaluateConstant(node.right);
            if (!left.constant || !right.constant) return NOT_CONSTANT;

            const op = node.operator;
            if (op === "and") return luaTruthy(left) ? right : left;
            if (op === "or") return luaTruthy(left) ? left : right;

            if (op === "==" || op === "~=") {
                const equal = left.kind === right.kind && left.value === right.value;
                return constant("boolean", op === "==" ? equal : !equal);
            }

            if (["<", "<=", ">", ">="].includes(op)) {
                if (left.kind !== "number" || right.kind !== "number") return NOT_CONSTANT;
                let result;
                if (op === "<") result = left.value < right.value;
                else if (op === "<=") result = left.value <= right.value;
                else if (op === ">") result = left.value > right.value;
                else result = left.value >= right.value;
                return constant("boolean", result);
            }

            if (op === "..") {
                return left.kind === "string" && right.kind === "string"
                    ? constant("string", left.value + right.value)
                    : NOT_CONSTANT;
            }

            if (left.kind !== "number" || right.kind !== "number") return NOT_CONSTANT;

            let value;
            switch (op) {
                case "+": value = left.value + right.value; break;
                case "-": value = left.value - right.value; break;
                case "*": value = left.value * right.value; break;
                case "/": value = left.value / right.value; break;
                case "//": value = Math.floor(left.value / right.value); break;
                case "%": value = left.value - Math.floor(left.value / right.value) * right.value; break;
                case "^": value = left.value ** right.value; break;
                default: return NOT_CONSTANT;
            }

            return Number.isFinite(value) ? constant("number", value) : NOT_CONSTANT;
        }
        default:
            return NOT_CONSTANT;
    }
}

function printConstant(value) {
    if (value.kind === "nil") return "nil";
    if (value.kind === "boolean") return value.value ? "true" : "false";
    if (value.kind === "string") return quoteLuaString(value.value);
    if (value.kind === "number") return Object.is(value.value, -0) ? "-0" : String(value.value);
    throw new Error(`Unsupported constant kind: ${value.kind}`);
}

function foldConstants(source, ast) {
    const replacements = [];

    function visit(node) {
        if (!isAstNode(node)) return;

        if (["UnaryExpression", "BinaryExpression", "LogicalExpression"].includes(node.type)) {
            const result = evaluateConstant(node);
            if (result.constant && Array.isArray(node.range)) {
                const replacement = printConstant(result);
                const original = source.slice(node.range[0], node.range[1]);
                if (replacement !== original) {
                    replacements.push({
                        start: node.range[0],
                        end: node.range[1],
                        original,
                        replacement,
                        type: node.type,
                    });
                }
                return;
            }
        }

        for (const value of Object.values(node)) {
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isAstNode(value)) {
                visit(value);
            }
        }
    }

    visit(ast);
    replacements.sort((a, b) => b.start - a.start);

    let output = source;
    for (const replacement of replacements) {
        output = output.slice(0, replacement.start) + replacement.replacement + output.slice(replacement.end);
    }

    return { source: output, replacements };
}

module.exports = { evaluateConstant, foldConstants, printConstant };

