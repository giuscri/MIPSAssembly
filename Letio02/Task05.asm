# Task05
# Make room for an array A of size 4
# such that
#
#    A[] = { 0, 4, 8, 12 }
# 
# using the data segment.

        .text
main:

        ## Printing the first token of the output string ...
        li        $v0, 4
        la        $a0, Ais_str
        syscall
        la        $a0, leftsquare_str
        syscall
        la        $a0, blank_str
        syscall

        ## Loading &A at t0 ...
        la        $t0, A

        ## Storing A[ 0 ] in t1 ...
        lw        $t1, 0($t0)

        ## Printing t1 and a blank space ...
        li        $v0, 1
        move      $a0, $t1
        syscall
        li        $v0, 4
        la        $a0, blank_str
        syscall

        ## Storing &A +4 in t0 ...
        add       $t0, $t0, 4

        ## Storing A[ 1 ] in t1 ...
        lw        $t1, 0($t0)

        ## Printing t1 and a blank space ...
        li        $v0, 1
        move      $a0, $t1
        syscall
        li        $v0, 4
        la        $a0, blank_str
        syscall

        ## Storing (&A +4) +4 in t0 ...
        add       $t0, $t0, 4

        ## Storing A[ 2 ] in t1 ...
        lw        $t1, 0($t0)

        ## Printing t1 and a blank space ...
        li        $v0, 1
        move      $a0, $t1
        syscall
        li        $v0, 4
        la        $a0, blank_str
        syscall

        ## Storing ((&A +4) +4) +4 in t0 ...
        add       $t0, $t0, 4

        ## Storing A[ 3 ] in t1 ...
        lw        $t1, 0($t0)

        ## Printing t1 ...
        li        $v0, 1
        move      $a0, $t1
        syscall
        li        $v0, 4
        la        $a0, blank_str
        syscall

        ## Printing the last token of the output string ...
        li        $v0, 4
        la        $a0, rightsquare_str
        syscall

exit:

        li        $v0, 4
        la        $a0, newline_str
        syscall

        li        $v0, 10
        syscall

        .data
A:                .word   0 4 8 12
Ais_str:          .asciiz "A is "
leftsquare_str:   .asciiz "["
rightsquare_str:  .asciiz "]"
blank_str:        .asciiz " "
newline_str:      .asciiz "\n"
