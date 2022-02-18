//use owo_colors::OwoColorize;
use std::fmt;
use std::io;
use std::io::Write;

use crate::parser::{AstNode, AstNodeKind, IOKind, Operator};

pub struct Machine {
    dp: usize,
    data: Vec<u8>,
}

impl fmt::Display for Machine {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        //let data_string = format!("{:?}", self.data[0..=self.dp]);
        write!(f, "dp: {}", self.dp)
    }
}

#[derive(Debug)]
#[allow(dead_code)]
pub enum RuntimeErr {
    Fuck,
    How,
}

pub fn exec(v: &Vec<AstNode>, m: &mut Machine) -> Result<String, RuntimeErr> {
    for i in v {
        //println!("looking at node of type: {:?}", i.green());
        //println!("machine looks like: {}", m);

        //always check if we have iterated off the end of the data tape, and extend if we have.
        //Checking before we execute allows all cases to access the data tape without worrying about nullpointering
        //initialize new cells to 0s
        if m.dp >= m.data.len() {
            println!("RESIZING ARRY");
            m.data.resize(m.data.len() + (m.data.len() * 2), 0);
        }

        //match on type of the current node
        match &i.ntype {
            AstNodeKind::Exp { kind } => match kind {
                //we dont let our operator become < 0 or greater than usize::MAX
                Operator::Move { amount } => {
                    //println!("{}", format!("MOVE NODE: {}", amount).green());
                    //print!("dp before: {},", m.dp);
                    if amount > &0 {
                        m.dp = m.dp.saturating_add(amount.abs() as usize);
                    } else {
                        m.dp = m.dp.saturating_sub(amount.abs() as usize);
                    }
                    //println!("dp after: {}", m.dp);
                }
                Operator::Change { amount } => {
                    /*println!(
                        "{}",
                        format!("CHANGE NODE: {}", amount % u8::MAX as isize).red()
                    );
                    print!("value at {} before: {}, ", m.dp, m.data[m.dp]);*/
                    if amount > &0 {
                        m.data[m.dp] =
                            m.data[m.dp].wrapping_add((amount.abs() % u8::MAX as isize) as u8);
                    } else {
                        m.data[m.dp] =
                            m.data[m.dp].wrapping_sub((amount.abs() % u8::MAX as isize) as u8);
                    }
                    //println!("value at {} after: {}", m.dp, m.data[m.dp]);
                }
                Operator::IO { kind } => match kind {
                    //get a single byte of input and put it at data[dp]
                    IOKind::Input => {
                        let mut input = String::new();
                        match io::stdin().read_line(&mut input) {
                            Ok(_n) => {
                                //println!("{} bytes read", n);
                                //println!("{}", input);
                                m.data[m.dp] = input.chars().collect::<Vec<char>>()[0] as u8;
                            }
                            Err(error) => {}
                        }
                    }
                    //output the ascii char at data[dp]
                    IOKind::Output => {
                        /*println!(
                            "{}",
                            format!("OUTPUT NODE: dp:{}, *dp:{}", m.dp, m.data[m.dp]).yellow()
                        );
                        println!("output node: dp = {}, val = {} ", m.dp, m.data[m.dp]);*/
                        //print value at dp as ascii
                        let mut dst = [0; 2];
                        let result = (m.data[m.dp] as char).encode_utf8(&mut dst);
                        print!("{}", result);
                        io::stdout().flush().unwrap();
                    }
                },
                Operator::Clear {} => {
                    m.data[m.dp] = 0;
                }
                Operator::Scan { alignment } => {
                    //scan to the left
                    if alignment < &0 {
                        m.dp -= m.data[0..=m.dp]
                            .iter()
                            //.enumerate()
                            .rev()
                            .step_by(alignment.abs() as usize)
                            .position(|e| {
                                //(m.dp - e.0) % (alignment.abs() as usize) == 0 &&
                                e == &0
                            })
                            .unwrap()
                            * alignment.abs() as usize;
                    }
                    //scan to the right
                    else {
                        m.dp += m.data[m.dp..m.data.len()]
                            .iter()
                            .step_by(alignment.abs() as usize)
                            //.enumerate()
                            .position(|e| {
                                //(e.0 - m.dp) % (alignment.abs() as usize) == 0 &&
                                e == &0
                            })
                            .unwrap()
                            * alignment.abs() as usize
                    }
                }
                Operator::VirtChange { amount, offset } => {
                    if offset < &0 {
                        let index = m.dp.saturating_sub(offset.abs() as usize);
                        if amount < &0 {
                            m.data[index] =
                                m.data[index].wrapping_sub((amount.abs() % u8::MAX as isize) as u8);
                        } else {
                            m.data[index] =
                                m.data[index].wrapping_add((amount.abs() % u8::MAX as isize) as u8);
                        }
                    } else {
                        let index = m.dp.saturating_add(offset.abs() as usize);
                        if amount < &0 {
                            m.data[index] =
                                m.data[index].wrapping_sub((amount.abs() % u8::MAX as isize) as u8);
                        } else {
                            m.data[index] =
                                m.data[index].wrapping_add((amount.abs() % u8::MAX as isize) as u8);
                        }
                    }
                }
                //this is a specialized mult loop, it incurs no overall movement, and always zeros its starting cell
                Operator::Mult { iters, mults } => {
                    //we need to know how many times our mult loop runs
                    //since the loop will run until the value at dp is zero, we need to calculate this based on how much we change the value at dp each time
                    let num_loops = if iters < &0 {
                        //if we are iterating down, this value is the current dp value divided by the iteration amount
                        m.data[m.dp] as isize / iters.abs()
                    } else {
                        //if we are iterating upwards, this value is the difference between the max and the current value, divided by the change amount
                        (u8::MAX - m.data[m.dp]) as isize / iters.abs()
                    };

                    //(amount, offset)
                    for mul in mults {
                        let offset = mul.1;
                        let change_per_loop = mul.0;

                        let total_change = change_per_loop * num_loops;

                        //get the index we will be working at, regardless of which direction it is
                        let index = if offset < 0 {
                            m.dp.saturating_sub(offset.abs() as usize)
                        } else {
                            m.dp.saturating_add(offset.abs() as usize)
                        };

                        //if the change is negative, do a wrapping sub
                        if total_change < 0 {
                            /*m.data[index] = m.data[index]
                            .wrapping_sub((total_change.abs() % u8::MAX as isize) as u8);*/
                            for _i in 0..num_loops {
                                m.data[index] =
                                    m.data[index].wrapping_sub(change_per_loop.abs() as u8);
                            }
                        }
                        //if its positive, do a wrapping add
                        else {
                            /*m.data[index] = m.data[index]
                            .wrapping_add((total_change.abs() % u8::MAX as isize) as u8);*/
                            for _i in 0..num_loops {
                                m.data[index] =
                                    m.data[index].wrapping_add(change_per_loop.abs() as u8);
                            }
                        }
                    }

                    m.data[m.dp] = 0;
                }
            },

            //ONLY run loop if dp is non - zero
            AstNodeKind::Loop { exps } => {
                //println!("MATCHED INTO LOOP ");
                //println!("data at dp = {}", m.data[m.dp]);
                while m.data[m.dp] != 0 {
                    /*println!(
                        "{}",
                        format!("executing loop bc dp is at {}, val: {}", m.dp, m.data[m.dp])
                            .cyan()
                    );*/
                    exec(exps, m)?;
                }
                /*println!(
                    "{}",
                    format!("exiting loop bc dp is at {}, val: {}", m.dp, m.data[m.dp]).cyan()
                );*/
            }
        }
    }

    //println!("tape: {:?}", m.data);
    return Ok("command seq ran successfully".to_owned());
}

pub fn run(p: crate::parser::Program) -> Result<String, RuntimeErr> {
    let mut m = Machine {
        dp: 0,
        //prog: p,
        data: vec![0; 30_000],
    };

    return exec(&p.exps, &mut m);
}
