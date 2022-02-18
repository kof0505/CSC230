# UVic CSC 230, Summer 2021
# Assignment #1, part A

# Student name: Min Gu Kim
# Student number: V00938382

# Determine the number of left-most zeros in register $8's value
# Store this number in register $15


.text

start:
	lw $8, testcase3  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	ori $15, $0, 0	# setting a result 
loop:
	andi $10, $8, 0x80000000  #set $10 to store the result of 'and' between testcase and 0x80000000. reason I choose 0x80000000 is because this hex number in binary contain only single 1 at the left most. other numbers are all zero 
	bne $10, $0, exit  # program exit when $10 is not equal to zero. 
	addi $15, $15, 1   # add the value 1 to result register
	sll $8, $8, 1  #after compare, left most bit need to be update. So $8 shift left 1 position to compare next left most bit
	b loop
	    
	nop
	addi $15, $0, -10
	##these tow command line was written since i download the file. even if i delete and run, program work fine. with this code , it also work fine
	# I am not sure should I delete or not. So I decide not to delete. I dont want unexpected error during marking.

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


exit:
	add $2, $0, 10
	syscall
		

.data

# Note: These test cases are not exhaustive. The teaching team
# will use other test cases when evaluating student submissions
# for this part of the assignment.

testcase1:
	.word	0x00200020    # left-most zero bits is 10 

testcase2:
	.word 	0xfacefade    # left-most zero bits is 0
	
testcase3:
	.word  0x01020304     # left-most zero bits is 7
	
testcase4:
	.word  0x0000000c    # left-most zero bits is 28
	
testcase5:
	.word  0x7000000b     # left-most zero bits is 1

