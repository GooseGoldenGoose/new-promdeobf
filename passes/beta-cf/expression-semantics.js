"use strict";

const { staticGlobalNameFromRenderedKey } = require("./global-writes");

function staticMemberNameFromRenderedKey(key) {
    return staticGlobalNameFromRenderedKey(key);
}

function renderEnvironmentRead(key) {
    if (typeof key !== "string") return null;
    const globalName = staticGlobalNameFromRenderedKey(key);
    return globalName || `_env[${key}]`;
}

function renderIndexAccess(base, key) {
    if (typeof base !== "string" || typeof key !== "string") return null;
    const member = staticMemberNameFromRenderedKey(key);
    return member ? `${base}.${member}` : `${base}[${key}]`;
}

function renderInfix(left, operator, right) {
    if (typeof left !== "string" || typeof right !== "string" || typeof operator !== "string") return null;
    return `(${left} ${operator} ${right})`;
}

function renderCallable(base, args) {
    if (typeof base !== "string" || !Array.isArray(args) || args.some(arg => typeof arg !== "string")) return null;
    const callable = /^function\b/.test(base.trim()) ? `(${base})` : base;
    return `${callable}(${args.join(", ")})`;
}

module.exports = { staticMemberNameFromRenderedKey, renderEnvironmentRead, renderIndexAccess, renderInfix, renderCallable };