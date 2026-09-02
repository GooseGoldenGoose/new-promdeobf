# Prometheus Lua/Luau Deobfuscator - Authoritative Handoff

## Communication

Use caveman mode for project work:
- minimal/direct/technical
- short updates: `Found:`, `Fixed:`, `Tested:`, `Commit:`
- do the work instead of narrating obvious operations
- no filler, unnecessary questions, or repeated project history
- compact final unless explanation is requested
- end every project-related turn exactly:
  `Done for this turn — you can prompt now.`

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

## Current Fresh CF Capabilities

### Globals / expressions / locals
- direct global calls
- sequential global calls
- primitive/empty-table args
- arbitrary proven global member chains
- explicit source locals with cleanup-backed ownership handoff
- promotion-only locals when cleanup-backed physical register has exactly one non-nil definition
- ambiguous pre-lifetime TEMP reuse stays fail-closed
- binary/logical expressions
- unary `not`, unary `-`, `#`
- consumed call results are not duplicated as standalone calls

### Tables
Supports structurally resolved:
- array fields `{1,2,3}`
- keyed fields `{x=1}`
- dynamic keys `{[k]=v}`
- mixed array/keyed fields
- recursive nested constructors
- closures inside tables
- closures returning tables containing closures
- last-field multi-return expansion

Real broader-table proof recovered:
```lua
local v1 = 10
local t1 = { 1, 2, name = "hello", [v1] = 123, nested = { x = 5, 6, 7 } }
print(t1[1], t1[2], t1.name, t1[10], t1.nested.x, t1.nested[1])
```
Runtime parity: `1 2 hello 123 5 6`.

Nested function-in-table proof:
```lua
local t1 = { function()
    return { function()end }
end }
```
Runtime `type(t1[1]), type(t1[1]()[1])` -> `function function`.

Last-field RETURN_ALL proof:
source equivalent to:
```lua
local f = function() return 2,3,4 end
local t = {1, f()}
```
Fresh output preserves `{ 1, v1() }`; original and recovered both print `1 2 3 4`.

### RegisterOverflow virtual registers

Updated 2026-09-02: scalarization now runs in the normal canonical pipeline **before register scheduling**.

- physical VM locals are first presentation-named to collision-free `rN` / `ReturnVal`
- then every proven static `RegisterOverflow[N]` becomes scalar `oN`
- the dead `local RegisterOverflow = {}` bank declaration is removed
- scheduler therefore sees ordinary scalar identifiers `rN` and `oN` and applies the same dependency rules to both
- dynamic/nonconstant overflow indexes remain fail closed
- fresh CF still accepts old normal files containing `RegisterOverflow[N]` through its fallback scalarizer, but canonical new normal output already contains `oN`
- big opcode fixture proof: 128 overflow slots / 587 references scalarized before scheduling; scheduler still performs 678 dependency-safe swaps

### Multi-return / RETURN_ALL
- fixed multi-return -> grouped local declaration
- `{ f(...) }` + `unpack(pack)` final-argument form -> direct call
- contiguous uniquely owned slots only
- separated closure local into `pcall` multi-return supported
- VARARG/TCO forwarding supported for compiler shape `{ select(1, unpack(args)) } -> call(unpack(pack)) -> { unpack(ReturnVal) }`; recovered closure emits `function(...) return target(...) end`
- supports both direct/global forwarded calls and captured-function forwarding; preserves RETURN_ALL semantics

### Multi-state logical
- structural Prometheus `and/or` state-DAG recovery
- nested short-circuit chains
- path-local TEMP dropping at joins
- join merge is liveness-aware: unequal path temporaries are discarded only when proven unread before overwrite/exit; live unequal values still fail closed
- real full-pipeline TESTSET fixture `local ds = b or c` normalizes to 3 states and now recovers as `local v1 = (b or c)`
- fresh closure orchestration now supports a multi-state logical root subgraph plus independent child closure roots; the root TESTSET diamonds are flattened structurally before the existing closure/upvalue renderer runs
- multi-return pack recovery now supports scheduler-interleaved packs, overlapping pack creation/extraction, and slots cleaned before later slots are extracted, while preserving return-slot and call creation order
- ambiguity fails closed

### Closures / upvalues
- closure entry recovery from normalized child entry ID
- parameters from child `args[index]`, never randomized helper arity
- multiple returns
- recursive empty-capture closures
- effectful child calls
- read-only captures
- captured parameters
- multiple/shared/forwarded captures
- writable captured variables
- shared mutable captured cells
- root read after child mutation
- captured values callable as functions

Writable proof:
```lua
local v1 = 1
local v2 = function()
    v1 = (v1 + 1)
end
```

Shared writable proof: two closures mutate same cell by +1 and +10; runtime `12`.

Complex forwarding proof: root `a,b`, nested `c`, params `x,y`; deepest closure prints `10 20 30 40 50` and returns `150`.

### Namecall / method calls
Committed/pushed: `c61ddf2 Recover method calls`.

Compiler shape:
```lua
methodKey = "sub"
method = base[methodKey]
result = method(base, arg)
```
Often the key register is reused as method destination:
```lua
r1 = "sub"
r1 = r4[r1]
r5 = { r1(r4, r3) }
```

Canonicalization proof:
- track structural member provenance `{base, member}`
- if later call uses that exact method value and first resolved arg is the same base, emit `base:member(rest...)`
- otherwise preserve ordinary call semantics / fail closed
- `obj:method(x)` and explicit `obj.method(obj,x)` can compile identically, so colon syntax is a semantic canonical form, not guaranteed original punctuation
- derive member metadata before destination overwrite to handle key-register reuse

Proven:
- local: `local s="abc"; print(s:sub(2))` -> `local v1="abc"; print(v1:sub(2))`
- chained: `s:sub(2):upper()`
- inside recovered closure: `return v1:sub(2)` including child RETURN_ALL packing
- global base: `game:GetService("Players")`
- no hardcoded method/base names

Permanent regressions cover local, chained, and closure namecalls.
Post-commit verification 2026-09-01:
- fresh CF PASS
- scheduler PASS
- state reachability PASS
- register naming PASS

## Assignments / Field Writes

Implemented and tested in fresh CF.

Supported structurally:
- local field writes: `base.x = value`
- dynamic index writes: `base[key] = value`
- nested field writes such as `a.b.c = value`
- global writes through `_env["name"] = value` -> `name = value`
- writes through recovered closure parameters/captures when provenance proves a stable reference

Safety:
- literal identifier keys canonicalize to dot syntax
- dynamic keys stay bracket syntax
- no source-string call-shape regex
- write bases require structural stable-base provenance
- call-derived/effectful bases fail closed to avoid re-evaluation/side-effect duplication

Real compiler proofs:
```lua
local t = {}
t.x = 1
print(t.x)
```
->
```lua
local t1 = {}
t1.x = 1
print(t1.x)
```

```lua
local t = {}
local k = "x"
t[k] = 2
print(t[k])
```
->
```lua
local t1 = {}
local v1 = "x"
t1[v1] = 2
print(t1[v1])
```

```lua
local a = { b = { c = 1 } }
a.b.c = 123
print(a.b.c)
```
->
```lua
local t1 = { b = { c = 1 } }
t1.b.c = 123
print(t1.b.c)
```

Permanent regressions cover local/dynamic/global/captured writes plus fail-closed call-derived bases.

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


## Fresh-CF diagnostics

Updated 2026-09-02:
- unsupported multi-state failures now report normalized state count plus closure-root matcher detail
- closure-root diagnostics include the rejected state and last processed root statement text/index when available
- closure orchestration reports unconsumed normalized states when child-entry consumption is incomplete
- failing reduced opcode fixture now reports: 11 normalized states; state 1; root statement 57: `r16 = ReturnVal` instead of only `unsupported multi-state control flow`
- permanent regression verifies multi-state diagnostic includes state count/state/root statement context

## Full opcode matrix fresh-CF recovery

Updated 2026-09-02:
- exact canonical normal fixture `output/_tmp_opcode_matrix_full2.normal.lua` now recovers through fresh CF: 15 normalized states, 32 statements
- reduced fixture remains PASS: 11 states, 32 statements
- fixed scheduler-interleaved multi-return packs where a previous `ReturnVal` copy or upvalue bookkeeping crosses an incomplete pack
- dead trailing multi-return slots no longer force fake locals; dead slots before a live later slot synthesize positional locals so Lua multi-return indexing stays exact
- copied table-reference metadata now survives identifier copies and materializes one stable table local for later mutation/method use
- immediate anonymous recovered closures are parenthesized before calls
- pending-pack failures report pack/slot details
- final `r46` blocker was proven to be a logical-fallback TEMP: in the flattened root its nil definition fed synthesized `or` fallbacks after branch-state bridge reads were consumed
- logical flattening now substitutes only a proven reaching primitive fallback definition; the original assignment remains for normal lifetime analysis, so real cleanup-backed locals are still preserved
- logical renderer accepts proven identifier/primitive operands, enabling literal `nil` fallback without weakening arbitrary expression support
- permanent regressions cover previous-ReturnVal crossing, upvalue bookkeeping crossing, copied table identity, immediate closure calls, fully dead return packs, dead-leading/live-later pack slots, and primitive logical fallback temps
- generated full-matrix CF parses successfully and contains `print("PASSED")`; runtime parity was not used because the fixture depends on external globals/runtime behavior

## Latest test rule
Always validate user fixtures through the full canonical `main.js` pipeline with formatter enabled before fresh CF; proof runners that bypass formatting are not authoritative.
