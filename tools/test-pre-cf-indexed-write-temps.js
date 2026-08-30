"use strict";
const assert = require("assert");
const { finalizePreCfIndexedWriteTemps } = require("../passes/pre-cf-temp-recovery");

function makeBeta({ keyRhs='"key"', writeText='table_v[key_v] = value_v', extraRead=false, captured=false, gapWrite=false }={}) {
    const key={index:1,kind:"epoch-start",emittedTarget:"key_v",originalTarget:"r1",registerEpoch:"r1:epoch:1",rhs:keyRhs,reads:[],emittedText:`local key_v = ${keyRhs}`};
    const gap=gapWrite?{index:2,kind:"epoch-mutate",emittedTarget:"key_v",originalTarget:"r1",registerEpoch:"r1:epoch:1",rhs:"other_v",reads:["other_v"],emittedText:"key_v = other_v"}:null;
    const write={index:0,kind:"effect-write",reads:["table_v","key_v","value_v"],emittedText:writeText,originalText:writeText};
    const extra=extraRead?{index:0,kind:"statement",reads:["key_v"],emittedText:"observe(key_v)",originalText:"observe(key_v)"}:null;
    const transition={index:0,kind:"state-transition",emittedTarget:"state",originalTarget:"state",rhs:"nil",reads:[],emittedText:"state = nil"};
    const operations=[key,...(gap?[gap]:[]),write,...(extra?[extra]:[]),transition]; operations.forEach((op,i)=>op.index=i+1);
    const body=operations.map(op=>`            ${op.emittedText}`).join("\n");
    return {source:`vm = function(state, args, upvalues, gcProxy)\n    local ReturnVal\n    while state do\n        if state == 1 then\n${body}\n        end\n    end\n    return ReturnVal\nend`,graph:{cfgComplete:true,stateName:"state",returnName:"ReturnVal",recoveredUpvalueBindings:captured?["key_v"]:[],states:[{id:1,successors:[],operations}]}};
}

// Prometheus compiler.lua AssignmentIndexing: base/index are evaluated first; static key temp can be restored in-place.
for (const [keyRhs,expected] of [["1","table_v[1] = value_v"],['"key"','table_v["key"] = value_v'],["true","table_v[true] = value_v"]]) {
    const beta=makeBeta({keyRhs}); finalizePreCfIndexedWriteTemps(beta);
    assert.equal(beta.preCfIndexedWriteTemps.folds,1,beta.source); assert(beta.source.includes(expected),beta.source); assert(!beta.source.includes("local key_v ="),beta.source);
}
for (const beta of [
    makeBeta({keyRhs:"makeKey()"}),
    makeBeta({writeText:"table_v[key_v + 1] = value_v"}),
    makeBeta({writeText:"table_v.key = value_v"}),
    makeBeta({writeText:"table_v[key_v] += value_v"}),
    makeBeta({writeText:"_env[key_v] = value_v"}),
    makeBeta({extraRead:true}),
    makeBeta({captured:true}),
    makeBeta({gapWrite:true}),
]) { finalizePreCfIndexedWriteTemps(beta); assert.equal(beta.preCfIndexedWriteTemps.folds,0,beta.source); }

// Compiler RHS scratch scalar can be consumed directly by the proven indexed write.
{
    const beta=makeBeta({writeText:'table_v["key"] = value_v'});
    const value={index:1,kind:"epoch-start",emittedTarget:"value_v",originalTarget:"r2",registerEpoch:"r2:epoch:1",rhs:"10",reads:[],emittedText:"local value_v = 10"};
    beta.graph.states[0].operations.splice(1,0,value);
    beta.graph.states[0].operations.forEach((op,i)=>op.index=i+1);
    beta.source=beta.source.replace('            table_v["key"] = value_v','            local value_v = 10\n            table_v["key"] = value_v');
    finalizePreCfIndexedWriteTemps(beta);
    assert.equal(beta.preCfIndexedWriteTemps.rhsTempsRemoved,1,beta.source);
    assert(beta.source.includes('table_v["key"] = 10'),beta.source);
    assert(!beta.source.includes('local value_v = 10'),beta.source);
}
// Effectful RHS producers stay at their original evaluation point.
{
    const beta=makeBeta({writeText:'table_v["key"] = value_v'});
    const value={index:1,kind:"epoch-start",emittedTarget:"value_v",originalTarget:"r2",registerEpoch:"r2:epoch:1",rhs:"make()",reads:["make"],emittedText:"local value_v = make()"};
    beta.graph.states[0].operations.splice(1,0,value);
    beta.graph.states[0].operations.forEach((op,i)=>op.index=i+1);
    beta.source=beta.source.replace('            table_v["key"] = value_v','            local value_v = make()\n            table_v["key"] = value_v');
    finalizePreCfIndexedWriteTemps(beta);
    assert.equal(beta.preCfIndexedWriteTemps.rhsTempsRemoved,0,beta.source);
    assert(beta.source.includes('local value_v = make()'),beta.source);
}

console.log("pre-CF indexed write temps: PASS");
