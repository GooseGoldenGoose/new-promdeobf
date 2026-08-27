fn function_returns_only_zero_values(block: &Block) -> bool {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Return(ret) if !ret.values.is_empty() => return false,
            Stmt::Do(n) if !function_returns_only_zero_values(&n.block) => return false,
            Stmt::While(n) if !function_returns_only_zero_values(&n.block) => return false,
            Stmt::Repeat(n) if !function_returns_only_zero_values(&n.block) => return false,
            Stmt::If(n) => {
                if n.branches
                    .iter()
                    .any(|(_, b)| !function_returns_only_zero_values(b))
                {
                    return false;
                }
                if n.else_block
                    .as_ref()
                    .is_some_and(|b| !function_returns_only_zero_values(b))
                {
                    return false;
                }
            }
            Stmt::NumericFor(n) if !function_returns_only_zero_values(&n.block) => return false,
            Stmt::GenericFor(n) if !function_returns_only_zero_values(&n.block) => return false,
            // Nested functions have independent returns and do not affect the IIFE.
            Stmt::Function(_) | Stmt::LocalFunction(_) => {}
            _ => {}
        }
    }
    true
}

fn global_unpack_call_for_name<'a>(
    ctx: &Ctx<'_>,
    expr: &'a Expr,
    pack_name: &str,
    block: &Block,
    before_index: usize,
    outer_lexical: &HashSet<String>,
) -> bool {
    let Some((func, method, args)) = call_parts(expr) else {
        return false;
    };
    if method.is_some() || name_of_expr(ctx, func) != Some("unpack") {
        return false;
    }
    if outer_lexical.contains("unpack")
        || direct_local_declared_before(ctx, block, before_index, "unpack")
    {
        return false;
    }
    let Some(args) = paren_args(args) else {
        return false;
    };
    args.len() == 1 && name_of_expr(ctx, &args[0]) == Some(pack_name)
}

fn stable_prefix_expr(
    ctx: &Ctx<'_>,
    expr: &Expr,
    block: &Block,
    usage_index: &UsageIndex,
    before_index: usize,
    outer_lexical: &HashSet<String>,
) -> bool {
    match expr {
        Expr::Nil(_) | Expr::True(_) | Expr::False(_) | Expr::Number(_) | Expr::String(_) => true,
        Expr::Name(span) => ctx.text(*span).is_some_and(|name| {
            name_is_stable_lexical(ctx, block, usage_index, before_index, name, outer_lexical)
        }),
        _ => false,
    }
}

fn leading_unpack_outer_call<'a>(
    ctx: &Ctx<'_>,
    expr: &'a Expr,
    pack_name: &str,
    block: &Block,
    usage_index: &UsageIndex,
    before_index: usize,
    outer_lexical: &HashSet<String>,
) -> Option<(&'a Expr, &'a Expr)> {
    match expr {
        Expr::Call { func, args, .. } => {
            if let CallArgs::Paren(values) = args {
                if let Some(last) = values.last() {
                    if global_unpack_call_for_name(ctx, last, pack_name, block, before_index, outer_lexical)
                        && values[..values.len().saturating_sub(1)].iter().all(|arg| {
                            stable_prefix_expr(
                                ctx,
                                arg,
                                block,
                                usage_index,
                                before_index,
                                outer_lexical,
                            )
                        })
                    {
                        let outer_name = name_of_expr(ctx, func)?;
                        if name_is_stable_lexical(
                            ctx,
                            block,
                            usage_index,
                            before_index,
                            outer_name,
                            outer_lexical,
                        ) {
                            return Some((expr, last));
                        }
                    }
                }
            }
            // The call base is evaluated first; recurse only there. Re-entering an
            // arbitrary argument would move the producer past earlier argument effects.
            leading_unpack_outer_call(
                ctx,
                func,
                pack_name,
                block,
                usage_index,
                before_index,
                outer_lexical,
            )
        }
        Expr::Paren { inner, .. }
        | Expr::Unary { operand: inner, .. }
        | Expr::TypeAssert { expr: inner, .. } => leading_unpack_outer_call(
            ctx,
            inner,
            pack_name,
            block,
            usage_index,
            before_index,
            outer_lexical,
        ),
        Expr::Binary { lhs, .. } => leading_unpack_outer_call(
            ctx,
            lhs,
            pack_name,
            block,
            usage_index,
            before_index,
            outer_lexical,
        ),
        Expr::Index { object, .. } => leading_unpack_outer_call(
            ctx,
            object,
            pack_name,
            block,
            usage_index,
            before_index,
            outer_lexical,
        ),
        _ => None,
    }
}

fn leading_expr_for_pack_stmt<'a>(stmt: &'a Stmt) -> Option<&'a Expr> {
    match stmt {
        Stmt::Call(expr, _) => Some(expr),
        Stmt::Local(n) if n.values.len() == 1 => {
            if let Some(call) = table_single_call(&n.values[0]) {
                Some(call)
            } else {
                Some(&n.values[0])
            }
        }
        Stmt::Assign(n) if n.values.len() == 1 => Some(&n.values[0]),
        Stmt::Return(n) if n.values.len() == 1 => Some(&n.values[0]),
        Stmt::If(n) => n.branches.first().map(|(cond, _)| cond),
        // Generic-for iterator expressions execute once, left-to-right, before the
        // loop variables enter scope. The first iterator expression is therefore a
        // valid leading consumer for compiler packed-return forwarding.
        Stmt::GenericFor(n) => n.exprs.first(),
        _ => None,
    }
}

fn source_replace_inner(
    ctx: &Ctx<'_>,
    outer: &Expr,
    inner: &Expr,
    replacement: &str,
) -> Option<String> {
    let outer_range = ctx.range(outer.span())?;
    let inner_range = ctx.range(inner.span())?;
    if inner_range.start < outer_range.start || inner_range.end > outer_range.end {
        return None;
    }
    let mut text = ctx.src.get(outer_range.clone())?.to_string();
    let rel_start = inner_range.start - outer_range.start;
    let rel_end = inner_range.end - outer_range.start;
    text.replace_range(rel_start..rel_end, replacement);
    Some(text)
}

fn collect_multi_return_structural(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    edits: &mut Vec<Edit>,
    outer_lexical: &HashSet<String>,
) {
    // Sparse/out-of-order packed result extraction.
    for pack_index in 0..block.stmts.len() {
        let Some((pack_binding, pack_init)) = local_single(&block.stmts[pack_index]) else {
            continue;
        };
        let Some(inner_call) = table_single_call(pack_init) else {
            continue;
        };
        let pack_name = ctx.text(pack_binding.name).unwrap_or("");
        let Some(pack_range) = ctx.stmt_range(&block.stmts[pack_index]) else {
            continue;
        };
        let usage = usage_index.usage_after(pack_name, pack_range.end);
        if usage.reads.is_empty() || usage.writes != 0 || usage.redeclared || usage.captured {
            continue;
        }
        let mut by_slot: HashMap<usize, (usize, String, Range<usize>)> = HashMap::new();
        let mut read_ranges = Vec::new();
        let mut valid = true;
        for j in (pack_index + 1)..block.stmts.len() {
            let Some((binding, init)) = local_single(&block.stmts[j]) else {
                continue;
            };
            let Some(slot) = table_single_index_of(ctx, init, pack_name) else {
                continue;
            };
            let Some(index_range) = (match init {
                Expr::Index { object, .. } => ctx.range(object.span()),
                _ => None,
            }) else {
                valid = false;
                break;
            };
            read_ranges.push(index_range);
            if by_slot.contains_key(&slot) {
                valid = false;
                break;
            }
            let target_name = ctx.text(binding.name).unwrap_or("").to_string();
            // Moving the declaration earlier must not shadow a prior observation.
            if block.stmts[(pack_index + 1)..j]
                .iter()
                .any(|stmt| stmt_contains_name(ctx, stmt, &target_name))
            {
                valid = false;
                break;
            }
            let Some(stmt_range) = ctx.stmt_range(&block.stmts[j]) else {
                valid = false;
                break;
            };
            by_slot.insert(slot, (j, target_name, stmt_range));
        }
        if !valid || by_slot.is_empty() || by_slot.len() != usage.reads.len() {
            continue;
        }
        if !usage
            .reads
            .iter()
            .all(|r| read_ranges.iter().any(|x| x == r))
        {
            continue;
        }
        let mut target_seen = HashSet::new();
        if by_slot
            .values()
            .any(|(_, name, _)| !target_seen.insert(name.clone()))
        {
            continue;
        }
        let max_slot = *by_slot.keys().max().unwrap();
        let mut names = Vec::new();
        let mut placeholder = 1usize;
        for slot in 1..=max_slot {
            if let Some((_, name, _)) = by_slot.get(&slot) {
                names.push(name.clone());
            } else {
                let generated = unique_unused_return_name(ctx.src, placeholder);
                placeholder += 1;
                names.push(generated);
            }
        }
        let Some(call_text) = ctx.expr_text(inner_call) else {
            continue;
        };
        let mut group = vec![Edit {
            start: pack_range.start,
            end: pack_range.end,
            replacement: format!("local {} = {call_text}", names.join(", ")),
            kind: EditKind::MultiReturnCollapse,
        }];
        for (_, _, range) in by_slot.values() {
            group.push(Edit {
                start: range.start,
                end: range.end,
                replacement: String::new(),
                kind: EditKind::MultiReturnCollapse,
            });
        }
        add_group(ctx, edits, group);
    }

    // Rename dead positions of already-native multi-return assignments to placeholders.
    for stmt in &block.stmts {
        let Stmt::Local(local) = stmt else {
            continue;
        };
        if local.names.len() < 2
            || local.values.len() != 1
            || !matches!(local.values[0], Expr::Call { .. })
        {
            continue;
        }
        let Some(stmt_range) = ctx.stmt_range(stmt) else {
            continue;
        };
        let mut ordinal = 1usize;
        let mut group = Vec::new();
        for binding in &local.names {
            let Some(name) = ctx.text(binding.name) else {
                continue;
            };
            if name.starts_with("__beta_unused_return_") {
                continue;
            }
            let usage = usage_index.usage_after(name, stmt_range.end);
            if usage.reads.is_empty() && usage.writes == 0 && !usage.redeclared && !usage.captured {
                let Some(range) = ctx.range(binding.name) else {
                    continue;
                };
                group.push(Edit {
                    start: range.start,
                    end: range.end,
                    replacement: unique_unused_return_name(ctx.src, ordinal),
                    kind: EditKind::MultiReturnUnusedTarget,
                });
                ordinal += 1;
            }
        }
        add_group(ctx, edits, group);
    }

    // Generic adjacent packed-unpack forwarding and self-assignment recovery.
    for pack_index in 0..block.stmts.len().saturating_sub(1) {
        let Some((pack_binding, pack_init)) = local_single(&block.stmts[pack_index]) else {
            continue;
        };
        let Some(inner_call) = table_single_call(pack_init) else {
            continue;
        };
        let pack_name = ctx.text(pack_binding.name).unwrap_or("");
        let Some(pack_stmt_range) = ctx.stmt_range(&block.stmts[pack_index]) else {
            continue;
        };
        let usage = usage_index.usage_after(pack_name, pack_stmt_range.end);

        // t = outer(unpack(t)) where the pack initializer becomes outer(inner()).
        if let Stmt::Assign(assign) = &block.stmts[pack_index + 1] {
            if assign.targets.len() == 1
                && assign.values.len() == 1
                && name_of_expr(ctx, &assign.targets[0]) == Some(pack_name)
            {
                if let Expr::Call {
                    func,
                    args: CallArgs::Paren(args),
                    ..
                } = &assign.values[0]
                {
                    if args.len() == 1
                        && global_unpack_call_for_name(
                            ctx,
                            &args[0],
                            pack_name,
                            block,
                            pack_index + 1,
                            outer_lexical,
                        )
                    {
                        if let Some(outer_name) = name_of_expr(ctx, func) {
                            if outer_name != pack_name
                                && name_is_stable_lexical(
                                    ctx,
                                    block,
                                    usage_index,
                                    pack_index,
                                    outer_name,
                                    outer_lexical,
                                )
                            {
                                if let (
                                    Some(inner_text),
                                    Some(recovered),
                                    Some(assign_range),
                                    Some(init_range),
                                ) = (
                                    ctx.expr_text(inner_call),
                                    source_replace_inner(
                                        ctx,
                                        &assign.values[0],
                                        &args[0],
                                        ctx.expr_text(inner_call).unwrap_or(""),
                                    ),
                                    ctx.stmt_range(&block.stmts[pack_index + 1]),
                                    ctx.range(pack_init.span()),
                                ) {
                                    let _ = inner_text;
                                    add_group(
                                        ctx,
                                        edits,
                                        vec![
                                            Edit {
                                                start: init_range.start,
                                                end: init_range.end,
                                                replacement: recovered,
                                                kind: EditKind::MultiReturnSelfAssignment,
                                            },
                                            Edit {
                                                start: assign_range.start,
                                                end: assign_range.end,
                                                replacement: String::new(),
                                                kind: EditKind::MultiReturnSelfAssignment,
                                            },
                                        ],
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }

        if usage.reads.len() != 1 || usage.writes != 0 || usage.redeclared || usage.captured {
            continue;
        }
        let next = &block.stmts[pack_index + 1];

        // Packed tail into the final table field. Moving the inner call to the
        // last field preserves its position only when every earlier field is a
        // stable/no-effect prefix. This recovers compiler multi-return packing
        // without assuming the call itself is single-return.
        if let Some((_table_binding, Expr::Table { fields, .. })) = local_single(next) {
            if let Some(TableField::Positional(last)) = fields.last() {
                let prefix_stable = fields[..fields.len().saturating_sub(1)].iter().all(|field| {
                    match field {
                        TableField::Positional(value) | TableField::Named { value, .. } => {
                            stable_prefix_expr(
                                ctx,
                                value,
                                block,
                                usage_index,
                                pack_index,
                                outer_lexical,
                            )
                        }
                        TableField::Computed { key, value } => {
                            stable_prefix_expr(
                                ctx,
                                key,
                                block,
                                usage_index,
                                pack_index,
                                outer_lexical,
                            ) && stable_prefix_expr(
                                ctx,
                                value,
                                block,
                                usage_index,
                                pack_index,
                                outer_lexical,
                            )
                        }
                    }
                });
                if prefix_stable
                    && global_unpack_call_for_name(ctx, last, pack_name, block, pack_index + 1, outer_lexical)
                {
                    if let (Some(unpack_range), Some(inner_text)) =
                        (ctx.range(last.span()), ctx.expr_text(inner_call))
                    {
                        if usage.reads[0].start >= unpack_range.start
                            && usage.reads[0].end <= unpack_range.end
                            && add_group(
                                ctx,
                                edits,
                                vec![
                                    Edit {
                                        start: pack_stmt_range.start,
                                        end: pack_stmt_range.end,
                                        replacement: String::new(),
                                        kind: EditKind::MultiReturnForward,
                                    },
                                    Edit {
                                        start: unpack_range.start,
                                        end: unpack_range.end,
                                        replacement: inner_text.to_string(),
                                        kind: EditKind::MultiReturnForward,
                                    },
                                ],
                            )
                        {
                            continue;
                        }
                    }
                }
            }
        }

        let Some(expr) = leading_expr_for_pack_stmt(next) else {
            continue;
        };
        let Some((_outer_call, unpack_call)) = leading_unpack_outer_call(
            ctx,
            expr,
            pack_name,
            block,
            usage_index,
            pack_index,
            outer_lexical,
        ) else {
            continue;
        };
        let Some(unpack_range) = ctx.range(unpack_call.span()) else {
            continue;
        };
        if usage.reads[0].start < unpack_range.start || usage.reads[0].end > unpack_range.end {
            continue;
        }
        let Some(inner_text) = ctx.expr_text(inner_call) else {
            continue;
        };
        add_group(
            ctx,
            edits,
            vec![
                Edit {
                    start: pack_stmt_range.start,
                    end: pack_stmt_range.end,
                    replacement: String::new(),
                    kind: EditKind::MultiReturnForward,
                },
                Edit {
                    start: unpack_range.start,
                    end: unpack_range.end,
                    replacement: inner_text.to_string(),
                    kind: EditKind::MultiReturnForward,
                },
            ],
        );
    }
}
fn direct_vararg_capture(stmt: &Stmt) -> Option<(&Binding, &Expr)> {
    let (binding, init) = local_single(stmt)?;
    let Expr::Table { fields, .. } = init else {
        return None;
    };
    if fields.len() != 1 {
        return None;
    }
    match &fields[0] {
        TableField::Positional(Expr::Vararg(_)) => Some((binding, init)),
        _ => None,
    }
}

fn generated_header_capture<'a>(
    ctx: &Ctx<'_>,
    body: &'a FunctionBody,
) -> Option<(usize, &'a Binding, &'a Expr, Range<usize>)> {
    if !body.params.iter().any(|p| p.is_vararg) {
        return None;
    }
    let body_range = ctx.range(body.span)?;
    let comments: Vec<_> = ctx
        .comments
        .iter()
        .filter_map(|(start, end)| {
            let r = *start as usize..*end as usize;
            (r.start >= body_range.start && r.end <= body_range.end).then_some(r)
        })
        .collect();
    if comments.len() < 2 {
        return None;
    }
    let header_start = comments[0].end;
    let body_boundary = comments[1].start;
    let mut found = None;
    for (index, stmt) in body.block.stmts.iter().enumerate() {
        let Some(range) = ctx.stmt_range(stmt) else {
            continue;
        };
        if range.start < header_start || range.end > body_boundary {
            continue;
        }
        let Some((binding, init)) = direct_vararg_capture(stmt) else {
            continue;
        };
        if found.is_some() {
            return None;
        }
        found = Some((index, binding, init, range));
    }
    found
}

fn capture_target_mutates(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> bool {
    match expr {
        Expr::Name(span) => ctx.text(*span) == Some(name),
        Expr::Index { object, .. } => name_of_expr(ctx, object) == Some(name),
        _ => false,
    }
}

fn collect_capture_read_expr(
    ctx: &Ctx<'_>,
    expr: &Expr,
    name: &str,
    edits: &mut Vec<Edit>,
) -> bool {
    match expr {
        Expr::Name(span) if ctx.text(*span) == Some(name) => false,
        Expr::Index { object, key, span } if name_of_expr(ctx, object) == Some(name) => {
            let IndexKey::Computed(index) = key else {
                return false;
            };
            let Expr::Number(num) = index.as_ref() else {
                return false;
            };
            let Ok(slot) = ctx.text(*num).unwrap_or("").parse::<usize>() else {
                return false;
            };
            if slot == 0 {
                return false;
            }
            let Some(range) = ctx.range(*span) else {
                return false;
            };
            edits.push(Edit {
                start: range.start,
                end: range.end,
                replacement: format!("(select({slot}, ...))"),
                kind: EditKind::GeneratedVarargRead,
            });
            true
        }
        Expr::Call {
            func, args, span, ..
        } if name_of_expr(ctx, func) == Some("unpack") => {
            let CallArgs::Paren(values) = args else {
                return collect_capture_read_children(ctx, expr, name, edits);
            };
            if values.len() == 1 && name_of_expr(ctx, &values[0]) == Some(name) {
                let Some(range) = ctx.range(*span) else {
                    return false;
                };
                edits.push(Edit {
                    start: range.start,
                    end: range.end,
                    replacement: "...".to_string(),
                    kind: EditKind::GeneratedVarargRead,
                });
                true
            } else {
                collect_capture_read_children(ctx, expr, name, edits)
            }
        }
        Expr::Function { body, .. } => !block_contains_name(ctx, &body.block, name),
        _ => collect_capture_read_children(ctx, expr, name, edits),
    }
}

fn collect_capture_read_children(
    ctx: &Ctx<'_>,
    expr: &Expr,
    name: &str,
    edits: &mut Vec<Edit>,
) -> bool {
    match expr {
        Expr::Table { fields, .. } => fields.iter().all(|field| match field {
            TableField::Positional(v) => collect_capture_read_expr(ctx, v, name, edits),
            TableField::Named { value, .. } => collect_capture_read_expr(ctx, value, name, edits),
            TableField::Computed { key, value } => {
                collect_capture_read_expr(ctx, key, name, edits)
                    && collect_capture_read_expr(ctx, value, name, edits)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            collect_capture_read_expr(ctx, lhs, name, edits)
                && collect_capture_read_expr(ctx, rhs, name, edits)
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            collect_capture_read_expr(ctx, operand, name, edits)
        }
        Expr::Index { object, key, .. } => {
            collect_capture_read_expr(ctx, object, name, edits)
                && match key {
                    IndexKey::Field(_) => true,
                    IndexKey::Computed(k) => collect_capture_read_expr(ctx, k, name, edits),
                }
        }
        Expr::Call { func, args, .. } => {
            collect_capture_read_expr(ctx, func, name, edits)
                && match args {
                    CallArgs::Paren(values) => values
                        .iter()
                        .all(|v| collect_capture_read_expr(ctx, v, name, edits)),
                    CallArgs::Table(v) => collect_capture_read_expr(ctx, v, name, edits),
                    CallArgs::Str(_) => true,
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches.iter().all(|(a, b)| {
                collect_capture_read_expr(ctx, a, name, edits)
                    && collect_capture_read_expr(ctx, b, name, edits)
            }) && collect_capture_read_expr(ctx, else_value, name, edits)
        }
        Expr::Name(span) => ctx.text(*span) != Some(name),
        Expr::Function { body, .. } => !block_contains_name(ctx, &body.block, name),
        _ => true,
    }
}

fn collect_capture_read_stmt(
    ctx: &Ctx<'_>,
    stmt: &Stmt,
    name: &str,
    edits: &mut Vec<Edit>,
) -> bool {
    match stmt {
        Stmt::Local(n) => {
            if n.names.iter().any(|b| ctx.text(b.name) == Some(name)) {
                return false;
            }
            n.values
                .iter()
                .all(|e| collect_capture_read_expr(ctx, e, name, edits))
        }
        Stmt::Assign(n) => {
            if n.targets
                .iter()
                .any(|t| capture_target_mutates(ctx, t, name))
            {
                return false;
            }
            n.targets
                .iter()
                .all(|t| collect_capture_read_expr(ctx, t, name, edits))
                && n.values
                    .iter()
                    .all(|e| collect_capture_read_expr(ctx, e, name, edits))
        }
        Stmt::Call(e, _) => collect_capture_read_expr(ctx, e, name, edits),
        Stmt::Do(n) => n
            .block
            .stmts
            .iter()
            .all(|s| collect_capture_read_stmt(ctx, s, name, edits)),
        Stmt::While(n) => {
            collect_capture_read_expr(ctx, &n.cond, name, edits)
                && n.block
                    .stmts
                    .iter()
                    .all(|s| collect_capture_read_stmt(ctx, s, name, edits))
        }
        Stmt::Repeat(n) => {
            n.block
                .stmts
                .iter()
                .all(|s| collect_capture_read_stmt(ctx, s, name, edits))
                && collect_capture_read_expr(ctx, &n.cond, name, edits)
        }
        Stmt::If(n) => {
            n.branches.iter().all(|(c, b)| {
                collect_capture_read_expr(ctx, c, name, edits)
                    && b.stmts
                        .iter()
                        .all(|s| collect_capture_read_stmt(ctx, s, name, edits))
            }) && n.else_block.as_ref().is_none_or(|b| {
                b.stmts
                    .iter()
                    .all(|s| collect_capture_read_stmt(ctx, s, name, edits))
            })
        }
        Stmt::NumericFor(n) => {
            if ctx.text(n.var.name) == Some(name) {
                return false;
            }
            collect_capture_read_expr(ctx, &n.start, name, edits)
                && collect_capture_read_expr(ctx, &n.limit, name, edits)
                && n.step
                    .as_ref()
                    .is_none_or(|e| collect_capture_read_expr(ctx, e, name, edits))
                && n.block
                    .stmts
                    .iter()
                    .all(|s| collect_capture_read_stmt(ctx, s, name, edits))
        }
        Stmt::GenericFor(n) => {
            if n.vars.iter().any(|b| ctx.text(b.name) == Some(name)) {
                return false;
            }
            n.exprs
                .iter()
                .all(|e| collect_capture_read_expr(ctx, e, name, edits))
                && n.block
                    .stmts
                    .iter()
                    .all(|s| collect_capture_read_stmt(ctx, s, name, edits))
        }
        Stmt::Function(n) => !block_contains_name(ctx, &n.body.block, name),
        Stmt::LocalFunction(n) => {
            ctx.text(n.name) != Some(name) && !block_contains_name(ctx, &n.body.block, name)
        }
        Stmt::Return(n) => n
            .values
            .iter()
            .all(|e| collect_capture_read_expr(ctx, e, name, edits)),
        _ => true,
    }
}

fn compiler_vararg_tail(ctx: &Ctx<'_>, init: &Expr, capture_name: &str) -> Option<usize> {
    let call = table_single_call(init)?;
    let (func, method, args) = call_parts(call)?;
    if method.is_some() || name_of_expr(ctx, func) != Some("select") {
        return None;
    }
    let args = paren_args(args)?;
    if args.len() != 2 {
        return None;
    }
    let Expr::Number(offset_span) = &args[0] else {
        return None;
    };
    let offset = ctx.text(*offset_span)?.parse::<usize>().ok()?;
    if offset == 0 || !call_is_unpack_name(ctx, &args[1], capture_name) {
        return None;
    }
    Some(offset)
}

fn collect_exact_unpack_expr(
    ctx: &Ctx<'_>,
    expr: &Expr,
    name: &str,
    ranges: &mut Vec<Range<usize>>,
) -> bool {
    if let Expr::Call {
        func, args, span, ..
    } = expr
    {
        if name_of_expr(ctx, func) == Some("unpack") {
            if let CallArgs::Paren(values) = args {
                if values.len() == 1 && name_of_expr(ctx, &values[0]) == Some(name) {
                    let Some(range) = ctx.range(*span) else {
                        return false;
                    };
                    ranges.push(range);
                    return true;
                }
            }
        }
    }
    match expr {
        Expr::Name(span) if ctx.text(*span) == Some(name) => false,
        Expr::Function { body, .. } => !block_contains_name(ctx, &body.block, name),
        Expr::Table { fields, .. } => fields.iter().all(|f| match f {
            TableField::Positional(v) => collect_exact_unpack_expr(ctx, v, name, ranges),
            TableField::Named { value, .. } => collect_exact_unpack_expr(ctx, value, name, ranges),
            TableField::Computed { key, value } => {
                collect_exact_unpack_expr(ctx, key, name, ranges)
                    && collect_exact_unpack_expr(ctx, value, name, ranges)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            collect_exact_unpack_expr(ctx, lhs, name, ranges)
                && collect_exact_unpack_expr(ctx, rhs, name, ranges)
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            collect_exact_unpack_expr(ctx, operand, name, ranges)
        }
        Expr::Index { object, key, .. } => {
            collect_exact_unpack_expr(ctx, object, name, ranges)
                && match key {
                    IndexKey::Field(_) => true,
                    IndexKey::Computed(k) => collect_exact_unpack_expr(ctx, k, name, ranges),
                }
        }
        Expr::Call { func, args, .. } => {
            collect_exact_unpack_expr(ctx, func, name, ranges)
                && match args {
                    CallArgs::Paren(v) => v
                        .iter()
                        .all(|e| collect_exact_unpack_expr(ctx, e, name, ranges)),
                    CallArgs::Table(e) => collect_exact_unpack_expr(ctx, e, name, ranges),
                    CallArgs::Str(_) => true,
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches.iter().all(|(a, b)| {
                collect_exact_unpack_expr(ctx, a, name, ranges)
                    && collect_exact_unpack_expr(ctx, b, name, ranges)
            }) && collect_exact_unpack_expr(ctx, else_value, name, ranges)
        }
        _ => true,
    }
}

fn collect_exact_unpack_stmt(
    ctx: &Ctx<'_>,
    stmt: &Stmt,
    name: &str,
    ranges: &mut Vec<Range<usize>>,
) -> bool {
    match stmt {
        Stmt::Local(n) => n
            .values
            .iter()
            .all(|e| collect_exact_unpack_expr(ctx, e, name, ranges)),
        Stmt::Assign(n) => {
            n.targets
                .iter()
                .all(|e| collect_exact_unpack_expr(ctx, e, name, ranges))
                && n.values
                    .iter()
                    .all(|e| collect_exact_unpack_expr(ctx, e, name, ranges))
        }
        Stmt::Call(e, _) => collect_exact_unpack_expr(ctx, e, name, ranges),
        Stmt::Do(n) => n
            .block
            .stmts
            .iter()
            .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges)),
        Stmt::While(n) => {
            collect_exact_unpack_expr(ctx, &n.cond, name, ranges)
                && n.block
                    .stmts
                    .iter()
                    .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges))
        }
        Stmt::Repeat(n) => {
            n.block
                .stmts
                .iter()
                .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges))
                && collect_exact_unpack_expr(ctx, &n.cond, name, ranges)
        }
        Stmt::If(n) => {
            n.branches.iter().all(|(c, b)| {
                collect_exact_unpack_expr(ctx, c, name, ranges)
                    && b.stmts
                        .iter()
                        .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges))
            }) && n.else_block.as_ref().is_none_or(|b| {
                b.stmts
                    .iter()
                    .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges))
            })
        }
        Stmt::NumericFor(n) => {
            collect_exact_unpack_expr(ctx, &n.start, name, ranges)
                && collect_exact_unpack_expr(ctx, &n.limit, name, ranges)
                && n.step
                    .as_ref()
                    .is_none_or(|e| collect_exact_unpack_expr(ctx, e, name, ranges))
                && n.block
                    .stmts
                    .iter()
                    .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges))
        }
        Stmt::GenericFor(n) => {
            n.exprs
                .iter()
                .all(|e| collect_exact_unpack_expr(ctx, e, name, ranges))
                && n.block
                    .stmts
                    .iter()
                    .all(|s| collect_exact_unpack_stmt(ctx, s, name, ranges))
        }
        Stmt::Function(n) => !block_contains_name(ctx, &n.body.block, name),
        Stmt::LocalFunction(n) => !block_contains_name(ctx, &n.body.block, name),
        Stmt::Return(n) => n
            .values
            .iter()
            .all(|e| collect_exact_unpack_expr(ctx, e, name, ranges)),
        _ => true,
    }
}

fn collect_generated_vararg_recovery(ctx: &Ctx<'_>, body: &FunctionBody, edits: &mut Vec<Edit>) {
    let Some((capture_index, binding, _capture_init, capture_range)) =
        generated_header_capture(ctx, body)
    else {
        return;
    };
    let capture_name = ctx.text(binding.name).unwrap_or("");
    let usage_index = build_usage_index(ctx, &body.block);
    let capture_usage = usage_index.usage_after(capture_name, capture_range.end);
    if capture_usage.writes != 0 || capture_usage.redeclared || capture_usage.captured {
        return;
    }

    let mut tail_ranges = Vec::new();
    let mut tail_edits = Vec::new();
    for i in (capture_index + 1)..body.block.stmts.len() {
        let Some((tail_binding, tail_init)) = local_single(&body.block.stmts[i]) else {
            continue;
        };
        let Some(offset) = compiler_vararg_tail(ctx, tail_init, capture_name) else {
            continue;
        };
        let tail_name = ctx.text(tail_binding.name).unwrap_or("");
        let Some(tail_stmt_range) = ctx.stmt_range(&body.block.stmts[i]) else {
            continue;
        };
        let tail_usage = usage_index.usage_after(tail_name, tail_stmt_range.end);
        if tail_usage.reads.is_empty()
            || tail_usage.writes != 0
            || tail_usage.redeclared
            || tail_usage.captured
        {
            continue;
        }
        let mut unpack_ranges = Vec::new();
        let mut safe = true;
        for stmt in body.block.stmts.iter().skip(i + 1) {
            if !collect_exact_unpack_stmt(ctx, stmt, tail_name, &mut unpack_ranges) {
                safe = false;
                break;
            }
        }
        if !safe || unpack_ranges.len() != tail_usage.reads.len() {
            continue;
        }
        tail_ranges.push(tail_stmt_range.clone());
        tail_edits.push(Edit {
            start: tail_stmt_range.start,
            end: tail_stmt_range.end,
            replacement: String::new(),
            kind: EditKind::CompilerVarargForward,
        });
        for range in unpack_ranges {
            tail_edits.push(Edit {
                start: range.start,
                end: range.end,
                replacement: format!("select({offset}, ...)"),
                kind: EditKind::CompilerVarargForward,
            });
        }
    }

    let mut direct_edits = Vec::new();
    let mut safe = true;
    for (i, stmt) in body.block.stmts.iter().enumerate().skip(capture_index + 1) {
        if tail_ranges
            .iter()
            .any(|r| ctx.stmt_range(stmt).is_some_and(|sr| sr == *r))
        {
            continue;
        }
        if !collect_capture_read_stmt(ctx, stmt, capture_name, &mut direct_edits) {
            safe = false;
            break;
        }
        let _ = i;
    }
    if !safe {
        return;
    }
    let recovered_count = direct_edits.len()
        + tail_edits
            .iter()
            .filter(|e| !e.replacement.is_empty())
            .count();
    if recovered_count == 0 {
        return;
    }
    let mut group = vec![Edit {
        start: capture_range.start,
        end: capture_range.end,
        replacement: String::new(),
        kind: EditKind::GeneratedVarargCapture,
    }];
    group.extend(tail_edits);
    group.extend(direct_edits);
    add_group(ctx, edits, group);
}
