const assert = require("assert");
const { parseLua } = require("../main");
const { versionVmBlockRegisters, finalizeBetaRegisterUpvalues, finalizeBetaRegisterSchedule, finalizeBetaDeadStateSnapshots, finalizeBetaDeadStateInitializers, finalizeBetaDeadRegisterClears, finalizeBetaWhitespaceCleanup } = require("../passes/beta-register-versions");

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

const scratchFanInSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, ReturnVal
    while state do
        if state == 1 then
            r1 = allocA()
            r2 = r1
            r1 = allocB()
            r3 = r1
            r1 = build(r2, r3)
            ReturnVal = consume(r1)
            r1 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const scratchFanInResult = versionVmBlockRegisters(
    scratchFanInSource,
    parseLua(scratchFanInSource, "<beta-scratch-fanin-test>")
);
const scratchFanInBase = scratchFanInResult.mapping.find(item => item.originalName === "r1")?.baseName;
assert(scratchFanInBase);
assert(scratchFanInResult.source.includes(`local ${scratchFanInBase}_1 = allocA()`));
assert(scratchFanInResult.source.includes(`local ${scratchFanInBase}_2 = allocB()`));
assert(scratchFanInResult.source.includes(`local ${scratchFanInBase}_3 = build(`));
assert(scratchFanInResult.source.includes(`${scratchFanInBase}_3 = nil`));
assert(!scratchFanInResult.source.includes(`${scratchFanInBase}_1 = allocB()`));
parseLua(scratchFanInResult.source, "<beta-scratch-fanin-test-output>");

const transitiveScratchReuseSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = seed
            r2 = transform(r1)
            r1 = r2
            consume(r1)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const transitiveScratchReuseResult = versionVmBlockRegisters(
    transitiveScratchReuseSource,
    parseLua(transitiveScratchReuseSource, "<beta-transitive-scratch-reuse-test>")
);
const transitiveScratchBase = transitiveScratchReuseResult.mapping.find(item => item.originalName === "r1")?.baseName;
assert(transitiveScratchBase);
assert(transitiveScratchReuseResult.source.includes(`local ${transitiveScratchBase}_1 = seed`));
assert(transitiveScratchReuseResult.source.match(new RegExp(`local ${transitiveScratchBase}_2 = r_v\\d+_\\d+`)));
assert(!transitiveScratchReuseResult.source.includes(`${transitiveScratchBase}_1 = r_v`));
parseLua(transitiveScratchReuseResult.source, "<beta-transitive-scratch-reuse-output>");

const cleanupAnchoredCallReuseSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 2
            r2 = 1
            ReturnVal = call(r2, r1)
            r2 = ReturnVal
            ReturnVal = consume(r2)
            r2 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const cleanupAnchoredCallReuseResult = versionVmBlockRegisters(
    cleanupAnchoredCallReuseSource,
    parseLua(cleanupAnchoredCallReuseSource, "<beta-cleanup-call-reuse-test>")
);
const cleanupCallR2Base = cleanupAnchoredCallReuseResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(cleanupCallR2Base);
assert(cleanupAnchoredCallReuseResult.source.includes(`local ${cleanupCallR2Base}_1 = 1`));
assert(cleanupAnchoredCallReuseResult.source.match(new RegExp(`local ${cleanupCallR2Base}_2 = r_v\\d+_\\d+`)));
assert(cleanupAnchoredCallReuseResult.source.includes(`consume(${cleanupCallR2Base}_2)`));
assert(cleanupAnchoredCallReuseResult.source.includes(`${cleanupCallR2Base}_2 = nil`));
assert(!cleanupAnchoredCallReuseResult.source.includes(`${cleanupCallR2Base}_1 = r_v`));
parseLua(cleanupAnchoredCallReuseResult.source, "<beta-cleanup-call-reuse-output>");

const cleanupAnchoredPackedCallReuseSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, ReturnVal
    while state do
        if state == 1 then
            r1 = "tostring"
            r3 = _env[r1]
            r1 = {}
            r2 = { call(r3, r1) }
            ReturnVal = r2[1]
            r3 = ReturnVal
            ReturnVal = consume(r3)
            r3 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const cleanupAnchoredPackedCallReuseResult = versionVmBlockRegisters(
    cleanupAnchoredPackedCallReuseSource,
    parseLua(cleanupAnchoredPackedCallReuseSource, "<beta-cleanup-packed-call-reuse-test>")
);
const cleanupPackedCallR3Base = cleanupAnchoredPackedCallReuseResult.mapping.find(item => item.originalName === "r3")?.baseName;
assert(cleanupPackedCallR3Base);
assert(cleanupAnchoredPackedCallReuseResult.source.includes(`local ${cleanupPackedCallR3Base}_1 =`));
assert(cleanupAnchoredPackedCallReuseResult.source.match(new RegExp(`local ${cleanupPackedCallR3Base}_2 = r_v\\d+_\\d+`)));
assert(cleanupAnchoredPackedCallReuseResult.source.includes(`consume(${cleanupPackedCallR3Base}_2)`));
assert(cleanupAnchoredPackedCallReuseResult.source.includes(`${cleanupPackedCallR3Base}_2 = nil`));
assert(!cleanupAnchoredPackedCallReuseResult.source.includes(`${cleanupPackedCallR3Base}_1 = r_v`));
parseLua(cleanupAnchoredPackedCallReuseResult.source, "<beta-cleanup-packed-call-reuse-output>");

const cleanupAnchoredArithmeticReuseSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = r1 + 1
            r1 = r2
            ReturnVal = consume(r1)
            r1 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const cleanupAnchoredArithmeticReuseResult = versionVmBlockRegisters(
    cleanupAnchoredArithmeticReuseSource,
    parseLua(cleanupAnchoredArithmeticReuseSource, "<beta-cleanup-arithmetic-reuse-test>")
);
const cleanupArithmeticR1Base = cleanupAnchoredArithmeticReuseResult.mapping.find(item => item.originalName === "r1")?.baseName;
assert(cleanupArithmeticR1Base);
assert(cleanupAnchoredArithmeticReuseResult.source.includes(`local ${cleanupArithmeticR1Base}_1 = 10`));
assert(cleanupAnchoredArithmeticReuseResult.source.match(new RegExp(`${cleanupArithmeticR1Base}_1 = r_v\\d+_\\d+`)));
assert(cleanupAnchoredArithmeticReuseResult.source.includes(`consume(${cleanupArithmeticR1Base}_1)`));
assert(cleanupAnchoredArithmeticReuseResult.source.includes(`${cleanupArithmeticR1Base}_1 = nil`));
parseLua(cleanupAnchoredArithmeticReuseResult.source, "<beta-cleanup-arithmetic-reuse-output>");



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
            r1.value = state
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
assert.equal(indexedAssignmentReadResult.skippedAssignments, 0);
assert.equal(indexedAssignmentReadResult.orderedEffectWriteCount, 2);
assert(indexedAssignmentReadResult.source.includes(`upvalueValues[${indexedR1Base}_1] = ${indexedStateBase}_1`));
assert(!indexedAssignmentReadResult.source.includes("upvalueValues[r1] = state"));
const indexedEffect = indexedAssignmentReadResult.graph.states[0].operations.find(operation =>
    operation.kind === "effect-write" && String(operation.originalText || "").includes("upvalueValues[")
);
assert(indexedEffect);
assert(indexedEffect.reads.includes(`${indexedR1Base}_1`));
assert(indexedEffect.reads.includes(`${indexedStateBase}_1`));
assert(indexedEffect.emittedText.includes(`upvalueValues[${indexedR1Base}_1] = ${indexedStateBase}_1`));
const memberEffect = indexedAssignmentReadResult.graph.states[0].operations.find(operation =>
    operation.kind === "effect-write" && String(operation.originalText || "").includes(".value")
);
assert(memberEffect);
assert(memberEffect.emittedText.includes(`${indexedR1Base}_1.value = ${indexedStateBase}_1`));
parseLua(indexedAssignmentReadResult.source, "<beta-indexed-assignment-read-output>");

const ambiguousIndexedWriteSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = 5
            state = 9
            upvalueValues[r1], r1.value = state, state
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const ambiguousIndexedWriteResult = versionVmBlockRegisters(
    ambiguousIndexedWriteSource,
    parseLua(ambiguousIndexedWriteSource, "<beta-ambiguous-indexed-write-test>")
);
assert.equal(ambiguousIndexedWriteResult.orderedEffectWriteCount, 0);
assert.equal(ambiguousIndexedWriteResult.skippedAssignments, 1);
assert(ambiguousIndexedWriteResult.graph.states[0].operations.some(operation => operation.kind === "unsupported"));

const splitLoopSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, r4, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = r1
            r1 = 1
            r3 = r1
            r1 = 0
            r4 = r3 < r1
            ReturnVal = 1
            r1 = ReturnVal - r3
            state = 2
        end
        if state == 2 then
            ReturnVal = not r4
            r1 = r1 + r3
            r4 = r1 <= r2
            r2 = 3
            state = r4 and r2
            r3 = 4
            state = state or r3
        end
        if state == 3 then
            ReturnVal = consume(r1)
            state = 2
        end
        if state == 4 then
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const splitLoopResult = versionVmBlockRegisters(
    splitLoopSource,
    parseLua(splitLoopSource, "<beta-split-loop-test>")
);
assert.equal(splitLoopResult.cfgComplete, true);
assert(splitLoopResult.crossBlockVersionCount >= 4);
assert.equal(splitLoopResult.prunedPhysicalRegisterDeclarations, 4);
assert(!/\br[1-4]\b/.test(splitLoopResult.source));
assert(splitLoopResult.source.includes("state = r_v"));
parseLua(splitLoopResult.source, "<beta-split-loop-output>");


const atomicMultiCallSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, r4, ReturnVal
    while state do
        if state == 1 then
            r1 = iterator
            r2 = seed
            state = 2
        end
        if state == 2 then
            r2, r4 = r1(args, r2)
            state = r2 and 3 or 4
        end
        if state == 3 then
            r3 = r2
            consume(r3, r4)
            r3 = nil
            r4 = nil
            state = 2
        end
        if state == 4 then
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const atomicMultiCallResult = versionVmBlockRegisters(
    atomicMultiCallSource,
    parseLua(atomicMultiCallSource, "<beta-atomic-multi-call-test>")
);
assert.equal(atomicMultiCallResult.skippedAssignments, 0);
const atomicMultiCallOperation = atomicMultiCallResult.graph.states.find(state => state.id === 2).operations.find(operation => operation.kind === "multi-call-write");
assert(atomicMultiCallOperation);
assert.deepEqual(atomicMultiCallOperation.originalTargets, ["r2", "r4"]);
assert.equal(atomicMultiCallOperation.callBaseOriginal, "r1");
assert.deepEqual(atomicMultiCallOperation.callArgumentOriginals, ["args", "r2"]);
assert.equal(atomicMultiCallOperation.emittedTargets.length, 2);
assert.notDeepEqual(atomicMultiCallOperation.emittedTargets, atomicMultiCallOperation.originalTargets);
assert.deepEqual(atomicMultiCallOperation.targetDeclarations, [false, true]);
assert(atomicMultiCallOperation.targetRegisterEpochs.every(Boolean));
assert(atomicMultiCallOperation.rhs.includes(atomicMultiCallOperation.emittedTargets[0]));
assert.equal((atomicMultiCallOperation.emittedText.match(/iterator/g) || []).length, 0);
assert.equal((atomicMultiCallOperation.emittedText.match(/\(/g) || []).length >= 1, true);
assert(atomicMultiCallOperation.emittedText.startsWith(`${atomicMultiCallOperation.emittedTargets.join(", ")} =`));
assert(atomicMultiCallResult.source.includes(`local ${atomicMultiCallOperation.emittedTargets[1]}\n${atomicMultiCallOperation.emittedTargets.join(", ")} =`));
parseLua(atomicMultiCallResult.source, "<beta-atomic-multi-call-output>");


const compoundEffectSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = cellKey
            r2 = 1
            upvalueValues[r1] += r2
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const compoundEffectResult = versionVmBlockRegisters(
    compoundEffectSource,
    parseLua(compoundEffectSource, "<beta-compound-effect-write-test>")
);
assert.equal(compoundEffectResult.skippedAssignments, 0);
assert.equal(compoundEffectResult.orderedEffectWriteCount, 1);
const compoundEffectOperation = compoundEffectResult.graph.states[0].operations.find(operation =>
    operation.kind === "effect-write" && String(operation.originalText || "").includes("+=")
);
assert(compoundEffectOperation);
const compoundR1Base = compoundEffectResult.mapping.find(item => item.originalName === "r1")?.baseName;
const compoundR2Base = compoundEffectResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(compoundR1Base && compoundR2Base);
assert(compoundEffectOperation.emittedText.includes(`upvalueValues[${compoundR1Base}_1] += ${compoundR2Base}_1`));
parseLua(compoundEffectResult.source, "<beta-compound-effect-write-output>");

const liveNilJoinSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = nil
            state = cond and 2 or 3
        end
        if state == 2 then
            r1 = make()
            state = 3
        end
        if state == 3 then
            r2 = r1
            ReturnVal = { r2 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const liveNilJoinResult = versionVmBlockRegisters(
    liveNilJoinSource,
    parseLua(liveNilJoinSource, "<beta-live-nil-join-test>")
);
const liveNilStart = liveNilJoinResult.graph.states.find(state => state.id === 1).operations.find(operation => operation.originalTarget === "r1");
const liveNilMutation = liveNilJoinResult.graph.states.find(state => state.id === 2).operations.find(operation => operation.originalTarget === "r1");
assert(liveNilStart && liveNilMutation);
assert.equal(liveNilStart.kind, "epoch-start");
assert.equal(liveNilMutation.kind, "epoch-mutate");
assert.equal(liveNilStart.emittedTarget, liveNilMutation.emittedTarget);
assert.equal(liveNilStart.registerEpoch, liveNilMutation.registerEpoch);
assert.equal(liveNilStart.rhs, "nil");
assert.equal(liveNilMutation.rhs, "make()");
parseLua(liveNilJoinResult.source, "<beta-live-nil-join-output>");

const scalarCompoundSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = 2
            r1 += r2
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const scalarCompoundResult = versionVmBlockRegisters(
    scalarCompoundSource,
    parseLua(scalarCompoundSource, "<beta-scalar-compound-test>")
);
assert.equal(scalarCompoundResult.nativeCompoundWriteCount, 1);
assert.equal(scalarCompoundResult.lifetimeAnalysisStats.compoundMutationMergeCount, 1);
assert(scalarCompoundResult.source.includes("+="));
assert(!/\br1\s*\+=/.test(scalarCompoundResult.source));
const scalarCompoundR1Base = scalarCompoundResult.mapping.find(item => item.originalName === "r1")?.baseName;
const scalarCompoundR2Base = scalarCompoundResult.mapping.find(item => item.originalName === "r2")?.baseName;
assert(scalarCompoundR1Base && scalarCompoundR2Base);
const scalarCompoundOps = scalarCompoundResult.graph.states[0].operations;
const scalarCompoundStart = scalarCompoundOps.find(operation => operation.originalTarget === "r1" && operation.kind === "epoch-start");
const scalarCompoundMutation = scalarCompoundOps.find(operation => operation.compoundOperator === "+");
assert(scalarCompoundStart && scalarCompoundMutation);
assert.equal(scalarCompoundMutation.kind, "epoch-mutate");
assert.equal(scalarCompoundMutation.emittedTarget, scalarCompoundStart.emittedTarget);
assert.equal(scalarCompoundMutation.registerEpoch, scalarCompoundStart.registerEpoch);
assert.equal(scalarCompoundMutation.emittedText, `${scalarCompoundStart.emittedTarget} += ${scalarCompoundR2Base}_1`);
parseLua(scalarCompoundResult.source, "<beta-scalar-compound-output>");

for (const compoundOperator of ["+=", "-=", "*=", "/=", "//=", "%=", "^=", "..="]) {
    const operatorSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = 2
            r1 ${compoundOperator} r2
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
    const operatorResult = versionVmBlockRegisters(
        operatorSource,
        parseLua(operatorSource, `<beta-native-compound-${compoundOperator}>`)
    );
    assert.equal(operatorResult.nativeCompoundWriteCount, 1);
    assert(operatorResult.source.includes(compoundOperator));
    assert(operatorResult.graph.states[0].operations.some(operation =>
        operation.kind === "epoch-mutate" && operation.emittedText.includes(compoundOperator)
    ));
    parseLua(operatorResult.source, `<beta-native-compound-output-${compoundOperator}>`);
}

const compoundJoinSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            state = flag and 2 or 3
        end
        if state == 2 then
            r1 = 20
            state = 4
        end
        if state == 3 then
            r1 = 30
            state = 4
        end
        if state == 4 then
            r1 -= 1
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const compoundJoinResult = versionVmBlockRegisters(
    compoundJoinSource,
    parseLua(compoundJoinSource, "<beta-native-compound-join>")
);
assert.equal(compoundJoinResult.nativeCompoundWriteCount, 1);
const compoundJoinMutation = compoundJoinResult.graph.states.find(state => state.id === 4).operations.find(operation => operation.compoundOperator === "-");
assert(compoundJoinMutation);
assert.equal(compoundJoinMutation.kind, "epoch-mutate");
assert(compoundJoinMutation.emittedText.includes("-="));
assert(!/\br1\s*-=/.test(compoundJoinResult.source));
parseLua(compoundJoinResult.source, "<beta-native-compound-join-output>");


const complexCompoundTargetSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, ReturnVal
    while state do
        if state == 1 then
            r1 = bucket
            r2 = indexValue
            r3 = delta
            r1[getIndex(r2)] += r3
            r1.value *= r2
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const complexCompoundTargetResult = versionVmBlockRegisters(
    complexCompoundTargetSource,
    parseLua(complexCompoundTargetSource, "<beta-complex-compound-target-test>")
);
assert.equal(complexCompoundTargetResult.orderedEffectWriteCount, 2);
const complexCompoundOps = complexCompoundTargetResult.graph.states[0].operations.filter(operation => operation.kind === "effect-write");
assert.equal(complexCompoundOps.length, 2);
const indexedCompoundOp = complexCompoundOps.find(operation => String(operation.originalText).includes("getIndex"));
const memberCompoundOp = complexCompoundOps.find(operation => String(operation.originalText).includes(".value"));
assert(indexedCompoundOp && memberCompoundOp);
assert.equal((indexedCompoundOp.emittedText.match(/getIndex\(/g) || []).length, 1);
assert(indexedCompoundOp.emittedText.includes("+="));
assert(memberCompoundOp.emittedText.includes("*="));
assert(indexedCompoundOp.reads.length >= 3);
assert(memberCompoundOp.reads.length >= 2);
parseLua(complexCompoundTargetResult.source, "<beta-complex-compound-target-output>");

const parallelSwapSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = 20
            r1, r2 = r2, r1
            consume(r1, r2)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const parallelSwapResult = versionVmBlockRegisters(
    parallelSwapSource,
    parseLua(parallelSwapSource, "<beta-parallel-swap-test>")
);
const parallelSwapOp = parallelSwapResult.graph.states[0].operations.find(operation => operation.kind === "multi-write");
assert(parallelSwapOp);
assert.deepEqual(parallelSwapOp.originalTargets, ["r1", "r2"]);
assert.equal(parallelSwapOp.emittedTargets.length, 2);
assert.equal(parallelSwapOp.reads.length, 2);
assert(parallelSwapOp.emittedText.includes(","));
assert.equal((parallelSwapOp.emittedText.match(/=/g) || []).length, 1);
assert(!parallelSwapResult.source.includes("r1, r2 = r2, r1"));
parseLua(parallelSwapResult.source, "<beta-parallel-swap-output>");

const mixedParallelTargetSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 10
            r2 = key
            r1, box[r2] = produce()
            consume(r1)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const mixedParallelTargetResult = versionVmBlockRegisters(
    mixedParallelTargetSource,
    parseLua(mixedParallelTargetSource, "<beta-mixed-parallel-target-test>")
);
const mixedParallelTargetOp = mixedParallelTargetResult.graph.states[0].operations.find(operation => operation.kind === "multi-write");
assert(mixedParallelTargetOp);
assert.deepEqual(mixedParallelTargetOp.originalTargets, ["r1"]);
assert.equal(mixedParallelTargetOp.emittedTargets.length, 1);
assert.equal((mixedParallelTargetOp.emittedText.match(/produce\(/g) || []).length, 1);
assert(mixedParallelTargetOp.emittedText.includes("box["));
assert(mixedParallelTargetOp.reads.length >= 1);
parseLua(mixedParallelTargetResult.source, "<beta-mixed-parallel-target-output>");

const multiReturnTailSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, ReturnVal
    while state do
        if state == 1 then
            r1, r2, r3 = 1, pair()
            consume(r1, r2, r3)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const multiReturnTailResult = versionVmBlockRegisters(
    multiReturnTailSource,
    parseLua(multiReturnTailSource, "<beta-multi-return-tail-test>")
);
const multiReturnTailOp = multiReturnTailResult.graph.states[0].operations.find(operation => operation.kind === "multi-write");
assert(multiReturnTailOp);
assert.deepEqual(multiReturnTailOp.originalTargets, ["r1", "r2", "r3"]);
assert.equal((multiReturnTailOp.emittedText.match(/pair\(/g) || []).length, 1);
assert(multiReturnTailOp.emittedText.includes("= 1, pair()"));
parseLua(multiReturnTailResult.source, "<beta-multi-return-tail-output>");

const extraRhsSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = makeA(), makeB()
            consume(r1)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const extraRhsResult = versionVmBlockRegisters(
    extraRhsSource,
    parseLua(extraRhsSource, "<beta-extra-rhs-test>")
);
const extraRhsOp = extraRhsResult.graph.states[0].operations.find(operation => operation.kind === "multi-write");
assert(extraRhsOp);
assert.deepEqual(extraRhsOp.originalTargets, ["r1"]);
assert.equal((extraRhsOp.emittedText.match(/makeA\(/g) || []).length, 1);
assert.equal((extraRhsOp.emittedText.match(/makeB\(/g) || []).length, 1);
parseLua(extraRhsResult.source, "<beta-extra-rhs-output>");

const repeatedParallelTargetSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1, r1 = 1, 2
            consume(r1)
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const repeatedParallelTargetResult = versionVmBlockRegisters(
    repeatedParallelTargetSource,
    parseLua(repeatedParallelTargetSource, "<beta-repeated-parallel-target-test>")
);
const repeatedParallelTargetOp = repeatedParallelTargetResult.graph.states[0].operations.find(operation => operation.kind === "multi-write");
assert(repeatedParallelTargetOp);
assert.equal(new Set(repeatedParallelTargetOp.emittedTargets).size, 1);
assert.equal(repeatedParallelTargetResult.versions.filter(item => item.originalName === "r1").length, 1);
parseLua(repeatedParallelTargetResult.source, "<beta-repeated-parallel-target-output>");


const recoveredExistingBindingSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, r3, ReturnVal
    while state do
        if state == 1 then
            r1 = true
            r2 = allocUpvalue()
            upvalueValues[r2] = r1
            r3 = r1
            r1 = createClosure2(2, { r2 })
            ReturnVal = { r1 }
            state = nil
        end
        if state == 2 then
            r1 = upvalueValues[upvalues[1]]
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const recoveredExistingBinding = finalizeBetaRegisterUpvalues(versionVmBlockRegisters(
    recoveredExistingBindingSource,
    parseLua(recoveredExistingBindingSource, "<beta-upvalue-existing-binding-test>")
));
assert.equal(recoveredExistingBinding.upvalueRecovery.safe, true);
assert.equal(recoveredExistingBinding.upvalueRecovery.applied, true);
assert.equal(recoveredExistingBinding.upvalueRecovery.cells.length, 1);
const existingBindingCell = recoveredExistingBinding.upvalueRecovery.cells[0];
assert.equal(existingBindingCell.bindingMode, "post-init-beta-binding");
const r3BindingBase = recoveredExistingBinding.mapping.find(item => item.originalName === "r3")?.baseName;
assert(r3BindingBase);
assert.equal(existingBindingCell.bindingName, `${r3BindingBase}_1`);
assert(!recoveredExistingBinding.source.includes("allocUpvalue("));
assert(!recoveredExistingBinding.source.includes("upvalueValues["));
assert(recoveredExistingBinding.source.includes(`local ${r3BindingBase}_1 = `));
assert(recoveredExistingBinding.source.includes(`createClosure2(2, {})`));
parseLua(recoveredExistingBinding.source, "<beta-upvalue-existing-binding-output>");
const recoveredExistingBindingScheduled = finalizeBetaRegisterSchedule(recoveredExistingBinding);
assert.equal(recoveredExistingBindingScheduled.finalRegisterSchedule.safe, true);
assert.equal(recoveredExistingBindingScheduled.finalRegisterSchedule.applied, false);
assert.equal(recoveredExistingBindingScheduled.source, recoveredExistingBinding.source);
parseLua(recoveredExistingBindingScheduled.source, "<beta-upvalue-existing-binding-scheduled-output>");

const recoveredSyntheticBindingSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r2 = allocUpvalue()
            upvalueValues[r2] = args[1]
            r1 = createClosure2(2, { r2 })
            ReturnVal = { r1 }
            state = nil
        end
        if state == 2 then
            r1 = upvalueValues[upvalues[1]]
            upvalueValues[upvalues[1]] = r1
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const recoveredSyntheticBinding = finalizeBetaRegisterUpvalues(versionVmBlockRegisters(
    recoveredSyntheticBindingSource,
    parseLua(recoveredSyntheticBindingSource, "<beta-upvalue-synthetic-binding-test>")
));
assert.equal(recoveredSyntheticBinding.upvalueRecovery.safe, true);
assert.equal(recoveredSyntheticBinding.upvalueRecovery.applied, true);
const syntheticBindingCell = recoveredSyntheticBinding.upvalueRecovery.cells[0];
assert.equal(syntheticBindingCell.bindingMode, "cell-register-binding");
assert.equal(syntheticBindingCell.bindingName, "u_v1");
assert(recoveredSyntheticBinding.source.includes("local u_v1 = args[1]"));
assert(recoveredSyntheticBinding.source.includes("createClosure2(2, {})"));
assert(!recoveredSyntheticBinding.source.includes("allocUpvalue("));
assert(!recoveredSyntheticBinding.source.includes("upvalueValues["));
assert.equal(recoveredSyntheticBinding.upvalueRecovery.captures.find(item => item.entry === 2)?.slots[0]?.bindingName, "u_v1");
parseLua(recoveredSyntheticBinding.source, "<beta-upvalue-synthetic-binding-output>");

const deadStateSnapshotSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = state
            r2 = r1
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end`;
const deadStateSnapshotRaw = versionVmBlockRegisters(deadStateSnapshotSource, parseLua(deadStateSnapshotSource, "<dead-state-snapshot>"));
const deadStateSnapshotFinal = finalizeBetaDeadStateInitializers(finalizeBetaDeadStateSnapshots(finalizeBetaRegisterSchedule(finalizeBetaRegisterUpvalues(deadStateSnapshotRaw))));
assert.equal(deadStateSnapshotFinal.deadStateSnapshots.safe, true);
assert.equal(deadStateSnapshotFinal.deadStateSnapshots.applied, true);
assert.equal(deadStateSnapshotFinal.deadStateSnapshots.removedRoots, 1);
assert.equal(deadStateSnapshotFinal.deadStateSnapshots.removedCopies, 1);
assert(!/local\s+\w+\s*=\s*state\b/.test(deadStateSnapshotFinal.source));
parseLua(deadStateSnapshotFinal.source, "<dead-state-snapshot-output>");

const liveStateSnapshotSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = state
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end`;
const liveStateSnapshotRaw = versionVmBlockRegisters(liveStateSnapshotSource, parseLua(liveStateSnapshotSource, "<live-state-snapshot>"));
const liveStateSnapshotFinal = finalizeBetaDeadStateInitializers(finalizeBetaDeadStateSnapshots(finalizeBetaRegisterSchedule(finalizeBetaRegisterUpvalues(liveStateSnapshotRaw))));
assert.equal(liveStateSnapshotFinal.deadStateSnapshots.safe, true);
assert.equal(liveStateSnapshotFinal.deadStateSnapshots.applied, false);
assert(/local\s+\w+\s*=\s*state\b/.test(liveStateSnapshotFinal.source));
parseLua(liveStateSnapshotFinal.source, "<live-state-snapshot-output>");

const deadStateInitializerGraph = {
    found: true,
    applied: true,
    source: `vm = function(state, args, upvalues, gcProxy)
    while state do
        if state == 1 then
            local x = state
            local dead = x
            x = 5
            local sink = x
            state = nil
        end
    end
end`,
    graph: {
        stateName: "state",
        states: [{
            id: 1,
            successors: [],
            operations: [
                { index: 1, kind: "epoch-start", emittedTarget: "x", rhs: "state", reads: [], emittedText: "local x = state" },
                { index: 2, kind: "version-define", emittedTarget: "dead", rhs: "x", reads: ["x"], emittedText: "local dead = x" },
                { index: 3, kind: "epoch-mutate", emittedTarget: "x", rhs: "5", reads: [], emittedText: "x = 5" },
                { index: 4, kind: "version-define", emittedTarget: "sink", rhs: "x", reads: ["x"], emittedText: "local sink = x" },
                { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
            ],
        }],
    },
};
const deadStateInitializerFinal = finalizeBetaDeadStateInitializers(deadStateInitializerGraph);
assert.equal(deadStateInitializerFinal.deadStateInitializers.safe, true);
assert.equal(deadStateInitializerFinal.deadStateInitializers.applied, true);
assert.equal(deadStateInitializerFinal.deadStateInitializers.removedInitializers, 1);
assert.equal(deadStateInitializerFinal.deadStateInitializers.removedCopies, 1);
assert(deadStateInitializerFinal.source.includes("local x\n"));
assert(!deadStateInitializerFinal.source.includes("local x = state"));
assert(!deadStateInitializerFinal.source.includes("local dead = x"));
assert(deadStateInitializerFinal.source.includes("x = 5"));
parseLua(deadStateInitializerFinal.source, "<dead-state-initializer-output>");

const liveStateInitializerGraph = {
    found: true,
    applied: true,
    source: `vm = function(state, args, upvalues, gcProxy)
    while state do
        if state == 1 then
            local x = state
            local keep = x
            consume(keep)
            x = 5
            state = nil
        end
    end
end`,
    graph: {
        stateName: "state",
        states: [{
            id: 1,
            successors: [],
            operations: [
                { index: 1, kind: "epoch-start", emittedTarget: "x", rhs: "state", reads: [], emittedText: "local x = state" },
                { index: 2, kind: "version-define", emittedTarget: "keep", rhs: "x", reads: ["x"], emittedText: "local keep = x" },
                { index: 3, kind: "statement", reads: ["keep"], emittedText: "consume(keep)" },
                { index: 4, kind: "epoch-mutate", emittedTarget: "x", rhs: "5", reads: [], emittedText: "x = 5" },
                { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
            ],
        }],
    },
};
const liveStateInitializerFinal = finalizeBetaDeadStateInitializers(liveStateInitializerGraph);
assert.equal(liveStateInitializerFinal.deadStateInitializers.safe, true);
assert.equal(liveStateInitializerFinal.deadStateInitializers.applied, false);
assert(liveStateInitializerFinal.source.includes("local x = state"));

const transitiveDeadStateInitializerGraph = {
    found: true,
    applied: true,
    source: `vm = function(state, args, upvalues, gcProxy)
    while state do
        if state == 1 then
            local x = state
            local a = x
            local b = a
            b = 7
            consume(b)
            x = 5
            state = nil
        end
    end
end`,
    graph: {
        stateName: "state",
        states: [{
            id: 1,
            successors: [],
            operations: [
                { index: 1, kind: "epoch-start", emittedTarget: "x", rhs: "state", reads: [], emittedText: "local x = state" },
                { index: 2, kind: "version-define", emittedTarget: "a", rhs: "x", reads: ["x"], emittedText: "local a = x" },
                { index: 3, kind: "epoch-start", emittedTarget: "b", rhs: "a", reads: ["a"], emittedText: "local b = a" },
                { index: 4, kind: "epoch-mutate", emittedTarget: "b", rhs: "7", reads: [], emittedText: "b = 7" },
                { index: 5, kind: "statement", reads: ["b"], emittedText: "consume(b)" },
                { index: 6, kind: "epoch-mutate", emittedTarget: "x", rhs: "5", reads: [], emittedText: "x = 5" },
                { index: 7, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
            ],
        }],
    },
};
const transitiveDeadStateInitializerFinal = finalizeBetaDeadStateInitializers(transitiveDeadStateInitializerGraph);
assert.equal(transitiveDeadStateInitializerFinal.deadStateInitializers.safe, true);
assert.equal(transitiveDeadStateInitializerFinal.deadStateInitializers.applied, true);
assert(!transitiveDeadStateInitializerFinal.source.includes("local x = state"));
assert(!transitiveDeadStateInitializerFinal.source.includes("local a = x"));
assert(transitiveDeadStateInitializerFinal.source.includes("local b\n"));
assert(transitiveDeadStateInitializerFinal.source.includes("b = 7"));
assert(transitiveDeadStateInitializerFinal.source.includes("consume(b)"));
parseLua(transitiveDeadStateInitializerFinal.source, "<transitive-dead-state-initializer-output>");

const assignedDeadStateInitializerGraph = {
    found: true,
    applied: true,
    source: `vm = function(state, args, upvalues, gcProxy)
    local x
    while state do
        if state == 1 then
            x = state
            local dead = x
            x = 9
            consume(x)
            state = nil
        end
    end
end`,
    graph: {
        stateName: "state",
        states: [{
            id: 1,
            successors: [],
            operations: [
                { index: 1, kind: "epoch-mutate", emittedTarget: "x", rhs: "state", reads: [], emittedText: "x = state" },
                { index: 2, kind: "version-define", emittedTarget: "dead", rhs: "x", reads: ["x"], emittedText: "local dead = x" },
                { index: 3, kind: "epoch-mutate", emittedTarget: "x", rhs: "9", reads: [], emittedText: "x = 9" },
                { index: 4, kind: "statement", reads: ["x"], emittedText: "consume(x)" },
                { index: 5, kind: "state-transition", emittedTarget: "state", rhs: "nil", reads: [], emittedText: "state = nil" },
            ],
        }],
    },
};
const assignedDeadStateInitializerFinal = finalizeBetaDeadStateInitializers(assignedDeadStateInitializerGraph);
assert.equal(assignedDeadStateInitializerFinal.deadStateInitializers.safe, true);
assert.equal(assignedDeadStateInitializerFinal.deadStateInitializers.applied, true);
assert(!assignedDeadStateInitializerFinal.source.includes("x = state"));
assert(!assignedDeadStateInitializerFinal.source.includes("local dead = x"));
assert(assignedDeadStateInitializerFinal.source.includes("x = 9"));
assert(assignedDeadStateInitializerFinal.source.includes("consume(x)"));
parseLua(assignedDeadStateInitializerFinal.source, "<assigned-dead-state-initializer-output>");

const liveStateRestoreGraph = {
    found: true,
    applied: true,
    source: `vm = function(state, args, upvalues, gcProxy)
    while state do
        if state == 1 then
            local saved = state
            local copy = saved
            state = copy
        end
    end
end`,
    graph: {
        stateName: "state",
        states: [{
            id: 1,
            successors: [],
            operations: [
                { index: 1, kind: "epoch-start", emittedTarget: "saved", rhs: "state", reads: [], emittedText: "local saved = state" },
                { index: 2, kind: "version-define", emittedTarget: "copy", rhs: "saved", reads: ["saved"], emittedText: "local copy = saved" },
                { index: 3, kind: "state-transition", emittedTarget: "state", rhs: "copy", reads: ["copy"], emittedText: "state = copy" },
            ],
        }],
    },
};
const liveStateRestoreFinal = finalizeBetaDeadStateInitializers(liveStateRestoreGraph);
assert.equal(liveStateRestoreFinal.deadStateInitializers.safe, true);
assert.equal(liveStateRestoreFinal.deadStateInitializers.applied, false);
assert(liveStateRestoreFinal.source.includes("local saved = state"));
assert(liveStateRestoreFinal.source.includes("state = copy"));
const whitespaceCleanupFixture = {
    found: true,
    applied: true,
    source: "vm = function(state, args, upvalues, gcProxy)\n\n    -- keep comment\n    local a = 1\n    \n\n    local text = [=[first\n\nthird  \n]=]\n\n    --[[comment line\n\ncomment tail]]\n\n    if state == 1 then\n        \n        a = a + 1\n        \n    end\nend\n",
    graph: { stateName: "state", states: [] },
};
const whitespaceCleanupFinal = finalizeBetaWhitespaceCleanup(whitespaceCleanupFixture);
assert.equal(whitespaceCleanupFinal.whitespaceCleanup.safe, true);
assert.equal(whitespaceCleanupFinal.whitespaceCleanup.applied, true);
assert(whitespaceCleanupFinal.whitespaceCleanup.removedLines >= 5);
assert(whitespaceCleanupFinal.source.includes("first\n\nthird  \n"));
assert(whitespaceCleanupFinal.source.includes("comment line\n\ncomment tail"));
assert(!whitespaceCleanupFinal.source.includes("    \n"));
const outsideProtected = whitespaceCleanupFinal.source.replace("first\n\nthird  ", "first\nthird  ").replace("comment line\n\ncomment tail", "comment line\ncomment tail");
assert(!/\n[ \t]*\n/.test(outsideProtected));
parseLua(whitespaceCleanupFinal.source, "<beta-whitespace-cleanup-output>");
const unreadCleanupSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, ReturnVal
    while state do
        if state == 1 then
            r1 = {}
            state = 2
        end
        if state == 2 then
            r1 = nil
            state = 3
        end
        if state == 3 then
            r1 = make()
            ReturnVal = { r1 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;
const unreadCleanupResult = versionVmBlockRegisters(
    unreadCleanupSource,
    parseLua(unreadCleanupSource, "<beta-unread-cleanup-test>")
);
const unreadCleanupOps = unreadCleanupResult.graph.states.flatMap(state => state.operations).filter(operation => operation.originalTarget === "r1");
assert.equal(unreadCleanupOps.length, 3);
assert.equal(unreadCleanupOps[0].kind, "epoch-start");
assert.equal(unreadCleanupOps[1].kind, "epoch-kill");
assert.equal(unreadCleanupOps[1].emittedTarget, unreadCleanupOps[0].emittedTarget);
assert.equal(unreadCleanupOps[2].kind, "epoch-start");
assert.notEqual(unreadCleanupOps[2].emittedTarget, unreadCleanupOps[0].emittedTarget);
assert(unreadCleanupResult.source.includes(`${unreadCleanupOps[0].emittedTarget} = nil`));
assert(!unreadCleanupResult.source.includes(`local ${unreadCleanupOps[1].emittedTarget} = nil`));
parseLua(unreadCleanupResult.source, "<beta-unread-cleanup-output>");

const unreadCleanupFinal = finalizeBetaDeadRegisterClears(unreadCleanupResult);
assert.equal(unreadCleanupFinal.deadRegisterClears.safe, true);
assert.equal(unreadCleanupFinal.deadRegisterClears.applied, true);
assert.equal(unreadCleanupFinal.deadRegisterClears.removedOperations, 1);
assert(!unreadCleanupFinal.source.includes(`${unreadCleanupOps[0].emittedTarget} = nil`));
assert.equal(unreadCleanupFinal.graph.states.flatMap(state => state.operations).filter(operation => operation.kind === "epoch-kill").length, 0);
assert.equal(unreadCleanupFinal.graph.states.flatMap(state => state.operations).filter(operation => operation.originalTarget === "r1").length, 2);
assert.equal(unreadCleanupFinal.graph.states.flatMap(state => state.operations).find(operation => operation.originalTarget === "r1")?.compilerSourceLifetimeProven, true);
parseLua(unreadCleanupFinal.source, "<beta-unread-cleanup-final-output>");

const semanticNilSource = `vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = nil
            r2 = r1
            ReturnVal = { r2 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end`;
const semanticNilRaw = versionVmBlockRegisters(semanticNilSource, parseLua(semanticNilSource, "<beta-semantic-nil-test>"));
const semanticNilOps = semanticNilRaw.graph.states.flatMap(state => state.operations).filter(operation => operation.originalTarget === "r1");
assert.equal(semanticNilOps.length, 1);
assert.notEqual(semanticNilOps[0].kind, "epoch-kill");
const semanticNilFinal = finalizeBetaDeadRegisterClears(semanticNilRaw);
assert.equal(semanticNilFinal.deadRegisterClears.safe, true);
assert.equal(semanticNilFinal.deadRegisterClears.applied, false);
assert(/= nil/.test(semanticNilFinal.source));
parseLua(semanticNilFinal.source, "<beta-semantic-nil-output>");

console.log("beta register versioning tests passed");
