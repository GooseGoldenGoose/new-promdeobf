#[derive(Default)]
struct PrivateTableUse {
    unsafe_exposure: bool,
    mutation: bool,
}

fn scan_private_table_expr(
    ctx: &Ctx<'_>,
    expr: &Expr,
    name: &str,
    state: &mut PrivateTableUse,
    nested: bool,
) {
    if state.unsafe_exposure {
        return;
    }
    match expr {
        Expr::Name(span) if ctx.text(*span) == Some(name) => {
            state.unsafe_exposure = true;
        }
        Expr::Function { body, .. } => {
            if block_contains_name(ctx, &body.block, name) {
                state.unsafe_exposure = true;
            }
        }
        Expr::Index { object, key, .. } => {
            if name_of_expr(ctx, object) == Some(name) {
                if nested {
                    state.unsafe_exposure = true;
                    return;
                }
                if let IndexKey::Computed(k) = key {
                    scan_private_table_expr(ctx, k, name, state, nested);
                }
            } else {
                scan_private_table_expr(ctx, object, name, state, nested);
                if let IndexKey::Computed(k) = key {
                    scan_private_table_expr(ctx, k, name, state, nested);
                }
            }
        }
        Expr::Table { fields, .. } => {
            for f in fields {
                match f {
                    TableField::Positional(v) => {
                        scan_private_table_expr(ctx, v, name, state, nested)
                    }
                    TableField::Named { value, .. } => {
                        scan_private_table_expr(ctx, value, name, state, nested)
                    }
                    TableField::Computed { key, value } => {
                        scan_private_table_expr(ctx, key, name, state, nested);
                        scan_private_table_expr(ctx, value, name, state, nested);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            scan_private_table_expr(ctx, lhs, name, state, nested);
            scan_private_table_expr(ctx, rhs, name, state, nested);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            scan_private_table_expr(ctx, operand, name, state, nested)
        }
        Expr::Call { func, args, .. } => {
            scan_private_table_expr(ctx, func, name, state, nested);
            match args {
                CallArgs::Paren(v) => {
                    for e in v {
                        scan_private_table_expr(ctx, e, name, state, nested)
                    }
                }
                CallArgs::Table(e) => scan_private_table_expr(ctx, e, name, state, nested),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                scan_private_table_expr(ctx, a, name, state, nested);
                scan_private_table_expr(ctx, b, name, state, nested);
            }
            scan_private_table_expr(ctx, else_value, name, state, nested);
        }
        _ => {}
    }
}

fn scan_private_table_stmt(ctx: &Ctx<'_>, stmt: &Stmt, name: &str) -> PrivateTableUse {
    let mut state = PrivateTableUse::default();
    match stmt {
        Stmt::Local(n) => {
            for e in &n.values {
                scan_private_table_expr(ctx, e, name, &mut state, false)
            }
            if n.names.iter().any(|b| ctx.text(b.name) == Some(name)) {
                state.unsafe_exposure = true;
            }
        }
        Stmt::Assign(n) => {
            for target in &n.targets {
                match target {
                    Expr::Name(span) if ctx.text(*span) == Some(name) => {
                        state.mutation = true;
                        state.unsafe_exposure = true;
                    }
                    Expr::Index { object, key, .. } if name_of_expr(ctx, object) == Some(name) => {
                        state.mutation = true;
                        if let IndexKey::Computed(k) = key {
                            scan_private_table_expr(ctx, k, name, &mut state, false);
                        }
                    }
                    _ => scan_private_table_expr(ctx, target, name, &mut state, false),
                }
            }
            for e in &n.values {
                scan_private_table_expr(ctx, e, name, &mut state, false)
            }
        }
        Stmt::Call(e, _) => scan_private_table_expr(ctx, e, name, &mut state, false),
        Stmt::Do(n) => {
            for s in &n.block.stmts {
                let child = scan_private_table_stmt(ctx, s, name);
                state.unsafe_exposure |= child.unsafe_exposure;
                state.mutation |= child.mutation;
            }
        }
        Stmt::While(n) => {
            scan_private_table_expr(ctx, &n.cond, name, &mut state, false);
            for s in &n.block.stmts {
                let child = scan_private_table_stmt(ctx, s, name);
                state.unsafe_exposure |= child.unsafe_exposure;
                state.mutation |= child.mutation;
            }
        }
        Stmt::Repeat(n) => {
            for s in &n.block.stmts {
                let child = scan_private_table_stmt(ctx, s, name);
                state.unsafe_exposure |= child.unsafe_exposure;
                state.mutation |= child.mutation;
            }
            scan_private_table_expr(ctx, &n.cond, name, &mut state, false);
        }
        Stmt::If(n) => {
            for (c, b) in &n.branches {
                scan_private_table_expr(ctx, c, name, &mut state, false);
                for s in &b.stmts {
                    let child = scan_private_table_stmt(ctx, s, name);
                    state.unsafe_exposure |= child.unsafe_exposure;
                    state.mutation |= child.mutation;
                }
            }
            if let Some(b) = &n.else_block {
                for s in &b.stmts {
                    let child = scan_private_table_stmt(ctx, s, name);
                    state.unsafe_exposure |= child.unsafe_exposure;
                    state.mutation |= child.mutation;
                }
            }
        }
        Stmt::NumericFor(n) => {
            scan_private_table_expr(ctx, &n.start, name, &mut state, false);
            scan_private_table_expr(ctx, &n.limit, name, &mut state, false);
            if let Some(e) = &n.step {
                scan_private_table_expr(ctx, e, name, &mut state, false)
            }
            for s in &n.block.stmts {
                let child = scan_private_table_stmt(ctx, s, name);
                state.unsafe_exposure |= child.unsafe_exposure;
                state.mutation |= child.mutation;
            }
        }
        Stmt::GenericFor(n) => {
            for e in &n.exprs {
                scan_private_table_expr(ctx, e, name, &mut state, false)
            }
            for s in &n.block.stmts {
                let child = scan_private_table_stmt(ctx, s, name);
                state.unsafe_exposure |= child.unsafe_exposure;
                state.mutation |= child.mutation;
            }
        }
        Stmt::Function(n) => {
            if block_contains_name(ctx, &n.body.block, name) {
                state.unsafe_exposure = true;
            }
        }
        Stmt::LocalFunction(n) => {
            if block_contains_name(ctx, &n.body.block, name) {
                state.unsafe_exposure = true;
            }
        }
        Stmt::Return(n) => {
            for e in &n.values {
                scan_private_table_expr(ctx, e, name, &mut state, false)
            }
        }
        _ => {}
    }
    state
}

fn stable_lookup_index(
    ctx: &Ctx<'_>,
    expr: &Expr,
    block: &Block,
    usage_index: &UsageIndex,
    producer: usize,
    consumer: usize,
) -> bool {
    if is_pure_literal(expr) {
        return true;
    }
    let Some(name) = name_of_expr(ctx, expr) else {
        return false;
    };
    if !direct_local_declared_before(ctx, block, producer, name) {
        return false;
    }
    if usage_index
        .by_name
        .get(name)
        .is_some_and(|items| items.iter().any(|x| x.kind == OccKind::Capture))
    {
        return false;
    }
    for stmt in &block.stmts[(producer + 1)..consumer] {
        let mut usage = Usage::default();
        scan_stmt_usage(ctx, stmt, name, &mut usage);
        if usage.writes != 0 || usage.redeclared || usage.captured {
            return false;
        }
    }
    true
}

fn collect_dependency_safe_assignment_keys(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    edits: &mut Vec<Edit>,
) {
    for producer in 0..block.stmts.len() {
        let Some((key_binding, key_init)) = local_single(&block.stmts[producer]) else {
            continue;
        };
        let Expr::Index {
            object,
            key: IndexKey::Computed(index),
            ..
        } = key_init
        else {
            continue;
        };
        let Some(source_name) = name_of_expr(ctx, object) else {
            continue;
        };
        let key_name = ctx.text(key_binding.name).unwrap_or("");
        let Some(prod_range) = ctx.stmt_range(&block.stmts[producer]) else {
            continue;
        };
        let key_usage = usage_index.usage_after(key_name, prod_range.end);
        if key_usage.reads.len() != 1
            || key_usage.writes != 0
            || key_usage.redeclared
            || key_usage.captured
        {
            continue;
        }
        for consumer in (producer + 2)..block.stmts.len() {
            let Stmt::Assign(assign) = &block.stmts[consumer] else {
                continue;
            };
            if assign.targets.len() != 1 || assign.values.len() != 1 {
                continue;
            }
            let Expr::Index {
                object: dest,
                key: IndexKey::Computed(dest_key),
                ..
            } = &assign.targets[0]
            else {
                continue;
            };
            let Expr::Name(dest_key_span) = dest_key.as_ref() else {
                continue;
            };
            if ctx.text(*dest_key_span) != Some(key_name) {
                continue;
            }
            let Some(read_range) = ctx.range(*dest_key_span) else {
                continue;
            };
            if key_usage.reads[0] != read_range {
                continue;
            }
            let Some(dest_name) = name_of_expr(ctx, dest) else {
                continue;
            };
            if !name_is_stable_local(ctx, block, usage_index, consumer, dest_name)
                || !stable_lookup_index(ctx, index, block, usage_index, producer, consumer)
            {
                continue;
            }
            let mut table_decl = None;
            let mut declaration_count = 0usize;
            for i in 0..producer {
                if let Some((binding, init)) = local_single(&block.stmts[i]) {
                    if ctx.text(binding.name) == Some(source_name) {
                        declaration_count += 1;
                        if matches!(init, Expr::Table { .. }) {
                            table_decl = Some(i);
                        }
                    }
                }
            }
            if declaration_count != 1 {
                continue;
            }
            let Some(decl) = table_decl else {
                continue;
            };
            let mut safe = true;
            for i in (decl + 1)..=consumer {
                if i == producer {
                    continue;
                }
                let use_info = scan_private_table_stmt(ctx, &block.stmts[i], source_name);
                if use_info.unsafe_exposure || (i > producer && i < consumer && use_info.mutation) {
                    safe = false;
                    break;
                }
            }
            if !safe {
                continue;
            }
            let Some(value) = ctx.expr_text(key_init) else {
                continue;
            };
            if add_group(
                ctx,
                edits,
                vec![
                    Edit {
                        start: prod_range.start,
                        end: prod_range.end,
                        replacement: String::new(),
                        kind: EditKind::DependencyAssignmentKeyInline,
                    },
                    Edit {
                        start: read_range.start,
                        end: read_range.end,
                        replacement: value.to_string(),
                        kind: EditKind::DependencyAssignmentKeyInline,
                    },
                ],
            ) {
                break;
            }
        }
    }
}
