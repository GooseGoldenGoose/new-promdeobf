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

# Fresh-Chat Startup / Mandatory Workflow

When continuing this project in a new chat:

- Read this entire `CONTEXT.md` first and treat it as the authoritative live handoff. Do not ask the user to repeat decisions already recorded here.
- Active workspace: `C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf` on branch `main`; remote is `https://github.com/GooseGoldenGoose/new-promdeobf.git`.
- Use the connected Windows shell for project work. Prefer direct file edits / Node UTF-8 writes over PowerShell text round-trips when changing `CONTEXT.md`.
- Every project code/content change, even tiny, must be checkpointed with `git add` for only intended files, a focused commit, and `git push origin main`. Keep conceptually separate changes in separate commits when practical.
- Keep `CONTEXT.md` continuously updated after meaningful implementation/analysis decisions. Compact or replace stale/superseded notes rather than accumulating contradictions.
- Never stage or modify unrelated untracked workspace items. Current intentional untracked items include `formater/` and `sample/5.txt` unless the user explicitly changes that policy.
- Everything must be structural/generalized: never hardcode sample IDs, state numbers, register names, closure arities, strings, filenames, or random constants. Fix root causes, not output text afterward.
- After transformations, reparse generated Lua and run runtime regressions whenever executable fixtures permit it. Compare original/readable source, obfuscated input, and deobfuscated output where useful.
- When the user says **Prometheus**, they mean the local WeAreDevs obfuscator/compiler fixture at `C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`. Verify exact behavior against that local source first. Only use the public/canonical repository if the user explicitly asks for canonical/public Prometheus.
- Preserve stable pipeline behavior when experimenting. A recovery pass must fail closed: if proof is incomplete, preserve the previous safe output rather than guess.
- End every project-related turn with exactly: `Done for this turn — you can prompt now.`

Current implementation checkpoint is `7442545 Document overflow register scheduling` on `main`, pushed to `origin/main`. The active emitted pipeline includes structural helper/environment naming, safe assignment splitting, closed reachable VM-state normalization, analysis-only VM binding/capture metadata, dependency-safe scalar + proven-overflow register scheduling, VM register naming (`ReturnVal`, `rN`), and structural semantic naming (`InitialArgs`, helper locals, fixed closure args, `RegisterOverflow`). Source lexical-scope reconstruction has NOT been implemented yet.

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
- End every project-related assistant turn with exactly: `Done for this turn — you can prompt now.`
## Prometheus Reference

When the user says **Prometheus**, treat it as the local WeAreDevs obfuscator used by this project:

```text
C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf
```

Its compiler source is under `src/prometheus/compiler/compiler.lua`. Use this local implementation as the authority for exact VM/compiler behavior. Do not substitute the public `wcrddn/Prometheus` repository unless the user explicitly asks for the canonical/public implementation.

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
- The normal command is one step: `node main.js <input> <output>`. A separate state resolver is not required; the normal output contains the normalized VM-state result whenever recovery is proven safe.
- Promotion is conservative: `main.js` applies the VM-state rewrite only when the pass both finds the VM and reports `normalized === true`. If recovery is incomplete or normalization safety fails, main preserves the source from the previous pipeline step instead of forcing an experimental rewrite.
- `passes/vm-state.js` finds the semantic `vm`, root `createClosure(<entry>, ...)`, all `createClosureN(<entry>, ...)` calls, and `while state do`; state IDs and closure arities are discovered structurally.
- Dispatcher leaves are resolved by evaluating Prometheus nested numeric comparison trees for candidate state IDs. The walker follows proven POS-register terminators: `state = N` is a direct jump and `state = condition and A or B` is a two-way branch.
- Critical rule: Prometheus can temporarily reuse `POS_REGISTER` as an ordinary register, so not every assignment to the renamed `state` binding is a control-flow transition. Only the final proven POS/state write in a recovered dispatcher block is treated as its terminator.
- Graph walking uses a visited set, so back-edges are retained without infinite analysis. Closure-created entry IDs remain separate graph roots unless an actual CFG transition targets them.
- Normalization requires a closed reachable graph from every discovered closure entry: no unsupported/non-numeric closure-entry calls, no cross-root state overlap, all reached blocks resolved, only proven `jump` / `branch` / canonical-stop terminators, and every numeric successor present in the reachable state map. Full dispatcher-leaf coverage is not required because canonical `emitContainerFuncBody()` emits every block in `self.blocks` without reachability pruning; dispatcher leaves outside the closed reachable graph are dead compiler blocks and can be omitted.
- Safe graphs receive new contiguous IDs by closure root. Only proven closure entry arguments and CFG jump/branch targets are rewritten; ordinary temporary numeric values assigned through the reused state register are left unchanged.
- Each closure graph gets a contiguous normalized range, and output uses balanced binary range trees between closure ranges and inside each range. Exact equality is retained at final leaves for invalid-state safety, avoiding large `or` expressions and long linear `elseif` chains.
- Tracked normalization: sample 1 -> root range `1`; sample 2 -> root CFG `1-3`; sample 3 -> root `1`, closures `2` and `3`; sample 4 -> root `1`, `choose` `2-5`, `spin` `6-12`, `trim` `13-16`.
- Sample 4 closure calls become `createClosure1(2, ...)`, `createClosure2(6, ...)`, `createClosure5(13, ...)`, and the root call becomes `createClosure(1, ...)`. Its loop and repeat back-edges remain intact.
- End-to-end validation compares each original tracked obfuscated file with the promoted normal output under LuaJIT: sample 1 prints `AD`; sample 2 prints `gg`, `ranf` with `warn = print` and a fixed RNG seed; sample 3 prints `block 10 2`, `before 1`, `after 3 3`; sample 4 prints `start 0`, `choose 5`, `spin 10`, `trim 2`. All original/promoted pairs exit 0.
- A fresh randomized Medium sample-4 obfuscation previously changed the original root/closure IDs and closure-factory arities completely; recovery still produced logical ranges `1`, `2-5`, `6-12`, `13-16` and matched runtime, supporting name/ID-independent recovery.
- `tools/inspect-vm-state.js` remains an optional developer inspection utility for printing graph roots, terminators, dispatcher paths, and normalized ranges; it is not required for normal deobfuscation.
- Large untracked `sample\5.txt` is now the stress validation for Step 3: the initial walker reached 810/938 dispatcher leaves. Structural recovery of Prometheus split `and`/`or` POS branches expanded this to 930 reachable states; the remaining 8 dispatcher leaves have no incoming edge from any of 116 discovered closure roots or any reachable state.
- Closure-root discovery is now reachability-driven instead of global-AST-driven. Recovery starts from the real outer `createClosure` root, walks its closed CFG, discovers `createClosureN(entry, ...)` calls only inside those reachable blocks, then recursively walks the newly discovered child roots. A closure call that exists only in a dead dispatcher leaf can no longer keep its dead closure graph alive. Reachable unsupported closure-entry calls still fail normalization closed; unsupported/dead calls outside the reachable graph do not poison recovery. `tools/test-vm-state-reachability.js` proves a dead state that creates a dead closure is removed together with that child graph.
- Canonical compiler confirmation: `setPos(scope, nil)` deliberately emits `state = _env[randomString(12..14)]` instead of literal nil (the source comment retains `--Ast.NilExpression()`). Step 3 treats only this compiler-shaped random alphanumeric `_env[...]` lookup (or literal nil) as a stop; other unknown final state writes block normalization instead of being guessed as stops. Once a stop is proven, normalized rendering removes the obfuscator-only random environment lookup and emits semantic `state = nil` at the actual end of that recovered state body. The relocation is structural and restricted to a single canonical stop assignment; ordinary `_env[...]` lookups remain untouched/effectful.
- Normalized dispatcher leaf rendering no longer emits the defensive `else -- invalid/unreachable VM state; state = nil` fallback. A normalized CFG is already proven closed from every reachable root/closure entry and every emitted successor is in the normalized state map, so that branch is unreachable scaffolding on valid execution. Exact state equality checks remain, and balanced range-selection `else` branches remain because they route real normalized states. The older non-normalized/fail-closed renderer keeps its defensive fallback.
- Canonical numeric-for confirmation: Prometheus may split `state = condition and innerId or finalId` across temporary-register statements (`tmpTrue = innerId; state = condition and tmpTrue; tmpFalse = finalId; state = state or tmpFalse`). Step 3 recognizes this exact adjacent data-flow shape and rewrites both target literals during normalization.
- Canonical dispatcher generation (`emitContainerFuncBody`) shuffles and emits every entry in `self.blocks` before building the comparison tree; it does not prune unreachable blocks. Therefore sample 5 safely normalizes its closed 930-state reachable graph to IDs `1..930` and prunes 8 proven unreachable dispatcher leaves. `main.js` reports `VM state recovery applied: true`, `VM unreachable dispatcher leaves pruned: 8`, and `VM state IDs normalized: true`.
- Sample-5 normalization has 116 closure graph roots and zero unsupported closure-entry calls. Known original split-branch target IDs are absent from normalized output, while their executable temporary loads use compact normalized targets. A dead-leaf-only random sentinel checked during validation is also absent from output.
- A fresh temporary Medium numeric-`for` regression resolved 7/7 states and preserved runtime (`numfor 9`) while normalizing its compiler-split branch, confirming the rule is structural rather than sample-5-specific.
- Tracked `sample/6.source.lua` / `sample/6.txt` is the closure-ownership regression. Readable source: top-level captures `seed`; `outer(n)` has an `if` and `while`; inside `outer` a nested `inner(delta)` captures `value` and has its own branch. Runtime for readable source, obfuscated fixture, and deobfuscated output is identical: `theory 8 10 5`, exit 0.
- Sample 6 resolves 11/11 states into three closure graphs: root `1`; nested `inner` is `createClosure5` states `2-4` (original entry `2234492`); `outer` is `createClosure6` states `5-11` (original entry `7146503`). Root state 1 creates `outer` via `createClosure6(5, ...)`; inside `outer` state 11 creates `inner` via `createClosure5(2, ...)`. This proves multiple states in one range are pieces of one source function, while function nesting is established by a closure-creation call inside another function's reachable CFG, not by nested dispatcher `if` nodes.
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

- Fixture-generation rule: controlled Prometheus fixtures must use `source -> Prometheus Medium -> formater/luau-format.exe input.txt --luraph --output=out.txt -> sample/N.txt`. Do not copy raw Prometheus output directly into a tracked sample fixture; the formatter is part of the expected normalization stage. `formater/` remains intentionally untracked.
- Current tracked `sample/7.source.lua` now uses `if math.random(1,2) == 1 then` with a shadowed `local b = 2`, `print(b)`, and `return 123` inside that branch. The false branch falls through to `print(b)` using the outer `b = 3`, then creates/calls `w()` which reads captured `a`. Deterministic runtime checks cover both paths: seed 1 prints `1`, `2` and returns `123`; seed 3 prints `1`, `3`, `1` and returns nil. Source, formatted Prometheus fixture, and deobfuscated output match exactly on both seeds.
- After formatter normalization, sample 7 has 4/4 reachable dispatcher leaves. Step 3 normalizes the root CFG to states `1-3` and the reachable nested `w` closure to state `4`; no dispatcher leaves are pruned. This fixture now exercises branch-dependent early return, fallthrough, ordinary-local shadowing, and a reachable captured closure in one small graph.
- Current sample-7 data flow keeps the outer `b = 3` value live across the conditional CFG, while the branch-local shadowed `b = 2` is a separate definition used only on the returning branch. Source `a = 1` is represented by one local upvalue cell and the fallthrough path creates `w` with one capture slot pointing to that same cell. Register spellings are randomized fixture evidence only and must never become implementation assumptions.
- Scope-recovery rule remains: never merge identifiers by spelling or reused VM register name. Recover source binding identity from lexical/function ownership, reaching definitions/liveness, environment-vs-local provenance, and explicit closure capture/upvalue-cell identity; exact original block syntax may be unrecoverable once compilation erases it.

## Step 4: VM Binding / Capture Analysis

- `passes/vm-bindings.js` is now part of the normal analysis pipeline immediately after Step 3 graph recovery. It is analysis-only: it does not rewrite emitted Lua, and it runs only when the VM graph is found, closed, and safely normalized; otherwise it fails closed with no binding claims.
- Function identity is derived from Step 3 closure graph roots, not dispatcher nesting or VM register names. Closure-factory calls found inside a function's owned CFG infer parent/child function ownership. Sample 6 therefore proves the structural chain root -> outer -> inner even though all states still execute in the shared VM function.
- Every VM-register write inside an owned CFG receives a distinct definition-site identity. A forward reaching-definitions fixed point is computed across CFG predecessors/backedges. Identifier uses are linked to a source value only when exactly one definition reaches that use; joins with multiple possible definitions remain ambiguous instead of being guessed.
- Closure capture slots are provenance-classified. An identifier capture becomes a `local-cell` only when its unique reaching definition is a zero-argument `allocUpvalue()` result. Direct `upvalues[n]` capture expressions are recorded as `parent-capture-slot` relays. Capture metadata keeps `childSlot` and `parentSlot` distinct; this fixes the earlier metadata collision where a relayed parent slot could overwrite the child slot. Other forms remain explicitly unproven. This matches canonical Prometheus compiler behavior, where a nested function can capture either a newly allocated local cell or a higher-function upvalue slot.
- `upvalueValues[...]` reads and writes now have explicit access identities. Their cell index is resolved through reaching definitions for local `allocUpvalue()` IDs or recursively through `upvalues[n]` capture-slot relays. A relayed slot is considered resolved only when every static provenance path is complete and converges to one static cell-allocation identity; cycles, multiple cells, and incomplete provenance remain unresolved.
- Shared-cell identity is now explicit: sample 3's two closures resolve to the same local cell and all 5 cell accesses resolve to it; sample 4's three closures resolve to the same `total` cell and all 17 accesses resolve; sample 6 resolves the root->outer and outer->inner captures to two different cells with all 14 accesses resolved. Current sample 7 has 2 recovered functions, 1 local cell, 1 reachable capture slot, and 3/3 cell accesses resolve to that cell.
- Large untracked sample 5 also converges under the analysis: 116 recovered functions, 112 local upvalue-cell allocations, 131 parent-slot relays, and 3,017 `upvalueValues` accesses are observed. 2,835 accesses resolve to one static cell and 182 remain unproven; unresolved large-sample cases are metadata only and are not rewritten.
- Definition-site liveness is now computed backward over each recovered function CFG using the reaching-definition identities. Each definition records use counts, live-in/live-out blocks, cross-block lifetime, and loop-carried status. Alternative definitions are placed in a conservative join component only when they co-reach the same identifier use; sequential register reuse is not merged. Sample 4 has one such join component and one loop-carried lifetime; sample 6 has cross-block lifetimes; current sample 7 has 45 definitions, 32/32 uniquely resolved uses, 0 join components, 2 cross-block lifetimes, and 0 loop-carried lifetimes; sample 5 converges with 177 join components, 695 cross-block lifetimes, and 61 loop-carried lifetimes.
- Captured source-binding candidates now exist as a separate proof class keyed by static `allocUpvalue()` definition identity. Every candidate summarizes its owning function, resolved `upvalueValues` reads/writes, capture consumers, and transitive relays. Capture edges themselves carry final `resolvedCellId` when provable. Samples 3/4/6 have complete reachable capture graphs. Current sample 7 again has one complete captured-cell candidate with a reachable consumer in `w`; all 3 cell accesses resolve. Sample 5 remains fail-closed with 92 unresolved capture edges plus 182 unresolved cell accesses, so its 112 candidates are marked provenance-incomplete and are not eligible for source rewriting.
- `main.js` exposes compact reaching-definition, lifetime, cell-access, and captured-binding-candidate counts. Step 4 remains analysis-only; its metadata is computed from the proven Step-3 graph and is not rewritten by later presentation scheduling. Final emitted Lua is reparsed after all post-Step-3 scheduling.

- Cross-state register lifetime proof is present in tracked fixtures. Sample 4 has a direct ordinary-register case: normalized state 2 assigns `Z = args[1]`, branches to state 3/4, and state 3 uses the same reaching definition in `state = L + Z` without redefining `Z`. Sample 6 has two such definition identities, including `c` defined in normalized state 2 and consumed in later states plus an upvalue-cell register `Z` allocated in state 5 and reused across later states. Current sample 7 has root-state definitions `O = 3` and `j = allocUpvalue()` in state 1 that reach state 3, where `O` is used by `print` and `j` is used for closure capture/release without redefinition. Samples 1-3 currently have no unique cross-state register definition/use cases. State boundaries therefore cannot be treated as register-scope boundaries.

- Cross-state lifetime classification: this is not limited to conditional `if` branches. Sample 4 has (a) `choose`: state 2 defines `Z = args[1]`, then a branch carries it to state 3 where `Z` is used; (b) `spin`: state 6 defines `Z = args[1]`, then an unconditional jump goes to state 7 where `Z` is used as the loop bound and the same definition remains live across the later backedge `12 -> 7`; (c) `trim`: state 13 defines `Z = args[1]`, then unconditional jumps `13 -> 14 -> 15` carry it to the state-15 comparison, and the same definition survives the loop branch `15 -> 14`. Sample 6 inner `c` crosses the state-2 branch into either state 3 or 4; outer `Z = allocUpvalue()` is created in state 5, then survives both branch arms, the state-9/10 loop, and reaches state 11 closure creation. Sample 7 state 1 carries outer `O = 3` and captured-cell register `j` only along the fallthrough branch to state 3. Untracked sample 5 has 374 unique cross-state definition identities: 272 originate in branch-terminated states and 102 originate in unconditional-jump states (1,486 unique cross-state uses total). A `stop` block cannot originate a later-state use because there is no successor.
- Local WeAreDevs compiler register-allocation proof: source locals are keyed by `(scope, id)` in `registersForVar`; `getVarRegister(scope, id, ...)` reuses the same reserved `VAR_REGISTER` for repeated reads/writes of that source binding while it is live. `allocRegister(true)` prevents another live variable from taking that occupied register. At lexical block cleanup, `compileBlock` emits `reg = nil` for ordinary locals (or calls the upvalue-release helper for captured locals), then `freeRegister(reg, true)` releases that register for later reuse. Therefore repeated writes to the same VM register can mean mutation of one source binding while its `(scope,id)` remains active, but the same physical register can later represent a different source binding after scope cleanup/release. A visible `reg = nil` is evidence of cleanup only when provenance proves it is the compiler's block-variable cleanup; temporary nil values also exist and must not be treated as scope ends blindly. Captured locals are stronger: the variable register holds an upvalue-cell ID and source assignments update `upvalueValues[cell]`, so a proven identical cell ID is a proven identical captured binding.
- Register-ownership handoff rule for deobfuscation: the emitted VM has no explicit runtime marker for compiler `freeRegister`; ownership changes are therefore inferred conservatively. Treat every register write as a separate value epoch first. A new source-binding epoch may start only after the previous candidate is dead on all relevant CFG paths and there is structural scope-cleanup evidence (`reg = nil` for an ordinary proven local, or `reg = releaseUpvalue(reg)` for a proven captured-cell register), followed by a later first definition after that cleanup. Never use `reg = nil` alone as proof because explicit source assignments and temporary nil values can look identical. Repeated assignments before a proven ownership handoff remain candidates for mutation of the same binding; after a proven handoff the same physical register may represent a different `(scope,id)`. If cleanup/scope ownership is not provable, keep epochs separate rather than guessing.

- Local-nil initialization proof from tracked sample 9 corrects the earlier overgeneralization. `compileExpression(NilExpression)` first allocates an ordinary temporary with `allocRegister(false)`, which preferentially uses the special POS/RETURN registers when available. `getVarRegister(scope,id,...,potentialId)` explicitly refuses to promote `POS_REGISTER` or `RETURN_REGISTER`, so a standalone `local x` or `local y = nil` commonly becomes `tempSpecial = nil; varReg = tempSpecial`. In sample 9, deobfuscated `x` starts as `state = nil; B = state`, while `y = nil` starts as `U = nil; Q = U`. An in-memory compiler trace confirms `x reg=2` and `y reg=3` each received a special temporary potential and `same=false`. Direct single `R = nil` initialization is only possible when the nil temporary is a promotable general register; it is not the default standalone shape and must never be assumed. Existing binding-end analysis remains conservative because it requires prior reaching-definition/lifetime evidence rather than classifying a nil write by syntax alone.

- POS/state cleanup distinction from the local compiler: source locals can never own `POS_REGISTER` or `RETURN_REGISTER`. `allocRegister(true)` bypasses the special-register fast path, and `getVarRegister(..., potentialId)` explicitly rejects POS/RETURN promotion. Therefore lexical local cleanup via `compileBlock -> setRegister(varReg, nil)` cannot become the random environment sentinel. A temporary expression may use POS and thus emit ordinary `state = <value>` (including potentially `state = nil`) through `setRegister`, but only the dedicated control-flow `setPos(scope, nil)` path emits `state = _env[randomString(12..14)]`. Treat `_env[random]` on state as VM-stop/control-flow evidence, not source-variable cleanup.
- Tracked `sample/9.source.lua` / `sample/9.txt` is the nil-local initialization regression: it contains both `local x` and `local y = nil`, prints each before and after later non-nil assignments, and follows the required `source -> WeAreDevs Medium -> formatter -> sample/9.txt -> deobfuscator` workflow. Runtime parity is exact across readable source, formatted obfuscation, and `output/9.lua`: `x0 nil`, `x1 5`, `y0 nil`, `y1 6`.
- Tracked `sample/8.source.lua` / `sample/8.txt` is now the ordinary-register ownership-end regression. It mutates outer `keep`, explicitly assigns `keep = nil` and then reassigns it, creates block-local `inner`, then declares later `after`. An in-memory instrumentation wrapper around the local WeAreDevs compiler proved the ground truth: `keep` stayed on physical register 2; `inner` was bound to physical register 4, `freeRegister(4, true)` occurred at the end of the `do` block, and `after` was then allocated the same physical register 4. The instrumentation changed no compiler file.
- The emitted sample-8 VM distinguishes explicit source nil assignment from lexical cleanup. Source `keep = nil` compiles as a temporary nil definition followed by a copy into the still-reserved `keep` register (`tmp = nil; keepReg = tmp`), while block cleanup for `inner` is a direct dead `innerReg = nil` write; that same register is then reused by `after`. `passes/vm-bindings.js` now records `bindingEndCandidates` only for direct `NilLiteral` definitions with zero uses, exactly one prior reaching definition, and a previously-used value. A later same-block definition of the same physical register upgrades it to an `ownership-handoff-candidate`. Sample 8 reports 3 binding-end candidates and exactly 1 ownership handoff; the explicit `keep = nil` is correctly excluded because its nil temporary has one use. This remains conservative metadata, not a source rewrite.
- Sample-8 runtime parity is exact across readable source, formatted obfuscation, and deobfuscated output: `keep1 11`, `keep2 12`, `inner 22`, `after 33`, `keep3 16`. Tracked samples 1/2/3/4/6/7/8 all reparse after the new analysis. Current binding-end/handoff counts are: 1 `0/0`, 2 `0/0`, 3 `4/2`, 4 `3/0`, 6 `4/0`, 7 `2/0`, 8 `3/1`; these are analysis candidates and must not yet be treated as exact reconstructed lexical scopes without additional region proof.



## Post-Step-3 VM Register Scheduling

- `passes/vm-register-scheduler.js` runs after safe Step-3 normalization. Its purpose is readability: compact in-block producer/use chains so unrelated temporary loads do not separate the values consumed by a statement. It never uses fixture register names or state IDs.
- Scheduling is structural and local to normalized dispatcher leaves. Comments are barriers; blocks with non-whitespace source gaps are left unchanged. The only movable filler remains a one-identifier assignment whose RHS is a primitive literal or a simple identifier copy; assignments to `state`, `args`, `upvalues`, or `gcProxy` are never movable fillers. Table constructors, calls, function literals, indexed writes, arithmetic/other expressions remain non-movable.
- Overflow-register scheduling is now supported only for a structurally proven compiler register bank. `findRegisterOverflowBinding` identifies the VM return/scalar-register declaration from the VM's own final `return unpack(returnReg)`, then requires exactly one preceding empty-table local whose binding is never aliased/reassigned/shadowed and whose every use is a positive constant numeric index. Each proven `RegisterOverflow[k]`-style slot is normalized internally to its own register identity and participates in the same RAW/WAR/WAW scheduler logic as scalar registers. Arbitrary table/index expressions, dynamic overflow indices, aliases, or ambiguous banks remain conservative/non-register accesses.
- The scheduler compacts producer -> consumer and write -> next-touch gaps. Primitive literal/nil register loads may sink toward the next read OR next write of their destination when every crossing is RAW/WAR/WAW-safe, grouping overwrite chains without deleting either write. Simple identifier-copy assignments may pull left toward the nearest producer of their RHS when safe, recovering chains such as `z = D + G; ...; D = z` as adjacent statements. After those active-chain passes, any pure one-register assignment whose destination is not read again in the current dispatcher leaf is sunk out of the active chain: if another write to that register comes first it is grouped immediately before that overwrite; otherwise it moves to the actual end of the state body. It is never deleted, so values that are live-out into a successor state remain available before the next `while state do` iteration. The tail is the end of the dispatcher leaf, not the textual location of the final `state` write, because Prometheus may assign POS/state early and continue executing later statements in the same state.
- Effectful/non-movable statements never change relative order. Every candidate crossing checks RAW (left write -> right read), WAR (left read -> right write), and WAW (both write). A second fail-closed validator runs on each reordered segment before source emission: it verifies the same statement objects are present, the complete non-movable/effectful subsequence is unchanged, and every inverted original pair has a pure delayable statement on the left with no register hazard. If validation fails, that segment is emitted unchanged and counted as a safety rejection.
- Focused sample-1 output remains exactly the requested chain: `R = "print"; state = _env[R]; q = "AD"; R = state(q)`, then unrelated `V = args`. The stronger gap compaction uses 5 proven adjacent swaps for this fixture. Sample 2 now also compacts two safe loads, yielding `Y = "warn"; state = _env[Y]; Z = "gg"; Y = state(Z); r = "math"; Z = _env[r]` while preserving the warn call before the math environment lookup.
- Sample 8 exposes the current behavior clearly: `D = "keep1"` stays next to its call, `B = "print"` stays next to `_env[B]`, `z = D + G` stays immediately followed by `D = z` because `D` is read later in that state, while truly unread `j = args` now sinks to the state-body tail with the final cleanup writes. The ownership-handoff pair remains adjacent `D = nil; D = 30`. The scheduler intentionally never removes overwritten or unread stores. Its proven random `_env[...]` stop sentinel is now removed by Step 3 and re-emitted as final `state = nil`, so the stop is structurally at the bottom of the state and unread pure writes stay immediately above it.
- Current scheduling counts after canonical-stop tailing + unread compaction: sample 1 -> 1 block / 10 swaps / 1 unread sink; sample 2 -> 1 / 18 / 1; sample 3 -> 1 / 71 / 3; sample 4 -> 8 / 88 / 5; sample 6 -> 6 / 67 / 5; sample 7 -> 3 / 45 / 3; sample 8 -> 1 / 148 / 3; sample 9 -> 1 / 94 / 3. All outputs reparse and no safety-validator rejection is reported. LuaJIT parity matches samples 1/2/3/4/6/8/9, both deterministic sample-7 branches, and source/obfuscated/deobfuscated triples for samples 6/8/9.
- `tools/test-vm-register-scheduler.js` is a focused scheduler regression covering producer/use compaction, pure producer sinking, identifier-copy pulling, write/write adjacency without deletion, unread-to-tail sinking, RAW/WAR/WAW preservation, and effectful-call-order preservation; it currently passes.
- Large untracked sample 5 still resolves the same closed 930/938 dispatcher graph with 8 dead leaves and 116 reachable functions. Its compiler overflow bank is now proven with 62 used slots; overflow-aware scheduling still changes 565 blocks and now records 146,664 dependency-safe adjacent crossings. No safety-validator rejection is reported. The higher swap count reflects previously-immovable overflow-register loads/copies joining the same dependency scheduler, not additional semantic rewrites.
- Full post-scheduler batch validation on 2026-08-23 now covers fixtures 1 through 10, including untracked stress sample 5 and natural overflow sample 10. Samples without overflow storage (1-4, 6-9) remain byte-identical to their pre-overflow-scheduler outputs. Sample 10 proves 19 overflow slots and schedules 78,233 dependency-safe crossings; source/obfuscated/deobfuscated runtime remains exactly `overflow-test 1001 1098 1099 1100 1101 1110`. Runtime parity also matches samples 1/2/3/4/6/8/9 and both deterministic sample-7 seeds; sample 5 remains structural/stress validation only. Focused scheduler tests now cover overflow-slot producer/use compaction, independent slots, same-slot hazards, and rejection of ordinary-table treatment.


## Post-Scheduler VM Register Naming

- `passes/vm-register-names.js` is a presentation-only pass after dependency-aware register scheduling. Step 4 binding/capture analysis remains based on the pre-naming VM register identities; the naming pass returns an explicit old-name -> emitted-name mapping so later source-binding recovery can preserve provenance.
- The dedicated VM return register is identified only from the `vm` function's own final top-level `return unpack(<identifier>)`, matching the local WeAreDevs compiler `emitContainerFuncBody()` shape where `returnVar` is declared in the VM container and the function ends with `return unpack(returnVar)`. The outer wrapper/root invocation `...unpack(...)` is not evidence and is never used for this detection.
- Once identified, the same VM-local binding is renamed consistently to `ReturnVal` at its declaration and at every read/write inside the `vm` function. An unrelated identifier with the same textual spelling outside `vm` is untouched. The compiler may borrow `RETURN_REGISTER` as an expression temporary, so intermediate uses of that same physical binding are intentionally also named `ReturnVal`.
- The remaining scalar bindings in the same compiler-generated VM register declaration are renamed deterministically by declaration order to `r1`, `r2`, ... while skipping `ReturnVal` and any colliding names already used by another VM-scope binding. The separate overflow/spill register table (for example sample 5's table-backed register storage) is not part of this scalar rename. `state`, `args`, `upvalues`, `gcProxy`, helper bindings, globals, and helper-function locals are outside this pass.
- The pass fails closed if the final VM return shape is not unique/proven, the scalar register declaration cannot be uniquely identified, a candidate binding is shadowed in a nested lexical scope, or a generated name would collide. It performs binding-scoped AST range edits rather than textual search/replace.
- Current fixture mapping: sample 1 `R -> ReturnVal` + 2 scalar registers; sample 2 `Y -> ReturnVal` + 4; sample 3 `y -> ReturnVal` + 7; sample 4 `L -> ReturnVal` + 8; sample 5 `i -> ReturnVal` + 99; sample 6 `P -> ReturnVal` + 7; sample 7 `d -> ReturnVal` + 6; sample 8 `l -> ReturnVal` + 10; sample 9 `U -> ReturnVal` + 6. Sample 5 remains 930/938 reachable states with 8 dead states pruned.
- `tools/test-vm-register-names.js` proves full same-binding rename inside `vm`, `rN` scalar renaming, member-key preservation, unrelated same-spelling bindings outside `vm` remaining untouched, and fail-closed behavior when a candidate register name is shadowed. Runtime parity still matches all executable fixtures and both deterministic sample-7 branches.


## Performance Optimization Audit (2026-08-23)

- Before the whole-pipeline optimization audit, the user explicitly requested a pushed checkpoint first. Commit `c224017 Optimize VM state traversal queues` is that pre-audit checkpoint. It replaced array `shift()` BFS queues with cursor-based queues, used `Set` membership for queued/ordered state IDs, and kept reachable-state traversal itself O(V + E) aside from dispatcher-leaf resolution/rendering.
- Optimized implementation checkpoint: `0f4650a Optimize deobfuscator hot paths`. The audit read the complete normal deobfuscation pipeline (main + every current pass) and changed only mechanically equivalent hot paths; parser internals and the proven reaching-def/liveness solver were intentionally not redesigned.
- `passes/text-edits.js` now applies non-overlapping source edits in one ordered chunk build, O(source length + edit payload/count) after sorting, instead of repeatedly slicing/rebuilding the entire source once per edit. ConstantArray replacement, environment rename output, safe-assignment splitting, VM-state range patching, and register-scheduler output all use this path. This removed the largest hidden O(edit_count * source_size) cost.
- VM helper renaming now uses `passes/batch-parameter-rename.js`: helper-role bindings are planned together and renamed in one lexical AST traversal, including nested VM parameters, while preserving the same shadow/collision rules. If a batch conflict/collision is detected, `renameVmHelperBindings` falls back to the previous sequential implementation rather than guessing. Helper-function parameters are handled in a second small batch. Focused nested-shadowing regression: `tools/test-batch-parameter-rename.js`.
- Parsed ASTs are reused where the source is already known to match them: VM-helper output returns its final AST; safe-assignment splitting accepts/reuses that AST and returns its own final AST; main reuses it for Step 3. On sample 5 this reduced parser invocations in the measured pipeline from 55 to 9 while retaining the final mandatory reparse.
- Register scheduling caches immutable per-statement read/write sets in `WeakMap`s, eliminating repeated AST walks during RAW/WAR/WAW checks and validation. Scheduling decisions/output are unchanged.
- VM binding analysis keeps the existing fixed-point semantics. Safe construction optimizations only: capture-slot resolutions are memoized at top-level query keys, same-block next definitions are precomputed by one reverse scan instead of repeated `definitions.find(...)`, and live-in/live-out block lists are built by walking the converged live sets once instead of scanning every block for every definition. Sample-5 analysis remains exactly 11,858 definitions, 177 join groups, 695 cross-block lifetimes, and 61 loop-carried lifetimes.
- New primitive regression `tools/test-text-edits.js` covers replacement/text edits, absolute base offsets, and overlap rejection. Current focused regressions all pass: text edits, batch parameter rename, VM register scheduler, and VM state reachability.
- Performance reference on the same sample-5 stress fixture: the pre-audit stage-timed run measured about 10,223 ms total. After `0f4650a`, five `runDeobfuscator` runs measured 1220.0, 1011.1, 1182.8, 1085.4, and 1097.6 ms (average 1119.4 ms, median 1097.6 ms). Treat this as an approximate ~9x core-pipeline improvement, not a universal hardware-independent guarantee.
- Semantic validation after optimization is stronger than runtime-only: outputs for samples 1 through 9 are byte-for-byte identical to outputs generated from checkpoint `c224017`. LuaJIT runtime parity also matches samples 1/2/3/4/6/8/9, both deterministic sample-7 seeds, and source/obfuscated/deobfuscated triples for samples 6/7/8/9. Untracked sample 5 remains 930/938 reachable dispatcher leaves, 8 dead leaves pruned, and 116 functions.
- Optimization boundary: do not replace the proven reaching-def/liveness fixed points or scheduler semantics merely to chase micro-benchmarks. Their convergence is already small on sample 5 (321 total reaching iterations across 116 functions, max 8; 241 total liveness iterations, max 7). Remaining scheduler `indexOf` operations are local to short state blocks; any more invasive mutable-index/topological rewrite requires a separate correctness proof and benchmark before adoption.


## Semantic Naming Layer (2026-08-23)

- `passes/semantic-names.js` runs after VM register naming and renames only structurally proven compiler roles; it never renames from randomized spelling alone. Scope reconstruction remains unchanged and analysis-only.
- The outer wrapper parameter receiving the unique `{...}` argument is renamed `InitialArgs`. This is distinct from the VM parameter `args`: `InitialArgs` is the original top-level vararg table passed into the root closure, while `args` is the per-closure invocation argument table.
- Proven `createClosure*` helpers rename their `createUpvalueProxy(captures)` local to `gcProxy`, returned nested-function local to `closure`, and fixed-arity nested parameters to `arg1`, `arg2`, ...; the vararg factory keeps `...`.
- `releaseUpvalues` renames its structural iteration locals to `captureIndex` and `upvalueId`. `createUpvalueProxy` renames its numeric-for index to `captureIndex`, the `newproxy(true)` local to `proxy`, and `getmetatable(proxy)` to `proxyMetatable`.
- When a VM overflow-register table is proven structurally as the table-backed register bank before the scalar register declaration, it is renamed `RegisterOverflow`. Sample 5 exercises this path; smaller fixtures do not invent it.
- All semantic renames are lexical/binding-aware and fail closed on collision, shadowing, ambiguity, or edit conflicts. Current samples 1-9 apply with zero semantic-name skips.
- Focused regression `tools/test-semantic-names.js` covers `InitialArgs`, fixed closure `argN`, `gcProxy`, `closure`, `captureIndex`, `upvalueId`, `proxy`, `proxyMetatable`, and `RegisterOverflow`. All focused regressions pass. LuaJIT parity matches samples 1/2/3/4/6/8/9 and both deterministic sample-7 branches; sample 2 uses the existing `warn = print` compatibility shim for stock LuaJIT.

## Sample 10: Natural Register Overflow Regression (2026-08-23)

- Tracked `sample/10.source.lua` / `sample/10.txt` is a natural compiler-level overflow fixture. The readable source declares 110 ordinary locals in one lexical scope, keeps them alive through later mutations/reads, and follows the required `source -> local WeAreDevs Medium -> formatter -> sample/10.txt -> deobfuscator` path. It does not contain VM-shaped or synthetic register-table code.
- Local compiler instrumentation (in-memory wrapper only; compiler file unchanged) proves the boundary in this fixture: `v98 -> physical register 99` remains scalar, `v99 -> physical register 100 -> RegisterOverflow[1]`, `v100 -> 101 -> RegisterOverflow[2]`, through `v110 -> 111 -> RegisterOverflow[12]`. Later compiler temporaries naturally use higher overflow indices as well.
- Runtime parity is exact across readable source, formatted obfuscation, and deobfuscated output: `overflow-test 1001 1098 1099 1100 1101 1110`. The semantic naming pass correctly recognizes `RegisterOverflow`.
- Important current analysis gap exposed by sample 10: Step-4 reaching-definition/liveness analysis still models only scalar identifier register writes/uses. It reports no definition identity for `RegisterOverflow[k]`, so overflow-backed source locals are preserved semantically in emitted Lua but are not yet normalized into the same register-identity model as scalar VM registers. Keep this fixture as the regression for any future overflow-aware binding analysis.

# Immediate Next Steps

1. Keep Step 3 state normalization as the structural emitted-source boundary; the post-Step-3 scheduler may only reorder proven-independent statements for readability. Step 4 remains proof metadata, and source locals must not be reconstructed from register spelling or adjacency.
2. Add local-vs-environment provenance for VM values so `_env[...]` globals can never be promoted into invented locals, while register-backed source candidates remain distinct from environment lookups.
3. For ordinary locals, build conservative register-value epochs from definition/use/liveness connectivity without merging sequential unrelated values. Current sample 7 is the focused conditional-shadowing/early-return regression: one path uses the branch-local `b = 2` and returns, while the fallthrough path uses outer `b = 3` and then a captured closure. Only promote a source local when function ownership, provenance, and lifetime proof are unique.
4. Relate captured-cell candidates to source initialization/mutation patterns only after dominance/order proof is available; do not infer “initial write” from textual or block order across CFG joins.
5. Continue CFG structuring separately: sample 4 remains the focused if/while/repeat regression, sample 6 the nested-function ownership regression, and untracked sample 5 the stress case. Preserve backedges and evaluation order.
6. Keep POS-register temporary reuse distinct from true block terminators; extend Prometheus-specific recognition only from evidence in the local WeAreDevs compiler unless the user explicitly requests the public/canonical implementation.
7. Keep every pass structural/generalized, reparse transformed Lua, runtime-check executable fixtures, and update/commit/push `CONTEXT.md` after meaningful work.
8. If the current parser becomes a correctness blocker, evaluate Rust Moonlight instead of parser-specific hacks.
## Fresh Chat Resume Snapshot (2026-08-23)

### Authoritative workspace / Git

- Workspace: `C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`.
- Branch: `main`.
- Remote: `https://github.com/GooseGoldenGoose/new-promdeobf.git`.
- Latest pushed checkpoint at this snapshot: `7442545 Document overflow register scheduling`.
- Immediately preceding implementation commit: `b7f6185 Schedule overflow VM registers`.
- Before changing anything in a new chat: read this entire `CONTEXT.md`, run `git status --short --branch`, then `git log -8 --oneline --decorate`. Never assume the checkout is still at this exact commit if newer work exists.
- Every project code/content change, even small, gets a focused commit and `git push origin main`. Stage only files belonging to the current change.
- Never stage or modify `formater/` or `sample/5.txt` unless the user explicitly changes that policy. Generated `output/*.log` files may exist from validation and must not be committed accidentally.
- If the user asks for a risky/broad refactor, create and push a checkpoint BEFORE doing it when requested, then make the refactor in separate focused commits.
- End every project-related assistant turn exactly with: `Done for this turn — you can prompt now.`

### Prometheus authority / fixture workflow

- In this project, “Prometheus” means the LOCAL WeAreDevs compiler at `C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`; compiler authority is `src\prometheus\compiler\compiler.lua`. Do not substitute public/canonical Prometheus unless explicitly requested.
- Controlled fixtures MUST follow: readable `sample/N.source.lua` -> local WeAreDevs Medium -> `formater/luau-format.exe input.txt --luraph --output=out.txt` -> tracked `sample/N.txt` -> `node main.js sample/N.txt output/N.lua`.
- Use the absolute LuaJIT path when needed: `C:\Users\reala\AppData\Local\Programs\LuaJIT\bin\luajit.exe`.
- Compiler instrumentation is allowed only as an in-memory/development probe; do not modify the authoritative compiler file as part of the deobfuscator.

### Non-negotiable design rules

- Everything must be structural/generalized/dynamic. Never hardcode sample filenames, random generated names, state IDs, register spellings, string constants, closure arities, offsets, or fixture-specific behavior.
- Fix the earliest AST/CFG/data-flow cause. Do not patch final emitted text to conceal a bad analysis.
- Preserve evaluation order, calls, multi-return behavior, lexical ownership, globals, object/table identity, loops, closure capture semantics, mutations, and upvalue-cell sharing.
- Globals remain globals unless proven lexical. Do not invent aliases for `game`, `table.insert`, etc.
- Any uncertain transform fails closed and preserves the previous safe source.
- Parsing successfully is insufficient: reparse transformed Lua and run runtime/source parity wherever possible.

### Current pipeline

1. Parse Luau.
2. ConstantArray recovery/inlining.
3. Environment provenance/rename to `_env`.
4. Structural closure-factory naming: `createClosure`, `createClosureN`.
5. VM helper naming: `unpack`, `newproxy`, `setmetatable`, `getmetatable`, `select`, `vm`, upvalue helpers/tables and semantic parameters.
6. Split only proven-safe parallel assignments.
7. Step 3 VM-state/CFG recovery: reachability-driven roots, closed graph proof, dead-state pruning, contiguous normalized IDs, balanced dispatcher rendering, canonical stop `state = nil` at actual leaf tail, no normalized invalid/unreachable fallback.
8. Step 4 VM binding/capture analysis: analysis-only reaching definitions, liveness, definition epochs, capture slots, static upvalue-cell identities, relays, binding-end/ownership-handoff candidates.
9. Dependency-safe VM register scheduling inside normalized leaves.
10. VM register presentation naming: the VM’s own final `return unpack(R)` identifies that VM-local binding as `ReturnVal`; every use/write of that same binding inside `vm` is renamed consistently. Other scalar VM registers become deterministic `r1`, `r2`, ... . Same-spelled identifiers outside `vm` are untouched.
11. Structural semantic naming: wrapper original vararg table -> `InitialArgs`; closure helper locals -> `gcProxy` / `closure`; fixed closure parameters -> `arg1..argN`; `releaseUpvalues` locals -> `captureIndex` / `upvalueId`; proxy helper locals -> `proxy` / `proxyMetatable`; proven overflow bank -> `RegisterOverflow`.
12. Final reparse and output.

### State / scheduler facts that must not regress

- The compiler’s POS/state register has two roles: expression temporary and dispatcher program counter. A plain `state = value` is NOT automatically a terminator.
- Only proven final POS/state transitions determine CFG edges. Canonical `setPos(nil)` random `_env[12..14 alphanumeric]` is an obfuscated stop and Step 3 normalizes it to final `state = nil` at the actual end of the state body.
- Reachability starts from the real root; closure entries are discovered only from reachable states. Dead states cannot “rescue” dead child closures.
- Reachable graph walk uses Set/Map + cursor queues; pruning traversal is O(V+E) apart from dispatcher-leaf resolution/rendering.
- Scheduler NEVER deletes stores. It moves only proven pure register assignments through RAW/WAR/WAW-safe crossings and validates every reordered segment fail-closed.
- Unread pure writes sink toward the actual dispatcher-leaf tail; the final canonical `state = nil` remains the last stop anchor.
- Scalar scheduler reads/writes are cached per statement.
- Proven overflow register banks now participate in exactly the same scheduling logic as scalar registers. Detection is structural BEFORE the semantic name `RegisterOverflow` exists: unique empty-table VM bank before scalar declaration; every bank reference must be a positive constant numeric index; no alias/bare use/dynamic index/shadowing. Each slot is an internal identity such as `overflow:1`. Ordinary tables remain conservative.

### Current overflow proof / sample 10

- `sample/10.source.lua` and `sample/10.txt` are the tracked NATURAL overflow regression: 110 ordinary source locals in one lexical scope; no synthetic VM/table code.
- Compiler probe proves `v98 -> physical register 99` stays scalar; `v99 -> register 100 -> RegisterOverflow[1]`, through `v110 -> register 111 -> RegisterOverflow[12]`.
- Later compiler temporaries naturally use additional overflow slots.
- Runtime parity source/obfuscated/deobfuscated: `overflow-test 1001 1098 1099 1100 1101 1110`.
- Scheduler currently detects 19 used overflow slots in sample 10 and performs overflow-aware compaction; sample 5 detects 62 used slots.
- IMPORTANT CURRENT GAP: Step-4 reaching-definition/liveness/binding analysis still models scalar identifier registers only. It does NOT yet normalize `RegisterOverflow[k]` slots into definition/use identities. Runtime/emitted Lua is correct; source-binding analysis for overflow-backed locals is incomplete. If implementing this later, reuse the same structural bank detector and model scalar + overflow storage under one VMRegister identity abstraction. Do not treat arbitrary tables as registers.

### Current scope status — DO NOT assume implementation

- The user explicitly said NOT to implement scope recovery yet; the discussion was conceptual only.
- No source lexical-scope reconstruction pass should be claimed as implemented.
- What IS known for future work: physical VM register != source variable identity. Dispatcher states are CFG blocks, not lexical scopes. Same source local uses one reserved VAR_REGISTER while alive; compiler cleanup then force-frees it and later bindings can reuse the physical register. `R=nil` alone is never enough to prove scope end. Captured locals use shared upvalue-cell identity, which is stronger proof.
- Do not use normalized `rN` names, dispatcher nesting, or adjacency as source-scope evidence.

### Fixtures / key validations

- Sample 4: if/while/repeat CFG and shared mutable capture.
- Sample 6: nested function ownership root -> outer -> inner; runtime `theory 8 10 5`.
- Sample 7: conditional shadowing + early return + captured closure; deterministic seeds 1 and 3 both parity-tested.
- Sample 8: ordinary register cleanup/ownership handoff; proves explicit source nil vs compiler cleanup distinction.
- Sample 9: `local x` / `local y=nil` initialization via special temp + copy; prevents classifying every direct nil as scope cleanup.
- Sample 10: natural overflow storage boundary and overflow-aware scheduler regression.
- Untracked sample 5: stress fixture, 938 dispatcher leaves total, 930 reachable, 8 dead pruned, 116 recovered functions. Current overflow-aware scheduling uses 62 slots and ~146,664 dependency-safe crossings with no safety rejection. Step-4 sample-5 cell graph remains intentionally fail-closed where provenance is incomplete.
- Samples without overflow (1-4, 6-9) remained byte-identical when overflow scheduling was added. Runtime parity covers 1/2/3/4/6/8/9/10 plus sample-7 seeds 1 and 3; source/deobf parity covers controlled source fixtures including 6/7/8/9/10.

### Performance history / boundary

- Pre-audit sample-5 core pipeline was measured around 10.22s. Hot-path optimization (single-pass text edits, batch helper renames, AST reuse, cached scheduler read/write sets, safer metadata construction) reduced it to roughly 1.10s median before later semantic/overflow scheduling additions.
- Overflow-aware scheduler adds real work on overflow-heavy sample 5; recent measured average was around 1.79s. Do not remove dependency checks just to recover benchmark time.
- Existing reaching-def/liveness fixed points already converge in few iterations; do not rewrite them without a separate proof/benchmark.

### Most recent commits to recognize

`db021b3 Normalize VM register names`
`fd6a359 Document VM register naming`
`638cca8 Track semantic VM names`
`6e76c14 Document semantic VM naming`
`d6a96bd Add natural register overflow regression`
`0b60f90 Record overflow regression`
`b7f6185 Schedule overflow VM registers`
`7442545 Document overflow register scheduling`

### New-chat operating instruction

When the user pastes the resume prompt from this snapshot, do NOT merely summarize it. First read `CONTEXT.md`, inspect Git status/log, and then continue the user’s new requested task by actually editing/testing/committing/pushing as needed. Never ask them to repeat information already in this file.
