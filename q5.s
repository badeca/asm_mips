.data
	input_str: .asciiz "885688568697"
	output_str: .asciiz "000000"
.text
.globl start
.ent start

	start:

		la $4, input_str		# $4 as string input
		
		la $9, output_str       # $9 as string output
		
		jal function
		
		j done
		
	function:

		.control:
			lb $8, ($4)			# get the content of string
					
			beq $8, $0, .ret 	# check if it is the end of string
			
			addi $2, $0, 0      # init reg 2 (dozens)
			addi $3, $0, 0		# init reg 3 (units)
			
			addi $3, $8, 0		# reg 3 = unit
			
			addi $4, $4, 1		# advance one byte
			
			lb $8, ($4)			# get the content of string
			
			addi $2, $8, 0		# reg 2 = dozens
			
			addi $4, $4, 1		# advance one byte
			
			sll $2, $2, 5		# $2 = $2 * 10
			
			add $5, $2, $3		# $5 = $2 + $3
			
			sb $5, output_str	# store memory
			
			addi $9, $0, 1		# advance one byte
			
		.ret:					# end of label
			jr  $31
			
### done ###

	done:
		break
		
.end start
