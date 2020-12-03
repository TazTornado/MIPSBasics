#################################################
#												#
#				text segment					#
#												#
#################################################

	.text
	.globl __start
main:		l.s $f0, x
			l.s $f1, y
			mul.s $f12, $f0, $f1
print_1st:		jal print_float	
			jal printEndl
			
			l.s $f0, x
			l.s $f1, m_inf
			mul.s $f12, $f0, $f1			
print_2nd:		jal print_float	
			jal printEndl
			
			l.s $f0, y
			l.s $f1, zer_f
			div.s $f12, $f0, $f1
print_3rd:		jal print_float	
			jal printEndl
			
			l.s $f0, x
			l.s $f1, zer_f
			div.s $f12, $f0, $f1
print_3rd_2:		jal print_float	
			jal printEndl
			
			l.s $f0, zer_f
			l.s $f1, zer_f
			div.s $f12, $f0, $f1
print_4th:		jal print_float	
			jal printEndl
			
			l.s $f0, zer_f
			l.s $f1, p_inf
			mul.s $f12, $f0, $f1
print_5th:		jal print_float	
			jal printEndl
			
			l.s $f0, p_inf
			l.s $f1, m_inf
			div.s $f12, $f0, $f1
print_6th:		jal print_float	
			jal printEndl
			
			l.s $f0, p_inf
			l.s $f1, m_inf
			add.s $f12, $f0, $f1
print_7th:		jal print_float	
			jal printEndl
			
			l.s $f0, x
			l.s $f1, nan
			add.s $f12, $f0, $f1
print_8th:		jal print_float	
			jal printEndl
			
Exit:		li		$v0, 10
			syscall	
print_float:	li		$v0, 2
		syscall
		jr $ra
printEndl:      la $a0, Endl
		li $v0, 4
		syscall	
		jr $ra	
.data
zer_f:   .float 0.0
m_inf:   .word 0xff800000
p_inf:   .word 0x7f800000
nan:     .word 0x7fffffff
x:       .float 55.0
y:       .float -55.0
Endl: .asciiz "\n"
