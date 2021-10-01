/// @description Insert description here
// You can write your code in this editor
event_inherited();
area = instance_create_depth(x,y,depth+1,oAirDroneArea);
coll_box = instance_create_depth(x,y,depth+1,oAirDroneCollBox);


maxhp = 1;
hp = maxhp;
state = ENEMYSTATE.MOVE;


pathfGrid = mp_grid_create(0, 0, room_width/64, room_height/64, 64, 64);
//pathfGrid = ds_grid_create(room_width,room_height);
for (var _x = 0; _x <= room_width; _x+=64) {
	for (var _y = 0; _y <= room_height; _y+=64) {
		if tilemap_get_at_pixel(global.tilemap,_x ,_y ) {
			mp_grid_add_cell(pathfGrid,floor(_x/64),floor(_y/64));
		} else if tilemap_get_at_pixel(global.tilemap64,_x ,_y) {
			mp_grid_add_cell(pathfGrid,floor(_x/64),floor(_y/64));
		} 
	}
}
mp_grid_add_instances(pathfGrid,oAirDrone,false);

//mp_grid_add_instances(pathfGrid,class_enemy,false);
//mp_grid_add_cell(pathfGrid,floor(x/64),floor(y/64));

path = path_add();

target_x = noone; 
target_y = noone; 

attack_direction = noone;

