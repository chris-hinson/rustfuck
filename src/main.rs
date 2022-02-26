mod codegen;
mod lexer;
mod parser;
mod runner;
mod runner_naive;
mod tests;
use std::env;
use std::fs;
use std::time::Instant;

fn main() {
    //////////////////////////////encironment program setup////////////////////////////////////////
    let args: Vec<String> = env::args().collect();

    //dont run if we dont get a filename
    if args.len() < 2 {
        print_help();
        return;
    }

    //let filename = format!("./programs/{}", args[1]);
    let filename = &args[1];
    println!("running {}", filename);

    //if debugging is enabled, print our ast
    let debugging = args.contains(&"d".to_string());

    //optimization is only on or off
    let optimizing = !args.contains(&"O0".to_string());

    //dump to asm only, no compile, no run
    let dump_asm = args.contains(&"a".to_string());

    //vm runner
    let vm_run = args.contains(&"v".to_string());

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
            println!("Error while lexing: {}", e);
            return;
        }
    };
    ///////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////parsing////////////////////////////////////////////////////////
    let exps = match parser::parse(tokenized, 0) {
        Ok(v) => v,
        Err(e) => {
            println!("Error while parsing: {}", e);
            return;
        }
    };

    //generate our ast
    let mut prg = if optimizing {
        let e_optimized = parser::optimize(exps);
        parser::Program::new(e_optimized)
    } else {
        parser::Program::new(exps)
    };

    //print the ast and # of tokens if we have passed the flag to do so
    if debugging {
        parser::print_ast(prg.clone());
        println!(
            "there are {} tokens in our ast",
            parser::num_tokens(&mut prg.exps)
        );
    }
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
    if vm_run {
        let start_optimized = Instant::now();
        match runner::run(prg) {
            Ok(v) => {
                println!("\n\n{v}: took {} ms", start_optimized.elapsed().as_millis());
            }
            Err(e) => {
                println!("Program encountered runtime error: {:?}", e);
            }
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    else {
        let bf_prg_name = args[1]
            .split("/")
            .last()
            .unwrap()
            .split(".")
            .nth(0)
            .unwrap();

        match codegen::create_x86(bf_prg_name.to_string(), prg.exps) {
            Ok(v) => {
                println!("program executable created: {v}")
            }
            Err(e) => {
                println!("there was an error creating our executable: {:?}", e)
            }
        }
    }
}

//call this function anytime we get a malformed call
fn print_help() {
    println!("usage: ./bf source_file\n
    -O0 turns off optimizations

    -d prints the ast, and does not run or create an x86 executable

    -a creates an the assembly file in the current directory, but does not attempt to compile or run it

    -v runs the ast through the vm, rather than compiling to x86 " );
}
