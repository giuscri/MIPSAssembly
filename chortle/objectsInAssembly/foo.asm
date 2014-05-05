## foo.asm

            .text
            .globl      main

main:

            ## Push $ra onto the stack ...
            subu        $sp, $sp, 4
            sw          $ra, 0($sp)

            ## Push $fp onto the stack ...
            subu        $sp, $sp, 4
            sw          $fp, 0($sp)

            ## Make room for two var's ...
            subu        $fp, $sp, 8
            move        $sp, $fp

            ## Initialize ptr to sub1add ...
            la          $t0, sub1add
            sw          $t0, 0($fp)

            ## Initialize ctr to 0 ...
            sw          $zero, 4($fp)

mainLoop:

            ## If ctr >= 3, endMainLoop ...
            lw          $t0, 4($fp)
            li          $t1, 3
            bge         $t0, $t1, endMainLoop

            ## Else, call function at ptr ...
            lw          $t0, 0($fp)
            lw          $t1, 0($t0)
            jalr        $t1
            nop

            ## Then continue ...
            j           continueMainLoop
            nop

continueMainLoop:

            ## Increment ctr by 1 ...
            lw          $t0, 4($fp)
            addu        $t0, $t0, 1
            sw          $t0, 4($fp)

            ## Increment ptr by 4 ...
            lw          $t0, 0($fp)
            addu        $t0, $t0, 4
            sw          $t0, 0($fp)

            ## Jump to the top of the loop ...
            j           mainLoop
            nop

endMainLoop:

            ## Delete room for the two var's ...
            addu        $fp, $sp, 8
            move        $sp, $fp

            ## Pop out $fp ...
            lw          $fp, 0($sp)
            addu        $sp, $sp, 4

            ## Pop out $ra ...
            lw          $ra, 0($sp)
            addu        $sp, $sp, 4

exit:

            ## Jump back to the caller ...
            jr          $ra

            .data
sub1add:    .word       sub1
sub2add:    .word       sub2
sub3add:    .word       sub3

            .text
sub1:       li          $v0, 4
            la          $a0, messH
            syscall
            jr          $ra
            .data
messH:      .asciiz     "Hello "

            .text
sub2:       li          $v0, 4
            la          $a0, messW
            syscall
            jr          $ra
            .data
messW:      .asciiz     "World\n"

            .text
sub3:       li          $v0, 4
            la          $a0, wonderStr
            syscall
            jr          $ra
            .data
wonderStr:  .asciiz     "Wonderful"
