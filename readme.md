### note: if you are a potential employer, or university staff member, please pretend this repo is named rust-esolang-runner or something similar. Thank you. :)
# Brainfuck compiler (and virtual machine) written in rust
This is an optimizing brainfuck compiler written in rust.  It lexes and parses brainfuck code into an abstract syntax tree, then (optionally) performs a seres of optimizations to turn it into a (*fairly well*) optimized intermediate representation.

From there, the program can either directly run this intermediate representation via the vm emulator contained in runner.rs, or (more interestingly in my opinion) turn it into x86 code for the host machine to run for itself.

## dependencies
This crate uses `nasm` to assemble, and `ld` to link, so both of these programs need to be installed and on path *if you want to compile to x86*.  No external dependencies are required if you just want to run it through the vm.

If you're on windows, give me a while to figure out what is going on with windows syscalls, and how to link object files on that OS. Might work on wsl?

## building 
`cargo build --release` will place the executable at `./target/release/rustfuck`. No external dependencies are required to build the program.

## running
`./rustfuck program_name.bf`
in addition, the following command line flags are provided 

-O0 turns off optimizations

-d prints the ast, and does not run or create an x86 executable

-a creates an the assembly file in the current directory, but does not attempt to compile or run it

-v runs the ast through the vm, rather than compiling to x86

## optimizations

#### run-length encoding:

brainfuck only gives us the ability to move the data pointer or change the value at a cell, one at a time.  This leads to extremely long runs of +,-,<,> which can be simplified to +n,-n,<n,>n where n is a number of repetitions. This is the first optimization pass, and the most impactful one. 

#### loop flattening:

Loops are very expensive in time complexity, and due to brainfucks simple nature, occur extremely often. Thus, we stand to gain significantly from turning loops into a series of iterative operations. We do this in three major passes.

Clear loops - loops of the form `[+]` or `[-]` simply set the value of the cell our data pointer is at to a constant value, 0. 

Scan loops - loops of the form `[<n]` or `[>n]` where n is the length of a run of the character, scan our data tape (to the left or right) to find a cell with the value 0, which is offset from our current data pointer by an amount divisible by n.

Multiplication loops  - this optimizaion pass is not working, I will update this when it is

#### data pointer virtualization

brainfuck moves its data pointer around a lot. Instead of actually doing that and writing it back to memory, instead when we see a move followed by a data change, lets turn it into a data change at some offset from the current data pointer, and just make a note of how much we offset our dp by. Once we come to something thats not a move-change combination, we can "commit" this virtual poitner with a simple move n operation.  

#### nop removal

there are several patterns of brainfuck source that have no effect, including but not limited to : empty loops, moves or changes of amount 0, and loops with no instructions between them. While we usually wont see these patterns in our original source code, some of our optimizations may create them accidentally, so I included an optimization pass to remove them

## results

I pinkie promise I'll update this with some nice graphs and more detailed timings when I get a break from school.
I'm benchmarking against the programs found in this repo https://github.com/matslina/bfoptimization.  

Performance far outpaces any interpreter I've been able to find.  Native x86 execution seems on par with other optimizing compilers, such as bfc. 

## final remarks

This was a fun excersise in writing a compiler. I intentionally chose to avoid handing off my IR to something like llvm, cranelift, or similar standardized IR libraries because I wanted to write my own codegen.  I think I've had enough brainfuck for a lifetime.
