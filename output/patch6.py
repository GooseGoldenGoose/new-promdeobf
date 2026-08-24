from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
old='''    const write = overflowAnalysis.writeByOperation.get(position.operation);
    const skipTarget = write && !write.compound ? write.target : null;
    let count = overflowAnalysis.currentWriteDefinition(position) === storageKey ? 1 : 0;
'''
new='''    const statement = parsed.statement;
    let skipTarget = null;
    if (statement?.type === "AssignmentStatement") {
        const variables = statement.variables || [];
        const init = statement.init || [];
        if (variables.length === 1 && init.length === 1 && registerOverflowSlot(variables[0]) !== null) {
            skipTarget = variables[0];
        }
    }
    let count = overflowAnalysis.currentWriteDefinition(position) === storageKey ? 1 : 0;
'''
if old not in s: raise SystemExit('anchor missing')
s=s.replace(old,new,1)
p.write_text(s,encoding='utf-8')
