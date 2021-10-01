/// @description  Setup Steering Behaviour Support
event_inherited();

maxhp = 1;
hp = maxhp;
state = ENEMYSTATE.MOVE;
//Non-Steering behaviour stuff
my_color = c_red;
area = instance_create_depth(x,y,depth+1,oAirDroneArea);
coll_box = instance_create_depth(x,y,depth+1,oAirDroneCollBox);
image_xscale = 1;
image_yscale = image_xscale;


//Steering behaviour stuff
position = vect2(x,y); // will be used to update xy
velocity = vect2(0,0);
steering = vect2(0,0); // desired velocity

max_speed = 12;
max_force = 1.5; // How fast it turns

// Only needed if the object will follow paths
/*my_path = path_loop;
my_path_point = irandom(path_get_number(my_path)-1); // Choose a random point on the path
my_path_dir = 1; // 1 = forwards, -1 = backwards*/


//Only needed if object MUST not overlap specified solid object
solid_obj = oSolidStatic;
is_colliding = false;
collision_counter = 60; //Minimum number of frames to run alternate steering behaviours upon collision
collision_timer = 0; //Actual timer variable
flee_obj = noone; //specific instance to move away from
flee_x = 0;
flee_y = 0;

//Chase Demo specific stuff
target_obj = oPlayer;
target_range = 128;



