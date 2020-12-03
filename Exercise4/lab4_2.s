.data
input_prompt:   .asciiz "Enter integer number: "
arg_prompt:     .asciiz "Argument passed: "


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

        move $a0, $t0
        jal Bumblebee   # call recursive procedure

        li $v0, 10
        syscall         # exit routine



Bumblebee:
        addi $sp, $sp, -8   # alloc 8 bytes in stack
        sw $a0, 0($sp)      # store int
        sw $ra, 4($sp)      # store the latest $ra address

		ble $a0, $zero, return	# check if arg is negative or zero
        addi $a0, $a0, -1
        jal Bumblebee       # recursive call

return: li $v0, 4
        la $a0, arg_prompt
        syscall             # argument prompt

        lw $a0, 0($sp)
        li $v0, 1
        syscall             # print argument

        li $v0, 11
        li $a0, '\n'
        syscall             # endl

        lw $a0, 0($sp)
        lw $ra, 4($sp)      # load stored numbers
        addi $sp, $sp, 8    # free memory
        jr $ra              # return