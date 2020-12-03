.text 

a:  lw $t0, pair1
    lw $t1, pair1 + 4

    mult $s0, $t0, $t1      # signed multiplication  
    mflo $t2
    mfhi $t3
    sw $t2, results1        # storing result   
    sw $t3, results1 + 4

    multu $s0, $t0, $t1     # unsigned multiplication
    mflo $t2
    mfhi $t3
    sw $t2, results1 + 8    # storing result
    sw $t3, results1 + 12

b:  lw $t0, pair2
    lw $t1, pair2 + 4

    mult $s0, $t0, $t1      # signed multiplication  
    mflo $t2
    mfhi $t3
    sw $t2, results2        # storing result   
    sw $t3, results2 + 4

    multu $s0, $t0, $t1     # unsigned multiplication
    mflo $t2
    mfhi $t3
    sw $t2, results2 + 8    # storing result
    sw $t3, results2 + 12


c:  lw $t0, pair3
    lw $t1, pair3

    mult $s0, $t0, $t1      # signed multiplication  
    mflo $t2
    mfhi $t3
    sw $t2, results3        # storing result   
    sw $t3, results3 + 4

    multu $s0, $t0, $t1     # unsigned multiplication
    mflo $t2
    mfhi $t3
    sw $t2, results3 + 8    # storing result
    sw $t3, results3 + 12

    li $v0, 10              # exit routine
    syscall


.data
pair1:      .word 0xa, 0x8
results1:   .word 0x0, 0x0, 0x0, 0x0    # for mult and multu result
pair2:      .word 0x2, 0xffffffff
results2:   .word 0x0, 0x0, 0x0, 0x0    # for mult and multu result
pair3:      .word 0x8fffffff            # same number twice
results3:   .word 0x0, 0x0, 0x0, 0x0,   # for mult and multu result