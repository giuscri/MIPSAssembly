## bar.asm

                .text
                .globl          main

main:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Call object1.capitalize(this) ...
                la              $t0, object1
                lw              $t1, 16($t0)
                move            $a0, $t0
                jalr            $t1

                # Call object1.print(this) ...
                la              $t0, object1
                lw              $t1, 0($t0)
                move            $a0, $t0
                jalr            $t1

                ## Pop out $fp ...
                lw              $fp, 0($sp)
                addu            $sp, $sp, 4

                ## Pop out $ra ...
                lw              $ra, 0($sp)
                addu            $sp, $sp, 4

exit:

                ## Jump back to the caller ...
                jr              $ra
                nop

                .data

lf:             .asciiz         "\n"

                .data

object1:
                .word           print
                .word           cancel
                .asciiz         "foo"
                .word           clear
                .word           capitalize

                .text

capitalize:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for two ptr's ...
                subu            $fp, $sp, 8
                move            $sp, $fp

                ## Initialize ptr1 such that it points to `this' ...
                sw              $a0, 0($fp)

                ## Initialize ptr2 such that it points to its string ...
                lw              $t0, 0($fp)
                addu            $t0, $t0, 8
                sw              $t0, 4($fp)

capitalizeLoop:

                ## Load character at ptr2 ...
                lw              $t0, 4($fp)
                lbu             $t1, 0($t0)

                ## If it's null, endCapitalizeLoop ...
                lw              $t0, 4($fp)
                lbu             $t1, 0($t0)
                beqz            $t1, endCapitalizeLoop

                ## Else, decrement it by 0x20 ...
                lw              $t0, 4($fp)
                lbu             $t1, 0($t0)
                subu            $t1, $t1, 0x20
                sb              $t1, 0($t0)

                ## Then, continue ...
                j               continueCapitalizeLoop
                nop

continueCapitalizeLoop:

                ## Increment ptr2 by 1 ...
                lw              $t0, 4($fp)
                addu            $t0, $t0, 1
                sw              $t0, 4($fp)

                ## Jump to the top of loop ...
                j               capitalizeLoop
                nop

endCapitalizeLoop:

                ## Delete room for the two ptr's ...
                addu            $fp, $sp, 8
                move            $sp, $fp

                ## Pop out $fp ...
                lw              $fp, 0($sp)
                addu            $sp, $sp, 4

                ## Pop out $ra ...
                lw              $ra, 0($sp)
                addu            $sp, $sp, 4

                ## Jump back to the caller ...
                jr              $ra
                nop

clear:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for two ptr's ...
                subu            $fp, $sp, 8
                move            $sp, $fp

                ## Initialize ptr1 such that it points to `this' ...
                sw              $a0, 0($fp)

                ## Initialize ptr2 such that it points to its string ...
                lw              $t0, 0($fp)
                addu            $t0, $t0, 8
                sw              $t0, 4($fp)

                ## Set the first byte at ptr2 as null ...
                lw              $t0, 4($fp)
                sb              $zero, 0($t0)

                ## Delete room for the two ptr's ...
                addu            $fp, $sp, 8
                move            $sp, $fp

                ## Pop out $fp ...
                lw              $fp, 0($sp)
                addu            $sp, $sp, 4

                ## Pop out $ra ...
                lw              $ra, 0($sp)
                addu            $sp, $sp, 4

                ## Jump back to the caller ...
                jr              $ra
                nop

cancel:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for two ptr's ...
                subu            $fp, $sp, 8
                move            $sp, $fp

                ## Initialize ptr1 such that it points to `this' ...
                sw              $a0, 0($fp)

                ## Initialize ptr2 such that it points to its string ...
                lw              $t0, 0($fp)
                addu            $t0, $t0, 8
                sw              $t0, 4($fp)

cancelLoop:

                ## Load character at ptr2 ...
                lw              $t0, 4($fp)
                lbu             $t1, 0($t0)

                ## If it's null, endCancelLoop ...
                lw              $t0, 4($fp)
                lbu             $t1, 0($t0)
                beqz            $t1, endCancelLoop

                ## Else, replace it with a 'x' ...
                lw              $t0, 4($fp)
                li              $t1, 0x78
                sb              $t1, 0($t0)

                ## Then, continue ...
                j               continueCancelLoop
                nop

continueCancelLoop:

                ## Increment ptr2 by 1 ...
                lw              $t0, 4($fp)
                addu            $t0, $t0, 1
                sw              $t0, 4($fp)

                ## Jump to the top of loop ...
                j               cancelLoop
                nop

endCancelLoop:

                ## Delete room for the two ptr's ...
                addu            $fp, $sp, 8
                move            $sp, $fp

                ## Pop out $fp ...
                lw              $fp, 0($sp)
                addu            $sp, $sp, 4

                ## Pop out $ra ...
                lw              $ra, 0($sp)
                addu            $sp, $sp, 4

                ## Jump back to the caller ...
                jr              $ra
                nop



print:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for two ptr's ...
                subu            $fp, $sp, 8
                move            $sp, $fp

                ## Initialize ptr1 such that it points to `this' ...
                sw              $a0, 0($fp)

                ## Initialize ptr2 such that it points to its string ...
                lw              $t0, 0($fp)
                addu            $t0, $t0, 8
                sw              $t0, 4($fp)

                ## Print this' string ...
                li              $v0, 4
                lw              $a0, 4($fp)
                syscall
                li              $v0, 4
                la              $a0, lf
                syscall

                ## Delete room for the two ptr's ...
                addu            $fp, $sp, 8
                move            $sp, $fp

                ## Pop out $fp ...
                lw              $fp, 0($sp)
                addu            $sp, $sp, 4

                ## Pop out $ra ...
                lw              $ra, 0($sp)
                addu            $sp, $sp, 4

                ## Jump back to the caller ...
                jr              $ra
                nop


