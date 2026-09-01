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
- End project turns exactly: `Done for this turn โ€” you can prompt now.`

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
