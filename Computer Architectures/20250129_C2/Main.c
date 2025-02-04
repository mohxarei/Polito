#include "Main.h"

// Button pins: P2.10(INT0), P2.11(INT1), P2.12(INT2)
// LED pins: P2.0, P2.1, P2.2, P2.3, P2.4, P2.5, P2.6, P2.7
// Joystick pins: P1.26(Down), P1.27(Left), P1.28(Right), P1.29(Up)
// ADC channel: 5

// Simulator DARMP1.DLL		-pLPC1768
// Debugger  TARMP1.DLL		-pLPC1768
// LandTiger TARMP1.DLL		-pLPC1768 -dLandTiger

int main(){
	SystemInit();		//!!!!!!!!!!!!need to be commented for testing on ASEMBLY!!!!!!!!
	LPC_SC->PCONP |= (1 << 22);						//Power Control Timer 2 Enabel
	
		init_timer_SRI(2,0xFFFF,0b010);			//stop reset interrupt
		enable_timer(2);
		BUTTON_init();
		LED_init();
		init_RIT(0x004C4B40);								//generating 50ms for debouncing keys on RIT (this time is long for simulator test)
		enable_RIT();	

	
	while(1){
		
	}
	
}