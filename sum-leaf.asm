# sum-leaf.asm -- Using a leaf procedure.
# Remember that *by convention* registers
# are used this way: $a... four argument
# reg's in which to pass parameters,
# $v... two value registers in which to
# return values, $ra one return address
# register to return to the point of origin.
        .text
main:

        ## Set a0 as 15 and copy the same
        ## value to a1 ... {
        li        $a0, 15 
        add       $a1, $a0, $zero
        ## }

        ## Copy the next-instruction's address
        ## into ra, then jump to the sum label
        jal       sum

        ## Move the returned value into a0
        ## hence load the '1' value to the syscaller
        ## then make the syscall ... {
        add       $a0, $v0, $zero
        li        $v0, 1
        syscall
        ## }

        ## Print a newline before exit ... {
        la        $a0, newline_str
        li        $v0, 4
        syscall
        ## }
    

exit:

        li        $v0, 10
        syscall

sum:
        add       $v0, $a0, $a1
        jr        $ra

        .data
welcome_str:      .asciiz        "This process will print 15+15\n"
newline_str:      .asciiz        "\n"
