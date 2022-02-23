use crate::parser::{AstNode, AstNodeKind, Operator};
use std::fs;
use std::fs::File;
use std::io::prelude::*;
use std::process::Command;
///////////////////////////////////////Error enum and structs and impls////////////////////////////
#[derive(Debug)]
pub enum CodegenErr {
    AsmGenErr(String),
    NasmErr(String),
    LinkErr(String),
}
impl From<std::io::Error> for CodegenErr {
    fn from(err: std::io::Error) -> Self {
        CodegenErr::AsmGenErr(err.to_string())
    }
}
impl From<NasmErr> for CodegenErr {
    fn from(err: NasmErr) -> Self {
        CodegenErr::NasmErr(err.err_string)
    }
}
impl From<LinkErr> for CodegenErr {
    fn from(err: LinkErr) -> Self {
        CodegenErr::LinkErr(err.err_string)
    }
}

//assembling stage error struct
struct NasmErr {
    err_string: String,
}
impl From<String> for NasmErr {
    fn from(err: String) -> Self {
        NasmErr { err_string: err }
    }
}

//linking stage error struct
struct LinkErr {
    err_string: String,
}
impl From<String> for LinkErr {
    fn from(err: String) -> Self {
        LinkErr { err_string: err }
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////

//this should generate our x86 executable file
pub fn create_x86(name: String, prg: Vec<crate::parser::AstNode>) -> Result<String, CodegenErr> {
    let filename = format!("{}.asm", name);
    let mut f = File::create(&filename).unwrap();

    let mut loop_counter: u128 = 0;
    write!(f, "{}", gen_header())?;
    let mut code_buf = String::new();
    gen_code(prg, &mut code_buf, &mut loop_counter);
    write!(f, "{}", code_buf)?;
    write!(f, "{}", gen_exit())?;

    let o_path = gen_o(&filename)?;
    //println!("after assembling, filename is: {o_path}");
    let executable = gen_exec(o_path)?;
    //println!("after linking, filename is: {executable}");

    //cleanup(name.clone());

    return Ok(executable);
}

fn gen_header() -> String {
    return ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START PROLOGUE ;;;;;;;;;;;;;;;;;;;;;;;
global _start
section .bss
        data_tape: resb 30000
        ;note- we do not keep our dp in memory to save the cycles it would take to load it
section .text

;input macro
%macro get_char 0
%endmacro

;output macro
%macro  print_char 0
        mov     rbx, data_tape
        mov     rax, 1             ;sys_write call number
        mov     rdi, 1             ; write to stdout (fd=1)
        lea     rsi, [rbx + r8]   ; use char at current dp
        mov     rdx , 1            ; write 1 char
        syscall
%endmacro

;move macro
%macro move_dp 1
        add r8 ,%1
%endmacro

;changeval macro
%macro change 1
        mov rbx,data_tape
        mov al,[rbx+r8]
        add al,%1
        mov [rbx+r8],al
%endmacro

;loop macro?

_start:

;intialize our globals
;should probably be in memory, but we will keep them in regs to avoid the clock cycles to load them
;r8  will ALWAYS be our dp - nothing else should touch it
mov r8,0
;rbx should always be our data tape base address (ok if we lose it bc we can just load it back)
mov rbx,data_tape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END PROLOUGUE;;;;;;;;;;;;;;;;;;;;"
.to_string();
}
fn gen_code(
    ast: Vec<crate::parser::AstNode>,
    code_buf: &mut String,
    global_loop_counter: &mut u128,
) {
    let mut local_loop_counter = 0;

    for instruction in ast {
        match instruction.ntype {
            AstNodeKind::Exp { kind } => match kind {
                Operator::Move { amount } => code_buf.push_str(&format!("\nmove_dp {}", amount)),
                Operator::Change { amount } => code_buf.push_str(&format!("\nchange {}", amount)),
                Operator::IO { kind } => match kind {
                    crate::parser::IOKind::Output => code_buf.push_str("\nprint_char"),
                    crate::parser::IOKind::Input => {
                        code_buf.push_str("\n;get_char not yet implemented")
                    }
                },
                Operator::Clear => code_buf.push_str("\n;clear not yet implemented"),
                Operator::Scan { alignment } => code_buf.push_str(&format!(
                    "\n;scan not yet implemented-> alignment: {}",
                    alignment
                )),
                Operator::VirtChange { amount, offset } => code_buf.push_str(&format!(
                    "\n;virtchange not yet implemented-> amount: {}, offset: {}",
                    amount, offset
                )),
                Operator::Mult { iters, mults } => code_buf.push_str(&format!(
                    "\n;mult not yet implemented-> iters: {}, mults: {:?}",
                    iters, mults
                )),
            },
            AstNodeKind::Loop { exps } => {
                let level = &exps[0].clone().id;
                let cur_global_counter = *global_loop_counter;
                code_buf.push_str(&format!(
                    "\nmov al,[rbx+r8]
                     test al,al       ;sets zf=1 if al =0
                     jz loop_bottom_{}_{}_{}   ;jump over loop body if data is 0
                    loop_top_{}_{}_{}:\n ",
                    level,
                    local_loop_counter,
                    cur_global_counter,
                    level,
                    local_loop_counter,
                    cur_global_counter
                ));
                gen_code(exps, code_buf, global_loop_counter);
                code_buf.push_str(&format!(
                    " \n
                     mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
                     test al,al     ;set zf=1 if rax & rax =0
                     jnz loop_top_{}_{}_{}      ;continue looping if non-zero
                    loop_bottom_{}_{}_{}:\n",
                    level,
                    local_loop_counter,
                    cur_global_counter,
                    level,
                    local_loop_counter,
                    cur_global_counter
                ));

                local_loop_counter += 1;
                *global_loop_counter += 1;
            }
        }
    }
}
fn gen_exit() -> String {
    return "\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START EPILOGUE;;;;;;;;;;;;;;
;exit with return code 0 once our program has finished executing
        mov rax,60
        mov rdi,0
        syscall    ;exit with return code 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END EPILOGUE;;;;;;;;;;;;;;;;;;;;;;;;;;;"
.to_string();
}

//Ok(String) = string path of object file
//Err(String) = error string of what went wrong attempting to invoke nasm
fn gen_o(asm_filename: &str) -> Result<String, NasmErr> {
    let nasm_res = nasm_rs::Build::new()
        .file(asm_filename)
        .flag("-f elf64")
        .target("elf64")
        .out_dir("")
        .compile_objects();

    match nasm_res {
        Ok(v) => {
            println!("nasm compiled successfully -> {:?}", v);
            return Ok(v[0].to_str().unwrap().to_owned());
        }
        Err(e) => {
            return Err(NasmErr {
                err_string:
                    "nasm could not compile the generated asm file. Is it installed and on PATH?"
                        .to_string(),
            })
        }
    };
}

//returns
//Ok(String) = path to executable file generated
//Err(String) = Error message about what went wrong attempting to link
fn gen_exec(o_path_filename: String) -> Result<String, LinkErr> {
    let raw_name = o_path_filename.split(".").nth(0).unwrap();
    //println!("raw name is {raw_name}");

    match Command::new("ld")
        .arg("-o")
        .arg(raw_name)
        .arg(o_path_filename.clone())
        //.spawn()
        .status()
    {
        Ok(v) => {
            println!("finished linking -> output to : {}", raw_name);
            return Ok(raw_name.to_owned());
        }
        Err(e) => {
            return Err(LinkErr {
                err_string: "something went wrong executing ld. Is it installed and on PATH?"
                    .to_string(),
            })
        }
    }
}

//remove the asm and o file, leaving only the executable
fn cleanup(name: String) {
    let asm_filepath = format!("./{}.asm", name);
    let object_filepath = format!("./{}.o", name);
    println!(
        "in cleanup\nasm_filepath: {}\nobject_filepath: {}",
        asm_filepath, object_filepath
    );
    fs::remove_file(asm_filepath).unwrap();
    fs::remove_file(object_filepath).unwrap();
}
