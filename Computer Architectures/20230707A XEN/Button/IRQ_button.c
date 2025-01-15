#include "../Main.h"
#include "LPC17xx.h"

//for deboubce need to uncomment timer3
//#define debounce_time 50
//extern uint32_t tick;		//increse each time in timer3
//uint32_t last_tick = 0;
//int state = 1;

//const int max_value = 20;					//making a positive constant MAX_VALUES=20
#define max_value 5
char array[max_value];						//uninitialized array of char with the size of MAX_VALUES
int index = 0;										//creating an index
int state = 1;										//blinking LEDs

void insertionSort(int *address, int num);	//function needs to be declered and EXPORTED in ASM
																						//prototype for ASSM function, first element(R0), second (R1)...
								  													//*address points to an address in mem(array) (stored somewhere in mem)
																						//passing parameter by refrence(*mem)// or Regs 
																						//attention to follow AAPCS standard for passing parameters between C and Assembly
																						

void EINT0_IRQHandler (void)	  
{
//	if(tick<debounce_time && state==1){
//		test++;
//		state=0;
//		last_tick = tick;
//		LPC_SC->EXTINT &= (1 << 0); /* clear pending interrupt         */
//		return;
//	}
//	if ((tick - last_tick) < debounce_time) {	
//        LPC_SC->EXTINT &= (1 << 0); /* clear pending interrupt         */
//        return;
//	}
//	last_tick = tick;
//	state=1;
//  write code from here with or without debouncing
	if(index<max_value){															//can't write fot(;;)/while(;) since it will be run always with only one key press
		array[index] = (char)read_timer(1);							//TC value is 32bit using (char) to fit it in char array[]
		//char currentValue = (char)LPC_TIM1 -> TC;
		//array[index]=currentValue;										//putting currentValue on array by incrementing [index]
		index++;	
		if(state == 1){														//switch leds eachtime
			LED_On(6);															//led6
			LED_Off(7);															//led7
			state=0;														
		}else{														
			LED_On(7);															//led7
			LED_Off(6);															//led6
			state=1;
		}
	}
	
	
	
	
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{

	LED_Off(6); 											//led 6
	LED_Off(7);												//led 7
	insertionSort(array, max_value); 	//link to assembly: R0 = array, R1=MAX_VALUES(length)
																		//need to write "&" before variables pint to memory,(for array no need use "&")
	LED_On(11);												//led 11 on//numbers are diffrent
	
	
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{

  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


