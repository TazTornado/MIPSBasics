#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
main:	
read_float:	li $v0, 6
			syscall	
			mov.s $f12, $f0
print_endl: li $v0, 4
			la $a0, Endl
			syscall		
print_float:
            li $v0, 2
			syscall	
Exit:		li $v0, 10
			syscall			
.data
Endl: .asciiz "\n"
