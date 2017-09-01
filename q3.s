.data
	input_str: .asciiz "O Romeo, Romeo! Wherefore art thou Romeo?"
	na: .word 0
.text
.globl start
.ent start
	start:

		la $4, input_str		# $4 as string input
		addi $5, $0, 'a'		# $5 as searched character
	
		jal char_counter
		sw $2, na
		j done
		
### v0 char_counter(a0&, a1) ###
## @param:
# $4 as ADDRESS of input string (the address will be modified) 
# $5 as searched character (safe)
## @reg: $8 as auxiliary register
## @return: $2 as number of $5 chars in $4 string
	char_counter:
		
		addi $2, $0, 0
		
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
			jr  $31
### done ###

	done:
		break
		
.end start
