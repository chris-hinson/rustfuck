use crate::lexer::{Token, TokenKind};
use std::cell::RefCell;
use std::fmt::{Display, Formatter, Result as FmtResult};
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct AstNode {
    id: usize,
    ntype: AstNodeKind,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AstNodeKind {
    Move { amount: isize },
    Change { amount: i128 },
    Output {},
    Input {},
    StartLoop { jump: Option<Box<AstNode>> },
    EndLoop { jump: Option<Box<AstNode>> },
    Eof {},
}

impl Display for AstNode {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        match self.ntype {
            AstNodeKind::Move { amount } => write!(f, "move {}", amount),
            AstNodeKind::Change { amount } => {
                write!(f, "change dp by {}", amount)
            }
            AstNodeKind::Output { .. } => {
                write!(f, "output")
            }
            AstNodeKind::Input { .. } => {
                write!(f, "input")
            }
            AstNodeKind::StartLoop { .. } => {
                write!(f, "start loop")
            }
            AstNodeKind::EndLoop { .. } => {
                write!(f, "end loop")
            }
            AstNodeKind::Eof {} => {
                write!(f, "end of file")
            }
        }
    }
}

pub fn parse(mut tokens: Vec<Token>) -> Result<AstNode, String> {
    if tokens.is_empty() {
        return Err("no more tokens".to_owned());
    }
    let token = tokens.remove(0);
    let node = match token.kind {
        TokenKind::DpMove { dir } => match dir.as_str() {
            "left" => Ok(AstNode {
                ntype: AstNodeKind::Move { amount: -1 },
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            "right" => Ok(AstNode {
                ntype: AstNodeKind::Move { amount: 1 },
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            _ => Err("Dp move with bad direction".to_owned()),
        },
        TokenKind::DataChange { dir } => match dir.as_str() {
            "down" => Ok(AstNode {
                ntype: AstNodeKind::Change { amount: -1 },
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            "up" => Ok(AstNode {
                ntype: AstNodeKind::Change { amount: 1 },
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            _ => Err("Dp move with bad direction".to_owned()),
        },
        TokenKind::Io { dir } => match dir.as_str() {
            "out" => Ok(AstNode {
                ntype: AstNodeKind::Output {},
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            "in" => Ok(AstNode {
                ntype: AstNodeKind::Input {},
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            _ => Err("Dp move with bad direction".to_owned()),
        },
        TokenKind::Loop { dir } => match dir.as_str() {
            "left" => Ok(AstNode {
                ntype: AstNodeKind::StartLoop { jump: None },
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            "right" => Ok(AstNode {
                ntype: AstNodeKind::EndLoop { jump: None },
                next: match parse(tokens) {
                    Ok(v) => Some(Box::new(RefCell::new(v))),
                    Err(_e) => None,
                },
            }),
            _ => Err("Dp move with bad direction".to_owned()),
        },
    };

    node
}

/*pub fn optimize(head: AstNode) -> AstNode {
    let cur = &head;
    match head.ntype {
        AstNodeKind::Move { dir, amount } => match &cur.next {
            Some(v) => {
                if v.ntype
                    == (AstNodeKind::Move {
                        dir: true,
                        amount: 1,
                    })
                {
                    v.amount += 1;
                }
            }
            None => {}
        },
        _ => {}
    }

    return head;
}*/

pub fn print_ast(mut head: AstNode) {
    let mut cur = &mut head;
    loop {
        match cur.next {
            Some(ref mut v) => {
                println!("{}", v.get_mut());
                cur = v.get_mut();
            }
            None => {
                break;
            }
        }
    }
}
