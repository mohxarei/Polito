#include "../Main.h"
#include "LPC17xx.h"

//for deboubce need to uncomment timer3
//#define debounce_time 50
//extern uint32_t tick;		//increse each time in timer3
//uint32_t last_tick = 0;
//int state = 1;

const int NUM_ROWS = 10;
const int NUM_COLUMNS = 8;
unsigned char array[NUM_ROWS][NUM_COLUMNS];
char path[NUM_ROWS * NUM_COLUMNS];

//;				LDR R0,=NUM_ROW 8
//;				LDR R1,=NUM_COL 9
//;				LDR R2,=MAZE
//;				LDR R3,=PATH

//
char exploreMaze(char ROWS, char COLS, char *MAZE,char *PATH);
//extern void mazeSolver(int, int, int *, int *);


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

	for(int i=0;i<NUM_COLUMNS;i++)array[0][i]='X';							//TOP
	for(int i=0;i<NUM_ROWS;i++)array[i][NUM_COLUMNS-1]='X';			//right
	for(int i=0;i<NUM_ROWS;i++)array[i][0]='X';									//left
	for(int i=0;i<NUM_COLUMNS;i++)array[NUM_ROWS-1][i]='X';			//bottom
	array[1][1]=array[NUM_ROWS-2][NUM_COLUMNS-2]=' ';
	
	uint32_t value_old = read_timer(0);
	
	for(int i=1;i<NUM_ROWS-1;i++){															//since 1,1 is 'X'
		//if (i==1)i+1;
		for(int j=1;j<NUM_COLUMNS-1;j++){
			if(i==1 && j==1) j++;
			if((NUM_ROWS-2)==1 && (NUM_COLUMNS-2)==1 )break;
			uint32_t value_new = (value_old * 11 + 6) % 73;
			if(value_new<40)array[i][j]=' ';
			else array[i][j]='X';
			array[1][1]=array[NUM_ROWS-2][NUM_COLUMNS-2]=' ';
			value_old = value_new;
		}
	}
	
	
	char reter = exploreMaze(NUM_ROWS, NUM_COLUMNS, &array, &path);
	
	
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{

  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}
