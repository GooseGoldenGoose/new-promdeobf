"use strict";

function failure(reason) {
    return { applied: false, reason, mode: "fresh" };
}

function unsupported(name) {
    return function () {
        return { applied: false, reason: `Fresh beta CF solver: ${name} is not implemented yet` };
    };
}

function unsupportedMultiState(count, diagnostics = {}) {
    const detail = diagnostics.reason ? `; closure recovery: ${diagnostics.reason}` : "";
    const stateDetail = diagnostics.state != null ? ` at state ${diagnostics.state}` : "";
    const statementDetail = diagnostics.statementIndex != null
        ? `; root statement ${diagnostics.statementIndex}: ${String(diagnostics.statement || "unknown").replace(/\s+/g, " ").slice(0, 180)}`
        : "";
    const unconsumed = Array.isArray(diagnostics.unconsumed) && diagnostics.unconsumed.length
        ? `; unconsumed states: ${diagnostics.unconsumed.join(",")}`
        : "";
    return failure(`Fresh beta CF: unsupported multi-state control flow (${count} normalized states)${detail}${stateDetail}${statementDetail}${unconsumed}`);
}

module.exports = { failure, unsupported, unsupportedMultiState };
