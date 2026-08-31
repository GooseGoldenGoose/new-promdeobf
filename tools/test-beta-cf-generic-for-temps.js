const assert = require('assert');
const { parseLua } = require('../main');
const { solveBetaControlFlow, recoverGenericForPackedIterator } = require('../passes/beta-control-flow');

const ast = parseLua('local seed = 1\n', '<step16-base>');

function graph(extraPackUse = false) {
    const pre = [
        { kind: 'version-define', originalTarget: 'r8', emittedTarget: 'pack', rhs: '{ factory() }', emittedText: 'local pack = { factory() }', reads: [] },
        { kind: 'version-define', originalTarget: 'r7', emittedTarget: 'iter', rhs: 'pack[1]', emittedText: 'local iter = pack[1]', reads: ['pack'] },
        { kind: 'version-define', originalTarget: 'r1', emittedTarget: 'invariant', rhs: 'pack[2]', emittedText: 'local invariant = pack[2]', reads: ['pack'] },
        { kind: 'version-define', originalTarget: 'r2', emittedTarget: 'control', rhs: 'pack[3]', emittedText: 'local control = pack[3]', reads: ['pack'] },
    ];
    if (extraPackUse) pre.push({ kind: 'version-define', emittedTarget: 'escaped', rhs: 'pack', emittedText: 'local escaped = pack', reads: ['pack'], returnSinkSafe: true });
    pre.push({ kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: '2', emittedText: 'state = 2', reads: [] });
    return {
        applied: true,
        graph: {
            cfgComplete: true,
            stateName: 'state',
            entries: [1],
            states: [
                { id: 1, predecessors: [], successors: [2], operations: pre },
                { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                    { kind: 'multi-call-write', originalTargets: ['r2', 'r4'], emittedTargets: ['control', 'value'], callBaseOriginal: 'r7', callArgumentOriginals: ['r1', 'r2'], rhs: 'iter(invariant, control)', originalText: 'r2, r4 = r7(r1, r2)', emittedText: 'control, value = iter(invariant, control)', reads: ['iter', 'invariant', 'control'] },
                    { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: 'control and 3 or 4', emittedText: 'state = control and 3 or 4', reads: ['control'] },
                ] },
                { id: 3, predecessors: [2], successors: [2], operations: [
                    { kind: 'epoch-start', originalTarget: 'r3', emittedTarget: 'key', rhs: 'control', originalText: 'r3 = r2', emittedText: 'local key = control', reads: ['control'], registerEpoch: 'k:1' },
                    { kind: 'statement', originalText: 'consume(r3, r4)', emittedText: 'consume(key, value)', reads: ['key', 'value'] },
                    { kind: 'epoch-kill', originalTarget: 'r3', emittedTarget: 'key', rhs: 'nil', emittedText: 'key = nil', reads: [], registerEpoch: 'k:1' },
                    { kind: 'epoch-kill', originalTarget: 'r4', emittedTarget: 'value', rhs: 'nil', emittedText: 'value = nil', reads: [] },
                    { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: '2', emittedText: 'state = 2', reads: [] },
                ] },
                { id: 4, predecessors: [2], successors: [], operations: [
                    { kind: 'return-payload', terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: 'ReturnVal = {}', rhs: '{}', reads: [] },
                    { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: 'nil', emittedText: 'state = nil', reads: [] },
                ] },
            ],
        },
    };
}

const recovered = solveBetaControlFlow(ast, graph(false));
assert.equal(recovered.applied, true);
assert.equal(recovered.genericForLoopCount, 1);
assert(recovered.source.includes('for key, value in factory() do'));
assert(!recovered.source.includes('local pack ='));
assert(!recovered.source.includes('pack[1]'));
assert(!recovered.source.includes('pack[2]'));
assert(!recovered.source.includes('pack[3]'));
parseLua(recovered.source, '<step16-recovered>');

const refused = solveBetaControlFlow(ast, graph(true));
assert.equal(refused.applied, true);
assert.equal(refused.genericForLoopCount, 1);
assert(refused.source.includes('local pack = { factory() }'));
assert(refused.source.includes('for key, value in iter, invariant, control do'));
parseLua(refused.source, '<step16-refused>');



function directIteratorGraph({ mutateControl = false, mutateValue = false } = {}) {
    const bodyOperations = [
        ...(mutateControl ? [{ kind: 'epoch-mutate', originalTarget: 'r2', emittedTarget: 'control', rhs: '99', emittedText: 'control = 99', reads: [] }] : []),
        ...(mutateValue ? [{ kind: 'epoch-mutate', originalTarget: 'r7', emittedTarget: 'value', rhs: 'transform(value)', emittedText: 'value = transform(value)', reads: ['transform', 'value'] }] : []),
        { kind: 'effect-call', emittedText: 'print(control, value)', rhs: 'print(control, value)', reads: ['control', 'value'] },
        { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: '2', emittedText: 'state = 2', reads: [] },
    ];
    return {
        applied: true,
        graph: {
            cfgComplete: true,
            stateName: 'state',
            entries: [1],
            recoveredUpvalueBindings: [],
            states: [
                { id: 1, predecessors: [], successors: [2], operations: [
                    { kind: 'version-define', originalTarget: 'state', emittedTarget: 'pairsAlias', rhs: 'pairs', emittedText: 'local pairsAlias = pairs', reads: [], compilerGlobalLookupRecovered: 'pairs' },
                    { kind: 'epoch-start', originalTarget: 'r3', emittedTarget: 'gameAlias', rhs: 'game', emittedText: 'local gameAlias = game', reads: [], compilerGlobalLookupRecovered: 'game' },
                    { kind: 'epoch-start', originalTarget: 'r7', emittedTarget: 'method', rhs: 'gameAlias["GetChildren"]', emittedText: 'local method = gameAlias["GetChildren"]', reads: ['gameAlias'] },
                    { kind: 'epoch-start', originalTarget: 'r6', emittedTarget: 'innerPack', rhs: '{ method(gameAlias) }', emittedText: 'local innerPack = { method(gameAlias) }', reads: ['method', 'gameAlias'] },
                    { kind: 'epoch-start', originalTarget: 'r3', emittedTarget: 'iterPack', rhs: '{ pairsAlias(unpack(innerPack)) }', emittedText: 'local iterPack = { pairsAlias(unpack(innerPack)) }', reads: ['pairsAlias', 'innerPack'] },
                    { kind: 'version-define', originalTarget: 'ReturnVal', emittedTarget: 'iterResult', rhs: 'iterPack[1]', emittedText: 'local iterResult = iterPack[1]', reads: ['iterPack'] },
                    { kind: 'epoch-start', originalTarget: 'r1', emittedTarget: 'invariant', rhs: 'iterPack[2]', emittedText: 'local invariant = iterPack[2]', reads: ['iterPack'] },
                    { kind: 'epoch-start', originalTarget: 'r2', emittedTarget: 'control', rhs: 'iterPack[3]', emittedText: 'local control = iterPack[3]', reads: ['iterPack'] },
                    { kind: 'epoch-start', originalTarget: 'r3', emittedTarget: 'iter', rhs: 'iterResult', emittedText: 'local iter = iterResult', reads: ['iterResult'] },
                    { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: '2', emittedText: 'state = 2', reads: [] },
                ] },
                { id: 2, predecessors: [1, 3], successors: [3, 4], operations: [
                    { kind: 'multi-call-write', originalTargets: ['r2', 'r7'], emittedTargets: ['control', 'value'], callBaseOriginal: 'r3', callArgumentOriginals: ['r1', 'r2'], rhs: 'iter(invariant, control)', emittedText: 'control, value = iter(invariant, control)', reads: ['iter', 'invariant', 'control'] },
                    { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: 'control and 3 or 4', emittedText: 'state = control and 3 or 4', reads: ['control'] },
                ] },
                { id: 3, predecessors: [2], successors: [2], operations: bodyOperations },
                { id: 4, predecessors: [2], successors: [], operations: [
                    { kind: 'return-payload', terminalCompilerReturnPayload: true, returnExpressions: [], emittedText: 'ReturnVal = {}', rhs: '{}', reads: [] },
                    { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: 'nil', emittedText: 'state = nil', reads: [] },
                ] },
            ],
        },
    };
}

const directRecovered = solveBetaControlFlow(ast, directIteratorGraph());
assert.equal(directRecovered.applied, true);
assert.equal(directRecovered.genericForLoopCount, 1);
assert.equal(directRecovered.whileLoopCount, 0);
assert(directRecovered.source.includes('for control, value in pairs(game:GetChildren()) do'));
assert(!directRecovered.source.includes('innerPack'));
assert(!directRecovered.source.includes('pairsAlias'));
assert(!directRecovered.source.includes('gameAlias'));
parseLua(directRecovered.source, '<generic-for-direct-iterator-recovered>');

const directMutationRefused = solveBetaControlFlow(ast, directIteratorGraph({ mutateControl: true }));
assert.equal(directMutationRefused.applied, false);
assert(directMutationRefused.reason.includes('loop/backedge'));

const directValueMutationRecovered = solveBetaControlFlow(ast, directIteratorGraph({ mutateValue: true }));
assert.equal(directValueMutationRecovered.applied, true);
assert.equal(directValueMutationRecovered.genericForLoopCount, 1);
assert(directValueMutationRecovered.source.includes('for control, value in pairs(game:GetChildren()) do'));
assert(directValueMutationRecovered.source.includes('value = transform(value)'));
parseLua(directValueMutationRecovered.source, '<generic-for-value-mutation-recovered>');



function packedFieldIteratorFixture(sourceAlias = false) {
    const method = {
        kind: 'epoch-start',
        originalTarget: sourceAlias ? 'r1' : 'state',
        emittedTarget: 'method',
        rhs: 'obj["iter"]',
        emittedText: 'local method = obj["iter"]',
        reads: ['obj'],
        registerEpoch: sourceAlias ? 'r1:epoch:1' : null,
    };
    const pack = { kind: 'epoch-start', originalTarget: 'r5', emittedTarget: 'pack', rhs: '{ method() }', emittedText: 'local pack = { method() }', reads: ['method'], registerEpoch: 'r5:epoch:1' };
    const iter = { kind: 'version-define', originalTarget: 'ReturnVal', emittedTarget: 'iter', rhs: 'pack[1]', emittedText: 'local iter = pack[1]', reads: ['pack'] };
    const invariant = { kind: 'epoch-start', originalTarget: 'r2', emittedTarget: 'invariant', rhs: 'pack[2]', emittedText: 'local invariant = pack[2]', reads: ['pack'], registerEpoch: 'r2:epoch:1' };
    const control = { kind: 'epoch-start', originalTarget: 'r3', emittedTarget: 'control', rhs: 'pack[3]', emittedText: 'local control = pack[3]', reads: ['pack'], registerEpoch: 'r3:epoch:1' };
    const transition = { kind: 'state-transition', originalTarget: 'state', emittedTarget: 'state', rhs: '2', emittedText: 'state = 2', reads: [] };
    const iteratorStep = { kind: 'multi-call-write', emittedTargets: ['control', 'value'], reads: ['iter', 'invariant', 'control'] };
    const preOps = [method, pack, iter, invariant, control, transition];
    const graph = { stateName: 'state', recoveredUpvalueBindings: [], states: [{ id: 1, operations: preOps }, { id: 2, operations: [iteratorStep] }] };
    return { graph, preOps, roots: [iter, invariant, control], iteratorStep, transition, method };
}

{
    const fixture = packedFieldIteratorFixture(false);
    const recovered = recoverGenericForPackedIterator(fixture.graph, fixture.preOps, 5, fixture.roots, fixture.iteratorStep, fixture.transition);
    assert(recovered);
    assert.deepEqual(recovered.expressions, ['obj.iter()']);
    assert(recovered.removeOperations.has(fixture.method));
}

{
    const fixture = packedFieldIteratorFixture(true);
    const recovered = recoverGenericForPackedIterator(fixture.graph, fixture.preOps, 5, fixture.roots, fixture.iteratorStep, fixture.transition);
    assert(recovered);
    assert.deepEqual(recovered.expressions, ['method()']);
    assert(!recovered.removeOperations.has(fixture.method));
}

console.log('beta CF generic-for temps: PASS');
