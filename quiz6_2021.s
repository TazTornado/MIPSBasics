.text

main:
		# initialize all regs #
		ori $s0, $zero, 0x000000DD
		ori $s1, $zero, 0x1111CC11
		ori $s2, $zero, 0x22BB2222
		ori $s3, $zero, 0xAA333333

		# start playing around #
		andi $s0, $s0, 0x000000FF
		andi $s1, $s1, 0x0000FF00

		lui $t2, 0x00FF0000
		and $s2, $s2, $t2
		lui $t3, 0xFF000000
		and $s3, $s3, $t3
		
		ori $s4, $s0, $s1
		ori $s4, $s4, $s2
		ori $s4, $s4, $s3
		
