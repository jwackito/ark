		ORG 1000H
NUM1	DB	?
NUM2	DB	?
RES		DB	?
		DB	?
		
		ORG 1500H
ERR		DB	"Error. Ingrese un numero valido."
ERR_FIN	DB	?

		ORG 3000H
SUBR:	MOV AL, [BX]
		CMP AL, 30H
		JS LEO
		CMP AL, 3AH
		JNS LEO
		MOV CL, 0
		JMP FINSUB
LEO:	MOV CL, 1
		MOV AL, OFFSET ERR_FIN - OFFSET ERR
		MOV DX, BX
		MOV BX, OFFSET ERR
		INT 7
		MOV BX, DX
FINSUB:	RET

		ORG 2000H
		MOV BX, OFFSET NUM1
ING1:	INT 6
		CALL SUBR
		CMP CL, 1
		JZ ING1
		MOV BX, OFFSET NUM2
ING2:	INT 6
		CALL SUBR
		CMP CL, 1
		JZ ING2
		MOV CL, NUM1
		MOV CH, NUM2
		ADD CH, CL
		SUB CH, 60H
		MOV CL, CH
		SUB CL, 10
		JS SALTO
		ADD CL, 30H
		MOV RES, CL
		MOV RES+1, 31H
		MOV AL, 2
		JMP FIN
SALTO:	ADD CH, 30H
		MOV RES, CH
		MOV AL, 1
FIN:	MOV BX, OFFSET RES
		INT 7
		HLT
		END
		