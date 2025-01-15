                AREA	SPACEE, DATA, READWRITE

TMPSPACE		SPACE	8
				
				AREA    next, CODE, READONLY



next_state   	PROC
				PUSH{LR}
				EXPORT next_state

CURRENT			RN	0	;0b10101010
TABS			RN	1	;0b00011101 00 02 03 04
OUTBIT			RN	2	;0


;input_bit = (current_state ^ (current_state >> 2) ^ ) & 1;


				AND R3,CURRENT,#1
				STR R3,[OUTBIT]			;*output_bit = current_state & 1;
				
				LDR R3,=TMPSPACE

				;STR R1,[R5]
				;LDRB R4,[R2]
				
CNT				RN	4
CNT2			RN	5


;********************************storing TABS bits numbers in R3,=TMPSPACE********************
				MOV CNT2,#0			;CNT2: which bit of TABS is 1
				MOV CNT,#0
FOR				
				TST TABS,#1
				BEQ	TABTEST			;if TABS's LSB is 1 branch EQ is not taken (!)
					
				STRB CNT2,[R3,CNT]	;CNT is memory index
				ADD CNT,#1
TABTEST				
				LSR TABS,#1			;check next bit of TABS
				ADD CNT2,#1
				CMP CNT2,#8			;if CNT2 < 8 repeat the FOR (max size to check is 8Bit)
				BLO	FOR				
;*****************************************************************************
;input_bit = (current_state ^ (current_state >> 2) ^ (current_state >> 3) ^ (current_state >> 4)) & 1;
				
				MOV CNT2,#0
				MOV CNT,#0
				LDRB R5,[R3,CNT]			;TABS bits stored at R3,=TMPSPACE
				LSR R6,CURRENT, R5			;current_state>>0
				
REE				
				ADD CNT,#1					
				LDRB R7,[R3,CNT]			;load next value of TMPSPACE (represents 1st bits of TABS)
				LSR R8,CURRENT, R7			;(current_state >> 2)/(current_state >> 3)/(current_state >> 4)
				EOR R6,R8					;sooo tricky part! for XOR each step then go for next values
				
				CMP CNT,#3					;*****numbers of TABS's ones-1 ----> in case of changing TABS need to change
				BNE REE
				
				AND R6,#1					;input_bit = (()) & 1;
				
				LSR R7,CURRENT,#1			;new_state = (current_state >> 1) | (input_bit << 7);
				LSL R6,#7
				ORR	R0,R7,R6				;mention returinig register starts form R0 as well

				
				POP{PC}
				ENDP
					END