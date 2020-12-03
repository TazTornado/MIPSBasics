#####################################
#                                   #
#     June 2020, Group A Ex2        #
#                                   #
#####################################
# The task:							#
# In a loop, read an int, b, 		#
# AS STRING, which will be the		#
# base of numeric system.			#
# Then read a 5-digit (or less) int #
# AS STRING which will be considered#
# as b-based, and convert and print #
# it in decimal form. You have to   #
# check if 2<=b<=10, (if b == 0	    #
# then stop looping) and if all the #
# digits of the number are valid for#
# the given base (digit < b)		#
#####################################
# THE KEY here is to convert the 	#
# numbers from their ascii code to 	#
# their numeric value by doing: 	#
# digit - '0'. Don't burn too many 	#
# braincells with all the loops	:)	#
#####################################


.data
input_num:  .space 6    # 5 chars + \0
b_prompt:    .asciiz "Please enter the base system (2-10)\n"
input_prompt:   .asciiz "Please enter a 5-digit number "
base_error:  .asciiz "Error, wrong base\n"
string_error:   .asciiz "Error, digit out of base bounds.\n"
result_msg:     .asciiz "The base-10 number is "
exit_msg:   .asciiz "Base 0 was given, exiting.."

.text

############## Main Loop #################
read_base:
	li $v0, 4
	la $a0, b_prompt
	syscall         # print read prompt

	li $v0, 5       # read base
	syscall

	move $s0, $v0   # keep base in s0

	li $t8, 2       # lower boundary for b
	li $t9, 10      # upper boundary for b
	beqz $s0, exit   # if zero, exit loop
	blt $s0, $t8, error1    # if < 2 then error
	bgt $s0, $t9, error1    # if > 10 then error

read_number:
	li $s1, 4   # will serve as offset

	la $a0, input_prompt
	li $v0, 4
	syscall             # input number prompt

	la $a0, input_num
	li $a1, 6
	li $v0, 8
	syscall         # read number

	li $a0, '\n'    
	li $v0, 11
	syscall         # change line
	
	li $t3, 10
	li $s2, '0'     # keep the ascii code of 0 in s2

	bne $s0, $t3, get_byte  # if the base that was given is 10, print number as is
	la $a0, result_msg
	li $v0, 4
	syscall     # print prompt for result

	la $a0, input_num
	li $v0, 4
	syscall     # print num

	li $a0, '\n'    
	li $v0, 11
	syscall         # change line

	j read_base

		# $s3 will serve as power counter
		# $s4 will be used for the number in base 10
		get_byte:
			blt $s1, $zero, print_result    # if all digits have been read then exit loop
			lb $t0, input_num($s1)
			sub $t0, $t0, $s2   # convert to number

			bge $t0, $s0, error2    # if number is invalid go to error
			blt $t0, $zero, jump    # in case the number has < 5 digits
			move $a0, $s3       # arg1: exponent
			move $a1, $s0       # arg2: base
			jal Power           # call Power(exp, base) to convert the base-b value to base 10 value
			mult $v0, $t0       # multiply power's result with the digit aka its coefficient
			mflo $t1
			add $s4, $s4, $t1   # add new value to the sum
			addi $s3, $s3, 1    # increment power for next loop

		jump:
			addi $s1, $s1, -1   # decrement offset
			j get_byte

	print_result:
		la $a0, result_msg
		li $v0, 4
		syscall     # print prompt for result

		move $a0, $s4
		li $v0, 1
		syscall

		li $a0, '\n'    
		li $v0, 11
		syscall         # change line

		j read_base     # read next base & number


exit:

	la $a0, exit_msg
	li $v0, 4
	syscall     # print prompt for result

	li $v0, 10
	syscall  


############### Base Error ##################
error1:
	la $a0, base_error
	li $v0, 4
	syscall

	li $v0, 5       # read base
	syscall

	move $s0, $v0   # keep base in s0

	beqz $s0, end   # if zero, end loop
	blt $s0, $t8, error1    # keep looping until zero or a valid base
	bgt $s0, $t9, error1    

	j read_number

######### Number-Out-Of-Bounds Error ##########
error2:
	la $a0, string_error
	li $v0, 4
	syscall

	j read_number
############## Function Power #################      
	
Power:  # Power(exp, base)
	move $a2, $a1
 not_1st_time:
	beqz $a0, case_0    # if power is zero, return 1
	li $s7, 1
	beq $a0, $s7, case_1    # if the exp is 1 go to return 
	mult $a1, $a2           # multiply value so far with the initial factor
	mflo $a1                # new value in a1
	addi $a0, $a0, -1   # decrement exponent
	j not_1st_time

case_0:
	li $v0, 1   # set the result to 1
	jr $ra      # return 1

case_1:
	move $v0, $a1
	jr $ra      # return calculated value

		


	

