from pathlib import Path
p=Path(r'passes/beta-upvalues.js')
s=p.read_text(encoding='utf-8')
old='''    const cells = new Map();
    for (const position of positions) {
        const allocation = allocationFromOperation(position, overflowAnalysis);
'''
new='''    const usedBindingNames = new Set();
    for (const position of positions) {
        const parsed = parseStatement(position.operation?.emittedText);
        if (!parsed) continue;
        walk(parsed.statement, node => {
            if (isIdentifier(node)) usedBindingNames.add(node.name);
        });
    }
    let nextOverflowCellBindingId = 1;
    function allocateCellStorageBindingName(storageName) {
        if (/^[A-Za-z_][A-Za-z0-9_]*$/.test(String(storageName || ""))) return storageName;
        while (usedBindingNames.has(`r_overflow_cell_${nextOverflowCellBindingId}`)) nextOverflowCellBindingId++;
        const name = `r_overflow_cell_${nextOverflowCellBindingId++}`;
        usedBindingNames.add(name);
        return name;
    }

    const cells = new Map();
    for (const position of positions) {
        const allocation = allocationFromOperation(position, overflowAnalysis);
'''
if old not in s: raise SystemExit('cells anchor missing')
s=s.replace(old,new,1)
old2='''            registerName: allocation.cellName,
            ownerEntry: position.ownerEntry,
'''
new2='''            registerName: allocation.cellName,
            storageBindingName: allocateCellStorageBindingName(allocation.cellName),
            ownerEntry: position.ownerEntry,
'''
if old2 not in s: raise SystemExit('cell props anchor missing')
s=s.replace(old2,new2,1)
s=s.replace('''        if (!cell.bindingName) {
            cell.bindingName = cell.registerName;
            cell.bindingMode = "cell-register-binding";
        }
''','''        if (!cell.bindingName) {
            cell.bindingName = cell.storageBindingName;
            cell.bindingMode = "cell-register-binding";
        }
''',1)
s=s.replace('''        if (captureBeforeInitialization) {
            cell.bindingName = cell.registerName;
            cell.bindingMode = "hoisted-cell-binding";
        }
''','''        if (captureBeforeInitialization) {
            cell.bindingName = cell.storageBindingName;
            cell.bindingMode = "hoisted-cell-binding";
        }
''',1)
p.write_text(s,encoding='utf-8')
print('patched overflow cell lexical names')
