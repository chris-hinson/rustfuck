mod lexer;
mod parser;
mod runner;
use std::env;

use std::fs;
fn main() {
    //////////////////////////////encironment program setup////////////////////////////////////////
    let args: Vec<String> = env::args().collect();
    //let filename = format!("../programs/{}", args[1]);
    let filename = format!("./programs/{}", args[1]);
    println!("running {}", filename);

    let debugging = if args.len() > 2 && args[2].eq("d") {
        true
    } else {
        false
    };

    //read in our sourcecode from a file
    let source = match fs::read_to_string(filename) {
        Ok(v) => v,
        Err(_e) => {
            println!("that file does not exist. Exiting without running");
            return;
        }
    };
    ///////////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////lexing//////////////////////////////////////////////////////
    let mut tokenized = match lexer::lex(&source) {
        Ok(v) => v,
        Err(e) => {
            println!("ran into an error while lexing: {}", e);
            return;
        }
    };
    //println!("tokenized: {:?}", tokenized);
    //println!("{} tokens", tokenized.len());
    ///////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////parsing////////////////////////////////////////////////////////
    let ast = match parser::parse(tokenized) {
        Ok(v) => v,
        Err(e) => {
            println!("Error while parsing input file: {}", e);
            return;
        }
    };
    ///////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////running/////////////////////////////////////////////////////
    /*match runner::run(&source, debugging) {
        Ok(_v) => {
            println!("program returned successfully")
        }
        Err(e) => {
            println!("program encountered an error: {}", e)
        }
    }*/
    ///////////////////////////////////////////////////////////////////////////////////////////////
}
