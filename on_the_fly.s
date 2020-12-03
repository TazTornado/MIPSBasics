.data 
read_int:   .asciiz "Enter a number: "
div_promptA:    .asciiz " is a divisor of "
div_promptB:    .asciiz " is the min divisor of "

.text

taskA:  li $v0, 4       # read_int prompt
        la $a0, read_int
        syscall

        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line

        li $a0, 0xa
        li $v0, 1
        syscall

        li $v0, 10
        syscall         # exit routine

