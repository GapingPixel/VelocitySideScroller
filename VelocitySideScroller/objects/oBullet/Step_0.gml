/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x,y,class_solid)) instance_destroy();



if tilemap_get_at_pixel(global.tilemap,bbox_left+5,bbox_bottom) or tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_bottom)
	or tilemap_get_at_pixel(global.tilemap,bbox_left+5,bbox_top) or tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_top) {
	instance_destroy();	
}