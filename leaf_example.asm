# leaf_example -- Implementing the following
# function (I'm using C-like sintax now ...)
# leaf_example(g,h,i,j) {return g+h - i+j;}

# By convention: $t... should *not* be preserved
# during procedure calling, while $s... yes.

        .text
main:

        li        $a0, 1
        li        $a1, 2
        li        $a2, 3
        li        $a3, 4

        jal       leaf_example

        move      $a0, $v0
        li        $v0, 1
        syscall

exit:
        li        $v0, 10
        syscall

leaf_example:

        addi      $sp, $sp, -32
        lw        $s0, 0($sp)
        lw        $t0, 4($sp)
        lw        $t1, 8($sp)

        add       $t0, $a0, $a1
        add       $t1, $a2, $a3
        sub       $s0, $t0, $t1

        move      $v0, $s0

        sw        $s0, 0($sp)
        sw        $t0, 4($sp)
        sw        $t1, 8($sp)

        addi      $sp, $sp, 32

        jr        $ra
