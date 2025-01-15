#include "../Main.h"
#include "LPC17xx.h"
#include "../LED/led.h"


unsigned char	current_state = 0b10101010;
unsigned char	taps = 0b00011101;
int output_bit;
int j=0;

unsigned char next_state(unsigned char current_state, unsigned char taps, int *output_bit);
	
	//current_state / taps -------> form C to ASM
	//next_state	----------> form ASM to C
	//int *output_bit --> is stored in an integer variable passed by-reference called output_bit. 

void EINT0_IRQHandler (void)	  
{

  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{

//	char new_state = next_state(current_state, taps, &output_bit);
//	LPC_GPIO2->FIOCLR  = 0x000000FF;  //all LEDs off;
//	LPC_GPIO2->FIOSET |= new_state;
//	current_state = new_state;
	//equivalent:
	
	current_state = next_state(current_state, taps, &output_bit);	//sine *output_bit, need to call by &output_bit --> point to an address of mem
	
	LPC_GPIO2->FIOCLR  = 0x000000FF;  //all LEDs off;
	LPC_GPIO2->FIOSET |= current_state;
	
	
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{

char initial_state = current_state;  // Save the initial state for comparison
char new_state;


do {
		new_state = next_state(current_state, taps, &output_bit);  // Generate the next state
    LPC_GPIO2->FIOCLR = 0x000000FF;  // Turn off all LEDs
    LPC_GPIO2->FIOSET |= new_state;  // Set LEDs based on new_state
    current_state = new_state;       // Update current_state for the next iteration
		for(int i=0;i<5000;i++);				 //delay
		j+=1;														 //counter to see number of repitation till reach to initial state again
} while (initial_state != new_state);  // Loop until the new state equals the initial state

///////////////////////////////equivalent:
//while (1) {
//    new_state = next_state(current_state, taps, &output_bit);  // Generate the next state
//    LPC_GPIO2->FIOCLR = 0x000000FF;  // Turn off all LEDs
//    LPC_GPIO2->FIOSET |= new_state;  // Set LEDs based on new_state
//    current_state = new_state;       // Update current_state for the next iteration
//    for(int i = 0; i < 5000; i++);   // Simple delay loop
//    j += 1;  												 // Increment counter for each iteration
//    if (initial_state == new_state) break;  // Exit the loop when initial_state matches new_state
//    }

LPC_GPIO2->FIOCLR = 0x000000FF;			//LEDs off
for(int i=0;i<5000;i++);						//simple delay
LED_Out(j);													//show equivalent length on LEDs

	
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


