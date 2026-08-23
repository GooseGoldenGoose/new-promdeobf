const assert = require("assert");
const { parseLua } = require("../main");
const { versionVmBlockRegisters } = require("../passes/beta-register-versions");
const { renderText, renderDot, renderMermaid } = require("./beta-register-graph");

const source = `vm = function(state, args, upvalues, gcProxy)
    local r2, ReturnVal
    while state do
        if state == 1 then
            r2 = 10
            state = flag and 2 or 3
        end
        if state == 2 then
            ReturnVal = consume(r2)
            ping()
            r2 = 20
            state = 3
        end
        if state == 3 then
            ReturnVal = consume2(r2)
            r2 = nil
            ReturnVal = {}
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})`;

const result = versionVmBlockRegisters(source, parseLua(source, "<beta-graph-test>"));
assert.equal(result.found, true);
assert.equal(result.applied, true);
assert(result.graph);
assert.deepEqual(result.graph.entries, [1]);
assert.equal(result.graph.states.length, 3);
assert.deepEqual(result.graph.states[0].successors, [2, 3]);
assert.deepEqual(result.graph.states[1].predecessors, [1]);
assert.deepEqual(result.graph.states[2].predecessors, [1, 2]);
assert(result.graph.states[1].operations.some(operation => operation.kind === "statement" && operation.originalText === "ping()"));
assert.equal(result.graph.epochs.length, 1);

const epoch = result.graph.epochs[0];
assert.equal(epoch.originalRegister, "r2");
assert(epoch.events.some(event => event.kind === "start" && event.state === 1));
assert(epoch.events.some(event => event.kind === "read" && event.state === 2));
assert(epoch.events.some(event => event.kind === "mutate" && event.state === 2));
assert(epoch.events.some(event => event.kind === "read" && event.state === 3));
assert(epoch.events.some(event => event.kind === "kill" && event.state === 3));

const text = renderText(result.graph);
assert(text.includes("ENTRY -> S1"));
assert(text.includes("S1 -> S2 [true]"));
assert(text.includes("S1 -> S3 [false]"));
assert(text.includes("REGISTER EPOCHS"));
assert(result.graph.analysis);
assert(result.graph.analysis.definitionCount > 0);
assert(text.includes("analysis: defs="));
assert(text.includes(`${epoch.originalRegister} => ${epoch.name}`));
assert(text.includes("KILL S3"));

const dot = renderDot(result.graph);
assert(dot.startsWith("digraph BetaRegisterFlow"));
assert(dot.includes("entry -> s1"));
assert(dot.includes("s1 -> s2"));
assert(dot.includes("cluster_epochs"));

const mermaid = renderMermaid(result.graph);
assert(mermaid.startsWith("flowchart LR"));
assert(mermaid.includes("ENTRY --> S1"));
assert(mermaid.includes("S1 -->|true| S2"));
assert(mermaid.includes("S1 -->|false| S3"));

console.log("beta register graph tests passed");
