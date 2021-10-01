global.room_info = @"rm_test_basic, 
uses drones based on obj_drone_basic (demo_drone_basic).

Steering Behaviours:
sb_seek_arrive";
//instance_create(0,0,cont_steering);


//instance_create(100,100,oDroneSB);
/*
for (var _x = 0; _x <= room_width; _x+=64) {
		for (var _y = 0; _y <= room_height; _y+=64) {
			if tilemap_get_at_pixel(global.tilemap,_x ,_y ) {
				instance_create_layer(floor(_x/64),floor(_y/64),"Solid",oSolidStatic);
				//mp_grid_add_cell(pathfGrid,floor(_x/64),floor(_y/64));
			} else if tilemap_get_at_pixel(global.tilemap64,_x ,_y) {
				instance_create_layer(floor(_x/64),floor(_y/64),"Solid",oSolidStatic);
				//mp_grid_add_cell(pathfGrid,floor(_x/64),floor(_y/64));
			} 
		}
	}