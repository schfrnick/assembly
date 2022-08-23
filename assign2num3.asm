.data

enterNum: 	.asciiz "Enter your integer:  "
printBinary: 	.asciiz "The number in binary:  "

.text
#Print out string, collect intger input
main: li $v0, 4
      la $a0, enterNum
      syscall
  li $v0, 5
  syscall
  move $t0, $v0


#create print out the second string and prepare to print out binary
mask: 
  add $t1, $zero, 1
  sll $t1, $t1, 31
  addi $t2, $zero, 32
  li $v0, 4
  la $a0, printBinary
  syscall


 # compares integer
 
 loop: 
  and $t3,$t0, $t1
  beq $t3, $zero, print
  add $t3, $zero, $zero
  addi $t3, $zero, 1
  j print


 print: 
     
  li $v0, 1		 #prepares to print int

      
  move $a0, $t3		# moves into $a0 to be printed
  syscall

      
  srl $t1, $t1, 1	#shift

      #deincrement
  addi $t2, $t2, -1

      #loop back 
  bne $t2, $zero, loop
  beq $t2, $zero, exit
 exit: 
  li $v0, 10
  syscall