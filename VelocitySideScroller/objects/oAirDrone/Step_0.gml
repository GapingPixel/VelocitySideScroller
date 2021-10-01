/// @description Insert description here
// You can write your code in this editor
area.x = x;
area.y = y;
coll_box.x = x;
coll_box.y = y;

switch state {

	case ENEMYSTATE.IDLE:
	/*var _maxdist = 1000;
	if point_distance(xstart,ystart,x,y) < _maxdist {
		state = ENEMYSTATE.MOVE;
	}*/
	break;
	
	case ENEMYSTATE.MOVE:
	var _maxdist = 4000;
	/*if point_distance(xstart,ystart,x,y) > _maxdist {
		state = ENEMYSTATE.FLEE;
	}*/
	if distance_to_object(oPlayer) > _maxdist {
		state = ENEMYSTATE.FLEE;
	}
	if alarm_get(2) <=0 {
		with area {
			if place_meeting(x,y,oPlayer) {
				with other {
					state = ENEMYSTATE.MELEE;
					alarm[1] = global.onesecond*1;
					path_end();
					direction_ = point_direction(x,y,oPlayer.x,oPlayer.y);
				}
			
			}
		}
	}
	
	break;
	
	case ENEMYSTATE.FLEE:
	//alarm_set(0,global.onesecond*3);
	
	if distance_to_object(oPlayer) < 1000 {
		state = ENEMYSTATE.MOVE;
		
	}
	
	if x == xstart and y == ystart then state = ENEMYSTATE.MOVE;
	break;
	
	case ENEMYSTATE.MELEE:
	audio_sound_pitch(snFlap,random_range(0.9,1.2))
	audio_play_sound(snFlap,5,false);
	if alarm_get(1) == -1 {
		state = ENEMYSTATE.MOVE;
		audio_stop_sound(snFlap);
	}
	//speed_ = 80;
	with coll_box {
		if place_meeting(x,y,oPlayer) {
			with other {
				state = ENEMYSTATE.FALLBACK;
				audio_stop_sound(snFlap);
				alarm_set(1,-1);
				var _dmg = instance_create_depth(x,y,depth-1,class_dmg);
				_dmg.creator = id;
				direction_ = point_direction(oPlayer.x,oPlayer.y,x,y);
				alarm_set(2,global.onesecond*1.2);
			}
		} else {
			with other {
				add_movement_maxspeed(direction_,.5,80);
			}
		}
		
	}
	
	if distance_to_object(oPlayer) < 128 {
		
		state = ENEMYSTATE.FALLBACK;
		audio_stop_sound(snFlap);
		alarm_set(1,-1);
				var _dmg = instance_create_depth(x,y,depth-1,class_dmg);
				_dmg.creator = id;
				direction_ = point_direction(oPlayer.x,oPlayer.y,x,y);
				alarm_set(2,global.onesecond*1.2);
	}
	/*if place_meeting(x+lengthdir_x(speed_,direction_),y+lengthdir_y(speed_,direction_),oPlayer) {
		state = ENEMYSTATE.MOVE;
		audio_stop_sound(snFlap);
		alarm_set(1,-1);
		var _dmg = instance_create_depth(x,y,depth-1,class_dmg);
		_dmg.creator = id;
		direction_ = point_direction(oPlayer.x,oPlayer.y,x,y);
		alarm_set(2,global.onesecond*1.2);
	} else {
		add_movement_maxspeed(direction_,.5,80);
		
	}*/
	move_movement_lifeform(false);
	var dash = instance_create_layer(x,y,"Entities",oGhostTrail);
	dash.sprite_index = sprite_index;
	dash.image_index = image_index;
	break;
	
	case ENEMYSTATE.FALLBACK:
	speed_ = 20;
	
	
	if tilemap_get_at_pixel(global.tilemap,x+lengthdir_x(speed_,direction_),y+lengthdir_y(speed_,direction_)) or tilemap_get_at_pixel(global.tilemap64,x+lengthdir_x(speed_,direction_),y+lengthdir_y(speed_,direction_)) {
		state = ENEMYSTATE.MOVE;
	} else {
		/*x += lengthdir_x(_spd,attack_direction);
		y += lengthdir_y(_spd,attack_direction);*/
		add_movement_maxspeed(direction_,.5,speed_);
		move_movement_lifeform(false);
	}
	if alarm_get(2) <=0 then state = ENEMYSTATE.MOVE;
	break;

}

