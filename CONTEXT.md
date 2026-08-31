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

`main.js` is a newer dirty local copy and can require `./passes/input-formatter`, which does not exist at the reset checkpoint. For reset-checkpoint tests, use committed `main.js` only with a guarded backup/restore.

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

Normal path:

```text
parse
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

Beta path:

```text
normal output
-> beta register versions
-> beta register lifetimes
-> beta upvalue recovery
-> beta control-flow structuring
-> structural Lua/Luau
```

Key files:

```text
passes/vm-state.js
passes/vm-bindings.js
passes/vm-register-scheduler.js
passes/vm-register-names.js
passes/beta-register-versions.js
passes/beta-register-lifetimes.js
passes/beta-upvalues.js
passes/beta-control-flow.js
```

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
