/// @description Insert description here
// You can write your code in this editor
//alarm_set(0,0);
//alarm[0] = 0;
if coll then exit;


alarm[2] = 1;
coll = true;
speed = 0;
target = other;

with other {
	if hp <= 0 then exit;

	hp-=other.dmg;
	screenshake(5,global.onesecond*.4);
	audio_play_sound(snSwordHit,3,false);
	if hp <= 0 { 
		state = ENEMYSTATE.DEATH;
		screenshake(8,global.onesecond*1);
		//alarm_set(0,global.onesecond*10);
	}

}