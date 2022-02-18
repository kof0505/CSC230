# Skeleton file provided to students in UVic CSC 230, Summer 2021
# Original file copyright Mike Zastre, 2021

.include "a4support.asm"

.data

.eqv	MAX_ARRAY_SIZE 1024

.align 2
ARRAY_1:	.space MAX_ARRAY_SIZE
ARRAY_2:	.space MAX_ARRAY_SIZE
ARRAY_3:	.space MAX_ARRAY_SIZE
ARRAY_4:	.space MAX_ARRAY_SIZE
ARRAY_5:	.space MAX_ARRAY_SIZE
ARRAY_6:	.space MAX_ARRAY_SIZE
ARRAY_7:	.space MAX_ARRAY_SIZE
ARRAY_8:	.space MAX_ARRAY_SIZE

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

FILENAME_1:	.asciiz "integers-200-150.bin"
FILENAME_2:	.asciiz "integers-200-12345.bin"

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE



.globl main
.text 
main:

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	la $a0, FILENAME_1
	la $a1, ARRAY_1
	jal read_file_of_ints
	add $s1, $zero, $v0
	
	la $a0, FILENAME_2
	la $a1, ARRAY_2
	jal read_file_of_ints
	add $s2, $zero, $v0
	
	
	# WRITE YOUR SOLUTION TO THE PART E PROBLEM
	# HERE...
	
	move $t7, $s1
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	la $a0, ARRAY_1				#A3 = accumulate_max(A1)
	la $a1, ARRAY_3
	add $a2, $zero, $t7
	jal accumulate_max
	
	la $a0, ARRAY_2
	la $a1, ARRAY_4
	add $a2, $zero, $t7		#A4 = accumulate_max(A2)
	jal accumulate_max
	
	la $a0, ARRAY_3
	la $a1, ARRAY_5
	add $a2, $zero, $t7		#A5 = reverse(A3)
	jal reverse_array
	
	la $a0, ARRAY_4
	la $a1, ARRAY_5
	la $a2, ARRAY_6
	add $a3, $zero, $t7		#A6 = pairwise_max(A4, A5)
	jal pairwise_max
	
	la $a0, ARRAY_6
	la $a1, ARRAY_7			#A7 = accumulate_sum(A6)
	add $a2, $zero, $t7
	jal accumulate_sum
	
	
	
	la $a0, ARRAY_8		#call the array8 to store the number
	lw $t1, 0($a1)			#read the first element of $a1
	goto1:
	addi $a1, $a1, 4
	addi $t3,$t3, 1
	bne $t3, $a2, goto1 		#do the loop and reach the last element of the array
	lw $t1, 0($a1)
	sw $t1, 0($a0)			#then write on array8 only one number
	addi $a1, $zero, 1
	jal dump_ints_to_console		#then print
	
	
	
	# Get outta here.		
	add $v0, $zero, 10
	syscall	
	

	
# COPY YOUR PROCEDURES FROM PARTS A, B, C, and D BELOW
# THIS POINT.

accumulate_sum:
	
	addi $sp, $sp, -28
        sw $ra, ($sp)
        sw $a0, 4($sp)
        sw $a2, 8($sp)
        sw $t1, 12($sp)
        sw $t2, 16($sp)
        sw $s1, 20($sp)
        sw $a1, 24($sp)
	
	 
	lw $t1, 0($a0)
	sw $t1, 0($a1)
	
	loop:
	
	move $t2, $t1  #hold the previous value
	lw $t1, 4($a0)
	add $t1, $t1, $t2
	sw $t1, 4($a1)
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $s1, $s1, 1
	blt $s1, $a2, loop
	addi $a0, $zero, 0
	addi $a1, $zero, 0
	
	
	lw $ra, ($sp)
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $t1, 12($sp)
        lw $t2, 16($sp)
        lw $s1, 20($sp)
        lw $a1, 24($sp)
        addi $sp, $sp, 28
	jr $ra


# Accumulate max: Accepts two integer arrays where the value to be
# stored at each each index in the *second* array is the maximum
# of all integers from the index back to towards zero in the first
# array. The arrays are of the same size;  the size is the third
# parameter.
#
accumulate_max:

	
	addi $sp, $sp, -32
        sw $ra, ($sp)
        sw $a0, 4($sp)
        sw $a2, 8($sp)
        sw $t1, 12($sp)
        sw $t2, 16($sp)
        sw $s1, 20($sp)
        sw $a1, 24($sp)
        sw $t3, 28($sp)
	
	lw $t1, 0($a0)
	sw $t1, 0($a1)
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	move $t3, $t1
	lw $t1, 0($a0)
	bgt  $t1, $t3, loop1
	
	loop2:
	bgt  $t1, $t3, loop1
	move $t1, $t3
	sw $t1, 0($a1)
	
	
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	lw $t1, 0($a0)
	bgt  $t1, $t3, loop1
	addi $s1, $s1, 1
	blt $s1, $a2, loop2
	
	
	loop1:  #if low index have higher value
	sw $t1, 0($a1)
	move $t3, $t1
	
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	lw $t1, 0($a0)
	addi $s1, $s1, 1
	blt $s1, $a2, loop2
	
	
	lw $ra, ($sp)
        lw $a0, 4($sp)
        lw $a2, 8($sp)
        lw $t1, 12($sp)
        lw $t2, 16($sp)
        lw $s1, 20($sp)
        lw $a1, 24($sp)
        lw $t3, 28($sp)
        addi $sp, $sp, 32
	jr $ra
	
	
# Reverse: Accepts an integer array, and produces a new
# one in which the elements are copied in reverse order into
# a second array.  The arrays are of the same size; 
# the size is the third parameter.
#
reverse_array:



	addi $sp, $sp, -44
        sw $ra, ($sp)
        sw $a0, 4($sp)
        sw $a2, 8($sp)
        sw $t1, 12($sp)
        sw $t2, 16($sp)
        sw $t3, 20($sp)
        sw $a1, 24($sp)
        sw $t3, 28($sp)
	sw $t4, 32($sp)
	sw $t5, 36($sp)
	sw $t6, 40($sp)
	
	
	move $t4, $a0
	move $t5, $a1
	
	loop4:
	
	move $t2, $a2
	sub  $t2, $t2, $t3
	beq $t2, $zero, loop5
	lw $t1, 0($a0)
	
	loop3:
	addi $a1, $a1, 4
	subi $t2, $t2, 1
	bne $t2, $zero, loop3
	addi $a1, $a1, -4
	addi $t3, $t3, 1
	sw $t1, 0($a1)
	move $t6, $a0
	add $a0, $zero, $zero
	add $a1, $zero, $zero
	add $a0, $zero, $t6
	add $a1, $zero, $t5
	
	addi $a0, $a0, 4
	ble  $t3, $a2, loop4
	
	
	
	loop5:
	
	
        lw $ra, ($sp)
        lw $a0, 4($sp)
        lw $a2, 8($sp)
        lw $t1, 12($sp)
        lw $t2, 16($sp)
        lw $t3, 20($sp)
        lw $a1, 24($sp)
        lw $t3, 28($sp)
	lw $t4, 32($sp)
	lw $t5, 36($sp)
	lw $t6, 40($sp)
	addi $sp, $sp, 44
	jr $ra
	
	
# Reverse: Accepts three integer arrays, with the maximum
# element at each index of the first two arrays is stored
# at that same index in the third array. The arrays are 
# of the same size; the size is the fourth parameter.
#	
pairwise_max:
	
	addi $sp, $sp, -32
        sw $ra, ($sp)
        sw $a0, 4($sp)
        sw $a1, 8($sp)
        sw $a2, 12($sp)
        sw $a3, 16($sp)
        sw $t1, 20($sp)
        sw $t2, 24($sp)
        sw $t3, 28($sp)
	loop7:
	
	lw $t1, 0($a0)
	lw $t2, 0($a1)
	ble $t1, $t2, loop6
	sw $t1, 0($a2)
	addi $a2, $a2, 4
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t3, $t3, 1
	beq $t3, $a3, loop8
	j loop7
	
	
	loop6:
	sw $t2, 0($a2)
	addi $a2, $a2, 4
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t3, $t3, 1
	beq $t3, $a3, loop8
	j loop7
	
	
	loop8:
	
        lw $ra, ($sp)
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $a2, 12($sp)
        lw $a3, 16($sp)
        lw $t1, 20($sp)
        lw $t2, 24($sp)
        lw $t3, 28($sp)
        addi $sp, $sp, 32
	jr $ra


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
