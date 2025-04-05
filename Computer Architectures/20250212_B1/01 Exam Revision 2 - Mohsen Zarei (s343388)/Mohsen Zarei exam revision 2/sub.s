  
;				LDR R0,=25	;Y
;				LDR R1,=4	;N


;*********only for test****************
;				AREA TEST, DATA, READWRITE
;SPA				SPACE  8
;*********only for test****************

				AREA    exam, CODE, READONLY


Maclaurin_cos   PROC
				PUSH{R4-R10,LR}
                EXPORT  Maclaurin_cos  
				
				
I				RN 	3
ITR				RN	6

				;LDR R4,=SPA		;TEST
				MOV R9,#0
				
				LDR I,=100
				MOV R10,I
				LDR ITR,=1		;number of iteration
				
FOR					

				MOV R5,#0
				SUBS R5,I     	;making negative number -t(i-1)
				
				MUL R2,R0,R0	  	;R2=y^2
				MUL R5,R2		;R5 = -t(i-1)· y^2
				;STR R5,[R4]
				
				MOV R7,#2
				MUL R7,ITR	;2i
				SUBS R8,R7,#1
				MUL R8,R7
				
				MOV R7,#100
				MUL R8,R7		;R8 = (2i-1)·(2i)· 100
				;STR R8,[R4]
				
				
				SDIV I,R5,R8
				
				ADD R9,I
				
;				STR I,[R4],#4	;for test


	
				ADD ITR,#1
				CMP ITR,R1
				BLS FOR
				
				ADD R0,R9,R10
				
				POP{R4-R10,PC}
				ENDP
					END