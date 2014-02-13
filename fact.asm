## fact.asm -- Using a recursive procedure to
## compute n!

        .text
main:

        ## Computing 4! -- which is 4*3*2*1 == 24 ...
        li        $a0, 4
        jal       fact

        ## Prints the result, stored in v0 ...
        move      $a0, $v0
        li        $v0, 1
        syscall

        ## Exit procedure ...
exit:
        li        $v0, 10
        syscall

        ## Computing a0! ...
fact:
        beq       $a0, 1, L1

        ## Store inside the stack return-address
        ## and a0, since we're going to use both ...
        addi      $sp, $sp, -32
        sw        $ra, 0($sp)
        sw        $a0, 4($sp)

        ## Prepare the argument a0 for the next
        ## factorial step ...
        addi      $a0, $a0, -1

        ## Call fact again, now with a0-1 ...
        jal       fact
       
        ## Restore a0, ra, previously stored
        ## in the stack ... 
        lw        $a0, 4($sp)
        lw        $ra, 0($sp)

        ## Restore the stack pointer ...
        addi      $sp, $sp, 32

        ## Computing a step of a factorial ...
        mul       $v0, $a0, $v0

        ## Jumping back the last call of fact ...
        j         $ra


        ## If a0 == 1, then 1! == 1 ...
L1:
        li        $v0, 1
        j         $ra
