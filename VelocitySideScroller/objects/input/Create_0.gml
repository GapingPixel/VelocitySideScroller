/// @description Insert description here
// You can write your code in this editor
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);

num_controllers = 1;
//Stick pressed
for (var i=0; i<num_controllers; i++)
{
    stick_left_pressed[i] = false;
    stick_right_pressed[i] = false;
    stick_up_pressed[i] = false;
    stick_down_pressed[i] = false;

    stick_left_held[i] = false;
    stick_right_held[i] = false;
    stick_up_held[i] = false;
    stick_down_held[i] = false;

    stick_left_released[i] = false;
    stick_right_released[i] = false;
    stick_up_released[i] = false;
    stick_down_released[i] = false;
}

threshold = 0.4; 

inputs_kb();
global.pad = noone; 
global.gamepad_active = false;
global.gamepad_thresh = .3;


gpu_set_texfilter(false);
