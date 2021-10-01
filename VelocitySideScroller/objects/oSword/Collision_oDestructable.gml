/// @description Insert description here
// You can write your code in this editor
//Circle DMG
if state == SWORDSTATE.ATTACK {
	if other.hp <= 0 then exit;

	other.hp--;
	if other.hp <= 0 { 
		other.state = ENEMYSTATE.DEATH;
		//alarm_set(0,global.onesecond*10);
	}
}

screenshake(5,global.onesecond*.4);