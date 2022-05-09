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
    #[clap(short, long)]
    lexer: String,

    /// Run only parser and show its output
    #[clap(short, long)]
    parser: String,

    /// Run only IR builder and show its output
    #[clap(short, long)]
    ir: String
}

fn main() {
    let _args = Args::parse();

    let stage = Tokens;

    main_loop(stage);
}
