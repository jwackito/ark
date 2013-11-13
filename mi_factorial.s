	.data
valor:   .word 1000
result:  .word 0
	
.text

	daddi  $sp, $0, 0x400
	ld     $a0, valor($0)
	jal    factorial
	sd     $v0, result($0)
	halt


factorial:
	slti   $v0, $a0, 2
	daddi  $sp, $sp, -16
	bnez   $v0, terminar
	sd	   $ra, 0($sp)
	sd	   $s0, 8($sp)
	dadd   $s0, $a0, $0
	daddi  $a0, $a0, -1
	jal    factorial
	dmul   $v0, $s0, $v0
	ld	   $s0, 8($sp)
    ld	   $ra, 0($sp)
terminar: 	daddi  $sp, $sp, 16

    jr $ra