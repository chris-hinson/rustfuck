mod lexer;
mod parser;
mod runner;
mod runner_naive;
use std::env;

//for profiling
use std::time::Instant;

use std::fs;
fn main() {
    //////////////////////////////encironment program setup////////////////////////////////////////
    let args: Vec<String> = env::args().collect();

    //dont run if we dont get a filename
    if args.len() < 2 {
        print_help();
        return;
    }

    let filename = format!("./programs/{}", args[1]);
    println!("running {}", filename);

    //TODO: implement debugging mode in our VM runner
    let _debugging = if args.len() > 2 && args[2].eq("d") {
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

    let mut prg = parser::Program::new(exps);
    parser::print_ast(prg.clone());
    println!(
        "there are {} tokens in our ast",
        parser::num_tokens(&mut prg.exps)
    );
    ///////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////running - naive/////////////////////////////////////////////
    /*let start_naive = Instant::now();
    match runner_naive::run(&source, debugging) {
        Ok(_v) => {
            println!("\n program returned successfully")
        }
        Err(e) => {
            println!("\n program encountered an error: {}", e)
        }
    }
    let duration_naive = start_naive.elapsed().as_millis();*/
    ///////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////////////
    let start_optimized = Instant::now();
    match runner::run(prg) {
        Ok(v) => {
            println!("\n\n{v}: took {} ms", start_optimized.elapsed().as_millis());
        }
        Err(e) => {
            println!("Program encountered runtime error: {:?}", e);
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////

    /*println!("program took {} ms to run naively", duration_naive);
    println!(
        "program took {} ms to run with run-length compression optimization",
        duration_optimized
    );*/
}

//call this function anytime we get a malformed call
fn print_help() {
    println!("usage: ./bf source_file");
}
