// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function inputs_kb() {
	
	
	/*key_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
	key_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
	key_up_held = keyboard_check(vk_up) or keyboard_check(ord("W"));
	key_up = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
	 
	key_down_held = keyboard_check(vk_down) or keyboard_check(ord("S"));
	key_down = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
	key_shift = keyboard_check(vk_shift);
	
	key_dash = keyboard_check_pressed(vk_space);*/
	key_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
	key_right_pressed = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
	key_right_released = keyboard_check_released(vk_right) or keyboard_check_released(ord("D"));
	key_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
	key_left_pressed = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
	key_left_released = keyboard_check_released(vk_left) or keyboard_check_released(ord("A"));
	key_up = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
	key_up_held = keyboard_check(vk_up) or keyboard_check(ord("W"));
	key_down_held = keyboard_check(vk_down) or keyboard_check(ord("S"));
	key_down  = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
	key_shift = keyboard_check(vk_shift);
	key_dash = keyboard_check_pressed(vk_space);
	//key_attack = keyboard_check_pressed(ord("P"));
	key_attack_held = keyboard_check(ord("O"));
	key_attack = keyboard_check_pressed(ord("O"));
	key_attack_released = keyboard_check_released(ord("O"));
	//key_tp = keyboard_check_pressed(vk);
	key_jump = keyboard_check(ord("P"));
	key_jump_pressed = keyboard_check_pressed(ord("P"));
	pause = keyboard_check_pressed(ord("M"));
	
	pause_exit = keyboard_check_released(vk_escape);
	//keyboard_check_pressed(vk_escape);
	
	//Menu Only Inputs
	enter = keyboard_check_pressed(vk_enter);
	menu_back = keyboard_check_pressed(vk_alt);
	menu_up = keyboard_check_pressed(vk_up);
	menu_down = keyboard_check_pressed(vk_down);
	menu_right = keyboard_check_pressed(vk_right);
	menu_left = keyboard_check_pressed(vk_left);
	
	//map = keyboard_check(ord("M"));

}

function inputs_gp(argument0) {
	
	
	for (var i=0; i<num_controllers; i++)
	{
	    // left pressed
	    if (!stick_left_held[i] && gamepad_axis_value(i,gp_axislh) <= -threshold)
	    {
	        stick_left_held[i] = true;
	        stick_left_pressed[i] = true;
	        stick_left_released[i] = false;
	        alarm[1] = 1;
	    }

	    // left released
	    else if (stick_left_held[i] && gamepad_axis_value(i,gp_axislh) > -threshold)
	    {
	        stick_left_held[i] = false;
	        stick_left_pressed[i] = false;
	        stick_left_released[i] = true;
	        alarm[1] = 1;
	    }


	    // right pressed
	    if (!stick_right_held[i] && gamepad_axis_value(i,gp_axislh) >= threshold)
	    {
	        stick_right_held[i] = true;
	        stick_right_pressed[i] = true;
	        stick_right_released[i] = false;
	        alarm[1] = 1;
	    }

	    // right released
	    else if (stick_right_held[i] && gamepad_axis_value(i,gp_axislh) < threshold)
	    {
	        stick_right_held[i] = false;
	        stick_right_pressed[i] = false;
	        stick_right_released[i] = true;
	        alarm[1] = 1;
	    }

  
	    // up pressed
	    if (!stick_up_held[i] && gamepad_axis_value(i,gp_axislv) >= threshold)
	    {
	        stick_up_held[i] = true;
	        stick_up_pressed[i] = true;
	        stick_up_released[i] = false;
	        alarm[1] = 1;
	    }

	    // up released
	    else if (stick_up_held[i] && gamepad_axis_value(i,gp_axislv) < threshold)
	    {
	        stick_up_held[i] = false;
	        stick_up_pressed[i] = false;
	        stick_up_released[i] = true;
	        alarm[1] = 1;
	    }


	    // down pressed
	    if (!stick_down_held[i] && gamepad_axis_value(i,gp_axislv) <= -threshold)
	    {
	        stick_down_held[i] = true;
	        stick_down_pressed[i] = true;
	        stick_down_released[i] = false;
	        alarm[1] = 1;
	    }

	    // down released
	    else if (stick_down_held[i] && gamepad_axis_value(i,gp_axislv) > -threshold)
	    {
	        stick_down_held[i] = false;
	        stick_down_pressed[i] = false;
	        stick_down_released[i] = true;
	        alarm[1] = 1;
	    }
	
	}
	
	key_right = stick_right_held[global.pad];
	key_right_pressed = stick_right_pressed[global.pad];
	key_right_released = stick_right_released[global.pad];
	key_left = stick_left_held[global.pad];
	key_left_pressed = stick_left_pressed[global.pad];
	key_left_released = stick_left_released[global.pad];
	key_up = stick_down_pressed[global.pad];
	key_up_held = stick_down_held[global.pad];
	
	key_down = stick_up_pressed[global.pad];
	key_down_held = stick_up_held[global.pad];
	key_shift = gamepad_button_check_pressed(global.pad,gp_shoulderl);
	key_jump = gamepad_button_check(global.pad,gp_face1);
	key_jump_pressed = gamepad_button_check_pressed(global.pad,gp_face1);
	key_dash = gamepad_button_check_pressed(global.pad,gp_face2);
	key_attack = gamepad_button_check_pressed(global.pad,gp_face3);
	key_attack_held = gamepad_button_check(global.pad,gp_face3);
	key_attack_released = gamepad_button_check_released(global.pad,gp_face3);
	key_throw = 0;//gamepad_button_check_pressed(global.pad,gp_shoulderlb);;
	
	pause = gamepad_button_check_pressed(global.pad,gp_select);
	pause_exit = gamepad_button_check_released(global.pad,gp_select);
	//Menu Only Inputs
	enter = max(gamepad_button_check_pressed(global.pad,gp_start), gamepad_button_check_pressed(global.pad,gp_face1));
	menu_up = gamepad_axis_value(global.pad,gp_axislv) < 0;
	menu_down =  gamepad_axis_value(global.pad,gp_axislv) > 0;
	
	menu_back = gamepad_button_check(global.pad,gp_face2);
	menu_up = stick_down_pressed[global.pad];//keyboard_check_pressed(vk_up);
	menu_down = stick_up_pressed[global.pad];//keyboard_check_pressed(vk_down);
	menu_right = stick_right_pressed[global.pad];//keyboard_check_pressed(vk_right);
	menu_left =  stick_left_pressed[global.pad];//keyboard_check_pressed(vk_left);
}