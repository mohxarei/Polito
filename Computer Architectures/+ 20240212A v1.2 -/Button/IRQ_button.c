#include "../Main.h"
#include "LPC17xx.h"

//for deboubce need to uncomment timer3
//#define debounce_time 50
//extern uint32_t tick;		//increse each time in timer3
//uint32_t last_tick = 0;
//int state = 1;


#define NUM_ROWS 10 	//
//const int NUM_ROWS = 10;
#define NUM_COLUMNS 8
//const int NUM_COLUMNS = 8;

//unsigned char MAZE[NUM_ROWS*NUM_COLUMNS];

unsigned char MAZE[NUM_ROWS][NUM_COLUMNS];		//;[10][8]
//;				LDR R0,=NUM_ROW
//;				MOV R1,#NUM_COL
//;				LDR R2,=maze
extern char mazeSolver(char row, char col, char *maze);

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
	
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{

	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{

//		MAZE[0]='*';
//		MAZE[NUM_COLUMNS-1]='*';
//		MAZE[(NUM_COLUMNS*NUM_ROWS)-1]='*';
//		MAZE[NUM_COLUMNS*(NUM_ROWS-1)]='*';
	
		MAZE[0][0]='*';
		MAZE[0][NUM_COLUMNS-1]='*';
		MAZE[NUM_ROWS-1][0]='*';
		MAZE[NUM_ROWS-1][NUM_COLUMNS-1]='*';
		
		uint32_t value_old = read_timer(0);				//need to use uint32_t since value may be too big
																							//(char)read_timer(0); for char integer
	
	//upper border
		for(int i=1;i<NUM_COLUMNS-1;i++){			//*------* since using (<)
			uint32_t value_new = (value_old * 18) % 101;
			if(value_new<90)MAZE[0][i]='*';
			else MAZE[0][i]='n';
			value_old = value_new;	
		}
		
	//right border
		for(int i=1;i<NUM_ROWS-1;i++){
			uint32_t value_new = (value_old * 18) % 101;
			if(value_new<90)MAZE[i][NUM_COLUMNS-1]='*';
			else MAZE[i][NUM_COLUMNS-1]='e';
			value_old = value_new;	
		}
		
	//lower border,
		for(int i=1;i<NUM_COLUMNS-1;i++){
			uint32_t value_new = (value_old * 18) % 101;
			if(value_new<90)MAZE[NUM_ROWS-1][i]='*';
			else MAZE[NUM_ROWS-1][i]='s';
			value_old = value_new;	
		}		
		
	//left border
		for(int i=1;i<NUM_ROWS-1;i++){
			uint32_t value_new = (value_old * 18) % 101;
			if(value_new<90)MAZE[i][0]='*';
			else MAZE[i][0]='w';
			value_old = value_new;	
		}
		
	//other cells
		for(int i=1;i<NUM_ROWS-1;i++){
			for(int j=1;j<NUM_COLUMNS-1;j++){
			uint32_t value_new = (value_old * 18) % 101;
			if(value_new<60)MAZE[i][j]=' ';
			else MAZE[i][j]='*';
			value_old = value_new;	
			}
		}
		
char iterations = mazeSolver(NUM_ROWS, NUM_COLUMNS, &MAZE);
		
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


