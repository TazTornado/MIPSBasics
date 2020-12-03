.text
.globl __start

main:
    la $t7, b0
    ulw $t0, 11 ($t7)
    ulhu $t1, 5 ($t7)

    li $v0, 0xa
    syscall

.data
    .align 0
b0: .byte 0x01, 0x02, 0x03, 0x04
    .byte 0x05
    .half 0x6677
b1: .byte 0x81, 0x82, 0x83, 0x84
w:  .word 0x12345678, 0x87654321
