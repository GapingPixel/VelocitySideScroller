/// @description Insert description here
// You can write your code in this editor
other.orb_count++;
other.orb_count = min(other.orb_count,999);
audio_play_sound(snOrbPickUp,3,false);
instance_destroy();