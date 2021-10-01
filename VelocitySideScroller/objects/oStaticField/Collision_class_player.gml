/// @description Insert description here
// You can write your code in this editor

	
switch sprite_index {

	case sStaticFieldGreen:
	if other.key[KEY.GREEN] == false {
		other.hp = 0;
		other.state = PLAYERSTATE.DEATH;
		screenshake(8,global.onesecond*1.5);
	}
	break;
	
	case sStaticFieldBlue:
	if other.key[KEY.BLUE] == false {
		other.hp = 0;
		other.state = PLAYERSTATE.DEATH;
		screenshake(8,global.onesecond*1.5);
	}
	break;
	
	case sStaticFieldWhite:
	if other.key[KEY.WHITE] == false {
		other.hp = 0;
		other.state = PLAYERSTATE.DEATH;
		screenshake(8,global.onesecond*1.5);
	}
	break;
	
	case sStaticFieldRed:
	if other.key[KEY.RED] == false {
		other.hp = 0;
		other.state = PLAYERSTATE.DEATH;
		screenshake(8,global.onesecond*1.5);
	}
	break;
	
	case sStaticFieldYellow:
	if other.key[KEY.YELLOW] == false {
		other.hp = 0;
		other.state = PLAYERSTATE.DEATH;
		screenshake(8,global.onesecond*1.5);
	}
	break;
	
}