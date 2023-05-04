extern crate clap;
extern crate kyoto;

use std::fs;
use kyoto::driver::{main_loop, Tokens};

use clap::Parser;

/// Kyoto compiler [(-r | -d)]
#[derive(Parser, Debug)]
struct Args {
    /// Run only lexer and show its output
    #[clap(default_value_t = String::from(""))]
    filepath: String,

    /// Executes a read–eval–print loop (REPL), also termed an interactive toplevel or language shell
    #[clap(short, long)]
    repl: bool,

    /// Enable debug logs
    #[clap(short, long)]
    debug: bool,
}

fn main() {
    let args = Args::parse();
    let inputfile = &args.filepath;
    let data: String;

    if !inputfile.is_empty() && inputfile.ends_with(".kto") {
        let inputfile = fs::read_to_string(inputfile);
        data = match inputfile {
            Ok(input) => input,
            Err(err) => {
                panic!("Failed trying to read Kyoto (.kto) file. {:?}", err)
            }
        }
    } else {
        panic!("Please provide a valid Kyoto (.kto) file");
    }

    main_loop(Tokens, data);
}
