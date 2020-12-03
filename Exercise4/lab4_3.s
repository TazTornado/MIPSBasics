.data
input_prompt:   .asciiz "Enter integer number: "
output_prompt:	.asciiz " bytes where used in stack."

.text

main:
        la $a0, input_prompt
        li $v0, 4
        syscall         # display prompt

        li $v0, 5
        syscall         # read int

        move $t0, $v0
        
        li $v0, 11      
        li $a0, '\n'
        syscall         # endl

		move $s0, $sp
		move $v0, $sp	# init $v0 with current $sp value
        move $a0, $t0
        jal Gandalf   # recursive call

		sub $s0, $s0, $v0	# $sp(before call) - $sp(after call)
		move $a0, $s0
		li $v0, 1
		syscall				# print diff

		la $a0, output_prompt
		li $v0, 4
		syscall				# print prompt

        li $v0, 10
        syscall         # exit routine



Gandalf:
            addi $sp, $sp, -8	# alloc 8 bytes in stack
            sw $a0, 0($sp)      # store int
            sw $ra, 4($sp)      # store latest $ra address

            beq $a0, $zero, base_case	# when arg is zero stop recursive calls
            addi $a0, $a0, -1
            jal Gandalf

base_case:	lw $a0, 0($sp)      # load latest saved $a0 value
            ble $v0, $sp, return
            move $v0, $sp 	  

return:     move $t1, $v0		# keep $v0's value temporarily

			li $v0, 1
            syscall				# print argument

            li $a0, '\n'
            li $v0, 11
            syscall             # change line 

			move $v0, $t1		# return value to $v0

            lw $ra, 4($sp)      # load stored numbers
            addi $sp, $sp, 8   	# free memory
            jr $ra              # return