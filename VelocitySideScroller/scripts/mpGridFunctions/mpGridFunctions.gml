function mp_grid_move(_x,_y){
	target_x = _x;
	target_y = _y;
	
	mp_grid_path(pathfGrid,path,x,y,target_x,target_y,true);
	
	
	path_start(path, 20, path_action_stop,true);
	
}