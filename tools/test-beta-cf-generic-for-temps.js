const assert = require('assert');
const { parseLua } = require('../main');
const { solveBetaControlFlow } = require('../passes/beta-control-flow');

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

console.log('beta CF generic-for temps: PASS');
