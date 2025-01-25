
;				LDR R0,=NUM_ROW
;				MOV R1,#NUM_COL
;				LDR R2,=maze


				AREA    mazesolver, CODE, READONLY

mazeSolver   	PROC
                EXPORT  mazeSolver   
 				PUSH{LR}
				
NUM_ROW			RN	0	
NUM_COL			RN	1	

				
				MOV R10,R2						;making a copy of =maze on R10
				
				MUL R4,NUM_ROW,NUM_COL			;81/length of tabel
				
				MOV R0,#0						;since need R0 for returning value (number of iterations)
				MOV R3,#0						;counter

FOR				
				LDRB R5, [R10, R3]         	    ; checking each cell is ' ' or not(check again till finding free space)
                CMP R5,' '
				BNE	ADDD
				
				
				BL	TOP       					; Check top neighbor
                BL	RIGHT       				; Check right neighbor
                BL	BOTTOM      				; Check bottom neighbor
                BL	LEFT  		    			; Check left neighbor		
				
				
ADDD			ADD R3,#1						;aftre any replacement increse pointer++
				CMP R3,R4						;81/if not checking all cells continue (repeat)
				BLO FOR
				
;after cheking and replacing whole table onece, scan and replace Capital Letters with Small ones
SMALLETTER			
				LDRB R5,[R10,R3]				;pointer is 81, come back to 0 and replace CAPITAL with SMALL
				CMP R5,'S'						;if the word is capital
				MOVEQ R5,'s'					;move small one instead
				CMP R5,'N'
				MOVEQ R5,'n'
				CMP R5,'E'
				MOVEQ R5,'e'
				CMP R5,'W'
				MOVEQ R5,'w'
				STRB R5,[R10,R3]

				SUB R3,#1						;decrese pointer
				CMP R3,#0						;till first cell
				BNE SMALLETTER					;repeat
				
				CMP R7,#0						;EXIT condition(there is no storing happened)
				BEQ FINISH
				
				ADD R0,#1						;each time all replacements done, add one to iterations (R0)
				
				MOV R7,#0						;bring EXIT pointer back to Zero each time updating table
				B FOR
				
				
;cheking neighbors and storing -- also each time storing sth making EXIT flag (R7) #1
;cheking if TOP is little word
TOP				SUB R3,NUM_COL					;go to top	
				LDRB R5,[R10,R3]
				ADD R3,NUM_COL					;bring pointer back
				MOV R6,'N'						;since STR works with R
				CMP R5,'a'						;all small letters are more than 'a'
				BLO ET							;so if letter is LessThan 'a' means its not small letter--come back where you left :')
				STRB R6,[R10,R3]				;if its bigger then 'a' means its a small letter so store 'N'
				MOV R7,#1						;change EXIT flag, everytime store
ET				BX LR							;majical command, come back where you came!(it works with BL name)

;cheking if RIGHT is little word	
RIGHT			ADD R3,#1
				LDRB R5,[R10,R3]
				SUB R3,#1
				MOV R6,'E'
				CMP R5,'a'						;all small letters are more than 'a'
				BLO ER
				STRB R6,[R10,R3]
				MOV R7,#1						;change sth everytime store
ER				BX LR							;back where you left

;cheking if BOTTOM is little word					
BOTTOM			ADD R3,NUM_COL
				LDRB R5,[R10,R3]
				SUB R3,NUM_COL
				MOV R6,'S'
				CMP R5,'a'						;all small letters are more than 'a'
				BLO EB
				STRB R6,[R10,R3]
				MOV R7,#1						;change sth everytime store
EB				BX LR

;cheking if LEFT is little word	
LEFT			SUB R3,#1
				LDRB R5,[R10,R3]
				ADD R3,#1
				MOV R6,'W'
				CMP R5,'a'						;all small letters are more than 'a'
				BLO EL
				STRB R6,[R10,R3]
				MOV R7,#1						;change sth everytime store
EL				BX LR
;program never meets here, since BX LR bring back PC where it called
				
				
FINISH											;EXIT
				
				POP{PC}
				ENDP
					END