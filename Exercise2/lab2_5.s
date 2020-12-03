# Function: Ci+1= Si'Bi + Si'Ai + AiBi

.text

main:

    lw $t0, A			# loading 2 words
    lw $t1, B			# don't care about the values

	#creating Si
	addu $t2,$t1,$t0	# get sum

	# only keep the sign bit (31->0)
	srl $t0,$t0,31
	srl $t1,$t1,31
	srl $t2,$t2,31

	# flip Si to Si'
	not $t2, $t2 		 # nor $t2, $zero

	and $t4,$t2,$t1		# Si'Bi
	and $t5,$t2,$t0		# Si'Ai
	and $t6,$t0,$t1		# AiBi

	or $t7,$t4,$t5		# si'Bi + Si'Ai
	or $t7,$t7,$t6		# (Si'Bi + Si'Ai) + AiBi

	li $v0, 10			# exit routine
	syscall

	.data
A:  .word 0xffffffff
B:  .word 0xffffffff
