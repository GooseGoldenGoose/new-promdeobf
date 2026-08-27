#[derive(Default, Debug, Clone)]
pub struct Stats {
    pub rounds: usize,
    pub parses: usize,
    pub edits: usize,
    pub literal_inlines: usize,
    pub local_alias_inlines: usize,
    pub global_alias_inlines: usize,
    pub adjacent_inlines: usize,
    pub env_folds: usize,
    pub deferred_locals: usize,
    pub namecalls: usize,
    pub packed_returns: usize,
    pub packed_forwards: usize,
    pub multi_return_slots: usize,
    pub dead_locals: usize,
    pub dead_call_results: usize,
    pub direct_nil_cleanups: usize,
    pub assignment_value_inlines: usize,
    pub call_argument_inlines: usize,
    pub function_inlines: usize,
    pub bare_returns: usize,
    pub copy_chains: usize,
    pub index_base_aliases: usize,
    pub index_key_inlines: usize,
    pub assignment_key_inlines: usize,
    pub dependency_assignment_key_inlines: usize,
    pub table_constructor_key_inlines: usize,
    pub table_constructor_value_inlines: usize,
    pub table_call_argument_inlines: usize,
    pub repeat_tail_inlines: usize,
    pub multi_return_table_collapses: usize,
    pub multi_return_forwarders: usize,
    pub compiler_vararg_forwarders: usize,
    pub generated_vararg_captures: usize,
    pub generated_vararg_reads: usize,
    pub packed_return_forwarders: usize,
    pub returned_call_base_inlines: usize,
    pub multi_return_self_assignments: usize,
    pub multi_return_placeholders: usize,
    pub multi_return_unused_targets: usize,
    pub generic_for_tuple_inlines: usize,
    pub generic_for_tuple_locals: usize,
    pub numeric_for_constant_inlines: usize,
    pub numeric_for_default_steps: usize,
    pub short_circuit_ladders: usize,
    pub value_short_circuit_ladders: usize,
    pub while_conditions: usize,
    pub repeat_conditions: usize,
    pub repeat_prechecks: usize,
    pub string_decodes: usize,
    pub static_field_indexes: usize,
}

#[derive(Debug, Clone)]
struct Edit {
    start: usize,
    end: usize,
    replacement: String,
    kind: EditKind,
}

#[derive(Debug, Clone, Copy)]
enum EditKind {
    LiteralInline,
    LocalAlias,
    GlobalAlias,
    AdjacentInline,
    EnvFold,
    DeferredLocal,
    Namecall,
    PackedReturn,
    MultiReturnSlots,
    DeadLocal,
    DeadCallResult,
    DirectNilCleanup,
    AssignmentValueInline,
    CallArgumentInline,
    FunctionInline,
    BareReturn,
    CopyChain,
    IndexBaseAlias,
    IndexKeyInline,
    AssignmentKeyInline,
    DependencyAssignmentKeyInline,
    TableConstructorKeyInline,
    TableConstructorValueInline,
    TableCallArgumentInline,
    RepeatTailInline,
    MultiReturnCollapse,
    MultiReturnForward,
    CompilerVarargForward,
    GeneratedVarargCapture,
    GeneratedVarargRead,
    PackedReturnForward,
    ReturnedCallBaseInline,
    MultiReturnSelfAssignment,
    MultiReturnPlaceholder,
    MultiReturnUnusedTarget,
    GenericForTuple,
    NumericForConstant,
    NumericForDefaultStep,
    ShortCircuit,
    ValueShortCircuit,
    WhileCondition,
    RepeatCondition,
    RepeatPrecheck,
    StringDecode,
    StringDecodeCleanup,
    StaticFieldIndex,
}

struct Ctx<'a> {
    src: &'a str,
    toks: &'a [Tok],
    comments: &'a [(u32, u32)],
    nested_writer_cache: RefCell<HashMap<usize, HashSet<String>>>,
    direct_decl_cache: RefCell<HashMap<usize, HashMap<String, Vec<usize>>>>,
    edit_intervals: RefCell<BTreeMap<usize, usize>>,
}

impl<'a> Ctx<'a> {
    fn range(&self, span: TokSpan) -> Option<Range<usize>> {
        if span.start >= span.end {
            return None;
        }
        let first = self.toks.get(span.start as usize)?;
        let last = self.toks.get(span.end as usize - 1)?;
        Some(first.start as usize..last.end as usize)
    }

    fn text(&self, span: TokSpan) -> Option<&'a str> {
        let range = self.range(span)?;
        self.src.get(range)
    }

    fn expr_text(&self, expr: &Expr) -> Option<&'a str> {
        self.text(expr.span())
    }
    fn stmt_range(&self, stmt: &Stmt) -> Option<Range<usize>> {
        self.range(stmt.span())
    }
}

#[derive(Default)]
struct Usage {
    reads: Vec<Range<usize>>,
    writes: usize,
    redeclared: bool,
    captured: bool,
}

fn span_eq(ctx: &Ctx<'_>, span: TokSpan, range: &Range<usize>) -> bool {
    ctx.range(span)
        .is_some_and(|r| r.start == range.start && r.end == range.end)
}

fn name_of_expr<'a>(ctx: &'a Ctx<'_>, expr: &Expr) -> Option<&'a str> {
    match expr {
        Expr::Name(span) => ctx.text(*span),
        _ => None,
    }
}

fn simple_string_identifier(ctx: &Ctx<'_>, expr: &Expr) -> Option<String> {
    let expr = unwrap_parens(expr);
    let Expr::String(span) = expr else {
        return None;
    };
    let text = ctx.text(*span)?;
    if text.len() < 2 {
        return None;
    }
    let b = text.as_bytes();
    let quote = b[0];
    if !((quote == b'"' || quote == b'\'') && b[text.len() - 1] == quote) {
        return None;
    }
    let inner = &text[1..text.len() - 1];
    if inner.is_empty() || inner.contains('\\') {
        return None;
    }
    let mut chars = inner.chars();
    let first = chars.next()?;
    if !(first == '_' || first.is_ascii_alphabetic()) {
        return None;
    }
    if !chars.all(|c| c == '_' || c.is_ascii_alphanumeric()) {
        return None;
    }
    const KW: &[&str] = &[
        "and", "break", "continue", "do", "else", "elseif", "end", "false", "for", "function",
        "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
        "while",
    ];
    if KW.contains(&inner) {
        return None;
    }
    Some(inner.to_string())
}

fn index_key_identifier(ctx: &Ctx<'_>, key: &IndexKey) -> Option<String> {
    match key {
        IndexKey::Field(span) => ctx.text(*span).map(str::to_string),
        IndexKey::Computed(expr) => simple_string_identifier(ctx, expr),
    }
}

fn is_pure_literal(expr: &Expr) -> bool {
    matches!(
        expr,
        Expr::Nil(_) | Expr::True(_) | Expr::False(_) | Expr::Number(_) | Expr::String(_)
    )
}

fn is_numeric_literal_constant(ctx: &Ctx<'_>, expr: &Expr) -> bool {
    match expr {
        Expr::Number(_) => true,
        Expr::Paren { inner, .. } => is_numeric_literal_constant(ctx, inner),
        Expr::Unary { op, operand, .. } if ctx.text(*op) == Some("-") => {
            is_numeric_literal_constant(ctx, operand)
        }
        _ => false,
    }
}

fn is_string_literal_constant(expr: &Expr) -> bool {
    match expr {
        Expr::String(_) => true,
        Expr::Paren { inner, .. } => is_string_literal_constant(inner),
        _ => false,
    }
}

// Constants accepted here must be safe to move across unrelated statements:
// no mutable reads, calls, identity-bearing allocations, metamethod dispatch, or
// operand-dependent runtime errors. Keep the operator whitelist deliberately narrow.
fn is_safe_inline_constant(ctx: &Ctx<'_>, expr: &Expr) -> bool {
    if is_pure_literal(expr) {
        return true;
    }
    match expr {
        Expr::Paren { inner, .. } => is_safe_inline_constant(ctx, inner),
        Expr::Unary { op, operand, .. } => match ctx.text(*op) {
            Some("-") => is_numeric_literal_constant(ctx, operand),
            Some("not") => is_safe_inline_constant(ctx, operand),
            Some("#") => is_string_literal_constant(operand),
            _ => false,
        },
        _ => false,
    }
}

fn safe_inline_constant_text(ctx: &Ctx<'_>, expr: &Expr) -> Option<String> {
    let value = ctx.expr_text(expr)?;
    if is_pure_literal(expr) {
        Some(value.to_string())
    } else {
        // A local name is a primary expression. Parenthesize non-atomic constants so
        // replacement cannot change precedence, e.g. `x ^ 2` with `x = -1`.
        Some(format!("({value})"))
    }
}

fn is_scalar_temp_expr(expr: &Expr) -> bool {
    match expr {
        Expr::Nil(_)
        | Expr::True(_)
        | Expr::False(_)
        | Expr::Number(_)
        | Expr::String(_)
        | Expr::Name(_) => true,
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => is_scalar_temp_expr(operand),
        Expr::Binary { lhs, rhs, .. } => is_scalar_temp_expr(lhs) && is_scalar_temp_expr(rhs),
        _ => false,
    }
}
fn is_pure_dead_expr(expr: &Expr) -> bool {
    match expr {
        Expr::Nil(_)
        | Expr::True(_)
        | Expr::False(_)
        | Expr::Number(_)
        | Expr::String(_)
        | Expr::Vararg(_) => true,
        Expr::Table { fields, .. } => fields.iter().all(|field| match field {
            TableField::Positional(value) => is_pure_dead_expr(value),
            TableField::Named { value, .. } => is_pure_dead_expr(value),
            TableField::Computed { key, value } => {
                is_pure_dead_expr(key) && is_pure_dead_expr(value)
            }
        }),
        Expr::Function { .. } => true,
        _ => false,
    }
}

fn is_no_effect_expr(expr: &Expr) -> bool {
    match expr {
        Expr::Nil(_)
        | Expr::True(_)
        | Expr::False(_)
        | Expr::Number(_)
        | Expr::String(_)
        | Expr::Vararg(_)
        | Expr::Name(_) => true,
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => is_no_effect_expr(operand),
        Expr::Binary { lhs, rhs, .. } => is_no_effect_expr(lhs) && is_no_effect_expr(rhs),
        Expr::Table { fields, .. } => fields.iter().all(|field| match field {
            TableField::Positional(value) => is_no_effect_expr(value),
            TableField::Named { value, .. } => is_no_effect_expr(value),
            TableField::Computed { key, value } => {
                is_no_effect_expr(key) && is_no_effect_expr(value)
            }
        }),
        // Creating a closure does not execute its body.
        Expr::Function { .. } => true,
        _ => false,
    }
}

fn statement_has_effect(stmt: &Stmt) -> bool {
    match stmt {
        Stmt::Empty(_) => false,
        Stmt::Local(node) => !node.values.iter().all(is_no_effect_expr),
        _ => true,
    }
}

fn barrier_free(block: &Block, from_index: usize, to_index: usize) -> bool {
    block
        .stmts
        .iter()
        .take(to_index)
        .skip(from_index + 1)
        .all(|stmt| !statement_has_effect(stmt))
}

fn expr_is_leading_call_base_use(ctx: &Ctx<'_>, expr: &Expr, target: &Range<usize>) -> bool {
    if ctx.range(expr.span()).is_some_and(|range| range == *target) {
        return true;
    }
    match expr {
        Expr::Paren { inner, .. } | Expr::TypeAssert { expr: inner, .. } => {
            expr_is_leading_call_base_use(ctx, inner, target)
        }
        Expr::Index { object, .. } => expr_is_leading_call_base_use(ctx, object, target),
        _ => false,
    }
}

fn expr_has_call_base_use(ctx: &Ctx<'_>, expr: &Expr, target: &Range<usize>) -> bool {
    match expr {
        Expr::Function { .. } => false,
        Expr::Call { func, args, .. } => {
            if expr_is_leading_call_base_use(ctx, func, target) {
                return true;
            }
            expr_has_call_base_use(ctx, func, target)
                || match args {
                    CallArgs::Paren(values) => values
                        .iter()
                        .any(|value| expr_has_call_base_use(ctx, value, target)),
                    CallArgs::Table(value) => expr_has_call_base_use(ctx, value, target),
                    CallArgs::Str(_) => false,
                }
        }
        Expr::Table { fields, .. } => fields.iter().any(|field| match field {
            TableField::Positional(value) => expr_has_call_base_use(ctx, value, target),
            TableField::Named { value, .. } => expr_has_call_base_use(ctx, value, target),
            TableField::Computed { key, value } => {
                expr_has_call_base_use(ctx, key, target)
                    || expr_has_call_base_use(ctx, value, target)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            expr_has_call_base_use(ctx, lhs, target) || expr_has_call_base_use(ctx, rhs, target)
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => expr_has_call_base_use(ctx, operand, target),
        Expr::Index { object, key, .. } => {
            expr_has_call_base_use(ctx, object, target)
                || match key {
                    IndexKey::Field(_) => false,
                    IndexKey::Computed(key) => expr_has_call_base_use(ctx, key, target),
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches.iter().any(|(condition, value)| {
                expr_has_call_base_use(ctx, condition, target)
                    || expr_has_call_base_use(ctx, value, target)
            }) || expr_has_call_base_use(ctx, else_value, target)
        }
        _ => false,
    }
}

fn stmt_has_call_base_use(ctx: &Ctx<'_>, stmt: &Stmt, target: &Range<usize>) -> bool {
    match stmt {
        Stmt::Local(node) => node
            .values
            .iter()
            .any(|expr| expr_has_call_base_use(ctx, expr, target)),
        Stmt::Assign(node) => node
            .targets
            .iter()
            .chain(node.values.iter())
            .any(|expr| expr_has_call_base_use(ctx, expr, target)),
        Stmt::Call(expr, _) => expr_has_call_base_use(ctx, expr, target),
        Stmt::Return(node) => node
            .values
            .iter()
            .any(|expr| expr_has_call_base_use(ctx, expr, target)),
        Stmt::If(node) => node
            .branches
            .iter()
            .any(|(condition, _)| expr_has_call_base_use(ctx, condition, target)),
        Stmt::While(node) => expr_has_call_base_use(ctx, &node.cond, target),
        Stmt::Repeat(node) => expr_has_call_base_use(ctx, &node.cond, target),
        Stmt::NumericFor(node) => {
            expr_has_call_base_use(ctx, &node.start, target)
                || expr_has_call_base_use(ctx, &node.limit, target)
                || node
                    .step
                    .as_ref()
                    .is_some_and(|expr| expr_has_call_base_use(ctx, expr, target))
        }
        Stmt::GenericFor(node) => node
            .exprs
            .iter()
            .any(|expr| expr_has_call_base_use(ctx, expr, target)),
        _ => false,
    }
}

fn expr_has_direct_call_argument_use(ctx: &Ctx<'_>, expr: &Expr, target: &Range<usize>) -> bool {
    match expr {
        Expr::Function { .. } => false,
        Expr::Call { func, args, .. } => {
            let direct = match args {
                CallArgs::Paren(values) => values.iter().any(|value| {
                    ctx.range(value.span())
                        .is_some_and(|range| range == *target)
                }),
                CallArgs::Table(value) => ctx
                    .range(value.span())
                    .is_some_and(|range| range == *target),
                CallArgs::Str(_) => false,
            };
            if direct {
                return true;
            }
            expr_has_direct_call_argument_use(ctx, func, target)
                || match args {
                    CallArgs::Paren(values) => values
                        .iter()
                        .any(|value| expr_has_direct_call_argument_use(ctx, value, target)),
                    CallArgs::Table(value) => expr_has_direct_call_argument_use(ctx, value, target),
                    CallArgs::Str(_) => false,
                }
        }
        Expr::Table { fields, .. } => fields.iter().any(|field| match field {
            TableField::Positional(value) => expr_has_direct_call_argument_use(ctx, value, target),
            TableField::Named { value, .. } => {
                expr_has_direct_call_argument_use(ctx, value, target)
            }
            TableField::Computed { key, value } => {
                expr_has_direct_call_argument_use(ctx, key, target)
                    || expr_has_direct_call_argument_use(ctx, value, target)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            expr_has_direct_call_argument_use(ctx, lhs, target)
                || expr_has_direct_call_argument_use(ctx, rhs, target)
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            expr_has_direct_call_argument_use(ctx, operand, target)
        }
        Expr::Index { object, key, .. } => {
            expr_has_direct_call_argument_use(ctx, object, target)
                || match key {
                    IndexKey::Field(_) => false,
                    IndexKey::Computed(key) => expr_has_direct_call_argument_use(ctx, key, target),
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches.iter().any(|(condition, value)| {
                expr_has_direct_call_argument_use(ctx, condition, target)
                    || expr_has_direct_call_argument_use(ctx, value, target)
            }) || expr_has_direct_call_argument_use(ctx, else_value, target)
        }
        _ => false,
    }
}

fn stmt_has_direct_call_argument_use(ctx: &Ctx<'_>, stmt: &Stmt, target: &Range<usize>) -> bool {
    match stmt {
        Stmt::Local(node) => node
            .values
            .iter()
            .any(|expr| expr_has_direct_call_argument_use(ctx, expr, target)),
        Stmt::Assign(node) => node
            .targets
            .iter()
            .chain(node.values.iter())
            .any(|expr| expr_has_direct_call_argument_use(ctx, expr, target)),
        Stmt::Call(expr, _) => expr_has_direct_call_argument_use(ctx, expr, target),
        Stmt::Return(node) => node
            .values
            .iter()
            .any(|expr| expr_has_direct_call_argument_use(ctx, expr, target)),
        Stmt::If(node) => node
            .branches
            .iter()
            .any(|(condition, _)| expr_has_direct_call_argument_use(ctx, condition, target)),
        Stmt::While(node) => expr_has_direct_call_argument_use(ctx, &node.cond, target),
        Stmt::Repeat(node) => expr_has_direct_call_argument_use(ctx, &node.cond, target),
        Stmt::NumericFor(node) => {
            expr_has_direct_call_argument_use(ctx, &node.start, target)
                || expr_has_direct_call_argument_use(ctx, &node.limit, target)
                || node
                    .step
                    .as_ref()
                    .is_some_and(|expr| expr_has_direct_call_argument_use(ctx, expr, target))
        }
        Stmt::GenericFor(node) => node
            .exprs
            .iter()
            .any(|expr| expr_has_direct_call_argument_use(ctx, expr, target)),
        _ => false,
    }
}

fn source_binding_changes_between(
    usage_index: &UsageIndex,
    name: &str,
    start: usize,
    end: usize,
) -> bool {
    usage_index.by_name.get(name).is_some_and(|items| {
        items.iter().any(|item| {
            item.pos > start
                && item.pos < end
                && matches!(
                    item.kind,
                    OccKind::Write | OccKind::Redeclare | OccKind::Capture
                )
        })
    })
}

fn call_parts<'a>(expr: &'a Expr) -> Option<(&'a Expr, Option<TokSpan>, &'a CallArgs)> {
    match expr {
        Expr::Call {
            func, method, args, ..
        } => Some((func, *method, args)),
        _ => None,
    }
}

fn paren_args(args: &CallArgs) -> Option<&[Expr]> {
    match args {
        CallArgs::Paren(values) => Some(values.as_slice()),
        _ => None,
    }
}

fn expr_contains_name(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> bool {
    match expr {
        Expr::Name(span) => ctx.text(*span) == Some(name),
        Expr::Function { body, .. } => block_contains_name(ctx, &body.block, name),
        Expr::Table { fields, .. } => fields.iter().any(|field| match field {
            TableField::Positional(v) => expr_contains_name(ctx, v, name),
            TableField::Named { value, .. } => expr_contains_name(ctx, value, name),
            TableField::Computed { key, value } => {
                expr_contains_name(ctx, key, name) || expr_contains_name(ctx, value, name)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            expr_contains_name(ctx, lhs, name) || expr_contains_name(ctx, rhs, name)
        }
        Expr::Unary { operand, .. } => expr_contains_name(ctx, operand, name),
        Expr::Paren { inner, .. } => expr_contains_name(ctx, inner, name),
        Expr::Index { object, key, .. } => {
            expr_contains_name(ctx, object, name)
                || match key {
                    IndexKey::Field(_) => false,
                    IndexKey::Computed(key) => expr_contains_name(ctx, key, name),
                }
        }
        Expr::Call { func, args, .. } => {
            expr_contains_name(ctx, func, name)
                || match args {
                    CallArgs::Paren(v) => v.iter().any(|e| expr_contains_name(ctx, e, name)),
                    CallArgs::Table(e) => expr_contains_name(ctx, e, name),
                    CallArgs::Str(_) => false,
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches
                .iter()
                .any(|(a, b)| expr_contains_name(ctx, a, name) || expr_contains_name(ctx, b, name))
                || expr_contains_name(ctx, else_value, name)
        }
        Expr::TypeAssert { expr, .. } => expr_contains_name(ctx, expr, name),
        _ => false,
    }
}

fn block_contains_name(ctx: &Ctx<'_>, block: &Block, name: &str) -> bool {
    block.stmts.iter().any(|s| stmt_contains_name(ctx, s, name))
}

fn stmt_contains_name(ctx: &Ctx<'_>, stmt: &Stmt, name: &str) -> bool {
    match stmt {
        Stmt::Local(n) => {
            n.values.iter().any(|e| expr_contains_name(ctx, e, name))
                || n.names.iter().any(|b| ctx.text(b.name) == Some(name))
        }
        Stmt::Assign(n) => n
            .targets
            .iter()
            .chain(n.values.iter())
            .any(|e| expr_contains_name(ctx, e, name)),
        Stmt::Call(e, _) => expr_contains_name(ctx, e, name),
        Stmt::Do(n) => block_contains_name(ctx, &n.block, name),
        Stmt::While(n) => {
            expr_contains_name(ctx, &n.cond, name) || block_contains_name(ctx, &n.block, name)
        }
        Stmt::Repeat(n) => {
            block_contains_name(ctx, &n.block, name) || expr_contains_name(ctx, &n.cond, name)
        }
        Stmt::If(n) => {
            n.branches
                .iter()
                .any(|(c, b)| expr_contains_name(ctx, c, name) || block_contains_name(ctx, b, name))
                || n.else_block
                    .as_ref()
                    .is_some_and(|b| block_contains_name(ctx, b, name))
        }
        Stmt::NumericFor(n) => {
            ctx.text(n.var.name) == Some(name)
                || expr_contains_name(ctx, &n.start, name)
                || expr_contains_name(ctx, &n.limit, name)
                || n.step
                    .as_ref()
                    .is_some_and(|e| expr_contains_name(ctx, e, name))
                || block_contains_name(ctx, &n.block, name)
        }
        Stmt::GenericFor(n) => {
            n.vars.iter().any(|b| ctx.text(b.name) == Some(name))
                || n.exprs.iter().any(|e| expr_contains_name(ctx, e, name))
                || block_contains_name(ctx, &n.block, name)
        }
        Stmt::Function(n) => {
            n.path.iter().any(|s| ctx.text(*s) == Some(name))
                || block_contains_name(ctx, &n.body.block, name)
        }
        Stmt::LocalFunction(n) => {
            ctx.text(n.name) == Some(name) || block_contains_name(ctx, &n.body.block, name)
        }
        Stmt::Return(n) => n.values.iter().any(|e| expr_contains_name(ctx, e, name)),
        _ => false,
    }
}

fn scan_expr_usage(ctx: &Ctx<'_>, expr: &Expr, name: &str, usage: &mut Usage, nested_fn: bool) {
    match expr {
        Expr::Name(span) if ctx.text(*span) == Some(name) => {
            if nested_fn {
                usage.captured = true;
            } else if let Some(r) = ctx.range(*span) {
                usage.reads.push(r);
            }
        }
        Expr::Function { body, .. } => {
            if block_contains_name(ctx, &body.block, name) {
                usage.captured = true;
            }
        }
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(v) => scan_expr_usage(ctx, v, name, usage, nested_fn),
                    TableField::Named { value, .. } => {
                        scan_expr_usage(ctx, value, name, usage, nested_fn)
                    }
                    TableField::Computed { key, value } => {
                        scan_expr_usage(ctx, key, name, usage, nested_fn);
                        scan_expr_usage(ctx, value, name, usage, nested_fn);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            scan_expr_usage(ctx, lhs, name, usage, nested_fn);
            scan_expr_usage(ctx, rhs, name, usage, nested_fn);
        }
        Expr::Unary { operand, .. } => scan_expr_usage(ctx, operand, name, usage, nested_fn),
        Expr::Paren { inner, .. } => scan_expr_usage(ctx, inner, name, usage, nested_fn),
        Expr::Index { object, key, .. } => {
            scan_expr_usage(ctx, object, name, usage, nested_fn);
            if let IndexKey::Computed(k) = key {
                scan_expr_usage(ctx, k, name, usage, nested_fn);
            }
        }
        Expr::Call { func, args, .. } => {
            scan_expr_usage(ctx, func, name, usage, nested_fn);
            match args {
                CallArgs::Paren(v) => {
                    for e in v {
                        scan_expr_usage(ctx, e, name, usage, nested_fn)
                    }
                }
                CallArgs::Table(e) => scan_expr_usage(ctx, e, name, usage, nested_fn),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                scan_expr_usage(ctx, a, name, usage, nested_fn);
                scan_expr_usage(ctx, b, name, usage, nested_fn);
            }
            scan_expr_usage(ctx, else_value, name, usage, nested_fn);
        }
        Expr::TypeAssert { expr, .. } => scan_expr_usage(ctx, expr, name, usage, nested_fn),
        _ => {}
    }
}

fn scan_target_usage(ctx: &Ctx<'_>, expr: &Expr, name: &str, usage: &mut Usage) {
    match expr {
        Expr::Name(span) if ctx.text(*span) == Some(name) => usage.writes += 1,
        Expr::Index { object, key, .. } => {
            scan_expr_usage(ctx, object, name, usage, false);
            if let IndexKey::Computed(k) = key {
                scan_expr_usage(ctx, k, name, usage, false);
            }
        }
        _ => scan_expr_usage(ctx, expr, name, usage, false),
    }
}

fn scan_block_usage(ctx: &Ctx<'_>, block: &Block, name: &str, usage: &mut Usage) {
    for stmt in &block.stmts {
        scan_stmt_usage(ctx, stmt, name, usage);
    }
}

fn scan_stmt_usage(ctx: &Ctx<'_>, stmt: &Stmt, name: &str, usage: &mut Usage) {
    match stmt {
        Stmt::Local(n) => {
            for e in &n.values {
                scan_expr_usage(ctx, e, name, usage, false);
            }
            if n.names.iter().any(|b| ctx.text(b.name) == Some(name)) {
                usage.redeclared = true;
            }
        }
        Stmt::Assign(n) => {
            for t in &n.targets {
                scan_target_usage(ctx, t, name, usage);
            }
            for e in &n.values {
                scan_expr_usage(ctx, e, name, usage, false);
            }
        }
        Stmt::Call(e, _) => scan_expr_usage(ctx, e, name, usage, false),
        Stmt::Do(n) => scan_block_usage(ctx, &n.block, name, usage),
        Stmt::While(n) => {
            scan_expr_usage(ctx, &n.cond, name, usage, false);
            scan_block_usage(ctx, &n.block, name, usage);
        }
        Stmt::Repeat(n) => {
            scan_block_usage(ctx, &n.block, name, usage);
            scan_expr_usage(ctx, &n.cond, name, usage, false);
        }
        Stmt::If(n) => {
            for (c, b) in &n.branches {
                scan_expr_usage(ctx, c, name, usage, false);
                scan_block_usage(ctx, b, name, usage);
            }
            if let Some(b) = &n.else_block {
                scan_block_usage(ctx, b, name, usage);
            }
        }
        Stmt::NumericFor(n) => {
            scan_expr_usage(ctx, &n.start, name, usage, false);
            scan_expr_usage(ctx, &n.limit, name, usage, false);
            if let Some(e) = &n.step {
                scan_expr_usage(ctx, e, name, usage, false);
            }
            if ctx.text(n.var.name) == Some(name) {
                usage.redeclared = true;
            }
            scan_block_usage(ctx, &n.block, name, usage);
        }
        Stmt::GenericFor(n) => {
            for e in &n.exprs {
                scan_expr_usage(ctx, e, name, usage, false);
            }
            if n.vars.iter().any(|b| ctx.text(b.name) == Some(name)) {
                usage.redeclared = true;
            }
            scan_block_usage(ctx, &n.block, name, usage);
        }
        Stmt::Function(n) => {
            if block_contains_name(ctx, &n.body.block, name) {
                usage.captured = true;
            }
        }
        Stmt::LocalFunction(n) => {
            if ctx.text(n.name) == Some(name) {
                usage.redeclared = true;
            }
            if block_contains_name(ctx, &n.body.block, name) {
                usage.captured = true;
            }
        }
        Stmt::Return(n) => {
            for e in &n.values {
                scan_expr_usage(ctx, e, name, usage, false)
            }
        }
        _ => {}
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum OccKind {
    Read,
    Write,
    Redeclare,
    Capture,
}

#[derive(Debug, Clone)]
struct Occurrence {
    pos: usize,
    range: Option<Range<usize>>,
    kind: OccKind,
}

#[derive(Default)]
struct UsageIndex {
    by_name: HashMap<String, Vec<Occurrence>>,
}

impl UsageIndex {
    fn add(&mut self, name: &str, occurrence: Occurrence) {
        self.by_name
            .entry(name.to_string())
            .or_default()
            .push(occurrence);
    }

    fn usage_after(&self, name: &str, after: usize) -> Usage {
        let mut usage = Usage::default();
        if let Some(items) = self.by_name.get(name) {
            for item in items {
                if item.pos <= after {
                    continue;
                }
                match item.kind {
                    OccKind::Read => {
                        if let Some(range) = &item.range {
                            usage.reads.push(range.clone());
                        }
                    }
                    OccKind::Write => usage.writes += 1,
                    OccKind::Redeclare => usage.redeclared = true,
                    OccKind::Capture => usage.captured = true,
                }
            }
        }
        usage
    }
}

fn index_read(ctx: &Ctx<'_>, span: TokSpan, index: &mut UsageIndex) {
    if let (Some(name), Some(range)) = (ctx.text(span), ctx.range(span)) {
        index.add(
            name,
            Occurrence {
                pos: range.start,
                range: Some(range),
                kind: OccKind::Read,
            },
        );
    }
}

fn index_binding(ctx: &Ctx<'_>, span: TokSpan, index: &mut UsageIndex) {
    if let (Some(name), Some(range)) = (ctx.text(span), ctx.range(span)) {
        index.add(
            name,
            Occurrence {
                pos: range.start,
                range: None,
                kind: OccKind::Redeclare,
            },
        );
    }
}

fn index_write(ctx: &Ctx<'_>, span: TokSpan, index: &mut UsageIndex) {
    if let (Some(name), Some(range)) = (ctx.text(span), ctx.range(span)) {
        index.add(
            name,
            Occurrence {
                pos: range.start,
                range: Some(range),
                kind: OccKind::Write,
            },
        );
    }
}

fn index_capture_span(ctx: &Ctx<'_>, span: TokSpan, index: &mut UsageIndex) {
    let Some(range) = ctx.range(span) else {
        return;
    };
    let mut names = HashSet::new();
    for token in ctx
        .toks
        .iter()
        .skip(span.start as usize)
        .take((span.end - span.start) as usize)
    {
        if token.kind == TokKind::Ident {
            names.insert(token.text(ctx.src));
        }
    }
    for name in names {
        index.add(
            name,
            Occurrence {
                pos: range.start,
                range: None,
                kind: OccKind::Capture,
            },
        );
    }
}

fn index_expr(ctx: &Ctx<'_>, expr: &Expr, index: &mut UsageIndex) {
    match expr {
        Expr::Name(span) => index_read(ctx, *span, index),
        Expr::Function { span, .. } => index_capture_span(ctx, *span, index),
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(v) => index_expr(ctx, v, index),
                    TableField::Named { value, .. } => index_expr(ctx, value, index),
                    TableField::Computed { key, value } => {
                        index_expr(ctx, key, index);
                        index_expr(ctx, value, index);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            index_expr(ctx, lhs, index);
            index_expr(ctx, rhs, index);
        }
        Expr::Unary { operand, .. } => index_expr(ctx, operand, index),
        Expr::Paren { inner, .. } => index_expr(ctx, inner, index),
        Expr::Index { object, key, .. } => {
            index_expr(ctx, object, index);
            if let IndexKey::Computed(k) = key {
                index_expr(ctx, k, index);
            }
        }
        Expr::Call { func, args, .. } => {
            index_expr(ctx, func, index);
            match args {
                CallArgs::Paren(v) => {
                    for e in v {
                        index_expr(ctx, e, index);
                    }
                }
                CallArgs::Table(e) => index_expr(ctx, e, index),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                index_expr(ctx, a, index);
                index_expr(ctx, b, index);
            }
            index_expr(ctx, else_value, index);
        }
        Expr::TypeAssert { expr, .. } => index_expr(ctx, expr, index),
        _ => {}
    }
}

fn index_target(ctx: &Ctx<'_>, expr: &Expr, index: &mut UsageIndex) {
    match expr {
        Expr::Name(span) => index_write(ctx, *span, index),
        Expr::Index { object, key, .. } => {
            index_expr(ctx, object, index);
            if let IndexKey::Computed(k) = key {
                index_expr(ctx, k, index);
            }
        }
        _ => index_expr(ctx, expr, index),
    }
}

fn index_block_into(ctx: &Ctx<'_>, block: &Block, index: &mut UsageIndex) {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(n) => {
                for e in &n.values {
                    index_expr(ctx, e, index);
                }
                for b in &n.names {
                    index_binding(ctx, b.name, index);
                }
            }
            Stmt::Assign(n) => {
                for t in &n.targets {
                    index_target(ctx, t, index);
                }
                for e in &n.values {
                    index_expr(ctx, e, index);
                }
            }
            Stmt::Call(e, _) => index_expr(ctx, e, index),
            Stmt::Do(n) => index_block_into(ctx, &n.block, index),
            Stmt::While(n) => {
                index_expr(ctx, &n.cond, index);
                index_block_into(ctx, &n.block, index);
            }
            Stmt::Repeat(n) => {
                index_block_into(ctx, &n.block, index);
                index_expr(ctx, &n.cond, index);
            }
            Stmt::If(n) => {
                for (c, b) in &n.branches {
                    index_expr(ctx, c, index);
                    index_block_into(ctx, b, index);
                }
                if let Some(b) = &n.else_block {
                    index_block_into(ctx, b, index);
                }
            }
            Stmt::NumericFor(n) => {
                index_expr(ctx, &n.start, index);
                index_expr(ctx, &n.limit, index);
                if let Some(e) = &n.step {
                    index_expr(ctx, e, index);
                }
                index_binding(ctx, n.var.name, index);
                index_block_into(ctx, &n.block, index);
            }
            Stmt::GenericFor(n) => {
                for e in &n.exprs {
                    index_expr(ctx, e, index);
                }
                for b in &n.vars {
                    index_binding(ctx, b.name, index);
                }
                index_block_into(ctx, &n.block, index);
            }
            Stmt::Function(n) => {
                for span in &n.path {
                    index_write(ctx, *span, index);
                }
                index_capture_span(ctx, n.span, index);
            }
            Stmt::LocalFunction(n) => {
                index_binding(ctx, n.name, index);
                index_capture_span(ctx, n.span, index);
            }
            Stmt::Return(n) => {
                for e in &n.values {
                    index_expr(ctx, e, index);
                }
            }
            _ => {}
        }
    }
}

fn build_usage_index_with_tail(ctx: &Ctx<'_>, block: &Block, tail: Option<&Expr>) -> UsageIndex {
    let mut index = UsageIndex::default();
    index_block_into(ctx, block, &mut index);
    if let Some(expr) = tail {
        index_expr(ctx, expr, &mut index);
    }
    index
}

fn build_usage_index(ctx: &Ctx<'_>, block: &Block) -> UsageIndex {
    build_usage_index_with_tail(ctx, block, None)
}

fn stmt_contains_range(ctx: &Ctx<'_>, stmt: &Stmt, range: &Range<usize>) -> bool {
    ctx.stmt_range(stmt)
        .is_some_and(|r| r.start <= range.start && r.end >= range.end)
}

fn direct_statement_index_containing(
    ctx: &Ctx<'_>,
    block: &Block,
    start_index: usize,
    target: &Range<usize>,
) -> Option<usize> {
    if start_index >= block.stmts.len() {
        return None;
    }
    let mut lo = start_index;
    let mut hi = block.stmts.len();
    while lo < hi {
        let mid = lo + (hi - lo) / 2;
        let Some(range) = ctx.stmt_range(&block.stmts[mid]) else {
            // Rare malformed/empty statement range: fall back to the safe linear path.
            return block.stmts[start_index..]
                .iter()
                .position(|stmt| stmt_contains_range(ctx, stmt, target))
                .map(|offset| start_index + offset);
        };
        if range.start <= target.start {
            lo = mid + 1;
        } else {
            hi = mid;
        }
    }
    let candidate = lo.checked_sub(1)?;
    if candidate < start_index {
        return None;
    }
    stmt_contains_range(ctx, &block.stmts[candidate], target).then_some(candidate)
}

fn expr_leading_use(ctx: &Ctx<'_>, expr: &Expr, target: &Range<usize>) -> bool {
    if let Expr::Name(span) = expr {
        if span_eq(ctx, *span, target) {
            return true;
        }
    }
    match expr {
        Expr::Paren { inner, .. }
        | Expr::TypeAssert { expr: inner, .. }
        | Expr::Unary { operand: inner, .. } => expr_leading_use(ctx, inner, target),
        Expr::Binary { op, lhs, rhs, .. } => {
            if expr_leading_use(ctx, lhs, target) {
                true
            } else {
                let logical = matches!(ctx.text(*op), Some("and") | Some("or"));
                !logical && is_pure_literal(lhs) && expr_leading_use(ctx, rhs, target)
            }
        }
        Expr::Index { object, .. } => expr_leading_use(ctx, object, target),
        Expr::Call { func, .. } => expr_leading_use(ctx, func, target),
        _ => false,
    }
}

fn stable_index_key_use(
    ctx: &Ctx<'_>,
    expr: &Expr,
    target: &Range<usize>,
    block: &Block,
    before_index: usize,
    outer_lexical: &HashSet<String>,
) -> bool {
    match expr {
        Expr::Paren { inner, .. } | Expr::TypeAssert { expr: inner, .. } => {
            stable_index_key_use(ctx, inner, target, block, before_index, outer_lexical)
        }
        Expr::Index {
            object,
            key: IndexKey::Computed(key),
            ..
        } => {
            let Expr::Name(base_span) = object.as_ref() else {
                return false;
            };
            let Some(base_name) = ctx.text(*base_span) else {
                return false;
            };
            name_is_immediate_stable_lexical(ctx, block, before_index, base_name, outer_lexical)
                && expr_leading_use(ctx, key, target)
        }
        _ => false,
    }
}
fn leading_call_base_span(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> Option<TokSpan> {
    match expr {
        Expr::Paren { inner, .. } | Expr::TypeAssert { expr: inner, .. } => {
            leading_call_base_span(ctx, inner, name)
        }
        Expr::Binary { lhs, .. } => leading_call_base_span(ctx, lhs, name),
        Expr::Call { func, .. } => match func.as_ref() {
            Expr::Name(span) if ctx.text(*span) == Some(name) => Some(*span),
            Expr::Paren { inner, .. } => match inner.as_ref() {
                Expr::Name(span) if ctx.text(*span) == Some(name) => Some(*span),
                _ => None,
            },
            _ => None,
        },
        _ => None,
    }
}

fn direct_if_condition_name_span(ctx: &Ctx<'_>, stmt: &Stmt, name: &str) -> Option<TokSpan> {
    fn inner(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> Option<TokSpan> {
        match expr {
            Expr::Paren { inner: value, .. } | Expr::TypeAssert { expr: value, .. } => {
                inner(ctx, value, name)
            }
            Expr::Unary { op, operand, .. } if ctx.text(*op) == Some("not") => {
                inner(ctx, operand, name)
            }
            Expr::Name(span) if ctx.text(*span) == Some(name) => Some(*span),
            _ => None,
        }
    }
    let Stmt::If(node) = stmt else {
        return None;
    };
    let (condition, _) = node.branches.first()?;
    inner(ctx, condition, name)
}

fn direct_if_condition_call(stmt: &Stmt) -> Option<&Expr> {
    fn inner(expr: &Expr) -> Option<&Expr> {
        match expr {
            Expr::Call { .. } => Some(expr),
            Expr::Paren { inner: value, .. }
            | Expr::TypeAssert { expr: value, .. }
            | Expr::Unary { operand: value, .. } => inner(value),
            _ => None,
        }
    }

    let Stmt::If(node) = stmt else {
        return None;
    };
    node.branches.first().and_then(|(condition, _)| inner(condition))
}
fn direct_call_base_name_span(ctx: &Ctx<'_>, stmt: &Stmt, name: &str) -> Option<TokSpan> {
    let call = call_expr_whole(stmt).or_else(|| direct_if_condition_call(stmt))?;
    let (func, _, _) = call_parts(call)?;
    match unwrap_parens(func) {
        Expr::Name(span) if ctx.text(*span) == Some(name) => Some(*span),
        _ => None,
    }
}

fn direct_assignment_target_base_name_span(
    ctx: &Ctx<'_>,
    stmt: &Stmt,
    name: &str,
) -> Option<TokSpan> {
    let Stmt::Assign(node) = stmt else {
        return None;
    };
    if node.targets.len() != 1 {
        return None;
    }
    let Expr::Index { object, key, .. } = unwrap_parens(&node.targets[0]) else {
        return None;
    };
    if !matches!(key, IndexKey::Field(_)) {
        return None;
    }
    match unwrap_parens(object) {
        Expr::Name(span) if ctx.text(*span) == Some(name) => Some(*span),
        _ => None,
    }
}

fn stmt_leading_use(ctx: &Ctx<'_>, stmt: &Stmt, target: &Range<usize>) -> bool {
    match stmt {
        Stmt::Local(n) => n
            .values
            .first()
            .is_some_and(|e| expr_leading_use(ctx, e, target)),
        Stmt::Call(e, _) => expr_leading_use(ctx, e, target),
        Stmt::Return(n) => n
            .values
            .first()
            .is_some_and(|e| expr_leading_use(ctx, e, target)),
        Stmt::Assign(n)
            if n.targets.len() == 1
                && n.values.len() == 1
                && matches!(n.targets[0], Expr::Name(_)) =>
        {
            expr_leading_use(ctx, &n.values[0], target)
        }
        Stmt::If(n) => n
            .branches
            .first()
            .is_some_and(|(c, _)| expr_leading_use(ctx, c, target)),
        _ => false,
    }
}

fn expr_span_contains_range(ctx: &Ctx<'_>, expr: &Expr, target: &Range<usize>) -> bool {
    ctx.range(expr.span())
        .is_some_and(|range| range.start <= target.start && range.end >= target.end)
}

fn stmt_has_direct_expression_use(ctx: &Ctx<'_>, stmt: &Stmt, target: &Range<usize>) -> bool {
    match stmt {
        Stmt::Local(node) => node
            .values
            .iter()
            .any(|expr| expr_span_contains_range(ctx, expr, target)),
        Stmt::Assign(node) => node
            .targets
            .iter()
            .chain(node.values.iter())
            .any(|expr| expr_span_contains_range(ctx, expr, target)),
        Stmt::Call(expr, _) => expr_span_contains_range(ctx, expr, target),
        Stmt::Return(node) => node
            .values
            .iter()
            .any(|expr| expr_span_contains_range(ctx, expr, target)),
        Stmt::If(node) => node
            .branches
            .iter()
            .any(|(condition, _)| expr_span_contains_range(ctx, condition, target)),
        Stmt::While(node) => expr_span_contains_range(ctx, &node.cond, target),
        Stmt::Repeat(node) => expr_span_contains_range(ctx, &node.cond, target),
        Stmt::NumericFor(node) => {
            expr_span_contains_range(ctx, &node.start, target)
                || expr_span_contains_range(ctx, &node.limit, target)
                || node
                    .step
                    .as_ref()
                    .is_some_and(|expr| expr_span_contains_range(ctx, expr, target))
        }
        Stmt::GenericFor(node) => node
            .exprs
            .iter()
            .any(|expr| expr_span_contains_range(ctx, expr, target)),
        _ => false,
    }
}

fn is_repeated_evaluation_statement(stmt: &Stmt) -> bool {
    matches!(
        stmt,
        Stmt::While(_) | Stmt::Repeat(_) | Stmt::NumericFor(_) | Stmt::GenericFor(_)
    )
}

fn local_single(stmt: &Stmt) -> Option<(&Binding, &Expr)> {
    let Stmt::Local(n) = stmt else {
        return None;
    };
    if n.names.len() != 1 || n.values.len() != 1 {
        return None;
    }
    Some((&n.names[0], &n.values[0]))
}

fn local_uninitialized(stmt: &Stmt) -> Option<&Binding> {
    let Stmt::Local(n) = stmt else {
        return None;
    };
    if n.names.len() != 1 || !n.values.is_empty() {
        return None;
    }
    Some(&n.names[0])
}

fn assignment_single(stmt: &Stmt) -> Option<(&Expr, &Expr)> {
    let Stmt::Assign(n) = stmt else {
        return None;
    };
    if n.targets.len() != 1 || n.values.len() != 1 {
        return None;
    }
    Some((&n.targets[0], &n.values[0]))
}

fn call_expr_whole(stmt: &Stmt) -> Option<&Expr> {
    match stmt {
        Stmt::Call(e, _) => Some(e),
        Stmt::Local(n) if n.values.len() == 1 && matches!(n.values[0], Expr::Call { .. }) => {
            Some(&n.values[0])
        }
        Stmt::Assign(n) if n.values.len() == 1 && matches!(n.values[0], Expr::Call { .. }) => {
            Some(&n.values[0])
        }
        Stmt::Return(n) if n.values.len() == 1 && matches!(n.values[0], Expr::Call { .. }) => {
            Some(&n.values[0])
        }
        _ => None,
    }
}

fn find_direct_call_by_func_range_in_expr<'a>(
    ctx: &Ctx<'_>,
    expr: &'a Expr,
    target: &Range<usize>,
) -> Option<&'a Expr> {
    match expr {
        Expr::Function { .. } => None,
        Expr::Call { func, args, .. } => {
            if ctx.range(func.span()).is_some_and(|range| range == *target) {
                return Some(expr);
            }
            if let Some(found) = find_direct_call_by_func_range_in_expr(ctx, func, target) {
                return Some(found);
            }
            match args {
                CallArgs::Paren(values) => values
                    .iter()
                    .find_map(|value| find_direct_call_by_func_range_in_expr(ctx, value, target)),
                CallArgs::Table(value) => find_direct_call_by_func_range_in_expr(ctx, value, target),
                CallArgs::Str(_) => None,
            }
        }
        Expr::Table { fields, .. } => fields.iter().find_map(|field| match field {
            TableField::Positional(value) | TableField::Named { value, .. } => {
                find_direct_call_by_func_range_in_expr(ctx, value, target)
            }
            TableField::Computed { key, value } => find_direct_call_by_func_range_in_expr(ctx, key, target)
                .or_else(|| find_direct_call_by_func_range_in_expr(ctx, value, target)),
        }),
        Expr::Binary { lhs, rhs, .. } => find_direct_call_by_func_range_in_expr(ctx, lhs, target)
            .or_else(|| find_direct_call_by_func_range_in_expr(ctx, rhs, target)),
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            find_direct_call_by_func_range_in_expr(ctx, operand, target)
        }
        Expr::Index { object, key, .. } => find_direct_call_by_func_range_in_expr(ctx, object, target)
            .or_else(|| match key {
                IndexKey::Field(_) => None,
                IndexKey::Computed(key) => find_direct_call_by_func_range_in_expr(ctx, key, target),
            }),
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => branches
            .iter()
            .find_map(|(condition, value)| {
                find_direct_call_by_func_range_in_expr(ctx, condition, target)
                    .or_else(|| find_direct_call_by_func_range_in_expr(ctx, value, target))
            })
            .or_else(|| find_direct_call_by_func_range_in_expr(ctx, else_value, target)),
        _ => None,
    }
}

fn find_direct_call_by_func_range_in_stmt<'a>(
    ctx: &Ctx<'_>,
    stmt: &'a Stmt,
    target: &Range<usize>,
) -> Option<&'a Expr> {
    match stmt {
        Stmt::Local(node) => node
            .values
            .iter()
            .find_map(|expr| find_direct_call_by_func_range_in_expr(ctx, expr, target)),
        Stmt::Assign(node) => node
            .values
            .iter()
            .find_map(|expr| find_direct_call_by_func_range_in_expr(ctx, expr, target)),
        Stmt::Call(expr, _) => find_direct_call_by_func_range_in_expr(ctx, expr, target),
        Stmt::Return(node) => node
            .values
            .iter()
            .find_map(|expr| find_direct_call_by_func_range_in_expr(ctx, expr, target)),
        Stmt::If(node) => node
            .branches
            .iter()
            .find_map(|(condition, _)| find_direct_call_by_func_range_in_expr(ctx, condition, target)),
        Stmt::GenericFor(node) => node
            .exprs
            .iter()
            .find_map(|expr| find_direct_call_by_func_range_in_expr(ctx, expr, target)),
        Stmt::NumericFor(node) => find_direct_call_by_func_range_in_expr(ctx, &node.start, target)
            .or_else(|| find_direct_call_by_func_range_in_expr(ctx, &node.limit, target))
            .or_else(|| {
                node.step
                    .as_ref()
                    .and_then(|expr| find_direct_call_by_func_range_in_expr(ctx, expr, target))
            }),
        _ => None,
    }
}

fn call_is_unpack_name(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> bool {
    let Some((func, method, args)) = call_parts(expr) else {
        return false;
    };
    if method.is_some() || name_of_expr(ctx, func) != Some("unpack") {
        return false;
    }
    let Some(args) = paren_args(args) else {
        return false;
    };
    args.len() == 1 && name_of_expr(ctx, &args[0]) == Some(name)
}

fn table_single_call(expr: &Expr) -> Option<&Expr> {
    let Expr::Table { fields, .. } = expr else {
        return None;
    };
    if fields.len() != 1 {
        return None;
    }
    match &fields[0] {
        TableField::Positional(e) if matches!(e, Expr::Call { .. }) => Some(e),
        _ => None,
    }
}

fn table_single_index_of<'a>(ctx: &Ctx<'_>, expr: &'a Expr, base: &str) -> Option<usize> {
    let Expr::Index { object, key, .. } = expr else {
        return None;
    };
    if name_of_expr(ctx, object) != Some(base) {
        return None;
    }
    let IndexKey::Computed(k) = key else {
        return None;
    };
    let Expr::Number(span) = k.as_ref() else {
        return None;
    };
    ctx.text(*span)?.parse::<usize>().ok().filter(|n| *n >= 1)
}

fn edit_overlaps(ctx: &Ctx<'_>, start: usize, end: usize) -> bool {
    let intervals = ctx.edit_intervals.borrow();
    intervals
        .range(..end)
        .next_back()
        .is_some_and(|(_, existing_end)| *existing_end > start)
}

fn add_edit(ctx: &Ctx<'_>, edits: &mut Vec<Edit>, edit: Edit) -> bool {
    if edit.start >= edit.end || edit_overlaps(ctx, edit.start, edit.end) {
        return false;
    }
    ctx.edit_intervals.borrow_mut().insert(edit.start, edit.end);
    edits.push(edit);
    true
}

fn add_group(ctx: &Ctx<'_>, edits: &mut Vec<Edit>, group: Vec<Edit>) -> bool {
    if group.iter().any(|e| e.start >= e.end) {
        return false;
    }
    for (index, left) in group.iter().enumerate() {
        if edit_overlaps(ctx, left.start, left.end) {
            return false;
        }
        if group
            .iter()
            .skip(index + 1)
            .any(|right| left.start < right.end && right.start < left.end)
        {
            return false;
        }
    }
    {
        let mut intervals = ctx.edit_intervals.borrow_mut();
        for edit in &group {
            intervals.insert(edit.start, edit.end);
        }
    }
    edits.extend(group);
    true
}
fn collect_env_folds(ctx: &Ctx<'_>, expr: &Expr, edits: &mut Vec<Edit>) {
    match expr {
        Expr::Index { object, key, span } => {
            if name_of_expr(ctx, object) == Some("_env") {
                if let IndexKey::Computed(k) = key {
                    if let Some(id) = simple_string_identifier(ctx, k) {
                        if let Some(r) = ctx.range(*span) {
                            add_edit(
                                ctx,
                                edits,
                                Edit {
                                    start: r.start,
                                    end: r.end,
                                    replacement: id,
                                    kind: EditKind::EnvFold,
                                },
                            );
                            return;
                        }
                    }
                }
            }
            collect_env_folds(ctx, object, edits);
            if let IndexKey::Computed(k) = key {
                collect_env_folds(ctx, k, edits);
            }
        }
        Expr::Table { fields, .. } => {
            for f in fields {
                match f {
                    TableField::Positional(v) => collect_env_folds(ctx, v, edits),
                    TableField::Named { value, .. } => collect_env_folds(ctx, value, edits),
                    TableField::Computed { key, value } => {
                        collect_env_folds(ctx, key, edits);
                        collect_env_folds(ctx, value, edits);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_env_folds(ctx, lhs, edits);
            collect_env_folds(ctx, rhs, edits);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => collect_env_folds(ctx, operand, edits),
        Expr::Call { func, args, .. } => {
            collect_env_folds(ctx, func, edits);
            match args {
                CallArgs::Paren(v) => {
                    for e in v {
                        collect_env_folds(ctx, e, edits)
                    }
                }
                CallArgs::Table(e) => collect_env_folds(ctx, e, edits),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                collect_env_folds(ctx, a, edits);
                collect_env_folds(ctx, b, edits);
            }
            collect_env_folds(ctx, else_value, edits);
        }
        Expr::Function { .. } => {}
        _ => {}
    }
}

fn collect_env_folds_stmt(ctx: &Ctx<'_>, stmt: &Stmt, edits: &mut Vec<Edit>) {
    match stmt {
        Stmt::Local(n) => {
            for e in &n.values {
                collect_env_folds(ctx, e, edits)
            }
        }
        Stmt::Assign(n) => {
            for e in n.targets.iter().chain(n.values.iter()) {
                collect_env_folds(ctx, e, edits)
            }
        }
        Stmt::Call(e, _) => collect_env_folds(ctx, e, edits),
        Stmt::While(n) => collect_env_folds(ctx, &n.cond, edits),
        Stmt::Repeat(n) => collect_env_folds(ctx, &n.cond, edits),
        Stmt::If(n) => {
            for (c, _) in &n.branches {
                collect_env_folds(ctx, c, edits)
            }
        }
        Stmt::NumericFor(n) => {
            collect_env_folds(ctx, &n.start, edits);
            collect_env_folds(ctx, &n.limit, edits);
            if let Some(e) = &n.step {
                collect_env_folds(ctx, e, edits);
            }
        }
        Stmt::GenericFor(n) => {
            for e in &n.exprs {
                collect_env_folds(ctx, e, edits)
            }
        }
        Stmt::Return(n) => {
            for e in &n.values {
                collect_env_folds(ctx, e, edits)
            }
        }
        _ => {}
    }
}

fn collect_static_field_indexes(ctx: &Ctx<'_>, expr: &Expr, edits: &mut Vec<Edit>) {
    match expr {
        Expr::Index { object, key, span } => {
            if let IndexKey::Computed(k) = key {
                if let (Some(id), Some(object_text), Some(r)) = (
                    simple_string_identifier(ctx, k),
                    ctx.expr_text(object),
                    ctx.range(*span),
                ) {
                    let base = match unwrap_parens(object) {
                        Expr::Name(_) | Expr::Index { .. } | Expr::Call { .. } => {
                            object_text.to_string()
                        }
                        _ => format!("({object_text})"),
                    };
                    if add_edit(
                        ctx,
                        edits,
                        Edit {
                            start: r.start,
                            end: r.end,
                            replacement: format!("{base}.{id}"),
                            kind: EditKind::StaticFieldIndex,
                        },
                    ) {
                        return;
                    }
                }
            }
            collect_static_field_indexes(ctx, object, edits);
            if let IndexKey::Computed(k) = key {
                collect_static_field_indexes(ctx, k, edits);
            }
        }
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(value) | TableField::Named { value, .. } => {
                        collect_static_field_indexes(ctx, value, edits)
                    }
                    TableField::Computed { key, value } => {
                        collect_static_field_indexes(ctx, key, edits);
                        collect_static_field_indexes(ctx, value, edits);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_static_field_indexes(ctx, lhs, edits);
            collect_static_field_indexes(ctx, rhs, edits);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            collect_static_field_indexes(ctx, operand, edits)
        }
        Expr::Call { func, args, .. } => {
            collect_static_field_indexes(ctx, func, edits);
            match args {
                CallArgs::Paren(values) => {
                    for value in values {
                        collect_static_field_indexes(ctx, value, edits);
                    }
                }
                CallArgs::Table(value) => collect_static_field_indexes(ctx, value, edits),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (condition, value) in branches {
                collect_static_field_indexes(ctx, condition, edits);
                collect_static_field_indexes(ctx, value, edits);
            }
            collect_static_field_indexes(ctx, else_value, edits);
        }
        Expr::Function { .. } => {}
        _ => {}
    }
}

fn collect_static_field_indexes_stmt(ctx: &Ctx<'_>, stmt: &Stmt, edits: &mut Vec<Edit>) {
    match stmt {
        Stmt::Local(node) => {
            for expr in &node.values {
                collect_static_field_indexes(ctx, expr, edits);
            }
        }
        Stmt::Assign(node) => {
            for expr in node.targets.iter().chain(node.values.iter()) {
                collect_static_field_indexes(ctx, expr, edits);
            }
        }
        Stmt::Call(expr, _) => collect_static_field_indexes(ctx, expr, edits),
        Stmt::While(node) => collect_static_field_indexes(ctx, &node.cond, edits),
        Stmt::Repeat(node) => collect_static_field_indexes(ctx, &node.cond, edits),
        Stmt::If(node) => {
            for (condition, _) in &node.branches {
                collect_static_field_indexes(ctx, condition, edits);
            }
        }
        Stmt::NumericFor(node) => {
            collect_static_field_indexes(ctx, &node.start, edits);
            collect_static_field_indexes(ctx, &node.limit, edits);
            if let Some(step) = &node.step {
                collect_static_field_indexes(ctx, step, edits);
            }
        }
        Stmt::GenericFor(node) => {
            for expr in &node.exprs {
                collect_static_field_indexes(ctx, expr, edits);
            }
        }
        Stmt::Return(node) => {
            for expr in &node.values {
                collect_static_field_indexes(ctx, expr, edits);
            }
        }
        _ => {}
    }
}

fn unwrap_parens(expr: &Expr) -> &Expr {
    match expr {
        Expr::Paren { inner, .. } | Expr::TypeAssert { expr: inner, .. } => unwrap_parens(inner),
        _ => expr,
    }
}

fn direct_call_named_no_args(ctx: &Ctx<'_>, expr: &Expr, name: &str) -> bool {
    let expr = unwrap_parens(expr);
    let Some((func, method, args)) = call_parts(expr) else {
        return false;
    };
    method.is_none()
        && name_of_expr(ctx, func) == Some(name)
        && paren_args(args).is_some_and(|args| args.is_empty())
}

fn unwrapped_call(expr: &Expr) -> Option<&Expr> {
    let expr = unwrap_parens(expr);
    matches!(expr, Expr::Call { .. }).then_some(expr)
}

fn direct_local_names_before(ctx: &Ctx<'_>, block: &Block, index: usize) -> HashSet<String> {
    let mut names = HashSet::new();
    for stmt in block.stmts.iter().take(index) {
        match stmt {
            Stmt::Local(local) => {
                for binding in &local.names {
                    if let Some(name) = ctx.text(binding.name) {
                        names.insert(name.to_string());
                    }
                }
            }
            Stmt::LocalFunction(local) => {
                if let Some(name) = ctx.text(local.name) {
                    names.insert(name.to_string());
                }
            }
            _ => {}
        }
    }
    names
}

fn direct_local_declared_before(ctx: &Ctx<'_>, block: &Block, index: usize, name: &str) -> bool {
    // Build each immutable block's direct declaration positions once per parse round.
    // Hot callers then answer prefix-membership without rescanning prior statements.
    let block_key = block as *const Block as usize;
    if !ctx.direct_decl_cache.borrow().contains_key(&block_key) {
        let mut declarations: HashMap<String, Vec<usize>> = HashMap::new();
        for (stmt_index, stmt) in block.stmts.iter().enumerate() {
            match stmt {
                Stmt::Local(local) => {
                    for binding in &local.names {
                        if let Some(local_name) = ctx.text(binding.name) {
                            declarations
                                .entry(local_name.to_string())
                                .or_default()
                                .push(stmt_index);
                        }
                    }
                }
                Stmt::LocalFunction(local) => {
                    if let Some(local_name) = ctx.text(local.name) {
                        declarations
                            .entry(local_name.to_string())
                            .or_default()
                            .push(stmt_index);
                    }
                }
                _ => {}
            }
        }
        ctx.direct_decl_cache
            .borrow_mut()
            .insert(block_key, declarations);
    }
    ctx.direct_decl_cache
        .borrow()
        .get(&block_key)
        .and_then(|declarations| declarations.get(name))
        .is_some_and(|positions| positions.first().is_some_and(|position| *position < index))
}

fn scopes_resolve(scopes: &[HashSet<String>], name: &str) -> bool {
    scopes.iter().rev().any(|scope| scope.contains(name))
}

fn lexical_expr(ctx: &Ctx<'_>, expr: &Expr, scopes: &mut Vec<HashSet<String>>) -> bool {
    match expr {
        Expr::Name(span) => ctx
            .text(*span)
            .is_some_and(|name| scopes_resolve(scopes, name)),
        Expr::Function { body, .. } => lexical_function_body(ctx, body, scopes),
        Expr::Table { fields, .. } => fields.iter().all(|field| match field {
            TableField::Positional(value) => lexical_expr(ctx, value, scopes),
            TableField::Named { value, .. } => lexical_expr(ctx, value, scopes),
            TableField::Computed { key, value } => {
                lexical_expr(ctx, key, scopes) && lexical_expr(ctx, value, scopes)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            lexical_expr(ctx, lhs, scopes) && lexical_expr(ctx, rhs, scopes)
        }
        Expr::Unary { operand, .. } => lexical_expr(ctx, operand, scopes),
        Expr::Paren { inner, .. } => lexical_expr(ctx, inner, scopes),
        Expr::Index { object, key, .. } => {
            lexical_expr(ctx, object, scopes)
                && match key {
                    IndexKey::Field(_) => true,
                    IndexKey::Computed(key) => lexical_expr(ctx, key, scopes),
                }
        }
        Expr::Call { func, args, .. } => {
            lexical_expr(ctx, func, scopes)
                && match args {
                    CallArgs::Paren(values) => {
                        values.iter().all(|value| lexical_expr(ctx, value, scopes))
                    }
                    CallArgs::Table(value) => lexical_expr(ctx, value, scopes),
                    CallArgs::Str(_) => true,
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches.iter().all(|(condition, value)| {
                lexical_expr(ctx, condition, scopes) && lexical_expr(ctx, value, scopes)
            }) && lexical_expr(ctx, else_value, scopes)
        }
        Expr::TypeAssert { expr, .. } => lexical_expr(ctx, expr, scopes),
        _ => true,
    }
}

fn lexical_target(ctx: &Ctx<'_>, expr: &Expr, scopes: &mut Vec<HashSet<String>>) -> bool {
    match expr {
        Expr::Name(span) => ctx
            .text(*span)
            .is_some_and(|name| scopes_resolve(scopes, name)),
        Expr::Index { object, key, .. } => {
            lexical_expr(ctx, object, scopes)
                && match key {
                    IndexKey::Field(_) => true,
                    IndexKey::Computed(key) => lexical_expr(ctx, key, scopes),
                }
        }
        _ => lexical_expr(ctx, expr, scopes),
    }
}

fn lexical_child_block(ctx: &Ctx<'_>, block: &Block, scopes: &mut Vec<HashSet<String>>) -> bool {
    scopes.push(HashSet::new());
    let ok = lexical_block(ctx, block, scopes);
    scopes.pop();
    ok
}

fn lexical_function_body(
    ctx: &Ctx<'_>,
    body: &FunctionBody,
    inherited: &mut Vec<HashSet<String>>,
) -> bool {
    let mut scopes = inherited.clone();
    let mut params = HashSet::new();
    for param in &body.params {
        if !param.is_vararg {
            if let Some(name) = ctx.text(param.name) {
                params.insert(name.to_string());
            }
        }
    }
    scopes.push(params);
    lexical_block(ctx, &body.block, &mut scopes)
}

fn lexical_block(ctx: &Ctx<'_>, block: &Block, scopes: &mut Vec<HashSet<String>>) -> bool {
    for stmt in &block.stmts {
        let ok = match stmt {
            Stmt::Local(local) => {
                if !local
                    .values
                    .iter()
                    .all(|value| lexical_expr(ctx, value, scopes))
                {
                    false
                } else {
                    if let Some(scope) = scopes.last_mut() {
                        for binding in &local.names {
                            if let Some(name) = ctx.text(binding.name) {
                                scope.insert(name.to_string());
                            }
                        }
                    }
                    true
                }
            }
            Stmt::Assign(assign) => {
                assign
                    .values
                    .iter()
                    .all(|value| lexical_expr(ctx, value, scopes))
                    && assign
                        .targets
                        .iter()
                        .all(|target| lexical_target(ctx, target, scopes))
            }
            Stmt::Call(expr, _) => lexical_expr(ctx, expr, scopes),
            Stmt::Do(node) => lexical_child_block(ctx, &node.block, scopes),
            Stmt::While(node) => {
                lexical_expr(ctx, &node.cond, scopes)
                    && lexical_child_block(ctx, &node.block, scopes)
            }
            Stmt::Repeat(node) => {
                scopes.push(HashSet::new());
                let body_ok = lexical_block(ctx, &node.block, scopes);
                let cond_ok = body_ok && lexical_expr(ctx, &node.cond, scopes);
                scopes.pop();
                cond_ok
            }
            Stmt::If(node) => {
                node.branches.iter().all(|(condition, body)| {
                    lexical_expr(ctx, condition, scopes) && lexical_child_block(ctx, body, scopes)
                }) && node
                    .else_block
                    .as_ref()
                    .is_none_or(|body| lexical_child_block(ctx, body, scopes))
            }
            Stmt::NumericFor(node) => {
                if !lexical_expr(ctx, &node.start, scopes)
                    || !lexical_expr(ctx, &node.limit, scopes)
                    || node
                        .step
                        .as_ref()
                        .is_some_and(|step| !lexical_expr(ctx, step, scopes))
                {
                    false
                } else {
                    scopes.push(HashSet::new());
                    if let Some(name) = ctx.text(node.var.name) {
                        scopes.last_mut().unwrap().insert(name.to_string());
                    }
                    let ok = lexical_block(ctx, &node.block, scopes);
                    scopes.pop();
                    ok
                }
            }
            Stmt::GenericFor(node) => {
                if !node
                    .exprs
                    .iter()
                    .all(|expr| lexical_expr(ctx, expr, scopes))
                {
                    false
                } else {
                    scopes.push(HashSet::new());
                    for binding in &node.vars {
                        if let Some(name) = ctx.text(binding.name) {
                            scopes.last_mut().unwrap().insert(name.to_string());
                        }
                    }
                    let ok = lexical_block(ctx, &node.block, scopes);
                    scopes.pop();
                    ok
                }
            }
            Stmt::Function(node) => {
                let base_ok = node
                    .path
                    .first()
                    .and_then(|span| ctx.text(*span))
                    .is_some_and(|name| scopes_resolve(scopes, name));
                base_ok && lexical_function_body(ctx, &node.body, scopes)
            }
            Stmt::LocalFunction(node) => {
                if let Some(name) = ctx.text(node.name) {
                    scopes.last_mut().unwrap().insert(name.to_string());
                }
                lexical_function_body(ctx, &node.body, scopes)
            }
            Stmt::Return(node) => node
                .values
                .iter()
                .all(|value| lexical_expr(ctx, value, scopes)),
            _ => true,
        };
        if !ok {
            return false;
        }
    }
    true
}

fn function_move_is_lexical(
    ctx: &Ctx<'_>,
    body: &FunctionBody,
    outer_locals: HashSet<String>,
) -> bool {
    let mut scopes = vec![outer_locals];
    lexical_function_body(ctx, body, &mut scopes)
}

fn gap_is_safe_for_function_move(
    ctx: &Ctx<'_>,
    block: &Block,
    start: usize,
    end: usize,
    body: &FunctionBody,
) -> bool {
    // Match the JS reference proof: arbitrary intervening execution is allowed
    // once the closure has no environment/global-backed runtime bindings. Moving
    // closure creation itself does not execute its body. The only lexical hazard
    // is a new same-block local declaration that could capture a different cell.
    for stmt in block.stmts.iter().take(end).skip(start) {
        match stmt {
            Stmt::Local(local) => {
                for binding in &local.names {
                    if let Some(name) = ctx.text(binding.name) {
                        if block_contains_name(ctx, &body.block, name) {
                            return false;
                        }
                    }
                }
            }
            Stmt::LocalFunction(local) => {
                if let Some(name) = ctx.text(local.name) {
                    if block_contains_name(ctx, &body.block, name) {
                        return false;
                    }
                }
            }
            _ => {}
        }
    }
    true
}

fn assignment_rhs_read<'a>(ctx: &Ctx<'_>, stmt: &'a Stmt, name: &str) -> Option<&'a Expr> {
    let (_, rhs) = assignment_single(stmt)?;
    (name_of_expr(ctx, rhs) == Some(name)).then_some(rhs)
}

fn usage_is_single_next_read(
    ctx: &Ctx<'_>,
    usage_index: &UsageIndex,
    name: &str,
    stmt_range: &Range<usize>,
    next_stmt: &Stmt,
    expected: TokSpan,
) -> bool {
    let usage = usage_index.usage_after(name, stmt_range.end);
    usage.reads.len() == 1
        && usage.writes == 0
        && !usage.redeclared
        && !usage.captured
        && ctx.range(expected).is_some_and(|r| r == usage.reads[0])
        && stmt_contains_range(ctx, next_stmt, &usage.reads[0])
}

fn collect_expr_nested_function_writes(ctx: &Ctx<'_>, expr: &Expr, out: &mut HashSet<String>) {
    match expr {
        Expr::Function { body, .. } => collect_function_body_writes(ctx, &body.block, out),
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(value) => {
                        collect_expr_nested_function_writes(ctx, value, out)
                    }
                    TableField::Named { value, .. } => {
                        collect_expr_nested_function_writes(ctx, value, out)
                    }
                    TableField::Computed { key, value } => {
                        collect_expr_nested_function_writes(ctx, key, out);
                        collect_expr_nested_function_writes(ctx, value, out);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_expr_nested_function_writes(ctx, lhs, out);
            collect_expr_nested_function_writes(ctx, rhs, out);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            collect_expr_nested_function_writes(ctx, operand, out)
        }
        Expr::Index { object, key, .. } => {
            collect_expr_nested_function_writes(ctx, object, out);
            if let IndexKey::Computed(key) = key {
                collect_expr_nested_function_writes(ctx, key, out);
            }
        }
        Expr::Call { func, args, .. } => {
            collect_expr_nested_function_writes(ctx, func, out);
            match args {
                CallArgs::Paren(values) => {
                    for value in values {
                        collect_expr_nested_function_writes(ctx, value, out);
                    }
                }
                CallArgs::Table(value) => collect_expr_nested_function_writes(ctx, value, out),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (condition, value) in branches {
                collect_expr_nested_function_writes(ctx, condition, out);
                collect_expr_nested_function_writes(ctx, value, out);
            }
            collect_expr_nested_function_writes(ctx, else_value, out);
        }
        _ => {}
    }
}

fn collect_function_body_writes(ctx: &Ctx<'_>, block: &Block, out: &mut HashSet<String>) {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(node) => {
                for value in &node.values {
                    collect_expr_nested_function_writes(ctx, value, out);
                }
            }
            Stmt::Assign(node) => {
                for target in &node.targets {
                    if let Expr::Name(span) = target {
                        if let Some(name) = ctx.text(*span) {
                            out.insert(name.to_string());
                        }
                    }
                    collect_expr_nested_function_writes(ctx, target, out);
                }
                for value in &node.values {
                    collect_expr_nested_function_writes(ctx, value, out);
                }
            }
            Stmt::Call(expr, _) => collect_expr_nested_function_writes(ctx, expr, out),
            Stmt::Do(node) => collect_function_body_writes(ctx, &node.block, out),
            Stmt::While(node) => {
                collect_expr_nested_function_writes(ctx, &node.cond, out);
                collect_function_body_writes(ctx, &node.block, out);
            }
            Stmt::Repeat(node) => {
                collect_function_body_writes(ctx, &node.block, out);
                collect_expr_nested_function_writes(ctx, &node.cond, out);
            }
            Stmt::If(node) => {
                for (condition, body) in &node.branches {
                    collect_expr_nested_function_writes(ctx, condition, out);
                    collect_function_body_writes(ctx, body, out);
                }
                if let Some(body) = &node.else_block {
                    collect_function_body_writes(ctx, body, out);
                }
            }
            Stmt::NumericFor(node) => {
                collect_expr_nested_function_writes(ctx, &node.start, out);
                collect_expr_nested_function_writes(ctx, &node.limit, out);
                if let Some(step) = &node.step {
                    collect_expr_nested_function_writes(ctx, step, out);
                }
                collect_function_body_writes(ctx, &node.block, out);
            }
            Stmt::GenericFor(node) => {
                for expr in &node.exprs {
                    collect_expr_nested_function_writes(ctx, expr, out);
                }
                collect_function_body_writes(ctx, &node.block, out);
            }
            Stmt::Function(node) => collect_function_body_writes(ctx, &node.body.block, out),
            Stmt::LocalFunction(node) => collect_function_body_writes(ctx, &node.body.block, out),
            Stmt::Return(node) => {
                for value in &node.values {
                    collect_expr_nested_function_writes(ctx, value, out);
                }
            }
            _ => {}
        }
    }
}

fn collect_nested_function_writes(ctx: &Ctx<'_>, block: &Block, out: &mut HashSet<String>) {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(node) => {
                for value in &node.values {
                    collect_expr_nested_function_writes(ctx, value, out);
                }
            }
            Stmt::Assign(node) => {
                for target in &node.targets {
                    collect_expr_nested_function_writes(ctx, target, out);
                }
                for value in &node.values {
                    collect_expr_nested_function_writes(ctx, value, out);
                }
            }
            Stmt::Call(expr, _) => collect_expr_nested_function_writes(ctx, expr, out),
            Stmt::Do(node) => collect_nested_function_writes(ctx, &node.block, out),
            Stmt::While(node) => {
                collect_expr_nested_function_writes(ctx, &node.cond, out);
                collect_nested_function_writes(ctx, &node.block, out);
            }
            Stmt::Repeat(node) => {
                collect_nested_function_writes(ctx, &node.block, out);
                collect_expr_nested_function_writes(ctx, &node.cond, out);
            }
            Stmt::If(node) => {
                for (condition, body) in &node.branches {
                    collect_expr_nested_function_writes(ctx, condition, out);
                    collect_nested_function_writes(ctx, body, out);
                }
                if let Some(body) = &node.else_block {
                    collect_nested_function_writes(ctx, body, out);
                }
            }
            Stmt::NumericFor(node) => {
                collect_expr_nested_function_writes(ctx, &node.start, out);
                collect_expr_nested_function_writes(ctx, &node.limit, out);
                if let Some(step) = &node.step {
                    collect_expr_nested_function_writes(ctx, step, out);
                }
                collect_nested_function_writes(ctx, &node.block, out);
            }
            Stmt::GenericFor(node) => {
                for expr in &node.exprs {
                    collect_expr_nested_function_writes(ctx, expr, out);
                }
                collect_nested_function_writes(ctx, &node.block, out);
            }
            Stmt::Function(node) => collect_function_body_writes(ctx, &node.body.block, out),
            Stmt::LocalFunction(node) => collect_function_body_writes(ctx, &node.body.block, out),
            Stmt::Return(node) => {
                for value in &node.values {
                    collect_expr_nested_function_writes(ctx, value, out);
                }
            }
            _ => {}
        }
    }
}

fn nested_function_writes_name(ctx: &Ctx<'_>, block: &Block, name: &str) -> bool {
    let key = block as *const Block as usize;
    if !ctx.nested_writer_cache.borrow().contains_key(&key) {
        let mut names = HashSet::new();
        collect_nested_function_writes(ctx, block, &mut names);
        ctx.nested_writer_cache.borrow_mut().insert(key, names);
    }
    ctx.nested_writer_cache
        .borrow()
        .get(&key)
        .is_some_and(|names| names.contains(name))
}
fn name_is_immediate_stable_lexical(
    ctx: &Ctx<'_>,
    block: &Block,
    before_index: usize,
    name: &str,
    outer_lexical: &HashSet<String>,
) -> bool {
    (outer_lexical.contains(name) || direct_local_declared_before(ctx, block, before_index, name))
        && !nested_function_writes_name(ctx, block, name)
}

fn stable_prefix_expr_with_outer(
    ctx: &Ctx<'_>,
    expr: &Expr,
    block: &Block,
    before_index: usize,
    outer_lexical: &HashSet<String>,
) -> bool {
    match expr {
        Expr::Nil(_) | Expr::True(_) | Expr::False(_) | Expr::Number(_) | Expr::String(_) => true,
        Expr::Name(span) => ctx.text(*span).is_some_and(|name| {
            name_is_immediate_stable_lexical(ctx, block, before_index, name, outer_lexical)
        }),
        _ => false,
    }
}

fn name_is_stable_local(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    before_index: usize,
    name: &str,
) -> bool {
    if !direct_local_declared_before(ctx, block, before_index, name) {
        return false;
    }
    !usage_index.by_name.get(name).is_some_and(|items| {
        items
            .iter()
            .any(|item| matches!(item.kind, OccKind::Write | OccKind::Capture))
    })
}

fn name_is_stable_lexical(
    ctx: &Ctx<'_>,
    block: &Block,
    _usage_index: &UsageIndex,
    before_index: usize,
    name: &str,
    outer_lexical: &HashSet<String>,
) -> bool {
    if !direct_local_declared_before(ctx, block, before_index, name)
        && !outer_lexical.contains(name)
    {
        return false;
    }
    // Packed producer and consumer are adjacent. The only way moving this local
    // read before the producer call can change its value is a nested closure writer
    // reachable during that call. Read-only captures are safe and must not block.
    !nested_function_writes_name(ctx, block, name)
}

fn name_is_stable_between(
    ctx: &Ctx<'_>,
    block: &Block,
    usage_index: &UsageIndex,
    from_index: usize,
    to_index: usize,
    name: &str,
) -> bool {
    if !direct_local_declared_before(ctx, block, from_index, name) {
        return false;
    }
    let Some(from) = ctx.stmt_range(&block.stmts[from_index]) else {
        return false;
    };
    let Some(to) = ctx.stmt_range(&block.stmts[to_index]) else {
        return false;
    };
    !usage_index.by_name.get(name).is_some_and(|items| {
        items.iter().any(|item| {
            item.pos > from.end
                && item.pos < to.start
                && matches!(
                    item.kind,
                    OccKind::Write | OccKind::Redeclare | OccKind::Capture
                )
        })
    })
}

fn plain_table_expr_between(
    ctx: &Ctx<'_>,
    expr: &Expr,
    block: &Block,
    usage_index: &UsageIndex,
    from_index: usize,
    to_index: usize,
) -> bool {
    match expr {
        Expr::Nil(_) | Expr::True(_) | Expr::False(_) | Expr::Number(_) | Expr::String(_) => true,
        Expr::Name(span) => ctx.text(*span).is_some_and(|name| {
            name_is_stable_between(ctx, block, usage_index, from_index, to_index, name)
        }),
        Expr::Table { fields, .. } => fields.iter().all(|field| match field {
            TableField::Positional(value) | TableField::Named { value, .. } => {
                plain_table_expr_between(ctx, value, block, usage_index, from_index, to_index)
            }
            TableField::Computed { key, value } => {
                plain_table_expr_between(ctx, key, block, usage_index, from_index, to_index)
                    && plain_table_expr_between(
                        ctx,
                        value,
                        block,
                        usage_index,
                        from_index,
                        to_index,
                    )
            }
        }),
        _ => false,
    }
}

fn static_number(ctx: &Ctx<'_>, expr: &Expr) -> Option<f64> {
    let Expr::Number(span) = expr else {
        return None;
    };
    ctx.text(*span)?.parse::<f64>().ok()
}

fn unique_unused_return_name(source: &str, mut ordinal: usize) -> String {
    loop {
        let candidate = format!("__beta_unused_return_{ordinal}");
        if !source.contains(&candidate) {
            return candidate;
        }
        ordinal += 1;
    }
}

