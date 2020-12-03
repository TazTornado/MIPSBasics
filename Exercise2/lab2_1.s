#####################################
# take a 32-bit binary and create   #
# its equivalent in Gray code       #
#####################################


.text
.globl __start

start:
        # change the contents of $s0
        srl $t0, $s0, 1     # shift 1 bit to the right
        xor $t1, $s0, $t0   # xor between initial and shifted bin num

        la $a0, str1        # print 1st string from .data
        li $v0, 4           # syscall code to print a string
        syscall
        move $a0, $s0       # print bin number
        li $v0, 1           #syscall code to print an int
        syscall
        la $a0, str2
        li $v0, 4
        syscall
        move $a0, $t1       # print gray code number
        li $v0, 1
        syscall

        li $v0, 0xa         # exit routine
        syscall

.data

str1:   .asciiz "Gray code of "
str2:   .asciiz " is "
