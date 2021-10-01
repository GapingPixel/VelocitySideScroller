/// @description Insert description here
// You can write your code in this editor
mp_grid_add_instances(pathfGrid,oAirDrone,false);
if state == ENEMYSTATE.MOVE {
	//point_distance(x,y,bbox_left,bbox_top) 
	mp_grid_move(oPlayer.x,oPlayer.y);
} else if state == ENEMYSTATE.FLEE {
	mp_grid_move(xstart,ystart);
} else {
	//path_end();	
}