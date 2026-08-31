from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
def rep(a,b,label):
    global s
    if a not in s: raise SystemExit('missing '+label)
    s=s.replace(a,b,1)
rep('function rewriteExpressionUpvalues(text, ownerEntry, resolveCellIndex, bindingByCell) {','function rewriteExpressionUpvalues(text, position, resolveCellIndex, bindingByCell) {','rewrite expr sig')
s=s.replace('const cellId = resolveCellIndex(ownerEntry, node.index);','const cellId = resolveCellIndex(position.ownerEntry, node.index, position);',1)
rep('function rewriteStatementUpvalueReads(text, ownerEntry, resolveCellIndex, bindingByCell) {','function rewriteStatementUpvalueReads(text, position, resolveCellIndex, bindingByCell) {','rewrite stmt sig')
# replace second occurrence after stmt signature
idx=s.index('function rewriteStatementUpvalueReads')
pos=s.index('const cellId = resolveCellIndex(ownerEntry, node.index);',idx)
s=s[:pos]+s[pos:].replace('const cellId = resolveCellIndex(ownerEntry, node.index);','const cellId = resolveCellIndex(position.ownerEntry, node.index, position);',1)
rep('''    const { ownerByState, stateById } = partition;
    const positions = operationPositions(graph, ownerByState);
''','''    const { ownerByState, stateById } = partition;
    const positions = operationPositions(graph, ownerByState);
    const overflowAnalysis = buildOverflowStorageAnalysis(graph);
''','overflow analysis insert')
p.write_text(s,encoding='utf-8')
print('patched rewrite contexts + overflow analysis')
