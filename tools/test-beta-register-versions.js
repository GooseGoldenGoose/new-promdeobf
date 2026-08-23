const assert = require("assert");
const { parseLua } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");

const source = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            ReturnVal = "warn"
            state = _env[ReturnVal]
            r1 = "gg"
            ReturnVal = state(r1)
            r2 = args
            ReturnVal = 1
            state = r1 == ReturnVal
            state = state and 2 or 3
        end
        if state == 2 then
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end`;

const result = versionVmBlockRegisters(source, parseLua(source, "<beta-register-test>"));
assert.equal(result.found, true);
assert.equal(result.applied, true);
assert.equal(result.blockCount, 2);
assert.equal(result.versionedAssignmentCount, 7);
assert.equal(result.preservedFinalWrites, 3);
assert.equal(result.skippedAssignments, 0);
assert.deepEqual(result.mapping, [
    { originalName: "ReturnVal", baseName: "r_v1" },
    { originalName: "state", baseName: "r_v2" },
    { originalName: "r1", baseName: "r_v3" },
    { originalName: "r2", baseName: "r_v4" },
]);
assert(result.source.includes('local r_v1_1 = "warn"'));
assert(result.source.includes("local r_v2_1 = _env[r_v1_1]"));
assert(result.source.includes('local r_v3_1 = "gg"'));
assert(result.source.includes("local r_v1_2 = r_v2_1(r_v3_1)"));
assert(result.source.includes("local r_v4_1 = args"));
assert(result.source.includes("local r_v1_3 = 1"));
assert(result.source.includes("local r_v2_2 = r_v3_1 == r_v1_3"));
assert(result.source.includes("state = r_v2_2 and 2 or 3"));
assert(result.source.includes("ReturnVal = {}"));
assert(result.source.includes("state = nil"));
assert(!result.source.includes("local r_v1_4 = {}"));
parseLua(result.source, "<beta-register-test-output>");

const crossStateSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r2 = 3123
            state = flag and 2 or 3
        end
        if state == 2 then
            ReturnVal = consume(r2)
            r2 = 3
            state = 3
        end
        if state == 3 then
            ReturnVal = consume2(r2)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const crossStateResult = versionVmBlockRegisters(
    crossStateSource,
    parseLua(crossStateSource, "<beta-cross-state-test>")
);
assert.equal(crossStateResult.found, true);
assert.equal(crossStateResult.applied, true);
assert.equal(crossStateResult.cfgComplete, true);
assert.equal(crossStateResult.crossBlockVersionCount, 1);
assert(crossStateResult.source.includes("local r_v1_1 = 3123"));
assert.equal((crossStateResult.source.match(/local r_v1_1/g) || []).length, 1);
assert(crossStateResult.source.includes("consume(r_v1_1)"));
assert(crossStateResult.source.includes("consume2(r_v1_1)"));
assert(!crossStateResult.source.includes("consume2(r2)"));
assert(!crossStateResult.source.includes("consume2(r_v1_2)"));
parseLua(crossStateResult.source, "<beta-cross-state-test-output>");
const lifetimeSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = r1
            state = 2
        end
        if state == 2 then
            ReturnVal = consume(r2)
            r1 = 20
            r2 = r1
            state = 3
        end
        if state == 3 then
            ReturnVal = consume2(r2)
            r2 = nil
            state = 4
        end
        if state == 4 then
            r1 = 30
            r2 = r1
            ReturnVal = consume3(r2)
            r2 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const lifetimeResult = versionVmBlockRegisters(
    lifetimeSource,
    parseLua(lifetimeSource, "<beta-lifetime-test>")
);
assert.equal(lifetimeResult.found, true);
assert.equal(lifetimeResult.applied, true);
assert.equal(lifetimeResult.cfgComplete, true);
const r2Base = lifetimeResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(r2Base);
assert(lifetimeResult.source.includes(`local ${r2Base}_1 = r_v1_1`) || lifetimeResult.source.includes(`local ${r2Base}_1 = r_v2_1`) || lifetimeResult.source.includes(`local ${r2Base}_1 = r_v3_1`));
assert(lifetimeResult.source.includes(`consume(${r2Base}_1)`));
assert(lifetimeResult.source.match(new RegExp(`${r2Base}_1 = r_v\\d+_\\d+`)));
assert(lifetimeResult.source.includes(`consume2(${r2Base}_1)`));
assert(lifetimeResult.source.includes(`${r2Base}_1 = nil`));
assert(lifetimeResult.source.match(new RegExp(`local ${r2Base}_2 = r_v\\d+_\\d+`)));
assert(lifetimeResult.source.includes(`consume3(${r2Base}_2)`));
assert(lifetimeResult.source.includes(`${r2Base}_2 = nil`));
assert(!lifetimeResult.source.includes(`local ${r2Base}_1 = 20`));
parseLua(lifetimeResult.source, "<beta-lifetime-test-output>");

const scratchBoundarySource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r2 = "scratch"
            ReturnVal = consume(r2)
            ReturnVal = nil
            r2 = ReturnVal
            ReturnVal = consume2(r2)
            ReturnVal = 6
            r2 = ReturnVal
            ReturnVal = consume3(r2)
            r2 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const scratchBoundaryResult = versionVmBlockRegisters(
    scratchBoundarySource,
    parseLua(scratchBoundarySource, "<beta-scratch-boundary-test>")
);
const scratchR2Base = scratchBoundaryResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(scratchR2Base);
assert(scratchBoundaryResult.source.includes(`local ${scratchR2Base}_1 = "scratch"`));
assert(scratchBoundaryResult.source.match(new RegExp(`local ${scratchR2Base}_2 = r_v\\d+_\\d+`)));
assert.equal((scratchBoundaryResult.source.match(new RegExp(`${scratchR2Base}_2 =`, "g")) || []).length, 3);
assert(scratchBoundaryResult.source.includes(`${scratchR2Base}_2 = nil`));
assert(!scratchBoundaryResult.source.includes(`${scratchR2Base}_1 = nil`));
assert(scratchBoundaryResult.lifetimeAnalysisStats.provenCleanupCount >= 1);
parseLua(scratchBoundaryResult.source, "<beta-scratch-boundary-test-output>");

const compilerReturnPayloadSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = produce()
            observe()
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const compilerReturnPayloadResult = versionVmBlockRegisters(
    compilerReturnPayloadSource,
    parseLua(compilerReturnPayloadSource, "<beta-compiler-return-payload-test>")
);
assert(compilerReturnPayloadResult.source.includes("ReturnVal = { r_v1_1 }"));
assert(!compilerReturnPayloadResult.source.match(/local r_v\d+_\d+ = \{ r_v1_1 \}/));
const compilerReturnPayloadGraph = compilerReturnPayloadResult.graph.states[0].operations.find(
    operation => operation.kind === "return-payload"
);
assert(compilerReturnPayloadGraph?.terminalCompilerReturnPayload === true);

const effectfulReturnPayloadSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = "x"
            ReturnVal = { mark("table") }
            mark("after")
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const effectfulReturnPayloadResult = versionVmBlockRegisters(
    effectfulReturnPayloadSource,
    parseLua(effectfulReturnPayloadSource, "<beta-effectful-return-payload-test>")
);
assert(!effectfulReturnPayloadResult.graph.states[0].operations.some(operation => operation.kind === "return-payload"));
assert(effectfulReturnPayloadResult.source.indexOf('{ mark("table") }') < effectfulReturnPayloadResult.source.indexOf('mark("after")'));
parseLua(effectfulReturnPayloadResult.source, "<beta-effectful-return-payload-output>");

const returnedLocalSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 3
            r2 = r1
            ReturnVal = "print"
            state = _env[ReturnVal]
            ReturnVal = state(r2)
            r1 = 4
            r2 = r1
            ReturnVal = { r2 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const returnedLocalResult = versionVmBlockRegisters(
    returnedLocalSource,
    parseLua(returnedLocalSource, "<beta-returned-local-test>")
);
const returnedR2Base = returnedLocalResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(returnedR2Base);
assert.equal((returnedLocalResult.source.match(new RegExp("local " + returnedR2Base + "_1\\b", "g")) || []).length, 1);
assert(returnedLocalResult.source.match(new RegExp("\\n\\s*" + returnedR2Base + "_1 = r_v\\d+_\\d+")));
assert(returnedLocalResult.source.includes("ReturnVal = { " + returnedR2Base + "_1 }"));
assert(!returnedLocalResult.source.includes(returnedR2Base + "_2"));
assert(returnedLocalResult.lifetimeAnalysisStats.terminalReturnAnchorCount >= 1);
assert(returnedLocalResult.lifetimeAnalysisStats.terminalReturnCopyMergeCount >= 1);
parseLua(returnedLocalResult.source, "<beta-returned-local-output>");

const terminalPlacementSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = "x"
            ReturnVal = {}
            mark("after")
            r1 = nil
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const terminalPlacementResult = versionVmBlockRegisters(
    terminalPlacementSource,
    parseLua(terminalPlacementSource, "<beta-terminal-placement-test>")
);
assert.equal(terminalPlacementResult.terminalReturnPlacementMoves, 1);
const terminalMarkIndex = terminalPlacementResult.source.indexOf('mark("after")');
const terminalPayloadIndex = terminalPlacementResult.source.indexOf('ReturnVal = {}');
const terminalStopIndex = terminalPlacementResult.source.indexOf('state = nil');
assert(terminalMarkIndex >= 0 && terminalMarkIndex < terminalPayloadIndex);
assert(terminalPayloadIndex < terminalStopIndex);
const terminalOps = terminalPlacementResult.graph.states[0].operations;
assert.equal(terminalOps[terminalOps.length - 2].kind, "return-payload");
assert.equal(terminalOps[terminalOps.length - 1].kind, "state-transition");
parseLua(terminalPlacementResult.source, "<beta-terminal-placement-output>");

const unsafeNonEmptyPlacementSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = produce()
            ReturnVal = { r1 }
            mark("after")
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const unsafeNonEmptyPlacementResult = versionVmBlockRegisters(
    unsafeNonEmptyPlacementSource,
    parseLua(unsafeNonEmptyPlacementSource, "<beta-unsafe-nonempty-placement-test>")
);
assert.equal(unsafeNonEmptyPlacementResult.terminalReturnPlacementMoves, 0);
assert(
    unsafeNonEmptyPlacementResult.source.indexOf('ReturnVal = { r_v1_1 }') <
    unsafeNonEmptyPlacementResult.source.indexOf('mark("after")')
);
parseLua(unsafeNonEmptyPlacementResult.source, "<beta-unsafe-nonempty-placement-output>");

const indexedAssignmentReadSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = allocUpvalue()
            state = 123
            upvalueValues[r1] = state
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const indexedAssignmentReadResult = versionVmBlockRegisters(
    indexedAssignmentReadSource,
    parseLua(indexedAssignmentReadSource, "<beta-indexed-assignment-read-test>")
);
const indexedR1Base = indexedAssignmentReadResult.mapping.find(item => item.originalName === "r1")?.baseName;
const indexedStateBase = indexedAssignmentReadResult.mapping.find(item => item.originalName === "state")?.baseName;
assert(indexedR1Base && indexedStateBase);
assert.equal(indexedAssignmentReadResult.skippedAssignments, 1);
assert(indexedAssignmentReadResult.source.includes(`upvalueValues[${indexedR1Base}_1] = ${indexedStateBase}_1`));
assert(!indexedAssignmentReadResult.source.includes("upvalueValues[r1] = state"));
const indexedUnsupported = indexedAssignmentReadResult.graph.states[0].operations.find(operation =>
    operation.kind === "unsupported" && String(operation.originalText || "").includes("upvalueValues[")
);
assert(indexedUnsupported);
assert(indexedUnsupported.reads.includes(`${indexedR1Base}_1`));
assert(indexedUnsupported.reads.includes(`${indexedStateBase}_1`));
assert(indexedUnsupported.emittedText.includes(`upvalueValues[${indexedR1Base}_1] = ${indexedStateBase}_1`));
parseLua(indexedAssignmentReadResult.source, "<beta-indexed-assignment-read-output>");

console.log("beta register versioning tests passed");
