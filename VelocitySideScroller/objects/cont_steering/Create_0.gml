/// @description Initialise Variables

//Width and Height in pixels of grid squares used for Steering Behaviours.
//Lower numbers results in a finer grid, but uses more CPU
sb_cell_size = 64; 
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

depth = -100; //Probably completely unnecessary now
