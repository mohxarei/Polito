/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_RIT.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    RIT.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "LPC17xx.h"
#include "RIT.h"
#include "../Main.h"
/******************************************************************************
** Function name:		RIT_IRQHandler
**
** Descriptions:		REPETITIVE INTERRUPT TIMER handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
							//GENERIC TEST CODES
							//={0xF8, 0x7C, 0x3E, 0x1F, 0x8F, 0xC7, 0xE3, 0xF1};
							//={0xa0, 0xb1, 0xc2, 0xd3, 0xe4, 0xf5, 0x06, 0x17};
char A[8];
char B[8];
char AT[8], BT[8], SUM[8], SUMT[8];

int indexa=0, indexb=0, result = 1;

extern void transposition(char *Tabel, char *Transposed); 

volatile int KEY0=0, KEY1=0, KEY2=0;

void RIT_IRQHandler (void){
	
	
	if (KEY0 >= 1) {  
    if ((LPC_GPIO2->FIOPIN & (1 << 10)) == 0) {
        switch (KEY0) {
            case 2:  // code section
                //LED_init(); //if using led_out on reading values (extra trick)
                transposition(A, AT);
                transposition(B, BT);
                
                for (int i = 0; i < 8; i++) SUM[i] = A[i] ^ B[i];
                transposition(SUM, SUMT);
                
                for (int i = 0; i < 8; i++) {
                    if (SUMT[i] != (AT[i] ^ BT[i])) {
                        result = 0;
                        break;
                    }
                }
                
                if (result == 1) LED_On(1);
                else LED_On(2);
                break;
            
            default:
                break;
        }
        KEY0++;
    } else {  // Button released
        KEY0 = 0;
        NVIC_EnableIRQ(EINT0_IRQn);  				// Enable Button interrupts
        LPC_PINCON->PINSEL4 |= (1 << 20);  	// External interrupt 0 pin selection
    }
	}
	
	if (KEY1 >= 1) {  // KEY1 Pressed
			if ((LPC_GPIO2->FIOPIN & (1 << 11)) == 0) {
					switch (KEY1) {
							case 2:  // code section
									if (indexa < 8) {
											A[indexa] = (char)read_timer(2);
											//LED_Out(A[indexa]);//if using led_out on reading values (extra trick)
											indexa++;
									}
									break;
							
							default:
									break;
					}
					KEY1++;
			} else {  // Button released
					KEY1 = 0;
					NVIC_EnableIRQ(EINT1_IRQn);  				// Enable Button interrupts
					LPC_PINCON->PINSEL4 |= (1 << 22);  	// External interrupt 1 pin selection
			}
	}
	
	if (KEY2 >= 1) {  // KEY2 Pressed
			if ((LPC_GPIO2->FIOPIN & (1 << 12)) == 0) {
					switch (KEY2) {
							case 2:  // code section
									if (indexb < 8) {
											B[indexb] = (char)read_timer(2);
											//LED_Out(B[indexb]);//if using led_out on reading values (extra trick)
											indexb++;
									}
									break;
							
							default:
									break;
					}
					KEY2++;
			} else {  // Button released
					KEY2 = 0;
					NVIC_EnableIRQ(EINT2_IRQn);  				// Enable Button interrupts
					LPC_PINCON->PINSEL4 |= (1 << 24);  	// External interrupt 2 pin selection
			}
	}
	
	reset_RIT();
	LPC_RIT->RICTRL |= 0x1;  // Clear interrupt flag
	
	return;

}

/******************************************************************************
**                            End Of File
******************************************************************************/
