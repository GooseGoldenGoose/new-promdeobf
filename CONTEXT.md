# Prometheus Lua/Luau Deobfuscator - Live Handoff

## Project

Workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repository:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Authoritative branch: `main`.

Current best verified solver state:
canonical promoted overflow-CF solver plus the verified post-promotion performance optimization batch.

The last pre-optimization promoted checkpoint is:
`54964cf Promote overflow CF solver to default`.

Git is authoritative for the exact newest commit; this file records the verified design/state rather than trying to name its own commit hash.

Treat this file as the authoritative handoff. If Git is newer, Git wins.

## Mandatory Workflow

- Read this file first in a new chat.
- Run `git status --short --branch` and `git log --oneline --decorate -8` before changing anything.
- Do not ask the user to repeat decisions already recorded here.
- Use the connected native Windows shell for project work.
- Every tracked project code/content change gets a focused commit and `git push origin main`.
- Stage only files belonging to the current change.
- Never clean/reset/overwrite/stage unrelated working-copy files.
- Keep `CONTEXT.md` current, but replace stale history instead of endlessly appending.
- Reparse generated Lua after transformations.
- Run focused regressions and runtime parity where executable.
- Fail closed when structural proof is incomplete.
- End every project-related turn with exactly: `Done for this turn — you can prompt now.`

### Commit Everything Rule

- Do not leave project changes uncommitted. Every project file changed by the work in the current turn must be committed and pushed to `origin/main` before finishing the turn.
- "Commit everything" means include all project changes made as part of the current work, even small context/test/tool changes; do not silently leave part of the implemented work unstaged.
- Keep conceptually separate changes in separate commits when practical, but all completed current-turn project changes must be pushed before the turn ends.
- Pre-existing user edits, unrelated scratch/generated artifacts, secrets, and intentionally untracked fixtures are still preserved unless the user explicitly tells you to include them. Never use `git add .` blindly when unrelated files exist.

### Communication Style — Caveman Mode

Use this mode by default for all project/technical work unless the user explicitly asks for a detailed explanation.

- Talk as little as possible.
- Be direct and technical.
- Do the work instead of explaining what you are about to do.
- Do not repeat project history already in this file.
- Do not narrate obvious shell/file operations.
- Keep progress updates very short.
- Prefer status labels such as `Found:`, `Fixed:`, `Tested:`, `Commit:`.
- No filler, motivational language, or unnecessary questions.
- If enough information exists, make the best safe decision and continue.
- If something is wrong, say exactly what is wrong and fix it.
- Use simple words where possible: say `run`, `output`, `same result`, `could not compare`, `too many local variables`; avoid unnecessary jargon.
- At the end, give only a compact result: what changed, tests, commit/push status.
- If the user asks `why`, `explain`, or asks for detail, temporarily give the needed explanation, then return to caveman mode afterward.

### Preserve unrelated working-copy files

Latest known user/unrelated tracked edits:

```text
sample/20.source.lua
sample/23.source.lua
sample/23.txt
```

Common intentionally untracked items:

```text
formater/
output/
sample/*.source.obfuscated.lua
sample/sixzens.txt
sample/spacial*.txt
```

Do not stage these automatically.

## Core Rules

Everything must be structural, generalized, and dynamic.

Never hardcode sample IDs, filenames, VM state IDs, register names, random constants/strings, closure suffixes/arities, offsets, methods, URLs, or fixture-specific values.

Fix the earliest responsible AST/CFG/data-flow/scope/upvalue cause. Never patch final emitted text to hide bad analysis.

Preserve evaluation order, call count, side effects, multi-return behavior, lexical ownership, globals vs locals, closure identity, mutable upvalues, table/object identity, zero-iteration loop behavior, break/continue/return, and namecall `:` semantics.

A physical VM register is not one source binding. Dispatcher nesting is not lexical scope. The VM `state`/POS register can also hold ordinary compiler temporaries.

Globals such as `game`, `pairs`, `ipairs`, `table.insert`, etc. remain globals unless lexical provenance proves otherwise.

## Prometheus Authority

When the user says Prometheus, use the local WeAreDevs compiler:

`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`

Compiler source:
`src\prometheus\compiler\compiler.lua`

Do not substitute public/canonical Prometheus unless explicitly asked.

Current observed local Medium preset:

- LuaU
- EncryptStrings enabled
- Vmify
- ConstantArray
- NumbersToExpressions
- WrapInFunction
- AntiTamper absent/disabled in the current Medium pipeline

Do not edit the external compiler preset unless explicitly asked.

## Fixture / Run Pipeline

Typical controlled path:

```text
sample/N.source.lua
-> local WeAreDevs Medium
-> formater\luau-format.exe
-> sample/N.txt
-> node main.js sample/N.txt output/N.lua
-> beta register/version analysis
-> beta control-flow recovery
```

Useful commands:

```text
node main.js sample\63.txt output\63.lua
node tools\beta-register-versions.js output\63.lua output\63.beta.lua
node tools\beta-control-flow.js output\63.lua output\63.beta.cf.lua
```

`deobf.bat <sample> normal|cf` is the user-facing runner. `normal` still runs `main.js` directly. `cf` now calls `tools/deobfuscate-beta-control-flow.js` once, so normal deobfuscation and beta-CF run in one Node process with an in-memory handoff instead of launching `main.js` and then a second Node process that rereads/reparses the normal file. Standalone beta analysis remains available only through its development tool.

Standalone `output/*.beta.lua` is solver/intermediate representation and does not need to execute. Correctness matters for normal semantics and especially final beta-CF source.

## Current Architecture

Main pipeline:

```text
Luau parse
-> ConstantArray recovery
-> environment provenance / _env
-> closure factories
-> VM/helper semantic naming
-> safe parallel-assignment splitting
-> VM state / CFG recovery
-> binding/capture/provenance analysis
-> VM register scheduling
-> register presentation naming
-> final parse/output
```

Beta final-recovery path:

```text
normal output
-> beta register versions
-> beta lifetimes / ownership
-> beta upvalue recovery
-> beta control-flow structuring
-> closure-region inlining
-> final recovered source
```

### Structural helper recovery

Current recovery includes `_env`, `unpack`, `newproxy`, `setmetatable`, `getmetatable`, `select`, `vm`, `createUpvalueProxy`, `releaseUpvalues`, `releaseUpvalue`, `allocUpvalue`, `upvalueRefCounts`, `upvalueValues`, `currentUpvalueId`, `createClosure`, and fixed-arity `createClosureN`.

VM parameters are recovered structurally as:
`state, args, upvalues, gcProxy`.

### State/register invariants

- normalized state IDs are presentation only
- reaching definitions, provenance, epochs, lifetimes, ownership anchors, and capture cells drive recovery
- one physical register may hold multiple source lifetimes
- transitive value provenance alone must not merge unrelated ordinary register lifetimes
- captured-cell identity is stronger evidence because it is shared mutable storage
- terminal ReturnVal lowering is restricted to compiler-proven terminal shapes
- POS/state cleanup removes only proven dead compiler save/restore scaffolding

## Beta Control-Flow Capabilities

Current beta-CF supports proven:

- if / elseif / else
- shared joins
- guard/early returns
- multiple closure regions
- captured mutable upvalues
- numeric for
- generic for ... in
- while
- repeat ... until
- break
- continue
- early return inside loops
- nested/sequential loop mixtures
- multi-state short-circuit conditions
- captured loop variables
- visible numeric-for variable mutation with independent hidden induction state
- split Prometheus branch encodings
- dependency-safe reordered duplicate repeat-condition operations
- terminal return payload lowering
- per-function RegisterOverflow presentation

Generic-for currently proves the local compiler's two-variable shape including `pairs`, `next, table`, custom iterator triples, branches, break/continue, and captured variables. Unproven arities/shapes fail closed.

Repeat recovery is intended to remove the local compiler's discarded first repeat-condition evaluation and restore readable-source semantics.

## Default CF Solver / Legacy Solver

The former experimental overflow beta-CF path is now the canonical/default CF implementation.

Canonical files:

```text
passes/beta-control-flow.js
passes/beta-overflow-register.js
tools/beta-control-flow.js
```

`deobf.bat <sample> cf` and `tools/deobfuscate-beta-control-flow.js` both use this promoted path. When the user asks to "deobf cf", use the canonical `tools/beta-control-flow.js` path unless they explicitly request legacy behavior.

The old pre-promotion production solver is preserved but not used by default:

```text
passes/beta-control-flow-legacy.js
tools/beta-control-flow-legacy.js
```

The legacy CLI defaults to `*.beta.legacy.cf.lua` if manually invoked, so it cannot overwrite canonical CF output. No default project code references the legacy solver.

Compatibility aliases remain at:

```text
passes/beta-control-flow-overflow-experimental.js
passes/beta-overflow-register-experimental.js
tools/beta-control-flow-overflow-experimental.js
```

The pass/helper aliases point to the canonical implementation. The old experimental CLI remains only for compatibility; do not use it for normal CF work.

`deobf.bat` now exposes only `normal` and `cf`. Standalone beta analysis code (`tools/beta-register-versions.js`, beta passes) is retained for development/tests but is not a normal deobf mode.

## RegisterOverflow

Default CF now uses scalar overflow recovery:
- `passes/beta-overflow-register.js` proves the RegisterOverflow binding and every static numeric slot structurally.
- Sorted observed slots get dense synthetic physical scalar identities; e.g. slots 23/24 become synthetic overflow physical bases 1/2.
- Synthetic overflow physicals are inserted into the ordinary VM scalar-register declaration before beta versioning.
- From that point onward they use the exact normal beta lifetime/version solver. There is no overflow-specific nil/reset/lifetime logic.
- Final emitted beta names only are remapped to `o_vN_K`, where `K` is exactly the normal beta version number.
- Analysis metadata keeps the original synthetic physical identity unchanged; do not rename `originalTarget`/`originalRegister` independently of `originalText`, because compiler duplicate-condition/lifetime proofs depend on identity consistency.
- Overflow presentation remapping is now in-place on the fresh beta result to avoid cloning the whole large graph. Only emitted/presentation names are changed; `originalTarget`, `originalRegister`, and original synthetic physical identity remain untouched.
- If aggressive overflow prevents normal pre-beta state recovery from producing exact normalized VM leaves, canonical CF scalarizes first, reruns the existing VM-state recovery and production register scheduler, then invokes unchanged beta versioning. This remains fail-closed and only retries after the specific `No exact normalized VM state leaves were found` condition.

Forced WeAreDevs test compiler fork:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf overflow-test`

Current test setting: `MAX_REGS = 5`. The original WeAreDevs compiler is untouched.

Historical MAX_REGS=5 validation remains applicable to the promoted solver. Scalar overflow can expose more than 200 locals on some large final files; that is a practical execution/compiler limit, not a CF generation failure.

Promotion verification:
- canonical CF 1-63: 63/63 generated
- focused regression suites: 12/12 pass
- `deobf.bat spacial6 cf`: succeeds end-to-end
- `output/spacial6.beta.cf.lua`: 0 `RegisterOverflow[...]` refs and 0 residual VM/upvalue scaffold
- combined `tools/deobfuscate-beta-control-flow.js` smoke: pass
- preserved legacy solver smoke on sample 1: pass
## Verification State

All numeric fixtures currently present, sample 1 through 63, were tested.

Verified:

```text
normal generation: 63/63
beta generation: 63/63
beta-CF generation: 63/63
focused regression suites: 12/12 pass
```

Final-CF scaffold scan found no surviving dispatcher/state loop, `createClosure*`, `upvalueValues[...]`, `allocUpvalue(...)`, or `ReturnVal =` scaffolding in the checked numeric outputs.

During the performance optimization, every regenerated normal and beta-CF output for 1-63 was compared against a frozen pre-optimization baseline. After the final cache/index/copy-on-write edits, all 63 normal outputs and all 63 CF outputs are still byte-for-byte identical. The final combined 1-63 sweep completed with `BAD=` empty.

Runtime classification:

- 21/22 differences are table pointer addresses only
- 29/30 prove intended repeat-source restoration; beta-CF matches readable source
- native Luau continue cannot be directly executed by LuaJIT
- Roblox/executor fixtures 61-63 require their real environment
- some CF re-obfuscation still hits the local compiler's known `Unresolved Upvalue` bug
- anti-tamper/formatter-sensitive fixtures are not always valid standalone LuaJIT parity tests

## Fixed Repeat Short-Circuit Regression: Sample 36

Sample 36 previously retained Prometheus's compiler-discarded first evaluation of a multi-state short-circuit repeat condition, so readable source began with `short-repeat-body 0` while beta-CF began after `srA()/srC()` side effects at `short-repeat-body 1`.

Root cause: the duplicate-condition matcher saw the correct full pre-check region plus smaller suffix matches. It also treated dead pure compiler temporaries / ReturnVal aliases as semantic differences. Because the matcher required exactly one raw match, it rejected the valid full duplicate.

Fix in both production and experimental beta-CF:
- condition signatures ignore only proven dead scalar temporaries whose beta outputs are unread inside the condition region/transition graph
- compiler `ReturnVal = <identifier>` aliases are treated as storage bookkeeping, matching the existing compiler-condition signature path
- nested duplicate matches are filtered by structural containment; only a single maximal enclosing duplicate is accepted, and unrelated multiple maximal matches still fail closed

Verified source behavior is restored:

```text
short-repeat-body    0
RA                    1
RC                    1
```

Historical bisect was `0237d60` GOOD / `7a881ab` BAD. The regression is now fixed structurally without reverting later ReturnVal/join work.

Sample 20 is separate: its working-copy source has user-added `o/l/d/f` prints while tracked `20.txt` was not regenerated. Do not treat that as a solver regression.

## Large / Special Probes

### Generic-for 53-59

Proves `pairs`, `next, table`, custom iterator factory, nested branches, break, continue, and captured generic-for variables. Captured loop variables use compiler cell allocation/alias/release evidence; do not generalize beyond proven shapes.

### Sample 60

Broad control-flow smoke fixture covering mixed loops, closures, captures, methods/namecall, branches, break/continue, and generic/numeric loops. Beta-CF structures successfully. Runtime validation is constrained by native Luau/compiler re-obfuscation limitations.

### Samples 61-63

Large Roblox/UI/executor scale fixtures. Normal/beta/beta-CF generate successfully. Use for structural regression/scale testing, not standalone LuaJIT parity claims.

### sixzens.txt

Untracked large probe. Latest observed beta-CF succeeded and proved split branch encoding, dependency-ready duplicate repeat-condition matching, terminal payload sinking/lowering, and large captured-cell recovery.

Known separate presentation issue: latest sixzens final CF still had two live `local ... = state` POS-data reads. A broad materialization attempt was unsafe and reverted. Only proven dead POS save/restore scaffolding should be auto-removed.

### spacial6.txt

Large untracked probe. Normal deobf succeeds. The first beta-CF blocker was a residual compiler cleanup shape where an upvalue id is materialized as an ordinary beta value before `releaseUpvalue(id)`, so it no longer traces directly to the original `allocUpvalue()` register.

`beta-upvalues` now removes this residual release only after every other VM upvalue operation has already been recovered, the release argument is a side-effect-free value/literal, and the release assignment result is dead. Live results or any other unresolved upvalue machinery still fail closed. This removes the old state-3635 `releaseUpvalue` blocker without hardcoding state/register/id values.

After that first fix, spacial6 exposed a separate nested shared-join case: a branch had a unique immediate post-dominator that was itself a proven terminal return, but the acyclic solver discarded that local join only because it could not reach the surrounding partial continuation. Production and experimental beta-CF now preserve such a join only when `prepared[join].info.kind === "return"`; ordinary out-of-region joins are still rejected. A focused synthetic regression covers the exact outer-partial-continuation + inner-terminal-join shape in both solvers.

With that fix, the old closure-entry-2514 / state-2531 duplicate-emission error is gone. The former experimental solver that fully handles spacial6 is now the canonical/default CF solver. `deobf.bat spacial6 cf` succeeds and emits `output/spacial6.beta.cf.lua` with 3799 states, 554 closure regions, 0 `RegisterOverflow[...]`, and 0 residual VM/upvalue scaffold. The preserved legacy solver still has the separate root loop/backedge limitation, but it is no longer used by default.

Latest post-optimization spacial6 verification: combined normal->CF completed in about 10.58 s, and both generated normal and CF files were byte-for-byte identical to the existing verified outputs. Final CF size in that run was 4,293,593 bytes.

## Performance

The current optimization batch changes only execution strategy, parsing cost, indexing, caching, and allocation behavior. It does not intentionally change recovered source or proof rules.

### Current fast CF flow

`deobf.bat <sample> cf` now does:

```text
input .txt
-> one Node process
-> runDeobfuscator(..., analyzeBindings=false, structuralIntermediateAsts=true, structuralOutputAst=true)
-> in-memory normal.outputSource + normal.outputAst
-> beta register/version analysis
-> beta upvalue recovery
-> beta control-flow recovery
-> final CF output
```

The old user-facing CF path launched `main.js`, wrote the normal file, launched a second Node process, reread the normal file, and reparsed it. That duplicate process/I/O/parse handoff is removed. Diagnostic VM binding analysis is skipped only in this immediate normal->CF handoff because beta rebuilds the proof it needs; standalone normal mode keeps the normal behavior.

### Parser/cache optimizations

- After semantic naming, the combined CF handoff uses structural ASTs (`ranges` without scope/location/comment metadata) for assignment splitting, VM-state recovery, scheduling, register naming, and the returned normal AST.
- Beta terminal-return reparsing also uses structural parser options.
- Beta-upvalue expression/statement caches are 131072 entries and are cleared before/after each recovery, so a large solve does not thrash the old 32768 limit and cached trees do not leak into later stages.
- Beta-CF transition-expression cache is 131072 entries and scoped to one solve, replacing the old 4096-entry thrashing behavior.
- On spacial6, parser calls fell from roughly 654,718 to about 168,798 in the last parser-call profile.

### Upvalue/index optimizations

Beta upvalue recovery now builds reusable indexes once for:

- positions by closure owner/state
- writes by emitted target
- reads by beta name
- states by closure owner
- captured storage uses

This replaces repeated whole-graph scans for every captured cell. spacial6 has tens of thousands of operations and hundreds of recovered cells, so this removes a major quadratic cost while preserving the same dominance/escape checks.

### Allocation / copy-on-write optimizations

- RegisterOverflow beta presentation remapping works in-place on the fresh beta result instead of deep-copying every state, operation, epoch, and event. It indexes beta versions by synthetic physical register once instead of filtering the full version list for every overflow slot. Analysis identity fields remain unchanged.
- Beta lifetime reaching-definition maps use copy-on-write: Maps are shallow-copied and immutable Sets are shared until a register actually needs a union/replacement.
- Beta version reaching-definition maps use the same rule. One-predecessor flows share immutable Sets directly; multi-predecessor joins clone a Set only when a later predecessor contributes a new definition.
- Statement-level lifetime reaching snapshots share immutable Sets instead of copying them again for every statement/read.
- VM scheduler read/write caching stores the common one-context result directly and only allocates a context Map if the same AST statement is queried under another overflow context.

Do not mutate a Set after publishing it into these reaching-definition maps. The copy-on-write optimization is safe specifically because transfer/replay writes replace the entire Set for that register.

### Measured results

Historical old user-facing two-process CF path:

```text
sample63:  ~1.20 s separate normal+CF in one benchmark
spacial5:  ~3.72 s
spacial6:  ~23.89 s
```

Before the deeper cache/allocation work, the already-existing in-process combined path measured about 21.59 s on spacial6.

Current observed optimized results:

```text
1-63 combined sweep: ~2.57-2.94 s total (pre-batch frozen sweep ~3.53 s)
spacial5 combined:    ~2.3-2.7 s in observed runs
spacial6 combined:    ~10.0-10.6 s in final observed runs
```

So spacial6 is roughly 55-58% faster than the old user-facing two-process path while emitting the same files. Timing varies between runs; compare byte identity, not timing, for correctness.

CPU profiling also showed garbage-collection sampled time fall from about 3.9 s to about 2.36 s after the allocation reductions.

### Performance safety validation

Final gate after every optimization in this batch:

- 12/12 focused regression suites pass
- all 63 numeric fixtures regenerate normal + beta-CF successfully
- 63/63 normal outputs byte-for-byte match the frozen pre-optimization baseline
- 63/63 beta-CF outputs byte-for-byte match the frozen pre-optimization baseline
- spacial6 latest normal output matches its verified output byte-for-byte
- spacial6 latest CF output matches its verified output byte-for-byte
- no hardcoded fixture/state/register values were added

Profile before adding new broad scans or parallel workers. Most pipeline stages are data-dependent; removing duplicate work and allocation has been more valuable and safer than trying to run dependent passes concurrently.

## Important Recent Commits

```text
54964cf Promote overflow CF solver to default
f28771a Preserve terminal joins inside guard arms
daf4e8e Remove dead residual upvalue releases
97b285d Fix duplicated repeat short-circuit cleanup
3961200 Handle early overflow scalar state recovery
ca0dabc Treat overflow as normal beta registers
f74f4e4 Add experimental overflow beta-CF fork
7c3678a Checkpoint optimized beta-CF workspace
```

The performance batch documented above is newer than `54964cf`; use `git log` for its exact commit hash after this context update is committed.

## Immediate Priorities

1. Keep the current byte-identical fast path; profile before adding new global scans, deep copies, parser passes, or worker-thread complexity.
2. Preserve the immutable-Set/copy-on-write invariant in beta lifetime/version reaching-definition maps.
3. Preserve fail-closed behavior for unproven generic-for, POS/state-data, overflow, capture, lifetime, and repeat-duplicate shapes.
4. Re-run 12 focused suites plus 1-63 byte-identity checks after meaningful CFG/upvalue/lifetime/performance changes.
5. Use spacial6 as the primary large performance/GC probe while remembering it is untracked and environment-scale, not a simple LuaJIT parity fixture.
6. Keep this file compact; replace stale sections instead of appending chronology.

## New-Chat Resume

Read this file, inspect Git status/log, preserve unrelated working-copy files, continue the requested implementation directly, test it, update this file if needed, commit only intended files, and push main.

Do not merely summarize this handoff unless the user asks for a summary.