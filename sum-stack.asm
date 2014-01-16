# sum-stack -- Using a procedure to provide
#              addition of two numbers *squared*.
            .text
main:
            la        $a0, first_type_msg
            li        $v0, 4
            syscall

            li        $v0, 5
            syscall
            move      $s0, $v0

            la        $a0, second_type_msg
            li        $v0, 4
            syscall

            li        $v0, 5
            syscall
            move      $s1, $v0

            move      $a0, $s0
            move      $a1, $s1
            jal       sum_of_squares
            b         exit

sum_of_squares:
            subu      $sp, $sp, 32
            sw        $fp, 28($sp)
            sw        $ra, 24($sp)
            sw        $s0, 20($sp)
            sw        $s1, 16($sp)
            sw        $s2, 12($sp)
            addu      $fp, $sp, 32

            jal       square
            move      $s0, $v0

            move      $a0, $a1
            jal       square
            move      $s1, $v0

            add       $s2, $s0, $s1

            move      $v0, $s2

            lw        $fp, 28($sp)
            lw        $ra, 24($sp)
            lw        $s0, 20($sp)
            lw        $s1, 16($sp)
            lw        $s2, 12($sp)
            addu      $sp, $sp, 32

            jr        $ra

square:           
            subu      $sp, $sp, 32
            sw        $fp, 28($sp)
            sw        $ra, 24($sp)
            sw        $s0, 20($sp)
            addu      $fp, $sp, 32

            move      $s0, $a0
            mul       $s0, $s0, $s0
            move      $v0, $s0

            lw        $fp, 28($sp)
            lw        $ra, 24($sp)
            lw        $s0, 20($sp)
            addu      $sp, $sp, 32

            jr        $ra

exit:
            move      $s2, $v0

            la        $a0, return_msg
            li        $v0, 4
            syscall

            move      $a0, $s2
            li        $v0, 1
            syscall

            la        $a0, newline
            li        $v0, 4
            syscall

            li        $v0, 10
            syscall
            

            .data
newline:              .asciiz    "\n"
first_type_msg:       .asciiz    "Type the first number:\n"
second_type_msg:      .asciiz    "Type the second number:\n"
return_msg:           .asciiz    "first_number**2 + second_number**2 == "
