# Project Overview

The user is starting a brand-new Lua/Luau deobfuscator project intended to recover readable, source-like Lua from Prometheus-obfuscated code. The new project should be designed from the ground up using the user's base ideas, while keeping the semantic lessons learned from the previous `promdeobf` project without carrying over its accumulated implementation mistakes.

The active project directory is:

```text
C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf
```

The Git repository is connected to:

```text
https://github.com/GooseGoldenGoose/new-promdeobf.git
```

# Core Knowledge & Rules

## General Deobfuscation Philosophy

- Recover **source-like Lua/Luau semantics**, not merely code that parses or happens to run.
- Fix problems at the **earliest responsible AST / CFG / data-flow / scope stage**.
- Never patch final emitted text to hide structural mistakes.
- Do not hardcode fixture filenames, VM register names, block IDs, source strings, methods, URLs, or specific sample constants.
- Obfuscator/runtime signatures may be specialized when they are genuinely part of the Prometheus implementation, but fixture-specific assumptions are forbidden.
- Always preserve evaluation order, reaching definitions, lexical scope, closure captures, mutable upvalue semantics, table/object identity, call count, multi-return behavior, and loop behavior including zero-iteration cases.
- Do not invent locals for globals. Globals such as `game`, `table.insert`, `pairs`, and `ipairs` should remain globals unless lexical evidence proves otherwise.
- Only inline values when movement is provably semantics-safe.
- Do not collapse aliases merely because nearby code looks related.
- Namecall recovery requires receiver identity and call-count proof.
- Parsing successfully is not enough. Generated output must be inspected for semantic contradictions.

## Working Style

- The user wants direct technical judgment.
- If an idea is weak or unsafe, say so and propose a better design.
- Do not agree with an approach just because the user suggested it.
- Prefer generalized compiler/data-flow reasoning over local pattern hacks.
- Build incrementally and add focused regressions for semantic rules.
- Test each coherent change before continuing.
- Treat `CONTEXT.md` as a live handoff: update it after meaningful decisions or implementation work, compact superseded detail, and remove stale topics that have not mattered for a while.
- After every project change, even a small one, create a Git checkpoint commit and push it to origin/main.
- At the end of every assistant turn, clearly state that the current work is done and the user can send the next prompt.
## Prometheus Reference

Whenever the user says **Prometheus**, use this repository as the reference implementation:

```text
https://github.com/wcrddn/Prometheus
```

Do not rely on vague recollection if exact Prometheus behavior matters. Inspect that repository when needed.

## Recommended Implementation Language

Current recommendation:

```text
TypeScript + Bun
```

The project is dominated by AST rewriting, CFG reconstruction, scope analysis, reaching definitions, provenance, lifetime tracking, and closure analysis. TypeScript provides strong AST unions and faster iteration than Rust during design-heavy work. Rust is a possible later optimization for expensive analysis if profiling proves it necessary. Do not start hybrid TypeScript/Rust unless profiling justifies it.

Preferred conceptual layout:

```text
src/
  parser/
  ast/
  analysis/
    scopes.ts
    cfg.ts
    dominators.ts
    reachingDefs.ts
    liveness.ts
    effects.ts
    captures.ts
    provenance.ts
  passes/
    vm/
    strings/
    controlFlow/
    cleanup/
  printer/
  pipeline/
```

## Core Architectural Principle

Transformations should query formal analysis rather than guessing from adjacency.

Bad:

```ts
if (previousStatementLooksLikeAlias) {
    inline()
}
```

Preferred:

```ts
const def = reachingDefs.uniqueDefinition(binding, useSite)

if (
    def &&
    !captures.isCaptured(def.binding) &&
    effects.canMove(def.value, def.site, useSite)
) {
    inline()
}
```

# Current Progress & Key Decisions

## Old Project

The prior project existed at:

```text
C:\Users\reala\Desktop\!workspaces\promdeobf ova\promdeobf
```

It had accumulated many semantic recovery passes and regressions. At the user's request, its `main` branch was reverted to:

```text
9fb1a43 Recover short-circuit polling loops
```

and `origin/main` was force-updated to that commit.

The user then decided to stop continuing that implementation and start a new project. The detailed old bug list, fixture-specific repair plan, and later experimental fixes should not drive the new implementation.

Retain only the methodology learned from that work:

- find the earliest destructive transformation
- reason through real lifetimes
- treat captured mutable state carefully
- do not use final-output cleanup to conceal an analysis bug
- test semantics, not just syntax

## New Project

Active directory:

```text
C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf
```

Git remote:

```text
https://github.com/GooseGoldenGoose/new-promdeobf.git
```

Current pushed commits:

```text
f188f8f Initial commit
ffda1ba Add Luau AST entrypoint
c7cf1e9 Add Lua AST inspection tool
```

Current implementation:

- `main.js` reads Lua/Luau source, parses it with the Luau-capable parser, keeps the AST in memory for future passes, and can dump it to `output/ast.json`.
- `parser/luaparse.js` is reused only as the syntax frontend; no old deobfuscation passes were ported.
- `tools/inspect-lua.js` is a developer-only AST inspection helper for node counts, functions, calls, globals, control-flow nodes, and targeted searches by node type/name.
- Default deobfuscator input is currently `formater/out.txt`.
- `formater/luau-format.exe` is the normalization stage. Its existing runner formats Lua and simplifies arithmetic/constants before AST processing.
- Controlled obfuscator fixture source exists at `C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`; `run.bat` invokes `luajit cli.lua --preset Medium input.txt`, producing `input.txt.obfuscated.lua`.
- Both the formatted sample and the direct `wearedev obf\input.txt.obfuscated.lua` parse successfully as a `Chunk` with one top-level statement.
- Existing untracked `sample/` content should not be modified unless explicitly needed.
- sample\1.txt is the current normalized fixture copied byte-for-byte from ormater\out.txt; use it as the next-stage deobfuscation sample.

## Prometheus ConstantArray Step

- The arithmetic constant-folding pass was removed; step 1 is Prometheus ConstantArray recovery.
- `passes/constant-array.js` structurally recovers the literal array, optional rotation, accessor offset, and custom-base64 decoder.
- Accessor replacement is scope-aware; fixture names, offsets, and constant values are not hardcoded.
- Missing ConstantArray is now a safe pass-through so later stages still run when that Prometheus step is disabled.
- `sample\1.txt`: 7 constants recovered and 10 references inlined with 0 unresolved wrapper/array uses.
- `sample\2.txt`: 11 constants recovered and 14 references inlined with 0 unresolved wrapper/array uses.
- `sample\3.txt` is a controlled scope/upvalue fixture: outer mutable `x`, shadowed block-local `x`, block-local `y`, and two closures (`inc`, `get`) sharing the captured outer `x`.
- `sample\4.txt` is a controlled Medium-obfuscated CFG fixture with three closures sharing mutable `total`: `choose(n)` uses if/else, `spin(n)` uses a while loop with nested if/else, and `trim(limit)` uses repeat/until. ConstantArray recovery finds 13 entries and inlines 19 references with 0 unresolved wrapper/array uses.
- Keep the current Luau parser while sufficient; Rust Moonlight is acceptable if parser limitations become a correctness blocker.

## Step 2: VM Wrapper Semantic Naming

- Step 2 now uses `passes/environment.js`, `passes/closure-factory.js`, `passes/vm-helpers.js`, and `passes/split-safe-assignments.js`.
- Environment provenance is recovered from the wrapper call (direct `getgenv()`, Prometheus-style `getfenv and getfenv() or _ENV`, or direct `_ENV`) and the receiving binding is renamed to `_env` with lexical shadow/collision checks.
- Closure factories are detected by behavior: a factory receives an entry ID and capture list, obtains an upvalue proxy, returns a nested closure, and that closure calls the shared VM with `(entryId, argsTable, captures, proxy)`.
- The general vararg factory is `createClosure`. Fixed-arity factories are independently named `createClosureN` from the actual nested wrapper arity; do not assume 0/1 or any particular generated binding.
- The closure-factory graph identifies the shared VM and upvalue-proxy helper without generated-name or numeric-entry-ID assumptions.
- `passes/vm-helpers.js` currently recovers: `unpack`, `newproxy`, `setmetatable`, `getmetatable`, `select`, `vm`, `createUpvalueProxy`, `releaseUpvalues`, `releaseUpvalue`, `allocUpvalue`, `upvalueRefCounts`, `upvalueValues`, and `currentUpvalueId`.
- The VM function parameters are renamed structurally to `state`, `args`, `upvalues`, and `gcProxy` from their positions in every detected closure-factory call.
- Helper parameters are also recovered where proven: `releaseUpvalue(upvalueId)`; proxy/GC helpers use `captures`; closure factories use `(entryId, captures)`.
- Renaming is binding/scope-aware through `renameFunctionParameterBinding`; collisions are skipped/reported rather than forcing a textual rename.
- `passes/split-safe-assignments.js` decomposes proven-safe parallel identifier assignments into one assignment per line. It currently permits anonymous function literals, primitive literals, empty table constructors, and signed numeric literals as RHS values; indexed LHS, calls/effectful expressions, local declarations, and other order-sensitive parallel assignments are preserved.
- Current helper initialization splits: sample 1 -> 9 assignments, sample 2 -> 9 assignments, sample 3 -> 11 assignments, sample 4 -> 12 assignments. Sample 3/4 emit readable helper assignments such as `releaseUpvalue = function(...)`, `createUpvalueProxy = function(...)`, `vm = function(...)`, `upvalueValues = {}`, and closure factories.
- Full tracked validation covers `sample\1.txt` through `sample\4.txt`; all pass ConstantArray + step-2 recovery and final output reparses.
- `sample\3.txt` runtime remains identical after semantic naming: `block 10 2`, `before 1`, `after 3 3`.
- A fresh randomized Medium obfuscation of the same sample-3 source also passed. It changed bindings (for example environment `V`, general factory `O`, VM `W`, proxy `p`) and emitted fixed factories of arity 2 and 5 instead of the tracked fixture's 0 and 1; the pass recovered `createClosure2` / `createClosure5` structurally and the transformed output produced the same runtime result.
- `main.js` reparses between semantic naming stages and writes stable outputs `output\1.lua` through `output\4.lua` when invoked with the corresponding sample/output paths.

## Step 3: VM State / CFG Recovery

- VM state/CFG recovery is now part of the normal deobfuscation pipeline after helper naming and safe parallel-assignment splitting. The implementation lives in `passes/vm-state.js` and is called from `main.js` through `recoverVmStateGraph(...)`.
- The final normal command is one step: `node main.js sample\4.txt output\4.lua`. A separate beta resolver command is no longer required; `output\1.lua` through `output\4.lua` now contain the normalized VM-state result when recovery is proven safe.
- Promotion is conservative: `main.js` applies the VM-state rewrite only when the pass both finds the VM and reports `normalized === true`. If recovery is incomplete or normalization safety fails, main preserves the source from the previous pipeline step instead of forcing an experimental rewrite.
- `passes/vm-state.js` finds the semantic `vm`, root `createClosure(<entry>, ...)`, all `createClosureN(<entry>, ...)` calls, and `while state do`; state IDs and closure arities are discovered structurally.
- Dispatcher leaves are resolved by evaluating Prometheus nested numeric comparison trees for candidate state IDs. The walker follows proven POS-register terminators: `state = N` is a direct jump and `state = condition and A or B` is a two-way branch.
- Critical rule: Prometheus can temporarily reuse `POS_REGISTER` as an ordinary register, so not every assignment to the renamed `state` binding is a control-flow transition. Only the final proven POS/state write in a recovered dispatcher block is treated as its terminator.
- Graph walking uses a visited set, so back-edges are retained without infinite analysis. Closure-created entry IDs remain separate graph roots unless an actual CFG transition targets them.
- Normalization requires complete dispatcher-leaf coverage, no cross-root state overlap, all blocks resolved, only proven `jump` / `branch` / `stop` terminators, and every numeric successor present in the recovered state map.
- Safe graphs receive new contiguous IDs by closure root. Only proven closure entry arguments and CFG jump/branch targets are rewritten; ordinary temporary numeric values assigned through the reused state register are left unchanged.
- Each closure graph gets a contiguous normalized range, and output uses balanced binary range trees between closure ranges and inside each range. Exact equality is retained at final leaves for invalid-state safety, avoiding large `or` expressions and long linear `elseif` chains.
- Tracked normalization: sample 1 -> root range `1`; sample 2 -> root CFG `1-3`; sample 3 -> root `1`, closures `2` and `3`; sample 4 -> root `1`, `choose` `2-5`, `spin` `6-12`, `trim` `13-16`.
- Sample 4 closure calls become `createClosure1(2, ...)`, `createClosure2(6, ...)`, `createClosure5(13, ...)`, and the root call becomes `createClosure(1, ...)`. Its loop and repeat back-edges remain intact.
- End-to-end validation compares each original tracked obfuscated file with the promoted normal output under LuaJIT: sample 1 prints `AD`; sample 2 prints `gg`, `ranf` with `warn = print` and a fixed RNG seed; sample 3 prints `block 10 2`, `before 1`, `after 3 3`; sample 4 prints `start 0`, `choose 5`, `spin 10`, `trim 2`. All original/promoted pairs exit 0.
- A fresh randomized Medium sample-4 obfuscation previously changed the original root/closure IDs and closure-factory arities completely; recovery still produced logical ranges `1`, `2-5`, `6-12`, `13-16` and matched runtime, supporting name/ID-independent recovery.
- `tools/inspect-vm-state.js` remains an optional developer inspection utility for printing graph roots, terminators, dispatcher paths, and normalized ranges; it is not required for normal deobfuscation.

## Control-Flow Understanding

Prometheus-style control-flow flattening should be modeled as a dispatcher/state machine.

Conceptually:

```lua
local state = A

while true do
    if state == A then
        ...
        state = B
    elseif state == B then
        ...
    end
end
```

Prometheus may encode dispatcher selection through nested comparisons instead of direct equality tests.

The new deobfuscator should recover:

```text
dispatcher state value
    เนยโ€
basic block
    เนยโ€
successor transitions
    เนยโ€
CFG
```

Recommended basic block model:

```ts
type Terminator =
    | { kind: "jump"; target: BlockId }
    | { kind: "branch"; condition: Expr; onTrue: BlockId; onFalse: BlockId }
    | { kind: "return"; values: Expr[] }
    | { kind: "stop" }

interface BasicBlock {
    id: BlockId
    statements: Statement[]
    terminator: Terminator
}
```

Preferred recovery pipeline:

```text
Prometheus dispatcher
        เนยโ€
basic blocks
        เนยโ€
CFG
        เนยโ€
dominators
post-dominators
backedge detection
loop discovery
        เนยโ€
structured regions
        เนยโ€
Lua/Luau AST
```

Important decisions:

- Do not immediately turn CFG blocks back into Lua statements.
- Maintain a real CFG intermediate representation first.
- Detect loops before aggressively structuring if-statements.
- Backedges where the target dominates the source are strong natural-loop evidence.
- Use post-dominators to identify branch joins.
- Short-circuit boolean expressions should also be reconstructed from CFG structure.
- The CFG layer must identify dispatcher behavior structurally and must never depend on names such as `r37`, `state`, or `__vm_pc`.

## Prometheus Scope Handling

Prometheus lexical scopes track structures conceptually equivalent to:

```text
parentScope
variables
variablesLookup
variablesFromHigherScopes
children
level
```

A child scope resolves identifiers through parent scopes. A reference to an outer lexical variable is tracked as a reference to that actual binding rather than only by its text name.

Normal block nesting does not automatically create an upvalue. Crossing a **function boundary** does.

## Prometheus Upvalue Handling

Prometheus treats captured locals as shared mutable cells.

Source:

```lua
local x = 1

local function inc()
    x = x + 1
end

local function get()
    return x
end
```

must behave conceptually like:

```text
       เนโ€ยเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€ย
inc เนโ€โฌเนโ€โฌเนโ€“เธเนโ€ย shared x cell เนโ€ยเนโ€”ยเนโ€โฌเนโ€โฌ get
       เนโ€โ€เนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€โฌเนโ€ย
```

It must not be treated as two copied values.

Prometheus runtime structures conceptually include:

```text
upvaluesTable[id]
upvaluesReferenceCounts[id]
```

A captured variable is represented through an upvalue ID/cell.

Conceptual distinction:

```text
ordinary local:
register -> value
```

versus:

```text
captured local:
register -> upvalue ID -> shared value
```

Nested functions receive references to those cells. Deep nesting can relay an upvalue through intermediate functions:

```text
root binding
    เนยโ€
function A upvalue slot
    เนยโ€
function B upvalue slot
    เนยโ€
function C upvalue slot
```

Captured function parameters are also promoted into shared upvalue cells.

At scope/function cleanup, Prometheus uses reference counting so a captured cell survives after the original lexical scope ends while closures still reference it.

Therefore the new deobfuscator should recover an explicit binding/capture graph before aggressive inlining.

Suggested model:

```ts
interface Binding {
    id: BindingId
    ownerFunction: FunctionId
    ownerScope: ScopeId
    captured: boolean
    mutable: boolean
    upvalueCell?: UpvalueCellId
}
```

and:

```ts
interface ClosureCapture {
    childFunction: FunctionId
    slot: number
    binding: BindingId
}
```

This should allow VM-level code resembling:

```lua
upvalueId = allocUpvalue()
upvalues[upvalueId] = false

makeClosure(..., upvalueId)
```

to eventually recover as:

```lua
local enabled = false

local function callback()
    enabled = ...
end
```

without producing unrelated locals.

# Immediate Next Steps

1. Treat `output\\N.lua` as the normal final output through promoted Step 3; keep earlier step boundaries only as internal pipeline stages.
2. Treat promoted Step 3 output as the normal baseline and use sample 4 as the primary CFG regression for source-level `if`/loop/repeat structuring; keep closure graphs distinct and preserve proven jump/back-edge semantics.
3. Keep POS-register temporary reuse distinct from true block terminators; extend terminator recognition only from proven Prometheus compiler patterns.
4. Keep each pass structural/generalized and reparse/runtime-check transformed outputs before advancing.
5. If the current parser becomes a correctness blocker, evaluate Rust Moonlight instead of parser-specific hacks.
6. Update `CONTEXT.md`, commit, and push every project change as a checkpoint.
