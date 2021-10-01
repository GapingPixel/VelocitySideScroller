/// @description Insert description here
// You can write your code in this editor
event_inherited();

area = instance_create_depth(x,y,depth,oArea);

//image_xscale = 1;

state = ENEMYSTATE.IDLE;
maxhp = 3;
hp = maxhp;
hsp = 4;
//dir = ANG_RIGHT;
dir = DIR_RIGHT;

stuck = false;


function ground_drone_shoot() {
	with area {
		if place_meeting(x,y,oPlayer) and other.alarm[0] == -1 {
			other.alarm[0] = global.onesecond*0.15;
			var dir = point_direction(x,y,oPlayer.x,oPlayer.y);
			var _distance = 125;
			var _bull = instance_create_depth(x+lengthdir_x(_distance,dir), y+lengthdir_y(_distance,dir), depth-1, oBullet);
			_bull.speed = 32;
			_bull.direction = dir;
			_bull.image_angle = dir;
			_bull.alarm[0] = global.onesecond*2;
			_bull.dmg = 1;
			audio_play_sound(snShot,2, false);
			other.state = ENEMYSTATE.IDLE;
		}
	}
}
	
	/*if collision_line( x,y, lengthdir_x(x+1600*image_xscale,0), lengthdir_y(y+1600*image_xscale,0,oPlayer,false,true) ) and alarm_get(0) == -1 {
	//if collision_line(x,y,x+1600*image_xscale,y,oPlayer,false,true) and alarm_get(0) == -1 {
		alarm_set(0,global.onesecond*.025);
		
		var _bull = instance_create_depth( x + (150*dir), y, depth, oBullet);
		_bull.speed = 32*dir;
		_bull.alarm[0] = global.onesecond*2;
		_bull.dmg = 1;
		
		state = ENEMYSTATE.IDLE;
	}*/
