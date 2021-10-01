/// @description Insert description here
// You can write your code in this editor
if place_meeting(x,y+1,oSolid) {
	var _sld = instance_nearest(x,y,oSolid);
	x+=_sld.spd;
}

if place_meeting(x+1,y,oEnemy) or place_meeting(x-1,y,oEnemy) or place_meeting(x,y+1,oEnemy) {
	if hp <= 0 or state == PLAYERSTATE.HIT then exit;

	hp-= 1;

	state = PLAYERSTATE.HIT;
	alarm_set(11,global.onesecond*.25);
	var _en = instance_nearest(x,y,oEnemy);
	
	if _en.x < x {
		knockback_dir = DIR_RIGHT;
	} else {
		knockback_dir = DIR_LEFT;
	}
	
	
	if hp <= 0 { 
		state = PLAYERSTATE.DEATH;
		alarm_set(0,global.onesecond*10);
	}

}
/*
if alarm_get(11) > 0 {
	
}