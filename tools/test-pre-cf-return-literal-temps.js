"use strict";
const assert = require("assert");
const { finalizePreCfLiteralReturnTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ effectful = false, extraUse = false, sourceLifetime = false }) {
    const lines = [
        "            local a = 1",
        effectful ? "            local b = side()" : "            local b = nil",
        ...(extraUse ? ["            use(a)"] : []),
        "            ReturnVal = { a, b, 3 }",
        "            state = nil",
    ];
    const operations = [
        { kind:"version-define", emittedTarget:"a", rhs:"1", reads:[], emittedText:"local a = 1" },
        effectful
            ? { kind:"version-define", emittedTarget:"b", rhs:"side()", reads:["side"], emittedText:"local b = side()", compilerSourceLifetimeProven: sourceLifetime }
            : { kind:"version-define", emittedTarget:"b", rhs:"nil", reads:[], emittedText:"local b = nil", compilerSourceLifetimeProven: sourceLifetime },
        ...(extraUse ? [{ kind:"effect-call", rhs:"use(a)", reads:["use","a"], emittedText:"use(a)" }] : []),
        { kind:"return-payload", terminalCompilerReturnPayload:true, emittedTarget:"ReturnVal", returnExpressions:["a","b","3"], rhs:"{ a, b, 3 }", reads:["a","b"], emittedText:"ReturnVal = { a, b, 3 }" },
        { kind:"state-transition", emittedTarget:"state", rhs:"nil", reads:[], emittedText:"state = nil" },
    ];
    operations.forEach((op,i)=>op.index=i+1);
    return {
        source:`vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${lines.join("\n")}\n        end\n    end\n    return ReturnVal\nend`,
        graph:{ cfgComplete:true, stateName:"state", returnName:"ReturnVal", recoveredUpvalueBindings:[], states:[{id:1,successors:[],operations}] },
    };
}

{
    const beta = makeBeta({});
    finalizePreCfLiteralReturnTemps(beta);
    assert.equal(beta.preCfLiteralReturnTemps.safe, true);
    assert.equal(beta.preCfLiteralReturnTemps.folds, 2);
    assert(beta.source.includes("ReturnVal = { 1, nil, 3 }"), beta.source);
    assert(!beta.source.includes("local a =") && !beta.source.includes("local b ="), beta.source);
}

{
    const beta = makeBeta({ effectful:true });
    finalizePreCfLiteralReturnTemps(beta);
    assert.equal(beta.preCfLiteralReturnTemps.folds, 2, beta.source);
    assert(!beta.source.includes("local b = side()"), beta.source);
    assert(beta.source.includes("ReturnVal = { 1, (side()), 3 }"), beta.source);
}

{
    const beta = makeBeta({ effectful:true, sourceLifetime:true });
    finalizePreCfLiteralReturnTemps(beta);
    assert.equal(beta.preCfLiteralReturnTemps.folds, 1, beta.source);
    assert(beta.source.includes("local b = side()"), beta.source);
    assert(beta.source.includes("ReturnVal = { 1, b, 3 }"), beta.source);
}

{
    const beta = makeBeta({ extraUse:true });
    finalizePreCfLiteralReturnTemps(beta);
    assert.equal(beta.preCfLiteralReturnTemps.folds, 1, beta.source);
    assert(beta.source.includes("local a = 1"), beta.source);
    assert(beta.source.includes("ReturnVal = { a, nil, 3 }"), beta.source);
}

console.log("pre-CF literal return temps: PASS");
