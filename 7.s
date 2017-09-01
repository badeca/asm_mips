.data
a:	.word 0
n: 	.word 0
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
	
factorial:
	j factorial
	
done:
		break
	
.end start