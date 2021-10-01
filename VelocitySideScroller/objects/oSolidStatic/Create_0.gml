/// @description Insert description here
// You can write your code in this editor
event_inherited();
position = vect2(x,y); // will be used to update xy
velocity = vect2(0,0);
steering = vect2(0,0); // desired velocity
max_speed = 8;
max_force = 0.7; 
//Place behind everything else
depth = 10;