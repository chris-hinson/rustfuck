use std::fs;
use std::fs::File;
use std::io::prelude::*;

//this should generate our x86 source code file
pub fn create_x86(name: String) -> Result<String, std::io::Error> {
    let filename = format!("./{}.asm", name);
    let mut f = File::create(filename).unwrap();
    //let write = OpenOptions::new().write(true).open(f);

    write!(f, "{}", gen_header())?;
    write!(f, "{}", gen_code())?;
    write!(f, "{}", gen_exit())?;

    gen_o(name.clone());
    //cleanup(name.clone());
    Ok("sucussfully wrote to asm and generates o file".to_string())
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
fn gen_code() -> String {
    return ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START CODE SECTION;;;;;;;;;;
change 66  ;set addr 0 = B
move_dp 1  ;move to addr 1
change 66  ;set addr 1 = B
move_dp -1 ;move to addr 0
change -1  ;subtract 1
print_char ;print char 0
move_dp 1  ;move right 1
print_char ;print char 1

;loop - copy char to cell 2
;a loop should execute while data[dp] !=0
 mov al,[rbx+r8]
 test al,al       ;sets zf=1 if al =0
 jz loop_bottom   ;jump over loop body if data is 0
loop_top:
        change -1  ;subtract one

        move_dp 1  ;move one right
        change 1   ;add one
        ;print_char ;print the val

        move_dp -1 ;move back to intial cell
 mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
 test al,al     ;set zf=1 if rax & rax =0
 jnz loop_top      ;continue looping if non-zero
loop_bottom:


move_dp 1
change 1
print_char
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END CODE SECTION;;;;;;;;;;;;;;;;;;;;;;;"
.to_string();
}
fn gen_exit() -> String {
    return ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START EPILOGUE;;;;;;;;;;;;;;
;exit with return code 0 once our program has finished executing
        mov rax,60
        mov rdi,0
        syscall    ;exit with return code 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END EPILOGUE;;;;;;;;;;;;;;;;;;;;;;;;;;;"
.to_string();
}

fn gen_o(name: String) {
    let asm_filename = format!("{}.asm", name).to_string();
    //let out_name = format!("{}.o", name);
    nasm_rs::Build::new()
        .file(asm_filename)
        .flag("-f elf64")
        .target("elf64")
        .out_dir("./")
        .compile_objects()
        .unwrap();
}

fn gen_exec() {}

//remove the asm and o file, leaving only the executable
fn cleanup(name: String) {
    let asm_filepath = format!("./{}.asm", name);
    let object_filepath = format!("./{}.o", name);
    fs::remove_file(asm_filepath).unwrap();
    fs::remove_file(object_filepath).unwrap();
}
