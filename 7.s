.data
a:	.word 0
n: 	.word 3
s: 	.word 5
sd:	 .word 0
	.text
	.globl start
	.ent start
	
start: 

	lw $8, n 					# $8 = n
	lw $9, s					# $9 = s
	lw $3, a					# start $3 = 0
	
	slt $10, $8, $0				# $8 < 0 ?
	bne $10, $0, ltz			# $10 != 0 -> $10 == 1 // ltz = lesser than zero
	slt $10, $9, $0				# $9 < 0 ?
	bne $10, $0, ltz			# $10 != 0 -> $10 == 1
	
	beq $8, $9, equal	
	
	beq $8, $0, z_equal
	beq $9, $0, z_equal					
	
	slt $10, $8, $9 			# s > n ?
	beq $10, $0, factorial		
	
	addi $3, $0, 4				# $3 = 4
	j factorial 
	
ltz:

	addi $3, $0, 5				# $3 = 5
	j factorial

	
equal:

	addi $3, $0, 6				# $3 = 6
	j factorial

z_equal:

	addi $3, $0, 7				# $3 = 7
	j factorial
	
factorial: 						# $ fatorial de n
	add $4, $0, $8
	jal fact
	j done
	
fact:
	
	addi $29, $29, -8 			
	sw $31, 4($29) 				# save the return address
 	sw $4, 0($29) 				# save the argument n
 	
	slti $8,$4,1 				# (n < 1) ?
	beq $8, $0, L1	 			# if n >= 1, goto L1
	
	addi $2,$0,1	 			# else return 1
	addi $29, $29, 8 			# pop 2 items off stack
	jr $31 						# return to caller
	
L1: 

	addi $4,$4,–1	 			# n >= 1: argument gets (n – 1)
 	jal fact 					# call fact with (n –1)
 	lw $4, 0($29) 				# return from jal: restore argument n
	lw $31, 4($29) 				# restore the return address
	addi $29, $29, 8 			# adjust stack pointer to pop 2 items
	mul $2, $4, $2 				# return n * fact (n – 1)
	jr $31 						# return to the caller
	
done:
		break
	
.end start