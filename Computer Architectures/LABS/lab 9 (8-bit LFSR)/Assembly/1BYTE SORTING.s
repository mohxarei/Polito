;in resetHandler:
			;IMPORT DESSORT
			;BL DESSORT

;____________________________________;for Ascendinga change to: BLS EXIT	;else if <= exit (complimentary)
;____________________________________;if data is signed use LDRSB / SUBS ... 
;------------------------------------
;chnage SPACE / COPY / FOR's numbers based on 'DATA elements'
;---------->R0 is where data readed from
;---------->R1 is where data sorted to (READWRITE)
;------------------------------------
;if DATA is DCD(4byte)
	;SPACE=numbers*4
	;'DCD -> LDR'
	;'DCD -> STR'
	;'DCD -> #4 / DCB -> #1'



				AREA	HISTORY,DATA,READONLY 
DATAS 			DCB 0x0A,0xEC,0xD5,0x0F,0x73,0x55		;DCB is 1byte	DCD is 4byte

				AREA CCC,DATA,READWRITE
MYSPACE			SPACE	6								;for DCD --> 'DATA elements' x 4
	
	
	
	
	
	
	
	
				AREA    XYZ, CODE, READONLY
					
DESSORT			PROC
				EXPORT DESSORT
				PUSH{R4-R11,LR}
				
				
				
				
;*********************************copyData to from RAEDONLY to R/W memory space

				LDR R0,=MYSPACE		;strating point if MYDATA space in mem to R0
				LDR R1,=DATAS

				MOV R4,#0			;making index
COPY				
				LDRB R2,[R1,R4]		;read form R1=DATA				;--------->'DCD -> LDR'
				STRB R2,[R0,R4]		;write to R0=MYSPACE			;--------->'DCD -> STR'
				ADD R4,#1
				CMP R4,#6 											;>>>>>>>>>number of SPACE (for DCD SPACE*4)
				BNE COPY
;************************************now MYSPACE contain data // but its R/W	
						
;int data[] = {1300,1700,1200,1900,1110,1670};				;R0=MYSPACE				
;    for(int i=0;i<6;i++){									;i= 'DATA elements'
;        for(int j=0;j<5;j++){								;j=i-1
;            if(data[j] < data[j+1]){						;for acending (data[j] > data[j+1])
;                int tmp = data[j];
;                data[j] = data[j+1];
;                data[j+1] = tmp;
;            }
;        }
;        
;    }			

;;

I				RN	2
J				RN	3
	
				LDR I, =0        	;i=0
FORI
				CMP I, #6											;>>>>>>>>> 'DATA elements'
				BHS ENDFORI      	;check BRANCH condition (complimentary)
				
				
				LDR J, =0        	;j=0
				MOV R5,#0			;making memory inde
FORJ
				CMP J, #5       	;								;>>>>>>>>> 'DATA-1 elements'
				BHS ENDFORJ       	
						
										
				LDRB R6, [R0,R5]	;FORM R0 TO R6 BY INDEX J(R3);data[j]=r6 		;--------->'DCD -> LDR'
				ADD R8, R5,#1		;J+1/R5+1										;--------> DCD = #4 / DCB = #1
				LDRB R7, [R0,R8]	;FORM R0 TO R7 BY INDEX J+1(R8);data[j+1]=r7 	;--------->'DCD -> LDR'
				
				CMP R6,R7	;if(data[j] < data[j+1]) remain
				BHS EXIT	;else if >= exit (complimentary) 		;for Ascending <= BLS
				MOV R9,R6	;tmp = data[j]
				STRB R7,[R0,R5]	;load data[j+1](R7) into MYSPACE(R0) by index R5		;--------->'DCD -> STR'
				STRB R9,[R0,R8]	;load tmp = data[j](R9) into MYSPACE(R0) by index R5+1	;--------->'DCD -> STR'
EXIT						
				ADD R5,#1															;--------> DCD = #4 / DCB = #1
				ADD J, #1    ; J++
				B FORJ
ENDFORJ
						
						
				ADD I, #1    ; i++
				B FORI
ENDFORI
				
				
				

				POP{R4,R11,PC}
				ENDP
			
				END