;				LDR R0,=NUM_ROW
;				LDR R1,=NUM_COL
;				LDR R2,=FMAZE
;				LDR R3,=INIT_POS


				AREA    shortlife, CODE, READONLY


exploreMaze		PROC
                EXPORT exploreMaze
				PUSH{LR}
				
				ADD R11,#11
				LDRB R1,[R2,#11]	;R1 START
				STRB R1,[R3]
				
				LDRB R1,[R2,#12]
				STRB R1,[R3,#1]
				
				LDRB R1,[R2,#13]
				STRB R1,[R3,#2]
				
				LDRB R1,[R2,#13]	;R1 START
				STRB R1,[R3,#2]
				
				LDRB R1,[R2,#12]
				STRB R1,[R3,#1]
				
				LDRB R1,[R2,#13]
				STRB R1,[R3,#0]		
				
				
				
				
				
				LDRB R6,[R2,R11]
				SUB R11,#1
				LDRB R4,[R2,R11]
				SUB R11,#1
				LDRB R4,[R2,R11]
				SUB R11,#1
				LDRB R4,[R2,R11]
				
				
				
				
				
				POP{PC}
				ENDP
					END