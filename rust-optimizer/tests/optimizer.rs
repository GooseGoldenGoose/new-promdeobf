use prom_rust_optimizer::optimize;

fn opt(source: &str) -> String {
    let (out, _) = optimize(source, 30).expect("optimizer failed");
    assert!(
        eclipse_luau::parse_one(&out).is_ok(),
        "optimized output must parse"
    );
    out
}

#[test]
fn recovers_indexed_if_call_chain() {
    let out = opt(r#"
local _env = getfenv()
local m = "math"
local mt = _env[m]
local k = "random"
local f = mt[k]
local v = f(2, 3)
if v == 3 then
    print("three")
end
"#);
    assert!(out.contains("math"));
    assert!(out.contains("[\"random\"]"));
    assert!(out.contains("(2, 3)"));
    assert!(!out.contains("local v ="));
    assert!(!out.contains("_env[m]"));
}

#[test]
fn folds_contextual_type_global() {
    let out = opt("local _env = getfenv()\nlocal f = _env[\"type\"]\nreturn f(1)\n");
    assert!(out.contains("type"));
    assert!(!out.contains("_env[\"type\"]"));
}

#[test]
fn packed_return_becomes_native_return() {
    let out = opt("local f = source\nlocal t = { f() }\nreturn unpack(t)\n");
    assert!(!out.contains("unpack(t)"));
    assert!(out.contains("return"));
    assert!(out.contains("source"));
}

#[test]
fn deferred_self_capture_is_not_folded() {
    let out = opt(r#"
local x
x = function()
    return x
end
return x
"#);
    assert!(out.contains("local x"));
    assert!(out.contains("x = function()"));
    assert!(!out.contains("local x = function()"));
}

#[test]
fn positive_namecall_recovery() {
    let out = opt(r#"
local obj = make()
local method = obj["Run"]
method(obj, 1)
"#);
    assert!(out.contains(":Run(1)"));
    assert!(!out.contains("local method"));
}

#[test]
fn namecall_multi_use_is_blocked() {
    let out = opt(r#"
local obj = make()
local method = obj["Run"]
method(obj)
print(method)
"#);
    assert!(out.contains("local method"));
    assert!(!out.contains(":Run()"));
}
#[test]
fn namecall_captured_base_is_blocked() {
    let out = opt(r#"
local obj = make()
local function mutate()
    obj = other
end
local method = obj["Run"]
method(obj)
return mutate
"#);
    assert!(!out.contains(":Run()"));
    assert!(out.contains("local method") || out.contains("obj[\"Run\"](obj)"));
}
#[test]
fn second_pass_is_fixed_point() {
    let first = opt("local a = 1\nlocal b = a\nreturn b\n");
    let (second, stats) = optimize(&first, 30).expect("second pass failed");
    assert_eq!(first, second);
    assert_eq!(stats.rounds, 0);
}

#[test]
fn removes_dead_direct_nil_release() {
    let out = opt(r#"
local x = 1
print(x)
x = nil
return
"#);
    assert!(!out.contains("x = nil"));
}

#[test]
fn dead_nil_release_capture_is_blocked() {
    let out = opt(r#"
local x = 1
local function read()
    return x
end
x = nil
return read
"#);
    assert!(out.contains("x = nil"));
}

#[test]
fn forwards_adjacent_assignment_rhs() {
    let out = opt(r#"
local target
local temp = function()
    return 7
end
target = temp
return target()
"#);
    assert!(!out.contains("local temp"));
    assert!(out.contains("return (function()"));
}

#[test]
fn inlines_small_lexical_function_across_safe_local_gap() {
    let out = opt(r#"
local x = 7
local f = function()
    return x
end
local unrelated = assert
local result = f()
return result
"#);
    assert!(!out.contains("local f ="));
    assert!(out.contains("(function()"));
}

#[test]
fn small_function_global_reference_is_blocked() {
    let out = opt(r#"
local f = function()
    return print("x")
end
local unrelated = side_effect()
local result = f()
return result, unrelated
"#);
    assert!(out.contains("local f = function()"));
}

#[test]
fn small_function_gap_shadow_is_blocked() {
    let out = opt(r#"
local x = 1
local f = function()
    return x
end
local x = 2
local result = f()
return result, x, x
"#);
    assert!(out.contains("local f = function()"));
}

#[test]
fn forwards_leading_call_argument_temp() {
    let out = opt(r#"
local callee = assert
local value = foo()
callee(value == nil)
"#);
    assert!(!out.contains("local value"));
    assert!(out.contains("foo()"));
}

#[test]
fn call_argument_captured_callee_is_blocked() {
    let out = opt(r#"
local callee = assert
local function mutate()
    callee = other
end
local value = foo()
callee(value == nil)
return mutate
"#);
    assert!(out.contains("local value"));
}

#[test]
fn removes_dead_generated_headers() {
    let out = opt(r#"
local _env = getfenv()
local args = { ... }
return 1
"#);
    assert!(!out.contains("local _env"));
    assert!(!out.contains("local args"));
}

#[test]
fn preserves_effect_of_dead_parenthesized_call_result() {
    let out = opt(r#"
local value = (getfenv())
return 1
"#);
    assert!(!out.contains("local value"));
    assert!(out.contains("getfenv()"));
}

#[test]
fn removes_only_function_root_bare_return() {
    let out = opt(r#"
local function f(flag)
    if flag then
        return
    end
    print(flag)
    return
end
return f
"#);
    assert!(out.contains("if flag then\n        return\n    end"));
    assert!(!out.contains("print(flag)\n    return\nend"));
}

#[test]
fn inlines_small_lexical_function_inside_comparison_argument() {
    let out = opt(r#"
local x = 1
local f = function()
    return x
end
local assert_local = assert
assert_local((f()) == 1)
"#);
    assert!(!out.contains("local f = function()"));
    assert!(out.contains("function()"));
}

#[test]
fn small_function_outside_loop_is_not_moved_into_loop() {
    let out = opt(r#"
local x = 1
local f = function()
    return x
end
while f() do
    break
end
"#);
    assert!(out.contains("local f = function()"));
}

#[test]
fn folds_opaque_adjacent_copy_chain() {
    let out = opt(r#"
local temp = make()
local real = temp
return real
"#);
    assert!(!out.contains("local temp"));
    assert!(out.contains("make()"));
}

#[test]
fn folds_adjacent_index_base_alias() {
    let out = opt(r#"
local t = math
local f = t["random"]
return f
"#);
    assert!(!out.contains("local t"));
    assert!(out.contains("math[\"random\"]"));
}

#[test]
fn folds_adjacent_call_index_key() {
    let out = opt(r#"
local base = {}
local k = decode()
local v = base[k]
return v
"#);
    assert!(!out.contains("local k"));
    assert!(out.contains("decode()"));
}

#[test]
fn folds_adjacent_assignment_key_lookup() {
    let out = opt(r#"
local source = {}
local target = {}
local k = source[1]
target[k] = 5
return target
"#);
    assert!(!out.contains("local k"));
    assert!(out.contains("target[source[1]] = 5"));
}

#[test]
fn folds_one_field_table_constructor_key() {
    let out = opt(r#"
local k = decode()
local t = { [k] = 0.5 }
return t
"#);
    assert!(!out.contains("local k"));
    assert!(out.contains("[decode()] = 0.5"));
}

#[test]
fn folds_two_plain_table_call_arguments() {
    let out = opt(r#"
local stable = 1
local a = {}
local b = { value = stable }
local sink = consume
sink(a, b)
"#);
    assert!(!out.contains("local a ="));
    assert!(!out.contains("local b ="));
    assert!(out.contains("consume({}, { value = 1 })") || out.contains("sink({}, { value = 1 })"));
}

#[test]
fn folds_generic_for_tuple() {
    let out = opt(r#"
local f, s, c = pairs(t)
for k, v in f, s, c do
    print(k, v)
end
"#);
    assert!(out.contains("for k, v in pairs(t) do"));
}

#[test]
fn folds_numeric_for_constants_and_default_step() {
    let out = opt(r#"
local a = 1
local b = 10
local c = 1
for i = a, b, c do
    print(i)
end
"#);
    assert!(out.contains("for i = 1, 10 do"));
}

#[test]
fn folds_non_adjacent_deferred_local() {
    let out = opt(r#"
local x
print("gap")
x = make()
return x
"#);
    assert!(!out.lines().any(|line| line.trim() == "local x"));
    assert!(out.contains("make()"));
}

#[test]
fn folds_repeat_tail_condition_temp() {
    let out = opt(r#"
repeat
    local done = check()
until done
"#);
    assert!(!out.contains("local done"));
    assert!(out.contains("until check()") || out.contains("until (check())"));
}

#[test]
fn folds_adjacent_returned_call_base() {
    let out = opt(r#"
local f = maker()
return f(1)
"#);
    assert!(!out.contains("local f"));
    assert!(out.contains("return (maker())(1)"));
}

#[test]
fn collapses_sparse_multi_return_pack() {
    let out = opt(r#"
local t = { f() }
local a = t[1]
local c = t[3]
print(a, c)
"#);
    assert!(!out.contains("t[1]"));
    assert!(!out.contains("t[3]"));
    assert!(out.contains("__beta_unused_return_"));
    assert!(out.contains("= f()"));
}

#[test]
fn collapses_only_second_multi_return_pack() {
    let out = opt(r#"
local t = { f() }
local b = t[2]
print(b)
"#);
    assert!(!out.contains("t[2]"));
    assert!(out.contains("__beta_unused_return_"));
}

#[test]
fn collapses_out_of_order_multi_return_pack() {
    let out = opt(r#"
local t = { f() }
local b = t[2]
local a = t[1]
print(a, b)
"#);
    assert!(!out.contains("local t"));
    assert!(out.contains("local a, b = f()") || out.contains("local a, b = (f())"));
}

#[test]
fn renames_dead_native_multi_return_target() {
    let out = opt(r#"
local a, b = f()
print(b)
"#);
    assert!(out.contains("__beta_unused_return_"));
    assert!(out.contains(", b = f()"));
}

#[test]
fn forwards_adjacent_packed_unpack() {
    let out = opt(r#"
local sink = print
local fn = function() return 1, 2, 3 end
local t = { pcall(fn) }
sink(unpack(t))
"#);
    assert!(!out.contains("local t"));
    assert!(!out.contains("unpack(t)"));
    assert!(out.contains("pcall"));
}

#[test]
fn forwards_packed_unpack_in_leading_if_expression() {
    let out = opt(r#"
local outer = consume
local inner = produce
local t = { inner() }
if outer(unpack(t)) == 1 then
    print("yes")
end
"#);
    assert!(!out.contains("local t"));
    assert!(!out.contains("unpack(t)"));
    assert!(out.contains("consume") && out.contains("produce"));
}

#[test]
fn packed_unpack_rhs_order_barrier_is_preserved() {
    let out = opt(r#"
local outer = consume
local inner = produce
local t = { inner() }
if other() == outer(unpack(t)) then
    print("yes")
end
"#);
    assert!(out.contains("local t"));
    assert!(out.contains("unpack(t)"));
}

#[test]
fn recovers_packed_unpack_self_assignment() {
    let out = opt(r#"
local outer = consume
local inner = produce
local t = { inner() }
t = outer(unpack(t))
print(t)
"#);
    assert!(!out.contains("unpack(t)"));
    assert!(out.contains("consume") && out.contains("produce"));
}

#[test]
fn packed_self_assignment_extra_arg_is_blocked() {
    let out = opt(r#"
local outer = consume
local inner = produce
local t = { inner() }
t = outer(unpack(t), after())
print(t)
"#);
    assert!(out.contains("unpack(t)"));
}

#[test]
fn packed_forward_local_unpack_is_blocked() {
    let out = opt(r#"
local sink = print
local unpack = customUnpack
local t = { f() }
sink(unpack(t))
"#);
    assert!(out.contains("unpack(t)"));
}

#[test]
fn zero_return_iife_pack_can_forward() {
    let out = opt(r#"
local t = { (function()
    if flag then return end
end)() }
return unpack(t)
"#);
    assert!(!out.contains("local t"));
    assert!(out.contains("return (function()"));
}

#[test]
fn value_return_iife_pack_does_not_generic_forward() {
    let out = opt(r#"
local t = { (function()
    return 1
end)() }
return unpack(t)
"#);
    assert!(out.contains("local t"));
    assert!(out.contains("unpack(t)"));
}

#[test]
fn prometheus_packed_return_respects_local_unpack_barrier() {
    let out = opt(r#"
local callee = source
local unpack = customUnpack
local t = { callee() }
return unpack(t)
"#);
    assert!(out.contains("local t"));
    assert!(out.contains("unpack(t)"));
}

#[test]
fn recovers_generated_vararg_capture_and_tail() {
    let out = opt(r##"
function probe(...)
-- generated header
local internalArgs = { ... }
-- generated body
local tail = { select(2, unpack(internalArgs)) }
local head = internalArgs[1]
if select("#", unpack(tail)) == 0 then
    print(head)
    return
end
consume(unpack(tail))
end
"##);
    assert!(!out.contains("local internalArgs ="));
    assert!(!out.contains("local tail ="));
    assert!(!out.contains("unpack(internalArgs)"));
    assert!(!out.contains("unpack(tail)"));
    assert!(out.contains("select(1, ...)"));
    assert!(out.contains("select(2, ...)"));
}

#[test]
fn recovers_generated_vararg_direct_reads() {
    let out = opt(r#"
function probe(...)
-- alpha
local captured = { ... }
-- omega
local first = captured[1]
local third = captured[3]
return first, third, unpack(captured)
end
"#);
    assert!(!out.contains("local captured ="));
    assert!(out.contains("select(1, ...)"));
    assert!(out.contains("select(3, ...)"));
    assert!(out.contains("..."));
}

#[test]
fn generated_vararg_dynamic_index_is_blocked() {
    let out = opt(r#"
function probe(...)
-- alpha
local captured = { ... }
-- omega
local index = choose()
return captured[index]
end
"#);
    assert!(out.contains("local captured = { ... }"));
    assert!(out.contains("captured[index]"));
}

#[test]
fn generated_vararg_nested_capture_is_blocked() {
    let out = opt(r#"
function probe(...)
-- alpha
local captured = { ... }
-- omega
local function read()
    return captured[1]
end
return read()
end
"#);
    assert!(out.contains("local captured = { ... }"));
}

#[test]
fn generated_vararg_preserves_body_vararg_copy() {
    let out = opt(r#"
function probe(...)
-- alpha
local generated = { ... }
-- omega
local sourceCopy = { ... }
local a = generated[1]
local b = sourceCopy[1]
return a, b
end
"#);
    assert!(!out.contains("local generated ="));
    assert!(out.contains("sourceCopy"));
}

#[test]
fn generated_vararg_mutation_is_blocked() {
    let out = opt(r#"
function probe(...)
-- generated header
local internalArgs = { ... }
-- generated body
internalArgs[2] = mutate()
return internalArgs[1]
end
"#);
    assert!(out.contains("local internalArgs = { ... }"));
}

#[test]
fn collapses_value_short_circuit_ladders() {
    let out = opt(r#"
local seed = table
local first = seed
if seed then
    local member = table["unpack"]
    first = member
end
local chosen = first
if not first then
    local fallback = unpack
    chosen = fallback
end
consume(chosen)
"#);
    assert!(!out.contains("if seed then"));
    assert!(!out.contains("if not first then"));
    assert!(out.contains(" and "));
    assert!(out.contains(" or "));
}

#[test]
fn value_short_circuit_global_seed_is_blocked() {
    let out = opt(r#"
local chosen = globalValue
if globalValue then
    chosen = rhs()
end
consume(chosen)
"#);
    assert!(out.contains("if globalValue then"));
}

#[test]
fn value_short_circuit_self_reference_is_blocked() {
    let out = opt(r#"
local seed = left()
local chosen = seed
if seed then
    chosen = combine(chosen)
end
consume(chosen)
"#);
    assert!(out.contains("if seed then"));
}

#[test]
fn value_short_circuit_keeps_live_seed_snapshot() {
    let out = opt(r#"
local seed = left()
local chosen = seed
if seed then
    chosen = combine(seed)
end
consume(chosen)
"#);
    assert!(out.contains("local seed = left()"));
    assert!(!out.contains("if seed then"));
    assert!(out.contains(" and "));
}

#[test]
fn collapses_while_short_circuit_ladder() {
    let out = opt(r#"
while true do
    local out
    local a = A()
    out = a
    if a then
        local inner
        local b = B()
        inner = b
        if not b then
            local c = C()
            inner = c
        end
        out = inner
    end
    if not out then
        break
    end
    body()
end
"#);
    assert!(!out.contains("while true do"));
    assert!(out.contains("A()"));
    assert!(out.contains("B()"));
    assert!(out.contains("C()"));
    assert!(out.contains(" and "));
    assert!(out.contains(" or "));
}

#[test]
fn collapses_repeat_short_circuit_ladder() {
    let out = opt(r#"
repeat
    body()
    local out
    local a = A()
    out = a
    if a then
        local inner
        local b = B()
        inner = b
        if not b then
            local c = C()
            inner = c
        end
        out = inner
    end
until out
"#);
    assert!(!out.contains("local out"));
    assert!(out.contains("until"));
    assert!(out.contains(" and "));
    assert!(out.contains(" or "));
}

#[test]
fn while_short_circuit_near_miss_is_blocked() {
    let out = opt(r#"
while true do
    local out
    local a = A()
    out = a
    if a then
        local b = B()
        out = b
    end
    if not out then break end
    print(out)
end
"#);
    assert!(out.contains("while true do"));
}

#[test]
fn collapses_long_while_short_circuit_ladder() {
    let out = opt(r#"
while true do
    local out
    local a = A()
    out = a
    if a then
        local chain
        local or1
        local b = B()
        or1 = b
        if not b then
            local or2
            local c = C()
            or2 = c
            if not c then
                local d = D()
                or2 = d
            end
            or1 = or2
        end
        chain = or1
        if or1 then
            local or3
            local e = E()
            or3 = e
            if not e then
                local f = F()
                or3 = f
            end
            chain = or3
        end
        out = chain
    end
    if not out then break end
    body()
end
"#);
    assert!(!out.contains("while true do"));
    assert!(out.contains("A()"));
    assert!(out.contains("F()"));
}

#[test]
fn removes_exact_discarded_repeat_precheck() {
    let out = opt(r#"
local right
local first = A()
right = B
if first then
    right()
end
repeat
    body()
until A() and right()
"#);
    assert!(!out.contains("local first = A()"));
    assert!(!out.contains("if first then"));
    assert!(out.contains("right = B"));
}

#[test]
fn discarded_repeat_precheck_mismatch_is_blocked() {
    let out = opt(r#"
local first = A()
if first then
    C()
end
repeat
    body()
until A() and B()
"#);
    assert!(out.contains("local first = A()"));
    assert!(out.contains("if first then"));
}

#[test]
fn dependency_safe_assignment_key_moves_private_table_lookup() {
    let out = opt(r#"
local source = {}
local target = {}
local other = {}
local touch = function()
    other[1] = 2
end
local key = source[1]
touch()
target[key] = true
"#);
    assert!(!out.contains("local key ="));
    assert!(out.contains("target[source[1]] = true"));
}

#[test]
fn dependency_safe_assignment_key_mutation_is_blocked() {
    let out = opt(r#"
local source = {}
local target = {}
local key = source[1]
source[1] = 2
target[key] = true
"#);
    assert!(out.contains("local key = source[1]"));
}

#[test]
fn dependency_safe_assignment_key_function_pass_is_blocked() {
    let out = opt(r#"
local source = {}
local target = {}
local mutate = function(t)
    t[1] = 2
end
local key = source[1]
mutate(source)
target[key] = true
"#);
    assert!(out.contains("local key = source[1]"));
}

#[test]
fn dependency_safe_assignment_key_alias_is_blocked() {
    let out = opt(r#"
local source = {}
local alias = source
local target = {}
local key = source[1]
alias[1] = 2
target[key] = true
print(alias)
"#);
    assert!(out.contains("local key = source[1]"));
}

#[test]
fn dependency_safe_assignment_key_capture_is_blocked() {
    let out = opt(r#"
local source = {}
local target = {}
local mutate = function()
    source[1] = 2
end
local key = source[1]
mutate()
target[key] = true
"#);
    assert!(out.contains("local key = source[1]"));
}

#[test]
fn dependency_safe_assignment_key_index_write_is_blocked() {
    let out = opt(r#"
local source = {}
local target = {}
local i = 1
local key = source[i]
i = 2
target[key] = true
"#);
    assert!(out.contains("local key = source[i]"));
}

#[test]
fn dependency_safe_assignment_key_call_index_is_blocked() {
    let out = opt(r#"
local source = {}
local target = {}
local decode = function()
    return 1
end
local key = source[decode()]
unrelated()
target[key] = true
"#);
    assert!(out.contains("local key = source["));
}

#[test]
fn env_setfenv_blocks_global_recovery() {
    let out = opt(r#"
local _env = getfenv()
local p = _env["print"]
setfenv(1, other)
p("x")
"#);
    assert!(out.contains("_env[\"print\"]"));
}

#[test]
fn env_rebind_blocks_global_recovery() {
    let out = opt(r#"
local _env = getfenv()
local p = _env["print"]
_env = other
p("x")
"#);
    assert!(out.contains("_env[\"print\"]"));
}

#[test]
fn env_readonly_capture_folds_inside_nested_function() {
    let out = opt(r#"
local _env = getfenv()
local f = function()
    return _env["warn"]
end
return f
"#);
    assert!(!out.contains("_env[\"warn\"]"));
    assert!(out.contains("warn"));
}

#[test]
fn env_deep_readonly_capture_folds() {
    let out = opt(r#"
local _env = getfenv()
local f = function()
    local g = function()
        return _env["warn"]
    end
    return g
end
return f
"#);
    assert!(!out.contains("_env[\"warn\"]"));
}

#[test]
fn nested_setfenv_blocks_only_nested_env_recovery() {
    let out = opt(r#"
local _env = getfenv()
local outer = _env["print"]
local f = function()
    setfenv(1, other)
    return _env["warn"]
end
return outer, f
"#);
    assert!(!out.contains("_env[\"print\"]"));
    assert!(out.contains("_env[\"warn\"]"));
}

#[test]
fn lexical_alias_moves_across_safe_same_block_gap() {
    let out = opt(r#"
local x = source()
local a = x
local unrelated = 1
print(a)
"#);
    assert!(!out.contains("local x = source()"));
    assert!(!out.contains("local a = x"));
    assert!(out.contains("local a = source()"));
    assert!(out.contains("print(a)"));
}

#[test]
fn lexical_alias_source_mutation_is_blocked() {
    let out = opt(r#"
local x = source()
local a = x
x = other
print(a)
"#);
    assert!(out.contains("local a = x"));
}

#[test]
fn global_alias_crosses_only_effect_free_gap() {
    let safe = opt(r#"
local p = print
local x = 1
p("x")
"#);
    assert!(!safe.contains("local p = print"));
    assert!(safe.contains("print(\"x\")"));

    let blocked = opt(r#"
local p = print
g()
p("x")
"#);
    assert!(blocked.contains("local p = print"));
}

#[test]
fn global_alias_immediate_generic_iterator_recovers() {
    let out = opt(r#"
local iterator = next
for k, v in iterator, t, nil do
    print(k, v)
end
"#);
    assert!(!out.contains("local iterator = next"));
    assert!(out.contains("for k, v in next, t, nil do"));
}

#[test]
fn global_alias_generic_iterator_gap_is_blocked() {
    let out = opt(r#"
local iterator = next
sideEffect()
for k, v in iterator, t, nil do
    print(k, v)
end
"#);
    assert!(out.contains("local iterator = next"));
}

#[test]
fn literal_snapshot_outside_loop_is_preserved() {
    let out = opt(r#"
local a = 3
while check(a) do
    tick()
end
"#);
    assert!(out.contains("local a = 3"));
    assert!(out.contains("while check(a) do"));
}

#[test]
fn global_snapshot_outside_loop_is_preserved() {
    let out = opt(r#"
local p = print
while again() do
    p("x")
end
"#);
    assert!(out.contains("local p = print"));
    assert!(out.contains("p(\"x\")"));
}

#[test]
fn recovers_parenthesized_if_call_temp() {
    let out = opt(r#"
local s = select
local function f(...)
    local v = s(1, ...)
    if (v == 0) then
        return 1
    end
end
return s, f
"#);
    assert!(!out.contains("local v ="));
    assert!(out.contains("if s(1, ...) == 0 then") || out.contains("if (s(1, ...) == 0) then"));
}

#[test]
fn deferred_local_crosses_unrelated_loop() {
    let out = opt(r#"
local x
while cond do
    tick()
end
x = 1
return x
"#);
    assert!(!out.lines().any(|line| line.trim() == "local x"));
    assert!(!out.contains("x = 1"));
    assert!(out.contains("return 1"));
}

#[test]
fn deferred_local_loop_observation_is_blocked() {
    let out = opt(r#"
local x
while cond do
    print(x)
end
x = 1
return x
"#);
    assert!(out.lines().any(|line| line.trim() == "local x"));
    assert!(out.contains("x = 1"));
}

#[test]
fn repeat_until_tail_local_is_live() {
    let out = opt(r#"
local i = 0
repeat
    i = i + 1
    local stop = 2
until i == stop
return i
"#);
    assert!(out.contains("local stop = 2") || out.contains("i == 2"));
}

#[test]
fn repeat_ancestor_nil_release_is_preserved() {
    let out = opt(r#"
local x = make()
repeat
    use(x)
    x = nil
until done()
return x
"#);
    assert!(out.contains("x = nil"));
}

#[test]
fn collapses_branch_alias_value_chain_to_one_expression() {
    let out = opt(r#"
local r_v13_1 = table
local r_v14_1 = r_v13_1
if r_v13_1 then
    local r_v12_2 = table
    r_v14_1 = r_v12_2["unpack"]
end
local r_v4_5 = r_v14_1
if not (r_v14_1) then
    r_v4_5 = unpack
end
return r_v4_5
"#);
    assert!(!out.contains("if r_v13_1 then"));
    assert!(!out.contains("if not (r_v14_1) then"));
    assert!(!out.contains("local r_v14_1 ="));
    assert!(out.contains("table"));
    assert!(out.contains("[\"unpack\"]"));
    assert!(out.contains(" and "));
    assert!(out.contains(" or "));
}
