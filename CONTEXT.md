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

Generated `output/` content is disposable and ignored as a whole. Do not commit regenerated output/test artifacts.

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

## Standalone Beta Optimizer (Experimental)

A new optimizer is intentionally isolated from normal/CF. Nothing in `main.js`, `deobf.bat`, or the canonical CF path imports it.

Files:

```text
passes/beta-optimizer.js
tools/beta-optimizer.js
tools/test-beta-optimizer.js
```

Manual usage:

```text
node tools/beta-optimizer.js <final-cf.lua> [optimized.lua]
```

Current v1 behavior is conservative and iterative:
- before any folding, removes only direct `x = nil` lifetime-cleanup writes in a function root block when `x` has a prior local declaration in that same function root, the nil value is never read later, the binding is not captured, and no goto/label exists in that function; parser-local upvalue writes therefore fail closed. This pre-cleanup phase is never rerun after folding, so source-style `local temp = nil; local real = temp` can still fold normally without being mistaken for pre-fold cleanup
- removes dead single locals only when the initializer is proven effect-free, and removes unused uninitialized single-local declarations
- folds an adjacent compiler copy chain `local temp = thing; local real = temp` to `local real = thing` by renaming the producer binding at its original evaluation point and deleting the transfer local; arbitrary calls/tables/closures are allowed because timing and identity stay unchanged, but any extra temp read/write/capture/redeclaration fails closed
- folds a plain deferred local initialization `local x; ...; x = value` to `...; local x = value` only in the same block when no read/write/capture/redeclaration of `x` occurs before that first assignment, the assignment target is parser-confirmed as the same lexical local, the RHS does not reference `x`, and no goto/label scope-transfer boundary is crossed
- preserves an unused call's effect by changing `local x = f()` into `f()` instead of deleting the call
- inlines single-use literals
- inlines single-use local aliases only when the source local is not changed before the use; scoped parsing distinguishes globals from lexically local/captured outer bindings inside nested functions
- folds adjacent one-use scalar compiler temporaries (identifier/literal unary/binary/logical trees) only into a proven leading evaluation position of the immediately following statement; loop snapshot boundaries still block movement, and a temp is never moved into the conditional right arm of `and`/`or`
- proves the generated `local _env = getfenv()` header before folding static `_env["name"]` lookups to direct globals; a proven `_env` binding now propagates down the actual nested-function parent chain so captured static lookups inside closures fold too. Each nested function independently fails closed on `_env` writes/redeclarations/shadowing or `setfenv`, while deeper read-only captures remain eligible
- moves a direct global alias only across effect-free sibling statements and only into call-base position
- collapses proven compiler multi-return table storage `local t = { call(...) }; local a = t[1]; local b = t[2]` back to one native multi-return assignment at the original call position
- sparse used result slots are preserved with collision-free `__beta_unused_return_N` locals, so using only slot 2 becomes `local __beta_unused_return_1, b = call()` without relying on `_`
- if Prometheus extracted a result into a beta local that later proves unused, that target is renamed to a collision-free throwaway placeholder instead of keeping a meaningless register name
- multi-return collapse fails closed if the temporary table escapes, is written, is length-observed, uses dynamic/duplicate slots, is captured, or moving an extraction declaration earlier would change shadowing/capture behavior
- collapses a proven adjacent generic-for iterator tuple `local f, s, c = exprs; for k, v in f, s, c do` to `for k, v in exprs do` only when all three tuple locals are used exactly once by that loop header, in the same order, with no writes/captures/later uses
- the generic-for tuple rule is call-agnostic and handles factory calls plus explicit triples such as `next, t, nil`; direct global iterator aliases such as `local iterator = next` are inlined only when immediately followed by the generic-for using that alias
- generic-for tuple/alias inlining refuses reordered/subset tuple variables, body/later uses, captures, intervening statements, and unsupported declaration arities/RHS shapes instead of moving evaluation
- one-use alias inlining treats `while`, `repeat`, numeric-for, and generic-for statements as repeated-evaluation boundaries; a local/global snapshot declared outside a loop is not rewritten into a fresh read on every iteration, while literal values remain safe
- nested `if`/`elseif` clause bodies are traversed as real statement blocks so ordinary dead-local/literal/alias cleanup applies inside short-circuit scaffolding too
- exact compiler short-circuit value ladders are recursively rebuilt as native `and`/`or` expressions in `while` headers and `repeat ... until` conditions; the recursive matcher handles chained groups and preserves call order / short-circuit effects
- a discarded pre-repeat condition evaluation is removed only when its left/right expression tree exactly matches the already-recovered logical `until` condition; mismatches fail closed. This fixes the observed extra condition call before the first repeat body without broad dead-effect deletion
- optimizer ordering is structural recovery / compiler-pattern collapse first, then safe inlining; unused/dead local cleanup is a separate final phase only after earlier transforms reach a fixed point
- final dead-local cleanup scans nested/later blocks and statements bottom-to-top; it never runs early enough to destroy a compiler structure another recovery pass still needs
- `repeat ... until` body locals treat the `until` expression as a real trailing use in dead-liveness analysis. This prevents deletion of locals such as `local done = ...; until done`, whose only read is the repeat condition outside the body-array representation
- one-use locals declared outside a `while`, `repeat`, numeric-for, or generic-for are treated as one-time snapshots and are not generically inlined into repeated loop evaluation, even for literals; dedicated proven loop/compiler patterns are handled separately
- natural source conditions already written as `while A and (B or C)` / `repeat ... until A or (B and C)` are left alone; short-circuit collapse only targets the proven compiler temp/assignment ladder shapes
- removes a final bare `return` during the final cleanup phase
- reparses after each edit and reparses the final source

It deliberately does not inline arbitrary calls, table/index lookups, closure creation, or other expressions merely because they have one use. This avoids changing evaluation order, call timing, metamethod effects, table/closure identity, or mutable reads.

First controlled probe, with EncryptStrings and AntiTamper disabled during obfuscation:

```lua
print("hi")
```

Current CF is one state / zero closures. Standalone beta optimizer reduces the live code to `print("hi")`; generated `--headers` / `--body` comments and blank formatting may remain. Stats for that probe: 9 rounds, 1 global fold, 1 global-alias inline, 2 other single-use inlines, 3 dead locals, 1 dead call-result lowering, 1 bare return removed.

Safety regressions cover call-order preservation, dead call-result preservation, literal movement, mutable local aliases, repeated-evaluation loop snapshots, effect barriers for global aliases, `setfenv` blocking, nested clause-block cleanup, dead table removal, full/sparse/out-of-order multi-return slots, only-second/only-third results, method calls, placeholder-name collisions, shadow/capture barriers, table escape, dynamic indexes, duplicate slots, table writes, `#table` observation, generic-for tuple calls, `next, state, nil`, omitted control nil, method/custom factories, direct-global iterator aliases, later/body/captured tuple uses, reordered tuple values, effect gaps, unsupported tuple arities, short and long `and`/`or` ladders, `while`/`repeat` condition recovery, exact repeat precheck removal, and mismatch refusal. LuaJIT parity probes include only-second, sparse 1+3, side-effectful call ordering, five real iterator cases, side-effectful while/repeat conditions, and a 33-state deep mixed-condition loop probe; checked before/after output is identical. Real local-Prometheus iterator probes with EncryptStrings/AntiTamper disabled verify `pairs`, `ipairs`, `next`, a direct custom iterator triple, and a custom iterator factory. Real loop probes verify `while A() and (B() or C())`, side-effectful repeat, and long chained conditions; the side-effectful repeat previously exposed an extra pre-body condition call, now removed only by exact structural duplicate proof. Packed `pairs`/`ipairs`/factory triples collapse and inline into the generic-for header; `next` folds to direct `for ... in next, state, nil`. The direct custom triple remains conservative where post-loop compiler cleanup would make alias deletion require stronger lifetime proof.
## Rust Beta Optimizer Port (Experimental)

Standalone Rust optimizer lives at `rust-optimizer/`; it is not wired into `main.js`, `deobf.bat`, or canonical beta-CF. The JS optimizer remains the semantic oracle on small/normal samples only.

Rust files:

```text
rust-optimizer/.gitignore
rust-optimizer/Cargo.toml
rust-optimizer/Cargo.lock
rust-optimizer/src/lib.rs
rust-optimizer/src/main.rs
rust-optimizer/tests/optimizer.rs
```

Manual usage:

```text
rust-optimizer\target\release\prom-rust-optimizer.exe <final-cf.lua> [optimized.lua] --max-rounds 1000
```

The port uses `eclipse_luau` and byte-range AST edits. The attempted `full_moon` migration was reverted before commit; `eclipse_luau` remains authoritative. It runs to a parse-validated fixed point and ports the JS structural/fail-closed optimizer behavior rather than using textual substitutions. Dedicated Rust regressions are **192/192 PASS**.

Important safety/parity rules:
- nested functions distinguish stable captured lexical bindings from globals; read-only captures are allowed only where the JS proof allows them, while nested writers block movement
- parenthesized binary `if` conditions use the narrow adjacent call-result proof; direct booleans and logical right arms remain barriers
- immediate generic-for header aliases may fold anywhere inside the iterator header, including a source argument whose spelling is shadowed by a loop variable; the read still occurs before loop variables enter scope, and later/body uses remain blockers
- direct calls nested under an adjacent `if` condition may consume a sole-use callee alias and a sole-use argument snapshot when prior arguments are stable/effect-free; this recovers shapes such as `table.find(items, profile.field)` while effectful earlier arguments remain barriers
- relaxed static-field policy: an adjacent sole-use dot-field snapshot may move into a stable `obj:Method(...)` argument when all earlier arguments are stable/effect-free; computed-index snapshots remain conservative. Direct pass-self `obj.Method(obj, ...)` recovers to `obj:Method(...)` for a noncaptured direct-name base, and an adjacent call snapshot may replace the base of a dot-field assignment target. Together these now collapse the verified fresh beta-CF `getgenv()` / `T_Macro` / `macro_record` compiler shape to `getgenv().MacroRecordToggle = T_Macro:AddToggle(..., r_v40_42.macro_record, ...)`.
- deferred locals may cross unrelated loops only when the local is not observed there
- repeat-body liveness includes the `until` expression and repeat bodies are always backedge contexts, so ancestor lifetime-release writes are not deleted unsafely
- `_env` recovery requires proven getfenv provenance and respects rebind/shadow/setfenv barriers, including parenthesized string keys
- value short-circuit recovery handles branch-local simple aliases, including the Prometheus `table and table["unpack"] or unpack` shape, while preserving evaluation order
- packed final-argument forwarding accepts proven stable outer lexical locals/read-only captures but still blocks nested writers and effectful earlier prefixes
- self-key overwrite recovery folds local base = source; local key = scalar; key = base[key] to local key = source[scalar] only when the base snapshot has no other observable use; live-base cases remain unchanged
- nested effectful index-key producers may fold into a following stable lexical index base, and index temps may fold into a computed key inside a call argument only when both the outer callee and the index base are proven stable lexical bindings with no nested writer
- small-function size accounting ignores comment-only lines, matching the JS oracle so compiler `--headers` / `--body` comments do not block otherwise-safe sole-use closure inlining
- single-use movable constants include atomic literals plus only proven literal-derived unary forms: numeric unary `-`, `not` over another safe constant, `#` over a string literal, and parenthesized forms. Non-atomic replacements are parenthesized to preserve precedence. Mutable/metamethod-sensitive forms such as `-x` and `#table` are not treated as movable constants

Final small/normal parity gates:
- fresh samples 14/20/23 and sample 63: Rust second pass = 0 edits and JS-after-Rust = 0 transforms
- samples 14/20/23 LuaJIT runtime stdout/exit parity passes (14 against raw CF; 20/23 against readable source because raw 20 exceeds LuaJIT's 200-local limit)
- current measured Rust timings on the final gate: sample 14 ~0 ms, 20 ~6 ms, 23 ~4 ms, 63 ~118 ms; Rust pass 2 is 0 edits for all four, and JS-after-Rust finds 0 transforms for 14/20/23/63

JS optimizer test policy from the user: do **not** run JS optimizer on `spacial6`. Sample 63 is allowed. For any other file, if a JS optimizer run exceeds 60 seconds, stop it and do not use that file with the JS optimizer again. Rust has no equivalent restriction.

Fresh `spacial6` beta-CF remains 3799 states / 554 closures. The post-`ad877ce` Rust performance work reuses immutable usage indexes, removes per-statement lexical-set cloning, indexes direct declarations/statement lookup, precomputes nested-writer name sets instead of rescanning function trees per variable, and applies edits with one output build. With the current safe-unary-constant extension, final `opti/spacial6.lua` is produced in **36 rounds / 37 parses**, **101,837 raw edits**, measured at **8,964 ms** on the final gate. Final size is **2,805,753 bytes**. Rust pass 2 takes about **171 ms**, performs 0 edits, and is byte-for-byte identical; SHA-256 is `CA9A90C7E8B5168E2BF89E578446945500C5DEA127AE40455BDDA4AFF112E15F`. The final file passes the project Luau structural parser and has zero checked `RegisterOverflow[...]`, `createClosure`, `upvalueValues[...]`, `allocUpvalue(...)`, `ReturnVal =`, or `while state do` scaffold patterns. The reported `firesignal` chain still emits directly as `firesignal(r_v2_330[r_v2_3[r_v3_5(...)]])`.
## Current Immediate Beta Optimizer Checkpoint

The JavaScript optimizer section below remains the semantic baseline/oracle for the active standalone optimizer work. Both JS and Rust optimizers remain experimental and standalone; do not connect either to `main.js`, canonical CF, or `deobf.bat` unless the user explicitly asks later.

Latest relevant commits:

```text
729b0ac Run beta dead cleanup last
d1d1da7 Recover logical loop conditions in beta optimizer
eece1a9 Inline generic-for iterator tuples in beta optimizer
db2a17d Collapse packed multi-return calls in beta optimizer
39d3d2f Add standalone beta optimizer
```

Current optimizer path:

```text
final beta-CF source
-> structural compiler-pattern recovery
   - packed call multi-return table collapse
   - generic-for iterator tuple recovery
   - exact while/repeat short-circuit ladder recovery
   - exact discarded repeat-precheck removal
-> safe single-use/global/alias inlining
-> structural transforms reach fixed point
-> dead/unused cleanup runs last, bottom-to-top
-> final reparse
```

Important current behavior / proofs:

- Basic cleanup: removes proven dead locals including unused uninitialized declarations, preserves effects of unused calls, folds proven `_env["name"]` lookups to globals, safely inlines literals/aliases, and removes a final bare `return`.
- Nested function bodies now use lexical `isLocal` provenance. Any nested-closure reference to an outer local, including write-only assignment, is treated conservatively as a capture/upvalue and blocks generic inline/fold/dead removal of that local. Adjacent scalar temp chains such as `local t = x + 1; x = t` and `local t = x < 3; return t` fold only when the use is the immediate leading evaluation position. Right-side `and/or` uses and repeated-evaluation loop boundaries fail closed.
- Generic single-use inlining is same-lexical-block only. A use inside an `if`/`do`/loop child body is not eligible for generic parent-block inlining; dedicated structural/CFG recovery passes may still cross blocks when they prove an exact compiler pattern.
- Adjacent compiler key temps of the exact form `local k = call(...); local v = cache[k]` can fold to `local v = cache[call(...)]` when `k` has one adjacent same-block use, `cache` is a lexical local, and no nested closure in that function can write/rebind the cache binding. This preserves call count and lookup timing while refusing unstable-base cases.
- Adjacent lookup-result temps used only as the key of the next indexed assignment also fold structurally: `local k = source[decode(...)]; target[k] = value` -> `target[source[decode(...)]] = value`. The destination base must be a lexical local and no nested closure in the current function may write/rebind it, because the inlined form reads that destination local before evaluating the key expression. Global/member/complex destination bases, captures, writes, redeclarations, or non-adjacent uses fail closed.
- Non-adjacent assignment-key lookup temps have a separate dependency-safe proof. It only moves a lookup from a uniquely declared direct local table constructor when that table remains private/plain through the consumer: any alias, function argument, closure capture, return/store, rebind, metatable exposure, or direct table mutation in the gap blocks movement. The lookup index must be a literal or a stable lexical-local snapshot with no intervening writes/captured writer. Because the proven lookup itself is then side-effect free, unrelated calls/state may be crossed safely. Lookup indexes containing calls remain fail-closed. The table-safety information is indexed once per parsed function so the pass does not rescan the whole function per candidate.
- Adjacent single-use temps used only as the computed key of the immediately following one-field table constructor can inline directly into that `TableKey` when the field value is a literal. This permits stateful/indexed producers because no real statement is crossed; the literal-value and one-field restriction keeps constructor field evaluation-order proof trivial. Extra temp uses/writes/captures/redeclarations, effectful field values, multiple fields, or any intervening statement refuse the fold.
- Prometheus compiler packed self-assignment forwarding is recovered structurally: `local t = { inner() }; t = outer(unpack(t))` -> `local t = outer(inner())`. This is source-pattern recovery based on the local WeAreDevs compiler lowering for final call arguments compiled with `RETURN_ALL`, not a generic Lua table/unpack equivalence. The match requires immediate adjacency, the same lexical target local, exact global `unpack(t)` as the sole outer argument, a lexical outer call target distinct from `t`, and no captured writer for that outer target. No function/register names are hardcoded.
- Packed `RETURN_ALL` forwarding also handles nested packed consumers and a final `unpack(t)` argument after stable literal/local prefix arguments: `local a={inner()}; local b={middle(unpack(a))}; sink(x,y,unpack(b))` recovers through fixed point to `sink(x,y,middle(inner()))`. The outer call base and all earlier local arguments must have no nested captured writer; effectful/complex prefix arguments remain a barrier. This is the same local-WeAreDevs compiler source-recovery rule, not generic Lua pack/unpack equivalence.
- Adjacent producer temps may move into a following direct-local call argument or into the leading scalar-evaluation path inside one argument (for example `local v=f(); sink(v == nil)`). The outer call base must be a stable lexical local; every earlier argument must be a literal/stable lexical snapshot; conditional right arms of `and`/`or`, captured writers, and effectful prefixes are barriers. Calls are parenthesized on substitution to preserve single-result adjustment. This recovers Prometheus call-base snapshots without weakening generic global-alias movement.
- Adjacent Prometheus `if` comparison temps also recover when a one-use call result is the leading binary operand of the immediately following `if`. After that fold, an immediately preceding one-use indexed callee snapshot such as `local f = math["random"]` may move into that leading call-base position, preserving lookup -> args -> call order. Direct boolean conditions and `and`/`or` right arms remain barriers.
- Adjacent plain table-constructor call arguments now recover structurally when **two or more** consecutive one-use same-block table temps immediately feed the same next call in increasing argument order. Constructors are restricted to literals, stable uncaptured lexical locals, and nested plain constructors; calls, indexing, global reads, captures, writes, redeclarations, or non-plain fields fail closed. This recovers shapes like `local a = {}; local b = { [k] = v }; out = f(a, b)` to direct constructor arguments without enabling broad single-table inlining.
- Adjacent single-use producer locals used as the sole RHS of the next single-target assignment fold directly into that assignment. Luau/Lua evaluates the RHS before resolving an indexed LHS; an adversarial Luau probe where the RHS rebinds both destination table and key matched before/after, so compiler `local c = char(...); out[k] = c` can recover to `out[k] = char(...)`.
- A repeat-body temp declared as the final real statement and used only as the direct `until temp` condition is recovered to `until <initializer>` at the same evaluation point. Repeat-body direct `x = nil` lifetime writes are also eligible for pre-fold cleanup when `x` is declared in that repeat body, is not captured, and is not referenced by the `until` condition.
- Adjacent index-base aliases also fold only with exact one-use same-block proof: `local t = math; local f = t["random"]` -> `local f = math["random"]`. This applies equally to source globals such as `table` and lexical identifier sources, but never crosses a statement/block boundary or a capture/write/redeclaration of the temporary.
- Bare `return` cleanup is restricted to the actual function root block. A bare return ending an `if`/loop/other nested block is semantic control flow and must remain. Numeric sample 14 exposed and now covers this regression.
- Multi-return recovery is call-agnostic. Compiler storage like `local t = { call() }; local a=t[1]; local b=t[2]` becomes native `local a,b = call()` only with structural proof.
- Exact adjacent packed-call forwarding is also recovered when Prometheus emits `local t = { call() }; local dead = sink(unpack(t))`: with one pack use, one `unpack` argument, one outer call argument, a lexical local call target, no target capture, and no pack escape/write/redeclare, the optimizer removes the pack/unpack layer and restores `sink(call())`. Local/shadowed `unpack`, extra outer arguments, target capture, and pack escape fail closed.
- Generated beta-CF vararg storage is now recovered structurally. The pass identifies the compiler-injected `{ ... }` capture by its position in the generated header section rather than by variable name, forwards repeated packed tails such as `{ select(N, unpack(args)) }` through every proven expanding `unpack(temp)` use, rewrites static `args[n]` reads to `(select(n, ...))`, rewrites exact global `unpack(args)` to `...`, and removes the generated capture when all reads are recoverable. Dynamic indexes, mutation, aliases/escape, redeclaration, and nested-closure capture fail closed; body/user `{ ... }` copies are not treated as headers.
- A packed return wrapper around an immediately-invoked anonymous function can also collapse when that IIFE is proven to return zero values only: `local t = { IIFE() }; return unpack(t)` -> `return IIFE()`. The proof walks the IIFE body while ignoring nested functions and refuses any `return` carrying one or more expressions; bare `return` and fallthrough are zero-value exits. `return nil`, `return 1`, `return f()`, pack escape/write/capture/redeclare, local/shadowed `unpack`, or non-IIFE calls fail closed.
- Verified Prometheus returned-call lowering is recovered separately from the generic zero-value rule: an adjacent lexical-callee pack `local t = { f(...) }; return unpack(t)` becomes `return f(...)` because the local WeAreDevs compiler lowers a final returned call through `RETURN_ALL` exactly this way. Local/shadowed `unpack`, pack escape/write/capture/redeclare, non-adjacent consumers, or non-lexical call bases refuse. An immediately preceding call-created callee may then collapse as `local f = maker(); return f(...)` -> `return (maker())(...)`; call-base single-value adjustment matches the local assignment.
- Small anonymous function locals are inlined when they have exactly one same-block use and the function is at most 100 effective source lines. Effective-line counting masks parser-recognized comments and ignores blank lines, so generated `--headers` / `--body` scaffolding does not make a tiny function look large. Adjacent use remains the broad safe case. Non-adjacent same-block use is allowed only when every runtime identifier in the moved closure is lexical/local (no global/environment-backed binding) and no intervening direct same-block local declaration can shadow a referenced name; this preserves captured-cell identity while allowing compiler setup/assignments between declaration and sole use. Repeated-evaluation loop statements, capture/write/redeclare ambiguity, live local shadowing, global/environment-backed references for non-adjacent moves, and functions over 100 effective lines fail closed. The same dedicated rule is allowed at the tail of dead cleanup after compiler junk between declaration/use has disappeared; general transforms are still not rerun after dead cleanup.
- Sparse result use is supported. If only result 2 or 3 is needed, collision-free `__beta_unused_return_N` locals consume earlier return positions instead of using `_` or changing semantics.
- Packed-result recovery refuses table escape, writes, `#table`, dynamic/duplicate slot reads, capture/shadow changes, or other unproven shapes.
- Generic-for iterator recovery is also call-agnostic. Proven adjacent iterator tuples become direct source-like loops, e.g. `local f,s,c = pairs(t); for k,v in f,s,c do` -> `for k,v in pairs(t) do`.
- Numeric-for header constants are recovered separately from the generic loop-snapshot rule because numeric-for start/end/step expressions execute once before loop iteration. A one-use same-block numeric literal local used only in `ForNumericStatement.start/end/step` is inlined into the header; if the proven step value is exactly numeric `1`, the explicit step is removed entirely (`for i = start, finish, 1 do` -> `for i = start, finish do`). Extra reads/writes/captures/redeclarations refuse the fold.
- Verified real iterator shapes include `pairs`, `ipairs`, `next, state, nil`, custom direct iterator triples, and custom iterator factories. `pairs`/`ipairs`/factory triples inline into the loop header; `next` folds to direct `for ... in next, state, nil`. The direct custom triple remains conservative if stronger lifetime proof would be needed to remove aliases/cleanup.
- One-use locals declared outside `while`, `repeat`, numeric-for, or generic-for are treated as one-time snapshots. They are not generically moved into repeated loop evaluation, including literal snapshots. This prevents one AST use from becoming many runtime reads/evaluations.
- Nested `if`/`elseif` clause bodies are traversed as real blocks for cleanup.
- Exact Prometheus short-circuit temp/assignment ladders are recursively rebuilt as native `and` / `or` expressions for `while` and `repeat ... until`. Natural source conditions already written with `and/or` are not rewritten by this pattern recovery.
- Exact short-circuit value ladders are also recovered outside loop conditions. The structural shape `local result = seed; if seed then result = rhs end` becomes `local result = seed and rhs`, and `if not seed` becomes `or`. If `seed` was produced by the immediately preceding local and is used only by the result copy and branch condition, that producer is folded at its original evaluation point too. Global seeds, result self-reference, captures/writes/redeclarations, and unproven branch bodies fail closed.
- Side-effect order is preserved. The loop-condition matcher only accepts the exact proven ladder structure; calls remain in the same left-to-right short-circuit order.
- Prometheus can emit a discarded evaluation of a repeat condition before the first body iteration. That precheck is removed only when its expression tree exactly matches the recovered `until` condition. Mismatch refuses optimization.
- Optimizer ordering matters: structural recovery and safe inlining finish first; dead cleanup runs only afterward and never returns to structural transforms. This prevents dead-storage deletion from destroying compiler patterns needed for recovery.
- Performance batching: the standalone optimizer no longer reparses the whole Lua file after every independent safe transform. It batches source-disjoint same-AST local inlines (still same-lexical-block only per individual inline), proven `_env[...]` folds, pre-fold direct-nil cleanup writes, adjacent copy/index-base/index-key/assignment-key/call-argument/assignment-value patterns, independent deferred-local initializations, and source-disjoint dead cleanup. CFG/loop/multi-return transforms remain one-at-a-time. `stats.rounds` counts logical transforms only; `stats.parseRounds` reports expensive full scoped reparses. The safety budget is now `maxParseRounds` (with legacy `maxRounds` accepted as an alias), so batching no longer causes large files to stop merely because 1000 logical edits were applied. `stats.parseLimitHit` explicitly reports an incomplete run.
- Pre-fold direct `x = nil` cleanup is treated as Prometheus dead-register/lifetime-release elimination. Function-root and repeat-body cases keep their existing exact-block/iteration-aware proofs. Nested `if`/`do` child blocks outside loop backedges may also drop a release of an ancestor local when that beta name has exactly one prior declaration in the function, is not captured, and has no later read/write activity anywhere in the function. Nested blocks under while/repeat/numeric-for/generic-for backedges remain conservative unless covered by the dedicated repeat proof.

Controlled examples already verified:

```lua
print("hi")
```

reduces from final CF scaffolding to live `print("hi")`.

```lua
local a, b = pcall(function()
    return 1 / "hejsks"
end)
print(a, b)
```

has its compiler `{ pcall(...) }` result table recovered to native multi-return assignment. Only-second / only-third result variants are also covered.

```lua
for i, v in pairs(t) do
    print(i, v)
end
```

is recovered through real Prometheus obfuscation -> CF -> optimizer to direct `for ... in pairs(t) do` form.

Real loop probes cover nested/mixed short-circuit forms such as:

```lua
while A() and (B() or C()) do
    ...
end

repeat
    ...
until A() or (B() and C())
```

including side-effectful condition functions and a deeper mixed-condition probe. Before/after runtime output matched in the checked executable probes.

Current verification state for the standalone optimizer work:

```text
focused project suites: 14/14 PASS
real iterator runtime probes: pairs/ipairs/next/custom-direct/custom-factory = equal
multi-return runtime probes: equal for successful cases
direct forwarding/runtime probe: local WeAreDevs Medium obfuscation of `print(pcall(function() return 1,2,3 end))` -> normal -> beta-CF -> optimizer now recovers the packed forwarder and then inlines the tiny sole-use closure, emitting `print(pcall(function(...) ... return 1, 2, 3 end))`; source/obfuscated/CF/optimized LuaJIT output is `true 1 2 3`, forwarder count is 1, small-function inline count is 1, and a second optimizer pass applies 0 transforms
loop/repeat side-effect parity probes: equal
nested-function/repeat/scalar-temp LuaJIT parity: equal, including arithmetic metamethod timing and right-side and/or refusal
current loop-effects/loop-repeat/loop-while optimized probes: fixed point on second optimizer call
numeric 1-63 fresh-CF sweep after capture/bare-return fixes: CF generation 63/63; optimizer emitted parseable output for 63/63. For 1-62, 46 LuaJIT cases matched CF exactly, 21/22 differed only by pointer addresses, sample 10 optimized output matched readable source while raw CF exceeded LuaJIT local limits, and no confirmed optimizer-caused runtime regression remained. Thirteen cases are runtime-unvalidated because CF/source require Luau/Roblox/anti-tamper support or exceed LuaJIT local limits. Sample 63 also exceeds LuaJIT runtime local limits, but its previously partial `63.optall3.lua` now reaches optimizer fixed point under default parse-budget control.
write-only captured-upvalue regression from numeric sample 20/23 is fixed: nested `x = ...` now counts as capture, preventing unsafe outer-local inline/dead cleanup
same-block generic inline regression: parent locals are no longer inlined into child `if`/`do`/loop bodies; focused tests cover the boundary
numeric sample `61.optall3.lua`: 123 adjacent decoder-key temps fold in one pass; the exact `r_v22_19 = r_v3_5(...); r_v16_24 = r_v2_3[r_v22_19]` pair becomes `local r_v16_24 = r_v2_3[r_v3_5(...)]`, and a second optimizer pass is fixed-point
sample 61 follow-up alias pass: 11 adjacent index-base aliases fold, including `local r_v4_3 = math; local r_v1_5 = r_v4_3["random"]` -> `local r_v1_5 = math["random"]` and the equivalent `table["concat"]`; the next pass is fixed-point
sample 63 continuation: historical `63.optall2.lua` / `63.optall3.lua` were partial outputs because the old 1000-logical-transform cap stopped before fixed point. After switching the safety budget to full scoped parses, normal/default optimization of the exact `63.optall3.lua` completed 1411 logical transforms in 65 full parses and reached a real fixed point; a second optimizer call applied 0 transforms. The stale key/env/call chain (`"l2"`/`"l1"` temp keys, `_env[...]`, and `r_v10_15 -> r_v4_22`) collapses to direct globals/call. The remaining two swap snapshots are intentionally preserved because naively inlining them would change global read/write ordering and can differ under environment metamethods.
performance benchmark after batching: exact same `63.optall3.lua` 100-transform slice measured 69482 ms before batching vs 1101 ms after, with only 3 full scoped parses after batching (~63x wall-clock improvement on this slice). Fresh `63.beta.cf.lua` first 1000 transforms now measured 29878 ms / 96 full parses and preserved the same 1000 transform counts/output size used by the pre-batch benchmark. Sample 61 batched output is byte-identical to the prior fixed-point `61.alias.lua`.
performance/fixed-point safety gates: focused optimizer tests pass; full project suites 14/14 PASS; numeric 14/20/23 CF->optimized LuaJIT parity PASS; sample 61 fixed-point output byte-identical to pre-performance output; exact `63.optall3.lua` default run reaches fixed point in 65 parses / 1411 transforms and second pass is 0 transforms.
sample 63 terminal nested nil cleanup: the reported `r_v17_34`, `r_v11_29`, `r_v25_32`, `r_v5_11`, and `r_v27_31` direct nil writes were in a terminal `if` clause, so the old function-root-only Phase 0 skipped them. The terminal-block proof now removes those five plus four other proven dead direct-nil lifetime writes (9 total). `63.optall3.nilfixed.lua` reaches fixed point in 1420 transforms / 66 full parses; second pass applies 0 transforms.
sample 63 value-ladder cleanup: the reported `table -> r_v13_1 -> r_v14_1`, conditional `table["unpack"]`, then fallback `unpack` ladder is now structurally recovered to `local r_v14_2 = ((table) and (table["unpack"])) or (unpack)`. Running on `63.optall3.nilfixed.lua` collapsed 12 value short-circuit ladders plus the resulting safe aliases in 18 transforms / 19 parses, and a second optimizer run applies 0 transforms. A custom LuaJIT environment with side-effectful global lookup proved truthy-path behavior still performs two `table` reads and false-path behavior performs one read before falling back to `unpack`.
sample 63 small-function follow-up: running the new <=100-effective-line sole-use closure rule on `63.optall3.valuefixed.lua` applies 22 small-function inlines (26 total transforms, including 3 newly exposed packed forwarders) in 12 full parses, reaches fixed point, and a second pass applies 0 transforms.
sample 63 adjacent assignment-key follow-up: running on `63.optall3.smallfn.lua` removes 52 exact one-use lookup-result key temporaries. The reported `local r_v22_48 = r_v4_3[r_v5_5(...)] ; r_v28_24[r_v22_48] = true` becomes `r_v28_24[r_v4_3[r_v5_5(...)]] = true`; the result reaches fixed point in 14 full parses and the second optimizer pass applies 0 transforms. Focused optimizer tests, full project suites 14/14, and numeric 14/20/23 runtime parity all pass.
sample 63 non-adjacent small-function follow-up: `r_v3_1` is a sole-use closure whose body only writes the already-existing local/upvalue cell `r_v1_1`; intervening setup declares unrelated locals and assigns `r_v1_1 = false`, so moving closure creation to its `pcall` use preserves binding identity. Running on `63.optall3.assignkey.lua` removes `r_v3_1` and emits `local r_v6_2 = (pcall(function(...) ... r_v1_1 = true ... end)) and (r_v1_1)`. Three non-adjacent small closures inline in that file (plus one newly exposed deferred-local fold), fixed point is reached in 7 full parses, and a second pass applies 0 transforms. A direct LuaJIT captured-upvalue probe matches before/after output; full suites 14/14 and numeric 14/20/23 runtime parity pass.
sample 63 repeat-chain follow-up: the reported repeat block now recovers from `#t`/random/remove/arithmetic/char/result/nil/condition temporaries to `repeat; local r_v17_11 = r_v9_8(r_v15_5, (r_v5_7(1, #r_v15_5))); r_v13_5[r_v17_11] = r_v8_10(r_v17_11 - 1); until (#r_v15_5) == 0`. `r_v17_11` intentionally remains because it has two real uses. Running on `63.optall3.nonadjfn.lua` applies 143 transforms in 62 parses: 2 repeat lifetime nil writes removed, 22 adjacent call-argument folds, 111 adjacent assignment-value folds, 3 repeat-tail condition-temp folds, plus 5 newly exposed assignment-key folds; the second pass is 0 transforms. A direct Luau repeat parity probe matches byte-for-byte output, an adversarial Luau assignment-order probe matches (`nil nil nil 7`), full suites are 14/14 PASS, and numeric 14/20/23 runtime parity passes.
sample 63 numeric-for follow-up: running on `63.optall3.repeatfixed.lua` inlines 9 one-use numeric-for header constants and removes 4 explicit default step-1 temps. The reported `local r_v18_3 = 1; local r_v6_11 = 1; for r_v22_5 = r_v6_11, r_v19_3, r_v18_3 do` becomes `for r_v22_5 = 1, r_v19_3 do`. The result reaches fixed point; a second optimizer pass applies 0 transforms. Direct Luau output for a 1..4 numeric loop matches before/after, full project suites are 14/14 PASS, and numeric 14/20/23 runtime parity passes.
sample 63 dead-register release follow-up: the reported `r_v12_3 = nil` and `r_v15_4 = nil` are compiler lifetime-release writes at the start of a terminal `if` body; both locals are declared in the parent function, have no later activity, and are not captured. The ancestor-release proof now removes them. Running on `63.optall3.numericfor.lua` removes 21 proven direct nil release writes total; both reported assignments are gone, fixed point is reached in 4 parses, and a second pass applies 0 transforms. Focused optimizer tests, full project suites 14/14, and numeric 14/20/23 parity pass; loop/backedge, later-read, and capture barriers remain covered.
sample 63 dependency-safe non-adjacent key check: the requested `r_v14_208` remains intentionally un-inlined. Its producer is `r_v4_3[r_v5_5(...)]`, so the key itself calls the Prometheus decoder; that decoder mutates shared rolling/cache state and another decoder call occurs before the assignment use. Moving it would reorder stateful calls. The new private-table dependency proof therefore reports 0 extra folds on fresh sample 63 rather than weakening semantics. Synthetic private-table cases do inline across unrelated calls, while direct mutation, alias mutation, function-pass/capture, index-local writes, and call-containing lookup indexes refuse. Fresh sample 63 reaches fixed point with 4683 transforms / 374 parses; full suites 14/14 and numeric 14/20/23 runtime parity pass.
sample 63 adjacent table-constructor-key follow-up: the reported `local r_v1_273 = r_v4_3[r_v5_5(...)] ; local r_v7_237 = { [r_v1_273] = 0.5 }` now becomes `local r_v7_237 = { [r_v4_3[r_v5_5(...)]] = 0.5 }`. Running the new rule on the prior fixed-point sample 63 removes 9 such constructor-key temps in 8 full parses; a second optimizer pass applies 0 transforms. A direct LuaJIT probe with a stateful decoder plus `__index` metamethod has identical before/after output; full suites 14/14 and numeric 14/20/23 runtime parity pass.
sample 63 packed self-assignment follow-up: the reported `local r_v10_8 = { r_v4_10() }; r_v10_8 = r_v2_39(unpack(r_v10_8))` is confirmed against the local WeAreDevs compiler lowering and now recovers to `local r_v10_8 = r_v2_39(r_v4_10())`. Applying the rule to `63.packedreturn.lua` performs exactly 1 self-assignment forwarder / 1 multi-return-table collapse in 4 parses; a second pass applies 0 transforms. Focused optimizer tests cover extra-argument, local-unpack, and captured-target barriers; full suites 14/14 and numeric 14/20/23 runtime parity pass.

sample 63 namecall follow-up: Prometheus pass-self lowering `local method = base["Name"] ; method(base, args...)` is now recovered structurally to `base:Name(args...)` when the method temp has one call-target use, the first argument is the same lexical base, the method name is a valid non-keyword identifier, and the base binding has no intervening write/redeclaration/captured writer. On `63.nestedpacked.lua`, 32 namecalls recover; the reported SetAttribute chain becomes `r_v10_35:SetAttribute(r_v6_57, r_v4_48(r_v7_31()))`. Second pass applies 0 transforms; full suites 14/14 and numeric 14/20/23 runtime parity pass.
sample 63 nested packed-forwarding follow-up: the reported two-layer chain `local r_v1_38={r_v7_31()}; local r_v5_49={r_v4_48(unpack(r_v1_38))}; r_v2_65(r_v10_35,r_v6_57,unpack(r_v5_49))` now recovers to `r_v2_65(r_v10_35, r_v6_57, r_v4_48(r_v7_31()))`. Running on `63.selfassign2.lua` collapses 4 packed forwarders/tables total in 7 parses (the requested two layers plus two other same-pattern opportunities); a second pass applies 0 transforms. Focused tests cover nested packed consumers, stable prefix args, and effectful-prefix refusal; full suites 14/14 and fresh numeric 14/20/23 runtime parity pass.
sample 63 adjacent table-argument follow-up: consecutive plain table temps feeding one call now collapse back into direct constructor arguments. The reported `local r_v24_11 = {}; local r_v25_5 = { ["__index"] = r_v21_8, ["__metatable"] = nil }; r_v4_3 = setmetatable(r_v24_11, r_v25_5)` shape reduces to `r_v4_3 = setmetatable({}, { ... })`; second optimizer pass applies 0 transforms. Focused optimizer tests, full suites 14/14, and numeric 14/20/23 runtime parity pass.
parity-23 call-argument follow-up: Prometheus split `local callee = assert; local value = fn(1); callee(value == nil)` now recovers through the leading-argument rule and existing global-alias fold to `assert((fn(1)) == nil)`. The local compiler confirms call base is compiled before arguments and binary lhs before rhs. Parity-23 applies 9 adjacent call-argument folds plus 9 global aliases, second optimizer pass is 0 transforms, full suites are 14/14 PASS, and numeric 14/20/23 runtime parity passes.
if-comparison follow-up: `local f = math["random"]; local v = f(2, 3); if v == 3 then ... end` now recovers to `if math["random"](2, 3) == 3 then ... end`. The rule is intentionally narrow: adjacent call result, leading binary use in the next `if`, then adjacent indexed call-base snapshot; direct-condition and logical-right-arm regressions remain blocked. Exact probe reaches fixed point on pass 2; full suites 14/14 and numeric 14/20/23 runtime parity pass.

sample 20 returned-call follow-up: the reported `local r_v4_7 = r_v2_6(); local r_v2_35 = { r_v4_7() }; return unpack(r_v2_35)` is now recovered in two fixed-point steps to `return (r_v2_6())()`. The local WeAreDevs compiler confirms final returned calls use `RETURN_ALL` pack/unpack lowering. Fresh parity-20 collapses 7 packed return wrappers and 5 adjacent returned call-base temps; second optimizer pass applies 0 transforms. Full suites 14/14 and numeric 14/20/23 runtime parity pass.
sample 20/23 generated-vararg follow-up: the reported `local tail = { select(2, unpack(args)) }; if select("#", unpack(tail)) == 0 then ...` now recovers through repeated tail forwarding plus generated-header elimination to `if select("#", select(2, ...)) == 0 then ...`; `args[1]` becomes `(select(1, ...))` and later `concat(unpack(tail))` becomes `concat(select(2, ...))`. Fresh `output/20.beta.cf.lua` and `output/23.beta.cf.lua` each eliminate 5 generated vararg captures / recover 8 direct vararg reads, leaving zero generated `{ ... }` headers in the optimized files; second optimizer pass on parity-20 is 0 transforms. Focused barriers cover dynamic index, mutation, escape, nested closure capture, and preservation of a user/body `{ ... }` copy. Full suites 14/14 and numeric 14/20/23 LuaJIT parity pass.
main beta-CF closure-signature follow-up: nested closure emission now reconstructs source function parameters before the standalone optimizer. `createClosureN` is treated only as a padded fixed-arity upper bound because the local compiler uses `getCreateClosureVar(#node.args + math.random(0, 5))`; real fixed arity is proven by the contiguous compiler prologue loads `target = args[1..m]`. `createClosure` proves a vararg source closure; its `{ select(k, unpack(args)) }` prologue gives `m = k-1` fixed parameters and every proven `unpack(varargTemp)` / static `varargTemp[n]` use is restored to `...` / `select(n, ...)`. The promoted beta target names become the actual emitted function parameters, their local prologue declarations/loads are removed, and synthetic nested `local args = { ... }` is omitted. If prologue shape, contiguity, declaration ownership, or vararg-temp usage is not exact, emission falls back to the old `function(...)` + args header. Fresh sample 20 now emits `function(r_v12_2, ...)` with direct `select("#", ...)` / recursive `concat(...)`; its fixed `foo(a,b)` region emits two parameters despite a padded factory. Fresh samples 20/23 contain zero nested args headers/index/unpack references. Focused beta-CF tests, full suites 14/14, fresh CF->optimizer parity 14/20/23, and fresh-CF vs previous-CF runtime parity 14/20/23 all pass.
sample 63 zero-value packed-return follow-up: the reported `local r_v19_6 = { (function(...) ... end)() }; return unpack(r_v19_6)` wrapper now becomes direct `return (function(...) ... end)()` because the IIFE contains no value-returning `return`; bare return/fallthrough still produce zero values. Running on `63.tablekey.lua` applies exactly 1 packed-return forwarder / multi-return table collapse in 4 parses and reaches fixed point; a second pass applies 0 transforms. Direct LuaJIT zero-value arity/side-effect parity matches before/after, `return nil` and value-return regressions refuse, full suites are 14/14 PASS, and numeric 14/20/23 runtime parity passes.
loop-effects nested captured `_env["print"]` lookups now fold through the proven outer env to direct `print(...)`; the dead `_env` header and one-use print aliases disappear. LuaJIT before/after output matches, and all three kept loop probes are fixed point
fresh local-Prometheus loop-effects re-obfuscate -> beta-CF -> optimizer: 6 dead direct-nil cleanup writes removed, 4 adjacent opaque copy chains folded, and LuaJIT output matches readable source; current loop-effects/repeat/while probes also match readable source and are fixed point
optimizer imports from main/CF/deobf.bat: none
```

Current working tree outside generated/ignored output is intentionally left with only pre-existing user/scratch items:

```text
M formater/input.txt
?? sample/input.txt
```

Do not stage, reset, overwrite, or reinterpret those unless the user explicitly asks.

If a new chat is opened only to establish context, it must read this file and Git state, then explain what it understands. It must not start implementing, testing, changing files, committing, or pushing until the user gives a new action request.
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
small adjacent-index/if follow-up: a sole-use adjacent `Index` snapshot may inline into the next binary `if` only when that read is the leading evaluated use. Split probe `local p = game.Players; if ((#p:GetPlayers()) <= 1) then ... end` now becomes `if ((#game.Players:GetPlayers()) <= 1) then ... end`; `check() and ...p...` remains blocked so no earlier effect is crossed. Small probe pass 2 is 0 edits/byte-identical; Rust suite 130/130 PASS; no big-file run was used.
Rust decoder assignment-alias fix: Prometheus layers that predeclare aliases (`local proxyAlias=nil`, `local decoderAlias=nil`) and later assign them from the proven proxy/decoder are now discovered structurally. Exact `output/63.beta.cf.lua` changes from `Decoded strings: 0` to `Decoded strings: 563`; direct `r_v4_3[r_v5_5(...)]` uses drop to 0; second Rust pass is 0 edits/byte-identical; Rust suite 132/132 PASS. Non-local/global assignment aliases remain blocked. No JS optimizer used.
post-decode exposed-shape follow-up: adjacent index chains now fold `local a = Enum.EasingStyle; local b = a.Circular` -> `Enum.EasingStyle.Circular`, and one adjacent plain table temp may inline into a call argument. This lets later existing call-argument/call-base rounds collapse the reported tween shape to `r_v9_13.tween(..., Enum.EasingStyle.Circular, { ... })`. Split lexical probe only: 3 rounds, pass 2 = 0 edits/byte-identical; Rust suite 135/135 PASS; no big-file run.
same-index read/modify/write follow-up: adjacent `local old = state["index-focus"]; state["index-focus"] = old - 1` now folds to `state["index-focus"] = state["index-focus"] - 1` only when the base is a stable lexical binding and the exact key is the same pure literal. The later `local current = state["index-focus"]; pager:JumpToIndex(current)` snapshot intentionally remains because moving the indexed read into a namecall argument would reorder it after method lookup. Split lexical probe only: pass 2 = 0 edits/byte-identical; Rust suite 138/138 PASS; no big-file run.
Rust decoder proxy-backing-table variant: after ordinary Rust folding, some Prometheus samples keep `local backing = {}; proxy = setmetatable(backing, {...})` instead of inlining `{}`. Decoder proof now accepts that form only when the backing local is a fresh empty direct local with exactly two identifier occurrences in the containing scope (declaration + setmetatable argument), so any escape/reuse/reassignment fails closed. Real beta-CF gates: spacial=598 decoded / 147ms / 20 rounds, spacial2=311 / 49ms / 12, spacial4=171 / 25ms / 9, spacial5=1156 / 309ms / 12; all four second Rust passes are 0 edits and byte-identical. Canonical encrypted calls remaining: spacial=0, spacial2=0, spacial5=0. Rust suite 140/140 PASS. No spacial6 or JS run.
Rust dead-call statement rendering: the earlier leading-`;(` workaround was invalid for `eclipse_luau` and is superseded. Preserved dead-call side effects now strip only redundant parenthesized call/name/index callee wrappers, e.g. `(game:GetService(...)):Method()` -> `game:GetService(...):Method()` and `(loadstring(...))()` -> `loadstring(...)()`. If a leading parenthesized form is actually required, generic inlining fails closed instead of emitting `;(`.
Rust namecall argument-chain fusion: proven Prometheus namecall recovery can now consume the whole ordered same-block local dependency program between method capture and call, including local aliases, literals, indexed reads, and calls, then rebuild those values directly inside the namecall arguments. The proof requires every gap local to be single-use/noncaptured/nonwritten, all non-literal evaluations to occur in the same original order, no conditional right-arm movement, no effectful/non-local statement gap, and nested/partial gap use only in the final gap-fed argument; pure literal temp order may differ because those evaluations are effect-free. Proven string-decoder edits now take priority once the private decoder layer becomes available, before ordinary source recovery can consume ordering evidence. Exact `output/spacial6.beta.cf.lua` now emits `r_v4_874:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)` with the three snapshot locals gone; run was ~5.34 s / 37 rounds / 6149 decoded strings, pass 2 = 0 edits and byte-identical SHA-256 `1F711F78E85F3C5E6A78722D4E6EA4ED4E913D6A31C274280249DB9A80DE89EA`; Rust suite 147/147 PASS. Generic already-recovered namecalls such as the JumpToIndex snapshot remain conservative.
Rust dynamic inline follow-up: generalized global-alias call-base recovery so adjacent/effect-free `local t = task; t.wait()` becomes `task.wait()` while effect barriers block movement; compiler-namecall recovery now absorbs proven contiguous argument dependency closures on both sides of the captured method, so fresh spacial6 recovers `r_v4_874:Teleport(game.PlaceId, game.Players.LocalPlayer)` without hardcoded API names; added a structural conditional value coalescer for `holder -> seed -> result -> if seed ... -> holder=result` chains, producing one reused holder local while blocking self-referential branch sources. Exact `output/spacial6.beta.cf.lua`: 5980 ms / 37 rounds / 6149 decoded strings; requested leftover temps all 0; second pass 0 edits and byte-identical SHA-256 C4DCC7D27F91CE47633DDF67D8F1F358A143AFC64D6EAEEAC5F31D3523988BD1; Rust suite 153/153 PASS.

Rust generalized snapshot/iterator/table follow-up: contiguous single-use dependency programs feeding one table constructor now inline as one ordered batch, with compiler one-call pack tables excluded for dedicated multi-return handling; this collapses the large Color3.fromRGB producer array without reordering calls. Adjacent indexed snapshots may inline into a leading direct assignment RHS, nested pass-self calls recover inside larger expressions, immediate generic-for iterator aliases respect loop-variable shadow scope, and compiler packed `{ call() } -> outer(unpack(pack))` forwarding now works in the first generic-for iterator expression. This recovers `pairs(obj:GetChildren())`, removes the `WaveValue` one-use snapshot, removes `local iterator=pairs` even when the loop variable reuses that spelling, and collapses packed generic-for args to direct `pairs(obj:GetChildren())`. Packed forwarding now also refuses lexical/parameter-shadowed `unpack`. Exact stale `opt/www2.lua` reoptimization reaches fixed point in 4 rounds/5 parses with every reported leftover temp gone; fresh `output/spacial6.beta.cf.lua` is ~5.78 s / 37 rounds / 6149 decoded strings, all reported iterator/WaveValue/Color3 leftovers are 0, and pass 2 is 0 edits. Rust suite 169/169 PASS.
Rust optimizer modular split: the former ~8061-line `rust-optimizer/src/lib.rs` is now a tiny include shell with code physically split into `core.rs`, `steps/structural.rs`, `steps/multi_return.rs`, `steps/control_flow.rs`, `steps/private_table.rs`, `steps/namecall.rs`, and `pipeline.rs`. The split uses same-module `include!` files, so visibility/behavior is unchanged; Rust suite remains 169/169 PASS.
Rust direct pass-self early-stage follow-up: exact `output/spacial6.beta.cf.lua` now produces `getgenv().MacroRecordToggle = T_Macro:AddToggle(..., r_v40_42.macro_record, ...)` with all three reported locals gone; full run 5502 ms / 37 rounds / 6149 decoded strings; pass 2 = 0 edits; Rust suite 174/174 PASS.
Rust dead-nil cleanup follow-up: function parameters are now tracked separately from captured outer lexicals, so terminal parameter releases such as `r_v10_765 = nil` are removed when there is no later use/capture. Repeated-block cleanup now tracks the innermost loop body source range, allowing ancestor locals created inside each iteration to be released safely, and loop-tail nil writes may be removed when the next iteration's first direct use is an overwrite, with no capture or after-loop use. Exact `output/spacial6.beta.cf.lua`: 5119 ms / 37 rounds / 6149 decoded strings / 671 direct nil cleanups; direct `= nil` writes fell from 246 to 5. The five remaining writes are persistent state resets on `o_v29_5` / `o_v52_10` and are intentionally preserved. Pass 2 = 0 edits; Rust suite 181/181 PASS.
Rust parseability follow-up: regenerated exact `opt/www2.lua` from `output/spacial6.beta.cf.lua` in 5112 ms / 37 rounds. All three reported parse failures are fixed: `game:GetService("TeleportService"):TeleportToPlaceInstance(...)`, `loadstring(game:HttpGet("https://pastebin.com/raw/CnN5kYRT"))()`, and `loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterCompat.lua"))()`. Leading `;(` count is 0; Rust pass 2 parses successfully with 0 edits; suite 182/182 PASS.
Rust stable-field / callback-chain follow-up: immediate sole-use static dot-field fallback expressions composed from stable field chains, stable lexical names, literals, and `and`/`or` may inline into the next stable direct/namecall argument; computed indexes and effectful prefix arguments remain blocked. Immediate global aliases may also inline into a dot-field assignment target only when the RHS is effect-free. Adjacent sole-use index snapshots may now move into the leading evaluation position of the next statement, so `local a=obj.field; local b=a or 50` reaches `local b=obj.field or 50`. A sole-use closure with global-backed body names may move across a non-adjacent gap only when every crossed statement is effect-free and the existing no-shadow proof succeeds; effectful gaps still block. Exact `output/spacial6.beta.cf.lua` now collapses the reported slider chain to `T_Misc:AddSlider(..., r_v40_42.toggle_size or 50, function(...) ...)`, with `r_v53_339`, `r_v59_253`, `r_v58_275`, and `r_v57_302` all at 0 occurrences. Fresh run: 5611 ms / 39 rounds; pass 2 = 0 edits and byte-identical SHA-256 `15F561E918F4A159B10ED21E1550358AD700B1B8C89EF4A1E1125BB4F79FD5B5`; Rust suite 190/190 PASS. Immediate global aliases may also collapse into the next leading non-repeated expression use, and arbitrary non-name single-value temps may collapse into an immediately following direct `if` condition. Exact `spacial6` now emits `if not _G.auto_executed then` with `o_v127_15` / `o_v121_79` gone; fresh run 5538 ms / 39 rounds; pass 2 = 0 edits and byte-identical SHA-256 `3882F556F6C54D0647EC5C45392FC224AB03031AED740A3FB9520CFA056846AE`; Rust suite 192/192 PASS.

## PRE-CF Temp Recovery Work

Step 1 checkpoint: mapped local WeAreDevs compiler temp ownership in `docs/pre-cf-temp-map.md`. PRE-CF owns only proven transport/adjacent expression setup; branch/backedge-dependent `and/or`, if, while, repeat, numeric-for, generic-for, break/continue remain CF-owned. Dedicated probe: `sample/pre-cf/01-compiler-shapes.source.lua`, verified by local Medium compilation. Do not use generic one-use inlining.
Step 2 checkpoint: added `passes/pre-cf-temp-recovery.js` proof/index infrastructure. It indexes beta writes/reads by emitted binding, exposes exact producer/consumer facts, capture status from recovered upvalue bindings, same-state/adjacency, and CFG cycle crossing. Initial safe transport proof is deliberately same-state only. Focused test: `tools/test-pre-cf-temp-recovery.js`.
