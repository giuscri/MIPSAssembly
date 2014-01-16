      .text
main:
bubbleSort:
      li      $t0, 0                    # t0 contains swapped, == false
      li      $t2, 1                    # t2 contains i, starting from 1
for_loop:
      bge     $t2, 5, endfor_loop       # if i >= 5, break

      la      $t1, A                    # put address of A into t1
      move    $t3, $t2                  # put i into t3
      move    $t4, $t2                  
      add     $t4, $t4, -1              # put i-1 into t4

      add     $t3, $t3, $t3             # double i
      add     $t3, $t3, $t3             # double i again (now 4x)

      add     $t4, $t4, $t4             # double i-1
      add     $t4, $t4, $t4             # double i-1 again (now 4x)

      add     $t5, $t1, $t3             # put &A[i] into t5
      add     $t6, $t1, $t4             # put &A[i-1] into t6

      lw      $t7, 0($t5)               # put A[i] into t7
      lw      $t8, 0($t6)               # put A[i-1] into t8

      ble     $t8, $t7, continue        # if A[i-1] <= A[i], continue
      
      sw      $t8, 0($t5)               # else, load A[i] into &A[i-1]
      sw      $t7, 0($t6)               # hence A[i-1] into &A[i]

      li      $t0, 1                    # set swapped as true

continue:
      add     $t2, $t2, 1               # i += 1
      b       for_loop                  # repeat

endfor_loop:
      bnez    $t0, bubbleSort           # if swapped is true, repeat
                                        # else, go to the next instruction
      la      $t0, A
      li      $t1, 0
print_loop:
      add     $t3, $t3, $t3             # double i
      add     $t3, $t3, $t3             # double i again (now 4x)

      add     $t0, $t0, $t3             # put &A[i] into t0
      lw      $t2, 0($t0)               # put A[i] into t2
      move    $a0, $t2                  # put A[i] as parameter for next syscall
      li      $v0, 1                    # load print_int syscall parameter
      syscall                           # make the syscall

      add     $t1, $t1, 1               # increment i
      bge     $t1, 5, end_print_loop    # if i >= 5, break

      b       print_loop                # else, repeat
end_print_loop:

      la      $a0, newline              # load address of '\n\0'
      li      $v0, 4                    # load print_string syscall parameter
      syscall                           # make the syscall

exit:
      li      $v0, 10                   # load exit syscall parameter
      syscall                           # make the syscall

      .data
A:            .word -2, 4, 7, 3, 7      # int A[] = {-2, 4, 7, 3, 7, ...};
newline:      .asciiz "\n"

