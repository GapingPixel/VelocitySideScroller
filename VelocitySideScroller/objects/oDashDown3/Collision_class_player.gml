/// @description Insert description here
// You can write your code in this editor
if first_coll then exit;
first_coll = true;

if other.state == PLAYERSTATE.DASH {
	//.hsp = 0;
	other.vsp = -other.vsp_super_max;
} else {
	other.state = PLAYERSTATE.DASH;
	//other.hsp = 0;
	other.vsp = other.vsp_super_max;
	class_player.start = 0;
}

