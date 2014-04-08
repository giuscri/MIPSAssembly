# Task03
# Computing and printing 1*3, 2*3, 3*3,
# using only two registers (say, $s0 and $t0).
#
# Note that the way stack is managed is *very* much
# illiterate. Don't try this at home, or at least
# do not say I've done it ...
#
# Choice here is to pushing into the stack *only*
# the sum; nothing more.

        .text
main:

        ## Setting the sum at 0 ...
        li        $s0, 0

        ## Making room for a stack frame 32byte large ...
        add       $sp, $sp, -32

        ## Pushing the sum into the stack ...
        sw        $s0, 0($sp)

        ## Loading 1 and 3 as the two terms ...
        add       $s0, $zero, 1
        add       $t0, $zero, 3

        ## Multiply them ...
        mult      $s0, $t0

        ## Store result in t0 ...
        mflo      $t0

        ## Popping the sum from the stack ...
        lw        $s0, 0($sp)

        ## Delete the empty stack frame ...
        add       $sp, $sp, 32

        ## Add the value of t0 to the sum ...
        add       $s0, $s0, $t0

        ## Making room for a stack frame 32byte large ...
        add       $sp, $sp, -32

        ## Pushing the sum into the stack ...
        sw        $s0, 0($sp)

        ## Loading 2 and 3 as the two terms ...
        add       $s0, $zero, 2
        add       $t0, $zero, 3

        ## Multiply them ...
        mult      $s0, $t0

        ## Store result in t0 ...
        mflo      $t0

        ## Popping the sum from the stack ...
        lw        $s0, 0($sp)

        ## Delete the empty stack frame ...
        add       $sp, $sp, 32

        ## Add the value of t0 to the sum ...
        add       $s0, $s0, $t0

        ## Making room for a stack frame 32byte large ... 
        add       $sp, $sp, -32

        ## Pushing the sum into the stack ...
        sw        $s0, 0($sp)

        ## Loading 3 and 3 as the two terms ...
        add       $s0, $zero, 3
        add       $t0, $zero, 3

        ## Multiply them ...
        mult      $s0, $t0

        ## Store result in t0 ...
        mflo      $t0

        ## Popping the sum from the stack ...
        lw        $s0, 0($sp)

        ## Delete the empty stack frame ...
        add       $sp, $sp, 32

        ## Add the value of t0 to the sum ...
        add       $s0, $s0, $t0

        ## Print the sum ...
        add       $a0, $zero, $s0
        li        $v0, 1
        syscall
        la        $a0, newline_str
        li        $v0, 4
        syscall

exit:

        li        $v0, 10
        syscall

        .data

newline_str:
        .asciiz   "\n"
