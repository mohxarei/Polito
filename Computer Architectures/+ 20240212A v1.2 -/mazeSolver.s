;********************************************************
;
;
;			alghough this code looks great :) but there is no exit condition for it
;			so I revised it but i'll keep it, if you want to use make a name for this subroutine!
;






				;LDR R0,=maze
				;LDR R1,=NUM_ROW
				;MOV R2,#NUM_COL


				AREA    mazesolver, CODE, READONLY

mazeSolver1   	PROC
                EXPORT  mazeSolver1    
 				PUSH{LR}
				
NUM_ROW			RN	1	
NUM_COL			RN	2	

				
				MOV R10,R0						;making a copy of =maze on R10
				MOV R0,#0						
				
				MUL R4,NUM_ROW,NUM_COL			;81/length of tabel
				MOV R3,#0						;counter

FOR				
				LDRB R5, [R10, R3]         	    ; checking each cell is ' ' or not(check again till finding space)
                CMP R5,' '
				BNE EEND
				
;cheking if TOP is little word				
				SUB R3,NUM_COL					;go to top	
				LDRB R5,[R10,R3]
				ADD R3,NUM_COL					;bring pointer back
				MOV R6,'N'						;since STR works with R
				CMP R5,'n'	
				STRBEQ R6,[R10,R3]
				CMP R5,'e'
				STRBEQ R6,[R10,R3]
				CMP R5,'s'
				STRBEQ R6,[R10,R3]
				CMP R5,'w'
				STRBEQ R6,[R10,R3]

;cheking if RIGHT is little word	
				ADD R3,#1
				LDRB R5,[R10,R3]
				SUB R3,#1
				MOV R6,'E'
				CMP R5,'n'
				STRBEQ R6,[R10,R3]
				CMP R5,'e'
				STRBEQ R6,[R10,R3]
				CMP R5,'s'
				STRBEQ R6,[R10,R3]
				CMP R5,'w'
				STRBEQ R6,[R10,R3]
				
;;cheking if BOTTOM is little word					
				ADD R3,NUM_COL
				LDRB R5,[R10,R3]
				SUB R3,NUM_COL
				MOV R6,'S'
				CMP R5,'n'				
				STRBEQ R6,[R10,R3]
				CMP R5,'e'
				STRBEQ R6,[R10,R3]
				CMP R5,'s'
				STRBEQ R6,[R10,R3]
				CMP R5,'w'
				STRBEQ R6,[R10,R3]

;cheking if LEFT is little word	
				SUB R3,#1
				LDRB R5,[R10,R3]
				ADD R3,#1
				MOV R6,'W'
				CMP R5,'n'
				STRBEQ R6,[R10,R3]
				CMP R5,'e'
				STRBEQ R6,[R10,R3]
				CMP R5,'s'
				STRBEQ R6,[R10,R3]
				CMP R5,'w'
				STRBEQ R6,[R10,R3]
				
EEND			
				ADD R3,#1						;aftre any replacement increse pointer++
				CMP R3,R4						;81/if not checking all cells continue
				BNE FOR
				
				
				
SMALLETTER			
				LDRB R5,[R10,R3]				;pointer is 81, come back and replace CAPITAL with SMALL
				CMP R5,'S'
				MOVEQ R5,'s'
				CMP R5,'N'
				MOVEQ R5,'n'
				CMP R5,'E'
				MOVEQ R5,'e'
				CMP R5,'W'
				MOVEQ R5,'w'
				STRB R5,[R10,R3]

				SUB R3,#1
				CMP R3,#0
				BNE SMALLETTER


				ADD R0,#1			;?????????????????????? flag after each change 1 and then check
				B FOR
				
FINISH								;?????????????????
				
				POP{PC}
				ENDP
					END