/// @description Insert description here
// You can write your code in this editor
if !instance_exists(class_player) then exit;

if place_meeting(x,y-1,class_player) {

	with class_player {
		trampolin = true;
		alarm_set(10,global.onesecond*.5); 
		//jumps -= 1;
		jumpbuffer = 0;
		vsp_jump = vsp_jump*2;
		if jumps = 1 {
				
		} else {
			vsp = -600//-vsp_jump;
		}
		vsp = -600;
		vsp_fraction = 0;
		vsp_max = 55;
		grounded = false;
		_slpGrounded = false;
		_slopeGrounded = false;
	}
	audio_play_sound(snTrampoline,3,false);
	sprite_index = sTrampolinUsed;

}