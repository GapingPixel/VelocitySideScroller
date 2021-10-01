/// @description Insert description here
// You can write your code in this editor
var bbox_side;

//Horizontal coll
if (hsp > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
if (tilemap_get_at_pixel(global.tilemap,bbox_side+hsp,bbox_top)!=0) or (tilemap_get_at_pixel(global.tilemap,bbox_side+hsp,bbox_bottom) != 0 )  
{
	if (hsp > 0) x = x - (x mod 32) + 31 - (bbox_right - x);
	else x = x - (x mod 32) - (bbox_left - x);
	hsp = 0;
}

//Hor Solid coll
coll_sld_hor();
x += hsp;


//Vertical coll
if (vsp > 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
if (tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_side+vsp) != 0) or (tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_side+vsp) != 0)  
{
	if (vsp > 0) y = y - (y mod 32) + 31 -(bbox_bottom - y);
	else y = y - (y mod 32) - (bbox_top - y);
	vsp = 0;
}

// Vert Solid check
coll_sld_ver();
y +=  vsp;

if x == xprevious {
	if alarm_get(0) <= 0 {
		alarm_set(0,global.onesecond*1);
	}
}



