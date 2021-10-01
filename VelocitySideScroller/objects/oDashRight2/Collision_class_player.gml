/// @description Insert description here
// You can write your code in this editor
/*if first_coll then exit;
first_coll = true;*/
if check == true then exit;

other.state = PLAYERSTATE.DASH;
	
	other.hsp = other.hsp_dash;
	
	other.vsp = 0;
	

	other.hsp_dir = 1;
	other.image_xscale = 1;


/*
if class_player.start == 0 {
other.state = PLAYERSTATE.DASH;
	
	other.hsp = other.hsp_dash;
	
	other.vsp = 0;
	

	other.hsp_dir = 1;
	other.image_xscale = 1;
} else {
	other.state = PLAYERSTATE.DASH;
	
	other.hsp = -other.hsp_dash;
	
	other.vsp = 0;
	

	other.hsp_dir = -1;
	other.image_xscale = -1;
	
	with oPlayer {
		if tilemap_get_at_pixel(global.tilemap,bbox_left-1,y) {
			hsp = 0;
			vsp = -vsp_max;
		}
	}
}*/

/*
with class_player {
	if place_meeting(x,y,oDashUp) {
		other.check = true;
	}
	
	if place_meeting(x,y,oDashUp) {
		while place_meeting(x,y,oDashUp) {
			y++;
		}
	}
	
}

if check and class_player.hsp != other.hsp_dash  {
	other.hsp = -other.hsp_dash;

	other.hsp_dir = -1;
	other.image_xscale = -1;
} else {

	other.state = PLAYERSTATE.DASH;
	other.hsp = other.hsp_dash;

	other.hsp_dir = 1;
	other.image_xscale = 1;
}