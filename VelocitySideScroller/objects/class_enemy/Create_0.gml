/// @description Insert description here
// You can write your code in this editor
event_inherited();


enum ENEMYSTATE {
	IDLE,
	MOVE,
	FLEE,
	LEDGE_GRAB,
	HIT,
	STUN,
	DEATH,
	MELEE,
	FALLBACK,
}

speed_ = 0;
direction_ = 0;
friction_ = .2;

position = vect2(x,y);
velocity = vect2(0,0);
steering = vect2(0,0); // desired velocity

outline = false;