## foobar.asm
## 
## Inspired by the exercise 5 from
## > http://chortle.ccsu.edu/AssemblyTutorial/Chapter-36/ass36programs.html
##

                .text
                .globl          main

## http://youtu.be/4smim2MNvF8

main:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for a ptr ...
                subu            $fp, $sp, 4
                move            $sp, $fp

                ## Allocate enough space onto the heap for object1 ...
                li              $v0, 9
                li              $a0, 16
                syscall
                sw              $v0, 0($fp)

                ## Populate its jump table ...
                lw              $t0, 0($fp)
                la              $t1, set
                sw              $t1, 4($t0)
                la              $t1, double
                sw              $t1, 8($t0)
                la              $t1, print
                sw              $t1, 12($t0)

                ## Call object1.set(self, 5) ...
                lw              $t0, 0($fp)
                li              $t1, 5
                lw              $t2, 4($t0)
                move            $a0, $t0
                move            $a1, $t1
                jalr            $t2
                nop

                ## Call object1.double(self) ...
                lw              $t0, 0($fp)
                lw              $t1, 8($t0)
                move            $a0, $t0
                jalr            $t1
                nop

                ## Call object1.print(self) ...
                lw              $t0, 0($fp)
                lw              $t1, 12($t0)
                move            $a0, $t0
                jalr            $t1
                nop

                ## Delete room for the ptr ...
                addu            $fp, $sp, 4
                move            $sp, $fp

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

object1:        .word           0

                .text

set:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for two var's ...
                subu            $fp, $sp, 8
                move            $sp, $fp

                ## Store this into ptr ...
                sw              $a0, 0($fp)

                ## Store integer into numb ...
                sw              $a1, 4($fp)

                ## Store integer at this.value ...
                lw              $t0, 0($fp)
                lw              $t1, 4($fp)
                sw              $t1, 0($t0)

                ## Delete room for the two var's ...
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

double:

                ## Push $ra onto the stack ...
                subu            $sp, $sp, 4
                sw              $ra, 0($sp)

                ## Push $fp onto the stack ...
                subu            $sp, $sp, 4
                sw              $fp, 0($sp)

                ## Make room for one ptr ...
                subu            $fp, $sp, 4
                move            $sp, $fp

                ## Store this into ptr ...
                sw              $a0, 0($fp)

                ## this.value *= 2 ...
                lw              $t0, 0($fp)
                lw              $t1, 0($t0)
                addu            $t1, $t1, $t1
                sw              $t1, 0($t0)

                ## Delete room for the ptr ...
                addu            $fp, $sp, 4
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

                ## Make room for one ptr ...
                subu            $fp, $sp, 4
                move            $sp, $fp

                ## Store this into ptr ...
                sw              $a0, 0($fp)

                ## Print this.value ...
                lw              $t0, 0($fp)
                lw              $a0, 0($t0)
                li              $v0, 1
                syscall
                la              $a0, lf
                li              $v0, 4
                syscall

                ## Delete room for the ptr ...
                addu            $fp, $sp, 4
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


