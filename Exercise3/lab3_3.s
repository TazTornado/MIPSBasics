.data
read_int:   .asciiz "Enter an integer "
string: 	.asciiz "Mary had a little lamb"
copiedA:    .space 30   # 30 bytes
copiedB:    .space 30   # 30 bytes

.text
AND_CONDITION:

        la $a0, read_int
        li $v0, 4
        syscall                 # read_int prompt
        li $v0, 5
        syscall                 # read the int

        move $s1, $v0           # keep int in $2
        
        li $a0, '\n'
        li $v0, 11
        syscall                 # change line

        li $t1, 0               # string characters counter
        li $s0, 't'             # t indicates the end of copy


whileA: lbu $t0, string($t1)    # load a character
        beq $t0, $s0, endA      # if 't' then exit loop
        beq $t1, $s1, endA      # if copy limit is reached, exit loop
        sb $t0, copiedA($t1)    # store character in empty space
        addi $t1, $t1, 1        # counter++
        
        j whileA

endA:   li $t2, 0               # use zero as the end of string, '\0'
        sb $t2, copiedA($t1)    # append '\0' to copied string
        
        la $a0, copiedA
        li $v0, 4
        syscall                 # print copied string

        li $a0, '\n'
        li $v0, 11
        syscall                 # change line


OR_CONDITION:

        and $t1, $t1, $zero     # reinitialize counter
        # $s0 contains 't'
        # $s1 contains the copy limit

whileB: lbu $t0, string($t1)    # load a character
        bne $t0, $s0, continue  # if !('t') then continue, else check limit
        bge $t1, $s1, endB      # if copy limit is reached/exceeded, exit loop

 continue:
        sb $t0, copiedB($t1)    # store character in empty space
        addi $t1, $t1, 1        # counter++

        j whileB

endB:   li $t2, 0               # use zero as the end of string, '\0'
        sb $t2, copiedB($t1)    # append '\0' to copied string
        
        la $a0, copiedB
        li $v0, 4
        syscall                 # print copied string

        li $a0, '\n'
        li $v0, 11
        syscall                 # change line

        li $v0, 10
        syscall                 # exit routine