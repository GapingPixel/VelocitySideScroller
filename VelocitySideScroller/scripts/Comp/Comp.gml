// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @description Creates an instance of a given object at a given position.
/// @param x The x position the object will be created at.
/// @param y The y position the object will be created at.
/// @param obj The object to create an instance of.
function instance_create(argument0, argument1, argument2) {
	var myDepth = object_get_depth( argument2 );
	return instance_create_depth( argument0, argument1, myDepth, argument2 );

}

/// @description Returns the depth of the specified object.
/// @param {Number} obj The index of the object to check
/// @return {Number} depth of the object
function object_get_depth(argument0) {

	var objID = argument0;
	var ret = 0;
	if (objID >= 0) && (objID < array_length_1d(global.__objectID2Depth)) {
		ret = global.__objectID2Depth[objID];
	} // end if
	return ret;


}


function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 0; // par_drone
	global.__objectDepths[1] = 0; // obj_drone_basic
	global.__objectDepths[2] = 0; // obj_drone_flock_grid
	global.__objectDepths[3] = 0; // obj_drone_flock_grid_solid_aware
	global.__objectDepths[4] = 0; // obj_drone_flock_grid_solid_aware_counter
	global.__objectDepths[5] = 0; // obj_drone_flock_grid_solid_flee
	global.__objectDepths[6] = 0; // par_obstacle
	global.__objectDepths[7] = 0; // obj_obstacle_circle
	global.__objectDepths[8] = 0; // obj_obstacle_square
	global.__objectDepths[9] = 0; // par_solid
	global.__objectDepths[10] = 0; // obj_solid_circle
	global.__objectDepths[11] = 0; // obj_solid_square
	global.__objectDepths[12] = 0; // cont_debug
	global.__objectDepths[13] = 0; // cont_steering
	global.__objectDepths[14] = 0; // demo_drone_basic
	global.__objectDepths[15] = 0; // demo_drone_path
	global.__objectDepths[16] = 0; // demo_drone_flock
	global.__objectDepths[17] = 0; // demo_drone_flock_grid
	global.__objectDepths[18] = 0; // demo_drone_flock_grid_solid
	global.__objectDepths[19] = 0; // demo_drone_flock_grid_solid_counter
	global.__objectDepths[20] = 0; // demo_drone_solid_flee
	global.__objectDepths[21] = 0; // demo_drone_chaser
	global.__objectDepths[22] = 0; // demo_drone_chasee
	global.__objectDepths[23] = 0; // demo_grid_resize


	global.__objectNames[0] = "par_drone";
	global.__objectNames[1] = "obj_drone_basic";
	global.__objectNames[2] = "obj_drone_flock_grid";
	global.__objectNames[3] = "obj_drone_flock_grid_solid_aware";
	global.__objectNames[4] = "obj_drone_flock_grid_solid_aware_counter";
	global.__objectNames[5] = "obj_drone_flock_grid_solid_flee";
	global.__objectNames[6] = "par_obstacle";
	global.__objectNames[7] = "obj_obstacle_circle";
	global.__objectNames[8] = "obj_obstacle_square";
	global.__objectNames[9] = "par_solid";
	global.__objectNames[10] = "obj_solid_circle";
	global.__objectNames[11] = "obj_solid_square";
	global.__objectNames[12] = "cont_debug";
	global.__objectNames[13] = "cont_steering";
	global.__objectNames[14] = "demo_drone_basic";
	global.__objectNames[15] = "demo_drone_path";
	global.__objectNames[16] = "demo_drone_flock";
	global.__objectNames[17] = "demo_drone_flock_grid";
	global.__objectNames[18] = "demo_drone_flock_grid_solid";
	global.__objectNames[19] = "demo_drone_flock_grid_solid_counter";
	global.__objectNames[20] = "demo_drone_solid_flee";
	global.__objectNames[21] = "demo_drone_chaser";
	global.__objectNames[22] = "demo_drone_chasee";
	global.__objectNames[23] = "demo_grid_resize";


	// create another array that has the correct entries
	var len = array_length_1d(global.__objectDepths);
	global.__objectID2Depth = [];
	for( var i=0; i<len; ++i ) {
		var objID = asset_get_index( global.__objectNames[i] );
		if (objID >= 0) {
			global.__objectID2Depth[ objID ] = global.__objectDepths[i];
		} // end if
	} // end for


}