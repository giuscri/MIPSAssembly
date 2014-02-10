## palindrome.asm-- reads a line of text and tests if it is a palindrome.

        .text

main:
                   la             $a0, sample_str
                   li             $a1, 1024
                   li             $v0, 8
                   syscall

                   ## Searching address of null-character
                   ## for sample_str
                   la             $t0, sample_str
length:
                   add            $t0, $t0, 1
                   lb             $t1, ($t0)
                   bne            $t1, 0, length

                   move           $t3, $t0
                   la             $t0, sample_str

search_letter_from_left:

                   bge            $t0, $t3, palindrome

                   lb             $t1, ($t0)

                   move           $a0, $t1
                   li             $v0, 1
                   syscall

                   add            $t0, $t0, 1
                   blt            $t1, 0x41, search_letter_from_left
                   bgt            $t1, 0x7A, search_letter_from_left

search_letter_from_right:

                   ble            $t3, $t0, palindrome

                   lb             $t2, ($t3)

                   move           $a0, $t2
                   li             $v0, 1
                   syscall

                   add            $t3, $t3, -1
                   blt            $t2, 0x41, search_letter_from_right
                   bgt            $t2, 0x7A, search_letter_from_right

                   beq            $t1, $t2, search_letter_from_left
first_attempt:
                   add            $t1, $t1, -32
                   beq            $t1, $t2, search_letter_from_left
                   add            $t1, $t1, 32
second_attempt:
                   add            $t2, $t2, -32
                   beq            $t1, $t2, search_letter_from_left
                   b              not_palindrome

palindrome:

                   ## Prints "Found palindrome-nature ..."
                   la             $a0, palindrome_msg
                   li             $v0, 4
                   syscall

                   b              exit

not_palindrome:
 
                   ## Prints "Found not-palindrome-nature ..."
                   la             $a0, not_palindrome_msg
                   li             $v0, 4
                   syscall

                   b              exit

exit:
                   li             $v0, 10
                   syscall

        .data
sample_str:        .space         1024
null_byte:         .byte          0x00
newline_byte:      .byte          0x10

palindrome_msg:    .asciiz        "Found palindrome-nature ...\n"
not_palindrome_msg:.asciiz        "Found not-palindrome-nature ...\n"
