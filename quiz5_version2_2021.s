#################################
# This solution is not generic,	#
# therefore not 100% correct.	#
#################################
.data

w0:     .word 0x000000DD
w1:     .word 0x1111CC11
w2:     .word 0x22BB2222
w3:     .word 0xAA333333

.text

main:
        # initialize all regs #
        lw $s0, w0
        lw $s1, w1
        lw $s2, w2
        lw $s3, w3


        # start playing around #
        addi $s3, $s3, -0x00333333
        addi $s2, $s2, -0x22002222
        addi $s1, $s1, -0x11110011

        or $s4, $s3, $s2
        or $s4, $s4, $s1
        or $s4, $s4, $s0