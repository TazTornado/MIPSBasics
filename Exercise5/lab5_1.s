.data 
testA:	.float -0,75, 1,0, 1,5, 0,0000152587890625
testB:	.float 0,775, 0,1, 1,23456789
# testC:	.float 

.text

main:	l.s $f12, testA
		li $v0, 2
		syscall

		li $v0, 10
		syscall
