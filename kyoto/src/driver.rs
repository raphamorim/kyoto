pub use self::Stage::Tokens;
use lexer::*;

use std::io;
use std::io::Write;

#[derive(PartialEq, Clone, Debug)]
pub enum Stage {
    Tokens,
}

pub fn main_loop(stage: Stage, data: String) {
    if !data.is_empty() {
        let tokens = tokenize(&data);
        println!("{:?}", tokens);
        return;
    }

    let stdin = io::stdin();
    let mut stdout = io::stdout();
    let mut input = String::new();

    'main: loop {
        print!("> ");
        stdout.flush().unwrap();
        input.clear();
        stdin.read_line(&mut input).ok();

        if input.as_str() == ".quit\n" {
            break;
        }

        loop {
            let tokens = tokenize(input.as_str());
            if stage == Tokens {
                println!("{:?}", tokens);
                continue 'main;
            }
        }
    }
}
