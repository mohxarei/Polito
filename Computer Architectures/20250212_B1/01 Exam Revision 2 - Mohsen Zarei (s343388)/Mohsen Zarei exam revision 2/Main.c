/*********************************************************************************************************
**--------------Template Info---------------------------------------------------------------------------------
** Last modified Date:  2025-01-05
** Last Version:        V1.00
** Descriptions:        This template includes all the peripheral libraries covered in the Computer Architecture 
**											course, as well as instructions for SysTick and exception configuration.
** Author:    					Saman Alipour
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/
#include "Main.h"

// Button pins: P2.10(INT0), P2.11(INT1), P2.12(INT2)
// LED pins: P2.0, P2.1, P2.2, P2.3, P2.4, P2.5, P2.6, P2.7
// Joystick pins: P1.26(Down), P1.27(Left), P1.28(Right), P1.29(Up)
// ADC channel: 5

//static int x; //static means previus vule keeped, use in IRQs



// Simulator DARMP1.DLL		-pLPC1768
// Debugger  TARMP1.DLL		-pLPC1768
// LandTiger TARMP1.DLL		-pLPC1768 -dLandTiger

//&= 0xFFFF0000;	//&=~(0xFFFF<<0); set 0-15 to Z // |= 0xff makes 1
//LPC_PINCON->PINSEL4 &= 0xFFFF0000;	//&=~(0xFFFF<<0); set 0-15 PINSEL4 to Z (using them as GPIO)
//LPC_GPIO2->FIODIR   |= 0x000000FF;  //P2.0...P2.7 Output (LEDs on PORT2 defined as Output)

int main(){
	
		SystemInit();  //need to comment for ASMBELY testing

	//Button
		BUTTON_init();
	
	
	//Timer
		//init_timer_SRI(0,0xFF,0b000);			//stop reset interrupt
		//enable_timer(0);
		//uint32_t timer_value = read_timer(0); //only for MR0
	
	//LED
		//LED_init();
		//LED_On(0);
	  //LED_Off(0);
		//LED_Out(0);    //led clear
		//LED_Out(1);
		
	//Joystick
		//joystick_init();
		//if((LPC_GPIO1->FIOPIN & (1<<26)) == 0) //means key pressed
		
	//RIT			//intit + enable --> for key debouncing
//	init_RIT(0x004C4B40);									/* RIT Initialization 50 msec       	*/
//	enable_RIT();													/* RIT enabled				
		//disable_RIT();
		
	//ADC
		//ADC_init();
		//ADC_start_conversion();	//single mode(masure once)
	
	//DAC
		//DAC_write(500); //500 is just a number
	
	LPC_PINCON->PINSEL1 |= (1<<21);
	LPC_PINCON->PINSEL1 &= ~(1<<20);
	LPC_GPIO0->FIODIR |= (1<<26);
		
	//GLCD
		//LCD_Initialization();
		//LCD_Clear(Black);
		//PutChar(0,0,'a',White,Black);
		//GUI_Text(0,0,(uint8_t *)"Hello world!!",White,Black);
	
	while(1){
		
	}
	
}