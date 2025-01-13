/*********************************************************************************************************
**in specific amount of time RIT interupts happen, and check what is Joystick position
**while chnaging PacMan_dir by corresponding direction (or acctully joystick pin which is pressed)
**DO while game is Resume
*********************************************************************************************************/
#include "LPC17xx.h"
#include "RIT.h"
//#include <stdbool.h>

typedef enum {
    UP,
    DOWN,
    LEFT,
    RIGHT,
    STOP
} Direction;
typedef enum {
    Pause,
    Resume,
		Victory,
		Over
} State;
extern State Status;
extern Direction PacMan_dir;
//extern void pause_game(void);
//extern void Resume_game(void);
void RIT_IRQHandler (void)
{				

		
	if(Status == Resume){
		if((LPC_GPIO1->FIOPIN & (1<<26)) == 0){			//down
			PacMan_dir = DOWN;
		}
		if((LPC_GPIO1->FIOPIN & (1<<27)) == 0){			//left
			PacMan_dir = LEFT;
		}
		if((LPC_GPIO1->FIOPIN & (1<<28)) == 0){			//right
			PacMan_dir = RIGHT;
		}
		if((LPC_GPIO1->FIOPIN & (1<<29)) == 0){			//up
			PacMan_dir = UP;
		}
	}
  LPC_RIT->RICTRL |= 0x1;	/* clear interrupt flag */
	
}

/******************************************************************************
**                            End Of File
******************************************************************************/
