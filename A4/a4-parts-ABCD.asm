# Skeleton file provided to students in UVic CSC 230, Summer 2021
# Original file copyright Mike Zastre, 2021

.include "a4support.asm"


.globl main

.text 

main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	la $a0, FILENAME_1
	la $a1, ARRAY_A
	jal read_file_of_ints
	add $s0, $zero, $v0	# Number of integers read into the array from the file
	
	la $a0, ARRAY_A
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part A test
	#
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	add $a2, $zero, $s0
	jal accumulate_sum
	
	
	la $a0, ARRAY_B
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part B test
	#
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	add $a2, $zero, $s0
	jal accumulate_max
	
	la $a0, ARRAY_B
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part C test
	#
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	add $a2, $zero, $s0
	jal reverse_array
	
	la $a0, ARRAY_B
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part D test
	la $a0, FILENAME_1
	la $a1, ARRAY_A
	jal read_file_of_ints
	add $s0, $zero, $v0
	
	la $a0, FILENAME_2
	la $a1, ARRAY_B
	jal read_file_of_ints
	# $v0 should be the same as for the previous call to read_file_of_ints
	# but no error checking is done here...
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	la $a2, ARRAY_C
	add $a3, $zero, $s0
	jal pairwise_max
	
	la $a0, ARRAY_C
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Get outta here...
	add $v0, $zero, 10
	syscall	
	
	
# Accumulate sum: Accepts two integer arrays where the value to be
# stored at each each index in the *second* array is the sum of all
# integers from the index back to towards zero in the first
# array. The arrays are of the same size; the size is the third
# parameter.
#
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
	sw $t1, 0($a1)       #save first number of $a0 array to $a1
	
	loop:
	
	move $t2, $t1  #hold the previous value
	lw $t1, 4($a0)
	add $t1, $t1, $t2
	sw $t1, 4($a1)
	addi $a0, $a0, 4		#store the number to $a1 and move the both $a0 and $a1 address. load and write
	addi $a1, $a1, 4		#keep repeat it uintil the end of the array
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
	addi $a1, $a1, 4		#load the first number of $a0 and next number. 
	move $t3, $t1
	lw $t1, 0($a0)
	bgt  $t1, $t3, loop1		#then, we compare the two number. if $t1 is greater than $t3, go to loop1
	
	loop2:
	bgt  $t1, $t3, loop1
	move $t1, $t3
	sw $t1, 0($a1)
	
	
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	lw $t1, 0($a0)
	bgt  $t1, $t3, loop1
	addi $s1, $s1, 1
	blt $s1, $a2, loop2		#it control the loop. how many time should it run
	
	
	loop1:  #if low index have higher value
	sw $t1, 0($a1)
	move $t3, $t1
	
	addi $a0, $a0, 4		#take the higher number after comparing. and store to $a1. then update the address 
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
	lw $t1, 0($a0)			#load the number of $a0 
	
	loop3:
	addi $a1, $a1, 4			#keep add the $a1 address location until the end
	subi $t2, $t2, 1
	bne $t2, $zero, loop3			
	addi $a1, $a1, -4
	addi $t3, $t3, 1
	sw $t1, 0($a1)				#store the number when it reach to the end of the array
	move $t6, $a0
	add $a0, $zero, $zero
	add $a1, $zero, $zero
	add $a0, $zero, $t6
	add $a1, $zero, $t5
	
	addi $a0, $a0, 4			#when one number is done store, go to loop4 and start do the same process for the next number
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
	ble $t1, $t2, loop6			#load the first number of each array
	sw $t1, 0($a2)				#and if $t2 is larger, continue to next code and store the value on the third array
	addi $a2, $a2, 4
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $t3, $t3, 1
	beq $t3, $a3, loop8
	j loop7
	
	
	loop6:
	sw $t2, 0($a2)
	addi $a2, $a2, 4		# also the same process above. store the right number after comparison and store to thrid array
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
	

.data

.eqv	MAX_ARRAY_SIZE 1024

.align 2

ARRAY_A:	.space MAX_ARRAY_SIZE
ARRAY_B:	.space MAX_ARRAY_SIZE
ARRAY_C:	.space MAX_ARRAY_SIZE

FILENAME_1:	.asciiz "integers-10-6.bin"
FILENAME_2:	.asciiz "integers-10-21.bin"


# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


# In this region you can add more arrays and more
# file-name strings. Make sure you use ".align 2" before
# a line for a .space directive.


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
