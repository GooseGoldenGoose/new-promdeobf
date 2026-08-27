use eclipse_luau::{ast::*, lexer::Tok};
use std::{
    collections::{HashMap, HashSet},
    ops::Range,
};

#[derive(Debug, Clone)]
pub(crate) struct DecodedEdit {
    pub start: usize,
    pub end: usize,
    pub replacement: String,
    pub counts_decode: bool,
}
#[derive(Debug, Clone)]
struct DecodeUse {
    range: Range<usize>,
    proxy: String,
    decoder: String,
    cipher: Vec<u8>,
    key: u64,
}
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct DecoderParams {
    state_mul: u64,
    state_add: u64,
    state_mod: u64,
    cursor_mul: u64,
    cursor_mod: u64,
    key_cursor_mod: u64,
    key_cursor_add: u64,
    rolling_seed: u64,
    exponent_bias: u64,
}
#[derive(Debug, Clone)]
struct DecoderProof {
    params: DecoderParams,
    private_names: Vec<String>,
    allowed_ranges: Vec<Range<usize>>,
    scope_range: Range<usize>,
}
#[derive(Debug, Clone, PartialEq, Eq)]
struct GeneratorProof {
    state: (u64, u64, u64),
    cursor: (u64, u64),
    bias: u64,
    generator: String,
    buffer: String,
    generator_range: Range<usize>,
    chars: String,
    char_ranges: Vec<Range<usize>>,
}
struct Ctx<'a> {
    src: &'a str,
    toks: &'a [Tok],
}
impl<'a> Ctx<'a> {
    fn range(&self, s: TokSpan) -> Option<Range<usize>> {
        if s.start >= s.end {
            return None;
        }
        let a = self.toks.get(s.start as usize)?;
        let b = self.toks.get(s.end as usize - 1)?;
        Some(a.start as usize..b.end as usize)
    }
    fn text(&self, s: TokSpan) -> Option<&'a str> {
        self.src.get(self.range(s)?)
    }
}
fn unwrap(e: &Expr) -> &Expr {
    match e {
        Expr::Paren { inner, .. } | Expr::TypeAssert { expr: inner, .. } => unwrap(inner),
        _ => e,
    }
}
fn name<'a>(c: &'a Ctx<'_>, e: &Expr) -> Option<&'a str> {
    match unwrap(e) {
        Expr::Name(s) => c.text(*s),
        _ => None,
    }
}
fn num(c: &Ctx<'_>, e: &Expr) -> Option<u64> {
    let Expr::Number(s) = unwrap(e) else {
        return None;
    };
    let t = c.text(*s)?.replace('_', "");
    if let Some(h) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
        u64::from_str_radix(h, 16).ok()
    } else {
        t.parse().ok()
    }
}
fn bin<'a>(c: &Ctx<'_>, e: &'a Expr, op: &str) -> Option<(&'a Expr, &'a Expr)> {
    let Expr::Binary {
        op: o, lhs, rhs, ..
    } = unwrap(e)
    else {
        return None;
    };
    (c.text(*o) == Some(op)).then_some((lhs, rhs))
}
fn call(e: &Expr) -> Option<(&Expr, Option<TokSpan>, &CallArgs)> {
    match unwrap(e) {
        Expr::Call {
            func, method, args, ..
        } => Some((func, *method, args)),
        _ => None,
    }
}
fn args(a: &CallArgs) -> Option<&[Expr]> {
    match a {
        CallArgs::Paren(v) => Some(v),
        _ => None,
    }
}

fn lua_bytes(t: &str) -> Option<Vec<u8>> {
    let b = t.as_bytes();
    if b.len() < 2 || !matches!(b[0], b'\'' | b'"') || b[b.len() - 1] != b[0] {
        return None;
    }
    let x = &t[1..t.len() - 1];
    let r = x.as_bytes();
    let mut o = Vec::new();
    let mut i = 0;
    while i < r.len() {
        if r[i] != b'\\' {
            let ch = x[i..].chars().next()?;
            let mut z = [0; 4];
            o.extend_from_slice(ch.encode_utf8(&mut z).as_bytes());
            i += ch.len_utf8();
            continue;
        }
        i += 1;
        if i >= r.len() {
            return None;
        }
        match r[i] {
            b'a' => {
                o.push(7);
                i += 1
            }
            b'b' => {
                o.push(8);
                i += 1
            }
            b'f' => {
                o.push(12);
                i += 1
            }
            b'n' => {
                o.push(10);
                i += 1
            }
            b'r' => {
                o.push(13);
                i += 1
            }
            b't' => {
                o.push(9);
                i += 1
            }
            b'v' => {
                o.push(11);
                i += 1
            }
            b'\\' => {
                o.push(92);
                i += 1
            }
            b'"' => {
                o.push(34);
                i += 1
            }
            b'\'' => {
                o.push(39);
                i += 1
            }
            b'z' => {
                i += 1;
                while i < r.len() && r[i].is_ascii_whitespace() {
                    i += 1
                }
            }
            b'x' if i + 2 < r.len() => {
                let h = std::str::from_utf8(&r[i + 1..i + 3]).ok()?;
                o.push(u8::from_str_radix(h, 16).ok()?);
                i += 3
            }
            b'0'..=b'9' => {
                let s = i;
                let mut e = i;
                while e < r.len() && e < s + 3 && r[e].is_ascii_digit() {
                    e += 1
                }
                let v = std::str::from_utf8(&r[s..e]).ok()?.parse::<u16>().ok()?;
                if v > 255 {
                    return None;
                }
                o.push(v as u8);
                i = e
            }
            _ => {
                let ch = x[i..].chars().next()?;
                let mut z = [0; 4];
                o.extend_from_slice(ch.encode_utf8(&mut z).as_bytes());
                i += ch.len_utf8()
            }
        }
    }
    Some(o)
}
fn quote(d: &[u8]) -> String {
    if let Ok(t) = std::str::from_utf8(d) {
        let mut o = String::from("\"");
        for ch in t.chars() {
            match ch {
                '\\' => o.push_str("\\\\"),
                '"' => o.push_str("\\\""),
                '\n' => o.push_str("\\n"),
                '\r' => o.push_str("\\r"),
                '\t' => o.push_str("\\t"),
                c if c.is_control() => {
                    let mut z = [0; 4];
                    for b in c.encode_utf8(&mut z).as_bytes() {
                        o.push_str(&format!("\\{b:03}"))
                    }
                }
                c => o.push(c),
            }
        }
        o.push('"');
        return o;
    }
    let mut o = String::from("\"");
    for &b in d {
        if (32..=126).contains(&b) && !matches!(b, b'"' | b'\\') {
            o.push(b as char)
        } else {
            o.push_str(&format!("\\{b:03}"))
        }
    }
    o.push('"');
    o
}

fn match_use(c: &Ctx<'_>, e: &Expr) -> Option<DecodeUse> {
    let Expr::Index {
        object,
        key: IndexKey::Computed(k),
        span,
    } = unwrap(e)
    else {
        return None;
    };
    let p = name(c, object)?.to_string();
    let (f, m, a) = call(k)?;
    if m.is_some() {
        return None;
    }
    let d = name(c, f)?.to_string();
    let a = args(a)?;
    if a.len() != 2 {
        return None;
    }
    let Expr::String(s) = unwrap(&a[0]) else {
        return None;
    };
    Some(DecodeUse {
        range: c.range(*span)?,
        proxy: p,
        decoder: d,
        cipher: lua_bytes(c.text(*s)?)?,
        key: num(c, &a[1])?,
    })
}

fn literal_decoder_call_name(c: &Ctx<'_>, e: &Expr) -> Option<String> {
    let (func, method, call_args) = call(e)?;
    if method.is_some() {
        return None;
    }
    let decoder = name(c, func)?.to_string();
    let call_args = args(call_args)?;
    if call_args.len() != 2
        || !matches!(unwrap(&call_args[0]), Expr::String(_))
        || num(c, &call_args[1]).is_none()
    {
        return None;
    }
    Some(decoder)
}

fn seed_pair_expr(
    c: &Ctx<'_>,
    e: &Expr,
    temp_decoders: &HashMap<String, HashSet<String>>,
    pairs: &mut HashSet<(String, String)>,
) {
    if let Some(use_site) = match_use(c, e) {
        pairs.insert((use_site.proxy, use_site.decoder));
        return;
    }
    if let Expr::Index {
        object,
        key: IndexKey::Computed(key),
        ..
    } = unwrap(e)
    {
        if let (Some(proxy), Some(temp)) = (name(c, object), name(c, key)) {
            if let Some(decoders) = temp_decoders.get(temp) {
                for decoder in decoders {
                    pairs.insert((proxy.to_string(), decoder.clone()));
                }
            }
        }
    }
    match e {
        Expr::Function { body, .. } => seed_pairs_block(c, &body.block, temp_decoders, pairs),
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(value) | TableField::Named { value, .. } => {
                        seed_pair_expr(c, value, temp_decoders, pairs)
                    }
                    TableField::Computed { key, value } => {
                        seed_pair_expr(c, key, temp_decoders, pairs);
                        seed_pair_expr(c, value, temp_decoders, pairs);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            seed_pair_expr(c, lhs, temp_decoders, pairs);
            seed_pair_expr(c, rhs, temp_decoders, pairs);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            seed_pair_expr(c, operand, temp_decoders, pairs)
        }
        Expr::Index { object, key, .. } => {
            seed_pair_expr(c, object, temp_decoders, pairs);
            if let IndexKey::Computed(key) = key {
                seed_pair_expr(c, key, temp_decoders, pairs);
            }
        }
        Expr::Call { func, args, .. } => {
            seed_pair_expr(c, func, temp_decoders, pairs);
            match args {
                CallArgs::Paren(values) => {
                    for value in values {
                        seed_pair_expr(c, value, temp_decoders, pairs);
                    }
                }
                CallArgs::Table(value) => seed_pair_expr(c, value, temp_decoders, pairs),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (cond, value) in branches {
                seed_pair_expr(c, cond, temp_decoders, pairs);
                seed_pair_expr(c, value, temp_decoders, pairs);
            }
            seed_pair_expr(c, else_value, temp_decoders, pairs);
        }
        _ => {}
    }
}

fn seed_pairs_block(
    c: &Ctx<'_>,
    block: &Block,
    temp_decoders: &HashMap<String, HashSet<String>>,
    pairs: &mut HashSet<(String, String)>,
) {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(node) => {
                for value in &node.values {
                    seed_pair_expr(c, value, temp_decoders, pairs);
                }
            }
            Stmt::Assign(node) => {
                for target in &node.targets {
                    seed_pair_expr(c, target, temp_decoders, pairs);
                }
                for value in &node.values {
                    seed_pair_expr(c, value, temp_decoders, pairs);
                }
            }
            Stmt::Call(expr, _) => seed_pair_expr(c, expr, temp_decoders, pairs),
            Stmt::Do(node) => seed_pairs_block(c, &node.block, temp_decoders, pairs),
            Stmt::While(node) => {
                seed_pair_expr(c, &node.cond, temp_decoders, pairs);
                seed_pairs_block(c, &node.block, temp_decoders, pairs);
            }
            Stmt::Repeat(node) => {
                seed_pairs_block(c, &node.block, temp_decoders, pairs);
                seed_pair_expr(c, &node.cond, temp_decoders, pairs);
            }
            Stmt::If(node) => {
                for (cond, block) in &node.branches {
                    seed_pair_expr(c, cond, temp_decoders, pairs);
                    seed_pairs_block(c, block, temp_decoders, pairs);
                }
                if let Some(block) = &node.else_block {
                    seed_pairs_block(c, block, temp_decoders, pairs);
                }
            }
            Stmt::NumericFor(node) => {
                seed_pair_expr(c, &node.start, temp_decoders, pairs);
                seed_pair_expr(c, &node.limit, temp_decoders, pairs);
                if let Some(step) = &node.step {
                    seed_pair_expr(c, step, temp_decoders, pairs);
                }
                seed_pairs_block(c, &node.block, temp_decoders, pairs);
            }
            Stmt::GenericFor(node) => {
                for expr in &node.exprs {
                    seed_pair_expr(c, expr, temp_decoders, pairs);
                }
                seed_pairs_block(c, &node.block, temp_decoders, pairs);
            }
            Stmt::Function(node) => seed_pairs_block(c, &node.body.block, temp_decoders, pairs),
            Stmt::LocalFunction(node) => {
                seed_pairs_block(c, &node.body.block, temp_decoders, pairs)
            }
            Stmt::Return(node) => {
                for value in &node.values {
                    seed_pair_expr(c, value, temp_decoders, pairs);
                }
            }
            _ => {}
        }
    }
}

fn alias_candidates(name: &str, aliases: &HashMap<String, HashSet<String>>) -> HashSet<String> {
    let mut out = HashSet::from([name.to_string()]);
    let mut stack = vec![name.to_string()];
    while let Some(current) = stack.pop() {
        if let Some(sources) = aliases.get(&current) {
            for source in sources {
                if out.insert(source.clone()) {
                    stack.push(source.clone());
                }
            }
        }
    }
    out
}

fn decoder_seed_pairs(c: &Ctx<'_>, root: &Block) -> HashSet<(String, String)> {
    let mut statements = Vec::new();
    collect_layer_stmt_refs(root, &mut statements);
    let mut aliases = HashMap::<String, HashSet<String>>::new();
    let mut temp_decoders = HashMap::<String, HashSet<String>>::new();
    for stmt in &statements {
        match stmt {
            Stmt::Local(node) if node.names.len() == 1 && node.values.len() == 1 => {
                let Some(target) = c.text(node.names[0].name) else {
                    continue;
                };
                if let Some(source) = name(c, &node.values[0]) {
                    aliases
                        .entry(target.to_string())
                        .or_default()
                        .insert(source.to_string());
                }
                if let Some(decoder) = literal_decoder_call_name(c, &node.values[0]) {
                    temp_decoders
                        .entry(target.to_string())
                        .or_default()
                        .insert(decoder);
                }
            }
            Stmt::Assign(node) if node.targets.len() == 1 && node.values.len() == 1 => {
                if let (Some(target), Some(source)) =
                    (name(c, &node.targets[0]), name(c, &node.values[0]))
                {
                    // Candidate discovery may be broad; the layer proof later requires
                    // assignment aliases to target an already-declared lexical local.
                    aliases
                        .entry(target.to_string())
                        .or_default()
                        .insert(source.to_string());
                }
            }
            _ => {}
        }
    }
    let mut raw = HashSet::new();
    seed_pairs_block(c, root, &temp_decoders, &mut raw);
    let mut expanded = HashSet::new();
    for (proxy, decoder) in raw {
        for proxy_candidate in alias_candidates(&proxy, &aliases) {
            for decoder_candidate in alias_candidates(&decoder, &aliases) {
                expanded.insert((proxy_candidate.clone(), decoder_candidate));
            }
        }
    }
    expanded
}

#[derive(Debug, Default)]
struct LayerUses {
    uses: Vec<DecodeUse>,
    allowed_ranges: Vec<Range<usize>>,
    alias_names: Vec<String>,
    cleanup_edits: Vec<(Range<usize>, String)>,
}

fn collect_layer_expr_stmt_refs<'a>(expr: &'a Expr, out: &mut Vec<&'a Stmt>) {
    match expr {
        Expr::Function { body, .. } => collect_layer_stmt_refs(&body.block, out),
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(value) | TableField::Named { value, .. } => {
                        collect_layer_expr_stmt_refs(value, out)
                    }
                    TableField::Computed { key, value } => {
                        collect_layer_expr_stmt_refs(key, out);
                        collect_layer_expr_stmt_refs(value, out);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_layer_expr_stmt_refs(lhs, out);
            collect_layer_expr_stmt_refs(rhs, out);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => collect_layer_expr_stmt_refs(operand, out),
        Expr::Index { object, key, .. } => {
            collect_layer_expr_stmt_refs(object, out);
            if let IndexKey::Computed(key) = key {
                collect_layer_expr_stmt_refs(key, out);
            }
        }
        Expr::Call { func, args, .. } => {
            collect_layer_expr_stmt_refs(func, out);
            match args {
                CallArgs::Paren(values) => {
                    for value in values {
                        collect_layer_expr_stmt_refs(value, out);
                    }
                }
                CallArgs::Table(value) => collect_layer_expr_stmt_refs(value, out),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (cond, value) in branches {
                collect_layer_expr_stmt_refs(cond, out);
                collect_layer_expr_stmt_refs(value, out);
            }
            collect_layer_expr_stmt_refs(else_value, out);
        }
        _ => {}
    }
}

fn collect_layer_stmt_refs<'a>(block: &'a Block, out: &mut Vec<&'a Stmt>) {
    for stmt in &block.stmts {
        out.push(stmt);
        match stmt {
            Stmt::Local(node) => {
                for value in &node.values {
                    collect_layer_expr_stmt_refs(value, out);
                }
            }
            Stmt::Assign(node) => {
                for target in &node.targets {
                    collect_layer_expr_stmt_refs(target, out);
                }
                for value in &node.values {
                    collect_layer_expr_stmt_refs(value, out);
                }
            }
            Stmt::Call(expr, _) => collect_layer_expr_stmt_refs(expr, out),
            Stmt::Do(node) => collect_layer_stmt_refs(&node.block, out),
            Stmt::While(node) => {
                collect_layer_expr_stmt_refs(&node.cond, out);
                collect_layer_stmt_refs(&node.block, out);
            }
            Stmt::Repeat(node) => {
                collect_layer_stmt_refs(&node.block, out);
                collect_layer_expr_stmt_refs(&node.cond, out);
            }
            Stmt::If(node) => {
                for (cond, block) in &node.branches {
                    collect_layer_expr_stmt_refs(cond, out);
                    collect_layer_stmt_refs(block, out);
                }
                if let Some(block) = &node.else_block {
                    collect_layer_stmt_refs(block, out);
                }
            }
            Stmt::NumericFor(node) => {
                collect_layer_expr_stmt_refs(&node.start, out);
                collect_layer_expr_stmt_refs(&node.limit, out);
                if let Some(step) = &node.step {
                    collect_layer_expr_stmt_refs(step, out);
                }
                collect_layer_stmt_refs(&node.block, out);
            }
            Stmt::GenericFor(node) => {
                for expr in &node.exprs {
                    collect_layer_expr_stmt_refs(expr, out);
                }
                collect_layer_stmt_refs(&node.block, out);
            }
            Stmt::Function(node) => collect_layer_stmt_refs(&node.body.block, out),
            Stmt::LocalFunction(node) => collect_layer_stmt_refs(&node.body.block, out),
            Stmt::Return(node) => {
                for value in &node.values {
                    collect_layer_expr_stmt_refs(value, out);
                }
            }
            _ => {}
        }
    }
}

fn literal_decode_call(
    c: &Ctx<'_>,
    expr: &Expr,
    decoder_aliases: &HashSet<String>,
) -> Option<(String, Vec<u8>, u64)> {
    let (func, method, call_args) = call(expr)?;
    if method.is_some() {
        return None;
    }
    let decoder = name(c, func)?.to_string();
    if !decoder_aliases.contains(&decoder) {
        return None;
    }
    let call_args = args(call_args)?;
    if call_args.len() != 2 {
        return None;
    }
    let Expr::String(cipher) = unwrap(&call_args[0]) else {
        return None;
    };
    Some((
        decoder,
        lua_bytes(c.text(*cipher)?)?,
        num(c, &call_args[1])?,
    ))
}

fn collect_layer_expr_uses(
    c: &Ctx<'_>,
    expr: &Expr,
    proxy_aliases: &HashSet<String>,
    decoder_aliases: &HashSet<String>,
    temps: &HashSet<String>,
    direct: &mut Vec<DecodeUse>,
    temp_consumers: &mut HashMap<String, Vec<(Range<usize>, String)>>,
) {
    if let Expr::Index {
        object,
        key: IndexKey::Computed(key),
        span,
    } = unwrap(expr)
    {
        if let Some(proxy) = name(c, object) {
            if proxy_aliases.contains(proxy) {
                if let Some((decoder, cipher, key_value)) =
                    literal_decode_call(c, key, decoder_aliases)
                {
                    if let Some(range) = c.range(*span) {
                        direct.push(DecodeUse {
                            range,
                            proxy: proxy.to_string(),
                            decoder,
                            cipher,
                            key: key_value,
                        });
                        return;
                    }
                }
                if let Some(temp) = name(c, key) {
                    if temps.contains(temp) {
                        if let Some(range) = c.range(*span) {
                            temp_consumers
                                .entry(temp.to_string())
                                .or_default()
                                .push((range, proxy.to_string()));
                            return;
                        }
                    }
                }
            }
        }
    }
    match expr {
        Expr::Function { body, .. } => collect_layer_block_uses(
            c,
            &body.block,
            proxy_aliases,
            decoder_aliases,
            temps,
            direct,
            temp_consumers,
        ),
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(value) | TableField::Named { value, .. } => {
                        collect_layer_expr_uses(
                            c,
                            value,
                            proxy_aliases,
                            decoder_aliases,
                            temps,
                            direct,
                            temp_consumers,
                        );
                    }
                    TableField::Computed { key, value } => {
                        collect_layer_expr_uses(
                            c,
                            key,
                            proxy_aliases,
                            decoder_aliases,
                            temps,
                            direct,
                            temp_consumers,
                        );
                        collect_layer_expr_uses(
                            c,
                            value,
                            proxy_aliases,
                            decoder_aliases,
                            temps,
                            direct,
                            temp_consumers,
                        );
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_layer_expr_uses(
                c,
                lhs,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            );
            collect_layer_expr_uses(
                c,
                rhs,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            );
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => collect_layer_expr_uses(
            c,
            operand,
            proxy_aliases,
            decoder_aliases,
            temps,
            direct,
            temp_consumers,
        ),
        Expr::Index { object, key, .. } => {
            collect_layer_expr_uses(
                c,
                object,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            );
            if let IndexKey::Computed(key) = key {
                collect_layer_expr_uses(
                    c,
                    key,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
            }
        }
        Expr::Call { func, args, .. } => {
            collect_layer_expr_uses(
                c,
                func,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            );
            match args {
                CallArgs::Paren(values) => {
                    for value in values {
                        collect_layer_expr_uses(
                            c,
                            value,
                            proxy_aliases,
                            decoder_aliases,
                            temps,
                            direct,
                            temp_consumers,
                        );
                    }
                }
                CallArgs::Table(value) => collect_layer_expr_uses(
                    c,
                    value,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                ),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (cond, value) in branches {
                collect_layer_expr_uses(
                    c,
                    cond,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
                collect_layer_expr_uses(
                    c,
                    value,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
            }
            collect_layer_expr_uses(
                c,
                else_value,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            );
        }
        _ => {}
    }
}

fn collect_layer_block_uses(
    c: &Ctx<'_>,
    block: &Block,
    proxy_aliases: &HashSet<String>,
    decoder_aliases: &HashSet<String>,
    temps: &HashSet<String>,
    direct: &mut Vec<DecodeUse>,
    temp_consumers: &mut HashMap<String, Vec<(Range<usize>, String)>>,
) {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(node) => {
                for value in &node.values {
                    collect_layer_expr_uses(
                        c,
                        value,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
            }
            Stmt::Assign(node) => {
                for target in &node.targets {
                    collect_layer_expr_uses(
                        c,
                        target,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
                for value in &node.values {
                    collect_layer_expr_uses(
                        c,
                        value,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
            }
            Stmt::Call(expr, _) => collect_layer_expr_uses(
                c,
                expr,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            ),
            Stmt::Do(node) => collect_layer_block_uses(
                c,
                &node.block,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            ),
            Stmt::While(node) => {
                collect_layer_expr_uses(
                    c,
                    &node.cond,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
                collect_layer_block_uses(
                    c,
                    &node.block,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
            }
            Stmt::Repeat(node) => {
                collect_layer_block_uses(
                    c,
                    &node.block,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
                collect_layer_expr_uses(
                    c,
                    &node.cond,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
            }
            Stmt::If(node) => {
                for (cond, block) in &node.branches {
                    collect_layer_expr_uses(
                        c,
                        cond,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                    collect_layer_block_uses(
                        c,
                        block,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
                if let Some(block) = &node.else_block {
                    collect_layer_block_uses(
                        c,
                        block,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
            }
            Stmt::NumericFor(node) => {
                collect_layer_expr_uses(
                    c,
                    &node.start,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
                collect_layer_expr_uses(
                    c,
                    &node.limit,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
                if let Some(step) = &node.step {
                    collect_layer_expr_uses(
                        c,
                        step,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
                collect_layer_block_uses(
                    c,
                    &node.block,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
            }
            Stmt::GenericFor(node) => {
                for expr in &node.exprs {
                    collect_layer_expr_uses(
                        c,
                        expr,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
                collect_layer_block_uses(
                    c,
                    &node.block,
                    proxy_aliases,
                    decoder_aliases,
                    temps,
                    direct,
                    temp_consumers,
                );
            }
            Stmt::Function(node) => collect_layer_block_uses(
                c,
                &node.body.block,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            ),
            Stmt::LocalFunction(node) => collect_layer_block_uses(
                c,
                &node.body.block,
                proxy_aliases,
                decoder_aliases,
                temps,
                direct,
                temp_consumers,
            ),
            Stmt::Return(node) => {
                for value in &node.values {
                    collect_layer_expr_uses(
                        c,
                        value,
                        proxy_aliases,
                        decoder_aliases,
                        temps,
                        direct,
                        temp_consumers,
                    );
                }
            }
            _ => {}
        }
    }
}

#[derive(Debug, Clone)]
struct AliasWindow {
    declaration: Range<usize>,
    valid_before: usize,
    scan_end: usize,
    write_tokens: Vec<Range<usize>>,
}

fn alias_window(
    c: &Ctx<'_>,
    statements: &[&Stmt],
    declaration: Range<usize>,
    alias: &str,
    scope: &Range<usize>,
) -> AliasWindow {
    let mut best: Option<(usize, usize, Vec<Range<usize>>)> = None;
    for stmt in statements {
        let Some(stmt_range) = c.range(stmt.span()) else {
            continue;
        };
        if stmt_range.start <= declaration.start {
            continue;
        }
        let mut write_tokens = Vec::new();
        match stmt {
            Stmt::Assign(node) => {
                for target in &node.targets {
                    if name(c, target) == Some(alias) {
                        if let Some(range) = c.range(target.span()) {
                            write_tokens.push(range);
                        }
                    }
                }
            }
            Stmt::Local(node) => {
                for binding in &node.names {
                    if c.text(binding.name) == Some(alias) {
                        if let Some(range) = c.range(binding.name) {
                            write_tokens.push(range);
                        }
                    }
                }
            }
            _ => {}
        }
        if write_tokens.is_empty() {
            continue;
        }
        let candidate = (stmt_range.start, stmt_range.end, write_tokens);
        if best.as_ref().is_none_or(|old| candidate.0 < old.0) {
            best = Some(candidate);
        }
    }
    if let Some((_write_start, scan_end, write_tokens)) = best {
        AliasWindow {
            declaration,
            valid_before: scan_end,
            scan_end,
            write_tokens,
        }
    } else {
        AliasWindow {
            declaration,
            valid_before: scope.end,
            scan_end: scope.end,
            write_tokens: Vec::new(),
        }
    }
}

fn alias_active_at(
    candidate: &str,
    position: usize,
    canonical: &str,
    windows: &HashMap<String, AliasWindow>,
) -> bool {
    candidate == canonical
        || windows.get(candidate).is_some_and(|window| {
            position > window.declaration.end && position < window.valid_before
        })
}

fn alias_occurrences_safe(
    c: &Ctx<'_>,
    alias: &str,
    window: &AliasWindow,
    recognized: &[Range<usize>],
) -> bool {
    c.toks
        .iter()
        .filter(|tok| {
            let start = tok.start as usize;
            let end = tok.end as usize;
            start >= window.declaration.start && end <= window.scan_end && tok.text(c.src) == alias
        })
        .all(|tok| {
            let start = tok.start as usize;
            let end = tok.end as usize;
            recognized
                .iter()
                .chain(window.write_tokens.iter())
                .any(|range| start >= range.start && end <= range.end)
        })
}

fn temp_shadow_ranges(
    c: &Ctx<'_>,
    statements: &[&Stmt],
    target: &str,
    declaration: &Range<usize>,
) -> Vec<Range<usize>> {
    let mut out = Vec::new();
    for stmt in statements {
        let Some(stmt_range) = c.range(stmt.span()) else {
            continue;
        };
        if stmt_range.start <= declaration.start {
            continue;
        }
        match stmt {
            Stmt::NumericFor(node) if c.text(node.var.name) == Some(target) => {
                if let Some(range) = c.range(node.var.name) {
                    out.push(range);
                }
                if let Some(range) = c.range(node.block.span) {
                    out.push(range);
                }
            }
            Stmt::GenericFor(node)
                if node
                    .vars
                    .iter()
                    .any(|binding| c.text(binding.name) == Some(target)) =>
            {
                for binding in &node.vars {
                    if c.text(binding.name) == Some(target) {
                        if let Some(range) = c.range(binding.name) {
                            out.push(range);
                        }
                    }
                }
                if let Some(range) = c.range(node.block.span) {
                    out.push(range);
                }
            }
            Stmt::Function(node)
                if node
                    .body
                    .params
                    .iter()
                    .any(|param| !param.is_vararg && c.text(param.name) == Some(target)) =>
            {
                for param in &node.body.params {
                    if !param.is_vararg && c.text(param.name) == Some(target) {
                        if let Some(range) = c.range(param.name) {
                            out.push(range);
                        }
                    }
                }
                if let Some(range) = c.range(node.body.block.span) {
                    out.push(range);
                }
            }
            Stmt::LocalFunction(node)
                if node
                    .body
                    .params
                    .iter()
                    .any(|param| !param.is_vararg && c.text(param.name) == Some(target)) =>
            {
                for param in &node.body.params {
                    if !param.is_vararg && c.text(param.name) == Some(target) {
                        if let Some(range) = c.range(param.name) {
                            out.push(range);
                        }
                    }
                }
                if let Some(range) = c.range(node.body.block.span) {
                    out.push(range);
                }
            }
            _ => {}
        }
    }
    out.sort_by_key(|range| (range.start, range.end));
    out.dedup();
    out
}

fn temp_binding_occurrences_safe(
    c: &Ctx<'_>,
    scope: &Range<usize>,
    target: &str,
    declaration: &Range<usize>,
    consumers: &[Range<usize>],
    shadow_ranges: &[Range<usize>],
) -> bool {
    let mut allowed = Vec::with_capacity(consumers.len() + shadow_ranges.len() + 1);
    allowed.push(declaration.clone());
    allowed.extend(consumers.iter().cloned());
    allowed.extend(shadow_ranges.iter().cloned());
    c.toks
        .iter()
        .filter(|tok| {
            let start = tok.start as usize;
            let end = tok.end as usize;
            start >= scope.start && end <= scope.end && tok.text(c.src) == target
        })
        .all(|tok| {
            let start = tok.start as usize;
            let end = tok.end as usize;
            allowed
                .iter()
                .any(|range| start >= range.start && end <= range.end)
        })
}

fn direct_local_declared_before_stmt(
    c: &Ctx<'_>,
    block: &Block,
    target: &Range<usize>,
    name: &str,
) -> bool {
    for (index, stmt) in block.stmts.iter().enumerate() {
        let Some(range) = c.range(stmt.span()) else {
            continue;
        };
        if range == *target {
            return block.stmts[..index].iter().any(|prior| match prior {
                Stmt::Local(node) => node
                    .names
                    .iter()
                    .any(|binding| c.text(binding.name) == Some(name)),
                _ => false,
            });
        }
        if target.start < range.start || target.end > range.end {
            continue;
        }
        let found = match stmt {
            Stmt::Do(node) => direct_local_declared_before_stmt(c, &node.block, target, name),
            Stmt::While(node) => direct_local_declared_before_stmt(c, &node.block, target, name),
            Stmt::Repeat(node) => direct_local_declared_before_stmt(c, &node.block, target, name),
            Stmt::If(node) => {
                node.branches
                    .iter()
                    .any(|(_, child)| direct_local_declared_before_stmt(c, child, target, name))
                    || node.else_block.as_ref().is_some_and(|child| {
                        direct_local_declared_before_stmt(c, child, target, name)
                    })
            }
            Stmt::NumericFor(node) => {
                direct_local_declared_before_stmt(c, &node.block, target, name)
            }
            Stmt::GenericFor(node) => {
                direct_local_declared_before_stmt(c, &node.block, target, name)
            }
            Stmt::Function(node) => {
                direct_local_declared_before_stmt(c, &node.body.block, target, name)
            }
            Stmt::LocalFunction(node) => {
                direct_local_declared_before_stmt(c, &node.body.block, target, name)
            }
            _ => false,
        };
        if found {
            return true;
        }
    }
    false
}

fn collect_layer_uses(
    c: &Ctx<'_>,
    root: &Block,
    canonical_proxy: &str,
    canonical_decoder: &str,
    scope: &Range<usize>,
) -> Option<LayerUses> {
    let mut statements = Vec::new();
    collect_layer_stmt_refs(root, &mut statements);
    statements.retain(|stmt| {
        c.range(stmt.span())
            .is_some_and(|range| range.start >= scope.start && range.end <= scope.end)
    });

    let mut proxy_aliases = HashSet::from([canonical_proxy.to_string()]);
    let mut decoder_aliases = HashSet::from([canonical_decoder.to_string()]);
    let mut alias_ranges = HashMap::<String, Range<usize>>::new();
    loop {
        let before = proxy_aliases.len() + decoder_aliases.len();
        for stmt in &statements {
            let (alias, source, range) = match stmt {
                Stmt::Local(node) if node.names.len() == 1 && node.values.len() == 1 => {
                    let (Some(alias), Some(source), Some(range)) = (
                        c.text(node.names[0].name),
                        name(c, &node.values[0]),
                        c.range(node.span),
                    ) else {
                        continue;
                    };
                    (alias, source, range)
                }
                Stmt::Assign(node) if node.targets.len() == 1 && node.values.len() == 1 => {
                    let (Some(alias), Some(source), Some(range)) = (
                        name(c, &node.targets[0]),
                        name(c, &node.values[0]),
                        c.range(node.span),
                    ) else {
                        continue;
                    };
                    if !direct_local_declared_before_stmt(c, root, &range, alias) {
                        continue;
                    }
                    (alias, source, range)
                }
                _ => continue,
            };
            let target_set = if proxy_aliases.contains(source) {
                Some(&mut proxy_aliases)
            } else if decoder_aliases.contains(source) {
                Some(&mut decoder_aliases)
            } else {
                None
            };
            let Some(target_set) = target_set else {
                continue;
            };
            if alias == canonical_proxy || alias == canonical_decoder {
                continue;
            }
            if target_set.insert(alias.to_string()) {
                alias_ranges.insert(alias.to_string(), range);
            } else if let Some(existing) = alias_ranges.get(alias) {
                if *existing != range {
                    return None;
                }
            }
        }
        if proxy_aliases.len() + decoder_aliases.len() == before {
            break;
        }
    }

    let alias_windows: HashMap<String, AliasWindow> = alias_ranges
        .iter()
        .map(|(alias, range)| {
            (
                alias.clone(),
                alias_window(c, &statements, range.clone(), alias, scope),
            )
        })
        .collect();

    let mut temps = HashMap::<String, (Vec<u8>, u64, Range<usize>, Range<usize>)>::new();
    for stmt in &statements {
        let Stmt::Local(node) = stmt else { continue };
        if node.names.len() != 1 || node.values.len() != 1 {
            continue;
        }
        let Some(temp) = c.text(node.names[0].name) else {
            continue;
        };
        let Some((decoder_name, cipher, key)) =
            literal_decode_call(c, &node.values[0], &decoder_aliases)
        else {
            continue;
        };
        let declaration_range = c.range(node.span)?;
        let call_range = c.range(node.values[0].span())?;
        if !alias_active_at(
            &decoder_name,
            call_range.start,
            canonical_decoder,
            &alias_windows,
        ) {
            continue;
        }
        if temps
            .insert(
                temp.to_string(),
                (cipher, key, declaration_range, call_range),
            )
            .is_some()
        {
            return None;
        }
    }

    let temp_names: HashSet<String> = temps.keys().cloned().collect();
    let mut direct = Vec::new();
    let mut raw_temp_consumers = HashMap::<String, Vec<(Range<usize>, String)>>::new();
    collect_layer_block_uses(
        c,
        root,
        &proxy_aliases,
        &decoder_aliases,
        &temp_names,
        &mut direct,
        &mut raw_temp_consumers,
    );

    direct.sort_by_key(|use_site| (use_site.range.start, use_site.range.end));
    direct.dedup_by(|a, b| a.range == b.range);
    direct.retain(|use_site| {
        use_site.range.start >= scope.start
            && use_site.range.end <= scope.end
            && alias_active_at(
                &use_site.proxy,
                use_site.range.start,
                canonical_proxy,
                &alias_windows,
            )
            && alias_active_at(
                &use_site.decoder,
                use_site.range.start,
                canonical_decoder,
                &alias_windows,
            )
    });

    let mut out = LayerUses::default();
    out.uses = direct;
    out.allowed_ranges.extend(alias_ranges.values().cloned());

    for (temp, (cipher, key, declaration_range, call_range)) in temps {
        let shadow_ranges = temp_shadow_ranges(c, &statements, &temp, &declaration_range);
        let mut consumers = Vec::<Range<usize>>::new();
        if let Some(raw) = raw_temp_consumers.get(&temp) {
            for (range, proxy_name) in raw {
                if range.start <= declaration_range.end
                    || range.start < scope.start
                    || range.end > scope.end
                    || shadow_ranges
                        .iter()
                        .any(|shadow| range.start >= shadow.start && range.end <= shadow.end)
                    || !alias_active_at(proxy_name, range.start, canonical_proxy, &alias_windows)
                {
                    continue;
                }
                consumers.push(range.clone());
            }
        }
        consumers.sort_by_key(|range| (range.start, range.end));
        consumers.dedup();
        let temp_safe = temp_binding_occurrences_safe(
            c,
            scope,
            &temp,
            &declaration_range,
            &consumers,
            &shadow_ranges,
        );
        if consumers.is_empty() || !temp_safe {
            continue;
        }
        out.allowed_ranges.push(declaration_range);
        out.cleanup_edits.push((call_range, key.to_string()));
        for consumer in consumers {
            out.uses.push(DecodeUse {
                range: consumer,
                proxy: canonical_proxy.to_string(),
                decoder: canonical_decoder.to_string(),
                cipher: cipher.clone(),
                key,
            });
        }
    }

    let mut recognized_alias_ranges = out.allowed_ranges.clone();
    recognized_alias_ranges.extend(out.uses.iter().map(|use_site| use_site.range.clone()));
    for (alias, window) in &alias_windows {
        if !alias_occurrences_safe(c, alias, window, &recognized_alias_ranges) {
            return None;
        }
    }

    out.uses
        .sort_by_key(|use_site| (use_site.range.start, use_site.range.end));
    out.uses.dedup_by(|a, b| a.range == b.range);
    out.allowed_ranges
        .sort_by_key(|range| (range.start, range.end));
    out.allowed_ranges.dedup();
    out.cleanup_edits
        .sort_by_key(|(range, _)| (range.start, range.end));
    out.cleanup_edits.dedup_by(|a, b| a.0 == b.0);
    Some(out)
}

fn visit<'a, F: FnMut(&'a Stmt)>(b: &'a Block, f: &mut F) {
    for s in &b.stmts {
        f(s);
        match s {
            Stmt::Do(n) => visit(&n.block, f),
            Stmt::While(n) => visit(&n.block, f),
            Stmt::Repeat(n) => visit(&n.block, f),
            Stmt::If(n) => {
                for (_, x) in &n.branches {
                    visit(x, f)
                }
                if let Some(x) = &n.else_block {
                    visit(x, f)
                }
            }
            Stmt::NumericFor(n) => visit(&n.block, f),
            Stmt::GenericFor(n) => visit(&n.block, f),
            _ => {}
        }
    }
}
fn find_fn<'a>(c: &Ctx<'_>, b: &'a Block, w: &str, o: &mut Vec<(&'a FunctionBody, &'a Block)>) {
    for s in &b.stmts {
        match s {
            Stmt::Local(n)
                if n.names.len() == 1
                    && n.values.len() == 1
                    && c.text(n.names[0].name) == Some(w) =>
            {
                if let Expr::Function { body, .. } = &n.values[0] {
                    o.push((body, b))
                }
            }
            Stmt::Assign(n)
                if n.targets.len() == 1
                    && n.values.len() == 1
                    && name(c, &n.targets[0]) == Some(w) =>
            {
                if let Expr::Function { body, .. } = &n.values[0] {
                    o.push((body, b))
                }
            }
            Stmt::LocalFunction(n) if c.text(n.name) == Some(w) => o.push((&n.body, b)),
            _ => {}
        }
        match s {
            Stmt::Do(n) => find_fn(c, &n.block, w, o),
            Stmt::While(n) => find_fn(c, &n.block, w, o),
            Stmt::Repeat(n) => find_fn(c, &n.block, w, o),
            Stmt::If(n) => {
                for (_, x) in &n.branches {
                    find_fn(c, x, w, o)
                }
                if let Some(x) = &n.else_block {
                    find_fn(c, x, w, o)
                }
            }
            Stmt::NumericFor(n) => find_fn(c, &n.block, w, o),
            Stmt::GenericFor(n) => find_fn(c, &n.block, w, o),
            Stmt::Function(n) => find_fn(c, &n.body.block, w, o),
            Stmt::LocalFunction(n) => find_fn(c, &n.body.block, w, o),
            _ => {}
        }
    }
}
fn local_table<'a>(c: &Ctx<'_>, b: &'a Block, w: &str) -> Option<&'a Expr> {
    let mut z = None;
    for s in &b.stmts {
        let Stmt::Local(n) = s else { continue };
        if n.names.len() == 1
            && n.values.len() == 1
            && c.text(n.names[0].name) == Some(w)
            && matches!(unwrap(&n.values[0]), Expr::Table { .. })
        {
            if z.replace(&n.values[0]).is_some() {
                return None;
            }
        }
    }
    z
}
fn cache_from_meta(c: &Ctx<'_>, e: &Expr) -> Option<String> {
    let Expr::Table { fields, .. } = unwrap(e) else {
        return None;
    };
    let mut z = None;
    for f in fields {
        let (ok, v) = match f {
            TableField::Named { name, value } => (c.text(*name) == Some("__index"), value),
            TableField::Computed { key, value } => (
                matches!(unwrap(key),Expr::String(s) if lua_bytes(c.text(*s).unwrap_or("")).as_deref()==Some(b"__index")),
                value,
            ),
            _ => continue,
        };
        if ok {
            let q = name(c, v)?.to_string();
            if z.replace(q).is_some() {
                return None;
            }
        }
    }
    z
}
fn proven_private_empty_table_arg(c: &Ctx<'_>, b: &Block, expr: &Expr) -> bool {
    if matches!(unwrap(expr), Expr::Table { fields, .. } if fields.is_empty()) {
        return true;
    }
    let Some(alias) = name(c, expr) else {
        return false;
    };
    let Some((decl, decl_range)) = direct_local_decl(c, b, alias) else {
        return false;
    };
    if decl.values.len() != 1 || !empty_table_expr(&decl.values[0]) {
        return false;
    }
    let (Some(binding_range), Some(arg_range), Some(scope_range)) = (
        c.range(decl.names[0].name),
        c.range(expr.span()),
        c.range(b.span),
    ) else {
        return false;
    };
    if decl_range.end > arg_range.start {
        return false;
    }

    let occurrences: Vec<_> = c
        .toks
        .iter()
        .filter(|tok| {
            let start = tok.start as usize;
            let end = tok.end as usize;
            start >= scope_range.start && end <= scope_range.end && tok.text(c.src) == alias
        })
        .collect();
    occurrences.len() == 2
        && occurrences.iter().all(|tok| {
            let start = tok.start as usize;
            let end = tok.end as usize;
            (start >= binding_range.start && end <= binding_range.end)
                || (start >= arg_range.start && end <= arg_range.end)
        })
}

fn proxy_cache(c: &Ctx<'_>, b: &Block, p: &str) -> Option<(String, Range<usize>)> {
    let mut found = None;
    for s in &b.stmts {
        let (value, span) = match s {
            Stmt::Assign(n)
                if n.targets.len() == 1
                    && n.values.len() == 1
                    && name(c, &n.targets[0]) == Some(p) =>
            {
                (&n.values[0], n.span)
            }
            Stmt::Local(n)
                if n.names.len() == 1
                    && n.values.len() == 1
                    && c.text(n.names[0].name) == Some(p) =>
            {
                (&n.values[0], n.span)
            }
            _ => continue,
        };
        let Some((func, method, call_args)) = call(value) else {
            continue;
        };
        if method.is_some() || name(c, func) != Some("setmetatable") {
            continue;
        }
        let call_args = args(call_args)?;
        if call_args.len() != 2 || !proven_private_empty_table_arg(c, b, &call_args[0]) {
            continue;
        }
        // Decode recovery runs only after ordinary structural folding reaches a
        // fixed point. A named backing table is accepted only when it is a fresh
        // empty direct local whose only two identifier occurrences are its
        // declaration and this setmetatable argument, so its identity cannot escape.
        let Expr::Table { .. } = unwrap(&call_args[1]) else {
            continue;
        };
        let cache = cache_from_meta(c, &call_args[1])?;
        let range = c.range(span)?;
        if found.replace((cache, range)).is_some() {
            return None;
        }
    }
    found
}
fn contains(c: &Ctx<'_>, e: &Expr, w: &str) -> bool {
    match e {
        Expr::Name(s) => c.text(*s) == Some(w),
        Expr::Function { .. } => false,
        Expr::Table { fields, .. } => fields.iter().any(|f| match f {
            TableField::Positional(v) | TableField::Named { value: v, .. } => contains(c, v, w),
            TableField::Computed { key, value } => contains(c, key, w) || contains(c, value, w),
        }),
        Expr::Binary { lhs, rhs, .. } => contains(c, lhs, w) || contains(c, rhs, w),
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => contains(c, operand, w),
        Expr::Index { object, key, .. } => {
            contains(c, object, w) || matches!(key,IndexKey::Computed(k) if contains(c,k,w))
        }
        Expr::Call { func, args, .. } => {
            contains(c, func, w)
                || match args {
                    CallArgs::Paren(v) => v.iter().any(|x| contains(c, x, w)),
                    CallArgs::Table(v) => contains(c, v, w),
                    _ => false,
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches
                .iter()
                .any(|(a, b)| contains(c, a, w) || contains(c, b, w))
                || contains(c, else_value, w)
        }
        _ => false,
    }
}

fn cache_index(c: &Ctx<'_>, e: &Expr, objs: &HashSet<String>, key: &str) -> bool {
    if let Expr::Index {
        object,
        key: IndexKey::Computed(k),
        ..
    } = unwrap(e)
    {
        if name(c, object).is_some_and(|x| objs.contains(x)) && name(c, k) == Some(key) {
            return true;
        }
    }
    match e {
        Expr::Function { .. } => false,
        Expr::Table { fields, .. } => fields.iter().any(|f| match f {
            TableField::Positional(v) | TableField::Named { value: v, .. } => {
                cache_index(c, v, objs, key)
            }
            TableField::Computed { key: k, value: v } => {
                cache_index(c, k, objs, key) || cache_index(c, v, objs, key)
            }
        }),
        Expr::Binary { lhs, rhs, .. } => {
            cache_index(c, lhs, objs, key) || cache_index(c, rhs, objs, key)
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => cache_index(c, operand, objs, key),
        Expr::Index { object, key: k, .. } => {
            cache_index(c, object, objs, key)
                || matches!(k,IndexKey::Computed(x) if cache_index(c,x,objs,key))
        }
        Expr::Call { func, args, .. } => {
            cache_index(c, func, objs, key)
                || match args {
                    CallArgs::Paren(v) => v.iter().any(|x| cache_index(c, x, objs, key)),
                    CallArgs::Table(v) => cache_index(c, v, objs, key),
                    _ => false,
                }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches
                .iter()
                .any(|(a, b)| cache_index(c, a, objs, key) || cache_index(c, b, objs, key))
                || cache_index(c, else_value, objs, key)
        }
        _ => false,
    }
}
fn direct_cache_index(c: &Ctx<'_>, e: &Expr, objs: &HashSet<String>, key: &str) -> bool {
    matches!(unwrap(e),Expr::Index{object,key:IndexKey::Computed(k),..} if name(c,object).is_some_and(|x|objs.contains(x))&&name(c,k)==Some(key))
}
fn decoder_cache(c: &Ctx<'_>, b: &FunctionBody, cache: &str, key: &str) -> bool {
    let mut objs = HashSet::from([cache.to_string()]);
    loop {
        let before = objs.len();
        for s in &b.block.stmts {
            let Stmt::Local(n) = s else { continue };
            if n.names.len() != 1 || n.values.len() != 1 {
                continue;
            }
            if let Some(src) = name(c, &n.values[0]) {
                if objs.contains(src) {
                    if let Some(dst) = c.text(n.names[0].name) {
                        objs.insert(dst.to_string());
                    }
                }
            }
        }
        if objs.len() == before {
            break;
        }
    }
    let mut read = false;
    let mut write = false;
    visit(&b.block, &mut |s| {
        let mut q = |e: &Expr| {
            if cache_index(c, e, &objs, key) {
                read = true
            }
        };
        match s {
            Stmt::Local(n) => {
                for v in &n.values {
                    q(v)
                }
            }
            Stmt::Assign(n) => {
                for v in &n.targets {
                    if direct_cache_index(c, v, &objs, key) {
                        write = true
                    }
                }
                for v in &n.values {
                    q(v)
                }
            }
            Stmt::Call(e, _) => q(e),
            Stmt::While(n) => q(&n.cond),
            Stmt::Repeat(n) => q(&n.cond),
            Stmt::If(n) => {
                for (x, _) in &n.branches {
                    q(x)
                }
            }
            Stmt::NumericFor(n) => {
                q(&n.start);
                q(&n.limit);
                if let Some(x) = &n.step {
                    q(x)
                }
            }
            Stmt::GenericFor(n) => {
                for x in &n.exprs {
                    q(x)
                }
            }
            Stmt::Return(n) => {
                for x in &n.values {
                    q(x)
                }
            }
            _ => {}
        }
    });
    read && write
}
fn calls_expr(c: &Ctx<'_>, e: &Expr, w: &str) -> bool {
    match e {
        Expr::Function { .. } => false,
        Expr::Call { func, args, .. } => {
            name(c, func) == Some(w)
                || calls_expr(c, func, w)
                || match args {
                    CallArgs::Paren(v) => v.iter().any(|x| calls_expr(c, x, w)),
                    CallArgs::Table(v) => calls_expr(c, v, w),
                    _ => false,
                }
        }
        Expr::Table { fields, .. } => fields.iter().any(|f| match f {
            TableField::Positional(v) | TableField::Named { value: v, .. } => calls_expr(c, v, w),
            TableField::Computed { key, value } => calls_expr(c, key, w) || calls_expr(c, value, w),
        }),
        Expr::Binary { lhs, rhs, .. } => calls_expr(c, lhs, w) || calls_expr(c, rhs, w),
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => calls_expr(c, operand, w),
        Expr::Index { object, key, .. } => {
            calls_expr(c, object, w) || matches!(key,IndexKey::Computed(k) if calls_expr(c,k,w))
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            branches
                .iter()
                .any(|(a, b)| calls_expr(c, a, w) || calls_expr(c, b, w))
                || calls_expr(c, else_value, w)
        }
        _ => false,
    }
}
fn body_calls(c: &Ctx<'_>, b: &FunctionBody, w: &str) -> bool {
    let mut hit = false;
    visit(&b.block, &mut |s| {
        if hit {
            return;
        }
        let mut q = |e: &Expr| {
            if calls_expr(c, e, w) {
                hit = true
            }
        };
        match s {
            Stmt::Local(n) => {
                for v in &n.values {
                    q(v)
                }
            }
            Stmt::Assign(n) => {
                for v in &n.values {
                    q(v)
                }
            }
            Stmt::Call(e, _) => q(e),
            Stmt::While(n) => q(&n.cond),
            Stmt::Repeat(n) => q(&n.cond),
            Stmt::If(n) => {
                for (x, _) in &n.branches {
                    q(x)
                }
            }
            Stmt::NumericFor(n) => {
                q(&n.start);
                q(&n.limit);
                if let Some(x) = &n.step {
                    q(x)
                }
            }
            Stmt::GenericFor(n) => {
                for x in &n.exprs {
                    q(x)
                }
            }
            Stmt::Return(n) => {
                for x in &n.values {
                    q(x)
                }
            }
            _ => {}
        }
    });
    hit
}

fn immutable_local_defs<'a>(c: &Ctx<'_>, block: &'a Block) -> HashMap<String, &'a Expr> {
    let mut defs = HashMap::new();
    let mut duplicates = HashSet::new();
    let mut writes = HashSet::new();
    visit(block, &mut |stmt| match stmt {
        Stmt::Local(node) if node.names.len() == 1 && node.values.len() == 1 => {
            if let Some(name) = c.text(node.names[0].name) {
                if defs.insert(name.to_string(), &node.values[0]).is_some() {
                    duplicates.insert(name.to_string());
                }
            }
        }
        Stmt::Assign(node) => {
            for target in &node.targets {
                if let Some(name) = name(c, target) {
                    writes.insert(name.to_string());
                }
            }
        }
        _ => {}
    });
    for name in duplicates.into_iter().chain(writes) {
        defs.remove(&name);
    }
    defs
}

fn resolved<'a>(c: &Ctx<'_>, mut expr: &'a Expr, defs: &HashMap<String, &'a Expr>) -> &'a Expr {
    let mut seen = HashSet::new();
    loop {
        let current = unwrap(expr);
        let Expr::Name(span) = current else {
            return current;
        };
        let Some(name) = c.text(*span) else {
            return current;
        };
        if !seen.insert(name.to_string()) {
            return current;
        }
        let Some(next) = defs.get(name) else {
            return current;
        };
        expr = next;
    }
}

fn direct_local_defs<'a>(c: &Ctx<'_>, block: &'a Block) -> HashMap<String, &'a Expr> {
    let mut defs = HashMap::new();
    let mut invalid = HashSet::new();
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(node) if node.names.len() == 1 && node.values.len() == 1 => {
                if let Some(name) = c.text(node.names[0].name) {
                    if defs.insert(name.to_string(), &node.values[0]).is_some() {
                        invalid.insert(name.to_string());
                    }
                }
            }
            Stmt::Assign(node) => {
                for target in &node.targets {
                    if let Some(name) = name(c, target) {
                        invalid.insert(name.to_string());
                    }
                }
            }
            _ => {}
        }
    }
    for name in invalid {
        defs.remove(&name);
    }
    defs
}

fn computed_string_is(c: &Ctx<'_>, key: &IndexKey, wanted: &[u8]) -> bool {
    match key {
        IndexKey::Field(span) => c.text(*span).is_some_and(|text| text.as_bytes() == wanted),
        IndexKey::Computed(expr) => match unwrap(expr) {
            Expr::String(span) => lua_bytes(c.text(*span).unwrap_or(""))
                .is_some_and(|bytes| bytes.as_slice() == wanted),
            _ => false,
        },
    }
}

fn global_member<'a>(
    c: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    base: &str,
    field: &[u8],
) -> bool {
    let expr = resolved(c, expr, defs);
    let Expr::Index { object, key, .. } = expr else {
        return false;
    };
    alias_binding_name(c, object, defs).as_deref() == Some(base)
        && computed_string_is(c, key, field)
}

fn named<'a>(c: &'a Ctx<'_>, expr: &Expr) -> Option<&'a str> {
    name(c, unwrap(expr))
}

fn bin_names(c: &Ctx<'_>, expr: &Expr, op: &str) -> Option<(String, String)> {
    let (lhs, rhs) = bin(c, expr, op)?;
    Some((named(c, lhs)?.to_string(), named(c, rhs)?.to_string()))
}

fn mod_name_const(c: &Ctx<'_>, expr: &Expr, modulus: u64) -> Option<String> {
    let (lhs, rhs) = bin(c, expr, "%")?;
    (num(c, rhs) == Some(modulus))
        .then(|| named(c, lhs).map(str::to_string))
        .flatten()
}

fn div_sub_names_const(c: &Ctx<'_>, expr: &Expr, divisor: u64) -> Option<(String, String)> {
    let (numerator, denominator) = bin(c, expr, "/")?;
    if num(c, denominator) != Some(divisor) {
        return None;
    }
    bin_names(c, numerator, "-")
}

fn pow_two_name(c: &Ctx<'_>, expr: &Expr) -> Option<String> {
    let (base, exponent) = bin(c, expr, "^")?;
    (num(c, base) == Some(2))
        .then(|| named(c, exponent).map(str::to_string))
        .flatten()
}

fn divisor_shape(c: &Ctx<'_>, expr: &Expr, cursor: &str, shift: &str, bias: u64) -> bool {
    let Some((base, exponent)) = bin(c, expr, "^") else {
        return false;
    };
    if num(c, base) != Some(2) {
        return false;
    }
    let Some((bias_expr, scaled)) = bin(c, exponent, "-") else {
        return false;
    };
    if num(c, bias_expr) != Some(bias) {
        return false;
    }
    let Some((difference, divisor)) = bin(c, scaled, "/") else {
        return false;
    };
    if num(c, divisor) != Some(32) {
        return false;
    }
    bin_names(c, difference, "-").is_some_and(|(left, right)| left == cursor && right == shift)
}

fn floor_call<'a>(
    c: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    parent_defs: &HashMap<String, &'a Expr>,
) -> Option<&'a Expr> {
    let expr = resolved(c, expr, defs);
    let (func, method, call_args) = call(expr)?;
    if method.is_some() {
        return None;
    }
    let func = resolved(c, func, defs);
    if !global_member(c, func, parent_defs, "math", b"floor")
        && !global_member(c, func, defs, "math", b"floor")
    {
        return None;
    }
    let call_args = args(call_args)?;
    (call_args.len() == 1).then_some(&call_args[0])
}

fn table_remove_return(
    c: &Ctx<'_>,
    body: &FunctionBody,
    defs: &HashMap<String, &Expr>,
    parent_defs: &HashMap<String, &Expr>,
    buffer: &str,
) -> bool {
    let mut returns = 0usize;
    let mut valid = true;
    visit(&body.block, &mut |stmt| {
        let Stmt::Return(ret) = stmt else {
            return;
        };
        returns += 1;
        if ret.values.len() != 1 {
            valid = false;
            return;
        }
        let value = resolved(c, &ret.values[0], defs);
        let Some((func, method, call_args)) = call(value) else {
            valid = false;
            return;
        };
        if method.is_some() {
            valid = false;
            return;
        }
        let func = resolved(c, func, defs);
        if !global_member(c, func, parent_defs, "table", b"remove")
            && !global_member(c, func, defs, "table", b"remove")
        {
            valid = false;
            return;
        }
        let Some(call_args) = args(call_args) else {
            valid = false;
            return;
        };
        if call_args.len() != 1 || named(c, resolved(c, &call_args[0], defs)) != Some(buffer) {
            valid = false;
        }
    });
    valid && returns == 1
}

fn collect_calls_expr<'a>(expr: &'a Expr, calls: &mut Vec<&'a Expr>, nested_function: &mut bool) {
    match expr {
        Expr::Function { .. } => *nested_function = true,
        Expr::Table { fields, .. } => {
            for field in fields {
                match field {
                    TableField::Positional(value) | TableField::Named { value, .. } => {
                        collect_calls_expr(value, calls, nested_function)
                    }
                    TableField::Computed { key, value } => {
                        collect_calls_expr(key, calls, nested_function);
                        collect_calls_expr(value, calls, nested_function);
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            collect_calls_expr(lhs, calls, nested_function);
            collect_calls_expr(rhs, calls, nested_function);
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => {
            collect_calls_expr(operand, calls, nested_function)
        }
        Expr::Index { object, key, .. } => {
            collect_calls_expr(object, calls, nested_function);
            if let IndexKey::Computed(key) = key {
                collect_calls_expr(key, calls, nested_function);
            }
        }
        Expr::Call { func, args, .. } => {
            calls.push(expr);
            collect_calls_expr(func, calls, nested_function);
            match args {
                CallArgs::Paren(values) => {
                    for value in values {
                        collect_calls_expr(value, calls, nested_function);
                    }
                }
                CallArgs::Table(value) => collect_calls_expr(value, calls, nested_function),
                CallArgs::Str(_) => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (condition, value) in branches {
                collect_calls_expr(condition, calls, nested_function);
                collect_calls_expr(value, calls, nested_function);
            }
            collect_calls_expr(else_value, calls, nested_function);
        }
        _ => {}
    }
}

fn collect_calls_block<'a>(
    block: &'a Block,
    calls: &mut Vec<&'a Expr>,
    nested_function: &mut bool,
) {
    for stmt in &block.stmts {
        match stmt {
            Stmt::Local(node) => {
                for value in &node.values {
                    collect_calls_expr(value, calls, nested_function);
                }
            }
            Stmt::Assign(node) => {
                for value in node.targets.iter().chain(node.values.iter()) {
                    collect_calls_expr(value, calls, nested_function);
                }
            }
            Stmt::Call(expr, _) => collect_calls_expr(expr, calls, nested_function),
            Stmt::Do(node) => collect_calls_block(&node.block, calls, nested_function),
            Stmt::While(node) => {
                collect_calls_expr(&node.cond, calls, nested_function);
                collect_calls_block(&node.block, calls, nested_function);
            }
            Stmt::Repeat(node) => {
                collect_calls_block(&node.block, calls, nested_function);
                collect_calls_expr(&node.cond, calls, nested_function);
            }
            Stmt::If(node) => {
                for (condition, block) in &node.branches {
                    collect_calls_expr(condition, calls, nested_function);
                    collect_calls_block(block, calls, nested_function);
                }
                if let Some(block) = &node.else_block {
                    collect_calls_block(block, calls, nested_function);
                }
            }
            Stmt::NumericFor(node) => {
                collect_calls_expr(&node.start, calls, nested_function);
                collect_calls_expr(&node.limit, calls, nested_function);
                if let Some(step) = &node.step {
                    collect_calls_expr(step, calls, nested_function);
                }
                collect_calls_block(&node.block, calls, nested_function);
            }
            Stmt::GenericFor(node) => {
                for expr in &node.exprs {
                    collect_calls_expr(expr, calls, nested_function);
                }
                collect_calls_block(&node.block, calls, nested_function);
            }
            Stmt::Function(_) | Stmt::LocalFunction(_) => *nested_function = true,
            Stmt::Return(node) => {
                for value in &node.values {
                    collect_calls_expr(value, calls, nested_function);
                }
            }
            _ => {}
        }
    }
}

fn table_remove_call(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    parent_defs: &HashMap<String, &Expr>,
    buffer: &str,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Some((func, method, call_args)) = call(expr) else {
        return false;
    };
    if method.is_some() {
        return false;
    }
    let func = resolved(c, func, defs);
    if !global_member(c, func, parent_defs, "table", b"remove")
        && !global_member(c, func, defs, "table", b"remove")
    {
        return false;
    }
    let Some(call_args) = args(call_args) else {
        return false;
    };
    call_args.len() == 1 && alias_binding_name(c, &call_args[0], defs).as_deref() == Some(buffer)
}

fn generator_calls_are_exact(
    c: &Ctx<'_>,
    body: &FunctionBody,
    parent: &Block,
    buffer: &str,
) -> bool {
    let defs = immutable_local_defs(c, &body.block);
    let parent_defs = direct_local_defs(c, parent);
    let mut calls = Vec::new();
    let mut nested_function = false;
    collect_calls_block(&body.block, &mut calls, &mut nested_function);
    if nested_function || calls.len() != 4 {
        return false;
    }
    let mut floors = 0usize;
    let mut removes = 0usize;
    for call_expr in calls {
        if floor_call(c, call_expr, &defs, &parent_defs).is_some() {
            floors += 1;
        } else if table_remove_call(c, call_expr, &defs, &parent_defs, buffer) {
            removes += 1;
        } else {
            return false;
        }
    }
    floors == 3 && removes == 1
}

fn decoder_calls_are_exact(c: &Ctx<'_>, body: &FunctionBody, generator: &str) -> bool {
    let defs = immutable_local_defs(c, &body.block);
    let mut calls = Vec::new();
    let mut nested_function = false;
    collect_calls_block(&body.block, &mut calls, &mut nested_function);
    if nested_function || calls.len() != 3 {
        return false;
    }
    let mut lens = 0usize;
    let mut bytes = 0usize;
    let mut generators = 0usize;
    for call_expr in calls {
        if member_call_args(c, call_expr, &defs, "string", b"len").is_some() {
            lens += 1;
            continue;
        }
        if member_call_args(c, call_expr, &defs, "string", b"byte").is_some() {
            bytes += 1;
            continue;
        }
        let call_expr = resolved(c, call_expr, &defs);
        let Some((func, method, call_args)) = call(call_expr) else {
            return false;
        };
        let func = resolved(c, func, &defs);
        if method.is_none()
            && alias_binding_name(c, func, &defs).as_deref() == Some(generator)
            && args(call_args).is_some_and(|args| args.is_empty())
        {
            generators += 1;
            continue;
        }
        return false;
    }
    lens == 1 && bytes == 1 && generators == 1
}

fn decoder_writes_are_exact(
    c: &Ctx<'_>,
    body: &FunctionBody,
    cache: &str,
    key: &str,
    state: &str,
    cursor: &str,
    buffer: &str,
    rolling: &str,
) -> bool {
    let defs = immutable_local_defs(c, &body.block);
    let mut state_writes = 0usize;
    let mut cursor_writes = 0usize;
    let mut buffer_writes = 0usize;
    let mut rolling_writes = 0usize;
    let mut cache_writes = 0usize;
    let mut invalid = false;
    visit(&body.block, &mut |stmt| {
        let Stmt::Assign(node) = stmt else {
            return;
        };
        for target in &node.targets {
            if let Some(name) = name(c, target) {
                match name {
                    n if n == state => state_writes += 1,
                    n if n == cursor => cursor_writes += 1,
                    n if n == buffer => buffer_writes += 1,
                    n if n == rolling => rolling_writes += 1,
                    _ => invalid = true,
                }
            } else if index_is(c, target, &defs, cache, key) {
                cache_writes += 1;
            } else {
                invalid = true;
            }
        }
    });
    !invalid
        && state_writes == 1
        && cursor_writes == 1
        && buffer_writes == 1
        && rolling_writes == 1
        && cache_writes == 2
}

fn generator_writes_are_exact(
    c: &Ctx<'_>,
    body: &FunctionBody,
    state: &str,
    cursor: &str,
    buffer: &str,
) -> bool {
    let mut state_writes = 0usize;
    let mut cursor_writes = 0usize;
    let mut buffer_writes = 0usize;
    let mut invalid = false;
    visit(&body.block, &mut |stmt| {
        let Stmt::Assign(node) = stmt else {
            return;
        };
        for target in &node.targets {
            match name(c, target) {
                Some(name) if name == state => state_writes += 1,
                Some(name) if name == cursor => cursor_writes += 1,
                Some(name) if name == buffer => buffer_writes += 1,
                _ => invalid = true,
            }
        }
    });
    !invalid && state_writes == 1 && cursor_writes == 1 && buffer_writes == 1
}

fn generator_byte_shape(
    c: &Ctx<'_>,
    body: &FunctionBody,
    parent: &Block,
    state: &str,
    cursor: &str,
    bias: u64,
) -> Option<String> {
    let defs = immutable_local_defs(c, &body.block);
    let parent_defs = direct_local_defs(c, parent);
    let mut candidates = Vec::<(String, [String; 4])>::new();
    visit(&body.block, &mut |stmt| {
        let (target, value) = match stmt {
            Stmt::Assign(node) if node.targets.len() == 1 && node.values.len() == 1 => {
                (named(c, &node.targets[0]), Some(&node.values[0]))
            }
            _ => (None, None),
        };
        let (Some(buffer), Some(value)) = (target, value) else {
            return;
        };
        let Expr::Table { fields, .. } = unwrap(value) else {
            return;
        };
        if fields.len() != 4 {
            return;
        }
        let mut names = Vec::with_capacity(4);
        for field in fields {
            let TableField::Positional(value) = field else {
                return;
            };
            let Some(name) = named(c, value) else {
                return;
            };
            names.push(name.to_string());
        }
        candidates.push((
            buffer.to_string(),
            [
                names[0].clone(),
                names[1].clone(),
                names[2].clone(),
                names[3].clone(),
            ],
        ));
    });

    for (buffer, [b0, b1, b2, b3]) in candidates {
        let (Some(b0_def), Some(b1_def), Some(b2_def), Some(b3_def)) =
            (defs.get(&b0), defs.get(&b1), defs.get(&b2), defs.get(&b3))
        else {
            continue;
        };
        let Some(lo) = mod_name_const(c, b0_def, 256) else {
            continue;
        };
        if div_sub_names_const(c, b1_def, 256).is_none_or(|(left, right)| left != lo || right != b0)
        {
            continue;
        }
        let Some(hi) = mod_name_const(c, b2_def, 256) else {
            continue;
        };
        if div_sub_names_const(c, b3_def, 256).is_none_or(|(left, right)| left != hi || right != b2)
        {
            continue;
        }
        let (Some(lo_def), Some(hi_def)) = (defs.get(&lo), defs.get(&hi)) else {
            continue;
        };
        let Some(packed) = mod_name_const(c, lo_def, 65536) else {
            continue;
        };
        if div_sub_names_const(c, hi_def, 65536)
            .is_none_or(|(left, right)| left != packed || right != lo)
        {
            continue;
        }
        let Some(packed_def) = defs.get(&packed) else {
            continue;
        };
        let Some((left_term, right_term)) = bin_names(c, packed_def, "+") else {
            continue;
        };
        let mut floor_pair = None;
        for (frac_name, whole_name) in [(&left_term, &right_term), (&right_term, &left_term)] {
            let (Some(frac_def), Some(whole_def)) = (defs.get(frac_name), defs.get(whole_name))
            else {
                continue;
            };
            let Some(whole_arg) = floor_call(c, whole_def, &defs, &parent_defs) else {
                continue;
            };
            let Some(mixed) = named(c, whole_arg) else {
                continue;
            };
            let Some(frac_arg) = floor_call(c, frac_def, &defs, &parent_defs) else {
                continue;
            };
            let Some((fraction, scale)) = bin(c, frac_arg, "*") else {
                continue;
            };
            if num(c, scale) != Some(4294967296) {
                continue;
            }
            let Some((fraction_base, one)) = bin(c, fraction, "%") else {
                continue;
            };
            if num(c, one) != Some(1) || named(c, fraction_base) != Some(mixed) {
                continue;
            }
            floor_pair = Some(mixed.to_string());
            break;
        }
        let Some(mixed) = floor_pair else {
            continue;
        };
        let Some(mixed_def) = defs.get(&mixed) else {
            continue;
        };
        let Some((state32, pow)) = bin_names(c, mixed_def, "/") else {
            continue;
        };
        let (Some(state32_def), Some(pow_def)) = (defs.get(&state32), defs.get(&pow)) else {
            continue;
        };
        let Some(floored) = mod_name_const(c, state32_def, 4294967296) else {
            continue;
        };
        let Some(shift) = pow_two_name(c, pow_def) else {
            continue;
        };
        let (Some(floored_def), Some(shift_def)) = (defs.get(&floored), defs.get(&shift)) else {
            continue;
        };
        if mod_name_const(c, shift_def, 32).as_deref() != Some(cursor) {
            continue;
        }
        let Some(floor_arg) = floor_call(c, floored_def, &defs, &parent_defs) else {
            continue;
        };
        let Some((state_expr, divisor_expr)) = bin(c, floor_arg, "/") else {
            continue;
        };
        if named(c, state_expr) != Some(state) {
            continue;
        }
        let Some(divisor_name) = named(c, divisor_expr) else {
            continue;
        };
        let Some(divisor_def) = defs.get(divisor_name) else {
            continue;
        };
        if !divisor_shape(c, divisor_def, cursor, &shift, bias) {
            continue;
        }
        if table_remove_return(c, body, &defs, &parent_defs, &buffer)
            && generator_calls_are_exact(c, body, parent, &buffer)
            && generator_writes_are_exact(c, body, state, cursor, &buffer)
        {
            return Some(buffer);
        }
    }
    None
}

fn alias_binding_name(c: &Ctx<'_>, expr: &Expr, defs: &HashMap<String, &Expr>) -> Option<String> {
    let mut current = unwrap(expr);
    let mut seen = HashSet::new();
    loop {
        let Expr::Name(span) = current else {
            return None;
        };
        let name = c.text(*span)?.to_string();
        if !seen.insert(name.clone()) {
            return Some(name);
        }
        let Some(next) = defs.get(&name) else {
            return Some(name);
        };
        match unwrap(next) {
            Expr::Name(_) => current = next,
            _ => return Some(name),
        }
    }
}

fn merged_defs<'a>(
    outer: &HashMap<String, &'a Expr>,
    inner: &HashMap<String, &'a Expr>,
) -> HashMap<String, &'a Expr> {
    let mut merged = outer.clone();
    for (name, expr) in inner {
        merged.insert(name.clone(), *expr);
    }
    merged
}

fn member_call_args<'a>(
    c: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    base: &str,
    field: &[u8],
) -> Option<&'a [Expr]> {
    let expr = resolved(c, expr, defs);
    let (func, method, call_args) = call(expr)?;
    if method.is_some() || !global_member(c, func, defs, base, field) {
        return None;
    }
    args(call_args)
}

fn index_is(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    object_name: &str,
    key_name: &str,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Expr::Index {
        object,
        key: IndexKey::Computed(key),
        ..
    } = expr
    else {
        return false;
    };
    alias_binding_name(c, object, defs).as_deref() == Some(object_name)
        && alias_binding_name(c, key, defs).as_deref() == Some(key_name)
}

fn unary_len_name(c: &Ctx<'_>, expr: &Expr, defs: &HashMap<String, &Expr>, name: &str) -> bool {
    let expr = resolved(c, expr, defs);
    matches!(expr, Expr::Unary { op, operand, .. }
        if c.text(*op) == Some("#") && alias_binding_name(c, operand, defs).as_deref() == Some(name))
}

fn add_is_name_plus_const(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    name: &str,
    value: u64,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Some((lhs, rhs)) = bin(c, expr, "+") else {
        return false;
    };
    (named(c, resolved(c, lhs, defs)) == Some(name)
        && num(c, resolved(c, rhs, defs)) == Some(value))
        || (named(c, resolved(c, rhs, defs)) == Some(name)
            && num(c, resolved(c, lhs, defs)) == Some(value))
}

fn sub_is_name_minus_const(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    name: &str,
    value: u64,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Some((lhs, rhs)) = bin(c, expr, "-") else {
        return false;
    };
    alias_binding_name(c, lhs, defs).as_deref() == Some(name)
        && num(c, resolved(c, rhs, defs)) == Some(value)
}

fn flatten_add<'a>(
    c: &Ctx<'_>,
    expr: &'a Expr,
    defs: &HashMap<String, &'a Expr>,
    out: &mut Vec<&'a Expr>,
) {
    let expr = resolved(c, expr, defs);
    if let Some((lhs, rhs)) = bin(c, expr, "+") {
        flatten_add(c, lhs, defs, out);
        flatten_add(c, rhs, defs, out);
    } else {
        out.push(expr);
    }
}

fn call_named_no_args(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    callee: &str,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Some((func, method, call_args)) = call(expr) else {
        return false;
    };
    method.is_none()
        && named(c, resolved(c, func, defs)) == Some(callee)
        && args(call_args).is_some_and(|args| args.is_empty())
}

fn string_byte_call(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    cipher: &str,
    index: &str,
) -> bool {
    let Some(call_args) = member_call_args(c, expr, defs, "string", b"byte") else {
        return false;
    };
    call_args.len() == 2
        && alias_binding_name(c, &call_args[0], defs).as_deref() == Some(cipher)
        && alias_binding_name(c, &call_args[1], defs).as_deref() == Some(index)
}

fn string_len_call(c: &Ctx<'_>, expr: &Expr, defs: &HashMap<String, &Expr>, cipher: &str) -> bool {
    let Some(call_args) = member_call_args(c, expr, defs, "string", b"len") else {
        return false;
    };
    call_args.len() == 1 && alias_binding_name(c, &call_args[0], defs).as_deref() == Some(cipher)
}

fn rolling_update_shape(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    rolling: &str,
    cipher: &str,
    index: &str,
    generator: &str,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Some((sum, modulus)) = bin(c, expr, "%") else {
        return false;
    };
    if num(c, resolved(c, modulus, defs)) != Some(256) {
        return false;
    }
    let mut terms = Vec::new();
    flatten_add(c, sum, defs, &mut terms);
    terms.len() == 3
        && string_byte_call(c, terms[0], defs, cipher, index)
        && call_named_no_args(c, terms[1], defs, generator)
        && named(c, resolved(c, terms[2], defs)) == Some(rolling)
}

fn concat_cache_char_shape(
    c: &Ctx<'_>,
    target: &Expr,
    value: &Expr,
    defs: &HashMap<String, &Expr>,
    cache: &str,
    key: &str,
    rolling: &str,
) -> Option<String> {
    if !index_is(c, target, defs, cache, key) {
        return None;
    }
    let value = resolved(c, value, defs);
    let (old, ch) = bin(c, value, "..")?;
    if !index_is(c, old, defs, cache, key) {
        return None;
    }
    let ch = resolved(c, ch, defs);
    let Expr::Index {
        object,
        key: IndexKey::Computed(index),
        ..
    } = ch
    else {
        return None;
    };
    let chars = alias_binding_name(c, object, defs)?;
    add_is_name_plus_const(c, index, defs, rolling, 1).then_some(chars)
}

fn cache_initialized_empty_before(
    c: &Ctx<'_>,
    body: &FunctionBody,
    defs: &HashMap<String, &Expr>,
    cache: &str,
    key: &str,
    before: usize,
) -> bool {
    let mut found = false;
    visit(&body.block, &mut |stmt| {
        let Stmt::Assign(node) = stmt else {
            return;
        };
        let Some(range) = c.range(node.span) else {
            return;
        };
        if range.start >= before || node.targets.len() != 1 || node.values.len() != 1 {
            return;
        }
        if !index_is(c, &node.targets[0], defs, cache, key) {
            return;
        }
        let value = resolved(c, &node.values[0], defs);
        if matches!(value, Expr::String(span) if lua_bytes(c.text(*span).unwrap_or("")).is_some_and(|bytes| bytes.is_empty()))
        {
            found = true;
        }
    });
    found
}

fn decoder_returns_key(c: &Ctx<'_>, body: &FunctionBody, key: &str) -> bool {
    let mut count = 0usize;
    let mut valid = true;
    visit(&body.block, &mut |stmt| {
        let Stmt::Return(ret) = stmt else {
            return;
        };
        count += 1;
        if ret.values.len() != 1 || named(c, &ret.values[0]) != Some(key) {
            valid = false;
        }
    });
    valid && count == 1
}

fn decoder_loop_shape(
    c: &Ctx<'_>,
    body: &FunctionBody,
    cache: &str,
    key: &str,
    cipher: &str,
    rolling: &str,
    generator: &str,
) -> Option<String> {
    if !decoder_returns_key(c, body, key) {
        return None;
    }
    let defs = immutable_local_defs(c, &body.block);
    let mut matches = Vec::<String>::new();
    visit(&body.block, &mut |stmt| {
        let Stmt::NumericFor(loop_stmt) = stmt else {
            return;
        };
        if num(c, resolved(c, &loop_stmt.start, &defs)) != Some(1)
            || loop_stmt
                .step
                .as_ref()
                .is_some_and(|step| num(c, resolved(c, step, &defs)) != Some(1))
            || !string_len_call(c, &loop_stmt.limit, &defs, cipher)
        {
            return;
        }
        let Some(index) = c.text(loop_stmt.var.name) else {
            return;
        };
        let Some(loop_range) = c.range(loop_stmt.span) else {
            return;
        };
        if !cache_initialized_empty_before(c, body, &defs, cache, key, loop_range.start) {
            return;
        }
        let loop_defs = immutable_local_defs(c, &loop_stmt.block);
        let all_defs = merged_defs(&defs, &loop_defs);
        let mut rolling_ok = false;
        let mut chars = None;
        let mut multiple_chars = false;
        for inner in &loop_stmt.block.stmts {
            let Stmt::Assign(node) = inner else {
                continue;
            };
            if node.targets.len() != 1 || node.values.len() != 1 {
                continue;
            }
            if named(c, &node.targets[0]) == Some(rolling)
                && rolling_update_shape(
                    c,
                    &node.values[0],
                    &all_defs,
                    rolling,
                    cipher,
                    index,
                    generator,
                )
            {
                rolling_ok = true;
            }
            if let Some(candidate) = concat_cache_char_shape(
                c,
                &node.targets[0],
                &node.values[0],
                &all_defs,
                cache,
                key,
                rolling,
            ) {
                if chars.is_some() {
                    multiple_chars = true;
                } else {
                    chars = Some(candidate);
                }
            }
        }
        if rolling_ok && !multiple_chars {
            if let Some(chars) = chars {
                matches.push(chars);
            }
        }
    });
    matches.sort();
    matches.dedup();
    (matches.len() == 1).then(|| matches.remove(0))
}

fn assignment_pool_identity(c: &Ctx<'_>, block: &Block, pool: &str, index: &str) -> bool {
    block.stmts.iter().any(|stmt| {
        let Stmt::Assign(node) = stmt else {
            return false;
        };
        node.targets.len() == 1
            && node.values.len() == 1
            && matches!(unwrap(&node.targets[0]), Expr::Index { object, key: IndexKey::Computed(key), .. }
                if named(c, object) == Some(pool) && named(c, key) == Some(index))
            && named(c, &node.values[0]) == Some(index)
    })
}

fn repeat_condition_pool_empty(
    c: &Ctx<'_>,
    repeat: &Repeat,
    defs: &HashMap<String, &Expr>,
    pool: &str,
) -> bool {
    let cond = resolved(c, &repeat.cond, defs);
    let Some((lhs, rhs)) = bin(c, cond, "==") else {
        return false;
    };
    (unary_len_name(c, lhs, defs, pool) && num(c, resolved(c, rhs, defs)) == Some(0))
        || (unary_len_name(c, rhs, defs, pool) && num(c, resolved(c, lhs, defs)) == Some(0))
}

fn table_remove_pool_random(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    pool: &str,
) -> bool {
    let expr = resolved(c, expr, defs);
    let Some((func, method, call_args)) = call(expr) else {
        return false;
    };
    if method.is_some() || !global_member(c, func, defs, "table", b"remove") {
        return false;
    }
    let Some(call_args) = args(call_args) else {
        return false;
    };
    if call_args.len() != 2 || alias_binding_name(c, &call_args[0], defs).as_deref() != Some(pool) {
        return false;
    }
    let random = resolved(c, &call_args[1], defs);
    let Some((func, method, random_args)) = call(random) else {
        return false;
    };
    if method.is_some() || !global_member(c, func, defs, "math", b"random") {
        return false;
    }
    let Some(random_args) = args(random_args) else {
        return false;
    };
    random_args.len() == 2
        && num(c, resolved(c, &random_args[0], defs)) == Some(1)
        && unary_len_name(c, &random_args[1], defs, pool)
}

fn string_char_index_minus_one(
    c: &Ctx<'_>,
    expr: &Expr,
    defs: &HashMap<String, &Expr>,
    index: &str,
) -> bool {
    let Some(call_args) = member_call_args(c, expr, defs, "string", b"char") else {
        return false;
    };
    call_args.len() == 1 && sub_is_name_minus_const(c, &call_args[0], defs, index, 1)
}

fn empty_direct_table(c: &Ctx<'_>, parent: &Block, name: &str) -> bool {
    local_table(c, parent, name)
        .is_some_and(|expr| matches!(unwrap(expr), Expr::Table { fields, .. } if fields.is_empty()))
}

fn char_table_shape(c: &Ctx<'_>, parent: &Block, chars: &str) -> Option<Vec<Range<usize>>> {
    if !empty_direct_table(c, parent, chars) {
        return None;
    }
    let mut char_decl = None;
    for stmt in &parent.stmts {
        let Stmt::Local(node) = stmt else {
            continue;
        };
        if node.names.len() == 1
            && node.values.len() == 1
            && c.text(node.names[0].name) == Some(chars)
            && matches!(unwrap(&node.values[0]), Expr::Table { fields, .. } if fields.is_empty())
        {
            let range = c.range(node.span)?;
            if char_decl.replace(range).is_some() {
                return None;
            }
        }
    }
    let char_decl = char_decl?;
    let parent_defs = direct_local_defs(c, parent);
    let mut pools = Vec::<String>::new();
    for stmt in &parent.stmts {
        let Stmt::NumericFor(loop_stmt) = stmt else {
            continue;
        };
        if num(c, resolved(c, &loop_stmt.start, &parent_defs)) != Some(1)
            || num(c, resolved(c, &loop_stmt.limit, &parent_defs)) != Some(256)
            || loop_stmt
                .step
                .as_ref()
                .is_some_and(|step| num(c, resolved(c, step, &parent_defs)) != Some(1))
        {
            continue;
        }
        let Some(index) = c.text(loop_stmt.var.name) else {
            continue;
        };
        for candidate in parent_defs.keys() {
            if empty_direct_table(c, parent, candidate)
                && assignment_pool_identity(c, &loop_stmt.block, candidate, index)
            {
                pools.push(candidate.clone());
            }
        }
    }
    pools.sort();
    pools.dedup();
    let mut matches = Vec::<Range<usize>>::new();
    for pool in pools {
        for stmt in &parent.stmts {
            let Stmt::Repeat(repeat) = stmt else {
                continue;
            };
            let repeat_defs = immutable_local_defs(c, &repeat.block);
            let defs = merged_defs(&parent_defs, &repeat_defs);
            if !repeat_condition_pool_empty(c, repeat, &defs, &pool) {
                continue;
            }
            let mut removed_index = None::<String>;
            for inner in &repeat.block.stmts {
                let Stmt::Local(node) = inner else {
                    continue;
                };
                if node.names.len() != 1 || node.values.len() != 1 {
                    continue;
                }
                let Some(index) = c.text(node.names[0].name) else {
                    continue;
                };
                if table_remove_pool_random(c, &node.values[0], &defs, &pool) {
                    if removed_index.replace(index.to_string()).is_some() {
                        removed_index = None;
                        break;
                    }
                }
            }
            let Some(index) = removed_index else {
                continue;
            };
            let mut map_range = None;
            for inner in &repeat.block.stmts {
                let Stmt::Assign(node) = inner else {
                    continue;
                };
                if node.targets.len() != 1 || node.values.len() != 1 {
                    continue;
                }
                let Expr::Index {
                    object,
                    key: IndexKey::Computed(key),
                    ..
                } = unwrap(&node.targets[0])
                else {
                    continue;
                };
                if alias_binding_name(c, object, &defs).as_deref() == Some(chars)
                    && alias_binding_name(c, key, &defs).as_deref() == Some(&index)
                    && string_char_index_minus_one(c, &node.values[0], &defs, &index)
                {
                    let range = c.range(node.span)?;
                    if map_range.replace(range).is_some() {
                        map_range = None;
                        break;
                    }
                }
            }
            if let Some(range) = map_range {
                matches.push(range);
            }
        }
    }
    matches.sort_by_key(|range| (range.start, range.end));
    matches.dedup();
    if matches.len() != 1 {
        return None;
    }
    Some(vec![char_decl, matches.remove(0)])
}

fn key_mod(c: &Ctx<'_>, e: &Expr, key: &str) -> Option<u64> {
    let (a, b) = bin(c, e, "%")?;
    (name(c, a) == Some(key)).then(|| num(c, b)).flatten()
}
fn key_cursor(c: &Ctx<'_>, e: &Expr, key: &str) -> Option<(u64, u64)> {
    let (a, b) = bin(c, e, "+")?;
    for (m, x) in [(a, b), (b, a)] {
        if let (Some(add), Some(md)) = (num(c, x), key_mod(c, m, key)) {
            return Some((md, add));
        }
    }
    None
}
fn mul_name(c: &Ctx<'_>, e: &Expr, w: &str) -> Option<u64> {
    let (a, b) = bin(c, e, "*")?;
    if name(c, a) == Some(w) {
        num(c, b)
    } else if name(c, b) == Some(w) {
        num(c, a)
    } else {
        None
    }
}
fn state_rec(c: &Ctx<'_>, e: &Expr, w: &str) -> Option<(u64, u64, u64)> {
    let (v, m) = bin(c, e, "%")?;
    let md = num(c, m)?;
    let (a, b) = bin(c, v, "+")?;
    for (x, y) in [(a, b), (b, a)] {
        if let (Some(add), Some(mu)) = (num(c, y), mul_name(c, x, w)) {
            return Some((mu, add, md));
        }
    }
    None
}
fn cursor_rec(c: &Ctx<'_>, e: &Expr, w: &str) -> Option<(u64, u64)> {
    let (v, m) = bin(c, e, "%")?;
    Some((mul_name(c, v, w)?, num(c, m)?))
}
fn bias_expr(c: &Ctx<'_>, e: &Expr, w: &str, o: &mut HashSet<u64>) {
    if let Some((base, exp)) = bin(c, e, "^") {
        if num(c, base) == Some(2) {
            if let Some((a, b)) = bin(c, exp, "-") {
                if let Some(n) = num(c, a) {
                    if contains(c, b, w) {
                        o.insert(n);
                    }
                }
            }
        }
    }
    match e {
        Expr::Function { .. } => {}
        Expr::Table { fields, .. } => {
            for f in fields {
                match f {
                    TableField::Positional(v) | TableField::Named { value: v, .. } => {
                        bias_expr(c, v, w, o)
                    }
                    TableField::Computed { key, value } => {
                        bias_expr(c, key, w, o);
                        bias_expr(c, value, w, o)
                    }
                }
            }
        }
        Expr::Binary { lhs, rhs, .. } => {
            bias_expr(c, lhs, w, o);
            bias_expr(c, rhs, w, o)
        }
        Expr::Unary { operand, .. }
        | Expr::Paren { inner: operand, .. }
        | Expr::TypeAssert { expr: operand, .. } => bias_expr(c, operand, w, o),
        Expr::Index { object, key, .. } => {
            bias_expr(c, object, w, o);
            if let IndexKey::Computed(x) = key {
                bias_expr(c, x, w, o)
            }
        }
        Expr::Call { func, args, .. } => {
            bias_expr(c, func, w, o);
            match args {
                CallArgs::Paren(v) => {
                    for x in v {
                        bias_expr(c, x, w, o)
                    }
                }
                CallArgs::Table(v) => bias_expr(c, v, w, o),
                _ => {}
            }
        }
        Expr::IfElse {
            branches,
            else_value,
            ..
        } => {
            for (a, b) in branches {
                bias_expr(c, a, w, o);
                bias_expr(c, b, w, o)
            }
            bias_expr(c, else_value, w, o)
        }
        _ => {}
    }
}
fn biases(c: &Ctx<'_>, b: &FunctionBody, w: &str) -> HashSet<u64> {
    let mut o = HashSet::new();
    visit(&b.block, &mut |s| {
        let mut q = |e: &Expr| bias_expr(c, e, w, &mut o);
        match s {
            Stmt::Local(n) => {
                for v in &n.values {
                    q(v)
                }
            }
            Stmt::Assign(n) => {
                for v in &n.targets {
                    q(v)
                }
                for v in &n.values {
                    q(v)
                }
            }
            Stmt::Call(e, _) => q(e),
            Stmt::While(n) => q(&n.cond),
            Stmt::Repeat(n) => q(&n.cond),
            Stmt::If(n) => {
                for (x, _) in &n.branches {
                    q(x)
                }
            }
            Stmt::NumericFor(n) => {
                q(&n.start);
                q(&n.limit);
                if let Some(x) = &n.step {
                    q(x)
                }
            }
            Stmt::GenericFor(n) => {
                for x in &n.exprs {
                    q(x)
                }
            }
            Stmt::Return(n) => {
                for x in &n.values {
                    q(x)
                }
            }
            _ => {}
        }
    });
    o
}
fn direct_local_decl<'a>(
    c: &Ctx<'_>,
    block: &'a Block,
    target: &str,
) -> Option<(&'a Local, Range<usize>)> {
    let mut found = None;
    for stmt in &block.stmts {
        let Stmt::Local(node) = stmt else {
            continue;
        };
        if node.names.len() != 1 || c.text(node.names[0].name) != Some(target) {
            continue;
        }
        let range = c.range(node.span)?;
        if found.replace((node, range)).is_some() {
            return None;
        }
    }
    found
}

fn direct_function_range(
    c: &Ctx<'_>,
    block: &Block,
    target: &str,
    allow_assignment: bool,
) -> Option<Range<usize>> {
    let mut found = None;
    for stmt in &block.stmts {
        let span = match stmt {
            Stmt::Local(node)
                if node.names.len() == 1
                    && node.values.len() == 1
                    && c.text(node.names[0].name) == Some(target)
                    && matches!(unwrap(&node.values[0]), Expr::Function { .. }) =>
            {
                Some(node.span)
            }
            Stmt::Assign(node)
                if allow_assignment
                    && node.targets.len() == 1
                    && node.values.len() == 1
                    && name(c, &node.targets[0]) == Some(target)
                    && matches!(unwrap(&node.values[0]), Expr::Function { .. }) =>
            {
                Some(node.span)
            }
            Stmt::LocalFunction(node) if c.text(node.name) == Some(target) => Some(node.span),
            _ => None,
        };
        let Some(span) = span else {
            continue;
        };
        let range = c.range(span)?;
        if found.replace(range).is_some() {
            return None;
        }
    }
    found
}

fn is_nil_expr(expr: &Expr) -> bool {
    matches!(unwrap(expr), Expr::Nil(_))
}

fn empty_table_expr(expr: &Expr) -> bool {
    matches!(unwrap(expr), Expr::Table { fields, .. } if fields.is_empty())
}

fn simple_private_decl_range(
    c: &Ctx<'_>,
    block: &Block,
    target: &str,
    kind: &str,
) -> Option<Range<usize>> {
    let (node, range) = direct_local_decl(c, block, target)?;
    let ok = match kind {
        "nil-or-empty" => {
            node.values.is_empty() || (node.values.len() == 1 && is_nil_expr(&node.values[0]))
        }
        "empty-table" => node.values.len() == 1 && empty_table_expr(&node.values[0]),
        "number" => node.values.len() == 1 && num(c, &node.values[0]).is_some(),
        "nil-or-function" => {
            node.values.is_empty()
                || (node.values.len() == 1
                    && (is_nil_expr(&node.values[0])
                        || matches!(unwrap(&node.values[0]), Expr::Function { .. })))
        }
        "nil-or-call" => {
            node.values.is_empty()
                || (node.values.len() == 1
                    && (is_nil_expr(&node.values[0])
                        || matches!(unwrap(&node.values[0]), Expr::Call { .. })))
        }
        _ => false,
    };
    ok.then_some(range)
}

fn buffer_setup(
    c: &Ctx<'_>,
    parent: &Block,
    buffer: &str,
) -> Option<(Vec<Range<usize>>, Option<String>)> {
    let (decl, decl_range) = direct_local_decl(c, parent, buffer)?;
    let mut ranges = vec![decl_range];
    let mut alias = None;
    let mut needs_assignment = false;
    if decl.values.is_empty() || (decl.values.len() == 1 && is_nil_expr(&decl.values[0])) {
        needs_assignment = true;
    } else if decl.values.len() == 1 && empty_table_expr(&decl.values[0]) {
        // Direct private empty buffer.
    } else if decl.values.len() == 1 {
        let name = name(c, &decl.values[0])?;
        let (alias_decl, alias_range) = direct_local_decl(c, parent, name)?;
        if alias_decl.values.len() != 1 || !empty_table_expr(&alias_decl.values[0]) {
            return None;
        }
        ranges.push(alias_range);
        alias = Some(name.to_string());
    } else {
        return None;
    }

    let mut assignments = Vec::new();
    for stmt in &parent.stmts {
        let Stmt::Assign(node) = stmt else {
            continue;
        };
        if node.targets.len() == 1
            && node.values.len() == 1
            && name(c, &node.targets[0]) == Some(buffer)
        {
            assignments.push(node);
        }
    }
    if needs_assignment {
        if assignments.len() != 1 {
            return None;
        }
        let node = assignments[0];
        if empty_table_expr(&node.values[0]) {
            ranges.push(c.range(node.span)?);
        } else {
            let source = name(c, &node.values[0])?;
            let (source_decl, source_range) = direct_local_decl(c, parent, source)?;
            if source_decl.values.len() != 1 || !empty_table_expr(&source_decl.values[0]) {
                return None;
            }
            ranges.push(source_range);
            ranges.push(c.range(node.span)?);
            alias = Some(source.to_string());
        }
    } else if !assignments.is_empty() {
        return None;
    }
    Some((ranges, alias))
}

fn private_names_confined(c: &Ctx<'_>, proof: &DecoderProof, uses: &[DecodeUse]) -> bool {
    if uses.iter().any(|use_site| {
        use_site.range.start < proof.scope_range.start || use_site.range.end > proof.scope_range.end
    }) {
        return false;
    }
    let names: HashSet<&str> = proof.private_names.iter().map(String::as_str).collect();
    let mut allowed = proof.allowed_ranges.clone();
    allowed.extend(uses.iter().map(|use_site| use_site.range.clone()));
    for tok in c.toks {
        let start = tok.start as usize;
        let end = tok.end as usize;
        if start < proof.scope_range.start || end > proof.scope_range.end {
            continue;
        }
        if !names.contains(tok.text(c.src)) {
            continue;
        }
        if !allowed
            .iter()
            .any(|range| start >= range.start && end <= range.end)
        {
            return false;
        }
    }
    true
}

fn params(c: &Ctx<'_>, root: &Block, proxy: &str, decoder: &str) -> Option<DecoderProof> {
    let mut fs = Vec::new();
    find_fn(c, root, decoder, &mut fs);
    if fs.len() != 1 {
        return None;
    }
    let (body, parent) = fs[0];
    if body.params.len() != 2 || body.params.iter().any(|p| p.is_vararg) {
        return None;
    }
    let cipher = c.text(body.params[0].name)?;
    let key = c.text(body.params[1].name)?;
    let (cache, proxy_range) = proxy_cache(c, parent, proxy)?;
    if !decoder_cache(c, body, &cache, key) {
        return None;
    }

    let mut ss = Vec::<(String, u64)>::new();
    let mut cs = Vec::<(String, u64, u64)>::new();
    visit(&body.block, &mut |s| {
        let Stmt::Assign(n) = s else { return };
        if n.targets.len() != 1 || n.values.len() != 1 {
            return;
        }
        let Some(t) = name(c, &n.targets[0]) else {
            return;
        };
        if let Some(m) = key_mod(c, &n.values[0], key) {
            ss.push((t.to_string(), m));
        }
        if let Some((m, a)) = key_cursor(c, &n.values[0], key) {
            cs.push((t.to_string(), m, a));
        }
    });
    ss.sort();
    ss.dedup();
    cs.sort();
    cs.dedup();
    if ss.len() != 1 || cs.len() != 1 {
        return None;
    }
    let (sn, sm) = &ss[0];
    let (cn, kcm, kca) = &cs[0];
    if sn == cn {
        return None;
    }

    let mut seeds = Vec::new();
    visit(&body.block, &mut |s| {
        if let Stmt::Local(n) = s {
            if n.names.len() == 1 && n.values.len() == 1 {
                if let (Some(v), Some(w)) = (num(c, &n.values[0]), c.text(n.names[0].name)) {
                    seeds.push((w.to_string(), v));
                }
            }
        }
    });
    let mut roll = Vec::new();
    for (w, seed) in seeds {
        let mut ok = false;
        visit(&body.block, &mut |s| {
            let Stmt::Assign(n) = s else { return };
            if n.targets.len() != 1 || n.values.len() != 1 || name(c, &n.targets[0]) != Some(&w) {
                return;
            }
            if let Some((v, m)) = bin(c, &n.values[0], "%") {
                if num(c, m) == Some(256) && contains(c, v, &w) {
                    ok = true;
                }
            }
        });
        if ok {
            roll.push((w, seed));
        }
    }
    roll.sort();
    roll.dedup();
    if roll.len() != 1 {
        return None;
    }
    let rolling_name = roll[0].0.clone();
    let rolling_seed = roll[0].1;

    let mut gp = Vec::<GeneratorProof>::new();
    for s in &parent.stmts {
        let (candidate, generator_range) = match s {
            Stmt::Local(n) if n.names.len() == 1 && n.values.len() == 1 => match &n.values[0] {
                Expr::Function { body, .. } => (
                    c.text(n.names[0].name).map(|name| (name, body.as_ref())),
                    c.range(n.span),
                ),
                _ => (None, None),
            },
            Stmt::Assign(n) if n.targets.len() == 1 && n.values.len() == 1 => match &n.values[0] {
                Expr::Function { body, .. } => (
                    name(c, &n.targets[0]).map(|name| (name, body.as_ref())),
                    c.range(n.span),
                ),
                _ => (None, None),
            },
            Stmt::LocalFunction(n) => (c.text(n.name).map(|name| (name, &n.body)), c.range(n.span)),
            _ => (None, None),
        };
        let (Some((generator_name, g)), Some(generator_range)) = (candidate, generator_range)
        else {
            continue;
        };
        if !body_calls(c, body, generator_name) {
            continue;
        }
        let mut a = Vec::new();
        let mut b = Vec::new();
        visit(&g.block, &mut |s| {
            let Stmt::Assign(n) = s else { return };
            if n.targets.len() != 1 || n.values.len() != 1 {
                return;
            }
            if name(c, &n.targets[0]) == Some(sn) {
                if let Some(x) = state_rec(c, &n.values[0], sn) {
                    a.push(x);
                }
            }
            if name(c, &n.targets[0]) == Some(cn) {
                if let Some(x) = cursor_rec(c, &n.values[0], cn) {
                    b.push(x);
                }
            }
        });
        a.sort();
        a.dedup();
        b.sort();
        b.dedup();
        if a.len() != 1 || b.len() != 1 || a[0].2 != *sm {
            continue;
        }
        let z = biases(c, g, cn);
        if z.len() != 1 {
            continue;
        }
        let bias = *z.iter().next()?;
        let Some(buffer) = generator_byte_shape(c, g, parent, sn, cn, bias) else {
            continue;
        };
        let Some(chars) =
            decoder_loop_shape(c, body, &cache, key, cipher, &rolling_name, generator_name)
        else {
            continue;
        };
        if !decoder_calls_are_exact(c, body, generator_name)
            || !decoder_writes_are_exact(c, body, &cache, key, sn, cn, &buffer, &rolling_name)
        {
            continue;
        }
        let Some(char_ranges) = char_table_shape(c, parent, &chars) else {
            continue;
        };
        let candidate = GeneratorProof {
            state: a[0],
            cursor: b[0],
            bias,
            generator: generator_name.to_string(),
            buffer,
            generator_range,
            chars,
            char_ranges,
        };
        if !gp.contains(&candidate) {
            gp.push(candidate);
        }
    }
    if gp.len() != 1 {
        return None;
    }
    let gp = gp.remove(0);
    let (state_mul, state_add, state_mod) = gp.state;
    let (cursor_mul, cursor_mod) = gp.cursor;
    let worst = (state_mod.saturating_sub(1) as u128) * (state_mul as u128) + state_add as u128;
    if state_mod as u128 > (1u128 << 53)
        || worst > (1u128 << 53)
        || state_mul == 0
        || cursor_mul == 0
        || cursor_mod == 0
    {
        return None;
    }

    // The decoded call mutates cache/PRNG/buffer state. Static replacement is safe
    // only while that whole state remains private to this generated decoder layer.
    let scope_range = c.range(parent.span)?;
    let proxy_decl = simple_private_decl_range(c, parent, proxy, "nil-or-call")?;
    let decoder_decl = simple_private_decl_range(c, parent, decoder, "nil-or-function")?;
    let cache_decl = simple_private_decl_range(c, parent, &cache, "empty-table")?;
    let state_decl = simple_private_decl_range(c, parent, sn, "number")?;
    let cursor_decl = simple_private_decl_range(c, parent, cn, "number")?;
    let generator_decl = simple_private_decl_range(c, parent, &gp.generator, "nil-or-function")?;
    let decoder_range = direct_function_range(c, parent, decoder, true)?;
    let (mut buffer_ranges, buffer_alias) = buffer_setup(c, parent, &gp.buffer)?;

    let mut allowed_ranges = vec![
        proxy_range,
        proxy_decl,
        decoder_decl,
        cache_decl,
        state_decl,
        cursor_decl,
        generator_decl,
        decoder_range,
        gp.generator_range.clone(),
    ];
    allowed_ranges.append(&mut buffer_ranges);
    allowed_ranges.extend(gp.char_ranges.iter().cloned());

    let mut private_names = vec![
        proxy.to_string(),
        decoder.to_string(),
        cache,
        sn.clone(),
        cn.clone(),
        gp.generator.clone(),
        gp.buffer.clone(),
        gp.chars.clone(),
    ];
    if let Some(alias) = buffer_alias {
        private_names.push(alias);
    }
    private_names.sort();
    private_names.dedup();

    Some(DecoderProof {
        params: DecoderParams {
            state_mul,
            state_add,
            state_mod,
            cursor_mul,
            cursor_mod,
            key_cursor_mod: *kcm,
            key_cursor_add: *kca,
            rolling_seed,
            exponent_bias: gp.bias,
        },
        private_names,
        allowed_ranges,
        scope_range,
    })
}

fn decode(cipher: &[u8], key: u64, p: DecoderParams) -> Option<Vec<u8>> {
    if p.state_mod == 0 || p.cursor_mod == 0 || p.key_cursor_mod == 0 {
        return None;
    }
    let mut state = key % p.state_mod;
    let mut cursor = key % p.key_cursor_mod + p.key_cursor_add;
    let mut buf = Vec::<u8>::new();
    let mut rolling = p.rolling_seed % 256;
    let mut out = Vec::with_capacity(cipher.len());
    for &byte in cipher {
        if buf.is_empty() {
            state = (((state as u128) * (p.state_mul as u128) + p.state_add as u128)
                % (p.state_mod as u128)) as u64;
            let mut guard = 0;
            loop {
                cursor =
                    (((cursor as u128) * (p.cursor_mul as u128)) % (p.cursor_mod as u128)) as u64;
                if cursor != 1 {
                    break;
                }
                guard += 1;
                if guard > 1024 {
                    return None;
                }
            }
            let sh = cursor % 32;
            let exp = p.exponent_bias as f64 - (cursor - sh) as f64 / 32.0;
            let div = 2f64.powf(exp);
            if !div.is_finite() || div == 0.0 {
                return None;
            }
            let x = (state as f64 / div).floor();
            let mix = (x % 4294967296.0) / 2f64.powi(sh as i32);
            let pack = ((mix % 1.0) * 4294967296.0).floor() + mix.floor();
            if !pack.is_finite() || pack < 0.0 || pack > 4294967295.0 {
                return None;
            }
            let pack = pack as u64;
            let lo = pack % 65536;
            let hi = (pack - lo) / 65536;
            let b0 = lo % 256;
            let b1 = (lo - b0) / 256;
            let b2 = hi % 256;
            let b3 = (hi - b2) / 256;
            buf = vec![b0 as u8, b1 as u8, b2 as u8, b3 as u8]
        }
        rolling = (byte as u64 + buf.pop()? as u64 + rolling) % 256;
        out.push(rolling as u8)
    }
    Some(out)
}
pub(crate) fn collect_decoded_string_edits(
    src: &str,
    root: &Block,
    toks: &[Tok],
) -> Vec<DecodedEdit> {
    let c = Ctx { src, toks };
    let pairs = decoder_seed_pairs(&c, root);
    let mut e = Vec::new();
    for (p, d) in pairs {
        let Some(mut proof) = params(&c, root, &p, &d) else {
            continue;
        };
        let Some(layer) = collect_layer_uses(&c, root, &p, &d, &proof.scope_range) else {
            continue;
        };
        proof
            .allowed_ranges
            .extend(layer.allowed_ranges.iter().cloned());
        proof
            .private_names
            .extend(layer.alias_names.iter().cloned());
        proof.private_names.sort();
        proof.private_names.dedup();
        if !private_names_confined(&c, &proof, &layer.uses) {
            continue;
        }
        let mut decoded_all = true;
        let mut decoded = Vec::new();
        for u in &layer.uses {
            let Some(x) = decode(&u.cipher, u.key, proof.params) else {
                decoded_all = false;
                break;
            };
            decoded.push(DecodedEdit {
                start: u.range.start,
                end: u.range.end,
                replacement: quote(&x),
                counts_decode: true,
            });
        }
        if !decoded_all {
            continue;
        }
        e.extend(decoded);
        for (range, replacement) in layer.cleanup_edits {
            e.push(DecodedEdit {
                start: range.start,
                end: range.end,
                replacement,
                counts_decode: false,
            });
        }
    }
    e.sort_by_key(|x| x.start);
    let mut o = Vec::new();
    for x in e {
        if o.last().is_some_and(|p: &DecodedEdit| p.end > x.start) {
            continue;
        }
        o.push(x)
    }
    o
}
