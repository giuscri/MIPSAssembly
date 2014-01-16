# multiples.asm -- Prints every multiple
#                  of A, from A to A*B.

      .text
main:
      ## Ask to type the first number, A ...
      li    $v0, 4
      la    $a0, first_request
      syscall

      ## Store A in t0 ...
      li    $v0, 5
      syscall
      move  $t0, $v0

      ## Ask to type the second number, B ...
      li    $v0, 4
      la    $a0, second_request
      syscall

      ## Store B in t1 ...
      li    $v0, 5
      syscall
      move  $t1, $v0 
      ## DEBUG: Print A ...
      la    $a0, debug_t0
      li    $v0, 4
      syscall
      move  $a0, $t0
      li    $v0, 1
      syscall
      la    $a0, newline
      li    $v0, 4
      syscall

      ## DEBUG: Print B ...
      la    $a0, debug_t1
      li    $v0, 4
      syscall
      move  $a0, $t1
      li    $v0, 1
      syscall
      la    $a0, newline
      li    $v0, 4
      syscall


      ## If B <= 0, exit ...
      blez  $t1, exit


      ## Store max value A*B at t3 ... 
      mul   $t3, $t0, $t1
      ## Store tmp multiple in t1 ...
      move  $t1, $t0
loop:
      ## DEBUG: print m ...
      la    $a0, debug_m
      li    $v0, 4
      syscall
      move  $a0, $t1
      li    $v0, 1
      syscall
      la    $a0, newline
      li    $v0, 4
      syscall

      ## If m >= S, break ...
      bge   $t1, $t3, endloop

      ## Else, m += A ...
      add   $t1, $t1, $t0

      ## Continue ...
      b     loop

endloop:
exit:
      ## Exit ...
      li    $v0, 10
      syscall

      .data
first_request:
            .asciiz "Type the first number: "
second_request:
            .asciiz "Type the second number: "

debug_t0:
            .asciiz "DEBUG: t0 == "
debug_t1:
            .asciiz "DEBUG: t1 == "
debug_m:
            .asciiz "DEBUG: m == "

newline:
            .ascii  "\n"
