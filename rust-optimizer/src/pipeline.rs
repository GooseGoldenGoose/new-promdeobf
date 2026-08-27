fn function_parameter_names(ctx: &Ctx<'_>, body: &FunctionBody) -> HashSet<String> {
    body.params
        .iter()
        .filter(|param| !param.is_vararg)
        .filter_map(|param| ctx.text(param.name).map(str::to_string))
        .collect()
}

fn function_visible_scope(
    ctx: &Ctx<'_>,
    body: &FunctionBody,
    captured: &HashSet<String>,
) -> HashSet<String> {
    let mut scope = captured.clone();
    scope.extend(function_parameter_names(ctx, body));
    scope
}

fn ancestor_release_safe(
    function_usage: &UsageIndex,
    name: &str,
    statement: &Range<usize>,
    repeated_scope_start: Option<usize>,
) -> bool {
    let Some(items) = function_usage.by_name.get(name) else {
        return false;
    };
    let mut declarations = items
        .iter()
        .filter(|item| item.kind == OccKind::Redeclare && item.pos < statement.start);
    let Some(declaration) = declarations.next() else {
        return false;
    };
    if declarations.next().is_some() {
        return false;
    }
    if repeated_scope_start.is_some_and(|start| declaration.pos < start) {
        return false;
    }
    if items.iter().any(|item| item.kind == OccKind::Capture) {
        return false;
    }
    !items.iter().any(|item| {
        item.pos >= statement.end
            && matches!(
                item.kind,
                OccKind::Read | OccKind::Write | OccKind::Redeclare | OccKind::Capture
            )
    })
}

fn assignment_reinitializes_name(ctx: &Ctx<'_>, stmt: &Stmt, name: &str) -> bool {
    let Stmt::Assign(node) = stmt else {
        return false;
    };
    let mut direct_target = false;
    for target in &node.targets {
        if name_of_expr(ctx, target) == Some(name) {
            if direct_target {
                return false;
            }
            direct_target = true;
        } else if expr_contains_name(ctx, target, name) {
            return false;
        }
    }
    direct_target && !node.values.iter().any(|value| expr_contains_name(ctx, value, name))
}

fn loop_tail_release_safe(
    ctx: &Ctx<'_>,
    block: &Block,
    statement_index: usize,
    function_usage: &UsageIndex,
    name: &str,
    statement: &Range<usize>,
    repeated_scope_start: Option<usize>,
) -> bool {
    if statement_index + 1 != block.stmts.len()
        || repeated_scope_start
            != ctx.range(block.span).map(|range| range.start)
    {
        return false;
    }
    let Some(items) = function_usage.by_name.get(name) else {
        return false;
    };
    if items.iter().any(|item| item.kind == OccKind::Capture) {
        return false;
    }
    if items.iter().any(|item| {
        item.pos >= statement.end
            && matches!(
                item.kind,
                OccKind::Read | OccKind::Write | OccKind::Redeclare | OccKind::Capture
            )
    }) {
        return false;
    }
    for stmt in &block.stmts[..statement_index] {
        if stmt_contains_name(ctx, stmt, name) {
            return assignment_reinitializes_name(ctx, stmt, name);
        }
    }
    false
}
fn collect_block(
    ctx: &Ctx<'_>,
    block: &Block,
    edits: &mut Vec<Edit>,
    function_root: bool,
    env_start: Option<usize>,
    outer_lexical: &HashSet<String>,
    function_params: &HashSet<String>,
    function_usage: &UsageIndex,
    repeated_scope_start: Option<usize>,
) {
    collect_block_with_tail(
        ctx,
        block,
        edits,
        function_root,
        env_start,
        outer_lexical,
        function_params,
        function_usage,
        repeated_scope_start,
        None,
    );
}

fn collect_block_with_tail(
    ctx: &Ctx<'_>,
    block: &Block,
    edits: &mut Vec<Edit>,
    function_root: bool,
    env_start: Option<usize>,
    outer_lexical: &HashSet<String>,
    function_params: &HashSet<String>,
    function_usage: &UsageIndex,
    repeated_scope_start: Option<usize>,
    tail_expr: Option<&Expr>,
) {
    // Structural control-flow recovery must claim the compiler ladder before child cleanup can erase it.
    // Function roots already receive their whole-function usage index from the caller; reuse it
    // instead of indexing the entire function body twice in the same immutable AST round.
    let structural_usage_owned;
    let structural_usage = if function_root && tail_expr.is_none() {
        function_usage
    } else {
        structural_usage_owned = build_usage_index_with_tail(ctx, block, tail_expr);
        &structural_usage_owned
    };
    collect_repeat_precheck(ctx, block, edits);
    collect_loop_short_circuit(ctx, block, edits);
    collect_conditional_value_coalesce(ctx, block, structural_usage, edits);
    collect_value_short_circuit(ctx, block, structural_usage, edits);

    // Recurse after structural claims so overlapping child cleanup is refused.
    // Track lexical names visible at each statement so nested closures can distinguish
    // outer locals/upvalues from globals without trusting generated names.
    let mut visible_here = outer_lexical.clone();
    for stmt in &block.stmts {
        // The visible set is not mutated until this statement is fully processed, so
        // nested analysis can borrow it directly instead of cloning a growing HashSet.
        let statement_visible = &visible_here;
        match stmt {
            Stmt::Do(n) => collect_block(
                ctx,
                &n.block,
                edits,
                false,
                env_start,
                statement_visible,
                function_params,
                function_usage,
                repeated_scope_start,
            ),
            Stmt::While(n) => collect_block(
                ctx,
                &n.block,
                edits,
                false,
                env_start,
                statement_visible,
                function_params,
                function_usage,
                ctx.range(n.block.span).map(|range| range.start),
            ),
            Stmt::Repeat(n) => {
                collect_repeat_tail_inline(ctx, n, edits);
                collect_block_with_tail(
                    ctx,
                    &n.block,
                    edits,
                    false,
                    env_start,
                    statement_visible,
                    function_params,
                    function_usage,
                    ctx.range(n.block.span).map(|range| range.start),
                    Some(&n.cond),
                );
            }
            Stmt::If(n) => {
                for (_, b) in &n.branches {
                    collect_block(
                        ctx,
                        b,
                        edits,
                        false,
                        env_start,
                        statement_visible,
                        function_params,
                        function_usage,
                        repeated_scope_start,
                    );
                }
                if let Some(b) = &n.else_block {
                    collect_block(
                        ctx,
                        b,
                        edits,
                        false,
                        env_start,
                        statement_visible,
                        function_params,
                        function_usage,
                        repeated_scope_start,
                    );
                }
            }
            Stmt::NumericFor(n) => collect_block(
                ctx,
                &n.block,
                edits,
                false,
                env_start,
                statement_visible,
                function_params,
                function_usage,
                ctx.range(n.block.span).map(|range| range.start),
            ),
            Stmt::GenericFor(n) => collect_block(
                ctx,
                &n.block,
                edits,
                false,
                env_start,
                statement_visible,
                function_params,
                function_usage,
                ctx.range(n.block.span).map(|range| range.start),
            ),
            Stmt::Function(n) => {
                collect_generated_vararg_recovery(ctx, &n.body, edits);
                let child_env = resolve_env_start(ctx, &n.body.block, env_start.is_some());
                let child_lexical = function_visible_scope(ctx, &n.body, statement_visible);
                let child_params = function_parameter_names(ctx, &n.body);
                let child_usage = build_usage_index(ctx, &n.body.block);
                collect_block(
                    ctx,
                    &n.body.block,
                    edits,
                    true,
                    child_env,
                    &child_lexical,
                    &child_params,
                    &child_usage,
                    None,
                );
            }
            Stmt::LocalFunction(n) => {
                collect_generated_vararg_recovery(ctx, &n.body, edits);
                let child_env = resolve_env_start(ctx, &n.body.block, env_start.is_some());
                let child_lexical = function_visible_scope(ctx, &n.body, statement_visible);
                let child_params = function_parameter_names(ctx, &n.body);
                let child_usage = build_usage_index(ctx, &n.body.block);
                collect_block(
                    ctx,
                    &n.body.block,
                    edits,
                    true,
                    child_env,
                    &child_lexical,
                    &child_params,
                    &child_usage,
                    None,
                );
            }
            Stmt::Local(n) => {
                for e in &n.values {
                    collect_expr_functions(ctx, e, edits, env_start.is_some(), statement_visible)
                }
            }
            Stmt::Assign(n) => {
                for e in &n.values {
                    collect_expr_functions(ctx, e, edits, env_start.is_some(), statement_visible)
                }
            }
            Stmt::Call(e, _) => {
                collect_expr_functions(ctx, e, edits, env_start.is_some(), statement_visible)
            }
            Stmt::Return(n) => {
                for e in &n.values {
                    collect_expr_functions(ctx, e, edits, env_start.is_some(), statement_visible)
                }
            }
            _ => {}
        }
        match stmt {
            Stmt::Local(node) => {
                for binding in &node.names {
                    if let Some(name) = ctx.text(binding.name) {
                        visible_here.insert(name.to_string());
                    }
                }
            }
            Stmt::LocalFunction(node) => {
                if let Some(name) = ctx.text(node.name) {
                    visible_here.insert(name.to_string());
                }
            }
            _ => {}
        }
    }
    // The AST is immutable during a collection round. Reuse the structural usage index;
    // rebuilding the same block index here doubles one of the hottest large-file scans.
    let usage_index = structural_usage;
    collect_low_risk_structural(ctx, block, usage_index, edits, outer_lexical);
    collect_multi_return_structural(ctx, block, usage_index, edits, outer_lexical);
    collect_dependency_safe_assignment_keys(ctx, block, usage_index, edits);
    // Dedicated structural patterns first.
    let mut i = 0usize;
    while i < block.stmts.len() {
        // Proven dead compiler lifetime release: direct local x = nil with no later use.
        if let Some((target, value)) = assignment_single(&block.stmts[i]) {
            if matches!(value, Expr::Nil(_)) {
                if let (Some(name), Some(stmt_range)) =
                    (name_of_expr(ctx, target), ctx.stmt_range(&block.stmts[i]))
                {
                    let same_block = direct_local_declared_before(ctx, block, i, name);
                    let safe = if same_block || (function_root && function_params.contains(name)) {
                        let usage = usage_index.usage_after(name, stmt_range.end);
                        let captured_anywhere =
                            usage_index.by_name.get(name).is_some_and(|items| {
                                items.iter().any(|item| item.kind == OccKind::Capture)
                            });
                        usage.reads.is_empty()
                            && usage.writes == 0
                            && !usage.redeclared
                            && !usage.captured
                            && !captured_anywhere
                    } else {
                        // Ancestor releases are safe in ordinary child blocks, for locals
                        // created inside the current loop iteration, or at a loop tail when
                        // the next iteration directly overwrites the value before any read.
                        !function_root
                            && (ancestor_release_safe(
                                function_usage,
                                name,
                                &stmt_range,
                                repeated_scope_start,
                            ) || loop_tail_release_safe(
                                ctx,
                                block,
                                i,
                                function_usage,
                                name,
                                &stmt_range,
                                repeated_scope_start,
                            ))
                    };
                    if safe {
                        add_edit(
                            ctx,
                            edits,
                            Edit {
                                start: stmt_range.start,
                                end: stmt_range.end,
                                replacement: String::new(),
                                kind: EditKind::DirectNilCleanup,
                            },
                        );
                        i += 1;
                        continue;
                    }
                }
            }
        }

        // Adjacent assignment forwarding: local temp = value; target = temp -> target = value.
        if i + 1 < block.stmts.len() {
            if let Some((binding, init)) = local_single(&block.stmts[i]) {
                let name = ctx.text(binding.name).unwrap_or("");
                if let Some(rhs) = assignment_rhs_read(ctx, &block.stmts[i + 1], name) {
                    if let Some(stmt_range) = ctx.stmt_range(&block.stmts[i]) {
                        let usage = usage_index.usage_after(name, stmt_range.end);
                        if usage.reads.len() == 1
                            && usage.writes == 0
                            && !usage.redeclared
                            && !usage.captured
                            && ctx.range(rhs.span()).is_some_and(|r| r == usage.reads[0])
                        {
                            if let Some(value) = ctx.expr_text(init) {
                                if add_group(
                                    ctx,
                                    edits,
                                    vec![
                                        Edit {
                                            start: stmt_range.start,
                                            end: stmt_range.end,
                                            replacement: String::new(),
                                            kind: EditKind::AssignmentValueInline,
                                        },
                                        Edit {
                                            start: usage.reads[0].start,
                                            end: usage.reads[0].end,
                                            replacement: value.to_string(),
                                            kind: EditKind::AssignmentValueInline,
                                        },
                                    ],
                                ) {
                                    i += 2;
                                    continue;
                                }
                            }
                        }
                    }
                }
            }
        }

        // Adjacent deferred local: local x; x = value -> local x = value.
        if i + 1 < block.stmts.len() {
            if let Some(binding) = local_uninitialized(&block.stmts[i]) {
                if let Some((target, value)) = assignment_single(&block.stmts[i + 1]) {
                    let name = ctx.text(binding.name).unwrap_or("");
                    if name_of_expr(ctx, target) == Some(name)
                        && !expr_contains_name(ctx, value, name)
                    {
                        if let (Some(a), Some(b), Some(v)) = (
                            ctx.stmt_range(&block.stmts[i]),
                            ctx.stmt_range(&block.stmts[i + 1]),
                            ctx.expr_text(value),
                        ) {
                            add_edit(
                                ctx,
                                edits,
                                Edit {
                                    start: a.start,
                                    end: b.end,
                                    replacement: format!("local {name} = {v}"),
                                    kind: EditKind::DeferredLocal,
                                },
                            );
                            i += 2;
                            continue;
                        }
                    }
                }
            }
        }

        // Packed call + native return-all.
        if i + 1 < block.stmts.len() {
            if let Some((binding, init)) = local_single(&block.stmts[i]) {
                let name = ctx.text(binding.name).unwrap_or("");
                if let Some(inner) = table_single_call(init) {
                    let safe_inner =
                        call_parts(inner).is_some_and(|(func, _, _)| match unwrap_parens(func) {
                            Expr::Name(span) => ctx.text(*span).is_some_and(|callee| {
                                direct_local_declared_before(ctx, block, i, callee)
                            }),
                            Expr::Function { body, .. } => {
                                function_returns_only_zero_values(&body.block)
                            }
                            _ => false,
                        });
                    if let Stmt::Return(ret) = &block.stmts[i + 1] {
                        if safe_inner
                            && !direct_local_declared_before(ctx, block, i + 1, "unpack")
                            && ret.values.len() == 1
                            && call_is_unpack_name(ctx, &ret.values[0], name)
                        {
                            if let (Some(a), Some(b), Some(call)) = (
                                ctx.stmt_range(&block.stmts[i]),
                                ctx.stmt_range(&block.stmts[i + 1]),
                                ctx.expr_text(inner),
                            ) {
                                add_edit(
                                    ctx,
                                    edits,
                                    Edit {
                                        start: a.start,
                                        end: b.end,
                                        replacement: format!("return {call}"),
                                        kind: EditKind::PackedReturn,
                                    },
                                );
                                i += 2;
                                continue;
                            }
                        }
                    }
                }
            }
        }

        // Packed multi-return slots: local t={call()}; local a=t[1]; local b=t[2]...
        if let Some((binding, init)) = local_single(&block.stmts[i]) {
            let pack = ctx.text(binding.name).unwrap_or("");
            if let Some(inner) = table_single_call(init) {
                let mut names = Vec::new();
                let mut j = i + 1;
                let mut slot = 1usize;
                while j < block.stmts.len() {
                    let Some((b, v)) = local_single(&block.stmts[j]) else {
                        break;
                    };
                    if table_single_index_of(ctx, v, pack) != Some(slot) {
                        break;
                    }
                    names.push(ctx.text(b.name).unwrap_or("").to_string());
                    slot += 1;
                    j += 1;
                }
                if !names.is_empty() {
                    let mut usage = Usage::default();
                    for s in block.stmts.iter().skip(j) {
                        scan_stmt_usage(ctx, s, pack, &mut usage);
                    }
                    if usage.reads.is_empty()
                        && usage.writes == 0
                        && !usage.captured
                        && !usage.redeclared
                    {
                        if let (Some(a), Some(b), Some(call)) = (
                            ctx.stmt_range(&block.stmts[i]),
                            ctx.stmt_range(&block.stmts[j - 1]),
                            ctx.expr_text(inner),
                        ) {
                            add_edit(
                                ctx,
                                edits,
                                Edit {
                                    start: a.start,
                                    end: b.end,
                                    replacement: format!("local {} = {call}", names.join(", ")),
                                    kind: EditKind::MultiReturnSlots,
                                },
                            );
                            i = j;
                            continue;
                        }
                    }
                }
            }
        }

        // Prometheus namecall recovery. Argument temporaries may be materialized
        // between the method capture and its sole call use, so preserve the gap and
        // replace only the capture statement + call expression.
        if let Some((binding, init)) = local_single(&block.stmts[i]) {
            let method_local = ctx.text(binding.name).unwrap_or("");
            if let Some(method_stmt_range) = ctx.stmt_range(&block.stmts[i]) {
                let method_usage = usage_index.usage_after(method_local, method_stmt_range.end);
                if method_usage.reads.len() == 1
                    && method_usage.writes == 0
                    && !method_usage.redeclared
                    && !method_usage.captured
                {
                    if let Expr::Index { object, key, .. } = init {
                        if let (Some(base), Some(method)) =
                            (name_of_expr(ctx, object), index_key_identifier(ctx, key))
                        {
                            let base_captured =
                                usage_index.by_name.get(base).is_some_and(|items| {
                                    items.iter().any(|item| item.kind == OccKind::Capture)
                                });
                            if !base_captured {
                                {
                                    let read_range = &method_usage.reads[0];
                                    let consumer =
                                        ((i + 1)..block.stmts.len()).find_map(|consumer_index| {
                                            let call =
                                                call_expr_whole(&block.stmts[consumer_index])?;
                                            let (func, _, _) = call_parts(call)?;
                                            (name_of_expr(ctx, func) == Some(method_local)
                                                && ctx
                                                    .range(func.span())
                                                    .is_some_and(|range| range == *read_range))
                                            .then_some((consumer_index, call))
                                        });
                                    if let Some((consumer_index, call)) = consumer {
                                        let consumer_start = ctx
                                            .stmt_range(&block.stmts[consumer_index])
                                            .map(|range| range.start)
                                            .unwrap_or(usize::MAX);
                                        if !source_binding_changes_between(
                                            &usage_index,
                                            base,
                                            method_stmt_range.end,
                                            consumer_start,
                                        ) {
                                            let fused = reconstruct_namecall_with_gap_index_args(
                                                ctx,
                                                block,
                                                &usage_index,
                                                i,
                                                consumer_index,
                                                call,
                                                base,
                                                &method,
                                            );
                                            let fallback = || {
                                                reconstruct_call_without_first(
                                                    ctx, call, base, &method,
                                                )
                                                .map(|call| (call, Vec::new()))
                                            };
                                            if let Some((new_call, removed_gap)) =
                                                fused.or_else(fallback)
                                            {
                                                if let Some(call_range) = ctx.range(call.span()) {
                                                    let mut group =
                                                        Vec::with_capacity(removed_gap.len() + 2);
                                                    group.push(Edit {
                                                        start: method_stmt_range.start,
                                                        end: method_stmt_range.end,
                                                        replacement: String::new(),
                                                        kind: EditKind::Namecall,
                                                    });
                                                    for range in removed_gap {
                                                        group.push(Edit {
                                                            start: range.start,
                                                            end: range.end,
                                                            replacement: String::new(),
                                                            kind: EditKind::Namecall,
                                                        });
                                                    }
                                                    group.push(Edit {
                                                        start: call_range.start,
                                                        end: call_range.end,
                                                        replacement: new_call,
                                                        kind: EditKind::Namecall,
                                                    });
                                                    if add_group(ctx, edits, group) {
                                                        i += 1;
                                                        continue;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        i += 1;
    }
    // Single-use local and cleanup candidates.
    for (index, stmt) in block.stmts.iter().enumerate() {
        let Some((binding, init)) = local_single(stmt) else {
            continue;
        };
        let Some(name) = ctx.text(binding.name) else {
            continue;
        };
        let Some(stmt_range) = ctx.stmt_range(stmt) else {
            continue;
        };
        let usage = usage_index.usage_after(name, stmt_range.end);

        if usage.reads.len() == 1 && usage.writes == 0 && !usage.redeclared && !usage.captured {
            let read = &usage.reads[0];
            if is_safe_inline_constant(ctx, init) {
                let consumer_index = direct_statement_index_containing(ctx, block, index + 1, read)
                    .filter(|candidate| {
                        stmt_has_direct_expression_use(ctx, &block.stmts[*candidate], read)
                    });
                let Some(consumer_index) = consumer_index else {
                    // Generic single-use inlining is same lexical block only. Child
                    // blocks are handled only by dedicated structural proofs.
                    continue;
                };
                if is_repeated_evaluation_statement(&block.stmts[consumer_index]) {
                    continue;
                }
                if let Some(value) = safe_inline_constant_text(ctx, init) {
                    if add_group(
                        ctx,
                        edits,
                        vec![
                            Edit {
                                start: stmt_range.start,
                                end: stmt_range.end,
                                replacement: String::new(),
                                kind: EditKind::LiteralInline,
                            },
                            Edit {
                                start: read.start,
                                end: read.end,
                                replacement: value,
                                kind: EditKind::LiteralInline,
                            },
                        ],
                    ) {
                        continue;
                    }
                }
            }
            if let Expr::Name(source_span) = init {
                let source_name = ctx.text(*source_span).unwrap_or("");
                let consumer_index = direct_statement_index_containing(ctx, block, index + 1, read)
                    .filter(|candidate| {
                        stmt_has_direct_expression_use(ctx, &block.stmts[*candidate], read)
                    });
                if let Some(consumer_index) = consumer_index {
                    let source_is_lexical = outer_lexical.contains(source_name)
                        || direct_local_declared_before(ctx, block, index, source_name);
                    if source_is_lexical {
                        if !is_repeated_evaluation_statement(&block.stmts[consumer_index]) {
                            let consumer_start = ctx
                                .stmt_range(&block.stmts[consumer_index])
                                .map(|range| range.start)
                                .unwrap_or(usize::MAX);
                            if !source_binding_changes_between(
                                &usage_index,
                                source_name,
                                stmt_range.end,
                                consumer_start,
                            ) {
                                if add_group(
                                    ctx,
                                    edits,
                                    vec![
                                        Edit {
                                            start: stmt_range.start,
                                            end: stmt_range.end,
                                            replacement: String::new(),
                                            kind: EditKind::LocalAlias,
                                        },
                                        Edit {
                                            start: read.start,
                                            end: read.end,
                                            replacement: source_name.to_string(),
                                            kind: EditKind::LocalAlias,
                                        },
                                    ],
                                ) {
                                    continue;
                                }
                            }
                        }
                    } else {
                        let call_base_use =
                            stmt_has_call_base_use(ctx, &block.stmts[consumer_index], read);
                        let immediate_generic_iterator_use = consumer_index == index + 1
                            && matches!(&block.stmts[consumer_index], Stmt::GenericFor(node)
                                if node.exprs.iter().any(|expr| ctx.range(expr.span()).is_some_and(|range| range == *read)));
                        let immediate_generic_iterator_call_base = consumer_index == index + 1
                            && matches!(&block.stmts[consumer_index], Stmt::GenericFor(node)
                                if node.exprs.iter().any(|expr| expr_has_call_base_use(ctx, expr, read)));
                        let call_safe = call_base_use
                            && (!is_repeated_evaluation_statement(&block.stmts[consumer_index])
                                || immediate_generic_iterator_call_base)
                            && barrier_free(block, index, consumer_index);
                        if call_safe || immediate_generic_iterator_use {
                            if add_group(
                                ctx,
                                edits,
                                vec![
                                    Edit {
                                        start: stmt_range.start,
                                        end: stmt_range.end,
                                        replacement: String::new(),
                                        kind: EditKind::GlobalAlias,
                                    },
                                    Edit {
                                        start: read.start,
                                        end: read.end,
                                        replacement: source_name.to_string(),
                                        kind: EditKind::GlobalAlias,
                                    },
                                ],
                            ) {
                                continue;
                            }
                        }
                    }
                }
            }

            // Adjacent producer into one leading call-argument use. Prometheus
            // snapshots the outer callee before evaluating arguments, so moving the
            // producer is valid only with a stable lexical callee and stable earlier
            // argument snapshots. Conditional right arms remain blocked by
            // expr_leading_use.
            if (is_scalar_temp_expr(init) || matches!(init, Expr::Call { .. } | Expr::Index { .. }))
                && index + 1 < block.stmts.len()
                && !matches!(&block.stmts[index + 1], Stmt::Return(_))
            {
                if let Some(call) = call_expr_whole(&block.stmts[index + 1])
                    .or_else(|| direct_if_condition_call(&block.stmts[index + 1]))
                {
                    if let Some((func, method, args_node)) = call_parts(call) {
                        let allow_method_field_snapshot = method.is_some()
                            && matches!(init, Expr::Index { key: IndexKey::Field(_), .. });
                        if method.is_none() || allow_method_field_snapshot {
                            if let (Some(base), Some(args)) =
                                (name_of_expr(ctx, func), paren_args(args_node))
                            {
                                if name_is_immediate_stable_lexical(
                                    ctx,
                                    block,
                                    index,
                                    base,
                                    outer_lexical,
                                ) {
                                    let mut arg_index = None;
                                    for (candidate, arg) in args.iter().enumerate() {
                                        if !expr_span_contains_range(ctx, arg, read) {
                                            continue;
                                        }
                                        if arg_index.is_some() {
                                            arg_index = None;
                                            break;
                                        }
                                        arg_index = Some(candidate);
                                    }
                                    if let Some(arg_index) = arg_index {
                                        let argument = &args[arg_index];
                                        let prefix_stable = args[..arg_index].iter().all(|arg| {
                                            stable_prefix_expr_with_outer(
                                                ctx,
                                                arg,
                                                block,
                                                index,
                                                outer_lexical,
                                            )
                                        });
                                        if prefix_stable
                                            && (expr_leading_use(ctx, argument, read)
                                                || stable_index_key_use(
                                                    ctx,
                                                    argument,
                                                    read,
                                                    block,
                                                    index,
                                                    outer_lexical,
                                                ))
                                        {
                                            if let Some(value) = ctx.expr_text(init) {
                                                let replacement =
                                                    if matches!(init, Expr::Call { .. }) {
                                                        format!("({value})")
                                                    } else {
                                                        value.to_string()
                                                    };
                                                if add_group(
                                                    ctx,
                                                    edits,
                                                    vec![
                                                        Edit {
                                                            start: stmt_range.start,
                                                            end: stmt_range.end,
                                                            replacement: String::new(),
                                                            kind: EditKind::CallArgumentInline,
                                                        },
                                                        Edit {
                                                            start: read.start,
                                                            end: read.end,
                                                            replacement,
                                                            kind: EditKind::CallArgumentInline,
                                                        },
                                                    ],
                                                ) {
                                                    continue;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Small sole-use anonymous functions may move to a later same-block leading use
            // only when every runtime identifier is lexical and the gap cannot shadow it.
            if let Expr::Function { body, .. } = init {
                let consumer_index = direct_statement_index_containing(ctx, block, index + 1, read);
                if let Some(consumer_index) = consumer_index {
                    let source_lines_ok = ctx.range(init.span()).is_some_and(|range| {
                        let mut bytes = ctx.src.as_bytes()[range.clone()].to_vec();
                        for &(comment_start, comment_end) in ctx.comments {
                            let from = (comment_start as usize).max(range.start);
                            let to = (comment_end as usize).min(range.end);
                            if from >= to {
                                continue;
                            }
                            for byte in &mut bytes[(from - range.start)..(to - range.start)] {
                                if *byte != b'\n' && *byte != b'\r' {
                                    *byte = b' ';
                                }
                            }
                        }
                        String::from_utf8_lossy(&bytes)
                            .lines()
                            .filter(|line| !line.trim().is_empty())
                            .count()
                            <= 100
                    });
                    let mut outer_locals = direct_local_names_before(ctx, block, index);
                    outer_locals.extend(outer_lexical.iter().cloned());
                    if source_lines_ok
                        && stmt_has_direct_expression_use(ctx, &block.stmts[consumer_index], read)
                        && !is_repeated_evaluation_statement(&block.stmts[consumer_index])
                        && (consumer_index == index + 1
                            || function_move_is_lexical(ctx, body, outer_locals))
                        && gap_is_safe_for_function_move(
                            ctx,
                            block,
                            index + 1,
                            consumer_index,
                            body,
                        )
                    {
                        if let Some(value) = ctx.expr_text(init) {
                            if add_group(
                                ctx,
                                edits,
                                vec![
                                    Edit {
                                        start: stmt_range.start,
                                        end: stmt_range.end,
                                        replacement: String::new(),
                                        kind: EditKind::FunctionInline,
                                    },
                                    Edit {
                                        start: read.start,
                                        end: read.end,
                                        replacement: {
                                            let direct_argument = stmt_has_direct_call_argument_use(
                                                ctx,
                                                &block.stmts[consumer_index],
                                                read,
                                            );
                                            let mut replacement = if direct_argument {
                                                value.to_string()
                                            } else {
                                                format!("({value})")
                                            };
                                            if matches!(
                                                &block.stmts[consumer_index],
                                                Stmt::Call(_, _)
                                            ) && ctx
                                                .stmt_range(&block.stmts[consumer_index])
                                                .is_some_and(|r| r.start == read.start)
                                            {
                                                replacement.insert(0, ';');
                                            }
                                            replacement
                                        },
                                        kind: EditKind::FunctionInline,
                                    },
                                ],
                            ) {
                                continue;
                            }
                        }
                    }
                }
            }

            // Adjacent leading use safely preserves evaluation order. Exact direct
            // condition/call-base uses also admit call/index producers: the producer
            // still executes once at the same statement boundary and no other effect is crossed.
            let next_stmt = block.stmts.get(index + 1);
            let adjacent_if_effect_temp = matches!(init, Expr::Call { .. } | Expr::Index { .. })
                && matches!(next_stmt, Some(Stmt::If(node)) if node.branches.first().is_some_and(|(cond, _)| {
                    matches!(unwrap_parens(cond), Expr::Binary { .. }) && expr_leading_use(ctx, cond, read)
                }));
            let adjacent_if_value_temp = matches!(init, Expr::Call { .. } | Expr::Index { .. })
                // A local+if immediately before repeat may be the compiler's discarded
                // repeat-condition precheck. Keep that snapshot unless the dedicated
                // exact repeat matcher proves it removable.
                && !matches!(block.stmts.get(index + 2), Some(Stmt::Repeat(_)))
                && next_stmt
                    .and_then(|stmt| direct_if_condition_name_span(ctx, stmt, name))
                    .and_then(|span| ctx.range(span))
                    .is_some_and(|range| range == *read);
            let adjacent_call_base_temp = matches!(init, Expr::Call { .. } | Expr::Index { .. })
                && next_stmt
                    .and_then(|stmt| direct_call_base_name_span(ctx, stmt, name))
                    .and_then(|span| ctx.range(span))
                    .is_some_and(|range| range == *read);
            let adjacent_assignment_target_base_temp = matches!(init, Expr::Call { .. })
                && next_stmt
                    .and_then(|stmt| direct_assignment_target_base_name_span(ctx, stmt, name))
                    .and_then(|span| ctx.range(span))
                    .is_some_and(|range| range == *read);
            if !matches!(init, Expr::Name(_))
                && (is_scalar_temp_expr(init)
                    || adjacent_if_effect_temp
                    || adjacent_if_value_temp
                    || adjacent_call_base_temp
                    || adjacent_assignment_target_base_temp)
                && index + 1 < block.stmts.len()
                && stmt_contains_range(ctx, &block.stmts[index + 1], read)
                && (stmt_leading_use(ctx, &block.stmts[index + 1], read)
                    || adjacent_if_value_temp
                    || adjacent_call_base_temp
                    || adjacent_assignment_target_base_temp)
            {
                if let Some(value) = ctx.expr_text(init) {
                    let mut replacement =
                        if adjacent_assignment_target_base_temp {
                            value.to_string()
                        } else if adjacent_call_base_temp && matches!(init, Expr::Call { .. }) {
                            format!("({value})")
                        } else if adjacent_if_effect_temp
                            || adjacent_if_value_temp
                            || matches!(init, Expr::Name(_) | Expr::Index { .. })
                        {
                            value.to_string()
                        } else {
                            format!("({value})")
                        };
                    if (matches!(&block.stmts[index + 1], Stmt::Call(_, _))
                        && ctx
                            .stmt_range(&block.stmts[index + 1])
                            .is_some_and(|next| next.start == read.start)
                        && replacement.starts_with('('))
                        || (adjacent_assignment_target_base_temp && replacement.starts_with('('))
                    {
                        replacement.insert(0, ';');
                    }
                    if add_group(
                        ctx,
                        edits,
                        vec![
                            Edit {
                                start: stmt_range.start,
                                end: stmt_range.end,
                                replacement: String::new(),
                                kind: EditKind::AdjacentInline,
                            },
                            Edit {
                                start: read.start,
                                end: read.end,
                                replacement,
                                kind: EditKind::AdjacentInline,
                            },
                        ],
                    ) {
                        continue;
                    }
                }
            }
        }

        if usage.reads.is_empty() && usage.writes == 0 && !usage.captured && !usage.redeclared {
            let dead_local_name = match init {
                Expr::Name(span) => ctx
                    .text(*span)
                    .is_some_and(|source| direct_local_declared_before(ctx, block, index, source)),
                _ => false,
            };
            let generated_env = name == "_env" && direct_call_named_no_args(ctx, init, "getfenv");
            if is_no_effect_expr(init) || dead_local_name || generated_env {
                add_edit(
                    ctx,
                    edits,
                    Edit {
                        start: stmt_range.start,
                        end: stmt_range.end,
                        replacement: String::new(),
                        kind: EditKind::DeadLocal,
                    },
                );
                continue;
            }
            if let Some(call_expr) = unwrapped_call(init) {
                if let Some(call) = ctx.expr_text(call_expr) {
                    let replacement = if call.trim_start().starts_with('(') {
                        format!(";{call}")
                    } else {
                        call.to_string()
                    };
                    add_edit(
                        ctx,
                        edits,
                        Edit {
                            start: stmt_range.start,
                            end: stmt_range.end,
                            replacement,
                            kind: EditKind::DeadCallResult,
                        },
                    );
                    continue;
                }
            }
        }
    }
    // Unused uninitialized locals carry no value/effect and can be removed.
    for stmt in &block.stmts {
        let Some(binding) = local_uninitialized(stmt) else {
            continue;
        };
        let Some(name) = ctx.text(binding.name) else {
            continue;
        };
        let Some(stmt_range) = ctx.stmt_range(stmt) else {
            continue;
        };
        let usage = usage_index.usage_after(name, stmt_range.end);
        if usage.reads.is_empty() && usage.writes == 0 && !usage.captured && !usage.redeclared {
            add_edit(
                ctx,
                edits,
                Edit {
                    start: stmt_range.start,
                    end: stmt_range.end,
                    replacement: String::new(),
                    kind: EditKind::DeadLocal,
                },
            );
        }
    }

    // A bare return at the actual function/chunk tail is redundant. Nested control-flow
    // block returns are never touched here.
    if function_root {
        if let Some(Stmt::Return(ret)) = block.stmts.last() {
            if ret.values.is_empty() {
                if let Some(range) = ctx.stmt_range(block.stmts.last().unwrap()) {
                    add_edit(
                        ctx,
                        edits,
                        Edit {
                            start: range.start,
                            end: range.end,
                            replacement: String::new(),
                            kind: EditKind::BareReturn,
                        },
                    );
                }
            }
        }
    }
    // Fold only a proven getfenv-backed environment binding. Child blocks share the
    // current function context; nested functions resolve their own/inherited context.
    if let Some(start) = env_start {
        for stmt in &block.stmts {
            if ctx
                .stmt_range(stmt)
                .is_some_and(|range| range.start >= start)
            {
                collect_env_folds_stmt(ctx, stmt, edits);
            }
        }
    }

    for stmt in &block.stmts {
        collect_static_field_indexes_stmt(ctx, stmt, edits);
    }
}

fn collect_expr_functions(
    ctx: &Ctx<'_>,
    expr: &Expr,
    edits: &mut Vec<Edit>,
    inherited_env: bool,
    outer_lexical: &HashSet<String>,
) {
    match expr {
        Expr::Function { body, .. } => {
            collect_generated_vararg_recovery(ctx, body, edits);
            let child_env = resolve_env_start(ctx, &body.block, inherited_env);
            let child_lexical = function_visible_scope(ctx, body, outer_lexical);
            let child_params = function_parameter_names(ctx, body);
            let child_usage = build_usage_index(ctx, &body.block);
            collect_block(
                ctx,
                &body.block,
                edits,
                true,
                child_env,
                &child_lexical,
                &child_params,
                &child_usage,
                None,
            );
        }
        Expr::Table { fields, .. } => {
            for f in fields {
                match f {
                    TableField::Positional(v) => {
                        collect_expr_functions(ctx, v, edits, inherited_env, outer_lexical)
                    }
                    TableField::Named { value, .. } => {
                        collect_expr_functions(ctx, value, edits, inherited_env, outer_lexical)
                    }
                    TableField::Computed { key, value } => {
                        collect_expr_functions(ctx, key, edits, inherited_env, outer_lexical);
                        collect_expr_functions(ctx, value, edits, inherited_env, outer_lexical);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_expr_functions(ctx, lhs, edits, inherited_env, outer_lexical);
            collect_expr_functions(ctx, rhs, edits, inherited_env, outer_lexical);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            collect_expr_functions(ctx, operand, edits, inherited_env, outer_lexical)
        }
        Expr::Index { object, key, .. } => {
            collect_expr_functions(ctx, object, edits, inherited_env, outer_lexical);
            if let IndexKey::Computed(k) = key {
                collect_expr_functions(ctx, k, edits, inherited_env, outer_lexical);
            }
        }
        Expr::Call { func, args, .. } => {
            collect_expr_functions(ctx, func, edits, inherited_env, outer_lexical);
            match args {
                CallArgs::Paren(v) => {
                    for e in v {
                        collect_expr_functions(ctx, e, edits, inherited_env, outer_lexical)
                    }
                }
                CallArgs::Table(e) => {
                    collect_expr_functions(ctx, e, edits, inherited_env, outer_lexical)
                }
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                collect_expr_functions(ctx, a, edits, inherited_env, outer_lexical);
                collect_expr_functions(ctx, b, edits, inherited_env, outer_lexical);
            }
            collect_expr_functions(ctx, else_value, edits, inherited_env, outer_lexical);
        }
        _ => {}
    }
}

fn apply_edits(source: &str, mut edits: Vec<Edit>, stats: &mut Stats) -> Result<String> {
    // Count before moving strings out.
    for e in &edits {
        match e.kind {
            EditKind::LiteralInline => stats.literal_inlines += 1,
            EditKind::LocalAlias => stats.local_alias_inlines += 1,
            EditKind::GlobalAlias => stats.global_alias_inlines += 1,
            EditKind::AdjacentInline => stats.adjacent_inlines += 1,
            EditKind::EnvFold => stats.env_folds += 1,
            EditKind::DeferredLocal => stats.deferred_locals += 1,
            EditKind::Namecall => stats.namecalls += 1,
            EditKind::PackedReturn => stats.packed_returns += 1,
            EditKind::MultiReturnSlots => stats.multi_return_slots += 1,
            EditKind::DeadLocal => stats.dead_locals += 1,
            EditKind::DeadCallResult => stats.dead_call_results += 1,
            EditKind::DirectNilCleanup => stats.direct_nil_cleanups += 1,
            EditKind::AssignmentValueInline => stats.assignment_value_inlines += 1,
            EditKind::CallArgumentInline => stats.call_argument_inlines += 1,
            EditKind::FunctionInline => stats.function_inlines += 1,
            EditKind::BareReturn => stats.bare_returns += 1,
            EditKind::CopyChain => stats.copy_chains += 1,
            EditKind::IndexBaseAlias => stats.index_base_aliases += 1,
            EditKind::IndexKeyInline => stats.index_key_inlines += 1,
            EditKind::AssignmentKeyInline => stats.assignment_key_inlines += 1,
            EditKind::DependencyAssignmentKeyInline => stats.dependency_assignment_key_inlines += 1,
            EditKind::TableConstructorKeyInline => stats.table_constructor_key_inlines += 1,
            EditKind::TableConstructorValueInline => stats.table_constructor_value_inlines += 1,
            EditKind::TableCallArgumentInline => stats.table_call_argument_inlines += 1,
            EditKind::RepeatTailInline => stats.repeat_tail_inlines += 1,
            EditKind::MultiReturnCollapse => stats.multi_return_table_collapses += 1,
            EditKind::MultiReturnForward => stats.multi_return_forwarders += 1,
            EditKind::CompilerVarargForward => stats.compiler_vararg_forwarders += 1,
            EditKind::GeneratedVarargCapture => stats.generated_vararg_captures += 1,
            EditKind::GeneratedVarargRead => stats.generated_vararg_reads += 1,
            EditKind::PackedReturnForward => stats.packed_return_forwarders += 1,
            EditKind::ReturnedCallBaseInline => stats.returned_call_base_inlines += 1,
            EditKind::MultiReturnSelfAssignment => stats.multi_return_self_assignments += 1,
            EditKind::MultiReturnPlaceholder => stats.multi_return_placeholders += 1,
            EditKind::MultiReturnUnusedTarget => stats.multi_return_unused_targets += 1,
            EditKind::GenericForTuple => stats.generic_for_tuple_inlines += 1,
            EditKind::NumericForConstant => stats.numeric_for_constant_inlines += 1,
            EditKind::NumericForDefaultStep => stats.numeric_for_default_steps += 1,
            EditKind::ShortCircuit => stats.short_circuit_ladders += 1,
            EditKind::ValueShortCircuit => stats.value_short_circuit_ladders += 1,
            EditKind::WhileCondition => stats.while_conditions += 1,
            EditKind::RepeatCondition => stats.repeat_conditions += 1,
            EditKind::RepeatPrecheck => stats.repeat_prechecks += 1,
            EditKind::StringDecode => stats.string_decodes += 1,
            EditKind::StringDecodeCleanup => {}
            EditKind::StaticFieldIndex => stats.static_field_indexes += 1,
        }
    }
    // Two edits form one inline logical transform, but raw edit count is useful performance data.
    stats.edits += edits.len();
    edits.sort_by_key(|e| e.start);
    for w in edits.windows(2) {
        if w[0].end > w[1].start {
            return Err(anyhow!(
                "overlapping Rust optimizer edits {}..{} and {}..{}",
                w[0].start,
                w[0].end,
                w[1].start,
                w[1].end
            ));
        }
    }
    // Build the rewritten source once. Repeated String::replace_range on a multi-MB
    // file shifts the remaining bytes for every edit and becomes O(file_size * edits).
    let replacement_bytes: usize = edits.iter().map(|e| e.replacement.len()).sum();
    let removed_bytes: usize = edits.iter().map(|e| e.end - e.start).sum();
    let mut out =
        String::with_capacity(source.len() + replacement_bytes.saturating_sub(removed_bytes));
    let mut cursor = 0usize;
    for e in edits {
        out.push_str(&source[cursor..e.start]);
        out.push_str(&e.replacement);
        cursor = e.end;
    }
    out.push_str(&source[cursor..]);
    Ok(out)
}

pub fn optimize(source: &str, max_rounds: usize) -> Result<(String, Stats)> {
    let mut current = source.to_string();
    let mut stats = Stats::default();
    for round in 0..max_rounds {
        stats.parses += 1;
        let parsed = eclipse_luau::parse_one(&current).map_err(|e| {
            let bytes = current.as_bytes();
            let start = e.offset.saturating_sub(160);
            let end = (e.offset + 160).min(bytes.len());
            let snippet = String::from_utf8_lossy(&bytes[start..end]);
            anyhow!(
                "parse failed in Rust optimizer round {} at {}: {}\n--- nearby ---\n{}",
                round + 1,
                e.offset,
                e.message,
                snippet
            )
        })?;
        let ctx = Ctx {
            src: &current,
            toks: &parsed.lexed.toks,
            comments: &parsed.lexed.comments,
            nested_writer_cache: RefCell::new(HashMap::new()),
            direct_decl_cache: RefCell::new(HashMap::new()),
            edit_intervals: RefCell::new(BTreeMap::new()),
        };
        let mut edits = Vec::new();
        // Once the private Prometheus string layer is structurally proven, expose
        // decoded indexes before ordinary source recovery can consume ordering proof
        // such as a method capture that precedes compiler-generated argument temps.
        // If the decoder is not proven yet, normal cleanup continues until a later
        // round exposes the layer.
        let decoded = string_decoder::collect_decoded_string_edits(
            &current,
            &parsed.chunk.block,
            &parsed.lexed.toks,
        );
        if !decoded.is_empty() {
            for decoded_edit in decoded {
                add_edit(
                    &ctx,
                    &mut edits,
                    Edit {
                        start: decoded_edit.start,
                        end: decoded_edit.end,
                        replacement: decoded_edit.replacement,
                        kind: if decoded_edit.counts_decode {
                            EditKind::StringDecode
                        } else {
                            EditKind::StringDecodeCleanup
                        },
                    },
                );
            }
        } else {
            let root_env = resolve_env_start(&ctx, &parsed.chunk.block, false);
            let root_lexical = HashSet::new();
            let root_params = HashSet::new();
            let root_usage = build_usage_index(&ctx, &parsed.chunk.block);
            collect_block(
                &ctx,
                &parsed.chunk.block,
                &mut edits,
                true,
                root_env,
                &root_lexical,
                &root_params,
                &root_usage,
                None,
            );
        }
        if edits.is_empty() {
            stats.rounds = round;
            return Ok((current, stats));
        }
        current = apply_edits(&current, edits, &mut stats)?;
        stats.rounds = round + 1;
    }
    Err(anyhow!(
        "Rust optimizer did not reach fixed point after {max_rounds} rounds"
    ))
}
