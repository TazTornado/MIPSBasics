#########################################
# This version of the solution is the 	#
# correct one, because it is generic as #
# required.								#
#########################################

.data

w0:     .word 0x000000DD
w1:     .word 0x1111CC11
w2:     .word 0x22BB2222
w3:     .word 0xAA333333

mask1:  .word 0xFF000000
mask2:  .word 0x00FF0000
mask3:  .word 0x0000FF00

.text

main:
        # initialize all regs #
        lw $s0, w0
        lw $s1, w1
        lw $s2, w2
        lw $s3, w3


        # start playing around #
        lw $s4, mask1
        and $s3, $s3, $s4   # $s3 = 0xAA000000 ready to go

        lw $s4, mask2
        and $s2, $s2, $s4   # $s2 = 0x00BB0000 ready to go

        lw $s4, mask3
        and $s1, $s1, $s4   # $s1 = 0x0000CC00 ready to go

        # $s0 is already as it should be so good for me hehe

        or $s4, $s3, $s2    # $s4 = 0x0000CCDD
        or $s4, $s4, $s1    # $s4 = 0x00BBCCDD
        or $s4, $s4, $s0

