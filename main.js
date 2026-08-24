const fs = require("fs");
const path = require("path");
const luaparse = require("./parser/luaparse");
const { inlinePrometheusConstantArray } = require("./passes/constant-array");
const { renameEnvironmentBinding } = require("./passes/environment");
const { renameCreateClosureBinding } = require("./passes/closure-factory");
const { renameVmHelperBindings } = require("./passes/vm-helpers");
const { splitSafeParallelAssignmentsFully } = require("./passes/split-safe-assignments");
const { recoverVmStateGraph } = require("./passes/vm-state");
const { recoverVmBindings } = require("./passes/vm-bindings");
const { scheduleVmRegisterUses } = require("./passes/vm-register-scheduler");
const { renameVmRegisterBindings } = require("./passes/vm-register-names");
const { renameSemanticBindings } = require("./passes/semantic-names");
const { applyTextEdits } = require("./passes/text-edits");

const ROOT = __dirname;
const DEFAULT_INPUT = path.join(ROOT, "sample", "1.txt");
const DEFAULT_OUTPUT = path.join(ROOT, "output", "1.lua");
const DEFAULT_AST_OUTPUT = path.join(ROOT, "output", "ast.json");

function parseLua(source, filename = "<input>") {
    try {
        return luaparse.parse(source, {
            luaVersion: "luau",
            comments: true,
            scope: true,
            locations: true,
            ranges: true,
        });
    } catch (error) {
        error.message = `Failed to parse ${filename}: ${error.message}`;
        throw error;
    }
}

function loadAst(inputPath = DEFAULT_INPUT) {
    const absoluteInput = path.resolve(inputPath);
    const source = fs.readFileSync(absoluteInput, "utf8");
    const ast = parseLua(source, absoluteInput);
    return { inputPath: absoluteInput, source, ast };
}

function writeAst(ast, outputPath = DEFAULT_AST_OUTPUT) {
    const absoluteOutput = path.resolve(outputPath);
    fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
    fs.writeFileSync(absoluteOutput, JSON.stringify(ast, null, 2), "utf8");
    return absoluteOutput;
}

function writeSource(source, outputPath = DEFAULT_OUTPUT) {
    const absoluteOutput = path.resolve(outputPath);
    fs.mkdirSync(path.dirname(absoluteOutput), { recursive: true });
    fs.writeFileSync(absoluteOutput, source, "utf8");
    return absoluteOutput;
}

function runDeobfuscator(inputPath = DEFAULT_INPUT, outputPath = DEFAULT_OUTPUT) {
    const loaded = loadAst(inputPath);

    const constantArray = inlinePrometheusConstantArray(loaded.source, loaded.ast);
    const stage1Source = constantArray.found ? constantArray.source : loaded.source;
    const stage1Ast = parseLua(stage1Source, `${inputPath} <after ConstantArray>`);

    const environment = renameEnvironmentBinding(stage1Source, stage1Ast, "_env");
    if (environment.collision) throw new Error(environment.reason);

    // Environment, root createClosure, helper roles, and helper parameters are
    // independent lexical binding edits. Plan all of them from the same AST and
    // apply once. Any ambiguous/colliding case falls back to the proven
    // sequential pipeline below.
    let createClosure;
    let vmHelpers;
    const parallelCreateClosure = renameCreateClosureBinding(stage1Source, stage1Ast, "createClosure");
    const parallelVmHelpers = renameVmHelperBindings(stage1Source, stage1Ast, parseLua, { deferParse: true });
    const canBatchWrapperRenames =
        !parallelCreateClosure.collision &&
        !parallelCreateClosure.ambiguous &&
        parallelCreateClosure.found &&
        parallelVmHelpers.found &&
        parallelVmHelpers.batched === true &&
        Array.isArray(environment.edits) &&
        Array.isArray(parallelCreateClosure.edits) &&
        Array.isArray(parallelVmHelpers.edits);

    if (canBatchWrapperRenames) {
        try {
            const coreEdits = [...environment.edits, ...parallelCreateClosure.edits];
            const combinedEdits = [...coreEdits, ...parallelVmHelpers.edits];
            const createClosureSource = applyTextEdits(stage1Source, coreEdits);
            const helperSource = applyTextEdits(stage1Source, combinedEdits);
            const helperAst = parseLua(helperSource, `${inputPath} <after wrapper/helper rename batch>`);
            createClosure = { ...parallelCreateClosure, source: createClosureSource };
            vmHelpers = { ...parallelVmHelpers, source: helperSource, ast: helperAst, parseDeferred: false };
        } catch {
            createClosure = null;
            vmHelpers = null;
        }
    }

    if (!vmHelpers) {
        const environmentAst = environment.source === stage1Source
            ? stage1Ast
            : parseLua(environment.source, `${inputPath} <after environment rename>`);
        createClosure = renameCreateClosureBinding(environment.source, environmentAst, "createClosure");
        if (createClosure.collision || createClosure.ambiguous) throw new Error(createClosure.reason);
        const createClosureAst = createClosure.source === environment.source
            ? environmentAst
            : parseLua(createClosure.source, `${inputPath} <after createClosure rename>`);
        vmHelpers = renameVmHelperBindings(createClosure.source, createClosureAst, parseLua);
    }
    const semanticNames = vmHelpers.found
        ? renameSemanticBindings(vmHelpers.source, vmHelpers.ast || parseLua(vmHelpers.source, `${inputPath} <before semantic naming>`), parseLua)
        : { source: vmHelpers.source, found: false, applied: false, mapping: [], skipped: [] };
    const semanticNamedSource = semanticNames.applied ? semanticNames.source : vmHelpers.source;
    const semanticNamedAst = semanticNames.applied
        ? parseLua(semanticNamedSource, `${inputPath} <after semantic naming>`)
        : (vmHelpers.ast || null);

    const splitAssignments = splitSafeParallelAssignmentsFully(semanticNamedSource, parseLua, 8, semanticNamedAst);

    const vmStateAst = splitAssignments.ast || parseLua(splitAssignments.source, `${inputPath} <before VM state recovery>`);
    const vmState = recoverVmStateGraph(splitAssignments.source, vmStateAst);
    const vmBindings = recoverVmBindings(splitAssignments.source, vmStateAst, vmState);
    const vmStateApplied = vmState.found && vmState.normalized;
    const normalizedSource = vmStateApplied ? vmState.source : splitAssignments.source;
    const normalizedAst = parseLua(normalizedSource, `${inputPath} <before VM register scheduling>`);
    const registerSchedule = vmStateApplied
        ? scheduleVmRegisterUses(normalizedSource, normalizedAst)
        : { source: normalizedSource, found: false, applied: false, blocksChanged: 0, swaps: 0 };
    const scheduledSource = registerSchedule.applied ? registerSchedule.source : normalizedSource;
    const scheduledAst = parseLua(scheduledSource, `${inputPath} <before VM register naming>`);
    const registerNames = vmStateApplied
        ? renameVmRegisterBindings(scheduledSource, scheduledAst)
        : { source: scheduledSource, found: false, applied: false, mapping: [] };
    const finalSource = registerNames.applied ? registerNames.source : scheduledSource;

    const outputAst = parseLua(finalSource, outputPath);
    const resolvedOutput = writeSource(finalSource, outputPath);

    return {
        ...loaded,
        outputAst,
        outputPath: resolvedOutput,
        outputSource: finalSource,
        constantArray,
        environment,
        createClosure,
        vmHelpers,
        splitAssignments,
        vmState,
        vmBindings,
        registerSchedule,
        registerNames,
        semanticNames,
        vmStateApplied,
    };
}

function main() {
    const inputPath = process.argv[2] || DEFAULT_INPUT;
    const outputPath = process.argv[3] || DEFAULT_OUTPUT;
    const result = runDeobfuscator(inputPath, outputPath);
    const constants = result.constantArray;
    const env = result.environment;
    const createClosure = result.createClosure;
    const vmHelpers = result.vmHelpers;
    const splitAssignments = result.splitAssignments;
    const vmState = result.vmState;
    const vmBindings = result.vmBindings;
    const registerSchedule = result.registerSchedule;
    const registerNames = result.registerNames;
    const semanticNames = result.semanticNames;
    const vmStateApplied = result.vmStateApplied;

    console.log(`Input: ${result.inputPath}`);
    console.log(`AST root: ${result.ast.type}`);
    console.log(`ConstantArray found: ${constants.found}`);
    if (constants.found) {
        console.log(`Constant entries: ${constants.constants.length}`);
        console.log(`Constant references inlined: ${constants.replacements.length}`);
        console.log(`Array rotated: ${constants.rotated}`);
        console.log(`Strings decoded: ${constants.decoded}`);
        console.log(`Prelude removed: ${constants.removedPrelude}`);
        console.log(`Unresolved wrapper uses: ${constants.unresolvedWrapperUses}`);
        console.log(`Unresolved array uses: ${constants.unresolvedArrayUses}`);
    }
    console.log(`Environment binding found: ${env.found}`);
    if (env.found) {
        console.log(`Environment source: ${env.sourceKind}`);
        console.log(`Environment rename: ${env.oldName} -> ${env.newName}`);
        console.log(`Environment references renamed: ${env.referencesRenamed}`);
    }
    console.log(`CreateClosure binding found: ${createClosure.found}`);
    if (createClosure.found) {
        console.log(`CreateClosure rename: ${createClosure.oldName} -> ${createClosure.newName}`);
        console.log(`CreateClosure references renamed: ${createClosure.referencesRenamed}`);
    }
    console.log(`VM helper tracking found: ${vmHelpers.found}`);
    if (vmHelpers.found) {
        for (const item of vmHelpers.renamedRoles) {
            console.log(`VM helper rename: ${item.oldName} -> ${item.newName} (${item.referencesRenamed} refs)`);
        }
        for (const item of vmHelpers.renamedParameters || []) {
            console.log(`VM helper parameter: ${item.role}[${item.index}] ${item.oldName} -> ${item.newName} (${item.referencesRenamed} refs)`);
        }
        for (const item of vmHelpers.skippedRoles) {
            console.log(`VM helper skipped: ${item.role}: ${item.reason}`);
        }
    }
    console.log(`Semantic naming applied: ${semanticNames.applied}`);
    if (semanticNames.applied) {
        if (semanticNames.initialArgsRenamed) console.log(`Semantic name: InitialArgs`);
        if (semanticNames.closureArgumentRenameCount > 0) console.log(`Semantic closure arguments renamed: ${semanticNames.closureArgumentRenameCount}`);
        if (semanticNames.helperLocalRenameCount > 0) console.log(`Semantic helper locals renamed: ${semanticNames.helperLocalRenameCount}`);
        if (semanticNames.registerOverflowRenamed) console.log(`Semantic name: RegisterOverflow`);
    }
    if ((semanticNames.skipped || []).length > 0) console.log(`Semantic naming skips: ${semanticNames.skipped.length}`);
    console.log(`Safe parallel statements split: ${splitAssignments.statementsSplit}`);
    console.log(`Individual assignments produced: ${splitAssignments.assignmentsProduced}`);
    console.log(`VM state recovery found: ${vmState.found}`);
    console.log(`VM state recovery applied: ${vmStateApplied}`);
    if (vmState.found) {
        console.log(`VM dispatcher leaves: ${vmState.resolvedLeafCount}/${vmState.dispatcherLeafCount}`);
        if (vmState.prunedDispatcherLeafCount > 0) {
            console.log(`VM unreachable dispatcher leaves pruned: ${vmState.prunedDispatcherLeafCount}`);
        }
        if (vmState.ignoredUnreachableClosureEntryCount > 0) {
            console.log(`VM unreachable closure entry calls ignored: ${vmState.ignoredUnreachableClosureEntryCount}`);
        }
        console.log(`VM state IDs normalized: ${vmState.normalized}`);
        if (vmState.normalized) {
            for (const group of vmState.normalization.groups) {
                console.log(`VM state range: ${group.root.factory} ${group.min}-${group.max} (entry ${group.entryNewId})`);
            }
        }
    }
    console.log(`VM register scheduling applied: ${registerSchedule.applied}`);
    if (registerSchedule.applied) {
        console.log(`VM register scheduling: ${registerSchedule.blocksChanged} blocks, ${registerSchedule.swaps} dependency-safe swaps`);
        if (registerSchedule.unreadSinks > 0) {
            console.log(`VM unread register writes sunk: ${registerSchedule.unreadSinks}`);
        }
        if (registerSchedule.directStateTransitionMoves > 0) {
            console.log(`VM direct numeric state transitions moved to tail: ${registerSchedule.directStateTransitionMoves}`);
        }
        if (registerSchedule.overflowRegisterBank) {
            console.log(`VM overflow register scheduling: ${registerSchedule.overflowRegisterSlots} slots`);
        }
        if (registerSchedule.safetyRejectedSegments > 0) {
            console.log(`VM register scheduling safety rejections: ${registerSchedule.safetyRejectedSegments}`);
        }
    }
    console.log(`VM register naming applied: ${registerNames.applied}`);
    if (registerNames.applied) {
        console.log(`VM return register: ${registerNames.returnRegisterOldName} -> ${registerNames.returnRegisterName}`);
        console.log(`VM temporary registers renamed: ${registerNames.temporaryRegisterCount}`);
    } else if (registerNames.found && registerNames.reason) {
        console.log(`VM register naming skipped: ${registerNames.reason}`);
    }
    console.log(`VM binding analysis found: ${vmBindings.found}`);
    if (vmBindings.found) {
        console.log(`VM functions analyzed: ${vmBindings.functionCount}`);
        console.log(`VM reaching definitions: ${vmBindings.definitions.length} defs, ${vmBindings.uniqueUseCount}/${vmBindings.uses.length} unique uses`);
        console.log(`VM value provenance: env=${vmBindings.environmentReferenceDefinitions.length}, register=${vmBindings.registerValueDefinitions.length}, external=${vmBindings.externalReferenceDefinitions.length}, unknown=${vmBindings.unknownValueDefinitions.length}`);
        console.log(`VM ordinary register epochs: ${vmBindings.ordinaryRegisterEpochs.length}, eligible defs: ${vmBindings.ordinaryRegisterEpochStats.eligibleDefinitionCount}, merged defs: ${vmBindings.ordinaryRegisterEpochStats.mergedDefinitionCount}`);
        console.log(`VM definition lifetimes: ${vmBindings.definitionLifetimes.length}, joins: ${vmBindings.definitionJoinGroups.length}, cross-block: ${vmBindings.crossBlockLifetimeCount}, loop-carried: ${vmBindings.loopCarriedLifetimeCount}`);
        console.log(`VM binding-end candidates: ${vmBindings.bindingEndCandidates.length}, ownership handoffs: ${vmBindings.ownershipHandoffCandidates.length}`);
        console.log(`VM capture slots: ${vmBindings.captures.length}, local cells: ${vmBindings.localCells.length}, shared cells: ${vmBindings.sharedLocalCells.length}`);
        console.log(`VM upvalue cell accesses: ${vmBindings.resolvedCellAccessCount}/${vmBindings.cellAccesses.length} resolved`);
        console.log(`VM captured binding candidates: ${vmBindings.capturedBindingCandidates.length}, cell graph complete: ${vmBindings.cellGraphComplete}`);
    }
    console.log(`Output: ${result.outputPath}`);
    return result;
}

if (require.main === module) main();

module.exports = {
    parseLua,
    loadAst,
    writeAst,
    writeSource,
    runDeobfuscator,
    main,
};
