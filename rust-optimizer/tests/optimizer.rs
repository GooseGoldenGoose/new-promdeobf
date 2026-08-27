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
    assert!(out.contains(".random(2, 3)"));
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
fn namecall_recovery_inlines_ordered_index_argument_snapshots() {
    let out = opt(r#"
local function probe(game, service)
    local method = service.TeleportToPlaceInstance
    local place_id = game.PlaceId
    local job_id = game.JobId
    local players = game.Players
    method(service, place_id, job_id, players.LocalPlayer)
end
"#);
    assert!(!out.contains("local method ="), "{out}");
    assert!(!out.contains("local place_id ="), "{out}");
    assert!(!out.contains("local job_id ="), "{out}");
    assert!(!out.contains("local players ="), "{out}");
    assert!(
        out.contains(
            "service:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)"
        ),
        "{out}"
    );
}

#[test]
fn namecall_recovery_inlines_compiler_base_alias_and_ordered_index_args() {
    let out = opt(r#"
local function probe(game, r_v4_874)
    local r_v1_2873 = r_v4_874
    local r_v4_3312 = r_v1_2873.TeleportToPlaceInstance
    local r_v2_2097 = game.PlaceId
    local r_v3_2193 = game.JobId
    local r_v6_2883 = game.Players
    local result = r_v4_3312(r_v1_2873, r_v2_2097, r_v3_2193, r_v6_2883.LocalPlayer)
end
"#);
    assert!(
        out.contains(
            "r_v4_874:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)"
        ),
        "{out}"
    );
    assert!(!out.contains("local r_v2_2097 ="), "{out}");
    assert!(!out.contains("local r_v3_2193 ="), "{out}");
    assert!(!out.contains("local r_v6_2883 ="), "{out}");
}

#[test]
fn namecall_gap_allows_pure_literal_temp_reordering() {
    let out = opt(r#"
local function probe(service, game, decode)
    local method = service.Run
    local decode_alias = decode
    local number = 7
    local text = "key"
    local key = decode_alias(text, number)
    local value = game[key]
    local result = method(service, value)
end
"#);
    assert!(!out.contains("local number ="), "{out}");
    assert!(!out.contains("local text ="), "{out}");
    assert!(!out.contains("local value ="), "{out}");
    assert!(out.contains("service:Run(game["), "{out}");
    assert!(out.contains("decode"), "{out}");
}

#[test]
fn namecall_argument_snapshot_fusion_requires_contiguous_gap() {
    let out = opt(r#"
local function probe(game, service)
    local method = service.Teleport
    local place_id = game.PlaceId
    touch()
    method(service, place_id)
end
"#);
    assert!(out.contains("local place_id = game.PlaceId"), "{out}");
}

#[test]
fn namecall_argument_snapshot_fusion_blocks_early_partial_use() {
    let out = opt(r#"
local function probe(game, service)
    local method = service.Teleport
    local players = game.Players
    local place_id = game.PlaceId
    method(service, players.LocalPlayer, place_id)
end
"#);
    assert!(out.contains("local players = game.Players"), "{out}");
    assert!(out.contains("local place_id = game.PlaceId"), "{out}");
}

#[test]
fn namecall_recovery_inlines_prefix_and_suffix_argument_dependencies() {
    let out = opt(r#"
local function probe(game, service)
    local base = service
    local game_before = game
    local place = game_before.PlaceId
    local method = base.Teleport
    local players = game.Players
    method(base, place, players.LocalPlayer)
end
"#);
    assert!(!out.contains("local place ="), "{out}");
    assert!(!out.contains("local players ="), "{out}");
    assert!(
        out.contains("service:Teleport(game.PlaceId, game.Players.LocalPlayer)"),
        "{out}"
    );
}

#[test]
fn namecall_prefix_argument_fusion_does_not_cross_effect() {
    let out = opt(r#"
local function probe(game, service)
    local game_before = game
    local place = game_before.PlaceId
    touch()
    local method = service.Teleport
    method(service, place)
end
"#);
    assert!(out.contains("local place ="), "{out}");
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
fn namecall_recovers_field_index_syntax() {
    let out = opt(r#"
local obj = source
local method = obj.Run
method(obj, 1)
"#);
    assert!(!out.contains("local method"), "{out}");
    assert!(out.contains(":Run(1)"), "{out}");
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
    assert!(out.contains("local method") || out.contains("obj.Run(obj)"));
}
#[test]
fn global_alias_indexed_callee_base_inlines() {
    let out = opt(r#"
local alias = task
alias.wait()
"#);
    assert!(!out.contains("local alias = task"), "{out}");
    assert!(out.contains("task.wait()"), "{out}");
}

#[test]
fn global_alias_indexed_callee_base_does_not_cross_effect() {
    let out = opt(r#"
local alias = task
touch()
alias.wait()
"#);
    assert!(out.contains("local alias = task"), "{out}");
    assert!(out.contains("alias.wait()"), "{out}");
}

#[test]
fn conditional_value_coalesce_reuses_holder() {
    let out = opt(r#"
local function probe(base)
    local holder = base
    local seed = holder:FindFirstChild("RobloxPromptGui")
    local result = seed
    if seed then
        holder = base.RobloxPromptGui
        result = holder:FindFirstChild("promptOverlay")
    end
    holder = result
    if holder then
        consume(holder)
    end
end
"#);
    assert!(!out.contains("local seed ="), "{out}");
    assert!(!out.contains("local result ="), "{out}");
    assert!(
        out.contains("local holder = base:FindFirstChild(\"RobloxPromptGui\")"),
        "{out}"
    );
    assert!(
        out.contains("holder = base.RobloxPromptGui:FindFirstChild(\"promptOverlay\")"),
        "{out}"
    );
}

#[test]
fn conditional_value_coalesce_blocks_branch_source_self_reference() {
    let out = opt(r#"
local function probe(base)
    local holder = base
    local seed = holder:FindFirstChild("a")
    local result = seed
    if seed then
        holder = holder.child
        result = holder:FindFirstChild("b")
    end
    holder = result
    consume(holder)
end
"#);
    assert!(out.contains("local seed ="), "{out}");
    assert!(out.contains("local result ="), "{out}");
}

#[test]
fn ordered_call_results_inline_into_table_constructor() {
    let out = opt(r#"
local function probe(f)
    local a = f(1)
    local b = f(2)
    local alias = f
    local tail = { alias(3) }
    local out = { a, b, unpack(tail) }
    return out
end
"#);
    assert!(!out.contains("local a ="), "{out}");
    assert!(!out.contains("local b ="), "{out}");
    assert!(!out.contains("local tail ="), "{out}");
    assert!(out.contains("f(1)"), "{out}");
    assert!(out.contains("f(2)"), "{out}");
    assert!(out.contains("f(3)"), "{out}");
}

#[test]
fn table_constructor_call_batch_preserves_producer_order() {
    let out = opt(r#"
local function probe(f)
    local a = f(1)
    local b = f(2)
    local out = { b, a }
    return out
end
"#);
    assert!(out.contains("local a = f(1)"), "{out}");
    assert!(out.contains("local b = f(2)"), "{out}");
}

#[test]
fn packed_table_tail_does_not_cross_prior_field_effect() {
    let out = opt(r#"
local function probe(f, g)
    local tail = { f() }
    local out = { g(), unpack(tail) }
    return out
end
"#);
    assert!(out.contains("local tail ="), "{out}");
    assert!(out.contains("unpack(tail)"), "{out}");
}

#[test]
fn table_constructor_batch_preserves_prior_captured_read_timing() {
    let out = opt(r#"
local function probe()
    local observed = 0
    local function produce()
        observed = 1
        return 5
    end
    local value = produce()
    local out = { observed, value }
    return out
end
"#);
    assert!(out.contains("local value = produce()"), "{out}");
    assert!(out.contains("{ observed, value }"), "{out}");
}

#[test]
fn table_constructor_call_batch_does_not_cross_prior_field_effect() {
    let out = opt(r#"
local function probe(f, g)
    local a = f(1)
    local b = f(2)
    local out = { g(), a, b }
    return out
end
"#);
    assert!(out.contains("local a = f(1)"), "{out}");
    assert!(out.contains("local b = f(2)"), "{out}");
}

#[test]
fn adjacent_index_snapshot_inlines_into_leading_assignment_rhs() {
    let out = opt(r#"
local function probe(game)
    local result
    local wave = game.ReplicatedStorage.WaveValue
    result = wave.Value
    return result
end
"#);
    assert!(!out.contains("local wave ="), "{out}");
    assert!(
        out.contains("result = game.ReplicatedStorage.WaveValue.Value"),
        "{out}"
    );
}

#[test]
fn adjacent_index_snapshot_does_not_cross_prior_rhs_effect() {
    let out = opt(r#"
local function probe(game)
    local result
    local wave = game.ReplicatedStorage.WaveValue
    result = before() + wave.Value
    return result
end
"#);
    assert!(out.contains("local wave = game.ReplicatedStorage.WaveValue"), "{out}");
}

#[test]
fn nested_pass_self_call_recovers_namecall() {
    let out = opt(r#"
local function probe(obj, each)
    local method = obj.GetChildren
    local a, b, c = each(method(obj))
    return a, b, c
end
"#);
    assert!(!out.contains("local method ="), "{out}");
    assert!(out.contains("each(obj:GetChildren())"), "{out}");
}

#[test]
fn nested_pass_self_call_requires_same_base() {
    let out = opt(r#"
local function probe(obj, other, each)
    local method = obj.GetChildren
    local a, b, c = each(method(other))
    return a, b, c
end
"#);
    assert!(!out.contains("obj:GetChildren()"), "{out}");
    assert!(out.contains("obj.GetChildren(other)"), "{out}");
}

#[test]
fn generic_for_header_alias_allows_loop_variable_shadow() {
    let out = opt(r#"
local function probe(t)
    local iterator = pairs
    for iterator, value in iterator(t) do
        consume(iterator, value)
    end
end
"#);
    assert!(!out.contains("local iterator = pairs"), "{out}");
    assert!(out.contains("for iterator, value in pairs(t) do"), "{out}");
}

#[test]
fn generic_for_header_argument_alias_and_iterator_alias_collapse() {
    let out = opt(r#"
local function probe(t)
    local iterator = pairs
    local source = t
    for source, value in iterator(source) do
        consume(source, value)
    end
end
"#);
    assert!(!out.contains("local iterator = pairs"), "{out}");
    assert!(!out.contains("local source = t"), "{out}");
    assert!(out.contains("for source, value in pairs(t) do"), "{out}");
}


#[test]
fn generic_for_header_alias_keeps_outer_alias_with_later_use() {
    let out = opt(r#"
local function probe(t)
    local iterator = pairs
    for iterator, value in iterator(t) do
        consume(iterator, value)
    end
    consume(iterator)
end
"#);
    assert!(out.contains("local iterator = pairs"), "{out}");
}

#[test]
fn nested_namecall_tuple_and_iterator_alias_reach_direct_generic_for() {
    let out = opt(r#"
local function probe(obj)
    local method = obj.GetChildren
    local iter, state, control = pairs(method(obj))
    local iter_alias = iter
    for key, value in iter_alias, state, control do
        consume(key, value)
    end
end
"#);
    assert!(!out.contains("local method ="), "{out}");
    assert!(!out.contains("local iter, state, control"), "{out}");
    assert!(!out.contains("local iter_alias ="), "{out}");
    assert!(out.contains("for key, value in pairs(obj:GetChildren()) do"), "{out}");
}

#[test]
fn packed_generic_for_argument_and_iterator_alias_collapse() {
    let out = opt(r#"
local function probe(obj)
    local iterator = pairs
    local packed = { obj:GetChildren() }
    for key, value in iterator(unpack(packed)) do
        consume(key, value)
    end
end
"#);
    assert!(!out.contains("local iterator = pairs"), "{out}");
    assert!(!out.contains("local packed ="), "{out}");
    assert!(!out.contains("unpack(packed)"), "{out}");
    assert!(out.contains("for key, value in pairs(obj:GetChildren()) do"), "{out}");
}

#[test]
fn packed_generic_for_argument_respects_shadowed_unpack() {
    let out = opt(r#"
local function probe(obj, unpack)
    local iterator = pairs
    local packed = { obj:GetChildren() }
    for key, value in iterator(unpack(packed)) do
        consume(key, value)
    end
end
"#);
    assert!(out.contains("local packed = { obj:GetChildren() }"), "{out}");
    assert!(out.contains("unpack(packed)"), "{out}");
}

#[test]
fn packed_generic_for_argument_keeps_escaping_pack() {
    let out = opt(r#"
local function probe(obj)
    local iterator = pairs
    local packed = { obj:GetChildren() }
    observe(packed)
    for key, value in iterator(unpack(packed)) do
        consume(key, value)
    end
end
"#);
    assert!(out.contains("local packed = { obj:GetChildren() }"), "{out}");
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
fn dead_parenthesized_namecall_result_gets_statement_separator() {
    let out = opt(r#"
local function probe(game, key)
    local unused = (game:GetService(key)):Set3dRenderingEnabled(false)
end
"#);
    assert!(
        out.contains(";(game:GetService(key)):Set3dRenderingEnabled(false)"),
        "{out}"
    );
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
    assert!(out.contains("math.random"));
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
    assert!(out.contains("_env.print"));
}

#[test]
fn env_rebind_blocks_global_recovery() {
    let out = opt(r#"
local _env = getfenv()
local p = _env["print"]
_env = other
p("x")
"#);
    assert!(out.contains("_env.print"));
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
    assert!(out.contains("_env.warn"));
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
fn global_alias_immediate_generic_iterator_call_base_recovers() {
    let out = opt(r#"
local iterator = pairs
for k, v in iterator(t) do
    print(k, v)
end
"#);
    assert!(!out.contains("local iterator = pairs"), "{out}");
    assert!(out.contains("for k, v in pairs(t) do"), "{out}");
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
    assert!(out.contains(".unpack"));
    assert!(out.contains(" and "));
    assert!(out.contains(" or "));
}

#[test]
fn folds_self_key_overwrite_lookup() {
    let out = opt(r#"
local r_v5_3 = math
local r_v8_2 = "random"
r_v8_2 = r_v5_3[r_v8_2]
return r_v8_2
"#);
    assert!(!out.contains("local r_v5_3 = math"));
    assert!(!out.contains("r_v8_2 = r_v5_3[r_v8_2]"));
    assert!(out.contains("local r_v8_2 = math.random"));
}

#[test]
fn self_key_overwrite_keeps_live_base_snapshot() {
    let out = opt(r#"
local base = math
local key = "random"
key = base[key]
consume(base)
return key
"#);
    assert!(out.contains("local base = math"));
    assert!(out.contains("key = base[key]"));
}

#[test]
fn folds_nested_index_key_with_stable_lexical_base() {
    let out = opt(r#"
local function probe(source, decode, base)
    local key = source[decode()]
    local value = base[key]
    return value
end
return probe
"#);
    assert!(!out.contains("local key = source[decode()]"));
    assert!(out.contains("base[source[decode()]]"));
}

#[test]
fn nested_index_key_unstable_base_is_blocked() {
    let out = opt(r#"
local function probe(source, decode, base, replacement)
    local function mutate()
        base = replacement
    end
    local key = source[decode()]
    local value = base[key]
    return value, mutate
end
return probe
"#);
    assert!(out.contains("local key = source[decode()]"));
}

#[test]
fn folds_index_temp_into_stable_call_argument() {
    let out = opt(r#"
local function probe(callee, source, decode, base)
    local value = base[source[decode()]]
    callee(value)
end
return probe
"#);
    assert!(!out.contains("local value = base[source[decode()]]"));
    assert!(out.contains("callee(base[source[decode()]])"));
}

#[test]
fn index_temp_call_argument_callee_writer_is_blocked() {
    let out = opt(r#"
local function probe(callee, source, decode, base, replacement)
    local function mutate()
        callee = replacement
    end
    local value = base[source[decode()]]
    callee(value)
    return mutate
end
return probe
"#);
    assert!(out.contains("local value = base[source[decode()]]"));
}

#[test]
fn small_function_size_ignores_comment_only_lines() {
    let comments = (0..120)
        .map(|index| format!("-- filler {index}"))
        .collect::<Vec<_>>()
        .join("\n");
    let source = format!(
        "local function outer(x)\n    local f = function()\n{comments}\n        return x\n    end\n    return f()\nend\nreturn outer\n"
    );
    let out = opt(&source);
    assert!(!out.contains("local f = function"));
    assert!(out.contains("return (function()"));
}

#[test]
fn folds_index_key_temp_inside_stable_call_argument() {
    let out = opt(r#"
local function probe(source, decode, base)
    local fire = firesignal
    local key = source[decode()]
    fire(base[key])
end
return probe
"#);
    assert!(!out.contains("local fire = firesignal"));
    assert!(!out.contains("local key = source[decode()]"));
    assert!(out.contains("firesignal(base[source[decode()]])"));
}

#[test]
fn index_key_temp_inside_call_blocks_unstable_index_base() {
    let out = opt(r#"
local function probe(source, decode, base, replacement, callee)
    local function mutate()
        base = replacement
    end
    local key = source[decode()]
    callee(base[key])
    return mutate
end
return probe
"#);
    assert!(out.contains("local key = source[decode()]"));
}

#[test]
fn inlines_negative_numeric_constant_across_effect_gap() {
    let out = opt(r#"
local r_v6_34 = -1
sideEffect()
r_v2_23(r_v8_17 == r_v6_34)
"#);
    assert!(!out.contains("local r_v6_34 = -1"));
    assert!(out.contains("r_v8_17 == (-1)"));
}

#[test]
fn negative_constant_inline_preserves_precedence() {
    let out = opt(r#"
local value = -2
return value ^ 2
"#);
    assert!(!out.contains("local value = -2"));
    assert!(out.contains("return (-2) ^ 2"));
}

#[test]
fn inlines_safe_literal_unary_constants_across_effect_gap() {
    let out = opt(r#"
local truth = not false
local length = #"abc"
sideEffect()
sink(truth, length)
"#);
    assert!(!out.contains("local truth ="));
    assert!(!out.contains("local length ="));
    assert!(out.contains("not false"));
    assert!(out.contains("#\"abc\""));
}

#[test]
fn mutable_unary_minus_is_not_treated_as_movable_constant() {
    let out = opt(r#"
local value = -source
sideEffect()
sink(value)
"#);
    assert!(out.contains("local value = -source"));
}

#[test]
fn table_length_is_not_treated_as_movable_constant() {
    let out = opt(r#"
local value = #source
sideEffect()
sink(value)
"#);
    assert!(out.contains("local value = #source"));
}

#[test]
fn inlines_nonadjacent_plain_table_call_arguments() {
    let out = opt(r#"
local a = {}
local middle = {}
local meta = { ["__index"] = middle, ["__metatable"] = nil }
result = setmetatable(a, meta)
"#);
    assert!(!out.contains("local a = {}"));
    assert!(!out.contains("local meta ="));
    assert!(out.contains("setmetatable({}, {"));
    assert!(out.contains("[\"__index\"] = middle"));
    assert!(out.contains("local middle = {}"));
}

#[test]
fn table_call_argument_allows_later_referenced_table_mutation() {
    let out = opt(r#"
local base = {}
local cache = {}
local meta = { ["__index"] = cache, ["__metatable"] = nil }
result = setmetatable(base, meta)
cache[1] = "later"
"#);
    assert!(!out.contains("local base = {}"), "{out}");
    assert!(!out.contains("local meta ="), "{out}");
    assert!(out.contains("setmetatable({}, {"), "{out}");
    assert!(out.contains("[\"__index\"] = cache"), "{out}");
    assert!(out.contains("cache[1] = \"later\""), "{out}");
}

#[test]
fn table_call_argument_effect_gap_is_blocked() {
    let out = opt(r#"
local a = {}
sideEffect()
local meta = { ["__index"] = current }
result = setmetatable(a, meta)
"#);
    assert!(out.contains("local a = {}"));
}

#[test]
fn adjacent_call_result_moves_into_direct_if_condition() {
    let out = opt(r#"
local loaded = game:IsLoaded()
if not loaded then
    warn("wait")
end
"#);
    assert!(!out.contains("local loaded ="));
    assert!(out.contains("if not game:IsLoaded() then"));
}

#[test]
fn adjacent_index_result_moves_into_leading_nested_if_use() {
    let out = opt(r#"
local players_service = game.Players
if ((#players_service:GetPlayers()) <= 1) then
    print("one")
end
"#);
    assert!(
        !out.contains("local players_service = game.Players"),
        "{out}"
    );
    assert!(out.contains("#game.Players:GetPlayers()"), "{out}");
}

#[test]
fn adjacent_index_result_does_not_cross_prior_if_effect() {
    let out = opt(r#"
local players_service = game.Players
if check() and ((#players_service:GetPlayers()) <= 1) then
    print("one")
end
"#);
    assert!(
        out.contains("local players_service = game.Players"),
        "{out}"
    );
}

#[test]
fn adjacent_index_result_moves_into_direct_if_condition() {
    let out = opt(r#"
local player = players[key]
if player then
    use(player)
end
"#);
    // The body use makes this two reads, so the snapshot must stay.
    assert!(out.contains("local player = players[key]"));

    let out = opt(r#"
local player = players[key]
if player then
    print("yes")
end
"#);
    assert!(!out.contains("local player = players[key]"));
    assert!(out.contains("if players[key] then"));
}

#[test]
fn adjacent_index_result_moves_into_namecall_base() {
    let out = opt(r#"
local loadedSignal = game[key]
loadedSignal:Wait()
"#);
    assert!(!out.contains("local loadedSignal ="));
    assert!(out.contains("game[key]:Wait()"));
}

#[test]
fn adjacent_index_result_moves_into_call_base() {
    let out = opt(r#"
local fn = task[key]
fn()
"#);
    assert!(!out.contains("local fn ="));
    assert!(out.contains("task[key]()"));
}

#[test]
fn adjacent_call_created_callee_keeps_single_result_grouping() {
    let out = opt(r#"
local fn = makeFn()
fn()
"#);
    assert!(!out.contains("local fn ="));
    assert!(out.contains("(makeFn())()"));
}

const PROM_DECODER_FIXTURE: &str = r#"
local chars = {}
local proxy = nil
local pool = {}
local decoder = nil
local floor = math.floor
local random = math.random
local remove = table.remove
local char = string.char
local state = 0
local cursor = 2
for index = 1, 256 do
    pool[index] = index
end
repeat
    local index = remove(pool, random(1, #pool))
    chars[index] = char(index - 1)
    local remaining = #pool
    local zero = 0
until remaining == zero
local empty_buffer = {}
local buffer
local next_byte = function()
    if #buffer == 0 then
        state = ((state * 45) + 21402374792941) % 35184372088832
        repeat
            cursor = (cursor * 164) % 257
            local current = cursor
            local one = 1
        until current ~= one
        local shift = cursor % 32
        local divisor = 2 ^ (13 - ((cursor - shift) / 32))
        local floored = floor(state / divisor)
        local state32 = floored % 4294967296
        local power = 2 ^ shift
        local mixed = state32 / power
        local fraction = floor((mixed % 1) * 4294967296)
        local whole = floor(mixed)
        local packed = fraction + whole
        local low = packed % 65536
        local high = (packed - low) / 65536
        local b0 = low % 256
        local b1 = (low - b0) / 256
        local b2 = high % 256
        local b3 = (high - b2) / 256
        buffer = { b0, b1, b2, b3 }
    end
    return table.remove(buffer)
end
buffer = empty_buffer
local cache = {}
proxy = setmetatable({}, { ["__index"] = cache, ["__metatable"] = nil })
decoder = function(cipher, key)
    local cache_alias = cache
    local cached = cache_alias[key]
    if not cached then
        buffer = {}
        local chars_alias = chars
        local string_lib = string
        state = key % 35184372088832
        cursor = (key % 255) + 2
        local length = string_lib.len(cipher)
        cache_alias[key] = ""
        local limit = length
        local rolling = 28
        for index = 1, limit do
            local byte = string_lib.byte(cipher, index)
            local stream = next_byte()
            rolling = ((byte + stream) + rolling) % 256
            local old = cache_alias[key]
            local ch = chars_alias[rolling + 1]
            cache_alias[key] = old .. ch
        end
    end
    return key
end
return task[proxy[decoder("\184@\156~", 5321961048494)]]
"#;

#[test]
fn decodes_structurally_proven_private_string_layer() {
    let out = opt(PROM_DECODER_FIXTURE);
    assert!(out.contains("task.wait"), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
    assert!(!out.contains("\\184@\\156~"), "{out}");
}

#[test]
fn decoder_precedes_namecall_snapshot_recovery() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "local service = {}\nlocal method = service.Run\nlocal value = task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]\nmethod(service, value)\nreturn true",
    );
    let out = opt(&source);
    assert!(out.contains("service:Run(task.wait)"), "{out}");
    assert!(!out.contains("local value = task.wait"), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_named_private_proxy_backing_table_is_folded() {
    let source = PROM_DECODER_FIXTURE.replace(
        "proxy = setmetatable({}, {",
        "local proxy_backing = {}\nproxy = setmetatable(proxy_backing, {",
    );
    let out = opt(&source);
    assert!(out.contains("task.wait"), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_named_proxy_backing_table_escape_is_blocked() {
    let source = PROM_DECODER_FIXTURE.replace(
        "proxy = setmetatable({}, {",
        "local proxy_backing = {}\nobserve(proxy_backing)\nproxy = setmetatable(proxy_backing, {",
    );
    let out = opt(&source);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_assignment_aliases_are_discovered() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "local proxy_alias = nil\nlocal decoder_alias = nil\nproxy_alias = proxy\ndecoder_alias = decoder\nreturn task[proxy_alias[decoder_alias(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&source);
    assert!(out.contains("task.wait"), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_assignment_alias_without_local_binding_is_blocked() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "proxy_alias = proxy\ndecoder_alias = decoder\nreturn task[proxy_alias[decoder_alias(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&source);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_two_step_temp_lookup_is_folded() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "local decoded_key = decoder(\"\\184@\\156~\", 5321961048494)\nreturn task[proxy[decoded_key]]",
    );
    let out = opt(&source);
    assert!(out.contains("task.wait"), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_alias_rhs_reassignment_is_folded() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "local decode_alias = decoder\ndecode_alias = proxy[decode_alias(\"\\184@\\156~\", 5321961048494)]\nreturn task[decode_alias]",
    );
    let out = opt(&source);
    assert!(out.contains("decode_alias = \"wait\""), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
    assert!(!out.contains("\\184@\\156~"), "{out}");
}

#[test]
fn proxy_alias_reassigned_after_decode_still_folds_prior_use() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "local proxy_alias = proxy\nlocal decoded = proxy_alias[decoder(\"\\184@\\156~\", 5321961048494)]\nproxy_alias = other\nreturn task[decoded]",
    );
    let out = opt(&source);
    assert!(out.contains("task.wait"), "{out}");
    assert!(!out.contains("5321961048494"), "{out}");
}

#[test]
fn proxy_alias_use_after_reassignment_is_not_folded() {
    let source = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "local proxy_alias = proxy\nproxy_alias = other\nreturn task[proxy_alias[decoder(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&source);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_near_miss_without_cache_append_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace("cache_alias[key] = old .. ch", "sink(old, ch)");
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_cache_escape_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "observe(cache)\nreturn task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_generator_escape_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "observe(next_byte)\nreturn task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_dynamic_unmatched_use_blocks_static_folding() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "observe(proxy[decoder(dynamicCipher, dynamicKey)])\nreturn task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_extra_side_effect_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "    return key\nend\nreturn task",
        "    touch()\n    return key\nend\nreturn task",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_extra_state_write_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "        buffer = {}\n        local chars_alias = chars",
        "        buffer = {}\n        state = state + 1\n        local chars_alias = chars",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_generator_extra_side_effect_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "    return table.remove(buffer)\nend",
        "    touch()\n    return table.remove(buffer)\nend",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_extra_rolling_write_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "            rolling = ((byte + stream) + rolling) % 256\n            local old",
        "            rolling = ((byte + stream) + rolling) % 256\n            rolling = rolling + 1\n            local old",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_char_table_escape_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "return task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
        "observe(chars)\nreturn task[proxy[decoder(\"\\184@\\156~\", 5321961048494)]]",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_char_table_extra_write_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "local empty_buffer = {}",
        "chars[1] = \"tampered\"\nlocal empty_buffer = {}",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_extra_global_write_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "    return key\nend\nreturn task",
        "    external_state = 1\n    return key\nend\nreturn task",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_generator_extra_state_write_is_not_folded() {
    let broken = PROM_DECODER_FIXTURE.replace(
        "        state = ((state * 45) + 21402374792941) % 35184372088832",
        "        state = state + 1\n        state = ((state * 45) + 21402374792941) % 35184372088832",
    );
    let out = opt(&broken);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn decoder_near_miss_without_cache_write_is_not_folded() {
    let out = opt(r#"
local state
local cursor
local cache = {}
local proxy = setmetatable({}, { ["__index"] = cache })
local function next_byte()
    state = ((state * 45) + 21402374792941) % 35184372088832
    cursor = (cursor * 164) % 257
    local shift = cursor % 32
    return 2 ^ (13 - ((cursor - shift) / 32))
end
local function decoder(cipher, key)
    local cached = cache[key]
    state = key % 35184372088832
    cursor = (key % 255) + 2
    local rolling = 28
    rolling = (rolling + next_byte()) % 256
    return key
end
return task[proxy[decoder("\\184@\\156~", 5321961048494)]]
"#);
    assert!(out.contains("5321961048494"), "{out}");
}

#[test]
fn static_identifier_index_becomes_field_but_keyword_stays_bracketed() {
    let out = opt(r#"
local object = source
local a = object["Valid_Name9"]
local b = object["end"]
return a, b
"#);
    assert!(out.contains(".Valid_Name9"), "{out}");
    assert!(out.contains("[\"end\"]"), "{out}");
}

#[test]
fn adjacent_index_chain_inlines_enum_style() {
    let out = opt(r#"
local style = Enum.EasingStyle
local circular = style.Circular
use(circular)
"#);
    assert!(!out.contains("local style = Enum.EasingStyle"), "{out}");
    assert!(out.contains("Enum.EasingStyle.Circular"), "{out}");
}

#[test]
fn single_adjacent_plain_table_call_argument_inlines() {
    let out = opt(r#"
local props = {
    ["ImageTransparency"] = 0
}
apply(target, props)
"#);
    assert!(!out.contains("local props ="), "{out}");
    assert!(out.contains("apply(target, {"), "{out}");
    assert!(out.contains("[\"ImageTransparency\"] = 0"), "{out}");
}

#[test]
fn decoded_style_chain_reaches_post_decode_shape_fixed_point() {
    let out = opt(r#"
local function probe(ui, first_call, first_target, first_style, second_target)
    local first_props = {
        ["ImageTransparency"] = 0
    }
    first_call(first_target, 0.25, first_style, first_props)

    local tween = ui.tween
    local easing_style = Enum.EasingStyle
    local circular = easing_style.Circular
    local second_props = {
        ["BackgroundTransparency"] = 1
    }
    tween(second_target, 0.25, circular, second_props)
end
"#);
    assert!(!out.contains("local first_props ="), "{out}");
    assert!(!out.contains("local easing_style ="), "{out}");
    assert!(!out.contains("local circular ="), "{out}");
    assert!(!out.contains("local second_props ="), "{out}");
    assert!(!out.contains("local tween = ui.tween"), "{out}");
    assert!(out.contains("Enum.EasingStyle.Circular"), "{out}");
    assert!(
        out.contains("ui.tween(second_target, 0.25, Enum.EasingStyle.Circular, {"),
        "{out}"
    );
}

#[test]
fn same_index_read_modify_write_inlines_but_namecall_snapshot_stays() {
    let out = opt(r#"
local function probe(state, pager)
    local old = state["index-focus"]
    state["index-focus"] = old - 1
    local current = state["index-focus"]
    pager:JumpToIndex(current)
end
"#);
    assert!(!out.contains("local old ="), "{out}");
    assert!(
        out.contains("state[\"index-focus\"] = state[\"index-focus\"] - 1"),
        "{out}"
    );
    assert!(
        out.contains("local current = state[\"index-focus\"]"),
        "{out}"
    );
    assert!(out.contains("pager:JumpToIndex(current)"), "{out}");
}

#[test]
fn same_index_read_modify_write_blocks_global_base() {
    let out = opt(r#"
local old = state["index-focus"]
state["index-focus"] = old - 1
"#);
    assert!(out.contains("local old = state[\"index-focus\"]"), "{out}");
}

#[test]
fn same_index_read_modify_write_blocks_different_key() {
    let out = opt(r#"
local function probe(state)
    local old = state["before"]
    state["after"] = old - 1
end
"#);
    assert!(out.contains("local old = state.before"), "{out}");
}

#[test]
fn adjacent_if_call_argument_and_callee_aliases_collapse() {
    let out = opt(r#"
local function probe(items, profile)
    local finder = table.find
    local wanted = profile.macro_profile
    if not finder(items, wanted) then
        consume(items)
    end
end
"#);
    assert!(!out.contains("local finder = table.find"), "{out}");
    assert!(!out.contains("local wanted = profile.macro_profile"), "{out}");
    assert!(out.contains("if not table.find(items, profile.macro_profile) then"), "{out}");
}

#[test]
fn adjacent_if_call_argument_keeps_effectful_prefix_order() {
    let out = opt(r#"
local function probe(profile)
    local wanted = profile.macro_profile
    if not find(loadItems(), wanted) then
        consume()
    end
end
"#);
    assert!(out.contains("local wanted = profile.macro_profile"), "{out}");
}

#[test]
fn stable_field_snapshot_and_env_target_collapse() {
    let out = opt(r#"
local function probe(profile)
    local env = getgenv()
    local ui = T_Macro
    local method = ui.AddToggle
    local wanted = profile.macro_record
    env.MacroRecordToggle = method(ui, "title", "desc", wanted, function() end)
end
"#);
    assert!(!out.contains("local env = getgenv()"), "{out}");
    assert!(!out.contains("local ui = T_Macro"), "{out}");
    assert!(!out.contains("local method ="), "{out}");
    assert!(!out.contains("local wanted = profile.macro_record"), "{out}");
    assert!(
        out.contains("getgenv().MacroRecordToggle = T_Macro:AddToggle(\"title\", \"desc\", profile.macro_record, function()"),
        "{out}"
    );
}
#[test]
fn direct_pass_self_and_snapshot_aliases_collapse() {
    let out = opt(r#"
local function probe(profile)
    local env = getgenv()
    local ui = T_Macro
    local wanted = profile.macro_record
    env.MacroRecordToggle = ui.AddToggle(ui, "title", "desc", wanted, function() end)
end
"#);
    assert!(!out.contains("local env = getgenv()"), "{out}");
    assert!(!out.contains("local ui = T_Macro"), "{out}");
    assert!(!out.contains("local wanted = profile.macro_record"), "{out}");
    assert!(
        out.contains("getgenv().MacroRecordToggle = T_Macro:AddToggle(\"title\", \"desc\", profile.macro_record, function()"),
        "{out}"
    );
}
