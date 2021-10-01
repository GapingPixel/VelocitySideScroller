hsp = 3;
vsp = -4;
grv = 0.2;
done = 0;

image_speed = 0;
image_index = 0;

screenshake(8,60);
audio_play_sound(snPlayerDie,10,false);
game_set_speed(30,gamespeed_fps);
with (oCamera) follow = other.id;
