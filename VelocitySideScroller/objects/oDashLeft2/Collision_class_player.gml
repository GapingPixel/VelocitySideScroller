/// @description Insert description here
// You can write your code in this editor
var _player = instance_nearest(x,y,class_player);

with _player {
	if place_meeting(x,y,oDashDown2) and tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top) {
		exit;
	}
}


	other.state = PLAYERSTATE.DASH;
	other.hsp = -other.hsp_dash;

	other.hsp_dir = -1;
	other.image_xscale = -1;
