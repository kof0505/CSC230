# UVic CSC 230, Summer 2021
# Assignment #1, part B

# Student name: Min Gu Kim
# Student number: V938382


.text

start:
	lw $8, testcase4_a  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	lw $9, testcase4_b  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	ori $15, $0 , 0	# setting a result 
	ori $7, $0, 0xFFFFFFFF  #setting a countdown vlaue
		
loop:
	
	
	xor $11, $8, $9
	andi $11, $11, 0x00000001

	
	bne $11, $0, loop2
	
	srl $8, $8, 1 
	srl $9, $9, 1 
	srl $7, $7, 1		
	beq $7, $0, exit
	
	b loop
	#using xor return value 1, when two value bit are different. Then set $11 to comparison the result of xor.
	#if the right most value is one then go to loop, if not , repeat the loop. To prevent the infinet loop, i set up the countdown vlaue $7.
	#when it reach to zero, program exit
loop2:
	addi $15, $15, 1
	srl $8, $8, 1 
	srl $9, $9, 1 

		
	b loop
	#xor right most bit is 1, so move to loop2 and add a value one to result register $15
	#and shit right to compare next right most bit.
	nop
	addi $15, $0, -10
	#these tow command line was written since i download the file. even if i delete and run, program work fine. with this code , it also work fine
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

# testcase1: Hamming distance is 32
testcase1_a:
	.word	0x00000000
testcase1_b:
	.word   0xffffffff
	    

# testcase2: Hamming distance is 0
testcase2_a:
	.word	0xabcd0123
testcase2_b:
	.word   0xabcd0123
	
	
# testcase3: Hamming distance is 16
testcase3_a:
	.word	0xffff0000
testcase3_b:
	.word   0xaaaaaaaa
	
	
# testcase4: Hamming distance is 11
testcase4_a:
	.word	0xcafef00d
testcase4_b:
	.word   0xfacefade
