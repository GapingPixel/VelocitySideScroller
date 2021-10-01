/// @description Insert description here
// You can write your code in this editor
var spd = 3;
var maxspd = 60;
var acc = .1;

//lerp()



if !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+spd) {
	
	
	spd_final += acc;
	spd_final = min(spd_final,maxspd);
	y+= spd_final;
}