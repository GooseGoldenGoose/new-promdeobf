from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
def rep(a,b,label):
    global s
    if a not in s: raise SystemExit('missing '+label)
    s=s.replace(a,b,1)
anchor='''function countIdentifier(node, name) {
    let count = 0;
    walk(node, current => {
        if (isIdentifier(current, name)) count++;
    });
    return count;
}
'''
insert=anchor+'''
function countStorageKeyUsesAtPosition(position, storageKey, overflowAnalysis) {
    const parsed = parseStatement(position.operation?.emittedText);
    if (!parsed) return null;
    if (!String(storageKey).startsWith("overflow-def:")) {
        return countIdentifier(parsed.statement, storageKey);
    }

    const write = overflowAnalysis.writeByOperation.get(position.operation);
    const skipTarget = write && !write.compound ? write.target : null;
    let count = overflowAnalysis.currentWriteDefinition(position) === storageKey ? 1 : 0;

    function visit(node) {
        if (!isNode(node) || node === skipTarget) return;
        const slot = registerOverflowSlot(node);
        if (slot !== null) {
            if (storageReadKey(node, position, overflowAnalysis) === storageKey) count++;
            return;
        }
        for (const [key, value] of Object.entries(node)) {
            if (key === "loc" || key === "range") continue;
            if (Array.isArray(value)) {
                for (const child of value) visit(child);
            } else if (isNode(value)) {
                visit(value);
            }
        }
    }

    visit(parsed.statement);
    return count;
}
'''
rep(anchor,insert,'count storage helper')
old='''        const ownerFootprint = positions.filter(position => {
            if (position.ownerEntry !== cell.ownerEntry) return false;
            const text = String(position.operation?.emittedText || "");
            if (![...cellRegisterNames].some(name => text.includes(name))) return false;
            const parsed = parseStatement(text);
            return parsed ? [...cellRegisterNames].some(name => countIdentifier(parsed.statement, name) > 0) : false;
        });
'''
new='''        const ownerFootprint = positions.filter(position => {
            if (position.ownerEntry !== cell.ownerEntry) return false;
            return [...cellRegisterNames].some(name => {
                const count = countStorageKeyUsesAtPosition(position, name, overflowAnalysis);
                return count !== null && count > 0;
            });
        });
'''
rep(old,new,'owner footprint')
p.write_text(s,encoding='utf-8')
print('patched reaching-definition-aware cell footprint')
