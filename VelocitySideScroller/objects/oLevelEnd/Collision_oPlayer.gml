/// @desc Move to next room
if !instance_exists(oPlayer) exit; 

with (oPlayer)
{
	if (hascontrol)
	{
		hascontrol = false;
		slide_transition(TRANS_MODE.GOTO,other.target);
	} 
}

audio_stop_all();