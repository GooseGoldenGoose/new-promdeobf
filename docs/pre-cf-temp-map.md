# PRE-CF / CF Compiler Temp Ownership Map

Authority: local WeAreDevs compiler `src/prometheus/compiler/compiler.lua` only.

| Compiler shape | Local lowering evidence | Evaluation property | Owner | Generic PRE-CF move? |
| --- | --- | --- | --- | --- |
| literals / nil | `compileExpression` allocates register then scalar write | no effects; one evaluation | PRE-CF | only exact producer/use proof |
| local variable read | same-depth non-upvalue may reuse source register; copied when assignment needs snapshot | snapshot identity matters across writes | PRE-CF | adjacent/zero-movement first |
| global variable read | string-key temp then `_env[key]` index | environment/index read can be effectful | PRE-CF structural | never broad movement |
| static/dynamic index | base then index then index read | base/index order + metamethod effects | PRE-CF structural | adjacent only until stronger proof |
| unary/binary | operands compiled left-to-right then result register | operators can invoke metamethods | PRE-CF | only same evaluation position |
| ordinary call | call base compiled before args; final arg may use RETURN_ALL pack/unpack | call/order/multi-return sensitive | PRE-CF structural | dedicated call proof only |
| pass-self/namecall | base snapshot, method-name temp, indexed method lookup, explicit base as arg 1 | method lookup and base identity are semantic | PRE-CF structural | dedicated namecall recognizer only |
| local assignment | RHS temps first, then copy to lexical register/upvalue cell | snapshot / parallel assignment rules | PRE-CF | transport-only proof |
| normal assignment | indexed LHS base/index compiled before RHS; parallel results kept in temps | LHS address/RHS ordering is semantic | PRE-CF structural | never split/reorder atomic writes |
| return payload | ordinary args compile as one result; final call/namecall/vararg compiles RETURN_ALL and is unpacked into return table | Lua result adjustment differs | PRE-CF structural | dedicated return/multi-return proof |
| table constructor | entries compiled in source order; final list call may RETURN_ALL | table identity + field order + expansion | POST/PRE structural | no generic table inline |
| nonconstant `and` / `or` | compiler creates blocks, result register, state save/restore | short-circuit CFG | CF | no |
| `if` / `elseif` | condition register feeds POS branch | branch structure required | CF | no |
| `while` | explicit check block/backedge; condition compiled in check block | repeated each test | CF | no |
| `repeat` | compiler emits discarded first condition evaluation plus real check block | post-body repeated test + duplicate precheck | CF | no |
| numeric `for` | start/final/step setup once, hidden induction and sign-condition states | setup once; check repeated | CF | no generic PRE-CF loop move |
| generic `for` | iterator/state/control tuple made persistent, iterator call in check block | setup once; iterator repeated | CF | no generic PRE-CF loop move |
| break / continue | cleanup writes then jump to loop final/start state | loop-region control | CF | no |
| compound indexed assignment | base then index then RHS then one compound operation | address/RHS order + metamethods | PRE-CF keep atomic | never split |
| closure/function expression | closure factory/upvalue machinery | closure identity/capture timing | beta upvalue/closure + POST | never generic PRE-CF inline |

## Initial implementation boundary

PRE-CF starts with transport/copy and adjacent scalar expression recovery. Calls, indexes, globals, namecalls, return expansion, and multi-return each get separate structural rules. Any expression tied to branch/backedge/loop setup stays for CF. Arbitrary beautification stays post-CF.

## Focused probe

`sample/pre-cf/01-compiler-shapes.source.lua` covers scalar copies, binary temps, global/member reads, calls, multi-return, if, while, repeat, numeric for, generic for, and return. It is intentionally small and is the only source fixture used for this mapping checkpoint.