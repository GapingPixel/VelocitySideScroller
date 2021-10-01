/// @description Insert description here
// You can write your code in this editor
enum SWORDSTATE {
	STANDING,
	ATTACK,
	DASH,
	SLAM
}	

#macro SLASH_SLAM_DMG 3

creator = oPlayer.id;

state = SWORDSTATE.STANDING;
dir = noone;

up_hover = true;
hover_spd = .2;

player_yprev = oPlayer.y;

Orbit = 100; // Orbit distance
Angle = 180; // Current orbital angle
Speed = -25; // Orbital speed
Center_X = oPlayer.x; // x of orbital center
Center_Y = oPlayer.y; // y of orbital center

SwordMove = 0;

dmg = 1;

slice = false;

//Snap behavior
distancetoEnemy = 0;
directiontoEnemy = 0;

swingCount = 0;
swingSprite = false;

//Less is more time 
taping_buffer = 1;

