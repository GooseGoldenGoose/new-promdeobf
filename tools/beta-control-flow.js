const fs = require("fs");
const path = require("path");
const { parseLua, parseLuaStructural } = require("../main");
const { versionVmBlockRegisters, finalizeBetaRegisterUpvalues, finalizeBetaRegisterSchedule, finalizeBetaDeadStateSnapshots } = require("../passes/beta-register-versions");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");
const { recoverVmStateGraph } = require("../passes/vm-state");
const { scheduleVmRegisterUses } = require("../passes/vm-register-scheduler");
const { prepareOverflowAsScalarRegisters, remapOverflowBetaVersions } = require("../passes/beta-overflow-register");

function defaultOutputPath(inputPath) {
    const parsed = path.parse(path.resolve(inputPath));
    return path.join(parsed.dir, `${parsed.name}.beta.cf${parsed.ext || ".lua"}`);
}

function generateBetaControlFlowFromSource(source, ast, outputPath) {
    const resolvedOutput = path.resolve(outputPath);
    const prepared = prepareOverflowAsScalarRegisters(source, ast, parseLuaStructural);
    if (!prepared.applied && (prepared.slots || []).length > 0) {
        throw new Error(prepared.reason || "Overflow scalarization failed closed");
    }
    let betaSource = prepared.source;
    let betaAst = prepared.ast;
    let earlyVmState = null;
    let earlyRegisterSchedule = null;
    let betaRaw = versionVmBlockRegisters(betaSource, betaAst);

    // With an aggressively low compiler MAX_REGS, even temporary values used to
    // compute state transitions can live in RegisterOverflow. The normal pipeline
    // therefore cannot normalize the dispatcher before this experimental pass.
    // Once overflow slots are scalarized, retry the exact production state +
    // register-scheduling stages, then hand the result to ordinary beta versioning.
    if (!betaRaw.applied && betaRaw.reason === "No exact normalized VM state leaves were found" && prepared.applied) {
        earlyVmState = recoverVmStateGraph(betaSource, betaAst);
        if (!earlyVmState.found || !earlyVmState.normalized) {
            throw new Error(earlyVmState.reason || "Early overflow-scalar VM state recovery failed closed");
        }
        betaSource = earlyVmState.source;
        const scheduleAst = parseLua(betaSource, "<overflow before VM register scheduling>");
        earlyRegisterSchedule = scheduleVmRegisterUses(betaSource, scheduleAst);
        if (earlyRegisterSchedule.applied) betaSource = earlyRegisterSchedule.source;
        betaAst = parseLuaStructural(betaSource, "<overflow after VM state recovery>");
        betaRaw = versionVmBlockRegisters(betaSource, betaAst);
    }

    if (!betaRaw.found || !betaRaw.applied) {
        throw new Error(betaRaw.reason || "Beta register analysis did not apply");
    }
    let beta = remapOverflowBetaVersions(betaRaw, prepared);
    beta = finalizeBetaRegisterUpvalues(beta);
    beta = finalizeBetaDeadStateSnapshots(finalizeBetaRegisterSchedule(beta));
    if (beta.upvalueRecovery?.completed && !beta.upvalueRecovery.safe) {
        throw new Error(beta.upvalueRecovery.reason || "Beta upvalue recovery failed closed");
    }
    if (beta.deadStateSnapshots && !beta.deadStateSnapshots.safe) {
        throw new Error(beta.deadStateSnapshots.reason || "Dead state snapshot cleanup failed closed");
    }

    if (beta.finalRegisterSchedule && !beta.finalRegisterSchedule.safe) {
        throw new Error(beta.finalRegisterSchedule.reason || "Final beta register scheduling failed closed");
    }

    betaAst = parseLuaStructural(beta.source, "<after final beta register scheduling>");
    const controlFlow = solveBetaControlFlow(betaAst, beta);
    if (!controlFlow.applied) throw new Error(controlFlow.reason || "Beta control-flow solving did not apply");

    parseLuaStructural(controlFlow.source, `${resolvedOutput} <beta control flow>`);
    fs.mkdirSync(path.dirname(resolvedOutput), { recursive: true });
    fs.writeFileSync(resolvedOutput, controlFlow.source, "utf8");
    return { beta, controlFlow, overflow: beta.overflow, earlyVmState, earlyRegisterSchedule, outputPath: resolvedOutput };
}

function generateBetaControlFlow(inputPath, outputPath = null) {
    const resolvedInput = path.resolve(inputPath);
    const resolvedOutput = path.resolve(outputPath || defaultOutputPath(resolvedInput));
    const source = fs.readFileSync(resolvedInput, "utf8");
    const ast = parseLuaStructural(source, resolvedInput);
    return generateBetaControlFlowFromSource(source, ast, resolvedOutput);
}

function main() {
    const inputArg = process.argv[2];
    if (!inputArg) throw new Error("Usage: node tools/beta-control-flow.js <output.lua> [output.beta.cf.lua]");
    const generated = generateBetaControlFlow(inputArg, process.argv[3] || null);
    console.log(`Mode: ${generated.controlFlow.mode}`);
    console.log(`Entry state: ${generated.controlFlow.entryState}`);
    console.log(`States: ${generated.controlFlow.stateCount}`);
    console.log(`Statements: ${generated.controlFlow.statementCount}`);
    if (generated.overflow?.applied) {
        console.log(`Overflow slots: ${generated.overflow.slots.length}`);
        console.log(`Overflow versions: ${generated.overflow.rows.length}`);
    }
    console.log(`Branches: ${generated.controlFlow.branchCount || 0}`);
    if (generated.controlFlow.joinCount !== undefined) console.log(`Branch joins: ${generated.controlFlow.joinCount}`);
    if (generated.controlFlow.guardBranchCount !== undefined) console.log(`Guard-return branches: ${generated.controlFlow.guardBranchCount}`);
    if (generated.controlFlow.numericForLoopCount !== undefined) console.log(`Numeric for loops: ${generated.controlFlow.numericForLoopCount}`);
    if (generated.controlFlow.genericForLoopCount !== undefined) console.log(`Generic for loops: ${generated.controlFlow.genericForLoopCount}`);
    if (generated.controlFlow.whileLoopCount !== undefined) console.log(`While loops: ${generated.controlFlow.whileLoopCount}`);
    if (generated.controlFlow.repeatLoopCount !== undefined) console.log(`Repeat loops: ${generated.controlFlow.repeatLoopCount}`);
    if (generated.controlFlow.removedRepeatCompilerConditionOperationCount) console.log(`Repeat compiler-junk condition operations removed: ${generated.controlFlow.removedRepeatCompilerConditionOperationCount}`);
    if (generated.controlFlow.posPreservationRemoval?.removed) console.log(`POS preservation operations removed: ${generated.controlFlow.posPreservationRemoval.removed}`);
    if (generated.controlFlow.terminalReturnCount !== undefined) console.log(`Terminal returns: ${generated.controlFlow.terminalReturnCount}`);
    if (generated.controlFlow.closureRegionCount !== undefined) console.log(`Closure regions: ${generated.controlFlow.closureRegionCount}`);
    if (generated.controlFlow.inlinedClosureFactoryCount !== undefined) console.log(`Inlined closure factories: ${generated.controlFlow.inlinedClosureFactoryCount}`);
    if (generated.controlFlow.upvalueRecoveryApplied) {
        console.log(`Recovered upvalue cells: ${generated.controlFlow.recoveredUpvalueCellCount}`);
        console.log(`Recovered capture slots: ${generated.controlFlow.recoveredCaptureCount}`);
        console.log(`Upvalue reads/writes rewritten: ${generated.controlFlow.upvalueReadRewriteCount}/${generated.controlFlow.upvalueWriteRewriteCount}`);
        console.log(`Upvalue releases removed: ${generated.controlFlow.upvalueReleaseRemovalCount}`);
    }
    console.log(`Return payload sunk: ${generated.controlFlow.terminalReturnPayloadSunk}`);
    console.log(`Terminal return lowered: ${generated.controlFlow.terminalReturnLowered}`);
    if (generated.controlFlow.environmentHeader) console.log(`Header: ${generated.controlFlow.environmentHeader}`);
    console.log(`Output: ${generated.outputPath}`);
}

if (require.main === module) main();

module.exports = {
    defaultOutputPath,
    generateBetaControlFlowFromSource,
    generateBetaControlFlow,
};
