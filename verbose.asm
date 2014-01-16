          .text
main:
          la       $a0, m_str       # load m_str-address as a parameter
          li       $v0, 8           # load read_string as a syscall-parameter
          syscall                   # make the syscall

          la       $t0, m_str       # load the begin-string ptr in t0
          li       $t2, 0           # init of char-counter

printchar_loop:

          lb       $t1, ($t0)       # load char pointed by t0

          la       $a0, debug_msg   # load the dbg part of output
          li       $v0, 4           # load print_string as a syscall-parameter
          syscall                   # make the syscall

          move     $a0, $t1         
          li       $v0, 1
          syscall

          la       $a0, newline
          li       $v0, 4
          syscall

          lb       $t3, newline
          beq      $t1, $t3, endprintchar_loop
          
          addi     $t0, $t0, 1    # update begin-string pointer
          addi     $t2, $t2, 1    # increment char-counter

          b        printchar_loop

endprintchar_loop:

          ## Print str-length ...
          move     $a0, $t2
          li       $v0, 1
          syscall
          la       $a0, newline
          li       $v0, 4
          syscall
          
exit:
          li       $v0, 10
          syscall


          .data
m_str:
          .space 500              # allocate 500bytes of space
debug_msg:
          .asciiz "DEBUG: Current character is ... "
newline:
          .byte  0x0a

