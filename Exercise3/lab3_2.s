.data
A:  .word 0xf791a0b0
B:  .word 0xf4f829dc
Hamming1:   .asciiz "Hamming distance of "
Hamming2:   .asciiz " and "
Hamming3:   .asciiz " is "

.text
 
 main:

        lw $t0, A
        lw $t1, B

        xor $s0, $t0, $t1	# each bit: 1 if different, 0 if identical
        li $t8, 32     		# use $t8 as loop counter

        # use $t9 for hamming dist sum
loop:   # beq $zero, $t8, prints

		#############################
		# alternative: 'while loop'	#
		# if line 19 uncommented,	#
		# uncomment line 33 and 	#
		# comment out line 35		#
		#############################

        andi $t2, $s0, 0x1  # keep currently useful bit
        addu $t9, $t9, $t2	# add to hamming dist sum
        srl $s0, $s0, 1     # "throw away" used bit
        sub $t8, $t8, 1     # loop counter--

        # j loop
		# alternative: bne $t8, $zero, loop
        bgt $t8,$zero, loop # do while $t8 > 0

prints: la $a0, Hamming1
        li $v0, 4
        syscall         # Hamming distance of "..
        move $a0, $t0
        li $v0, 1     
        syscall         # .."0x2791a0b0"..
        la $a0, Hamming2
        li $v0, 4
        syscall         # .." and "..
        move $a0, $t1
        li $v0, 1
        syscall         # .."0xb4f829dc"..
        la $a0, Hamming3
        li $v0, 4
        syscall         # .." is "..
        move $a0, $t9
        li $v0, 1
        syscall         # <hamming distance>

        li $v0, 10
        syscall         # exit routine