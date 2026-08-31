const fs=require("fs");
const luaparse=require("../parser/luaparse");
const {versionVmBlockRegisters}=require("../passes/beta-register-versions");
const source=fs.readFileSync("output/spacial.lua","utf8");
const ast=luaparse.parse(source,{luaVersion:"luau",comments:true,scope:true,locations:true,ranges:true});
const beta=versionVmBlockRegisters(source,ast);
const wanted=new Set([61,62,63,64,65,66,67,68,69,70,71,72]);
const states=beta.graph.states.filter(s=>wanted.has(s.id));
const preds=new Map(states.map(s=>[s.id,[]]));
for(const s of states) for(const t of s.successors||[]) if(preds.has(t)) preds.get(t).push(s.id);
for(const s of states){
 console.log(`STATE ${s.id} preds=${JSON.stringify(preds.get(s.id)||[])} succ=${JSON.stringify(s.successors||[])}`);
 for(const op of s.operations||[]) console.log(`  ${op.kind} :: ${String(op.text||op.source||op.rhs||"").replace(/\s+/g," ").slice(0,220)}`);
}
