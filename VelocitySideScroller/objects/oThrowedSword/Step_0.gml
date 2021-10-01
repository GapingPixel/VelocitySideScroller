/// @description Insert description here
// You can write your code in this editor
var _spd = 32;

if speed == 0 and alarm_get(2) > 0 {
	if target.state == ENEMYSTATE.DEATH {
		alarm_set(2,0);
	}
	target.state = ENEMYSTATE.STUN;
	if input.key_dash {
		if !tilemap_get_at_pixel(global.tilemap,x,y) and !tilemap_get_at_pixel(global.tilemap,x,y) {
			oPlayer.x = x;	
			oPlayer.y = y-24;	
			audio_play_sound(snTeleport,3,false);
		} else {
			show_debug_message("Can't tp");
		}
	}
}

if alarm_get(0) > -1 and !coll and target != noone {
	direction = point_direction(x,y,target.x,target.y);
}

//Move to player pos
if alarm_get(0) == -1 and !coll  {
	
	if speed > -_spd { 
		speed -= _spd;
	}
	direction = point_direction(oPlayer.x,oPlayer.y,x,y);
	if distance_to_object(oPlayer) <= _spd {
		instance_destroy();
	}
}

if alarm_get(2) <=0 and coll {
	speed = -_spd;
	direction = point_direction(oPlayer.x,oPlayer.y,x,y);
	if distance_to_object(oPlayer) <= _spd {
		instance_destroy();
	}
} 

/*if target != noone and !coll and alarm_get(0) <=0  {
	direction = point_direction(x,y,oPlayer.x,oPlayer.y);
}*/


image_angle = direction;