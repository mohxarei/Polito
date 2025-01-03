#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"
const int max_value = 5;
char array[max_value];
int index=0;
int state = 1;
void insertionSort(int *address, int num);
void EINT0_IRQHandler (void)	  
{
	if (index<20){
		char current_value = (char)LPC_TIM1 -> TC;
		array[index] = current_value;
		index++;
		if (state == 1){
			LED_on(5);
			LED_off(6);
			state =0;
		}else{
			LED_on(6);
			LED_off(5);
			state =1;			
		}
	}
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	LED_off(5);
	LED_off(6);
	insertionSort(array, max_value);
	LED_on(0);
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
}


