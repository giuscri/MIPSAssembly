# Task04
# Write the Assembly code that performs
#
#    A[c-1] = c * (B[A[c]] + c) / A[2*c -1]
#
# where A and B contains 4 elements (each 32bits long ...), c is a 32bit int
# and c == 2, and A == { -1, -1, 1, 4 } and B == { -1, 6, -1, -1 }

        .text
main:
         ## Making room for A, that's an array of 4 int's ...
         la      $s0, 0x10000000

         ## Making room for B, that's an array of 4 int's ...
         addu    $s1, $s0, 16

         ## Making room for c, that's a int ...
         addu    $s2, $s1, 16

         ## Initializing values in A ...

         ## A[ 0 ] = A[ 1 ] = -1 ...
         li      $t0, -1
         sw      $t0, 0($s0)
         sw      $t0, 4($s0)

         ## A[ 2 ] = 1 ...
         li      $t0, 1
         sw      $t0, 8($s0)
       
         ## A[ 3 ] = 4 ...
         li      $t0, 4
         sw      $t0, 12($s0)

         ## Initializing values in B ...

         ## B[ 0 ] = -1 ...
         li      $t0, -1
         sw      $t0, 0($s1)

         ## B[ 1 ] = 6 ...
         li      $t0, 6
         sw      $t0, 4($s1)

         ## B[ 2 ] = B[ 3 ] = -1 ...
         li      $t0, -1
         sw      $t0, 8($s1)
         sw      $t0, 12($s1)

         ## Initializing c ...

         ## c = 2 ...
         li      $t0, 2
         sw      $t0, 0($s2)

         ## Storing c into t0 ...
         lw      $t0, 0($s2)

         ## Storing 4*c into t1 ...
         mul     $t1, $t0, 4

         ## Storing &(A[c]) into t1 ...
         add     $t1, $s0, $t1

         ## Storing A[c] into t1 ...
         lw      $t1, 0($t1)

         ## Storing 4*A[c] into t1 ...
         mul     $t1, $t1, 4

         ## Storing &(B[A[c]]) into t1 ...
         add     $t1, $s1, $t1

         ## Storing B[A[c]] into t1 ...
         lw      $t1, 0($t1)

         ## Storing B[A[c]] + c into t1 ...
         add     $t1, $t1, $t0

         ## Storing c * (B[A[c]] + c) into t1 ...
         mul     $t1, $t0, $t1

         ## Storing 2*c into t2 ...
         mul     $t2, $t0, 2

         ## Storing 2*c -1 into t2 ...
         add     $t2, $t2, -1

         ## Storing 4*(2*c -1) into t2 ...
         mul     $t2, $t2, 4

         ## Storing &(A[2*c -1]) into t2 ...
         add     $t2, $s0, $t2

         ## Storing A[2*c -1] into t2 ...
         lw      $t2, 0($t2)

         ## Storing c * (B[A[c]] + c) / A[2*c -1] into t3 ...
         div     $t3, $t1, $t2

         ## Storing c-1 into t0 ...
         add     $t0, $t0, -1

         ## Storing 4*(c-1) into t0 ...
         mul     $t0, $t0, 4

         ## Storing &(A[c -1]) into t0 ...
         add     $t0, $s0, $t0

         ## Storing c * (B[A[c]] + c) / A[2*c -1] at &(A[c -1]) ...
         sw      $t3, 0($t0)

         ## Printing A[c -1] ...
         li      $v0, 4
         la      $a0, resultis_str
         syscall

         li      $v0, 1
         lw      $a0, 0($t0)
         syscall

exit:
         li      $v0, 4
         la      $a0, newline_str
         syscall

         li      $v0, 10
         syscall

         .data
resultis_str:    .asciiz "A[ c -1 ] is "
newline_str:     .asciiz "\n"
