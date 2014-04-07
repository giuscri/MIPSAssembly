# Task02, Letio03
# Write the procedure for computing the sum
# of two integers (known at runtime ...) and store
# them into an array A of size 2. Hence print the array ...

        .text
main:

        ## ...
        la             $s0, A
        move           $t0, $s0

        ## Asking user to type the first number ...
        li             $v0, 4
        la             $a0, typethefirstnumber
        syscall
        li             $v0, 5
        syscall
        sw             $v0, 0($t0)

        ## Asking user to type the second number ...
        li             $v0, 4
        la             $a0, typethesecondnumber
        syscall
        li             $v0, 5
        syscall
        add            $t0, $t0, 4
        sw             $v0, 0($t0)

        ## Printing the filled array ...

        move           $t0, $s0

        la             $a0, arraystoredis_str
        li             $v0, 4
        syscall

        la             $a0, leftsquarebracket_str
        li             $v0, 4
        syscall

        la             $a0, blankspace_str
        syscall

        lw             $a0, 0($t0)
        li             $v0, 1
        syscall

        la             $a0, blankspace_str
        li             $v0, 4
        syscall

        add            $t0, $t0, 4

        lw             $a0, 0($t0)
        li             $v0, 1
        syscall

        la             $a0, blankspace_str
        li             $v0, 4
        syscall

        la             $a0, rightsquarebracket_str
        li             $v0, 4
        syscall

exit:

        ## Printing a newline before quitting ...
        la             $a0, newline_str
        li             $v0, 4
        syscall

        ## Hence quit ...
        li             $v0, 10
        syscall

        .data

A:      
        ## Making room for an array of 2 int's ...
        .space         8

typethefirstnumber:
        .asciiz        "Type the first number: "
typethesecondnumber:
        .asciiz        "Type the second number: "
arraystoredis_str:
        .asciiz        "Array stored is: "
leftsquarebracket_str:
        .asciiz        "["
rightsquarebracket_str:
        .asciiz        "]"
blankspace_str:
        .asciiz        " "
newline_str:
        .asciiz        "\n"
