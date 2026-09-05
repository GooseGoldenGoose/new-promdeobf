"use strict";

const { renderStaticEnvironmentWrite } = require("./global-writes");
const { renderIndexAccess } = require("./expression-semantics");

function renderOrdinaryIndexWrite({ baseName, renderedBase, renderedKey, renderedValue, stableBase }) {
    if (typeof baseName !== "string" || typeof renderedKey !== "string" || typeof renderedValue !== "string") return null;
    if (baseName === "_env") {
        const line = renderStaticEnvironmentWrite(renderedKey, renderedValue);
        return line ? { kind: "global-write", line, baseName } : null;
    }
    if (!stableBase || typeof renderedBase !== "string") return null;
    const target = renderIndexAccess(renderedBase, renderedKey);
    return target ? { kind: "index-write", line: `${target} = ${renderedValue}`, baseName } : null;
}

module.exports = { renderOrdinaryIndexWrite };