# Task01
# Write the procedure for computing the
# sum of two integers punched on the keyboard
# by the user.

        .text
main:
     
        ## Asking user to put the first number; store it into s0 ...
        li           $v0, 4  
        la           $a0, typethefirstnumber_str
        syscall
        li           $v0, 5
        syscall
        move         $s0, $v0

        ## Asking user to put the second number; store it into s1 ...
        li           $v0, 4
        la           $a0, typethesecondnumber_str
        syscall
        li           $v0, 5
        syscall
        move         $s1, $v0

        ## Compute and print their sum ...
        li           $v0, 4
        la           $a0, theirsumis_str
        syscall
        li           $v0, 1
        add          $a0, $s0, $s1
        syscall

exit:

        ## Printing a newline before quitting ...
        li           $v0, 4
        la           $a0, newline_str
        syscall

        ## Hence quit ...
        li           $v0, 10
        syscall

        .data
typethefirstnumber_str:
        .asciiz      "Type the first number: "
typethesecondnumber_str:
        .asciiz      "Type the second number: "
theirsumis_str:
        .asciiz      "Their sum is: "
newline_str:
        .asciiz      "\n"
