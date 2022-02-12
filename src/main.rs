mod lexer;
mod parser;
mod runner;
mod runner_naive;
use std::env;

//for profiling
use std::time::{Duration, Instant};

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
    let tokenized = match lexer::lex(&source) {
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
    let exps = match parser::parse(tokenized, 0) {
        Ok(v) => v,
        Err(e) => {
            println!("Error while parsing input file: {}", e);
            return;
        }
    };

    let prg = parser::Program::new(exps);
    //parser::print_ast(prg.clone());
    ///////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////running - naive/////////////////////////////////////////////
    let start_naive = Instant::now();
    match runner_naive::run(&source, debugging) {
        Ok(_v) => {
            println!("\n program returned successfully")
        }
        Err(e) => {
            println!("\n program encountered an error: {}", e)
        }
    }
    let duration_naive = start_naive.elapsed().as_millis();
    ///////////////////////////////////////////////////////////////////////////////////////////////

    let start_optimized = Instant::now();
    match runner::run(prg) {
        Ok(v) => {
            println!("\n\n{v}");
        }
        Err(e) => {
            println!("Program encountered runtime error: {:?}", e);
        }
    }
    let duration_optimized = start_optimized.elapsed().as_millis();

    println!("program took {} ms to run naively", duration_naive);
    println!(
        "program took {} ms to run with run-length compression optimization",
        duration_optimized
    );
}
