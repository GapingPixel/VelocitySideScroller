/// @description Insert description here
// You can write your code in this editor


switch state {

	case ENEMYSTATE.MOVE: 
	/// @description Report to grids
	if((is_colliding == false) && collision_timer == 0) { //No collision and timer has run continue as normal
	    //Follow mouse on left click hold
		steering = vect_add(steering, sb_seek_arrive(oPlayer.x,oPlayer.y,256,15));
		//Follow prey
	    /*if(target_obj != noone) {
	        steering = vect_add(steering, sb_pursuit(target_obj,5));
	    }*/
	    //steering = vect_add(steering, sb_wander(128,160,60,3));
	    steering = vect_add(steering, sb_alignment(class_enemy,256,1));
	    steering = vect_add(steering, sb_separation(class_enemy,128,3));
	    steering = vect_add(steering, sb_cohesion(class_enemy,368,2));
	   
		steering = vect_add(steering, sb_avoid_collision(class_solid,200,100,8));
		 //steering = vect_add(steering, sb_avoid_collision(oTurret,200,100,8));
		//steering = vect_add(steering, sb_avoid_collision(oTurret,200,100,8));
	} else { //Colliding and/or timer hasn't finished, run these steering behaviours instead
	    steering = vect_add(steering, sb_wander(64,80,30,1));
	    steering = vect_add(steering, sb_flee(flee_x,flee_y,64));
	    steering = vect_add(steering, sb_avoid_collision(class_solid,200,100,6));
	}

	//## Steering Behaviours go above here ##//

	//Limit steering by max_force
	steering = vect_truncate(steering, max_force); 
	// Limit velocity to max_speed
	velocity = vect_truncate(vect_add(velocity, steering),max_speed); 
	//Add velocity to position
	position = vect_add(position, velocity);

	//Check for collision with solid_obj.
	flee_obj = instance_place(position[1], position[2], solid_obj);
	if(flee_obj != noone) { //Collision found
	    is_colliding = true;
	    //Set flee point
	    flee_x = flee_obj.x;
	    flee_y = flee_obj.y;
	    //Don't update XY to new position.
	    position[1] = x;
	    position[2] = y;
	    //Reset collision_timer
	    collision_timer = collision_counter;
	} else {
	    is_colliding = false;
	    //Reduce timer by 1, but don't go below 0.
	    collision_timer = max(0, collision_timer - 1); 
	    //update xy
	    x = position[1];
	    y = position[2];
	}

	image_angle = vect_direction(velocity);
	///Screen Wrap
	if position[1] > room_width position[1] = 0;
	if position[2] > room_height position[2] = 0;
	if position[1] < 0 position[1] = room_width;
	if position[2] < 0 position[2] = room_height;
	
	//Re update support objs 
	area.x = x;
	area.y = y;
	coll_box.x = x;
	coll_box.y = y;
	
	/*var _dir = point_direction(x,y,class_player.x,class_player.y);
	var _ = point_direction(x,y,class_player.x,class_player.y);*/
	//collision_line_first(x,y,class_player.x,class_player.y, all, false,true)
	
	if alarm_get(2) <=0 and distance_to_object(class_player) < 230 {
		 /*if collision_line_first(x,y,class_player.x,class_player.y, all, false,true) == oPlayer.id {
			state = ENEMYSTATE.MELEE;
						alarm[1] = global.onesecond*1;
						//path_end();
						//direction_ = point_direction(x,y,oPlayer.x,oPlayer.y);
						max_speed = 100;
						max_force = 40;
						alarm[3] = global.onesecond*1.5;
		 }*/
		with area {
			while direction < 360 {
				image_angle++;
				direction++; 
				if place_meeting(x,y,oPlayer) and !place_meeting(x,y,oSolidStatic) and !place_meeting(x,y,oTurret) and !place_meeting(x,y,oEnemy)   {
					with other {
						state = ENEMYSTATE.MELEE;
						alarm[1] = global.onesecond*1;
						//path_end();
						//direction_ = point_direction(x,y,oPlayer.x,oPlayer.y);
						max_speed = 100;
						max_force = 40;
						alarm[3] = global.onesecond*1.5;
					}
					
					break;
					
				}
				
			}
			direction = 0;
			image_angle = 0;
		}
	}
	break;
	
	case ENEMYSTATE.MELEE: 
	//sb_evade(class_solid,1);
	if((is_colliding == false) && collision_timer == 0) { //No collision and timer has run continue as normal
	    //Follow mouse on left click hold
		steering = vect_add(steering, sb_seek_arrive(oPlayer.x,oPlayer.y,32,1));
		//Follow prey
	    /*if(target_obj != noone) {
	        steering = vect_add(steering, sb_pursuit(target_obj,5));
	    }*/
	    //steering = vect_add(steering, sb_wander(128,160,60,3));
	    steering = vect_add(steering, sb_alignment(class_enemy,256,1));
	    steering = vect_add(steering, sb_separation(class_enemy,128,3));
	    steering = vect_add(steering, sb_cohesion(class_enemy,368,2));
	    steering = vect_add(steering, sb_avoid_collision(class_solid,300,200,8));
	} else { //Colliding and/or timer hasn't finished, run these steering behaviours instead
	    //steering = vect_add(steering, sb_wander(64,80,30,1));
	    steering = vect_add(steering, sb_flee(flee_x,flee_y,64));
	    steering = vect_add(steering, sb_avoid_collision(oPlayer,150,100,6));
	}

	//## Steering Behaviours go above here ##//
	//Limit steering by max_force
	steering = vect_truncate(steering, max_force); 
	// Limit velocity to max_speed
	velocity = vect_truncate(vect_add(velocity, steering),max_speed); 
	//Add velocity to position
	position = vect_add(position, velocity);

	//Check for collision with solid_obj.
	flee_obj = instance_place(position[1], position[2], solid_obj);
	if(flee_obj != noone) { //Collision found
	    is_colliding = true;
	    //Set flee point
	    flee_x = flee_obj.x;
	    flee_y = flee_obj.y;
	    //Don't update XY to new position.
	    position[1] = x;
	    position[2] = y;
	    //Reset collision_timer
	    collision_timer = collision_counter;
	} else {
	    is_colliding = false;
	    //Reduce timer by 1, but don't go below 0.
	    collision_timer = max(0, collision_timer - 1); 
	    //update xy
	    x = position[1];
	    y = position[2];
	}

	image_angle = vect_direction(velocity);
	///Screen Wrap
	if position[1] > room_width position[1] = 0;
	if position[2] > room_height position[2] = 0;
	if position[1] < 0 position[1] = room_width;
	if position[2] < 0 position[2] = room_height;
	
	//Re update support objs 
	area.x = x;
	area.y = y;
	coll_box.x = x;
	coll_box.y = y;
	
	/*if alarm_get(1) == -1 {
		state = ENEMYSTATE.MOVE;
		audio_stop_sound(snFlap);
	}
	speed_ = 80;*/
	if distance_to_object(oPlayer) < 100 {
		state = ENEMYSTATE.FLEE;
		audio_stop_sound(snFlap);
		alarm_set(1,-1);
		/*var _dmg = instance_create_depth(x,y,depth-1,class_dmg);
		_dmg.creator = id;
		_dmg.image_xscale = 2;
		_dmg.image_yscale = 2;*/
		with oPlayer {
			hp-=1;
			if hp <= 0 { 
				state = PLAYERSTATE.DEATH;
				alarm_set(0,global.onesecond*10);
			}
		}
		//direction_ = point_direction(oPlayer.x,oPlayer.y,x,y);
		alarm_set(2,global.onesecond*2);
		max_speed = 8;
		max_force = 0.7;		
	}
	/*with coll_box {
		if place_meeting(x,y,oPlayer) {
			with other {
				state = ENEMYSTATE.FLEE;
				audio_stop_sound(snFlap);
				alarm_set(1,-1);
				var _dmg = instance_create_depth(x,y,depth-1,class_dmg);
				_dmg.creator = id;
				//direction_ = point_direction(oPlayer.x,oPlayer.y,x,y);
				alarm_set(2,global.onesecond*2);
				max_speed = 8;
				max_force = 0.7;
			}
		} 
		
	}*/
	
	/*if distance_to_object(oPlayer) < 128 {
		
		state = ENEMYSTATE.FALLBACK;
		audio_stop_sound(snFlap);
		alarm_set(1,-1);
				var _dmg = instance_create_depth(x,y,depth-1,class_dmg);
				_dmg.creator = id;
				direction_ = point_direction(oPlayer.x,oPlayer.y,x,y);
				alarm_set(2,global.onesecond*1.2);
	}*/
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
	//move_movement_lifeform(false);
	var dash = instance_create_layer(x,y,"Entities",oGhostTrail);
	dash.sprite_index = sprite_index;
	dash.image_index = image_index;
	
	if alarm_get(3) <=0 {
		state = ENEMYSTATE.FLEE;
		audio_stop_sound(snFlap);
		alarm_set(1,-1);
	}
	break;
	
	case ENEMYSTATE.FLEE: 
	/// @description Report to grids
	if((is_colliding == false) && collision_timer == 0) { //No collision and timer has run continue as normal
	    //Follow mouse on left click hold
		steering = vect_add(steering, sb_seek_arrive(xstart,ystart,256,15));
		//Follow prey
	    /*if(target_obj != noone) {
	        steering = vect_add(steering, sb_pursuit(target_obj,5));
	    }*/
	    //steering = vect_add(steering, sb_wander(128,160,60,3));
	    steering = vect_add(steering, sb_alignment(class_enemy,256,1));
	    steering = vect_add(steering, sb_separation(class_enemy,128,3));
	    steering = vect_add(steering, sb_cohesion(class_enemy,368,2));
	    steering = vect_add(steering, sb_avoid_collision(class_solid,80,200,8));
	} else { //Colliding and/or timer hasn't finished, run these steering behaviours instead
	    //steering = vect_add(steering, sb_wander(64,80,30,1));
	    steering = vect_add(steering, sb_flee(flee_x,flee_y,64));
	    steering = vect_add(steering, sb_avoid_collision(class_solid,200,180,6));
	}

	//## Steering Behaviours go above here ##//

	//Limit steering by max_force
	steering = vect_truncate(steering, max_force); 
	// Limit velocity to max_speed
	velocity = vect_truncate(vect_add(velocity, steering),max_speed); 
	//Add velocity to position
	position = vect_add(position, velocity);

	//Check for collision with solid_obj.
	flee_obj = instance_place(position[1], position[2], solid_obj);
	if(flee_obj != noone) { //Collision found
	    is_colliding = true;
	    //Set flee point
	    flee_x = flee_obj.x;
	    flee_y = flee_obj.y;
	    //Don't update XY to new position.
	    position[1] = x;
	    position[2] = y;
	    //Reset collision_timer
	    collision_timer = collision_counter;
	} else {
	    is_colliding = false;
	    //Reduce timer by 1, but don't go below 0.
	    collision_timer = max(0, collision_timer - 1); 
	    //update xy
	    x = position[1];
	    y = position[2];
	}

	image_angle = vect_direction(velocity);
	///Screen Wrap
	if position[1] > room_width position[1] = 0;
	if position[2] > room_height position[2] = 0;
	if position[1] < 0 position[1] = room_width;
	if position[2] < 0 position[2] = room_height;
	
	/*if alarm_get(2) <=0 {
		with area {
			if place_meeting(x,y,oPlayer) {
				with other {
					state = ENEMYSTATE.MELEE;
					alarm[1] = global.onesecond*1;
					path_end();
					direction_ = point_direction(x,y,oPlayer.x,oPlayer.y);
					max_speed = 100;
					max_force = 40;
				}
			
			}
		}
	}*/
	
	if alarm_get(2) < 0 {
		state = ENEMYSTATE.MOVE;
	}
	break;
	
	case ENEMYSTATE.DEATH: 
	instance_destroy(id,true);
	break;

}
