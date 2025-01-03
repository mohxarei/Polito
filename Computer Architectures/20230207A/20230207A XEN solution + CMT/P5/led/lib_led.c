/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           lib_led.c
** Descriptions:        Atomic led init functions    
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/
#include "LPC17xx.h"
#include "led.h"

/*----------------------------------------------------------------------------
  Function that initializes LEDs
 *----------------------------------------------------------------------------*/

void LED_init(void)
{
	LPC_PINCON->PINSEL4 &= 0xFFFF0000;	// &= ~(0xFFFF<<0); set 0-15 PINSEL4 to Z (using them as GPIO)
	LPC_GPIO2->FIODIR |= 0x000000FF;	// P2.0-P2.7 on PORT2 defined as Output
}

void LED_deinit(void)
{
	LPC_GPIO2->FIODIR &= 0xFFFFFF00;
}

void LED_on(int num) 
{
  LPC_GPIO2 -> FIOSET |= 1<<num;						//making num LED on
}

void LED_off(int num) 
{
  LPC_GPIO2 -> FIOCLR |= 1<<num;						//making num LED off
}


