#include "LPC17xx.h"
#include "led/led.h"
#include "joystick/joystick.h"
#include "RIT/RIT.h"
#include "GLCD/GLCD.h" 
#include <stdio.h>
#include "Timer/timer.h"
#include <stdlib.h>
#include <time.h>
#include "Button/button.h"
#ifdef SIMULATOR
extern uint8_t ScaleFlag; // <- ScaleFlag needs to visible in order for the emulator to find the symbol (can be placed also inside system_LPC17xx.h but since it is RO, it needs more work)
#endif
typedef enum {
    UP,
    DOWN,
    LEFT,
    RIGHT,
    STOP														//when meet the walls
} Direction;												//by Direction can use some conditions 
Direction PacMan_dir = STOP;				//PacMan_dir can be diffrent types of Direction


typedef enum {
    Pause,
    Resume,
		Victory,
		Over
	} State;													//by State: Status = Resume/Pause/Victory/Over
State Status = Pause; 							//game starts from Pasue



extern void print_CountDown(void); 	//in timer IRQ
void placePowerPills(void);
void init_drawing(void);
void print_remaining_lives(void);
void print_Score(void);
uint32_t random(uint32_t max);
void update_display(int position,uint8_t ch);
void PacMan_move(Direction Dir);
void pause_game(void);
	
	
char Remaining_lives = 1;
int  Score = 0;
int tmp_score = 0;
char POWER_PILLS = 6;				//at the begining we have 6 Pills
int PacMan_pos = 0;					//where is PacMan on the map?

	
#define ROWS 17								//17*16(font height)= 272 //320-272=48/16= 3 only lines can ba avalible on LCD after drawing the map
#define COLS 30								//30*8(font width)=240
#define new_life 1000					//every 1000 score getting a new life 
#define Victory_point 1000		//2640  240-6=234*10(each pill score)=2340+(6*50 powerPill=300)=2640 maxScore

//       # ########################## # 2 // 28
//       #.............$$.............#
//       #.#########..$$$$..#########.#
//       #.##.....##.$$$$$$.##.....##.#
//       #.##.###.##.$$$$$$.##.###.##.#
//       #.##.###.##..$$$$..##.###.##.#
//       #.##.###.##...$$...##.###.##.#
//       #............................#
//       #.#########.##--##.#########.#
//        ...........#    #........... 
//       #.#########.######.#########.#
//       #............................#
//       #######.##.##.##.##.##.#######
//       #######.##.##.##.##.##.#######
//       #######.##.##.##.##.##.#######
//       #######................#######
//       ##############################

uint8_t pacmanMap[ROWS * COLS] = {				//presenting  map on single dimention array - each character is 1byte=1 memory cell
'#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#', 
'#','.','.','.','.','.','.','.','.','.','.','.','.','.','$','$','.','.','.','.','.','.','.','.','.','.','.','.','.','#',
'#','.','#','#','#','#','#','#','#','#','#','.','.','$','$','$','$','.','.','#','#','#','#','#','#','#','#','#','.','#',
'#','.','#','#','.','.','.','.','.','#','#','.','$','$',' ',' ','$','$','.','#','#','.','.','.','.','.','#','#','.','#',
'#','.','#','#','.','#','#','#','.','#','#','.','$','$',' ',' ','$','$','.','#','#','.','#','#','#','.','#','#','.','#',
'#','.','#','#','.','#','#','#','.','#','#','.','.','$','$','$','$','.','.','#','#','.','#','#','#','.','#','#','.','#',
'#','.','#','#','.','#','#','#','.','#','#','.','.','.','$','$','.','.','.','#','#','.','#','#','#','.','#','#','.','#',
'#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',
'#','.','#','#','#','#','#','#','#','#','#','.','#','#','-','-','#','#','.','#','#','#','#','#','#','#','#','#','.','#', //270
' ','.','.','.','.','.','.','.','.','.','.','.','#',' ',' ',' ',' ','#','.','.','.','.','.','.','.','.','.','.','.',' ', //299
'#','.','#','#','#','#','.','#','#','#','#','.','#','#','#','#','#','#','.','#','#','#','#','.','#','#','#','#','.','#',
'#','.','.','.','.','.','.','.','.','.','.','.','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',
'#','#','#','#','#','#','#','.','#','#','.','#','#','.','#','#','.','#','#','.','#','#','.','#','#','#','#','#','#','#',
'#','#','#','#','#','#','#','.','#','#','.','#','#','.','#','#','.','#','#','.','#','#','.','#','#','#','#','#','#','#',
'#','#','#','#','#','#','#','.','#','#','.','#','#','.','#','#','.','#','#','.','#','#','.','#','#','#','#','#','#','#',
'#','#','#','#','#','#','#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#','#','#','#','#','#','#',
'#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',

};



int main(){
	SystemInit();
	BUTTON_init();
	for(int i=0;i<ROWS * COLS;i++){											//finding PacMan position	
		if(pacmanMap[i] == '@'){PacMan_pos = i;break;}			
	}

	joystick_init(); 											//like key initiate
	
	init_RIT(0x5FFFF);//0x004C4B40				//in each specific time goes into interupt
	init_timer(0,0xFFFFF);//0x17D7840			//enable Interupt/stop //in physical environment need to change based on Micro Clock
  
	LCD_Initialization();
	init_drawing(); 											//drowing map
	enable_timer(0);
	enable_RIT();
	pause_game();													//since game starts from pause, write it on screen
	
	
  while (1)	
  {
		if(Status == Resume)PacMan_move(PacMan_dir);

		if(Score >= Victory_point){								//if all pills eaten Victory :))
					Status = Victory;
					//LCD_Clear(Black);
					GUI_Text(80, 152,   (uint8_t *)"Victory!!!", Green, White);
					disable_RIT();
					disable_timer(0);
					}
		
  }
}

//xy
//font size is 8*16
//240*320 LCD size
//max character can be shown on LCD
//240/8 = 30 X
//320/16 = 20 Y
void init_drawing(void){
	LCD_Clear(Black);
  GUI_Text(0, 0,   (uint8_t *)"Time", White, Black);  //write Time on (0,0) position; white with background black
	print_CountDown();
	GUI_Text(144, 0, (uint8_t *)"Score", White, Black);
	print_Score();
	for(int i=0;i<ROWS;i++){
		for(int j=0;j<COLS;j++){
			uint8_t character = pacmanMap[i*30+j]; //scan all characters of array and place them on LCD
			if(character == '.')PutChar(j*8,32+(i*16),character,White,Black);		//each character with specific color
			if(character == '#')PutChar(j*8,32+(i*16),character,Cyan,Black);		//start draw map from 3ed line(0.32)
			if(character == '-')PutChar(j*8,32+(i*16),character,White,Black);
			if(character == ' ')PutChar(j*8,32+(i*16),character,White,Black);
			if(character == '@')PutChar(j*8,32+(i*16),character,Yellow,Black);			
			if(character == '$')PutChar(j*8,32+(i*16),character,Green,Black);
			
		}
	}
	print_remaining_lives(); 										//starts with 1 as beginning
	placePowerPills();	
}
//
//
void print_Score(void){
	char buffer[5];
	sprintf(buffer, "%04d", Score);					//Score is a number, need to change to character to display
	GUI_Text(144, 16, (uint8_t *)buffer, White, Black);		
}
//
void print_remaining_lives(void){
	for(int i=0;i<Remaining_lives;i++)PutChar(i*8,304,'@',Yellow,Black);	//starts with 1, each time called in new position add anotehr
}
//
void placePowerPills(void) {								//place powerPills randomy and place them on the map 
	  for(int i=0;i<ROWS * COLS;i++){
			if(pacmanMap[i] == '*'){pacmanMap[i] = '.';update_display(i,'.');}
		}
    int pillsPlaced = 0;

    while (pillsPlaced < POWER_PILLS) {
        uint32_t randIndex = random(ROWS * COLS);
        if (pacmanMap[randIndex] == '.') {	//only replace . with *
            pacmanMap[randIndex] = '*';
						update_display(randIndex,'*');	//go to given position, replace with ''
            pillsPlaced++;
        }
    }
}
//
uint32_t random(uint32_t max) {	//generate random number based on time (everytime called)
    static uint32_t seed = 0; // Persistent seed variable
    if (seed == 0) {
        seed = LPC_TIM0->TC; // Initialize seed from timer (CurrentValue)only once
    }
    seed = (1103515245 * seed + 12345) & 0x7FFFFFFF;
    return seed % max;
}
//
void update_display(int position,uint8_t ch){	//update given position with ch (given character)
	int i = position/COLS;
	int j = position%COLS;
	PutChar(j*8,32+(i*16),ch,Yellow,Black);
}
//
void Resume_game(void){
	
	
  GUI_Text(0, 0,   (uint8_t *)"Time", White, Black);
	print_CountDown();
	GUI_Text(144, 0, (uint8_t *)"Score", White, Black);
	print_Score();
	
		for(int i=0;i<40;i+=8) PutChar((100+i),192,'#',Cyan,Black);	//remove Pause effect on screen
	update_display(PacMan_pos,'@');
	
	print_remaining_lives();	
	
	enable_timer(0);  
  enable_RIT();    
		
	return;

}
//
void pause_game(void){
	
	PacMan_dir = STOP;
	disable_timer(0);  		// Stop timer or relevant game logic
  disable_RIT();
	GUI_Text(100, 192,   (uint8_t *)"Pause", White, Red);
	
}
//
//
//
void PacMan_move(Direction Dir){ //input as Direction: UP/DOWN/LEFT/RIGHT/STOP
	
	
	int next_pos = 0;
	switch (Dir) {									//PacMan_pos --> location of PacMan
		case UP:											//next_pos --> new position PacMan, wants to go
				next_pos = PacMan_pos - COLS;	//PacMan_pos-30 (since LCD shows 30 on X, means exactly address of "up" from PacMan)
					
		
				if(pacmanMap[next_pos] == '#' || pacmanMap[next_pos] == '$')PacMan_dir = STOP;	//if reached wall or '-' --> STOP (PacMan don't move)
				else if(pacmanMap[next_pos] == ' '){
					pacmanMap[next_pos] = '@';					//update map with new pisition of PacMan
					update_display(next_pos,'@');      //update PacMan location on LCD (only that position)
					pacmanMap[PacMan_pos] = ' ';      //place previous position of PacMan by ' ' (sapce)
					update_display(PacMan_pos,' ');   //update lcd (only that position)
					PacMan_pos = next_pos;             //update PacMan position
					Score += 0;		//***to make code balanced for each Direction and runs  in the same speed
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '.'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 10;
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
					// if sore reaches 1000, ;life ++ //by tmp_score making a controller for every 1000 point only
				}else if(pacmanMap[next_pos] == '*'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 50;	
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
					POWER_PILLS--; //eachtime eat one * numbers decrese
				}
				break;
				
				
		case DOWN:
				next_pos = PacMan_pos + COLS;
		
				if(pacmanMap[next_pos] == '#' || pacmanMap[next_pos] == '-')PacMan_dir = STOP;
				else if(pacmanMap[next_pos] == ' '){
					pacmanMap[next_pos] = '@';				
					update_display(next_pos,'@');		
					pacmanMap[PacMan_pos] = ' '; 		
					update_display(PacMan_pos,' ');	
					PacMan_pos = next_pos; 					
					Score += 0;		//***to make code balanced for each Direction and runs  in the same speed
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '.'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 10;
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '*'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 50;	
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
					POWER_PILLS--;
				}			
				break;
				
				
		case LEFT:
				next_pos = PacMan_pos - 1;
				
						if(next_pos == 270) {
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = 298;
					pacmanMap[PacMan_pos] = '@';
					update_display(PacMan_pos,'@');
					}
		
				else if(pacmanMap[next_pos] == '#' || pacmanMap[next_pos] == '-')PacMan_dir = STOP;
				else if(pacmanMap[next_pos] == ' '){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';	
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 0;		//***to make code balanced for each Direction and runs  in the same speed
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '.'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 10;
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '*'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 50;	
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
					POWER_PILLS--;
				}		
				
				break;
				
				
		case RIGHT:		
				next_pos = PacMan_pos + 1;
				
					if(next_pos == 299) {
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = 271;
					pacmanMap[PacMan_pos] = '@';
					update_display(PacMan_pos,'@');
					}
						
				else if(pacmanMap[next_pos] == '#' || pacmanMap[next_pos] == '-')PacMan_dir = STOP;
				else if(pacmanMap[next_pos] == ' '){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 0;		//***to make code balanced for each Direction and runs  in the same speed
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '.'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 10;
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
				}else if(pacmanMap[next_pos] == '*'){
					pacmanMap[next_pos] = '@';
					update_display(next_pos,'@');
					pacmanMap[PacMan_pos] = ' ';
					update_display(PacMan_pos,' ');
					PacMan_pos = next_pos;
					Score += 50;	
					print_Score();
					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
					POWER_PILLS--;
				}		
				break;
				
				
				
		case STOP:
				PacMan_dir = STOP;
				break;
	}

	
}

//
//
// !end of story!