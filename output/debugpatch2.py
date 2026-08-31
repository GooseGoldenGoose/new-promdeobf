from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
old='''                return { applied: false, safe: false, reason: `State ${state.id} retains unresolved VM upvalue machinery after recovery` };
'''
new='''                return { applied: false, safe: false, reason: `State ${state.id} retains unresolved VM upvalue machinery after recovery: ${text}` };
'''
if old not in s: raise SystemExit('anchor missing')
p.write_text(s.replace(old,new,1),encoding='utf-8')
