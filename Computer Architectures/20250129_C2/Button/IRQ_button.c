#include "../Main.h"
#include "LPC17xx.h"


extern  int KEY0;
extern  int KEY1; 
extern  int KEY2;
void EINT0_IRQHandler (void)	  	/* KEY0														 */
{	
	//LED_deinit(); //if using led_out on reading values (extra trick)
  NVIC_DisableIRQ(EINT0_IRQn);		/* disable Button interrupts			 */
  LPC_PINCON->PINSEL4    &= ~(1 << 20); /* GPIO pin selection */
	KEY0=1;
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */

}


void EINT1_IRQHandler (void)	  	/* KEY1														 */
{
	NVIC_DisableIRQ(EINT1_IRQn);		/* disable Button interrupts			 */
	LPC_PINCON->PINSEL4    &= ~(1 << 22);     /* GPIO pin selection */
	KEY1=1;
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  	/* KEY2														 */
{
	NVIC_DisableIRQ(EINT2_IRQn);		/* disable Button interrupts			 */
	LPC_PINCON->PINSEL4    &= ~(1 << 24);     /* GPIO pin selection */  //da fixare
	KEY2=1;
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}
