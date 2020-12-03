#################################################
#	                                        #
# lab4_4.s			                #
# stack exercise 4 	(to be completed)       #
#					        #
#################################################
	.text		
       	.globl __start 
__start:			# execution starts here

# start of main program
	la $a0,prompt		
	li $v0,4
	syscall			# display "Enter integer number :"		
	li $v0,5
	syscall			# read integer
	move $t0,$v0
	la $a0,endl		
	li $v0,4
	syscall			# display end of line
	move $a0,$t0

	jal fibo

	move $a0,$v0		#print the nth fibonacci term
	li $v0,1		
	syscall
	
	j exit	

fibo:	addi $sp,$sp,-12 #save in stack
	sw $ra,0($sp)
	sw $s0,4($sp)   # n as in n-th term
	sw $s1,8($sp)

	add $s0,$a0,$zero

	addi $t1,$zero,1
	beq $s0,$zero,return0   
	beq $s0,$t1,return1

	addi $a0,$s0,-1

	jal fibo

	add $s1,$zero,$v0     #s1=fib(n-1)
	
	add $v0,$v0,$s1       #v0=fib(n-2)+$s1

exitfib:
	lw $ra,0($sp)       #read registers from stack
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12       #bring back stack pointer
	jr $ra

return1:
 	li $v0,1
 	j exitfib
return0:     
	li $v0,0
 	j exitfib

exit:	li $v0,10
	syscall		#au revoir
	
		.data
prompt:		.asciiz "Enter integer number : "
endl:		.asciiz "\n"
#################################################
#                                               #
# End of program		                # 
#					        #
#################################################