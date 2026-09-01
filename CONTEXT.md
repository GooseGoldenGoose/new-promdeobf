# Prometheus Lua/Luau Deobfuscator - Live Handoff

## Reset Authority

Workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repository:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Branch: `main`

Project was intentionally reset to the tracked tree of:
`7c3678acf52d47134388db1f755da9dcddf99e3e`

Rollback commit:
`000552b0783dc966713c06fbffd94b60d4b86310 Restore project to 7c3678a checkpoint`

Reset tree hash:
`2c54a981c7313474cf55387696dfca69207b1aa8`

Treat later PRE-CF/post-CF optimizer work as abandoned unless the user explicitly asks to revive a specific idea.

## Mandatory Workflow

- Read this file first.
- Run `git status --short --branch` and `git log -5 --oneline` before changing anything.
- Preserve unrelated dirty/untracked work.
- Update this file after meaningful tracked changes.
- Stage only files belonging to the current task.
- Commit focused changes and push `origin/main`.
- Fail closed on incomplete structural proof.
- End project turns exactly: `Done for this turn — you can prompt now.`

Known tracked user dirt to preserve:

```text
formater/input.txt
main.js
```

Known untracked areas include `opt/`, `opti/`, `tmp/`, `--output-dir/`, `_tmp-*` tools/passes, generated samples. Do not clean/stage them blindly.

`main.js` still contains unrelated newer dirty local edits that must be preserved. The tracked pipeline now provides `passes/input-formatter.js`, so the formatter dependency is valid.

## Goal

Prometheus VM -> recover registers/upvalues/control flow -> understandable structural Lua/Luau.

Correctness first. No aggressive generic optimizer chain.

Everything dynamic/structural. No hardcoded states, registers, names, methods, globals, services, or fixture patterns.

Preserve evaluation order, side effects, calls, multi-return semantics, lexical scope, captures/upvalues, break/continue/return, namecall/self semantics, and loop frequency.

## Compiler Authority

Local compiler:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`

Authority source:
`src\prometheus\compiler\compiler.lua`

Important register facts:

- `allocRegister(false)` creates a temporary allocation.
- `allocRegister(true)` / `getVarRegister(scope,id,...)` creates/reserves a source-variable register lifetime.
- Normal `freeRegister(id,false)` does not free `VAR_REGISTER` allocations.
- Source-variable registers are force-freed at source scope end.
- Physical register identity is reusable across different lifetimes; classify lifetimes, not register numbers.
- Temporary allocation priority is POS register (`state`), then RETURN register (`ReturnVal`), then the lowest free scalar register with current `MAX_REGS_MUL = 0`.
- `state` and `ReturnVal` can temporarily hold ordinary compiler values.
- `freeRegister` operations and `VAR_REGISTER` tags are not emitted into the VM.
- Captured locals use `allocUpvalue`, `upvalueValues[...]`, capture IDs, and `releaseUpvalue` lifecycle.
- `emitContainerFuncBody` dependency-shuffles block statements while respecting read/write conflicts and upvalue/effect barriers.

## Current Structural Pipeline

## Input Formatting

- `passes/input-formatter.js` runs `formater/luau-format.exe <input> --luraph --output=<temp>` before the first parse.
- Formatting is enabled by default; `options.formatInput === false` is an explicit diagnostic bypass.
- It reads the requested source file directly and does not touch `formater/input.txt`.

Normal path:

```text
format input with formater/luau-format.exe (--luraph)
-> parse
-> constant-array recovery
-> environment recovery
-> closure-factory recovery
-> VM helper semantic naming
-> safe parallel-assignment splitting
-> VM state/CFG recovery
-> VM binding/capture/provenance analysis
-> VM register scheduler
-> VM register presentation naming
-> normal output
```

Beta path (fresh/reset):

```text
normal output
-> fresh beta control-flow pipeline (not wired yet)
-> structural Lua/Luau
```

Key files:

```text
passes/vm-state.js
passes/vm-bindings.js
passes/vm-register-scheduler.js
passes/vm-register-names.js
passes/beta-register-versions-old.js
passes/beta-register-lifetimes.js
passes/beta-upvalues.js
passes/beta-control-flow.js
```

## Retired Beta Register Versioning

- Legacy implementation is preserved at `passes/beta-register-versions-old.js`.
- Legacy CLI is `tools/beta-register-versions-old.js`.
- It is out of the active beta pipeline and active beta CF does not invoke it.
- Legacy graph/version diagnostics may still import the `-old` pass explicitly.
- Do not revive it implicitly; build new register recovery only when explicitly requested.

## Register / Lifetime Rule

A physical VM register is not one source binding.

Conceptually:

```text
rN
-> CFG/reaching-definition lifetimes
-> r_vN_1, r_vN_2, ...
```

Same proven logical lifetime stays together across states. Independent definition/lifetime gets a new version. Ambiguous merges fail closed.

Long-term target classification per lifetime:

```text
TEMP
VAR
CAPTURED_VAR
UNKNOWN
```

Do not force TEMP/VAR classification when emitted evidence permits multiple compiler histories.

## VM Register Scheduler

`passes/vm-register-scheduler.js` canonicalizes dependency-safe statement order after compiler block shuffling.

Safety invariants:

- preserve RAW/WAR/WAW dependencies
- preserve relative order of non-movable/effectful anchors
- never delete writes as part of scheduling
- keep final branch/jump/stop state transitions anchored
- only move pure primitive/register-copy assignments when proven independent

Latest scheduler change:

- Static canonicalization now protects wider-lifetime register chains identified by a final direct `rN = nil` cleanup in the current straight-line leaf.
- All writes to such a register are scheduling anchors, and delayable TEMP writes may not cross those anchors.
- This prevents source locals such as `local a = 1; print(a)` from being pulled into a call-local TEMP chain while still allowing direct TEMP chains such as GETGLOBAL key/load and literal call arguments to compact deterministically.
- The rule is intentionally conservative and loop-specific nil behavior remains deferred to later control-flow-aware handling.
- Scheduler regression, VM state reachability, and register naming regressions pass.

Latest change after reset:

- Recognize earlier overwritten `state` assignments with primitive/register RHS as borrowed POS-register temporary writes.
- Those proven borrowed POS temps may move dependency-safely toward their next use.
- The final state write in the leaf remains non-delayable/anchored.
- Focused scheduler/state/register-name regressions pass.
- Beta test scripts are blocked by the user's dirty `main.js` importing abandoned `passes/input-formatter` unless committed `main.js` is temporarily restored.

## spacial6

Large fixture: `sample/spacial6.txt`

Correct CF input at this checkpoint is normal deobfuscated VM source (`output/spacial6.lua`), not raw `sample/spacial6.txt` directly into beta-CF.

Known blocker from fresh reset testing:

```lua
local r_v15_1511 = releaseUpvalue(r_v15_1510)
```

Observed failure:

```text
State 3635 retains unresolved VM upvalue machinery after recovery
```

Do not hardcode state 3635 and do not delete `releaseUpvalue` afterward. Trace compiler upvalue-cell ownership/lifetime structurally.

## Testing

For structural fixes:

1. tiny readable source
2. obfuscate with local compiler
3. normal deobf
4. beta / beta-CF
5. inspect intermediate CFG/data flow
6. runtime parity where possible
7. focused regression
8. existing fixtures
9. `spacial6` when relevant
10. update context, focused commit, push
## Fresh Beta CF Solver Reset

- `passes/beta-control-flow-old.js` is the exact previous beta control-flow solver preserved unchanged (same Git blob as pre-reset `passes/beta-control-flow.js`).
- `passes/beta-control-flow.js` is now a fresh fail-closed solver shell.
- The fresh solver does not silently call or fall back to the old solver.
- Existing callers keep importing `./passes/beta-control-flow`, so new CF work can be implemented incrementally behind the same entry point.
- Old helper export names remain present as explicit unimplemented fail-closed stubs for compatibility while the new solver is rebuilt case-by-case.


Latest scheduler canonicalization improvement:

- Source-lifetime register writes remain non-delayable, but unrelated TEMP assignments may now cross non-boundary writes in that lifetime when RAW/WAR/WAW proof allows it.
- Only the final proven direct `rN = nil` source-lifetime cleanup is a hard crossing boundary for unrelated TEMP motion.
- This restores tighter compiler-handler grouping without allowing TEMP scheduling to leak across source lifetime end.
- Real `sample/1.txt` scheduling improved from 13 to 27 dependency-safe swaps; call-local producers now group as `r2 = 3 -> r3 = r5(r2)`, `r4 = 1 -> r5(r4)`, and `r1 = "baseline" -> final print call`.
- Scheduler, VM state reachability, and VM register naming regressions pass, including a new source-lifetime boundary test.
## Scheduler Performance Optimization

- `passes/vm-register-scheduler.js` now detects final `rN = nil` lifetime boundaries with one reverse dataflow pass instead of rescanning the remainder of the leaf for each cleanup.
- Statement read/write caches now store one flat most-recent overflow context per AST statement instead of allocating a nested `Map` per statement; alternate diagnostic contexts recompute safely.
- On `output/spacial6.lua` (~8.87 MB), scheduler cold-process runtime improved from about 720 ms baseline to 607 / 583 / 565 ms across three fresh-process runs.
- Scheduling result stayed identical: 2,337 changed blocks, 28,972 swaps, zero safety-rejected segments.
- `sample/1.txt` scheduled output is byte-identical to the pre-performance-optimization result.
- Scheduler, VM state reachability, and VM register naming regressions pass.


## Fresh CF: Direct Global Call

- The active fresh solver now consumes normal output source + AST directly; it does not consume retired beta register-version analysis.
- First implemented fail-closed case: exactly one normalized VM state containing the proven direct GETGLOBAL + primitive-argument call pattern and terminal root bookkeeping.
- Proven `print(1)` pipeline now recovers exactly `print(1)`.
- Matching is linear over the single dispatcher leaf: no CFG search, no backtracking, no legacy fallback.
- Unknown/effectful statements, non-terminal state transitions, unsupported global-name encodings, duplicate/missing argument producers, or extra VM states fail closed.
- `tools/beta-control-flow.js` is active again for normal-output Lua and validates the recovered source structurally.
- Fresh matcher benchmark on the parsed real `print(1)` normal output: about 7.5 microseconds per solve over 100,000 iterations; parsing is outside this measurement.
- Fresh CF regression, scheduler regression, VM state reachability regression, and VM register naming regression pass.

## Fresh CF: Sequential / Multi-Argument Global Calls

- One-state fresh CF now consumes multiple direct global calls sequentially in one linear pass.
- Supported call arguments: primitive literals, empty table literals, and proven global-expression TEMP pairs such as `k = "math"; v = _env[k]`.
- Compiler key TEMP slots may be reused later only after the key has been consumed by its `_env[...]` lookup; live argument TEMP overwrites still fail closed.
- Real compiler/main/fresh-CF fixtures recover exactly `print(1)\nprint(2)\nprint(3)` and `print({}, 1, "wa", math, true, nil)`.
- Function literal arguments remain intentionally unsupported/fail-closed.
- Matcher remains linear, consume-once, with no CFG search/backtracking or legacy fallback.
- Benchmark across parsed real sequential + multi-argument fixtures: about 8.87 microseconds/solve over 100,000 solves; parsing excluded.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.

## Fresh CF: Direct Global Member Calls

- Fresh one-state CF now supports the proven direct member-call chain `GLOBAL -> INDEX -> immediate CALL`, e.g. `math.random(1, 2)`.
- Matching is structural/dynamic: global and member identifiers are recovered from the normalized VM key loads; no `math`/`random` hardcode.
- The matcher requires the member result to feed the call directly through `state`; any intervening source-local copy/promotion/lifetime evidence fails closed.
- Real compiler -> main -> fresh-CF fixture recovers exactly `math.random(1, 2)`.
- Real `local a = math; a.random(1,2)` and `local a = math.random; a(1,2)` shapes are explicitly rejected by this direct-member case.
- Parsed real `math.random(1,2)` matcher benchmark: about 14.43 microseconds/solve over 100,000 solves; parsing excluded.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.

## Fresh CF: Arbitrary Direct Member Chains

- Direct callable recovery is no longer hardcoded to a two-hop `math.random` shape.
- The fresh solver now follows any number of proven compiler `IndexExpression` hops: `key = "member"; next = current[key]`, beginning from a proven global `_env[key]` load and ending at the immediate call.
- Real compiler/main/fresh-CF fixtures recover exactly `math.random(1, 2)` and `game.foo.bar.baz.qux()`.
- Destination registers may alternate across ordinary VM registers, `ReturnVal`, and `state`; provenance follows register identity at each hop.
- Table/function local alias shapes remain rejected because visible copy/lifetime-cleanup evidence breaks the direct-chain consume pattern. Promoted-local cleanup also prevents terminal bookkeeping from matching.
- Matching remains linear in the leaf with no depth limit, search, backtracking, or legacy fallback.
- Parsed-fixture benchmark across `math.random(1, 2)` and a four-member chain: about 14.3 microseconds/solve over 100,000 solves; parsing excluded.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.

## Fresh CF: Register Maker / Local Lifetimes

- Fresh one-state CF now has a register-maker path for explicit source-local ownership handoffs backed by a proven final direct `rN = nil` cleanup.
- First supported local-lifetime shape requires a visible register copy from a computed expression into the cleanup-backed physical register; this covers POS/RETURN result handoffs and fails closed on promotion-only local starts for now.
- Pre-lifetime TEMP reuse of the same physical register is ignored until the proven ownership handoff, so key temporaries such as `r1 = "game"` do not become fake locals.
- The first ownership handoff emits `local rN = <expr>`; later writes in the same cleanup-backed lifetime emit `rN = <expr>`.
- Real compiler/main/fresh-CF fixtures recover `local r4 = math; r4.random(1, 2)`, `local r2 = math.random; r2(1, 2)`, and `local r1 = game.Players; local r3 = r1.LocalPlayer; r3 = r3.Character`.
- Member/global expression reconstruction is symbolic and dynamic; no hardcoded `math`, `game`, `Players`, `LocalPlayer`, or `Character` names.
- Physical-register names are used as generated source-local names because original source identifiers are not recoverable from the VM.
- Register-maker matcher benchmark across the three parsed real fixtures: about 13.8 microseconds/solve over 90,000 solves; parsing excluded.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.

## Fresh CF: Keyed Table Constructors

- Register-maker symbolic rendering now supports proven keyed table constructors emitted as `TableKey` fields backed by already-known register expressions.
- Identifier string keys render as Lua record fields (`{ b = 2 }`); other proven keys render as `[expr] = value`.
- Real compiler/main/fresh-CF fixture `local a = { b = 2 }; print(a.b)` recovers exactly `local r3 = { b = 2 }; print(r3.b)`.
- Table field names/values are recovered dynamically from compiler expressions; no hardcoded `b`.
- Fresh CF and existing VM regressions pass.


## Fresh CF: Presentation Local Renaming

- Recovered source locals are now presentation-renamed independently of physical VM register numbers.
- Ordinary/value locals are named `v1`, `v2`, ... in declaration order.
- Locals whose declaration value is a proven table constructor are named `t1`, `t2`, ... in declaration order.
- `v` and `t` counters are independent, so a table local does not consume a value-local index and vice versa.
- Renaming is presentation-only; lifetime ownership/recovery logic is unchanged.
- References, calls, member reads, and later assignments use the stable recovered name consistently.
- Real fixtures now recover `local v1 = math; v1.random(1, 2)`, `local v1 = math.random; v1(1, 2)`, `local v1 = game.Players; local v2 = v1.LocalPlayer; v2 = v2.Character`, and `local t1 = { b = 2 }; print(t1.b)`.
- Mixed regression proves independent numbering: `local v1 = 1; local t1 = { x = 2 }`.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.

## Fresh CF: Binary / Logical Expressions

- Register-maker symbolic rendering now composes proven `BinaryExpression` and `LogicalExpression` nodes from already-resolved register expressions.
- Real compiler/main/fresh-CF fixture `local a = math.random(1,2) == 1 and 123 or 321` recovers as `local v1 = (((math.random(1, 2) == 1) and 123) or 321)`.
- Consumed call results are no longer emitted as standalone call statements; this prevents duplicate side effects when a call feeds a larger expression.
- A non-local TEMP assignment with an unknown RHS may be skipped only when the immediately following statement overwrites the same register, proving the first write dead before observation.
- Expression rendering remains fail-closed when operands are not already proven symbolic values.

## Fresh CF: Multi-State Short-Circuit Logical Chains

- Fresh CF now reconstructs Prometheus short-circuit `and` / `or` expressions that compile into multiple normalized VM states.
- State leaves are extracted structurally from either nested `if state == N` dispatchers or `if/elseif` normalized dispatchers.
- Logical transitions are recognized dynamically from the compiler form `state = condition and TRUE_STATE or FALSE_STATE`; state IDs and operand count are not hardcoded.
- Symbolic execution propagates proven register expressions through the normalized state DAG and merges short-circuit joins using branch provenance.
- Nested logical expressions use a provenance stack, so inner joins preserve outer branch conditions and arbitrary chain depth can merge inside-out.
- Join merging ignores the VM control-state register itself because block entry proves `state == current normalized ID`; compiler POS-state copies can therefore be handled without becoming fake program values.
- Path-local TEMP values present on only one predecessor are dropped at joins and remain fail-closed if read before redefinition.
- Cleanup-backed registers with one non-nil definition remain stable source locals; cleanup-backed registers with multiple mutually-exclusive logical-path definitions are treated as short-circuit accumulators and emitted once at final cleanup instead of as fake assignments.
- Real 5-state fixture recovers `local v1 = game; local v2 = workspace; local v3 = (v1 and v2); local v4 = (v1 or v2)`.
- Real 9-state distinct-operand fixture recovers `local v4 = (v1 or (v2 or v3))` and `local v5 = (v1 and (v2 and v3))`.
- Repeated nested fixture `a and b or a and b` safely simplifies through value merging to `(a and b)`.
- Constant-only chains may already be folded by Prometheus before fresh CF; real `1 or 2 or 3 or 4 or 5` recovers as `local v1 = 1`, preserving semantics.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.



## Fresh CF: Closure Entry Recovery

- Fresh CF now recognizes normalized closure-factory calls structurally from semantically named `createClosure` / `createClosureN` calls carrying `(childEntryId, captureTable)`.
- First implemented closure scope is empty-capture closures only; non-empty capture tables fail closed and remain future upvalue work.
- Child function source is recovered from the normalized child entry state instead of using the randomized closure-helper arity.
- Source parameters are derived from actual child `args[index]` reads, so compiler-added dummy helper arguments do not become fake parameters.
- Child entry rendering currently supports primitive/global/member/binary/logical/call symbolic expressions and terminal return tables; multiple return values are preserved.
- Closure expressions are fed into the existing register-maker via a special-call renderer, so local ownership/lifetime and `vN` naming stay unified with ordinary locals.
- Real compiler/main/fresh-CF fixture `local a = function() return 123 end` recovers `local v1 = function() return 123 end`.
- Real two-parameter/multi-return fixture recovers `local v1 = function(v1, v2) return v1, v2 end`, while the compiler helper may have a different randomized arity.
- Mode: `fresh-closure-entry`; reports `closureCount`.
- Nested closure creation, captured upvalues, vararg closures, and packed closure-call/multi-return lowering are not claimed supported yet and fail closed.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass.

- Closure child bodies now emit proven standalone call statements when the call result is unused before overwrite; this prevents side effects such as `print(1)` from disappearing.
- Real fixture `local a = function() print(1) end` now recovers `local v1 = function() print(1) end`.

## Fresh CF: Multi-Return Calls / RETURN_ALL

- Fresh CF now recovers the compiler-defined packed call-result forms used by `compileExpression(FunctionCallExpression, ...)`.
- `RETURN_ALL` compiler shape is recognized structurally as `pack = { f(...) }` followed by `unpack(pack)` in the consuming final argument; fresh CF collapses this back to the original direct call while preserving Lua multi-return expansion.
- Real compiler/main fixture `print(1, math.modf(1.5))` recovers exactly `print(1, math.modf(1.5))` through mode `fresh-call-results`.
- Closure call `print(a, a(1,2))` now recovers through the same generic packed/unpack rule; this is not closure-specific.
- Fixed multi-return compiler shape is recognized as `pack = { f(...) }` followed by numeric slot reads (`pack[1]`, `pack[2]`, ...).
- Source-local ownership for fixed returns supports both compiler forms: direct TEMP-to-VAR promotion of a slot register and explicit slot-temp -> cleanup-backed local-register copy.
- Fixed return slots are emitted as one grouped declaration so the function call executes exactly once, e.g. real `local a,b = math.modf(1.5)` recovers `local v1, v2 = math.modf(1.5)`.
- Presentation names for grouped multi-return locals follow return-slot order, independent of physical register allocation/promotion order.
- Packed return slots must be contiguous from 1 and uniquely owned; ambiguous/missing slots fail closed.
- The no-local packed-call fallback requires proven terminal root bookkeeping (`ReturnVal = {}` then `state = nil`) and does not accept non-terminal state transitions.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass, including fixed multi-return and generic `RETURN_ALL` tests.


## Fresh CF: Separated Closure Local Into Multi-Return Call

- Fresh CF now tolerates proven neutral bookkeeping and source-local cleanup between packed fixed-return slot extraction and the later source-local ownership handoff.
- Compiler scheduling can emit `ReturnVal = pack[1]; r4 = pack[2]; argsTemp = args; closureLocal = nil; resultLocal = ReturnVal` before the packed call can be finalized.
- Recovered source locals already resolve as later call arguments; the actual blocker was premature packed-call flushing before all result slots acquired source-local owners.
- Real compiler/main fixture `local c = function() error("231sadsa") end; local a,b = pcall(c); print(a,b)` now recovers as `local v1 = function() error("231sadsa") end; local v2, v3 = pcall(v1); print(v2, v3)`.
- Neutral statements allowed while a packed call is pending are restricted to the proven `args` bookkeeping copy and direct cleanup-backed `rN = nil`; unrelated statements still force a successful flush or fail closed.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass with a permanent separated-closure `pcall` case.


## Fresh CF: Recursive Empty-Capture Closures

- Closure child rendering now reuses the same structural `createClosureN(entry, captures)` special-call hook recursively, so an empty-capture child may itself create and return another empty-capture closure.
- Recursive entry consumption is guarded by normalized entry ID; already-consumed entries are rejected, so malformed/cyclic closure references fail closed instead of recursing indefinitely.
- Child entries are only marked consumed while their structural render is active/successful; a failed child render removes its provisional consumption mark.
- Multiline nested closure expressions are indented line-by-line in emitted function bodies.
- Real compiler/main fixture `local a=123; print(a,123); print(pcall(print,1)); local b=function() return function() print(321) end end; b()()` now recovers as `local v1 = 123; print(v1, 123); print(pcall(print, 1)); local v2 = function() return function() print(321) end end; v2()()` with proper nesting/indentation.
- Current recursive support remains empty-capture only; captured nested closures still belong to upvalue recovery.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass with the full mixed nested-closure case.


## Fresh CF: First Read-Only Captured Local

- Fresh CF now recovers the first proven captured-local/upvalue shape from the actual compiler cell lifecycle.
- Proven root chain: `cell = allocUpvalue(); value = ...; upvalueValues[cell] = value; closure = createClosureN(child, { cell }); releaseUpvalue(cell)`.
- Proven child read: `upvalueValues[upvalues[1]]` maps back to the parent captured source local.
- Real compiler/main fixture `local a = 123; local f = function() print(a) end; f()` now recovers as `local v1 = 123; local v2 = function() print(v1) end; v2()` through mode `fresh-captured-closure`.
- The matcher uses capture-slot identity (`child slot 1 -> cell -> parent value`) rather than physical register identity.
- Child closure rendering can resolve direct captured reads and the compiler-shuffled `_env[key]` load where the key literal is the immediately following proven producer.
- Current scope is deliberately read-only, one captured cell, one child closure. Shared cells, captured writes, multiple captures, and captured nested closures remain unsupported/fail-closed.
- Original obfuscated fixture, normal deobfuscated VM, and recovered fresh-CF output all execute and print `123`.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass with a permanent captured-local case.

## Fresh CF: Captured Parameters in Nested Closures

- Recursive closure rendering now tracks local upvalue-cell identities created inside a child function, even when `createClosureN(child, { cell })` is emitted before the later `upvalueValues[cell] = args[index]` write.
- A pending captured closure records capture cell registers first; when the closure is later returned/used, each cell is resolved back to its proven source expression/parameter.
- Child `upvalueValues[upvalues[n]]` reads then render through the capture-slot map to the parent parameter name.
- Real compiler/main fixture `local a=function(b) return function() return b end end; print(a(1)())` now recovers as `local v1=function(v1) return function() return v1 end end; print(v1(1)())`.
- The generalized recursive renderer preserves existing empty-capture recursion and the earlier top-level read-only captured-local matcher.
- Shared cells, captured writes, and arbitrary mutation through upvalue cells remain unsupported/fail-closed.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass with a permanent captured-parameter case.


## Fresh CF: Shared / Forwarded Capture Cells

- Recursive capture recovery now resolves capture-table fields by logical source binding rather than requiring every child capture to come from a locally-created cell register.
- A child capture field may be either a local cell register or forwarded upvalues[n]; forwarded slots keep the same source binding identity through arbitrary nested closure levels.
- Root captured cells are presentation-named when upvalueValues[cell] = value is proven, then those names seed child capture maps.
- Nested local/parameter cells may be mixed with inherited slots in one capture table, e.g. { upvalues[1], upvalues[2], r4, r3 }.
- Parameter presentation names now avoid inherited capture names so nested parameters cannot shadow captured bindings and silently change semantics.
- Real complex fixture with root captures a,b, nested captured local c, captured parameters x,y, 11 capture slots, 5 local cells, 4 shared cells, and 15/15 resolved accesses now recovers and runs correctly.
- Current emitted form safely inlines immutable captured local c = 30 as 30 in the deepest closure; source-local re-materialization for that presentation case remains optional future cleanup.
- Runtime parity for the complex fixture: prints 10 20 30 40 50 then 150.
- Captured mutation/shared writable cells remain separate future work.


## Fresh CF: Capture Dynamic/Performance Audit

- Removed the obsolete matchReadOnlyCapturedClosureProgram special case. It hardcoded the first captured-local presentation as v1/v2 and assumed exactly two states / one capture; the generic closure/cell matcher now handles that fixture identically.
- All captured-closure recovery now uses the unified structural path: normalized closure entry IDs, capture-table order, local upvalue cell identity, and forwarded upvalues[n] slot identity. No fixture state/register/global names were added.
- Parameter-name allocation now builds inherited-capture reserved names once per closure and advances one monotonic suffix counter instead of rebuilding/scanning a Set from v1 for every parameter.
- The former fresh-captured-closure mode is retired; the same simple captured-local fixture now reports fresh-closure-entry through the generic path.
- Parsed complex shared-capture fixture benchmark after cleanup: about 35.2 microseconds per solve over 30,000 solves; parsing excluded.
- Fresh CF, scheduler, VM state reachability, VM register naming, simple captured local, captured parameter, recursive empty-capture, and complex shared/forwarded capture runtime tests pass.


## Fresh CF: Writable Captured Variables

- Closure child rendering now recognizes writes through inherited captured cells: upvalueValues[upvalues[n]] = expr becomes an assignment to the resolved captured source binding name.
- The rule is structural: slot n is resolved through the current closure capture map; no state IDs, register IDs, variable names, or fixture values are hardcoded.
- Root/local-cell reads through upvalueValues[cellReg] now resolve back to the same captured source binding, which allows reading a shared mutable capture after child closures mutate it.
- Exact fixture local a=1; local f=function() a=a+1 end now recovers as local v1=1; local v2=function() v1=(v1+1) end.
- Shared writable-cell fixture with two closures mutating the same a by +1 and +10 recovers both closures against the same v1 and prints 12 at runtime.
- Normal binding analysis for the shared fixture reports 2 capture slots, 1 local cell, 1 shared cell, 6/6 upvalue accesses resolved, complete cell graph.
- Fresh CF, scheduler, VM state reachability, and VM register naming regressions pass with permanent writable and shared-writable capture cases.


## Fresh CF: Promotion-Only Source Locals

- Fresh register-local recovery now supports compiler `getVarRegister(..., potentialId)` promotion when an ordinary TEMP result register is promoted directly to a source VAR and `copyRegisters` emits no assignment because source/destination are the same physical register.
- Structural proof is cleanup-backed and conservative: a promoted local is declared directly from its own first/only non-nil definition only when that cleanup-backed register has exactly one non-nil definition in the leaf.
- This prevents pre-lifetime TEMP reuse from being misclassified as a source local. If the same cleanup-backed physical register has multiple non-nil definitions without an explicit ownership handoff, fresh CF still fails closed because the promotion boundary is not observable from emitted VM code alone.
- Real compiler fixture `local a,b,c=1,2,3; print(a,b,c)` produces promotion-only `r1 = 3` with no `r1 = temp` handoff and now recovers structurally; scheduler order yields `local v1=3; local v2=1; local v3=2; print(v2,v3,v1)`, preserving semantics.
- Original and recovered fixture both print `1 2 3`.
- Permanent positive regression covers promotion-only recovery; negative regression proves an earlier TEMP definition on the same cleanup-backed register remains fail-closed.
- Fresh CF, VM register scheduler, VM state reachability, and VM register naming regressions pass.


## Fresh CF: Unary Expressions

- Fresh symbolic rendering now supports parser UnaryExpression nodes for operators not, unary -, and #.
- Support is shared across one-state register/local recovery, closure-body recovery, and multi-state symbolic execution.
- Operands must already resolve structurally; unsupported/unresolved unary operators fail closed.
- Real compiler fixture local a=math.random(1,2); local s="abc"; print(not a,-a,#s) recovers as local v1=math.random(1,2); local v2="abc"; print((not v1),(-v1),(#v2)).
- Recovered fixture runtime prints false, a negative random value, and 3 as expected for the sampled run.
- Permanent regressions cover root/local unary rendering and unary expressions inside recovered closures.
- Fresh CF, VM register scheduler, VM state reachability, and VM register naming regressions pass.
