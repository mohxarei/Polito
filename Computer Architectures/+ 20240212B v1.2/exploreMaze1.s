;				LDR R0,=NUM_ROW 8
;				LDR R1,=NUM_COL 9
;				LDR R2,=MAZE
;				LDR R3,=PATH


ROW				RN	0
COL				RN	1
MAZE_ADDRESS	RN	2		;location memory
PATH_ADDRESS	RN	3
CURRENT			RN	4
TMP1			RN	5
PNT1			RN	6
CNT				RN	7

				AREA    shortlife, CODE, READONLY


exploreMaze		PROC
                EXPORT exploreMaze
				PUSH{LR}
				
				LDR CURRENT,=0	
				ADD CURRENT,COL,#1					;find starting point position
				LDR CNT,=0
				
STEP1			LDR TMP1,='V'
				STRB TMP1,[MAZE_ADDRESS,CURRENT]
				
STEP2			ADD PNT1,CURRENT,#1					;cell at right
				LDRB TMP1,[MAZE_ADDRESS,PNT1]
				CMP TMP1,#'X'
				BEQ STEP3			;jump
				CMP TMP1,#'V'
				BEQ STEP3
				STRB CURRENT,[PATH_ADDRESS,CNT] 	;if not, save address on PATH
				ADD CNT,#1							;update PATH mem index
				MOV CURRENT,PNT1					;current cell = cell at the right
				B STEP7
				
STEP3			SUB PNT1,CURRENT,#1					;cell at left
				LDRB TMP1,[MAZE_ADDRESS,PNT1]
				CMP TMP1,#'X'
				BEQ STEP4
				CMP TMP1,#'V'
				BEQ STEP4
				STRB CURRENT,[PATH_ADDRESS,CNT]
				ADD CNT,#1
				MOV CURRENT,PNT1
				B STEP7
				
STEP4			SUB PNT1,CURRENT,COL				;top
				LDRB TMP1,[MAZE_ADDRESS,PNT1]
				CMP TMP1,#'X'
				BEQ STEP5
				CMP TMP1,#'V'
				BEQ STEP5
				STRB CURRENT,[PATH_ADDRESS,CNT]
				ADD CNT,#1
				MOV CURRENT,PNT1
				B STEP7
				
STEP5			ADD PNT1,CURRENT,COL				;bottom
				LDRB TMP1,[MAZE_ADDRESS,PNT1]
				CMP TMP1,#'X'
				BEQ STEP6
				CMP TMP1,#'V'
				BEQ STEP6
				STRB CURRENT,[PATH_ADDRESS,CNT]
				ADD CNT,#1
				MOV CURRENT,PNT1
				B STEP7
				
STEP6							;if the path array contains one or more elements:
								;-	current cell = last element of the path array
								;-	remove the last element of the path array (e.g., you can overwrite it with 0)

				CMP CNT,#0
				BEQ ELS								
				SUB CNT,#1						
				LDRB TMP1,[PATH_ADDRESS,CNT]
				MOV CURRENT,TMP1				;current cell = last element of the path array
				LDR TMP1,=0						;remove the last element of the path array (e.g., you can overwrite it with 0)
				STRB TMP1,[PATH_ADDRESS,CNT]	;STR stores in one ahead mem
				;SUB CNT,#1
				B STEP7
ELS
				LDR R0,=0						;b.	else:	return 0
				B EXIT

STEP7	
				MUL TMP1,COL,ROW
				SUB TMP1,#1						;ending point
				SUB TMP1,COL	
				SUB TMP1,#1						;last position
				CMP CURRENT,TMP1
				BNE STEP1
				
				;MOV CURRENT,TMP1
				STRB TMP1,[PATH_ADDRESS,CNT]	;update last position
				LDR R0,=1						;return 1
				
EXIT			POP{PC}
				ENDP
					END