.data
.text
.globl start
.ent start

start: 	
	add $6, $0, $0				# $6 = 0
	addi $7, $0, 20				# $7 = 20
	addi $8, $0, 14				# $8 = 14
 	add $10, $0, $0 			# $10 = 0
 	
for:
	add $6, $0, $0				# $6 = 0
	slti $12, $6, 10 			# $6 < 10 ?     
	beq $12, $0, endfor
		
	if:
 		slt $12, $7, $8				# ($7 < $8) ? 1 : 0
 		beq $12, $0, else
 		addi $9, $0, 15 			# $9 = 15
 		addi $10, $10, 1			# $10 ++
 		addi $6, $6, 1 				# $6 ++
 		j for
	else:
		addi $9, $0, 13				# $9 = 13
		addi $8, $8, 1				# $8 ++
		addi $6, $6, 1 				# $6 ++
 		j for
	
endfor:	
	slt $12, $10, $8 			# ($10 < $8) ? 1 : 0
	beq $12, $0, done 			
	addi $11, $0, 1				# $11 = 1
	
done:

.end start

