.data
	input_str: .asciiz "O Romeo, Romeo! Wherefore art thou Romeo?"
	na: .word 0
.text
.globl start
.ent start
	start:

		la $4, input_str		# $4 as string input
		addi $5, $0, 'a'		# $5 as searched character
		lw $2, na				# $2 as result
		
		j char_counter

	char_counter:
		
		.control:
			lb $8, ($4)			# get the content of string
			beq $8, $0, .ret 	# check if it is the end of string
			beq $8, $5, .count	# check if it is the searched char
			j	.index_incr		# increment the string index

		.count:
			addi $2, $2, 1		# compute the char analyzed
			j .index_incr		# and increment the string index

		.index_incr:
			addi $4, $4, 1		# advance one byte, the sizeof character
			j .control			# go back to the control loop
		
		.ret:					# end of label
			j done

	done:
		break
		
.end start