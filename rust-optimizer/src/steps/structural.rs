fn collect_low_risk_structural(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    edits: &mut Vec<Edit>,
    outer_lexical: &HashSet<String>,
) {
    for i in 0..block.stmts.len() {
        // Non-adjacent deferred local initialization with no intervening observation.
        if let Some(binding) = local_uninitialized(&block.stmts[i]) {
            let Some(name) = ctx.text(binding.name) else {
                continue;
            };
            let Some(decl_range) = ctx.stmt_range(&block.stmts[i]) else {
                continue;
            };
            // The usage index already contains every nested observation. The first
            // occurrence after `local x` must be the direct assignment write; otherwise
            // the old forward scan would stop before folding too.
            let first = usage_index.by_name.get(name).and_then(|items| {
                items
                    .iter()
                    .filter(|item| item.pos > decl_range.end)
                    .min_by_key(|item| item.pos)
            });
            if let Some(first) = first {
                if first.kind == OccKind::Write {
                    if let Some(first_range) = &first.range {
                        if let Some(j) =
                            direct_statement_index_containing(ctx, block, i + 1, first_range)
                        {
                            if let Some((target, value)) = assignment_single(&block.stmts[j]) {
                                if name_of_expr(ctx, target) == Some(name)
                                    && !expr_contains_name(ctx, value, name)
                                {
                                    if let (Some(assign_range), Some(value_text)) =
                                        (ctx.stmt_range(&block.stmts[j]), ctx.expr_text(value))
                                    {
                                        add_group(
                                            ctx,
                                            edits,
                                            vec![
                                                Edit {
                                                    start: decl_range.start,
                                                    end: decl_range.end,
                                                    replacement: String::new(),
                                                    kind: EditKind::DeferredLocal,
                                                },
                                                Edit {
                                                    start: assign_range.start,
                                                    end: assign_range.end,
                                                    replacement: format!(
                                                        "local {name} = {value_text}"
                                                    ),
                                                    kind: EditKind::DeferredLocal,
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
        }

        if i + 1 >= block.stmts.len() {
            continue;
        }
        let next = &block.stmts[i + 1];

        // Opaque adjacent copy chain: local t = expr; local x = t -> local x = expr.
        if let (Some((producer_binding, producer_init)), Some((consumer_binding, consumer_init))) =
            (local_single(&block.stmts[i]), local_single(next))
        {
            let producer_name = ctx.text(producer_binding.name).unwrap_or("");
            let consumer_name = ctx.text(consumer_binding.name).unwrap_or("");
            if !matches!(
                producer_init,
                Expr::Nil(_)
                    | Expr::True(_)
                    | Expr::False(_)
                    | Expr::Number(_)
                    | Expr::String(_)
                    | Expr::Name(_)
            ) && name_of_expr(ctx, consumer_init) == Some(producer_name)
            {
                if let (Some(producer_stmt_range), Some(producer_name_range), Some(next_range)) = (
                    ctx.stmt_range(&block.stmts[i]),
                    ctx.range(producer_binding.name),
                    ctx.stmt_range(next),
                ) {
                    if usage_is_single_next_read(
                        ctx,
                        usage_index,
                        producer_name,
                        &producer_stmt_range,
                        next,
                        consumer_init.span(),
                    ) {
                        add_group(
                            ctx,
                            edits,
                            vec![
                                Edit {
                                    start: producer_name_range.start,
                                    end: producer_name_range.end,
                                    replacement: consumer_name.to_string(),
                                    kind: EditKind::CopyChain,
                                },
                                Edit {
                                    start: next_range.start,
                                    end: next_range.end,
                                    replacement: String::new(),
                                    kind: EditKind::CopyChain,
                                },
                            ],
                        );
                    }
                }
            }
        }

        // Prometheus self-key overwrite: local base = source; local key = scalar;
        // key = base[key] -> local key = source[scalar]. The source snapshot is
        // evaluated before the scalar in both forms, and the base must have no
        // other observable use.
        if i + 2 < block.stmts.len() {
            if let (
                Some((base_binding, base_init)),
                Some((key_binding, key_init)),
                Some((target, value)),
            ) = (
                local_single(&block.stmts[i]),
                local_single(&block.stmts[i + 1]),
                assignment_single(&block.stmts[i + 2]),
            ) {
                if let Expr::Name(source_span) = base_init {
                    let base_name = ctx.text(base_binding.name).unwrap_or("");
                    let key_name = ctx.text(key_binding.name).unwrap_or("");
                    if !base_name.is_empty()
                        && !key_name.is_empty()
                        && name_of_expr(ctx, target) == Some(key_name)
                        && is_scalar_temp_expr(key_init)
                    {
                        if let Expr::Index {
                            object,
                            key: IndexKey::Computed(index),
                            ..
                        } = value
                        {
                            if name_of_expr(ctx, object) == Some(base_name)
                                && name_of_expr(ctx, index) == Some(key_name)
                            {
                                if let (
                                    Some(base_stmt_range),
                                    Some(key_stmt_range),
                                    Some(assign_range),
                                    Some(object_range),
                                    Some(source_text),
                                    Some(key_text),
                                ) = (
                                    ctx.stmt_range(&block.stmts[i]),
                                    ctx.stmt_range(&block.stmts[i + 1]),
                                    ctx.stmt_range(&block.stmts[i + 2]),
                                    ctx.range(object.span()),
                                    ctx.text(*source_span),
                                    ctx.expr_text(key_init),
                                ) {
                                    let base_usage =
                                        usage_index.usage_after(base_name, base_stmt_range.end);
                                    if base_usage.reads.len() == 1
                                        && base_usage.writes == 0
                                        && !base_usage.redeclared
                                        && !base_usage.captured
                                        && base_usage.reads[0] == object_range
                                    {
                                        add_group(
                                            ctx,
                                            edits,
                                            vec![
                                                Edit {
                                                    start: base_stmt_range.start,
                                                    end: base_stmt_range.end,
                                                    replacement: String::new(),
                                                    kind: EditKind::AssignmentKeyInline,
                                                },
                                                Edit {
                                                    start: key_stmt_range.start,
                                                    end: key_stmt_range.end,
                                                    replacement: format!(
                                                        "local {key_name} = {source_text}[{key_text}]"
                                                    ),
                                                    kind: EditKind::AssignmentKeyInline,
                                                },
                                                Edit {
                                                    start: assign_range.start,
                                                    end: assign_range.end,
                                                    replacement: String::new(),
                                                    kind: EditKind::AssignmentKeyInline,
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
        }
        // Adjacent base alias: local t = math; local f = t["random"], or
        // local t = Enum.EasingStyle; local f = t.Circular. No effect is crossed.
        if let (Some((producer_binding, producer_init)), Some((_consumer_binding, consumer_init))) =
            (local_single(&block.stmts[i]), local_single(next))
        {
            if matches!(producer_init, Expr::Name(_) | Expr::Index { .. }) {
                if let Expr::Index { object, .. } = consumer_init {
                    if let Expr::Name(base_span) = object.as_ref() {
                        let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                        if ctx.text(*base_span) == Some(producer_name) {
                            if let (Some(stmt_range), Some(base_range), Some(source_text)) = (
                                ctx.stmt_range(&block.stmts[i]),
                                ctx.range(*base_span),
                                ctx.expr_text(producer_init),
                            ) {
                                if usage_is_single_next_read(
                                    ctx,
                                    usage_index,
                                    producer_name,
                                    &stmt_range,
                                    next,
                                    *base_span,
                                ) {
                                    add_group(
                                        ctx,
                                        edits,
                                        vec![
                                            Edit {
                                                start: stmt_range.start,
                                                end: stmt_range.end,
                                                replacement: String::new(),
                                                kind: EditKind::IndexBaseAlias,
                                            },
                                            Edit {
                                                start: base_range.start,
                                                end: base_range.end,
                                                replacement: source_text.to_string(),
                                                kind: EditKind::IndexBaseAlias,
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

        // Prometheus indexed callee snapshot immediately before an if whose
        // condition starts with that exact call. Restoring the index lookup into
        // call-base position preserves lookup -> args -> call ordering.
        if i + 1 < block.stmts.len() {
            if let Some((producer_binding, producer_init)) = local_single(&block.stmts[i]) {
                if matches!(producer_init, Expr::Index { .. }) {
                    if let Stmt::If(node) = &block.stmts[i + 1] {
                        if let Some((condition, _)) = node.branches.first() {
                            let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                            if let Some(base_span) =
                                leading_call_base_span(ctx, condition, producer_name)
                            {
                                if let (Some(stmt_range), Some(base_range), Some(value)) = (
                                    ctx.stmt_range(&block.stmts[i]),
                                    ctx.range(base_span),
                                    ctx.expr_text(producer_init),
                                ) {
                                    let usage =
                                        usage_index.usage_after(producer_name, stmt_range.end);
                                    if usage.reads.len() == 1
                                        && usage.writes == 0
                                        && !usage.redeclared
                                        && !usage.captured
                                        && usage.reads[0] == base_range
                                    {
                                        add_group(
                                            ctx,
                                            edits,
                                            vec![
                                                Edit {
                                                    start: stmt_range.start,
                                                    end: stmt_range.end,
                                                    replacement: String::new(),
                                                    kind: EditKind::IndexBaseAlias,
                                                },
                                                Edit {
                                                    start: base_range.start,
                                                    end: base_range.end,
                                                    replacement: value.to_string(),
                                                    kind: EditKind::IndexBaseAlias,
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
        }

        // Adjacent call-created index key: local k = decode(); local v = base[k].
        if let (Some((producer_binding, producer_init)), Some((_consumer_binding, consumer_init))) =
            (local_single(&block.stmts[i]), local_single(next))
        {
            if matches!(producer_init, Expr::Call { .. } | Expr::Index { .. })
                || is_scalar_temp_expr(producer_init)
            {
                if let Expr::Index {
                    object,
                    key: IndexKey::Computed(key),
                    ..
                } = consumer_init
                {
                    if let (Expr::Name(base_span), Expr::Name(key_span)) =
                        (object.as_ref(), key.as_ref())
                    {
                        let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                        let base_name = ctx.text(*base_span).unwrap_or("");
                        if ctx.text(*key_span) == Some(producer_name)
                            && name_is_immediate_stable_lexical(
                                ctx,
                                block,
                                i,
                                base_name,
                                outer_lexical,
                            )
                        {
                            if let (Some(stmt_range), Some(key_range), Some(value)) = (
                                ctx.stmt_range(&block.stmts[i]),
                                ctx.range(*key_span),
                                ctx.expr_text(producer_init),
                            ) {
                                if usage_is_single_next_read(
                                    ctx,
                                    usage_index,
                                    producer_name,
                                    &stmt_range,
                                    next,
                                    *key_span,
                                ) {
                                    add_group(
                                        ctx,
                                        edits,
                                        vec![
                                            Edit {
                                                start: stmt_range.start,
                                                end: stmt_range.end,
                                                replacement: String::new(),
                                                kind: EditKind::IndexKeyInline,
                                            },
                                            Edit {
                                                start: key_range.start,
                                                end: key_range.end,
                                                replacement: value.to_string(),
                                                kind: EditKind::IndexKeyInline,
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

        // Adjacent same-index read/modify/write: local old = base["k"];
        // base["k"] = old - 1. The base must be a stable lexical binding and the
        // exact same key must be a pure literal, so moving the indexed read into the
        // assignment RHS crosses only effect-free LHS base/key evaluation.
        if let Some((producer_binding, producer_init)) = local_single(&block.stmts[i]) {
            if let Expr::Index {
                object: producer_object,
                key: producer_key,
                ..
            } = producer_init
            {
                if let Stmt::Assign(assign) = next {
                    if assign.targets.len() == 1 && assign.values.len() == 1 {
                        if let Expr::Index {
                            object: target_object,
                            key: target_key,
                            ..
                        } = &assign.targets[0]
                        {
                            let same_key = match (producer_key, target_key) {
                                (IndexKey::Field(a), IndexKey::Field(b)) => {
                                    ctx.text(*a) == ctx.text(*b)
                                }
                                (IndexKey::Computed(a), IndexKey::Computed(b)) => {
                                    is_pure_literal(a)
                                        && is_pure_literal(b)
                                        && expr_signature(ctx, a) == expr_signature(ctx, b)
                                }
                                _ => false,
                            };
                            if same_key {
                                if let (Expr::Name(producer_base), Expr::Name(target_base)) =
                                    (producer_object.as_ref(), target_object.as_ref())
                                {
                                    let base_name = ctx.text(*producer_base).unwrap_or("");
                                    let producer_name =
                                        ctx.text(producer_binding.name).unwrap_or("");
                                    if ctx.text(*target_base) == Some(base_name)
                                        && name_is_immediate_stable_lexical(
                                            ctx,
                                            block,
                                            i,
                                            base_name,
                                            outer_lexical,
                                        )
                                    {
                                        if let Some(stmt_range) = ctx.stmt_range(&block.stmts[i]) {
                                            let usage = usage_index
                                                .usage_after(producer_name, stmt_range.end);
                                            if usage.reads.len() == 1
                                                && usage.writes == 0
                                                && !usage.redeclared
                                                && !usage.captured
                                                && stmt_contains_range(ctx, next, &usage.reads[0])
                                                && expr_leading_use(
                                                    ctx,
                                                    &assign.values[0],
                                                    &usage.reads[0],
                                                )
                                            {
                                                if let Some(value) = ctx.expr_text(producer_init) {
                                                    add_group(
                                                        ctx,
                                                        edits,
                                                        vec![
                                                            Edit {
                                                                start: stmt_range.start,
                                                                end: stmt_range.end,
                                                                replacement: String::new(),
                                                                kind:
                                                                    EditKind::AssignmentValueInline,
                                                            },
                                                            Edit {
                                                                start: usage.reads[0].start,
                                                                end: usage.reads[0].end,
                                                                replacement: value.to_string(),
                                                                kind:
                                                                    EditKind::AssignmentValueInline,
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
                    }
                }
            }
        }

        // Adjacent assignment key: local k = source[idx]; target[k] = value.
        if let Some((producer_binding, producer_init)) = local_single(&block.stmts[i]) {
            if matches!(producer_init, Expr::Index { .. }) {
                if let Stmt::Assign(assign) = next {
                    if assign.targets.len() == 1 && assign.values.len() == 1 {
                        if let Expr::Index {
                            object,
                            key: IndexKey::Computed(key),
                            ..
                        } = &assign.targets[0]
                        {
                            if let (Expr::Name(base_span), Expr::Name(key_span)) =
                                (object.as_ref(), key.as_ref())
                            {
                                let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                                let base_name = ctx.text(*base_span).unwrap_or("");
                                if ctx.text(*key_span) == Some(producer_name)
                                    && name_is_immediate_stable_lexical(
                                        ctx,
                                        block,
                                        i,
                                        base_name,
                                        outer_lexical,
                                    )
                                {
                                    if let (Some(stmt_range), Some(key_range), Some(value)) = (
                                        ctx.stmt_range(&block.stmts[i]),
                                        ctx.range(*key_span),
                                        ctx.expr_text(producer_init),
                                    ) {
                                        if usage_is_single_next_read(
                                            ctx,
                                            usage_index,
                                            producer_name,
                                            &stmt_range,
                                            next,
                                            *key_span,
                                        ) {
                                            add_group(
                                                ctx,
                                                edits,
                                                vec![
                                                    Edit {
                                                        start: stmt_range.start,
                                                        end: stmt_range.end,
                                                        replacement: String::new(),
                                                        kind: EditKind::AssignmentKeyInline,
                                                    },
                                                    Edit {
                                                        start: key_range.start,
                                                        end: key_range.end,
                                                        replacement: value.to_string(),
                                                        kind: EditKind::AssignmentKeyInline,
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
            }
        }

        // One-field constructor key: local k = expr; local t = { [k] = literal }.
        if let (
            Some((producer_binding, producer_init)),
            Some((_consumer_binding, Expr::Table { fields, .. })),
        ) = (local_single(&block.stmts[i]), local_single(next))
        {
            if fields.len() == 1 {
                if let TableField::Computed { key, value } = &fields[0] {
                    if let Expr::Name(key_span) = key {
                        let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                        if ctx.text(*key_span) == Some(producer_name) && is_pure_literal(value) {
                            if let (Some(stmt_range), Some(key_range), Some(value_text)) = (
                                ctx.stmt_range(&block.stmts[i]),
                                ctx.range(*key_span),
                                ctx.expr_text(producer_init),
                            ) {
                                if usage_is_single_next_read(
                                    ctx,
                                    usage_index,
                                    producer_name,
                                    &stmt_range,
                                    next,
                                    *key_span,
                                ) {
                                    add_group(
                                        ctx,
                                        edits,
                                        vec![
                                            Edit {
                                                start: stmt_range.start,
                                                end: stmt_range.end,
                                                replacement: String::new(),
                                                kind: EditKind::TableConstructorKeyInline,
                                            },
                                            Edit {
                                                start: key_range.start,
                                                end: key_range.end,
                                                replacement: value_text.to_string(),
                                                kind: EditKind::TableConstructorKeyInline,
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

        // Returned call base: local f = maker(); return f(...).
        if let Some((producer_binding, producer_init)) = local_single(&block.stmts[i]) {
            if matches!(producer_init, Expr::Call { .. }) {
                if let Stmt::Return(ret) = next {
                    if ret.values.len() == 1 {
                        if let Expr::Call { func, .. } = &ret.values[0] {
                            if let Expr::Name(func_span) = func.as_ref() {
                                let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                                if ctx.text(*func_span) == Some(producer_name) {
                                    if let (Some(stmt_range), Some(func_range), Some(value)) = (
                                        ctx.stmt_range(&block.stmts[i]),
                                        ctx.range(*func_span),
                                        ctx.expr_text(producer_init),
                                    ) {
                                        if usage_is_single_next_read(
                                            ctx,
                                            usage_index,
                                            producer_name,
                                            &stmt_range,
                                            next,
                                            *func_span,
                                        ) {
                                            add_group(
                                                ctx,
                                                edits,
                                                vec![
                                                    Edit {
                                                        start: stmt_range.start,
                                                        end: stmt_range.end,
                                                        replacement: String::new(),
                                                        kind: EditKind::ReturnedCallBaseInline,
                                                    },
                                                    Edit {
                                                        start: func_range.start,
                                                        end: func_range.end,
                                                        replacement: format!("({value})"),
                                                        kind: EditKind::ReturnedCallBaseInline,
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
            }
        }
    }
    // Two-or-more plain constructor arguments feeding one call. Producers may be
    // separated by other effect-free setup locals; moving a fresh plain table across
    // those statements does not move any call/index/metamethod effect.
    for consumer_index in 1..block.stmts.len() {
        let Some(call) = call_expr_whole(&block.stmts[consumer_index]) else {
            continue;
        };
        let Some((_func, _method, call_args)) = call_parts(call) else {
            continue;
        };
        let Some(args) = paren_args(call_args) else {
            continue;
        };
        let mut producers = Vec::new();
        for (arg_i, arg) in args.iter().enumerate() {
            let Some(name) = name_of_expr(ctx, arg) else {
                continue;
            };
            let Some((producer_index, binding, init)) =
                (0..consumer_index).rev().find_map(|index| {
                    let (binding, init) = local_single(&block.stmts[index])?;
                    (ctx.text(binding.name) == Some(name)).then_some((index, binding, init))
                })
            else {
                continue;
            };
            if !matches!(init, Expr::Table { .. })
                || !plain_table_expr_between(
                    ctx,
                    init,
                    block,
                    usage_index,
                    producer_index,
                    consumer_index,
                )
                || !barrier_free(block, producer_index, consumer_index)
            {
                continue;
            }
            let Some(stmt_range) = ctx.stmt_range(&block.stmts[producer_index]) else {
                continue;
            };
            let Some(arg_range) = ctx.range(arg.span()) else {
                continue;
            };
            let usage = usage_index.usage_after(name, stmt_range.end);
            if usage.reads.len() != 1
                || usage.writes != 0
                || usage.redeclared
                || usage.captured
                || usage.reads[0] != arg_range
            {
                continue;
            }
            producers.push((arg_i, producer_index, binding, init, stmt_range, arg_range));
        }
        if producers.len() < 2
            && !producers
                .first()
                .is_some_and(|item| item.1 + 1 == consumer_index)
        {
            continue;
        }
        producers.sort_by_key(|item| item.0);
        let mut group = Vec::new();
        let mut seen_statements = HashSet::new();
        for (_, producer_index, _binding, init, stmt_range, arg_range) in producers {
            if !seen_statements.insert(producer_index) {
                continue;
            }
            group.push(Edit {
                start: stmt_range.start,
                end: stmt_range.end,
                replacement: String::new(),
                kind: EditKind::TableCallArgumentInline,
            });
            group.push(Edit {
                start: arg_range.start,
                end: arg_range.end,
                replacement: ctx.expr_text(init).unwrap_or("").to_string(),
                kind: EditKind::TableCallArgumentInline,
            });
        }
        if group.len() >= 2 {
            add_group(ctx, edits, group);
        }
    }
    // Contiguous single-use local dependency program feeding one table constructor.
    // Expand the whole program together and require the runtime evaluation order of
    // every non-literal producer to match its original statement order exactly.
    for consumer_index in 1..block.stmts.len() {
        let Some((_consumer_binding, consumer_init)) = local_single(&block.stmts[consumer_index]) else {
            continue;
        };
        let Expr::Table { fields, .. } = consumer_init else {
            continue;
        };
        // A one-call table is a compiler multi-return pack. Leave it entirely to
        // the dedicated packed-return/multi-return passes so their native-return
        // proof is not weakened by generic dependency inlining.
        if table_single_call(consumer_init).is_some() || fields.is_empty() {
            continue;
        }

        let mut start_index = consumer_index;
        while start_index > 0 && local_single(&block.stmts[start_index - 1]).is_some() {
            start_index -= 1;
        }
        if start_index == consumer_index {
            continue;
        }

        let mut defs: HashMap<String, &Expr> = HashMap::new();
        let mut def_order = HashMap::new();
        let mut source_order = Vec::new();
        let mut effect_order = Vec::new();
        let mut producer_ranges = Vec::new();
        let mut valid = true;
        for (offset, stmt) in block.stmts[start_index..consumer_index].iter().enumerate() {
            let Some((binding, init)) = local_single(stmt) else {
                valid = false;
                break;
            };
            let Some(name) = ctx.text(binding.name) else {
                valid = false;
                break;
            };
            let name = name.to_string();
            if defs.insert(name.clone(), init).is_some() {
                valid = false;
                break;
            }
            def_order.insert(name.clone(), offset);
            source_order.push(name.clone());
            if !is_pure_literal(init) {
                effect_order.push(name.clone());
            }
            let Some(stmt_range) = ctx.stmt_range(stmt) else {
                valid = false;
                break;
            };
            let usage = usage_index.usage_after(&name, stmt_range.end);
            if usage.reads.len() != 1
                || usage.writes != 0
                || usage.redeclared
                || usage.captured
            {
                valid = false;
                break;
            }
            producer_ranges.push(stmt_range);
        }
        if !valid || defs.is_empty() {
            continue;
        }

        let mut eval_counts = HashMap::new();
        let mut eval_order = Vec::new();
        let mut eval_stack = HashSet::new();
        for (field_index, field) in fields.iter().enumerate() {
            let before_effects = eval_order.len();
            let field_ok = match field {
                TableField::Positional(value) | TableField::Named { value, .. } => {
                    collect_namecall_gap_eval_order(
                        ctx,
                        value,
                        &defs,
                        &def_order,
                        None,
                        &mut eval_stack,
                        &mut eval_counts,
                        &mut eval_order,
                    )
                }
                TableField::Computed { key, value } => {
                    collect_namecall_gap_eval_order(
                        ctx,
                        key,
                        &defs,
                        &def_order,
                        None,
                        &mut eval_stack,
                        &mut eval_counts,
                        &mut eval_order,
                    ) && collect_namecall_gap_eval_order(
                        ctx,
                        value,
                        &defs,
                        &def_order,
                        None,
                        &mut eval_stack,
                        &mut eval_counts,
                        &mut eval_order,
                    )
                }
            };
            if !field_ok {
                valid = false;
                break;
            }
            let after_effects = eval_order.len();
            let external_order_safe = match field {
                TableField::Positional(value) => {
                    if after_effects == before_effects {
                        before_effects == effect_order.len()
                            || stable_prefix_expr(
                                ctx,
                                value,
                                block,
                                usage_index,
                                start_index,
                                outer_lexical,
                            )
                    } else if name_of_expr(ctx, value).is_some_and(|name| defs.contains_key(name)) {
                        true
                    } else if field_index + 1 == fields.len()
                        && after_effects == effect_order.len()
                    {
                        match unwrap_parens(value) {
                            Expr::Call { func, method, args, .. }
                                if method.is_none()
                                    && name_of_expr(ctx, func)
                                        .is_some_and(|name| defs.contains_key(name)) =>
                            {
                                match args {
                                    CallArgs::Paren(values) => values.iter().all(is_no_effect_expr),
                                    CallArgs::Table(value) => is_no_effect_expr(value),
                                    CallArgs::Str(_) => true,
                                }
                            }
                            _ => false,
                        }
                    } else {
                        false
                    }
                }
                TableField::Named { value, .. } => {
                    if after_effects == before_effects {
                        before_effects == effect_order.len()
                            || stable_prefix_expr(
                                ctx,
                                value,
                                block,
                                usage_index,
                                start_index,
                                outer_lexical,
                            )
                    } else {
                        name_of_expr(ctx, value).is_some_and(|name| defs.contains_key(name))
                    }
                }
                TableField::Computed { key, value } => {
                    after_effects == before_effects
                        && (before_effects == effect_order.len()
                            || (stable_prefix_expr(
                                ctx,
                                key,
                                block,
                                usage_index,
                                start_index,
                                outer_lexical,
                            ) && stable_prefix_expr(
                                ctx,
                                value,
                                block,
                                usage_index,
                                start_index,
                                outer_lexical,
                            )))
                }
            };
            if !external_order_safe {
                valid = false;
                break;
            }
        }
        if !valid
            || eval_order != effect_order
            || source_order
                .iter()
                .any(|name| eval_counts.get(name).copied().unwrap_or(0) != 1)
        {
            continue;
        }

        let mut render_counts = HashMap::new();
        let mut field_edits = Vec::new();
        for (field_index, field) in fields.iter().enumerate() {
            let is_last_positional = field_index + 1 == fields.len()
                && matches!(field, TableField::Positional(_));
            let mut render_one = |expr: &Expr| -> Option<()> {
                let range = ctx.range(expr.span())?;
                let mut stack = HashSet::new();
                let mut rendered = render_namecall_gap_expr(
                    ctx,
                    expr,
                    &defs,
                    &mut render_counts,
                    &mut stack,
                )?;
                if !is_last_positional {
                    if let Some(name) = name_of_expr(ctx, expr) {
                        if defs.get(name).is_some_and(|def| matches!(unwrap_parens(def), Expr::Call { .. }))
                            && rendered.starts_with('(')
                            && rendered.ends_with(')')
                            && rendered.len() >= 2
                        {
                            rendered = rendered[1..rendered.len() - 1].to_string();
                        }
                    }
                }
                if rendered != ctx.expr_text(expr)? {
                    field_edits.push(Edit {
                        start: range.start,
                        end: range.end,
                        replacement: rendered,
                        kind: EditKind::TableConstructorValueInline,
                    });
                }
                Some(())
            };

            let rendered = match field {
                TableField::Positional(value) | TableField::Named { value, .. } => render_one(value),
                TableField::Computed { key, value } => {
                    render_one(key).and_then(|_| render_one(value))
                }
            };
            if rendered.is_none() {
                valid = false;
                break;
            }
        }
        if !valid
            || source_order
                .iter()
                .any(|name| render_counts.get(name).copied().unwrap_or(0) != 1)
        {
            continue;
        }

        let mut group = Vec::with_capacity(producer_ranges.len() + field_edits.len());
        for range in producer_ranges {
            group.push(Edit {
                start: range.start,
                end: range.end,
                replacement: String::new(),
                kind: EditKind::TableConstructorValueInline,
            });
        }
        group.extend(field_edits);
        if !group.is_empty() {
            add_group(ctx, edits, group);
        }
    }
    // Adjacent indexed snapshot into the leading RHS of a direct assignment.
    // No runtime statement is crossed, and a direct-name LHS has no address effect.
    for i in 0..block.stmts.len().saturating_sub(1) {
        let Some((binding, init)) = local_single(&block.stmts[i]) else {
            continue;
        };
        if !matches!(init, Expr::Index { .. }) {
            continue;
        }
        let Some((target, rhs)) = assignment_single(&block.stmts[i + 1]) else {
            continue;
        };
        if !matches!(target, Expr::Name(_)) {
            continue;
        }
        let Some(name) = ctx.text(binding.name) else {
            continue;
        };
        let Some(stmt_range) = ctx.stmt_range(&block.stmts[i]) else {
            continue;
        };
        let usage = usage_index.usage_after(name, stmt_range.end);
        if usage.reads.len() != 1
            || usage.writes != 0
            || usage.redeclared
            || usage.captured
            || !expr_leading_use(ctx, rhs, &usage.reads[0])
            || !stmt_contains_range(ctx, &block.stmts[i + 1], &usage.reads[0])
        {
            continue;
        }
        let Some(value) = ctx.expr_text(init) else {
            continue;
        };
        add_group(
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
        );
    }

    // Adjacent compiler method snapshot used as a pass-self call inside the next
    // expression. This is the nested form of Prometheus namecall lowering, e.g.
    // outer(method(base)) -> outer(base:Method()).
    for i in 0..block.stmts.len().saturating_sub(1) {
        let Some((binding, init)) = local_single(&block.stmts[i]) else {
            continue;
        };
        let Expr::Index { object, key, .. } = init else {
            continue;
        };
        let (Some(base), Some(method)) =
            (name_of_expr(ctx, object), index_key_identifier(ctx, key))
        else {
            continue;
        };
        let Some(method_local) = ctx.text(binding.name) else {
            continue;
        };
        let Some(stmt_range) = ctx.stmt_range(&block.stmts[i]) else {
            continue;
        };
        let usage = usage_index.usage_after(method_local, stmt_range.end);
        if usage.reads.len() != 1
            || usage.writes != 0
            || usage.redeclared
            || usage.captured
            || usage_index.by_name.get(base).is_some_and(|items| {
                items.iter().any(|item| item.kind == OccKind::Capture)
            })
        {
            continue;
        }
        let read = &usage.reads[0];
        let next = &block.stmts[i + 1];
        let Some(call) = find_direct_call_by_func_range_in_stmt(ctx, next, read) else {
            continue;
        };
        if call_expr_whole(next).is_some_and(|whole| {
            ctx.range(whole.span()) == ctx.range(call.span())
        }) {
            continue;
        }
        let Some(new_call) = reconstruct_call_without_first(ctx, call, base, &method) else {
            continue;
        };
        let Some(call_range) = ctx.range(call.span()) else {
            continue;
        };
        add_group(
            ctx,
            edits,
            vec![
                Edit {
                    start: stmt_range.start,
                    end: stmt_range.end,
                    replacement: String::new(),
                    kind: EditKind::Namecall,
                },
                Edit {
                    start: call_range.start,
                    end: call_range.end,
                    replacement: new_call,
                    kind: EditKind::Namecall,
                },
            ],
        );
    }

    // An immediate alias used in the first generic-for iterator expression is read
    // before the loop variables enter scope. Therefore a loop variable may legally
    // reuse the alias spelling without redeclaring the outer binding at that read.
    for i in 0..block.stmts.len().saturating_sub(1) {
        let Some((binding, init)) = local_single(&block.stmts[i]) else {
            continue;
        };
        let Expr::Name(source_span) = init else {
            continue;
        };
        let Stmt::GenericFor(loop_stmt) = &block.stmts[i + 1] else {
            continue;
        };
        let (Some(alias), Some(source_name)) =
            (ctx.text(binding.name), ctx.text(*source_span))
        else {
            continue;
        };
        if alias == source_name || loop_stmt.exprs.is_empty() {
            continue;
        }
        let wanted = HashSet::from([alias.to_string()]);
        let mut hits = Vec::new();
        for expr in &loop_stmt.exprs {
            collect_name_ranges(expr, ctx, &wanted, &mut hits);
        }
        if hits.len() != 1 {
            continue;
        }
        let read = hits[0].0.clone();
        let first = &loop_stmt.exprs[0];
        let leading = ctx.range(first.span()).is_some_and(|range| range == read)
            || call_parts(first).is_some_and(|(func, _, _)| {
                expr_is_leading_call_base_use(ctx, func, &read)
            });
        if !leading {
            continue;
        }
        let shadows_alias = loop_stmt
            .vars
            .iter()
            .any(|var| ctx.text(var.name) == Some(alias));
        if (!shadows_alias && block_contains_name(ctx, &loop_stmt.block, alias))
            || block.stmts[i + 2..]
                .iter()
                .any(|stmt| stmt_contains_name(ctx, stmt, alias))
        {
            continue;
        }
        let Some(stmt_range) = ctx.stmt_range(&block.stmts[i]) else {
            continue;
        };
        add_group(
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
        );
    }

    // Adjacent 3-value iterator tuple into generic-for header.
    for i in 0..block.stmts.len().saturating_sub(1) {
        let Stmt::Local(local) = &block.stmts[i] else {
            continue;
        };
        let Stmt::GenericFor(loop_stmt) = &block.stmts[i + 1] else {
            continue;
        };
        if local.names.len() != 3
            || local.values.is_empty()
            || local.values.len() > 3
            || loop_stmt.exprs.len() != 3
        {
            continue;
        }
        let local_names: Vec<_> = local
            .names
            .iter()
            .filter_map(|b| ctx.text(b.name))
            .collect();
        if local_names.len() != 3 || local_names.iter().collect::<HashSet<_>>().len() != 3 {
            continue;
        }
        let mut valid = true;
        for slot in 0..3 {
            let Expr::Name(use_span) = &loop_stmt.exprs[slot] else {
                valid = false;
                break;
            };
            if ctx.text(*use_span) != Some(local_names[slot]) {
                valid = false;
                break;
            }
            let Some(decl_range) = ctx.stmt_range(&block.stmts[i]) else {
                valid = false;
                break;
            };
            let usage = usage_index.usage_after(local_names[slot], decl_range.end);
            let Some(use_range) = ctx.range(*use_span) else {
                valid = false;
                break;
            };
            if usage.reads.len() != 1
                || usage.writes != 0
                || usage.redeclared
                || usage.captured
                || usage.reads[0] != use_range
            {
                valid = false;
                break;
            }
        }
        if !valid {
            continue;
        }
        let Some(decl_range) = ctx.stmt_range(&block.stmts[i]) else {
            continue;
        };
        let Some(first_range) = ctx.range(loop_stmt.exprs[0].span()) else {
            continue;
        };
        let Some(last_range) = ctx.range(loop_stmt.exprs[2].span()) else {
            continue;
        };
        let iterator_source = local
            .values
            .iter()
            .filter_map(|e| ctx.expr_text(e))
            .collect::<Vec<_>>()
            .join(", ");
        add_group(
            ctx,
            edits,
            vec![
                Edit {
                    start: decl_range.start,
                    end: decl_range.end,
                    replacement: String::new(),
                    kind: EditKind::GenericForTuple,
                },
                Edit {
                    start: first_range.start,
                    end: last_range.end,
                    replacement: iterator_source,
                    kind: EditKind::GenericForTuple,
                },
            ],
        );
    }
    // Numeric-for literal snapshots in start/limit/step.
    for (loop_index, stmt) in block.stmts.iter().enumerate() {
        let Stmt::NumericFor(loop_stmt) = stmt else {
            continue;
        };
        let mut slots: Vec<(&str, &Expr)> =
            vec![("start", &loop_stmt.start), ("limit", &loop_stmt.limit)];
        if let Some(step) = &loop_stmt.step {
            slots.push(("step", step));
        }
        let mut group = Vec::new();
        for (slot_name, use_expr) in slots {
            let Expr::Name(use_span) = use_expr else {
                continue;
            };
            let use_name = ctx.text(*use_span).unwrap_or("");
            let mut found = None;
            for declaration_index in (0..loop_index).rev() {
                let Some((binding, init)) = local_single(&block.stmts[declaration_index]) else {
                    continue;
                };
                if ctx.text(binding.name) == Some(use_name) && matches!(init, Expr::Number(_)) {
                    found = Some((declaration_index, init));
                    break;
                }
            }
            let Some((declaration_index, init)) = found else {
                continue;
            };
            let Some(decl_range) = ctx.stmt_range(&block.stmts[declaration_index]) else {
                continue;
            };
            let usage = usage_index.usage_after(use_name, decl_range.end);
            let Some(use_range) = ctx.range(*use_span) else {
                continue;
            };
            if usage.reads.len() != 1
                || usage.writes != 0
                || usage.redeclared
                || usage.captured
                || usage.reads[0] != use_range
            {
                continue;
            }
            group.push(Edit {
                start: decl_range.start,
                end: decl_range.end,
                replacement: String::new(),
                kind: EditKind::NumericForConstant,
            });
            if slot_name == "step" && static_number(ctx, init) == Some(1.0) {
                let Some(limit_range) = ctx.range(loop_stmt.limit.span()) else {
                    continue;
                };
                let between = ctx.src.get(limit_range.end..use_range.start).unwrap_or("");
                if between.trim() == "," {
                    group.push(Edit {
                        start: limit_range.end,
                        end: use_range.end,
                        replacement: String::new(),
                        kind: EditKind::NumericForDefaultStep,
                    });
                    continue;
                }
            }
            group.push(Edit {
                start: use_range.start,
                end: use_range.end,
                replacement: ctx.expr_text(init).unwrap_or("").to_string(),
                kind: EditKind::NumericForConstant,
            });
        }
        add_group(ctx, edits, group);
    }
}

fn collect_repeat_tail_inline(ctx: &Ctx<'_>, repeat: &Repeat, edits: &mut Vec<Edit>) {
    let Expr::Name(condition_span) = &repeat.cond else {
        return;
    };
    let Some(last_stmt) = repeat.block.stmts.last() else {
        return;
    };
    let Some((binding, init)) = local_single(last_stmt) else {
        return;
    };
    let name = ctx.text(binding.name).unwrap_or("");
    if ctx.text(*condition_span) != Some(name) {
        return;
    }
    let usage_index = build_usage_index(ctx, &repeat.block);
    let Some(stmt_range) = ctx.stmt_range(last_stmt) else {
        return;
    };
    let usage = usage_index.usage_after(name, stmt_range.end);
    if !usage.reads.is_empty() || usage.writes != 0 || usage.redeclared || usage.captured {
        return;
    }
    let (Some(cond_range), Some(value)) = (ctx.range(*condition_span), ctx.expr_text(init)) else {
        return;
    };
    add_group(
        ctx,
        edits,
        vec![
            Edit {
                start: stmt_range.start,
                end: stmt_range.end,
                replacement: String::new(),
                kind: EditKind::RepeatTailInline,
            },
            Edit {
                start: cond_range.start,
                end: cond_range.end,
                replacement: value.to_string(),
                kind: EditKind::RepeatTailInline,
            },
        ],
    );
}
