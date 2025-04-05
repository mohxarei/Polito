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
// for debouncing need to change on button IRQ and here//
//RIT value and Enable in main/////

//volatile int INT0=0;
//volatile int KEY1=0; 
//volatile int KEY2=0;

void RIT_IRQHandler (void)
{					
	
//	
//	if(INT0>=1){ /* INT0 Pressed*/
//		if((LPC_GPIO2->FIOPIN & (1<<10)) == 0){	
//			switch(INT0){				
//					case 2:					
//		 
//					
//					//key 0 Code Here
//					
//					
//					default:
//						break;
//			}
//		INT0++;
//		}else {	/* button released */
//			INT0=0;
//			NVIC_EnableIRQ(EINT0_IRQn);							 /* disable Button interrupts			*/
//			LPC_PINCON->PINSEL4    |= (1 << 20);     /* External interrupt 0 pin selection */
//		}
//	}
//	
//	if(KEY1>=1){ // KEY1 pressed 
//		if((LPC_GPIO2->FIOPIN & (1<<11)) == 0){	
//			switch(KEY1){				
//				case 2:	
//			
//			
//				// key1 code here
//				
//				
//				
//				
//				default:
//					break;
//			}
//			KEY1++;
//		}
//		else {	// button released 
//			KEY1=0;			
//			NVIC_EnableIRQ(EINT1_IRQn);							 // enable Button interrupts			
//			LPC_PINCON->PINSEL4    |= (1 << 22);     // External interrupt 0 pin selection 
//		}
//	}
//	
//	if(KEY2>=1){ // KEY2 pressed 
//		if((LPC_GPIO2->FIOPIN & (1<<12)) == 0){	 
//			switch(KEY2){				
//				case 2:			
//				
//				
//				//key2 code here
//				
//				
//				
//				default:
//					break;
//			}
//			KEY2++;
//		}
//		else {	// button released 
//			KEY2=0;			
//			NVIC_EnableIRQ(EINT2_IRQn);							 //enable Button interrupts			
//			LPC_PINCON->PINSEL4    |= (1 << 24);     // External interrupt 0 pin selection 
//		}
//	}
//	
//	
//	
//	
//	reset_RIT();
  LPC_RIT->RICTRL |= 0x1;	/* clear interrupt flag */
	
  //return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
//for joystick
//		if((LPC_GPIO1->FIOPIN & (1<<26)) == 0){			//down
//		}
//		if((LPC_GPIO1->FIOPIN & (1<<27)) == 0){			//left
//		}
//		if((LPC_GPIO1->FIOPIN & (1<<28)) == 0){			//right
//		}
//		if((LPC_GPIO1->FIOPIN & (1<<29)) == 0){			//up
//		}