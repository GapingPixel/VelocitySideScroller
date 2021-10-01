/// @description Dash/slam
// You can write your code in this editor
if oPlayer.sprite_index == sPlayer_Slam {
	oPlayer.y -= 50;
}

if oPlayer.sprite_index == sPlayer_Dash {

}

//Circle DMG
if state == SWORDSTATE.ATTACK {
	if other.hp <= 0 then exit;
	
	audio_play_sound(snSwordHit,3,false);
	other.hp--;
	if other.hp <= 0 { 
		other.state = ENEMYSTATE.DEATH;
		//alarm_set(0,global.onesecond*10);
	}
}

screenshake(5,global.onesecond*.4);