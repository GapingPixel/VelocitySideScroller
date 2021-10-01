/// @description Size variables and mode setup
//depth = -9999;

w = window_get_width();
h = window_get_height();
h_half = h * 0.5;
enum TRANS_MODE
{
	OFF,
	NEXT,
	GOTO,
	RESTART,
	INTRO 
	
}
mode = TRANS_MODE.INTRO;
percent = 1;
target = room;