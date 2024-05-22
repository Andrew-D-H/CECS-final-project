.data
prompt: .asciiz "Enter a between 0 and 100 (-1 to exit): "
error_msg: .asciiz "Invalid input! Please enter a number between -1 and 100.\n"

.text

    li $v1, 0       # Initialize sum to 0
    li $t0, 0       # Initialize counter to 0

loop:
    # Prompt user for input
    li $v0, 4      
    la $a0, prompt  
    syscall

    # Read user input
    li $v0, 5     
    syscall
    move $t1, $v0   

    # Validate input
    ble $t1, -1, end_loop  
    bgt $t1, 100, loop_error 
    j add_sum   

loop_error:
    # Display error message
    li $v0, 4       
    la $a0, error_msg  
    syscall
    j loop        

add_sum:
    add $v1, $v1, $t1   # Add input to sum
    addi $t0, $t0, 1    # Increment counter
    j loop        

end_loop:
    # Calculate average
    div $v1, $t0   # Divide sum by counter
    mflo $s1       # Move result to $s1
    li $v0, 1
    add $a0, $zero, $s1
    syscall

    # Exit program
    li $v0, 10      
    syscall
