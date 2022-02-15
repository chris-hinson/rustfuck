use owo_colors::OwoColorize;
use std::fmt;
use std::io;
use std::io::Write;

struct Program {
    ip: usize,
    dp: usize,
    prog: Vec<char>,
    data: Vec<u8>,
}

impl fmt::Display for Program {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        //first just print the position of our pointers
        let pointers = format!("ip: {}, dp: {}\n", self.ip, self.dp);
        //lets get a range of 10 around our ip and then the values of that slice of program mem
        let text_seg_bound_lower = if self.prog.len() > 10 {
            if self.ip < 10 {
                0
            } else {
                self.ip - 10
            }
        } else {
            0
        };
        let text_seg_bound_upper = if self.prog.len() > 10 {
            if self.ip > (self.prog.len() - 10) {
                self.prog.len()
            } else {
                self.ip + 10
            }
        } else {
            self.prog.len()
        };
        let text_seg_bounds = text_seg_bound_lower..text_seg_bound_upper;
        let mut text_seg = String::new();
        //text_seg.push_str("starting at index ");
        text_seg.push_str(&format!("{}:", text_seg_bound_lower.red()));
        for i in text_seg_bounds {
            if i.eq(&self.ip) {
                text_seg.push_str(&format!("{}", self.prog[i].green()));
            } else {
                text_seg.push(self.prog[i]);
            }
        }
        text_seg.push_str(&format!(":{}", (text_seg_bound_upper - 1).red()));
        text_seg.push('\n');

        //lets do the same thing for our data segment, but a range of 20
        //let text_seg = format!("text seg looks like: {:?}\n", &self.prog[text_seg_bounds]);
        let data_seg_bound_lower = if self.dp < 10 { 0 } else { self.dp - 10 };
        let data_seg_bound_upper = if self.dp > self.data.len() - 10 {
            self.data.len()
        } else {
            self.dp + 10
        };
        let data_seg_bounds = data_seg_bound_lower..data_seg_bound_upper;
        let mut data_seg = String::new();
        data_seg.push_str(&format!("{}:", data_seg_bound_lower.green()));

        for i in data_seg_bounds {
            if i.eq(&self.dp) {
                data_seg.push_str(&format!("{}", self.data[i].yellow()));
            } else {
                data_seg.push_str(&format!("{}", self.data[i]));
            }
            data_seg.push(',');
        }
        data_seg.push_str(&format!(":{}", (data_seg_bound_upper - 1).green()));

        write!(f, "{}{}{}", pointers, text_seg, data_seg)
    }
}

impl Program {
    #[allow(dead_code)]
    fn new(source: &str) -> Program {
        //turn our source code string into a vector of chars
        let mut prog = source.chars().collect::<Vec<char>>();
        //strip non-valid chars from our source
        prog.retain(|c| {
            c.eq(&'<')
                || c.eq(&'>')
                || c.eq(&'+')
                || c.eq(&'-')
                || c.eq(&'.')
                || c.eq(&',')
                || c.eq(&'[')
                || c.eq(&']')
        });

        return Program {
            ip: 0,
            dp: 0,
            prog: prog,
            //TODO: figure out some way to initialize this to the exact amount we will need
            //can we count every data pointer > and figure out the farthest right we ever go?
            //what about some conditional right? process the AST specially?
            data: vec![0; 30_000],
        };
    }

    //execute one program step
    #[allow(dead_code)]
    fn step(&mut self) -> Result<bool, String> {
        //get the operator at the ip
        let op = self.prog[self.ip];

        //println!("executing op: {}", op);

        //operator should only be a value defined by the ISA
        //our pre-processor should handle this in the future
        match op {
            '>' => {
                //move dp right
                //if we are at the end of our data vec, double its size and fill with 0s
                if self.dp == self.data.len() - 1 {
                    self.data.resize(self.data.len() * 2, 0);
                }
                self.dp += 1;
            }
            '<' => {
                //move dp left

                //if dp is at 0, saturate
                if self.dp != 0 {
                    self.dp -= 1;
                }
            }
            '+' => {
                //incrememnt value at dp
                //self.data[self.dp] += 1;
                /*let add = self.data[self.dp].checked_add(1);
                match add {
                        Some(v) => self.data[self.dp] = v,
                        None => {
                            return Err(format!(
                                "attempted to add beyond the bounds of a u8 at {}",
                                self.dp
                            ));
                        }
                    }*/
                //self.data[self.dp] = self.data[self.dp].wrapping_add(1);
                self.data[self.dp] = self.data[self.dp].saturating_add(1);
            }
            '-' => {
                //decrement value at dp
                /*let sub = self.data[self.dp].checked_sub(1);
                match sub {
                    Some(v) => self.data[self.dp] = v,
                    None => {
                        return Err(format!(
                            "attempted to sub beyond the bounds of a u8 at {}",
                            self.dp
                        ));
                    }
                }*/
                //self.data[self.dp] = self.data[self.dp].wrapping_sub(1);
                self.data[self.dp] = self.data[self.dp].saturating_sub(1);
            }
            '.' => {
                //print value at dp as ascii
                let mut dst = [0; 2];
                let result = (self.data[self.dp] as char).encode_utf8(&mut dst);
                //print!("{},{}", result, self.data[self.dp]);
                print!("{}", result);
                io::stdout().flush().unwrap();
            }
            ',' => {
                //get a single byte of data and store it in the cell dp is pointing at.
                //if more than one byte is provided, we take the 0th byte
                let mut input = String::new();
                match io::stdin().read_line(&mut input) {
                    Ok(_n) => {
                        //println!("{} bytes read", n);
                        //println!("{}", input);
                        self.data[self.dp] = input.chars().collect::<Vec<char>>()[0] as u8;
                    }
                    Err(error) => return Err(format!("error: {}", error)),
                }
            }
            //TODO: make this more efficient using our IR
            //each bracket should also hold data about the index of its corresponding bracket
            //if data at dp is ZERO, jump to instruction immeadiately AFTER corresponding ]
            '[' => {
                if self.data[self.dp] == 0 {
                    //we need a bracket stack to determine where the corresponding bracket is
                    let mut bracket_stack: Vec<char> = Vec::new();
                    bracket_stack.push(self.prog[self.ip]);

                    //after this
                    while bracket_stack.len() != 0 {
                        self.ip += 1;
                        let cur_char = self.prog[self.ip];

                        if cur_char == '[' {
                            bracket_stack.push(cur_char);
                        };
                        //TODO: checking for bracket balance in preprocessor
                        if cur_char == ']' {
                            bracket_stack.pop().unwrap();
                        }
                    }
                    //we want to jump to the instruction AFTER the corresponding ]
                    //self.ip += 1;
                }
            }
            //if data at dp is NON-ZERO, jump to instruction immeadiately BEFORE corresponding [
            ']' => {
                if self.data[self.dp] != 0 {
                    //we need a bracket stack to determine where the corresponding bracket is
                    let mut bracket_stack: Vec<char> = Vec::new();
                    bracket_stack.push(self.prog[self.ip]);

                    //after this
                    while bracket_stack.len() != 0 {
                        self.ip -= 1;
                        let cur_char = self.prog[self.ip];

                        if cur_char == ']' {
                            bracket_stack.push(cur_char);
                        };
                        //TODO: checking for bracket balance in preprocessor
                        if cur_char == '[' {
                            bracket_stack.pop().unwrap();
                        }
                    }
                    //we want to jump to the instruction AFTER the corresponding ]
                    //self.ip -= 1;
                }
            }
            _ =>
            //panic!("found bad op at index: {}, val is {}", self.ip, op),
            {
                return Err(format!("found bad op at index: {}, val is {}", self.ip, op));
            }
        }

        //if we have at least one more op, increase our ip and return still running
        if self.ip < self.prog.len() - 1 {
            self.ip += 1;
            return Ok(true);
        } else {
            //if we have executed our last instruction, return done running
            return Ok(false);
        }
    }
}

//runs some given source code, return a result of whether any runtime errors were encountered
#[allow(dead_code)]
pub fn run(source: &str, debugging: bool) -> Result<bool, String> {
    let mut prg = Program::new(source);

    loop {
        //show up the program state if debugging is enabled, and wait for us to press a key to continue execution
        if debugging {
            println!("{}", prg);
            println!("press any key to continue executing...");
            let mut line = String::new();
            let _b1 = std::io::stdin().read_line(&mut line).unwrap();
        }

        //execute one step of our program
        let step_res = prg.step();

        //keep running if there's more instructions, if we have encountered an error, propogate it to parent function
        match step_res {
            Ok(v) => {
                if v == false {
                    return Ok(true);
                }
            }
            Err(e) => {
                return Err(e);
            }
        }
    }
}
