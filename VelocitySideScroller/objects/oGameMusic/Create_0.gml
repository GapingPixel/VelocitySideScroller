/// @desc Plays music
audio_stop_all()
randomize();
audio_play_sound(choose(mscGameplay1,mscGameplay2,mscGameplay3,mscGameplay4),1,true);
audio_play_sound(snWind,1,true);


//audio_sound_set_track_position()