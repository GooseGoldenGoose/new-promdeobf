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

    const environmentAst = parseLua(environment.source, `${inputPath} <after environment rename>`);
    const createClosure = renameCreateClosureBinding(environment.source, environmentAst, "createClosure");
    if (createClosure.collision || createClosure.ambiguous) throw new Error(createClosure.reason);

    const createClosureAst = parseLua(createClosure.source, `${inputPath} <after createClosure rename>`);
    const vmHelpers = renameVmHelperBindings(createClosure.source, createClosureAst, parseLua);

    const splitAssignments = splitSafeParallelAssignmentsFully(vmHelpers.source, parseLua);

    const vmStateAst = parseLua(splitAssignments.source, `${inputPath} <before VM state recovery>`);
    const vmState = recoverVmStateGraph(splitAssignments.source, vmStateAst);
    const vmBindings = recoverVmBindings(splitAssignments.source, vmStateAst, vmState);
    const vmStateApplied = vmState.found && vmState.normalized;
    const finalSource = vmStateApplied ? vmState.source : splitAssignments.source;

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
    console.log(`Safe parallel statements split: ${splitAssignments.statementsSplit}`);
    console.log(`Individual assignments produced: ${splitAssignments.assignmentsProduced}`);
    console.log(`VM state recovery found: ${vmState.found}`);
    console.log(`VM state recovery applied: ${vmStateApplied}`);
    if (vmState.found) {
        console.log(`VM dispatcher leaves: ${vmState.resolvedLeafCount}/${vmState.dispatcherLeafCount}`);
        if (vmState.prunedDispatcherLeafCount > 0) {
            console.log(`VM unreachable dispatcher leaves pruned: ${vmState.prunedDispatcherLeafCount}`);
        }
        console.log(`VM state IDs normalized: ${vmState.normalized}`);
        if (vmState.normalized) {
            for (const group of vmState.normalization.groups) {
                console.log(`VM state range: ${group.root.factory} ${group.min}-${group.max} (entry ${group.entryNewId})`);
            }
        }
    }
    console.log(`VM binding analysis found: ${vmBindings.found}`);
    if (vmBindings.found) {
        console.log(`VM functions analyzed: ${vmBindings.functionCount}`);
        console.log(`VM reaching definitions: ${vmBindings.definitions.length} defs, ${vmBindings.uniqueUseCount}/${vmBindings.uses.length} unique uses`);
        console.log(`VM capture slots: ${vmBindings.captures.length}, local cells: ${vmBindings.localCells.length}, shared cells: ${vmBindings.sharedLocalCells.length}`);
        console.log(`VM upvalue cell accesses: ${vmBindings.resolvedCellAccessCount}/${vmBindings.cellAccesses.length} resolved`);
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
