## palindrome.asm -- Ask user to type a string hence
##                   check if it is palindrome.

        .text
main:
        ## Ask user to type a string ...
        la          $a0, typestring_msg
        li          $v0, 4
        syscall

        ## Load the string ...
        la          $a0, m_str
        li          $v0, 8
        syscall

        ## Load newline character ...
        la          $t2, newline
        lb          $t2, ($t2)
  
        ## Get the address of newline character ...
getnewlineaddress_loop:
        lb          $t0, ($a0)
        beq         $t0, $t2, endgetnewlineaddress_loop
        add         $a0, $a0, 1
        b           getnewlineaddress_loop
endgetnewlineaddress_loop:

        ## Store both first readable character address in t0, last in a0 ...
        la          $t0, m_str
        add         $a0, $a0, -1

        ## Check if loaded string is palindrome ...
checkpalindromeness_loop:
        lb          $t1, ($t0)
        lb          $t2, ($a0)
        bne         $t1, $t2, not_palindrome_msg
        add         $t0, $t0, 1
        add         $a0, $a0, -1
        ble         $t0, $a0, checkpalindromeness_loop
        b           palindrome_msg

        not_palindrome_msg:
        la          $a0, negative_msg
        li          $v0, 4
        syscall
        b           endcheckpalindromeness_loop

        palindrome_msg:
        la          $a0, positive_msg
        li          $v0, 4
        syscall
        b           endcheckpalindromeness_loop
endcheckpalindromeness_loop:



exit:
        li          $v0, 10
        syscall

        .data
typestring_msg:     .asciiz "Type a string:\n"
m_str:              .space 500
newline:            .byte  0x0A
negative_msg:       .asciiz "String is not palindrome\n"
positive_msg:       .asciiz "String is palindrome\n"
