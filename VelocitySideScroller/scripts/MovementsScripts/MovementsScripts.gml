// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function apply_friction_to_movement_entity() {
	gml_pragma("forceinline");
	speed_ = approach(speed_, 0, friction_);
}

function move_movement_lifeform(_bounce) {
	// Apply friction when sliding on walls
	var bounce_amount_ = .5;
	var collision_object_ = class_solid;
	if place_meeting(x+lengthdir_x(speed_, direction_), y+lengthdir_y(speed_, direction_), collision_object_) and !_bounce {
		apply_friction_to_movement_entity();
	}
	var _x_speed = lengthdir_x(speed_, direction_);
	var _y_speed = lengthdir_y(speed_, direction_);
	//if speed_ <= 0 exit; // No need to check for collisions
	if place_meeting(x+_x_speed, y, collision_object_) {
		while !place_meeting(x+sign(_x_speed), y, collision_object_) {
			x += sign(_x_speed);
		}
		if _bounce {
			_x_speed = -(_x_speed)*bounce_amount_;
		} else {
			_x_speed = 0;
		}
	}
	if tilemap_get_at_pixel(global.tilemap,x+_x_speed, y) or tilemap_get_at_pixel(global.tilemap64,x+_x_speed, y) {
		while !tilemap_get_at_pixel(global.tilemap,x+sign(_x_speed), y) and !tilemap_get_at_pixel(global.tilemap64,x+sign(_x_speed), y) {
			x += sign(_x_speed);
		}
		if _bounce {
			_x_speed = -(_x_speed)*bounce_amount_;
		} else {
			_x_speed = 0;
		}
	}
	x += _x_speed;
	
	if place_meeting(x, y+_y_speed, collision_object_) {
		while !place_meeting(x, y+sign(_y_speed), collision_object_) {
			y += sign(_y_speed);
		}
		if _bounce {
			_y_speed = -(_y_speed)*bounce_amount_;
		} else {
			_y_speed = 0;
		}
	
	}
	if tilemap_get_at_pixel(global.tilemap,x, y+_y_speed) and tilemap_get_at_pixel(global.tilemap64,x, y+_y_speed) {
		while !tilemap_get_at_pixel(global.tilemap,x, y+sign(_y_speed)) and !tilemap_get_at_pixel(global.tilemap64,x, y+sign(_y_speed)) {
			y += sign(_y_speed);
		}
		if _bounce {
			_y_speed = -(_y_speed)*bounce_amount_;
		} else {
			_y_speed = 0;
		}
	
	}
	y += _y_speed;
	
	speed_ = point_distance(0, 0, _x_speed, _y_speed);
	direction_ = point_direction(0, 0, _x_speed, _y_speed);
}


function add_movement_maxspeed(_direction, _acceleration, _max_speed ) {
	var _x_speed = lengthdir_x(speed_, direction_);
	var _y_speed = lengthdir_y(speed_, direction_);

	var _x_acceleration = lengthdir_x(_acceleration, _direction);
	var _y_acceleration = lengthdir_y(_acceleration, _direction);

	_x_speed += _x_acceleration;
	_y_speed += _y_acceleration;

	speed_ = point_distance(0, 0, _x_speed, _y_speed);
	direction_ = point_direction(0, 0, _x_speed, _y_speed);
	speed_ = min(speed_, _max_speed);

}
