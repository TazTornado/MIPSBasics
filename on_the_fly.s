.data 
read_str:   .space 3
stored_str:	.space 3
div_promptA:    .asciiz " is a divisor of "
div_promptB:    .asciiz " is the min divisor of "

.text

# taskA:  li $v0, 4       # read_int prompt
#         la $a0, read_int
#         syscall

#         li $a0, '\n'    # endl character
#         li $v0, 11      # print_char
#         syscall         # change line

#         li $a0, 0xa
#         li $v0, 1
#         syscall



		li $v0, 8			# read a 2-char string
		la $a0, read_str
		li $a1, 3
		syscall

		lb $t1, read_str + 1	# load 1st byte - signed
		lbu $t2, read_str + 1	# load same byte - unsigned

		li $v0, 1
		or $a0, $zero, $t1
		syscall				# print signed

		li $v0, 11
		li $a0, '\n'
		syscall 			# change line

		li $v0, 1
		or $a0, $zero, $t2
		syscall				# print unsigned

		li $v0, 11
		li $a0, '\n'
		syscall 			# change line

		sb $t1, stored_str
		
		li $v0, 4
		la $a0, stored_str
		syscall



        li $v0, 10
        syscall         # exit routine