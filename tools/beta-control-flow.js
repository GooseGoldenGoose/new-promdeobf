const path = require("path");

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta.cf${parsed.ext || ".lua"}`);
}

function retiredRegisterVersionPipelineError() {
    return new Error("Fresh beta control-flow pipeline is not wired yet; legacy beta register versioning was retired to beta-register-versions-old.js");
}

function generateBetaControlFlowFromSource() {
    throw retiredRegisterVersionPipelineError();
}

function generateBetaControlFlow() {
    throw retiredRegisterVersionPipelineError();
}

function main() {
    throw retiredRegisterVersionPipelineError();
}

if (require.main === module) main();

module.exports = {
    defaultOutputPath,
    generateBetaControlFlowFromSource,
    generateBetaControlFlow,
};