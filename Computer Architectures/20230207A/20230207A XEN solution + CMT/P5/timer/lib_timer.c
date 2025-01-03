/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           lib_timer.h
** Descriptions:        atomic functions to be used by higher sw levels
** Correlated files:    lib_timer.c, funct_timer.c, IRQ_timer.c
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"

/******************************************************************************
** Function name:		enable_timer
**
** Descriptions:		Enable timer
**
** parameters:			timer number: 0 or 1
** Returned value:		None
**
******************************************************************************/
void enable_timer( uint8_t timer_num )
{
  if ( timer_num == 0 )
  {
	LPC_TIM0->TCR = 1;			//enable timer0
  }
  else
  {
	LPC_TIM1->TCR = 1;
  }
  return;
}

/******************************************************************************
** Function name:		disable_timer
**
** Descriptions:		Disable timer
**
** parameters:			timer number: 0 or 1
** Returned value:		None
**
******************************************************************************/
void disable_timer( uint8_t timer_num )
{
  if ( timer_num == 0 )
  {
	LPC_TIM0->TCR = 0;
  }
  else
  {
	LPC_TIM1->TCR = 0;
  }
  return;
}

/******************************************************************************
** Function name:		reset_timer
**
** Descriptions:		Reset timer
**
** parameters:			timer number: 0 or 1
** Returned value:		None
**
******************************************************************************/
void reset_timer( uint8_t timer_num )
{
  uint32_t regVal;

  if ( timer_num == 0 )
  {
	regVal = LPC_TIM0->TCR;
	regVal |= 0x02;
	LPC_TIM0->TCR = regVal;
  }
  else
  {
	regVal = LPC_TIM1->TCR;
	regVal |= 0x02;
	LPC_TIM1->TCR = regVal;
  }
  return;
}
/******************************************************************************
** Function name:		init_timer
**
** Descriptions:		initialize timer
**
** parameters:			timer number: 0 or 1
** Returned value:		None
**
******************************************************************************/
uint32_t init_timer ( uint8_t timer_num, uint32_t TimerInterval ) //T0-3, and time we want count
{																																	//unit32 --> means univeral unsigned 32bit intiger
  if ( timer_num == 0 )
  {
	LPC_TIM0->MR0 = TimerInterval;			
	LPC_TIM0->MCR = 2;									/* Interrupt and Reset on MR1 */

	//NVIC_EnableIRQ(TIMER0_IRQn);			//DISABLE INT TIMER 0
	return (1);
  }
	
	
	
  else if ( timer_num == 1 )
  {
	LPC_TIM1->MR0 = TimerInterval;		 	//count from 0 till MR0
	LPC_TIM1->MCR = 3;									//MR1 of TIMER0 config --> no INT/ reset TC when TC=MR0/no STOP counting after match

	//NVIC_EnableIRQ(TIMER1_IRQn);			//DISABLE INT TIMER 1
	return (1);
  }
	
	
	else if ( timer_num == 2 )
  {
	LPC_TIM0->MR0 = TimerInterval;			
	LPC_TIM0->MCR = 2;									/* Interrupt and Reset on MR1 */

	//NVIC_EnableIRQ(TIMER0_IRQn);			//DISABLE INT TIMER 0
	return (1);
  }
	
	
		else if ( timer_num == 2 )
  {
	LPC_TIM0->MR0 = TimerInterval;			
	LPC_TIM0->MCR = 2;									/* Interrupt and Reset on MR1 */

	//NVIC_EnableIRQ(TIMER0_IRQn);			//DISABLE INT TIMER 0
	return (1);
  }
	
	
  return (0);
}

/******************************************************************************
**                            End Of File
******************************************************************************/
