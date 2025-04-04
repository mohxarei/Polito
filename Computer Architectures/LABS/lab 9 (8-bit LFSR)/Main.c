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

// Button pins: P2.10(INT0), P2.11(INT1/key1), P2.12(INT2/key2)
// LED pins: P2.0(LED11), P2.1(LED1), P2.2, P2.3, P2.4, P2.5, P2.6, P2.7
// Joystick pins: P1.26(Down), P1.27(Left), P1.28(Right), P1.29(Up)
// ADC channel: 5
// Audio freq: const int freqs[8]={4240,3779,3367,3175,2834,2525,2249,2120};
// uint16_t SinTable[45] =                                       
// {
//     410, 467, 523, 576, 627, 673, 714, 749, 778,
//     799, 813, 819, 817, 807, 789, 764, 732, 694, 
//     650, 602, 550, 495, 438, 381, 324, 270, 217,
//     169, 125, 87 , 55 , 30 , 12 , 2  , 0  , 6  ,   
//     20 , 41 , 70 , 105, 146, 193, 243, 297, 353
// };
// Simulator DARMP1.DLL		-pLPC1768 -dLandTiger
// Debugger  TARMP1.DLL		-pLPC1768

	extern unsigned char	current_state;
//	extern unsigned char	taps;
//	extern int output_bit;
//	extern unsigned char new_state;


//extern unsigned char next_state(unsigned char current_state, unsigned char taps, int *output_bit);


int main(){
	SystemInit();




	
	//Timer
		//init_timer_SRI(0,0xFF,0b000);			//stop reset interrupt
		//enable_timer(0);
		//uint32_t timer_value = read_timer(0);
	
	//Button
		BUTTON_init();
	
	//LED
		LED_init();
		
		LPC_GPIO2->FIOSET |= current_state;
	

		//LED_On(1);
		//LED_On(3);
		//LED_On(7);
		//LED_Off(0);
		//LED_Out(255);
	
	//Joystick
		//joystick_init();
		
	//RIT
		//init_RIT(0xFFF);
		//enable_RIT();
		
	//ADC
		//ADC_init();
		//ADC_start_conversion();
	
	//DAC
		//DAC_write(500);
		
	//GLCD
		//LCD_Initialization();
		//LCD_Clear(Black);
		//PutChar(0,0,'a',White,Black);
		//GUI_Text(0,0,(uint8_t *)"Hello world!!",White,Black);
		

	
	while(1){
		
	}
	
}