## atoi.asm  --  This program implements the read_int
##               syscall by the read_string syscall
##               We're implementing the same algorithm
##               presented at page 37 of the book for CS50
##               of Daniel J. Ellard (Sept. 1994).

        .text
main:
        ## Load a string ...
        la        $a0, str_space
        li        $a1, 1024
        li        $v0, 8
        syscall

        ## Let t0 be S, a ptr to start of the str ...
        la        $t0, str_space

        ## Let t1 be D, our tmp integer ...
        li        $t1, 0

get_sign:
        li        $t3, 1
        lb        $t2, ($t0)
        bne       $t2, '-', positive
        li        $t3, -1
        add       $t0, $t0, 1
positive:
        bne       $t2, '+', sum_loop
        add       $t0, $t0, 1

sum_loop:
        ## if *S == '\n', break ...
        lb        $t2, ($t0)
        beq       $t2, 10, end_sum_loop
        blt       $t2, '0', end_sum_loop
        bgt       $t2, '9', end_sum_loop

        ## D = D * 10 ...
        mul       $t1, $t1, 10
        mfhi      $t5
        bnez      $t5, overflow
        blt       $t1, $0, overflow

        ## t2 = *S - '0' ...
        sub       $t2, $t2, 48

        ## D = D + (*S - '0') ...
        add       $t1, $t1, $t2

        ## S = S + 1 ...
        add       $t0, $t0, 1

        b         sum_loop
end_sum_loop:

        ## Adjust sign ...
        mul       $t1, $t1, $t3
        ## Print D ...
        move      $a0, $t1
        li        $v0, 1
        syscall

        ## Print a newline character, before quitting ...
        la        $a0, newline
        li        $v0, 4
        syscall

exit:
        li        $v0, 10
        syscall

overflow:
        la        $a0, overflow_msg
        li        $v0, 4
        syscall
        b         exit


        .data
str_space:        .space  1024
newline:          .asciiz "\n"
overflow_msg:     .asciiz "Overflow occurred!\n"
