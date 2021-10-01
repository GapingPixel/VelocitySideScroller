/// @description Insert description here
// You can write your code in this editor
//alarm_set(0,global.onesecond*2);
event_inherited();
hp = 6;
state = ENEMYSTATE.IDLE;

area = instance_create_depth(x,y,depth,oAreaHalf);
area.image_xscale = image_xscale;

function turret_shoot() {
	with area {
		if place_meeting(x,y,oPlayer) and other.alarm[0] == -1 {
			other.alarm[0] = global.onesecond*.15;
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