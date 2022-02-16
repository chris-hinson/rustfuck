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
    VirtChange { amount: isize, offset: isize },
    Mult { amount: isize, offset: isize },
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
    program = virtualize_changes(&mut program);
    //run another remove run pass to remove double moves that virt may have created
    //this should be optional?
    program = remove_runs(program);
    program = remove_nops(&mut program).to_vec();
    program = mult_loops(&mut program).to_vec();
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

//when we see move-change sequences, we can actually do an offset change for them, followed by a move
//this lets us do serieses of move changes without wasting time moving our poitner more than once
pub fn virtualize_changes(ops: &mut Vec<AstNode>) -> Vec<AstNode> {
    let mut new_ops: Vec<AstNode> = Vec::new();

    //we keep the ops as a stack so we can pop one and look at the top to view the next
    ops.reverse();

    //keep trying to virtualize as long as we have more than one node
    let mut virtual_dp: isize = 0;
    while ops.len() > 1 {
        //get our current node
        let mut cur = ops.pop().unwrap();

        match cur.ntype {
            //if we are looking at a node of type MOVE && the next node is of type CHANGE,
            //pop the next one too and turn it into a virtual change
            AstNodeKind::Exp {
                kind: Operator::Move { amount: mam },
            } => {
                let next_index = ops.len() - 1;
                let next_op = &ops[next_index];
                match &next_op.ntype {
                    &AstNodeKind::Exp {
                        kind: Operator::Change { amount: cam },
                    } => {
                        //keep track of our virtual dp
                        virtual_dp += mam;
                        //push the new op
                        new_ops.push(AstNode {
                            id: cur.id,
                            ntype: AstNodeKind::Exp {
                                kind: Operator::VirtChange {
                                    amount: cam,
                                    offset: virtual_dp,
                                },
                            },
                        });
                        //get rid of the actual change op
                        ops.pop();
                    }
                    //if the next node is not a change, just push cur node
                    _ => {
                        //before we push the cur node, we might need to commit a move
                        if virtual_dp != 0 {
                            new_ops.push(AstNode {
                                id: ops[0].id,
                                ntype: AstNodeKind::Exp {
                                    kind: Operator::Move { amount: virtual_dp },
                                },
                            });
                            virtual_dp = 0;
                        }

                        //then push our cur node
                        new_ops.push(cur);
                    }
                }
            }
            AstNodeKind::Loop { exps: ref mut e } => {
                //if we have a non-zero virtual dp, commit to our move before we process the loop
                if virtual_dp != 0 {
                    //println!("pushing move before we go to loop");
                    new_ops.push(AstNode {
                        id: ops[0].id,
                        ntype: AstNodeKind::Exp {
                            kind: Operator::Move { amount: virtual_dp },
                        },
                    });
                    virtual_dp = 0;
                }

                *e = virtualize_changes(&mut e.to_vec());
                new_ops.push(cur);
            }
            //if we are not looking at a move node, just push our cur node
            _ => {
                if virtual_dp != 0 {
                    new_ops.push(AstNode {
                        id: ops[0].id,
                        ntype: AstNodeKind::Exp {
                            kind: Operator::Move { amount: virtual_dp },
                        },
                    });
                    virtual_dp = 0;
                }
                new_ops.push(cur);
            }
        }
    }

    if virtual_dp != 0 {
        //println!("commit move at end");
        new_ops.push(AstNode {
            id: new_ops[0].id,
            ntype: AstNodeKind::Exp {
                kind: Operator::Move { amount: virtual_dp },
            },
        });
    }
    if ops.len() > 0 {
        ops.reverse();
        new_ops.append(ops);
    }

    return new_ops;
}

//remove any moves or changes by 0
fn remove_nops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    ops.retain(|ele| match ele.ntype {
        AstNodeKind::Exp {
            kind: Operator::Move { amount },
        } => {
            if amount != 0 {
                true
            } else {
                false
            }
        }
        AstNodeKind::Exp {
            kind: Operator::Change { amount },
        } => {
            if amount != 0 {
                true
            } else {
                false
            }
        }
        _ => true,
    });

    for e in ops.iter_mut() {
        match e.ntype {
            AstNodeKind::Loop { exps: ref mut e } => *e = remove_nops(e).to_vec(),
            _ => {}
        }
    }

    return ops;
}

//this will not catch all mult behavior, only explicit mult loops
//TODO: can we generalize this?
//mult loops will look like virtual changes with a single change at the beginning or end
//TODO: account for mult loops with non-1 increments
fn mult_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    let first = &ops[0];
    let last = &ops[ops.len() - 1];

    //this is a mult loop if there are no instances of non change or non virt-change and either the first or last op is a change
    let is_mult = !ops.iter().any(|e| {
        !matches!(
            e,
            AstNode {
                id: _,
                ntype: AstNodeKind::Exp {
                    kind: Operator::Change { amount: _ }
                }
            }
        ) || !matches!(
            e,
            AstNode {
                id: _,
                ntype: AstNodeKind::Exp {
                    kind: Operator::VirtChange {
                        amount: _,
                        offset: _
                    }
                }
            }
        )
    }) && (matches!(
        first,
        AstNode {
            id: _,
            ntype: AstNodeKind::Exp {
                kind: Operator::Change { amount: -1 }
            }
        }
    ) || matches!(
        last,
        AstNode {
            id: _,
            ntype: AstNodeKind::Exp {
                kind: Operator::Change { amount: -1 }
            }
        }
    ));

    println!("is a mult loop? {is_mult}");

    //if this is a mult loop, flatten it
    if is_mult {

        //only keep our virtchanges
        ops.retain(|ele| {
            matches!(
                ele,
                AstNode {
                    id: _,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::VirtChange {
                            amount: _,
                            offset: _
                        }
                    }
                }
            )
        });

        //now turn all the VirtChanges into mults
        for i in ops.iter_mut() {
            if let AstNodeKind::Exp { ref mut kind } = i.ntype {
                match kind {
                    Operator::VirtChange {
                        amount: a,
                        offset: o,
                    } => {
                        *kind = Operator::Mult {
                            amount: *a,
                            offset: *o,
                        };
                        i.id -= 1;
                    }
                    Operator::Change { amount: _ } => {
                        *kind = Operator::Clear {};
                        i.id -= 1;
                    }
                    _ => {}
                }
            }
        }
    }
    //if its not a mult loop, it might contain a mult loop, so recurse on the loops it contains
    else {
        for i in ops.iter_mut() {
            if let AstNodeKind::Loop { exps: ref mut e } = i.ntype {
                *e = mult_loops(e).to_vec();
            }
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
