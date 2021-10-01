
area.x = x;
area.y = y;

switch state {

	case ENEMYSTATE.IDLE:
	image_angle = 0;
	//if stuck then exit;
	if alarm_get(0) == -1 {
		if !tilemap_get_at_pixel(global.tilemap,bbox_right+hsp,bbox_bottom) and !place_meeting(x+hsp,y,class_solid) {
			state = ENEMYSTATE.MOVE;
			dir = DIR_RIGHT;
		} else if !tilemap_get_at_pixel(global.tilemap,bbox_left-hsp,bbox_bottom) and !place_meeting(x-hsp,y,class_solid) {
			state = ENEMYSTATE.MOVE;
			dir = DIR_LEFT;
		}
		image_xscale = dir;
	}
	ground_drone_shoot();
	break;
	
	case ENEMYSTATE.MOVE:
	image_angle = 0;
	switch dir {
	
		case DIR_RIGHT:
		if !tilemap_get_at_pixel(global.tilemap,bbox_right+hsp,bbox_bottom) and tilemap_get_at_pixel(global.tilemap,bbox_right+hsp,bbox_bottom+1) and !place_meeting(x+hsp,y,class_solid) {
			x+=hsp; 
		} else {
			//state = ENEMYSTATE.IDLE;
			dir = DIR_LEFT;
		}
		image_xscale = dir;
		break;
		
		case DIR_LEFT:
		if !tilemap_get_at_pixel(global.tilemap, bbox_left-hsp, bbox_bottom) and tilemap_get_at_pixel(global.tilemap, bbox_left-hsp, bbox_bottom+1) and !place_meeting(x-hsp,y,class_solid) {
			x-=hsp; 
		} else {
			dir = DIR_RIGHT;
		}
		image_xscale = dir;
		break;
	
	}
	ground_drone_shoot();
	break;
	
	case ENEMYSTATE.STUN:
	if alarm_get(1) == -1 {
		state = ENEMYSTATE.IDLE;
		image_angle = 0;
	}
	//sprite_index = sEnemy;
	image_angle = 90;
	with oThrowedSword {
		if alarm_get(2) <= 0 {
			other.state = ENEMYSTATE.IDLE;
			image_angle = 0;
		}
	}
	break;
	
	case ENEMYSTATE.DEATH:
	//sprite_index = sEnemyD;
	break;

}


/*vsp = vsp + grv;

//Horizantle Collision
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp);
	}
	hsp = -hsp;
}

x = x + hsp;

//Vertical Collision
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}

y = y + vsp;

//Animation
if (vsp != 0)
{
	sprite_index = sEnemyA
	image_speed = 0;
	if (sign(vsp) > 0) image_index =1; else image_index = 0;

}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = sEnemy;	
	}
	else
	{
		sprite_index = sEnemyR;
	}
}

if (hsp !=0) image_xscale = sign(hsp) * size;
image_yscale = size;
