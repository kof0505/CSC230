# UVic CSC 230, Summer 2021
#
# Good day, world!

	.data
goodday_string:
	.asciiz	"\nGood Day! My name is Min Gu Kim\n\n"
goodday_number:
	.asciiz "V00938382\n"
	
	
	.text
main:
	li	$v0, 4
	la	$a0, goodday_string
	syscall
	
	li	$v0, 4
	la	$a0, goodday_number
	syscall
	
	li	$v0, 10
	syscall
