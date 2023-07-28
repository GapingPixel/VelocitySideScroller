/// @description  Macros, Variables, Tilemap , Structs
global.onesecond = 60; 


#region COMPONENTS 
comp_hud = instance_create_depth(x,y,depth,hud);
///comp_sword = instance_create_depth(x,y,depth-1,oSword);
///comp_dot = instance_create_depth(x,y,depth,oReticle);
#endregion 

global.tilemap = layer_tilemap_get_id("Tilemap");
global.slopes = layer_tilemap_get_id("Slopes");

enum PLAYERSTATE {
	MOVE,
	LEDGE_GRAB,
	HIT,
	STUN,
	DASH,
	DEATH
}

state = PLAYERSTATE.MOVE;

maxhp = 25;
hp = maxhp;

Jump_rest=1;
Jump_=0;

_Gravity=0.3;
_Floor=0;
 _JumpTime=45;
 _Ocuppied=0;
 _JumpHeight=12;
 
 

hsp = 0;
vsp = 0;
hsp_fraction = 0;
vsp_fraction = 0;
hsp_dir = 1;

hsp_acc = 1; //D 4
hsp_fric_ground = 0.4;//D 1.6
hsp_fric_slide = 0.2;//D 0.8
hsp_fric_air = 0.2; //0.8
hsp_walk = 3; //12
hsp_max = 8; //32
/*OG spd hsp_walk = 3.5;
hsp_max = 8;*/
hsp_slide = hsp_max;
canslide = 1;
//hsp_run = 8;
hsp_dash = 10; //80
hsp_wjump = 5; //20
hsp_hurdle = hsp_max;
walljumpdelay = 0;
walljumpdelay_max = 6;//D 25 //global.onesecond*.45;//counts down from this value, delay frames with no control after wall jump
dashtimer = 0;
dashtimer_max = 2;//D 8 //global.onesecond*.13;//counts down from this value, duration of dash


grav = 0.4; //1.6 
grav_wall = 0.1;/// 0.4
vsp_jump = 9; ///36
jumpbuffer = 0;//After you exit collission, how many frames you have to still input, jump etc.
jumps = 0;
jumpsmax = 1; //2
vsp_max = 12; ///45
vsp_super_max = 10;///80
vsp_hurdle = -50; ///-200
vsp_wjump = -7//-12;   ///-30
vsp_max_wall = 7//12;   ////30

event_inherited();

dust = 0;

//Vault
vault_delay = global.onesecond*.25;
hop = false;
hop_dir = 0.25; //1
hop_spd = 8;//6 //32

//Wallrun
wallrun = false;
wallrun_spd = 3; //12
wallrun_height = 0;
wallrun_locked = false;
wallrun_dir = 0.25; //

//Hit
knockback_dir = DIR_LEFT;

ledgeSwing = false;

hascontrol = true;


//Testing 
test = 0;//locked image_xscale 
boundingBoxComp = 0;
check_vsp = noone;

check_y_adjust = noone;

wullcheck = false;

wallrun_lock_key_released = false;

position = vect2(x,y);


//Orbit


//Static Keys 
enum KEY {
	RED = 0,
	GREEN = 1,
	YELLOW = 2,
	BLUE = 3,
	WHITE = 4
}

key[KEY.RED] = false;
key[KEY.GREEN] = false;
key[KEY.YELLOW] = false;
key[KEY.BLUE] = false;
key[KEY.WHITE] = false;

//Stamina 
maxenergy = 10;
energy = maxenergy;

enum COST {
	DASH = 3,
	THROW = 2,
	SLAM = 3,
	TELEPORT = 2
}


function dashing_screenshake() {
	if (sprite_index == sPlayer_Dash or sprite_index == sPlayer_Slam) {
		screenshake(6,global.onesecond*.5);
	}
}

orb_count = 0;

start = 0;

trampolin = false;