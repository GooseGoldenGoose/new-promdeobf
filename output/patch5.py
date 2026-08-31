from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
start=s.index('    // Validate every direct allocation register and every proven compiler alias')
end=s.index('    const removals = new Set();', start)
new='''    // Validate every direct allocation storage identity and every proven compiler alias
    // before deleting the VM cell representation. Scalar beta locals and static
    // RegisterOverflow slots use the same storage-identity proof here; overflow
    // identities are distinguished by their unique reaching definition rather than
    // by the raw physical slot number.
    for (const cellId of capturedCellIds) {
        const cell = cells.get(cellId);
        for (const registerName of [cell.registerName, ...cell.aliases]) {
            for (const position of positions) {
                const totalUses = countStorageKeyUsesAtPosition(position, registerName, overflowAnalysis);
                if (totalUses === null) {
                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " appears in an unparseable beta operation" };
                }
                if (totalUses === 0) continue;

                let understood = 0;
                const allocation = allocationFromOperation(position, overflowAnalysis);
                if (allocation?.cellName === registerName) understood += 1;

                const release = releaseCellFromOperation(position, overflowAnalysis);
                if (release?.cellName === registerName && cellIdByRegister.get(registerName) === cellId) {
                    understood += 1;
                    if (release.resultName === registerName) understood += 1;
                }

                const factory = factoryCallFromOperation(position.operation);
                if (factory) {
                    for (const capture of factory.captures) {
                        if (
                            storageReadKey(capture, position, overflowAnalysis) === registerName &&
                            resolveCellIndex(position.ownerEntry, capture, position) === cellId
                        ) understood += 1;
                    }
                }

                const statementParsed = parseStatement(position.operation?.emittedText);
                if (!statementParsed) {
                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " appears in an unparseable beta operation" };
                }
                walk(statementParsed.statement, node => {
                    if (!isUpvalueValuesIndex(node)) return;
                    if (
                        storageReadKey(node.index, position, overflowAnalysis) === registerName &&
                        resolveCellIndex(position.ownerEntry, node.index, position) === cellId
                    ) understood += 1;
                });

                const aliasCopy = storageCopyFromOperation(position, overflowAnalysis);
                if (aliasCopyOperations.has(position.operation) && aliasCopy) {
                    if (aliasCopy.sourceName === registerName) understood += 1;
                    if (aliasCopy.targetName === registerName) understood += 1;
                }

                if (understood < totalUses) {
                    return { applied: false, safe: false, reason: "Cell " + cellId + " alias " + registerName + " escapes recognized upvalue machinery in state " + position.stateId };
                }
            }
        }
    }

'''
s=s[:start]+new+s[end:]
# alias removals loop
old='''    for (const operation of aliasCopyOperations) {
        const copy = identifierCopyFromOperation(operation);
        const cellId = copy ? cellIdByRegister.get(copy.sourceName) : null;
        if (cellId && capturedCellIds.has(cellId)) removals.add(operation);
    }
'''
new2='''    for (const position of positions) {
        if (!aliasCopyOperations.has(position.operation)) continue;
        const copy = storageCopyFromOperation(position, overflowAnalysis);
        const cellId = copy ? cellIdByRegister.get(copy.sourceName) : null;
        if (cellId && capturedCellIds.has(cellId)) removals.add(position.operation);
    }
'''
if old not in s: raise SystemExit('missing alias removals')
s=s.replace(old,new2,1)
# remaining calls / contexts
s=s.replace('const release = releaseCellFromOperation(operation);','const release = releaseCellFromOperation(position, overflowAnalysis);',1)
s=s.replace('const cellId = resolveCellIndex(position.ownerEntry, write.target.index);','const cellId = resolveCellIndex(position.ownerEntry, write.target.index, position);',1)
s=s.replace('rewriteExpressionUpvalues(initRhsText, cell.ownerEntry, resolveCellIndex, bindingByCell)','rewriteExpressionUpvalues(initRhsText, cell.initialization, resolveCellIndex, bindingByCell)',1)
s=s.replace('rewriteExpressionUpvalues(rhsText, position.ownerEntry, resolveCellIndex, bindingByCell)','rewriteExpressionUpvalues(rhsText, position, resolveCellIndex, bindingByCell)',1)
s=s.replace('rewriteStatementUpvalueReads(operation.emittedText, position.ownerEntry, resolveCellIndex, bindingByCell)','rewriteStatementUpvalueReads(operation.emittedText, position, resolveCellIndex, bindingByCell)',1)
s=s.replace('rewriteExpressionUpvalues(operation.rhs, position.ownerEntry, resolveCellIndex, bindingByCell)','rewriteExpressionUpvalues(operation.rhs, position, resolveCellIndex, bindingByCell)',1)
p.write_text(s,encoding='utf-8')
print('patched generalized cell validation + remaining contexts')
