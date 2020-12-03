#####################################
#                                   #
#       June 2020 - Group B1        #
#                                   #
#####################################
# The task:                         #
# Read a signed int, then isolate   # 
# its 4 bytes and consider each of  #
# them as a 2's complement signed   #
# integer. Then calculate and print # 
# the following:                    #
# a) find the max int and display   #
#    its decimal form               #
# b) repeat the same for min        #
# c) sum of all 4 ints              #
# d) mean (average) of all 4 ints   #
# -> Loop this until 0 is given <-  #
#####################################
# THE KEY here is to use sra instead#
# of srl when isolating the bytes,  #
# since you want the sign to be     #
# extended to all the word's bits.  #
#####################################

.data
read_prompt:    .asciiz "Please enter an integer "
exit_msg:       .asciiz "Number 0 was given. Exiting..."
min_prompt: 	.asciiz "Smallest byte value is: "
max_prompt:		.asciiz "Largest byte value is: "
sum_prompt:		.asciiz "Sum of bytes is: "
mean_prompt:	.asciiz "Mean of bytes is: "

.text

read_ints:
        la $a0, read_prompt
        li $v0, 4
        syscall     # print msg prompt

        li $v0, 5
        syscall     # read int

		move $s0, $v0   # keep number in s0

		li $a0, '\n'
		li $v0, 11
		syscall		# change line

        beqz $s0, exit  # if 0 was given then exit loop

        sll $t0, $s0, 24
        sra $t0, $t0, 24    # isolate byte 0 with sign extension, in t0

        sll $t1, $s0, 16
        sra $t1, $t1, 24    # isolate byte 1 in t1

        sll $t2, $s0, 8
        sra $t2, $t2, 24    # isolate byte 2 in t2

        sra $t3, $s0, 24    # isolate byte 3 in t3

        task_a: # find maximum between the bytes and print it 
            move $s1, $t0				# consider t0 as max to start with

            ble $t1, $s1, max2			# if byte 1 <= max then skip to next arg
            move $s1, $t1				# else replace max

	max2:   ble $t2, $s1, max3			# if byte 2 <= max then skip to next arg
            move $s1, $t2				# else replace max

	max3:	ble $t3, $s1, print_max		# if byte 3 <= max then skip to save routine
            move $s1, $t3				# else replace max

	print_max:
			la $a0, max_prompt
			li $v0, 4
			syscall

			move $a0, $s1	# print min
			li $v0, 1
			syscall

			li $a0, '\n'	# change line
			li $v0, 11
			syscall

		task_b:   
			move $s2, $t0				# consider t0 as min to start with

            bge	$t1, $s2, min2			# if byte 1 >= min then skip to next arg
            move $s2, $t1				# else replace min

	min2:   bge	$t2, $s2, min3			# if byte 2 >= min then skip to next arg
        	move $s2, $t2				# else replace min	

	min3:   bge	$t3, $s2, print_min		# if byte 3 >= min then skip to next arg
        	move $s2, $t3				# else replace min	

	print_min:
			la $a0, min_prompt
			li $v0, 4
			syscall

			move $a0, $s2	# print min
			li $v0, 1
			syscall

			li $a0, '\n'	# change line
			li $v0, 11
			syscall

		task_c:
			# s3 will be used as sum
			add $s3, $t1, $t0
			add $s3, $s3, $t2
			add $s3, $s3, $t3		# sum up all bytes

			la $a0, sum_prompt
			li $v0, 4
			syscall

			move $a0, $s3	# print sum
			li $v0, 1
			syscall

			li $a0, '\n'	# change line
			li $v0, 11
			syscall

		task_d:
			li $t4, 4
			div $s3, $t4
			mflo $s4

			la $a0, mean_prompt
			li $v0, 4
			syscall

			move $a0, $s4	# print mean
			li $v0, 1
			syscall

			li $a0, '\n'	# change line
			li $v0, 11
			syscall

			j read_ints


exit: 
    la $a0, exit_msg
    li $v0, 4
    syscall     # print exit msg

    li $v0, 10
    syscall        
