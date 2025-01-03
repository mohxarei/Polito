#include "button.h"
#include "LPC17xx.h"
#include "../led/led.h"						//since using led here need to call

const int max_value = 20;					//making a positive constant MAX_VALUES=20
char array[max_value];						//uninitialized array of char with the size of MAX_VALUES
int index = 0;										//creating an index
int state = 1;										//blinking LEDs
void insertionSort(int *address, int num);	//prototype for ASSM function, first element(R0), second (R1)...
								  													//*address for passing array (stored somewhere in mem)
																						//passing parameter by refrence(*mem)// or Regs 
																						//attention to follow AAPCS standard for passing parameters between C and Assembly
void EINT0_IRQHandler (void)	  
{
	if(index<20){															//can't write fot(;;)/while(;) since it will be run always with only one key press
		char currentValue = (char)LPC_TIM1 -> TC;	//TC value is 32bit using (char) to fit it in "char currentValue"
		array[index]=currentValue;								//putting currentValue on array by incrementing [index]
		index++;	
		if(state == 1){														//switch leds eachtime
			LED_on(5);															//led6
			LED_off(4);															//led7
			state=0;														
		}else{														
			LED_on(4);															//led7
			LED_off(5);															//led6
			state=1;
		}
	}
	
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	
	LED_off(5); 											//led 6
	LED_off(4);												//led 7
	insertionSort(array, max_value); 	//link to assembly: R0 = array, R1=MAX_VALUES(length)
																		//when in fonctaion constant pinter to memory, need to write "&"(for array no need use "&")
	LED_on(0);												//led 11 on//numbers are diffrent
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
}

//void EINT2_IRQHandler (void)	  
//{
//	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
//}

