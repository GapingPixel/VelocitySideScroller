/// @description Insert description here
// You can write your code in this editor
/*if distance_to_object(class_player) <= 3 {
	other.hp = 0;
	other.state = PLAYERSTATE.DEATH;
}*/

if place_meeting(x+1,y,oPlayer) {
	oPlayer.hp = 0;
	oPlayer.state = PLAYERSTATE.DEATH;
	screenshake(8,global.onesecond*1.5);
} else if place_meeting(x-1,y,class_player) {
	oPlayer.hp = 0;
	oPlayer.state = PLAYERSTATE.DEATH;
	screenshake(8,global.onesecond*1.5);
} else if place_meeting(x,y+1,class_player) {
	oPlayer.hp = 0;
	oPlayer.state = PLAYERSTATE.DEATH;
	screenshake(8,global.onesecond*1.5);
} else if place_meeting(x,y-1,class_player) {
	oPlayer.hp = 0;
	oPlayer.state = PLAYERSTATE.DEATH;
	screenshake(8,global.onesecond*1.5);
} 