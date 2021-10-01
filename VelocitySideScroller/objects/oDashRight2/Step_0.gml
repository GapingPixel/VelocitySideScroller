/// @description Insert description here
// You can write your code in this editor
//if place_meeting(x,y,class)

	with oPlayer {
		if place_meeting(x,y,other) and place_meeting(x,y,oDashDown2) {
			if !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) {
				while !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) {
					y++;
				}
			}
		}
		
		if place_meeting(x,y,other) and place_meeting(x,y,oDashUp2) {
			check = true;
			other.hsp = 0;
	
			other.vsp = vsp_super_max;
		} else {
			other.check = false;
			other.hsp = vsp_super_max;
	
			other.vsp = 0;
		}
		
	}
