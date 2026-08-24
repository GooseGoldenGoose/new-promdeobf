from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
old='''                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " escapes recognized upvalue machinery in state " + position.stateId };
'''
new='''                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " escapes recognized upvalue machinery in state " + position.stateId + " op " + (position.operationIndex + 1) + " (" + understood + "/" + totalUses + "): " + String(position.operation?.emittedText || "") };
'''
if old not in s: raise SystemExit('anchor missing')
p.write_text(s.replace(old,new,1),encoding='utf-8')
