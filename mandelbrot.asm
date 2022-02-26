;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START PROLOGUE ;;;;;;;;;;;;;;;;;;;;;;;
global _start
section .bss
        data_tape: resb 30000
        ;note- we do not keep our dp in memory to save the cycles it would take to load it
section .text

;input macro
%macro get_char 0
        mov rbx, data_tape
        mov rax, 0                ;syscall 0 - read
        mov rdi, 0                ;read from stdin (fd = 0)
        lea rsi, [rbx + r8]       ;put the char at our dp location on data tape
        mov rdx, 1                ;we want to read exactly one character
        syscall                   ;make the syscall
%endmacro

;output macro
%macro  print_char 0
        mov     rbx, data_tape
        mov     rax, 1             ;sys_write call number
        mov     rdi, 1             ;write to stdout (fd=1)
        lea     rsi, [rbx + r8]    ;use char at current dp
        mov     rdx , 1            ;write 1 char
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END PROLOUGUE;;;;;;;;;;;;;;;;;;;;
change 13

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_1_0   ;jump over loop body if data is 0
loop_top_1_1_0:
 
change -1
move_dp 1
change 2
move_dp 3
change 5
move_dp 1
change 2
move_dp 1
change 1
move_dp -6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_1_0      ;continue looping if non-zero
loop_bottom_1_1_0:

move_dp 5
change 6
move_dp 1
change -3
move_dp 10
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_2_1   ;jump over loop body if data is 0
loop_top_2_2_1:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_1_2   ;jump over loop body if data is 0
loop_top_2_1_2:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_1_2      ;continue looping if non-zero
loop_bottom_2_1_2:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_2_3   ;jump over loop body if data is 0
loop_top_2_2_3:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_2_3      ;continue looping if non-zero
loop_bottom_2_2_3:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_2_1      ;continue looping if non-zero
loop_bottom_2_2_1:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_3_4   ;jump over loop body if data is 0
loop_top_1_3_4:
 
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_1_5   ;jump over loop body if data is 0
loop_top_2_1_5:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_1_5      ;continue looping if non-zero
loop_bottom_2_1_5:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_3_4      ;continue looping if non-zero
loop_bottom_1_3_4:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_4_6   ;jump over loop body if data is 0
loop_top_1_4_6:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_4_6      ;continue looping if non-zero
loop_bottom_1_4_6:

move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_5_7   ;jump over loop body if data is 0
loop_top_1_5_7:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_5_7      ;continue looping if non-zero
loop_bottom_1_5_7:

change 1
move_dp -7
change 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_6_8   ;jump over loop body if data is 0
loop_top_1_6_8:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_1_9   ;jump over loop body if data is 0
loop_top_2_1_9:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_1_9      ;continue looping if non-zero
loop_bottom_2_1_9:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_6_8      ;continue looping if non-zero
loop_bottom_1_6_8:

move_dp 7
change 1
move_dp 27
change 1
move_dp -17

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_7_10   ;jump over loop body if data is 0
loop_top_1_7_10:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_7_10      ;continue looping if non-zero
loop_bottom_1_7_10:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_8_11   ;jump over loop body if data is 0
loop_top_1_8_11:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_8_11      ;continue looping if non-zero
loop_bottom_1_8_11:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_1_9_12   ;jump over loop body if data is 0
loop_top_1_9_12:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_1_13   ;jump over loop body if data is 0
loop_top_2_1_13:
 
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_14   ;jump over loop body if data is 0
loop_top_3_1_14:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_14      ;continue looping if non-zero
loop_bottom_3_1_14:

move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_1_13      ;continue looping if non-zero
loop_bottom_2_1_13:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_2_15   ;jump over loop body if data is 0
loop_top_2_2_15:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_2_15      ;continue looping if non-zero
loop_bottom_2_2_15:

move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_3_16   ;jump over loop body if data is 0
loop_top_2_3_16:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_3_16      ;continue looping if non-zero
loop_bottom_2_3_16:

change 1
move_dp -6
change 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_4_17   ;jump over loop body if data is 0
loop_top_2_4_17:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_18   ;jump over loop body if data is 0
loop_top_3_1_18:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_18      ;continue looping if non-zero
loop_bottom_3_1_18:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_4_17      ;continue looping if non-zero
loop_bottom_2_4_17:

move_dp 6
change 1
move_dp -6
change 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_5_19   ;jump over loop body if data is 0
loop_top_2_5_19:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_20   ;jump over loop body if data is 0
loop_top_3_1_20:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_20      ;continue looping if non-zero
loop_bottom_3_1_20:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_5_19      ;continue looping if non-zero
loop_bottom_2_5_19:

move_dp 6
change 1
move_dp -16

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_6_21   ;jump over loop body if data is 0
loop_top_2_6_21:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_6_21      ;continue looping if non-zero
loop_bottom_2_6_21:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_7_22   ;jump over loop body if data is 0
loop_top_3_7_22:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_23   ;jump over loop body if data is 0
loop_top_3_1_23:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_23      ;continue looping if non-zero
loop_bottom_3_1_23:

move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_2_24   ;jump over loop body if data is 0
loop_top_3_2_24:
 
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_25   ;jump over loop body if data is 0
loop_top_4_1_25:
 
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_25      ;continue looping if non-zero
loop_bottom_4_1_25:

move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_26   ;jump over loop body if data is 0
loop_top_4_2_26:
 
change -1
move_dp 6
change 1
move_dp -2
change 1
move_dp -3
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_26      ;continue looping if non-zero
loop_bottom_4_2_26:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_2_24      ;continue looping if non-zero
loop_bottom_3_2_24:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_3_27   ;jump over loop body if data is 0
loop_top_3_3_27:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_3_27      ;continue looping if non-zero
loop_bottom_3_3_27:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_4_28   ;jump over loop body if data is 0
loop_top_3_4_28:
 
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_29   ;jump over loop body if data is 0
loop_top_4_1_29:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_29      ;continue looping if non-zero
loop_bottom_4_1_29:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_30   ;jump over loop body if data is 0
loop_top_4_2_30:
 
change -1
move_dp 7
change 1
move_dp -2
change 1
move_dp -3
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_30      ;continue looping if non-zero
loop_bottom_4_2_30:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_4_28      ;continue looping if non-zero
loop_bottom_3_4_28:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_5_31   ;jump over loop body if data is 0
loop_top_3_5_31:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_5_31      ;continue looping if non-zero
loop_bottom_3_5_31:

move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_6_32   ;jump over loop body if data is 0
loop_top_3_6_32:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_6_32      ;continue looping if non-zero
loop_bottom_3_6_32:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_7_33   ;jump over loop body if data is 0
loop_top_3_7_33:
 
change -1
move_dp 7
change 1
move_dp -2
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_7_33      ;continue looping if non-zero
loop_bottom_3_7_33:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_8_34   ;jump over loop body if data is 0
loop_top_4_8_34:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_35   ;jump over loop body if data is 0
loop_top_4_1_35:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_35      ;continue looping if non-zero
loop_bottom_4_1_35:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_36   ;jump over loop body if data is 0
loop_top_4_2_36:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_36      ;continue looping if non-zero
loop_bottom_4_2_36:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_37   ;jump over loop body if data is 0
loop_top_4_3_37:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_37      ;continue looping if non-zero
loop_bottom_4_3_37:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_38   ;jump over loop body if data is 0
loop_top_4_4_38:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_38      ;continue looping if non-zero
loop_bottom_4_4_38:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_39   ;jump over loop body if data is 0
loop_top_4_5_39:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_39      ;continue looping if non-zero
loop_bottom_4_5_39:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_6_40   ;jump over loop body if data is 0
loop_top_4_6_40:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_6_40      ;continue looping if non-zero
loop_bottom_4_6_40:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_7_41   ;jump over loop body if data is 0
loop_top_4_7_41:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_7_41      ;continue looping if non-zero
loop_bottom_4_7_41:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_8_42   ;jump over loop body if data is 0
loop_top_4_8_42:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_8_42      ;continue looping if non-zero
loop_bottom_4_8_42:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_9_43   ;jump over loop body if data is 0
loop_top_4_9_43:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_9_43      ;continue looping if non-zero
loop_bottom_4_9_43:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_10_44   ;jump over loop body if data is 0
loop_top_4_10_44:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_10_44      ;continue looping if non-zero
loop_bottom_4_10_44:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_11_45   ;jump over loop body if data is 0
loop_top_4_11_45:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_11_45      ;continue looping if non-zero
loop_bottom_4_11_45:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_8_34      ;continue looping if non-zero
loop_bottom_4_8_34:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_9_46   ;jump over loop body if data is 0
loop_top_3_9_46:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_9_46      ;continue looping if non-zero
loop_bottom_3_9_46:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_10_47   ;jump over loop body if data is 0
loop_top_3_10_47:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_10_47      ;continue looping if non-zero
loop_bottom_3_10_47:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_11_48   ;jump over loop body if data is 0
loop_top_3_11_48:
 
move_dp 1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_49   ;jump over loop body if data is 0
loop_top_4_1_49:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_49      ;continue looping if non-zero
loop_bottom_4_1_49:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_50   ;jump over loop body if data is 0
loop_top_4_2_50:
 
change -1
move_dp 4
change 1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_51   ;jump over loop body if data is 0
loop_top_5_1_51:
 
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_52   ;jump over loop body if data is 0
loop_top_6_1_52:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_52      ;continue looping if non-zero
loop_bottom_6_1_52:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_53   ;jump over loop body if data is 0
loop_top_6_2_53:
 
change -1
move_dp 2
change 1
move_dp 2
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_53      ;continue looping if non-zero
loop_bottom_6_2_53:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_51      ;continue looping if non-zero
loop_bottom_5_1_51:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_54   ;jump over loop body if data is 0
loop_top_5_2_54:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_54      ;continue looping if non-zero
loop_bottom_5_2_54:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_50      ;continue looping if non-zero
loop_bottom_4_2_50:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_55   ;jump over loop body if data is 0
loop_top_4_3_55:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_55      ;continue looping if non-zero
loop_bottom_4_3_55:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_56   ;jump over loop body if data is 0
loop_top_4_4_56:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_57   ;jump over loop body if data is 0
loop_top_5_1_57:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_57      ;continue looping if non-zero
loop_bottom_5_1_57:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_56      ;continue looping if non-zero
loop_bottom_4_4_56:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_58   ;jump over loop body if data is 0
loop_top_4_5_58:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_58      ;continue looping if non-zero
loop_bottom_4_5_58:

move_dp -1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_11_48      ;continue looping if non-zero
loop_bottom_3_11_48:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_12_59   ;jump over loop body if data is 0
loop_top_3_12_59:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_60   ;jump over loop body if data is 0
loop_top_4_1_60:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_60      ;continue looping if non-zero
loop_bottom_4_1_60:

move_dp -1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_61   ;jump over loop body if data is 0
loop_top_4_2_61:
 
change -1
move_dp -4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_62   ;jump over loop body if data is 0
loop_top_5_1_62:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_62      ;continue looping if non-zero
loop_bottom_5_1_62:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_63   ;jump over loop body if data is 0
loop_top_5_2_63:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_63      ;continue looping if non-zero
loop_bottom_5_2_63:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_61      ;continue looping if non-zero
loop_bottom_4_2_61:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_64   ;jump over loop body if data is 0
loop_top_4_3_64:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_64      ;continue looping if non-zero
loop_bottom_4_3_64:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_12_59      ;continue looping if non-zero
loop_bottom_3_12_59:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_13_65   ;jump over loop body if data is 0
loop_top_3_13_65:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_13_65      ;continue looping if non-zero
loop_bottom_3_13_65:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_14_66   ;jump over loop body if data is 0
loop_top_3_14_66:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_14_66      ;continue looping if non-zero
loop_bottom_3_14_66:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_15_67   ;jump over loop body if data is 0
loop_top_3_15_67:
 
move_dp 1
change -1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_68   ;jump over loop body if data is 0
loop_top_4_1_68:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_68      ;continue looping if non-zero
loop_bottom_4_1_68:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_69   ;jump over loop body if data is 0
loop_top_4_2_69:
 
change -1
move_dp 5
change 1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_70   ;jump over loop body if data is 0
loop_top_5_1_70:
 
change -1
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_71   ;jump over loop body if data is 0
loop_top_6_1_71:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_71      ;continue looping if non-zero
loop_bottom_6_1_71:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_72   ;jump over loop body if data is 0
loop_top_6_2_72:
 
change -1
move_dp 3
change 1
move_dp 1
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_72      ;continue looping if non-zero
loop_bottom_6_2_72:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_70      ;continue looping if non-zero
loop_bottom_5_1_70:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_73   ;jump over loop body if data is 0
loop_top_5_2_73:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_73      ;continue looping if non-zero
loop_bottom_5_2_73:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_69      ;continue looping if non-zero
loop_bottom_4_2_69:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_74   ;jump over loop body if data is 0
loop_top_4_3_74:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_74      ;continue looping if non-zero
loop_bottom_4_3_74:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_75   ;jump over loop body if data is 0
loop_top_4_4_75:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_76   ;jump over loop body if data is 0
loop_top_5_1_76:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_76      ;continue looping if non-zero
loop_bottom_5_1_76:

move_dp -11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_75      ;continue looping if non-zero
loop_bottom_4_4_75:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_77   ;jump over loop body if data is 0
loop_top_4_5_77:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_77      ;continue looping if non-zero
loop_bottom_4_5_77:

move_dp -2
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_15_67      ;continue looping if non-zero
loop_bottom_3_15_67:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_16_78   ;jump over loop body if data is 0
loop_top_3_16_78:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_79   ;jump over loop body if data is 0
loop_top_4_1_79:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_79      ;continue looping if non-zero
loop_bottom_4_1_79:

move_dp -1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_80   ;jump over loop body if data is 0
loop_top_4_2_80:
 
change -1
move_dp -4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_81   ;jump over loop body if data is 0
loop_top_5_1_81:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_81      ;continue looping if non-zero
loop_bottom_5_1_81:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_82   ;jump over loop body if data is 0
loop_top_5_2_82:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_82      ;continue looping if non-zero
loop_bottom_5_2_82:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_80      ;continue looping if non-zero
loop_bottom_4_2_80:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_83   ;jump over loop body if data is 0
loop_top_4_3_83:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_83      ;continue looping if non-zero
loop_bottom_4_3_83:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_16_78      ;continue looping if non-zero
loop_bottom_3_16_78:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_17_84   ;jump over loop body if data is 0
loop_top_3_17_84:
 
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_85   ;jump over loop body if data is 0
loop_top_4_1_85:
 
change -1
move_dp -36
change 1
move_dp 36

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_85      ;continue looping if non-zero
loop_bottom_4_1_85:

move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_17_84      ;continue looping if non-zero
loop_bottom_3_17_84:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_18_86   ;jump over loop body if data is 0
loop_top_3_18_86:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_18_86      ;continue looping if non-zero
loop_bottom_3_18_86:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_19_87   ;jump over loop body if data is 0
loop_top_4_19_87:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_88   ;jump over loop body if data is 0
loop_top_4_1_88:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_88      ;continue looping if non-zero
loop_bottom_4_1_88:

move_dp -9
change -1
move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_89   ;jump over loop body if data is 0
loop_top_4_2_89:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_89      ;continue looping if non-zero
loop_bottom_4_2_89:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_19_87      ;continue looping if non-zero
loop_bottom_4_19_87:

change 1
move_dp 21
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_20_90   ;jump over loop body if data is 0
loop_top_3_20_90:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_20_90      ;continue looping if non-zero
loop_bottom_3_20_90:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_21_91   ;jump over loop body if data is 0
loop_top_3_21_91:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_92   ;jump over loop body if data is 0
loop_top_4_1_92:
 
change -1
move_dp -3
change -1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_92      ;continue looping if non-zero
loop_bottom_4_1_92:

change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_93   ;jump over loop body if data is 0
loop_top_4_2_93:
 
change -1
move_dp 3
change -1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_94   ;jump over loop body if data is 0
loop_top_5_1_94:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_94      ;continue looping if non-zero
loop_bottom_5_1_94:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_95   ;jump over loop body if data is 0
loop_top_5_2_95:
 
change -1
move_dp 4
change 1
move_dp -13

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_96   ;jump over loop body if data is 0
loop_top_6_1_96:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_96      ;continue looping if non-zero
loop_bottom_6_1_96:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_97   ;jump over loop body if data is 0
loop_top_6_2_97:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_97      ;continue looping if non-zero
loop_bottom_6_2_97:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_98   ;jump over loop body if data is 0
loop_top_6_3_98:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_98      ;continue looping if non-zero
loop_bottom_6_3_98:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_95      ;continue looping if non-zero
loop_bottom_5_2_95:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_93      ;continue looping if non-zero
loop_bottom_4_2_93:

change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_99   ;jump over loop body if data is 0
loop_top_4_3_99:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_99      ;continue looping if non-zero
loop_bottom_4_3_99:

change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_100   ;jump over loop body if data is 0
loop_top_4_4_100:
 
change -1
move_dp 4
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_101   ;jump over loop body if data is 0
loop_top_5_1_101:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_101      ;continue looping if non-zero
loop_bottom_5_1_101:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_102   ;jump over loop body if data is 0
loop_top_5_2_102:
 
change -1
move_dp 3
change 1
move_dp -12

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_103   ;jump over loop body if data is 0
loop_top_6_1_103:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_103      ;continue looping if non-zero
loop_bottom_6_1_103:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_104   ;jump over loop body if data is 0
loop_top_6_2_104:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_104      ;continue looping if non-zero
loop_bottom_6_2_104:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_105   ;jump over loop body if data is 0
loop_top_6_3_105:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_105      ;continue looping if non-zero
loop_bottom_6_3_105:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_4_106   ;jump over loop body if data is 0
loop_top_6_4_106:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_4_106      ;continue looping if non-zero
loop_bottom_6_4_106:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_102      ;continue looping if non-zero
loop_bottom_5_2_102:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_100      ;continue looping if non-zero
loop_bottom_4_4_100:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_107   ;jump over loop body if data is 0
loop_top_4_5_107:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_108   ;jump over loop body if data is 0
loop_top_5_1_108:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_108      ;continue looping if non-zero
loop_bottom_5_1_108:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_107      ;continue looping if non-zero
loop_bottom_4_5_107:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_21_91      ;continue looping if non-zero
loop_bottom_3_21_91:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_22_109   ;jump over loop body if data is 0
loop_top_3_22_109:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_22_109      ;continue looping if non-zero
loop_bottom_3_22_109:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_23_110   ;jump over loop body if data is 0
loop_top_3_23_110:
 
change -1
move_dp 1
change 1
move_dp 3
change -1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_23_110      ;continue looping if non-zero
loop_bottom_3_23_110:

move_dp 9
change 26
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_24_111   ;jump over loop body if data is 0
loop_top_3_24_111:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_24_111      ;continue looping if non-zero
loop_bottom_3_24_111:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_25_112   ;jump over loop body if data is 0
loop_top_3_25_112:
 
change -1
move_dp 4
change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_113   ;jump over loop body if data is 0
loop_top_4_1_113:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_113      ;continue looping if non-zero
loop_bottom_4_1_113:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_25_112      ;continue looping if non-zero
loop_bottom_3_25_112:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_26_114   ;jump over loop body if data is 0
loop_top_3_26_114:
 
move_dp -7
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_115   ;jump over loop body if data is 0
loop_top_4_1_115:
 
change -1
move_dp -1
change 1
move_dp 4
change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_116   ;jump over loop body if data is 0
loop_top_5_1_116:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_116      ;continue looping if non-zero
loop_bottom_5_1_116:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_115      ;continue looping if non-zero
loop_bottom_4_1_115:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_117   ;jump over loop body if data is 0
loop_top_4_2_117:
 
change -1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_118   ;jump over loop body if data is 0
loop_top_5_1_118:
 
change -1
move_dp 1
change 1
move_dp 3
change -1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_118      ;continue looping if non-zero
loop_bottom_5_1_118:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_117      ;continue looping if non-zero
loop_bottom_4_2_117:

move_dp 13

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_119   ;jump over loop body if data is 0
loop_top_4_3_119:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_120   ;jump over loop body if data is 0
loop_top_5_1_120:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_120      ;continue looping if non-zero
loop_bottom_5_1_120:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_121   ;jump over loop body if data is 0
loop_top_5_2_121:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_121      ;continue looping if non-zero
loop_bottom_5_2_121:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_122   ;jump over loop body if data is 0
loop_top_5_3_122:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_122      ;continue looping if non-zero
loop_bottom_5_3_122:

move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_119      ;continue looping if non-zero
loop_bottom_4_3_119:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_123   ;jump over loop body if data is 0
loop_top_4_4_123:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_123      ;continue looping if non-zero
loop_bottom_4_4_123:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_124   ;jump over loop body if data is 0
loop_top_4_5_124:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_124      ;continue looping if non-zero
loop_bottom_4_5_124:

move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_6_125   ;jump over loop body if data is 0
loop_top_4_6_125:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_126   ;jump over loop body if data is 0
loop_top_5_1_126:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_126      ;continue looping if non-zero
loop_bottom_5_1_126:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_127   ;jump over loop body if data is 0
loop_top_5_2_127:
 
change -1
move_dp 4
change 1
move_dp -3
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_127      ;continue looping if non-zero
loop_bottom_5_2_127:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_6_125      ;continue looping if non-zero
loop_bottom_4_6_125:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_7_128   ;jump over loop body if data is 0
loop_top_4_7_128:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_7_128      ;continue looping if non-zero
loop_bottom_4_7_128:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_8_129   ;jump over loop body if data is 0
loop_top_4_8_129:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_130   ;jump over loop body if data is 0
loop_top_5_1_130:
 
change -1
move_dp -9
change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_130      ;continue looping if non-zero
loop_bottom_5_1_130:

move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_8_129      ;continue looping if non-zero
loop_bottom_4_8_129:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_9_131   ;jump over loop body if data is 0
loop_top_4_9_131:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_9_131      ;continue looping if non-zero
loop_bottom_4_9_131:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_10_132   ;jump over loop body if data is 0
loop_top_5_10_132:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_133   ;jump over loop body if data is 0
loop_top_5_1_133:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_133      ;continue looping if non-zero
loop_bottom_5_1_133:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_134   ;jump over loop body if data is 0
loop_top_5_2_134:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_134      ;continue looping if non-zero
loop_bottom_5_2_134:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_135   ;jump over loop body if data is 0
loop_top_5_3_135:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_135      ;continue looping if non-zero
loop_bottom_5_3_135:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_136   ;jump over loop body if data is 0
loop_top_5_4_136:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_136      ;continue looping if non-zero
loop_bottom_5_4_136:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_137   ;jump over loop body if data is 0
loop_top_5_5_137:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_137      ;continue looping if non-zero
loop_bottom_5_5_137:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_6_138   ;jump over loop body if data is 0
loop_top_5_6_138:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_6_138      ;continue looping if non-zero
loop_bottom_5_6_138:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_7_139   ;jump over loop body if data is 0
loop_top_5_7_139:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_7_139      ;continue looping if non-zero
loop_bottom_5_7_139:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_8_140   ;jump over loop body if data is 0
loop_top_5_8_140:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_8_140      ;continue looping if non-zero
loop_bottom_5_8_140:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_9_141   ;jump over loop body if data is 0
loop_top_5_9_141:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_9_141      ;continue looping if non-zero
loop_bottom_5_9_141:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_10_142   ;jump over loop body if data is 0
loop_top_5_10_142:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_10_142      ;continue looping if non-zero
loop_bottom_5_10_142:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_11_143   ;jump over loop body if data is 0
loop_top_5_11_143:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_11_143      ;continue looping if non-zero
loop_bottom_5_11_143:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_10_132      ;continue looping if non-zero
loop_bottom_5_10_132:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_11_144   ;jump over loop body if data is 0
loop_top_4_11_144:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_11_144      ;continue looping if non-zero
loop_bottom_4_11_144:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_12_145   ;jump over loop body if data is 0
loop_top_4_12_145:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_12_145      ;continue looping if non-zero
loop_bottom_4_12_145:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_13_146   ;jump over loop body if data is 0
loop_top_4_13_146:
 
move_dp 1
change -1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_147   ;jump over loop body if data is 0
loop_top_5_1_147:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_147      ;continue looping if non-zero
loop_bottom_5_1_147:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_148   ;jump over loop body if data is 0
loop_top_5_2_148:
 
change -1
move_dp 5
change 1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_149   ;jump over loop body if data is 0
loop_top_6_1_149:
 
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_150   ;jump over loop body if data is 0
loop_top_7_1_150:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_150      ;continue looping if non-zero
loop_bottom_7_1_150:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_151   ;jump over loop body if data is 0
loop_top_7_2_151:
 
change -1
move_dp 2
change 1
move_dp 1
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_151      ;continue looping if non-zero
loop_bottom_7_2_151:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_149      ;continue looping if non-zero
loop_bottom_6_1_149:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_152   ;jump over loop body if data is 0
loop_top_6_2_152:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_152      ;continue looping if non-zero
loop_bottom_6_2_152:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_148      ;continue looping if non-zero
loop_bottom_5_2_148:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_153   ;jump over loop body if data is 0
loop_top_5_3_153:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_153      ;continue looping if non-zero
loop_bottom_5_3_153:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_154   ;jump over loop body if data is 0
loop_top_5_4_154:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_155   ;jump over loop body if data is 0
loop_top_6_1_155:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_155      ;continue looping if non-zero
loop_bottom_6_1_155:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_154      ;continue looping if non-zero
loop_bottom_5_4_154:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_156   ;jump over loop body if data is 0
loop_top_5_5_156:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_156      ;continue looping if non-zero
loop_bottom_5_5_156:

move_dp -1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_13_146      ;continue looping if non-zero
loop_bottom_4_13_146:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_14_157   ;jump over loop body if data is 0
loop_top_4_14_157:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_158   ;jump over loop body if data is 0
loop_top_5_1_158:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_158      ;continue looping if non-zero
loop_bottom_5_1_158:

move_dp -1
change -1
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_159   ;jump over loop body if data is 0
loop_top_5_2_159:
 
change -1
move_dp -3
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_160   ;jump over loop body if data is 0
loop_top_6_1_160:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_160      ;continue looping if non-zero
loop_bottom_6_1_160:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_161   ;jump over loop body if data is 0
loop_top_6_2_161:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_161      ;continue looping if non-zero
loop_bottom_6_2_161:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_159      ;continue looping if non-zero
loop_bottom_5_2_159:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_162   ;jump over loop body if data is 0
loop_top_5_3_162:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_162      ;continue looping if non-zero
loop_bottom_5_3_162:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_14_157      ;continue looping if non-zero
loop_bottom_4_14_157:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_15_163   ;jump over loop body if data is 0
loop_top_4_15_163:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_164   ;jump over loop body if data is 0
loop_top_5_1_164:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_164      ;continue looping if non-zero
loop_bottom_5_1_164:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_165   ;jump over loop body if data is 0
loop_top_5_2_165:
 
change -1
move_dp 5
change 1
move_dp -4
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_165      ;continue looping if non-zero
loop_bottom_5_2_165:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_15_163      ;continue looping if non-zero
loop_bottom_4_15_163:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_16_166   ;jump over loop body if data is 0
loop_top_4_16_166:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_16_166      ;continue looping if non-zero
loop_bottom_4_16_166:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_17_167   ;jump over loop body if data is 0
loop_top_4_17_167:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_17_167      ;continue looping if non-zero
loop_bottom_4_17_167:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_18_168   ;jump over loop body if data is 0
loop_top_4_18_168:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_18_168      ;continue looping if non-zero
loop_bottom_4_18_168:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_19_169   ;jump over loop body if data is 0
loop_top_4_19_169:
 
move_dp 1
change -1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_170   ;jump over loop body if data is 0
loop_top_5_1_170:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_170      ;continue looping if non-zero
loop_bottom_5_1_170:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_171   ;jump over loop body if data is 0
loop_top_5_2_171:
 
change -1
move_dp 5
change 1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_172   ;jump over loop body if data is 0
loop_top_6_1_172:
 
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_173   ;jump over loop body if data is 0
loop_top_7_1_173:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_173      ;continue looping if non-zero
loop_bottom_7_1_173:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_174   ;jump over loop body if data is 0
loop_top_7_2_174:
 
change -1
move_dp 2
change 1
move_dp 2
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_174      ;continue looping if non-zero
loop_bottom_7_2_174:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_172      ;continue looping if non-zero
loop_bottom_6_1_172:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_175   ;jump over loop body if data is 0
loop_top_6_2_175:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_175      ;continue looping if non-zero
loop_bottom_6_2_175:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_171      ;continue looping if non-zero
loop_bottom_5_2_171:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_176   ;jump over loop body if data is 0
loop_top_5_3_176:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_176      ;continue looping if non-zero
loop_bottom_5_3_176:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_177   ;jump over loop body if data is 0
loop_top_5_4_177:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_178   ;jump over loop body if data is 0
loop_top_6_1_178:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_178      ;continue looping if non-zero
loop_bottom_6_1_178:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_177      ;continue looping if non-zero
loop_bottom_5_4_177:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_179   ;jump over loop body if data is 0
loop_top_5_5_179:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_179      ;continue looping if non-zero
loop_bottom_5_5_179:

move_dp -1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_19_169      ;continue looping if non-zero
loop_bottom_4_19_169:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_20_180   ;jump over loop body if data is 0
loop_top_4_20_180:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_181   ;jump over loop body if data is 0
loop_top_5_1_181:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_181      ;continue looping if non-zero
loop_bottom_5_1_181:

move_dp -1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_182   ;jump over loop body if data is 0
loop_top_5_2_182:
 
change -1
move_dp -4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_183   ;jump over loop body if data is 0
loop_top_6_1_183:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_183      ;continue looping if non-zero
loop_bottom_6_1_183:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_184   ;jump over loop body if data is 0
loop_top_6_2_184:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_184      ;continue looping if non-zero
loop_bottom_6_2_184:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_182      ;continue looping if non-zero
loop_bottom_5_2_182:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_185   ;jump over loop body if data is 0
loop_top_5_3_185:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_185      ;continue looping if non-zero
loop_bottom_5_3_185:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_20_180      ;continue looping if non-zero
loop_bottom_4_20_180:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_21_186   ;jump over loop body if data is 0
loop_top_4_21_186:
 
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_187   ;jump over loop body if data is 0
loop_top_5_1_187:
 
change -1
move_dp -36
change 1
move_dp 36

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_187      ;continue looping if non-zero
loop_bottom_5_1_187:

move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_21_186      ;continue looping if non-zero
loop_bottom_4_21_186:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_22_188   ;jump over loop body if data is 0
loop_top_4_22_188:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_22_188      ;continue looping if non-zero
loop_bottom_4_22_188:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_23_189   ;jump over loop body if data is 0
loop_top_4_23_189:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_190   ;jump over loop body if data is 0
loop_top_5_1_190:
 
change -1
move_dp -36
change 1
move_dp 36

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_190      ;continue looping if non-zero
loop_bottom_5_1_190:

move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_23_189      ;continue looping if non-zero
loop_bottom_4_23_189:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_24_191   ;jump over loop body if data is 0
loop_top_4_24_191:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_24_191      ;continue looping if non-zero
loop_bottom_4_24_191:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_25_192   ;jump over loop body if data is 0
loop_top_5_25_192:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_193   ;jump over loop body if data is 0
loop_top_5_1_193:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_193      ;continue looping if non-zero
loop_bottom_5_1_193:

move_dp -9
change -1
move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_194   ;jump over loop body if data is 0
loop_top_5_2_194:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_194      ;continue looping if non-zero
loop_bottom_5_2_194:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_25_192      ;continue looping if non-zero
loop_bottom_5_25_192:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_26_195   ;jump over loop body if data is 0
loop_top_4_26_195:
 
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_196   ;jump over loop body if data is 0
loop_top_5_1_196:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_196      ;continue looping if non-zero
loop_bottom_5_1_196:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_197   ;jump over loop body if data is 0
loop_top_5_2_197:
 
change -1
move_dp 7
change 1
move_dp -6
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_197      ;continue looping if non-zero
loop_bottom_5_2_197:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_26_195      ;continue looping if non-zero
loop_bottom_4_26_195:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_27_198   ;jump over loop body if data is 0
loop_top_4_27_198:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_27_198      ;continue looping if non-zero
loop_bottom_4_27_198:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_28_199   ;jump over loop body if data is 0
loop_top_4_28_199:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_200   ;jump over loop body if data is 0
loop_top_5_1_200:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_200      ;continue looping if non-zero
loop_bottom_5_1_200:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_28_199      ;continue looping if non-zero
loop_bottom_4_28_199:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_29_201   ;jump over loop body if data is 0
loop_top_4_29_201:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_29_201      ;continue looping if non-zero
loop_bottom_4_29_201:

move_dp 4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_30_202   ;jump over loop body if data is 0
loop_top_4_30_202:
 
change -1
move_dp -1
change -1
move_dp -4
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_30_202      ;continue looping if non-zero
loop_bottom_4_30_202:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_31_203   ;jump over loop body if data is 0
loop_top_4_31_203:
 
change -1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_204   ;jump over loop body if data is 0
loop_top_5_1_204:
 
change -1
move_dp 5
change 1
move_dp -1
change 2
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_204      ;continue looping if non-zero
loop_bottom_5_1_204:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_205   ;jump over loop body if data is 0
loop_top_5_2_205:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_205      ;continue looping if non-zero
loop_bottom_5_2_205:

move_dp -1
change -1
move_dp 1
change 1
move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_31_203      ;continue looping if non-zero
loop_bottom_4_31_203:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_32_206   ;jump over loop body if data is 0
loop_top_4_32_206:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_32_206      ;continue looping if non-zero
loop_bottom_4_32_206:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_33_207   ;jump over loop body if data is 0
loop_top_4_33_207:
 
change -1
move_dp 5
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_33_207      ;continue looping if non-zero
loop_bottom_4_33_207:

move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_34_208   ;jump over loop body if data is 0
loop_top_4_34_208:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_34_208      ;continue looping if non-zero
loop_bottom_4_34_208:

move_dp -6
change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_35_209   ;jump over loop body if data is 0
loop_top_4_35_209:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_35_209      ;continue looping if non-zero
loop_bottom_4_35_209:

change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_36_210   ;jump over loop body if data is 0
loop_top_4_36_210:
 
change -1
move_dp 4
change -1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_211   ;jump over loop body if data is 0
loop_top_5_1_211:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_212   ;jump over loop body if data is 0
loop_top_6_1_212:
 
change -1
move_dp -2
change -1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_212      ;continue looping if non-zero
loop_bottom_6_1_212:

change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_213   ;jump over loop body if data is 0
loop_top_6_2_213:
 
change -1
move_dp 2
change -1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_214   ;jump over loop body if data is 0
loop_top_7_1_214:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_214      ;continue looping if non-zero
loop_bottom_7_1_214:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_215   ;jump over loop body if data is 0
loop_top_7_2_215:
 
change -1
move_dp 3
change 1
move_dp -12

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_216   ;jump over loop body if data is 0
loop_top_8_1_216:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_216      ;continue looping if non-zero
loop_bottom_8_1_216:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_217   ;jump over loop body if data is 0
loop_top_8_2_217:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_217      ;continue looping if non-zero
loop_bottom_8_2_217:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_3_218   ;jump over loop body if data is 0
loop_top_8_3_218:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_3_218      ;continue looping if non-zero
loop_bottom_8_3_218:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_215      ;continue looping if non-zero
loop_bottom_7_2_215:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_213      ;continue looping if non-zero
loop_bottom_6_2_213:

change 1
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_219   ;jump over loop body if data is 0
loop_top_6_3_219:
 
change -1
move_dp -3
change -1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_219      ;continue looping if non-zero
loop_bottom_6_3_219:

change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_4_220   ;jump over loop body if data is 0
loop_top_6_4_220:
 
change -1
move_dp 3
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_221   ;jump over loop body if data is 0
loop_top_7_1_221:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_221      ;continue looping if non-zero
loop_bottom_7_1_221:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_222   ;jump over loop body if data is 0
loop_top_7_2_222:
 
change -1
move_dp 2
change 1
move_dp -11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_223   ;jump over loop body if data is 0
loop_top_8_1_223:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_223      ;continue looping if non-zero
loop_bottom_8_1_223:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_224   ;jump over loop body if data is 0
loop_top_8_2_224:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_224      ;continue looping if non-zero
loop_bottom_8_2_224:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_3_225   ;jump over loop body if data is 0
loop_top_8_3_225:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_3_225      ;continue looping if non-zero
loop_bottom_8_3_225:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_4_226   ;jump over loop body if data is 0
loop_top_8_4_226:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_4_226      ;continue looping if non-zero
loop_bottom_8_4_226:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_222      ;continue looping if non-zero
loop_bottom_7_2_222:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_4_220      ;continue looping if non-zero
loop_bottom_6_4_220:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_5_227   ;jump over loop body if data is 0
loop_top_6_5_227:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_228   ;jump over loop body if data is 0
loop_top_7_1_228:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_228      ;continue looping if non-zero
loop_bottom_7_1_228:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_5_227      ;continue looping if non-zero
loop_bottom_6_5_227:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_211      ;continue looping if non-zero
loop_bottom_5_1_211:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_229   ;jump over loop body if data is 0
loop_top_5_2_229:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_229      ;continue looping if non-zero
loop_bottom_5_2_229:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_230   ;jump over loop body if data is 0
loop_top_5_3_230:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_230      ;continue looping if non-zero
loop_bottom_5_3_230:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_231   ;jump over loop body if data is 0
loop_top_5_4_231:
 
change -1
move_dp 4
change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_232   ;jump over loop body if data is 0
loop_top_6_1_232:
 
move_dp 1
change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_233   ;jump over loop body if data is 0
loop_top_7_1_233:
 
change -1
move_dp -2
change -1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_233      ;continue looping if non-zero
loop_bottom_7_1_233:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_234   ;jump over loop body if data is 0
loop_top_7_2_234:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_234      ;continue looping if non-zero
loop_bottom_7_2_234:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_232      ;continue looping if non-zero
loop_bottom_6_1_232:

move_dp -8
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_235   ;jump over loop body if data is 0
loop_top_6_2_235:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_236   ;jump over loop body if data is 0
loop_top_7_1_236:
 
change -1
move_dp 5
change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_237   ;jump over loop body if data is 0
loop_top_8_1_237:
 
change -1
move_dp 4
change -1
move_dp -14
change 1
move_dp 11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_9_1_238   ;jump over loop body if data is 0
loop_top_9_1_238:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_9_1_238      ;continue looping if non-zero
loop_bottom_9_1_238:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_237      ;continue looping if non-zero
loop_bottom_8_1_237:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_239   ;jump over loop body if data is 0
loop_top_8_2_239:
 
change -1
move_dp 3
change -1
move_dp -14
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_239      ;continue looping if non-zero
loop_bottom_8_2_239:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_236      ;continue looping if non-zero
loop_bottom_7_1_236:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_240   ;jump over loop body if data is 0
loop_top_7_2_240:
 
change -1
move_dp 4
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_241   ;jump over loop body if data is 0
loop_top_8_1_241:
 
change -1
move_dp 3
change -1
move_dp -14
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_241      ;continue looping if non-zero
loop_bottom_8_1_241:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_240      ;continue looping if non-zero
loop_bottom_7_2_240:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_242   ;jump over loop body if data is 0
loop_top_7_3_242:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_242      ;continue looping if non-zero
loop_bottom_7_3_242:

move_dp -12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_235      ;continue looping if non-zero
loop_bottom_6_2_235:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_243   ;jump over loop body if data is 0
loop_top_6_3_243:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_243      ;continue looping if non-zero
loop_bottom_6_3_243:

move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_231      ;continue looping if non-zero
loop_bottom_5_4_231:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_244   ;jump over loop body if data is 0
loop_top_5_5_244:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_244      ;continue looping if non-zero
loop_bottom_5_5_244:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_6_245   ;jump over loop body if data is 0
loop_top_5_6_245:
 
change -1
move_dp 3
change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_246   ;jump over loop body if data is 0
loop_top_6_1_246:
 
move_dp 1
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_247   ;jump over loop body if data is 0
loop_top_7_1_247:
 
change -1
move_dp -1
change -1
move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_247      ;continue looping if non-zero
loop_bottom_7_1_247:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_248   ;jump over loop body if data is 0
loop_top_7_2_248:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_248      ;continue looping if non-zero
loop_bottom_7_2_248:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_246      ;continue looping if non-zero
loop_bottom_6_1_246:

move_dp -8
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_249   ;jump over loop body if data is 0
loop_top_6_2_249:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_250   ;jump over loop body if data is 0
loop_top_7_1_250:
 
change -1
move_dp 5
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_251   ;jump over loop body if data is 0
loop_top_8_1_251:
 
change -1
move_dp 3
change -1
move_dp -14
change 1
move_dp 10

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_9_1_252   ;jump over loop body if data is 0
loop_top_9_1_252:
 
change -1
move_dp 4
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_9_1_252      ;continue looping if non-zero
loop_bottom_9_1_252:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_251      ;continue looping if non-zero
loop_bottom_8_1_251:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_253   ;jump over loop body if data is 0
loop_top_8_2_253:
 
change -1
move_dp 4
change -1
move_dp -14
change 1
move_dp 10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_253      ;continue looping if non-zero
loop_bottom_8_2_253:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_250      ;continue looping if non-zero
loop_bottom_7_1_250:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_254   ;jump over loop body if data is 0
loop_top_7_2_254:
 
change -1
move_dp 3
change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_255   ;jump over loop body if data is 0
loop_top_8_1_255:
 
change -1
move_dp 4
change -1
move_dp -14
change 1
move_dp 10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_255      ;continue looping if non-zero
loop_bottom_8_1_255:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_254      ;continue looping if non-zero
loop_bottom_7_2_254:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_256   ;jump over loop body if data is 0
loop_top_7_3_256:
 
change -1
move_dp 4
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_256      ;continue looping if non-zero
loop_bottom_7_3_256:

move_dp -11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_249      ;continue looping if non-zero
loop_bottom_6_2_249:

move_dp 6
change 1
move_dp -6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_6_245      ;continue looping if non-zero
loop_bottom_5_6_245:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_36_210      ;continue looping if non-zero
loop_bottom_4_36_210:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_37_257   ;jump over loop body if data is 0
loop_top_4_37_257:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_37_257      ;continue looping if non-zero
loop_bottom_4_37_257:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_38_258   ;jump over loop body if data is 0
loop_top_4_38_258:
 
change -1
move_dp 4
change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_259   ;jump over loop body if data is 0
loop_top_5_1_259:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_259      ;continue looping if non-zero
loop_bottom_5_1_259:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_260   ;jump over loop body if data is 0
loop_top_5_2_260:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_261   ;jump over loop body if data is 0
loop_top_6_1_261:
 
change -1
move_dp 5
change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_262   ;jump over loop body if data is 0
loop_top_7_1_262:
 
change -1
move_dp 4
change -1
move_dp -14
change 1
move_dp 11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_263   ;jump over loop body if data is 0
loop_top_8_1_263:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_263      ;continue looping if non-zero
loop_bottom_8_1_263:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_262      ;continue looping if non-zero
loop_bottom_7_1_262:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_264   ;jump over loop body if data is 0
loop_top_7_2_264:
 
change -1
move_dp 3
change -1
move_dp -14
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_264      ;continue looping if non-zero
loop_bottom_7_2_264:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_261      ;continue looping if non-zero
loop_bottom_6_1_261:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_265   ;jump over loop body if data is 0
loop_top_6_2_265:
 
change -1
move_dp 4
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_266   ;jump over loop body if data is 0
loop_top_7_1_266:
 
change -1
move_dp 3
change -1
move_dp -14
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_266      ;continue looping if non-zero
loop_bottom_7_1_266:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_265      ;continue looping if non-zero
loop_bottom_6_2_265:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_267   ;jump over loop body if data is 0
loop_top_6_3_267:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_267      ;continue looping if non-zero
loop_bottom_6_3_267:

move_dp -12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_260      ;continue looping if non-zero
loop_bottom_5_2_260:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_38_258      ;continue looping if non-zero
loop_bottom_4_38_258:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_39_268   ;jump over loop body if data is 0
loop_top_4_39_268:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_39_268      ;continue looping if non-zero
loop_bottom_4_39_268:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_40_269   ;jump over loop body if data is 0
loop_top_4_40_269:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_40_269      ;continue looping if non-zero
loop_bottom_4_40_269:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_41_270   ;jump over loop body if data is 0
loop_top_4_41_270:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_41_270      ;continue looping if non-zero
loop_bottom_4_41_270:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_42_271   ;jump over loop body if data is 0
loop_top_4_42_271:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_272   ;jump over loop body if data is 0
loop_top_5_1_272:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_272      ;continue looping if non-zero
loop_bottom_5_1_272:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_273   ;jump over loop body if data is 0
loop_top_5_2_273:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_273      ;continue looping if non-zero
loop_bottom_5_2_273:

move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_42_271      ;continue looping if non-zero
loop_bottom_4_42_271:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_43_274   ;jump over loop body if data is 0
loop_top_4_43_274:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_43_274      ;continue looping if non-zero
loop_bottom_4_43_274:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_44_275   ;jump over loop body if data is 0
loop_top_4_44_275:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_276   ;jump over loop body if data is 0
loop_top_5_1_276:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_276      ;continue looping if non-zero
loop_bottom_5_1_276:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_277   ;jump over loop body if data is 0
loop_top_5_2_277:
 
change -1
move_dp 4
change 1
move_dp -3
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_277      ;continue looping if non-zero
loop_bottom_5_2_277:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_44_275      ;continue looping if non-zero
loop_bottom_4_44_275:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_45_278   ;jump over loop body if data is 0
loop_top_4_45_278:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_45_278      ;continue looping if non-zero
loop_bottom_4_45_278:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_46_279   ;jump over loop body if data is 0
loop_top_5_46_279:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_280   ;jump over loop body if data is 0
loop_top_5_1_280:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_280      ;continue looping if non-zero
loop_bottom_5_1_280:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_281   ;jump over loop body if data is 0
loop_top_5_2_281:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_281      ;continue looping if non-zero
loop_bottom_5_2_281:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_282   ;jump over loop body if data is 0
loop_top_5_3_282:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_282      ;continue looping if non-zero
loop_bottom_5_3_282:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_283   ;jump over loop body if data is 0
loop_top_5_4_283:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_283      ;continue looping if non-zero
loop_bottom_5_4_283:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_284   ;jump over loop body if data is 0
loop_top_5_5_284:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_284      ;continue looping if non-zero
loop_bottom_5_5_284:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_6_285   ;jump over loop body if data is 0
loop_top_5_6_285:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_6_285      ;continue looping if non-zero
loop_bottom_5_6_285:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_7_286   ;jump over loop body if data is 0
loop_top_5_7_286:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_7_286      ;continue looping if non-zero
loop_bottom_5_7_286:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_8_287   ;jump over loop body if data is 0
loop_top_5_8_287:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_8_287      ;continue looping if non-zero
loop_bottom_5_8_287:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_9_288   ;jump over loop body if data is 0
loop_top_5_9_288:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_9_288      ;continue looping if non-zero
loop_bottom_5_9_288:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_10_289   ;jump over loop body if data is 0
loop_top_5_10_289:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_10_289      ;continue looping if non-zero
loop_bottom_5_10_289:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_11_290   ;jump over loop body if data is 0
loop_top_5_11_290:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_11_290      ;continue looping if non-zero
loop_bottom_5_11_290:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_46_279      ;continue looping if non-zero
loop_bottom_5_46_279:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_47_291   ;jump over loop body if data is 0
loop_top_4_47_291:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_47_291      ;continue looping if non-zero
loop_bottom_4_47_291:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_48_292   ;jump over loop body if data is 0
loop_top_4_48_292:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_48_292      ;continue looping if non-zero
loop_bottom_4_48_292:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_49_293   ;jump over loop body if data is 0
loop_top_4_49_293:
 
move_dp 1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_294   ;jump over loop body if data is 0
loop_top_5_1_294:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_294      ;continue looping if non-zero
loop_bottom_5_1_294:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_295   ;jump over loop body if data is 0
loop_top_5_2_295:
 
change -1
move_dp 4
change 1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_296   ;jump over loop body if data is 0
loop_top_6_1_296:
 
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_297   ;jump over loop body if data is 0
loop_top_7_1_297:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_297      ;continue looping if non-zero
loop_bottom_7_1_297:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_298   ;jump over loop body if data is 0
loop_top_7_2_298:
 
change -1
move_dp 2
change 1
move_dp 1
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_298      ;continue looping if non-zero
loop_bottom_7_2_298:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_296      ;continue looping if non-zero
loop_bottom_6_1_296:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_299   ;jump over loop body if data is 0
loop_top_6_2_299:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_299      ;continue looping if non-zero
loop_bottom_6_2_299:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_295      ;continue looping if non-zero
loop_bottom_5_2_295:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_300   ;jump over loop body if data is 0
loop_top_5_3_300:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_300      ;continue looping if non-zero
loop_bottom_5_3_300:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_301   ;jump over loop body if data is 0
loop_top_5_4_301:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_302   ;jump over loop body if data is 0
loop_top_6_1_302:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_302      ;continue looping if non-zero
loop_bottom_6_1_302:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_301      ;continue looping if non-zero
loop_bottom_5_4_301:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_303   ;jump over loop body if data is 0
loop_top_5_5_303:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_303      ;continue looping if non-zero
loop_bottom_5_5_303:

move_dp -1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_49_293      ;continue looping if non-zero
loop_bottom_4_49_293:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_50_304   ;jump over loop body if data is 0
loop_top_4_50_304:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_305   ;jump over loop body if data is 0
loop_top_5_1_305:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_305      ;continue looping if non-zero
loop_bottom_5_1_305:

move_dp -1
change -1
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_306   ;jump over loop body if data is 0
loop_top_5_2_306:
 
change -1
move_dp -3
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_307   ;jump over loop body if data is 0
loop_top_6_1_307:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_307      ;continue looping if non-zero
loop_bottom_6_1_307:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_308   ;jump over loop body if data is 0
loop_top_6_2_308:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_308      ;continue looping if non-zero
loop_bottom_6_2_308:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_306      ;continue looping if non-zero
loop_bottom_5_2_306:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_309   ;jump over loop body if data is 0
loop_top_5_3_309:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_309      ;continue looping if non-zero
loop_bottom_5_3_309:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_50_304      ;continue looping if non-zero
loop_bottom_4_50_304:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_51_310   ;jump over loop body if data is 0
loop_top_4_51_310:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_311   ;jump over loop body if data is 0
loop_top_5_1_311:
 
change -1
move_dp -36
change 1
move_dp 36

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_311      ;continue looping if non-zero
loop_bottom_5_1_311:

move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_51_310      ;continue looping if non-zero
loop_bottom_4_51_310:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_52_312   ;jump over loop body if data is 0
loop_top_4_52_312:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_52_312      ;continue looping if non-zero
loop_bottom_4_52_312:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_53_313   ;jump over loop body if data is 0
loop_top_4_53_313:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_53_313      ;continue looping if non-zero
loop_bottom_4_53_313:

move_dp 4
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_54_314   ;jump over loop body if data is 0
loop_top_5_54_314:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_315   ;jump over loop body if data is 0
loop_top_5_1_315:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_315      ;continue looping if non-zero
loop_bottom_5_1_315:

move_dp -9
change -1
move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_316   ;jump over loop body if data is 0
loop_top_5_2_316:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_316      ;continue looping if non-zero
loop_bottom_5_2_316:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_54_314      ;continue looping if non-zero
loop_bottom_5_54_314:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_55_317   ;jump over loop body if data is 0
loop_top_4_55_317:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_318   ;jump over loop body if data is 0
loop_top_5_1_318:
 
change -1
move_dp -3
change -1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_318      ;continue looping if non-zero
loop_bottom_5_1_318:

change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_319   ;jump over loop body if data is 0
loop_top_5_2_319:
 
change -1
move_dp 3
change -1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_320   ;jump over loop body if data is 0
loop_top_6_1_320:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_320      ;continue looping if non-zero
loop_bottom_6_1_320:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_321   ;jump over loop body if data is 0
loop_top_6_2_321:
 
change -1
move_dp 4
change 1
move_dp -13

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_322   ;jump over loop body if data is 0
loop_top_7_1_322:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_322      ;continue looping if non-zero
loop_bottom_7_1_322:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_323   ;jump over loop body if data is 0
loop_top_7_2_323:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_323      ;continue looping if non-zero
loop_bottom_7_2_323:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_324   ;jump over loop body if data is 0
loop_top_7_3_324:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_324      ;continue looping if non-zero
loop_bottom_7_3_324:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_321      ;continue looping if non-zero
loop_bottom_6_2_321:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_319      ;continue looping if non-zero
loop_bottom_5_2_319:

change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_325   ;jump over loop body if data is 0
loop_top_5_3_325:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_325      ;continue looping if non-zero
loop_bottom_5_3_325:

change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_326   ;jump over loop body if data is 0
loop_top_5_4_326:
 
change -1
move_dp 4
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_327   ;jump over loop body if data is 0
loop_top_6_1_327:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_327      ;continue looping if non-zero
loop_bottom_6_1_327:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_328   ;jump over loop body if data is 0
loop_top_6_2_328:
 
change -1
move_dp 3
change 1
move_dp -12

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_329   ;jump over loop body if data is 0
loop_top_7_1_329:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_329      ;continue looping if non-zero
loop_bottom_7_1_329:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_330   ;jump over loop body if data is 0
loop_top_7_2_330:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_330      ;continue looping if non-zero
loop_bottom_7_2_330:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_331   ;jump over loop body if data is 0
loop_top_7_3_331:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_331      ;continue looping if non-zero
loop_bottom_7_3_331:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_4_332   ;jump over loop body if data is 0
loop_top_7_4_332:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_4_332      ;continue looping if non-zero
loop_bottom_7_4_332:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_328      ;continue looping if non-zero
loop_bottom_6_2_328:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_326      ;continue looping if non-zero
loop_bottom_5_4_326:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_333   ;jump over loop body if data is 0
loop_top_5_5_333:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_334   ;jump over loop body if data is 0
loop_top_6_1_334:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_334      ;continue looping if non-zero
loop_bottom_6_1_334:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_333      ;continue looping if non-zero
loop_bottom_5_5_333:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_55_317      ;continue looping if non-zero
loop_bottom_4_55_317:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_56_335   ;jump over loop body if data is 0
loop_top_4_56_335:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_56_335      ;continue looping if non-zero
loop_bottom_4_56_335:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_57_336   ;jump over loop body if data is 0
loop_top_4_57_336:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_57_336      ;continue looping if non-zero
loop_bottom_4_57_336:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_58_337   ;jump over loop body if data is 0
loop_top_4_58_337:
 
change -1
move_dp 3
change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_338   ;jump over loop body if data is 0
loop_top_5_1_338:
 
move_dp 1
change 1
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_339   ;jump over loop body if data is 0
loop_top_6_1_339:
 
change -1
move_dp -3
change -1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_339      ;continue looping if non-zero
loop_bottom_6_1_339:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_340   ;jump over loop body if data is 0
loop_top_6_2_340:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_340      ;continue looping if non-zero
loop_bottom_6_2_340:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_338      ;continue looping if non-zero
loop_bottom_5_1_338:

move_dp -8
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_341   ;jump over loop body if data is 0
loop_top_5_2_341:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_342   ;jump over loop body if data is 0
loop_top_6_1_342:
 
change -1
move_dp 1
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_343   ;jump over loop body if data is 0
loop_top_7_1_343:
 
change -1
move_dp -1
change -1
move_dp -10
change 1
move_dp 12

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_344   ;jump over loop body if data is 0
loop_top_8_1_344:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_344      ;continue looping if non-zero
loop_bottom_8_1_344:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_343      ;continue looping if non-zero
loop_bottom_7_1_343:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_345   ;jump over loop body if data is 0
loop_top_7_2_345:
 
change -1
move_dp -2
change -1
move_dp -10
change 1
move_dp 12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_345      ;continue looping if non-zero
loop_bottom_7_2_345:

move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_342      ;continue looping if non-zero
loop_bottom_6_1_342:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_346   ;jump over loop body if data is 0
loop_top_6_2_346:
 
change -1
move_dp -1
change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_347   ;jump over loop body if data is 0
loop_top_7_1_347:
 
change -1
move_dp -2
change -1
move_dp -10
change 1
move_dp 12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_347      ;continue looping if non-zero
loop_bottom_7_1_347:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_346      ;continue looping if non-zero
loop_bottom_6_2_346:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_348   ;jump over loop body if data is 0
loop_top_6_3_348:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_348      ;continue looping if non-zero
loop_bottom_6_3_348:

move_dp -13

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_341      ;continue looping if non-zero
loop_bottom_5_2_341:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_58_337      ;continue looping if non-zero
loop_bottom_4_58_337:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_59_349   ;jump over loop body if data is 0
loop_top_4_59_349:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_59_349      ;continue looping if non-zero
loop_bottom_4_59_349:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_60_350   ;jump over loop body if data is 0
loop_top_4_60_350:
 
change -1
move_dp 4
change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_351   ;jump over loop body if data is 0
loop_top_5_1_351:
 
move_dp 1
change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_352   ;jump over loop body if data is 0
loop_top_6_1_352:
 
change -1
move_dp -2
change -1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_352      ;continue looping if non-zero
loop_bottom_6_1_352:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_353   ;jump over loop body if data is 0
loop_top_6_2_353:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_353      ;continue looping if non-zero
loop_bottom_6_2_353:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_351      ;continue looping if non-zero
loop_bottom_5_1_351:

move_dp -8
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_354   ;jump over loop body if data is 0
loop_top_5_2_354:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_355   ;jump over loop body if data is 0
loop_top_6_1_355:
 
change -1
move_dp 1
change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_356   ;jump over loop body if data is 0
loop_top_7_1_356:
 
change -1
move_dp -2
change -1
move_dp -10
change 1
move_dp 11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_357   ;jump over loop body if data is 0
loop_top_8_1_357:
 
change -1
move_dp -1
change 1
move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_357      ;continue looping if non-zero
loop_bottom_8_1_357:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_356      ;continue looping if non-zero
loop_bottom_7_1_356:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_358   ;jump over loop body if data is 0
loop_top_7_2_358:
 
change -1
move_dp -1
change -1
move_dp -10
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_358      ;continue looping if non-zero
loop_bottom_7_2_358:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_355      ;continue looping if non-zero
loop_bottom_6_1_355:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_359   ;jump over loop body if data is 0
loop_top_6_2_359:
 
change -1
move_dp -2
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_360   ;jump over loop body if data is 0
loop_top_7_1_360:
 
change -1
move_dp -1
change -1
move_dp -10
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_360      ;continue looping if non-zero
loop_bottom_7_1_360:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_359      ;continue looping if non-zero
loop_bottom_6_2_359:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_361   ;jump over loop body if data is 0
loop_top_6_3_361:
 
change -1
move_dp -1
change 1
move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_361      ;continue looping if non-zero
loop_bottom_6_3_361:

move_dp -12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_354      ;continue looping if non-zero
loop_bottom_5_2_354:

move_dp 5
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_60_350      ;continue looping if non-zero
loop_bottom_4_60_350:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_61_362   ;jump over loop body if data is 0
loop_top_4_61_362:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_363   ;jump over loop body if data is 0
loop_top_5_1_363:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_363      ;continue looping if non-zero
loop_bottom_5_1_363:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_364   ;jump over loop body if data is 0
loop_top_5_2_364:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_364      ;continue looping if non-zero
loop_bottom_5_2_364:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_365   ;jump over loop body if data is 0
loop_top_5_3_365:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_365      ;continue looping if non-zero
loop_bottom_5_3_365:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_61_362      ;continue looping if non-zero
loop_bottom_4_61_362:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_62_366   ;jump over loop body if data is 0
loop_top_4_62_366:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_62_366      ;continue looping if non-zero
loop_bottom_4_62_366:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_63_367   ;jump over loop body if data is 0
loop_top_4_63_367:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_63_367      ;continue looping if non-zero
loop_bottom_4_63_367:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_64_368   ;jump over loop body if data is 0
loop_top_4_64_368:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_64_368      ;continue looping if non-zero
loop_bottom_4_64_368:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_65_369   ;jump over loop body if data is 0
loop_top_4_65_369:
 
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_370   ;jump over loop body if data is 0
loop_top_5_1_370:
 
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_370      ;continue looping if non-zero
loop_bottom_5_1_370:

move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_371   ;jump over loop body if data is 0
loop_top_5_2_371:
 
change -1
move_dp 6
change 1
move_dp -4
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_371      ;continue looping if non-zero
loop_bottom_5_2_371:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_65_369      ;continue looping if non-zero
loop_bottom_4_65_369:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_66_372   ;jump over loop body if data is 0
loop_top_4_66_372:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_66_372      ;continue looping if non-zero
loop_bottom_4_66_372:

move_dp 4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_67_373   ;jump over loop body if data is 0
loop_top_4_67_373:
 
change -1
move_dp -1
change -1
move_dp -4
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_67_373      ;continue looping if non-zero
loop_bottom_4_67_373:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_68_374   ;jump over loop body if data is 0
loop_top_4_68_374:
 
change -1
move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_375   ;jump over loop body if data is 0
loop_top_5_1_375:
 
change -1
move_dp 5
change 1
move_dp -1
change 2
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_375      ;continue looping if non-zero
loop_bottom_5_1_375:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_376   ;jump over loop body if data is 0
loop_top_5_2_376:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_376      ;continue looping if non-zero
loop_bottom_5_2_376:

move_dp -1
change -1
move_dp 1
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_68_374      ;continue looping if non-zero
loop_bottom_4_68_374:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_69_377   ;jump over loop body if data is 0
loop_top_4_69_377:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_69_377      ;continue looping if non-zero
loop_bottom_4_69_377:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_70_378   ;jump over loop body if data is 0
loop_top_4_70_378:
 
change -1
move_dp 5
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_70_378      ;continue looping if non-zero
loop_bottom_4_70_378:

change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_71_379   ;jump over loop body if data is 0
loop_top_4_71_379:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_71_379      ;continue looping if non-zero
loop_bottom_4_71_379:

change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_72_380   ;jump over loop body if data is 0
loop_top_4_72_380:
 
change -1
move_dp 4
change -1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_381   ;jump over loop body if data is 0
loop_top_5_1_381:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_382   ;jump over loop body if data is 0
loop_top_6_1_382:
 
change -1
move_dp -3
change -1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_382      ;continue looping if non-zero
loop_bottom_6_1_382:

change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_383   ;jump over loop body if data is 0
loop_top_6_2_383:
 
change -1
move_dp 3
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_384   ;jump over loop body if data is 0
loop_top_7_1_384:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_384      ;continue looping if non-zero
loop_bottom_7_1_384:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_385   ;jump over loop body if data is 0
loop_top_7_2_385:
 
change -1
move_dp 2
change 1
move_dp -11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_386   ;jump over loop body if data is 0
loop_top_8_1_386:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_386      ;continue looping if non-zero
loop_bottom_8_1_386:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_387   ;jump over loop body if data is 0
loop_top_8_2_387:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_387      ;continue looping if non-zero
loop_bottom_8_2_387:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_3_388   ;jump over loop body if data is 0
loop_top_8_3_388:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_3_388      ;continue looping if non-zero
loop_bottom_8_3_388:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_385      ;continue looping if non-zero
loop_bottom_7_2_385:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_383      ;continue looping if non-zero
loop_bottom_6_2_383:

change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_389   ;jump over loop body if data is 0
loop_top_6_3_389:
 
change -1
move_dp -2
change -1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_389      ;continue looping if non-zero
loop_bottom_6_3_389:

change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_4_390   ;jump over loop body if data is 0
loop_top_6_4_390:
 
change -1
move_dp 2
change -1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_391   ;jump over loop body if data is 0
loop_top_7_1_391:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_391      ;continue looping if non-zero
loop_bottom_7_1_391:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_392   ;jump over loop body if data is 0
loop_top_7_2_392:
 
change -1
move_dp 3
change 1
move_dp -12

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_393   ;jump over loop body if data is 0
loop_top_8_1_393:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_393      ;continue looping if non-zero
loop_bottom_8_1_393:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_394   ;jump over loop body if data is 0
loop_top_8_2_394:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_394      ;continue looping if non-zero
loop_bottom_8_2_394:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_3_395   ;jump over loop body if data is 0
loop_top_8_3_395:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_3_395      ;continue looping if non-zero
loop_bottom_8_3_395:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_4_396   ;jump over loop body if data is 0
loop_top_8_4_396:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_4_396      ;continue looping if non-zero
loop_bottom_8_4_396:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_392      ;continue looping if non-zero
loop_bottom_7_2_392:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_4_390      ;continue looping if non-zero
loop_bottom_6_4_390:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_5_397   ;jump over loop body if data is 0
loop_top_6_5_397:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_398   ;jump over loop body if data is 0
loop_top_7_1_398:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_398      ;continue looping if non-zero
loop_bottom_7_1_398:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_5_397      ;continue looping if non-zero
loop_bottom_6_5_397:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_381      ;continue looping if non-zero
loop_bottom_5_1_381:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_399   ;jump over loop body if data is 0
loop_top_5_2_399:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_399      ;continue looping if non-zero
loop_bottom_5_2_399:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_400   ;jump over loop body if data is 0
loop_top_5_3_400:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_400      ;continue looping if non-zero
loop_bottom_5_3_400:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_401   ;jump over loop body if data is 0
loop_top_5_4_401:
 
change -1
move_dp 3
change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_402   ;jump over loop body if data is 0
loop_top_6_1_402:
 
move_dp 1
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_403   ;jump over loop body if data is 0
loop_top_7_1_403:
 
change -1
move_dp -1
change -1
move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_403      ;continue looping if non-zero
loop_bottom_7_1_403:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_404   ;jump over loop body if data is 0
loop_top_7_2_404:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_404      ;continue looping if non-zero
loop_bottom_7_2_404:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_402      ;continue looping if non-zero
loop_bottom_6_1_402:

move_dp -8
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_405   ;jump over loop body if data is 0
loop_top_6_2_405:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_406   ;jump over loop body if data is 0
loop_top_7_1_406:
 
change -1
move_dp 4
change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_407   ;jump over loop body if data is 0
loop_top_8_1_407:
 
change -1
move_dp 2
change -1
move_dp -13
change 1
move_dp 10

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_9_1_408   ;jump over loop body if data is 0
loop_top_9_1_408:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_9_1_408      ;continue looping if non-zero
loop_bottom_9_1_408:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_407      ;continue looping if non-zero
loop_bottom_8_1_407:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_409   ;jump over loop body if data is 0
loop_top_8_2_409:
 
change -1
move_dp 3
change -1
move_dp -13
change 1
move_dp 10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_409      ;continue looping if non-zero
loop_bottom_8_2_409:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_406      ;continue looping if non-zero
loop_bottom_7_1_406:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_410   ;jump over loop body if data is 0
loop_top_7_2_410:
 
change -1
move_dp 2
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_411   ;jump over loop body if data is 0
loop_top_8_1_411:
 
change -1
move_dp 3
change -1
move_dp -13
change 1
move_dp 10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_411      ;continue looping if non-zero
loop_bottom_8_1_411:

move_dp 1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_410      ;continue looping if non-zero
loop_bottom_7_2_410:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_412   ;jump over loop body if data is 0
loop_top_7_3_412:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_412      ;continue looping if non-zero
loop_bottom_7_3_412:

move_dp -11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_405      ;continue looping if non-zero
loop_bottom_6_2_405:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_413   ;jump over loop body if data is 0
loop_top_6_3_413:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_413      ;continue looping if non-zero
loop_bottom_6_3_413:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_4_414   ;jump over loop body if data is 0
loop_top_6_4_414:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_4_414      ;continue looping if non-zero
loop_bottom_6_4_414:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_5_415   ;jump over loop body if data is 0
loop_top_6_5_415:
 
change -1
move_dp 7
change 1
move_dp -2
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_5_415      ;continue looping if non-zero
loop_bottom_6_5_415:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_401      ;continue looping if non-zero
loop_bottom_5_4_401:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_416   ;jump over loop body if data is 0
loop_top_5_5_416:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_416      ;continue looping if non-zero
loop_bottom_5_5_416:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_6_417   ;jump over loop body if data is 0
loop_top_5_6_417:
 
change -1
move_dp 4
change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_418   ;jump over loop body if data is 0
loop_top_6_1_418:
 
move_dp 1
change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_419   ;jump over loop body if data is 0
loop_top_7_1_419:
 
change -1
move_dp -2
change -1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_419      ;continue looping if non-zero
loop_bottom_7_1_419:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_420   ;jump over loop body if data is 0
loop_top_7_2_420:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_420      ;continue looping if non-zero
loop_bottom_7_2_420:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_418      ;continue looping if non-zero
loop_bottom_6_1_418:

move_dp -8
change 1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_421   ;jump over loop body if data is 0
loop_top_6_2_421:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_422   ;jump over loop body if data is 0
loop_top_7_1_422:
 
change -1
move_dp 4
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_423   ;jump over loop body if data is 0
loop_top_8_1_423:
 
change -1
move_dp 3
change -1
move_dp -13
change 1
move_dp 11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_9_1_424   ;jump over loop body if data is 0
loop_top_9_1_424:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_9_1_424      ;continue looping if non-zero
loop_bottom_9_1_424:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_423      ;continue looping if non-zero
loop_bottom_8_1_423:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_2_425   ;jump over loop body if data is 0
loop_top_8_2_425:
 
change -1
move_dp 2
change -1
move_dp -13
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_2_425      ;continue looping if non-zero
loop_bottom_8_2_425:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_422      ;continue looping if non-zero
loop_bottom_7_1_422:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_426   ;jump over loop body if data is 0
loop_top_7_2_426:
 
change -1
move_dp 3
change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_427   ;jump over loop body if data is 0
loop_top_8_1_427:
 
change -1
move_dp 2
change -1
move_dp -13
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_427      ;continue looping if non-zero
loop_bottom_8_1_427:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_426      ;continue looping if non-zero
loop_bottom_7_2_426:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_428   ;jump over loop body if data is 0
loop_top_7_3_428:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_428      ;continue looping if non-zero
loop_bottom_7_3_428:

move_dp -12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_421      ;continue looping if non-zero
loop_bottom_6_2_421:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_6_417      ;continue looping if non-zero
loop_bottom_5_6_417:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_7_429   ;jump over loop body if data is 0
loop_top_5_7_429:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_7_429      ;continue looping if non-zero
loop_bottom_5_7_429:

move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_72_380      ;continue looping if non-zero
loop_bottom_4_72_380:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_73_430   ;jump over loop body if data is 0
loop_top_4_73_430:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_73_430      ;continue looping if non-zero
loop_bottom_4_73_430:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_74_431   ;jump over loop body if data is 0
loop_top_4_74_431:
 
change -1
move_dp 4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_432   ;jump over loop body if data is 0
loop_top_5_1_432:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_432      ;continue looping if non-zero
loop_bottom_5_1_432:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_433   ;jump over loop body if data is 0
loop_top_5_2_433:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_433      ;continue looping if non-zero
loop_bottom_5_2_433:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_434   ;jump over loop body if data is 0
loop_top_5_3_434:
 
change -1
move_dp 7
change 1
move_dp -2
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_434      ;continue looping if non-zero
loop_bottom_5_3_434:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_435   ;jump over loop body if data is 0
loop_top_5_4_435:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_435      ;continue looping if non-zero
loop_bottom_5_4_435:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_436   ;jump over loop body if data is 0
loop_top_5_5_436:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_437   ;jump over loop body if data is 0
loop_top_6_1_437:
 
change -1
move_dp 4
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_438   ;jump over loop body if data is 0
loop_top_7_1_438:
 
change -1
move_dp 3
change -1
move_dp -13
change 1
move_dp 11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_8_1_439   ;jump over loop body if data is 0
loop_top_8_1_439:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_8_1_439      ;continue looping if non-zero
loop_bottom_8_1_439:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_438      ;continue looping if non-zero
loop_bottom_7_1_438:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_440   ;jump over loop body if data is 0
loop_top_7_2_440:
 
change -1
move_dp 2
change -1
move_dp -13
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_440      ;continue looping if non-zero
loop_bottom_7_2_440:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_437      ;continue looping if non-zero
loop_bottom_6_1_437:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_441   ;jump over loop body if data is 0
loop_top_6_2_441:
 
change -1
move_dp 3
change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_442   ;jump over loop body if data is 0
loop_top_7_1_442:
 
change -1
move_dp 2
change -1
move_dp -13
change 1
move_dp 11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_442      ;continue looping if non-zero
loop_bottom_7_1_442:

move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_441      ;continue looping if non-zero
loop_bottom_6_2_441:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_443   ;jump over loop body if data is 0
loop_top_6_3_443:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_443      ;continue looping if non-zero
loop_bottom_6_3_443:

move_dp -12

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_436      ;continue looping if non-zero
loop_bottom_5_5_436:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_74_431      ;continue looping if non-zero
loop_bottom_4_74_431:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_75_444   ;jump over loop body if data is 0
loop_top_4_75_444:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_445   ;jump over loop body if data is 0
loop_top_5_1_445:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_445      ;continue looping if non-zero
loop_bottom_5_1_445:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_446   ;jump over loop body if data is 0
loop_top_5_2_446:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_446      ;continue looping if non-zero
loop_bottom_5_2_446:

move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_75_444      ;continue looping if non-zero
loop_bottom_4_75_444:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_76_447   ;jump over loop body if data is 0
loop_top_4_76_447:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_76_447      ;continue looping if non-zero
loop_bottom_4_76_447:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_77_448   ;jump over loop body if data is 0
loop_top_4_77_448:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_77_448      ;continue looping if non-zero
loop_bottom_4_77_448:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_78_449   ;jump over loop body if data is 0
loop_top_4_78_449:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_78_449      ;continue looping if non-zero
loop_bottom_4_78_449:

move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_79_450   ;jump over loop body if data is 0
loop_top_4_79_450:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_451   ;jump over loop body if data is 0
loop_top_5_1_451:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_451      ;continue looping if non-zero
loop_bottom_5_1_451:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_452   ;jump over loop body if data is 0
loop_top_5_2_452:
 
change -1
move_dp 4
change 1
move_dp -3
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_452      ;continue looping if non-zero
loop_bottom_5_2_452:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_79_450      ;continue looping if non-zero
loop_bottom_4_79_450:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_80_453   ;jump over loop body if data is 0
loop_top_4_80_453:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_80_453      ;continue looping if non-zero
loop_bottom_4_80_453:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_81_454   ;jump over loop body if data is 0
loop_top_4_81_454:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_455   ;jump over loop body if data is 0
loop_top_5_1_455:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_455      ;continue looping if non-zero
loop_bottom_5_1_455:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_456   ;jump over loop body if data is 0
loop_top_5_2_456:
 
change -1
move_dp 5
change 1
move_dp -3
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_456      ;continue looping if non-zero
loop_bottom_5_2_456:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_81_454      ;continue looping if non-zero
loop_bottom_4_81_454:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_82_457   ;jump over loop body if data is 0
loop_top_4_82_457:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_82_457      ;continue looping if non-zero
loop_bottom_4_82_457:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_83_458   ;jump over loop body if data is 0
loop_top_5_83_458:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_459   ;jump over loop body if data is 0
loop_top_5_1_459:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_459      ;continue looping if non-zero
loop_bottom_5_1_459:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_460   ;jump over loop body if data is 0
loop_top_5_2_460:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_460      ;continue looping if non-zero
loop_bottom_5_2_460:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_461   ;jump over loop body if data is 0
loop_top_5_3_461:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_461      ;continue looping if non-zero
loop_bottom_5_3_461:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_462   ;jump over loop body if data is 0
loop_top_5_4_462:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_462      ;continue looping if non-zero
loop_bottom_5_4_462:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_463   ;jump over loop body if data is 0
loop_top_5_5_463:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_463      ;continue looping if non-zero
loop_bottom_5_5_463:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_6_464   ;jump over loop body if data is 0
loop_top_5_6_464:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_6_464      ;continue looping if non-zero
loop_bottom_5_6_464:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_7_465   ;jump over loop body if data is 0
loop_top_5_7_465:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_7_465      ;continue looping if non-zero
loop_bottom_5_7_465:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_8_466   ;jump over loop body if data is 0
loop_top_5_8_466:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_8_466      ;continue looping if non-zero
loop_bottom_5_8_466:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_9_467   ;jump over loop body if data is 0
loop_top_5_9_467:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_9_467      ;continue looping if non-zero
loop_bottom_5_9_467:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_10_468   ;jump over loop body if data is 0
loop_top_5_10_468:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_10_468      ;continue looping if non-zero
loop_bottom_5_10_468:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_11_469   ;jump over loop body if data is 0
loop_top_5_11_469:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_11_469      ;continue looping if non-zero
loop_bottom_5_11_469:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_83_458      ;continue looping if non-zero
loop_bottom_5_83_458:

change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_84_470   ;jump over loop body if data is 0
loop_top_4_84_470:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_84_470      ;continue looping if non-zero
loop_bottom_4_84_470:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_85_471   ;jump over loop body if data is 0
loop_top_4_85_471:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_85_471      ;continue looping if non-zero
loop_bottom_4_85_471:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_86_472   ;jump over loop body if data is 0
loop_top_4_86_472:
 
move_dp 1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_473   ;jump over loop body if data is 0
loop_top_5_1_473:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_473      ;continue looping if non-zero
loop_bottom_5_1_473:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_474   ;jump over loop body if data is 0
loop_top_5_2_474:
 
change -1
move_dp 4
change 1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_475   ;jump over loop body if data is 0
loop_top_6_1_475:
 
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_476   ;jump over loop body if data is 0
loop_top_7_1_476:
 
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_476      ;continue looping if non-zero
loop_bottom_7_1_476:

move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_477   ;jump over loop body if data is 0
loop_top_7_2_477:
 
change -1
move_dp 2
change 1
move_dp 2
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_477      ;continue looping if non-zero
loop_bottom_7_2_477:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_475      ;continue looping if non-zero
loop_bottom_6_1_475:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_478   ;jump over loop body if data is 0
loop_top_6_2_478:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_478      ;continue looping if non-zero
loop_bottom_6_2_478:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_474      ;continue looping if non-zero
loop_bottom_5_2_474:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_479   ;jump over loop body if data is 0
loop_top_5_3_479:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_479      ;continue looping if non-zero
loop_bottom_5_3_479:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_480   ;jump over loop body if data is 0
loop_top_5_4_480:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_481   ;jump over loop body if data is 0
loop_top_6_1_481:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_481      ;continue looping if non-zero
loop_bottom_6_1_481:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_480      ;continue looping if non-zero
loop_bottom_5_4_480:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_482   ;jump over loop body if data is 0
loop_top_5_5_482:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_482      ;continue looping if non-zero
loop_bottom_5_5_482:

move_dp -1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_86_472      ;continue looping if non-zero
loop_bottom_4_86_472:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_87_483   ;jump over loop body if data is 0
loop_top_4_87_483:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_484   ;jump over loop body if data is 0
loop_top_5_1_484:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_484      ;continue looping if non-zero
loop_bottom_5_1_484:

move_dp -1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_485   ;jump over loop body if data is 0
loop_top_5_2_485:
 
change -1
move_dp -4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_486   ;jump over loop body if data is 0
loop_top_6_1_486:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_486      ;continue looping if non-zero
loop_bottom_6_1_486:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_487   ;jump over loop body if data is 0
loop_top_6_2_487:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_487      ;continue looping if non-zero
loop_bottom_6_2_487:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_485      ;continue looping if non-zero
loop_bottom_5_2_485:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_488   ;jump over loop body if data is 0
loop_top_5_3_488:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_488      ;continue looping if non-zero
loop_bottom_5_3_488:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_87_483      ;continue looping if non-zero
loop_bottom_4_87_483:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_88_489   ;jump over loop body if data is 0
loop_top_4_88_489:
 
move_dp 1
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_88_489      ;continue looping if non-zero
loop_bottom_4_88_489:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_89_490   ;jump over loop body if data is 0
loop_top_4_89_490:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_89_490      ;continue looping if non-zero
loop_bottom_4_89_490:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_90_491   ;jump over loop body if data is 0
loop_top_4_90_491:
 
move_dp 1
change -1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_492   ;jump over loop body if data is 0
loop_top_5_1_492:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_492      ;continue looping if non-zero
loop_bottom_5_1_492:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_493   ;jump over loop body if data is 0
loop_top_5_2_493:
 
change -1
move_dp 5
change 1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_494   ;jump over loop body if data is 0
loop_top_6_1_494:
 
change -1
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_495   ;jump over loop body if data is 0
loop_top_7_1_495:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_495      ;continue looping if non-zero
loop_bottom_7_1_495:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_496   ;jump over loop body if data is 0
loop_top_7_2_496:
 
change -1
move_dp 3
change 1
move_dp 1
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_496      ;continue looping if non-zero
loop_bottom_7_2_496:

change 1
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_494      ;continue looping if non-zero
loop_bottom_6_1_494:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_497   ;jump over loop body if data is 0
loop_top_6_2_497:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_497      ;continue looping if non-zero
loop_bottom_6_2_497:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_493      ;continue looping if non-zero
loop_bottom_5_2_493:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_498   ;jump over loop body if data is 0
loop_top_5_3_498:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_498      ;continue looping if non-zero
loop_bottom_5_3_498:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_499   ;jump over loop body if data is 0
loop_top_5_4_499:
 
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_500   ;jump over loop body if data is 0
loop_top_6_1_500:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_500      ;continue looping if non-zero
loop_bottom_6_1_500:

move_dp -11

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_499      ;continue looping if non-zero
loop_bottom_5_4_499:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_501   ;jump over loop body if data is 0
loop_top_5_5_501:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_501      ;continue looping if non-zero
loop_bottom_5_5_501:

move_dp -2
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_90_491      ;continue looping if non-zero
loop_bottom_4_90_491:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_91_502   ;jump over loop body if data is 0
loop_top_4_91_502:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_503   ;jump over loop body if data is 0
loop_top_5_1_503:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_503      ;continue looping if non-zero
loop_bottom_5_1_503:

move_dp -1
change -1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_504   ;jump over loop body if data is 0
loop_top_5_2_504:
 
change -1
move_dp -4
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_505   ;jump over loop body if data is 0
loop_top_6_1_505:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_505      ;continue looping if non-zero
loop_bottom_6_1_505:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_506   ;jump over loop body if data is 0
loop_top_6_2_506:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_506      ;continue looping if non-zero
loop_bottom_6_2_506:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_504      ;continue looping if non-zero
loop_bottom_5_2_504:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_507   ;jump over loop body if data is 0
loop_top_5_3_507:
 
change -1
move_dp 3
change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_507      ;continue looping if non-zero
loop_bottom_5_3_507:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_91_502      ;continue looping if non-zero
loop_bottom_4_91_502:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_92_508   ;jump over loop body if data is 0
loop_top_4_92_508:
 
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_509   ;jump over loop body if data is 0
loop_top_5_1_509:
 
change -1
move_dp -36
change 1
move_dp 36

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_509      ;continue looping if non-zero
loop_bottom_5_1_509:

move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_92_508      ;continue looping if non-zero
loop_bottom_4_92_508:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_93_510   ;jump over loop body if data is 0
loop_top_4_93_510:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_93_510      ;continue looping if non-zero
loop_bottom_4_93_510:

move_dp 9
change 15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_94_511   ;jump over loop body if data is 0
loop_top_5_94_511:
 

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_512   ;jump over loop body if data is 0
loop_top_5_1_512:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_512      ;continue looping if non-zero
loop_bottom_5_1_512:

move_dp -9
change -1
move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_513   ;jump over loop body if data is 0
loop_top_5_2_513:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_513      ;continue looping if non-zero
loop_bottom_5_2_513:

move_dp 9
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_94_511      ;continue looping if non-zero
loop_bottom_5_94_511:

change 1
move_dp 21
change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_95_514   ;jump over loop body if data is 0
loop_top_4_95_514:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_95_514      ;continue looping if non-zero
loop_bottom_4_95_514:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_96_515   ;jump over loop body if data is 0
loop_top_4_96_515:
 
move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_516   ;jump over loop body if data is 0
loop_top_5_1_516:
 
change -1
move_dp -3
change -1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_516      ;continue looping if non-zero
loop_bottom_5_1_516:

change 1
move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_517   ;jump over loop body if data is 0
loop_top_5_2_517:
 
change -1
move_dp 3
change -1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_518   ;jump over loop body if data is 0
loop_top_6_1_518:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_518      ;continue looping if non-zero
loop_bottom_6_1_518:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_519   ;jump over loop body if data is 0
loop_top_6_2_519:
 
change -1
move_dp 4
change 1
move_dp -13

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_520   ;jump over loop body if data is 0
loop_top_7_1_520:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_520      ;continue looping if non-zero
loop_bottom_7_1_520:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_521   ;jump over loop body if data is 0
loop_top_7_2_521:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_521      ;continue looping if non-zero
loop_bottom_7_2_521:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_522   ;jump over loop body if data is 0
loop_top_7_3_522:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_522      ;continue looping if non-zero
loop_bottom_7_3_522:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_519      ;continue looping if non-zero
loop_bottom_6_2_519:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_517      ;continue looping if non-zero
loop_bottom_5_2_517:

change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_523   ;jump over loop body if data is 0
loop_top_5_3_523:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_523      ;continue looping if non-zero
loop_bottom_5_3_523:

change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_524   ;jump over loop body if data is 0
loop_top_5_4_524:
 
change -1
move_dp 4
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_525   ;jump over loop body if data is 0
loop_top_6_1_525:
 
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_525      ;continue looping if non-zero
loop_bottom_6_1_525:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_526   ;jump over loop body if data is 0
loop_top_6_2_526:
 
change -1
move_dp 3
change 1
move_dp -12

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_527   ;jump over loop body if data is 0
loop_top_7_1_527:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_527      ;continue looping if non-zero
loop_bottom_7_1_527:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_528   ;jump over loop body if data is 0
loop_top_7_2_528:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_528      ;continue looping if non-zero
loop_bottom_7_2_528:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_529   ;jump over loop body if data is 0
loop_top_7_3_529:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_529      ;continue looping if non-zero
loop_bottom_7_3_529:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_4_530   ;jump over loop body if data is 0
loop_top_7_4_530:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_4_530      ;continue looping if non-zero
loop_bottom_7_4_530:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_526      ;continue looping if non-zero
loop_bottom_6_2_526:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_524      ;continue looping if non-zero
loop_bottom_5_4_524:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_531   ;jump over loop body if data is 0
loop_top_5_5_531:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_532   ;jump over loop body if data is 0
loop_top_6_1_532:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_532      ;continue looping if non-zero
loop_bottom_6_1_532:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_531      ;continue looping if non-zero
loop_bottom_5_5_531:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_96_515      ;continue looping if non-zero
loop_bottom_4_96_515:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_97_533   ;jump over loop body if data is 0
loop_top_4_97_533:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_97_533      ;continue looping if non-zero
loop_bottom_4_97_533:

move_dp 2
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_98_534   ;jump over loop body if data is 0
loop_top_4_98_534:
 
change -1
move_dp -4
change 1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_98_534      ;continue looping if non-zero
loop_bottom_4_98_534:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_99_535   ;jump over loop body if data is 0
loop_top_4_99_535:
 
change -1
move_dp 4
change 1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_536   ;jump over loop body if data is 0
loop_top_5_1_536:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_536      ;continue looping if non-zero
loop_bottom_5_1_536:

move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_99_535      ;continue looping if non-zero
loop_bottom_4_99_535:

move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_26_114      ;continue looping if non-zero
loop_bottom_3_26_114:

move_dp -2
change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_27_537   ;jump over loop body if data is 0
loop_top_3_27_537:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_27_537      ;continue looping if non-zero
loop_bottom_3_27_537:

change 1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_28_538   ;jump over loop body if data is 0
loop_top_3_28_538:
 
change -1
move_dp 4
change -1
move_dp -6
print_char
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_28_538      ;continue looping if non-zero
loop_bottom_3_28_538:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_29_539   ;jump over loop body if data is 0
loop_top_3_29_539:
 
change -1
move_dp -7
print_char
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_29_539      ;continue looping if non-zero
loop_bottom_3_29_539:

move_dp -3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_30_540   ;jump over loop body if data is 0
loop_top_3_30_540:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_30_540      ;continue looping if non-zero
loop_bottom_3_30_540:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_31_541   ;jump over loop body if data is 0
loop_top_3_31_541:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_31_541      ;continue looping if non-zero
loop_bottom_3_31_541:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_32_542   ;jump over loop body if data is 0
loop_top_3_32_542:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_32_542      ;continue looping if non-zero
loop_bottom_3_32_542:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_33_543   ;jump over loop body if data is 0
loop_top_3_33_543:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_33_543      ;continue looping if non-zero
loop_bottom_3_33_543:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_34_544   ;jump over loop body if data is 0
loop_top_3_34_544:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_34_544      ;continue looping if non-zero
loop_bottom_3_34_544:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_35_545   ;jump over loop body if data is 0
loop_top_3_35_545:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_35_545      ;continue looping if non-zero
loop_bottom_3_35_545:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_36_546   ;jump over loop body if data is 0
loop_top_3_36_546:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_547   ;jump over loop body if data is 0
loop_top_4_1_547:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_547      ;continue looping if non-zero
loop_bottom_4_1_547:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_548   ;jump over loop body if data is 0
loop_top_4_2_548:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_548      ;continue looping if non-zero
loop_bottom_4_2_548:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_549   ;jump over loop body if data is 0
loop_top_4_3_549:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_549      ;continue looping if non-zero
loop_bottom_4_3_549:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_550   ;jump over loop body if data is 0
loop_top_4_4_550:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_550      ;continue looping if non-zero
loop_bottom_4_4_550:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_551   ;jump over loop body if data is 0
loop_top_4_5_551:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_551      ;continue looping if non-zero
loop_bottom_4_5_551:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_6_552   ;jump over loop body if data is 0
loop_top_4_6_552:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_6_552      ;continue looping if non-zero
loop_bottom_4_6_552:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_36_546      ;continue looping if non-zero
loop_bottom_3_36_546:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_37_553   ;jump over loop body if data is 0
loop_top_3_37_553:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_37_553      ;continue looping if non-zero
loop_bottom_3_37_553:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_38_554   ;jump over loop body if data is 0
loop_top_3_38_554:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_555   ;jump over loop body if data is 0
loop_top_4_1_555:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_555      ;continue looping if non-zero
loop_bottom_4_1_555:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_38_554      ;continue looping if non-zero
loop_bottom_3_38_554:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_39_556   ;jump over loop body if data is 0
loop_top_3_39_556:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_39_556      ;continue looping if non-zero
loop_bottom_3_39_556:

move_dp 1
change 11

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_40_557   ;jump over loop body if data is 0
loop_top_3_40_557:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_558   ;jump over loop body if data is 0
loop_top_4_1_558:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_558      ;continue looping if non-zero
loop_bottom_4_1_558:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_40_557      ;continue looping if non-zero
loop_bottom_3_40_557:

move_dp 4
change 1
move_dp 9
change 1
move_dp -14

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_41_559   ;jump over loop body if data is 0
loop_top_3_41_559:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_41_559      ;continue looping if non-zero
loop_bottom_3_41_559:

move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_42_560   ;jump over loop body if data is 0
loop_top_3_42_560:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_42_560      ;continue looping if non-zero
loop_bottom_3_42_560:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_43_561   ;jump over loop body if data is 0
loop_top_3_43_561:
 
change -1
move_dp 7
change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_562   ;jump over loop body if data is 0
loop_top_4_1_562:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_562      ;continue looping if non-zero
loop_bottom_4_1_562:

move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_563   ;jump over loop body if data is 0
loop_top_4_2_563:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_563      ;continue looping if non-zero
loop_bottom_4_2_563:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_564   ;jump over loop body if data is 0
loop_top_4_3_564:
 
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_565   ;jump over loop body if data is 0
loop_top_5_1_565:
 
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_565      ;continue looping if non-zero
loop_bottom_5_1_565:

move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_566   ;jump over loop body if data is 0
loop_top_5_2_566:
 
change -1
move_dp 6
change 1
move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_567   ;jump over loop body if data is 0
loop_top_6_1_567:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_567      ;continue looping if non-zero
loop_bottom_6_1_567:

move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_568   ;jump over loop body if data is 0
loop_top_6_2_568:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_568      ;continue looping if non-zero
loop_bottom_6_2_568:

change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_566      ;continue looping if non-zero
loop_bottom_5_2_566:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_564      ;continue looping if non-zero
loop_bottom_4_3_564:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_43_561      ;continue looping if non-zero
loop_bottom_3_43_561:

move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_44_569   ;jump over loop body if data is 0
loop_top_3_44_569:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_44_569      ;continue looping if non-zero
loop_bottom_3_44_569:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_45_570   ;jump over loop body if data is 0
loop_top_3_45_570:
 
change -1
move_dp 7
change 1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_571   ;jump over loop body if data is 0
loop_top_4_1_571:
 
move_dp 1
change 1
move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_572   ;jump over loop body if data is 0
loop_top_5_1_572:
 
change -1
move_dp -4
change -1
move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_572      ;continue looping if non-zero
loop_bottom_5_1_572:

move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_573   ;jump over loop body if data is 0
loop_top_5_2_573:
 
change -1
move_dp 4
change 1
move_dp -4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_573      ;continue looping if non-zero
loop_bottom_5_2_573:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_571      ;continue looping if non-zero
loop_bottom_4_1_571:

move_dp -2
change 1
move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_574   ;jump over loop body if data is 0
loop_top_4_2_574:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_575   ;jump over loop body if data is 0
loop_top_5_1_575:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_575      ;continue looping if non-zero
loop_bottom_5_1_575:

move_dp -14

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_574      ;continue looping if non-zero
loop_bottom_4_2_574:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_576   ;jump over loop body if data is 0
loop_top_4_3_576:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_576      ;continue looping if non-zero
loop_bottom_4_3_576:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_577   ;jump over loop body if data is 0
loop_top_4_4_577:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_578   ;jump over loop body if data is 0
loop_top_5_1_578:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_578      ;continue looping if non-zero
loop_bottom_5_1_578:

move_dp -1
change -1
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_579   ;jump over loop body if data is 0
loop_top_5_2_579:
 
change -1
move_dp -7
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_580   ;jump over loop body if data is 0
loop_top_6_1_580:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_580      ;continue looping if non-zero
loop_bottom_6_1_580:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_581   ;jump over loop body if data is 0
loop_top_6_2_581:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_581      ;continue looping if non-zero
loop_bottom_6_2_581:

move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_579      ;continue looping if non-zero
loop_bottom_5_2_579:

move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_582   ;jump over loop body if data is 0
loop_top_5_3_582:
 
change -1
move_dp 6
change 1
move_dp -6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_582      ;continue looping if non-zero
loop_bottom_5_3_582:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_577      ;continue looping if non-zero
loop_bottom_4_4_577:

move_dp 7
change -1
move_dp -4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_583   ;jump over loop body if data is 0
loop_top_4_5_583:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_583      ;continue looping if non-zero
loop_bottom_4_5_583:

change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_45_570      ;continue looping if non-zero
loop_bottom_3_45_570:

change 1
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_46_584   ;jump over loop body if data is 0
loop_top_3_46_584:
 
change -1
move_dp -7
change -1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_46_584      ;continue looping if non-zero
loop_bottom_3_46_584:

change 1
move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_47_585   ;jump over loop body if data is 0
loop_top_3_47_585:
 
change -1
move_dp 7
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_586   ;jump over loop body if data is 0
loop_top_4_1_586:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_587   ;jump over loop body if data is 0
loop_top_5_1_587:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_587      ;continue looping if non-zero
loop_bottom_5_1_587:

move_dp 4

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_586      ;continue looping if non-zero
loop_bottom_4_1_586:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_588   ;jump over loop body if data is 0
loop_top_4_2_588:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_589   ;jump over loop body if data is 0
loop_top_5_1_589:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_589      ;continue looping if non-zero
loop_bottom_5_1_589:

move_dp -1
change -1
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_590   ;jump over loop body if data is 0
loop_top_5_2_590:
 
change -1
move_dp -7
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_591   ;jump over loop body if data is 0
loop_top_6_1_591:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -3
change 1
move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_591      ;continue looping if non-zero
loop_bottom_6_1_591:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_592   ;jump over loop body if data is 0
loop_top_6_2_592:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_592      ;continue looping if non-zero
loop_bottom_6_2_592:

move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_590      ;continue looping if non-zero
loop_bottom_5_2_590:

move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_593   ;jump over loop body if data is 0
loop_top_5_3_593:
 
change -1
move_dp 6
change 1
move_dp -6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_593      ;continue looping if non-zero
loop_bottom_5_3_593:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_588      ;continue looping if non-zero
loop_bottom_4_2_588:

move_dp 1
change 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_594   ;jump over loop body if data is 0
loop_top_4_3_594:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_595   ;jump over loop body if data is 0
loop_top_5_1_595:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_595      ;continue looping if non-zero
loop_bottom_5_1_595:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_594      ;continue looping if non-zero
loop_bottom_4_3_594:

move_dp 4
change 1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_596   ;jump over loop body if data is 0
loop_top_4_4_596:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_596      ;continue looping if non-zero
loop_bottom_4_4_596:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_597   ;jump over loop body if data is 0
loop_top_4_5_597:
 
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_598   ;jump over loop body if data is 0
loop_top_5_1_598:
 
change -1
move_dp -5
change -1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_598      ;continue looping if non-zero
loop_bottom_5_1_598:

change 1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_599   ;jump over loop body if data is 0
loop_top_5_2_599:
 
change -1
move_dp 5
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_600   ;jump over loop body if data is 0
loop_top_6_1_600:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_600      ;continue looping if non-zero
loop_bottom_6_1_600:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_601   ;jump over loop body if data is 0
loop_top_6_2_601:
 
change -1
move_dp 7
change 1
move_dp -16

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_602   ;jump over loop body if data is 0
loop_top_7_1_602:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_602      ;continue looping if non-zero
loop_bottom_7_1_602:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_603   ;jump over loop body if data is 0
loop_top_7_2_603:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_603      ;continue looping if non-zero
loop_bottom_7_2_603:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_604   ;jump over loop body if data is 0
loop_top_7_3_604:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_604      ;continue looping if non-zero
loop_bottom_7_3_604:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_601      ;continue looping if non-zero
loop_bottom_6_2_601:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_599      ;continue looping if non-zero
loop_bottom_5_2_599:

change 1
move_dp 7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_3_605   ;jump over loop body if data is 0
loop_top_5_3_605:
 
change -1
move_dp -7
change -1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_3_605      ;continue looping if non-zero
loop_bottom_5_3_605:

change 1
move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_4_606   ;jump over loop body if data is 0
loop_top_5_4_606:
 
change -1
move_dp 7
change -1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_607   ;jump over loop body if data is 0
loop_top_6_1_607:
 
change -1
move_dp -5
change 1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_607      ;continue looping if non-zero
loop_bottom_6_1_607:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_608   ;jump over loop body if data is 0
loop_top_6_2_608:
 
change -1
move_dp 5
change 1
move_dp -14

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_1_609   ;jump over loop body if data is 0
loop_top_7_1_609:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_1_609      ;continue looping if non-zero
loop_bottom_7_1_609:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_2_610   ;jump over loop body if data is 0
loop_top_7_2_610:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_2_610      ;continue looping if non-zero
loop_bottom_7_2_610:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_3_611   ;jump over loop body if data is 0
loop_top_7_3_611:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_3_611      ;continue looping if non-zero
loop_bottom_7_3_611:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_7_4_612   ;jump over loop body if data is 0
loop_top_7_4_612:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_7_4_612      ;continue looping if non-zero
loop_bottom_7_4_612:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_608      ;continue looping if non-zero
loop_bottom_6_2_608:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_4_606      ;continue looping if non-zero
loop_bottom_5_4_606:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_5_613   ;jump over loop body if data is 0
loop_top_5_5_613:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_614   ;jump over loop body if data is 0
loop_top_6_1_614:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_614      ;continue looping if non-zero
loop_bottom_6_1_614:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_5_613      ;continue looping if non-zero
loop_bottom_5_5_613:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_597      ;continue looping if non-zero
loop_bottom_4_5_597:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_6_615   ;jump over loop body if data is 0
loop_top_4_6_615:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_6_615      ;continue looping if non-zero
loop_bottom_4_6_615:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_7_616   ;jump over loop body if data is 0
loop_top_4_7_616:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_7_616      ;continue looping if non-zero
loop_bottom_4_7_616:

move_dp -3
change 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_8_617   ;jump over loop body if data is 0
loop_top_4_8_617:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_618   ;jump over loop body if data is 0
loop_top_5_1_618:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_618      ;continue looping if non-zero
loop_bottom_5_1_618:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_8_617      ;continue looping if non-zero
loop_bottom_4_8_617:

move_dp 4
change -1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_9_619   ;jump over loop body if data is 0
loop_top_4_9_619:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_9_619      ;continue looping if non-zero
loop_bottom_4_9_619:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_47_585      ;continue looping if non-zero
loop_bottom_3_47_585:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_7_22      ;continue looping if non-zero
loop_bottom_3_7_22:

move_dp -4
print_char
move_dp 10

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_8_620   ;jump over loop body if data is 0
loop_top_2_8_620:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_621   ;jump over loop body if data is 0
loop_top_3_1_621:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_621      ;continue looping if non-zero
loop_bottom_3_1_621:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_8_620      ;continue looping if non-zero
loop_bottom_2_8_620:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_9_622   ;jump over loop body if data is 0
loop_top_2_9_622:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_9_622      ;continue looping if non-zero
loop_bottom_2_9_622:

move_dp 1
change 10

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_10_623   ;jump over loop body if data is 0
loop_top_2_10_623:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_624   ;jump over loop body if data is 0
loop_top_3_1_624:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_624      ;continue looping if non-zero
loop_bottom_3_1_624:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_10_623      ;continue looping if non-zero
loop_bottom_2_10_623:

move_dp 5
change 1
move_dp 9
change 1
move_dp -15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_11_625   ;jump over loop body if data is 0
loop_top_2_11_625:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_11_625      ;continue looping if non-zero
loop_bottom_2_11_625:

move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_12_626   ;jump over loop body if data is 0
loop_top_2_12_626:
 
change -1
move_dp -8
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_12_626      ;continue looping if non-zero
loop_bottom_2_12_626:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_13_627   ;jump over loop body if data is 0
loop_top_2_13_627:
 
change -1
move_dp 8
change 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_628   ;jump over loop body if data is 0
loop_top_3_1_628:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_628      ;continue looping if non-zero
loop_bottom_3_1_628:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_2_629   ;jump over loop body if data is 0
loop_top_3_2_629:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_2_629      ;continue looping if non-zero
loop_bottom_3_2_629:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_3_630   ;jump over loop body if data is 0
loop_top_3_3_630:
 
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_631   ;jump over loop body if data is 0
loop_top_4_1_631:
 
change -1
move_dp -7
change 1
move_dp 7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_631      ;continue looping if non-zero
loop_bottom_4_1_631:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_632   ;jump over loop body if data is 0
loop_top_4_2_632:
 
change -1
move_dp 7
change 1
move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_633   ;jump over loop body if data is 0
loop_top_5_1_633:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_633      ;continue looping if non-zero
loop_bottom_5_1_633:

move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_634   ;jump over loop body if data is 0
loop_top_5_2_634:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_634      ;continue looping if non-zero
loop_bottom_5_2_634:

change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_632      ;continue looping if non-zero
loop_bottom_4_2_632:

move_dp -10

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_3_630      ;continue looping if non-zero
loop_bottom_3_3_630:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_13_627      ;continue looping if non-zero
loop_bottom_2_13_627:

move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_14_635   ;jump over loop body if data is 0
loop_top_2_14_635:
 
change -1
move_dp -8
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_14_635      ;continue looping if non-zero
loop_bottom_2_14_635:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_15_636   ;jump over loop body if data is 0
loop_top_2_15_636:
 
change -1
move_dp 8
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_637   ;jump over loop body if data is 0
loop_top_3_1_637:
 
move_dp 1
change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_638   ;jump over loop body if data is 0
loop_top_4_1_638:
 
change -1
move_dp -5
change -1
move_dp 5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_638      ;continue looping if non-zero
loop_bottom_4_1_638:

move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_639   ;jump over loop body if data is 0
loop_top_4_2_639:
 
change -1
move_dp 5
change 1
move_dp -5

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_639      ;continue looping if non-zero
loop_bottom_4_2_639:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_637      ;continue looping if non-zero
loop_bottom_3_1_637:

move_dp -1
change 1
move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_2_640   ;jump over loop body if data is 0
loop_top_3_2_640:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_641   ;jump over loop body if data is 0
loop_top_4_1_641:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_641      ;continue looping if non-zero
loop_bottom_4_1_641:

move_dp -15

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_2_640      ;continue looping if non-zero
loop_bottom_3_2_640:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_3_642   ;jump over loop body if data is 0
loop_top_3_3_642:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_3_642      ;continue looping if non-zero
loop_bottom_3_3_642:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_4_643   ;jump over loop body if data is 0
loop_top_3_4_643:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_644   ;jump over loop body if data is 0
loop_top_4_1_644:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_644      ;continue looping if non-zero
loop_bottom_4_1_644:

move_dp -1
change -1
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_645   ;jump over loop body if data is 0
loop_top_4_2_645:
 
change -1
move_dp -8
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_646   ;jump over loop body if data is 0
loop_top_5_1_646:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_646      ;continue looping if non-zero
loop_bottom_5_1_646:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_647   ;jump over loop body if data is 0
loop_top_5_2_647:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_647      ;continue looping if non-zero
loop_bottom_5_2_647:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_645      ;continue looping if non-zero
loop_bottom_4_2_645:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_648   ;jump over loop body if data is 0
loop_top_4_3_648:
 
change -1
move_dp 7
change 1
move_dp -7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_648      ;continue looping if non-zero
loop_bottom_4_3_648:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_4_643      ;continue looping if non-zero
loop_bottom_3_4_643:

move_dp 8
change -1
move_dp -5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_5_649   ;jump over loop body if data is 0
loop_top_3_5_649:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_5_649      ;continue looping if non-zero
loop_bottom_3_5_649:

change 1
move_dp -3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_15_636      ;continue looping if non-zero
loop_bottom_2_15_636:

change 1
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_16_650   ;jump over loop body if data is 0
loop_top_2_16_650:
 
change -1
move_dp -8
change -1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_16_650      ;continue looping if non-zero
loop_bottom_2_16_650:

change 1
move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_2_17_651   ;jump over loop body if data is 0
loop_top_2_17_651:
 
change -1
move_dp 8
change -1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_1_652   ;jump over loop body if data is 0
loop_top_3_1_652:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_653   ;jump over loop body if data is 0
loop_top_4_1_653:
 
change -1
move_dp 2
change 1
move_dp -2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_653      ;continue looping if non-zero
loop_bottom_4_1_653:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_1_652      ;continue looping if non-zero
loop_bottom_3_1_652:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_2_654   ;jump over loop body if data is 0
loop_top_3_2_654:
 
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_655   ;jump over loop body if data is 0
loop_top_4_1_655:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_655      ;continue looping if non-zero
loop_bottom_4_1_655:

move_dp -1
change -1
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_656   ;jump over loop body if data is 0
loop_top_4_2_656:
 
change -1
move_dp -8
change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_657   ;jump over loop body if data is 0
loop_top_5_1_657:
 
move_dp -1
change -1
move_dp 1
change -1
move_dp -2
change 1
move_dp 2

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_657      ;continue looping if non-zero
loop_bottom_5_1_657:

move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_658   ;jump over loop body if data is 0
loop_top_5_2_658:
 
change -1
move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_658      ;continue looping if non-zero
loop_bottom_5_2_658:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_656      ;continue looping if non-zero
loop_bottom_4_2_656:

move_dp -7

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_659   ;jump over loop body if data is 0
loop_top_4_3_659:
 
change -1
move_dp 7
change 1
move_dp -7

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_659      ;continue looping if non-zero
loop_bottom_4_3_659:

move_dp -1
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_2_654      ;continue looping if non-zero
loop_bottom_3_2_654:

move_dp 1
change 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_3_660   ;jump over loop body if data is 0
loop_top_3_3_660:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_661   ;jump over loop body if data is 0
loop_top_4_1_661:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_661      ;continue looping if non-zero
loop_bottom_4_1_661:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_3_660      ;continue looping if non-zero
loop_bottom_3_3_660:

move_dp 5
change 1
move_dp 27
change 1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_4_662   ;jump over loop body if data is 0
loop_top_3_4_662:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_4_662      ;continue looping if non-zero
loop_bottom_3_4_662:

move_dp 9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_5_663   ;jump over loop body if data is 0
loop_top_3_5_663:
 
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_664   ;jump over loop body if data is 0
loop_top_4_1_664:
 
change -1
move_dp -6
change -1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_664      ;continue looping if non-zero
loop_bottom_4_1_664:

change 1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_2_665   ;jump over loop body if data is 0
loop_top_4_2_665:
 
change -1
move_dp 6
change -1
move_dp 2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_666   ;jump over loop body if data is 0
loop_top_5_1_666:
 
change -1
move_dp -8
change 1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_666      ;continue looping if non-zero
loop_bottom_5_1_666:

move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_667   ;jump over loop body if data is 0
loop_top_5_2_667:
 
change -1
move_dp 8
change 1
move_dp -17

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_668   ;jump over loop body if data is 0
loop_top_6_1_668:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_668      ;continue looping if non-zero
loop_bottom_6_1_668:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_669   ;jump over loop body if data is 0
loop_top_6_2_669:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_669      ;continue looping if non-zero
loop_bottom_6_2_669:

change 1
move_dp 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_670   ;jump over loop body if data is 0
loop_top_6_3_670:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_670      ;continue looping if non-zero
loop_bottom_6_3_670:

move_dp 1
change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_667      ;continue looping if non-zero
loop_bottom_5_2_667:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_2_665      ;continue looping if non-zero
loop_bottom_4_2_665:

change 1
move_dp 8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_3_671   ;jump over loop body if data is 0
loop_top_4_3_671:
 
change -1
move_dp -8
change -1
move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_3_671      ;continue looping if non-zero
loop_bottom_4_3_671:

change 1
move_dp -8

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_4_672   ;jump over loop body if data is 0
loop_top_4_4_672:
 
change -1
move_dp 8
change -1
move_dp -2

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_673   ;jump over loop body if data is 0
loop_top_5_1_673:
 
change -1
move_dp -6
change 1
move_dp 6

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_673      ;continue looping if non-zero
loop_bottom_5_1_673:

move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_2_674   ;jump over loop body if data is 0
loop_top_5_2_674:
 
change -1
move_dp 6
change 1
move_dp -15

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_1_675   ;jump over loop body if data is 0
loop_top_6_1_675:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_1_675      ;continue looping if non-zero
loop_bottom_6_1_675:

move_dp 3

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_2_676   ;jump over loop body if data is 0
loop_top_6_2_676:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_2_676      ;continue looping if non-zero
loop_bottom_6_2_676:

change 1
move_dp 6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_3_677   ;jump over loop body if data is 0
loop_top_6_3_677:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_3_677      ;continue looping if non-zero
loop_bottom_6_3_677:

move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_6_4_678   ;jump over loop body if data is 0
loop_top_6_4_678:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_6_4_678      ;continue looping if non-zero
loop_bottom_6_4_678:

change 1
move_dp -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_2_674      ;continue looping if non-zero
loop_bottom_5_2_674:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_4_672      ;continue looping if non-zero
loop_bottom_4_4_672:

change 1
move_dp 1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_5_679   ;jump over loop body if data is 0
loop_top_4_5_679:
 
change -1
move_dp -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_5_1_680   ;jump over loop body if data is 0
loop_top_5_1_680:
 
move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_5_1_680      ;continue looping if non-zero
loop_bottom_5_1_680:

move_dp -8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_5_679      ;continue looping if non-zero
loop_bottom_4_5_679:

move_dp 8

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_5_663      ;continue looping if non-zero
loop_bottom_3_5_663:

move_dp -9

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_6_681   ;jump over loop body if data is 0
loop_top_3_6_681:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_6_681      ;continue looping if non-zero
loop_bottom_3_6_681:

move_dp 4

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_7_682   ;jump over loop body if data is 0
loop_top_3_7_682:
 
change -1

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_7_682      ;continue looping if non-zero
loop_bottom_3_7_682:

move_dp -3
change 5

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_8_683   ;jump over loop body if data is 0
loop_top_3_8_683:
 
change -1

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_4_1_684   ;jump over loop body if data is 0
loop_top_4_1_684:
 
change -1
move_dp 9
change 1
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_4_1_684      ;continue looping if non-zero
loop_bottom_4_1_684:

move_dp 9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_8_683      ;continue looping if non-zero
loop_bottom_3_8_683:

move_dp 5
change -1
move_dp 27
change -1
move_dp -6

mov al,[rbx+r8]
test al,al       ;sets zf=1 if al =0
jz loop_bottom_3_9_685   ;jump over loop body if data is 0
loop_top_3_9_685:
 
move_dp -9

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_3_9_685      ;continue looping if non-zero
loop_bottom_3_9_685:


mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_2_17_651      ;continue looping if non-zero
loop_bottom_2_17_651:

move_dp 3

mov al,[rbx+r8] ;put the value of data_tape[dp] into rax
test al,al     ;set zf=1 if rax & rax =0
jnz loop_top_1_9_12      ;continue looping if non-zero
loop_bottom_1_9_12:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START EPILOGUE;;;;;;;;;;;;;;
;exit with return code 0 once our program has finished executing
        mov rax,60
        mov rdi,0
        syscall    ;exit with return code 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END EPILOGUE;;;;;;;;;;;;;;;;;;;;;;;;;;;