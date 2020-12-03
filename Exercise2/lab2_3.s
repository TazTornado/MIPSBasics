.text

task_c:

pair1:	lw $t0, w			# load the number into $t0
		lw $t1, w			# alternatively, or $t1, $t0, $zero
							# or just use $t0 twice

		add $t2, $t1, $t0	# alternatively, add $t2, $t0, $t0
		addu $t3, $t1, $t0	# alternatively, addu $t3, $t0, $t0

		move $a0, $t2		# print the signed result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

		move $a0, $t3		# print the unsigned result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

pair2:	ori $t4, $t2, 1		# add 1 to ...646, to get ...647
		li $s0, 1			# need that ace

		add $t5, $t4, $s0	# additions..
		addu $t6, $t4, $s0

		move $a0, $t5		# print the signed result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

		move $a0, $t6		# print the unsigned result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

pair3:	lw $t7, w+12		# get -1. -...648 is in $t6

		add $t1, $t6, $t7	# additions..
		addu $t2, $t6, $t7

		move $a0, $t1		# print the signed result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

		move $a0, $t2		# print the unsigned result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

pair4:	move $t6, $t7		# another -1

		add $t1, $t6, $t7	# additions..
		addu $t2, $t6, $t7

		move $a0, $t1		# print the signed result
		li $v0, 1
		syscall

		la $a0, endl		# change line
		li $v0, 4
		syscall

		move $a0, $t2		# print the unsigned result
		li $v0, 1
		syscall

		li $v0, 10			# exit routine
		syscall


.data
w: 		.word 0x3fffffff	# 0011 1111...|1 073 741 823
		.word 0x7fffffff	# 0111 1111...|2 147 483 647
		.word 0xffffffff	# 1111 1111...|-1
		.word 0x80000000	# 1000 0000...|-2 147 483 648
endl: 	.asciiz "\n"
