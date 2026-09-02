# Prometheus Lua/Luau Deobfuscator — Authoritative Handoff

## Communication
Use caveman mode for project work:
- minimal/direct/technical
- short updates: `Found:`, `Fixed:`, `Tested:`, `Commit:`
- no filler or unnecessary questions
- end every project turn exactly:
  `Done for this turn — you can prompt now.`

## Workspace / Git
Workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repo:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Branch: `main`

Current authoritative commit:
`51e9f5b Restore nil-lifetime CF baseline`

Core fresh-CF behavior was restored to:
`7375421 Refine nil register lifetimes`

Kept on top:
- RegisterOverflow scalarization/integration
- improved fresh-CF diagnostics from `05f351b`

Before project changes:
1. read this file completely
2. run `git status --short --branch`
3. run `git log -5 --oneline`
4. preserve unrelated dirty/untracked work

After meaningful tracked changes:
- update this file only with current authoritative facts
- stage only task-related files
- focused commit
- push `origin/main`

Known unrelated tracked user changes — preserve:
- `formater/input.txt`
- `main.js`

Do not clean unrelated untracked/temp files unless explicitly asked.

## Core Rules
- dynamic/structural only
- never hardcode register IDs, state IDs, globals, methods, fixture values, etc.
- correctness first; fail closed when proof is incomplete
- preserve evaluation order, side effects, multi-return, source-local lifetime, table identity, upvalues, closure captures, and method self
- do not use cosmetic cleanup to hide a structural mistake

## Active Pipeline
Normal pipeline:
```text
formatter
-> parse
-> constant array recovery
-> environment recovery
-> closure/helper recovery
-> safe parallel assignment split
-> VM state recovery
-> VM binding/provenance analysis
-> VM register naming
-> RegisterOverflow scalarization
-> VM register scheduler
-> normal output
```

Fresh CF:
```text
normal output source + AST
-> passes/beta-control-flow.js
-> structural Lua/Luau
```

Active fresh-CF files:
- `passes/beta-control-flow.js`
- `tools/beta-control-flow.js`
- `tools/test-beta-control-flow-fresh.js`

## Compiler Authority
Compiler workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`

Compiler source:
`src\prometheus\compiler\compiler.lua`

Run:
`luajit cli.lua --preset Medium <fixture>`

Important compiler facts:
- `allocRegister(false)` allocates TEMP registers
- `allocRegister(true)` allocates source VAR registers
- `getVarRegister(..., potentialId)` can promote an ordinary TEMP directly into a source VAR
- POS/state and ReturnVal cannot be promoted; compiler copies into a VAR instead
- normal TEMP registers are freed internally
- source VAR lifetime ends with cleanup (`reg = nil`) or upvalue release bookkeeping, then force-free
- physical registers can be reused for unrelated lifetimes
- compiler scheduling can reorder dependency-independent instructions
- method/self lowering loads `base[key]` then calls that function with the original base as arg1

## Current Fresh-CF State
Fresh CF is back to the behavior of `7375421 Refine nil register lifetimes`.

Do not revive the later broken rebuilds from commits after `7375421` unless explicitly requested.

RegisterOverflow support remains active and tested.

Improved diagnostics remain active. Unsupported multi-state failures can report:
- normalized state count
- closure recovery reason
- state ID
- root statement index/text
- unconsumed states

## Verified Working Cases After Restore
Fixed-arg closure:
```lua
local a = function(x)
    return x
end
print(a)
```
Recovers as:
```lua
local v1 = function(v1)
    return v1
end
print(v1)
```

Vararg closure:
```lua
local a = function(...)
    return ...
end
print(a)
```
Recovers as:
```lua
local v1 = function(...)
    return ...
end
print(v1)
```

Table reassignment + method call:
```lua
local a = {}
a = {1,2}
a = {se=function()end}
a:se()
```
Recovers as:
```lua
local t1 = {}
t1 = { 1, 2 }
t1 = { se = function()end }
t1:se()
```

## Tests Last Verified
PASS:
- `node tools/test-beta-control-flow-fresh.js`
- `node tools/test-vm-register-overflow.js`
- `node tools/test-vm-register-scheduler.js`
- `node tools/test-vm-state-reachability.js`
- `node tools/test-vm-register-names.js`
- `git diff --check`

Also verified after restore:
- fixed-arg closure fresh CF PASS
- vararg closure fresh CF PASS
- table reassignment/namecall fresh CF PASS

## Important Warning
Do not treat “fresh CF applied” or “output parses” as semantic correctness by itself. Compare recovered source shape against compiler behavior and expected source semantics.

Do not repeat the later post-`7375421` rebuild that incorrectly regressed existing closure/table recovery.
