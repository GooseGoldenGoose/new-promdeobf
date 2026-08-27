fn reconstruct_call_without_first(
    ctx: &Ctx<'_>,
    call: &Expr,
    base: &str,
    method: &str,
) -> Option<String> {
    let (_, m, args) = call_parts(call)?;
    if m.is_some() {
        return None;
    }
    let args = paren_args(args)?;
    if args.is_empty() || name_of_expr(ctx, &args[0]) != Some(base) {
        return None;
    }
    let rest = args
        .iter()
        .skip(1)
        .map(|e| ctx.expr_text(e).map(str::to_owned))
        .collect::<Option<Vec<_>>>()?;
    Some(format!("{}:{}({})", base, method, rest.join(", ")))
}

fn reconstruct_direct_pass_self_namecall(ctx: &Ctx<'_>, call: &Expr) -> Option<String> {
    let (func, existing_method, _) = call_parts(call)?;
    if existing_method.is_some() {
        return None;
    }
    let Expr::Index { object, key, .. } = unwrap_parens(func) else {
        return None;
    };
    let base = name_of_expr(ctx, object)?;
    let method = index_key_identifier(ctx, key)?;
    reconstruct_call_without_first(ctx, call, base, &method)
}

fn expr_contains_gap_def(
    ctx: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
) -> bool {
    defs.keys().any(|name| expr_contains_name(ctx, expr, name))
}

fn collect_namecall_gap_eval_order<'a>(
    ctx: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    def_order: &HashMap<String, usize>,
    before_def: Option<usize>,
    stack: &mut HashSet<String>,
    counts: &mut HashMap<String, usize>,
    order: &mut Vec<String>,
) -> bool {
    if let Expr::Name(span) = expr {
        let Some(name) = ctx.text(*span) else {
            return true;
        };
        let Some(def) = defs.get(name) else {
            return true;
        };
        let Some(&index) = def_order.get(name) else {
            return false;
        };
        if before_def.is_some_and(|limit| index >= limit) {
            return false;
        }
        *counts.entry(name.to_string()).or_default() += 1;
        if !stack.insert(name.to_string()) {
            return false;
        }
        if !collect_namecall_gap_eval_order(
            ctx,
            def,
            defs,
            def_order,
            Some(index),
            stack,
            counts,
            order,
        ) {
            return false;
        }
        stack.remove(name);
        if !is_pure_literal(def) {
            order.push(name.to_string());
        }
        return true;
    }

    match expr {
        Expr::Paren { inner, .. }
        | Expr::TypeAssert { expr: inner, .. }
        | Expr::Unary { operand: inner, .. } => collect_namecall_gap_eval_order(
            ctx, inner, defs, def_order, before_def, stack, counts, order,
        ),
        Expr::Index { object, key, .. } => {
            collect_namecall_gap_eval_order(
                ctx, object, defs, def_order, before_def, stack, counts, order,
            ) && match key {
                IndexKey::Field(_) => true,
                IndexKey::Computed(key) => collect_namecall_gap_eval_order(
                    ctx, key, defs, def_order, before_def, stack, counts, order,
                ),
            }
        }
        Expr::Call { func, args, .. } => {
            if !collect_namecall_gap_eval_order(
                ctx, func, defs, def_order, before_def, stack, counts, order,
            ) {
                return false;
            }
            match args {
                CallArgs::Paren(values) => values.iter().all(|value| {
                    collect_namecall_gap_eval_order(
                        ctx, value, defs, def_order, before_def, stack, counts, order,
                    )
                }),
                // A table-constructor call argument has language-specific field
                // evaluation details. Keep gap-local movement out of that shape.
                CallArgs::Table(value) => !expr_contains_gap_def(ctx, value, defs),
                CallArgs::Str(_) => true,
            }
        }
        Expr::Binary { op, lhs, rhs, .. } => {
            if !collect_namecall_gap_eval_order(
                ctx, lhs, defs, def_order, before_def, stack, counts, order,
            ) {
                return false;
            }
            if matches!(ctx.text(*op), Some("and") | Some("or")) {
                // Gap locals were evaluated unconditionally before the call. Never
                // move one into a conditional right arm.
                !expr_contains_gap_def(ctx, rhs, defs)
            } else {
                collect_namecall_gap_eval_order(
                    ctx, rhs, defs, def_order, before_def, stack, counts, order,
                )
            }
        }
        Expr::Table { .. } | Expr::IfElse { .. } | Expr::Function { .. } => {
            !expr_contains_gap_def(ctx, expr, defs)
        }
        _ => !expr_contains_gap_def(ctx, expr, defs),
    }
}

fn render_namecall_gap_expr<'a>(
    ctx: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    use_counts: &mut HashMap<String, usize>,
    stack: &mut HashSet<String>,
) -> Option<String> {
    let base_range = ctx.range(expr.span())?;
    let wanted = defs.keys().cloned().collect::<HashSet<_>>();
    let mut hits = Vec::new();
    collect_name_ranges(expr, ctx, &wanted, &mut hits);
    if hits.is_empty() {
        return ctx.expr_text(expr).map(str::to_string);
    }

    let mut replacements = Vec::new();
    for (range, name) in hits {
        if range.start < base_range.start || range.end > base_range.end {
            continue;
        }
        *use_counts.entry(name.clone()).or_default() += 1;
        if !stack.insert(name.clone()) {
            return None;
        }
        let def = *defs.get(&name)?;
        let rendered = render_namecall_gap_expr(ctx, def, defs, use_counts, stack)?;
        stack.remove(&name);
        let replacement = match unwrap_parens(def) {
            Expr::Name(_)
            | Expr::Index { .. }
            | Expr::Nil(_)
            | Expr::True(_)
            | Expr::False(_)
            | Expr::Number(_)
            | Expr::String(_) => rendered,
            _ => format!("({rendered})"),
        };
        replacements.push((
            range.start - base_range.start,
            range.end - base_range.start,
            replacement,
        ));
    }
    replacements.sort_by_key(|x| x.0);
    let mut text = ctx.src.get(base_range)?.to_string();
    for (start, end, replacement) in replacements.into_iter().rev() {
        text.replace_range(start..end, &replacement);
    }
    Some(text)
}

fn reconstruct_namecall_with_gap_index_args<'a>(
    ctx: &Ctx<'_>,
    block: &'a Block,
    usage_index: &UsageIndex,
    method_index: usize,
    consumer_index: usize,
    call: &'a Expr,
    base: &str,
    method: &str,
) -> Option<(String, Vec<Range<usize>>)> {
    let (_, existing_method, args_node) = call_parts(call)?;
    if existing_method.is_some() {
        return None;
    }
    let args = paren_args(args_node)?;
    if args.len() < 2 || name_of_expr(ctx, &args[0]) != Some(base) {
        return None;
    }
    let call_args = &args[1..];

    // Collect a dependency closure of argument temporaries that were materialized
    // immediately before the compiler's captured method. This is intentionally tied
    // to proven namecall lowering (method = base[key]; method(base, ...)); arbitrary
    // already-written namecalls never enter this path.
    let mut available_pre: HashMap<String, (usize, &Expr, Range<usize>)> = HashMap::new();
    let mut duplicate_pre = HashSet::new();
    for (index, stmt) in block.stmts[..method_index].iter().enumerate() {
        let Some((binding, init)) = local_single(stmt) else {
            continue;
        };
        let name = ctx.text(binding.name)?.to_string();
        let range = ctx.stmt_range(stmt)?;
        if available_pre.insert(name.clone(), (index, init, range)).is_some() {
            duplicate_pre.insert(name);
        }
    }
    for name in &duplicate_pre {
        available_pre.remove(name);
    }
    available_pre.remove(base);

    let available_names = available_pre.keys().cloned().collect::<HashSet<_>>();
    let mut selected_pre = HashSet::new();
    let mut pending = Vec::new();
    for arg in call_args {
        let mut hits = Vec::new();
        collect_name_ranges(arg, ctx, &available_names, &mut hits);
        pending.extend(hits.into_iter().map(|(_, name)| name));
    }
    while let Some(name) = pending.pop() {
        if !selected_pre.insert(name.clone()) {
            continue;
        }
        let (_, init, _) = *available_pre.get(&name)?;
        let mut hits = Vec::new();
        collect_name_ranges(init, ctx, &available_names, &mut hits);
        for (_, dep) in hits {
            if dep != base && !selected_pre.contains(&dep) {
                pending.push(dep);
            }
        }
    }

    // Prefix movement may not jump across unrelated statements. In the generated
    // compiler shape the dependency program is a contiguous local run ending at the
    // method capture; requiring that boundary also prevents lexical-shadow changes.
    if let Some(first_pre) = selected_pre
        .iter()
        .filter_map(|name| available_pre.get(name).map(|(index, _, _)| *index))
        .min()
    {
        for stmt in &block.stmts[first_pre..method_index] {
            let (binding, _) = local_single(stmt)?;
            let name = ctx.text(binding.name)?;
            if !selected_pre.contains(name) {
                return None;
            }
        }
    }

    let mut entries: Vec<(usize, String, &Expr, Range<usize>)> = Vec::new();
    for name in &selected_pre {
        let (index, init, range) = available_pre.get(name)?.clone();
        let usage = usage_index.usage_after(name, range.end);
        if usage.reads.len() != 1 || usage.writes != 0 || usage.redeclared || usage.captured {
            return None;
        }
        entries.push((index, name.clone(), init, range));
    }

    let gap = block.stmts.get(method_index + 1..consumer_index)?;
    for (offset, stmt) in gap.iter().enumerate() {
        let (binding, init) = local_single(stmt)?;
        let name = ctx.text(binding.name)?.to_string();
        let range = ctx.stmt_range(stmt)?;
        let usage = usage_index.usage_after(&name, range.end);
        if usage.reads.len() != 1 || usage.writes != 0 || usage.redeclared || usage.captured {
            return None;
        }
        entries.push((method_index + 1 + offset, name, init, range));
    }
    if entries.is_empty() {
        return None;
    }
    entries.sort_by_key(|(index, _, _, _)| *index);

    let mut defs: HashMap<String, &Expr> = HashMap::new();
    let mut def_order = HashMap::new();
    let mut gap_order = Vec::with_capacity(entries.len());
    let mut effect_order = Vec::with_capacity(entries.len());
    let mut removed = Vec::with_capacity(entries.len());
    for (index, name, init, range) in entries {
        if defs.insert(name.clone(), init).is_some() {
            return None;
        }
        def_order.insert(name.clone(), index);
        gap_order.push(name.clone());
        if !is_pure_literal(init) {
            effect_order.push(name.clone());
        }
        removed.push(range);
    }

    // Prove that expanding all selected compiler temporaries into the recovered call
    // evaluates every initializer exactly once and preserves their relative order.
    // Pure literals are allowed to move because they have no runtime observation.
    let mut eval_order = Vec::new();
    let mut eval_counts = HashMap::new();
    let mut stack = HashSet::new();
    for (arg_index, arg) in call_args.iter().enumerate() {
        let before = eval_order.len();
        if !collect_namecall_gap_eval_order(
            ctx,
            arg,
            &defs,
            &def_order,
            None,
            &mut stack,
            &mut eval_counts,
            &mut eval_order,
        ) {
            return None;
        }
        if eval_order.len() != before {
            let direct_gap_name = name_of_expr(ctx, arg).is_some_and(|name| defs.contains_key(name));
            if !direct_gap_name
                && call_args[arg_index + 1..]
                    .iter()
                    .any(|later| expr_contains_gap_def(ctx, later, &defs))
            {
                return None;
            }
        }
    }
    if eval_order != effect_order {
        return None;
    }
    if gap_order
        .iter()
        .any(|name| eval_counts.get(name).copied().unwrap_or(0) != 1)
    {
        return None;
    }

    let mut rendered = Vec::with_capacity(call_args.len());
    let mut render_counts = HashMap::new();
    for arg in call_args {
        let mut render_stack = HashSet::new();
        rendered.push(render_namecall_gap_expr(
            ctx,
            arg,
            &defs,
            &mut render_counts,
            &mut render_stack,
        )?);
    }
    if gap_order
        .iter()
        .any(|name| render_counts.get(name).copied().unwrap_or(0) != 1)
    {
        return None;
    }

    Some((
        format!("{}:{}({})", base, method, rendered.join(", ")),
        removed,
    ))
}

fn expr_has_setfenv(ctx: &Ctx<'_>, expr: &Expr) -> bool {
    match expr {
        Expr::Function { .. } => false,
        Expr::Call { func, args, .. } => {
            if name_of_expr(ctx, unwrap_parens(func)) == Some("setfenv") {
                return true;
            }
            expr_has_setfenv(ctx, func)
                || match args {
                    CallArgs::Paren(values) => {
                        values.iter().any(|value| expr_has_setfenv(ctx, value))
                    }
                    CallArgs::Table(value) => expr_has_setfenv(ctx, value),
                    CallArgs::Str(_) => false,
                }
        }
        Expr::Table { fields, .. } => fields.iter().any(|field| match field {
            TableField::Positional(value) => expr_has_setfenv(ctx, value),
            TableField::Named { value, .. } => expr_has_setfenv(ctx, value),
            TableField::Computed { key, value } => {
                expr_has_setfenv(ctx, key) || expr_has_setfenv(ctx, value)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => expr_has_setfenv(ctx, lhs) || expr_has_setfenv(ctx, rhs),
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => expr_has_setfenv(ctx, operand),
        Expr::Index { object, key, .. } => {
            expr_has_setfenv(ctx, object)
                || match key {
                    IndexKey::Field(_) => false,
                    IndexKey::Computed(key) => expr_has_setfenv(ctx, key),
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches.iter().any(|(condition, value)| {
                expr_has_setfenv(ctx, condition) || expr_has_setfenv(ctx, value)
            }) || expr_has_setfenv(ctx, else_value)
        }
        _ => false,
    }
}

fn block_has_setfenv(ctx: &Ctx<'_>, block: &Block) -> bool {
    block.stmts.iter().any(|stmt| match stmt {
        Stmt::Local(node) => node.values.iter().any(|expr| expr_has_setfenv(ctx, expr)),
        Stmt::Assign(node) => node
            .targets
            .iter()
            .chain(node.values.iter())
            .any(|expr| expr_has_setfenv(ctx, expr)),
        Stmt::Call(expr, _) => expr_has_setfenv(ctx, expr),
        Stmt::Do(node) => block_has_setfenv(ctx, &node.block),
        Stmt::While(node) => {
            expr_has_setfenv(ctx, &node.cond) || block_has_setfenv(ctx, &node.block)
        }
        Stmt::Repeat(node) => {
            block_has_setfenv(ctx, &node.block) || expr_has_setfenv(ctx, &node.cond)
        }
        Stmt::If(node) => {
            node.branches.iter().any(|(condition, body)| {
                expr_has_setfenv(ctx, condition) || block_has_setfenv(ctx, body)
            }) || node
                .else_block
                .as_ref()
                .is_some_and(|body| block_has_setfenv(ctx, body))
        }
        Stmt::NumericFor(node) => {
            expr_has_setfenv(ctx, &node.start)
                || expr_has_setfenv(ctx, &node.limit)
                || node
                    .step
                    .as_ref()
                    .is_some_and(|expr| expr_has_setfenv(ctx, expr))
                || block_has_setfenv(ctx, &node.block)
        }
        Stmt::GenericFor(node) => {
            node.exprs.iter().any(|expr| expr_has_setfenv(ctx, expr))
                || block_has_setfenv(ctx, &node.block)
        }
        Stmt::Return(node) => node.values.iter().any(|expr| expr_has_setfenv(ctx, expr)),
        // Nested functions own their environment semantics and are checked separately.
        Stmt::Function(_) | Stmt::LocalFunction(_) => false,
        _ => false,
    })
}

fn resolve_env_start(ctx: &Ctx<'_>, block: &Block, inherited_env: bool) -> Option<usize> {
    if block_has_setfenv(ctx, block) {
        return None;
    }
    let usage_index = build_usage_index(ctx, block);
    let own = block.stmts.iter().enumerate().find_map(|(index, stmt)| {
        let (binding, init) = local_single(stmt)?;
        (ctx.text(binding.name) == Some("_env") && direct_call_named_no_args(ctx, init, "getfenv"))
            .then_some(index)
    });
    if let Some(index) = own {
        let range = ctx.stmt_range(&block.stmts[index])?;
        let usage = usage_index.usage_after("_env", range.end);
        if usage.writes != 0 || usage.redeclared {
            return None;
        }
        return Some(range.end);
    }
    if !inherited_env {
        return None;
    }
    let usage = usage_index.usage_after("_env", 0);
    if usage.writes != 0 || usage.redeclared {
        return None;
    }
    Some(0)
}

