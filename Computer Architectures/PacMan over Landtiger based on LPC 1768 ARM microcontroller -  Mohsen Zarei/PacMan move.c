//#include "LPC17xx.h"
//#include "PacManMove.h"





//void PacMan_move(Direction Dir){
//	
//	
//	int tmp_pos = 0;
//	switch (Dir) {
//		case UP:
//				tmp_pos = PacMan_pos - COLS;
//				if(pacmanMap[tmp_pos] == '#'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '-'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '|'){
//					if(tmp_pos == 240) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 208;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//					if(tmp_pos == 209) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 241;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//				}else if(pacmanMap[tmp_pos] == ' '){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//				}else if(pacmanMap[tmp_pos] == '.'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 10;
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
//				}else if(pacmanMap[tmp_pos] == '*'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 50;	
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
//					POWER_PILLS--;
//				}
//				break;
//		case DOWN:
//				tmp_pos = PacMan_pos + COLS;
//				if(pacmanMap[tmp_pos] == '#'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '-'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '|'){
//					if(tmp_pos == 240) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 208;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//					if(tmp_pos == 209) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 241;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//				}else if(pacmanMap[tmp_pos] == ' '){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//				}else if(pacmanMap[tmp_pos] == '.'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 10;
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
//				}else if(pacmanMap[tmp_pos] == '*'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 50;	
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
//					POWER_PILLS--;
//				}			
//				break;
//		case LEFT:
//				tmp_pos = PacMan_pos - 1;
//				if(pacmanMap[tmp_pos] == '#'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '-'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '|'){
//					if(tmp_pos == 240) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 208;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//					if(tmp_pos == 209) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 241;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//				}else if(pacmanMap[tmp_pos] == ' '){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//				}else if(pacmanMap[tmp_pos] == '.'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 10;
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
//				}else if(pacmanMap[tmp_pos] == '*'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 50;	
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
//					POWER_PILLS--;
//				}			
//				break;
//		case RIGHT:
//				tmp_pos = PacMan_pos + 1;
//				if(pacmanMap[tmp_pos] == '#'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '-'){
//					PacMan_dir = STOP;
//				}else if(pacmanMap[tmp_pos] == '|'){
//					if(tmp_pos == 240) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 208;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//					if(tmp_pos == 209) {pacmanMap[PacMan_pos] = ' ';update_display(PacMan_pos,' ');PacMan_pos = 241;pacmanMap[PacMan_pos] = '@';update_display(PacMan_pos,'@');}
//				}else if(pacmanMap[tmp_pos] == ' '){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//				}else if(pacmanMap[tmp_pos] == '.'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 10;
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}
//				}else if(pacmanMap[tmp_pos] == '*'){
//					pacmanMap[tmp_pos] = '@';
//					update_display(tmp_pos,'@');
//					pacmanMap[PacMan_pos] = ' ';
//					update_display(PacMan_pos,' ');
//					PacMan_pos = tmp_pos;
//					Score += 50;	
//					print_Score();
//					if((Score/new_life) > tmp_score){tmp_score++;Remaining_lives++;print_remaining_lives();}					
//					POWER_PILLS--;
//				}		
//				break;
//		case STOP:
//				PacMan_dir = STOP;
//				break;
//	}	
//}