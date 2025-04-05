/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "LPC17xx.h"
#include "../Main.h"

int cosineValues[45] = {0};
extern int Maclaurin_cos(int input1,int input2);


void TIMER0_IRQHandler (void)
{
  LPC_TIM0->IR |= 1;			/* clear interrupt flag */
  return;
}


void TIMER1_IRQHandler (void)
{
	static int repeat = 0;
	static int ticks = 0;
	int input, output;

	if (repeat < 200)
		{
//		input = (1.428 * ticks);	// see Note 1 below
//	
//			if(input>=0){
//			input+=0.5;
//			}
//			else if(input<0){
//			input-=0.5;
//			}
		float tmp = (1.428 * ticks);

		if (tmp >= 0) {
    tmp += 0.5;
		} else {
    tmp -= 0.5;
		}

		input = (int)tmp;	//casting a float value to an integer
		
			output = 500 + Maclaurin_cos(input, 3) / 2;	
			cosineValues[ticks + 22] = output;		// see Note 2 below
			DAC_write(output);
			ticks ++;
			if (ticks > 22)
			{
			ticks = -22;
			repeat += 1;
			}
		
	else DAC_write(0);
	}

	
	
  LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

void TIMER2_IRQHandler (void)
{
  LPC_TIM2->IR = 1;			/* clear interrupt flag */
  return;
}

void TIMER3_IRQHandler (void)
{
  LPC_TIM3->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
