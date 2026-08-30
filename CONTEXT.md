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

## Current Handoff Snapshot — 2026-08-30 after Step 47

Latest semantic implementation before this handoff: `e8bf425 Recover assignment scalar RHS temps`. Git/log is authoritative for newer commits.

Current phase: late structural cleanup / real-compiler audit. There is no fixed remaining step count. Do not invent Step 48+ transformations from a checklist; regenerate current production output, compare against readable source and local compiler behavior, and only implement a surviving compiler artifact when its ownership/evaluation semantics are proven.

Current verified gate:

- `tools/test-pre-cf-cf-combined.js`: **37 focused suites + 66/66 canonical samples PASS**.
- Fresh real Medium source/obfuscated/final runtime parity has been exact for Steps 42-47 fixtures.
- Production boundary remains `node tools/deobfuscate.js <obfuscated> <final>`.
- Local Prometheus authority remains the WeAreDevs compiler at `C:\Users\reala\Desktop\!workspaces\promdeobf ova\wearedev obf`.

Latest completed recovery/presentation steps:

- Step 42: global-write literal/scalar RHS transport.
- Step 43: indexed-write literal/scalar RHS transport.
- Step 44: post-discard `effect-call` argument literal/static-lookup recovery with evaluation-order proof.
- Step 45: post-discard direct global call-base recovery using preserved `compilerGlobalLookupRecovered` provenance; genuine source aliases remain untouched.
- Step 46: post-CF static table key presentation, `{["key"] = v}` -> `{key = v}` only for valid non-keyword identifier strings.
- Step 47: PRE-CF scalar RHS scratch removal for existing-local `epoch-mutate` and captured-local `upvalue-write`; identifier-root RHS remains a hard source-copy barrier. Compiler proof is `compiler.lua:1386-1440`.

Fresh outputs after these steps:

- `tmp/compiler-static-audit2-20260829.final.step46.lua` is structurally clean apart from unrecoverable source names/style: table literal is direct and call is `print("values", r_v4_2, r_v3_2[1], r_v3_2[2], r_v3_2.key)`.
- `tmp/indexed-write-20260830.final.step43.lua` / current regenerated form is structurally clean: direct indexed writes and direct `print` call; remaining register names are source-name loss, not compiler transport.
- `tmp/scope-mutation-20260830-015811.final.step47.lua` now emits direct captured mutations `r_v1_1 = 2` and `r_v1_1 = 3`. A possible next audit is the surviving nested closure terminal bare `return`; do not remove it unless child-region/compiler metadata proves it is synthetic.

Important fail-closed barriers:

- Never generic-inline one-use locals. Recover compiler intent only from exact AST/CFG/data-flow provenance.
- Do not invent original source variable names. `r_vN_K` / `o_vN_K` names are correct when source names are unrecoverable.
- Calls, indexes, table constructors, closures, globals, captures, multi-return and logical expressions have separate proof rules; do not move them across effects.
- For global READ recovery, lexical name collision is allowed by current policy after proving the real `_env` binding. For global WRITE recovery, lexical collision must still refuse direct assignment because it would bind the local.
- Source aliases such as `local f = print; f()` are real source unless compiler provenance proves otherwise.
- Identifier-root assignment RHS is a value-copy barrier; Step 47 must not collapse `local b=2; a=b` into `a=2`.

Next turn when the user says `continue`:

1. Read this file completely.
2. Check `git status --short --branch` and recent log; preserve unrelated files.
3. Regenerate current production outputs; never reason from stale `.final.step*` files alone.
4. Audit one real surviving compiler artifact. The nested synthetic child bare-return shape is a candidate, not a mandate.
5. Inspect local `compiler.lua` and existing passes before implementing.
6. Add focused positive + refusal tests.
7. Run source/obfuscated/final Luau parity where possible and the canonical combined gate.
8. Update this file, stage only intended files, commit, push `origin/main`, and verify `HEAD == origin/main`.
9. Stop after the completed step and end exactly: `Done for this turn — you can prompt now.`

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
- End every project-related turn with exactly: `Done for this turn โ€” you can prompt now.`

### Commit Everything Rule

- Do not leave project changes uncommitted. Every project file changed by the work in the current turn must be committed and pushed to `origin/main` before finishing the turn.
- "Commit everything" means include all project changes made as part of the current work, even small context/test/tool changes; do not silently leave part of the implemented work unstaged.
- Keep conceptually separate changes in separate commits when practical, but all completed current-turn project changes must be pushed before the turn ends.
- Pre-existing user edits, unrelated scratch/generated artifacts, secrets, and intentionally untracked fixtures are still preserved unless the user explicitly tells you to include them. Never use `git add .` blindly when unrelated files exist.

### Communication Style โ€” Caveman Mode

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

Current known pre-existing unrelated tracked edits (preserve; do not stage unless explicitly requested):

```text
formater/input.txt
main.js
opti/spacial6.lua
```

There are also many unrelated untracked artifacts under `opt/`, `opti/`, `tmp/`, `tools/_tmp-*`, generated `sample/*.source.obfuscated.lua`, and similar scratch paths. Preserve them.

Generated output/test artifacts are disposable unless the user explicitly asks to track them. Never use `git add .` when unrelated files exist.

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

`deobf.bat <sample> production` is the production runner. `production`, `prod`, and the old `cf` alias all call `tools/deobfuscate.js` and write the final recovered source directly to `output/<sample>.lua`; the normal-only development/intermediate mode writes `output/<sample>.normal.lua`. `tools/deobfuscate.js` is the production boundary over the verified normal -> beta/PRE-CF -> CF pipeline; internal beta-named modules remain implementation details.

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
-> overflow scalarization when needed
-> beta register versions
-> beta lifetimes / ownership
-> beta upvalue resolve + binding recovery
-> final beta register scheduling / local sinking
-> dead state/POS snapshot cleanup
-> dead state/POS initializer cleanup
-> beta control-flow structuring
-> closure-region inlining
-> final recovered source
```

Beta register/version analysis now owns captured-cell resolution before CF. For a proven compiler shape `cell = allocUpvalue(); upvalueValues[cell] = temp; local sourceBinding = temp`, the cell maps to the surviving `sourceBinding`. When no proven source binding exists, recovery creates a deterministic collision-free `u_vN` binding. Capture lists propagate `(closure entry, slot) -> recovered binding` through nested closures. Proven `upvalueValues[cell]` / `upvalueValues[upvalues[N]]` reads and writes are rewritten to that binding, and resolved alloc/release/cell bookkeeping is removed from standalone `.beta.lua`. CF consumes this pre-resolved graph/metadata; its direct recovery fallback remains only for raw/handcrafted compatibility callers.

The beta source emitter maps recovered graph operations back to their original beta statements by structural operation ownership. Atomic `multi-write` / `multi-call-write` semantics are unchanged; the mapper only accounts for their optional separate local-declaration statement so upvalue edits keep exact operation/source alignment.

After beta upvalue resolution, the final beta ordering pass is tail-only. It does not dependency-sort, sink, pull, or otherwise reorder ordinary beta statements. It only canonicalizes proven block tails: the final live `state = ...` transition is placed last when it can commute across only pure dependency-safe single-target statements, and the final proven `ReturnVal = ...` is placed immediately above that state write. Generic pure ReturnVal expressions use the same dependency proof; compiler-proven terminal return payloads may also use the existing stronger return-sink metadata so packed/unpack return payloads can move without weakening call/effect ordering. States containing multi-statement atomic operations remain untouched when exact source/graph statement ownership is unavailable. The earlier VM scheduler used by normal/source analysis remains in place because beta lifetime/version analysis consumes that normalized order. Ambiguous/effectful tail movement fails closed.

Dead state/POS snapshot cleanup runs immediately after final beta scheduling and before CF. It starts only from beta-version bindings whose exact RHS is the VM `state` value, follows only proven local beta copy edges, and removes a chain backward from zero-read leaves. Any semantic beta read keeps that binding and its ancestors live. Source operation ranges and `beta.graph` operations are deleted together, then operation indices are renumbered and the source reparsed. This is deliberately not generic dead-local cleanup.

Dead state/POS initializer cleanup runs after dead snapshot cleanup. It now handles both `local x = state` and reused-binding `x = state` definitions. The proof tracks the exact saved-state definition through the state CFG, treats pure identifier copies as transparent propagation instead of semantic reads, follows copied definitions transitively, and kills each active definition only at its own overwrite/end. Any real use (branch/call/index/arithmetic/return/state restore/etc.), ambiguous successor, or unresolved path fails closed. A reached copy is removed only after its own produced definition is independently proven dead from that operation forward; if a local copy/root must keep lexical ownership for later writes, only its initializer is cleared to a bare `local x`. Assignment-form dead state saves are removed entirely. Source edits and beta graph operations stay synchronized and are reparsed after cleanup.

Dead register-clear cleanup runs after dead state/POS initializer cleanup and before whitespace cleanup/CF. It removes only beta operations already proven by lifetime analysis as `epoch-kill` with exact direct scalar `register = nil` syntax, a concrete register epoch, zero RHS reads, ordinary physical/synthetic-overflow register identity, and no recovered-upvalue binding. It never guesses from generic `= nil` text: semantic nil definitions, `state`, `ReturnVal`, indexed/member writes, atomic multi-writes, captures, and ambiguous/unproven cases remain untouched. Source statement ownership must be exactly one statement; source and graph operations are removed together, indices are renumbered, and the result is reparsed.

Final pre-CF whitespace cleanup runs immediately after dead state/POS initializer cleanup and before CF. It removes whitespace-only/empty source lines created by prior structural edits, trims trailing spaces/tabs on ordinary source lines, preserves physical lines and trailing whitespace inside long-bracket strings/comments and multiline quoted/interpolated strings, keeps comments/statements unchanged, preserves a final newline, and reparses before accepting the cleaned source. It changes source presentation only; beta graph operations are untouched because no statement is added, removed, or reordered.

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
- proven direct `rN = nil` register cleanup stays attached to the single existing reaching beta epoch even when the previous value had zero reads; it must not consume a fresh beta suffix. Ambiguous/multi-epoch reaches remain conservative.
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
- native simple VM-register compound assignment recovery (`+=`, `-=`, `*=`, `/=`, `//=`, `%=`, `^=`, `..=`) with no normalize/reparse pass
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

`deobf.bat <sample> production` (with `cf` kept as a compatibility alias) and `tools/deobfuscate.js` use this promoted path. Internal `tools/deobfuscate-beta-control-flow.js` / `tools/beta-control-flow.js` remain the implementation layer unless legacy behavior is explicitly requested.

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
focused regression suites: 14/14 pass
```

Final-CF scaffold scan found no surviving dispatcher/state loop, `createClosure*`, `upvalueValues[...]`, `allocUpvalue(...)`, or `ReturnVal =` scaffolding in the checked numeric outputs.

Current beta-upvalue-stage verification: numeric 1-63 standalone beta finalization passes 63/63; canonical normal->CF passes 63/63 with `upvalueRecovery.completed=true` before final beta scheduling and CF. Across the 63 resolved beta outputs, dispatcher `allocUpvalue(...)` and `releaseUpvalue(...)` counts are zero; at most two `upvalueValues[...]` references remain, both generic helper-definition cleanup references outside recovered dispatcher cells. Eleven numeric fixtures require synthetic `u_vN` bindings. `spacial6` also passes the canonical overflow path at 3799 states / 554 closures / 220 overflow slots with 362 recovered cells and 2539 capture slots.


Final beta ordering verification: ordinary beta statements are no longer reordered after upvalue resolution; only proven `ReturnVal` / `state` tail movement remains. Numeric samples 1-64 pass canonical CF 64/64; sample 64 preserves runtime `1, 2, 1`; beta register-version, beta-upvalue, and beta-CF focused suites pass; `spacial6` succeeds at 3799 states / 554 closures with zero `RegisterOverflow[...]`, `createClosure`, `upvalueValues[...]`, or `ReturnVal =` scaffold in final CF.

Dead state/POS cleanup verification: `output/input.beta.lua` state snapshots reduce from 9 to 0; `spacial6.beta.lua` reduces from 251 to 8, leaving only live/semantically-read beta bindings. Dedicated dead-chain and live-use regressions pass. Full project suites remain 14/14, canonical numeric CF remains 63/63, and `spacial6` remains 3799 states / 554 closures.

Dead state/POS initializer verification: canonical pre-CF validation now follows saved-state copies transitively and handles assignment-form saves. `spacial6` has 0 remaining `= state` assignments and 0 `RegisterOverflow[...]` references before CF; numeric fixtures 1-63 pass the same canonical pre-CF path 63/63 with 0 remaining `= state` and 0 `RegisterOverflow[...]` references.

Dead register-clear verification: focused beta register/upvalue/CF suites pass; canonical CF samples 1-66 pass 66/66; fresh samples 65 and 66 each remove 2 proven `epoch-kill` clears; `spacial6` still solves at 3799 states / 554 closures with 0 `RegisterOverflow[...]`, `createClosure`, `upvalueValues[...]`, or `ReturnVal =` scaffold in final CF. A semantic `nil` regression whose nil value is copied/returned remains non-`epoch-kill` and is preserved.

Final pre-CF whitespace verification: whitespace cleanup removes 673 empty/whitespace-only lines from canonical `spacial6` pre-CF output with 0 consecutive blank-line pairs, while preserving long string/comment contents and reparsing successfully. Numeric fixtures 1-63 pass 63/63 through the same pre-CF-only path; 273 whitespace lines are removed in aggregate with 0 consecutive blank-line pairs.

During the earlier performance optimization, every regenerated normal and beta-CF output for 1-63 was compared against a frozen pre-optimization baseline, and that performance-only checkpoint was byte-for-byte identical. That byte-identity statement is historical: the current beta-upvalue ownership change intentionally changes recovered binding presentation (for example choosing the proven surviving `r_v...` source binding or a synthetic `u_vN`), so current final CF is not expected to be byte-identical to the pre-feature baseline. Current generation/parse/regression gates above are authoritative for this feature.

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

## Native Scalar Compound Assignment Recovery

Direct VM-register compounds are now handled natively instead of being expanded/reparsed first.

Supported operators:

```text
+=  -=  *=  /=  //=  %=  ^=  ..=
```

Rules:
- `CompoundAssignmentStatement` with a proven simple ordinary VM-register target becomes a `compound-write` beta plan directly.
- Lifetime analysis treats the compound target as both a read and a write. The compound syntax itself is read-modify-write evidence, so the post-write definition is merged with every fully proven concrete reaching definition of that same register.
- When that proof gives one beta epoch, emitted source stays native, e.g. `r1 += r2` -> `r_v1_1 += r_v2_1`; no extra beta source normalization or recursive reparse is needed.
- If native same-epoch emission cannot be proven, beta keeps a safe non-native fallback or preserves the unresolved compound instead of inventing ownership.
- Complex indexed/member compounds remain on the separate ordered effect-write path so LHS calls/index expressions are never duplicated.
- `nativeCompoundWriteCount` reports direct scalar compounds seen by beta; lifetime stats expose `compoundMutationMergeCount`.

Verification:
- native beta regressions cover all 8 parser-supported compound operators
- branch-join compound mutation is covered
- final beta-CF preserves native compound syntax
- 13/13 focused suites pass
- numeric 1-63 normal + CF remain byte-for-byte identical to the verified frozen baseline
- spacial6 normal + CF remain byte-for-byte identical: 3799 states / 554 closures
- current untracked `sample/input.txt` normal->CF still passes (120 states / 21 closures)

## Complex Compound and Parallel Assignment Edge Cases

The two edge classes requested after the scalar-compound fix are now covered structurally.

### Complex compound targets

Indexed/member compound writes such as `table[index()] += value` and `object.field *= value` stay as one compound statement. Beta versioning rewrites only proven VM-register reads inside the target base/index and RHS. It never expands or duplicates the complex LHS, so calls/index expressions are evaluated the same number of times and in the same order. Direct simple VM-register compounds use the native scalar compound path; complex indexed/member targets remain ordered effect writes.

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

### Sample 64

Lexical shadowing probe: `local a = 1`; inner `do` block redeclares `local a = 2`; final outer read must still see 1. Local WeAreDevs Medium obfuscation -> canonical full beta-CF succeeds at 20 states / 3 closure regions. LuaJIT runtime parity is exact for source, obfuscated input, and final CF: `1`, `2`, `1`. CF preserves semantics but does not currently recreate the original explicit `do ... end` presentation.

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

1. Continue late-stage real-output auditing after Step 47; no predetermined Step 48 transform.
2. Prefer exact compiler-proven cleanup over generic inlining/dead-code rules.
3. A candidate for the next audit is compiler-synthetic terminal bare `return` inside recovered child closures; prove child-region ownership before changing it.
4. Keep current semantic barriers for globals, captures, calls, indexes, multi-return, namecalls, and assignment RHS copies.
5. Canonical regression requirement is currently 37 focused suites + 66/66 canonical samples; also run fresh Medium runtime parity for the changed shape.
6. Preserve formatter/cache, immutable reaching-set, scheduler, and overflow invariants documented above.
7. Keep this file compact and update this snapshot instead of adding contradictory handoff sections.

## New-Chat Resume

Read this file, inspect Git status/log, preserve unrelated working-copy files, continue the requested implementation directly, test it, update this file if needed, commit only intended files, and push main.

Do not merely summarize this handoff unless the user asks for a summary.

## PRE-CF Temp Recovery Work

Step 1 checkpoint: mapped local WeAreDevs compiler temp ownership in `docs/pre-cf-temp-map.md`. PRE-CF owns only proven transport/adjacent expression setup; branch/backedge-dependent `and/or`, if, while, repeat, numeric-for, generic-for, break/continue remain CF-owned. Dedicated probe: `sample/pre-cf/01-compiler-shapes.source.lua`, verified by local Medium compilation. Do not use generic one-use inlining.
Step 2 checkpoint: added `passes/pre-cf-temp-recovery.js` proof/index infrastructure. It indexes beta writes/reads by emitted binding, exposes exact producer/consumer facts, capture status from recovered upvalue bindings, same-state/adjacency, and CFG cycle crossing. Initial safe transport proof is deliberately same-state only. Focused test: `tools/test-pre-cf-temp-recovery.js`.
Step 3 checkpoint: PRE-CF exact copy transport implemented in `finalizePreCfCopyTemps`. It folds only adjacent same-state beta-to-beta identifier copies with exact single def/use, complete CFG, no recovered-upvalue capture, exact one-statement ownership, graph/source update together, and successful reparse. Any intervening statement remains unchanged. Focused cases live in `tools/test-pre-cf-temp-recovery.js`.
Step 4 checkpoint: added adjacent PRE-CF scalar transport in `finalizePreCfScalarTemps`. It only folds exact same-state single-def/use producer->consumer pairs whose producer parses as literal/unary/binary scalar syntax; calls, indexes, logical `and/or`, tables, closures, and non-adjacent uses fail closed. Focused test: `tools/test-pre-cf-scalar-temps.js`.
Step 5 checkpoint: added `finalizePreCfLookupTemps` for adjacent static lookup snapshots only. Accepted shapes are direct `base.member` and `base[literal]` with direct identifier base; dynamic identifiers, call keys/bases, and chained lookups remain unchanged. Source/graph ownership and reparse rules match earlier PRE-CF steps. Focused test: `tools/test-pre-cf-lookup-temps.js`.
Step 6 checkpoint: added `finalizePreCfCallArgumentTemps`. An adjacent one-use call-result temp may move into a following top-level call argument only when the consumer call base is a proven beta/local binding and every earlier argument is a literal or stable identifier. The moved call is always parenthesized to preserve single-result adjustment, including final-argument position. Effectful earlier arguments, non-beta call bases, or repeated temp occurrences fail closed. Focused test: `tools/test-pre-cf-call-argument-temps.js`.
Step 7 checkpoint: added `finalizePreCfCallBaseTemps`. It folds an adjacent one-use call-base temp only when the producer is a proven beta identifier snapshot or direct static lookup; call-created callees, globals without beta provenance, dynamic lookup keys, and non-call-base uses fail closed. Focused test: `tools/test-pre-cf-call-base-temps.js`.
Step 8 checkpoint: added `finalizePreCfNamecalls` for the exact local-compiler pass-self triple: method-name string temp -> `base[key]` method temp -> immediate call whose first argument is that same base. Method names must be plain non-keyword identifiers; wrong self/base, repeated method-temp use, or any operation inserted inside the triple fails closed. Focused test: `tools/test-pre-cf-namecalls.js`.

Step 9 checkpoint: added `finalizePreCfReturnTemps`. It folds only an adjacent exact single-use temp into a compiler-proven single-expression `return-payload`. Safe scalar/static-lookup producers inline directly; call producers inline parenthesized inside the payload table to preserve one-result adjustment. Packed tables, `unpack(temp)`, and multi-expression payloads remain untouched for dedicated multi-return recovery. Focused test: `tools/test-pre-cf-return-temps.js`.

Step 10 checkpoint: `finalizePreCfMultiReturnTemps` recognizes the local compiler multi-return group structurally: one exact same-state `local pack = { call(...) }` whose every read is a local static extraction `pack[N]`, with unique slots exactly `1..N`, no capture/escape/other pack use, and single-definition uncaptured extraction targets. Extraction statements may be reordered or have scheduler-inserted unrelated operations between them; recovery keeps the call at the original pack position, replaces only that pack statement with native `local a, b, ... = call(...)`, deletes only the exact extraction statements, and preserves unrelated operations in place. If an intervening operation reads/writes a target before its original extraction, recovery refuses so moving the local declaration earlier cannot change lexical resolution. Sparse/duplicate slots, cross-state reads, nonlocal extracts, pack mutation/escape, captures, and non-single-call tables fail closed. Focused test: `tools/test-pre-cf-multi-return-temps.js`.

Step 11 checkpoint: canonical `tools/beta-control-flow.js` now runs `finalizePreCfTempRecovery` after beta scheduling/dead cleanup/whitespace and before CF. The wrapper executes Steps 3-10 in fixed order, aggregates fold counts, and fails closed on the first unsafe stage. Dedicated integration fixture: `sample/pre-cf/11-integration.normal.lua` with `tools/test-pre-cf-integration.js`; canonical normal-beta->PRE-CF->CF applies 2 safe folds and emits a parsed one-state terminal result. All focused `tools/test-pre-cf*.js` tests pass.

PRE-CF deep verification checkpoint: focused PRE-CF tests pass; six real local-WeAreDevs Medium runtime adversarial probes (call order, single-result return adjustment, native multi-return, namecall/self order, lookup snapshot mutation, copy/scalar) match source/obfuscated/final-CF stdout and exit status exactly; canonical numeric samples 1-66 pass 66/66 after two structural fixes. PRE-CF source ownership now counts beta multi-write/multi-call-write operations using the same one-vs-two-statement ownership rule as beta emission. Call-argument and return-temp recovery now preserve proven createClosure/createClosureN operations whose first numeric argument is a known beta closure entry, because CF still needs those standalone factory operations as closure-region evidence. Large spacial6 verification exposed a separate PRE-CF scale regression. Isolated on the same 8.87 MB normal output: PRE-CF disabled ~9.8 s, + copy ~13.0 s, + scalar ~34.7 s, and + lookup exceeded a 45 s bound. A full PRE-CF spacial6 run was cancelled after ~154 s wall time with the Node worker over 200 CPU-s. This is a performance/scale blocker, not a known semantic mismatch. Post-fix correctness gates remain focused PRE-CF PASS, six real Medium runtime adversarial probes 6/6 exact, numeric canonical 1-66 = 66/66, and sample 64 runtime exact 1/2/1. Do not call PRE-CF production-verified until the repeated scalar/lookup rescans are optimized.
`r`nPRE-CF performance fix: scalar, lookup, call-base, namecall, return, and copy stages now batch source-disjoint proven candidates per round instead of reparsing/re-indexing the whole beta source after every individual fold. Exact ownership and one validation reparse are retained per batch. Cross-state CFG cycle reachability is no longer computed eagerly for every binding in the hot proof-index path; `provePreCfTempUse` computes that fact only for the explicitly requested binding, while all current transform eligibility remains same-state only. On `output/spacial6.lua`, canonical beta-CF with PRE-CF now completes in about 19.7 s (3799 states / 554 closures) versus the pre-fix >150 s cancelled run; focused PRE-CF tests PASS and canonical samples 1-66 pass 66/66. No proof rule was relaxed.`r`n
Step 12 checkpoint: CF acyclic branch structuring consumes proven single-use condition beta temps directly into emitted `if` headers and now handles the real final-beta scheduling shape where pure compiler bookkeeping is placed between the condition producer and state transition or after the transition. The producer is anchored by the actual transition, must have one graph definition/read, be a normal beta scalar definition, and not be a recovered upvalue binding. Crossing is allowed only over `returnSinkSafe` direct beta definitions that neither write producer inputs/output nor read the condition temp; effectful/dependent gaps, captures, and extra uses fail closed. Proven compiler short-circuit value ladders are also recovered at the final acyclic branch using the existing Step-13 logical-program proof; unrelated inserted snapshots may move before the condition only when they are effect-free and every beta binding they read/write has one immutable definition. Real local-WeAreDevs Medium probes recover scalar/call conditions plus `A() and B()`, `B() or C()`, and `A() and (B() or C())`; source/obfuscated/final-CF side-effect output matches exactly. Argument-heavy short-circuit setup remains conservative when arm-local setup cannot be proven movable. Focused `tools/test-beta-cf-condition-temps.js` covers direct calls, logical `and`, `not`, indexed comparisons, pure-tail crossing, effect/dependency/capture/extra-use refusal, and a multi-state compiler `and` ladder. Full beta-CF suite passes and canonical numeric samples 1-66 pass 66/66.

Step 15 checkpoint: CF numeric-for recovery now consumes proven start/final/step setup temps into the native loop header after the numeric-for region is structurally proven. Literal-derived header values may move regardless of compiler scheduling; effectful/mutable producers move only as one complete `start -> final -> step` group when producer order already matches Lua header evaluation order and no extra semantic read exists. Reordered effectful producers or extra uses fail closed and keep the original beta header names. An exact recovered numeric step `1` is omitted. Real samples 35/45 now emit `for ... = 1, 3 do` / `for ... = 1, 2 do` with runtime parity exact; dedicated `tools/test-beta-cf-numeric-for-temps.js` covers default step, negative step, ordered effectful producers, reordered-producer refusal, and extra-use refusal. Full beta-CF tests pass and canonical numeric samples 1-66 pass 66/66. Real call-valued numeric-for shapes that do not satisfy the existing numeric-for structural matcher remain conservative and may still structure as while; Step 15 does not weaken loop recognition.
Step 17 checkpoint: CF loop-body branch condition temps are recovered only after loop topology has already been structured, so break/continue/join recovery cannot consume evidence needed by numeric/generic/while/repeat matchers. The structured-node pass accepts only an adjacent raw beta producer whose condition binding has exactly one structured definition/read, is not a recovered upvalue binding, and parses as an exact scalar expression; it substitutes that RHS into the proven in-loop `if` and removes the producer. Extra semantic uses/captures/ambiguous definitions fail closed. Dedicated `tools/test-beta-cf-loop-control-temps.js` covers break, continue, and extra-use refusal; existing numeric-for joined-branch plus while break/continue/return tests now require direct conditions. Real sample 31 removes branch-condition temps around `break` with exact LuaJIT source/final-CF parity. Full beta-CF tests pass and canonical raw sample/N.txt -> normal -> CF samples 1-66 pass 66/66.

Step 13 checkpoint: CF while recovery now consumes exact adjacent condition temps into the loop test and reconstructs proven compiler short-circuit value ladders into direct logical headers. Exact ladder proof handles nested bridges such as A() and (B() or C()) without duplicating calls; when the condition program is fully recovered, emission uses native while <expr> do instead of while true + guard. If any condition-body statement remains, the old guarded form is preserved. Direct-header reads are validated in the parent scope. Side-effect runtime probe through local WeAreDevs Medium -> CF matches source/obfuscated exactly for repeated A/B tests and nested X/(Y or Z); full beta-CF suite passes and numeric 1-66 pass 66/66.

Step 14 checkpoint: CF repeat recovery now consumes proven condition temps into the post-test `until` header and reconstructs exact compiler logical value ladders through the same structural proof used by Step 13. The recovered expression remains after the repeat body, so condition calls are reevaluated once per post-test and short-circuit order is preserved. Direct local-WeAreDevs Medium probe `repeat ... until A()` recovers to native `until (A())` and matches readable-source LuaJIT output exactly; focused beta-CF repeat tests pass and canonical numeric samples 1-66 pass 66/66. Existing duplicate-repeat-precheck cleanup remains separate: sample 36's proven duplicated region is still removed, but a broader compiler shape that interleaves unrelated source closure setup inside the discarded first short-circuit precheck remains conservatively unreduced because deleting that mixed region would also delete real declarations. Do not broaden that cleanup without a proof that preserves those interleaved source operations.

Step 16 checkpoint: CF generic-for recovery now consumes the local compiler's proven one-call iterator pack only after the generic-for region is structurally proven. Exact `{ factory(...) }` storage plus slot-1/2/3 extraction and copy chains are replaced by the original single iterator expression in the native `for ... in` header; the factory call still executes exactly once before iteration. Only compiler iterator-step/branch/loop-variable uses are allowed for the consumed tuple; pack escape, extra semantic reads, captures, ambiguous definitions, effectful crossed setup, or unproven shapes fail closed. Real sample 59 changes from `for ... in iter, invariant, control do` with pack/extract temps to `for ... in r_v2_1(r_v6_1) do`; source/final-CF LuaJIT output matches exactly. Dedicated `tools/test-beta-cf-generic-for-temps.js` covers packed recovery and extra-pack-use refusal. Full beta-CF tests pass and canonical numeric samples 1-66 pass 66/66. Generic-for shapes that do not pass the existing structural loop matcher remain conservative; Step 16 does not broaden loop recognition.

Step 18 checkpoint: added tools/test-pre-cf-cf-combined.js as the canonical combined regression gate for the complete PRE-CF + CF temp-recovery sequence. One command runs all 14 focused PRE-CF/CF suites, then regenerates raw sample/1.txt through sample/66.txt via the real normal -> PRE-CF -> CF pipeline into tmp output, requires PRE-CF safe completion, requires CF application, and reparses every final source. Current gate passes 14/14 focused suites and 66/66 canonical samples. No semantic solver change was required by Step 18.


Step 19 checkpoint: post-CF structured cleanup now removes only an adjacent exact local identifier copy when that temp has one structured definition/read, is not captured, its source is already proven local/captured, and the next raw beta assignment consumes the temp exactly once in the leading evaluation position of a scalar-only RHS (identifier/literal/unary/binary; no calls, indexes, tables, closures, or logical and/or). No statement is crossed. Non-leading uses, effectful/unsupported expressions, extra uses, captures, and intervening statements fail closed. Dedicated `tools/test-beta-cf-post-copy-scalar.js` covers the fold and refusal barriers. Fresh canonical samples 1-66 pass 66/66 with 252 folds across 10 samples; sample 3 changes `local r_v5_7 = r_v1_1; local r_v1_9 = r_v5_7 + r_v9_2` to `local r_v1_9 = (r_v1_1) + r_v9_2` with exact LuaJIT runtime parity. The combined gate now runs 15 focused suites.
Get-global recovery checkpoint: canonical PRE-CF now runs `finalizePreCfGlobalLookups` after scalar temp recovery and before generic lookup recovery. It first reproves the collision-safe `_env` wrapper binding from the scoped beta source, then rewrites static environment lookups whose key resolves to a valid non-keyword identifier. Per user direction, proposed global-name collisions with existing locals/parameters are no longer a refusal barrier; only environment-binding shadowing remains protected. Exact string-key temps require one definition/use, same-state forward definition, no capture, and a string-literal producer; that dead key temp is removed while the destination alias is preserved, e.g. `local k = "print"; local f = _env[k]` -> `local f = print`. Dynamic keys, extra uses, captures, shadowed `_env`, invalid identifiers and keywords fail closed; shadowed global names are intentionally allowed by current policy. Dedicated `tools/test-pre-cf-global-lookups.js` covers recovery/refusal. Combined gate is 16 focused suites + canonical 1-66 = 66/66; the current 1-66 sweep recovers 748 globals / removes 748 key temps with 13 conservative refusals, and sample 1 LuaJIT parity is exact.
Production promotion checkpoint (2026-08-29): added `tools/deobfuscate.js` as the user-facing production boundary and changed `deobf.bat` so `production`/`prod`/legacy `cf` write final recovered source to `output/<sample>.lua`; normal-only development output is `output/<sample>.normal.lua`. `tools/test-production-pipeline.js` proves production output is byte-identical to the canonical internal beta-CF path on sample 1 and is included in the combined gate, which now passes 17 focused suites + 66/66 canonical samples. Fresh local-WeAreDevs Medium promotion probes under `tmp/promotion-tests/01-16` cover multi-return, mutable closures/upvalues, short-circuit if/while, repeat, numeric/generic/custom loops, method/namecall, parallel assignment, local/global-name collision shapes, nested closures, varargs, argument side-effect order, shadowed names, and captured loop locals; source == obfuscated == final production runtime output under the user Luau CLI for all 16/16 valid probes. A first method-declaration probe was rejected from the gate because the local Prometheus compiler itself produced a runtime-broken obfuscation; the equivalent assignment+namecall probe executes correctly and passes end-to-end. Sample 1 production runtime parity is exact: `baseline\t14\t4`.

Call-argument scalar setup checkpoint (2026-08-29): `finalizePreCfCallArgumentTemps` now also folds a contiguous tail of proven one-use literal-only scalar argument producers into one following direct call. It handles compiler-reordered setup such as `arg2=2; arg1=1; f(arg1,arg2)` -> `f(1,2)` while leaving call-base/lookup/and-or recovery unchanged. Eligible scalar expressions are literals and unary/binary compositions of literals only; identifiers, calls, indexes, tables, captures, extra uses, non-call consumers, and non-contiguous/effectful gaps fail closed. Focused `tools/test-pre-cf-call-argument-temps.js` covers the two-argument reversed setup. Exact fresh Medium probe `tmp/andor-final2`: final `final.lua:13` is `local r_v2_2 = r_v3_1(1, 2)`; seeded source/obfuscated/final runtime output matches. Combined production gate remains 17 focused suites + 66/66 canonical samples.

Call-result lifetime barrier checkpoint (2026-08-29): cleanup/return-anchored backward register lifetime merging no longer treats transitive provenance through a call as proof that an earlier same-physical-register value belongs to the returned-value epoch. `dependencyPathCrossesCall` blocks only provenance paths that actually reach the candidate prior definition through a `CallExpression`; direct identifier-copy continuity, joins, native compound mutation, and non-call arithmetic write-back remain unchanged. Exact local Medium probe `local a = math.random(1,2); print(a == 2)` now produces `local r_v2_2 = r_v3_1(1, 2); local r_v1_4 = r_v2_2` instead of mutating the argument-temp lifetime. Focused beta-register regressions cover cleanup-anchored call split plus cleanup-anchored arithmetic continuity; call-argument focused PASS; combined production gate remains 17 focused suites + canonical 66/66; fixed-seed source/obfuscated/final Luau parity is exact.
Post-CF logical scalar-chain checkpoint (2026-08-29): `recoverStructuredPostCfCopyScalarTemps` now folds proven computed scalar/logical temps and side-effect-free literal logical operands, plus adjacent self-logical mutation `local x = expr; x = x or/and rhs` into one expression. Calls/index/table/function producers remain refused; captures, extra uses, and non-adjacent effectful statements remain fail-closed. Exact Medium probe `local a = math.random(1,2) == 1 and "wasd" or "ee"; print(a)` now emits one recovered value expression at `tmp/andor-exact/final.optimized.lua:15`; focused post-CF test PASS; combined gate 17 focused suites + 66/66 canonical PASS; fixed-seed source/obfuscated/final Luau parity exact (`ee`).
Packed-call lifetime barrier checkpoint (2026-08-29): beta lifetime dependency-call detection now treats calls nested anywhere inside a dependency RHS (not only top-level `CallExpression`) as call boundaries. This fixes the local compiler multi-return shape `tmp = { call(...) }; ReturnVal = tmp[1]; reused = ReturnVal`, where a freed physical register previously holding an unrelated call input was incorrectly merged into the new source-binding lifetime. Exact probe `tmp/pcall-mr-418818ce695d4c9cbdd154ab928570cb/final.step1.lua` now keeps `tostring` in `r_v4_1` and creates source local `a` as fresh `r_v4_2`; focused beta-register tests pass, combined gate remains 17 focused suites + 66/66 canonical, and Luau source/obfuscated/final all exit 0 with matching `true + table:` result shape.
Multi-return compiler-group recovery checkpoint (2026-08-29): `finalizePreCfMultiReturnTemps` uses the local compiler's exact `{ call(...) }` plus static result-slot readers rather than requiring those readers to remain contiguous after later scheduling. Every pack read must be a same-state local `pack[N]`, slots must be unique and exactly `1..N`, and targets are sorted by slot before emitting one native `multi-call-write` at the original pack/call position. Scheduler-interleaved unrelated operations are preserved in place; any intervening read/write of an extraction target refuses recovery to avoid changing local visibility. Duplicate/sparse/cross-state slots, pack escape/mutation, captures, nonlocal extracts, and non-single-call packs fail closed. Exact Medium probe `tmp/returnall-return-payload-20260829-2343/final.multireturn.lua:48-50` now emits `local r_v2_4, r_v7_1, r_v6_1 = r_v3_1()` followed by the preserved unrelated `local r_v5_1 = r_v2_3`; focused multi-return and RETURN_ALL suites PASS, combined gate is 18 focused suites + 66/66 canonical PASS, and source/obfuscated/final Luau output matches exactly.
RETURN_ALL call-argument recovery checkpoint (2026-08-29): `finalizePreCfReturnAllTemps` now removes the local compiler final-argument scaffold `pack = { inner(...) }; outer(..., unpack(pack))` only when the pack has one definition/read, is uncaptured, same-state adjacent to the consumer, and the unpack call is the final outer argument. The inner call is substituted directly into that final argument so all return values still expand; non-final unpack, extra pack reads, direct pack use, and captures fail closed. Exact Medium probe `tmp/multi-return-func-a556f06f0e17483bb828ac92a443afa1/final.returnall.lua:50` now emits `local r_v8_7 = r_v1_5(r_v2_1(r_v11_1, r_v12_1))` with the `{ call() }`/`unpack(pack)` transport gone. Focused RETURN_ALL suite PASS; combined gate 18 focused suites + 66/66 canonical PASS; Luau source/obfuscated/final runtime output is exactly `12`, `34`, `2 3 12 34 56`.

RETURN_ALL return-payload recovery checkpoint (2026-08-29): `finalizePreCfReturnAllTemps` now also removes the local compiler terminal-return scaffold `pack = { inner(...) }; ReturnVal = { ..., unpack(pack) }` only when the pack has one definition/read, is uncaptured, same-state adjacent to a compiler-proven terminal `return-payload`, and `unpack(pack)` is the final return expression. It rewrites that tail to the original call so Lua multi-return expansion is preserved, updates `returnExpressions`/reads/source ownership together, removes the pack operation, and reparses. Non-final unpack, extra reads, capture, non-terminal payloads, and non-single-call packs fail closed. Exact Medium fixture `tmp/returnall-return-payload-20260829-2343/final.after.lua:30,45` now emits direct `return r_v2_9()` and `return r_v2_10, r_v7_9()`. Focused RETURN_ALL suite PASS; combined gate remains 18 focused suites + 66/66 canonical PASS; source/obfuscated/final Luau parity is exact. Fresh side-effect/namecall stress `tmp/returnall-return-stress-20260829/final.lua:63,82` also recovers direct return calls with exact runtime parity.

Closure-temp recovery checkpoint (2026-08-29): `finalizePreCfClosureTemps` now recovers the local compiler function-literal transport `temp = createClosureN(entry, captures); actual = temp` before CF. The proof requires an exact known `createClosure`/`createClosureN` entry, one definition/use of the temp, no capture/escape, same-state forward copy, direct destination binding, and no intervening read/write of the destination that would make moving its declaration earlier observable. The closure factory call stays at the original temp position; only its target is retargeted to the actual binding and the exact copy is removed, so existing closure-region embedding sees unchanged factory evidence and emits the nested function directly on the source binding. Focused `tools/test-pre-cf-closure-temps.js` PASS; canonical PRE-CF integration PASS; combined gate is 19 focused suites + 66/66 canonical PASS. Exact Medium fixture `tmp/closure-shape-20260829/final.closuretemp.lua:7-20` now emits `local r_v2_1 = function(r_v3_2) ... end` with the prior `local r_v1_1 = function...; local r_v2_1 = r_v1_1` transport gone; source/obfuscated/final Luau all exit 0.

Call-result destination recovery checkpoint (2026-08-30): `finalizePreCfCallResultDestinations` now recovers the local compiler call-result transport where an exact call is first written through compiler storage (`state`/`ReturnVal`) and then copied into a real physical VM-register epoch. Recovery requires one definition/read of the compiler result, no capture, same-state forward transport, a direct physical-register destination (`rN`/synthetic overflow epoch), no intervening read/write of either temp or destination, and exact source ownership. The call stays at its original evaluation point; only the producer target is retargeted and the exact copy is removed. Closure factories are excluded for the dedicated closure pass. Focused `tools/test-pre-cf-call-result-destinations.js` PASS; PRE-CF integration PASS; combined gate is 20 focused suites + 66/66 canonical PASS. Exact local Medium fixture `tmp/call-result-destination-20260830/final.lua:7-15` reduces `temp = pcall(print); actual = temp` to direct `local r_v4_2 = r_v2_1(r_v4_1)`; source/obfuscated/final Luau stdout matches exactly (`a	true`) with exit 0.
Discarded call-result recovery checkpoint (2026-08-30): `finalizePreCfDiscardedCallResults` now removes only compiler-proven unused call result storage: a `version-define` call whose original target is VM `state`/`ReturnVal`, has no register epoch, has exactly one definition and zero semantic reads, is uncaptured, and is not a closure factory. The call stays at the same statement position; only the fake result binding is removed and the beta operation becomes an `effect-call`. This avoids deleting genuine source locals such as `local x = print(...)`: those still copy the compiler call result into a physical source-register epoch and are preserved. Focused `tools/test-pre-cf-discarded-call-results.js` PASS; PRE-CF integration PASS; combined gate is 21 focused suites + 66/66 canonical PASS. Fresh local Medium compare fixture `tmp/discarded-call-compare.final.lua:7-13` emits bare `r_v2_1("bare")` while preserving `local r_v3_3 = r_v2_2("assigned")`; source/obfuscated/final Luau output is exactly `bare`, `assigned`, exit 0. Existing closure/member audit also recovers the method call statement to bare `r_v5_2:m(1)`.

Table-destination recovery checkpoint (2026-08-30): `finalizePreCfTableDestinations` now recovers the local compiler table-constructor transport where an exact `TableConstructorExpression` is first written through compiler storage (`state`/`ReturnVal`) and then copied into a real physical VM-register epoch. Recovery requires one definition/read, no capture, same-state forward transport, direct physical-register destination, no intervening read/write of temp or destination, and exact source ownership. The table is still created at its original producer position; only that producer is retargeted and the exact copy is removed. Declaration ownership now also handles the compiler's terminal-state register-reuse shape: when an `epoch-mutate` destination already has a prior local value that is read by this constructor, the recovered constructor shadows it with a new `local` at the original constructor point; cross-state cases stay assignments and fail closed on lexical escape risk. Entry/key/value temps remain intentionally untouched for the next dedicated table-entry step. Focused `tools/test-pre-cf-table-destinations.js` PASS; combined gate remains 22 focused suites + 66/66 canonical samples. Exact Medium audit `tmp/compiler-static-audit2-20260829.final.table-decl.lua:21-25` now emits `local r_v3_2 = { ... }`; source/obfuscated/final Luau output matches exactly (`values\ttrue\t1\t2\t3`).
Table-entry temp recovery checkpoint (2026-08-30): `finalizePreCfTableEntryTemps` now runs immediately after table-destination recovery. It folds only direct table array/key/value identifier temps whose exact nearest reaching same-state definition is a local literal-only scalar expression; calls, indexes, tables, closures, captures, repeated field uses, intervening reads/writes, cross-state live values, and ambiguous ownership remain unchanged. It handles the real self-shadow case `local old = 2; local old = { old }` by preserving Lua RHS-before-new-local semantics. Exact Medium `tmp/compiler-static-audit2-20260829.final.tableentry.lua:13-17` emits `local r_v3_2 = { 1, 2, ["key"] = 3 }`; source/obfuscated/final Luau output matches exactly (`values\ttrue\t1\t2\t3`). Focused test + integration PASS; combined gate 23 focused suites + 66/66 canonical samples PASS.

Static index-key recovery checkpoint (2026-08-30): `finalizePreCfIndexKeyTemps` now removes compiler-only literal key temps from exact indexed reads after table-entry recovery. Proof requires complete CFG, exact single definition/use, same-state forward flow, uncaptured local producer, literal-only scalar key, direct identifier base, exact `IndexExpression` key position, no intervening key touch, exact source ownership, and successful reparse. Calls, computed/non-index uses, captures, extra reads, or overwritten keys fail closed. Exact Medium audit `tmp/compiler-static-audit2-20260829.final.indexkey.lua:21-25` emits `r_v3_2[1]`, `r_v3_2[2]`, and `r_v3_2["key"]` directly. Focused `tools/test-pre-cf-index-key-temps.js` PASS; integration PASS; combined gate is 24 focused suites + 66/66 canonical samples; source/obfuscated/final Luau runtime output matches exactly (`values\ttrue\t1\t2\t3`).

Global-write recovery checkpoint (2026-08-30): `finalizePreCfGlobalWrites` now recovers compiler-proven global assignments from beta `effect-write` shapes `_env[key] = value` / `_env["name"] = value` to direct `name = value`. Dynamic key temps require one definition/use, same-state forward ownership, uncaptured literal-string producer, and exact source ownership; the dead key temp is removed. Direct emission is refused when the proposed global name is invalid/reserved, `_env` is unproven/shadowed, or any lexical local/parameter/loop binding with the same name exists, because direct assignment would bind that local instead of the environment. Fresh local Medium fixture `tmp/global-write-20260830.final.lua:9,19` emits direct `answer = ...`; source/obfuscated/final Luau output is exactly `g\t1`, `g\t2`. Focused global-write and PRE-CF integration tests pass.
Indexed-write key recovery checkpoint (2026-08-30): `finalizePreCfIndexedWriteTemps` now runs after global-write recovery and removes compiler-only literal key temps from exact indexed assignment writes such as `base[key] = value`. Proof requires complete CFG, beta `effect-write` ownership, exact one-use same-state key transport, uncaptured local literal-only key producer, direct identifier base, exact `IndexExpression` key position, no intervening key touch, exact source ownership, and successful reparse. `_env[...]` writes stay owned by global-write recovery; compound assignments, member writes without a key temp, dynamic/computed keys, captures, extra reads, and overwritten keys fail closed. Fresh Medium fixture `tmp/indexed-write-20260830.final.lua:11,15` emits `r_v2_1[1] = r_v3_1` and `r_v2_1["key"] = r_v3_2`; source/obfuscated/final Luau output matches exactly (`w\t10\t20`). Focused indexed-write and PRE-CF integration tests pass.
Closure-write destination recovery checkpoint (2026-08-30): `finalizePreCfClosureWriteDestinations` now runs immediately after indexed-write key recovery. Step 26 already turns compiler key temps into static indexed writes; Step 27 specializes proven closure-factory destinations further from `base["member"] = closureTemp` to `base.member = closureTemp` when the member is a valid non-keyword identifier. The pass requires an exact beta `effect-write`, direct identifier base, string-literal member key, one-definition/one-use uncaptured closure binding, same-state forward flow, and a producer that is a proven `createClosure`/`createClosureN` call for a known closure entry. It never removes or moves the closure producer, so closure allocation timing/identity is preserved. Invalid member names, non-closure values, extra uses, captures, or ambiguous ownership remain unchanged. Exact Medium audit `tmp/compiler-static-audit-20260829.final.closurewrite.lua:53,65` emits `r_v5_2.m = r_v3_4` and `r_v5_2.n = r_v6_2`; source/obfuscated/final Luau output is exactly `call-statement`.

Step 28 chained call-setup recovery checkpoint (2026-08-30): `finalizePreCfCallSetupChains` now runs after global/static lookup recovery and before the individual call-argument/base passes. It recovers a contiguous compiler setup group only when the call base plus at least one direct argument are one-use uncaptured same-state local temps, every producer is a side-effect-free identifier/literal snapshot, and every temp is consumed by the same direct call. The group is rewritten at the original call position (for example `local base=pcall; local arg=print; local actual=base(arg)` -> `local actual=pcall(print)`), so call timing/count stay unchanged and setup reads cannot cross effects. Calls/indexes/tables/functions, captures, extra uses, non-contiguous groups, or ambiguous ownership fail closed. Focused `tools/test-pre-cf-call-setup-chains.js` covers positive identifier/literal chains plus effect/extra-use/capture refusal.

Step 29 post-CF closure destination recovery checkpoint (2026-08-30): `recoverStructuredPostCfClosureDestinationTemps` now runs after closure-region factory replacement and before post-CF scalar-copy cleanup. It folds only adjacent structured `local temp = function(...) ... end` -> direct assignment/local destination uses when the temp has exactly one structured definition/read and is not captured. The consumer must be a single direct assignment/local statement whose RHS is exactly that temp; identifier, member, and indexed destinations are supported. No statement/effect is crossed, and the already-recovered nested function expression is moved only into the immediately following destination, so closure allocation/call timing and CF factory evidence are preserved. Intervening operations, extra uses, captures, non-function producers, and unsupported targets fail closed. Fresh real Medium audit `tmp/compiler-static-audit-20260829.final.step29.lua:29,41,51` now emits direct `g = function(...)`, `r_v5_2.m = function(...)`, and `r_v5_2.n = function(...)`; source/obfuscated/final Luau output is exactly `call-statement`. Focused post-CF closure-destination and main beta-CF tests pass; combined gate is 29 focused suites + 66/66 canonical samples.

Step 30 post-CF dead closure cleanup checkpoint (2026-08-30): `recoverStructuredPostCfDeadClosureTemps` runs immediately after post-CF closure-destination recovery. It removes only recovered `local temp = function(...) ... end` values that are uncaptured and structurally unobservable: either the closure binding has zero reads, or its sole read is a direct assignment/local declaration into another uncaptured local binding that itself has zero reads. No closure is moved or evaluated at a different point; the dead producer and, when present, the dead local transport write are deleted in place, so unrelated effects between them remain ordered. Global/member/index writes, captured closures/destinations, live destinations, extra closure uses, and non-function producers remain unchanged. Focused `tools/test-beta-cf-post-dead-closures.js` covers zero-read removal, dead local chains across effects, dead local declaration destinations, plus capture/live/global refusal.

Step 31 closure positional-parameter / vararg signature recovery checkpoint (2026-08-30): `recoverNestedFunctionSignature` now recovers parameters from proven surviving static `args[K]` reads in the fully structured child body, including cases where earlier cleanup already inlined compiler parameter-load locals. It no longer depends on the randomized numeric suffix of `createClosureN` for source arity. Static positive integer slots are mapped to parameters; sparse slots preserve position, existing parameter-load target names are reused, direct-only slots get deterministic collision-free `argN` names, and all direct `args[K]` reads are rewritten. Dynamic indexes, writes, bare/escaped `args`, unsupported unpack/select shapes, ambiguous bindings, nested-capture ambiguity, parse/range failure, or mixed unsafe storage fail closed. Existing proven vararg-tail recovery is preserved and emits `...` only when the tail shape is structurally proven. Focused `tools/test-beta-cf-closure-signatures.js` covers direct one/two/three-slot recovery, repeated/reordered reads, sparse slots, mixed explicit/direct loads, name collisions, nested functions, unsafe args uses, and real varargs. Fresh local Medium closure audit `tmp/compiler-static-audit-20260829.final.step31.lua` now emits `g = function(arg1)`, `r_v5_2.m = function(arg1)`, and `r_v5_2.n = function(arg1)` with no nested synthetic `local args = { ... }`; source/obfuscated/final Luau output is exactly `call-statement`. Main beta-CF tests pass and combined gate is 31 focused suites + 66/66 canonical samples.
Step 32 post-CF namecall recovery checkpoint (2026-08-30): `recoverStructuredPostCfNamecalls` now rewrites only exact direct-identifier self-call shapes `base["method"](base, ...)` to native `base:method(...)` after CF structuring. The method key must be a plain non-keyword identifier string, the call base must be a direct identifier, and the first argument must be that exact same identifier; effectful/computed bases, dynamic/invalid/keyword keys, or mismatched self remain unchanged. No evaluation point moves. Focused `tools/test-beta-cf-post-namecalls.js` covers bare/result calls and refusal cases. Fresh Medium closure audit `tmp/compiler-static-audit-20260829.final.step32.lua:40` now emits `r_v5_2:m(1)` and runtime remains exactly `call-statement`. Main beta-CF passes; combined gate is 32 focused suites + 66/66 canonical samples.
Step 33 post-CF static-member presentation checkpoint (2026-08-30): `recoverStructuredPostCfStaticMembers` now runs after semantic post-CF cleanup and rewrites only direct-identifier static string indexes `base["field"]` to `base.field` when the key is a plain non-keyword identifier. Reads, writes, and call arguments are supported; computed/effectful bases, dynamic keys, invalid names, and keywords stay bracketed. This is presentation-only and reparses each rewritten raw statement before accepting it. Focused `tools/test-beta-cf-post-static-members.js` covers read/write/call positions plus refusal cases. Fresh Medium closure audit `tmp/compiler-static-audit-20260829.final.step33.lua` keeps native `r_v5_2:m(1)` and has no remaining eligible static bracket member; runtime remains exactly `call-statement`. Main beta-CF passes; combined gate is 33 focused suites + 66/66 canonical samples.
Step 34 post-CF dead scalar local cleanup checkpoint (2026-08-30): `recoverStructuredPostCfDeadScalarLocals` now removes only zero-read, single-definition, uncaptured local storage whose initializer is side-effect-free and structurally safe: nil/number/string/boolean literals, or an identifier already proven local/captured in the structured body. Multiple definitions, later writes, captures, live reads, calls, indexes, tables/functions, and unproven/global identifier reads remain unchanged. Fresh Medium closure audit `tmp/compiler-static-audit-20260829.final.step34.lua` removes the dead `local r_v2_1 = nil`; it deliberately keeps `local r_v8_1 = args` because the root wrapper `args` binding is outside structured-node provenance. Focused `tools/test-beta-cf-post-dead-scalars.js` and main beta-CF pass; combined gate is 34 focused suites + 66/66 canonical samples.
Step 35 discarded-call provenance guard checkpoint (2026-08-30): a broad post-CF rewrite `local x = call(...)` -> bare `call(...)` was tested and rejected because it also removes genuine source locals whose values happen to be unused. Existing PRE-CF discarded-call recovery deliberately requires compiler-result ownership (`state`/`ReturnVal`, no register epoch), so a beta register epoch is a safety barrier until stronger compiler provenance exists. `tools/test-beta-cf-post-discarded-call-results.js` now permanently proves that beta-CF preserves a genuine unused source call local (`local sink = consume(value)`). The remaining real audit shape `local r_v6_4 = print("call-statement")` therefore remains intentionally unchanged for now; fixing that specific compiler-generated storage requires an earlier provenance proof, not generic dead-call cleanup.
Step 36 compiler-scratch discarded-call recovery checkpoint (2026-08-30): PRE-CF now distinguishes direct compiler scratch call results from source-owned call locals. Local compiler authority at `compiler.lua:1226-1252` shows `FunctionCallStatement` allocates a temporary `retReg`, writes the call result directly, then immediately frees that register; `LocalVariableDeclaration` instead compiles the call into an expression temp and copies it into a source variable register (`compiler.lua:1180-1214`). `finalizePreCfCallResultDestinations` now preserves explicit `compilerCallResultRetargeted` provenance when it retargets a compiler result through that source-variable copy. `finalizePreCfDiscardedCallResults` may also lower a zero-read, single-definition, uncaptured direct physical-register call epoch to a bare call only when it was not Step-20-retargeted and is not a closure factory. This fixes the real audit from `local r_v6_4 = print("call-statement")` to `print("call-statement")` while preserving genuine source call locals. Focused discarded-call tests and the permanent post-CF source-local guard pass. Fresh local Medium probe `tmp/discarded-call-provenance.source.lua` keeps `local r_v3_2 = print("assigned")`, removes only the true bare-call result, and source/obfuscated/final Luau output matches exactly (`assigned`, `after\tnil`, `bare`). The compiler static audit final `tmp/compiler-static-audit-20260829.final.step36.lua:36` is bare `print("call-statement")`; source/obfuscated/final runtime output is exact. Combined gate remains 35 focused suites + 66/66 canonical samples.
Step 37 root synthetic-args cleanup checkpoint (2026-08-30): post-CF dead-scalar cleanup now receives the presenter's synthetic-local proof explicitly. A dead `local x = args` is removable only when `args` is a proven synthetic wrapper local **and** `x` is a direct physical-register epoch (`rN`/overflow) with one definition, zero reads, and no capture; arbitrary/source locals such as `local setup = args` remain preserved. After structured cleanup, `buildPresentedSource` emits `local args = { ... }` only when the remaining body still references `args`, so a fully recovered root wrapper no longer keeps an unused vararg table. Fresh Medium audit `tmp/compiler-static-audit-20260829.final.step37.lua` now has no root `r_v8_1 = args` and no root `local args = { ... }`; relevant final lines are `34: print("call-statement")`, `36: r_v5_2:m(1)`, `38: return`. Source/obfuscated/final Luau output is exactly `call-statement`. Focused dead-scalar + main beta-CF tests pass; combined gate remains 35 focused suites + 66/66 canonical samples.
Step 38 post-CF function declaration presentation checkpoint (2026-08-30): `recoverStructuredPostCfFunctionDeclarations` now rewrites only direct assignment-form recovered closures into equivalent Lua function declaration sugar: `g = function(...) ... end` -> `function g(...) ... end` and dot-member chains such as `t.m = function(...) ... end` -> `function t.m(...) ... end`. Targets must be an Identifier or a pure dot MemberExpression chain rooted at an Identifier; indexed/computed/effectful targets and all LocalStatement forms remain unchanged. In particular `local x = function...` is intentionally not rewritten to `local function x...` because that changes recursive lexical binding semantics. No colon declarations are produced, so self/namecall semantics are untouched. Fresh Medium audit `tmp/compiler-static-audit-20260829.final.step38.lua` emits `function g(arg1)` at line 5, `function r_v5_2.m(arg1)` at line 16, and `function r_v5_2.n(arg1)` at line 25; source/obfuscated/final Luau output is exactly `call-statement`. Focused function-declaration + main beta-CF tests pass; combined gate is 36 focused suites + 66/66 canonical samples.
Step 39 presentation-marker cleanup checkpoint (2026-08-30): beta-CF keeps `--headers` / `--body` markers only as internal region delimiters while child closures are being solved, then strips the root markers at the outer public solver boundary. `nestedFunctionExpression` no longer emits synthetic marker comments, so recovered nested closures are marker-free too. Finalization is exact-prefix/delimiter based rather than a broad regex, so user strings/comments are not scanned or rewritten. Fresh Medium audit `tmp/compiler-static-audit-20260829.final.step39.lua` has no `--headers`/`--body`; relevant lines are `1: function g(arg1)`, `8: function r_v5_2.m(arg1)`, `13: function r_v5_2.n(arg1)`, `18: print("call-statement")`, `20: r_v5_2:m(1)`, `22: return`. Source/obfuscated/final Luau output is exactly `call-statement`. Main beta-CF tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 40 nested-function spacing checkpoint (2026-08-30): `nestedFunctionExpression` no longer inserts an artificial blank line between a recovered function header and its first emitted body statement. This is generator-local presentation cleanup only; no global whitespace rewriting or semantic AST movement occurs. Fresh Medium audit `tmp/compiler-static-audit-20260829.final.step40.lua` now emits compact closures at lines 1-3, 7-9, and 11-13, followed by `print("call-statement")` at line 15 and `r_v5_2:m(1)` at line 17. Source/obfuscated/final Luau output is exactly `call-statement`. Main beta-CF tests pass; combined gate remains 36 focused suites + 66/66 canonical samples.
Step 41 root bare-return cleanup checkpoint (2026-08-30): the public beta-CF result now removes only a compiler-proven empty root return. Closure-region solving preserves the root region's `terminalReturnText`; after internal presentation markers are removed, `removeCompilerRootBareReturn` reparses the final public chunk and deletes the last top-level statement only when metadata is exactly `terminalReturnText == "return"`, that statement is an empty `ReturnStatement`, and its AST range is exact. Nested function returns, value returns, branch returns, and any unproven root return remain unchanged. Fresh Medium audit `tmp/compiler-static-audit-20260829.final.step41.lua` now ends at line 17 with `r_v5_2:m(1)` instead of a synthetic line-19 bare `return`. Source/obfuscated/final Luau output is exactly `call-statement`; main beta-CF passes and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 42 global-write RHS scalar transport checkpoint (2026-08-30): `finalizePreCfGlobalWrites` now also removes a compiler-only RHS register temp when the proven global write consumes that temp exactly once. The RHS producer must be a same-state uncaptured local `version-define`/`epoch-start` with one definition/use and a literal-only scalar expression; calls, indexes, tables, closures, captures, extra reads, or ambiguous/nonlocal producers remain unchanged. The literal/scalar expression is substituted directly into the already-proven global assignment at the write point, the dead RHS producer is removed with exact source ownership, and reads/graph indices stay synchronized. Fresh Medium fixture `tmp/global-write-20260830.final.step42.lua` now emits `answer = 1` at line 1 and `answer = 2` at line 5 with no transport locals; source/obfuscated/final Luau output is exactly `g\t1`, `g\t2`. Focused global-write tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 43 indexed-write RHS scalar transport checkpoint (2026-08-30): `finalizePreCfIndexedWriteTemps` now also removes compiler-only RHS register temps from proven indexed writes. The RHS binding must have one definition/use, remain same-state and uncaptured, come from a local `version-define`/`epoch-start` literal-only scalar producer, and feed the exact indexed write; calls, indexes, tables, closures, captures, extra reads, or ambiguous/effectful producers remain unchanged. The pass now handles both key-temp and RHS-temp recovery in separate proof rounds, so a write can first become static-key form and then consume its scalar RHS without generic inlining. Fresh Medium fixture `tmp/indexed-write-20260830.final.step43.lua` now emits `r_v2_1[1] = 10` at line 3 and `r_v2_1.key = 20` at line 5; source/obfuscated/final Luau output is exactly `w\t10\t20`. Focused indexed-write tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 44 effect-call argument lookup recovery checkpoint (2026-08-30): after compiler scratch-call result cleanup converts a discarded source call statement into beta `effect-call`, `finalizePreCfEffectCallArgumentTemps` now runs immediately afterward and restores only a contiguous compiler argument-setup tail made of literal-only scalar temps and static lookup snapshots. Static lookups must remain in the same producer/argument order; every non-recovered argument before the last moved lookup must be a side-effect-free literal or identifier, so moving the lookup evaluations into the call cannot cross an effectful earlier/interleaved argument. Producers require exact one-definition/one-use same-state uncaptured transport, local source ownership, and direct consumption by the same effect-call. Reordered lookups, captures, extra uses, gaps/effectful producers, computed/dynamic lookups, or effectful earlier arguments fail closed. Fresh Medium fixture `tmp/compiler-static-audit2-20260829.final.step44.lua` now emits `r_v2_3("values", r_v4_2, r_v3_2[1], r_v3_2[2], r_v3_2.key)` at line 11 with the prior four argument temps removed; source/obfuscated/final Luau output is exactly `values\ttrue\t1\t2\t3`. Focused call-argument tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 45 effect-call global-base recovery checkpoint (2026-08-30): global lookup recovery now preserves exact compiler provenance on each rewritten `_env[...]` alias via `compilerGlobalLookupRecovered`. After discarded-call cleanup and effect-call argument recovery, `finalizePreCfEffectCallBaseTemps` may remove a now-adjacent call-base alias only when that provenance exists, the alias still has one definition/use in the same state, and the consumer is the exact `effect-call`. This prevents generic rewriting of genuine source aliases such as `local f = print; f()`. Fresh Medium fixture `tmp/compiler-static-audit2-20260829.final.step45.lua` now emits direct `print("values", r_v4_2, r_v3_2[1], r_v3_2[2], r_v3_2.key)` at line 9; source/obfuscated/final Luau output is exactly `values\ttrue\t1\t2\t3`. Focused call-argument/base tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 46 table static-key presentation checkpoint (2026-08-30): `recoverStructuredPostCfStaticMembers` now also normalizes table-constructor fields from bracketed static string keys to identifier-key syntax when the key is a plain valid non-keyword identifier: `{["key"] = value}` -> `{key = value}`. The rewrite is AST/range-based inside existing post-CF raw-node presentation, skips nested function bodies, reparses before accepting, and refuses invalid names such as `"hello-world"`, keywords such as `"end"`, and dynamic/computed keys. Fresh Medium fixture `tmp/compiler-static-audit2-20260829.final.step46.lua` now emits `key = 3` at line 6 while retaining exact semantics; source/obfuscated/final Luau output is exactly `values\ttrue\t1\t2\t3`. Focused static-member tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Step 47 captured/local assignment RHS scalar transport checkpoint (2026-08-30): PRE-CF scalar recovery now accepts proven compiler assignment consumers that write an existing local (`epoch-mutate`) or recovered captured local (`upvalue-write`), in addition to new local definitions. The producer proof is unchanged: one definition/use, same-state adjacency, uncaptured scratch binding, exact source ownership, and a safe scalar expression whose root is not an Identifier. This matches the local compiler `AssignmentStatement` path at `compiler.lua:1386-1440`, which first compiles each RHS into an expression register and then writes that register into the real variable/upvalue destination. Identifier-root producers remain a hard barrier, so genuine source value copies such as `local b=2; a=b` are not collapsed into `a=2`. Fresh Medium fixture `tmp/scope-mutation-20260830-015811.final.step47.lua` now emits direct `r_v1_1 = 2` at line 5 and captured-closure `r_v1_1 = 3` at line 14 with the compiler scalar temps removed; source/obfuscated/final Luau output is exactly `1,2,2,2,3`. Focused scalar tests pass and combined gate remains 36 focused suites + 66/66 canonical samples.
Generic-for direct iterator ownership / nested RETURN_ALL recovery checkpoint (2026-08-30): canonical beta-CF now accepts the local compiler shape where earlier proven cleanup has removed the explicit first loop-variable copy and register-clear scaffolding, leaving the iterator step outputs themselves as the surviving loop bindings. This direct-binding path is allowed only when the bindings are uncaptured and no body write reuses the protected iterator-control physicals; ambiguous mutation still refuses and falls back conservatively. `recoverGenericForPackedIterator` also recognizes the exact nested compiler RETURN_ALL chain `{ producer(...) } -> factory(unpack(pack)) -> { iterator,invariant,control }`, preserves final-argument multi-return semantics, restores exact explicit-self method snapshots to native namecalls, and substitutes only compiler-proven `_env` aliases (never genuine source aliases). Fresh local Medium fixture `tmp/genericfor-game-20260830.final.fixed.lua` now emits `for r_v7_1, r_v5_3 in pairs(game:GetChildren()) do print(r_v7_1, r_v5_3) end` with no iterator packs/aliases/while scaffold or synthetic root return. Stubbed Luau runtime parity is exact for source/obfuscated/final (`1 A`, `2 B`). Focused generic-for positive/refusal tests PASS; combined gate remains 36 focused suites + 66/66 canonical samples. Acyclic CF now preserves the unique compiler terminal-return text so existing root bare-return cleanup can remove the proven synthetic root return after loop structuring.
Control-flow post-PRE-CF shape contract checkpoint (2026-08-30): numeric/generic/condition recovery no longer requires compiler syntax already consumed by proven beta/PRE-CF cleanup. Numeric-for accepts both surviving visible-loop copies whose epoch-kill was removed by `finalizeBetaDeadRegisterClears` and the fully direct binding form where copy+cleanup are gone; direct hidden-induction binding is allowed only when uncaptured and not written by the loop body. Generic-for likewise accepts ordinary first/second loop bindings after dead cleanup while preserving captured/upvalue refusal rules. Lightweight numeric/generic core classifiers reserve proven compiler loop machinery from generic-while fallback when strict recovery refuses, so unsafe near-matches fail closed instead of silently degrading to `while`. Structured condition cleanup now folds one-use literal/unary-literal leaves into proven `if`, `while`, `repeat`, `break`, and `continue` conditions; the same exact proof is rerun after dead-scalar/copy cleanup because those deletions can expose safe adjacency late. Added `tools/test-beta-cf-post-pre-cf-shapes.js` as an explicit PRE-CF->CF contract suite. Fresh local Medium `tmp/numericfor-both-20260830.final.fixed2.lua` now emits native `for ... = 1, 10 do` and `for ... = 10, 1, -1 do`; source/obfuscated/final Luau output is identical (1..10 then 10..1). Fresh mixed control-flow `tmp/cf-shapes-plan-plain-20260830.final.fixed2.lua` emits direct `if x == 0`, native `while x < 3`, direct `continue`/`break` tests, and `repeat ... until x <= 0`; source/obfuscated/final Luau output matches exactly. Canonical sample 25 now recovers numeric-for with nested if/else after dead-clear cleanup; sample 57 recovers generic-for with nested if/else + break. Combined gate passes 37 focused suites + 66/66 canonical samples.
## RETURN_ALL / literal return recovery checkpoint (2026-08-30)

- `finalizePreCfReturnAllTemps` now accepts compiler RETURN_ALL packs consumed by proven `effect-call` operations, not only assignment/return consumers. This recovers shapes such as `local t = { pcall(w) }; atf(unpack(t)) -> atf(pcall(w))`.
- RETURN_ALL transport no longer requires strict adjacency. Non-adjacent same-state transport is allowed only across literal-only scalar compiler definitions with no pack/input dependency; calls/indexes/effectful gaps, captures, extra pack reads, non-final unpack positions, and ambiguous ownership still refuse.
- New `finalizePreCfLiteralReturnTemps` folds any number of uniquely-owned literal scalar temps into terminal return payload slots. Large compiler output like thirty `local r = <literal>` definitions followed by one return now becomes a direct `return 1, 2, ...`; effectful/nonliteral or multiply-used slots remain.
- Added bounded post-RETURN_ALL convergence using the existing proven call-argument/base and effect-call argument/base passes. It does not weaken global-alias provenance; aliases that still lack the existing proof remain.
- Fresh vararg/pcall fixture: later `pcall`/`xpcall` pack+unpack forwarding is removed and both large constant-return closures collapse to direct return lists. The first IIFE pack remains because its producer/consumer cross closure-allocation/ownership structure rather than the proven same-state transport handled here.
- Refusal coverage includes effectful gaps, captured packs, extra reads, non-final unpack use, and effectful return slots.
- Verification: `test-pre-cf-return-all-temps.js`, new `test-pre-cf-return-literal-temps.js`, canonical PRE-CF integration all PASS. Combined gate PASS: 38 focused suites, 66/66 canonical samples.

