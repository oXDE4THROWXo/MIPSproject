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
    addi $a0, 45      # W (55)
    syscall
    addi $a0, 42      # a (97)
    syscall
    addi $a0, 19      # t (116)
    syscall
    sub $a0,  15      # e (101)
    syscall
    addi $a0, 13      # r (114)
    syscall
    addi $a0, 1       # s (115)
    syscall
    sub $a0,  71      # , (44)
    syscall
    sub $a0,  12      # [space] (32)
    syscall
    addi $a0, 35      # C (67)
    syscall
    addi $a0, 37      # h (104)
    syscall
    addi $a0, 10      # r (114)
    syscall
    sub $a0,  9       # i (105)
    syscall
    addi $a0, 10      # s (115)
    syscall
    addi $a0, 10      # t (116)
    syscall
    sub $a0,  5       # o (111)
    syscall
    addi $a0, 2       # p (112)
    syscall
    sub $a0,  8       # h (104)
    syscall
    sub $a0,  3       # e (101)
    syscall
    addi $a0, 13      # r (114)
    syscall
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
