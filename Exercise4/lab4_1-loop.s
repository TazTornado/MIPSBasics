.data
min_prompt: .asciiz "Minimum argument is "
max_prompt: .asciiz "Maximum argument is "

.text

main:

    li $a0, -10     # argument 0 = -10
	li $a1, -30		# argument 1 = -30
	li $a2, 120		# argument 2 = 120
	li $a3, 200     # argument 3 = 200

######################################################

    li $s0, 1		# test values for $s registers
	li $s1, 2
    
    jal MinMax

######################################################

    move $t0, $v0	# max in t0
	move $t1, $v1	# min in t1

	la $a0, max_prompt		
	li $v0, 4
	syscall			# display "Max is :"

	move $a0,$t0		
	li $v0, 1
	syscall			# display max

	li $a0, '\n'		
	li $v0, 11
	syscall			# change line

	la $a0, min_prompt		
	li $v0, 4
	syscall			# display "Min is :"

	move $a0,$t1		
	li $v0, 1
	syscall			# display min

    li $v0, 0xa
    syscall         # exit routine	

######################################################

###################### MinMax ########################

 MinMax:	# allocation in stack #
			addi $sp, $sp, -20	# alloc 20 bytes
			sw $a1, 0($sp)		# store arg1 to use in loop
			sw $a2, 4($sp)		# store arg2 to use in loop
			sw $a3, 8($sp)		# store arg3 to use in loop
			sw $s0, 12($sp)		# store 1 for now
			sw $s1, 16($sp) 	# store 2 for now

			li $s1, 3			# loop counter
			move $v0, $a0		# v0 for max
			move $v1, $a0		# v1 for min
loop:		beq $s1, $zero, return
			lw $s0, 0($sp)		# get 1st arg in stack

			ble $s0, $v0, skip_max	# if arg <= max then skip
			move $v0, $s0			# else replace max

skip_max:	bge $s0, $v1, skip_min	# if arg >= min then skip
			move $v1, $s0			# else replace min

skip_min:	addi $s1, $s1, -1	# counter--
			addi $sp, $sp, 4	# throw away used argument from stack
			j loop

			# free memory and return
return:		lw $s0, 0($sp)				# return initial values
			lw $s1, 4($sp)				# to $s registers

			addi $sp, $sp, 8			# free the 8 bytes left

			jr $ra					    # return