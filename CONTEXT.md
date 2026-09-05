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
- project workflow rules
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
- fresh-CF behavior is the current tracked solver on `main`; it extends the restored nil-lifetime baseline with unified scalar/overflow register handling, pending-pack interleaving recovery, source-statement preservation, and persistent terminal source-storage proof
- source recovery is intentionally not a source optimizer: proven source declarations/assignments/aliases remain even when unused, overwritten, or safely inlineable
- proven source-local function bindings are preserved even when every later read is a direct call; closure identity/allocation/lifetime are source semantics, not an inlining opportunity
- unrelated tracked user edits in `main.js` and `formater/input.txt` must be preserved unless explicitly requested otherwise

## 1. Strict Task Confirmation / Scope Lock

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

At the beginning of project work:
1. In a brand-new chat, read `CONTEXT.md` completely. In the same chat, do not reread the entire file on every turn unless it changed externally or the current task depends on a section not already loaded; reuse the already-read context and refresh only relevant sections when needed.
2. Refresh Git status/history when repository state may have changed. Prefer one combined/context call when supported instead of separate repeated status/log calls.
3. Inspect current relevant files before changing them; do not reread unchanged files solely for ceremony.
4. Preserve unrelated dirty/untracked user work.

During work:
- update `CONTEXT.md` whenever meaningful implementation knowledge, compiler behavior, supported behavior, unsupported behavior, architectural decisions, or test results change
- do not leave context stale until many turns later
- compact/remove superseded notes instead of keeping contradictory versions
- inspect the actual Prometheus compiler/obfuscator whenever a compiler pattern is uncertain
- do not guess compiler behavior from one output when compiler source can prove it
- test tiny readable source fixtures through the real compiler and real deobfuscator when a pattern matters
- treat performance as a standing requirement for every new pipeline feature: avoid unnecessary full-source parses/tree walks, reuse an AST when its source text is unchanged, prefer cached/indexed dataflow over repeated scans, and do not retain large intermediate objects longer than required
- profile before performance edits and optimize measured hot paths first; keep representative before/after timing, memory, and byte-identical output evidence

After meaningful tracked changes:
1. run focused tests
2. run broader regressions relevant to the change
3. for Fresh-CF/register-lifetime/scheduling changes, keep a mixed control-flow gate: run the tracked Fresh CF + if suites and representative real-compiler fixtures covering supported short-circuit `and`/`or` (TESTSET-style CFG) plus `if/elseif/else`; when a newly added mixed fixture fails, compare the same normalized VM against the pre-change commit before classifying it as a regression
4. run `git diff --check`
5. update/compact `CONTEXT.md`
6. stage ONLY files belonging to the current change
7. make a focused commit
8. push `origin/main`

Git should be updated constantly: meaningful self-contained project changes should not accumulate uncommitted across many unrelated tasks. Context should also be updated constantly.

Do NOT commit temporary probes/generated outputs unless explicitly requested.

### 2.1 Tool Execution Efficiency

Minimize tool-call latency without weakening correctness or verification:
- reuse already-discovered tool schemas/capabilities; do not rediscover the same tool unless a prior invocation failed or its capabilities may have changed
- batch independent reads, searches, status checks, and related commands whenever supported instead of serial one-file/one-command calls
- prefer foreground execution for commands expected to finish quickly; use background execution and polling only for genuinely long-running work
- parallelize independent operations when supported; do not serialize unrelated reads or checks
- avoid redundant rereads/rechecks when the underlying source/state has not changed; revalidate after writes, failures, external changes, or when correctness requires it
- prefer direct known tools over broad discovery/context tools when the exact target and action are already known
- for the standard fixture path, run `source -> Medium obfuscate -> normal deobf -> fresh CF -> runtime parity` in the shortest reliable command sequence; inspect intermediate artifacts only on failure or when the user asks to see them
- for agent-side testing, prefer the tracked one-call runner `node tools/fast-obf-deobf.js <source.lua> --runtime`; it performs Medium obfuscation, in-process normal deobf + Fresh CF, exact runtime parity, and timing in one tool invocation. It also accepts multiple source files in one Node process.
- combine related CLI operations into one invocation when safe and when later steps do not depend on inspecting earlier output
- speed must never remove required semantic checks, fail-closed proof, scope discipline, or protection of unrelated user work

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

As of the 2026-09-02 handoff cleanup, clearly generated/test/temp artifacts were removed. Ambiguous untracked work such as `opt/`, `opti/`, `sample/input.txt`, and non-generated source fixtures must still be preserved unless the user explicitly scopes them for deletion. Never use a blind `git clean -fd`.

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
- preserve proven source declarations/assignments even when their produced values are unused or overwritten later
- remove compiler bookkeeping, not source-level dead code, unless the user explicitly requests a separate optimizer
- fail closed when proof is incomplete

A pretty output that changes semantics is a bug. Do not use cosmetic cleanup as a substitute for understanding the compiler pattern.

### 4.1 Source-Preservation / No-Optimizer Rule

This is a hard project rule unless the user explicitly asks for a separate optimizer:

```text
recover source semantics first
DO NOT dead-code eliminate proven source locals
DO NOT collapse unused multi-return declarations into bare calls
DO NOT remove proven source assignments merely because later unused/overwritten
DO NOT inline proven source aliases
DO NOT constant-propagate proven source aliases into later expressions
```

Only remove proven compiler bookkeeping such as register cleanup, state transport, ReturnVal transport, return-pack slot transport, compiler-only TEMP copies, and upvalue machinery. If a source declaration is proven, preserve it even when unused. If a source local shadows an earlier local, preserve the new binding and all later references to that binding.

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

Therefore a multi-state region can represent one source logical expression rather than an `if` statement. Fresh CF now composes proven compiler short-circuit regions with supported source conditionals instead of forcing one matcher to own the entire CFG. Before conditional structuring, `reduceCompilerLogicalStateGraph` identifies a value-producing logical branch only when the branch block contains the compiler result-carrier copy, exactly one successor is the lazy path that reaches the other successor as the join, `flattenLogicalRootLeaf(..., { stopId: join })` proves that lazy region reduces to the same result carrier, and the region is closed: no internal state except the region entry has an external predecessor and no consumed state escapes anywhere except the proven join. The reducer replaces that region with the synthesized proof-marked logical assignment plus a direct jump to the join, then repeats, so logical regions may appear before, inside, or after supported `if/elseif/else` regions. A source conditional that merely consumes an already-computed logical value has no qualifying compiler result-carrier region and remains for conditional structuring. The previous 55-state side-effecting `and/or` + nested `if/elseif/else` fixture now recovers with exact runtime parity rather than failing at state 15.

### 7.14 `if`

Compiler creates body/next/final blocks and writes state using the condition:

```lua
state = condition and innerState or nextState
```

Each completed branch jumps to final state.

Fresh CF supports proven simple `if`, `if/else`, same-join `elseif` chains, and recursively nested conditional regions. N-way `elseif` recovery is depth-independent: at a join it computes the longest shared outer marker prefix, proves that only the remaining suffix is a canonical false-edge `elseif` chain whose branch bodies converge to that same join, and either emits it at the root or returns it as one structured branch effect when the shared prefix is non-empty. The final false path may carry a normal `else` body or be effect-free, in which case the recovered chain ends with `end` and no invented `else`. This lets `elseif` chains appear dynamically inside outer true/false branches and compose recursively with distinct-inner-join `if` / `if-else` regions. Explicit nesting is preserved because a distinct inner join is recovered before its enclosing join; same-join chains remain `elseif`. Direct/call conditions and cleanup-backed source-local conditions are supported. Common effects that occur inside the outer branch before the nested chain are preserved as a proven effect prefix. Conditional source storage is also supported when lifetime proof is complete: a root-level persistent register may become one source binding only when multiple definitions converge, the merged storage is read after the join, and every reachable path eventually reaches that register's compiler nil cleanup; a branch-local binding may be recovered only for a stable cleanup-backed epoch that is read, has no later non-nil write in that epoch, and reaches cleanup on every continuation path. Branch-local binding identity is path-scoped rather than keyed globally by the reusable physical register, so sibling CFG paths may safely reuse one VM register for unrelated source storage or compiler TEMPs. Proven field/index writes to an active table binding remain inside the owning branch. Multiple independent root conditional regions in one closure are supported as a source sequence only when each later root branch starts on the unique non-branching continuation from the previous root join; straight-line statements between regions remain in order. Conditional markers carry their originating branch-state ID, so equal rendered condition text from different CFG branch sites is not treated as the same marker. This rule is iterative rather than limited to two roots. For conditional recovery, proven compiler logical-value regions are reduced structurally before marker-based `if/elseif/else` merging. This keeps logical result production separate from statement-conditional routing while allowing both to coexist in one root CFG. After reduction, root conditional sequencing retains the existing strict unique non-branching continuation proof; logical diamonds do not weaken that sequencing rule because they have already been collapsed. The matcher still rejects live path-dependent values, ambiguous storage epochs, empty/ambiguous true or `elseif` bodies, inconsistent marker/effect depths, non-closed logical regions, and non-canonical join shapes.

### 7.15 `while`

Compiler pattern:
1. jump to check block
2. check condition
3. branch state -> body or final
4. body executes
5. body jumps back to check

Fresh CF now recovers proven Prometheus pre-test `while` regions structurally in `passes/beta-cf/control/while.js`. The matcher discovers natural loops from CFG back-edges whose target dominates the source, proves a unique preheader and compiler while decision polarity (true -> body, false -> final), reduces compiler TESTSET/short-circuit condition regions through the existing logical reducer, and collapses nested loops inner-first. It supports loop-carried source locals, supported nested `if/elseif/else`, nested `while`, multiple compiler `break`/`continue` sites, and early source `return` paths whose off-cycle region is proven closed/acyclic and ends in the compiler `ReturnVal = { ... }; state = nil` terminal form. Loop-local storage that starts inside an outer loop is tied to the exact last non-nil VM-register definition statement in its proven compiler preheader, not merely to the preheader block. This statement-level epoch provenance prevents earlier same-block compiler TEMP uses of the same physical register (for example global/namecall key transport before the loop counter assignment) from being promoted into the source binding. Forced loop-carried storage without a nil cleanup is allowed only as a specifically proven terminal-live binding. Child closure entries delegate through the same while matcher before ordinary structured recovery, and while metadata reports only original reachable VM state IDs/counts, never synthetic body-join IDs used internally during acyclic structuring. Numeric/generic-for signatures are explicitly rejected by the while matcher. Ambiguous natural loops, overlapping non-nested loops, unproven extra exits/back-edges/terminal regions, and unsupported body semantics remain fail-closed. The extra nested-candidate reduction used for complex break/continue/return composition is loop-scoped and runs only after the existing normal structured merge fails, so non-loop conditional recovery keeps its old fast path. Closure creation inside a proven while body is also supported: root and child-entry while recovery receive the same transactional `createClosureN` renderer, so captures are resolved without contaminating root lifetime analysis. Prometheus one-call transport such as `pack = { closure(...) }; outer(..., unpack(pack))` is collapsed only when the unpack is the final argument and the pack is still the exact proven single-call compiler pack. Proven source-local closure bindings are NEVER inlined merely because all of their reads are direct calls. Source binding identity/lifetime is separate from value-use shape. A cleanup-backed storage epoch is recovered as one source local when the value is really used and every path from that definition ends the current epoch either at the compiler nil cleanup or at function terminal, with at least one path proving the cleanup. A later physical-register write after that boundary is a new epoch and cannot retroactively erase the earlier source binding. This preserves per-iteration and branch-local closure objects instead of duplicating anonymous function creation at each call.

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

Fresh-CF while recovery recognizes loop-control edges only inside an already-proven compiler while region. A body path that reaches the proven loop final becomes source `break`. Every proven body-to-check back-edge is treated as an iteration-ending path; branch-local paths retain explicit source `continue`, while only a redundant final top-level `continue` at the reconstructed loop tail is omitted as ordinary fallthrough. This removes the old requirement to guess one unique physical latch and supports several `continue` sites dynamically. A body edge may instead leave the natural loop into a closed acyclic terminal-return region; that region is accepted only when every path ends in the compiler return-pack + stop form, after which existing terminal folding renders the source `return` in its original nested branch. An off-core abrupt-only subregion may mix `break` and `return` arms only when the region is closed and acyclic and every leaf is either a dedicated compiler break-cleanup jump to the proven loop final or a proven compiler return-pack + stop; cycles, direct unproven conditional exits, and edges back into the loop core reject. Loop-only abrupt-path folding can turn sibling break/continue paths into guarded effects before a local join, and a loop-only deepest-sibling fallback handles N-way joins with missing terminal arms; both are disabled for ordinary non-loop conditionals. A structured loop join that becomes ready before an opposite terminal-only sibling has finished is deferred only when that sibling is proven closed, acyclic, internally predecessor-closed, disjoint from the synthetic body join, and disjoint from the loop's normal exit. Deferral applies only to real multi-candidate joins, so terminal leaves cannot form scheduler cycles. The special rule that prevents a synthetic body-join `continue` from being folded into a terminal sibling is limited to loops with exactly one proven body-to-check backedge; multi-backedge loops retain the existing abrupt folding needed for explicit `continue`/`break` versus `return` branches. Compiler cleanup statements disappear only after the associated source lifetime is proven. Equivalent source layout may use guard `if` statements or an `else` around the non-terminating sibling path when VM control flow no longer proves the exact lexical surface form, but evaluation/control semantics are preserved.

### Root captured-local reads during pending multi-return packs

Fresh CF now treats a proven root read `upvalueValues[cell]` as neutral bookkeeping while a compiler multi-return pack is pending, but only when `cell` is already mapped to a proven root source binding by `allocUpvalue` + `upvalueValues[cell] = value`. This preserves call order while allowing compiler-shuffled captured-local reads to occur between pack slot extractions.

Verified on the user opcode/closure/TCO fixture: proven root `upvalueValues[cell]` reads, bare `cell = allocUpvalue()` allocations, and proven self-cleanup `cell = releaseUpvalue(cell)` can cross pending compiler multi-return pack bookkeeping without forcing an early flush. `releaseUpvalue` is accepted only when the destination and sole argument are the same already-known upvalue cell, never `state`/`ReturnVal`; arbitrary calls remain barriers. The extended call/TCO fixture now passes fresh CF and the emitted source parses successfully. Proven `createClosureN(entry, captures)` creation can also interleave with older pending return packs when its result has a unique future cleanup-backed source-local handoff and every still-live older return pack is already tracked as pending. The closure source declaration is deferred behind a pack-order barrier: older packs emit first, the closure emits at its original relative point, and any later-created packs emit afterward. This prevents source call/closure reordering while supporting Prometheus statement shuffling. The large table/return fixture that previously stopped at `ReturnVal = createClosure4(...)` now passes all 14 normalized states and its emitted source parses. Proven ordinary calls can also cross older pending multi-return packs when the callable/arguments already render safely and the call result is either a unique cleanup-backed handoff or is observably discarded through only dead register copies. Source emission uses the same pack-order barrier as closures, but active pack order is read directly from `pendingPacks` rather than rescanning `exprKinds`; this remains correct when a pack register has already been reused for slot 1 and avoids an unnecessary full provenance scan per call. Pure dead register copies may cross the pack only when the destination is not state/ReturnVal, is not cleanup-backed source storage, and has no observable downstream use. The expanded field/method fixture gets past the previously failing `floor(pi)` call group. Fresh CF now also supports a proven closure handoff into a reused physical register when the destination starts a new terminal-live epoch: the closure result is copied into a non-cleanup-backed ordinary register, that new epoch has at least one real use, no later redefinition reaches it, and the binding remains live only to the root function terminal. The prior physical-register lifetime is ignored after the overwrite, but the handoff copy itself must be consumed exactly once before terminal retirement. This fixes the `createClosure0(...) -> reused r81 -> r81()` shape dynamically. Fresh CF now also supports closure results handed directly into a proven allocated-but-unbound upvalue cell while older return packs are pending: it proves the future `upvalueValues[cell] = temp` store, allocates the recovered source binding at the closure evaluation point, maps the cell immediately so later captures/reads resolve to that same binding, and treats the eventual cell store as compiler bookkeeping. The closure temp may not be used or overwritten before the store, the cell must still be unbound, and the deferred store must be consumed exactly once. This fixes the expanded fixture's `createClosure5(9, { r71, r91 }) -> upvalueValues[r93] = ReturnVal` shape dynamically. The fixture now advances beyond that closure/capture region. Fresh CF also permits a pending-pack crossing for a pure TEMP producer only when the entire produced value epoch is provably dead through copies until overwrite: the RHS must be structurally side-effect-free, must not depend on an active return pack, and every use of the TEMP must be a dead copy chain. Calls, index reads, function creation, and other effectful/identity-sensitive live values are excluded. This fixes the shuffled `ReturnVal = {}; o26 = ReturnVal` dead TEMP shape without duplicating table identity. The expanded 15-state field/method fixture now completes fresh CF and emits parseable source. Related pending-pack support now covers proven live plain-table constructor handoffs while preserving one table identity, dependent field writes/namecalls behind a deferred-local order barrier, stable primitive/global-load TEMPs, closure values used exactly once as table operands, and proven source-result packs even when their resulting locals are unused. Source-level dead-code elimination is not part of fresh CF: proven unused single-result/multi-result locals, nil locals, table declarations, table reassignments, and field-read locals are preserved; only compiler transport/bookkeeping is removed. Root terminal `ReturnVal = { ... }` payloads are lowered only for proven non-empty terminal payloads; when earlier pack/deferred work remains, the `return` line is held until that work is emitted so no source statement appears after `return`. Terminal-live source storage now uses the same structural ownership proof for scalar `rN` and scalarized overflow `oN`, including repeated table reassignment plus field mutation/read; pending packs only impose an emission-order barrier and are not required to establish table ownership. The completed 15-state field/method fixture still emits parseable source ending with the recovered table namecall, `print("PASSED")`, and `return 321`.
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
  beta-cf/
    ast.js
    cfg.js
    closures.js
    diagnostics.js
    direct-calls.js
    logical.js
    normalize.js
    render.js
    solve.js
    linear/
      context.js
      lifetime.js
      bindings.js
      packs.js
      render.js
      solver.js
    structured/
      context.js
      lifetime.js
      bindings.js
      tokens.js
      packs.js
      render.js
      branches.js
      terminal.js
      solver.js
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

Old/retired beta files may exist for reference. Do not silently fall back to them. `passes/beta-control-flow.js` is the compatibility facade; the active implementation is under `passes/beta-cf/`.

## 9. Normal Deobfuscation Pipeline in Detail

### 9.1 Input formatting / parsing

`main.js` loads input and normally sends it through the formatter before parse.

The parser runs in Luau mode with ranges; ranges are critical because most passes preserve source by applying targeted text edits from AST positions.

The active beta pipeline uses lean AST modes to reduce parser time and retained memory without changing generated source:
- early lexical-analysis stages keep scope and comments but omit unused source-location objects
- later structural stages keep ranges but omit scope, comments, and locations once lexical binding recovery is complete
- the public/default normal pipeline still returns the full final AST unless its caller explicitly requests the lean structural result
- when a stage returns unchanged source text, the prior AST is reused instead of parsing the identical text again

The external formatter still runs once before parsing. Its temporary output is removed in a `finally` path on success or failure, so repeated runs no longer accumulate formatter files in the system temp directory.

`main.js` exposes these lean parse modes as explicit options. Keep the full parser for callers that need complete AST metadata; use the lean modes for internal source recovery after the required lexical facts are already established.

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
1. identify proven compiler `{ call() }` return packs and their static numeric slot reads
2. pull live-in `ReturnVal` snapshots before independent work and canonicalize proven pack-slot reads (slot 1, slot 2, ...) without crossing RAW/WAR/WAW hazards
3. sink pure primitive producers toward next touch
4. pull register-copy consumers toward nearest producer; proven `dest = ReturnVal` snapshots are movable even when `dest` is cleanup-backed source storage, because the snapshot itself is a pure VM-local handoff
5. compact producer/consumer gaps by moving only independent pure assignments
6. sink unread pure assignments toward next overwrite or state tail

The scheduler NEVER deletes these assignments merely because they look dead.

Return-pack scheduling is deliberately narrower than treating arbitrary table indexing as pure. A pack is recognized only from a direct compiler-shaped `pack = { call(...) }` definition; only static positive numeric reads from that still-unmodified pack are marked as compiler pack-slot reads. These reads may be reordered only by normal register-hazard proof and never before pack creation. This lets a shuffled `ReturnVal = pack[2]; state = pack[1]` become canonical and then lets a delayed source handoff such as `sourceVar = ReturnVal` move beside the exact `ReturnVal` definition, including when `sourceVar` has a final nil cleanup. Generic user-table index reads remain non-delayable.

After generic scheduling it may also:
- move a proven direct numeric state transition to the physical tail when safe
- move a proven return payload immediately before final `state = nil` across only pure compiler bookkeeping

Validation step reconstructs whether every inversion is legal. If validation fails, original segment order is kept.

Scheduler performance rules:
- nearest direct producers are found with one reverse scan per consumer rather than one reverse scan per read register
- final RAW/WAR/WAW validation projects accesses per register in linear time: writes must retain order and every read must remain between the same surrounding writes; read/read reordering remains allowed
- the output newline convention is detected once per source instead of rescanning the complete source for every changed dispatcher leaf

These are proof-equivalent changes. They do not weaken the dependency validator or alter scheduling output.

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

## 11. Fresh CF Modular Architecture and Entry Flow

`passes/beta-control-flow.js` is intentionally a small compatibility facade. It preserves the public solver, direct-call, linear-matcher, overflow-normalizer, and unsupported stub exports. New implementation logic belongs under `passes/beta-cf/`.

### 11.1 File ownership map - which file contains which work

Use this map before editing Fresh CF. Put new work in the file that owns the behavior instead of growing the compatibility facade or duplicating proof logic in another module.

Public entry and shared work:

- `passes/beta-control-flow.js`: compatibility facade only. It preserves the existing public exports and unsupported feature stubs. Do not put solver implementation here.
- `passes/beta-cf/solve.js`: top-level entry flow and the ordered choice between closure, logical, structured, linear, and direct-call recovery.
- `passes/beta-cf/ast.js`: stateless AST/source helpers, literal decoding, safe identifier checks, source slicing, table helpers, and unary helpers.
- `passes/beta-cf/normalize.js`: dispatcher extraction, normalized state leaves and transitions, one-state unwrapping, and static overflow-register normalization.
- `passes/beta-cf/cfg.js`: the shared `StateGraph` builder plus reachability, predecessor/successor, and unique-path queries.
- `passes/beta-cf/logical.js`: compiler short-circuit logical-value graph flattening and reduction. Source `if` branch reconstruction does not belong here.
- `passes/beta-cf/closures.js`: simple and recursive multi-state closure recovery, capture mapping, recursion/cycle guards, and consumed-state transactions.
- `passes/beta-cf/direct-calls.js`: strict direct global/member call recognition and its terminal bookkeeping.
- `passes/beta-cf/render.js`: final whole-program and recovered-function text rendering shared by both solver paths.
- `passes/beta-cf/diagnostics.js`: stable fail-closed results and unsupported-state diagnostic messages.
- `passes/beta-cf/control/while.js`: Prometheus while natural-loop discovery, compiler-while signature proof, inner-first loop collapse, break/continue edge classification, loop-carried storage-start proof, and anti-matching for numeric/generic for shapes.

`StateGraph` contract:

```text
{
  entryId,
  blocks,        // id -> { id, body, transitionIndex, transition }
  successors,   // id -> target ids
  predecessors, // id -> source ids
  reachable     // ids reachable from entryId
}
```

Transitions are `{ kind: "jump", target }`, `{ kind: "branch", conditionRegister, onTrue, onFalse }`, or `{ kind: "stop" }`. Shared queries provide reachability and unique linear-path proof. Future control-flow features consume this contract rather than rediscovering graph edges.

Linear recovery (one normalized state / straight-line statement order):

- `passes/beta-cf/linear/context.js`: builds the explicit linear context: source/leaf identity, future-event indexes, register epochs and cleanup evidence, expressions, binding names, pending packs, deferred copies, terminal locals, output, counters, and diagnostic options.
- `passes/beta-cf/linear/lifetime.js`: future reads/writes, cleanup, last-use, dead-copy, terminal-epoch, and overwrite proof.
- `passes/beta-cf/linear/bindings.js`: source-local allocation and naming, predeclaration, active ownership, emitted lines, and emission barriers.
- `passes/beta-cf/linear/packs.js`: pending multi-return slot ownership, display-name reservation, and source-order flushing.
- `passes/beta-cf/linear/render.js`: expression, call-argument, and member rendering against the linear context.
- `passes/beta-cf/linear/solver.js`: the straight-line statement loop, delegation to the modules above, and final terminal validation.

Structured recovery (multiple normalized states / branching paths):

- `passes/beta-cf/structured/context.js`: builds the explicit structured context: shared graph, environments, global/path-local bindings, displays, branch and terminal candidates, pack reservations, capture/parameter names, output, counters, and lifetime caches.
- `passes/beta-cf/structured/lifetime.js`: cross-path reads, cleanup, stable terminal epochs, future writes, and persistent-storage proof.
- `passes/beta-cf/structured/bindings.js`: source displays, active and path-local identity, captures, upvalue aliases, and function parameters.
- `passes/beta-cf/structured/tokens.js`: non-renderable internal pack tokens; this keeps binding code independent from pack implementation.
- `passes/beta-cf/structured/packs.js`: structured multi-return and vararg transport, expected slots, future extraction/owner preclaims, delayed activation, and flushing.
- `passes/beta-cf/structured/render.js`: expression rendering for values proven by the structured context; internal pack tokens are rejected here.
- `passes/beta-cf/structured/branches.js`: candidate merging, root ordering, `elseif`, absent-arm versus explicit-empty-arm proof, and source conditional rendering.
- `passes/beta-cf/structured/terminal.js`: sibling terminal matching, early and guard returns, terminal collapse, and terminal-path folding.
- `passes/beta-cf/structured/solver.js`: graph-block processing, candidate-environment propagation, delegation to branch/terminal/pack logic, and final validation.

Fast routing for future changes:

- public API compatibility -> `passes/beta-control-flow.js`
- recovery strategy order -> `passes/beta-cf/solve.js`
- AST shape recognition -> `passes/beta-cf/ast.js`
- normalized dispatcher/state decoding -> `passes/beta-cf/normalize.js`
- graph/path questions -> `passes/beta-cf/cfg.js`
- short-circuit `and`/`or` recovery -> `passes/beta-cf/logical.js`
- closure/upvalue recovery -> `passes/beta-cf/closures.js`
- one-state locals/calls/tables/packs -> the matching `passes/beta-cf/linear/` module
- multi-state locals/calls/tables/packs/conditionals/returns -> the matching `passes/beta-cf/structured/` module
- final program/function layout -> `passes/beta-cf/render.js`
- unsupported/failure reporting -> `passes/beta-cf/diagnostics.js`
- proven Prometheus while / nested while / loop break+continue -> `passes/beta-cf/control/while.js` plus shared structured lifetime/branch rendering
- focused behavior regressions -> `tools/test-beta-control-flow-fresh.js`, `tools/test-beta-control-flow-if.js`, and `tools/test-beta-control-flow-while.js`; register, binding, upvalue, version, graph, and semantic-name regressions remain in their matching `tools/test-*.js` suites

Important isolation rules:
- logical result-carrier diamonds are reduced in `logical.js`; statement-level branch recovery does not classify them as empty source branches
- structured pack tokens never render as source and pack ownership never lives inside branch recovery
- terminal paths are kept separate from continuing candidates and are merged only by `terminal.js`
- closure recovery calls the same entry-parametric structured solver through a narrow callback contract, independent of whether the parent construct is a conditional or a future loop
- a small amount of coupling remains intentionally in each solver's statement loop because evaluation order is decided at the exact compiler-statement position; cross-cutting proof and mutable state still live behind explicit context/module boundaries

Loop recovery remains modular. `control/while.js` now owns proven Prometheus while recovery and consumes `StateGraph` plus narrow structured-solver options for lifetime/control effects. Future `repeat`, numeric-for, and generic-for support must remain separate modules such as `control/repeat.js`, `control/numeric-for.js`, and `control/generic-for.js`. They must not duplicate private `elseif`, structured-pack, upvalue-transport, or closure-transaction internals. Unsupported/ambiguous loop shapes continue to fail closed.

Before adding any new recovery feature, run syntax checks for every changed/new JavaScript file, all twelve tracked Fresh-CF/if/register/binding/upvalue/version/graph/semantic suites, relevant real Medium runtime-parity fixtures, randomized layout stress for the touched shape, and `git diff --check`.

`solveFreshSource(source, ast)` currently does approximately:

1. require normal output source + AST
2. find semantically named VM
3. normalize remaining static RegisterOverflow AST references to `oN`; reject dynamic overflow indexes
4. identify `state` parameter
5. identify `ReturnVal`
6. find `while state` dispatcher
7. try closure-entry program recovery; closure roots may first use the mixed structural solver with root-only reachability and the existing child-closure renderer
8. try fully reducible root logical flattening and multi-state logical/local recovery
9. try proven `if` / `if/else` / same-join `elseif` / recursive nested-if recovery; this path first reduces closed compiler logical-value subregions before structuring source conditionals
10. if none applies, require one-state leaf
11. try register/local program recovery
12. try direct global-call recovery
13. if direct call path fails, retry register program allowing zero source locals for call-result statements
14. otherwise fail closed with detailed diagnostic reason

Current modes include:
- `fresh-closure-entry`
- `fresh-multistate-logical`
- `fresh-simple-if`
- `fresh-register-locals`
- `fresh-call-results`
- `fresh-direct-global-call`

Fresh-CF performance rules:
- build immutable per-register future-event indexes once for each flattened leaf instead of rescanning the remaining leaf for every candidate value
- index initializer reads, indexed-destination reads, ordinary writes, and nil writes separately so each proof query preserves its original read/write ordering and exact stop condition
- resolve the next relevant event by binary search; do not replace semantic proof with a looser global use count
- direct `tools/beta-control-flow.js` parsing uses range-only structural ASTs because fresh CF does not require comment, lexical-scope, or source-location metadata at that point

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
- an erased in-place TEMP->VAR promotion when Prometheus reuses the expression TEMP as the source VAR: `getVarRegister(..., potentialId)` may mark that physical register VAR-owned and `copyRegisters(varReg, exprReg)` emits no statement when the ids are equal. Fresh CF proves the narrow no-reassignment form structurally: the candidate is a direct non-copy/non-nil definition of a cleanup-backed register and the very next write to that same physical register is its compiler nil cleanup. Earlier TEMP epochs on that physical register do not become source storage merely because the later VAR lifetime cleans up; when a later direct-promotion start is proven, earlier cleanup-backed promotion heuristics for that register are suppressed. Pack-slot extraction stays on its specialized multi-return path rather than being consumed by this generic proof.

Future-copy/lifetime queries use the leaf event index documented above. `valueUsedBeforeOverwrite`, later-cleanup detection, terminal-unread proof, future cleanup-backed copies, terminal closure copies, terminal unused copies, and deferred upvalue closure stores all retain their prior proof conditions while avoiding repeated whole-leaf scans. AST identifier walks used outside those indexed queries remain uncached to limit retained-memory growth; on the 2,000-local solver-only comparison the index added about 1.1 MB heap, while the complete direct command still used less memory because its structural parser removed larger unused AST metadata.

Once local is active:
- writes become source assignments
- final cleanup removes active local instead of emitting source `= nil`
- a proven terminal-live source-storage lifetime may instead end at the root terminal when compiler structure proves there is no later physical-register reuse

Source-storage lifetime is distinct from value liveness. A source local may own multiple sequential value epochs, for example `local t = {}; t = {1}; t = {2}`. Fresh CF must preserve those source statements even if an earlier value is never read before the next assignment. It must not use `valueUsedBeforeOverwrite`/dead-result reasoning as permission to delete a proven source declaration or assignment.

Persistent table-storage ownership is proven structurally from TEMP/POS/RETURN/table-value handoffs into one VM storage register plus compatible later reassignment/mutation/read behavior. This proof is independent of pending multi-return packs: pending packs affect only when a recovered source line can be emitted. After overflow scalarization the same rule applies to `rN` and `oN`; the storage bank is irrelevant.

Terminal source aliases are also preserved instead of inlined when a special compiler transport (`state`/`ReturnVal`) is copied into stable ordinary VM storage and the later lifetime proves persistent source ownership. This covers source such as `local math = math`, `local newproxy = newproxy`, `local floor = math.floor`, `local pi = math.pi`, stable primitive aliases such as `local f = false`, and terminal-live nil source storage copied from `ReturnVal`. The recovered names remain generated presentation names (`vN`), but later source expressions use those bindings rather than substituting the original global/member/literal. The proof is deliberately narrower than "special register copied to ordinary register": it rejects POS save/restore, immediately consumed one-use operands, one-use callable stabilization (including calls nested inside compiler return-pack tables), and a sole logical-expression use because that can be compiler short-circuit transport. Repeated stable use across distinct logical source expressions can prove the binding when no later redefinition occurs. This preserves source like `local b; local x = b or c; local y = not b or c` as one recovered `b` binding instead of substituting literal `nil`. The same rule applies to scalar `rN` and scalarized overflow `oN`.

At terminal, cleanup-backed locals must have ended normally, while specifically proven terminal-live storage bindings are retired at root terminal. Any other still-live recovered local is a proof failure, not silently dropped.

Latest randomized validation for the straight-line lifetime/pack change: 500 fresh Medium layouts passed with repeated exact runtime parity across the 2-state straight-line reuse/local-function/multi-return fixture, 65-state nested/sequential `if/elseif/else`, 28-state conditional storage, shadowing `pcall` multi-return, and direct call-local promotion. An additional supported 19-state TESTSET/short-circuit `and/or` fixture passed 100/100 fresh Medium layouts. This mixed gate is intentional so register-lifetime changes are checked against logical and conditional recovery immediately.

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
- each source-result slot can be traced to proven source storage, including cleanup-backed or terminal-live ownership
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

For a unique future TEMP -> cleanup-backed storage handoff, the source call/declaration is emitted at the actual call-evaluation point and the later VM copy is treated as storage bookkeeping. This preserves call order while allowing compiler shuffling. Pack provenance is preserved until all needed slots are recovered; reserving the pack register as source storage must not erase its still-live `return-pack` identity. Direct cleanup-backed slot registers likewise retain `pack-slot` provenance until flush. If a later call reads a pending pack slot that is already proven to become a source local, that call may not render/defer across the pending-pack barrier: Fresh CF flushes/maps the multi-return declaration first so the call uses the recovered locals instead of duplicating the original call expression once per slot. Ambiguous/multiple handoffs still fail closed.

A pending multi-return declaration may also survive a compiler-shuffled borrowed-POS global load between slot extractions. Fresh CF accepts `state = _env[key]` across exactly one active pending pack only when the key is already proven, the load does not depend on that pack, and another unextracted static slot from that same pack is reachable before any later `state` touch or pack-register overwrite. This fixes source shadowing such as `local a, b = pcall(a, "asdsa")` when slot 1 becomes the newly shadowing `a`, slot 2 is unused and immediately cleaned, and setup for the following call is shuffled between the two slot reads. If slot 1 must be referenced by deferred source before pack flush, its presentation binding is attached to the pending slot; pending display names are reserved in pack-creation/slot order, and flush explicitly rebinds every still-active slot local while leaving already-cleaned unused slots retired. The exact vararg/pcall shadowing fixture passed 10/10 randomized Medium recompiles with exact runtime parity; the non-shadowing variant and the 130-state stress fixture also retain runtime parity.

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

Closure-aware root recovery first tries a proven `while` program with the same transactional child renderer before the ordinary mixed-structured and legacy linear closure paths. This is required when `createClosureN(...)` occurs inside a root loop body: failed speculative child renders are rolled back, successful children claim only their proven entry-state set, and synthetic loop join IDs never participate in public closure/state accounting.

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

Inside `renderSimpleClosureLeaf`, a locally allocated upvalue cell represents source binding identity, not its current value. For a proven `cell = allocUpvalue(); upvalueValues[cell] = initialValue`, a non-argument initializer now creates a generated source local (`local vN = initialValue`) and `localCells` stores that binding name. Later direct reads `upvalueValues[cell]` resolve to the same name, later writes emit assignments to that same name, and nested closure capture tables pass that name through recursively. Captured function arguments are the special case: `upvalueValues[cell] = args[N]` maps the cell directly to the recovered parameter name without emitting a duplicate local. This prevents invalid/value-inlined recovery such as `5 = 5 + a` and preserves mutable captured locals as real source bindings.

## 19. Fresh CF Logical Multi-State Recovery

Fresh CF currently has two limited mechanisms for compiler-generated logical control flow.

### 19.1 Root logical flattening

`flattenLogicalRootLeaf` follows a sequence of root states and recognizes a narrow short-circuit region when:
- branch shape is recognized
- one branch flows directly to a join
- alternate branch contains the expected result assignment and then joins
- relevant result register relationship is proven

It reconstructs an `and`/`or` expression and continues flattening. When strict flattening consumes every normalized root state, the resulting straight-line leaf is now handed to the full `matchLocalRegisterProgram` recovery path before the narrower DAG matcher. This lets proven short-circuit regions compose with large post-join programs containing arithmetic, comparisons, calls, multi-return packs, globals, and normal local lifetimes.

A short-circuit alternate branch may also contain the compiler-only captured-local transport `temp = upvalueValues[cell]; ReturnVal = temp` before its jump to the join. Fresh CF proves this exact two-statement shape structurally, embeds the upvalue read as the lazy logical RHS, and later resolves it through the already-proven upvalue cell binding. Root logical flattening now also follows recursively nested Prometheus `AndExpression`/`OrExpression` templates such as `a and b and c` and `a or b or c`, including the compiler case where a child logical join is fused with the parent branch or where the final join immediately starts the next logical source expression. The proof is still template-bounded: the branch state must contain the compiler result copy `resultReg = conditionReg`; exactly one immediate successor must be reachable from the other as the lazy-RHS path to the join; the lazy path must reduce entirely to assignments feeding that same result register except compiler POS save/restore; and path-dependent temporaries may not remain live into the join. Synthesized nested logical AST nodes are explicitly marked and only those proven nodes receive recursive rendering. A real Medium fixture for captured `a and b` recovers as `(v1 and v2)`, and a 9-state real Medium fixture with chained `and` followed by chained `or` recovers both expressions; five randomized recompiles also passed.

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

It also preserves compiler-lowered source calls whose return value is
discarded. A path-aware liveness query proves whether a call result is read
before overwrite; an unconditional continuation call is emitted exactly once,
and a cleanup-backed value used as its argument is promoted before that call
when the terminal cleanup would otherwise reorder the declaration. A discarded
call on a path-dependent branch is rejected because this matcher cannot emit a
bare conditional statement safely. The eventual compiler cleanup is consumed
for every early-promoted value so it cannot create a duplicate declaration.

It is intentionally conservative.

### 19.3 Mixed logical + conditional CFG composition

When `allowConditionalIf` is enabled, Fresh CF performs a proof-preserving logical CFG reduction before conditional marker propagation. This is the bridge between TESTSET-style value production and source statement control flow.

Dynamic classification rule:
- decode the generic `state = condition and A or B` transition without assuming its source role
- require an explicit compiler result-carrier copy from the same branch condition before treating the branch as a logical-value producer
- prove exactly one branch successor is a lazy path that reaches the other successor as the join
- reuse strict logical flattening to prove the whole region reduces to that result carrier and stops at the join
- require the region to be closed against external predecessors/escapes
- collapse only that region into a synthetic `freshCompilerLogical` AST assignment and direct join jump
- leave branches without that proof untouched for `if/elseif/else` structuring

The synthetic logical AST is the only form that enables recursive expression rendering in the mixed solver. Ordinary unproven logical ASTs retain the conservative renderer. This prevents a broad recursive-expression relaxation.

Closure-aware mixed recovery scopes CFG/lifetime analysis to states reachable from normalized root entry 1. Child closure entry states are rendered by the existing `createClosureN` path and are excluded from root cleanup/definition evidence, because different VM invocations reuse the same physical `rN` names. All root-reachable original states plus every consumed child closure entry must account for the complete normalized leaf set before closure recovery succeeds.

Persistent storage remains epoch-sensitive. A physical register that belongs to a later persistent source lifetime does not retroactively make an earlier branch TEMP write persistent. A persistent binding may start only on a marker-free definition; branch-local storage still requires its separate cleanup-backed path proof. This matters for layouts where one register is an arithmetic TEMP in one region and the later source local (for example the final logical result) in another.

Verified regression anchors:
- focused normalized 7-state real-Prometheus shape: child closure + `and` value + consuming `if/else`
- full 55-state real fixture: side-effecting chained `and/or`, nested `if/elseif/else`, persistent mutations, and a post-conditional logical initializer
- both recover through `fresh-closure-entry` with source/obfuscated/recovered runtime parity

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
- `collapseCompilerRepeatLoops`
- `matchCompilerRepeatConditionRegion`
- `removeDuplicatedRepeatConditionRegions`
- `collapseCompilerStructuredLoops`
- `forwardControlOnlyJoinBranches`
- `removeCompilerPosPreservationOperations`

Therefore do NOT claim full support for:
- arbitrary `if` regions beyond proven recursive same-join `elseif` chains and distinct two-way joins; branch-local/persistent declarations and assignments are supported only for cleanup-proven storage epochs/merges, while ambiguous lifetime, escaping, or path-dependent storage remains fail-closed
- arbitrary/unproven `while` CFGs outside the compiler natural-loop/signature proof
- general `repeat`
- numeric `for`
- generic `for`
- arbitrary nested control flow outside the proven conditional/while composition
- break/continue outside a proven compiler while region or with ambiguous loop-control edges

Limited compiler short-circuit multi-state logic now composes with the proven `if` / `if/else` / same-join `elseif` / recursive nested-if shapes through the closed logical-region reducer documented above. This is still template-bounded structural recovery, not arbitrary CFG structuring.

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

For every future pipeline addition or performance change:
1. benchmark an existing small/medium fixture and at least one large representative input before editing
2. use CPU profiling to rank parser, formatter, scheduler, and recovery costs instead of guessing
3. compare SHA-256 hashes of normal and fresh-CF outputs before/after; required result is byte-identical unless the task explicitly changes output
4. measure process memory on a representative large input when AST retention/allocation behavior changes
5. reject speedups that weaken semantic proof, diagnostics, or fail-closed behavior

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

The full 15-state opcode/call/closure/table fixture was recompiled with Medium and now preserves terminal source aliases as generated locals: a `math` binding, `newproxy` binding, `math.floor` member binding, `math.pi` member binding, `false` binding, and the terminal-live nil binding used by the two TESTSET-style expressions are emitted separately and reused by later expressions/calls. The logical lines recover as generated-binding equivalents of `b or c` and `not b or c`, not `(nil or c)` / `((not nil) or c)`. The recovered output contains no direct `math.pi` or `math.floor` substitutions in those later operations, still completes all 15 states, and parses successfully. Focused negatives verify that ordinary one-use call arguments, one-use short-circuit transports, table-constructor operand temps, and interleaved return-pack callables are not falsely promoted to source aliases.

A minimal captured-upvalue short-circuit fixture (`local x = a and b` where `a`/`b` are captured by a child closure) passes Medium -> normal -> fresh CF, with focused regression coverage for both `and` and `or` branch polarity. The previously failing alternate state `temp = upvalueValues[cell]; ReturnVal = temp; state = join` is folded into the logical RHS without exposing the compiler TEMP. Chained/fused logical CFGs are now also supported: a real 9-state Medium fixture containing `a and b and c` immediately followed by `d or e or f` recovers both logical locals, and 5/5 randomized Medium recompiles passed. The larger 130-state stress fixture now flattens all 119 root logical states. Scheduler canonicalization of proven compiler return-pack slots + `ReturnVal` source handoffs gets past the former `local r1, r2 = getTwo()` multi-return blocker, and `solveBetaControlFlow` applies across all 130 states. Nested mutable captured locals are now preserved as bindings instead of inlined values: the `nestedUpvalue` source shape recovers `local v1 = 5`, mutates `v1` inside the returned child closure, and returns that same binding. The complete recovered 130-state output parses and matches the original fixture at runtime. A minimal real Medium nested-mutable-upvalue fixture also passed 5/5 randomized recompiles with runtime parity.

The exact shadowing/vararg fixture below is also a current regression anchor:

```lua
print("HI")
local a = function(...)
    print(...)
    return 1, 2, 3, 4, function()
        return GLOBAL
    end
end
local a, b = pcall(a, "asdsa")
print(pcall(a, "WWWW"))
```

Fresh CF must recover the second `a` as the first result of `pcall`, preserve unused `b`, and make the later `pcall(a, "WWWW")` call the newly shadowing boolean binding. Current implementation passed 10/10 randomized Medium recompiles with exact runtime parity. The recovered presentation shape is `local v2, v3 = pcall(v1, "asdsa")` followed by `print(pcall(v2, "WWWW"))`.

## 31. Current Baseline / Next-Chat Snapshot

This section is the shortest current-state handoff. Read the detailed sections above for implementation rules.

### Current branch / Git truth

- branch: `main`
- remote: `origin/main`
- current feature/code baseline is the latest commit containing this `CONTEXT.md`; verify exact Git truth with `git log -5 --oneline` rather than relying on an older hardcoded hash
- immediately preceding relevant handoff/recovery commits include `e12bbf5 Refresh active Fresh-CF handoff` and `795f1b5 Recover recursive structured closures`
- current tracked behavior includes closed logical-CFG reduction, structural early returns, recursive multi-state closure recovery, structured multi-return/vararg transport, and empty conditional-clause preservation
- important historical semantic baseline: `7375421 Refine nil register lifetimes`
- do not reintroduce discarded experimental CF changes merely because they exist in Git history

### Current unrelated user work to preserve

As of the 2026-09-05 validation pass, unrelated tracked work must still be preserved. Untracked `_tmp_*.lua` source fixtures may be intentionally retained when they are useful for real-Medium stress/reproduction, but task-local patch/debug/trace/backup scripts and generated temp outputs are disposable. Once a behavior has durable tracked regression coverage and the temporary artifact is no longer needed, delete that artifact instead of accumulating stale debug copies. Preserve unrelated/user-created temp material unless it is proven disposable or the user explicitly requests its cleanup.

### Workspace cleanup state

The 2026-09-02 handoff cleanup intentionally removed generated material so future chats should not depend on stale probes:
- removed 5,222 clearly generated/untracked temp/probe/output files (over 807 MB)
- removed the entire tracked/ignored `output/` tree; output is generated material and should be recreated as needed, not used as authority
- removed 41 tracked `sample/*.source.obfuscated.lua` generated compiler outputs that had matching `sample/*.source.lua` fixtures and no tracked references
- preserved all tracked `sample/*.source.lua` and `sample/*.txt` fixture/source material
- preserved unrelated tracked user edits `main.js` and `formater/input.txt`
- preserved ambiguous untracked work `opt/`, `opti/`, and `sample/input.txt`

Do not assume a missing old `_tmp_*`, `.normal.lua`, `.beta.cf.lua`, `.obfuscated.lua`, debug graph, profile, or output file is a lost project dependency. Recreate probes from source/compiler when needed. Do not commit regenerated output unless explicitly requested.

### Current known-good functional state

As of 2026-09-04:

- the complex logic/upvalue stress fixture has 130 normalized states total, with 119 root logical states plus closure states
- chained/fused `and`/`or` flattening works across that root graph
- scheduler canonicalization handles shuffled compiler return packs and `ReturnVal` source snapshots used by that fixture
- nested mutable captured locals are preserved as real bindings, not initializer literals
- the complete recovered 130-state output parses and matches the original source at runtime
- captured-upvalue `and`/`or` fallback fixtures pass
- terminal nil locals used in TESTSET-style logic remain source bindings instead of being substituted with `nil`
- source aliases such as `local math = math`, member aliases, booleans, and proven nil aliases are preserved rather than inlined
- persistent table source storage survives reassignment/mutation/read without requiring a pending return pack
- scalar `rN` and scalarized overflow `oN` use the same fresh-CF semantic register rules
- multi-return packs survive compiler interleaving, including unused slots, cleanup-before-flush, shadowing, and borrowed-POS global loads between proven slot extractions
- exact shadowing vararg/pcall fixture passed 10/10 randomized Medium builds with exact runtime parity
- non-shadowing vararg/pcall variant passes
- minimal nested mutable-upvalue fixture passed 5/5 randomized Medium builds with runtime parity
- chained logical real Medium fixture passed 5/5 randomized builds
- current core suites pass:
  - `node tools/test-beta-control-flow-fresh.js`
  - `node tools/test-vm-register-scheduler.js`
  - `node tools/test-vm-state-reachability.js`
  - `node tools/test-vm-register-names.js`
  - `node tools/test-vm-register-overflow.js`

Current performance baseline after the 2026-09-02 pipeline optimization:
- `sample/63.txt` normal pipeline, 5 interleaved process runs: median 1.27 s before, 1.02 s after, 19.2% faster; SHA-256 output identical
- `sample/spacial5.txt`, 3 interleaved process runs: median 3.74 s before, 2.66 s after, 28.8% faster; SHA-256 output identical
- `sample/spacial6.txt`, one large 6.65 MB run: 14.30 s before, 12.51 s after, 12.5% faster; 8,685,928-byte output and SHA-256 identical
- `sample/spacial5.txt` post-run memory: RSS 460.0 MB before versus 367.3 MB after; heap used 329.6 MB before versus 246.2 MB after
- full Medium obfuscation -> normal -> fresh-CF on the shadowing vararg/`pcall` regression: 0.824 s before versus 0.407 s after in one paired run; normal and fresh-CF hashes identical; source, obfuscated, and recovered runtime output identical
- profiling authority: repeated parsing was 30-40% of CPU before the change; scheduler reached 31%; formatter was 9-13%; remaining whole-tree passes were individually lower impact
- fresh-CF one-state stress fixture with 2,000 locals and 4,000 recovered source statements: solver-only median 7,413.9 ms before versus 94.2 ms after, 78.7x faster; direct CF command median 9.913 s before versus 0.219 s after, 45.2x faster; recovered SHA-256 identical
- the same fresh-CF stress run reduced direct-command RSS from 149.6 MB to 138.1 MB and heap use from 53.2 MB to 51.5 MB
- a runnable 150-local real Medium fixture produced byte-identical old/new fresh-CF output and exact source/obfuscated/recovered runtime parity across 150 output lines
- the real 401-state logical stress fixture now recovers all 100 source locals and all 100 following `print` calls in source order; the recovered output has 200 statements and exact seeded runtime parity with the source and obfuscated programs
- the same 401-state Fresh-CF solver remains fast after call-preservation support (7-run solver median 105.9 ms with the lean structural AST)
- conditional recovery supports direct/call conditions, cleanup-backed local conditions, top-level and nested same-join `elseif` chains, and recursively nested distinct-join `if` / `if-else`. Nested `elseif` is recovered by stripping a proven common outer marker prefix and solving the remaining N-way chain structurally, so the rule is independent of nesting depth and outer branch polarity. The previously failing 14-state real fixture containing `else { if N1 ... elseif N2 ... elseif N3 ... else { if DEEP ... } }` now recovers exactly and has source/obfuscated/recovered runtime parity. Focused tests cover nested chains on both outer false and true branches, recursive composition with a deeper inner `if/else`, and top-level/nested chains without a final `else`. Real Medium validation also covers a statement before the nested chain, proving common branch-effect prefixes are preserved. The 14-state nested-elseif fixture, 18-state deep two-way fixture, 9-state prefix fixture, and 8-state no-final-else fixture all passed 5/5 fresh randomized Medium recompiles with exact runtime parity. Existing `or`/TESTSET fixtures remain in `fresh-multistate-logical`.
- conditional storage recovery now distinguishes source lifetime from reusable physical registers. Root persistent scalar/table storage requires converged definitions, a post-join read, and eventual nil cleanup on every path. Branch-local scalar/table storage requires a stable cleanup-backed epoch with no later non-nil write and cleanup on every continuation path; its binding name lives in the path environment so sibling branches may reuse the same VM register without sharing source scope. Proven table field/index writes stay in the branch, and dead path-dependent compiler TEMPs are dropped at joins only when no later read exists. Focused regressions cover persistent scalar assignment, persistent table mutation, sibling-register reuse, and branch-local table identity. The original 28-state complex variable/table/nested-conditional fixture passed 10/10 fresh randomized Medium recompiles with exact source/obfuscated/recovered runtime parity after this fix.
- sequential root conditional recovery now proves source ordering across independent top-level `if`/`elseif` regions. Every branch marker records its originating normalized branch state; after one root region merges, the next root is accepted only if its first branch state is the same join or is reached through a chain of blocks with exactly one successor each. Any intervening branch makes the sequence fail closed. A focused normalized regression covers two root `if/else` regions with a straight-line `print` between them. The 65-state extreme nested/storage fixture plus a second top-level `if/elseif/else` passed 10/10 fresh randomized Medium recompiles with exact runtime parity, and a separate three-root fixture with scalar/table mutations between regions also passed exact parity.
- Fresh-CF Prometheus `while` recovery is implemented structurally in `passes/beta-cf/control/while.js`. In addition to the earlier simple/call/logical conditions (including the 18-state chained and/or probe), loop-carried locals, nested if/elseif/else, nested while, and break/continue support, it now handles multiple independent `continue` sites, multiple `break` sites, early `return` paths inside a loop, mixed break+continue+return nesting, and the same loop shapes inside child closure entries. A 6-state early-return Medium fixture passes exact runtime parity; a 10-state three-break fixture passes exact runtime parity; a 10-state three-continue fixture recovers all three continues structurally; a 50-state deeply nested mixed root fixture and the 51-state local-function/closure variant both recover all nested break/continue/return control flow. Final randomized Medium stress passed 25/25 layouts for each of six fixtures = 150/150 total: return, multi-break, and nested-while were 75/75 exact source/obfuscated/recovered runtime parity; multi-continue, the 50-state mixed root, and the 51-state closure-wrapped mixed case were 75/75 structural because LuaJIT is not a reliable runtime target for Luau `continue`. Median deobf+CF timing over all 150 runs was 83.3 ms; the 50-state mixed fixture median was 99.6 ms and the closure-wrapped variant 110.7 ms. Numeric-for and generic-for Medium fixtures remain unsupported and were reverified fail-closed rather than being misclassified as while. The focused `tools/test-beta-control-flow-while.js` suite now permanently covers canonical/logical while, loop-carried storage, nested conditionals, break, continue, nested while, three continue edges, early return, and child-closure while state accounting. All 13 current Fresh-CF/if/while/register/binding/upvalue/version/graph/semantic suites pass; `tools/test-text-edits.js` and `tools/test-batch-parameter-rename.js` also pass. The older `tools/test-beta-control-flow.js` still has its pre-existing line-31 legacy single-state API assertion failure and is not part of the current Fresh-CF gate.
- closure creation inside proven `while` bodies is integrated with closure-entry recovery. The tracked 5-state regression recreates a captured closure each iteration, forces the same physical register through an earlier unrelated TEMP epoch, forwards `closure(i)` through the compiler `{ call(...) }` + final `unpack(pack)` transport, and still recovers one source-local closure binding with exact runtime parity. A second tracked regression proves the harder cleanup-or-terminal lifetime: the loop-local closure is cleaned on the continuing path while a sibling branch returns before cleanup, and Fresh CF still preserves the local at its creation scope. A deep Roblox-shaped fixture using `game:GetService("Players").LocalPlayer.Character`, `character.Deep.A.B.C`, `character.Stats.*`, closures returning closures, nested `if/elseif/else`, break/continue/return, and closure creation inside the loop recovers across 47-state root, 48-state local-function wrapper, and 49-state local mocked-global variants. The source locals corresponding to `readDeep`, `f`, `nested`, and `maker` remain separate local function values at their actual loop/branch scopes and are not substituted by repeated `(function(...) ... end)(...)` calls. Fresh randomized Medium validation after the source-binding fix passed 100/100 layouts: 25/25 exact runtime parity on the minimal closure-in-loop fixture plus 25/25 structural/source-binding checks for each 47/48/49-state deep variant. A direct compiler comparison also proves the source distinction: `local a = function() ... end; a()` lowers through a cleanup-backed handoff followed by `localReg = nil`, whereas an immediately-called anonymous closure lowers as a direct `createClosureN` TEMP with no source-local cleanup. The former must be preserved as a local; the latter is an anonymous callable TEMP and may flow through the same ordinary call machinery as any other callable expression, including intervening argument TEMP production and structured child bodies. Numeric/generic `for` remain fail-closed. All 15 current focused/core regression commands used for this change pass; the old `tools/test-beta-control-flow.js:31` legacy API assertion remains the same pre-existing failure.

- dynamic closure-capture ownership is now extended through loop/branch-local upvalue cells. An `allocUpvalue()` reached under structured markers is represented as path-local compiler cell identity; `upvalueValues[cell] = value` creates or mutates the source binding at that exact path scope, `createClosureN(..., { cell })` resolves the same binding, and `releaseUpvalue(cell)` retires only that path-local cell. Both Prometheus orders are supported: initialize-cell then create-closure, and create-closure then initialize-cell. The latter uses deferred captured-closure transport so a proven child closure object may cross `state`/`ReturnVal` compiler copies without being rendered before its newly captured cell gets a source name. Path-local source locals now also carry explicit owner metadata: a compiler TEMP alias may resolve/read the same rendered binding, but only the proven owner register/cell may emit assignment or cleanup for that source local. This fixes the alias-reuse bug where a later TEMP overwrite could otherwise become a false assignment to a captured local. Explicit `state`/`ReturnVal -> register` handoff from `createClosureN` is accepted as terminal-live source-closure ownership even with one static call site; direct `register = createClosureN(...)` immediate-anonymous TEMP is now recovered as an anonymous callable expression when its use is proven, without promoting it into a named source local. Existing recursive structured tests that formerly expected `(function(...) ... end)(...)` optimization were updated to require the real source factory/local handoffs instead. Permanent `tools/test-beta-control-flow-while.js` coverage now includes per-iteration fresh capture + mutation/owner-alias safety, create-before-initialize deferred nested capture, and positive immediate-anonymous callable-TEMP coverage. Final validation after the owner tightening: all 15 established focused/core commands pass; 10/10 targeted real Medium fixtures pass (nine exact runtime parity plus one Luau-`continue` structural nested-while case); randomized Medium closure stress passed 150/150 layouts = 125/125 exact runtime parity plus 25/25 nested-while structural, with combined deobf+CF median 81.7 ms and average 80.2 ms. A separate 10-state fixture with no closures still reproduces `logical branch has no compiler result copy` for the compound/abrupt logical-conditional shape used by the newer deep identity probe, proving that remaining failure is the existing general conditional-CFG boundary rather than closure/capture ownership; keep it fail-closed and separate from this feature.

- mixed logical/conditional recovery now reduces only closed compiler logical-value subgraphs before source conditional structuring. The discriminator is structural (result-carrier copy + lazy-path/join proof + closed-region proof), not register/state IDs or source constants. This fixes the previous state-15 failure where a completed short-circuit value was consumed as an outer if condition. Closure roots are analyzed only over root-reachable states; child closure entries cannot contaminate root register lifetimes. A focused 7-state normalized regression is tracked in `tools/test-beta-control-flow-if.js`.
- final validation for this mixed-CFG change: all eight tracked Fresh-CF/if/register/binding suites pass. Five real Medium fixtures passed 100/100 randomized layouts each with repeated exact runtime parity: the new 7-state closure+logical+if fixture, the full 55-state mixed TESTSET/and/or+nested-if fixture, the existing 65-state if/elseif/else fixture, the 28-state conditional-storage fixture, and the 19-state supported TESTSET fixture. Total: 500/500 fresh randomized layouts. No fixture-specific state/register IDs are used by the reducer.

There is no known blocker in the currently supported straight-line/local/call/table/closure/upvalue/multi-return/vararg/conditional/early-return feature set represented by the established regression fixtures.

2026-09-05 terminal-loop convergence validation: the 10-state compound logical/terminal sibling case and 15-state N-way no-`continue` case recover with exact runtime parity; the 18-state deep closure/identity terminal chain and the established 47-state deep mixed break/continue/return stress recover structurally with source-shape assertions. Fresh Medium randomized validation passed 25/25 layouts for each fixture (100/100 total), with median deobf+CF 96.6 ms and average 92.8 ms. The established 15-suite regression gate also passed after the change. A separate same-preheader TEMP-reuse regression proves loop-carried storage starts at the exact final preheader definition statement, preserving `game:GetService(...).LocalPlayer.Character` instead of binding an earlier key TEMP.

2026-09-05 anonymous callable-TEMP support: Fresh CF now splits callable production from call execution. `createClosureN(entry, captures)` may populate an ordinary compiler TEMP exactly as `_env[...]` or a member lookup can; subsequent argument TEMP assignments remain ordinary expression production, and `temp(args...)` uses the existing call renderer. Anonymous function-expression call bases are parenthesized as `(function(...) ... end)(...)`. Cleanup-backed/terminal-proven source closure handoffs still recover as named locals, so this does not erase source binding identity. Permanent while/closure regressions cover direct-register anonymous calls, dispatcher-register IIFEs with no arguments, and IIFEs with argument TEMP production plus structured `while`. Final validation passed the full 15-suite gate and 70/70 fresh Medium layouts: 60/60 finite runs had exact runtime parity across direct anonymous calls, parameterized IIFEs, mutable captured outer locals, early returns, statement IIFEs with args, and named equivalents; 10/10 infinite-loop IIFEs passed structural/source-shape checks.

2026-09-05 follow-up while fix: a mixed `break`/`return` subtree can target the loop's normal exit when that same exit block also performs the function's final return. Pure terminal-return-region proof now forbids traversing the proven loop exit, so the edge is classified as `break` and the sibling direct return remains terminal. Before outer convergence, proven terminal siblings are folded into queued abrupt candidates only when the queued control is a proven `break` (not `continue`), then exact terminal folding runs again after abrupt reduction because removing one marker can expose a new sibling. This fixed the formerly unsupported 23-state `_tmp_while_deep_runtime_no_continue.lua` fixture with exact source/obfuscated/recovered runtime parity. The permanent while suite covers the loop-exit-return classification and all 15 established regression commands pass. Fresh Medium certification passed 25/25 layouts for each of four fixtures = 100/100 total: the 23-state no-continue blocker, the 10-state compound-terminal case, the 15-state terminal-elseif case, and the established 47-state deep mixed-control fixture. During cleanup, obsolete task-local debug/trace/patch/backup copies and generated `output/_tmp_*` artifacts were removed; keep useful real-Medium source fixtures, but do not let disposable debug scripts accumulate.

### Still intentionally unsupported / fail-closed

Do not claim full source reconstruction for:
- arbitrary `if` regions beyond proven recursive same-join `elseif` chains, distinct two-way joins, and linearly sequenced root regions; branch-local/persistent declarations and assignments are supported only for cleanup-proven storage epochs/merges, while ambiguous lifetime, escaping, or path-dependent storage remains fail-closed
- arbitrary/unproven `while` CFGs outside the compiler natural-loop/signature proof
- general `repeat`
- numeric `for`
- generic `for`
- arbitrary nested CFG structuring outside the proven conditional/while composition
- arbitrary N-way while convergence still fails closed when a missing sibling is not a structurally proven closed/acyclic terminal-only region (or another already-supported proven abrupt region). The previously known continuing-`elseif` + sibling-return convergence blocker is now supported dynamically under that proof; do not generalize it into arbitrary CFG guessing.
- `break` / `continue` outside a proven compiler while region or with ambiguous loop-control edges

Those remain separate future features. Limited compiler-generated short-circuit logical CFGs now compose with the proven simple `if` / `if/else` / same-join `elseif` / recursive nested-if / linearly sequenced root-conditional shapes through closed logical-subgraph reduction; this must not be generalized into arbitrary CFG guessing.

Correctness fix completed during 2026-09-02 Fresh-CF follow-up:
- the 401-state Medium fixture previously dropped every post-logical `print` call because `matchMultiStateLogicalLocals` stored discarded call results in its environment and later overwrote them without emitting the side effect
- Fresh-CF now emits proven unconditional discarded calls once, promotes their last-use cleanup-backed arguments before the call, consumes the later cleanup, and rejects path-dependent discarded calls instead of guessing
- focused regression coverage verifies 25 sequential logical/call pairs, conditional-call fail-closed behavior, exact ordering, and no duplicate calls
- the real 100-pair Medium run produced 100 locals plus 100 prints and matched source/obfuscated/recovered runtime output exactly with a fixed random seed

### Structural early return recovery — IMPLEMENTED

Fresh CF now recovers proven return-bearing conditional CFGs structurally. This composes with the existing closed logical/TESTSET reducer and does not invent synthetic joins for terminal paths.

Compiler facts verified directly in `compiler.lua` and real Medium output:
- explicit source `return` compiles the return payload into `RETURN_REGISTER` / normalized `ReturnVal`, then writes `POS_REGISTER = nil` / normalized `state = nil`; that path is terminal and bypasses later source continuation
- function fallthrough also creates an empty return pack and terminal state; after normalization an explicit final empty return and fallthrough are not always distinguishable, so Fresh CF omits only a trailing root-scope bare `return` when it is not provably source-authored
- last-expression calls/varargs use RETURN_ALL transport: compiler pack `{ call(...) }` / `{ ... }` followed by terminal `ReturnVal = { unpack(pack) }`; Fresh CF unwraps this only on the proven terminal return path

Current structural model in `passes/beta-cf/structured/`:
- terminal CFG candidates are stored separately from continuing candidates
- sibling terminal candidates collapse only when branch markers, effect prefixes, branch IDs, and polarity prove they are the two arms of the same source conditional
- one terminal arm + one continuing arm folds into a guard return while the continuing path keeps propagating
- nested and sequential return-bearing conditionals compose recursively through the same marker/effect model
- terminal paths stop propagation; they are never forced through a fake join
- proven terminal-live source aliases may end at function termination without compiler nil cleanup when their epoch is stable to terminal and has no physical-register redefinition
- terminal return rendering supports constants, locals, tables, calls, multiple values, RETURN_ALL calls, varargs, and closure values where existing Fresh-CF expression/closure recovery proves them
- proven synthetic logical AST rendering accepts primitive literal indices in `_env[...]` and recursively-rendered call bases only inside already-proven reduced logical expressions; this preserves short-circuit call count/order without broadening ordinary unproven expression rendering
- structured multi-state roots now recover compiler local upvalue cells when allocation and first binding initialization dominate conditional routing: `allocUpvalue()` is treated as binding-identity bookkeeping, `upvalueValues[cell] = value` creates/updates the recovered source local, direct `upvalueValues[cell]` reads resolve to that same binding, and `createClosureN(entry, { cell... })` passes proven binding names into the existing captured-closure renderer
- captured source-storage aliases use path-local metadata carried in the candidate environment; field writes are accepted only through an active source local or an alias proven to originate from the recovered upvalue binding, not by generated-name string coincidence
- direct calls of recovered anonymous closure expressions are parenthesized as `(function(...) ... end)(...)` so reduced TESTSET/call expressions remain syntactically valid Lua
- path-dependent cell allocation, capture of an uninitialized/unknown cell, non-direct capture-table shapes, ambiguous terminal payloads/lifetimes/merges, and unrelated arbitrary upvalue machinery still fail closed
- recursive nested closure recovery now supports proven multi-state child CFGs dynamically: `renderClosureCall` first keeps the single-state `renderSimpleClosureLeaf` fast path, then recursively invokes the same structural `matchMultiStateLogicalLocals` solver for a child entry when needed; the structural solver is entry-parametric, receives the child capture map, reconstructs child parameters from proven `args[N]` reads, resolves captured-slot reads/writes, supports mixed local-cell + forwarded `upvalues[N]` capture tables, and renders the recovered child as a function expression
- recursive closure consumption is transactional: a rendering-entry cycle guard prevents recursive self-consumption, failed child attempts roll back all descendant state-consumption side effects, and a successful multi-state child claims exactly its proven reachable state set; generated child parameter/local names avoid collisions with already-recovered capture bindings

Tracked focused regressions in `tools/test-beta-control-flow-fresh.js` now include:
- basic one-sided terminal branch
- nested TESTSET `a and (b or c)` feeding early return
- call-heavy TESTSET with `type(1) == "number" or tostring(2)`, covering the recursively-rendered proven call-base case
- structured captured-table mutation inside an early-return TESTSET root
- structured captured-variable rebind, proving the child closure writes the recovered outer binding rather than a copied value
- recursive structured child closure with forwarded captures and its own three-state conditional CFG
- the pre-existing deep logical/TESTSET regressions remain unchanged and passing

Real Medium validation completed for these source shapes:
- one-sided early return + final return
- side effects before terminal return and on continuation
- sequential early-return guards
- `if/else`, `elseif`, and nested return-bearing conditionals
- logical/TESTSET conditions, including true/false paths, a 23-state deeply nested `and/or` expression, and a call-heavy short-circuit expression
- returned locals without terminal cleanup
- persistent table identity/mutation on terminal and continuing paths
- returned calls / RETURN_ALL
- multiple return values
- varargs
- branch-local storage cleanup
- closure-containing roots and direct closure-value returns
- table-constructor return values
- empty return branches

Validation results on 2026-09-04:
- all eight established Fresh-CF/register/binding suites pass
- four complex TESTSET early-return fixtures passed 100/100 exact runtime-parity runs (25 randomized Medium layouts x 4 fixtures)
- the broader early-return matrix passed 210/210 exact runtime-parity runs (10 randomized Medium layouts x 21 fixtures)
- no call duplication, short-circuit order change, table identity break, or return-pack expansion mismatch was observed
- the exact user sample with `math.random(1,2)`, a second `thing()` early-return guard, `print(2)`, and final `return 4` recovers structurally from real Medium output; runtime parity is not a valid gate for that literal sample because `thing` is undefined unless the test defines it (and the random guard is nondeterministic across separate runs)
- a 33-state deeply nested early-return fixture with nesting depth 5, nested `if/elseif/else`, logical `and/or`, side effects, and multiple returns passed exact source/obfuscated/recovered runtime parity on the first real Medium run
- the former 103-state captured-table blocker is fixed: the exact monster fixture now recovers its captured `t` binding, mutating `check` closure, nested early returns, TESTSET logic, multi-return helper, and nested `transform` closure with exact source/obfuscated/recovered runtime parity
- focused real Medium probes for captured table-field mutation, captured scalar increment, and captured table-variable rebind all pass exact runtime parity
- structured capture stress passed 50/50 exact-parity runs (25 randomized Medium layouts x the minimal captured-table fixture and the 103-state monster)
- six targeted 103-state source-branch variants covering nested `check()` calls, deep early returns, complex TESTSET paths, and normal fallthrough all passed exact runtime parity
- recursive nested multi-state closure recovery is now fixed: the former 7-state forwarded-capture minimal and 8-state local-capture-only minimal both pass exact runtime parity, the previous 5-state single-state path remains passing, a 12-state depth-3 fixture with child + grandchild `if/else` CFGs and shared captured-table mutation passes, and a nested early-return child fixture passes
- randomized recursive-closure stress passed 100/100 exact-parity runs (25 randomized Medium layouts x 4 fixtures: forwarded captures, local-only captures, depth-3 recursion, nested early return)
- a separate two-parameter nested multi-state child probe also passes exact runtime parity, proving child parameter recovery is indexed structurally from `args[N]` rather than hardcoded to the first argument
- branch-local multi-return storage feeding later conditional CFG is implemented and tracked: a real 7-state Medium fixture with sibling captured closures recovers the source multi-return binding, uses later result slots in conditionals, preserves all return values, and passes exact runtime parity
- nested multi-state vararg-pack transport is implemented and tracked: the 9-state nested logical/TESTSET vararg child recovers `function(...)`, `select(1, ...)`, branch CFG, and `return value, ...` with exact runtime parity
- structured multi-return recovery is provenance/epoch based, not fixture-specific: it tracks compiler call-pack identity, expected extracted slots, physical-register transport through ordinary registers plus borrowed `state`/`ReturnVal`, one source owner per slot, mixed cleanup-or-terminal lifetime proof, and one declaration for the recovered source multi-local
- same-block future pack proof is now part of that model: from pack creation to pack-register overwrite, Fresh CF preclaims every expected static `pack[N]` extraction, reserves the exact extraction statement, proves the eventual source owner directly or through a future carrier copy, and may emit the source declaration before later compiler bookkeeping when semantic use occurs first; reserved extraction/owner copies are validated again when encountered
- deferred structured-pack owners do not reuse a stale display from an earlier physical-register epoch; owner activation occurs only at the proven reserved copy/extraction point
- the structured vararg model recognizes compiler-created `{ select(1, unpack(args)) }` as persistent semantic `...` transport across child states; terminal `unpack(varargPack)` reconstructs `...`, and recovered child signatures add `...` only when that structural proof is used
- proven recursive logical ASTs may render nested index bases such as captured table-field reads only inside already-proven recursive expressions; structured identifier resolution remains guarded so internal pack markers cannot leak into generated Lua
- the former 151-state mega blocker is fixed. The missing shape was a compiler call-pack whose first slot was extracted and semantically used before later expected slots/owner copies were emitted. Future slot/owner preclaim solves this structurally without state/register/source constants
- empty conditional clauses are now preserved structurally. A direct branch edge to the join proves that source arm is absent; an intermediate branch state before the join proves that arm is explicitly present even when it has zero effects. This distinguishes `if x then end` from `if x then else end` without guessing
- two-way conditional merging preserves explicit empty `then`/`else` arms, including asymmetric nonempty/empty bodies. N-way `if/elseif` merging allows empty clauses and preserves an explicit empty final `else` when the final false edge does not jump directly to the join
- empty statement branches are not confused with compiler short-circuit logical-value branches: the solver checks for the compiler logical result-copy shape and only preserves a zero-effect statement branch when that result-carrier proof is absent
- permanent Fresh-CF regressions now cover branch-local multi-return feeding a conditional, delayed/future structured-pack owner copies, nested multi-state vararg transport, standalone empty `if`, explicit empty `if/else`, asymmetric empty arms, and nested empty `if/elseif` clauses
- final validation after modularization on 2026-09-04: all 12 tracked Fresh-CF/if/register/binding/upvalue/version/graph/semantic suites pass; every changed/new JavaScript file passes `node --check`; `git diff --check` passes
- real Medium runtime parity after modularization passes for all eight acceptance fixtures with 3, 4, 4, 4, 8, 7, 9, and 151 normalized states respectively: standalone empty `if`, explicit empty `if/else`, both asymmetric empty-arm variants, nested empty `if/elseif`, branch-local multi-return with sibling closures, nested multi-state varargs, and the complex early-return mega fixture
- randomized Medium layout stress after modularization passes 100/100 for each of those eight fixtures = 800/800 exact-parity runs
- captured-upvalue and recursive-closure stress after modularization passes 50/50 and 100/100 respectively
- there is no known blocker in the currently supported straight-line/local/call/table/closure/upvalue/multi-return/vararg/conditional/early-return feature set represented by the established regressions

Early-return rendering remains shared with the structured terminal solver, while proven Prometheus `while` regions may now admit closed compiler terminal-return regions in addition to nested while and break/continue edges. Return regions are accepted only when they are off-cycle, closed/acyclic, and end in the proven compiler return-pack + stop shape; arbitrary loop exits remain fail-closed. `repeat`, numeric/generic `for`, and ambiguous loop/control-flow shapes remain separate fail-closed features.

### What a new chat should do next

1. Read this entire `CONTEXT.md` before editing anything.
2. Run `git status --short --branch` and `git log -5 --oneline`; trust Git/current tracked tests over old temp output.
3. Preserve unrelated/user-created temp work, but clean task-local `_tmp_*` patch/debug/trace/backup files once their behavior has durable tracked regression coverage. Keep only source fixtures that remain useful for real-Medium reproduction/stress. Never treat generated temp output as authority.
4. Before changing Fresh CF, run the focused regression that matches the intended feature, then the full Fresh-CF/if/register/binding/upvalue/version/graph/semantic suites after the edit.
5. For compiler-lowering uncertainty, inspect Prometheus `compiler.lua` and generate a tiny real Medium fixture. Recovery rules must be structural: no fixture-specific state IDs, register IDs, source literals, or globals.
6. Preserve exact evaluation order, call count, short-circuit behavior, multi-return expansion, table/upvalue identity, vararg semantics, and register epochs. Fail closed on ambiguous merges/lifetimes.
7. For new conditional shapes, use CFG evidence (branch targets, joins, result-carrier copies, cleanup/terminal proof) rather than source guesses. Empty branches are supported only when their explicit/absent arm is structurally distinguishable.
8. General loops and loop-control reconstruction remain separate future work; do not infer them from early-return/conditional support.
9. Before commit: run randomized Medium stress for the touched feature, `git diff --check`, inspect the exact tracked diff, update this context, and stage only intentional tracked files.
10. Treat current code + tracked tests + this file as authority; generated `output/` and `_tmp_*` files are disposable probes, not project truth.

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
