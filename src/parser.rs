use crate::lexer::{Token, TokenKind};
use std::fmt::{Display, Formatter, Result as FmtResult};
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AstNode {
    Move {
        dir: bool,
        amount: isize,
        next: Option<Box<AstNode>>,
    },
    Change {
        dir: bool,
        amount: i128,
        next: Option<Box<AstNode>>,
    },
    Output {
        next: Option<Box<AstNode>>,
    },
    Input {
        next: Option<Box<AstNode>>,
    },
    StartLoop {
        next: Option<Box<AstNode>>,
        jump: Option<Box<AstNode>>,
    },
    EndLoop {
        next: Option<Box<AstNode>>,
        jump: Option<Box<AstNode>>,
    },
    Err {},
}

impl Display for AstNode {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        match self {
            AstNode::Move { dir, amount, next } => write!(
                f,
                "move {} by {}",
                (if *dir { "right" } else { "left" }),
                amount
            ),
            AstNode::Change { dir, amount, next } => write!(
                f,
                "change dp by {}{}",
                (if *dir { "" } else { "-" }),
                amount
            ),
            AstNode::Output { .. } => {
                write!(f, "output")
            }
            AstNode::Input { .. } => {
                write!(f, "input")
            }
            AstNode::StartLoop { .. } => {
                write!(f, "start loop")
            }
            AstNode::EndLoop { .. } => {
                write!(f, "end loop")
            }
            AstNode::Err {} => {
                write!(f, "error node")
            }
        }
    }
}
impl AstNode {
    fn new(tok: Token) -> Self {
        match tok.kind {
            TokenKind::DpMove { dir } => match dir.as_str() {
                "left" => AstNode::Move {
                    dir: false,
                    amount: 1,
                    next: None,
                },
                "right" => AstNode::Move {
                    dir: true,
                    amount: 1,
                    next: None,
                },
                _ => AstNode::Err {},
            },
            TokenKind::DataChange { dir } => match dir.as_str() {
                "down" => AstNode::Change {
                    dir: false,
                    amount: 1,
                    next: None,
                },
                "up" => AstNode::Move {
                    dir: true,
                    amount: 1,
                    next: None,
                },
                _ => AstNode::Err {},
            },
            TokenKind::Io { dir } => match dir.as_str() {
                "out" => AstNode::Output { next: None },
                "in" => AstNode::Input { next: None },
                _ => AstNode::Err {},
            },
            TokenKind::Loop { dir } => match dir.as_str() {
                "left" => AstNode::StartLoop {
                    next: None,
                    jump: None,
                },
                "right" => AstNode::EndLoop {
                    next: None,
                    jump: None,
                },
                _ => AstNode::Err {},
            },
        }
    }
}

pub fn parse(mut tokens: Vec<Token>) -> Result<AstNode, String> {
    if tokens.is_empty() {
        return Err("no more tokens".to_owned());
    }
    let token = tokens.remove(0);
    let node = AstNode::new(token);
    match node {
        AstNode::Move {
            dir: _,
            amount: _,
            ref next,
        } => {
            next = match parse(tokens) {
                Ok(v) => &Some(Box::new(v)),
                Err(_e) => &None,
            };
        }
        _ => {}
    }

    Ok(node)
}

/*fn optimize(mut nodes: Vec<AstNode>) -> Vec<AstNode> {
    let mut new_nodes: Vec<AstNode> = Vec::new();

    for (i, n) in nodes.iter_mut().enumerate() {
        if nodes[i + 1].eq(n) {}
    }

    new_nodes
}*/
