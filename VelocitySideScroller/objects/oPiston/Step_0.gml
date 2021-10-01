/// @description Insert description here
// You can write your code in this editor

if image_angle == 90 {
	movement = HORIZONTAL;
}

switch movement {

	case VERTICAL:
	switch falling {
	
		case 0:
		y+= spd; 
		
		if tilemap_get_at_pixel(global.tilemap,x,y+spd) then falling = 1;
		if tilemap_get_at_pixel(global.tilemap64,x,y+spd) then falling = 1;
		break;
		
		case 1:
		y-=spd;
		
		if y <= ystart then falling = 0;
		break;
	}
	break;
	
	case HORIZONTAL:
	switch falling {
	
		case 0:
		x+= spd; 
		
		if tilemap_get_at_pixel(global.tilemap,x,y+spd) then falling = 1;
		if tilemap_get_at_pixel(global.tilemap64,x,y+spd) then falling = 1;
		break;
		
		case 1:
		x-=spd;
		
		if x <= xstart then falling = 0;
		break;
	}
	break;

}