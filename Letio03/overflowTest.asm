## Testing Overflow exceptions ... but it does not work!

        .text
main:

        ## Storing two terms to make them multiply ...        
        li        $t0, -2
        li        $t1, 2

        ## Actually multiply them ...
        mult      $t0, $t1

        ## Move the 'highest' token into a0 ...
        mfhi      $a0


        ## If it's not zero, overflow has occured. Jump to that block before quitting ...
        bnez      $a0, overflowreached_block
	
	li        $v0, 1
        syscall
        la        $a0, newline_str
        li        $v0, 4
        syscall

        ## ... else!, print the result ...
        mflo      $a0
        li        $v0, 1
        syscall
        la        $a0, newline_str
        li        $v0, 4
        syscall

exit:

        li        $v0, 10
        syscall

overflowreached_block:

        ## Print a string for making the user to know overflow has occurred ...
        la        $a0, overflowreached_str
        li        $v0, 4
        syscall
        la        $a0, newline_str
        li        $v0, 4
        syscall

        ## Hence, exit ...
        j         exit

        .data

newline_str:
        .asciiz   "\n"

overflowreached_str:
        .asciiz   "Overflow reached!"
