use anyhow::{Result, anyhow};
use eclipse_luau::{
    ast::*,
    lexer::{Tok, TokKind},
};
use std::{
    cell::RefCell,
    collections::{BTreeMap, HashMap, HashSet},
    ops::Range,
};

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

fn expr_has_call_base_use(ctx: &Ctx<'_>, expr: &Expr, target: &Range<usize>) -> bool {
    match expr {
        Expr::Function { .. } => false,
        Expr::Call { func, args, .. } => {
            if ctx.range(func.span()).is_some_and(|range| range == *target) {
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

fn plain_table_expr(
    ctx: &Ctx<'_>,
    expr: &Expr,
    block: &Block,
    usage_index: &UsageIndex,
    before_index: usize,
) -> bool {
    match expr {
        Expr::Nil(_) | Expr::True(_) | Expr::False(_) | Expr::Number(_) | Expr::String(_) => true,
        Expr::Name(span) => ctx
            .text(*span)
            .is_some_and(|name| name_is_stable_local(ctx, block, usage_index, before_index, name)),
        Expr::Table { fields, .. } => fields.iter().all(|field| match field {
            TableField::Positional(v) => plain_table_expr(ctx, v, block, usage_index, before_index),
            TableField::Named { value, .. } => {
                plain_table_expr(ctx, value, block, usage_index, before_index)
            }
            TableField::Computed { key, value } => {
                plain_table_expr(ctx, key, block, usage_index, before_index)
                    && plain_table_expr(ctx, value, block, usage_index, before_index)
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
        // Adjacent base alias: local t = math; local f = t["random"].
        if let (Some((producer_binding, producer_init)), Some((_consumer_binding, consumer_init))) =
            (local_single(&block.stmts[i]), local_single(next))
        {
            if let Expr::Name(source_span) = producer_init {
                if let Expr::Index { object, .. } = consumer_init {
                    if let Expr::Name(base_span) = object.as_ref() {
                        let producer_name = ctx.text(producer_binding.name).unwrap_or("");
                        if ctx.text(*base_span) == Some(producer_name) {
                            if let (Some(stmt_range), Some(base_range), Some(source_text)) = (
                                ctx.stmt_range(&block.stmts[i]),
                                ctx.range(*base_span),
                                ctx.text(*source_span),
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
            if matches!(producer_init, Expr::Call { .. } | Expr::Index { .. }) {
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
    // Two-or-more adjacent plain constructor arguments feeding one call.
    for consumer_index in 2..block.stmts.len() {
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
        let mut index = consumer_index;
        while index > 0 {
            index -= 1;
            let Some((binding, init)) = local_single(&block.stmts[index]) else {
                break;
            };
            if !matches!(init, Expr::Table { .. })
                || !plain_table_expr(ctx, init, block, usage_index, index)
            {
                break;
            }
            producers.push((index, binding, init));
        }
        producers.reverse();
        if producers.len() < 2 {
            continue;
        }
        let mut group = Vec::new();
        let mut last_arg = None;
        let mut valid = true;
        for (producer_index, binding, init) in producers {
            let name = ctx.text(binding.name).unwrap_or("");
            let matches: Vec<_> = args
                .iter()
                .enumerate()
                .filter_map(|(arg_i, arg)| {
                    if name_of_expr(ctx, arg) == Some(name) {
                        Some((arg_i, arg))
                    } else {
                        None
                    }
                })
                .collect();
            if matches.len() != 1 || last_arg.is_some_and(|last| matches[0].0 <= last) {
                valid = false;
                break;
            }
            let (arg_i, arg) = matches[0];
            let Some(stmt_range) = ctx.stmt_range(&block.stmts[producer_index]) else {
                valid = false;
                break;
            };
            let usage = usage_index.usage_after(name, stmt_range.end);
            let Some(arg_range) = ctx.range(arg.span()) else {
                valid = false;
                break;
            };
            if usage.reads.len() != 1
                || usage.writes != 0
                || usage.redeclared
                || usage.captured
                || usage.reads[0] != arg_range
            {
                valid = false;
                break;
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
            last_arg = Some(arg_i);
        }
        if valid {
            add_group(ctx, edits, group);
        }
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
) -> bool {
    let Some((func, method, args)) = call_parts(expr) else {
        return false;
    };
    if method.is_some() || name_of_expr(ctx, func) != Some("unpack") {
        return false;
    }
    if direct_local_declared_before(ctx, block, before_index, "unpack") {
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
                    if global_unpack_call_for_name(ctx, last, pack_name, block, before_index)
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

fn function_visible_scope(
    ctx: &Ctx<'_>,
    body: &FunctionBody,
    captured: &HashSet<String>,
) -> HashSet<String> {
    let mut scope = captured.clone();
    for param in &body.params {
        if !param.is_vararg {
            if let Some(name) = ctx.text(param.name) {
                scope.insert(name.to_string());
            }
        }
    }
    scope
}

fn ancestor_release_safe(
    function_usage: &UsageIndex,
    name: &str,
    statement: &Range<usize>,
) -> bool {
    let Some(items) = function_usage.by_name.get(name) else {
        return false;
    };
    let declaration_count = items
        .iter()
        .filter(|item| item.kind == OccKind::Redeclare && item.pos < statement.start)
        .count();
    if declaration_count != 1 {
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

fn collect_block(
    ctx: &Ctx<'_>,
    block: &Block,
    edits: &mut Vec<Edit>,
    function_root: bool,
    env_start: Option<usize>,
    outer_lexical: &HashSet<String>,
    function_usage: &UsageIndex,
    repeated_context: bool,
) {
    collect_block_with_tail(
        ctx,
        block,
        edits,
        function_root,
        env_start,
        outer_lexical,
        function_usage,
        repeated_context,
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
    function_usage: &UsageIndex,
    repeated_context: bool,
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
                function_usage,
                repeated_context,
            ),
            Stmt::While(n) => collect_block(
                ctx,
                &n.block,
                edits,
                false,
                env_start,
                statement_visible,
                function_usage,
                true,
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
                    function_usage,
                    true,
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
                        function_usage,
                        repeated_context,
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
                        function_usage,
                        repeated_context,
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
                function_usage,
                true,
            ),
            Stmt::GenericFor(n) => collect_block(
                ctx,
                &n.block,
                edits,
                false,
                env_start,
                statement_visible,
                function_usage,
                true,
            ),
            Stmt::Function(n) => {
                collect_generated_vararg_recovery(ctx, &n.body, edits);
                let child_env = resolve_env_start(ctx, &n.body.block, env_start.is_some());
                let child_lexical = function_visible_scope(ctx, &n.body, statement_visible);
                let child_usage = build_usage_index(ctx, &n.body.block);
                collect_block(
                    ctx,
                    &n.body.block,
                    edits,
                    true,
                    child_env,
                    &child_lexical,
                    &child_usage,
                    false,
                );
            }
            Stmt::LocalFunction(n) => {
                collect_generated_vararg_recovery(ctx, &n.body, edits);
                let child_env = resolve_env_start(ctx, &n.body.block, env_start.is_some());
                let child_lexical = function_visible_scope(ctx, &n.body, statement_visible);
                let child_usage = build_usage_index(ctx, &n.body.block);
                collect_block(
                    ctx,
                    &n.body.block,
                    edits,
                    true,
                    child_env,
                    &child_lexical,
                    &child_usage,
                    false,
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
                    let safe = if same_block {
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
                        // Prometheus may release a register local declared in an ancestor
                        // block from an if/do child. Never apply this across a loop backedge.
                        !function_root
                            && !repeated_context
                            && ancestor_release_safe(function_usage, name, &stmt_range)
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
                        if let (Some(base), IndexKey::Computed(k)) =
                            (name_of_expr(ctx, object), key)
                        {
                            let base_captured =
                                usage_index.by_name.get(base).is_some_and(|items| {
                                    items.iter().any(|item| item.kind == OccKind::Capture)
                                });
                            if !base_captured {
                                if let Some(method) = simple_string_identifier(ctx, k) {
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
                                            if let Some(new_call) = reconstruct_call_without_first(
                                                ctx, call, base, &method,
                                            ) {
                                                if let Some(call_range) = ctx.range(call.span()) {
                                                    if add_group(
                                                        ctx,
                                                        edits,
                                                        vec![
                                                            Edit {
                                                                start: method_stmt_range.start,
                                                                end: method_stmt_range.end,
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
                                                    ) {
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
                        let call_safe = call_base_use
                            && !is_repeated_evaluation_statement(&block.stmts[consumer_index])
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
                if let Some(call) = call_expr_whole(&block.stmts[index + 1]) {
                    if let Some((func, method, args_node)) = call_parts(call) {
                        if method.is_none() {
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

            // Adjacent leading use safely preserves evaluation order. Parenthesize
            // non-name producers to preserve single-result/local-assignment semantics.
            let adjacent_if_effect_temp = matches!(init, Expr::Call { .. } | Expr::Index { .. })
                && matches!(&block.stmts.get(index + 1), Some(Stmt::If(node)) if node.branches.first().is_some_and(|(cond, _)| {
                    matches!(unwrap_parens(cond), Expr::Binary { .. }) && expr_leading_use(ctx, cond, read)
                }));
            if !matches!(init, Expr::Name(_))
                && (is_scalar_temp_expr(init) || adjacent_if_effect_temp)
                && index + 1 < block.stmts.len()
                && stmt_contains_range(ctx, &block.stmts[index + 1], read)
                && stmt_leading_use(ctx, &block.stmts[index + 1], read)
            {
                if let Some(value) = ctx.expr_text(init) {
                    let mut replacement = if adjacent_if_effect_temp
                        || matches!(init, Expr::Name(_) | Expr::Index { .. })
                    {
                        value.to_string()
                    } else {
                        format!("({value})")
                    };
                    if matches!(&block.stmts[index + 1], Stmt::Call(_, _))
                        && ctx
                            .stmt_range(&block.stmts[index + 1])
                            .is_some_and(|next| next.start == read.start)
                        && replacement.starts_with('(')
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
                    add_edit(
                        ctx,
                        edits,
                        Edit {
                            start: stmt_range.start,
                            end: stmt_range.end,
                            replacement: call.to_string(),
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
            let child_usage = build_usage_index(ctx, &body.block);
            collect_block(
                ctx,
                &body.block,
                edits,
                true,
                child_env,
                &child_lexical,
                &child_usage,
                false,
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
        let root_env = resolve_env_start(&ctx, &parsed.chunk.block, false);
        let root_lexical = HashSet::new();
        let root_usage = build_usage_index(&ctx, &parsed.chunk.block);
        collect_block(
            &ctx,
            &parsed.chunk.block,
            &mut edits,
            true,
            root_env,
            &root_lexical,
            &root_usage,
            false,
        );
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
