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
    sub $a0,  2       # 0
    syscall
    addi $a0, 2       # 2
    syscall
    sub $a0,  2       # 0
    syscall
    addi $a0, 2       # 2
    syscall
    addi $a0, 6       # 9
    syscall
    sub $a0,  8       # 1
    syscall
    addi $v0, 10
    addi $a0, 4       # LF (10) (since I'm on a POSIX machine)
    syscall
    
    
   
