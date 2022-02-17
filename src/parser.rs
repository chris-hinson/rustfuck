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

//a collection of helper functions to make optimization passes neater
#[allow(dead_code)]
impl AstNode {
    fn is_loop(&mut self) -> Option<&mut Vec<AstNode>> {
        if let AstNodeKind::Loop { exps: ref mut e } = self.ntype {
            return Some(e);
        } else {
            return None;
        }
    }
    fn is_exp(&mut self) -> Option<&mut Operator> {
        if let AstNodeKind::Exp { kind: ref mut k } = self.ntype {
            return Some(k);
        } else {
            return None;
        }
    }
    //check if our node is a certain node type. optionally check if it has a specific contents
    fn is_change(&self, am: Option<isize>) -> Option<isize> {
        match self.ntype {
            AstNodeKind::Exp {
                kind: Operator::Change { amount },
            } => am.map_or(
                Some(amount),
                |am| if am == amount { Some(am) } else { None },
            ),

            _ => None,
        }
    }
    fn is_move(&self, am: Option<isize>) -> Option<isize> {
        match self.ntype {
            AstNodeKind::Exp {
                kind: Operator::Move { amount },
            } => am.map_or(
                Some(amount),
                |am| if am == amount { Some(am) } else { None },
            ),

            _ => None,
        }
    }
    //if the node is a move or a change,change its value by the amount passed in. if its not one of these types, no-op
    fn change_amount(&mut self, am: isize) {
        match self.ntype {
            AstNodeKind::Exp {
                kind: Operator::Move { amount: ref mut a },
            }
            | AstNodeKind::Exp {
                kind: Operator::Change { amount: ref mut a },
            } => {
                *a += am;
            }
            _ => {}
        }
    }
    fn is_io(&mut self) -> bool {
        matches!(
            self,
            AstNode {
                id: _,
                ntype: AstNodeKind::Exp {
                    kind: Operator::IO { kind: _ }
                }
            }
        )
    }
    fn is_clear(&mut self) -> bool {
        matches!(
            self,
            AstNode {
                id: _,
                ntype: AstNodeKind::Exp {
                    kind: Operator::Clear {}
                }
            }
        )
    }
    fn is_scan(&mut self) -> bool {
        matches!(
            self,
            AstNode {
                id: _,
                ntype: AstNodeKind::Exp {
                    kind: Operator::Scan { alignment: _ }
                }
            }
        )
    }
    fn is_virt_change(&self, val: Option<(isize, isize)>) -> Option<(isize, isize)> {
        match self.ntype {
            AstNodeKind::Exp {
                kind: Operator::VirtChange { amount, offset },
            } => val.map_or(Some((amount, offset)), |am| {
                if am.0 == amount && am.1 == offset {
                    Some((amount, offset))
                } else {
                    None
                }
            }),

            _ => None,
        }
    }
    /*fn is_mult(&mut self) -> bool {
        matches!(
            self,
            AstNode {
                id: _,
                ntype: AstNodeKind::Exp {
                    kind: Operator::Mult {
                        amount: _,
                        offset: _
                    }
                }
            }
        )
    }*/
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AstNodeKind {
    Loop { exps: Vec<AstNode> },
    Exp { kind: Operator },
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Operator {
    Move {
        amount: isize,
    },
    Change {
        amount: isize,
    },
    IO {
        kind: IOKind,
    },
    Clear,
    Scan {
        alignment: isize,
    },
    VirtChange {
        amount: isize,
        offset: isize,
    },
    //this is a flattened mult loop
    //iters is how many times the loop fires
    //mults is a vec of two-tuples where the first is the multiplicitave factor, second is the offset from dp
    //(amount, offset)
    Mult {
        iters: isize,
        mults: Vec<(isize, isize)>,
    },
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
    program = virtualize_changes(program);
    //run another remove run pass to remove double moves that virt may have created
    //this should be optional?
    program = remove_runs(program);
    program = remove_nops(&mut program).to_vec();
    program = mult_loops(&mut program).to_vec();
    Ok(program)
}

//first pass optimization
//this turns our code into an IR so its no longer "pure" brainfuck code
pub fn remove_runs(mut exprs: Vec<AstNode>) -> Vec<AstNode> {
    //first reverse the vec so we can get our ops in constant time via pop
    exprs.reverse();

    //since we cant really modify in place, instantiate a new vector, and push the modified IR tokens into it in the order we find them
    let mut new_exprs: Vec<AstNode> = Vec::new();

    //since we are looking at tokens two at a time, only iterate while there is more than one token left in the original vec
    while exprs.len() >= 2 {
        //pop the next node to be our cur
        let mut cur = exprs.pop().unwrap();

        //match on what kind of astnode we're currently looking at
        match cur.ntype {
            //if we're looking at an exp node, we might be able to eliminate it by smushing it into the next one
            AstNodeKind::Exp { kind: _ } => {
                //if its a move or a change op, try to smush
                //lets look at the next op to see if we can smush
                let end = exprs.len() - 1;
                let next = &mut exprs[end];

                //the only conditions where we can smush are when this node and the next are both either a change or a move
                if cur.is_change(None).is_some() && next.is_change(None).is_some() {
                    //change the amount of the next node by the amount of the current node
                    next.change_amount(cur.is_change(None).unwrap());
                } else if cur.is_move(None).is_some() && next.is_move(None).is_some() {
                    //change the amount of the next node by the amount of the current node
                    next.change_amount(cur.is_move(None).unwrap());
                } else
                //not a move or change, no smush
                {
                    new_exprs.push(cur);
                }
            }
            //if we're looking at a loop, we need to take a break and recurse to smush all of its values
            AstNodeKind::Loop { exps: ref mut e } => {
                *e = remove_runs(e.to_vec());
                //dont forget to push this loop onto the new vec
                new_exprs.push(cur);
            }
        }
    }

    //if we werent able to smush the last op, make sure we put it into the new_exprs vec
    if exprs.len() > 0 {
        exprs.reverse();
        new_exprs.append(&mut exprs);
    }

    return new_exprs;
}

//this turns any loops which contains only a change operator into an explicit clear op
pub fn clear_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    //iterate over our nodes at this level
    for i in ops.iter_mut() {
        //if we see a loop
        if i.is_loop().is_some() {
            //get its exprs
            let exps = i.is_loop().unwrap();
            //if it's one long and the one op is a change, turn it into a clear instead
            if exps.len() == 1 && exps[0].is_change(None).is_some() {
                *i = AstNode {
                    id: i.id - 1,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::Clear,
                    },
                };
            //since it's not one op long, recurse on it to check for other clear loops
            } else {
                *exps = clear_loops(exps).to_vec();
            }
        }
    }

    //since we have modified in place, return the original
    return ops;
}

//this turns any loop which contains only a move op into an explicit scan op
pub fn scan_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    //lets iterate over all the exps at this level
    for i in ops.iter_mut() {
        //we see a loop
        if i.is_loop().is_some() {
            let exps = i.is_loop().unwrap();
            //if the loop has only one op, and that op is a move, turn it into a scan loop, where the alignment is the change amount
            if exps.len() == 1 && exps[0].is_move(None).is_some() {
                if let AstNode {
                    id: _,
                    ntype:
                        AstNodeKind::Exp {
                            kind: Operator::Move { amount },
                        },
                } = exps[0]
                {
                    *i = AstNode {
                        id: i.id - 1,
                        ntype: AstNodeKind::Exp {
                            kind: Operator::Scan { alignment: amount },
                        },
                    }
                }
            //since the loop is more than one op, check it for scan loops
            } else {
                *exps = scan_loops(exps).to_vec();
            }
        }
    }

    //since we have modified in place, return the original
    return ops;
}

//when we see move-change sequences, we can actually do an offset change for them, followed by a move
//this lets us do serieses of move changes without wasting time moving our poitner more than once
pub fn virtualize_changes(mut ops: Vec<AstNode>) -> Vec<AstNode> {
    let mut new_ops: Vec<AstNode> = Vec::new();

    //we keep the ops as a stack so we can pop one and look at the top to view the next
    ops.reverse();

    let mut virtual_dp: isize = 0;
    //keep trying to virtualize as long as we have more than one node
    while ops.len() > 1 {
        //get our current node
        let mut cur = ops.pop().unwrap();

        //if we have a loop, we need to recurse to catch any virts in that loop
        match cur.ntype {
            //if we see a loop we need to recurse
            AstNodeKind::Loop { exps: ref mut e } => {
                //if we have a non-zero virtual dp, commit to our move before we process the loop
                if virtual_dp != 0 {
                    //push a virtchange, being careful to subtract one from the id,
                    //as loop nodes have the id of their expressions, not the level they are contained in
                    new_ops.push(AstNode {
                        id: cur.id - 1,
                        ntype: AstNodeKind::Exp {
                            kind: Operator::Move { amount: virtual_dp },
                        },
                    });
                    virtual_dp = 0;
                }
                //set the loop body's contents to be the result of the recursion, and then push the loop node
                *e = virtualize_changes(e.to_vec());
                new_ops.push(cur);
            }
            //if we are not looking at a loop, check if we can make a virtual node
            //we can only make virt nodes out of move-change sequences
            _ => {
                //this never panics because we break our loop when there is only one node left
                let end = ops.len() - 1;
                let next = &ops[end];

                //if we can make a virtual node, do it
                if cur.is_move(None).is_some() && next.is_change(None).is_some() {
                    //update our virtual_dp
                    virtual_dp += cur.is_move(None).unwrap();
                    //push a virtual node to our new_ops
                    new_ops.push(AstNode {
                        id: cur.id,
                        ntype: AstNodeKind::Exp {
                            kind: Operator::VirtChange {
                                amount: next.is_change(None).unwrap(),
                                offset: virtual_dp,
                            },
                        },
                    });

                    //pop off the change to get rid of it since we're virtualizing it
                    ops.pop();
                }
                //if we cant make a virtual node, commit our virtual dp, then push the current node
                else {
                    if virtual_dp != 0 {
                        new_ops.push(AstNode {
                            id: cur.id,
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
    }

    //do we need this?
    //if we are finished with this sequence of exps and still have a virtualdp, commit it
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
        new_ops.append(&mut ops);
    }

    return new_ops;
}

//remove any moves or changes by 0
fn remove_nops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    //retain only values which are NOT nops
    ops.retain(|ele| match ele.ntype {
        AstNodeKind::Exp {
            kind: Operator::Move { amount },
        } => amount != 0,
        AstNodeKind::Exp {
            kind: Operator::Change { amount },
        } => amount != 0,
        _ => true,
    });

    //now recurse on any loops we find
    for e in ops.iter_mut() {
        if e.is_loop().is_some() {
            let exps = e.is_loop().unwrap();
            *exps = remove_nops(exps).to_vec();
        }
    }
    //return original since we modified in place
    return ops;
}

//this will not catch all mult behavior, only explicit mult loops
//TODO: can we generalize this?
//mult loops will look like virtual changes with a single change at the beginning or end
//TODO: account for mult loops with non-1 increments
/*fn mult_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
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

    //println!("is a mult loop? {is_mult}");

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
}*/

//we are catching a very specific kind of loop
//if a loop contains only virtchanges and then one normal change(in the first or last index), we can flatten it into a mult op
pub fn mult_loops(ops: &mut Vec<AstNode>) -> &mut Vec<AstNode> {
    //iterate over our nodes at this level
    for i in ops.iter_mut() {
        //if we see a loop
        if i.is_loop().is_some() {
            //get its exprs
            let exps = i.is_loop().unwrap();

            //test if the first and last nodes are change nodes
            let first_change = exps[0].is_change(None).is_some();
            let last_change = exps[exps.len() - 1].is_change(None).is_some();

            //clone our exps for testing purposes
            let mut new_exps = exps.clone();
            //remove whichever node is a change
            if first_change {
                new_exps.remove(0);
            } else if last_change {
                new_exps.pop();
            }
            //once we have remove the change nodes, test if there are any nodes remaining that are non-virtchanges
            let only_virts = !new_exps.iter().any(|e| !e.is_virt_change(None).is_some());

            //if it starts or ends with a change(but not both), and then contains only virtchanges otherwise, turn it into a mult
            if (first_change != last_change) && only_virts {
                println!("found loop: {:?}", exps);
                //first figure out our iter change amount and remove the change node
                let iters = if exps[0].is_change(None).is_some() {
                    exps.remove(0).is_change(None).unwrap()
                } else {
                    exps.pop().unwrap().is_change(None).unwrap()
                };
                println!("iter change am: {}", iters);

                println!("these should all be virtchanges: {:?}", exps);
                //get all of our mults into a nice vec
                let mut mults: Vec<(isize, isize)> = Vec::new();
                for i in exps {
                    let this = i.is_virt_change(None).unwrap();
                    mults.push(this);
                }

                //do the actual flattening of our node
                *i = AstNode {
                    id: i.id - 1,
                    ntype: AstNodeKind::Exp {
                        kind: Operator::Mult { iters, mults },
                    },
                };
                println!("new node: {:?}", i);
                println!();
            //since its not a mult loop, recurse on it to check for mult loops
            } else {
                *exps = clear_loops(exps).to_vec();
            }
        }
    }

    //since we have modified in place, return the original
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

pub fn num_tokens(e: &mut Vec<AstNode>) -> u128 {
    //initialize this level to have cur tokens
    let mut sub_total = 0;
    //iterate over our tokens, recursing if we see a loop
    for i in e.iter_mut() {
        //if we have a loop, recurse and add, otherwise just add one
        match i.is_loop() {
            Some(v) => sub_total += num_tokens(v),
            None => sub_total += 1,
        }
    }

    return sub_total;
}
