# Prometheus Lua/Luau Deobfuscator - Authoritative Handoff

## Communication

Use caveman mode for project work:
- minimal/direct/technical
- short updates: `Found:`, `Fixed:`, `Tested:`, `Commit:`
- do the work instead of narrating obvious operations
- no filler, unnecessary questions, or repeated project history
- compact final unless explanation is requested
- end every project-related turn exactly:
  `Done for this turn � you can prompt now.`

## Workspace / Git

Workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repo:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Branch: `main`

Fresh rebuild baseline:
`7c3678acf52d47134388db1f755da9dcddf99e3e`

Latest committed/pushed feature commits:
- `c61ddf2 Recover method calls`
- `00f04b1 Recover broader table constructors`
- `4684a29 Recover unary expressions`
- `693f27d Recover promotion-only locals`
- `473bcb6 Recover writable captured variables`
- `1bbd182 Unify dynamic capture recovery`
- `42b440f Recover shared forwarded captures`
- `3be9247 Recover captured closure parameters`

Before project changes:
1. read this file completely
2. `git status --short --branch`
3. `git log -5 --oneline`
4. preserve unrelated dirty/untracked work

After meaningful tracked changes:
- update/compact this file
- stage only task files
- focused commit
- push `origin/main`

Known unrelated tracked user dirt - preserve:
- `M formater/input.txt`
- `M main.js`

Known untracked areas/files - preserve unless explicitly asked:
- `--output`, `--output-dir/`
- `_proof-main.js`, `_tmp-main-reset.js`, `_tmp-proof-main.js`
- `opt/`, `opti/`, `tmp/`
- generated sample files, `sample/pre-cf/`
- `passes/_tmp-*`, `tools/_tmp-*`

Never clean/stage unrelated work blindly.

## Goal / Core Rules

Goal:
`Prometheus VM -> recover registers/upvalues/control flow -> understandable structural Lua/Luau`

Rules:
- dynamic/structural only
- no hardcoded state IDs, register IDs, variable names, methods, globals, services, or fixture values
- correctness first; fail closed when proof is incomplete
- preserve evaluation order, side effects, calls, multi-return, lexical scope, captures/upvalues, self/namecall semantics, loop frequency, break/continue/return
- do not revive abandoned aggressive optimizer-era work unless explicitly requested

## Compiler Authority

Compiler workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`

Compiler source:
`src\prometheus\compiler\compiler.lua`

Run:
`luajit cli.lua --preset Medium <fixture>`

Important facts:
- `MAX_REGS=100`, `MAX_REGS_MUL=0`
- special registers include POS/state, RETURN/ReturnVal, VAR, RETURN_ALL, UPVALUE
- `allocRegister(false)` priority: POS -> RETURN -> lowest ordinary register
- `allocRegister(true)` allocates source VAR
- normal `freeRegister` does not free VAR; force-free ends source lifetime
- `getVarRegister(..., potentialId)` can promote an ordinary TEMP directly to VAR without a copy
- `copyRegisters` emits only when physical source != destination
- physical registers are reusable across independent lifetimes
- captured locals use `allocUpvalue`, `upvalueValues[...]`, capture tables, `releaseUpvalue`
- compiler statement scheduling may reorder dependency-independent instructions
- `PassSelfFunctionCallExpression` evaluates base once, loads `base[key]`, then calls that function with the original base as argument 1

## Active Pipeline

Normal:
```text
format input with formater/luau-format.exe --luraph
-> parse
-> constant-array recovery
-> environment recovery
-> closure-factory recovery
-> VM helper semantic naming
-> safe parallel-assignment splitting
-> VM state/CFG recovery
-> VM binding/capture/provenance analysis
-> VM register presentation naming (`rN` / `ReturnVal`)
-> RegisterOverflow scalarization (`RegisterOverflow[N]` -> `oN`)
-> VM register scheduler
-> normal output
```

Fresh beta:
```text
normal output source + AST
-> passes/beta-control-flow.js
-> structural Lua/Luau
```

Fresh CF does not consume retired beta register-version analysis and does not fall back to old CF.

Preserve old files unless explicitly asked:
- `passes/beta-control-flow-old.js`
- `passes/beta-register-versions-old.js`
- `tools/beta-register-versions-old.js`

Active files:
- `passes/beta-control-flow.js`
- `tools/beta-control-flow.js`
- `tools/test-beta-control-flow-fresh.js`

## Register / Lifetime Model

A physical `rN` is not one source binding.
Conceptually:
```text
rN -> CFG/reaching-definition lifetime/value identity -> logical binding
```

Same proven lifetime stays one binding. Independent reuse is separate. Ambiguous merge fails closed.

Presentation:
- value locals: `v1`, `v2`, ...
- table locals: `t1`, `t2`, ...
- counters are independent
- original identifiers are generally unrecoverable

## Current Fresh CF Baseline

Reset 2026-09-02 by user request to the minimal proven `print(1)` solver from commit `2567c29`.

Fresh CF currently supports only the direct one-state global-call proof shape used by:
```lua
print(1)
```

Do not re-add locals/tables/closures/multi-return/control-flow recovery until compiler register ownership is rebuilt from first principles.

Key compiler proof from real Prometheus output:

`print(1)`:
```lua
r1 = 1
ReturnVal = print(r1)
-- no r1 = nil
```
`r1` is a TEMP.

`local a = 1; print(a)`:
```lua
state = 1
r2 = state
ReturnVal = print(r2)
r2 = nil
```
`r2` is a source VAR. Its scope-end `= nil` is compiler lifetime cleanup.

Compiler source rule:
- local declarations compile RHS first to expression registers
- `getVarRegister(scope,id,depth,potentialId)` may promote an ordinary RHS TEMP directly to `VAR_REGISTER`
- POS/state and RETURN registers cannot be promoted, so compiler copies into a VAR register instead
- `copyRegisters` emits nothing when promoted source register already equals destination register
- normal `freeRegister(reg,false)` does not free a VAR register
- scope exit emits `varReg = nil` (or release-upvalue bookkeeping) then `freeRegister(varReg,true)`

Therefore source-local proof must track register ownership/lifetime, not merely "has a nil somewhere" or "value was read". TEMP operations must not be promoted to source locals just to make a fixture pass.

Table opcode examples to revisit only after local ownership is proven:
```lua
_table[_kst] = _nil
local ds = _table[_kst]
_table["Index"] = _nil
local ds = _table["Index"]
_table[1] = _nil
local ds = _table[1]
_table = { ["SELFCALL"] = function() end }
_table:SELFCALL()
```
## VM register scheduler: dead args snapshots

Updated 2026-09-01:
- proven VM bookkeeping copies like `rN = args` may sink despite a later lifetime-cleanup anchor on the same physical register
- they may cross unrelated lifetime-boundary cleanups only when normal RAW/WAR/WAW dependency checks permit it
- they still stop before their own read/overwrite and before the terminal `ReturnVal = {}; state = nil` tail
- verified on 3 independent Prometheus obfuscations of `local a,b,c`: dead args snapshot sinks immediately before terminal return bookkeeping
- scheduler/fresh-CF/state-reachability/register-naming regressions pass

## LOADNIL / nil-only locals

Implemented 2026-09-01 in fresh CF for proven nil-only source lifetimes.

- `local a,b,c` now recovers as three separate locals with no initializer.
- Handles Prometheus nil production through direct `rN = nil`, borrowed `state = nil; rN = state`, and `ReturnVal = nil; rN = ReturnVal`.
- Later `rN = nil` lifetime cleanup is still omitted.
- Nil classification now follows compiler ownership behavior more closely: Prometheus TEMP registers are freed internally, while source VAR lifetimes receive explicit scope-end `= nil` cleanup.
- A live nil definition (read before overwrite) is preserved as a source nil lifetime.
- A nil-only register with a later nil cleanup and no non-nil definitions is preserved as a nil-only source local.
- A single unobserved nil definition is dropped as dead TEMP/register state; an unobserved initial nil followed by exactly one meaningful definition is also dropped so the meaningful definition can establish the cleanup-backed source lifetime.
- Cleanup-backed registers with multiple meaningful pre-lifetime definitions remain fail-closed because TEMP-to-VAR ownership cannot be proven.
- Permanent regressions cover dead single nil removal, nil-before-one-value promotion, nil-only locals, and ambiguous TEMP reuse.
- Verified across 3 independent Prometheus obfuscations of `local a,b,c`; all produce `local v1`, `local v2`, `local v3`.

## VM state root constant expressions

Updated 2026-09-01:
- Prometheus Numbers To Expressions can leave root/closure entry state IDs as constant arithmetic ASTs such as `8728071 - 436750`, not only NumericLiteral nodes.
- `numericValue()` now evaluates only proven safe-integer constant arithmetic (unary minus; +, -, *, exact /, Lua-style %, nonnegative ^) and fails closed otherwise.
- root-entry discovery accepts all structurally recognized `createClosureN` factory names, matching nested closure-entry discovery.
- normalized direct-and/or branch target rewrites preserve parentheses so `cond and(<expr>) or (<expr>)` cannot become invalid `and2` tokenization.
- Full no-generic-for opcode fixture now reaches VM state recovery: 15/15 reachable states normalized, 10 reachable closure entries, scheduler and register naming apply.
- Fresh CF then stops later at genuine unsupported multi-state control flow; state recovery is no longer the blocker.

## Fresh-CF nested constant arithmetic

Updated 2026-09-01:
- Prometheus Numbers To Expressions can randomize LOADK-like scalar constants into nested arithmetic expressions inside otherwise one-state VM leaves.
- Fresh CF previously rendered binary expressions only when both operands were identifiers/registers, making the same source randomly pass with `rN = 1` and fail with `rN = -989881 + (194066 - ...)`.
- `matchLocalRegisterProgram()` now recursively renders BinaryExpression operands while keeping LogicalExpression handling restricted to the existing proven identifier shape.
- Exact one-state opcode fixture now recovers again as `fresh-register-locals`, 1 state, 48 statements.
- Added a regression covering nested compiler arithmetic constants so randomized Prometheus output cannot regress this again.

## Canonical initial local ordering

Implemented 2026-09-01 in fresh CF as presentation-only cleanup for prefixes containing nil-only locals.

- Prometheus compiler randomly shuffles dependency-independent VM statements, so exact original declaration order is not recoverable.
- Fresh CF now canonically reorders only the initial prefix of proven-simple local declarations when that prefix contains nil-only locals.
- Supported reorderable forms are nil-only declarations, primitive constants, direct global bindings, and simple member chains.
- Dependencies are topologically preserved; member-derived locals remain after their base.
- No declaration moves across the first non-simple/non-local/effectful statement.
- Constant-only programs keep their previous recovered ordering; this avoids broad presentation churn.
- Generated variable numbers are not renumbered by this pass, avoiding unsafe cross-scope renaming.
- Opcode matrix now groups globals/member loads -> constants -> all nil-only locals before NEW_GLOBAL.

## Remaining Feature Order

After assignments + field/index writes:
1. varargs
2. real control flow:
   - if
   - while
   - repeat
   - numeric for
   - generic for
   - break
   - continue
   - nesting

Additional audits when useful:
- deeper capture mutation/alias corner cases
- method-call ambiguity negative cases
- table side-effect/evaluation-order edge cases

## spacial6

Large fixture:
`sample/spacial6.txt` (~6.65 MB raw; normal output historically ~8.87 MB)

Earlier blocker was unresolved upvalue lifecycle around `releaseUpvalue`. Upvalue support has advanced substantially, but spacial6 has NOT been proven fixed after current capture/table/method changes. Do not claim fixed without rerunning.

## Testing Standard

For structural features:
1. inspect compiler if relevant
2. tiny readable source
3. obfuscate with local compiler
4. normal deobf through active `main.js`
5. fresh CF
6. inspect normalized VM/provenance
7. runtime parity where possible
8. focused positive regression
9. negative fail-closed regression when ambiguity matters
10. run:
   - `node tools/test-beta-control-flow-fresh.js`
   - `node tools/test-vm-register-scheduler.js`
   - `node tools/test-vm-state-reachability.js`
   - `node tools/test-vm-register-names.js`
   - `git diff --check`
11. broader fixtures/spacial6 when relevant
12. update/compact CONTEXT
13. focused commit + push

Never claim compiler behavior until actual compiler source/output proves it.
Never hardcode a fixture pattern just to clean output later.


## Latest test rule
Always validate user fixtures through the full canonical `main.js` pipeline with formatter enabled before fresh CF; proof runners that bypass formatting are not authoritative.

## Fresh CF owned table local rebuild

Updated 2026-09-02:
- first post-reset feature rebuilt from compiler register ownership, not old heuristic local promotion
- compiler proof: source VAR is cleanup-backed and may be established by POS/Return transport copy or direct TEMP promotion; ordinary TEMP has no scope-end cleanup
- fresh CF now has a narrow table-local matcher that requires exactly one cleanup-backed root VAR, proves its first ownership handoff, requires every recovered assignment on that VAR to remain table-valued, and fails closed otherwise
- supports table constructor reassignment on the same source local plus an empty child closure used as a keyed table field and Prometheus SELF lowering (`base[key]` then call with `base` as arg1)
- exact source `local a = {}; a = {1,2}; a = {se=function()end}; a:se()` recovers as `local t1 = {}; t1 = { 1, 2 }; t1 = { se = function() end }; t1:se()`
- verified through canonical formatter/normal pipeline and 3 independent randomized Prometheus Medium obfuscations; all recovered identically
- permanent regression covers the owned table VAR + reassignment + empty closure + namecall shape
- minimal `print(1)` direct-call solver remains intact; unsupported shapes still fail closed