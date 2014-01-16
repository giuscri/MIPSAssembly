          .text
main:
          la      $a0, debug_length
          li      $v0, 4
          syscall

exit:
          li      $v0, 10
          syscall

          .data
debug_length:
          .asciiz "DEBUG: length of sample_str == ...\n"
