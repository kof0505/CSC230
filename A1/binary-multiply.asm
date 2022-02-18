# UVic CSC 230, Summer 2021
# Assignment #1, part C

# Student name: Min Gu Kim
# Student number: V00938382

# Using the binary multiply (i.e., repeated shfits + add) technique,
# multiply value in $8 with value in $9. The initial values in $8
# and $9 will always be less than 0x7FFF (i.e., only right-most 15
# bits are used, such that result will always fit into 32 bits and
# not otherwise cause an arithmetic overflow).
#
# Store the result of the multiply in $15.


.text

start:
	lw $8, testcase3_a  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	lw $9, testcase3_b  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
set:
	ori $15, $0, 0 # setting a result 
	
	add $18, $0, $9	# copy the value of testcase b to edit and modify (shift)

if:
	
	beqz $8, exit
	and $10, $18, 0x1        
	beq $10, 0, if_cal
	beq $10, 1, else_cal
	#find out the binary combination of testcase b by 'and' with 0x1. If right most value is 0, go
	#to if_cal and if the bit is 1, then go to else_cal
	

	
if_cal:
	
	sll $8, $8, 1   #if the right most bit is 0, shift left the $8 value to make double 
	srl $18, $18, 1 #for next bit comparison, shit right to get rid of previous right most value
	b if
	
	
else_cal:
	add $15, $15, $8   #if the right most bit is 1, then add the $8 (contain copy value of testcase b) to result register $15
	sll $8, $8, 1	
	srl $18, $18, 1
	b if
	


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


exit:
	add $2, $0, 10
	syscall
		

.data

# Note: These test cases are not exhaustive. The teaching team
# will use other test cases when evaluating student submissions
# for this part of the assignment.

# testcase1: Result is 0x15
testcase1_a:
	.word	0x00000004
testcase1_b:
	.word   0x00000008
	    

# testcase2: Result is 0x00006c98
testcase2_a:
	.word	0x000000c8   # decimal 200
testcase2_b:
	.word   0x0000008b   # decimal 139


# testcase3: Result is 0x3fff0001
testcase3_a:
	.word	0x00007fff   # decimal 32767
testcase3_b:
	.word   0x00007fff
	
