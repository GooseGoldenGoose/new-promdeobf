from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
def rep(a,b,label):
    global s
    if a not in s: raise SystemExit('missing '+label)
    s=s.replace(a,b,1)
rep('const allocation = allocationFromOperation(position.operation);','const allocation = allocationFromOperation(position, overflowAnalysis);','alloc call 1')
rep('const copy = identifierCopyFromOperation(candidate.operation);','const copy = storageCopyFromOperation(candidate, overflowAnalysis);','copy call alias')
rep('''                const write = indexedWriteFromOperation(position.operation);
                return write && isIdentifier(write.target.index, cell.registerName);
''','''                const write = indexedWriteFromOperation(position.operation);
                return write && resolveCellIndex(position.ownerEntry, write.target.index, position) === cell.id;
''','init alias resolve')
rep('''            const aliasWrites = positions.filter(position =>
                position.ownerEntry === cell.ownerEntry && position.operation?.emittedTarget === copy.targetName
            );
''','''            const aliasWrites = positions.filter(position =>
                position.ownerEntry === cell.ownerEntry && operationTargetStorageKey(position, overflowAnalysis) === copy.targetName
            );
''','alias writes')
rep('return releaseCellFromOperation(position.operation)?.cellName !== copy.targetName;','return releaseCellFromOperation(position, overflowAnalysis)?.cellName !== copy.targetName;','alias release')
# resolveCellIndex body
old='''    function resolveCellIndex(ownerEntry, indexNode) {
        if (isIdentifier(indexNode)) {
            const cellId = cellIdByRegister.get(indexNode.name);
            return cellId && cells.get(cellId)?.ownerEntry === ownerEntry ? cellId : null;
        }
        const slot = upvalueSlot(indexNode);
        if (slot === null) return null;
        return captureCellsByEntry.get(ownerEntry)?.get(slot) || null;
    }
'''
new='''    function resolveCellIndex(ownerEntry, indexNode, position) {
        const storageKey = position ? storageReadKey(indexNode, position, overflowAnalysis) : null;
        if (storageKey) {
            const cellId = cellIdByRegister.get(storageKey);
            return cellId && cells.get(cellId)?.ownerEntry === ownerEntry ? cellId : null;
        }
        const slot = upvalueSlot(indexNode);
        if (slot === null) return null;
        return captureCellsByEntry.get(ownerEntry)?.get(slot) || null;
    }
'''
rep(old,new,'resolve cell')
rep('const cellId = resolveCellIndex(parentEntry, capture);','const cellId = resolveCellIndex(parentEntry, capture, site);','capture resolve')
rep('const targetCell = resolveCellIndex(position.ownerEntry, write.target.index);','const targetCell = resolveCellIndex(position.ownerEntry, write.target.index, position);','target resolve')
rep('site.captures.some(capture => resolveCellIndex(site.ownerEntry, capture) === cellId)','site.captures.some(capture => resolveCellIndex(site.ownerEntry, capture, site) === cellId)','capture site resolve')
p.write_text(s,encoding='utf-8')
print('patched allocation/alias/cell resolution')
