# Skeleton file provided to students in UVic CSC 230, Summer 2021
# Original file copyright Mike Zastre, 2021

.text


main:	


# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

    ## Test code that calls procedure for part A
    #jal sos_send

    ## signal_flash test for part B
    #addi $a0, $zero, 0x24   # dot dot dash dot
    #jal signal_flash

    ## signal_flash test for part B
     #addi $a0, $zero, 0x73   # dash dash dash
     #jal signal_flash
        
    ## signal_flash test for part B
    # addi $a0, $zero, 0x23     # dot dash dot
    # jal signal_flash
            
    ## signal_flash test for part B
    # addi $a0, $zero, 0xff   # dash
    # jal signal_flash  
    
    # signal_message test for part C
    # la $a0, test_buffer
    # jal signal_message

    # one_alpha_encode test for part D
    # the letter 'p' is properly encoded as 0x64.
    # addi $a0, $zero, 'p'
    # jal one_alpha_encode  
    
    # one_alpha_encode test for part D
    # the letter 'a' is properly encoded as 0x12
    # addi $a0, $zero, 'a'
    # jal one_alpha_encode
    
    # one_alpha_encode test for part D
    # the space' is properly encoded as 0xff
    # addi $a0, $zero, ' '
    # jal one_alpha_encode
    
    # message_into_code test for part E
    # The outcome of the procedure is here
    # immediately used by signal_message
    # la $a0, message01
    # la $a1, buffer01
    # jal message_into_code
    # la $a0, buffer01
    # jal signal_message
    

get_outta_here:
    # Proper exit from the program.
    addi $v0, $zero, 10
    syscall


	
	
###########
# PROCEDURE
sos_send:

	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	
	jr $31


# PROCEDURE
signal_flash:
	
	addi $sp, $sp, -24
   	sw $s0, 0($sp)
   	sw $s1, 4($sp)
   	sw $s2, 8($sp)
   	sw $s3, 12($sp)
   	sw $s4, 16($sp)
   	sw $ra, 20($sp)
   
   
   	andi $s0, $a0, 15  #the low nibble
   	andi $s1, $a0, 240 #the high nibble
   	andi $s2, $zero, 0 #counter 
   	
   	div $s1, $s1, 16   # put the number right most
   	
   	sle $s3, $s2, $s0
   	jal if
   	
   	
   	jump_here:  
   
   	lw $ra, 20($sp)
   	lw $s4, 16($sp)
   	lw $s3, 12($sp)
   	lw $s2, 8($sp)
   	lw $s1, 4($sp)
   	lw $s0, 0($sp)
   	addi $sp, $sp, 24
   
   	jr $ra
  
   	
   	
if:
	beq $a0, 255, special   # switch for choose presedure. depends on low nibble vlaue
	beq $s0, 4, low_4
	beq $s0, 3, low_3
	beq $s0, 2, low_2
	beq $s0, 1, low_1
	jr $ra
	
special: # for special case , 0xff
	jal delay_long
	jal delay_long
	jal delay_long
	jr $ra
		

 low_4:
	#if low nibble value is 4
        andi $s4, $s1, 8
        beq $s4, 8, dash
         
        jal dot
      
      
        sll $s1, $s1, 1   
        addi $s0, $s0, -1
        jr $ra  	 	
   	 	 	

low_3:
	#if low nibble value is 3
	andi $s4, $s1, 4
        beq $s4, 4, dash
         
        jal dot
      
      
        sll $s1, $s1, 1   
        addi $s0, $s0, -1
        jr $ra  
 
low_2:
	#if low nibble value is 2
	andi $s4, $s1, 2
        beq $s4, 2, dash
         
        jal dot
      
      
        sll $s1, $s1, 1   
        addi $s0, $s0, -1
        jr $ra  

low_1:
	#if low nibble value is 1
	andi $s4, $s1, 1
        beq $s4, 1, dash
         
        jal dot
      
      
        sll $s1, $s1, 1   
        addi $s0, $s0, -1
        jr $ra  	 	 	 	 	
   	 	 	 	 	  	 	 	 	 	
   	 	 	 	 	  	 	 	 	 	  	 	 	 	 	
   	 	 	 	 	  	 	 	 	 	  	 	 	 	 	  	 	 	 	 	  	 	 	 	 	
dash:
	#handling dash using sll and count
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	
	addi $s2, $s2, 1
	beq $s2, $s0, loop2
	sll $s1, $s1, 1
      
         
        b if
	
	
dot:
	#handling dot using sll 
	jal seven_segment_on
	jal delay_short
	jal seven_segment_off
	
	addi $s2, $s2, 1
	beq $s2, $s0, loop2
	sll $s1, $s1, 1
	b if
	
	
	

	
	
	
loop2:
	j jump_here
		
	
		
		
		
		
		
				
	
	
	


###########
# PROCEDURE
signal_message:

	#load $a0 and if the value and check if is zero or not
	addi $sp, $sp, -12
   	sw $s0, 0($sp)
   	sw $s1, 4($sp)
   	sw $ra, 8($sp)
	
	la $s0, 0($a0)		#set $s0 as the address location
	jal if1
	jump_here1:
	
	lw $ra, 8($sp)
   	lw $s1, 4($sp)
   	lw $s0, 0($sp)
   	addi $sp, $sp, 12
   	jr $ra
	
if1:
	beq $s0, $zero, end			#check, if $s0 is zero or not
	bne $s0, $zero, next
	
	
	jr $ra
	
	next:
		#if not zero, preced the next step
		lb $s1, 0($s0)		#load the value
		move $a0, $s1		# and put it into the $a0
		jal signal_flash	
		addi $s0, $s0, 1	
		beq $s1, $zero, end
		
		
		
		b if1
		

	
	# stop the programming when it reach zero	
	end:
		
		j jump_here1
	
	
	
	
	
	
	
###########
# PROCEDURE
one_alpha_encode:
	addi $sp, $sp, -28
   	sw $s0, 0($sp)
   	sw $s1, 4($sp)
   	sw $s2, 8($sp)
   	sw $s3, 12($sp)
   	sw $t7, 16($sp)
   	sw $a0, 20($sp)				#read the memory address of $a0 to compare
   	sw $ra, 24($sp)				
	beqz $a0, exit2 
	la $s4, ($a0)
	la $s0, codes				#set up the adress location of codes to compare
	lb $s1,  ($s0)
	bnez $a0, while
exit2:

# this exit2 does not mean aything special, it is just for attempt debugging for part e)

	jr $ra	
	
	          
while: 
	
	bnez $a0, if_1
	 
	
	
	
	jr $ra	
	
if_1:
	#compare the value of $a0 and $s1, if they are equal jump to while2 loop
	beq $a0, ' ', space
	beq $a0, $s1, while2
   	addi $s0, $s0, 1
	lb $s1,  ($s0)
	b while
	jr $ra	
	
while2:
	addi $s0, $s0, 1
	lb $s2, 0($s0)
	beq $s2, '.', dot_loop			#now we take a look at value in .code. 
  	beq $s2, '-', dash_loop			#if dot appear go to dot_loop and dash, go to dash loop
   	
   	srl $s3, $s3, 1				#these sll srl add instruction is for modify the binary digits.
   	sll $s3,$s3, 4				# it occure after finish all the dot_loop and dash_loop.
   	add $s3, $s3, $t7
   	add $v0, $zero, $s3	#store the right hex two digits number in the $v0
   	lw $ra, 24($sp)
   	lw $a0, 20($sp)
	lw $t7, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
   	lw $s1, 4($sp)
   	lw $s0, 0($sp)
   	addi $sp, $sp, 28
	jr $ra
	
dot_loop:
	addi $t7, $t7, 1		#handling dinary digits calculation when dot appear
	addi $s3, $s3, 0
	sll $s3, $s3, 1
	
	b while2

dash_loop:				##handling dinary digits calculation when dash appear
	addi $t7, $t7, 1
	addi $s3, $s3, 1
	sll $s3, $s3, 1
	
	b while2

space: 
	addi $v0, $zero, 255		##handling dinary digits calculation when ' ' appear
	
	jr $ra



###########
# PROCEDURE
message_into_code:

	
	# for thie code, i did manage to store the equvalent hex digits to buffer1. However after it store in to data, error occur and program stop running.
	# so I tried to fix it but i guess this is the far as i can reach. 	
		
        addi $sp, $sp, -24
        sw $s5, 0($sp)
        sw $s6, 4($sp)
        sw $s7, 8($sp)
        sw $a0, 12($sp)
        sw $v0, 16($sp)
        sw $ra, 20($sp)
        la $s6, ($a0)   #store memory address to $s6
        lb $s7, 0($s6)
        la $s5, buffer01	#store buffer01 address to $s5
        add $a0, $zero, $s7
        bnez $a0, msg_loop   #uf $a0 is not zero, jump into the loop
          
        exit:
          
        lw $ra, 20($sp)
        lw $v0, 16($sp)
        lw $a0, 12($sp)
        lw $s7, 8($sp)
        lw $s6, 4($sp)
        lw $s5, 0($sp)
        addi $sp, $sp, 24
           
          
        jr $ra
          
msg_loop1:
	
	sb $v0, 0($s5)		#stroe the byte  number into buffer01 location
	jr $ra
         
msg_loop:

	
        jal one_alpha_encode    #call one_alpha_encode to covert into hex digit
        beqz $a0, stop
        jal msg_loop1			
        
        addi $s5, $s5, 1	#move the pointer for next loop iteration
          
        addi $s6, $s6, 1
        lb $a0, 0($s6)
          
        b msg_loop
        jr $ra
          
stop:
	j exit      
         
     

         
        
   

	
	


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


#############################################
# DO NOT MODIFY ANY OF THE CODE / LINES BELOW

###########
# PROCEDURE
seven_segment_on:
	la $t1, 0xffff0010     # location of bits for right digit
	addi $t2, $zero, 0xff  # All bits in byte are set, turning on all segments
	sb $t2, 0($t1)         # "Make it so!"
	jr $31


###########
# PROCEDURE
seven_segment_off:
	la $t1, 0xffff0010	# location of bits for right digit
	sb $zero, 0($t1)	# All bits in byte are unset, turning off all segments
	jr $31			# "Make it so!"
	

###########
# PROCEDURE
delay_long:
	add $sp, $sp, -4	# Reserve 
	sw $a0, 0($sp)
	addi $a0, $zero, 600
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31

	
###########
# PROCEDURE			
delay_short:
	add $sp, $sp, -4
	sw $a0, 0($sp)
	addi $a0, $zero, 200
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31

#############
# DATA MEMORY
.data
codes:
    .byte 'a', '.', '-', 0, 0, 0, 0, 0
    .byte 'b', '-', '.', '.', '.', 0, 0, 0
    .byte 'c', '-', '.', '-', '.', 0, 0, 0
    .byte 'd', '-', '.', '.', 0, 0, 0, 0
    .byte 'e', '.', 0, 0, 0, 0, 0, 0
    .byte 'f', '.', '.', '-', '.', 0, 0, 0
    .byte 'g', '-', '-', '.', 0, 0, 0, 0
    .byte 'h', '.', '.', '.', '.', 0, 0, 0
    .byte 'i', '.', '.', 0, 0, 0, 0, 0
    .byte 'j', '.', '-', '-', '-', 0, 0, 0
    .byte 'k', '-', '.', '-', 0, 0, 0, 0
    .byte 'l', '.', '-', '.', '.', 0, 0, 0
    .byte 'm', '-', '-', 0, 0, 0, 0, 0
    .byte 'n', '-', '.', 0, 0, 0, 0, 0
    .byte 'o', '-', '-', '-', 0, 0, 0, 0
    .byte 'p', '.', '-', '-', '.', 0, 0, 0
    .byte 'q', '-', '-', '.', '-', 0, 0, 0
    .byte 'r', '.', '-', '.', 0, 0, 0, 0
    .byte 's', '.', '.', '.', 0, 0, 0, 0
    .byte 't', '-', 0, 0, 0, 0, 0, 0
    .byte 'u', '.', '.', '-', 0, 0, 0, 0
    .byte 'v', '.', '.', '.', '-', 0, 0, 0
    .byte 'w', '.', '-', '-', 0, 0, 0, 0
    .byte 'x', '-', '.', '.', '-', 0, 0, 0
    .byte 'y', '-', '.', '-', '-', 0, 0, 0
    .byte 'z', '-', '-', '.', '.', 0, 0, 0
    
message01:  .asciiz "a a a"
message02:  .asciiz "sos"
message03:  .asciiz "thriller"
message04:  .asciiz "billie jean"
message05:  .asciiz "the girl is mine"
message06:  .asciiz "pretty young thing"
message07:  .asciiz "human nature"
message08:  .asciiz "we are the world"
message09:  .asciiz "off the wall"
message10:  .asciiz "i want you back"

buffer01:   .space 128
buffer02:   .space 128
test_buffer:    .byte 0x03 0x73 0x03 0x00    # This is SOS
