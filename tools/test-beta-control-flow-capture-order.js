"use strict";

const assert = require("assert");
const luaparse = require("../parser/luaparse");
const { solveBetaControlFlow } = require("../passes/beta-control-flow");

function parse(source) {
    return luaparse.parse(source, { luaVersion: "luau", ranges: true });
}

function vmSource(rootBody) {
    const states = {
        1: rootBody,
        2: [
            "r4 = upvalueValues[upvalues[1]]",
            "r5 = upvalueValues[upvalues[2]]",
            "state = r4 + r5",
            "ReturnVal = { state }",
            "state = nil",
        ],
    };
    const lines = [
        "vm = function(state, args, upvalues, gcProxy)",
        "    local r1, r2, r3, r4, r5, ReturnVal",
        "    while state do",
    ];
    for (const id of [1, 2]) {
        lines.push(`        ${id === 1 ? "if" : "elseif"} state == ${id} then`);
        for (const line of states[id]) lines.push(`            ${line}`);
    }
    lines.push(
        "        end",
        "    end",
        "    state = #gcProxy",
        "    return unpack(ReturnVal)",
        "end",
    );
    return lines.join("\n");
}

const events = new Map([
    ["alloc1", { deps: [], lines: ["r1 = allocUpvalue()"] }],
    ["alloc2", { deps: [], lines: ["r2 = allocUpvalue()"] }],
    ["bind1", { deps: ["alloc1"], lines: ["state = 10", "upvalueValues[r1] = state"] }],
    ["bind2", { deps: ["alloc2"], lines: ["state = 20", "upvalueValues[r2] = state"] }],
    ["closure", { deps: ["alloc1", "alloc2"], lines: ["state = createClosure0(2, { r1, r2 })", "r3 = state"] }],
    ["release1", { deps: ["bind1", "closure"], lines: ["r1 = releaseUpvalue(r1)"] }],
    ["release2", { deps: ["bind2", "closure"], lines: ["r2 = releaseUpvalue(r2)"] }],
]);

function topologicalOrders() {
    const out = [];
    function visit(done, order) {
        if (done.size === events.size) {
            out.push([...order]);
            return;
        }
        for (const [name, event] of events) {
            if (done.has(name) || !event.deps.every(dep => done.has(dep))) continue;
            done.add(name);
            order.push(name);
            visit(done, order);
            order.pop();
            done.delete(name);
        }
    }
    visit(new Set(), []);
    return out;
}

function assertRecoveredSemantics(source, order) {
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, `order failed: ${order.join(" -> ")}\n${result.reason || ""}`);
    assert.strictEqual(result.mode, "fresh-closure-entry");
    parse(result.source);
    for (const compilerName of ["allocUpvalue", "releaseUpvalue", "upvalueValues", "createClosure"]) {
        assert(!result.source.includes(compilerName), `${compilerName} leaked for order ${order.join(" -> ")}`);
    }
    const ten = result.source.match(/local\s+(v\d+)\s*=\s*10\b/);
    const twenty = result.source.match(/local\s+(v\d+)\s*=\s*20\b/);
    const closure = result.source.match(/local\s+(v\d+)\s*=\s*function\(\)\s*\n\s*return\s+\((v\d+)\s*\+\s*(v\d+)\)\s*\nend/);
    assert(ten && twenty && closure, `missing recovered locals/closure for order ${order.join(" -> ")}\n${result.source}`);
    assert(new Set([closure[2], closure[3]]).has(ten[1]));
    assert(new Set([closure[2], closure[3]]).has(twenty[1]));
    assert.notStrictEqual(closure[2], closure[3]);
    assert(result.source.includes(`print(${closure[1]}())`), `closure use mismatch for order ${order.join(" -> ")}\n${result.source}`);
}

const orders = topologicalOrders();
assert(orders.length > 10, "dependency-order generator did not produce enough legal variants");
for (const order of orders) {
    const rootBody = [];
    for (const name of order) rootBody.push(...events.get(name).lines);
    rootBody.push(
        'ReturnVal = "print"',
        "state = _env[ReturnVal]",
        "ReturnVal = r3()",
        "ReturnVal = state(ReturnVal)",
        "r3 = nil",
        "ReturnVal = {}",
        "state = nil",
    );
    assertRecoveredSemantics(vmSource(rootBody), order);
}



// A cell allocated before a branch is still path-sensitive compiler storage.
// Releasing it on one terminal arm must not erase the sibling arm's live capture.
{
    const source = [
        "vm = function(state, args, upvalues, gcProxy)",
        "    local r1, r2, r3, ReturnVal",
        "    while state do",
        "        if state == 1 then",
        "            r1 = allocUpvalue()",
        "            state = 10",
        "            upvalueValues[r1] = state",
        '            ReturnVal = "cond"',
        "            state = _env[ReturnVal]",
        "            state = state and 2 or 3",
        "        elseif state == 2 then",
        "            r1 = releaseUpvalue(r1)",
        "            ReturnVal = {}",
        "            state = nil",
        "        elseif state == 3 then",
        "            state = createClosure0(4, { r1 })",
        "            r2 = state",
        '            ReturnVal = "print"',
        "            state = _env[ReturnVal]",
        "            ReturnVal = r2()",
        "            ReturnVal = state(ReturnVal)",
        "            ReturnVal = {}",
        "            state = nil",
        "        elseif state == 4 then",
        "            r3 = upvalueValues[upvalues[1]]",
        "            ReturnVal = { r3 }",
        "            state = nil",
        "        end",
        "    end",
        "    state = #gcProxy",
        "    return unpack(ReturnVal)",
        "end",
    ].join("\n");
    const result = solveBetaControlFlow(source, parse(source));
    assert.strictEqual(result.applied, true, result.reason || "pre-branch captured cell was erased by sibling release");
    parse(result.source);
    for (const compilerName of ["allocUpvalue", "releaseUpvalue", "upvalueValues", "createClosure"]) {
        assert(!result.source.includes(compilerName), compilerName + " leaked in sibling-release regression");
    }
    const binding = result.source.match(/local\s+(v\d+)\s*=\s*10\b/);
    assert(binding, result.source);
    assert(new RegExp("return\\s+" + binding[1] + "\\b").test(result.source), result.source);
}

console.log(`beta control-flow capture-order tests passed (${orders.length} legal orders)`);
