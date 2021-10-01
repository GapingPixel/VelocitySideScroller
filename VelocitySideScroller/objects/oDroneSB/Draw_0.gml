/// @description Insert description here
// You can write your code in this editor
if outline  {
	draw_self();
	var thickness = 10;
	draw_sprite_ext(sprite_index,image_index,x+thickness,y+thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-thickness,y-thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-thickness,y+thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x+thickness,y-thickness,image_xscale,image_yscale,image_angle,c_black,image_alpha);
	//draw_sprite_part()*/
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,my_color,image_alpha);

switch state {

	case ENEMYSTATE.MOVE:
	draw_text(x,y,"Move");
	break;
	
	case ENEMYSTATE.MELEE:
	draw_text(x,y,"Melee");
	/*for (var _x = 0; _x <= room_width; _x+=64) {
		for (var _y = 0; _y <= room_height; _y+=64) {
			if tilemap_get_at_pixel(global.tilemap,_x ,_y ) {
				instance_create_layer(floor(_x/64),floor(_y/64),"Solid",oSolidStatic);
				//mp_grid_add_cell(pathfGrid,floor(_x/64),floor(_y/64));
			} else if tilemap_get_at_pixel(global.tilemap64,_x ,_y) {
				instance_create_layer(floor(_x/64),floor(_y/64),"Solid",oSolidStatic);
				//mp_grid_add_cell(pathfGrid,floor(_x/64),floor(_y/64));
			} 
		}
	}*/
	break;

	case ENEMYSTATE.FLEE:
	draw_text(x,y,"Flee");
	break;
	
}

//event_inherited();