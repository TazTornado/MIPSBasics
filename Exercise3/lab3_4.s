.text

main:

        li $t0, 'z'             # keep the ascii codes
        li $t1, 'a'             # in registers to use
        li $t2, 'A'
        subu $s0, $t1, $t2      # keep 'a'-'A' to use in conversion

        la $a0, phrase          # buffer
        li $a1, 50              # length
        li $v0, 8
        syscall                 # read string

        la $a0, phrase
        li $v0, 4
        syscall                 # print string

        # use $t0, $t1 as char limits
        # use $s1 for temp byte
        # use $t3 for offset

while:  lbu $s1, phrase($t3)    # load current byte from string
        beq $zero, $s1, exit    # if char is '\0'-end of string, stop looping 
        blt $s1, $t1, jump      # if char < 'a', leave unchanged
        bgt $s1, $t0, jump      # if char > 'z', leave unchanged

        subu $s1, $s1, $s0       # convert char by subtracting with the diff
        sb $s1, phrase($t3)      # store capital char
		
jump:	addi $t3, $t3, 1        # counter++
	    j while                 # next loop

exit:	la $a0, phrase
        li $v0, 4
        syscall                 # print string

   	    li $v0, 10              # exit routine
        syscall

.data
phrase: .space 50ers to