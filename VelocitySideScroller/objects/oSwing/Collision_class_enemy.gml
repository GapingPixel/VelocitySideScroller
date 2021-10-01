/// @description Insert description here
// You can write your code in this editor
alarm_set(1,1);

var _en = other;

with oPlayer {
	if oPlayer.x < _en.x {
		knockback_dir = ANG_RIGHT;
	} else {
		knockback_dir = ANG_LEFT;
	}
	alarm_set(6,global.onesecond*.5)
}