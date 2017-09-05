.data
n: 	.word 0
s: 	.word 
sd:	.word 0
	.text
	.globl start
	.ent start
	
start: 

	lw $8, n 					# $8 = n
	lw $9, s					# $9 = s
	add $3, $0, $0				# start $3 = 0
	
	slt $10, $8, $9 			# is s greater than n?
	bne $10, $0, s_greater		# if so, go to s_greater
	
	slt $10, $8, $0				# is $8 lesser than zero?
	bne $10, $0, ltz			# if it is go to ltz // ltz = lesser than zero
	slt $10, $9, $0				# is $9 lesser than zero?
	bne $10, $0, ltz			# if it is, go to ltz // ltz = lesser than zero
	
	beq $8, $9, equal			# are $8 and $9 equal? if so, go to equal
	
	beq $8, $0, z_equal			# is $8 equal zero? if it is, go to z_equal
	beq $9, $0, z_equal			# is $9 equal zero? if it is, go to z_equal
	
	j combination				# else do the combination
	
s_greater:

	addi $3, $0, 4				# $3 = 4
	j done
	
ltz:

	addi $3, $0, 5				# $3 = 5
	j done

equal:

	addi $3, $0, 6				# $3 = 6
	j done

z_equal:

	addi $3, $0, 7				# $3 = 7
	j done
	
combination:

	add $4, $0, $8				# parameter n to the fact
	jal fact					# call fact function
	add $11, $0, $2				# $11 stores !n
	add $4, $0, $9				# parameter s to the fact
	jal fact					# call fact function
	add $12, $0, $2				# $12 stores !s
	add $4, $0, $8				# $4 = $8
	sub $4, $4, $9 				# $4 = $8 - $9 // (n - s)
	jal fact					# call fact function
	add $13, $0, $2				# $13 stores !(n - s)
	mul $12, $12, $13			# $12 = !s * !(n - s)
	div $11, $11, $12			# $11 = !n / (!s * !(n - s))
	
	sw $11, sd					# sd = !n / (!s * !(n - s))
	
	j done
	
done:
	break
	
## @param: $4 as the value used in the factorial
## @return: $2 as the fact result
## @altered_reg: $10, $2
fact:
	
	addi $29, $29, -8 			# adjust stack for 2 items
	sw $31, 4($29) 				# save the return address
 	sw $4, 0($29) 				# save the argument n
 	
	slti $10, $4, 1 			# is n lesser than 1?
	beq $10, $0, L1	 			# if not, goto L1
	
	addi $2, $0, 1	 			# else return 1
	addi $29, $29, 8 			# pop 2 items
	jr $31 						# return
	
L1: 

	addi $4, $4, -1	 			# n--
 	jal fact 					# call fact with n-1
 	
 	lw $4, 0($29) 				# $4 = n
	lw $31, 4($29) 				# $31 receives the last return address
	addi $29, $29, 8 			# pop 2 items
	mul $2, $4, $2 				# $2 = n * fact (n – 1)
	jr $31  					# return
	
.end start