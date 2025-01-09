				;LDR R0,=3075
				;b = 7530 and c = 0357.
				;d = 7530 – 357 = 7173.

IN				RN	0
TEN				RN	1
TMP				RN	2
CNT				RN	3	;FOR counter
TMP2			RN	4
D_BASE			RN	5	;DIGIT base(loading address of DIGIT there)
PNT				RN	6	;memory pointer (offset)
CNT2			RN	7	;FOR2 counter
TMP3			RN	8
				AREA	sore,DATA,READWRITE

DIGIT			SPACE 4		;4digit number, each is 1 byte
				
				
				AREA	xxx,CODE,READONLY
KaprekarRoutine	PROC
				EXPORT KaprekarRoutine 
				PUSH{R4-R11, LR}

				MOV TEN,#10				;move 10 to R1
				LDR D_BASE,=DIGIT 		;load address base to R5(D_BASE)
				LDR PNT,=0				;make memory offset=0
					
				MOV CNT,#4				;R3=4 (making FOR's index)
FOR						
				UDIV TMP,IN,TEN			;gives 3075/10=307 each time devid by 10, get result
				MUL TMP2,TMP,TEN		;307*10
				SUB TMP2, IN,TMP2		;3075-307
				STRB TMP2,[D_BASE,PNT]	;store on DIGIT mem by opointer PNT, each digit is 1byte
				MOV IN,TMP				;new input = devided one
				ADD PNT,#1				;increase PNT memory Pointer
				
				SUB CNT,#1				;R3 -1/ FOR counter
				CMP CNT,#0				;
				BNE FOR					;if R4!=0 go to FOR if R3=0 left the loop
				
;******************************************* descending SORT*****************************************
				LDR PNT,=0				;make memory offset=0
				
;				LDR R3,=4				;FOR1 counter
;FOR1									;for(int i=0;i<4;i++)
				LDR R7,=3				;FOR2 counter
FOR2									;for(int i=0;i<4;i++) / inner loop
				
				LDRB TMP,[D_BASE,PNT]	;data[j]	/load to TMP by index PNT
				
				ADD TMP2, PNT,#1		;PNT+1
				LDRB TMP2,[D_BASE,TMP2]	;data[j+1] /load to TMP2 by index PNT

				CMP TMP,TMP2			;if(data[j] < data[j+1])
				ITTT	LO
				STRBLO TMP2,[D_BASE,PNT]	;store J+1 to Js location(first place)/data[j] = data[j+1];
				ADDLO TMP2, PNT,#1
				STRBLO TMP,[D_BASE,TMP2]	;data[j+1] = tmp;
;;				equal to:
;;				BHS	EXIT
;;				STRB TMP2,[D_BASE,PNT]
;;				ADD TMP2, PNT,#1
;;				STRB TMP,[D_BASE,TMP2]
;;EXIT
				ADD PNT,#1

				SUB R7,#1				;CNT2 -1/ FOR counter
				CMP R7,#0				;
				BNE FOR2					;if CNT2!=0 go to FOR2 if CNT2=0 left the loop

;				SUB R3,#1				;CNT -1/ FOR1 counter
;				CMP R3,#0				;
;				BNE FOR1					;if CNT!=0 go to FOR1 if CNT=0 left the loop
;*****************************end sorting******************************

;***************************creating one single value(desending) out of seperate digits in memory (7530)***************************************				
				LDR PNT,=0			;memory pointer R6=0
				LDR	CNT,=3			;FOR3 counter	R3=3 (since did first load out of LOOP)			
				LDRB TMP,[D_BASE,PNT]	;first digit 7 in R2
				ADD PNT,#1
FOR3
				LDRB TMP2,[D_BASE,PNT]	;secound digit in R4
				MUL	TMP,TEN				;first digit * 10
				ADD TMP,TMP2
				ADD PNT,#1				;increase memory pointer


				SUB CNT,#1
				CMP CNT,#0
				BNE	FOR3

;***************************creating one single value(acending) out of seperate digits in memory (0357)***************************************				
				LDR PNT,=3			;memory pointer R6=0------------> now pointer starts from end (3th byte of mem)
				LDR	CNT,=3			;FOR3 counter	R3=3 (since did first load out of LOOP)			
				LDRB TMP3,[D_BASE,PNT]	;last digit 0 in R2
				SUB PNT,#1
FOR4
				LDRB TMP2,[D_BASE,PNT]	;secound digit in R8
				MUL	TMP3,TEN				;first digit * 10
				ADD TMP3,TMP2
				SUB PNT,#1				;decrese memory pointer

				SUB CNT,#1
				CMP CNT,#0
				BNE	FOR4
;***********************************TMP=7530 /// TMP3=0357*******************************
;returning value by R0
				SUB R0,TMP,TMP3
								;when coming back from subroutine every register becomes clear, EXEPT R0-R3


				POP{R4-R11, PC}
				ENDP
				END
					
					
;*******************descending sort algorithm
;#include <stdio.h>
;int main()
;{
;    int data[] = {1300,1700,1200,1900,1110,1670,1000};				//DIGIT
;    for(int i=0;i<7;i++){
;        for(int j=0;j<7;j++){
;            if(data[j] < data[j+1]){
;                int tmp = data[j];
;                data[j] = data[j+1];
;                data[j+1] = tmp;
;            }
;        }
;        
;    }
;    return 0;
;}
					
					
					