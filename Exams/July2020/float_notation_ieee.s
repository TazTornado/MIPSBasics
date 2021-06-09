#####################################
# 					                #
#       June 2020 - Group A Ex1     #
# 			  		    			#
#####################################
# The task:
# Read a float and then display its #
# scentific notation according to 	#
# the IEEE-754 prototype, as shown:	#
# Give real number: -12.5 			#
# Number in scientific notation: 	#
# -1.1001 x 2^3						#
# -> Loop this until 0.0 is given <-#
#####################################
# THE KEY here is to move the float #
# from an fp to an int reg and work #
# with bitwise operators			#
#####################################


 .text

read_float:
	la $a0, read_msg		    # print intro string line
	li $v0, 4
	syscall

	li $v0, 6
	syscall			    # read float
	mov.s $f12, $f0

	li $v0, 2		    # print float
	syscall

	c.eq.s $f0, $f1
	bc1t Exit           # if float is zero, exit

	la $a0, endl
	li $v0, 4
	syscall

	mfc1 $t0, $f0       # move float to an int reg, to process bits

	srl $t1, $t0, 31    # isolating the sign

	li $t5, ' '         # t5 = 32
	sb  $t5, sign       # fix the sign space in memory, from last loop
	beqz $t1, continue  # if sign == 1 then store '-', if sign == 0 then leave blank
storeMinus:
	li $t5, '-'
	sb $t5, sign

continue:
	sll $t3, $t0, 1		# isolating the biased exponent in $t3
	srl $t3, $t3, 24

	li $t2, 127
	sub $s0, $t3, $t2   # removing bias
	sw $s0, exponent

	sll $t4, $t0, 9     # isolating the mantissa
	srl $t4, $t4, 9     # bringing the bits back in place

	li $t6, 22  # will be used as offset

	loop:
		blt $t6, $zero, printAnsw   # escape clause
		andi $t7, $t4, 1            # masking t1 to get 1st bit
		beqz $t7, storeZero

	storeOne:
		li $s1, '1'		        # store ascii for 1
		sb $s1, mantissa($t6)
		addi $t6, $t6, -1       # subtract from the counter
        srl $t4, $t4, 1
		j loop

	storeZero:
		li $s1, '0'		        # store ascii for 0
		sb $s1, mantissa($t6)
		addi $t6, $t6, -1       # subtract from the counter
		srl $t4, $t4, 1
		j loop


printAnsw:
	la $a0, answ		# print prompt for result
	li $v0, 4
	syscall

	la $a0, sign        # print sign
	li $v0, 4
	syscall

	la $a0, comma       # print comma
	li $v0, 4
	syscall

	la $a0, mantissa    # print mantissa
	li $v0, 4
	syscall

	la $a0, base 		# print base
	li $v0, 4
	syscall


	la $a0, exponent    # print exponent
    lw $a0, 0($a0)
	li $v0, 1
	syscall
	la $a0, endl
	li $v0, 4
	syscall


	j read_float        # read next float


Exit:
    la $a0, bye 		# print base
    li $v0, 4
    syscall

	li $v0, 10
	syscall

.data
mantissa: 	.space 24 			# 24 bytes for mantissa
exit_msg:   .asciiz "Float 0.0 was given. Exiting..."
read_msg:	.asciiz "Please enter a floating point number\n"
answ:	.asciiz "Number in scientific notation is:"
endl:	.asciiz "\n"
base:	.asciiz " x 2^"
exponent: 	.word 1     # just space for exponent
comma:	.asciiz "1,"
sign: 	.asciiz " "     # 1 byte for sign
bye:    .ascii "\nBye.."
