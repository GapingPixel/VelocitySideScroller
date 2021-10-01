/// @description Insert description here
// You can write your code in this editor
/*Angle += Speed;
if(Angle >= 360) Angle -= 360;*/
	
// Update position
var _player = instance_nearest(x,y,class_player);
x = lengthdir_x(Orbit, Angle) + _player.x;
y = lengthdir_y(Orbit, Angle) + _player.y;


Center_X = oPlayer.x; // x of orbital center
Center_Y = oPlayer.y; // y of orbital center
area.x = oPlayer.x; 
area.y = oPlayer.y; 


if input.key_up_held and input.key_left {
	Angle = 135;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_up_held and  input.key_right  {
	Angle = 45;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_down_held and  input.key_right  {
	Angle = 315;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_down_held and  input.key_left  {
	Angle = 225;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_down_held {
	Angle = 270;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_up_held {
	Angle = 90;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_right {
	Angle = 0;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else if input.key_left {
	Angle = 180;
	image_angle = Angle;
	area.image_angle = image_angle; 
} else {
	if oPlayer.hsp_dir == 1 {
		Angle = 0;
		image_angle = Angle;
		area.image_angle = image_angle; 
	} else {
		Angle = 180;
		image_angle = Angle;
		area.image_angle = image_angle; 
	}
	
}

if !instance_exists(class_enemy) then exit;

with area {

	var _en = instance_nearest(x,y,class_enemy);

	if place_meeting(x,y,_en) {
		_en.outline = true;
	} else {
		_en.outline = false;
	}

}