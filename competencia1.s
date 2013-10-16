		.data
cadena:	.asciiz "adbdcdddadbdcd"
car:	.asciiz "d"
cant:	.double 0

		.code
		dadd r1, r0, r0
		dadd r4, r0, r0
		lbu r2, car(r0)
loop:	lbu r3, cadena(r1)
		daddi r1, r1, 1
		beq r3, r0, fin
		bne r3, r2, noigual
		daddi r4, r4, 1
noigual: j loop
fin:	sd r4, cant(r0)
		halt
