/// @description Insert description here
// You can write your code in this editor
with oPlayer {
		if place_meeting(x,y,other) and place_meeting(x,y,oDashDown2) {
			if !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) {
				while !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) {
					y++;
				}
			}
		}
}