.data 
read_int:   .asciiz "Enter a number: "
div_promptA:    .asciiz " is a divisor of "
div_promptB:    .asciiz " is the min divisor of "
no_divisor:		.asciiz "2,3,5 are not divisors of "



.text

TASK_A: li $v0, 4       # read_int prompt
        la $a0, read_int
        syscall
        li $v0, 5       #read the integer
        syscall

        move $a0, $v0   # display the int
        li $v0, 1
        syscall

        move $s0, $a0   # keep the int in $s0
        li $s2, 2       # 2 in $s2
        li $s3, 3       # 3 in $s3
        li $s5, 5       # 5 in $s5
		# use $t7 as flag

 divisions:
        div $s0, $s2
        mfhi $t2        # div2 remainder
        div $s0, $s3
        mfhi $t3        # div3 remainder
        div $s0, $s5
        mfhi $t5        # div5 remainder

        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line
        
case_2: bne $zero, $t2, div3
        li $a0, 2
        li $v0, 1
        syscall     # "2..
        la $a0, div_promptA 
        li $v0, 4
        syscall     # ..is a divisor of..
        move $a0, $s0
        li $v0, 1
        syscall     # ..<int>"
        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line 
		li $t7, 1		# set the flag to 1

case_3: bne $zero, $t3, div5
        li $a0, 3
        li $v0, 1
        syscall     # "3..
        la $a0, div_promptA 
        li $v0, 4
        syscall     # ..is a divisor of..
        move $a0, $s0
        li $v0, 1
        syscall     # ..<int>"
        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line 
		li $t7, 1		# set the flag to 1

case_5: bne $zero, $t5, defaultA
        li $a0, 5
        li $v0, 1
        syscall     # "5..
        la $a0, div_promptA 
        li $v0, 4
        syscall     # ..is a divisor of..
        move $a0, $s0
        li $v0, 1
        syscall     # ..<int>"
        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line
		li $t7, 1		# set the flag to 1

defaultA:
		bne $t7, $zero, exit_routineA
		la $a0, no_divisor 
        li $v0, 4
        syscall     # 2,3,5 are not divisors of...
        move $a0, $s0
        li $v0, 1
        syscall		# ...<int>


 exit_routineA:  
 		li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line 


#######################################################
#######################################################


TASK_B: li $v0, 4       # read_int prompt
        la $a0, read_int
        syscall
        li $v0, 5       #read the integer
        syscall

        move $a0, $v0   # display the int
        li $v0, 1
        syscall

        move $s0, $a0   # keep the int in $s0
        li $s2, 2       # 2 in $s2
        li $s3, 3       # 3 in $s3
        li $s5, 5       # 5 in $s5
		and $t7, $t7, $zero	# reinitialize flag

 divisions:
        div $s0, $s2
        mfhi $t2        # div2 remainder
        div $s0, $s3
        mfhi $t3        # div3 remainder
        div $s0, $s5
        mfhi $t5        # div5 remainder

        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line
        
case_2: bne $zero, $t2, div3
        li $a0, 2
        li $v0, 1
        syscall     # "2..
        la $a0, div_promptB 
        li $v0, 4
        syscall     # ..is a divisor of..
        move $a0, $s0
        li $v0, 1
        syscall     # ..<int>"
        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line 
		li $t7, 1		# set the flag to 1

        j exit_routine  # break;

case_3: bne $zero, $t3, div5
        li $a0, 3
        li $v0, 1
        syscall     # "3..
        la $a0, div_promptB 
        li $v0, 4
        syscall     # ..is a divisor of..
        move $a0, $s0
        li $v0, 1
        syscall     # ..<int>"
        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line
		li $t7, 1		# set the flag to 1 

        j exit_routine  # break;

case_5: bne $zero, $t5, defaultB
        li $a0, 5
        li $v0, 1
        syscall     # "5..
        la $a0, div_promptB 
        li $v0, 4
        syscall     # ..is a divisor of..
        move $a0, $s0
        li $v0, 1
        syscall     # ..<int>"
        li $a0, '\n'    # endl character
        li $v0, 11      # print_char
        syscall         # change line
		li $t7, 1		# set the flag to 1 

defaultB:
		bne $t7, $zero, exit_routine
		la $a0, no_divisor 
        li $v0, 4
        syscall     # 2,3,5 are not divisors of...
        move $a0, $s0
        li $v0, 1
        syscall		# ...<int>

 exit_routine:
        li $v0, 10
        syscall         # exit routine



