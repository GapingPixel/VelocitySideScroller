/// @description Insert description here
// You can write your code in this editor
with oPlayer {

	if state != PLAYERSTATE.DASH and alarm_get(6) == -1 {
		state = PLAYERSTATE.DASH;
		path_start(other.path,80,path_action_stop,true);
		audio_play_sound(snZipTube,3,false);
	}

}