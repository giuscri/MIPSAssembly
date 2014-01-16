# larger.asm -- prints the larger of two numbers
#               specified at runtime by the user.
# Registers used:
#       $t0     - used to hold the first number
#       $t1     - used to hold the second number
#       $t2     - used to store the larger of $t1 and $t2

        .text
main:
        ## Get the first number from user, put into $t0
        li      $v0, 5                  # load syscall read_int into $v0
        syscall                         # make the syscall
        move    $t0, $v0                # store the result of syscall into $t0

        ## Get the second number from user, put into $t1
        li      $v0, 5                  # load syscall read_int into $v0
        syscall                         # make the syscall
        move    $t1, $v0                # store the result of syscall into $t1

        ## if t0 > t1, branch to t0_bigger ...
        bgt     $t0, $t1, t0_bigger 
        ## else ...
        move    $t2, $t1
        b       endif
t0_bigger:
        move $t2, $t0                   # t2 = t0
endif:
        li      $v0, 4                  # load syscall print_string into $v0
        la      $a0, description_msg    # prepare msg to print
        syscall                         # make the syscall

        li      $v0, 1                  # load syscall print_int into $v0
        move    $a0, $t2                # prepare t2 to print
        syscall                         # make the syscall

        la      $v0, 4                  # load syscall print_string into $v0
        la      $a0, newline            # prepare newline to print
        syscall                         # make the syscall

        ## Exit
        li      $v0, 10                 # load syscall exit into $v0
        syscall                         # make the syscall

        .data
description_msg:
        .asciiz "DEBUG: Largest value is "
newline:
        .ascii  "\n"

# End of larger.asm
