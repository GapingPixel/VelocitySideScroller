/// @description Insert description here
// You can write your code in this editor
audio_play_sound(snSwordThrow,3,false);



alarm_set(0,global.onesecond*0.35);
speed = 75;
target = noone;

dis = noone;

dir_count = 0;
dmg = 1;

coll = false;

//Set Trajectory
//alarm_set(1,1);
//range = 300;

//count