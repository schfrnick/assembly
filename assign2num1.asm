.data
prompt:     .asciiz     " \n Enter string "
dot:        .asciiz     "."
eqmsg:      .asciiz     "strings are equal\n"
nemsg:      .asciiz     "strings are not equal\n"
result:     .asciiz	"in space "

str1: .space 20
str2: .space 20


    .text

    .globl  main
main:
    #display first prompt
	li $v0, 4
	la $a0, prompt
	syscall

	#read first instruction
	li $v0, 8
	la $a0,str1
	li $a1,50
	move $s2, $a0
	syscall
	
	#display the second prompt
	li $v0, 4
	la $a0, prompt
	syscall

	#read second string
	li $v0, 8
	la $a0,str2
	li $a1,50
	move $s3, $a0
	syscall
	

# string compare loop ()
cmploop:
	
    lb      $t2,($s2)                   # get next char from str1
    lb      $t3,($s3)
                   
    bne     $t3,$t2,ss
    beq     $t3,$t2,cmpeq #(strings equal)               
    
    
ss:
	addi    $s3,$s3,1                   # point to next char
	lbu	$t0,($s3)
	beq	$t0,$zero,ms			#check if null pointer then go to main string to increment if null pointer
	addi	$s5,$s5,1		#count length of substring to reset incrementation
	j	cmploop

	
ms:
	addi    $s2,$s2,1                   # point to next char
	addi    $s4,$s4,1			# index counter
	sub     $s3,$s3,$s5		#subtract incrementation
	lbu	$t0,($s2)		#check if null pointer then exit if null
	beq 	$t0,$zero,cmpne
	j	cmploop
		

# not equal

cmpne:
    la      $a0,nemsg
    li      $v0,4
    syscall
    li $v0,10
    syscall
	
# if strings are equal
cmpeq:
    la      $a0,eqmsg
    li      $v0,4
    syscall
#print

	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1		#print fn
	la $a0, ($s4)
	move $a0,$s4
	syscall
	li $v0,10
syscall
