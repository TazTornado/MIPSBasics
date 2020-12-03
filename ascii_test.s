.text 

main:

		li $t0, 0   		# just to state that $t0 is the counter
		li $t1, 127		# the last ascii character

ascii_table:    
		bgt $t0, $t1, exit	# check for the end of ascii table
				
		move $a0, $t0		# print current character
		li $v0, 11			# using print_char
		syscall			

		li $a0, '\n'
		syscall				# still using print_char

		addi $t0, $t0, 1	# increment ascii code

		j ascii_table	

exit:	li $v0, 10
		syscall				# exit routine