# hello.asm -- A "Hello World" program.
# Registers used:
#       $v0     - syscall parameter and return value
#       $a0     - syscall parameter -- the string to print

        .text
main:
        la      $a0, hello_msg  # load the addr of hello_msg into $a0
        li      $v0, 4          # 4 is the print_string syscall
        syscall

        ## Return part ...
        li      $v0, 10         # 10 is the exit syscall
        syscall

# Data for the program:
        .data
hello_msg:      .byte  0x48
                .byte  0x65
                .byte  0x6c
                .byte  0x6c
                .byte  0x6f
                .byte  0x0a
                .byte  0x00

# end hello.asm
