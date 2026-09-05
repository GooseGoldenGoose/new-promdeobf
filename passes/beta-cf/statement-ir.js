"use strict";

const { isIdentifier, isSingleAssignment } = require("./ast");

function decodeVmStatement(statement) {
    if (!isSingleAssignment(statement)) return null;
    const destination = statement.variables[0];
    const value = statement.init[0];
    if (destination?.type === "IndexExpression") {
        return { kind: "index-write", statement, destination, base: destination.base, key: destination.index, value };
    }
    if (isIdentifier(destination)) {
        return { kind: "register-write", statement, destination, targetName: destination.name, value };
    }
    return null;
}

function callKind(node) {
    if (node?.type !== "CallExpression") return null;
    const baseName = isIdentifier(node.base) ? node.base.name : null;
    if (baseName && /^createClosure\d*$/.test(baseName)) return "closure";
    if (baseName === "allocUpvalue") return "alloc-upvalue";
    if (baseName === "releaseUpvalue") return "release-upvalue";
    return "call";
}

module.exports = { decodeVmStatement, callKind };