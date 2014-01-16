# fib-- (caller-save method)
# Registers used:
#       $a0     - initially n.
#       $t0     - parameter n.
#       $t1     - fib (n - 1).
#       $t2     - fib (n - 2).
        .text
main:
        li      $a0, 5
        jal     fib
        b       exit
fib:
        subu    $sp, $sp, 32              # frame size = 32, just because ...
        sw      $ra, 28($sp)              # preserve the Return Address.
        sw      $fp, 24($sp)              # preserve the Frame Pointer.
        addu    $fp, $sp, 32              # move Frame Pointer to base of frame.

        move    $t0, $a0                  # get n from caller.

        blt     $t0, 2, fib_base_case     # if n < 2, then do base case.
                                         
                                          # call function fib (n - 1):
        sw      $t0, 20($sp)              # save n.
        sub     $a0, $t0, 1               # compute fib (n - 1)
        jal     fib
        move    $t1, $v0                  # $t1 = fib (n - 1)
        lw      $t0, 20($sp)              # restore n

                                          # call function fib (n - 2):
        sw      $t0, 20($sp)              # save n.
        sw      $t1, 16($sp)              # save $t1
        sub     $a0, $t0, 2               # compute fib (n - 2)
        jal     fib
        move    $t2, $v0                  # $t2 = fib (n - 2)
        lw      $t0, 20($sp)              # restore n
        lw      $t1, 16($sp)              # restore $t1.

        add     $v0, $t1, $t2             # $v0 = fib (n - 1) + fib (n - 2).
        b       fib_return

fib_base_case:                            # in the base case, return 1.
        li      $v0, 1

fib_return:
        lw      $ra, 28($sp)              # Restore the Return Address.
        lw      $fp, 24($sp)              # restore the Frame Pointer.
        addu    $sp, $sp, 32              # restore th Stack Pointer.
        jr      $ra                       # return.


exit:
        move    $a0, $v0
        li      $v0, 1
        syscall
 
        la      $a0, newline
        li      $v0, 4
        syscall

        li      $v0, 10
        syscall

        .data
newline:        .asciiz      "\n"
