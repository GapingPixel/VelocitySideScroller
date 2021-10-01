/// @description Insert description here
// You can write your code in this editor
if first_coll and class_player.start == 1 then exit;
first_coll = true;

/*other.state = PLAYERSTATE.DASH;
	other.hsp = 0;
	other.vsp = other.vsp_max;
	class_player.start = 1;*/
/*other.state = PLAYERSTATE.DASH;
	other.hsp = 0;
	other.vsp = other.vsp_max;
	class_player.start = 1;*/

/*other.state = PLAYERSTATE.DASH;
	//other.hsp = 0;
	other.vsp = -other.vsp_super_max;
	class_player.start = 1;*/
other.state = PLAYERSTATE.DASH;	
if y > class_player.y {
	other.hsp = 0;
	other.vsp = other.vsp_super_max;
} else {
	other.hsp = 0;
	other.vsp = -other.vsp_super_max;
	class_player.start = 1;
}

/*
if other.state == PLAYERSTATE.DASH {
	other.hsp = 0;
	other.vsp = -other.vsp_super_max;
} else {
	other.state = PLAYERSTATE.DASH;
	//other.hsp = 0;
	other.vsp = other.vsp_super_max;
	class_player.start = 1;
}