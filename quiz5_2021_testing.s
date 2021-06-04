.data
.align 0

w0:     .word 0x000000DD
w1:     .word 0x1111CC11
w2:     .word 0x22BB2222
w3:     .word 0xAA333333

stored0:	.word 0x11111111
stored1:	.word 0x11111111
stored2:	.word 0x11111111
stored3:	.word 0x11111111


.text

main:
		# initialize all regs #
		lw $s0, w0
		lw $s1, w1
		lw $s2, w2
		lw $s3, w3

		sw $s0, stored0
		sw $s1, stored1
		sw $s2, stored2
		sw $s3, stored3

		lb $s0, stored0
		lb $s1, stored1 + 1
		lb $s2, stored2 + 2
		lb $s3, stored3 + 3

		or $s4, $s0, $s1
		or $s4, $s4, $s2
		or $s4, $s4, $s3

		li $v0, 10
		syscall