/// @description Apply DMG
// You can write your code in this editor
if other.creator == id then exit;
if hp <= 0 then exit;

hp-=other.dmg;
if hp <= 0 { 
	state = ENEMYSTATE.DEATH;
	screenshake(7,global.onesecond*.4);
	//alarm_set(0,global.onesecond*10);
}
