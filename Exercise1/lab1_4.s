.text
.globl __start

main:# execution starts here
read_str:   li $v0, 8           # code to read a string
            li $a1, 21          # max size = 20 bytes
            la $a0, str         # $a0 points to the string
            syscall
            
print_endl: li $v0, 4
            la $a0, endl
            syscall

print_str:  la $a0, str
            syscall

change_6th: sb $zero, 5($a0)    #str+5
print_str2: la $a0, endl
            syscall

print_5chars:
            la $a0, str
            syscall

Exit:       li $v0, 10
            syscall

.data
str:    .asciiz "--------------------"
endl:   .asciiz "\n"
