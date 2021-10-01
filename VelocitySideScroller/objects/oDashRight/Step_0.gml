/// @description Insert description here
// You can write your code in this editor
//if place_meeting(x,y,class)
if class_player.start == 0 {
	with oPlayer {
		if place_meeting(x,y,other) and place_meeting(x,y,oDashDown) {
			while place_meeting(x,y,oDashDown) {
				y++;
			}
		}
	}
} else {
	/*with oPlayer {
		if !tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_top-1) {
			oPlayer.y-= 256;
		}
	}*/
}