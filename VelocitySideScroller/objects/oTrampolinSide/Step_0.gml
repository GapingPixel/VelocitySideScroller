/// @description Insert description here
// You can write your code in this editor
if !instance_exists(class_player) then exit;

if place_meeting(x+1,y,class_player) {
	alarm_set(0,global.onesecond*.32);
	with class_player {
		
		//hsp += image_xscale*50;
		/*trampolin = true;
		alarm_set(10,global.onesecond*.5); 
		jumps -= 1;
		jumpbuffer = 0;
		
		if jumps = 1 {
				
		} else {
			vsp = -vsp_jump*01;
		}
		vsp = -990;
		vsp_fraction = 0;
	
		grounded = false;
		_slpGrounded = false;
		_slopeGrounded = false;*/
	}
	audio_play_sound(snTrampoline,3,false);
	sprite_index = sTrampolinUsedRight;

}