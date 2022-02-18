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
	
	.globl main
	.text	
	
	.eqv DIAMOND_SIZE 7
	
main:
	addi $a0, $zero, 5
	addi $a1, $zero, 5
	addi $a2, $zero, 0x00ff0000
	jal draw_bitmap_diamond
	
	addi $a0, $zero, 12
	addi $a1, $zero, 9
	addi $a2, $zero, 0x0000ff00
	jal draw_bitmap_diamond
	
	addi $a0, $zero, 10
	addi $a1, $zero, 2
	addi $a2, $zero, 0x00ffffff
	jal draw_bitmap_diamond
	
	addi $a0, $zero, 2
	addi $a1, $zero, 14
	addi $a2, $zero, 0x000000ff
	jal draw_bitmap_diamond
	
	addi $a0, $zero, 7
	addi $a1, $zero, 5
	addi $a2, $zero, 0x00000000
	jal draw_bitmap_diamond

	addi $v0, $zero, 10
	syscall
	

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

# Draws a 7x7 pixel diamond in the "Bitmap Display" tool
#
# $a0: row of diamond's midpoint
# $a1: column of diamond's midpoint
# $a2: colour of diamond
#
# The diamond will be seven pixels high, seven pixels wide
# (i.e. what is indicated by DIAMOND_SIZE).
#

draw_bitmap_diamond:
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
    
    

	

	
		
	

	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
