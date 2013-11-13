	.data
val1: .word 50
val2: .word 8
res:  .word 0
	
	.text
	ld    $a0, val1($0)
	ld    $a1, val2($0)
	jal   a_la_potencia
	sd    $v0, res($0)
	halt

a_la_potencia:
	daddi $v0, $0, 1
lazo:	slti   $t1, $a1, 1
	bnez  $t1, terminar
	daddi $a1, $a1, -1
	dmul  $v0, $v0, $a0
	j     lazo
terminar:
	jr $ra
