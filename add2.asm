# add2.asm -- A program that computes and prints
#             the sum of two numbers specified 
#             at runtime by the user.
# Register used:
#       $t0    - used to hold the first number
#       $t1    - used to hold the second number
#       $t2    - used to hold the sum of $t1 and $t2
#       $v0    - syscall parameter

main:                              # SPIM starts from main

        ## Get the first number from user, put into $t0
        li     $v0, 5              # load syscall read_int into $v0
        syscall                    # make the syscall
        move   $t0, $v0            # move the number read into $t0

        ## Get the second number from user, put into $t1
        li     $v0, 5              # load syscall read_int into $v0
        syscall                    # make the syscall
        move   $t1, $v0            # move the number read into $t1

        add    $t2, $t0, $t1       # compute the sum

        ## Prints out $t2
        move   $a0, $t2            # move the number computed into $a0
        li     $v0, 1              # load syscall print_into into $v0
        syscall                    # make the syscall

        li     $v0, 10             # load syscall param
        syscall                    # make the syscall

# end of add2.asm
