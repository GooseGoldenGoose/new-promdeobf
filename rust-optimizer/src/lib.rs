mod string_decoder;

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


include!("core.rs");
include!("steps/structural.rs");
include!("steps/multi_return.rs");
include!("steps/control_flow.rs");
include!("steps/private_table.rs");
include!("steps/namecall.rs");
include!("pipeline.rs");
