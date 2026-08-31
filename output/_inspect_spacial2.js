const fs=require("fs");
const luaparse=require("../parser/luaparse");
const {versionVmBlockRegisters}=require("../passes/beta-register-versions-old");
const {recoverBetaUpvalues}=require("../passes/beta-upvalues");
const {forwardControlOnlyJoinBranches,collapseCompilerStructuredLoops}=require("../passes/beta-control-flow");
const source=fs.readFileSync("output/spacial.lua","utf8");
const ast=luaparse.parse(source,{luaVersion:"luau",comments:true,scope:true,locations:true,ranges:true});
const beta=versionVmBlockRegisters(source,ast);
const up=recoverBetaUpvalues(beta);
const ids=new Set([61,62,63,64,65,66,67,68,69,70,71,72]);
const region={...up.graph,entries:[61],states:up.graph.states.filter(s=>ids.has(s.id))};
function dump(label,g){console.log("--",label);for(const s of g.states.sort((a,b)=>a.id-b.id)) console.log(s.id,"->",JSON.stringify(s.successors||[]),"synthetic",s.syntheticKind||"");}
dump("upvalue",region);
const f=forwardControlOnlyJoinBranches(region); console.log("forwarded",f.forwardedControlJoinCount); dump("forward",f.graph);
const c=collapseCompilerStructuredLoops(f.graph); console.log("loops",c.numericForLoopCount,c.whileLoopCount,c.repeatLoopCount); dump("collapsed",c.graph);
