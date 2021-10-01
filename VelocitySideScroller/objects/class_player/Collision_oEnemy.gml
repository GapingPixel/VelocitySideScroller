/// @description Insert description here
// You can write your code in this editor
if hp <= 0 then exit;

hp-=other.dmg;

state = PLAYERSTATE.HIT;
alarm_set(11,global.onesecond*1.5);

if hp <= 0 { 
	state = PLAYERSTATE.DEATH;
	alarm_set(0,global.onesecond*10);
}