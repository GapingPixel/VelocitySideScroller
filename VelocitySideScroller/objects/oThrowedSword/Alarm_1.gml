/// @description Set Trajectory
// You can write your code in this editor
target = instance_nearest(x,y,class_enemy);

dis = distance_to_object(target);



while !place_meeting(x+lengthdir_x(dis,direction),y+lengthdir_y(dis,direction),class_enemy) {
	direction--;
	dir_count++;
	/*if dir_count >= 45 {
		exit;
	}*/
}