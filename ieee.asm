	ORG 1000H
ZERO	DW	0
	DW	0

INF	DW	7F80H
	DW	0000H

NAN	DW	7F80H
	DW	0AAAAH

DENORM	DW	007AH
	DW	1010H

NORM	DW	1234H
	DW	0ABCDH

RESULT0	DB	?
RESULT1	DB	?
RESULT2	DB	?
RESULT3	DB	?
RESULT4 DB	?


	ORG 3000H
IEEE:	MOV AX, [BX]
	MOV DX, 7F80H
	AND AX, DX
	JNZ ENZ		
	MOV AX, [BX]		;si el exponente es cer0
	MOV DX, 007fH
	AND AX, DX
	JZ MHZ
	MOV CL, 0		;y la mantisa es diferente de cero
	JMP FIN			;es un numero sin normalizar
MHZ:	PUSH BX
	ADD BX, 2
	MOV AX, [BX]		;comparo si el resto de la mantiza es cero
	POP BX
	XOR DX, DX
	AND AX, DX
	JZ MLZ
	MOV CL, 0               ;exp cero, man diferente de cero
        JMP FIN                 ;es un numero sin normalizar
MLZ:	MOV CL, 3		;sino, es +/- cero		
	JMP FIN
ENZ:	MOV AX, [BX]		;el exp no es cero
        MOV DX, 7F80H
	AND AX, DX
	CMP AX, 7F80H
	JNZ ENO			;si no es cero es un numero normalizado				
	MOV DX, 007fH		;si el exponenete es todos unos
        MOV AX, [BX]
	AND AX, DX
	JZ MHZ1
	MOV CL, 2 		;y la mantiza es diferente de cero 
	JMP FIN			;es un NAN
MHZ1:	PUSH BX
	ADD BX, 2
	MOV AX, [BX]		;comparo si el resto de la mantiza es cero
	POP BX
	XOR DX, DX		
	CMP AX, DX 
	JNZ MLZ1			
	MOV CL, 2		;exp todos uno, man diferente de cero
	JMP FIN			;es un NAN
MLZ1:	MOV CL, 1		;sino, es +/- INF
	JMP FIN
ENO:	MOV CL, 4		;sino, es un numero normalizado
FIN:	RET		

	ORG 2000H
	MOV BX, OFFSET ZERO
	CALL IEEE
	MOV RESULT0, CL
	MOV BX, OFFSET INF
	CALL IEEE
	MOV RESULT1, CL
	MOV BX, OFFSET NAN
	CALL IEEE
	MOV RESULT2, CL
	MOV BX, OFFSET DENORM
	CALL IEEE
	MOV RESULT3, CL
	MOV BX, OFFSET NORM
	CALL IEEE
	MOV RESULT4, CL
	HLT
END


