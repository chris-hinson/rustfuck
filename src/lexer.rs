//use std::fmt::{Display, Formatter, Result as FmtResult};
//All 8 brainfuck ops can fit into 4 subtypes, each with a direction
#[derive(Debug, PartialEq, Eq, Clone)]
pub enum TokenKind {
    DpMove { dir: String },
    DataChange { dir: String },
    Io { dir: String },
    Loop { dir: String },
}

#[derive(Debug, PartialEq, Eq, Clone)]
pub struct Token {
    pub loc: usize,
    pub kind: TokenKind,
}
impl Token {
    pub fn new(loc: usize, kind: TokenKind) -> Self {
        Token { loc, kind }
    }
}

//lexing errors should reallllllly never happen, but if they do, can really only be an invalid op
//NOTE: in standard brainfuck, all non-valid characters are considered comments and ignored. So lexing errors are impossible.
//there are brainfuck extenstions that add comment support, so I'm leaving this code here in case i end up supporting them
/*pub enum LexError {
    InvalidChar(char),
}

impl Display for LexError {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        match self {
            LexError::InvalidChar(c) => write!(f, "invalid character '{}'", c.escape_debug()),
        }
    }
}*/

//main function to lex our source code into a string of Tokens.
//return a result of either a Vec of Tokens, or a String, defining how the FUCK we managed to error
pub fn lex(source: &str) -> Result<Vec<Token>, String> {
    let mut source = source.chars().collect::<Vec<char>>();
    //strip whitespace
    source.retain(|c| !c.is_whitespace());
    //strip any characters that are not valid ops
    source.retain(|c| {
        c.eq(&'<')
            || c.eq(&'>')
            || c.eq(&'+')
            || c.eq(&'-')
            || c.eq(&'.')
            || c.eq(&',')
            || c.eq(&'[')
            || c.eq(&']')
    });

    let mut prog: Vec<Token> = Vec::new();

    for (index, char) in source.iter().enumerate() {
        match char {
            '<' => prog.push(Token::new(
                index,
                TokenKind::DpMove {
                    dir: "left".to_owned(),
                },
            )),
            '>' => prog.push(Token::new(
                index,
                TokenKind::DpMove {
                    dir: "right".to_owned(),
                },
            )),
            '+' => prog.push(Token::new(
                index,
                TokenKind::DataChange {
                    dir: "up".to_owned(),
                },
            )),
            '-' => prog.push(Token::new(
                index,
                TokenKind::DataChange {
                    dir: "down".to_owned(),
                },
            )),
            '.' => prog.push(Token::new(
                index,
                TokenKind::Io {
                    dir: "out".to_owned(),
                },
            )),
            ',' => prog.push(Token::new(
                index,
                TokenKind::Io {
                    dir: "in".to_owned(),
                },
            )),
            '[' => prog.push(Token::new(
                index,
                TokenKind::Loop {
                    dir: "left".to_owned(),
                },
            )),
            ']' => prog.push(Token::new(
                index,
                TokenKind::Loop {
                    dir: "right".to_owned(),
                },
            )),
            _ => return Err("how the fuck did we get here".to_owned()),
        }
    }

    Ok(prog)
}

//lexing tests (insofar as they are)
#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;

    //test a file with commends in it
    #[test]
    fn test_file_with_comments() {
        let filename = "./programs/tests/lexing_tests/comments.bf";
        let file_string = fs::read_to_string(filename).unwrap();
        let _lex_result = lex(&file_string).unwrap();
    }

    //test a minified file
    #[test]
    fn test_file_without_comments() {
        let filename = "./programs/tests/lexing_tests/no_comments.bf";
        let file_string = fs::read_to_string(filename).unwrap();
        let _lex_result = lex(&file_string).unwrap();
    }
}
