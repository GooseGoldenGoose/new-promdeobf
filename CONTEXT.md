# Prometheus Lua/Luau Deobfuscator — Authoritative Handoff

## Communication / Turn Rule

Use **caveman mode** for project work:
- minimal/direct/technical
- short updates: `Found:`, `Fixed:`, `Tested:`, `Commit:`
- do the work; no filler or repeated history
- no unnecessary questions when enough context exists
- compact final unless explanation requested
- end every project-related turn **exactly**:
  `Done for this turn — you can prompt now.`

## Workspace / Git

Workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repo:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Branch: `main`

Reset baseline used for the current fresh rebuild:
`7c3678acf52d47134388db1f755da9dcddf99e3e`

Latest committed/pushed feature commits before current WIP:
- `00f04b1 Recover broader table constructors`
- `4684a29 Recover unary expressions`
- `693f27d Recover promotion-only locals`
- `473bcb6 Recover writable captured variables`
- `1bbd182 Unify dynamic capture recovery`
- `42b440f Recover shared forwarded captures`
- `3be9247 Recover captured closure parameters`

Before changing project code:
1. Read this file completely.
2. `git status --short --branch`
3. `git log -5 --oneline`
4. Preserve unrelated dirty/untracked files.

After meaningful tracked changes:
- update/compact this file; remove stale contradictions
- stage only task files
- focused commit
- push `origin/main`

Known unrelated tracked user dirt — preserve:
- `M formater/input.txt`
- `M main.js`

Known untracked areas/files — preserve unless explicitly asked:
- `--output`, `--output-dir/`
- `_proof-main.js`, `_tmp-main-reset.js`, `_tmp-proof-main.js`
- `opt/`, `opti/`, `tmp/`
- `sample/pre-cf/`, generated sample files
- `passes/_tmp-*`, `tools/_tmp-*`

Never stage/clean unrelated work blindly.

## Goal / Rules

Goal:
`Prometheus VM -> recover registers/upvalues/control flow -> understandable structural Lua/Luau`

Rules:
- dynamic/structural only
- no hardcoded state IDs, register IDs, names, methods, globals, services, or fixture values
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
- special registers: POS/state, RETURN/ReturnVal, VAR, RETURN_ALL, UPVALUE
- `allocRegister(false)` priority: POS -> RETURN -> lowest ordinary register
- `allocRegister(true)` allocates source VAR
- normal `freeRegister` does not free VAR; force-free ends source lifetime
- `getVarRegister(..., potentialId)` can promote an ordinary TEMP directly to VAR without a copy
- `copyRegisters` emits only when physical source != destination
- physical registers are reused across independent lifetimes
- captured locals use `allocUpvalue`, `upvalueValues[...]`, capture tables, `releaseUpvalue`
- compiler block scheduler can reorder independent statements
- `PassSelfFunctionCallExpression` evaluates base once, gets `base[key]`, then calls that function with the original base inserted as argument 1

## Active Pipeline

Normal:
```text
format with formater/luau-format.exe --luraph
-> parse
-> constant array recovery
-> environment recovery
-> closure-factory recovery
-> VM helper semantic naming
-> safe parallel-assignment splitting
-> VM state / CFG recovery
-> VM binding/capture/provenance analysis
-> VM register scheduler
-> VM register presentation naming
-> normal output
```

Fresh beta:
```text
normal output source + AST
-> passes/beta-control-flow.js
-> structural Lua/Luau
```

Fresh CF does **not** consume retired beta register-version analysis and does **not** fall back to old CF.

Preserve old files unless explicitly asked:
- `passes/beta-control-flow-old.js`
- `passes/beta-register-versions-old.js`
- `tools/beta-register-versions-old.js`

Active files:
- `passes/beta-control-flow.js`
- `tools/beta-control-flow.js`
- `tools/test-beta-control-flow-fresh.js`

## Register / Lifetime Model

Physical `rN` is not one source binding.
Conceptually:
```text
rN -> CFG/reaching-definition lifetime/value identity -> logical binding
```

Same proven lifetime stays one binding; independent reuse is separate. Ambiguous merge fails closed.

Presentation names:
- ordinary/value locals: `v1`, `v2`, ...
- proven table locals: `t1`, `t2`, ...
- counters independent
- original source identifiers are generally unrecoverable

## Current Fresh CF Capabilities

### One-state / expressions / locals
- direct global calls
- sequential global calls
- primitive and empty-table args
- global member chains of arbitrary proven depth
- source locals with explicit ownership handoff + cleanup
- promotion-only locals when cleanup-backed physical register has exactly one non-nil definition
- pre-lifetime TEMP reuse stays fail-closed when promotion boundary is ambiguous
- binary/logical symbolic expressions
- unary `not`, unary `-`, `#`
- consumed call results are not duplicated as standalone side effects

### Tables
Supports structurally resolved:
- array fields: `{1,2,3}`
- keyed fields: `{x=1}`
- dynamic keys: `{[k]=v}`
- mixed ordered/keyed fields
- nested constructors, arbitrary supported nesting depth
- closures inside tables
- closures returning tables containing closures
- last-field multi-return expansion, proven with:
  `local t = {1, f()}` where `f()` returns `2,3,4`
  -> runtime `1 2 3 4`

Exact broader-table real fixture recovered:
```lua
local v1 = 10
local t1 = { 1, 2, name = "hello", [v1] = 123, nested = { x = 5, 6, 7 } }
print(t1[1], t1[2], t1.name, t1[10], t1.nested.x, t1.nested[1])
```
Runtime parity: `1 2 hello 123 5 6`.

### Multi-return / RETURN_ALL
- fixed multi-return calls -> grouped local declarations
- packed `{ f(...) }` + `unpack(pack)` final-argument form -> direct call
- return slots contiguous from 1 and uniquely owned
- separated closure local into `pcall` multi-return supported

### Multi-state logical chains
- structural Prometheus `and/or` state DAG recovery
- nested short-circuit chains
- path-local TEMP dropping at joins
- ambiguity fails closed

### Closures / upvalues
- closure entry recovery from normalized child entry IDs
- source params from child `args[index]`, not randomized helper arity
- multiple returns
- recursive empty-capture closures
- effectful calls inside closures
- read-only captures
- captured parameters
- multiple/shared/forwarded captures across supported nested closure depth
- writable captured variables
- shared mutable captured cell across multiple closures
- root reads after child mutation
- captured value can itself be called as a function

Example writable capture recovered:
```lua
local v1 = 1
local v2 = function()
    v1 = (v1 + 1)
end
```

Shared mutable proof: two closures mutate same capture by +1 and +10; runtime `12`.

Complex forwarded-capture proof:
root captures `a,b`, nested local `c`, params `x,y`; deepest closure prints `10 20 30 40 50` and returns `150`.

## Namecall / Method Calls — CURRENT WIP (UNCOMMITTED)

**Important:** `passes/beta-control-flow.js` and `tools/test-beta-control-flow-fresh.js` are currently modified/uncommitted for this feature. Do not assume this work is committed. Inspect diff/status first.

Compiler proof:
`PassSelfFunctionCallExpression` becomes structurally:
```lua
methodKey = "sub"
method = base[methodKey]
arg = 2
result = method(base, arg)
```
Often the key register is reused as method destination:
```lua
r1 = "sub"
r1 = r4[r1]
r5 = { r1(r4, r3) }
```

Critical fact:
`obj:method(x)` and explicit `obj.method(obj, x)` can compile to the same normalized VM shape. Original colon-vs-dot syntax is therefore not always uniquely recoverable. Current intended canonicalization is semantic: if provenance proves `method = base[literalMember]` and call argument 1 is the same resolved base, emit `base:member(rest...)`.

WIP implementation added:
- root/local `exprMeta` member provenance `{kind:"member", base, member}`
- member metadata is computed **before** overwriting the destination, required for key-register reuse
- call renderer emits colon syntax only if first resolved argument equals the recorded base
- closure `envMeta` equivalent
- closure RETURN_ALL support for method calls via single-call pack metadata

Proven manually with current uncommitted WIP:
1. Local namecall:
   source: `local s="abc"; print(s:sub(2))`
   recovered:
   ```lua
   local v1 = "abc"
   print(v1:sub(2))
   ```
2. Chained namecall:
   source: `local s="abc"; print(s:sub(2):upper())`
   recovered:
   ```lua
   local v1 = "abc"
   print(v1:sub(2):upper())
   ```
3. Closure-returned namecall:
   source: `local f=function(s) return s:sub(2) end; print(f("abc"))`
   recovered:
   ```lua
   local v1 = function(v1)
       return v1:sub(2)
   end
   print(v1("abc"))
   ```
4. Global base was already supported before this WIP:
   source: `game:GetService("Players")`
   recovered exactly:
   `game:GetService("Players")`

Current uncommitted test additions cover:
- local namecall
- chained local namecall
- closure namecall

**Next action after opening a new chat:**
1. inspect the uncommitted diff
2. run `node tools/test-beta-control-flow-fresh.js`
3. run standard VM regressions
4. test runtime parity for non-Roblox string namecalls (`sub`, `upper`)
5. consider a negative/ambiguity regression so a method value called with a different first arg does not become colon syntax
6. if all pass, update this section from WIP -> committed, commit only `passes/beta-control-flow.js`, `tools/test-beta-control-flow-fresh.js`, `CONTEXT.md`, push

## Known Gaps / Feature Order

After namecall/method-call work:
1. assignments + field/index writes
2. varargs
3. real control flow:
   - if
   - while
   - repeat
   - numeric for
   - generic for
   - break
   - continue
   - nesting

Potential additional edge auditing:
- deeper mutation/alias corner cases for captures
- method-call ambiguity/canonicalization negative cases
- broader table side-effect ordering cases if new compiler shapes appear

## spacial6

Large fixture:
`sample/spacial6.txt` (~6.65 MB raw; normal output historically ~8.87 MB)

Earlier blocker was unresolved upvalue lifecycle around `releaseUpvalue`. Upvalue support has advanced substantially since then, but **spacial6 has not been proven fixed after the latest capture/table/namecall changes**. Do not claim fixed without rerunning.

## Testing Standard

For a structural feature:
1. inspect compiler if relevant
2. tiny readable source
3. obfuscate with local compiler
4. normal deobf via active `main.js`
5. fresh CF
6. inspect normalized VM shape / provenance
7. runtime parity where possible
8. add focused positive regressions
9. add negative fail-closed regression when ambiguity matters
10. run:
   - `node tools/test-beta-control-flow-fresh.js`
   - `node tools/test-vm-register-scheduler.js`
   - `node tools/test-vm-state-reachability.js`
   - `node tools/test-vm-register-names.js`
   - `git diff --check`
11. run broader fixtures/spacial6 when relevant
12. update/compact CONTEXT
13. focused commit + push

Never claim compiler behavior until actual compiler source/output proves it.
Never hardcode a fixture pattern just to clean output later.
