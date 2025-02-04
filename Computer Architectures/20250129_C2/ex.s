;				AREA DD, DATA, READONLY
;MAT_A 			DCB 0xF8, 0x7C, 0x3E, 0x1F, 0x8F, 0xC7, 0xE3, 0xF1

;				AREA DDD,DATA, READWRITE
;MAT_AT			SPACE 8


;1.	the address of the bit matrix A
;2.	the address of the bit matrix AT

;				LDR R0,=MAT_A
;				LDR R1,=MAT_AT


				AREA    |.text|, CODE, READONLY
					
					
transposition 	PROC
				EXPORT transposition 
				PUSH {R4-R8,LR}
				
				
I				RN	2
J				RN	3

				
				MOV I,#0
				MOV R7,#7
FORI								;for (i = 0; i < 8; i ++)
				CMP I, #8									
				BHS ENDFORI
				
				LDRB R4,[R0,I]		;x = i-th row of A

				LDR J, =0        	;j=0
FORJ								;for (j = 0; j < 8; j ++)
				CMP J, #8       	
				BHS ENDFORJ   ;<= LS
				
							;(note: bit 0 is the most significant bit, bit 7 is the least significant bit
				SUB R8,R7,J
				LSR R5,R4,R8		;b = j-th bit of x 
				AND	R5,#1
				
							;store b to the i-th bit of the j-th row of AT
				SUB R8,R7,I
				LSL R5,R8
				
				LDRB R6,[R1,J]
				ORR R6,R5
				
				STRB R6,[R1,J]


				ADD J, #1    ; J++
				B FORJ
ENDFORJ


				ADD I, #1    ; i++
				B FORI
ENDFORI


result			
				POP {R4-R8,PC}	
				ENDP
					END
						
						
;for (i = 0; i < 8; i ++)
;	x = i-th row of A
;	for (j = 0; j < 8; j ++)
;		b = j-th bit of x (note: bit 0 is the most significant bit, bit 7 is the least significant bit)
;		store b to the i-th bit of the j-th row of AT