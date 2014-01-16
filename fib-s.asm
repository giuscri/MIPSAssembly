# fib-- (callee-save method)
# It is the callee that save ...?!
# Registers used:
#        $a0       -- initially n
#        $s0       -- parameter n
#        $s1       -- fib (n-1)
#        $s2       -- fib (n-2)

# Sequence is:
## fib (0) == 1
## fib (1) == 1
## fib (2) == 2
## fib (3) == 3
## fib (4) == 5
## ...and so on.

         .text
main:
         li        $a0, 5                  # computing fib (5)
         jal       fib
         b         exit
fib:
         subu      $sp, $sp, 32            # frame size = 32, just because...
         sw        $ra, 28($sp)            # preserve the Return Address.
         sw        $fp, 24($sp)            # preserve the Frame Pointer.
         sw        $s0, 20($sp)            # preserve $s0.
         sw        $s1, 16($sp)            # preserve $s1.
         sw        $s2, 12($sp)            # preserve $s2.
         addu      $fp, $sp, 32            # move Frame Pointer to base of frame.

         move      $s0, $a0                # get n from caller
         
         blt       $s0, 2, fib_base_case   # if n < 2, then do base case

         sub       $a0, $s0, 1             # compute fib (n-1)
         jal       fib                     #
         move      $s1, $v0                # s1 = fib (n-1).

         sub       $a0, $s0, 2             # compute fib (n-2)
         jal       fib                     #
         move      $s2, $v0                # $s2 = fib (n-2).

         add       $v0, $s1, $s2           # $v0 = fib (n-1) + fib (n-2).
         b         fib_return

fib_base_case:                             # in the base case, return 1.
         li        $v0, 1

fib_return:
         lw        $ra, 28($sp)            # restore the Return Address.
         lw        $fp, 24($sp)            # restore the Frame Pointer.
         lw        $s0, 20($sp)            # restore $s0
         lw        $s1, 16($sp)            # restore $s1
         lw        $s2, 12($sp)            # restore $s2
         addu      $sp, $sp, 32            # restore the Stack Pointer.
         jr        $ra                     # return.

exit:
         move      $a0, $v0
         li        $v0, 1
         syscall

         la        $a0, newline
         li        $v0, 4
         syscall

         li        $v0, 10
         syscall

         .data
newline:           .asciiz "\n"
