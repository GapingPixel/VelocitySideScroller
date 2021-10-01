/// @description Insert description here
// You can write your code in this editor
if !instance_exists(oPlayer) then exit;

y += oPlayer.vsp;

if state != SWORDSTATE.ATTACK or alarm_get(1) > -1 {

	if y < oPlayer.y+16 and !up_hover { 
		y += hover_spd;
		if y >= oPlayer.y+16 {
			up_hover = true;
		}
	} 

	if y > oPlayer.y-16 and up_hover { 
		y -= hover_spd;
		if y <= oPlayer.y-16 {
			up_hover = false;
		}
	}

	y = clamp(y,oPlayer.y-16,oPlayer.y+16);

	if oPlayer.dashtimer != 0 {
		state = SWORDSTATE.DASH;
	}

	if oPlayer.sprite_index == sPlayer_Slam {
		state = SWORDSTATE.SLAM;
	}

}

dir = oPlayer.hsp_dir;

/*switch dir {
	
	case 1:
	if SwordMove == 1 and Angle != 0 {
		Center_X = oPlayer.x; // x of orbital center
		Center_Y = oPlayer.y; // y of orbital center
		Angle += Speed;
		if(Angle <= 3) {
			Angle = 0;
			slice = true;
		}

		// Update position
		x = lengthdir_x(Orbit, Angle) + Center_X;
		y = lengthdir_y(Orbit, Angle) + Center_Y;
	}

	if SwordMove == 2 {
		Center_X = oPlayer.x; // x of orbital center
		Center_Y = oPlayer.y; // y of orbital center
		Angle -= Speed;
		if(Angle >= 180) {
			SwordMove = 0;
			Angle = 180;
		}

		// Update position
		x = lengthdir_x(Orbit, Angle) + Center_X;
		y = lengthdir_y(Orbit, Angle) + Center_Y;
	}

	if slice {
		image_angle-=2;
		if image_angle <= 150 {
			slice = false;
		}
		//if direction <= 
	}
	break;
	
	case -1:
	if SwordMove == 1 and Angle != 0 {
		Center_X = oPlayer.x; // x of orbital center
		Center_Y = oPlayer.y; // y of orbital center
		Angle -= Speed;
		if(Angle >= 180) {
			Angle = 180;
			slice = true;
		}
		image_angle = Angle;
		// Update position
		x = lengthdir_x(Orbit, Angle) + Center_X;
		y = lengthdir_y(Orbit, Angle) + Center_Y;
	}

	if SwordMove == 2 {
		Center_X = oPlayer.x; // x of orbital center
		Center_Y = oPlayer.y; // y of orbital center
		Angle += Speed;
		if(Angle <= 0) {
			SwordMove = 0;
			Angle = 0;
		}

		// Update position
		x = lengthdir_x(Orbit, Angle) + Center_X;
		y = lengthdir_y(Orbit, Angle) + Center_Y;
	}

	if slice {
		image_angle+=2;
		if image_angle <= -150 {
			slice = false;
		}
		//if direction <= 
	}
	break;

}*/
/*switch dir {

	case 1:
	x = oPlayer.x+16*dir;
	break;
	
	case -1:
	x = oPlayer.x+16;
	break;
}*/
	if instance_exists(oThrowedSword) {
		if input.key_attack and oPlayer.energy >= COST.TELEPORT {
			oPlayer.energy -= COST.THROW;
			var _oldx = oPlayer.x;
			var _oldy = oPlayer.y;
			oPlayer.hsp_fraction = 0;
			oPlayer.vsp_fraction = 0;
			oPlayer.x = oThrowedSword.x;	
			oPlayer.y = oThrowedSword.y;
			oPlayer.x = round(oPlayer.x);
			oPlayer.y = round(oPlayer.y);
			audio_play_sound(snTeleport,3,false);
			with oThrowedSword {
		
				if !tilemap_get_at_pixel(global.tilemap,oPlayer.bbox_left,oPlayer.bbox_top) and !tilemap_get_at_pixel(global.tilemap,oPlayer.bbox_left,oPlayer.bbox_bottom) and !tilemap_get_at_pixel(global.tilemap,oPlayer.bbox_right,oPlayer.bbox_bottom) and !tilemap_get_at_pixel(global.tilemap,oPlayer.bbox_right,oPlayer.bbox_top) and 
				!tilemap_get_at_pixel(global.tilemap64,oPlayer.bbox_left,oPlayer.bbox_top) and !tilemap_get_at_pixel(global.tilemap64,oPlayer.bbox_left,oPlayer.bbox_bottom) and !tilemap_get_at_pixel(global.tilemap64,oPlayer.bbox_right,oPlayer.bbox_bottom) and !tilemap_get_at_pixel(global.tilemap64,oPlayer.bbox_right,oPlayer.bbox_top) {
					if !place_meeting(oThrowedSword.x,oThrowedSword.y,class_enemy) {
						/*oPlayer.x = oThrowedSword.x;	
						oPlayer.y = oThrowedSword.y;*/
						oPlayer.alarm[7] = global.onesecond*.25;
						oPlayer.state = PLAYERSTATE.MOVE;
						
						
						instance_destroy();
					}
				} else {
					oPlayer.x = _oldx;	
					oPlayer.y =_oldy;
				}
			}
			/*with oThrowedSword {
				
			}*/
		}
	}


image_xscale = dir;

//Toggle visibility Check 1
if instance_exists(oSwing) or instance_exists(oThrowedSword) {
	visible = false;
} else {
	visible = true;
}


switch state {

	case SWORDSTATE.STANDING:
	x = oPlayer.x+64*-dir;
	image_angle = 180;
	
	if input.key_attack and alarm_get(0) <= 0 and swingCount <= 2 {
		state = SWORDSTATE.ATTACK;
		
		alarm_set(3,global.onesecond*.5);//Orbital Time Limit
		alarm_set(4,global.onesecond*.4);//Tap
		//Sword Block Max UpTime 
		//alarm_set(1,global.onesecond*1.5);
		//visible = false;
		
		var _swing = instance_create_depth(oPlayer.x,oPlayer.y,depth-1000,oSwing);
		_swing.creator = oPlayer.id;
		_swing.image_xscale = dir;
		_swing.visible = false;
		_swing.image_speed = 5;//taping_buffer;
		//SwordMove = 1;
		//image_angle = 90;
		//Snap to Enemy
		with oPlayer {
			var _en = instance_nearest(x,y,class_enemy);
			if distance_to_object(_en) <= 128 and distance_to_object(_en) > 96 and collision_line(x,y,_en.x,_en.y,_en,false,true) {
				if _en.x > oPlayer.x {
					other.distancetoEnemy = distance_to_object(_en)-64;
				} else {
					other.distancetoEnemy = distance_to_object(_en)+64;
				}
				other.directiontoEnemy = point_direction(x,y,_en.x,_en.y);
				if tilemap_get_at_pixel(global.tilemap,x+lengthdir_x(other.distancetoEnemy,other.directiontoEnemy),y+lengthdir_y(other.distancetoEnemy,other.directiontoEnemy)) == 0 and
					!place_meeting(x+lengthdir_x(other.distancetoEnemy,other.directiontoEnemy),y+lengthdir_y(other.distancetoEnemy,other.directiontoEnemy),class_solid)
				{
					x+=lengthdir_x(other.distancetoEnemy,other.directiontoEnemy);
					y+=lengthdir_y(other.distancetoEnemy,other.directiontoEnemy);
				}
				
			}
		}
	} else if input.key_attack_released and !instance_exists(oThrowedSword) and oPlayer.alarm[7] == -1 {
		
		
	}
	
	break;
	
	case SWORDSTATE.ATTACK:
	if !audio_is_playing(snSwordSwing) then audio_play_sound(snSwordSwing,3,false);
	
	Angle += Speed;
	if(Angle >= 360) Angle -= 360;
	
	// Update position
	var _player = instance_nearest(x,y,class_player);
	x = lengthdir_x(Orbit, Angle) + _player.x;
	y = lengthdir_y(Orbit, Angle) + _player.y;
	
	if !input.key_attack_held /*or alarm_get(1) == -1 */{
		state = SWORDSTATE.STANDING;
		sprite_index = sSword;
		image_angle = 0;
	} else {
		if !instance_exists(oSwing) {
			//visible = true;
			//x = oPlayer.x+64*dir;
		}
		sprite_index = sThrowedSword;
	}
	
	/*if input.key_attack_released and !instance_exists(oThrowedSword) and oPlayer.alarm[7] == -1 {
		SwordThrow();
	}*/
	if instance_exists(oThrowedSword) {
		sprite_index = sSword;
	} 
	image_angle = Angle;
	image_xscale = 1;
	
	if alarm_get(3) <= 0 {
		state = SWORDSTATE.STANDING;
		sprite_index = sSword;
		image_angle = 0;
	}
	break;
	
	case SWORDSTATE.DASH:
	visible = true;
	if oPlayer.dashtimer == 0 {
		state = SWORDSTATE.STANDING;
	}
	image_angle = 0;
	x = oPlayer.x+64*dir;
	break;
	
	case SWORDSTATE.SLAM:
	//visible = false;
	if oPlayer.sprite_index != sPlayer_Slam {
		state = SWORDSTATE.STANDING;
	}
	image_angle = 90;
	x += oPlayer.x;
	
	y+= 32;
	y = clamp(y,oPlayer.y-16,oPlayer.y+16);
	break;
	
}

if alarm_get(4) > 0 and input.key_attack_released and !instance_exists(oThrowedSword) and oPlayer.alarm[7] == -1 and oPlayer.energy >= COST.THROW {
	SwordThrow();
}

//Toggle visibility Check 2
if instance_exists(oSwing) or instance_exists(oThrowedSword)  {
	visible = false;
} else {
	visible = true;
}


////////Dash dmg

if oPlayer.sprite_index == sPlayer_Dash {
	
	if instance_exists(class_enemy) {
		if place_meeting(x+oPlayer.hsp,y,class_enemy) {
		
			var _en = instance_nearest(x,y,class_enemy);
			if x < _en.x {
				oPlayer.x -= oPlayer.hsp_max*2;
			} else {
				oPlayer.x += oPlayer.hsp_max*2;
			}
			oPlayer.hsp = 0;
			oPlayer.dashtimer = 0;
			with _en {
				if hp <= 0 then exit;

				hp-= SLASH_SLAM_DMG;
				
				if hp <= 0 { 
					state = ENEMYSTATE.DEATH;
					//alarm_set(0,global.onesecond*10);
				}
			}
		}
	}
	
	if instance_exists(oDestructable) {
		if place_meeting(x+oPlayer.hsp,y,oDestructable) {
		
			var _en = instance_nearest(x,y,oDestructable);
			if x < _en.x {
				oPlayer.x -= oPlayer.hsp_max*2;
			} else {
				oPlayer.x += oPlayer.hsp_max*2;
			}
			oPlayer.hsp = 0;
			oPlayer.dashtimer = 0;
			with _en {
				if hp <= 0 then exit;

				hp-= SLASH_SLAM_DMG;
				
				
			}
		}
	}

}

////////// Slam dmg

with oPlayer {
	if sprite_index == sPlayer_Slam {	
		if place_meeting(x,y+vsp_max*2,class_enemy) {
			var _en = instance_nearest(x,y,class_enemy);
			//y -= vsp_max*2;
			jumps -= 1;
			jumpbuffer = 0;
			vsp = -vsp_jump;
			vsp_fraction = 0;
			hsp = 0;
			dashtimer = 0;
			sprite_index = sPlayer_F;
			alarm_set(8,global.onesecond*1);
			with _en {
			
				if hp <= 0 then exit;

				hp-= SLASH_SLAM_DMG;
				
				if hp <= 0 { 
					state = ENEMYSTATE.DEATH;
					//alarm_set(0,global.onesecond*10);
				}
			}
		}
		if place_meeting(x,y+vsp_max*2,oDestructable) {
			var _en = instance_nearest(x,y,oDestructable);
			//y -= vsp_max*2;
			jumps -= 1;
			jumpbuffer = 0;
			vsp = -vsp_jump;
			vsp_fraction = 0;
			hsp = 0;
			dashtimer = 0;
			sprite_index = sPlayer_F;
			alarm_set(8,global.onesecond*1);
			with _en {
			
				if hp <= 0 then exit;

				hp-= SLASH_SLAM_DMG;
				
				
			}
		}
	}
}

if oPlayer.sprite_index == sPlayer_Slam {
	visible = false;
} 