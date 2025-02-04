#include "LPC17xx.h"
void DAC_write(uint16_t value){
	LPC_DAC->DACR = value<<6;
}

//for showing a sound on DAC
// in ADC handler(as chooser):
			//// Audio freq at top: 
//						const int freqs[8]={4240,3779,3367,3175,2834,2525,2249,2120};
			////disable_timer(0);
			//reset_timer(0);
			//init_timer_SRI(0,freqs[AD_current*7/0xFFF], 0b011); //enable timer0 and index chooser ofr values
			//enable_timer(0);

////then in timer 0 intrupt:
//top:
// uint16_t SinTable[45] =                                       
// {
//     410, 467, 523, 576, 627, 673, 714, 749, 778,
//     799, 813, 819, 817, 807, 789, 764, 732, 694, 
//     650, 602, 550, 495, 438, 381, 324, 270, 217,
//     169, 125, 87 , 55 , 30 , 12 , 2  , 0  , 6  ,   
//     20 , 41 , 70 , 105, 146, 193, 243, 297, 353
// };


/// static int ticks=0;
//DAC_write(SinTable[ticks]);
//ticks++;
//if(ticks==45) ticks=0;