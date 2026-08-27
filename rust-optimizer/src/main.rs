use anyhow::{Context, Result};
use clap::Parser;
use std::{fs, path::PathBuf, time::Instant};

#[derive(Parser, Debug)]
struct Cli {
    input: PathBuf,
    output: Option<PathBuf>,
    #[arg(long, default_value_t = 100)]
    max_rounds: usize,
    #[arg(long)]
    parse_only: bool,
}

fn main() -> Result<()> {
    let cli = Cli::parse();
    let source = fs::read_to_string(&cli.input)
        .with_context(|| format!("failed to read {}", cli.input.display()))?;
    if cli.parse_only {
        let t = Instant::now();
        let p = eclipse_luau::parse_one(&source)
            .map_err(|e| anyhow::anyhow!("parse failed at {}: {}", e.offset, e.message))?;
        eprintln!(
            "parse_ms={} bytes={} tokens={} stmts={}",
            t.elapsed().as_millis(),
            source.len(),
            p.lexed.toks.len(),
            p.chunk.block.stmts.len()
        );
        return Ok(());
    }
    let t = Instant::now();
    let (out, stats) = prom_rust_optimizer::optimize(&source, cli.max_rounds)?;
    let output = cli.output.unwrap_or_else(|| {
        let mut p = cli.input.clone();
        p.set_extension("optimized.lua");
        p
    });
    if let Some(parent) = output.parent() {
        fs::create_dir_all(parent)?;
    }
    fs::write(&output, &out)?;
    println!("Input: {}", cli.input.display());
    println!("Output: {}", output.display());
    println!("Elapsed ms: {}", t.elapsed().as_millis());
    println!("Rounds: {}", stats.rounds);
    println!("Parses: {}", stats.parses);
    println!("Raw edits: {}", stats.edits);
    println!("Literal inlines: {}", stats.literal_inlines / 2);
    println!("Adjacent inlines: {}", stats.adjacent_inlines / 2);
    println!("Env folds: {}", stats.env_folds);
    println!("Deferred locals: {}", stats.deferred_locals);
    println!("Namecalls: {}", stats.namecalls);
    println!("Packed returns: {}", stats.packed_returns);
    println!("Multi-return slots: {}", stats.multi_return_slots);
    println!("Dead locals: {}", stats.dead_locals);
    println!("Dead call results: {}", stats.dead_call_results);
    println!("Direct nil cleanups: {}", stats.direct_nil_cleanups);
    println!(
        "Assignment value inlines: {}",
        stats.assignment_value_inlines / 2
    );
    println!("Call argument inlines: {}", stats.call_argument_inlines / 2);
    println!("Function inlines: {}", stats.function_inlines / 2);
    println!("Bare returns: {}", stats.bare_returns);
    Ok(())
}
