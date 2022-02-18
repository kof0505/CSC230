# This code assumes the use of the "Bitmap Display" tool.
#
# Tool settings must be:
#   Unit Width in Pixels: 32
#   Unit Height in Pixels: 32
#   Display Width in Pixels: 512
#   Display Height in Pixels: 512
#   Based Address for display: 0x10010000 (static data)
#
# In effect, this produces a bitmap display of 16x16 pixels.


	.include "bitmap-routines.asm"

	.data
TELL_TALE:
	.word 0x12345678 0x9abcdef0	# Helps us visually detect where our part starts in .data section
KEYBOARD_EVENT_PENDING:
	.word	0x0
KEYBOARD_EVENT:
	.word   0x0
DIAMOND_ROW:
	.word	9
DIAMOND_COLUMN:
	.word	9
	
DIAMOND_COLOUR_1:
	.word 0x00db93c0
	
	.eqv LETTER_a 97
	.eqv LETTER_d 100
	.eqv LETTER_w 119
	.eqv LETTER_s 115
	.eqv LETTER_space 32
	
	.globl main
	
	.text	
main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	
	
check_for_event:
	 #<mike zastre> <lab08-c> (<MARS 4.5>) 
    la $s0, 0xffff0000   # control register for MMIO Simulator "Receiver"
    lb $s1, 0($s0)
    ori $s1, $s1, 0x02   # Set bit 1 to enable "Receiver" interrupts (i.e., keyboard)
    sb $s1, 0($s0)
    la $a0, DIAMOND_ROW
    lb $a0, 0($a0)
    la $a1, DIAMOND_COLUMN
    lb $a1, 0($a1)
    lw $a2, DIAMOND_COLOUR_1
    jal draw_bitmap_diamond
    
    lw $t0, KEYBOARD_EVENT_PENDING
    bne $t0, $zero, loop
    beq $zero, $zero, check_for_event

left: 
    addi $s2, $zero,-1
    addi $s3, $zero, 0
    b black_diamond
right: 
    addi $s2, $zero, 1
    addi $s3, $zero, 0				#put the value 1, -1 or 0 for wasd move
    b black_diamond    
up: 
    addi $s2, $zero, 0
    addi $s3, $zero, -1
    b black_diamond  
down: 
    addi $s2, $zero, 0
    addi $s3, $zero, 1
    b black_diamond    

black_diamond:    
    addi $a0, $a0, 0
    addi $a1, $a1, 0
    add $a2, $zero, $zero			 #black diamond at the orginal location
    jal draw_bitmap_diamond 
    b new_diamond          

loop:
    la $t0, KEYBOARD_EVENT
    lb $t0, KEYBOARD_EVENT
    beq $t0, LETTER_space, swap_color      #switch for user input
    beq $t0, LETTER_a, left
    beq $t0, LETTER_d, right
    beq $t0, LETTER_w, up
    beq $t0, LETTER_s, down
    

  
#<twalsh123> <https://www.youtube.com/watch?v=UejZ2A1HJms&ab_channel=twalsh123> (<MARS 4.5>)
swap_color:
    lw $a2, DIAMOND_COLOUR_2
    lw $t0, DIAMOND_COLOUR_1
    sw $a2, DIAMOND_COLOUR_1		#swap the color
    sw $t0, DIAMOND_COLOUR_2
    b new_color_diamond

  
    
new_diamond:
    
    add $a0, $a0, $s3
    sw $a0, DIAMOND_ROW
    add $a1, $a1, $s2				#update location
    sw $a1, DIAMOND_COLUMN			#save new location and draw with pink
    lw $a2, DIAMOND_COLOUR_1
    jal draw_bitmap_diamond           
 new_color_diamond:           
    la $a0, DIAMOND_ROW
    lb $a0, DIAMOND_ROW
    la $a1, DIAMOND_COLUMN
    lb $a1, DIAMOND_COLUMN
    jal draw_bitmap_diamond
    b clear 
         
clear:
    sw $0, KEYBOARD_EVENT
    sw $0, KEYBOARD_EVENT_PENDING
    b check_for_event                           
    # Should never, *ever* arrive at this point
    # in the code.  

    addi $v0, $zero, 10

.data
    .eqv DIAMOND_COLOUR_BLACK 0x00000000
.text

    addi $v0, $zero, DIAMOND_COLOUR_BLACK
    syscall

	

draw_bitmap_diamond:
 
# You can copy-and-paste some of your code from part (c)
# to provide the procedure body.
#
    addi $sp, $sp, -12
    sw $ra, ($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
	
    
    jal set_pixel
    subi $a0, $a0, 3
    jal set_pixel
    addi $a0, $a0,1
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, 2
    jal set_pixel
    addi $a0, $a0,1
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 2
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 1
    addi $a0, $a0, 1
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, 2
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    addi $a0, $a0, 1
    subi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    subi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, 1
    addi $a0, $a0, 1
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, 1
    jal set_pixel
    addi $a1, $a1, -1
    addi $a0, $a0, 1
    jal set_pixel
 
    lw $ra, ($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    addi $sp, $sp, 12
    jr $ra



	.kdata

	.ktext 0x80000180
#
# You can copy-and-paste some of your code from part (b)
# to provide elements of the interrupt handler.
#

__kernel_entry:
    mfc0 $k0, $13		#<mike zastre> <lab08-c> (<MARS 4.5>)
    andi $k1, $k0, 0x7c
    srl  $k1, $k1, 2       
    beq $zero, $k1, __is_interrupt
__is_interrupt:			#<mike zastre> <lab08-c> (<MARS 4.5>)
    andi $k1, $k0, 0x0100
    li $k0, 0xffff0004
    lw $k0, 0($k0)
    beq     $k1, $0, __exit_exception

    sw $k0, KEYBOARD_EVENT
    sw $k0, KEYBOARD_EVENT_PENDING
__exit_exception:
    eret

.data

# Any additional .text area "variables" that you need can
# be added in this spot. The assembler will ensure that whatever
# directives appear here will be placed in memory following the
# data items at the top of this file.
DIAMOND_COLOUR_2:
	.word 0x00938382
    
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


.eqv DIAMOND_COLOUR_WHITE 0x00FFFFFF
