extern crate clap;
extern crate kyoto;

use kyoto::driver::{main_loop,
                                Tokens
};

use clap::Parser;

/// Kyoto compiler [(-l | -p | -i)]
#[derive(Parser, Debug)]
struct Args {
    /// Run only lexer and show its output
    #[clap(default_value_t = String::from(""))]
    filepath: String,

    /// Run only lexer and show its output
    #[clap(short, long)]
    lexer: bool,

    /// Run only parser and show its output
    #[clap(short, long)]
    parser: bool,

    /// Run only IR builder and show its output
    #[clap(short, long)]
    ir: bool
}

fn main() {
    let args = Args::parse();

    let stage = Tokens;

    main_loop(stage, &args.filepath);
}
