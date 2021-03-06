.data

    input_too_long:
    .asciiz "Input is too long."
    input_is_empty:
    .asciiz "Input is empty."
    invalid_number:
    .asciiz "Invalid base-36 number."
    input_storage:                      # saves space memory for user input string
    .space 2000                         # allocate 4 bytes for filtered out string that doesn't have white spaces
    filtered_input:                             
    .space 4

.text
main:

    la $a0, input_storage               # $a0 is the starting address of user input
    li $v0, 8                           # load code into $v0, $v0 is for user string input                                  
    syscall
                                        # Use a loop to extract string and exclude white spaces
    li $s2, 0 
    li $t1, 10                          # load new line char ASCII into $t        
    li $t2, 32                          # load space char ASCII into $t2
    
    filter_loop:
    lb $t0, 0($a0)                      # load byte from $a0, $a0 points to first byte of user input and is updated in the loop
    beq $t0, $t1, exit_filter_loop      # exit when new line char found       
    beq $t0, $t2, skip                         
    beqz $t0, exit_filter_loop          # exit loop when NUL is found
    
    bne $s2, $zero, print_more_than_four       
    li $s2, 1                                  
    la $a1, filtered_input              # load address of filtered_input                 
    sb $t0, 0($a1)
    lb $t0, 1($a0)
    sb $t0, 1($a1)
    lb $t0, 2($a0)
    sb $t0, 2($a1)
    lb $t0, 3($a0)
    sb $t0, 3($a1)
    addi $a0, $a0, 3                            # updated address pointed in the loop to skip checking the 4 bytes already loaded into filtered_input

    skip:
    addi $a0, $a0, 1
    jal filter_loop
    
    exit_filter_loop:
    beqz $s2, print_empty
    
    li $s0, 1                                   # number to multiply 36 with after each iteration of valid char                                 
    li $s1, 0                                   # sum number based on calculation in each iteration
    li $s4, 0                                   # loop counter
    li $s6, 0                                   # will be updated to 1 when a non-space, non-NUL or non-new-line-char is found. 
    addi $a0, $a0, 4                            # $a0 points to the 5th byte now. 
    
                                                # Maintain a count of numer of characters read using $s4
    loop:
    li $t5, 4
    beq $t5, $s4, loop_exit
    addi $s4, $s4, 1                            
    addi $a0, $a0, -1 
    
    lb $t2, 0($a0)                                # get ASCII value of current char
    beqz $t2, loop                                # if the value is NUL, branch to loop start
    
    li $a1, 10                                    # load new line char in $a1
    beq $a1, $t2, loop                            # go to loop start if it is new line char.
    
    li $s7, 32                             
    beq $t2, $s7, handle_space
    
    li $s6, 1
    
    li $t0, 47
    slt $t1, $t0, $t2
    slti $t4, $t2, 58
    and $s5, $t1, $t4
    addi $s3, $t2, -48                             # $s3 has required value used for calulation later                        
    li $t7, 1
    beq $t7, $s5, calculation                      # if $s5 already has 1, calculate the char's value from ASCII
    
    li $t0, 64
    slt $t1, $t0, $t2
    slti $t4, $t2, 91
    and $s5, $t1, $t4                               #if $t2 has value within range 97 and 122
    addi $s3, $t2, -55 
    li $t7, 1
    beq $t7, $s5, calculation                   
    
    li $t0, 96
    slt $t1, $t0, $t2
    slti $t4, $t2, 123
    and $s5, $t1, $t4                          
    addi $s3, $t2, -87
    li $t7, 1
    beq $t7, $s5, calculation                           # if $s5 already has 1, calculate the char's value from ASCII 
    
    beq $s5, $zero, print_invalid_value                 # if $t2 has invalid value, jump to print_invalid_value    

    calculation:
    mult $s0, $s3                               
    mflo $t3
    add $s1, $s1, $t3                                   # add the above multiplication to the value resulting from calculation 
    
                                                        # Calculate the value of $s0 for next round of multiplication
    li $t6, 36
    mult $s0, $t6
    mflo $s0
    # Start the loop again
    jal loop

    handle_space:
    beq $zero, $s6, loop                                # if no alphanumeric char found, branch to loop                       
    jal print_invalid_value
    
    loop_exit:
    li $v0, 1                                           # load code to print integer                                
    add $a0, $zero, $s1                                 # load value calculated in the loop
    syscall
    jal exit
    
    print_empty:
    la $a0, input_is_empty                              # load address of the string to print              
    li $v0, 4                                           # load code to print string                                 
    syscall
    jal exit
    
    print_invalid_value:
    la $a0, invalid_number                              # load address of the string to print                     
    li $v0, 4                                           # load code to print string
    syscall
    jal exit
    
    print_more_than_four:
    la $a0, input_too_long                      
    li $v0, 4                                   
    syscall

    exit:
    li $v0, 10                                          # load code to exit the program                      
    syscall                
