# Prometheus Lua/Luau Deobfuscator - Authoritative Context

This file is the authoritative handoff for this project. Read it completely before project work. Keep it current. Replace stale facts instead of appending contradictory history.

## 0. New Chat Bootstrap - Read This First

This file MUST be sufficient for a brand-new chat with no useful prior conversation memory. A new chat should be able to read this file once and continue the project without asking the user to repeat project history, architecture, compiler behavior, workflow, or current decisions.

On a new chat:
1. Read ALL of `CONTEXT.md` before changing project files.
2. Treat this file as authoritative over remembered/guessed prior-chat details.
3. Run `git status --short --branch` and `git log -5 --oneline`.
4. Inspect the actual current implementation before editing.
5. If this file and code disagree, do NOT silently choose one: inspect Git history/compiler source/tests, determine the current truth, then update this file.
6. Do not ask the user to re-explain facts already recorded here.
7. Do not assume old experimental branches/features still exist just because a prior chat discussed them. Current tracked code + this handoff define reality.

A new chat should understand from this file alone:
- user communication/workflow rules
- repository and compiler-material paths
- exact project goal and semantic safety requirements
- how the Prometheus compiler turns source into VM states/register operations
- TEMP vs VAR vs POS vs RETURN vs overflow storage
- source-local promotion, reassignment, cleanup, and captured-local behavior
- globals, calls, method calls, tables, indexing, multi-return, varargs, closures and upvalues
- compiler control-flow templates for if/and/or/loops/break/continue/return
- every active normal-deobfuscation stage and why it exists
- how normalized state recovery and register scheduling work
- how fresh CF performs structural pattern reversal + semantic proof
- what fresh CF currently supports and what remains fail-closed
- how to build tiny compiler fixtures and verify new theories
- current Git/context maintenance rules and known unrelated dirty files

Do not depend on hidden chat context for any durable project fact. When a new durable fact is learned, write it here in the appropriate existing section and remove/update stale contradictory text.

Current intended baseline:
- branch: `main`
- fresh-CF behavior is the restored nil-lifetime baseline from commit `51e9f5b`, with RegisterOverflow support retained and improved diagnostics retained
- later context-only commits do not change solver behavior
- unrelated tracked user edits in `main.js` and `formater/input.txt` must be preserved unless explicitly requested otherwise

## 1. Communication Rules - Caveman Mode

For project work:
- talk as little as possible
- be direct and technical
- do the work instead of narrating obvious file/shell operations
- short progress updates only when useful
- preferred labels: `Found:`, `Fixed:`, `Tested:`, `Commit:`
- no filler
- no unnecessary questions when enough information exists
- do not repeat project history already written here
- if something is wrong, state exactly what is wrong
- if the user asks `why` or asks for explanation, then explain the technical reason in detail
- final summary should be compact unless the user asks for detail

Every project-related turn MUST end exactly with:

`Done for this turn - you can prompt now.`

### 1.1 Strict Task Confirmation / Scope Lock

Before doing any user-requested project task that would inspect, test, modify, or run project code:
- first state exactly what you are going to do in this turn
- include the concrete files/areas/actions that are in scope when known
- explicitly state what you will NOT do if there is a meaningful nearby risk of scope expansion
- do not begin implementation/testing beyond harmless context/status reading until that scope statement has been shown to the user

Once the scope is stated, it is locked for that turn:
- do ONLY the requested work inside that stated scope
- do not opportunistically fix, refactor, optimize, clean up, rename, or change anything outside it
- if you discover another bug, unsupported case, regression, architectural issue, or cleanup opportunity outside the locked scope, STOP expanding work and report it to the user
- do not fix the newly discovered issue unless the user explicitly asks for it in a later prompt
- if the requested task itself cannot be completed without expanding scope, stop at that boundary, explain exactly what blocks it, and wait for a new user instruction
- tests may reveal unrelated failures; report them, but do not repair them unless they are part of the locked task

This rule overrides the normal tendency to continue fixing newly discovered related issues. Scope discipline is mandatory.
## 2. Mandatory Turn Workflow

At the beginning of every project turn:
1. Read `CONTEXT.md` completely.
2. Run `git status --short --branch`.
3. Run `git log -5 --oneline`.
4. Inspect current relevant files before changing them.
5. Preserve unrelated dirty/untracked user work.

During work:
- update `CONTEXT.md` whenever meaningful implementation knowledge, compiler behavior, supported behavior, unsupported behavior, architectural decisions, or test results change
- do not leave context stale until many turns later
- compact/remove superseded notes instead of keeping contradictory versions
- inspect the actual Prometheus compiler/obfuscator whenever a compiler pattern is uncertain
- do not guess compiler behavior from one output when compiler source can prove it
- test tiny readable source fixtures through the real compiler and real deobfuscator when a pattern matters

After meaningful tracked changes:
1. run focused tests
2. run broader regressions relevant to the change
3. run `git diff --check`
4. update/compact `CONTEXT.md`
5. stage ONLY files belonging to the current change
6. make a focused commit
7. push `origin/main`

Git should be updated constantly: meaningful self-contained project changes should not accumulate uncommitted across many unrelated tasks. Context should also be updated constantly.

Do NOT commit temporary probes/generated outputs unless explicitly requested.

## 3. Workspace / Repository / Material Paths

Deobfuscator workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repository:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Branch:
`main`

Prometheus obfuscator/compiler workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`

Primary compiler source:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf\src\prometheus\compiler\compiler.lua`

Obfuscate a fixture with:
`luajit cli.lua --preset Medium <fixture.lua>`

Important current unrelated tracked user changes - preserve unless user explicitly says otherwise:
- `formater/input.txt`
- `main.js`

There are many untracked generated/probe files in the repo. Never mass-clean them blindly.

## 4. Project Goal and Correctness Rules

Goal:
`Prometheus VM output -> normalized VM -> proven source-level Lua/Luau structure`

The deobfuscator must be dynamic/structural.

Never hardcode:
- physical register numbers
- normalized register numbers
- VM state IDs
- random Prometheus block IDs
- fixture-specific constants
- method names
- global names
- service names
- source variable names
- closure entry IDs

Core correctness requirements:
- preserve evaluation order
- preserve side effects
- preserve call order and call count
- preserve Lua/Luau multiple-return behavior
- preserve last-expression expansion semantics
- preserve table/reference identity
- preserve method-call `self`
- preserve lexical scope/lifetime
- preserve closure captures/upvalue identity
- preserve mutation semantics
- preserve loop frequency and control-flow semantics
- preserve `break`, `continue`, and `return`
- fail closed when proof is incomplete

A pretty output that changes semantics is a bug. Do not use cosmetic cleanup as a substitute for understanding the compiler pattern.

## 5. High-Level Architecture

The project has two major deobfuscation layers.

### Layer A - Normal VM normalization (`main.js` + passes)

Purpose:
Turn randomized Prometheus wrapper/VM code into a stable, semantically named VM representation while preserving behavior.

Approximate active flow:

```text
input
-> formatter
-> parse
-> constant-array recovery
-> environment binding recovery
-> closure-factory recovery
-> VM helper semantic naming
-> helper/local semantic naming
-> safe parallel-assignment splitting
-> VM state/CFG recovery + state-ID normalization
-> optional VM binding/lifetime diagnostics
-> VM scalar register presentation naming
-> RegisterOverflow scalarization
-> VM register scheduling/canonicalization
-> normal output
```

### Layer B - Fresh control-flow/source recovery (`passes/beta-control-flow.js`)

Purpose:
Take the normalized VM and reverse proven Prometheus compiler patterns into understandable Lua/Luau source constructs.

Fresh CF does NOT simply remove the dispatcher or regex-match text. It recognizes compiler-generated AST/register/state patterns, follows value flow, proves ownership/lifetime/capture/evaluation-order facts, and emits source only when the full shape is safe.

The user's description - "identify pattern and recover the register-created pattern" - is fundamentally correct, with this refinement:

> A CF pattern is a structural compiler pattern plus semantic proof, not merely a textual pattern.

For example, seeing `r3 = nil` is not enough to say `r3` was a source local. CF must use surrounding definitions/reads/cleanup/lifetime behavior and known compiler rules to distinguish a source VAR lifetime from a temporary or semantic nil.

## 6. Prometheus Compiler Architecture

Primary authority:
`src/prometheus/compiler/compiler.lua`

The compiler converts source AST into a register VM whose control flow is driven by a POS/state variable and randomized block IDs.

### 6.1 Compiler block model

Each compiler block contains:
- random numeric block ID
- block scope
- ordered VM statements
- metadata for reads/writes/upvalue usage
- `advanceToNextBlock` flag

`Compiler:addStatement(...)` records:
- AST statement
- registers written
- registers read
- whether the statement uses upvalues

The final VM dispatcher is emitted as nested comparisons over randomized state IDs inside a `while state do ... end` loop.

### 6.2 Important compiler register categories

Compiler constants/types:

```lua
MAX_REGS = 100
MAX_REGS_MUL = 0
VAR_REGISTER
RETURN_ALL
POS_REGISTER
RETURN_REGISTER
UPVALUE
```

Meaning:
- `POS_REGISTER`: VM program counter/state; can also be borrowed temporarily when free
- `RETURN_REGISTER`: VM return payload register; can also be borrowed temporarily when free
- ordinary TEMP register: short-lived compiler value
- `VAR_REGISTER`: storage owned by a source local/argument/loop variable lifetime
- `RETURN_ALL`: request to preserve all return values using a packed table
- `UPVALUE`: conceptual compiler role for captured storage

### 6.3 Register allocation

`allocRegister(false)`:
1. tries free POS register
2. tries free RETURN register
3. otherwise allocates an ordinary numeric register

`allocRegister(true)` allocates an ordinary register marked `VAR_REGISTER`.

With the current compiler constants, ordinary registers are effectively allocated from the lowest available numeric ID after special POS/RETURN reuse opportunities.

Important: a physical register number is reusable. `r5` at one point does NOT necessarily represent the same logical source value as `r5` later.

### 6.4 Register freeing and source lifetime

Compiler rule:

```lua
function Compiler:freeRegister(id, force)
    if force or not (self.registers[id] == self.VAR_REGISTER) then
        ... free ...
    end
end
```

Therefore:
- TEMP can be normally freed/reused
- VAR survives normal `freeRegister(..., false)`
- source lifetime ends only when compiler force-frees the VAR

At source block exit, `compileBlock` emits cleanup for every source variable:
- normal local: `varReg = nil`
- captured local: release-upvalue bookkeeping
- then force-free register ownership

This cleanup is strong lifetime evidence, but not sufficient by itself: semantic nil values and dead temporary nil writes also exist.

### 6.5 TEMP -> VAR promotion

`getVarRegister(scope, id, functionDepth, potentialId)` can promote an existing ordinary RHS TEMP directly to a VAR if:
- it is not already VAR
- it is not POS
- it is not RETURN

If promotion succeeds, the source local and RHS TEMP become the same physical register.

`copyRegisters` emits no assignment when source and destination physical register are identical.

Therefore a source local declaration may have:
- explicit copy from a TEMP/POS/RETURN into a VAR, OR
- no visible copy because the RHS register was promoted in place

CF/local recovery must support both forms.

### 6.6 Physical register representation and overflow

Ordinary compiler register IDs `< 100` are scalar VM locals.

Register IDs `>= 100` are emitted as static slots in the overflow table:

```text
RegisterOverflow[(id - 100) + 1]
```

The deobfuscator proves this table structurally and scalarizes static slots to:

```text
o1, o2, o3, ...
```

Dynamic overflow indexing is not accepted as equivalent register storage.

After static overflow scalarization, fresh CF treats scalar `rN` and overflow `oN` names as the same ordinary VM-register class for semantic/lifetime/interleaving proof. The storage bank matters only before scalarization; source recovery must use current value epochs/provenance rather than assuming `oN` is semantically different from `rN`.

## 7. Compiler Patterns CF Must Reverse

These are not hardcoded fixture rules. They are compiler templates observed directly in `compiler.lua` and must be recognized structurally.

### 7.1 Globals

A global read is compiled as approximately:

```lua
keyTemp = "print"
valueTemp = _env[keyTemp]
```

So a normalized register chain can recover `print` only when the key/global load relationship is proven.

A global assignment becomes approximately:

```lua
keyTemp = "name"
_env[keyTemp] = valueReg
```

### 7.2 Source local declarations

For:

```lua
local a = expr
```

Compiler behavior:
1. compile `expr` into one or more expression registers
2. get source VAR storage for `a`
3. if possible, promote the expression TEMP directly to VAR
4. otherwise copy expression result into VAR
5. normal-free the expression register; promoted VAR remains alive
6. at lexical scope exit emit VAR cleanup (`= nil`) or upvalue release
7. force-free VAR

Therefore source-local recovery is a lifetime/ownership problem, not just a name problem.

### 7.2.1 Concrete source-local VM examples

These examples are important because future work must recognize the compiler's ownership pattern, not invent a new rule from one random register number. Physical register names and state IDs vary between obfuscations.

Source:

```lua
local a = 1
print(a)
```

One observed normalized Prometheus shape was conceptually:

```lua
state = 1
r2 = state              -- r2 is source VAR storage for a
ReturnVal = "print"
state = _env[ReturnVal]
ReturnVal = state(r2)
r2 = nil                -- lexical lifetime cleanup for a
```

Important interpretation:
- `state`/`ReturnVal` may be borrowed TEMP transport
- `r2` is persistent source-local storage in this shape
- the final `r2 = nil` is compiler lifetime cleanup, not necessarily source code `a = nil`
- other randomized compilations may promote a normal expression register directly to VAR and omit an explicit copy

Source:

```lua
local a = {}
a = {1, 2}
a = {se = function() end}
a:se()
```

Observed normalized root-state shape, simplified:

```lua
state = {}
r3 = state

state = { ReturnVal, r4 }
r3 = state

ReturnVal = { [r4] = r1 }
r3 = ReturnVal

r4 = "se"
r4 = r3[r4]
r4 = r4(r3)

r3 = nil
```

Interpretation:
- `r3` is the SAME source local `a` across all three assignments
- reassigning the local does not create a new source variable
- temporary RHS values may travel through POS/RETURN or ordinary TEMP storage before copying into `r3`
- `r4 = "se"; r4 = r3[r4]; r4 = r4(r3)` is the compiler's SELF/namecall-style lowering of `a:se()`
- final `r3 = nil` ends the direct local lifetime

Source:

```lua
local a = function(x)
    return x
end
print(a)
```

Conceptual normalized shape:

```lua
state = createClosureN(CHILD_ENTRY, {})
r2 = state
ReturnVal = "print"
state = _env[ReturnVal]
ReturnVal = state(r2)
r2 = nil

-- child entry
r1 = args[1]
ReturnVal = { r1 }
state = nil
```

This proves both:
- outer `r2` is source-local closure storage
- fixed function arguments are loaded from `args[index]` in the child VM function

Source:

```lua
local a = function(...)
    return ...
end
print(a)
```

Conceptual child shape uses the compiler vararg storage and RETURN_ALL packing, commonly normalized around:

```lua
r2 = { select(1, unpack(args)) }
ReturnVal = { unpack(r2) }
state = nil
```

Do not hardcode these exact register IDs. These examples document semantic roles/templates only.

### 7.3 Nil-only locals

For source like:

```lua
local a
```

the compiler still creates nil expression register/storage and later emits scope cleanup nil.

But compiler temporaries may also contain nil. Fresh CF therefore distinguishes:
- a nil definition that reaches a real read
- a cleanup-backed nil-only lifetime
- a dead/unobserved TEMP nil
- ambiguous multiple meaningful definitions before a cleanup

Ambiguous ownership must fail closed.

### 7.4 Local reassignment

Once a source local owns a VAR register, assignments update that same source storage until lifetime end, unless capture/upvalue mechanics replace direct storage.

Do not generate a new local merely because the physical register receives another value.

### 7.5 Function calls

Normal call expression:
- compile callable
- compile args left-to-right
- last call/method/vararg argument may preserve RETURN_ALL
- one result: direct result register
- multiple requested results: compiler creates a packed table `{ call(...) }`, then reads `pack[1]`, `pack[2]`, ...
- RETURN_ALL: compiler preserves packed result and later uses `unpack(pack)`

Fresh CF must reconstruct multi-return semantics, not convert every pack into a normal table source value.

### 7.6 Method / namecall (`:`)

Prometheus does not keep Lua `:` syntax directly. It compiles:

```lua
baseReg = <base expression>
methodTemp = "MethodName"
methodTemp = baseReg[methodTemp]
methodTemp = methodTemp(baseReg, arg1, ...)
```

The original base is evaluated once and passed as argument 1.

Fresh CF may recover:

```lua
base:MethodName(arg1, ...)
```

only when it proves:
- member function came from that same base
- first call argument is that same base/self
- no intervening mutation/evaluation-order issue invalidates the rewrite

### 7.7 Index reads/writes

Index read:

```lua
baseTemp = <base>
indexTemp = <index>
resultTemp = baseTemp[indexTemp]
```

Index assignment evaluates LHS base/index before RHS in compiler logic, then writes:

```lua
baseReg[indexReg] = rhsReg
```

Recovery must preserve this evaluation order if base/index/RHS can have effects.

### 7.8 Table constructors

Compiler evaluates table entries into registers, then creates one VM table expression.

Array entries:
- normal entry uses one value
- final call/method/vararg entry may preserve all values and emit `unpack(pack)` inside the VM constructor

Keyed entries:
- key is compiled
- value is compiled
- final constructor stores `[keyReg] = valueReg`

Fresh CF must distinguish a real source table from compiler-created return packs.

### 7.9 Return statements

Compiler builds `ReturnVal` as a table:

```lua
ReturnVal = { value1, value2, ... }
state = <stop>
```

If the final source return expression is a call/method/vararg, compiler preserves all values using RETURN_ALL + `unpack(pack)`.

Normal state recovery canonicalizes proven stop sentinels to `state = nil` where safe.

### 7.10 Function literals and closure factories

Each source function body becomes a separate VM entry/state graph.

The outer function value is created by a closure factory roughly:

```lua
createClosureN(entryId, captures)
```

or vararg factory:

```lua
createClosure(entryId, captures)
```

Factory itself creates a GC proxy and returns a real Lua closure that invokes:

```lua
vm(entryId, {args...}, captures, gcProxy)
```

Fixed-argument factories can intentionally have extra physical arguments because compiler chooses:

```text
source arity + random(0..5)
```

So physical closure-factory arity is not always original source arity. Source parameter recovery relies on actual `args[N]` reads used in the child VM body.

### 7.11 Function arguments

Normal fixed argument inside child VM:

```lua
varReg = args[N]
```

Captured fixed argument:
- source storage is an upvalue cell
- allocate cell
- `upvalueValues[cell] = args[N]`

Vararg function:

```lua
varargReg = { select(firstVarargIndex, unpack(args)) }
```

Fresh closure recovery recognizes this compiler shape as `...`, not a literal table source expression.

### 7.12 Upvalues / captures

Compiler first analyzes which source variables cross function depth.

Captured storage uses:
- `allocUpvalue()`
- `upvalueValues[cellId]`
- `upvalueRefCounts[cellId]`
- capture tables passed to `createClosureN`
- `upvalues[slot]` to forward parent captures
- `releaseUpvalue(...)` / `releaseUpvalues(...)`

A capture slot can refer to:
- a local cell allocated in the immediate parent
- a forwarded capture slot from an ancestor

Correct recovery must follow this graph until the underlying captured binding is uniquely proven.

### 7.13 Short-circuit `and` / `or`

For nonconstant RHS, compiler may create extra states to preserve short-circuit evaluation.

The result register is initialized from LHS, state chooses whether RHS executes, and RHS may overwrite the result before join.

Therefore a multi-state region can represent one source logical expression rather than an `if` statement. Fresh CF currently handles only limited proven forms of this pattern.

### 7.14 `if`

Compiler creates body/next/final blocks and writes state using the condition:

```lua
state = condition and innerState or nextState
```

Each completed branch jumps to final state.

General source-level `if` reconstruction is NOT currently fully implemented in fresh CF.

### 7.15 `while`

Compiler pattern:
1. jump to check block
2. check condition
3. branch state -> body or final
4. body executes
5. body jumps back to check

General `while` collapse is currently not implemented in fresh CF.

### 7.16 `repeat ... until`

Compiler uses inner/check/final states and evaluates condition at check to choose final vs another body iteration.

General repeat collapse is currently not implemented in fresh CF.

### 7.17 Numeric `for`

Compiler expands numeric-for into a larger register/state pattern:
- initial value
- final value
- step
- step-negative flag
- internal current value
- increment before each check
- <= or >= depending step sign
- branch to body/final
- source loop VAR assignment
- body jump back to check

General numeric-for recovery is currently exported as unsupported in fresh CF.

### 7.18 Generic `for`

Compiler keeps iterator tuple as long-lived registers and uses a check state roughly equivalent to:

```lua
control, value2 = iterator(stateValue, control)
state = control and bodyState or finalState
```

Body copies control into first source iteration variable and handles additional/missing vars.

General generic-for recovery is currently unsupported in fresh CF.

### 7.19 `break` / `continue`

Before jumping, compiler emits cleanup/release for source variables whose scopes are exited.

Then:
- `break` -> loop final block
- `continue` -> loop start/check block

Any future recovery must preserve these scope cleanups semantically even if compiler cleanup statements disappear from final source.

### Root captured-local reads during pending multi-return packs

Fresh CF now treats a proven root read `upvalueValues[cell]` as neutral bookkeeping while a compiler multi-return pack is pending, but only when `cell` is already mapped to a proven root source binding by `allocUpvalue` + `upvalueValues[cell] = value`. This preserves call order while allowing compiler-shuffled captured-local reads to occur between pack slot extractions.

Verified on the user opcode/closure/TCO fixture: proven root `upvalueValues[cell]` reads, bare `cell = allocUpvalue()` allocations, and proven self-cleanup `cell = releaseUpvalue(cell)` can cross pending compiler multi-return pack bookkeeping without forcing an early flush. `releaseUpvalue` is accepted only when the destination and sole argument are the same already-known upvalue cell, never `state`/`ReturnVal`; arbitrary calls remain barriers. The extended call/TCO fixture now passes fresh CF and the emitted source parses successfully. Proven `createClosureN(entry, captures)` creation can also interleave with older pending return packs when its result has a unique future cleanup-backed source-local handoff and every still-live older return pack is already tracked as pending. The closure source declaration is deferred behind a pack-order barrier: older packs emit first, the closure emits at its original relative point, and any later-created packs emit afterward. This prevents source call/closure reordering while supporting Prometheus statement shuffling. The large table/return fixture that previously stopped at `ReturnVal = createClosure4(...)` now passes all 14 normalized states and its emitted source parses. Proven ordinary calls can also cross older pending multi-return packs when the callable/arguments already render safely and the call result is either a unique cleanup-backed handoff or is observably discarded through only dead register copies. Source emission uses the same pack-order barrier as closures, but active pack order is read directly from `pendingPacks` rather than rescanning `exprKinds`; this remains correct when a pack register has already been reused for slot 1 and avoids an unnecessary full provenance scan per call. Pure dead register copies may cross the pack only when the destination is not state/ReturnVal, is not cleanup-backed source storage, and has no observable downstream use. The expanded field/method fixture gets past the previously failing `floor(pi)` call group. Fresh CF now also supports a proven closure handoff into a reused physical register when the destination starts a new terminal-live epoch: the closure result is copied into a non-cleanup-backed ordinary register, that new epoch has at least one real use, no later redefinition reaches it, and the binding remains live only to the root function terminal. The prior physical-register lifetime is ignored after the overwrite, but the handoff copy itself must be consumed exactly once before terminal retirement. This fixes the `createClosure0(...) -> reused r81 -> r81()` shape dynamically. Fresh CF now also supports closure results handed directly into a proven allocated-but-unbound upvalue cell while older return packs are pending: it proves the future `upvalueValues[cell] = temp` store, allocates the recovered source binding at the closure evaluation point, maps the cell immediately so later captures/reads resolve to that same binding, and treats the eventual cell store as compiler bookkeeping. The closure temp may not be used or overwritten before the store, the cell must still be unbound, and the deferred store must be consumed exactly once. This fixes the expanded fixture's `createClosure5(9, { r71, r91 }) -> upvalueValues[r93] = ReturnVal` shape dynamically. The fixture now advances beyond that closure/capture region. Fresh CF also permits a pending-pack crossing for a pure TEMP producer only when the entire produced value epoch is provably dead through copies until overwrite: the RHS must be structurally side-effect-free, must not depend on an active return pack, and every use of the TEMP must be a dead copy chain. Calls, index reads, function creation, and other effectful/identity-sensitive live values are excluded. This fixes the shuffled `ReturnVal = {}; o26 = ReturnVal` dead TEMP shape without duplicating table identity. The expanded 15-state field/method fixture now completes fresh CF and emits parseable source. Related pending-pack support now covers proven live plain-table constructor handoffs while preserving one table identity, dependent field writes/namecalls behind a deferred-local order barrier, stable primitive/global-load TEMPs, closure values used exactly once as table operands, dead reads from proven plain tables, and result packs whose extracted values are all provably dead (the source call is still emitted once for side effects). Root terminal `ReturnVal = { ... }` payloads are lowered only for proven non-empty terminal payloads; when earlier pack/deferred work remains, the `return` line is held until that work is emitted so no source statement appears after `return`. A terminal-live nil-only source local is retired only under the narrow proof used by the expanded fixture (nil-only ownership with multiple downstream reads and no later definition), while one-use nil TEMPs remain ordinary values. The completed fixture output ends with the recovered table namecall, `print("PASSED")`, and `return 321`.
## 8. Deobfuscator File Structure

Important active files:

```text
main.js
passes/
  constant-array.js
  environment.js
  closure-factory.js
  vm-helpers.js
  semantic-names.js
  split-safe-assignments.js
  vm-state.js
  vm-bindings.js
  vm-register-names.js
  vm-register-overflow.js
  vm-register-scheduler.js
  beta-control-flow.js
tools/
  beta-control-flow.js
  deobfuscate-beta-control-flow.js
  test-beta-control-flow-fresh.js
  test-vm-register-scheduler.js
  test-vm-state-reachability.js
  test-vm-register-names.js
  test-vm-register-overflow.js
parser/
formater/
sample/
output/
```

Old/retired beta files may exist for reference. Do not silently fall back to them. Active fresh CF is `passes/beta-control-flow.js`.

## 9. Normal Deobfuscation Pipeline in Detail

### 9.1 Input formatting / parsing

`main.js` loads input and normally sends it through the formatter before parse.

The parser runs in Luau mode with ranges; ranges are critical because most passes preserve source by applying targeted text edits from AST positions.

`main.js` also has a structural/light parse mode used by current user-local changes. Preserve those user changes unless explicitly asked to modify them.

### 9.2 Constant-array recovery - `passes/constant-array.js`

Purpose:
Remove Prometheus constant-array indirection before VM analysis.

It structurally detects:
- local literal constant array
- wrapper function indexing that array with an affine parameter offset
- optional Prometheus rotation loop
- optional Prometheus base64-style decoder table/loop

Behavior:
- safely evaluates constant numeric index arithmetic
- applies array rotation when ranges are proven valid
- decodes encoded string constants only when decoder structure is proven
- scope-aware wrapper replacement avoids shadowed bindings
- replaces wrapper calls with literal constants
- removes the constant-array prelude only when it is contiguous, all wrapper uses are resolved, and no array uses remain

Fails closed if rotation/decoder/use analysis is incomplete.

### 9.3 Environment recovery - `passes/environment.js`

Finds the wrapper parameter receiving environment source such as:
- `getgenv()`
- `getfenv()`
- `_ENV`
- logical fallback combinations

Renames the exact lexical binding to `_env`.

Tracks function/block/loop shadowing and replacement collisions. It does not blindly rename every identifier with the same text.

### 9.4 Closure-factory recovery - `passes/closure-factory.js`

Recognizes Prometheus factory structure:
- `(entryId, captures)` parameters
- proxy created from captures
- nested closure
- nested closure returns `vm(entryId, {args}, captures, proxy)`
- factory returns nested closure

Distinguishes:
- vararg factory
- fixed-arity factory

Finds the unique vararg root factory binding and renames it `createClosure`.

### 9.5 VM helper role recovery - `passes/vm-helpers.js`

Uses structure, not obfuscated names, to identify and rename:
- `unpack`
- `newproxy`
- `setmetatable`
- `getmetatable`
- `select`
- `vm`
- `createUpvalueProxy`
- `releaseUpvalues`
- `releaseUpvalue`
- `allocUpvalue`
- `upvalueRefCounts`
- `upvalueValues`
- `currentUpvalueId`
- VM parameters `state`, `args`, `upvalues`, `gcProxy`
- `createClosure`
- `createClosureN` fixed factories

Role proof uses behavior such as:
- closure factories agreeing on VM/proxy bindings
- `__gc` callback
- reference-count increment/decrement/clear behavior
- allocator increment + initial refcount
- wrapper builtin arguments

Renames are batched when safe; sequential fallback exists for conflict cases.

### 9.6 Semantic helper naming - `passes/semantic-names.js`

Adds readable names where structure uniquely proves roles:
- `InitialArgs`
- fixed closure physical params `arg1`, `arg2`, ...
- `gcProxy`
- `closure`
- `captureIndex`
- `upvalueId`
- `proxy`
- `proxyMetatable`
- `RegisterOverflow`

It checks shadowing/collisions before editing.

### 9.7 Safe parallel assignment splitting - `passes/split-safe-assignments.js`

Splits a parallel assignment only when all RHS values are structurally safe and independent forms:
- primitive literals
- anonymous function literal
- empty table
- simple unary numeric literal

It intentionally does NOT split arbitrary calls/indexes/effectful assignments because Lua parallel-assignment evaluation semantics could change.

Runs repeatedly up to a small fixed pass limit until no more safe splits exist.

### 9.8 VM state recovery - `passes/vm-state.js`

This pass turns the randomized Prometheus dispatcher into a known reachable CFG and, when safe, normalizes state IDs.

Important behavior:
- finds semantically named `vm`
- identifies VM state parameter
- finds `while state do ... end`
- finds root closure invocation outside VM
- recognizes all `createClosure` / `createClosureN` entry calls
- follows closure entries only when they occur in already-reachable states
- dead dispatcher leaves do not keep dead closure graphs alive

State IDs may be hidden in constant arithmetic because Prometheus Numbers-To-Expressions can rewrite numeric IDs. `numericValue` evaluates only proven safe integer arithmetic:
- literal integer
- unary minus
- `+`
- `-`
- `*`
- exact `/`
- Lua-style `%`
- nonnegative `^`

Dispatcher resolution:
- evaluates nested state comparisons for a known state ID
- descends Prometheus binary decision tree to the actual leaf

Only the FINAL state write in a leaf is treated as the control-flow terminator because POS/state can be borrowed earlier as a normal temporary.

Recognized terminators:
- direct numeric jump
- direct `condition and trueState or falseState`
- split compiler `and`/`or` transition sequence
- canonical stop (`nil` or recognized Prometheus environment sentinel)

Graph recovery:
- BFS from root entry
- discovers child closure roots from reachable states
- records reachable blocks and transitions
- proves whether every reachable target resolves
- tracks dispatcher leaves not reachable from any root

When graph is closed/safe:
- old random state IDs are remapped to contiguous IDs
- root group first, then closure groups
- closure factory entry IDs are rewritten
- jump/branch targets are rewritten
- normalized dispatcher is emitted as deterministic nested state tests

If normalization cannot be proven, the pass does not pretend the graph is solved.

### 9.9 VM binding/lifetime analysis - `passes/vm-bindings.js`

This is diagnostic/analysis infrastructure for normal output. Fresh CF rebuilds its own source recovery proof, so `tools/deobfuscate-beta-control-flow.js` can skip this duplicate analysis when handing normal output directly into beta CF.

Requires a closed normalized VM graph.

Per function/root it builds:
- CFG predecessors
- identifier definitions
- exact RHS when positional assignment is known
- uses
- reaching-definition sets
- RHS definition dependencies
- value provenance
- liveness
- cross-block lifetime facts
- loop-carried lifetime facts
- join groups
- binding-end candidates
- ordinary-register epochs
- closure/capture sites
- upvalue-cell reads/writes

Value provenance categories:
- `environment-reference`
- `register-value`
- `external-reference`
- `unknown`

Copies propagate provenance until convergence where possible.

Reaching-definition rule:
A use records every definition that may reach that point. One reaching definition is strong proof; multiple reaching definitions indicate a join/ambiguity that needs explicit reasoning.

Definition lifetime analysis records:
- use count
- unique/ambiguous uses
- use blocks
- live-in blocks
- live-out blocks
- cross-block flag
- loop-carried flag

Binding-end candidate:
A nil definition can be considered a possible source-lifetime end only when:
- nil definition itself is unused
- exactly one previous definition reaches it
- previous definition has real uses

If another definition of the same physical register occurs later in the same block, this becomes an ownership-handoff candidate.

Ordinary register epochs:
- do NOT equate every write to same physical register
- only selected exact non-nil register-value definitions are eligible
- merge definitions when a real use can see several definitions of the same register at a join
- merge mutation chains when the new definition transitively depends on a previous reaching definition of the same register
- cleanup/reuse naturally prevents unrelated values from merging

Upvalue/capture analysis:
- `allocUpvalue()` definitions become local cell candidates
- closure capture table entries classified as local-cell, parent-capture-slot, or unproven
- `upvalueValues[...]` reads/writes classified
- forwarded captures recursively resolve through parent slots
- resolution must end at one unique cell
- detects unresolved/ambiguous/cyclic capture chains
- records shared cells captured by multiple child functions

This analysis is useful authority when implementing new recovery but is not itself the final source renderer.

### 9.10 VM register presentation naming - `passes/vm-register-names.js`

This pass makes physical VM storage readable; it does NOT claim source variable identity.

Proof:
- VM must end with `return unpack(<return register>)`
- uniquely identify scalar VM register declaration containing that return register
- reject nested shadowing/collisions

Naming:
- return register -> `ReturnVal`
- other scalar physical VM registers -> `r1`, `r2`, ...

Important:
`r1` is only a physical VM register presentation name. It can represent different logical values at different lifetimes.

### 9.11 RegisterOverflow scalarization - `passes/vm-register-overflow.js`

Compiler registers beyond scalar bank are emitted through one table.

Pass proves:
- unique overflow table
- table initialized empty before scalar declaration
- all references are static positive integer indexes
- no shadowing
- no `oN` name collision

Then:
- `RegisterOverflow[1]` -> `o1`
- `RegisterOverflow[2]` -> `o2`
- etc.
- removes overflow table declaration

Any dynamic/invalid index fails this scalarization.

### 9.12 VM register scheduler - `passes/vm-register-scheduler.js`

Prometheus compiler may shuffle dependency-independent statements. CF matching becomes much easier if pure register producers are placed near their consumers without changing semantics.

Scheduler operates only inside normalized dispatcher leaf segments.

It computes read/write identities, including overflow slots when needed.

Generic delayable statement is a pure single assignment from:
- primitive literal
- another register

It never freely moves arbitrary calls/index mutations/effectful expressions.

Hazards that block reordering:
- RAW: earlier write -> later read
- WAR: earlier read -> later write
- WAW: write -> write

Lifetime safety:
- final direct `register = nil` touch can mark source-lifetime boundary
- writes associated with that protected register are anchored
- dead `args` snapshots have a narrow exception but still obey dependencies

POS/state safety:
- earlier state writes before final transition can be compiler borrowed-POS temp writes
- only proven simple borrowed writes are treated as movable temps
- final state transition stays control-flow authority

Scheduling phases:
1. sink pure primitive producers toward next touch
2. pull register-copy consumers toward nearest producer
3. compact producer/consumer gaps by moving only independent pure assignments
4. sink unread pure assignments toward next overwrite or state tail

The scheduler NEVER deletes these assignments merely because they look dead.

After generic scheduling it may also:
- move a proven direct numeric state transition to the physical tail when safe
- move a proven return payload immediately before final `state = nil` across only pure compiler bookkeeping

Validation step reconstructs whether every inversion is legal. If validation fails, original segment order is kept.

### 9.13 Normal output

After these passes, `main.js` writes a normalized VM source file. This normal file is intentionally still VM-like. It is the stable input to fresh CF.

## 10. Fresh CF - Correct Mental Model

Fresh CF is primarily a compiler-pattern reversal engine plus dataflow/lifetime proof.

Good mental model:

```text
Prometheus source construct
-> compiler emits known state/register/storage template
-> normal deobf removes randomized wrapper noise and normalizes names/state IDs
-> fresh CF recognizes template
-> fresh CF follows values/storage/captures
-> fresh CF proves source-level meaning
-> fresh CF emits readable source
```

So yes: "identify patterns and recover register-created patterns" is right.

But never implement it as:

```text
if text contains these 5 lines -> print guessed source
```

Correct implementation should use AST structure and generic relations such as:
- destination register identity
- source register identity
- definition/use relationship
- cleanup/lifetime evidence
- known state transition shape
- closure entry relation
- capture-slot relation
- table/index base relation
- method self relation
- multi-return pack relation
- evaluation-order constraints

Random register/state IDs and random constants must not matter.

## 11. Fresh CF Entry Flow - `passes/beta-control-flow.js`

`solveFreshSource(source, ast)` currently does approximately:

1. require normal output source + AST
2. find semantically named VM
3. normalize remaining static RegisterOverflow AST references to `oN`; reject dynamic overflow indexes
4. identify `state` parameter
5. identify `ReturnVal`
6. find `while state` dispatcher
7. try closure-entry program recovery
8. try limited multi-state logical/local recovery
9. if neither applies, require one-state leaf
10. try register/local program recovery
11. try direct global-call recovery
12. if direct call path fails, retry register program allowing zero source locals for call-result statements
13. otherwise fail closed with detailed diagnostic reason

Current modes include:
- `fresh-closure-entry`
- `fresh-multistate-logical`
- `fresh-register-locals`
- `fresh-call-results`
- `fresh-direct-global-call`

Fresh CF explicitly has no fallback to retired old beta register-version/CF recovery.

## 12. Fresh CF Expression / Value Recovery

Fresh CF maintains maps from VM registers to proven source expressions/kinds instead of blindly emitting every VM assignment.

It can render proven forms including:
- primitive literals
- empty and populated table constructors
- identifiers with known expression value
- unary `not`, `-`, `#`
- binary operators
- restricted logical operators
- global reads through `_env`
- member/index reads
- calls
- method calls when member + self relation is proven
- closure factory calls through child-state renderer
- return packs/unpack

Expression metadata tracks special kinds such as:
- table
- member reference
- return pack
- pack slot

This metadata matters for safe table writes and method-call reconstruction.

## 13. Fresh CF Local Lifetime Recovery

`matchLocalRegisterProgram` first scans the leaf for ordinary registers that receive nil cleanup and counts meaningful non-nil definitions.

It maintains:
- expression map
- expression-kind map
- member metadata
- set of active recovered locals
- local display names
- pending multi-return packs
- upvalue-cell map

Recovered source names are presentation names:
- ordinary/value locals: `v1`, `v2`, ...
- table locals: `t1`, `t2`, ...

Original source identifier names are generally unrecoverable.

### 13.1 Why nil is tricky

`register = nil` can mean:
- source value is actually nil
- nil-only local initialization
- source local lifetime cleanup
- temporary register content
- dead compiler bookkeeping

Current rules include:
- if exact nil definition is read before overwrite, preserve it semantically
- if register has no meaningful non-nil definitions and has later nil cleanup, it can prove nil-only local lifetime
- a nil-only source VAR may be read before its explicit VM `= nil` initializer when Prometheus shuffles that redundant write; fresh CF may predeclare it at first read only when the register has zero non-nil definitions, at least two nil definitions, and the first explicit nil write occurs later
- for such predeclared nil-only lifetimes, redundant/intermediate nil writes are ignored until the final cleanup ends the local
- one unobserved nil before one meaningful value can be dead TEMP bookkeeping
- multiple meaningful definitions before ownership is established can be ambiguous and fail closed

### 13.2 Cleanup-backed local establishment

Fresh CF can establish a source local by:
- copy from a proven expression/temp into cleanup-backed storage
- direct first meaningful definition when exactly one non-nil definition proves TEMP->VAR promotion shape

Once local is active:
- writes become source assignments
- final cleanup removes active local instead of emitting source `= nil`

At terminal, all recovered locals must have ended. A still-live local is treated as proof failure, not silently dropped.

## 14. Multi-Return Recovery

Prometheus commonly lowers:

```lua
local a, b = f()
```

into conceptually:

```lua
pack = { f() }
tmp1 = pack[1]
tmp2 = pack[2]
localA = tmp1
localB = tmp2
```

Fresh CF tracks pending packs rather than treating `pack` as a source table.

Requirements include:
- pack created from a call
- slots are positive contiguous indexes beginning at 1
- each slot can be traced to final local storage
- no conflicting/reused slot ownership

Then it emits:

```lua
local v1, v2 = f()
```

Prometheus can interleave independent storage handoffs after calls. Fresh CF now also handles proven forms where:
- a call result lives temporarily in `state`, `ReturnVal`, or another TEMP and is copied later into cleanup-backed source storage
- multiple return packs are created/interleaved before all slot-to-local copies occur
- a pack slot is extracted into `state`/`ReturnVal` and its final cleanup-backed destination appears later
- the physical pack register itself is reused as the first source-result local

For a unique future TEMP -> cleanup-backed storage handoff, the source call/declaration is emitted at the actual call-evaluation point and the later VM copy is treated as storage bookkeeping. This preserves call order while allowing compiler shuffling. Pack provenance is preserved until all needed slots are recovered; reserving the pack register as source storage must not erase its still-live `return-pack` identity. Ambiguous/multiple handoffs still fail closed.

RETURN_ALL packs and `unpack(pack)` are also recognized so source call expansion semantics are preserved.

## 15. Table / Field / Global Writes

Fresh CF can render index assignments only when base/value/key are proven.

Global write:

```lua
_env[key] = value
```

can become:

```lua
GlobalName = value
```

only for a proven valid identifier key.

Table write can become:

```lua
base.field = value
```

or:

```lua
base[key] = value
```

only when base is proven stable enough, such as:
- source local
- proven table value
- proven member/stable reference in closure recovery

This avoids duplicating an effectful base expression.

## 16. Method Call Recovery

Member load metadata is remembered:

```text
functionReg <- base["method"]
```

If a later call is:

```text
functionReg(base, ...)
```

and the same base is proven, fresh CF emits:

```lua
base:method(...)
```

Otherwise it keeps/fails the lower-level call rather than inventing `:` semantics.

## 17. Closure Recovery

`matchClosureEntryProgram` extracts normalized state leaves and treats state 1 as root normalized entry.

When it sees a proven `createClosureN(entryId, captures)`:
1. find child state leaf by normalized entry ID
2. build capture-name map if captures exist
3. render child with `renderSimpleClosureLeaf`
4. recursively support nested closures
5. record consumed child entry

A closure recovery succeeds only if every normalized state leaf belongs to root/consumed closures. Unconsumed states make the proof fail.

### 17.1 Fixed arguments inside closure bodies

Child VM argument loads such as:

```lua
rX = args[1]
```

are used to infer source parameters.

Presentation names are generated and collision-checked against captures.

Important: do not infer source arity from physical `createClosureN` factory arity alone because compiler may add random unused physical parameters.

### 17.2 Vararg closure bodies

Fresh CF recognizes compiler vararg storage like:

```lua
rX = { select(1, unpack(args)) }
```

as source `...`.

Return pack using `unpack(rX)` can then recover:

```lua
return ...
```

### 17.3 Simple closure return lowering

Child renderer recognizes compiler return payload:

```lua
ReturnVal = { ... }
state = nil
```

and emits source `return` when values are proven.

An empty `ReturnVal = {}` + stop represents a function with no explicit values returned.

## 18. Fresh CF Upvalue Recovery

Inside closure renderer, upvalue machinery is interpreted as storage, not source-level table code.

Recognized concepts:
- local cell allocation: `cellReg = allocUpvalue()`
- local cell read: `upvalueValues[cellReg]`
- local cell write: `upvalueValues[cellReg] = value`
- captured slot read: `upvalueValues[upvalues[N]]`
- captured slot write: same destination form
- child closure capture table entries

When capture mapping is complete, child expressions can refer directly to the recovered captured source binding.

Never emit fake independent locals for two closures that share the same proven underlying cell.

## 19. Fresh CF Logical Multi-State Recovery

Fresh CF currently has two limited mechanisms for compiler-generated logical control flow.

### 19.1 Root logical flattening

`flattenLogicalRootLeaf` follows a sequence of root states and recognizes a narrow short-circuit region when:
- branch shape is recognized
- one branch flows directly to a join
- alternate branch contains the expected result assignment and then joins
- relevant result register relationship is proven

It reconstructs an `and`/`or` expression and continues flattening. When strict flattening consumes every normalized root state, the resulting straight-line leaf is now handed to the full `matchLocalRegisterProgram` recovery path before the narrower DAG matcher. This lets proven short-circuit regions compose with large post-join programs containing arithmetic, comparisons, calls, multi-return packs, globals, and normal local lifetimes.

Logical flattening must also distinguish compiler POS preservation from source-local ownership. A cleanup-backed register assignment such as `R = state` is treated as temporary POS preservation rather than a source-local declaration when the same value is uniquely used only by the compiler restore `state = R` before `R` is redefined. A later proven definition can then establish the real source lifetime.

This is NOT a general CFG structurer.

### 19.2 `matchMultiStateLogicalLocals`

This handles a limited normalized DAG of states with cleanup-backed locals and logical branches.

It:
- extracts normalized leaves
- identifies stop/jump/branch terminators
- builds successor/predecessor graph
- requires all states reachable from normalized entry 1
- propagates expression environment along edges
- attaches truth markers to branch paths
- merges exactly proven symmetric branch candidates
- can reconstruct values such as conditional `and` / `or`
- drops path-local temps at join only if they are proven unread afterward
- fails on ambiguous live values

It is intentionally conservative.

## 20. Direct Global Call Recovery

Fresh CF has a strict direct-global-call matcher for simple compiler programs.

It recognizes:
- global key load
- `_env[key]` load
- safe argument producer registers
- direct call
- compiler terminal bookkeeping

It checks producer use counts so an argument TEMP is not silently duplicated or dropped.

It can also follow proven member chains.

## 21. Initial Local Presentation Canonicalization

Prometheus may shuffle dependency-independent VM statements. Exact original declaration order can become unrecoverable.

Fresh CF has a presentation-only canonicalizer for an initial prefix of simple locals, especially when nil-only locals are present.

It only reorders simple declarations such as:
- nil-only local
- primitive constant
- direct global
- simple member chain

Dependencies are topologically preserved. It never moves declarations across the first unsupported/effectful/non-simple boundary.

This is presentation normalization, not a claim that exact original source order is known.

## 22. Error Handling / Fail-Closed Diagnostics

Fresh CF must never return plausible-looking source when proof failed.

`tools/beta-control-flow.js` throws the exact `controlFlow.reason` when solver does not apply.

Improved diagnostics can report details such as:
- unsupported multi-state control flow count
- closure-recovery reason
- state where root flattening failed
- root statement index/text
- unconsumed normalized states
- final pending multi-return pack failure
- no proven source locals
- incomplete terminal bookkeeping
- recovered locals still live at terminal
- no source statements emitted

Keep diagnostics useful when adding support. Do not replace a precise error with a generic "unsupported" unless no better proof location exists.

## 23. Current Explicitly Unsupported Fresh-CF Areas

The following exported helpers are currently intentionally unsupported/stubs:
- `displayEnvironmentProvider`
- `sinkTerminalReturnPayload`
- `lowerTerminalReturn`
- `collapseCompilerNumericForLoops`
- `collapseCompilerGenericForLoops`
- `collapseCompilerWhileLoops`
- `matchCompilerWhileConditionRegion`
- `collapseCompilerRepeatLoops`
- `matchCompilerRepeatConditionRegion`
- `removeDuplicatedRepeatConditionRegions`
- `collapseCompilerStructuredLoops`
- `forwardControlOnlyJoinBranches`
- `removeCompilerPosPreservationOperations`

Therefore do NOT claim full support for:
- general `if`
- general `while`
- general `repeat`
- numeric `for`
- generic `for`
- arbitrary nested control flow
- arbitrary break/continue structuring

Limited compiler short-circuit multi-state logic is supported separately, as documented above.

## 24. What "Dynamic / Structural" Means in Practice

Good recovery rule example:

```text
Find any register R whose value is a proven member read from base B with constant valid key K;
if a later call uses R as callable and B as argument 1, with no invalidating mutation/effect,
recover B:K(...).
```

Bad recovery rule example:

```text
If r4 = r3["se"] then output r3:se().
```

Good rules survive:
- different register numbers
- different state IDs
- different method names
- different constants
- compiler statement shuffling when dependencies permit
- overflow/scalar register placement

Every new handler should be tested against randomized compiler outputs, not only one fixture.

## 25. Source Local vs TEMP - Critical Rule

Do not confuse physical storage with source bindings.

Conceptually:

```text
physical VM register
-> definitions/reaching uses/lifetime boundaries/ownership handoffs
-> logical value/storage epoch
-> source binding only when compiler ownership pattern is proven
```

Facts:
- same source local can have many assignments
- same physical VM register can later be reused for a completely different value
- a TEMP can be promoted in-place to VAR
- source local cleanup usually appears at scope exit
- captured local lifetime is represented by upvalue-cell machinery instead of plain direct storage
- mutation can join multiple definitions into one logical source storage epoch
- CFG joins can make multiple definitions one live value when proven

When uncertain, inspect `compiler.lua`, make a tiny source fixture, obfuscate it, normalize it, and compare.

## 26. Evaluation-Order Rule

Never inline or reorder merely because a variable has one use.

Before inlining/reconstructing, consider:
- is RHS pure?
- can evaluating it later change result?
- can base/index/call mutate?
- does Lua evaluate LHS base/index before RHS here?
- is function call count preserved?
- is table identity preserved?
- is a member base evaluated once?
- are multi-return positions preserved?

The scheduler handles only proven pure register movement. Fresh CF should rely on proof, not assume arbitrary normalized statements are freely movable.

## 27. Table / Reference Identity Rule

Tables/functions/userdata-like references must keep identity.

Example danger:

```lua
local t = {}
mutate(t)
print(t.x)
```

Do not replace repeated uses of `t` with reconstructed `{}` expressions. Once a source local/storage identity is needed across mutation/calls, preserve one local binding.

Same applies to method-call base objects and captured references.

## 28. Multiple-Return Rule

Lua/Luau has position-sensitive multiple return semantics.

Must preserve differences between:

```lua
local a = f()
local a, b = f()
print(f())
print(1, f())
local t = { f() }
return f()
```

Compiler pack tables are implementation details. Do not expose them as real source tables unless they actually originated from a source table constructor.

## 29. Testing Standard

For any structural feature or bug fix:

1. inspect relevant compiler code first if behavior is uncertain
2. make smallest readable source fixture
3. obfuscate with local Prometheus compiler, preferably preset Medium
4. run full normal deobfuscator pipeline with formatter enabled unless specifically testing a lower stage
5. inspect normalized VM shape
6. run fresh CF
7. inspect recovered source
8. run runtime/semantic parity where practical
9. add focused positive regression
10. add negative fail-closed regression when ambiguity matters
11. test multiple randomized obfuscations when compiler order/IDs/random constants may vary
12. run relevant standard regressions
13. run `git diff --check`
14. update `CONTEXT.md`
15. focused commit + push

Core regression commands currently include:

```text
node tools/test-beta-control-flow-fresh.js
node tools/test-vm-register-scheduler.js
node tools/test-vm-state-reachability.js
node tools/test-vm-register-names.js
node tools/test-vm-register-overflow.js
```

Use additional tests for the specific pass being changed.

## 30. Current Known-Good Recovery Examples

These were verified after restoring the fresh-CF behavior to the `7375421 Refine nil register lifetimes` baseline while retaining overflow support and improved diagnostics.

### Fixed-argument closure

Source:

```lua
local a = function(x)
    return x
end
print(a)
```

Recovered shape:

```lua
local v1 = function(v1)
    return v1
end
print(v1)
```

### Vararg closure

Source:

```lua
local a = function(...)
    return ...
end
print(a)
```

Recovered shape:

```lua
local v1 = function(...)
    return ...
end
print(v1)
```

### Table reassignment + method call

Source:

```lua
local a = {}
a = {1, 2}
a = {se = function() end}
a:se()
```

Recovered shape:

```lua
local t1 = {}
t1 = { 1, 2 }
t1 = { se = function()end }
t1:se()
```

These examples are regression anchors, not permission to hardcode their names/register layouts.

### Logical + opcode/call composition

A full opcode-style fixture containing globals, nil/boolean/constants, arithmetic, concat/unary, two sequential short-circuit `or` regions, comparisons, zero/one/multi-result calls, and two-argument calls now recovers through fresh CF as a 5-state logical program. The saved failing matrix and three fresh randomized Medium obfuscations passed after the logical/POS/nil/pack-handoff fixes.

A six-line call fixture (`floor(pi)`, one result, two results, three results) was also randomized 20 times; all 20 layouts passed, including 10 layouts that previously failed because result packs and delayed source-storage copies were interleaved.

## 31. Current Baseline / History That Matters

Important semantic baseline commit:
`7375421 Refine nil register lifetimes`

Current branch later restored fresh CF behavior to that baseline while keeping:
- RegisterOverflow scalarization/integration
- improved fresh-CF error diagnostics

Do not reintroduce discarded later experimental CF changes just because they exist in Git history. Read current files and this context first.

## 32. Context Maintenance Rule

This file should contain current durable truth, not a chronological diary.

When something changes:
- edit the relevant section
- delete stale claims
- update support/unsupported status
- update tests/baseline if needed
- record new compiler facts only after proving them

Do NOT append huge repeated "latest update" sections forever.

If a future chat starts from this file, it should be able to understand:
- how Prometheus compiler represents source
- how normal deobf works
- how fresh CF works
- what is currently supported
- what is unsafe/unsupported
- how to test and commit changes

## 33. Final Project Rule

Correctness over aggressiveness.

When a shape is unsupported or ambiguous:
- show a precise error
- inspect compiler behavior
- add structural proof
- test randomized variants
- only then recover source

Never force a fixture to pass by weakening safety globally.
