"use strict";

const { isLuaIdentifier } = require("./ast");

function staticGlobalNameFromRenderedKey(key) {
    if (typeof key !== "string") return null;
    const match = /^"([A-Za-z_][A-Za-z0-9_]*)"$/.exec(key);
    if (!match || !isLuaIdentifier(match[1])) return null;
    return match[1];
}

function renderStaticEnvironmentWrite(key, value) {
    if (typeof value !== "string") return null;
    const globalName = staticGlobalNameFromRenderedKey(key);
    return globalName ? `${globalName} = ${value}` : null;
}

module.exports = { staticGlobalNameFromRenderedKey, renderStaticEnvironmentWrite };
