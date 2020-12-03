.text
.globl __start

__start:
read_int:   li $v0, 5
            syscall

            move $t0, $v0
print_endl: li $v0, 4
            la $a0, Endl
            syscall

print_int:  move $a0, $t0
            li $v0, 1
            syscall

Exit:       li $v0, 10
            syscall

.data
Endl: .asciiz "\n"
