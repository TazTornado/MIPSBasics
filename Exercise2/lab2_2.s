.data
big_endian_word:   .word 0x89abcdef

.text

start:
    lw $t0, big_endian_word

    srl $s0, $t0, 24    # byte 0 into $s0

    sll $s1, $t0, 8
    srl $s1, $s1, 24    # byte 1 into $s1
    sll $s1, $s1, 8     # bring to position 15..8

    sll $s2, $t0, 16
    srl $s2, $s2, 24    # byte 2 into $s2
    sll $s2, $s2, 16    # bring to position 23..16

    sll $s3, $t0, 24    # byte 3 into $s3

    or $t1, $s0, $s1    #combining all 4 bytes into 1 word
    or $t1, $t1, $s2
    or $t1, $t1, $s3

    move $a0, $t1       # print little endian form
    li $v0, 0x01
    syscall

    li $v0, 0xa         # exit routine
    syscall
