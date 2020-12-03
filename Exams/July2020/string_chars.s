#####################################
#                                   #
#       June 2020, Group B2		    #
#                                   #
#####################################
# The task:							#
# Read a string of length UP TO 20.	#
# Count and display the capital, 	#
# lower case and the other chars.	#
# -> Loop that until "end" is input	#
#####################################
# THE KEY here is to check the ascii#
# boundaries of each category. This #
# is a switch statement with break;	#
# Lab exercise 3.1					#
#####################################

.data
str:	.space 21	# 20 bytes for chars and 1 for '\0'
caps:	.space 21	# might be all capitals
lower:	.space 21	#  ---- " ----
others: .space 21	#  ---- " ----
read_prompt:	.asciiz "Give string:\n"
contains_msg:	.asciiz " The string contains:\n"
caps_msg:	.asciiz " uppercase English letters: "
lower_msg:	.asciiz " lowercase English letters: "
others_msg: .asciiz " other characters: "
exit_prompt:	.asciiz "\nString 'end' was given. Exiting..."


.text

main_loop:

		la $a0, str			# reset space for str
		li $a1, 20
		jal resetSpace

		la $a0, caps		
		jal resetSpace		# reset space for caps

		la $a0, lower
		jal resetSpace		# reset space for lower
		
		la $a0, others
		jal resetSpace		# reset space for others

		li $v0, 4
		la $a0, read_prompt
		syscall					# read string prompt

		li $v0, 8
		la $a0, str
		li $a1, 21
		syscall					# read string of 20 chars

		li $v0, 4
		la $a0, str
		syscall					# display input string

		la $a0, str
		jal isEnd
		bne $zero, $v0, exit	# is "end", stop looping

		li $v0, 11
		li $a0, '\n'
		syscall 				# change line


	# s0 as string offset
	# s1, s2, s3 as categories offsets
	# t0 as the temporary byte
	# t4, t5, t6 as counters for char categories
	li $t7, 20	# i < 20 in for loop
	li $s4, 'A'	# lower bound for uppercase
	li $s5, 'Z' # upper bound for uppercase 
	li $s6, 'a'	# lower bound for lowercase
	li $s7, 'z'	# upper bound for lowercase
	


	traverse:
			beq $s0, $t7, prints	# if the 20 chars have been processed, exit loop
			lb $t0, str($s0)		# load a character
			
			blt $t0, $s4, case_others	####################
			blt $t0, $s5, case_caps		# check boundaries #
			blt $t0, $s6, case_others	# of character     #
			blt $t0, $s7, case_lower	####################

		case_others:
			addi $t1, $t1, 1	# others counter++
			sb $t0, others($s1) # store the char in its category space
			addi $s1, $s1, 1	# increment offset
			j jump
			  
		case_lower:
			addi $t2, $t2, 1	# lower counter++
			sb $t0, lower($s2) 	# store the char in its category space
			addi $s2, $s2, 1	# increment offset
			j jump 

		case_caps:
			addi $t3, $t3, 1	# caps counter++
			sb $t0, caps($s3) # store the char in its category space
			addi $s3, $s3, 1	# increment offset

		jump:
			addi $s0, $s0, 1
			j traverse


	prints:
		li $v0, 4
		la $a0, contains_msg
		syscall				# The string contains..

		li $v0, 1
		move $a0, $s3		# print upper case counter
		syscall

		li $v0, 4
		la $a0, caps_msg	# upper case blah blah
		syscall

		la $a0, caps
		syscall				# print capital letters

		li $v0, 11
		li $a0, '\n'
		syscall 			# change line

		li $v0, 1
		move $a0, $s2		# print lower case counter
		syscall

		li $v0, 4
		la $a0, lower_msg	# lower case blah blah
		syscall

		la $a0, lower
		syscall				# print lower case letters

		li $v0, 11
		li $a0, '\n'
		syscall 			# change line

		li $v0, 1
		move $a0, $s1		# print upper case counter
		syscall

		li $v0, 4
		la $a0, others_msg	# upper case blah blah
		syscall

		la $a0, others
		syscall				# print capital letters

		li $v0, 11
		li $a0, '\n'
		syscall 			# change line


		j main_loop


exit:	li $v0, 4
		la $a0, exit_prompt	# upper case blah blah
		syscall

		li $v0, 0xa
		syscall



######### Function isEnd ##########
# checks if the input string is "end"
isEnd:
		add $v0, $zero, $zero	# initialize v0 to 0
		lb $a2, 0($a0)			# $a0 contains the address of the string
		li $a1, 'e'
		bne $a2, $a1, return	# 1st char != 'e' => return

		li $a1, 'n'
		lb $a2, 1($a0)			# load next char from string
		bne $a2, $a1, return	# 2nd char != 'n' => return

		li $a1, 'd'
		lb $a2, 2($a0)			# load next char from string
		bne $a2, $a1, return	# 3rd char != 'd' => return		
		addi $v0, $zero, 1		# return value | 0 if !"end", 1 if "end"

	return:
		jr $ra	 

######################################################
# alternative, to make this function more generic:   #
# isEqual(a0,a1): in a0 must be the address of input #
# string, while a1 should point to the target string #
# keep a common index/offset for both strings, load  #
# the byte in the same position and check if equal	 #
# in a loop, until target's length is reached		 #
######################################################

resetSpace:
		# a0 points to the string to be cleaned
		# a1 contains the length of that string
		li $a2, 0	# the 'blank' byte to be stored
		li $a3, 0	# serves as loop counter

	loop:	beq $a3, $a1, stop	# if all characters have been processed, stop looping
			sb $a2, 0($a0)		# 'clean' a byte in string
			addi $a0, $a0, 1	# increment offset
			addi $a3, $a3, 1	# i++
			j loop

	stop:	
		jr $ra

