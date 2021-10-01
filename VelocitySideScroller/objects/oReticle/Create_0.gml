/// @description Insert description here
//Orbit
Orbit = 250; // Orbit distance
Angle = 0; // Current orbital angle
Speed = 0; // Orbital speed
Center_X = noone; // x of orbital center
Center_Y = noone; // y of orbital center

area = instance_create_depth(x,y,depth,oSegmentCollCheck);
area.reticle = true;