;**************************************Incrementing Sort*********************************
;											algorithm:
;A is the array to sort):
;;	i<-1									;LDR i, =1
;	while i < length(A)						;while (i<7(R3)) do:
;	        x <- A[i]						;LDR X,A[i]
;	        j <- i - 1						;SUB j,i,#1
;	        while j >= 0 and A[j] > x		;if two conditions are true, while:
;	                A[j+1] <-  A[j]			;storing A[j] into A[j+1]
;	                j <- j - 1				;SUB j,#1
;	        end while
;	        A[j+1] <- x						;storing X into A[j+1]
;	        i <- i + 1					;ADD i,#1
;	end while
;*/

;since getting data from C  need to use standard parametters
				AREA P4,CODE,READONLY


insertionSort 	PROC				;secound subroutine 
				EXPORT insertionSort	;for calling on reset_handler
					

				PUSH{R4-R7,LR}
;attention to follow AAPCS standard for passing parameters between C and Assembly
;R0=array (since its array no need "&"!)/ R1=max_value ---> from C

A				RN	0 					;array to sort (R1=outputData) //R0 form C prog
LENGTHA			RN	1 					;R3 length=7
I				RN	2 					;can't be negative so(unsigned)
X				RN	3 					
J				RN	4 					;can be negative (signed)
TEMP			RN	5 					;LDRSB TEMP,[A,J]
J1				RN	6 					;ADD TEMP2,J,#1
										;since data contain SIGNED values, used all branches SIGNED

				LDR I,=1
WHILE			
				CMP I,LENGTHA
				BGE ENDWHILE 			;if I>=LENGTHA go to ENDWHILE otherwise continue
				LDRSB	X,[A,I] 		;load data from A by index I into X; since datas are signed bytes LDRSB
				SUB J,I,#1				;J=I-1
WHILE2									;one of the both (J>=0 and A[J]>x) not true, quite the loop #opp of AND is OR
				CMP J,#0
				BLT ENDWHILE2 			;or if J<0(signed) go ENDWHILE2 otherwise continue
				LDRSB TEMP,[A,J]		;TEMP = A[J]
				CMP TEMP,X 			
				BLE ENDWHILE2 			;or if A[J]<=X(signed) go to ENDWHILE2 otherwise continue
				ADD J1,J,#1				;making J+1
				STRB TEMP,[A,J1]			;store TEMP(A[J]) into A[J+1]
				SUB J,#1				;J--
				B WHILE2				;if ~(J<0 | A[J]<=x) stay in WHILE2 // (J>=0 & A[J]>X) repeat WHILE2
ENDWHILE2
				ADD J1,J,#1 			;if previous while not running we don't have it. so need to creat J1 here again
				STRB X,[A,J1]			;store X on A with index J1(j+1)
				ADD I,#1				;I++
				B WHILE
ENDWHILE		
				POP{R4-R7,PC}
				ENDP
					
				END