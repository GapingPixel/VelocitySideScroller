/// @description Insert description here
// You can write your code in this editor

if outline  {
	draw_self();
	var thickness = 10;
	

	gpu_set_fog(true,c_white,0,0);
	draw_sprite_ext(sprite_index,image_index,x+thickness,y+thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-thickness,y-thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-thickness,y+thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x+thickness,y-thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	gpu_set_fog(false,c_white,0,0);
} 
	
draw_self();



//draw_text(x,y,string(outline));