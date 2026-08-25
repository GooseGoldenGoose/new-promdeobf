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
-> raw or already-formatted sample/N.txt
-> integrated formatter gate (formater\luau-format.exe --luraph)
-> Luau parse
-> normal deobf
-> beta register/version analysis
-> beta control-flow recovery
```

The formatter gate is part of `loadAst`, so both `normal` and `cf` use it before the first Luau parse. It formats to a temporary output and compares exact bytes. If the formatter output matches the input, the original bytes are parsed. If it differs, only the formatted temporary source is parsed; the user input file is not overwritten. Formatter failure/missing `formater\luau-format.exe` fails clearly instead of silently parsing raw input.

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
formatter canonicalization check (--luraph)
-> Luau parse
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
- simple VM-register compound assignment normalization before beta lifetime/version analysis
- generalized atomic parallel / multi-return assignment recovery
- side-effect-safe indexed/member compound assignment preservation

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
- focused regression suites: 13/13 pass
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
focused regression suites: 13/13 pass
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

## Fixed Scalar Compound Beta Regression

A user probe in `sample/input.txt` exposed direct VM register compound assignments such as `r64 += r54` and `r28 += r56`. Normal deobf succeeded, but beta versioning treated `CompoundAssignmentStatement` as a generic statement and emitted no `emittedText`; captured-cell validation then failed with `Captured-cell validation encountered an unparseable beta operation`.

Fix in `passes/beta-register-versions.js`:
- before lifetime/version analysis, direct state-leaf compound assignments whose target is a proven simple VM register identifier are normalized structurally, e.g. `r64 += r54` -> `r64 = r64 + (r54)`
- only parser-supported compound operators are accepted: `+ - * / // % ^ ..`
- indexed/member compounds are never normalized because their LHS evaluation can have side effects; existing ordered effect-write handling remains responsible for shapes such as `upvalueValues[idx] += value`
- the normalized source is reparsed and sent through the unchanged beta lifetime/version pipeline, so register reads/writes and ownership are recovered normally instead of special-casing compound semantics later
- `normalizedCompoundAssignmentCount` reports how many simple register compounds were expanded

Verification:
- focused scalar-compound regression added to `tools/test-beta-register-versions.js`
- user input normal mode: PASS
- user input CF mode: PASS, 695 states / 39 closures
- user input normalized 2 simple register compound assignments
- final user CF: 0 `RegisterOverflow[...]`, 0 `createClosure*`, 0 `upvalueValues[...]`, 0 `allocUpvalue(...)`, 0 `while state do`, and no physical `r64`/`r28` leftovers
- 13/13 focused suites pass
- numeric 1-63 normal + CF are byte-for-byte identical to the verified round-2 baseline; none of those fixtures require the new scalar-compound path

## Complex Compound and Parallel Assignment Edge Cases

The two edge classes requested after the scalar-compound fix are now covered structurally.

### Complex compound targets

Indexed/member compound writes such as `table[index()] += value` and `object.field *= value` stay as one compound statement. Beta versioning rewrites only proven VM-register reads inside the target base/index and RHS. It never expands or duplicates the complex LHS, so calls/index expressions are evaluated the same number of times and in the same order. Direct simple VM-register compounds still use the earlier safe normalization path.

Final-CF regressions prove a side-effectful `getIndex(...)` target is emitted exactly once and both indexed/member compound operators survive beta-CF parsing/structuring. The current untracked `sample/input.txt` also exercised two complex compound effect writes and completed CF with no VM/upvalue/overflow scaffold.

### Atomic parallel / multi-return assignments

`passes/beta-register-versions.js` now has a generalized `multi-write` path for assignments whose target/RHS arity is not the old single-target/single-RHS form and that contain at least one proven VM-register target. Supported target nodes are direct identifiers plus indexed/member targets with parser ranges.

Rules:
- the whole assignment remains one atomic Lua/Luau assignment; it is never split into sequential writes
- all RHS expressions and all complex LHS address expressions are rewritten against the pre-assignment reaching versions before any target becomes current
- direct VM-register targets get normal beta lifetime/version names
- mixed indexed/member/non-register targets stay textually in the same assignment
- new beta locals needed by direct targets are declared before the atomic assignment; declarations are side-effect free and use fresh beta names
- repeated direct targets in one parallel assignment share one post-statement beta definition, matching the final physical-register value
- multiple RHS expressions, target/RHS count mismatch, a last-call multi-return tail (for example `r1, r2, r3 = 1, pair()`), and extra evaluated RHS expressions (for example `r1 = makeA(), makeB()`) are preserved as one statement
- the old exact all-register + one-call shape remains `multi-call-write` so proven generic-for recognition is unchanged; generalized shapes use graph kind `multi-write`
- generalized multi-write definitions deliberately carry no invented single-RHS provenance; reaching/lifetime analysis knows the writes but does not fabricate copy provenance across ambiguous multi-result mapping

Regression coverage includes register swap, mixed direct/indexed targets, multi-return tail call, extra RHS values, repeated targets, and final beta-CF structuring. Numeric 1-63 remain byte-for-byte identical to the verified frozen baseline. spacial6 normal + CF also remain byte-for-byte identical.

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
-> integrated formatter gate before any Luau parse
-> one Node process
-> runDeobfuscator(..., analyzeBindings=false, structuralIntermediateAsts=true, structuralOutputAst=true)
-> in-memory normal.outputSource + normal.outputAst
-> beta register/version analysis
-> beta upvalue recovery
-> beta control-flow recovery
-> final CF output
```

The old user-facing CF path launched `main.js`, wrote the normal file, launched a second Node process, reread the normal file, and reparsed it. That duplicate process/I/O/parse handoff is removed. Diagnostic VM binding analysis is skipped only in this immediate normal->CF handoff because beta rebuilds the proof it needs; standalone normal mode keeps the normal behavior.

### Input formatter gate

- `passes/input-formatter.js` runs `formater\luau-format.exe <input> --luraph --output=<temp>` before the first parse when there is no valid cache entry.
- Formatter cache is persistent under `%LOCALAPPDATA%\promdeobf\formatter-cache-v1` (or the OS temp base when LOCALAPPDATA is unavailable).
- Cache key is SHA-256 over the exact input bytes plus cache version and formatter signature (resolved formatter path, size, mtime, and `--luraph` mode), so changing input or formatter invalidates the entry.
- Already-formatted input stores a small marker. Unformatted input stores the formatted result (up to 64 MiB), so an unchanged second run skips the formatter process in both cases.
- On a miss, exact byte comparison remains the formatted-state proof. The original input file is never overwritten; temporary formatter output is removed after the check.
- Cache writes are atomic. A cache hit returns the exact same source bytes the formatter gate previously proved.
- `tools/test-input-formatter.js` proves raw->formatted recovery, cached raw reuse, already-formatted detection, and cached already-formatted reuse.
- Current numeric fixtures 1-63 are already formatted; all formatter/cache changes were verified byte-identical at normal and final CF output.

### Parser/cache optimizations

- After semantic naming, the combined CF handoff uses structural ASTs (`ranges` without scope/location/comment metadata) for assignment splitting, VM-state recovery, scheduling, register naming, and the returned normal AST.
- Beta terminal-return reparsing also uses structural parser options.
- Beta-upvalue expression/statement caches are 131072 entries and are cleared before/after each recovery, so a large solve does not thrash the old 32768 limit and cached trees do not leak into later stages.
- Beta-CF transition-expression cache is 131072 entries and scoped to one solve, replacing the old 4096-entry thrashing behavior.
- On spacial6, parser calls fell from roughly 654,718 to about 168,798 in the last parser-call profile.

### Scheduler index optimizations

VM register scheduling now builds one per-leaf index containing:

- current statement position
- readers by register name
- writers by register name

Statement moves update only the affected position range. Nearest next touch / previous producer queries use the index instead of rescanning the full statement list, and repeated `indexOf` calls are removed from the scheduling phases. If generic scheduling performs zero moves, the expensive quadratic inversion validator is skipped because the list is provably still in original order; when anything moves, the full independent safety validator still runs.

### Upvalue/index optimizations

Beta upvalue recovery now builds reusable indexes once for:

- positions by closure owner/state
- writes by emitted target
- reads by beta name
- states by closure owner
- captured storage uses

This replaces repeated whole-graph scans for every captured cell. spacial6 has tens of thousands of operations and hundreds of recovered cells, so this removes a major quadratic cost while preserving the same dominance/escape checks.

### Allocation / copy-on-write optimizations

- RegisterOverflow beta presentation remapping works in-place on the fresh beta result instead of deep-copying every state, operation, epoch, and event. Analysis identity fields remain unchanged.
- Beta lifetime reaching-definition maps use immutable Sets + copy-on-write. Linear CFG edges now share the predecessor Map directly; a new Map is allocated only when the block actually writes or a join needs a union.
- Lifetime transfer precomputes each block's last reaching definition per register once. Worklist revisits reuse immutable singleton Sets instead of replaying every statement and reallocating one-element Sets.
- Lifetime entry unknowns are prebuilt as one immutable Map per entry state. Revisited closure entries share that Map instead of rebuilding `u:entry:*` strings/Sets name-by-name.
- Statement-level lifetime reaching snapshots are created only for write-bearing statements; read-only uses point directly at immutable reaching Sets.
- Beta register versioning uses the same immutable/singleton strategy: cached singleton definition Sets, precomputed block transfer maps, shared linear predecessor maps, and prebuilt entry-definition maps.
- Version replay caches the compact unique-version view by reaching-map identity, then clones only that small mutable view for each block.
- VM scheduler read/write caching stores the common one-context result directly and only allocates a context Map if the same AST statement is queried under another overflow context.

Do not mutate a Set after publishing it into these reaching-definition maps. The optimization is safe because later writes replace the entire Set/Map entry instead of mutating inherited definitions.

### Measured results

Round-2 checkpoint before these three optimizations:
`fae4496 Checkpoint before pipeline optimization round 2`.

Checkpoint measurements (formatter check always executed, no persistent formatter cache yet):

```text
1-63 combined: 4939.2 ms
spacial6:      11616.1 ms
```

Final round-2 measurements with formatter cache explicitly disabled (isolates scheduler + lifetime/version changes):

```text
1-63 combined: 4953.0 ms (small-suite timing noise; exact output)
spacial6:       9922.2 ms (~14.6% faster)
```

Final warm-cache measurements:

```text
1-63 combined: 2646.5 ms (~46% faster than checkpoint)
spacial6 warm runs: 9451.3 / 9405.8 / 9484.4 ms
spacial6 median:    9451.3 ms (~18.6% faster than checkpoint)
spacial5 warm:      ~2172 ms
```

Timing varies with GC/system load; exact-output comparison is the correctness gate. The formatter cache matters most across many small files, while scheduler/reaching-map changes give the larger cache-independent gain on large graphs.

### Performance safety validation

Final gate after round 2:

- 13/13 focused regression suites pass
- all 63 numeric fixtures regenerate normal + beta-CF successfully
- 63/63 normal outputs byte-for-byte match checkpoint `fae4496`
- 63/63 beta-CF outputs byte-for-byte match checkpoint `fae4496`
- spacial6 normal + final CF match checkpoint byte-for-byte
- spacial5 final CF: 930 states, 116 closures, 0 `RegisterOverflow[...]`, 0 VM/upvalue scaffold
- no hardcoded fixture/state/register values added

Profile before adding new broad scans or parallel workers. Most pipeline stages are data-dependent; removing duplicate work and allocation remains safer and more useful than running dependent passes concurrently.

## Important Recent Commits

```text
fae4496 Checkpoint before pipeline optimization round 2
a80d14d Format input before Luau parsing
7f119d8 Record commit-all and caveman workflow rules
3a5b21c Optimize beta-CF pipeline performance
54964cf Promote overflow CF solver to default
f28771a Preserve terminal joins inside guard arms
daf4e8e Remove dead residual upvalue releases
97b285d Fix duplicated repeat short-circuit cleanup
```

Use `git log` for commits newer than this handoff text.

## Immediate Priorities

1. Round-2 requested targets 1-3 are complete: formatter hash cache, scheduler indexes, lifetime/version allocation reduction.
2. Preserve formatter cache invalidation by exact input hash + formatter signature; never trust filename alone.
3. Preserve immutable-Set / copy-on-write rules in lifetime/version reaching maps and entry maps.
4. Preserve the scheduler's full safety validator whenever any generic scheduling move occurs.
5. Re-run 13 focused suites plus 1-63 byte-identity checks after meaningful CFG/upvalue/lifetime/performance changes.
6. If the user asks to continue optimization, next candidates are removing more duplicate full-file parses / AST rebuilds, then re-profile before any broader redesign.
7. Keep this file compact; replace stale sections instead of appending chronology.

## New-Chat Resume

Read this file, inspect Git status/log, preserve unrelated working-copy files, continue the requested implementation directly, test it, update this file if needed, commit only intended files, and push main.

Do not merely summarize this handoff unless the user asks for a summary.