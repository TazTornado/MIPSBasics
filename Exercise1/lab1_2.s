#################################
# exercise 1.2					#
# demo of load instructions		#
#################################
.text
	.globl __start
main:

task_a:	la $t7, b0			# getting address of b0
		lbu $t0, 0 ($t7)	# expected to load 1st byte
		lhu $t1, 0 ($t7)	# load 2 bytes (half word)
		lw $t2, 0 ($t7)		# load all 4 bytes

task_b: lbu $t3, 4 ($t7)	# load 1st byte of b1
		lhu $t4, 4 ($t7)	# load 2 bytes from b1
		lw $t5, 4 ($t7)		# load all 4 bytes of b1

task_c: lb $t0, 0 ($t7)		# same as "task_a", but signed
		lh $t1, 0 ($t7)
		lw $t2, 0 ($t7)

task_d:	lb $t3, 4 ($t7)		# same as "task_b", but signed
		lh $t4, 4 ($t7)
		lw $t5, 4 ($t7)

task_e:	lb $t6, 4 ($t7)		# load 1st byte of b1
		sb $t6, b0+16		# b0 and b1 contents take up 16 bytes

		li $v0, 0xa			# exit steps
		syscall

.data
b0:	.byte 0x01, 0x02, 0x03, 0x04
b1:	.byte 0x81, 0x82, 0x83, 0x84
	.word 0x12345678, 0x87654321
