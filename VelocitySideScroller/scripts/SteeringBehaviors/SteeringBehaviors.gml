// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sb_seek(x,y,_weight) {
	var _target = vect2(x, y);
	// subtract current position from target position and constrain to max_speed
	var _desired_velocity = vect_scaler(vect_subtract(_target,position),max_speed);

	return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));
}

function sb_seek_arrive(x,y,_slow_radius,_weight) {

	var _target = vect2(x, y);
	// subtract current position from target position and constrain to max_speed
	//var _desired_velocity = vect_scaler(vect_subtract(_target,position),max_speed);
	var _desired_velocity = vect_subtract(_target,position);
	var _distance = vect_len(_desired_velocity);

	if(_distance < _slow_radius) { //Inside slowing radius
	    _desired_velocity = vect_multr(vect_norm(_desired_velocity), max_speed * (_distance / _slow_radius));
	} else { // Outside slowing radius
	    _desired_velocity = vect_multr(vect_norm(_desired_velocity), max_speed);
	}

	return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));
}

function sb_flee(x,y,_weight) {

	var _target = vect2(x, y);
	// subtract target position from current position and constrain to max_speed
	var _desired_velocity = vect_scaler(vect_subtract(position,_target),max_speed);

	return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));
}

function sb_pursuit(_target_obj,_weight) {
	if(instance_exists(_target_obj)) { // Target exists
	    // var _time = 10; // basic
	    var _time = vect_dist(position, _target_obj.position) / _target_obj.max_speed; // dynamic
	    var _target_future_pos = vect_add(_target_obj.position, vect_multr(_target_obj.velocity, _time));
    
    
	    // subtract current position from target position and constrain to max_speed
	    var _desired_velocity = vect_scaler(vect_subtract(_target_future_pos,position),max_speed);
    
	    return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));

	} else { // No target
	    return vect2(0,0);
	}
}


function sb_evade(_target_obj,_weight) {
	if(instance_exists(_target_obj)) { // Target exists
	    // var _time = 10; // basic
	    var _time = vect_dist(position, _target_obj.position) / _target_obj.max_speed; // dynamic
	    var _target_future_pos = vect_add(_target_obj.position, vect_multr(_target_obj.velocity, _time));
    
    
	    // subtract current position from target position and constrain to max_speed
	    var _desired_velocity = vect_scaler(vect_subtract(position,_target_future_pos),max_speed);
    
	    return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));

	} else { // No target
	    return vect2(0,0);
	}
}

function sb_wander(_circle_distance,_circle_radius,wander_angle,_weight ) {

	var _wander_angle = wander_angle/2;
	// Use velocity vector to place circle
	var _circle_center = vect_multr(vect_norm(velocity), _circle_distance);

	var _displacement = vect2(0, -1);
	_displacement = vect_multr(_displacement, _circle_radius);

	//Set the angle
	var _displacement_length = vect_len(_displacement);
	var _random_angle = random_range(-_wander_angle, _wander_angle);
	_displacement[1] = cos(_random_angle) * _displacement_length;
	_displacement[2] = sin(_random_angle) * _displacement_length;

	var _target_position = vect_add(position,vect_add(_circle_center, _displacement));


	// Set velocity
	var _desired_velocity = vect_scaler(vect_subtract(_target_position,position),max_speed);

	return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));

}

function sb_avoid_collision(_avoid_obj,_see_ahead_distance,_max_avoidance_force,_weight) {

	//Note that this steering behaviour will try to avoid the given object, 
	//but in no way will it actually prevent it from moving inside said object, 
	//for example if the weighting of other steering behaviours overpowers this one. 
	//Please see the solid_obj variable in obj_drone_flock_grid2 if you need that functionality.

	//Actual XY position at end of line _see_ahead_distance length away from current position
	var _see_ahead = vect_add(position, vect_multr(vect_norm(velocity), _see_ahead_distance));
	//Find oject to avoid at this point
	var _nearest_obj = collision_line_first(position[1], position[2],
	                                        _see_ahead[1], _see_ahead[2],
	                                        _avoid_obj,
	                                        true,
	                                        true);

	if(_nearest_obj != noone) { //Object found
	    //Move away from object
	    var _avoidance_force = vect_subtract(_see_ahead, _nearest_obj.position);
	    _avoidance_force = vect_norm(_avoidance_force);
	    _avoidance_force = vect_multr(_avoidance_force, _max_avoidance_force);
    
	    return vect_multr(_avoidance_force, _weight);
	} else {
	    return vect2(0,0);
	}
                                    
}

function sb_path_loop(_path,_max_distance,_dir,_weight) {
	var _target_x = path_get_point_x(_path, my_path_point);
	var _target_y = path_get_point_y(_path, my_path_point);
	var _target = vect2(_target_x, _target_y);

	var _distance_to_point = vect_len(vect_subtract(_target,position));

	if(_distance_to_point < _max_distance) { //point reached
	    my_path_point += sign(_dir);
	    if(my_path_point > path_get_number(_path)-1) { my_path_point = 0; }
	    if(my_path_point < 0) { my_path_point = path_get_number(_path)-1; }
	} 

	// subtract current position from target position and constrain to max_speed
	var _desired_velocity = vect_scaler(vect_subtract(_target,position),max_speed);

	return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));
}

function sb_path_tofro(_path,_max_distance,_dir,_weight) {
	var _target_x = path_get_point_x(_path, my_path_point);
	var _target_y = path_get_point_y(_path, my_path_point);
	var _target = vect2(_target_x, _target_y);

	var _distance_to_point = vect_len(vect_subtract(_target,position));

	if(_distance_to_point < _max_distance) {
	    my_path_point += sign(_dir);
	    if(my_path_point > path_get_number(_path)-1) { my_path_point -= 2; my_path_dir *= -1;}
	    if(my_path_point < 0) { my_path_point += 2; my_path_dir *= -1;}
	} 

	// subtract current position from target position and constrain to max_speed
	var _desired_velocity = vect_scaler(vect_subtract(_target,position),max_speed);

	return (vect_multr(vect_subtract(_desired_velocity,velocity),_weight));
}


function sb_alignment(_align_obj,_align_radius,_weight) {

	var _neighbour_list = collision_circle_list_sb(position[1], position[2], _align_radius, _align_obj, false, true);

	if(_neighbour_list != noone) { // Has neighbours
	    var _neighbour_num = ds_list_size(_neighbour_list);
	    var _aligned_velocity = vect2(0,0);
    
	    for(i=0; i<_neighbour_num; i++) {
	        _aligned_velocity =vect_add(_aligned_velocity, _neighbour_list[|i].velocity);
	    }
	    //Testing adding own velocity
	    _neighbour_num++;
	    _aligned_velocity = vect_add(_aligned_velocity, velocity);
	    //End testing
    
	    _aligned_velocity = vect_divr(_aligned_velocity, _neighbour_num);

	    //destroy temp ds_list
	    ds_list_destroy(_neighbour_list);
    
	    //return aligned velocity
	    //return (vect_multr(vect_subtract(_aligned_velocity,velocity),_weight));
	    return (vect_multr(vect_norm(_aligned_velocity),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}
}

function sb_cohesion(_sep_obj , _sep_radius, _weight) {

	var _neighbour_list = collision_circle_list_sb(position[1], position[2], _sep_radius, _sep_obj, false, true);

	if(_neighbour_list != noone) { // Has neighbours
	    var _neighbour_num = ds_list_size(_neighbour_list);
	    var _aligned_position = vect2(0,0);
    
	    for(i=0; i<_neighbour_num; i++) {
	        _aligned_position = vect_add(_aligned_position, _neighbour_list[|i].position);
	    }

	    _aligned_position = vect_divr(_aligned_position, _neighbour_num);

	    //destroy temp ds_list
	    ds_list_destroy(_neighbour_list);
    
	    //return aligned velocity
	    return (vect_multr(vect_norm(vect_subtract(_aligned_position,position)),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}

}

function sb_separation(_sep_obj,_sep_radius,_weight) {
	var _neighbour_list = collision_circle_list_sb(position[1], position[2], _sep_radius, _sep_obj, false, true);

	if(_neighbour_list != noone) { // Has neighbours
	    var _neighbour_num = ds_list_size(_neighbour_list);
	    var _aligned_position = vect2(0,0);
    
	    for(i=0; i<_neighbour_num; i++) {
	        _aligned_position = vect_add(_aligned_position, _neighbour_list[|i].position);
	    }
    
	    _aligned_position = vect_divr(_aligned_position, _neighbour_num);

	    //destroy temp ds_list
	    ds_list_destroy(_neighbour_list);
    
	    //return aligned velocity
	    return (vect_multr(vect_norm(vect_subtract(position,_aligned_position)),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}
}

function sb_alignment_grid(_align_radius, _sb_grid_controller, _weight) {
	//Find total number of neighbours in a given radius
	var _neighbours = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius);

	if(_neighbours > 1) { // Has neighbours
	    var _aligned_velocity = vect2(0,0);
    
	    //Add all velocities together
	    _aligned_velocity[@1] = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_velocity_x,x div sb_cell_size,y div sb_cell_size,_align_radius);
	    _aligned_velocity[@2] = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_velocity_y,x div sb_cell_size,y div sb_cell_size,_align_radius);
    
    
	    //return aligned velocity
	    return (vect_multr(vect_norm(_aligned_velocity),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}
}

function sb_cohesion_grid(_align_radius, _sb_grid_controller, _weight) {

	//sb_cohesion_grid2 achieves more or less the same effect, 
	//although uses a different approach. Both steering behaviours use the same arguments.
	//Find total number of neighbours in given radius
	var _neighbours = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius);

	if(_neighbours > 1) { // Has neighbours
	    //Position to move towards
	    var _aligned_position = vect2(0,0);

	    //Divide XY positions by number of neighbours
	    _aligned_position[1] = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_center_x,x div sb_cell_size,y div sb_cell_size,_align_radius)/_neighbours;
	    _aligned_position[2] = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_center_y,x div sb_cell_size,y div sb_cell_size,_align_radius)/_neighbours;
    
	    //return aligned velocity
	    return (vect_multr(vect_norm(vect_subtract(_aligned_position,position)),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}

}

function sb_cohesion_grid2(_align_radius,_sb_grid_controller,_weight) {

	//Alternate methodolgy of cohesion compared to sb_cohesion_grid.
	//Both use same arguments and seem to have similar CPU usage.
	//Basic idea is find the cell with the most entities in a given radius 
	//and move towards the centre of mass of that cell.
	//get the maximum value for entities per cell in the given radius
	var _neighbour_cell = ds_grid_get_disk_max(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius);

	if(_neighbour_cell > 1) { // Has neighbours
	    //Find which cell actually has the maximum
	    var _neighbour_cell_x = ds_grid_value_disk_x(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius,_neighbour_cell);
	    var _neighbour_cell_y = ds_grid_value_disk_y(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius,_neighbour_cell);
	    //Get centre of mass (based on average XY values of entities)
	    var _mass_x = _sb_grid_controller.sb_grid_center_x[#_neighbour_cell_x,_neighbour_cell_y]/_sb_grid_controller.sb_grid_count[#_neighbour_cell_x,_neighbour_cell_y];
	    var _mass_y = _sb_grid_controller.sb_grid_center_y[#_neighbour_cell_x,_neighbour_cell_y]/_sb_grid_controller.sb_grid_count[#_neighbour_cell_x,_neighbour_cell_y];
    
	    //Generate position to move towards
	    var _aligned_position = vect2(_mass_x,_mass_y);

	    //return aligned velocity
	    return (vect_multr(vect_norm(vect_subtract(_aligned_position,position)),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}

}

function sb_separation_grid(_align_radius,_sb_grid_controller,_weight) {

	//sb_separation_grid2 works a lot better. 
	//I consider this version to be buggy but I have left it in for people to mess with.
	//Both steering behaviours use the same arguments and use similar amounts of CPU.
	//Get total number of neighbours
	var _neighbours = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius);

	if(_neighbours > 1) { // Has neighbours
	    var _aligned_position = vect2(0,0);
    
	    //Add all XY values together and divide by number of neighbours
	    _aligned_position[1] = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_center_x,x div sb_cell_size,y div sb_cell_size,_align_radius)/_neighbours;
	    _aligned_position[2] = ds_grid_get_disk_sum(_sb_grid_controller.sb_grid_center_y,x div sb_cell_size,y div sb_cell_size,_align_radius/_neighbours);

    
	    //return aligned velocity
	    return (vect_multr(vect_norm(vect_subtract(position,_aligned_position)),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}

}

function sb_separation_grid2(_align_radius, _sb_grid_controller, _weight) {

	//This is a much improved version of sb_separation_grid.
	//Both steering behaviours use the same arguments and use similar amounts of CPU.

	//This is essentially the opposite of sb_cohesion_grid2
	//It finds the cell with the most entities, gets the centre of mass,
	//then moves away from it instead of towards it.
	//Find value of cell with most entities in given radius
	var _neighbour_cell = ds_grid_get_disk_max(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius);

	if(_neighbour_cell > 1) { // Has neighbours
	    //Find the actual cell with said number of entities
	    var _neighbour_cell_x = ds_grid_value_disk_x(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius,_neighbour_cell);
	    var _neighbour_cell_y = ds_grid_value_disk_y(_sb_grid_controller.sb_grid_count,x div sb_cell_size,y div sb_cell_size,_align_radius,_neighbour_cell);
	    //Find centre of mass within said cell
	    var _mass_x = _sb_grid_controller.sb_grid_center_x[#_neighbour_cell_x,_neighbour_cell_y]/_sb_grid_controller.sb_grid_count[#_neighbour_cell_x,_neighbour_cell_y];
	    var _mass_y = _sb_grid_controller.sb_grid_center_y[#_neighbour_cell_x,_neighbour_cell_y]/_sb_grid_controller.sb_grid_count[#_neighbour_cell_x,_neighbour_cell_y];
    
	    var _aligned_position = vect2(_mass_x,_mass_y);
    
	    //return aligned velocity
	    return (vect_multr(vect_norm(vect_subtract(position,_aligned_position)),_weight));
	} else { // No neighbours
	    return vect2(0,0);
	}
}

function scr_grid_reset(sb_cell_size) {
	//This script can be used by the steering behaviour grid controller (cont_steering).
	//It recreates the ds_grids used for flocking with the specified cell size.
	//After the ds_grids are recreated it tells all the drones to use the new cell size.
	//If the drones are created after this script is run, that step would be unnecessary, 
	//but I left it in for completeness.
	//
	//This script is in no way necessary to use.
	//You can specify the cell size in cont_steering itself (default is 16x16)
	//and everything will work. I made this mostly for demo purposes.

	//Create list of grids to be used
	var grid_list;
	grid_list[0] = sb_grid_count;
	grid_list[1] = sb_grid_velocity_x;
	grid_list[2] = sb_grid_velocity_y;
	grid_list[3] = sb_grid_center_x;
	grid_list[4] = sb_grid_center_y;
	grid_list[5] = sb_grid_ids;

	//Destroy them if they exist (to prevent memory leaks)
	for(i=0; i<array_length_1d(grid_list)-1; i++) {
	    if(ds_exists(grid_list[i], ds_type_grid)) {
	        ds_grid_destroy(grid_list[i]);
	    }
	}

	//Width and Height in pixels of grid squares used for Steering Behaviours.
	//Lower numbers results in a finer grid, but uses more CPU
	//Generate the grid size based on the sb_cell_size fit to fill the entire room
	grid_width = (room_width div sb_cell_size)+1;
	grid_height = (room_height div sb_cell_size)+1;

	//Generate grids
	sb_grid_count = ds_grid_create(grid_width, grid_height); //Used to store the number of entities per square
	sb_grid_velocity_x = ds_grid_create(grid_width, grid_height); //Stores X velocities
	sb_grid_velocity_y = ds_grid_create(grid_width, grid_height); //Stores Y velocities
	sb_grid_center_x = ds_grid_create(grid_width, grid_height); //Stores X positions
	sb_grid_center_y = ds_grid_create(grid_width, grid_height); //Stores Y positions
	sb_grid_ids = ds_grid_create(grid_width, grid_height); //Stores unique IDs of objects

	//Make sure grids are empty
	ds_grid_clear(sb_grid_count, 0);
	ds_grid_clear(sb_grid_velocity_x, 0);
	ds_grid_clear(sb_grid_velocity_y, 0);
	ds_grid_clear(sb_grid_center_x, 0);
	ds_grid_clear(sb_grid_center_y, 0);
	ds_grid_clear(sb_grid_ids, 0);

	//Update drones to use new cell size.
	//If you intend on using multiple grid controllers you will need to modify this.
	//This is intentionally simple for demo purposes.
	if(instance_exists(par_drone)) {
	    with(par_drone) {
	        sb_cell_size = other.sb_cell_size;
	    }
	}
}

function collision_circle_list_sb(x1, y1, radius, obj, prec, notme) {
	//
	//  Returns a list data structure populated with the ids of instances 
	//  colliding with a given circle, or noone if no instances found.
	//
	//      x1,y1       center of the collision circle (filled), real
	//      radius      radius of the collision circle (filled), real
	//      obj         object to check for collision (or all), real
	//      prec        true for precise collision checking, bool
	//      notme       true to ignore the calling instance, bool
	//
	/// GMLscripts.com/license
	{
	    var dsid,i;
	    
	    dsid = ds_list_create();
	    with (obj) {
	        if (!notme || id != other.id) {
	            i = collision_circle(x1,y1,radius,id,prec,false);
	            if (i != noone) ds_list_add(dsid,i);
	        }
	    }
	    if (ds_list_empty(dsid)) {
	        ds_list_destroy(dsid);
	        dsid = noone;
	    }
	    return dsid;
	}
}

function collision_line_first(ox, oy, dx, dy, object, prec, notme) {
	//
	//  Returns the instance id of an object colliding with a given line and
	//  closest to the first point, or noone if no instance found.
	//  The solution is found in log2(range) collision checks.
	//
	//      x1,y2       first point on collision line, real
	//      x2,y2       second point on collision line, real
	//      object      which objects to look for (or all), real
	//      prec        if true, use precise collision checking, bool
	//      notme       if true, ignore the calling instance, bool
	//
	{
	    var sx,sy,inst,i;
	  
	    sx = dx - ox;
	    sy = dy - oy;
	    inst = collision_line(ox,oy,dx,dy,object,prec,notme);
	    if (inst != noone) {
	        while ((abs(sx) >= 1) || (abs(sy) >= 1)) {
	            sx /= 2;
	            sy /= 2;
	            i = collision_line(ox,oy,dx,dy,object,prec,notme);
	            if (i) {
	                dx -= sx;
	                dy -= sy;
	                inst = i;
	            }else{
	                dx += sx;
	                dy += sy;
	            }
	        }
	    }
	    return inst;
	}
}