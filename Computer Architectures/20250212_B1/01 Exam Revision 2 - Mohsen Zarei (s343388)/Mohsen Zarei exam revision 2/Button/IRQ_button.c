#include "../Main.h"
#include "LPC17xx.h"


//for deboubce need to uncomment here and in RIT
//extern  int INT0;
//extern  int KEY1; 
//extern  int KEY2;

void EINT0_IRQHandler (void)	  
{

	
	
//  NVIC_DisableIRQ(EINT0_IRQn);
//  LPC_PINCON->PINSEL4    &= ~(1 << 20);//ATTIVA PULSANTE
//	INT0=1; // --> Aggiorno a 1 il valore della variabile globale
//	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */

}

void EINT1_IRQHandler (void)	  
{

	init_timer_SRI(1,1592,0b011);			//stop reset interrupt
	enable_timer(1);
	
	
//	NVIC_DisableIRQ(EINT1_IRQn);		/* disable Button interrupts			 */
//	LPC_PINCON->PINSEL4    &= ~(1 << 22);     /* GPIO pin selection */
//	KEY1=1;
		LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{

//	NVIC_DisableIRQ(EINT2_IRQn);		/* disable Button interrupts			 */
//	LPC_PINCON->PINSEL4    &= ~(1 << 24);     /* GPIO pin selection */  //da fixare
//	KEY2=1;
//  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}



