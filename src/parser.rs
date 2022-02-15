use crate::lexer::{Token, TokenKind};
//use owo_colors::OwoColorize;
use std::fmt::{Display, Formatter, Result as FmtResult};

/*cfg that defines our language
Program = { Exp }
Exp     = '[' { Operator } ']' | Operator
Operator   = Move | Change | IO
Move    = '<' | '>'
Change  = '+' | '-'
IO      = ',' | '.'
*/
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Program {
    pub exps: Vec<AstNode>,
}
impl Program {
    pub fn new(e: Vec<AstNode>) -> Self {
        Program { exps: e }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct AstNode {
    pub id: usize,
    pub ntype: AstNodeKind,
}
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AstNodeKind {
    Loop { exps: Vec<AstNode> },
    Exp { kind: Operator },
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Operator {
    Move { amount: isize },
    Change { amount: isize },
    IO { kind: IOKind },
    Clear,
    Scan { alignment: isize },
}
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum IOKind {
    Input,
    Output,
}

impl Display for AstNode {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        match &self.ntype {
            AstNodeKind::Loop { exps } => {
                let mut tabs = String::new();
                if exps.len() > 0 {
                    for _i in 0..exps[0].id {
                        tabs.push('\t');
                    }
                }

                /*let debug = format!(
                    "this is a level {} loop with {} expressions",
                    exps[0].id,
                    exps.len(),
                );*/

                let mut loop_exprs = String::new();
                //loop_exprs.push_str(&debug);
                for i in exps {
                    match &i.ntype {
                        AstNodeKind::Exp { kind: _ } => {
                            loop_exprs.push_str(&format!("{}{}: {}\n", tabs, i.id, &i.to_string()));
                        }
                        AstNodeKind::Loop { exps: _ } => loop_exprs.push_str(&format!("{}", i)),
                    }
                }

                write!(f, "{}", loop_exprs)
            }
            AstNodeKind::Exp { kind } => {
                write!(f, "this is an exp node of kind: {:?}", kind)
            }
        }
    }
}

//turn our token sequence into an AST
pub fn parse(mut tokens: Vec<Token>, level: usize) -> Result<Vec<AstNode>, String> {
    let mut program = Vec::new();

    while !tokens.is_empty() {
        let token = tokens.remove(0);
        let node = match token.kind {
            TokenKind::DpMove { dir } => match dir.as_str() {
                "left" => Ok(AstNode {
                    id: level,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::Move { amount: -1 },
                    },
                }),
                "right" => Ok(AstNode {
                    id: level,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::Move { amount: 1 },
                    },
                }),
                _ => Err("Dp move with bad direction".to_owned()),
            },
            TokenKind::DataChange { dir } => match dir.as_str() {
                "down" => Ok(AstNode {
                    id: level,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::Change { amount: -1 },
                    },
                }),
                "up" => Ok(AstNode {
                    id: level,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::Change { amount: 1 },
                    },
                }),
                _ => Err("Dp move with bad direction".to_owned()),
            },
            TokenKind::Io { dir } => match dir.as_str() {
                "out" => Ok(AstNode {
                    id: level,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::IO {
                            kind: IOKind::Output,
                        },
                    },
                }),
                "in" => Ok(AstNode {
                    id: level,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::IO {
                            kind: IOKind::Input,
                        },
                    },
                }),
                _ => Err("Dp move with bad direction".to_owned()),
            },
            TokenKind::Loop { dir } => match dir.as_str() {
                "left" => {
                    //lets get all the tokens that make up this loop body and parse them as their own "ast"
                    let mut lefts = 0;
                    let mut rights = 0;
                    let mut end_index = 0;
                    for (index, token) in tokens.iter().enumerate() {
                        if lefts == rights
                            && token.kind.eq(&TokenKind::Loop {
                                dir: "right".to_string(),
                            })
                        {
                            end_index = index;
                            break;
                        }
                        match &token.kind {
                            TokenKind::Loop { dir } => {
                                if dir.eq("left") {
                                    lefts += 1
                                } else {
                                    rights += 1
                                }
                            }
                            _ => {}
                        }
                    }
                    let mut loop_string = tokens.drain(0..=end_index).collect::<Vec<Token>>();
                    loop_string.pop();

                    //return Good
                    Ok(AstNode {
                        id: level + 1,
                        ntype: AstNodeKind::Loop {
                            exps: parse(loop_string, level + 1).unwrap(),
                        },
                    })
                }
                "right" => Err("encountered end of a loop".to_owned()),
                _ => Err("Dp move with bad direction".to_owned()),
            },
        };
        program.push(node.unwrap());
    }

    program = remove_runs(program);
    program = clear_loops(&mut program).to_vec();
    program = scan_loops(&mut program).to_vec();
    Ok(program)
}

//first pass optimization
//this essentially turns our code into an IR so its no longer "technically" brainfuck code
pub fn remove_runs(mut exprs: Vec<AstNode>) -> Vec<AstNode> {
    //first reverse the vec so we can pop and push in constant time
    exprs.reverse();
    let mut new_exprs: Vec<AstNode> = Vec::new();

    while exprs.len() >= 2 {
        //pop the next char
        let mut cur = exprs.pop().unwrap();

        //match on what kind of astnode we're currently looking at
        match cur.ntype {
            //if we're looking at an exp node, we might be able to eliminate it by smushing it into the next one
            AstNodeKind::Exp { ref mut kind } => match kind {
                //if its a move or a change op, try to smush
                Operator::Move {
                    amount: ref mut cam,
                } => {
                    //lets look at the next op to see if we can smush
                    let end = exprs.len() - 1;
                    match exprs[end].ntype {
                        AstNodeKind::Exp {
                            kind:
                                Operator::Move {
                                    amount: ref mut nam,
                                },
                        } =>
                        //we are finally free to smush
                        {
                            *nam += *cam
                        }
                        _ => new_exprs.push(cur),
                    }
                }
                Operator::Change {
                    amount: ref mut cam,
                } => {
                    //lets look at the next op to see if we can smush
                    let end = exprs.len() - 1;
                    match exprs[end].ntype {
                        AstNodeKind::Exp {
                            kind:
                                Operator::Change {
                                    amount: ref mut nam,
                                },
                        } =>
                        //we are finally free to smush
                        {
                            *nam += *cam
                        }
                        _ => new_exprs.push(cur),
                    }
                }
                _ => new_exprs.push(cur),
            },
            AstNodeKind::Loop { exps: ref mut e } => {
                //println!("about to process a loop: {:?}", e.green());
                *e = remove_runs(e.to_vec());
                new_exprs.push(cur);
            }
        }
    }

    if exprs.len() > 0 {
        exprs.reverse();
        new_exprs.append(&mut exprs);
    }

    return new_exprs;
}

//this turns any loops which contains only a change operator into an explicit clear op
pub fn clear_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    //iterate over this expressions vector looking for loops we can turn into clears
    for i in ops.iter_mut() {
        match i.ntype {
            //if we see a loop we need to either clear it if we can, or otherwise recurse on it to
            //make sure it doesnt contain a nested loop which we might be able to clear
            AstNodeKind::Loop { ref mut exps } => {
                if exps.len() == 1 {
                    match exps[0].ntype {
                        AstNodeKind::Exp {
                            kind: Operator::Change { amount: _ },
                        } => {
                            *i = AstNode {
                                id: i.id - 1,
                                ntype: AstNodeKind::Exp {
                                    kind: Operator::Clear,
                                },
                            }
                        }
                        _ => {}
                    }
                } else {
                    clear_loops(exps);
                }
            }
            _ => {}
        }
    }

    return ops;
}

pub fn scan_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    for i in ops.iter_mut() {
        match i.ntype {
            AstNodeKind::Loop { ref mut exps } => {
                if exps.len() == 1 {
                    match exps[0].ntype {
                        AstNodeKind::Exp {
                            kind: Operator::Move { amount },
                        } => {
                            *i = AstNode {
                                id: i.id - 1,
                                ntype: AstNodeKind::Exp {
                                    kind: Operator::Scan { alignment: amount },
                                },
                            }
                        }
                        _ => {}
                    }
                }
            }
            _ => {}
        }
    }

    return ops;
}

pub fn print_ast(prg: Program) {
    for (_i, exp) in prg.exps.iter().enumerate() {
        match &exp.ntype {
            AstNodeKind::Exp { kind: _ } => {
                println!("{}: {}", exp.id, exp);
            }
            AstNodeKind::Loop { exps: _ } => {
                print!("{}", exp)
            }
        }
    }
}
