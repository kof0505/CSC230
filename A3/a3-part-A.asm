
	.data
ARRAY_A:
	.word	21, 210, 49, 4
ARRAY_B:
	.word	21, -314159, 0x1000, 0x7fffffff, 3, 1, 4, 1, 5, 9, 2
ARRAY_Z:
	.space	28
NEWLINE:
	.asciiz "\n"
SPACE:
	.asciiz " "
		
	
	.text  
main:	
	la $a0, ARRAY_A
	addi $a1, $zero, 4
	jal dump_array
	
	la $a0, ARRAY_B
	addi $a1, $zero, 11
	jal dump_array
	
	la $a0, ARRAY_Z
	lw $t0, 0($a0)
	addi $t0, $t0, 1
	sw $t0, 0($a0)
	addi $a1, $zero, 9
	jal dump_array
		
	addi $v0, $zero, 10
	syscall

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	
	
dump_array:
	addi $s1, $zero, 1
	beq $a0, 268500992, array_a
	beq $a0, 268501008, array_b		#find the right addess to implement the loop
	beq $a0, 268501052, array_z
	

array_a:
	li $v0,1
	lw $a0, ARRAY_A($s2)
	syscall
	beq $s1, $a1, stop
	addi $s1, $s1, 1			#implement the loop and print the value with right number of amount
	addi $s2, $s2, 4
	la $a0, SPACE
	addi $v0, $zero, 4
	syscall	
	b array_a
	
	 
	
	
	
array_b:
	li $v0,1
	lw $a0, ARRAY_B($s2)
	syscall
	beq $s1, $a1, stop
	addi $s1, $s1, 1			#implement the loop and print the value with right number of amount
	addi $s2, $s2, 4
	la $a0, SPACE
	addi $v0, $zero, 4
	syscall	
	b array_b
	
array_z:
	li $v0,1
	lw $a0, ARRAY_Z($s2)
	syscall
	beq $s1, $a1, stop
	addi $s1, $s1, 1		#implement the loop and print the value with right number of amount
	addi $s2, $s2, 4
	la $a0, SPACE
	addi $v0, $zero, 4
	syscall	
	b array_z
	jr $ra
stop:
	la $a0, NEWLINE
	addi $v0, $zero, 4		#exit
	addi $s2, $zero, 0
	syscall	
	jr $ra
	
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
