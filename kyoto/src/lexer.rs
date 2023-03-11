use regex::Regex;

pub use self::Token::{
    Def,
    Extern,
    Delimiter,
    OpeningParenthesis,
    ClosingParenthesis,
    Comma,
    Ident,
    Number,
    Operator
};

#[derive(PartialEq, Clone, Debug)]
pub enum Token {
    Def,
    Extern,
    Delimiter, //';' character
    OpeningParenthesis,
    ClosingParenthesis,
    Comma,
    Ident(String),
    Number(f64),
    Operator(String)
}

pub fn tokenize(input: &str) -> Vec<Token> {
    let comment_re = Regex::new(r"(?m)#.*\n").unwrap();
    let preprocessed = comment_re.replace_all(input, "\n");

    let mut result = Vec::new();

    // regex for token, just union of straightforward regexes for different token types
    // operators are parsed the same way as identifier and separated later
    let token_re = Regex::new(concat!(
        r"(?P<ident>\p{Alphabetic}\w*)|",
        r"(?P<number>\d+\.?\d*)|",
        r"(?P<delimiter>;)|",
        r"(?P<oppar>\()|",
        r"(?P<clpar>\))|",
        r"(?P<comma>,)|",
        r"(?P<operator>\S)")).unwrap();

    for cap in token_re.captures_iter(&preprocessed) {
        let token = if cap.name("ident").is_some() {
            match cap.name("ident").unwrap().as_str() {
                "def" => Def,
                "extern" => Extern,
                ident => Ident(ident.to_string())
            }
        } else if cap.name("number").is_some() {
            match cap.name("number").unwrap().as_str().parse() {
                Ok(number) => Number(number),
                Err(_) => panic!("Lexer failed trying to parse number")
            }
        } else if cap.name("delimiter").is_some() {
            Delimiter
        } else if cap.name("oppar").is_some() {
            OpeningParenthesis
        } else if cap.name("clpar").is_some() {
            ClosingParenthesis
        } else if cap.name("comma").is_some() {
            Comma
        } else {
            Operator(cap.name("operator").unwrap().as_str().to_string())
        };

        result.push(token)
    }

    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_tokenizer_on_strings() {
        let s = String::from("Hello");
        let v = tokenize(&s);
        assert_eq!(v[0], Ident(s));

        let s = String::from("Hello is it me you are looking for");
        let v = tokenize(&s);
        assert_eq!(v[0], Ident("Hello".to_string()));
        assert_eq!(v[1], Ident("is".to_string()));
        assert_eq!(v[2], Ident("it".to_string()));
        assert_eq!(v[3], Ident("me".to_string()));
        assert_eq!(v[4], Ident("you".to_string()));
        assert_eq!(v[5], Ident("are".to_string()));
        assert_eq!(v[6], Ident("looking".to_string()));
        assert_eq!(v[7], Ident("for".to_string()));
    }
}
