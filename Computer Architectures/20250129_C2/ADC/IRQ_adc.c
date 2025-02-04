/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_adc.c
** Last modified Date:  20184-12-30
** Last Version:        V1.00
** Descriptions:        functions to manage A/D interrupts
** Correlated files:    adc.h
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

#include "LPC17xx.h"
#include "../Main.h"

/*----------------------------------------------------------------------------
  A/D IRQ: Executed when A/D Conversion is ready (signal from ADC peripheral)
 *----------------------------------------------------------------------------*/

unsigned short AD_current;   

void ADC_IRQHandler(void) {
  	
  AD_current = ((LPC_ADC->ADGDR>>4) & 0xFFF);/* Read Conversion Result  0-4095           */
	
	
	
	
	
	/* for reading ADC value on showing it on LEDs and DAC * RIT and ADC and DAC need starts. writing: ADC_start_conversion(); on RIT */
//	disable_RIT();																//stop repeteation
//	reset_RIT();																	//no value contain it
//  AD_current = ((LPC_ADC->ADGDR>>4) & 0xFFF);		/* Read Conversion Result  0-4095 */
//	int value = (AD_current*256)/4096;						//ADC has 12bit resulution while LEDs are 8
//	LED_Out(value);																//put value of ADC on LEDs
//	int value1 = (AD_current*1024)/4096;					//DAC has 10bit resulution
//	DAC_write(value1);														//put ADC value on DAC port
//	enable_RIT();																	//resume story
	
}
