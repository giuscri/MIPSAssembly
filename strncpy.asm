## strncpy.asm -- Implementing the following C-like
## procedure:
## for (i=0; (x[i]=y[i])!='\0';) {i++;}

        .text
main:
        la         $a0, x
        la         $a1, y

        jal        strncpy

        la         $a0, y
        li         $v0, 4
        syscall

exit:
        li         $v0, 10
        syscall

strncpy:

        li         $t0, 0
while:
        add        $t2, $a0, $t0
        add        $t3, $a1, $t0

        lb         $t1, ($t2)

        sb         $t1, ($t3)

        beq        $t1, 0, R

        addi       $t0, $t0, 1
        b          while

R:
        jr         $ra

        .data
x:      .asciiz    "foo\n"
y:      .space     32
