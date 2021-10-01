/// @description Draw
// You can write your code in this editor
if state == PLAYERSTATE.HIT {
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle, c_orange, .5);
}else { 
	draw_self();
}
//var _onwall = (tilemap_get_at_pixel(global.tilemap,bbox_right+1,y)) - (tilemap_get_at_pixel(global.tilemap,bbox_left-1,y));
//draw_text(x,y,string(_onwall));

//draw_text(x,y,string(wallrun));

//draw_text(x,y, string(in_floor(global.tilemap,x,bbox_bottom+1)));
//draw_text(x,y+20,  string( -(TILE_SIZE - (bbox_bottom+1 mod TILE_SIZE)) )  )
//draw_text(x,y-40,string( (tilemap_get_at_pixel(global.tilemap,x-16,bbox_bottom+1)) ));
if (tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom) and tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top-32) and !tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top-33) and !tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom+33) ) {
		//draw_text(x,y,"yeee");
}

//draw_text(x,y,string(oSword.swingCount));
var grounded = in_floor64(global.tilemap64,x,bbox_bottom+1); //(in_floor(global.tilemap,x,bbox_bottom+1) >= 0); 
var floordist = in_floor64(global.tilemap64,x,bbox_bottom+vsp)//in_floor(global.tilemap,x,bbox_bottom+1)
var onwall = (tilemap_get_at_pixel(global.tilemap,bbox_right+1,y)) - (tilemap_get_at_pixel(global.tilemap,bbox_left-1,y));

var bumpslope = tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top) == 1;

var dustCheck = tilemap_get_at_pixel(global.tilemap,bbox_right+1,y);
var dustCheckLeft = !tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top)
var ledgeslope = tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top);
//var 
var _yoff = 32;

var onwall = max(tilemap_get_at_pixel(global.tilemap,bbox_right+1,y),tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y)) - max(tilemap_get_at_pixel(global.tilemap,bbox_left-1,y), tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y) );
if onwall != 0 {
	//draw_text(x,y+200, "ONWALL");
}
draw_text(x,y, string(state));

/*draw_text(x,y,string (tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10)));
draw_text(x,y+100,string (tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top+10)));
/*if tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10)  { 
	draw_text(x,y,"LEFT THIS SHIT WONT WORK");
}

if tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top+10) { 
	draw_text(x,y,"RIGHT THIS SHIT WONT WORK");
}*/

//draw_text(x,y+_yoff,"x" + string(test));
/*
draw_text(x+300,y+_yoff,"y" + string(y));
draw_text(x,y-_yoff*6,"Wallrunlocked: " + string(wallrun_locked));
draw_text(x,y-_yoff*7.5,"Wallrun " + string(wallrun));
//draw_text(x+100,y+_yoff,"Wallrun Height " + string(wallrun_height));
draw_text(x+100,y+_yoff*5,"hop state: " + string(hop));*/


//draw_text(x,y,"Jump " + string(input.key_jump_pressed));
/*
	if place_meeting(x,y+3,oSolid) {
			draw_text(x,y,"Sld Coll");
	}
	
	draw_text(x+200,y+60,"grounded: " + string(grounded));
	draw_text(x+200,y+_yoff+60,"floordist: " + string(floordist));
	draw_text(x,y-_yoff*2,"onwall: " + string(onwall));
	draw_text(x,y-_yoff*3,"vsp: " + string(vsp));
	draw_text(x,y-_yoff*4,"hsp: " + string(hsp));
	
	draw_text(x,y-_yoff*6,"dust check: " + string(dustCheck));
	draw_text(x,y-_yoff*7.5,"Ledge slope " + string(ledgeslope));
	draw_text(x+100,y+_yoff,"Bump slope " + string(bumpslope));
	draw_text(x+100,y+_yoff*5,"State: " + string(state));


