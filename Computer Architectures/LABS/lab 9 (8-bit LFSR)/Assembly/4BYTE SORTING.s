;in resetHandler:
			;IMPORT DESORT
			;BL DESORT



;------------------------------------
;chnage SPACE / COPY / FOR's numbers based on 'numbers of data'

;------------------------------------
;if DATA is DCD(4byte)
	;SPACE=numbers*4
	;LDRB to LDR
	;STRB to STR
	;check DCD #4 / DCB #1


				AREA	HISTORY,DATA,READONLY 
DATAS 			DCD 0x0A,0xEC,0xD5,0x0F,0x73,0x55		;DCB is 1byte	DCD is 4byte

				AREA CCC,DATA,READWRITE
MYSPACE			SPACE	24								;DCB or DCD	
	
	
	
	
	
	
	
	
	
	
	
				AREA    XYZ, CODE, READONLY
					
DESORT			PROC
				EXPORT DESORT
				PUSH{R4-R11,LR}
				
				;*********************************copyData to from RAEDONLY to R/W memory space R0,=MYSPACE	

				LDR R0,=MYSPACE		;strating point if MYDATA space in mem to R0
				LDR R1,=DATAS

				MOV R4,#0			;making index
COPY				
				LDR R2,[R1,R4]		;read form R1=DATA								;LDRB R2,[R1,R4]
												
				STR R2,[R0,R4]		;write to R0=MYSPACE							;STRB R2,[R0,R4]
				ADD R4,#4															;----> DCD = #4 / DCB = #1
				CMP R4,#24 															;---->number of SPACE
				BNE COPY
;************************************now MYSPACE contain data // but its R/W	
						
;int data[] = {1300,1700,1200,1900,1110,1670,1000};			;R0=MYSPACE				
;    for(int i=0;i<6;i++){									;i= number of elements
;        for(int j=0;j<5;j++){								;j=i-1
;            if(data[j] < data[j+1]){
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
				CMP I, #6			;Compare I with #5 								------> DATA elements
				BHS ENDFORI      	;Exit FORI if i >= 5		
				
				
				LDR J, =0        	;j=0
				MOV R5,#0			;making memory index (DCD/DCB?)
FORJ
				CMP J, #5       	;Compare J with #4								------> DATA-1 elements
				BHS ENDFORJ       	;Exit loop if J >= 4        
						
										
				LDR R6, [R0,R5]		;FORM R0 TO R6 BY INDEX J(R3)	;data[j]=r6		;LDRB R6, [R0,R5]
				ADD R8, R5,#4		;j+1											;------> DCD = #4 / DCB = #1
				LDR R7, [R0,R8]	;FORM R0 TO R7 BY INDEX J+1(R8)	;data[j+1]=r7		;LDRB R7, [R0,R8]
				
				CMP R6,R7				;if(data[j] < data[j+1]) remain
				BLS EXIT				;else if >= exit
				MOV R9,R6				;tmp = data[j]
				STR R7,[R0,R5]			;load data[j+1](R7) into MYSPACE(R0) by index R5		;STRB R7,[R0,R5]
				STR R9,[R0,R8]			;load tmp = data[j](R9) into MYSPACE(R0) by index R5    ;STRB R9,[R0,R8]
EXIT						
				ADD R5,#4				;add mem index ++ for DCD					;------> DCD = #4 / DCB = #1
				ADD J, #1    ; J++
				B FORJ
ENDFORJ
						
						
				ADD I, #1    ; i++
				B FORI
ENDFORI
				
				
				
				
				
				POP{R4,R11,PC}
				ENDP
			
				END