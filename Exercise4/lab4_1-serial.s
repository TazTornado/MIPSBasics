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
    li $s3, 3		# expected to remain 3

    jal MinMax

######################################################

    move $t0,$v0	# max in t0
	move $t1,$v1	# min in t1

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
			addi $sp, $sp, -8	# alloc 8 bytes
			sw $s0, 0($sp)		# store 1 for now
			sw $s1, 4($sp) 		# store 2 for now

	# $s0 will serve as max and $s1 as min

max_arg0:	move $s0, $a0				# consider a0 as max to start with

max_arg1:	ble $a1, $s0, max_arg2		# if arg1 <= max then skip to next arg
			move $s0, $a1				# else replace max

max_arg2:	ble $a2, $s0, max_arg3		# if arg2 <= max then skip to next arg
			move $s0, $a2				# else replace max

max_arg3:	ble $a3, $s0, save_max		# if arg3 <= max then skip to save routine
			move $s0, $a3				# else replace max

save_max:	move $v0, $s0				# max to $v0 for return

min_arg0:	move $s1, $a0				# consider a0 as min to start with

min_arg1:	bge	$a1, $s1, min_arg2		# if arg1 >= min then skip to next arg
			move $s1, $a1				# else replace min

min_arg2:	bge	$a2, $s1, min_arg3		# if arg2 >= min then skip to next arg
			move $s1, $a2				# else replace min	

min_arg3:	bge	$a3, $s1, save_min		# if arg3 >= min then skip to next arg
			move $s1, $a3				# else replace min	

save_min:	move $v1, $s1				# min to $v1 for return

			# free memory and return
			lw $s0, 0($sp)				# return initial values
			lw $s1, 4($sp)				# to $s registers

			addi $sp, $sp, 8			# free the 8 alloc'd bytes

			jr $ra					    # return