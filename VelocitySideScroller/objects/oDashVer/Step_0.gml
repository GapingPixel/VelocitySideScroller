/// @description Insert description here
// You can write your code in this editor

/*with oPlayer {
	var _side = instance_nearest(x,y,oDashSide);
	if place_meeting(x,y,other) and place_meeting(x,y,_side) and x < _side.x and y < other.y   {
		//y--;
	}	
}*/

if place_meeting(x,y,class_player) and class_player.start and tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+oPlayer.vsp) {
	do {
		class_player.y++;
	} until (tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+1));
	class_player.hsp = -class_player.hsp_dash;

	class_player.hsp_dir = -1;
	class_player.image_xscale = -1;
}

with class_player {

	if tilemap_get_at_pixel(global.tilemap,bbox_left-1,y) and tilemap_get_at_pixel(global.tilemap,x,bbox_top-1) {
		x+=128;
	}
	
	
}

/*
if place_meeting(x,y,class_player) and class_player.start and tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+oPlayer.vsp) {
	do {
		class_player.y++;
	} until (tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+1));
	class_player.hsp = -class_player.hsp_dash;

	class_player.hsp_dir = -1;
	class_player.image_xscale = -1;
}

/*
if place_meeting(x,y,class_player) and class_player.start and tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+oPlayer.vsp) {
	do {
		class_player.x++;
	} until (tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+1));
	class_player.hsp = -class_player.hsp_dash;

	class_player.hsp_dir = -1;
	class_player.image_xscale = -1;
}