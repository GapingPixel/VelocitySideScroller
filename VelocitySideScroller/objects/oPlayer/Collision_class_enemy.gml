/// @description Insert description here
// You can write your code in this editor
if oPlayer.sprite_index == sPlayer_Slam {
	if other.y>y {
		oPlayer.y -= 100
	}
	//oPlayer.y -= 100;
} else if oPlayer.sprite_index == sPlayer_Dash {
	if x < other.x {
		oPlayer.x -= 100
	} else {
		oPlayer.x += 100
	}
	with other {
		if hp <= 0 then exit;

		hp-=other.dmg;
		if hp <= 0 { 
			state = ENEMYSTATE.DEATH;
			//alarm_set(0,global.onesecond*10);
		}
	}
}