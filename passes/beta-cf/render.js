"use strict";

function renderProgram(lines) {
    return lines.join("\n") + "\n";
}

function renderFunction(parameters, lines) {
    const body = lines
        .map(line => String(line).split("\n").map(part => `    ${part}`).join("\n"))
        .join("\n");
    return `function(${parameters.join(", ")})${body ? `\n${body}\n` : ""}end`;
}

module.exports = { renderFunction, renderProgram };
