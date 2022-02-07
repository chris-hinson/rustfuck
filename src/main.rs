mod runner;
use std::env;

use std::fs;
fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = format!("../programs/{}", args[1]);
    println!("running {}", filename);

    let debugging = if args.len() > 2 && args[2].eq("d") {
        true
    } else {
        false
    };

    //let filename = "/home/chris/Documents/projects/rustfuck/programs/btest.bf";
    //let filename = "../programs/btest.bf";
    let mut source = fs::read_to_string(filename).expect("Something went wrong reading the file");
    //strip whitespace
    source.retain(|c| !c.is_whitespace());
    //strip and characters that are not valid ops
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
    //println!("{:?}", source.chars().collect::<Vec<char>>());

    match runner::run(&source, debugging) {
        Ok(_v) => {
            println!("program returned successfully")
        }
        Err(e) => {
            println!("program encountered an error: {}", e)
        }
    }
}
