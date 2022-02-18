	.globl main

	.data
KEYBOARD_EVENT_PENDING:
	.word	0x0
KEYBOARD_EVENT:
	.word   0x0
KEYBOARD_COUNTS:
	.space  128
NEWLINE:
	.asciiz "\n"
SPACE:
	.asciiz " "
	
	.eqv  LETTER_a 97
	.eqv  LETTER_space 32
	
	
	.text  
main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

check_for_event:
	#<mike zastre> <lab08-c> (<MARS 4.5>)
    la $s0, 0xffff0000	# control register for MMIO Simulator "Receiver"
    lb $s1, 0($s0)
    ori $s1, $s1, 0x02	# Set bit 1 to enable "Receiver" interrupts (i.e., keyboard)
    sb $s1, 0($s0)
    
    la $t0, KEYBOARD_EVENT_PENDING   #check if user type smthing valid
    lb $t0, 0($t0)
    bne $t0, $zero, goto      # if yesm then goto 'goto'
    beq $zero, $zero, check_for_event  # if not , go back to check_for_event
    
goto:
    la $t0, KEYBOARD_EVENT	
    lb $t0, 0($t0)
count:
    lb $t2, KEYBOARD_COUNTS($t0)  #store the number of character
    addi $t1,$t2,1
    sb $t1, KEYBOARD_COUNTS($t0)    
    
 if:   
    beq $t0, 32, initialize
    blt $t0, LETTER_a, clear  #check the input value and examine
    bgt $t0, 122, clear
    b clear
initialize:
    addi $t0, $zero, LETTER_a
    
print_loop_begin:
    beq $t0, LETTER_a, loop1
    bgt $t0, 122, NewLine
	
space:			
    la $a0, SPACE
    li $v0, 4		#print space
    syscall
	
loop1:    
    lb $a0, KEYBOARD_COUNTS($t0)
    li $v0, 1				#keep print the alphabet list character number
    syscall
	
    addi $t0, $t0, 1
    b print_loop_begin	
NewLine:
	la $a0, NEWLINE
	li $v0, 4		#Print newline
	syscall
	
clear:
	sw $0, KEYBOARD_EVENT
	sw $0, KEYBOARD_EVENT_PENDING
	b check_for_event
	
	.kdata

	.ktext 0x80000180
__kernel_entry:		#<mike zastre> <lab08-c> (<MARS 4.5>)
	mfc0 $k0, $13
	andi $k1, $k0, 0x7c
	srl  $k1, $k1, 2
	beq $zero, $k1, __is_interrupt
	
__is_interrupt:			#<mike zastre> <lab08-c> (<MARS 4.5>)
	andi $k1, $k0, 0x0100	# examine bit 8
	la $k0, 0xffff0004
	lw $k0, 0($k0)
	beq $k0, $0, __exit_exception
	sw $k0, KEYBOARD_EVENT
	sw $k0, KEYBOARD_EVENT_PENDING
	
	


__exit_exception:
	eret

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE	
