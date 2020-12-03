.text

lower1: lw $t0, pair1       # lower A
        lw $t1, pair1 + 8   # lower B

        addu $t2, $t0, $t1  # lower sum
        sw $t2, sums1       # store it

        srl $t0, $t0, 31    # lowerA's sign
        srl $t1, $t1, 31    # lowerB's sign
        srl $t2, $t2, 31    # lowerSum's sign
        nor $t2, $t2, $zero # flip lowerSum's sign

        and $s1, $t0, $t1   # AiBi
        and $s2, $t0, $t2   # Si'Ai
        and $s3, $t1, $t2   # Si'Bi
        or $s1, $s2, $s1    # AiBi + Si'Ai
        or $s0, $s3, $s1    # Si'Bi+Si'Ai+AiBi = lowerCarry

upper1: lw $t0, pair1 + 4   # upper A
        lw $t1, pair1 + 12  # upper B

        addu $t2, $t0, $t1  # upper sum
        ######################
        # overflow detection #
        ######################
        addu $t2, $t2, $s0  # add lowerCarry to the sum
        ######################
        # overflow detection #
        ######################
        sw $t2, sums1 + 4   # store it



lower2: lw $t0, pair2       # lower A
        lw $t1, pair2 + 8   # lower B

        addu $t2, $t0, $t1  # lower sum
        sw $t2, sums2       # store it

        srl $t0, $t0, 31    # lowerA's sign
        srl $t1, $t1, 31    # lowerB's sign
        srl $t2, $t2, 31    # lowerSum's sign
        nor $t2, $t2, $zero # flip lowerSum's sign

        and $s1, $t0, $t1   # AiBi
        and $s2, $t0, $t2   # Si'Ai
        and $s3, $t1, $t2   # Si'Bi
        or $s1, $s2, $s1    # AiBi + Si'Ai
        or $s0, $s3, $s1    # Si'Bi+Si'Ai+AiBi = lowerCarry

upper2: lw $t0, pair2 + 4   # upper A
        lw $t1, pair2 + 12  # upper B

        addu $t2, $t0, $t1  # upper sum
        ######################
        # overflow detection #
        ######################
        addu $t2, $t2, $s0  # add lowerCarry to the sum
        ######################
        # overflow detection #
        ######################
        sw $t2, sums2 + 4   # store it


        li $v0, 10          # exit routine
        syscall

    
.data
pair1:  .word 0xffffffff, 0x7fffffff # A
        .word 0x1, 0x0  # B
sums1:  .word 0x0, 0x0  # space for lower+upper sum

pair2:  .word 0xffffffff, 0x0 # A
        .word 0x0, 0xffffffff # B
sums2:  .word 0x0, 0x0  # space for lower+upper sum