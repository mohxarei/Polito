				AREA	sore,DATA,READWRITE

DIGIT			SPACE 4		;4digit number, each is 1 byte
				
				
				AREA	xxx,CODE,READONLY
KRoutine		PROC
				EXPORT KRoutine 
				PUSH{R4-R11, LR}
				
				;R0,=3075
				LDR R1,=DIGIT
				
;*****************************fatching each digit
TEN				RN	2
TMP				RN	3
TMP2			RN	4
CNT				RN	5
TMP3			RN	6

				MOV TEN,#10
				MOV CNT,#0	;memory counter
				MOV R6,R0	;douplicate of IN
				
DO				CMP CNT,#4	;length of IN
				BEQ	EXITD
				UDIV TMP,R6,TEN	;X=IN/10
				MOV TMP2,TMP	;SAVE RESULT X
				MUL	TMP,TEN		;X*10
				SUB TMP,R6,TMP	;IN-
				STRB TMP,[R1,CNT]
				
				ADD CNT,#1
				MOV R6,TMP2
				B	DO
EXITD
;*********************now R1 contain digits, lets sort DISENDING and put there (R1) again :)))))			
				;LDR R1,=DIGIT
				
I				RN	2
J				RN	3
	
				LDR I, =0        	;i=0
FORI
				CMP I, #4											;>>>>>>>>> 'DATA elements'
				BHS ENDFORI      	;check BRANCH condition (complimentary)
				
				
				LDR J, =0        	;j=0
				MOV R5,#0			;making memory index
FORJ
				CMP J, #3       	;								;>>>>>>>>> 'DATA-1 elements'
				BHS ENDFORJ       	
						
										
				LDRB R6, [R1,R5]	;FORM R0 TO R6 BY INDEX J(R3);data[j]=r6 		;--------->'DCD -> LDR'
				ADD R8, R5,#1		;J+1/R5+1										;--------> DCD = #4 / DCB = #1
				LDRB R7, [R1,R8]	;FORM R0 TO R7 BY INDEX J+1(R8);data[j+1]=r7 	;--------->'DCD -> LDR'
				
				CMP R6,R7	;if(data[j] < data[j+1]) remain
				BHS EXIT	;else if >= exit (complimentary) 		;for Ascending <= BLS
				MOV R9,R6	;tmp = data[j]
				STRB R7,[R1,R5]	;load data[j+1](R7) into MYSPACE(R0) by index R5		;--------->'DCD -> STR'
				STRB R9,[R1,R8]	;load tmp = data[j](R9) into MYSPACE(R0) by index R5+1	;--------->'DCD -> STR'
EXIT						
				ADD R5,#1															;--------> DCD = #4 / DCB = #1
				ADD J, #1    ; J++
				B FORJ
ENDFORJ
						
						
				ADD I, #1    ; i++
				B FORI
ENDFORI
;******************************************************end of sorting



				MOV R7,#10		;this reg is somewhere had changes
;-	first iteration: b = 7
;-	second iteration: b = 7 * 10 + 5 = 75
;-	third iteration: b = 75 * 10 + 3 = 753
;-	fourth iteration: b = 753 * 10 + 0 = 7530

;R2=7530
				LDRB R2,[R1]
				LDRB R3,[R1,#1]
				LDRB R4,[R1,#2]
				LDRB R5,[R1,#3]
				MUL	R2,R7	
				ADD R2,R3
				MUL R2,R7
				ADD R2,R4
				MUL R2,R7
				ADD R2,R5
				
;;;;;;;				MOV R2, #0           ; Result accumulator initialized to 0
;;;;;;;				MOV R3, #0           ; Loop counter (starting from the most significant byte)
;;;;;;;loopp
;;;;;;;				LDRB R5, [R1, R3]   ; Load byte from memory
;;;;;;;				MUL R2, R7      ; Multiply accumulator by 10
;;;;;;;				ADD R2, R5      ; Add the next byte
;;;;;;;				ADD R3, #1     ; Decrement loop counter
;;;;;;;				CMP R3, #3
;;;;;;;				BLS loopp            ; Repeat until all bytes are processed	/ <=			
				
				
				
				
				
;R6=0357
				LDRB R6,[R1,#3]
				LDRB R5,[R1,#2]
				LDRB R4,[R1,#1]
				LDRB R3,[R1]
				MUL	R6,R7	
				ADD R6,R5
				MUL R6,R7
				ADD R6,R4
				MUL R6,R7
				ADD R6,R3


;R0=7530-0357
				SUB R0,R2,R6
				

				
				
				POP{R4-R11, PC}
				ENDP
					
				END

;i know it's not too much efficient. but works :)
