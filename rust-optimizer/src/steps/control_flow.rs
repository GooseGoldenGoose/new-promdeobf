#[derive(Debug, Clone)]
struct ShortProgram {
    result_name: String,
    expression: String,
    names: HashSet<String>,
}

#[derive(Debug, Clone)]
struct ProgramProducer {
    expression: String,
    truth_name: String,
    names: HashSet<String>,
    next_index: usize,
}

fn unary_is_not_name(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> bool {
    match expr {
        Expr::Unary { op, operand, .. } => {
            ctx.text(*op) == Some("not") && name_of_expr(ctx, unwrap_parens(operand)) == Some(name)
        }
        _ => false,
    }
}

fn single_if<'a>(stmt: &'a Stmt) -> Option<(&'a Expr, &'a Block)> {
    let Stmt::If(node) = stmt else {
        return None;
    };
    if node.branches.len() != 1 || node.else_block.is_some() {
        return None;
    }
    Some((&node.branches[0].0, &node.branches[0].1))
}

fn single_assignment_to<'a>(ctx: &Ctx<'_>, stmt: &'a Stmt, target: &str) -> Option<&'a Expr> {
    let (lhs, rhs) = assignment_single(stmt)?;
    (name_of_expr(ctx, lhs) == Some(target)).then_some(rhs)
}

fn local_uninitialized_name<'a>(ctx: &'a Ctx<'_>, stmt: &Stmt) -> Option<&'a str> {
    let binding = local_uninitialized(stmt)?;
    ctx.text(binding.name)
}

fn collect_name_ranges(
    expr: &Expr,
    ctx: &Ctx<'_>,
    wanted: &HashSet<String>,
    out: &mut Vec<(Range<usize>, String)>,
) {
    match expr {
        Expr::Name(span) => {
            if let Some(name) = ctx.text(*span) {
                if wanted.contains(name) {
                    if let Some(r) = ctx.range(*span) {
                        out.push((r, name.to_string()));
                    }
                }
            }
        }
        Expr::Function { .. } => {}
        Expr::Table { fields, .. } => {
            for f in fields {
                match f {
                    TableField::Positional(v) => collect_name_ranges(v, ctx, wanted, out),
                    TableField::Named { value, .. } => collect_name_ranges(value, ctx, wanted, out),
                    TableField::Computed { key, value } => {
                        collect_name_ranges(key, ctx, wanted, out);
                        collect_name_ranges(value, ctx, wanted, out);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_name_ranges(lhs, ctx, wanted, out);
            collect_name_ranges(rhs, ctx, wanted, out);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => collect_name_ranges(operand, ctx, wanted, out),
        Expr::Index { object, key, .. } => {
            collect_name_ranges(object, ctx, wanted, out);
            if let IndexKey::Computed(k) = key {
                collect_name_ranges(k, ctx, wanted, out);
            }
        }
        Expr::Call { func, args, .. } => {
            collect_name_ranges(func, ctx, wanted, out);
            match args {
                CallArgs::Paren(v) => {
                    for e in v {
                        collect_name_ranges(e, ctx, wanted, out)
                    }
                }
                CallArgs::Table(e) => collect_name_ranges(e, ctx, wanted, out),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                collect_name_ranges(a, ctx, wanted, out);
                collect_name_ranges(b, ctx, wanted, out);
            }
            collect_name_ranges(else_value, ctx, wanted, out);
        }
        _ => {}
    }
}

fn render_expr_with_defs<'a>(
    ctx: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    use_counts: &mut HashMap<String, usize>,
    stack: &mut HashSet<String>,
) -> Option<String> {
    let base_range = ctx.range(expr.span())?;
    let mut hits = Vec::new();
    let wanted = defs.keys().cloned().collect::<HashSet<_>>();
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
        let rendered = render_expr_with_defs(ctx, *defs.get(&name)?, defs, use_counts, stack)?;
        stack.remove(&name);
        replacements.push((
            range.start - base_range.start,
            range.end - base_range.start,
            format!("({rendered})"),
        ));
    }
    replacements.sort_by_key(|x| x.0);
    let mut text = ctx.src.get(base_range)?.to_string();
    for (start, end, repl) in replacements.into_iter().rev() {
        text.replace_range(start..end, &repl);
    }
    Some(text)
}

fn build_leaf_expression(
    ctx: &Ctx<'_>,
    statements: &[Stmt],
    result_temp: &str,
) -> Option<(String, HashSet<String>)> {
    if statements.is_empty() {
        return None;
    }
    let mut defs: HashMap<String, &Expr> = HashMap::new();
    let mut order = Vec::new();
    for stmt in statements {
        let (binding, init) = local_single(stmt)?;
        let name = ctx.text(binding.name)?.to_string();
        if defs.insert(name.clone(), init).is_some() {
            return None;
        }
        order.push(name);
    }
    let final_expr = *defs.get(result_temp)?;
    for name in &order {
        if name == result_temp {
            continue;
        }
        let def = *defs.get(name)?;
        if !is_pure_literal(def) && !matches!(def, Expr::Name(_)) {
            return None;
        }
    }
    let mut counts = HashMap::new();
    let mut stack = HashSet::from([result_temp.to_string()]);
    let rendered = render_expr_with_defs(ctx, final_expr, &defs, &mut counts, &mut stack)?;
    for name in &order {
        if name == result_temp {
            continue;
        }
        let count = *counts.get(name).unwrap_or(&0);
        if count == 0 {
            return None;
        }
        if count != 1 && !is_pure_literal(*defs.get(name)?) {
            return None;
        }
    }
    Some((rendered, order.into_iter().collect()))
}

fn parse_short_program(
    ctx: &Ctx<'_>,
    statements: &[Stmt],
    expected: Option<&str>,
) -> Option<ShortProgram> {
    if statements.len() < 2 {
        return None;
    }
    let mut cursor = 0usize;
    let mut result_name = expected.map(str::to_string);
    if let Some(name) = local_uninitialized_name(ctx, &statements[0]) {
        if expected.is_none() || expected == Some(name) {
            result_name = Some(name.to_string());
            cursor += 1;
        }
    }
    let result_name = result_name?;
    let producer = parse_program_producer(ctx, statements, cursor, &result_name)?;
    let mut names = producer.names.clone();
    names.insert(result_name.clone());
    if producer.next_index == statements.len() {
        return Some(ShortProgram {
            result_name,
            expression: producer.expression,
            names,
        });
    }
    if producer.next_index + 1 != statements.len() {
        return None;
    }
    let (cond, body) = single_if(&statements[producer.next_index])?;
    let operator = if name_of_expr(ctx, cond) == Some(producer.truth_name.as_str()) {
        "and"
    } else if unary_is_not_name(ctx, cond, &producer.truth_name) {
        "or"
    } else {
        return None;
    };
    let right = parse_short_program(ctx, &body.stmts, Some(&result_name))?;
    names.extend(right.names);
    Some(ShortProgram {
        result_name,
        expression: format!(
            "({}) {operator} ({})",
            producer.expression, right.expression
        ),
        names,
    })
}

fn parse_program_producer(
    ctx: &Ctx<'_>,
    statements: &[Stmt],
    start: usize,
    result_name: &str,
) -> Option<ProgramProducer> {
    if start >= statements.len() {
        return None;
    }
    for assign_index in (start + 1)..statements.len() {
        let Some(rhs) = single_assignment_to(ctx, &statements[assign_index], result_name) else {
            continue;
        };
        let truth = name_of_expr(ctx, rhs)?.to_string();
        let prefix = &statements[start..assign_index];
        if prefix.is_empty() {
            continue;
        }
        if let Some((expr, names)) = build_leaf_expression(ctx, prefix, &truth) {
            return Some(ProgramProducer {
                expression: expr,
                truth_name: truth,
                names,
                next_index: assign_index + 1,
            });
        }
        if let Some(nested) = parse_short_program(ctx, prefix, Some(&truth)) {
            return Some(ProgramProducer {
                expression: nested.expression,
                truth_name: truth,
                names: nested.names,
                next_index: assign_index + 1,
            });
        }
    }
    None
}

fn is_break_guard(ctx: &Ctx<'_>, stmt: &Stmt, result: &str) -> bool {
    let Some((cond, body)) = single_if(stmt) else {
        return false;
    };
    unary_is_not_name(ctx, cond, result)
        && body.stmts.len() == 1
        && matches!(body.stmts[0], Stmt::Break(_))
}

fn expr_signature(ctx: &Ctx<'_>, expr: &Expr) -> String {
    match expr {
        Expr::Nil(_) => "nil".into(),
        Expr::True(_) => "true".into(),
        Expr::False(_) => "false".into(),
        Expr::Vararg(_) => "...".into(),
        Expr::Number(s) => format!("num:{}", ctx.text(*s).unwrap_or("")),
        Expr::String(s) => format!("str:{}", ctx.text(*s).unwrap_or("")),
        Expr::Name(s) => format!("name:{}", ctx.text(*s).unwrap_or("")),
        Expr::Paren { inner, .. } => expr_signature(ctx, inner),
        Expr::Unary { op, operand, .. } => format!(
            "u:{}:{}",
            ctx.text(*op).unwrap_or(""),
            expr_signature(ctx, operand)
        ),
        Expr::Binary { op, lhs, rhs, .. } => format!(
            "b:{}:{}:{}",
            ctx.text(*op).unwrap_or(""),
            expr_signature(ctx, lhs),
            expr_signature(ctx, rhs)
        ),
        Expr::Index { object, key, .. } => format!(
            "idx:{}:{}",
            expr_signature(ctx, object),
            match key {
                IndexKey::Field(s) => ctx.text(*s).unwrap_or("").into(),
                IndexKey::Computed(e) => expr_signature(ctx, e),
            }
        ),
        Expr::Call {
            func, method, args, ..
        } => format!(
            "call:{}:{}:{}",
            expr_signature(ctx, func),
            method.and_then(|s| ctx.text(s)).unwrap_or(""),
            match args {
                CallArgs::Paren(v) => v
                    .iter()
                    .map(|e| expr_signature(ctx, e))
                    .collect::<Vec<_>>()
                    .join(","),
                CallArgs::Table(e) => expr_signature(ctx, e),
                CallArgs::Str(s) => ctx.text(*s).unwrap_or("").into(),
            }
        ),
        Expr::Table { fields, .. } => format!("table:{}", fields.len()),
        Expr::Function { .. } => "fn".into(),
        Expr::IfElse { .. } => "ifexpr".into(),
        Expr::TypeAssert { expr, .. } => expr_signature(ctx, expr),
        Expr::InterpString(s) => format!("interp:{}", ctx.text(*s).unwrap_or("")),
    }
}

fn generated_expression_signature(text: &str) -> Option<String> {
    let src = format!("return {text}");
    let parsed = eclipse_luau::parse_one(&src).ok()?;
    let ret = match parsed.chunk.block.stmts.first()? {
        Stmt::Return(r) => r,
        _ => return None,
    };
    let expr = ret.values.first()?;
    let ctx = Ctx {
        src: &src,
        toks: &parsed.lexed.toks,
        comments: &parsed.lexed.comments,
        nested_writer_cache: RefCell::new(HashMap::new()),
        direct_decl_cache: RefCell::new(HashMap::new()),
        edit_intervals: RefCell::new(BTreeMap::new()),
    };
    Some(expr_signature(&ctx, expr))
}
fn assigned_branch_expression(ctx: &Ctx<'_>, body: &Block, result: &str) -> Option<String> {
    let last = body.stmts.last()?;
    let rhs = single_assignment_to(ctx, last, result)?;
    if expr_contains_name(ctx, rhs, result) {
        return None;
    }
    if body.stmts.len() == 1 {
        return ctx.expr_text(rhs).map(str::to_string);
    }
    let prefix = &body.stmts[..body.stmts.len() - 1];
    if prefix.iter().any(|s| stmt_contains_name(ctx, s, result)) {
        return None;
    }

    // Existing compiler-leaf form: branch locals end in a temp assigned to result.
    if let Some(rhs_name) = name_of_expr(ctx, rhs) {
        if let Some((rendered, _)) = build_leaf_expression(ctx, prefix, rhs_name) {
            return Some(rendered);
        }
    }

    // Also recover a single simple branch-local snapshot used inside the final RHS,
    // e.g. `local t = table; result = t["unpack"]`. For identifier snapshots the
    // use must be in leading evaluation position so moving the read cannot cross an
    // earlier effect. Literal snapshots are effect-free and may occur anywhere.
    if prefix.len() != 1 {
        return None;
    }
    let (binding, init) = local_single(&prefix[0])?;
    let alias = ctx.text(binding.name)?.to_string();
    if alias == result || (!is_pure_literal(init) && !matches!(init, Expr::Name(_))) {
        return None;
    }
    let mut hits = Vec::new();
    let wanted = HashSet::from([alias.clone()]);
    collect_name_ranges(rhs, ctx, &wanted, &mut hits);
    if hits.len() != 1 {
        return None;
    }
    let alias_range = hits[0].0.clone();
    if matches!(init, Expr::Name(_)) && !expr_leading_use(ctx, rhs, &alias_range) {
        return None;
    }
    let defs = HashMap::from([(alias.clone(), init)]);
    let mut counts = HashMap::new();
    let mut stack = HashSet::new();
    let rendered = render_expr_with_defs(ctx, rhs, &defs, &mut counts, &mut stack)?;
    (counts.get(&alias).copied() == Some(1)).then_some(rendered)
}

fn render_single_leading_name_substitution(
    ctx: &Ctx<'_>,
    outer: &Expr,
    name: &str,
    replacement: &Expr,
) -> Option<String> {
    let wanted = HashSet::from([name.to_string()]);
    let mut hits = Vec::new();
    collect_name_ranges(outer, ctx, &wanted, &mut hits);
    if hits.len() != 1 || !expr_leading_use(ctx, outer, &hits[0].0) {
        return None;
    }
    let outer_range = ctx.range(outer.span())?;
    let hit = &hits[0].0;
    if hit.start < outer_range.start || hit.end > outer_range.end {
        return None;
    }
    let raw = ctx.expr_text(replacement)?;
    let rendered = match unwrap_parens(replacement) {
        Expr::Name(_)
        | Expr::Index { .. }
        | Expr::Nil(_)
        | Expr::True(_)
        | Expr::False(_)
        | Expr::Number(_)
        | Expr::String(_) => raw.to_string(),
        _ => format!("({raw})"),
    };
    let mut text = ctx.src.get(outer_range.clone())?.to_string();
    text.replace_range(
        (hit.start - outer_range.start)..(hit.end - outer_range.start),
        &rendered,
    );
    Some(text)
}

fn collect_conditional_value_coalesce(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    edits: &mut Vec<Edit>,
) {
    for i in 0..block.stmts.len().saturating_sub(4) {
        let Some((holder_binding, holder_init)) = local_single(&block.stmts[i]) else {
            continue;
        };
        let Some((seed_binding, seed_expr)) = local_single(&block.stmts[i + 1]) else {
            continue;
        };
        let Some((result_binding, result_init)) = local_single(&block.stmts[i + 2]) else {
            continue;
        };
        let Some((cond, body)) = single_if(&block.stmts[i + 3]) else {
            continue;
        };
        let Some((final_target, final_rhs)) = assignment_single(&block.stmts[i + 4]) else {
            continue;
        };

        let holder = ctx.text(holder_binding.name).unwrap_or("");
        let seed = ctx.text(seed_binding.name).unwrap_or("");
        let result = ctx.text(result_binding.name).unwrap_or("");
        if holder.is_empty()
            || seed.is_empty()
            || result.is_empty()
            || holder == seed
            || holder == result
            || seed == result
            || name_of_expr(ctx, result_init) != Some(seed)
            || name_of_expr(ctx, unwrap_parens(cond)) != Some(seed)
            || name_of_expr(ctx, final_target) != Some(holder)
            || name_of_expr(ctx, final_rhs) != Some(result)
            || body.stmts.len() != 2
        {
            continue;
        }

        let Some((branch_holder_target, branch_source)) = assignment_single(&body.stmts[0]) else {
            continue;
        };
        let Some((branch_result_target, branch_expr)) = assignment_single(&body.stmts[1]) else {
            continue;
        };
        if name_of_expr(ctx, branch_holder_target) != Some(holder)
            || name_of_expr(ctx, branch_result_target) != Some(result)
            || expr_contains_name(ctx, holder_init, holder)
            || expr_contains_name(ctx, branch_source, holder)
            || expr_contains_name(ctx, branch_source, seed)
            || expr_contains_name(ctx, branch_source, result)
            || expr_contains_name(ctx, branch_expr, seed)
            || expr_contains_name(ctx, branch_expr, result)
        {
            continue;
        }

        let (Some(seed_stmt_range), Some(result_stmt_range), Some(final_stmt_range)) = (
            ctx.stmt_range(&block.stmts[i + 1]),
            ctx.stmt_range(&block.stmts[i + 2]),
            ctx.stmt_range(&block.stmts[i + 4]),
        ) else {
            continue;
        };
        let seed_usage = usage_index.usage_after(seed, seed_stmt_range.end);
        let result_usage = usage_index.usage_after(result, result_stmt_range.end);
        let Some(result_seed_range) = ctx.range(result_init.span()) else {
            continue;
        };
        let Expr::Name(cond_span) = unwrap_parens(cond) else {
            continue;
        };
        let Some(cond_range) = ctx.range(*cond_span) else {
            continue;
        };
        let Some(final_result_range) = ctx.range(final_rhs.span()) else {
            continue;
        };
        if seed_usage.reads.len() != 2
            || seed_usage.writes != 0
            || seed_usage.redeclared
            || seed_usage.captured
            || !seed_usage
                .reads
                .iter()
                .all(|r| *r == result_seed_range || *r == cond_range)
            || result_usage.reads.len() != 1
            || result_usage.reads[0] != final_result_range
            || result_usage.writes != 1
            || result_usage.redeclared
            || result_usage.captured
        {
            continue;
        }

        let Some(seed_rendered) =
            render_single_leading_name_substitution(ctx, seed_expr, holder, holder_init)
        else {
            continue;
        };
        let Some(branch_rendered) =
            render_single_leading_name_substitution(ctx, branch_expr, holder, branch_source)
        else {
            continue;
        };
        let Some(start) = ctx.stmt_range(&block.stmts[i]) else {
            continue;
        };
        let line_start = ctx.src[..start.start].rfind('\n').map(|pos| pos + 1).unwrap_or(0);
        let indent = &ctx.src[line_start..start.start];
        let replacement = format!(
            "local {holder} = {seed_rendered}\n{indent}if {holder} then\n{indent}    {holder} = {branch_rendered}\n{indent}end"
        );
        if add_edit(
            ctx,
            edits,
            Edit {
                start: start.start,
                end: final_stmt_range.end,
                replacement,
                kind: EditKind::CopyChain,
            },
        ) {
            return;
        }
    }
}

fn collect_value_short_circuit(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    edits: &mut Vec<Edit>,
) {
    for result_index in 0..block.stmts.len().saturating_sub(1) {
        let Some((binding, seed_expr)) = local_single(&block.stmts[result_index]) else {
            continue;
        };
        let Some(seed) = name_of_expr(ctx, seed_expr) else {
            continue;
        };
        if !direct_local_declared_before(ctx, block, result_index, seed) {
            continue;
        }
        let result = ctx.text(binding.name).unwrap_or("");
        let Some((cond, body)) = single_if(&block.stmts[result_index + 1]) else {
            continue;
        };
        let op = if name_of_expr(ctx, cond) == Some(seed) {
            "and"
        } else if unary_is_not_name(ctx, cond, seed) {
            "or"
        } else {
            continue;
        };
        let Some(right) = assigned_branch_expression(ctx, body, result) else {
            continue;
        };
        let mut start_index = result_index;
        let mut left = seed.to_string();
        if result_index > 0 {
            if let Some((producer_binding, producer_init)) =
                local_single(&block.stmts[result_index - 1])
            {
                if ctx.text(producer_binding.name) == Some(seed) {
                    if let Some(prod_range) = ctx.stmt_range(&block.stmts[result_index - 1]) {
                        let usage = usage_index.usage_after(seed, prod_range.end);
                        let cond_name_span = match cond {
                            Expr::Name(s) => Some(*s),
                            Expr::Unary { operand, .. } => match unwrap_parens(operand) {
                                Expr::Name(s) => Some(*s),
                                _ => None,
                            },
                            _ => None,
                        };
                        if let (Some(seed_range), Some(cond_span)) = (
                            ctx.range(seed_expr.span()),
                            cond_name_span.and_then(|s| ctx.range(s)),
                        ) {
                            if usage.reads.len() == 2
                                && usage.writes == 0
                                && !usage.redeclared
                                && !usage.captured
                                && usage
                                    .reads
                                    .iter()
                                    .all(|r| *r == seed_range || *r == cond_span)
                            {
                                start_index = result_index - 1;
                                left = ctx.expr_text(producer_init).unwrap_or(seed).to_string();
                            }
                        }
                    }
                }
            }
        }
        let (Some(start), Some(end)) = (
            ctx.stmt_range(&block.stmts[start_index]),
            ctx.stmt_range(&block.stmts[result_index + 1]),
        ) else {
            continue;
        };
        if add_edit(
            ctx,
            edits,
            Edit {
                start: start.start,
                end: end.end,
                replacement: format!("local {result} = ({left}) {op} ({right})"),
                kind: EditKind::ValueShortCircuit,
            },
        ) {
            // Structural ladder rewrites are intentionally one-at-a-time. A later
            // ladder can depend on the value produced by this one and may absorb
            // its producer on the next scoped parse.
            return;
        }
    }
}

fn collect_loop_short_circuit(ctx: &Ctx<'_>, block: &Block, edits: &mut Vec<Edit>) {
    for stmt in &block.stmts {
        if let Stmt::While(node) = stmt {
            if !matches!(node.cond, Expr::True(_)) {
                continue;
            }
            let body = &node.block.stmts;
            for split in 2..body.len() {
                let Some(parsed) = parse_short_program(ctx, &body[..split], None) else {
                    continue;
                };
                if !is_break_guard(ctx, &body[split], &parsed.result_name) {
                    continue;
                }
                if body[(split + 1)..]
                    .iter()
                    .any(|s| parsed.names.iter().any(|n| stmt_contains_name(ctx, s, n)))
                {
                    continue;
                }
                let (Some(cond_range), Some(first), Some(guard)) = (
                    ctx.range(node.cond.span()),
                    ctx.stmt_range(&body[0]),
                    ctx.stmt_range(&body[split]),
                ) else {
                    continue;
                };
                if add_group(
                    ctx,
                    edits,
                    vec![
                        Edit {
                            start: cond_range.start,
                            end: cond_range.end,
                            replacement: parsed.expression,
                            kind: EditKind::WhileCondition,
                        },
                        Edit {
                            start: first.start,
                            end: guard.end,
                            replacement: String::new(),
                            kind: EditKind::ShortCircuit,
                        },
                    ],
                ) {
                    break;
                }
            }
        }
        if let Stmt::Repeat(node) = stmt {
            let Some(result_name) = name_of_expr(ctx, &node.cond) else {
                continue;
            };
            let body = &node.block.stmts;
            for start in 0..body.len() {
                let Some(parsed) = parse_short_program(ctx, &body[start..], Some(result_name))
                else {
                    continue;
                };
                let (Some(first), Some(last), Some(cond_range)) = (
                    ctx.stmt_range(&body[start]),
                    ctx.stmt_range(body.last().unwrap()),
                    ctx.range(node.cond.span()),
                ) else {
                    continue;
                };
                if add_group(
                    ctx,
                    edits,
                    vec![
                        Edit {
                            start: first.start,
                            end: last.end,
                            replacement: String::new(),
                            kind: EditKind::ShortCircuit,
                        },
                        Edit {
                            start: cond_range.start,
                            end: cond_range.end,
                            replacement: parsed.expression,
                            kind: EditKind::RepeatCondition,
                        },
                    ],
                ) {
                    break;
                }
            }
        }
    }
}

fn discarded_branch_matches(ctx: &Ctx<'_>, body: &Block, wanted: &Expr) -> bool {
    let wanted_sig = expr_signature(ctx, wanted);
    if body.stmts.len() == 1 {
        match &body.stmts[0] {
            Stmt::Call(e, _) => return expr_signature(ctx, e) == wanted_sig,
            Stmt::Local(n) if n.values.len() == 1 => {
                return expr_signature(ctx, &n.values[0]) == wanted_sig;
            }
            _ => {}
        }
    }
    let Some(parsed) = parse_short_program(ctx, &body.stmts, None) else {
        return false;
    };
    generated_expression_signature(&parsed.expression).is_some_and(|sig| sig == wanted_sig)
}

fn collect_repeat_precheck(ctx: &Ctx<'_>, block: &Block, edits: &mut Vec<Edit>) {
    for repeat_index in 0..block.stmts.len() {
        let Stmt::Repeat(repeat) = &block.stmts[repeat_index] else {
            continue;
        };
        let Expr::Binary { op, lhs, rhs, .. } = &repeat.cond else {
            continue;
        };
        let operator = ctx.text(*op).unwrap_or("");
        if operator != "and" && operator != "or" {
            continue;
        }
        for if_index in (1..repeat_index).rev() {
            let Some((cond, body)) = single_if(&block.stmts[if_index]) else {
                continue;
            };
            let temp = if operator == "and" {
                name_of_expr(ctx, cond)
            } else {
                match cond {
                    Expr::Unary { operand, .. }
                        if ctx.text(match cond {
                            Expr::Unary { op, .. } => *op,
                            _ => unreachable!(),
                        }) == Some("not") =>
                    {
                        name_of_expr(ctx, operand)
                    }
                    _ => None,
                }
            };
            let Some(temp) = temp else {
                continue;
            };
            if !discarded_branch_matches(ctx, body, rhs) {
                continue;
            }
            for left_index in (0..if_index).rev() {
                let Some((binding, init)) = local_single(&block.stmts[left_index]) else {
                    continue;
                };
                if ctx.text(binding.name) != Some(temp)
                    || expr_signature(ctx, init) != expr_signature(ctx, lhs)
                {
                    continue;
                }
                if block.stmts[(left_index + 1)..if_index]
                    .iter()
                    .any(|s| stmt_contains_name(ctx, s, temp))
                    || block.stmts[(if_index + 1)..repeat_index]
                        .iter()
                        .any(|s| stmt_contains_name(ctx, s, temp))
                {
                    continue;
                }
                let (Some(a), Some(b)) = (
                    ctx.stmt_range(&block.stmts[left_index]),
                    ctx.stmt_range(&block.stmts[if_index]),
                ) else {
                    continue;
                };
                if add_group(
                    ctx,
                    edits,
                    vec![
                        Edit {
                            start: a.start,
                            end: a.end,
                            replacement: String::new(),
                            kind: EditKind::RepeatPrecheck,
                        },
                        Edit {
                            start: b.start,
                            end: b.end,
                            replacement: String::new(),
                            kind: EditKind::RepeatPrecheck,
                        },
                    ],
                ) {
                    break;
                }
            }
        }
    }
}
