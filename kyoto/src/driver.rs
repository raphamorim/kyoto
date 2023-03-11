pub use self::Stage::Tokens;
use lexer::*;
use std::fs;
use std::io;
use std::io::Write;

#[derive(PartialEq, Clone, Debug)]
pub enum Stage {
    Tokens,
}

pub fn main_loop(stage: Stage, inputfile: &String) {
    if inputfile.contains(".kto") {
        let inputfile = fs::read_to_string(inputfile);
        match inputfile {
            Ok(input) => {
                let tokens = tokenize(input.as_str());
                println!("{:?}", tokens);
            }
            Err(_) => {
                panic!("Failed trying to read Kyoto (.kto) file")
            }
        }
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
