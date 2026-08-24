# Prometheus Lua/Luau Deobfuscator - Live Handoff

## Project

Workspace:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\new promdeobf`

Repository:
`https://github.com/GooseGoldenGoose/new-promdeobf.git`

Authoritative branch: `main`.

Current best verified solver checkpoint:
`7c3678a Checkpoint optimized beta-CF workspace`

`main` and `origin/main` are aligned at that commit. Prior beta checkpoint:
`485130e Checkpoint beta solver working tree`.

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

`deobf.bat <sample> normal|beta|cf` may also be used when present.

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

## Experimental Overflow beta-CF Fork

Isolated experimental files:

```text
passes/beta-control-flow-overflow-experimental.js
passes/beta-overflow-register-experimental.js
tools/beta-control-flow-overflow-experimental.js
```

Production `passes/beta-control-flow.js` remains unchanged. The experimental CLI defaults to `*.beta.overflow-exp.cf.lua` so it cannot overwrite production beta-CF output.

Run example:

```text
node tools\beta-control-flow-overflow-experimental.js output\5.lua output\5.beta.overflow-exp.cf.lua
```

## RegisterOverflow

Production final CF still uses proven per-function table presentation:
`RegisterOverflow[n] -> RegisterOverflow.vN`.

Experimental scalar method:
- `passes/beta-overflow-register-experimental.js` proves the RegisterOverflow binding and every static numeric slot structurally.
- Sorted observed slots get dense synthetic physical scalar identities; e.g. slots 23/24 become synthetic overflow physical bases 1/2.
- Synthetic overflow physicals are inserted into the ordinary VM scalar-register declaration before beta versioning.
- From that point onward they use the exact normal beta lifetime/version solver. There is no overflow-specific nil/reset/lifetime logic.
- Final emitted beta names only are remapped to `o_vN_K`, where `K` is exactly the normal beta version number.
- Analysis metadata keeps the original synthetic physical identity unchanged; do not rename `originalTarget`/`originalRegister` independently of `originalText`, because compiler duplicate-condition/lifetime proofs depend on identity consistency.
- If aggressive overflow prevents the normal pipeline from producing exact normalized VM leaves, the experimental CLI scalarizes first, reruns the existing Step 3 VM-state recovery and production register scheduler, then invokes unchanged beta versioning. This is fail-closed and only retries after the specific `No exact normalized VM state leaves were found` condition.

Forced WeAreDevs test compiler fork:
`C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf overflow-test`

Current test setting: `MAX_REGS = 5`. The original WeAreDevs compiler is untouched.

MAX_REGS=5 regenerated source fixtures 1-10 were tested through source -> obfuscation -> formatter -> normal -> experimental beta-CF:
- beta-CF generation: 10/10
- final experimental CF: zero `RegisterOverflow[...]` refs in all 10
- runtime source/obfuscated/normal/experimental-CF parity: samples 1,2,3,4,6,7,8,9 pass; samples 2 and 7 were checked on both user `math.random(1,2)` branches with a targeted runtime shim
- samples 5 and 10: source/obfuscated/normal runtime parity passes and experimental CF generates, but LuaJIT cannot compile final CF because scalarization exposes more than 200 locals
- sample 4 initially exposed inconsistent experimental `originalTarget` presentation metadata; preserving the synthetic physical identity fixed repeat recognition, and sample 4 now recovers 35 states with 1 while + 3 repeats and matches source runtime

Existing tracked normal outputs 1-63 still pass both solvers: production 63/63 and experimental 63/63. After the sample 36 repeat fix, only sample 36 changes versus the prior production beta-CF baseline; production vs experimental still differ only on true overflow fixtures 5/10.

Saved MAX_REGS=5 regenerated normal outputs 1-63 also pass the experimental solver 63/63 after the repeat fix. Only sample 36 changes versus the prior forced-overflow results, and its runtime now matches readable source with zero `RegisterOverflow[...]` refs.

Samples 5 and 10 can exceed the Lua/Luau/LuaJIT local-register limit after scalar overflow presentation. This is a real practical downside of the scalar experiment, separate from CFG generation correctness.

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

During the performance optimization, every regenerated `output/N.beta.cf.lua` for 1-63 was byte-for-byte identical to its pre-optimization result.

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

## Performance

Current optimized pipeline keeps proof/fail-closed behavior unchanged. Main speedups:

- early-terminating AST queries and cheaper `Object.keys` traversal in hot walkers
- cached beta lifetime statement read/write analysis and sparse reaching snapshots
- indexed VM lifetime lookup instead of repeated linear scans
- one reusable numeric collator for beta epoch ordering
- large beta-upvalue parse cache to avoid cache thrash on 6k+ operation files
- structural parser mode for beta/beta-CF (`ranges` only; no comments/scope/locations)
- one-pass captured storage-use indexing
- optional fast normal->beta-CF handoff that skips diagnostic-only VM binding analysis and avoids rereading/reparsing the normal output

Sample 63 measured on the same machine after this pass:

```text
normal:  ~688 ms -> ~558 ms
beta:    ~607 ms -> ~361-378 ms
beta-CF: ~917 ms -> ~603-626 ms
```

The earlier unoptimized beta-CF baseline was ~2606 ms, so cumulative improvement is substantially larger.

Safety validation:

- all 12 focused regression suites pass
- all 63 numeric fixtures pass normal + beta + beta-CF generation
- 189/189 normal/beta/CF outputs were byte-for-byte identical to the frozen pre-optimization baseline
- combined `tools/deobfuscate-beta-control-flow.js` path passes all 63 numeric fixtures; both generated normal and beta-CF outputs match that frozen baseline byte-for-byte
- sample 36 repeat-source regression is fixed; production and experimental beta-CF now match readable source, including the forced MAX_REGS=5 overflow path

## Important Recent Commits

```text
2a55d22 Optimize beta control-flow hot paths
485130e Checkpoint beta solver working tree
9f73593 Record full numeric sample sweep
7138091 Document overflow CF normalization
beda61f Normalize RegisterOverflow in beta CF
0c10bb8 Recover captured reads in effect writes
992a262 Recover sixzens control-flow variants
272db25 Remove compiler POS preservation scaffolding
```

Use `git log` for anything newer.

## Immediate Priorities

1. Keep large-file beta-CF near current optimized performance; profile before adding expensive global scans.
2. Preserve fail-closed behavior for unproven generic-for, POS/state-data, overflow, capture, lifetime, and repeat-duplicate shapes.
3. Re-test numeric fixtures after meaningful CFG/upvalue/lifetime changes.
4. Keep this file compact; replace stale sections instead of appending chronology.

## New-Chat Resume

Read this file, inspect Git status/log, preserve unrelated working-copy files, continue the requested implementation directly, test it, update this file if needed, commit only intended files, and push main.

Do not merely summarize this handoff unless the user asks for a summary.