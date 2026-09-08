# Prometheus Lua/Luau Deobfuscator — Authoritative Context

This file is the single durable handoff for the project. It must describe **current truth**, not conversation history.

Rules for maintaining this file:
- replace stale facts instead of appending contradictory updates;
- keep one canonical rule per topic;
- keep only durable compiler facts, architecture, supported behavior, fail-closed limits, workflow, and meaningful validation baselines;
- do not preserve old gate counts or historical feature checkpoints once superseded;
- if code/tests disagree with this file, inspect current Git/compiler/tests and update this file.

### Standing context-maintenance rule

Maintain this file proactively during every project task; do not wait for another reminder. Update the relevant canonical section after meaningful discoveries, decisions, changes, and verification, and before the final response or a handoff. During long tasks, save useful checkpoints here so unfinished work can resume after context loss.

Record the current objective, completed work, affected files, actual verification results, unresolved issues, and the next concrete step when work remains. Clearly distinguish verified results from plans, assumptions, and historical test results. Never imply old tests certify newer edits.

Keep the handoff concise: replace stale statements, merge duplicates, and remove superseded detail without losing correctness rules, ownership boundaries, evidence, or unresolved work. Keep one current checkpoint rather than an accumulating conversation log. Read this file when resuming and reconcile it with current files and Git state. Context maintenance is part of finishing the task, not a separate optional request.

---

## 0. New-chat bootstrap / current snapshot

A new chat must:
1. read all of `CONTEXT.md` before editing project files;
2. run `git status --short --branch` and `git log -5 --oneline`;
3. inspect the actual current implementation before changing it;
4. preserve unrelated dirty/untracked work;
5. inspect Prometheus `compiler.lua` whenever a lowering rule is uncertain;
6. never ask the user to repeat durable facts already recorded here.

Current project state as of 2026-09-08:
- branch: `main`, two commits ahead of `origin/main`; HEAD `2a63976` (`Fix Fresh-CF sample 20 recovery`), preceding commit `5e55abf` (`Integrate Fresh-CF fixes and clean temp artifacts`);
- active Fresh-CF implementation is under `passes/beta-cf/` with `passes/beta-control-flow.js` as compatibility facade;
- existing uncommitted recovery changes are in `control/generic-for.js`, `control/loops.js`, `control/repeat.js`, and `logical.js` under `passes/beta-cf/`, plus generic-for/repeat/while regression tests;
- generic-for implementation and tests are tracked; `deobf.bat` has an existing tracked deletion; `passes/beta-cf/closures.debug.js` and `passes/beta-cf/structured/solver.debug.js` are untracked;
- `prod sample/` contains 50 downloaded Lua samples; contents were verified against GitHub blob hashes and sizes, but deobfuscation/runtime tests have not been run on these samples;
- preserve unrelated changes and any user probes; `formater/input.txt` is not currently dirty;
- historical regression gate: **19/19 PASS**, including the 42-order capture-permutation suite; not rerun for the current dirty tree during this handoff update;
- historical full tamper/gmatch fixture certification: **30/30 fresh randomized structural runs PASS**; the randomness/error-heavy fixture is not certified via uncontrolled runtime parity;
- historical semantic-nil/dispatcher-overwrite certification: **30/30 fresh Medium randomized runs PASS with exact LuaJIT runtime parity** on a closure/upvalue + later-register-reuse fixture;
- generic `for` currently supports proven one- and two-variable Prometheus shapes; **3+ iteration variables intentionally fail closed**.

Preferred project communication style:
- short updates using `Found:`, `Fixed:`, `Tested:`, `Commit:` when appropriate;
- no filler or repeated history;
- do not use Codex unless the user explicitly asks for it.

---

## 1. Task scope and workflow

Before project work that inspects/tests/modifies code, state the scope of the turn. Do not opportunistically expand into unrelated fixes.

During work:
- inspect relevant current files before editing;
- when an obfuscation shape is unclear, unfamiliar, or forgotten, inspect the relevant compiler logic in `C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf` (primary source: `src\prometheus\compiler\compiler.lua`) before designing or changing recovery; do not guess from memory;
- if reading the compiler does not settle the shape, make a small source fixture, obfuscate it with that compiler, and compare the emitted pattern with the actual sample; verify the sample matches the compiler rule rather than assuming every downloaded sample uses the same compiler version;
- make tiny readable fixtures for uncertain patterns;
- preserve unrelated work;
- fail closed on ambiguity;
- update this file when durable behavior/architecture changes;
- do not keep appending “latest checkpoint” sections.

After meaningful code changes:
1. run focused tests;
2. run relevant broader regressions;
3. for Fresh-CF/register-lifetime/control-flow work, run the full established gate;
4. run real Medium fixtures and randomized layouts for the touched shape;
5. run syntax checks for changed/new JS files;
6. run `git diff --check`;
7. update this context;
8. inspect the exact diff;
9. stage only intentional files;
10. focused commit + push when the user wants/when the task reaches a self-contained commit point.

Tool-efficiency rules:
- reuse already-known tool schemas;
- do not loop on repeated `git status` / `git diff` / discovery calls;
- batch independent reads/checks where possible;
- prefer `node tools/fast-obf-deobf.js <fixture.lua> --runtime` for real Medium validation;
- inspect intermediate output only when needed or requested.

---

## 2. Workspace and material paths

Deobfuscator workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repository:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Prometheus compiler workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`

Primary compiler source:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf\src\prometheus\compiler\compiler.lua`

Real obfuscation command:
`luajit cli.lua --preset Medium <fixture.lua>`

Fast project validation command:
`node tools/fast-obf-deobf.js <fixture.lua> --runtime`

Never use blind `git clean -fd`. Generated `output/` material is not authority; regenerate it when needed.

Production sample corpus: `prod sample/` in the deobfuscator workspace. Contains the first 50 `.lua` files by filename from `https://github.com/terrorlua/obfuscator-samples/tree/main/Prometheus/WeAreDevs`, downloaded from commit `82fa0134a660437c082b757517c2a59140112740` with original filenames preserved. All 50 saved files matched GitHub sizes and blob hashes (7,092,523 bytes total). Download verification does not certify recovery or execution.

Current objective: implement and verify complete recovery of all 50 production samples. User authorized implementation after the requirements interview. Preserve the pre-existing dirty tree and debug probes.

### All-50 recovery acceptance and implementation plan

Confirmed user requirements: recover every function, loop, and branch correctly in all 50 samples. Partial recovery, unresolved regions, placeholder bodies, or retained compiler VM machinery count as failures. Preserve proven source operations and semantics; do not remove source logic to obtain a passing result. Original variable names and exact original formatting are not required or generally recoverable.

The samples target Roblox. The user accepts syntax validation for the actual corpus in this environment; full Roblox runtime behavior remains unverified and must not be claimed. Syntax success is necessary but not proof of correctness. Recovery-rule changes still require source-shape checks, controlled behavior tests, randomized compiler layouts, and the established regression gate. Reject ambiguous recovery rather than silently emit guessed code, and count such rejection as a corpus failure.

Planned execution:
1. Preserve input hashes and existing work; establish the current regression baseline and a per-file corpus baseline with bounded processes, timings, failure reasons, and separate output directories. The existing `fast-obf-deobf.js` re-obfuscates source, so downloaded obfuscated samples must use the direct deobfuscation entry point instead.
2. Group failures by shared root cause and pipeline stage. Inspect actual normalized output and relevant compiler rules; reduce failures to small representative fixtures before changing recovery.
3. Implement general, evidence-based fixes. Add positive and ambiguity-rejection regressions, inspect recovered source, and validate deterministic fixture behavior across fresh randomized obfuscations. Never special-case sample filenames, literals, or randomized registers/states.
4. Rerun the corpus after each completed fix group and track recovery coverage separately from syntax validity. Require every root/child region to be accounted for; inspect residual machinery by provenance, not merely identifier searches.
5. Final gate: all 50 fully recovered, all recovered files pass Luau syntax/compilation checks, all established regressions pass, and touched recovery rules pass controlled behavior/randomized tests. Investigate any compiler resource-limit failures without dropping source operations. Report remaining Roblox-runtime uncertainty explicitly.
6. Keep this canonical checkpoint and the per-file results current during implementation; preserve the original corpus. Deliver recovered outputs and a reproducible batch command/report.

Current implementation checkpoint:
- Original all-50 baseline: 21 recovered/parser-valid, 27 recovery rejections, 2 timeouts at 120 seconds. Report: `output/production-2026-09-07T17-53-04-189Z/results.json`. All 19 established suites passed before edits.
- Latest complete batch: 26/50 accepted by recovery, 25/50 also pass independent Luau syntax/compilation, no timeouts; report `output/production-2026-09-08T01-13-35-671Z/results.json`. One parenthesized-call statement lacked a separator; emission is now fixed but needs a fresh corpus run. These counts are not correctness certification.
- Added `tools/test-production-corpus.js` (bounded per-file processes, original input hashes, separate normal/recovered output, retained errors and timings), `tools/inspect-fresh-failure.js` (diagnostics instrument modules only in memory), and `tools/test-beta-production-recovery.js` (controlled recursive-function and unused-result behavior plus reconverging graph regression).
- Current fixes: structured self-recursive cell binding; preserve unused cleanup-backed multi-return locals; recognize terminal return before dead nil cleanup; avoid exponential revisiting in loop-storage/read-before-write and structured cleanup/index-write queries; require live join use for new direct logical-result candidates so ordinary conditionals are not erased; recognize source tables with fixed fields followed by a proven return-pack expansion.
- `logical.js` changed outside this task during the first runs. Its broadened direct-result rule caused an existing nested-if regression; the live-join guard restores that test. Preserve the other existing edits; do not claim any mixed-revision run certifies a frozen revision.
- Additional fixes: terminal generic-for bodies with only breaks/returns, including return paths without nil cleanup; newly allocated captured locals initialized from a multi-return call (bind the exact cell identity to the already emitted local); separate parenthesized call statements from preceding expressions.
- All 19 established suites pass on the current edits. `tools/test-beta-production-recovery.js` passes controlled recovery tests. `tools/test-production-randomized.js` passes 30/30 behavior checks across five safe source fixtures and six distinct fixed compiler seeds; report logs `output/production-fixtures-1788830288761/`. The earlier time-seeded run was superseded because nearby runs could reuse a seed. `fast-obf-deobf.js --seed <positive integer>` now supports reproducible compiler layouts.
- Independent compiler available at `../luau/build/Release/luau-compile2.exe`; downloaded payloads have not been executed. Output review, remaining failure fixes, another frozen all-50 run, and all-50 completion remain outstanding.
- Next: diagnose child graph rejection in `0003d9e06049f5ed.lua` entry 86; explicit while/iterator lowering in `0126223f1553147e.lua` leaves its third iterator result unowned; nested call-pack forwarding in `0182c4620fb447f9.lua`. Continue grouping failures and keep strict all-region accounting.

---

## 3. Project goal and semantic rules

Goal:

```text
Prometheus VM output
-> normalized VM
-> proven source-level Lua/Luau structure
```

Fresh CF is **source recovery**, not a source optimizer.

Hard correctness requirements:
- preserve evaluation order;
- preserve side effects;
- preserve call count/order;
- preserve Lua/Luau multi-return semantics;
- preserve last-expression expansion;
- preserve table/function/reference identity;
- preserve method-call `self`;
- preserve lexical lifetime/scope;
- preserve closure capture/upvalue identity;
- preserve mutation semantics;
- preserve loop/control semantics;
- preserve `break`, `continue`, and `return`;
- preserve proven source declarations/assignments/aliases even when unused or overwritten;
- remove compiler bookkeeping, not proven source code;
- fail closed when proof is incomplete.

Never hardcode:
- physical/normalized register numbers;
- VM state IDs/random block IDs;
- fixture constants or literal values from a test;
- method/global/service/source variable names;
- closure entry IDs;
- fixture filenames, state counts, statement indexes, register layouts, or one observed lowering order.

A Fresh-CF recovery rule is valid only when it is derived from compiler structure, CFG/def-use/lifetime/provenance, or other semantic evidence. Never add a branch whose purpose is "make this fixture pass." State/register renaming or a fresh obfuscation layout must not change whether the rule applies. A one-layout pass is not proof: new support or a bug fix must be exercised across repeated fresh randomized obfuscations when the obfuscator randomizes layout. If layouts differ and some fail, the implementation is still broken/layout-sensitive and must not be reported as fixed.

Control-flow regions and closure bodies must reuse the same ordinary statement renderer/semantics as the root linear block. Do not add per-construct copies of ordinary expression/local/call/table/global rendering. Control modules prove and rewrite control structure only; ordinary body statements remain shared semantics.
A pretty output that changes semantics is a bug.

### Source-preservation rule

Unless the user explicitly asks for a separate optimizer:

```text
DO NOT dead-code eliminate proven source locals
DO NOT inline proven source aliases
DO NOT remove unused proven multi-return locals
DO NOT remove proven assignments merely because overwritten later
DO NOT duplicate closure/table creation by substituting expressions for bindings
```

Only remove proven compiler transport/bookkeeping.

---

## 4. Prometheus compiler model

Primary authority: `src/prometheus/compiler/compiler.lua`.

The compiler turns source AST into a register VM controlled by a POS/state register and randomized blocks.

### 4.1 Register categories

Important compiler roles/constants:

```text
MAX_REGS = 100
VAR_REGISTER
RETURN_ALL
POS_REGISTER
RETURN_REGISTER
UPVALUE
```

Roles:
- POS/state: dispatcher program counter; may also be borrowed as a TEMP;
- RETURN/ReturnVal: return payload transport; may also be borrowed as a TEMP;
- ordinary TEMP register: short-lived expression storage;
- VAR register: source-local/argument/loop-variable storage lifetime;
- RETURN_ALL: preserve all returned values using compiler pack transport;
- UPVALUE: captured source storage via cell machinery.

A physical `rN` is reusable and does **not** represent one permanent logical variable.

### 4.2 Allocation/freeing

`allocRegister(false)` may use free POS/RETURN before ordinary registers.

`allocRegister(true)` allocates VAR-owned storage.

`freeRegister(id, false)` does not free VAR registers. VAR ownership ends only when compiler lifetime logic force-frees it, normally after emitted cleanup/upvalue release at lexical scope exit.

Thus compiler `rN = nil` is often lifetime cleanup, but nil alone is not sufficient proof of a source local.

### 4.3 TEMP -> VAR promotion

`getVarRegister(scope, id, functionDepth, potentialId)` can promote an existing ordinary RHS TEMP directly into VAR ownership if it is not already VAR/POS/RETURN.

`copyRegisters(to, from)` emits nothing when `to == from`.

Therefore source local initialization has two valid forms:

1. explicit handoff:
```text
exprTemp = <expr>
varReg = exprTemp
...
varReg = nil
```

2. erased/in-place promotion:
```text
reg = <expr>   -- TEMP promoted to VAR, no visible copy
...
reg = nil
```

Fresh CF must support both, but must prove the **exact value epoch** that owns source storage.

### 4.4 Critical current TEMP/VAR epoch rule

Cleanup-backed **physical-register identity is never enough** to promote earlier values.

Canonical example:

```text
rN = 65                 -- call-argument TEMP epoch
call(3, rN)
rN = callResult         -- later source VAR handoff/epoch
...
rN = nil                -- source VAR cleanup
```

Correct recovery keeps the TEMP inline:

```lua
local n = random(3, 65)
```

It must **not** recover:

```lua
local fake = 65
local n = random(3, fake)
```

Current structured proof rules:
- compiler POS restore `state = temp` from an earlier `temp = state` is dispatcher transport, not source-use evidence;
- call-argument promotion examines the current unique reaching definition, not the register’s later cleanup;
- an explicit TEMP/special-register -> cleanup-backed VAR copy is ownership evidence;
- an erased direct TEMP→VAR promotion is accepted only when that exact definition reaches compiler nil cleanup before any non-nil rewrite on every continuation path;
- loop preheaders keep an additional future-write guard because they commonly borrow the eventual VAR register before the real handoff;
- reuse **after** a proven cleanup is a new epoch and must not invalidate the earlier source local;
- a nil write is compiler cleanup only when that exact nil definition is dead before overwrite/terminal; if the nil definition reaches a read, it is semantic data and must remain in the value epoch;
- POS/state is not exempt: after `state = nil`, later statements in the same VM block must resolve `state` to semantic `nil`, never to its previous dispatcher payload (for example a just-created closure);
- the single-state closure renderer follows the same read-before-overwrite nil rule as linear/structured recovery.

This rule is structural and independent of literals/register IDs.

### 4.5 Overflow registers

Compiler register IDs >= 100 are represented as static slots of `RegisterOverflow[(id - 100) + 1]`.

Normal deobf scalarizes proven static slots to `o1`, `o2`, ... . Dynamic overflow indexing is not treated as register storage.

After scalarization, Fresh CF treats `rN` and `oN` identically at the semantic/lifetime level.

---

## 5. Important compiler lowering templates

These are semantic templates, not fixture-specific text matches.

### Globals

Read:
```text
keyTemp = "print"
valueTemp = _env[keyTemp]
```

Write:
```text
keyTemp = "name"
_env[keyTemp] = value
```

Static valid-identifier environment writes can recover as normal global assignments.

### Source locals

For `local a = expr`:
1. compile expression;
2. obtain VAR storage;
3. promote expression TEMP in-place when possible, otherwise copy;
4. keep VAR alive through lexical lifetime;
5. emit cleanup/release at scope exit.

Reassignment updates the same source binding until that lifetime ends.

### Calls and multi-return

Compiler evaluates callable and arguments in source order.

For multiple requested results / RETURN_ALL it often creates:

```text
pack = { call(...) }
slot1 = pack[1]
slot2 = pack[2]
...
```

or later consumes `unpack(pack)`.

Fresh CF must distinguish this compiler pack from a real source table.

### Real source `{ call(...) }` table

Prometheus can lower a real source table like:

```lua
local t = { pcall(...) }
```

as two layers:

```text
pack = { pcall(...) }          -- compiler return pack
tableValue = { unpack(pack) }  -- real source table
```

Current rule:
- `{ unpack(existingReturnPack) }` is a real source table only when existing pack provenance proves that exact call pack;
- preserve table identity and later indexing;
- do not collapse both layers into a bare call.

### Method / namecall

Source `base:Method(args...)` is lowered approximately as:

```text
baseReg = <base>
methodTemp = "Method"
methodTemp = baseReg[methodTemp]
methodTemp = methodTemp(baseReg, args...)
```

Recover `:` only when member origin + first self argument + evaluation-order safety are proven.

### Tables/indexing

Table identity must be preserved across writes/calls.

Index assignment evaluates base/index/RHS according to compiler/source semantics; do not reorder effectful components.

### Returns

Source return becomes terminal payload transport:

```text
ReturnVal = { values... }
state = nil/stop
```

RETURN_ALL uses compiler packs + terminal unpack.

A root fallthrough empty return and explicit trailing bare return may be indistinguishable after normalization; do not invent authorship.

### Closures and arguments

Source functions become child VM entries and are materialized through `createClosureN(entryId, captures)` / `createClosure(entryId, captures)`.

Physical fixed factory arity may contain random extra unused args, so source parameter count is inferred from child `args[N]` reads, not factory arity.

Varargs are typically represented using compiler storage such as:

```text
{ select(firstVarargIndex, unpack(args)) }
```

and recovered as `...` when structurally proven.

### Upvalues

Captured source storage uses:
- `allocUpvalue()`;
- `upvalueValues[cell]`;
- refcounts/releases;
- capture tables passed to closure factories;
- forwarded `upvalues[N]` slots.

Capture recovery must uniquely resolve the underlying binding/cell. Shared captures must remain one binding.

### Anonymous closure TEMP vs source-local closure

Important distinction:
- `local f = function() ... end; f()` lowers through a source-storage handoff/cleanup and must stay a named local;
- an immediately called anonymous function may remain a direct `createClosureN` TEMP and can recover as `(function(...) ... end)(...)` when proven.

Do not inline a proven source-local closure merely because all uses are calls.

### Short-circuit `and` / `or`

Prometheus may create a multi-state TESTSET-style region. Fresh CF identifies value-producing logical regions by compiler result-carrier proof + lazy-path/join/closed-region proof, then collapses them before source conditional structuring.

Do not classify every `state = cond and A or B` as source `if`; it may be a logical expression.

### `if` / `elseif` / `else`

Compiler branches state to body/next/final. Fresh CF uses CFG joins/markers and closed-region proof, including explicit empty-arm versus absent-arm distinction.

### `while`

Pre-test natural loop:
- preheader -> check;
- condition branch -> body/final;
- body backedge -> check.

Supported only when strict compiler/natural-loop proof succeeds.

### `repeat ... until`

Post-test natural loop:
- enter body first;
- bottom condition true -> final, false -> body.

**Compiler bug:** current Prometheus compiler also evaluates `repeat` condition once before first body entry and discards the result, then evaluates the real bottom condition. Fresh CF recovers source semantics and removes this duplicated pre-loop evaluation only after structural/def-use equivalence proof.

If every repeat-body path terminates, Prometheus may suppress the body→check edge and dead-block cleanup can leave the old check/final blocks unreachable. Fresh CF has a dedicated terminal-repeat proof for that compiler signature. Reachable-only structured rendering is allowed only after that proof; unreachable states must not be ignored generically. A repeat-only recovered program is valid structured control and must be accepted from loop metadata rather than requiring rendered `if`/`while` text.

### Numeric `for`

Compiler uses initial/final/step/sign/current bookkeeping plus sign-aware <=/>= check and a current->source-loop-variable handoff.

Omitted step and explicit `1` compile identically; Fresh CF canonicalizes proven step `1` to the no-step source form.

### Generic `for`

Compiler maintains iterator/invariant/control tuple and check roughly:

```text
control[, second] = iterator(invariant, control)
state = control and BODY or FINAL
```

Body copies `control` into first source loop variable; optional second iterator result supplies second variable.

Prometheus variables 3+ are ambiguous because compiler body-entry nil writes are indistinguishable from real body locals. Fresh CF therefore supports only **1–2 source iteration variables** and fails closed for 3+.

`pairs`, `ipairs`, `next`, custom iterators, method-call iterator expressions, and explicit iterator tuples are recovered from structural header tracing; do not hardcode those names.

### `break` / `continue`

Compiler emits scope cleanup/release then jumps to loop final/check. Recover only inside an already-proven loop region and only when exit/backedge classification is unambiguous.

### Early `return`

Terminal return paths are represented separately from continuing candidates. They are never forced through synthetic joins. Guard returns and nested/sequential return-bearing conditionals are recovered only from closed terminal-region proof.

Source-recovery rendering preserves compiler-proven branch polarity. An explicit false/else arm such as if valid then else ... end must remain an empty 	hen plus else; do not canonicalize it to if not valid then ... end. The same rule applies when a false arm is folded through terminal-return recovery.

---

## 6. Normal deobfuscation pipeline

Approximate active flow:

```text
input
-> formatter / parser
-> constant-array recovery
-> environment recovery
-> closure-factory recovery
-> VM helper semantic naming
-> helper/local semantic naming
-> safe parallel-assignment splitting
-> VM state/CFG recovery + state-ID normalization
-> optional VM binding/lifetime analysis
-> scalar VM register naming
-> RegisterOverflow scalarization
-> VM register scheduler/canonicalization
-> normalized VM output
```

Important files:
- `main.js`
- `passes/constant-array.js`
- `passes/environment.js`
- `passes/closure-factory.js`
- `passes/vm-helpers.js`
- `passes/semantic-names.js`
- `passes/split-safe-assignments.js`
- `passes/vm-state.js`
- `passes/vm-bindings.js`
- `passes/vm-register-names.js`
- `passes/vm-register-overflow.js`
- `passes/vm-register-scheduler.js`

### VM state recovery

`passes/vm-state.js`:
- finds semantically named VM/state dispatcher;
- resolves randomized numeric-state arithmetic only when safely evaluable;
- treats only the final state write in a leaf as control terminator because POS may be borrowed earlier;
- builds reachable root/child-closure groups;
- normalizes closed/safe state IDs and closure entry IDs;
- does not pretend an unresolved graph is solved.

### VM binding analysis

`passes/vm-bindings.js` is diagnostic/analysis infrastructure: reaching definitions, provenance, liveness, epochs, cleanup candidates, capture/upvalue resolution, etc. Fresh CF performs its own source proof but can use these concepts as authority.

### Register scheduler

`passes/vm-register-scheduler.js` only reorders proven pure compiler register transport under RAW/WAR/WAW safety. It does not arbitrarily move calls/index effects and does not delete assignments just because they look dead.

It has specialized support for compiler return-pack slot scheduling and borrowed POS/ReturnVal transport.

---

## 7. Fresh CF architecture

Public facade:
- `passes/beta-control-flow.js` — compatibility/export layer only.

Core:
- `passes/beta-cf/solve.js` — top-level strategy routing;
- `ast.js` — AST/source helpers;
- `normalize.js` — normalized VM extraction/overflow handling;
- `cfg.js` — `StateGraph`, reachability, predecessors/successors/path queries;
- `logical.js` — compiler short-circuit value-region reduction;
- `closures.js` — child closure/capture rendering and state-consumption transactions;
- `direct-calls.js` — strict simple direct-call recovery;
- `statement-ir.js` — shared ordinary VM assignment decoding;
- `statement-semantics.js` — shared ordinary write semantics;
- `expression-semantics.js` — shared expression formatting primitives;
- `render.js` — final recovered source/function rendering;
- `diagnostics.js` — fail-closed reasons.

Linear one-state path:
- `linear/context.js`
- `linear/lifetime.js`
- `linear/bindings.js`
- `linear/packs.js`
- `linear/render.js`
- `linear/solver.js`

Structured multi-state path:
- `structured/context.js`
- `structured/lifetime.js`
- `structured/bindings.js`
- `structured/tokens.js`
- `structured/packs.js`
- `structured/render.js`
- `structured/branches.js`
- `structured/terminal.js`
- `structured/solver.js`

Loop control:
- `control/loops.js` — unified natural-loop orchestrator, inner-first;
- `control/numeric-for.js` — numeric-for compiler proof/rewrite;
- `control/generic-for.js` — generic-for iterator/header/body-variable proof/rewrite;
- `control/while.js` — while proof + shared abrupt-region helpers;
- `control/repeat.js` — repeat proof + duplicate-condition equivalence/removal;
- `control/loop-storage.js` — shared loop-carried source-storage proof and statement-identity remapping.

### Shared-statement rule

Ordinary assignment/call/index/global semantics are shared. Control modules identify structure; they do **not** implement private renderers for ordinary statements.

`if`, `while`, `repeat`, numeric `for`, generic `for`, and linear blocks should all ultimately use the shared statement/expression semantics.

### StateGraph contract

```text
{
  entryId,
  blocks,        // id -> body + transition
  successors,
  predecessors,
  reachable
}
```

Transitions are jump, branch, or stop.

### Approximate solve order

1. normalize VM/overflow;
2. closure-entry recovery with transactional child renderer;
3. unified proven loop recovery (numeric/generic/while/repeat, nested/mixed);
4. closed logical-value reduction;
5. structured conditional/terminal recovery;
6. one-state register/local recovery;
7. strict direct-call fallback;
8. fail closed with diagnostic reason.

No fallback to retired old beta CF/version recovery.

---

## 8. Canonical Fresh-CF source-lifetime rules

### Physical register != source variable

Conceptually:

```text
physical register
-> reaching definitions / uses / cleanup boundaries
-> value/storage epochs
-> source binding only when compiler ownership is proven
```

One source local may have many assignments. One physical register may host many unrelated epochs.

### Nil handling

`reg = nil` may be:
- semantic source nil;
- nil-only local initialization;
- compiler lifetime cleanup;
- dead TEMP bookkeeping.

Preserve nil when its exact value is read. Treat cleanup only with lifetime proof. Ambiguous nil-only shapes fail closed.

### Cleanup-backed local establishment

A source binding may begin from:
- explicit expression/special-register -> cleanup-backed VAR handoff;
- proven erased direct TEMP→VAR promotion;
- pack-slot owner handoff;
- proven upvalue-cell binding;
- specifically proven terminal-live storage.

Earlier TEMP epochs on the same physical register must not be promoted retroactively.

### Persistent/branch-local storage

Root persistent storage requires converged source-worthy definitions/read-after-join plus cleanup/terminal proof.

Branch-local storage is path-scoped; sibling branches may reuse the same physical register without sharing a source binding.

Compiler POS save/restore transport is excluded from ownership evidence.

### Source-storage lifetime vs value liveness

A proven source binding survives value overwrites:

```lua
local t = {}
t = {1}
t = {2}
```

Even if an earlier value is never read, the assignments remain source semantics and must be preserved.

### Terminal aliases

Stable source aliases such as `local math = math`, member aliases, booleans, or proven nil aliases are preserved only when storage ownership is proven. One-use operands/compiler transport are not automatically promoted.

### Call-argument promotion

Do not turn a call-argument TEMP into a local merely because that physical register is cleaned later.

Use the current reaching definition and epoch proof described in §4.4.

---

## 9. Multi-return, pack, and table rules

Compiler pack tables are transport, not source tables.

Typical source:

```lua
local a, b = f()
```

Compiler concept:

```text
pack = { f() }
aTemp = pack[1]
bTemp = pack[2]
VAR_A = aTemp
VAR_B = bTemp
```

Fresh CF tracks:
- pack identity;
- expected contiguous slots;
- slot owners;
- TEMP/ReturnVal/state carrier copies;
- cleanup/terminal ownership;
- pending emission order.

It emits one source multi-local when proven.

Critical rules:
- preserve pack provenance until all required slots are resolved;
- do not duplicate the original call when multiple slots are used;
- a source local that shadows the old callable must be respected (`local a,b = pcall(a, ...)` then later `a` means the new first result);
- RETURN_ALL/unpack expansion remains position-sensitive;
- real source `{ call(...) }` table is preserved using the proven two-layer rule in §5;
- delayed assignment/index-write transactions must honor the same pending-pack/deferred-local dependency barriers as declarations; never splice a delayed effect before a source binding it reads.

---

## 10. Closure and upvalue rules

Closure recovery must account for every child state it consumes and fail if normalized states are unexplained.

Parameter recovery:
- fixed params come from proven `args[N]` loads;
- vararg storage recovers `...`;
- capture names and generated locals must not collide.

Upvalue cells represent **binding identity**, not just current value.

For:

```text
cell = allocUpvalue()
upvalueValues[cell] = initial
```

Fresh CF creates/maps one source binding; later reads/writes and nested captures use that same binding.

### Path-local captured cells

Structured branches/loops may allocate/capture cells per path/iteration. Ownership metadata must ensure aliases can read a binding but only the proven owner may emit assignment/cleanup.

### Create-before-initialize captured closure

Prometheus may produce any dependency-valid ordering such as:

```text
cellA = allocUpvalue()
cellB = allocUpvalue()
upvalueValues[cellA] = first
closureTemp = createClosureN(child, {cellA, cellB})
sourceVar = closureTemp
cellA = releaseUpvalue(cellA)
upvalueValues[cellB] = second
... use sourceVar ...
```

Fresh CF must **not** recover this by moving statements into one observed compiler order. The active model is semantic/provenance based:
- every `allocUpvalue()` lifetime gets a unique **cell allocation-epoch identity** independent of the physical register name;
- `createClosureN` produces a deferred closure value that captures those cell identities, not `rN` names or statement positions;
- `releaseUpvalue` ends the compiler register/cell handle lifetime but does not change the identity already captured by a deferred closure;
- capture initialization binds the recovered source name to the matching allocation identity;
- when source-VAR ownership is proven before all captures are renderable, keep a **pending deferred source local** and materialize `local f = function ... end` only once all required capture bindings are available and before any semantic use/effect could cross it;
- pending locals do not reserve rendered `vN` names until materialization, so compiler bookkeeping order does not perturb recovered source naming/order;
- `createClosureN` is a value constructor, not an ordinary effectful source-call statement.
- **cell liveness / physical-cell mapping is candidate-local CFG state even when `allocUpvalue()` occurs before a branch**; `releaseUpvalue()` on one branch must not erase a sibling branch's live allocation identity/capture. Root-dominating source declarations may still be emitted globally, but physical cell ownership/release travels in the candidate environment.

There is no active create-before-initialize statement-reordering canonicalizer. Ambiguous capture identity, ownership, or ordering still fails closed.

Permanent `tools/test-beta-control-flow-capture-order.js` enumerates **42 legal dependency-order permutations** of the same capture graph and requires identical recovered semantics. Register/state renaming and independent bookkeeping order must not affect recovery.

### Transactional/idempotent child rendering

Structured proof may render the same child speculatively multiple times. Child rendering may reuse cached source only for the exact same entry + capture-name signature. Conflicting capture mappings fail closed.

### Known generic-header caveat

An earlier generic-for stress fixture using a side-effecting iterator expression like `ipairs(make())` exposed a separate child-closure duplicate-return recovery bug even though generic header reconstruction itself was correct. Do not claim that exact closure-header shape is certified unless it is explicitly retested after later closure changes.

---

## 11. Supported control-flow/source features

Current supported core, subject to strict compiler-shape proof:
- straight-line locals/assignments;
- globals;
- stable table/index reads+writes;
- calls and method/namecalls;
- unary/binary/logical expressions;
- multi-return and RETURN_ALL;
- varargs;
- closures, recursive/nested child closures, captures/upvalues;
- simple/nested/sequential `if` / `elseif` / `else`, including explicit empty arms;
- structured early returns;
- short-circuit `and` / `or` value regions composed with conditionals;
- `while`;
- `repeat ... until`;
- numeric `for`;
- generic `for` with one/two source iteration variables;
- nested/mixed supported loops;
- `break` / `continue` inside proven loops;
- loop-carried locals;
- closure creation inside proven loop bodies.

### While

Supports proven call/logical conditions, loop-carried storage, nested conditionals/loops, multiple break/continue sites, early return, mixed abrupt control, and closure-contained loops.

### Repeat

Supports simple/logical conditions, nested logical POS transport, loop-carried locals, nested conditionals, break/continue/return, nested repeat, repeat/while mixing, and closure-contained repeat. Duplicate pre-loop compiler condition is removed only after equivalence proof.

### Numeric for

Supports ascending/descending, omitted/default/non-unit/variable step/bounds, nested conditionals, break/continue/return, nested numeric loops, closures, and mixed supported loops. Proven step `1` canonicalizes to omitted step.

### Generic for

Supports structurally recovered iterator headers such as:

```lua
for i in iter do ... end
for i, v in pairs(t) do ... end
for i, v in ipairs(t) do ... end
for i, v in next, t do ... end
for i, v in customIter, state, control do ... end
for i, v in next, game:GetChildren() do ... end
```

Header tracing is structural and supports deep index/method expressions. Proven nested bodies, break, early return, nested/mixed loops, one variable, two variables, and empty bodies are supported.

3+ source iteration variables remain fail closed.

---

## 12. Explicit fail-closed boundaries

Do **not** claim arbitrary CFG recovery.

Still fail closed for:
- arbitrary/unproven `if`/join shapes outside existing closed structural proof;
- arbitrary/unproven `while`/`repeat`/numeric-for/generic-for CFGs outside certified compiler templates;
- generic `for` with 3+ source variables;
- ambiguous loop exits/backedges/N-way convergence not covered by proven abrupt/terminal regions;
- `break`/`continue` outside a proven compiler loop region;
- ambiguous source-storage epochs/merges;
- path-dependent values that cannot be proven safe at joins;
- dynamic/ambiguous RegisterOverflow indexing;
- ambiguous capture chains/cycles/uninitialized captures without deferred proof;
- method-call reconstruction without proven same-base/self relation;
- arbitrary table/index effect reordering;
- any source shape where compiler output does not retain enough information to distinguish authored surface forms.

Fail closed with a precise reason rather than weakening a global rule to make one fixture pass.

---

## 13. Current validation authority

### Established 19-suite gate

Current full gate consists of:

```text
node tools/test-beta-control-flow-fresh.js
node tools/test-beta-control-flow-if.js
node tools/test-beta-control-flow-while.js
node tools/test-beta-control-flow-repeat.js
node tools/test-beta-control-flow-numeric-for.js
node tools/test-beta-control-flow-generic-for.js
node tools/test-beta-control-flow-capture-order.js
node tools/test-beta-upvalues.js
node tools/test-beta-register-versions.js
node tools/test-beta-register-graph.js
node tools/test-vm-state-reachability.js
node tools/test-vm-register-scheduler.js
node tools/test-vm-register-overflow.js
node tools/test-vm-register-names.js
node tools/test-vm-bindings-provenance.js
node tools/test-vm-bindings-epochs.js
node tools/test-semantic-names.js
node tools/test-text-edits.js
node tools/test-batch-parameter-rename.js
```

Latest established gate after the dynamic capture/order and TEMP/VAR epoch fixes: **19/19 PASS**.

Old `tools/test-beta-control-flow.js` contains a pre-existing legacy API assertion and is not part of this gate.

### Generic-for certification

Permanent generic-for regression passes. Real Medium testing has covered:
- `pairs` / `ipairs` / `next`;
- one/two loop variables;
- explicit iterator tuples/custom iterator;
- deep method/index header expressions;
- nested conditional bodies;
- break / early return;
- nested generic loops;
- generic<->numeric/while mixing;
- empty body;
- closure-contained generic loop.

3+ variable generic header is a permanent fail-closed regression.

### Repeat certification

Permanent repeat regression passes. Prior randomized Medium certification covered simple, break, nested, mixed while/repeat, deep logical conditions, and closure-contained repeat with exact parity where runtime-capable.

### Numeric-for certification

Permanent numeric suite passes. Prior randomized Medium certification: 25 layouts x 8 runtime-capable families = 200/200 exact parity; prior median deobf+CF 52.8 ms.

### While certification

Permanent while suite covers simple/logical while, loop-carried storage, nested conditionals/loops, multiple break/continue, early return, child closure loops, and complex abrupt control. Luau `continue` structural cases should not be judged by LuaJIT runtime when LuaJIT cannot execute the syntax.

### Current tamper/gmatch fixture

Source includes:
- `string.gmatch` alias;
- local error closure;
- captured local mutated through `pcall(function()...) and flag`;
- `table and table.unpack or unpack`;
- `math.random(3,65)`;
- `{ pcall(function() ... erroring arithmetic ... end) }`;
- indexing second return;
- `gmatch(tostring(err), pattern)()`.

Latest recovered source has:

```lua
local v4 = math.random
...
local vN = v4(3, 65)
```

with **no false `local vX = 65`**.

Validation:
- exact original full tamper/gmatch sample: **30/30 fresh randomized structural runs PASS**;
- exact extended tamper/gmatch sample with terminal `if` + `repeat return (function() while ... end)()` tail: **100/100 fresh randomized structural runs PASS** after candidate-local upvalue-cell liveness; do not use uncontrolled runtime parity for these randomness/error-heavy fixtures;
- current full regression gate: **19/19 suites PASS**;
- semantic-nil/dispatcher overwrite fixture: **30/30 fresh Medium randomized exact-runtime-parity runs PASS**; permanent regression covers `state = createClosure...; state = nil; copy = state` and requires the copy to recover as `nil`;
- capture bookkeeping order regression: **42/42 legal dependency-order permutations PASS**, plus a permanent pre-branch allocation / sibling release-vs-capture regression;
- shape regression keeps literal `65` inline as the call argument, with no false `local vX = 65`;
- real `local x = 65` remains recoverable as source storage;
- real `x = math.random(3, x)` preserves local + reassignment.

### Source-packed table / deferred-capture regression

Permanent Fresh-CF tests cover:
- linear source `{ call(...) }` table;
- same source table after multi-state logical region while preserving evaluation order and table identity;
- create-before-initialize captured closure;
- delayed source-VAR closure ownership before final capture initialization;
- release/reuse of physical upvalue-cell registers after a closure has captured the allocation identity;
- 42 legal permutations of independent capture bookkeeping.

---

## 14. Testing standard for new structural work

For a compiler/recovery feature:
1. inspect compiler source if uncertain;
2. make the smallest readable source fixture;
3. obfuscate with real Medium;
4. run normal deobf;
5. inspect normalized VM on failure/ambiguity;
6. run Fresh CF;
7. inspect recovered source shape;
8. run runtime parity where valid;
9. add focused positive regression;
10. add negative/fail-closed regression when ambiguity matters;
11. randomize layouts;
12. run full relevant gate;
13. run syntax checks;
14. run `git diff --check`;
15. update this context;
16. inspect/stage/commit only intended files.

Do not use runtime parity blindly for nondeterministic programs or Luau-only syntax unsupported by the runtime harness.

---

## 15. Performance rules and durable baselines

Performance is a standing requirement, but correctness/proof comes first.

Rules:
- reuse ASTs when source text is unchanged;
- avoid repeated full-tree/source scans;
- use indexed/cached dataflow where semantics stay identical;
- profile before optimization;
- verify output hashes/semantics after performance changes;
- measure representative large input memory when AST retention changes.

Durable historical baselines from the pipeline optimization:
- `sample/63.txt`: median 1.27 s -> 1.02 s, output hash identical;
- `sample/spacial5.txt`: median 3.74 s -> 2.66 s, output hash identical;
- `sample/spacial6.txt`: 14.30 s -> 12.51 s, output hash identical;
- Fresh-CF 2,000-local stress: solver-only ~7413.9 ms -> ~94.2 ms; direct command ~9.913 s -> ~0.219 s; recovered hash identical.

Do not treat old timing values as current guarantees; rerun benchmarks after architecture changes.

---

## 16. Repository hygiene

Current worktree is not clean. Preserve unrelated changes.

Rules:
- never stage `formater/input.txt` unless explicitly requested;
- never bulk-stage `_tmp_*`, `output/`, generated `.normal.lua`, `.obfuscated.lua`, `.beta.cf.lua`;
- never blind-clean untracked files;
- temporary probes may be deleted only when proven task-local/disposable or explicitly requested;
- generated outputs are not authority;
- inspect staged diff before commit.

Existing uncommitted recovery files verified on 2026-09-08:
- `passes/beta-cf/control/loops.js`
- `passes/beta-cf/control/generic-for.js`
- `passes/beta-cf/control/repeat.js`
- `passes/beta-cf/logical.js`
- `tools/test-beta-control-flow-generic-for.js`
- `tools/test-beta-control-flow-repeat.js`
- `tools/test-beta-control-flow-while.js`

Other worktree items: existing deletion of `deobf.bat`, two untracked debug files listed in section 0, the new `prod sample/` corpus, and this context update. Their presence is not authorization to stage, delete, or commit them. Always verify with Git before staging.

---

## 17. Final project principles

1. **Compiler proof over guesses.** Read `compiler.lua` and compare real Medium output.
2. **Epochs over physical registers.** A register name is storage, not source identity.
3. **Source preservation over optimization.** Keep proven declarations/assignments/aliases.
4. **Shared semantics over per-control handlers.** Ordinary statements use shared IR/rendering.
5. **Identity matters.** Tables, closures, captures, and method bases must not be duplicated.
6. **Multi-return is positional.** Preserve pack/RETURN_ALL behavior exactly.
7. **Evaluation order matters.** Never inline/reorder solely because something has one use.
8. **Fail closed.** Unsupported/ambiguous shapes get precise errors, not plausible guesses.
9. **Randomize tests.** A structural rule must survive different registers/states/layouts/constants.
10. **Keep this file current.** Edit the canonical topic; do not append another historical checkpoint.
