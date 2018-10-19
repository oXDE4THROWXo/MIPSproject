.text
  main: 
    li $v0, 11        # Print chars
    la $a0, 64        # @ (64)
    syscall
    sub $v0, 10       # Print integers
    sub $a0, 64       # 0
    syscall
    addi $a0, 2       # 2
    syscall        
