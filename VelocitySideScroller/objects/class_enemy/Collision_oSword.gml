/// @description Insert description here
// You can write your code in this editor
if hp <= 0 then exit;

if other.SwordMove == 1 {
	hp -= other.dmg;
}

if hp <= 0 { 
	state = ENEMYSTATE.DEATH;
	//alarm_set(0,global.onesecond*10);
}