/// @description Insert description here
// You can write your code in this editor
if place_meeting(x,y,class_player) and class_player.start and tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+oPlayer.vsp) {
	do {
		class_player.y++;
	} until (tilemap_get_at_pixel(global.tilemap,class_player.x,class_player.bbox_bottom+1));
	class_player.hsp = -class_player.hsp_dash;

	class_player.hsp_dir = -1;
	class_player.image_xscale = -1;
}