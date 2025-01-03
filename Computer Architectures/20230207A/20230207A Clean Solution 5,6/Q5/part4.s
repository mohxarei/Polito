A				RN	0
LENGTH			RN	1
I				RN	2
X				RN	3
J				RN	4
TEMP			RN	5
TEMP2			RN	6

				AREA PART4,CODE,READONLY
insertionSort 	PROC
				EXPORT insertionSort
				PUSH{R4-R6,LR}
				LDR I,=1
WHILE			
				CMP I,LENGTH
				BHS ENDWHILE
				LDRSB	X,[A,I]
				SUB J,I,#1
WHILE2
				CMP J,#0
				BLT ENDWHILE2
				LDRSB TEMP,[A,J]
				CMP TEMP,X
				BLE ENDWHILE2
				ADD TEMP2,J,#1
				STRB TEMP,[A,TEMP2]
				SUB J,#1
				B WHILE2
ENDWHILE2
				ADD TEMP2,J,#1
				STRB X,[A,TEMP2]
				ADD I,#1
				B WHILE
ENDWHILE		
				POP{R4-R6,PC}
				ENDP


copyData 		PROC
				EXPORT copyData
				PUSH{R4-R6,LR}
				MOV R4,R2
				LDR R5,=0
FOR	
				LDRB R6,[R0,R5]
				STRB R6,[R1,R5]
				ADD R5,#1
				SUB R4,#1
				CMP R4,#0
				BNE FOR
				POP{R4-R6,PC}
				ENDP
				END