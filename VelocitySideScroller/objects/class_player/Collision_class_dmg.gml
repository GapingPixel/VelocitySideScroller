/// @description Apply DMG
// You can write your code in this editor
if hp <= 0 or other.creator == id then exit;

hp-=other.dmg;
screenshake(5,40);
if hp <= 0 { 
	state = PLAYERSTATE.DEATH;
	with oSword {
		instance_destroy();
	}
	alarm_set(0,global.onesecond*10);
	screenshake(8,global.onesecond*1.5);
}
