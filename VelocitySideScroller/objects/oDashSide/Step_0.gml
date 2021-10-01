/// @description Insert description here
// You can write your code in this editor
//if place_meeting(x,y,class)

with oPlayer {
		var _ver = instance_nearest(x,y,oDashVer);
		if place_meeting(x,y,other) and place_meeting(x,y,_ver) and _ver.y < y  {
			while place_meeting(x,y,other) {
				x--;
			}
		}	
			
		var _ver = instance_nearest(x,y,oDashVer);
		if place_meeting(x,y,other) and place_meeting(x-1,y,_ver) and _ver.y > y   {
			while place_meeting(x,y,other) {
				x--;
			}
		}	
		/*if !tilemap_get_at_pixel(global.tilemap,bbox_left-1,y) and image_xscale = -1 {
		while !tilemap_get_at_pixel(global.tilemap,bbox_left-1,y) {
			x--;
		}*/
	
		/*var _ver = instance_nearest(x,y,oDashVer);
		if place_meeting(x,y,other) and place_meeting(x,y,_ver) and _ver.y > y  {
			while place_meeting(x,y,oDashVer) {
				x++;
			}
		}*/
}

/*
if place_meeting(x,y,class_player) and class_player.start and tilemap_get_at_pixel(global.tilemap,class_player.bbox_right+oPlayer.vsp,class_player.y) {
	do {
		class_player.x++;
	} until (tilemap_get_at_pixel(global.tilemap,class_player.bbox_right,class_player.y));
	class_player.hsp = class_player.hsp_dash;

	class_player.hsp_dir = 1;
	class_player.image_xscale = 1;
}		


