/// @description Insert description here
// You can write your code in this editor

turret_shoot();
/*if collision_line(x,y,x+1600*image_xscale,y,oPlayer,false,true) and alarm_get(0) <=0 and alarm_get(1) <=0 {
	alarm_set(0,global.onesecond*2);

	var _bull = instance_create_depth(x+ (128*image_xscale),y,depth,oBullet);
	_bull.speed = 32*image_xscale;
	_bull.alarm[0] = global.onesecond*2;
	_bull.dmg = 1;
}*/

switch state {

	case ENEMYSTATE.DEATH:
	instance_destroy(id,true);
	break;

}