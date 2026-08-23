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
- Never stage or modify unrelated untracked workspace items. `formater/` remains intentionally untracked; every tracked `sample/N.txt` must have a matching tracked `sample/N.source.lua`.
- Everything must be structural/generalized: never hardcode sample IDs, state numbers, register names, closure arities, strings, filenames, or random constants. Fix root causes, not output text afterward.
- After transformations, reparse generated Lua and run runtime regressions whenever executable fixtures permit it. Compare original/readable source, obfuscated input, and deobfuscated output where useful.
- When the user says **Prometheus**, they mean the local WeAreDevs obfuscator/compiler fixture at `C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`. Verify exact behavior against that local source first. Only use the public/canonical repository if the user explicitly asks for canonical/public Prometheus.
- Preserve stable pipeline behavior when experimenting. A recovery pass must fail closed: if proof is incomplete, preserve the previous safe output rather than guess.
- End every project-related turn with exactly: `Done for this turn — you can prompt now.`

Latest beta behavior checkpoint is `f93cc7a Keep beta versions block local` on `main`, pushed to `origin/main`. Beta still performs CFG reaching-definition propagation across normalized state leaves, but every `r_vN_N` definition stays as a `local` inside its own state block. Cross-state reads may intentionally reference that block-local name outside lexical scope because beta is currently analysis/presentation output only and is not required to run. Ambiguous joins remain unresolved rather than guessed. Final `state` writes remain on the dispatcher binding, and only terminal return-table `ReturnVal` writes stay original. All tracked fixtures `sample/1` through `sample/11` have matching `.source.lua` + formatter-normalized `.txt` pairs. Source lexical-scope reconstruction has NOT been implemented yet.

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
- Every tracked `sample/N.txt` must have a matching tracked `sample/N.source.lua`. Current paired coverage is samples 1-11.
- `sample/1.source.lua` is the baseline fixture. It is obfuscated with local WeAreDevs Medium, formatter-normalized into `sample/1.txt`, then deobfuscated to `output/1.lua`. Runtime parity is `baseline 14 4`.
- Samples 2-4 were reconstructed from the old tracked fixtures/behavior: sample 2 is the `warn("gg")` + random branch regression; sample 3 is the shadowed block plus shared captured `x` regression; sample 4 is the shared `total` if/while/repeat regression with intentionally varied closure arities.
- Sample 5 is now a controlled static stress source with 115 closure functions plus the root VM function. Its first 44 workers include an additional branch so the local compiler emits exactly 938 reachable dispatcher states, matching the old stress fixture state scale while retaining a source file.

## Prometheus ConstantArray Step

- The arithmetic constant-folding pass was removed; step 1 is Prometheus ConstantArray recovery.
- `passes/constant-array.js` structurally recovers the literal array, optional rotation, accessor offset, and custom-base64 decoder.
- Accessor replacement is scope-aware; fixture names, offsets, and constant values are not hardcoded.
- Missing ConstantArray is now a safe pass-through so later stages still run when that Prometheus step is disabled.
- Current ConstantArray coverage: sample 1 -> 8 entries / 11 references; sample 2 -> 11 / 14; sample 3 -> 11 / 16; sample 4 -> 13 / 19; sample 5 -> 122 / 125. All have 0 unresolved wrapper/array uses.
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
- Current sample 1 helper initialization splits one parallel statement into 10 individual assignments.

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
- Current sample 1 resolves 5/5 dispatcher states: root `1`, fixed closure `createClosure5` states `2-5`. Source, formatted obfuscation, and deobfuscated output all print `baseline 14 4`.
- Restored sample 2 resolves 3/3 states and preserves `gg` / `ranf` under the existing LuaJIT warn+seed shim. Restored sample 3 resolves 3/3 states across root + two closures and preserves `block 10 2`, `before 1`, `after 3 3`. Restored sample 4 resolves 16/16 states across root + three closures and preserves `start 0`, `choose 5`, `spin 10`, `trim 2`.
- New sample 5 resolves 938/938 states across 116 VM functions. It is source-backed and intentionally replaces the former unpaired stress file; all states are reachable in this controlled fixture.
- `tools/inspect-vm-state.js` remains an optional developer inspection utility for printing graph roots, terminators, dispatcher paths, and normalized ranges; it is not required for normal deobfuscation.
- Closure-root discovery is now reachability-driven instead of global-AST-driven. Recovery starts from the real outer `createClosure` root, walks its closed CFG, discovers `createClosureN(entry, ...)` calls only inside those reachable blocks, then recursively walks the newly discovered child roots. A closure call that exists only in a dead dispatcher leaf can no longer keep its dead closure graph alive. Reachable unsupported closure-entry calls still fail normalization closed; unsupported/dead calls outside the reachable graph do not poison recovery. `tools/test-vm-state-reachability.js` proves a dead state that creates a dead closure is removed together with that child graph.
- Canonical compiler confirmation: `setPos(scope, nil)` deliberately emits `state = _env[randomString(12..14)]` instead of literal nil (the source comment retains `--Ast.NilExpression()`). Step 3 treats only this compiler-shaped random alphanumeric `_env[...]` lookup (or literal nil) as a stop; other unknown final state writes block normalization instead of being guessed as stops. Once a stop is proven, normalized rendering removes the obfuscator-only random environment lookup and emits semantic `state = nil` at the actual end of that recovered state body. The relocation is structural and restricted to a single canonical stop assignment; ordinary `_env[...]` lookups remain untouched/effectful.
- Normalized dispatcher leaf rendering no longer emits the defensive `else -- invalid/unreachable VM state; state = nil` fallback. A normalized CFG is already proven closed from every reachable root/closure entry and every emitted successor is in the normalized state map, so that branch is unreachable scaffolding on valid execution. Exact state equality checks remain, and balanced range-selection `else` branches remain because they route real normalized states. The older non-normalized/fail-closed renderer keeps its defensive fallback.
- Canonical numeric-for confirmation: Prometheus may split `state = condition and innerId or finalId` across temporary-register statements (`tmpTrue = innerId; state = condition and tmpTrue; tmpFalse = finalId; state = state or tmpFalse`). Step 3 recognizes this exact adjacent data-flow shape and rewrites both target literals during normalization.
- A fresh temporary Medium numeric-`for` regression resolved 7/7 states and preserved runtime (`numfor 9`) while normalizing its compiler-split branch, confirming the rule is structural rather than fixture-specific.
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
- `main.js` exposes compact reaching-definition, lifetime, cell-access, and captured-binding-candidate counts. Step 4 remains analysis-only; its metadata is computed from the proven Step-3 graph and is not rewritten by later presentation scheduling. Final emitted Lua is reparsed after all post-Step-3 scheduling.
- Current sample 1 analysis: 2 recovered functions, 34 definitions, 26/27 uniquely resolved uses, 1 join group, 3 cross-block lifetimes, 0 loop-carried lifetimes, 1 local upvalue cell, 1 capture slot, and 2/2 resolved cell accesses.
- Restored sample 3 has 3 functions, 43 definitions, 2 capture slots, one shared local cell, and 5/5 resolved cell accesses. Restored sample 4 has 4 functions, 97 definitions, 3 capture slots, one shared local cell, and 17/17 resolved cell accesses. New sample 5 has 116 functions, 4,488 definitions, 115 capture slots, one shared local cell, and 983/983 resolved cell accesses.


- Local WeAreDevs compiler register-allocation proof: source locals are keyed by `(scope, id)` in `registersForVar`; `getVarRegister(scope, id, ...)` reuses the same reserved `VAR_REGISTER` for repeated reads/writes of that source binding while it is live. `allocRegister(true)` prevents another live variable from taking that occupied register. At lexical block cleanup, `compileBlock` emits `reg = nil` for ordinary locals (or calls the upvalue-release helper for captured locals), then `freeRegister(reg, true)` releases that register for later reuse. Therefore repeated writes to the same VM register can mean mutation of one source binding while its `(scope,id)` remains active, but the same physical register can later represent a different source binding after scope cleanup/release. A visible `reg = nil` is evidence of cleanup only when provenance proves it is the compiler's block-variable cleanup; temporary nil values also exist and must not be treated as scope ends blindly. Captured locals are stronger: the variable register holds an upvalue-cell ID and source assignments update `upvalueValues[cell]`, so a proven identical cell ID is a proven identical captured binding.
- Register-ownership handoff rule for deobfuscation: the emitted VM has no explicit runtime marker for compiler `freeRegister`; ownership changes are therefore inferred conservatively. Treat every register write as a separate value epoch first. A new source-binding epoch may start only after the previous candidate is dead on all relevant CFG paths and there is structural scope-cleanup evidence (`reg = nil` for an ordinary proven local, or `reg = releaseUpvalue(reg)` for a proven captured-cell register), followed by a later first definition after that cleanup. Never use `reg = nil` alone as proof because explicit source assignments and temporary nil values can look identical. Repeated assignments before a proven ownership handoff remain candidates for mutation of the same binding; after a proven handoff the same physical register may represent a different `(scope,id)`. If cleanup/scope ownership is not provable, keep epochs separate rather than guessing.

- Local-nil initialization proof from tracked sample 9 corrects the earlier overgeneralization. `compileExpression(NilExpression)` first allocates an ordinary temporary with `allocRegister(false)`, which preferentially uses the special POS/RETURN registers when available. `getVarRegister(scope,id,...,potentialId)` explicitly refuses to promote `POS_REGISTER` or `RETURN_REGISTER`, so a standalone `local x` or `local y = nil` commonly becomes `tempSpecial = nil; varReg = tempSpecial`. In sample 9, deobfuscated `x` starts as `state = nil; B = state`, while `y = nil` starts as `U = nil; Q = U`. An in-memory compiler trace confirms `x reg=2` and `y reg=3` each received a special temporary potential and `same=false`. Direct single `R = nil` initialization is only possible when the nil temporary is a promotable general register; it is not the default standalone shape and must never be assumed. Existing binding-end analysis remains conservative because it requires prior reaching-definition/lifetime evidence rather than classifying a nil write by syntax alone.

- POS/state cleanup distinction from the local compiler: source locals can never own `POS_REGISTER` or `RETURN_REGISTER`. `allocRegister(true)` bypasses the special-register fast path, and `getVarRegister(..., potentialId)` explicitly rejects POS/RETURN promotion. Therefore lexical local cleanup via `compileBlock -> setRegister(varReg, nil)` cannot become the random environment sentinel. A temporary expression may use POS and thus emit ordinary `state = <value>` (including potentially `state = nil`) through `setRegister`, but only the dedicated control-flow `setPos(scope, nil)` path emits `state = _env[randomString(12..14)]`. Treat `_env[random]` on state as VM-stop/control-flow evidence, not source-variable cleanup.
- Tracked `sample/9.source.lua` / `sample/9.txt` is the nil-local initialization regression: it contains both `local x` and `local y = nil`, prints each before and after later non-nil assignments, and follows the required `source -> WeAreDevs Medium -> formatter -> sample/9.txt -> deobfuscator` workflow. Runtime parity is exact across readable source, formatted obfuscation, and `output/9.lua`: `x0 nil`, `x1 5`, `y0 nil`, `y1 6`.
- Tracked `sample/8.source.lua` / `sample/8.txt` is now the ordinary-register ownership-end regression. It mutates outer `keep`, explicitly assigns `keep = nil` and then reassigns it, creates block-local `inner`, then declares later `after`. An in-memory instrumentation wrapper around the local WeAreDevs compiler proved the ground truth: `keep` stayed on physical register 2; `inner` was bound to physical register 4, `freeRegister(4, true)` occurred at the end of the `do` block, and `after` was then allocated the same physical register 4. The instrumentation changed no compiler file.
- The emitted sample-8 VM distinguishes explicit source nil assignment from lexical cleanup. Source `keep = nil` compiles as a temporary nil definition followed by a copy into the still-reserved `keep` register (`tmp = nil; keepReg = tmp`), while block cleanup for `inner` is a direct dead `innerReg = nil` write; that same register is then reused by `after`. `passes/vm-bindings.js` now records `bindingEndCandidates` only for direct `NilLiteral` definitions with zero uses, exactly one prior reaching definition, and a previously-used value. A later same-block definition of the same physical register upgrades it to an `ownership-handoff-candidate`. Sample 8 reports 3 binding-end candidates and exactly 1 ownership handoff; the explicit `keep = nil` is correctly excluded because its nil temporary has one use. This remains conservative metadata, not a source rewrite.



## Post-Step-3 VM Register Scheduling

- `passes/vm-register-scheduler.js` runs after safe Step-3 normalization. Its purpose is readability: compact in-block producer/use chains so unrelated temporary loads do not separate the values consumed by a statement. It never uses fixture register names or state IDs.
- Scheduling is structural and local to normalized dispatcher leaves. Comments are barriers; blocks with non-whitespace source gaps are left unchanged. The only movable filler remains a one-identifier assignment whose RHS is a primitive literal or a simple identifier copy; assignments to `state`, `args`, `upvalues`, or `gcProxy` are never movable fillers. Table constructors, calls, function literals, indexed writes, arithmetic/other expressions remain non-movable.
- Overflow-register scheduling is now supported only for a structurally proven compiler register bank. `findRegisterOverflowBinding` identifies the VM return/scalar-register declaration from the VM's own final `return unpack(returnReg)`, then requires exactly one preceding empty-table local whose binding is never aliased/reassigned/shadowed and whose every use is a positive constant numeric index. Each proven `RegisterOverflow[k]`-style slot is normalized internally to its own register identity and participates in the same RAW/WAR/WAW scheduler logic as scalar registers. Arbitrary table/index expressions, dynamic overflow indices, aliases, or ambiguous banks remain conservative/non-register accesses.
- The scheduler compacts producer -> consumer and write -> next-touch gaps. Primitive literal/nil register loads may sink toward the next read OR next write of their destination when every crossing is RAW/WAR/WAW-safe, grouping overwrite chains without deleting either write. Simple identifier-copy assignments may pull left toward the nearest producer of their RHS when safe, recovering chains such as `z = D + G; ...; D = z` as adjacent statements. After those active-chain passes, any pure one-register assignment whose destination is not read again in the current dispatcher leaf is sunk out of the active chain: if another write to that register comes first it is grouped immediately before that overwrite; otherwise it moves to the actual end of the state body. It is never deleted, so values that are live-out into a successor state remain available before the next `while state do` iteration. The tail is the end of the dispatcher leaf, not the textual location of the final `state` write, because Prometheus may assign POS/state early and continue executing later statements in the same state.
- Effectful/non-movable statements never change relative order. Every candidate crossing checks RAW (left write -> right read), WAR (left read -> right write), and WAW (both write). A second fail-closed validator runs on each reordered segment before source emission: it verifies the same statement objects are present, the complete non-movable/effectful subsequence is unchanged, and every inverted original pair has a pure delayable statement on the left with no register hazard. If validation fails, that segment is emitted unchanged and counted as a safety rejection.
- Sample 8 exposes the current behavior clearly: `D = "keep1"` stays next to its call, `B = "print"` stays next to `_env[B]`, `z = D + G` stays immediately followed by `D = z` because `D` is read later in that state, while truly unread `j = args` now sinks to the state-body tail with the final cleanup writes. The ownership-handoff pair remains adjacent `D = nil; D = 30`. The scheduler intentionally never removes overwritten or unread stores. Its proven random `_env[...]` stop sentinel is now removed by Step 3 and re-emitted as final `state = nil`, so the stop is structurally at the bottom of the state and unread pure writes stay immediately above it.
- `tools/test-vm-register-scheduler.js` is a focused scheduler regression covering producer/use compaction, pure producer sinking, identifier-copy pulling, write/write adjacency without deletion, unread-to-tail sinking, RAW/WAR/WAW preservation, and effectful-call-order preservation; it currently passes.
- Current sample 1 scheduling changes 2 blocks with 43 dependency-safe swaps and 3 unread sinks; runtime parity remains exact.
- Current paired fixture coverage is samples 1-11. New sample 5 schedules 390 blocks with 221,956 dependency-safe swaps, 217 unread sinks, and a structurally proven 23-slot overflow bank. Sample 10 remains the natural overflow-boundary fixture with 19 slots.


## Post-Scheduler VM Register Naming

- `passes/vm-register-names.js` is a presentation-only pass after dependency-aware register scheduling. Step 4 binding/capture analysis remains based on the pre-naming VM register identities; the naming pass returns an explicit old-name -> emitted-name mapping so later source-binding recovery can preserve provenance.
- The dedicated VM return register is identified only from the `vm` function's own final top-level `return unpack(<identifier>)`, matching the local WeAreDevs compiler `emitContainerFuncBody()` shape where `returnVar` is declared in the VM container and the function ends with `return unpack(returnVar)`. The outer wrapper/root invocation `...unpack(...)` is not evidence and is never used for this detection.
- Once identified, the same VM-local binding is renamed consistently to `ReturnVal` at its declaration and at every read/write inside the `vm` function. An unrelated identifier with the same textual spelling outside `vm` is untouched. The compiler may borrow `RETURN_REGISTER` as an expression temporary, so intermediate uses of that same physical binding are intentionally also named `ReturnVal`.
- The remaining scalar bindings in the same compiler-generated VM register declaration are renamed deterministically by declaration order to `r1`, `r2`, ... while skipping `ReturnVal` and any colliding names already used by another VM-scope binding. The separate overflow/spill register table (as exercised by sample 10) is not part of this scalar rename. `state`, `args`, `upvalues`, `gcProxy`, helper bindings, globals, and helper-function locals are outside this pass.
- The pass fails closed if the final VM return shape is not unique/proven, the scalar register declaration cannot be uniquely identified, a candidate binding is shadowed in a nested lexical scope, or a generated name would collide. It performs binding-scoped AST range edits rather than textual search/replace.
- Current sample 1 maps VM return register `p -> ReturnVal` and 7 scalar temporaries to deterministic `rN` names.
- `tools/test-vm-register-names.js` proves full same-binding rename inside `vm`, `rN` scalar renaming, member-key preservation, unrelated same-spelling bindings outside `vm` remaining untouched, and fail-closed behavior when a candidate register name is shadowed. Runtime parity still matches all executable fixtures and both deterministic sample-7 branches.


## Experimental Beta Register Versioning (2026-08-23)

- This is a separate analysis/presentation experiment and is NOT part of the normal deobfuscation pipeline. It consumes an already-generated normal output file and writes a sibling beta file.
- Command: `node tools/beta-register-versions.js <output.lua> [output.beta.lua]`. If the second path is omitted, `output/2.lua` becomes `output/2.beta.lua` generically; no sample number is hardcoded in the transformer.
- `passes/beta-register-versions.js` finds exact normalized dispatcher leaves (`state == N`) inside the semantic VM and versions scalar VM writes into `r_vN_N` locals. Final `state` writes remain on the original dispatcher binding. Final `ReturnVal` is preserved only for a terminal table-constructor write that occurs before the leaf's final `state = nil`; every other `ReturnVal` write is versioned.
- The first versioned write encountered for an original register gets a stable base such as `ReturnVal -> r_v1`, `state -> r_v2`, `r1 -> r_v3`. Later versioned writes increment the suffix. Reads in the same leaf use the latest version. A preserved final `state` transition consumes the latest versions on its RHS. A preserved terminal `ReturnVal = { ... }` is treated as the VM return payload only when followed by the final nil stop.
- Sample 2 now versions 18 assignments across 3 dispatcher leaves with 0 skips and has 0 proven cross-state versions. In state 1, final non-table `ReturnVal = 1` is versioned and consumed by the final state condition; state 2's final call result is also versioned. Only state 3 preserves `ReturnVal = {}` together with final `state = nil`.
- Beta computes reaching-definition sets across the normalized numeric state CFG. If a successor has exactly one proven incoming version for a register, reads use that `r_vN_N` name. Definitions remain `local` inside the state where they were created even when another state references that name; this is intentional because current beta output is for analysis/readability, not execution. If multiple versions or an unknown entry value can reach a use, beta leaves that use on the original register instead of inventing a phi.
- This beta form is intentionally analysis/presentation-only and is not expected to be runtime-valid while cross-state references point at block-local version names. Ambiguous joins are not synthesized into source locals/phi nodes. Normal `output/N.lua` behavior is unchanged.
- Focused regression: `tools/test-beta-register-versions.js`; beta output is reparsed before writing.


## Performance Optimization Audit (2026-08-23)

- Historical performance measurements before `edc805b` used the previous unpaired sample 5 and remain historical only. The current source-backed sample 5 deliberately matches its 938-state / 116-function scale but is different source, so benchmark numbers are not directly comparable.

- Before the whole-pipeline optimization audit, the user explicitly requested a pushed checkpoint first. Commit `c224017 Optimize VM state traversal queues` is that pre-audit checkpoint. It replaced array `shift()` BFS queues with cursor-based queues, used `Set` membership for queued/ordered state IDs, and kept reachable-state traversal itself O(V + E) aside from dispatcher-leaf resolution/rendering.
- Optimized implementation checkpoint: `0f4650a Optimize deobfuscator hot paths`. The audit read the complete normal deobfuscation pipeline (main + every current pass) and changed only mechanically equivalent hot paths; parser internals and the proven reaching-def/liveness solver were intentionally not redesigned.
- `passes/text-edits.js` now applies non-overlapping source edits in one ordered chunk build, O(source length + edit payload/count) after sorting, instead of repeatedly slicing/rebuilding the entire source once per edit. ConstantArray replacement, environment rename output, safe-assignment splitting, VM-state range patching, and register-scheduler output all use this path. This removed the largest hidden O(edit_count * source_size) cost.
- VM helper renaming now uses `passes/batch-parameter-rename.js`: helper-role bindings are planned together and renamed in one lexical AST traversal, including nested VM parameters, while preserving the same shadow/collision rules. If a batch conflict/collision is detected, `renameVmHelperBindings` falls back to the previous sequential implementation rather than guessing. Helper-function parameters are handled in a second small batch. Focused nested-shadowing regression: `tools/test-batch-parameter-rename.js`.
- Register scheduling caches immutable per-statement read/write sets in `WeakMap`s, eliminating repeated AST walks during RAW/WAR/WAW checks and validation. Scheduling decisions/output are unchanged.
- New primitive regression `tools/test-text-edits.js` covers replacement/text edits, absolute base offsets, and overlap rejection. Current focused regressions all pass: text edits, batch parameter rename, VM register scheduler, and VM state reachability.
- Semantic naming was moved from the late post-register stage to the VM-helper stage in `bf7b107`. Before the fixture reset, the then-current samples 1-10 (including stress sample 5) remained byte-for-byte identical. A five-run sample-5 benchmark measured old 1993.5 ms average vs new 1935.4 ms average (~2.9% faster on that run); this is historical local evidence only.


## Semantic Naming Layer (2026-08-23)

- `passes/semantic-names.js` now runs immediately with VM helper naming, before safe parallel-assignment splitting and Step 3. It renames only structurally proven compiler roles and never from randomized spelling alone. Moving it earlier is presentation-only; scope reconstruction remains unchanged and analysis-only.
- The outer wrapper parameter receiving the unique `{...}` argument is renamed `InitialArgs`. This is distinct from the VM parameter `args`: `InitialArgs` is the original top-level vararg table passed into the root closure, while `args` is the per-closure invocation argument table.
- Proven `createClosure*` helpers rename their `createUpvalueProxy(captures)` local to `gcProxy`, returned nested-function local to `closure`, and fixed-arity nested parameters to `arg1`, `arg2`, ...; the vararg factory keeps `...`.
- `releaseUpvalues` renames its structural iteration locals to `captureIndex` and `upvalueId`. `createUpvalueProxy` renames its numeric-for index to `captureIndex`, the `newproxy(true)` local to `proxy`, and `getmetatable(proxy)` to `proxyMetatable`.
- When a VM overflow-register table is proven structurally as the table-backed register bank before the scalar register declaration, it is renamed `RegisterOverflow`. Current tracked samples 5 and 10 exercise this path; other fixtures do not invent it.
- Focused regression `tools/test-semantic-names.js` covers `InitialArgs`, fixed closure `argN`, `gcProxy`, `closure`, `captureIndex`, `upvalueId`, `proxy`, `proxyMetatable`, and `RegisterOverflow`. Current paired fixtures 1-11 remain parse/runtime-valid where executable.

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
5. Continue CFG structuring separately: sample 4 is again the focused if/while/repeat + shared-capture regression, sample 6 the nested-function/if/while regression, and sample 7 the branch/early-return regression.
6. Keep POS-register temporary reuse distinct from true block terminators; extend Prometheus-specific recognition only from evidence in the local WeAreDevs compiler unless the user explicitly requests the public/canonical implementation.
7. Keep every pass structural/generalized, reparse transformed Lua, runtime-check executable fixtures, and update/commit/push `CONTEXT.md` after meaningful work.
8. If the current parser becomes a correctness blocker, evaluate Rust Moonlight instead of parser-specific hacks.
## Fresh Chat Resume Snapshot (2026-08-23)

### Authoritative workspace / Git

- Workspace: `C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`.
- Branch: `main`.
- Remote: `https://github.com/GooseGoldenGoose/new-promdeobf.git`.
- Latest pushed beta behavior checkpoint at this snapshot: `f93cc7a Keep beta versions block local`.
- Previous beta behavior checkpoint: `88a2dc5 Preserve final VM special writes in beta`; it is superseded by the current rule that preserves all final `state` writes but only terminal table-valued `ReturnVal`.
- Latest fixture checkpoint: `4717198 Add beta branch sample 11`.
- Immediately preceding context checkpoint: `2643ebc Document restored sample coverage`.
- Before changing anything in a new chat: read this entire `CONTEXT.md`, run `git status --short --branch`, then `git log -8 --oneline --decorate`. Never assume the checkout is still at this exact commit if newer work exists.
- Every project code/content change, even small, gets a focused commit and `git push origin main`. Stage only files belonging to the current change.
- `formater/` remains intentionally untracked. Generated `output/*.log` or temporary output files must not be committed accidentally. All tracked `sample/N.txt` files must have matching tracked source files.
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
5. VM helper + structural semantic naming: helper roles (`unpack`, `newproxy`, `setmetatable`, `getmetatable`, `select`, `vm`, upvalue helpers/tables/parameters) plus `InitialArgs`, closure helper locals, fixed closure `argN`, release/proxy locals, and proven `RegisterOverflow`.
6. Split only proven-safe parallel assignments.
7. Step 3 VM-state/CFG recovery: reachability-driven roots, closed graph proof, dead-state pruning, contiguous normalized IDs, balanced dispatcher rendering, canonical stop `state = nil` at actual leaf tail, no normalized invalid/unreachable fallback.
8. Step 4 VM binding/capture analysis: analysis-only reaching definitions, liveness, definition epochs, capture slots, static upvalue-cell identities, relays, binding-end/ownership-handoff candidates.
9. Dependency-safe VM register scheduling inside normalized leaves.
10. VM register presentation naming: the VM’s own final `return unpack(R)` identifies that VM-local binding as `ReturnVal`; every use/write of that same binding inside `vm` is renamed consistently. Other scalar VM registers become deterministic `r1`, `r2`, ... . Same-spelled identifiers outside `vm` are untouched.
11. Final reparse and output.

### State / scheduler facts that must not regress

- The compiler’s POS/state register has two roles: expression temporary and dispatcher program counter. A plain `state = value` is NOT automatically a terminator.
- Only proven final POS/state transitions determine CFG edges. Canonical `setPos(nil)` random `_env[12..14 alphanumeric]` is an obfuscated stop and Step 3 normalizes it to final `state = nil` at the actual end of the state body.
- Reachability starts from the real root; closure entries are discovered only from reachable states. Dead states cannot “rescue” dead child closures.
- Reachable graph walk uses Set/Map + cursor queues; pruning traversal is O(V+E) apart from dispatcher-leaf resolution/rendering.
- Scheduler NEVER deletes stores. It moves only proven pure register assignments through RAW/WAR/WAW-safe crossings and validates every reordered segment fail-closed.
- Unread pure writes sink toward the actual dispatcher-leaf tail; the final canonical `state = nil` remains the last stop anchor.
- Scalar scheduler reads/writes are cached per statement.
- Proven overflow register banks participate in exactly the same scheduling logic as scalar registers. Detection is structural and does not depend on the spelling `RegisterOverflow`; semantic naming now runs earlier, so the bank may already carry that name when scheduling starts. Proof still requires a unique empty-table VM bank before the scalar declaration, positive constant numeric indices only, and no alias/bare use/dynamic index/shadowing. Each slot is an internal identity such as `overflow:1`. Ordinary tables remain conservative.

### Current overflow proof / sample 10

- `sample/10.source.lua` and `sample/10.txt` are the tracked NATURAL overflow regression: 110 ordinary source locals in one lexical scope; no synthetic VM/table code.
- Compiler probe proves `v98 -> physical register 99` stays scalar; `v99 -> register 100 -> RegisterOverflow[1]`, through `v110 -> register 111 -> RegisterOverflow[12]`.
- Later compiler temporaries naturally use additional overflow slots.
- Runtime parity source/obfuscated/deobfuscated: `overflow-test 1001 1098 1099 1100 1101 1110`.
- Scheduler currently detects 19 used overflow slots in sample 10 and performs overflow-aware compaction.
- IMPORTANT CURRENT GAP: Step-4 reaching-definition/liveness/binding analysis still models scalar identifier registers only. It does NOT yet normalize `RegisterOverflow[k]` slots into definition/use identities. Runtime/emitted Lua is correct; source-binding analysis for overflow-backed locals is incomplete. If implementing this later, reuse the same structural bank detector and model scalar + overflow storage under one VMRegister identity abstraction. Do not treat arbitrary tables as registers.

### Current scope status — DO NOT assume implementation

- The user explicitly said NOT to implement scope recovery yet; the discussion was conceptual only.
- No source lexical-scope reconstruction pass should be claimed as implemented.
- What IS known for future work: physical VM register != source variable identity. Dispatcher states are CFG blocks, not lexical scopes. Same source local uses one reserved VAR_REGISTER while alive; compiler cleanup then force-frees it and later bindings can reuse the physical register. `R=nil` alone is never enough to prove scope end. Captured locals use shared upvalue-cell identity, which is stronger proof.
- Do not use normalized `rN` names, dispatcher nesting, or adjacency as source-scope evidence.

### Fixtures / key validations

- Sample 1: paired baseline (`base`, `compute`, one captured upvalue, branch); runtime `baseline 14 4`; 5/5 states normalized.
- Sample 2: restored warn/random branch; runtime with deterministic shim `gg`, `ranf`; 3/3 states.
- Sample 3: restored shadowed block + shared mutable capture; runtime `block 10 2`, `before 1`, `after 3 3`; 3/3 states.
- Sample 4: restored if/while/repeat + shared `total`; runtime `start 0`, `choose 5`, `spin 10`, `trim 2`; 16/16 states.
- Sample 5: source-backed stress fixture; 938/938 states, 116 functions, 23 overflow slots; runtime `stress 2 63 182 182`.
- Sample 6: nested function ownership root -> outer -> inner; runtime `theory 8 10 5`.
- Sample 7: conditional shadowing + early return + captured closure; deterministic seeds 1 and 3 both parity-tested.
- Sample 8: ordinary register cleanup/ownership handoff; proves explicit source nil vs compiler cleanup distinction.
- Sample 9: `local x` / `local y=nil` initialization via special temp + copy; prevents classifying every direct nil as scope cleanup.
- Sample 10: natural overflow storage boundary and overflow-aware scheduler regression.
- Sample 11: beta branch/join fixture from `local a = 3123; if _G.wasd then print(a); a = 3 end; print(a)`. Normal source/obfuscated/deobfuscated parity: false path prints `3123`; true path prints `3123`, `3`. Normalized VM has 3 states, 20 definitions, one join group, and 2 cross-block lifetimes. Current beta output versions 16 assignments across 3 leaves and proves exactly 1 cross-state version: state 1 keeps `local r_v2_1 = ...`, while state 2 directly reads `r_v2_1`. This is intentionally non-runnable presentation output. State 3 still reads raw `r2` because two reaching definitions can reach the join, so beta refuses to guess.

### Performance history / boundary


### Most recent commits to recognize

`db021b3 Normalize VM register names`
`fd6a359 Document VM register naming`
`638cca8 Track semantic VM names`
`6e76c14 Document semantic VM naming`
`d6a96bd Add natural register overflow regression`
`0b60f90 Record overflow regression`
`b7f6185 Schedule overflow VM registers`
`7442545 Document overflow register scheduling`
`bf7b107 Run semantic naming with VM helpers`
`edc805b Restore paired samples 2 through 5`
`2643ebc Document restored sample coverage`
`56784a1 Add beta register versioning`
`57b8dcb Keep VM state registers unversioned in beta`
`4717198 Add beta branch sample 11`
`88a2dc5 Preserve final VM special writes in beta`
`5ae6133 Preserve only terminal return tables in beta`
`826ede5 Propagate proven beta register versions across states`
`f93cc7a Keep beta versions block local`

### New-chat operating instruction

When the user pastes the resume prompt from this snapshot, do NOT merely summarize it. First read `CONTEXT.md`, inspect Git status/log, and then continue the user’s new requested task by actually editing/testing/committing/pushing as needed. Never ask them to repeat information already in this file.
