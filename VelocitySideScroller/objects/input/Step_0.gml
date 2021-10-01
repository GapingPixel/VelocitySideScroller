/// @description Insert description here
// You can write your code in this editor
gpu_set_texfilter(false);
if keyboard_check(vk_space) {
	gpu_set_texfilter(true);
	/*if gpu_get_texfilter
	{
		gpu_set_texfilter(false);
	}
	else
	{
		gpu_set_texfilter(true);
	}*/

}

if max ( keyboard_check(vk_right), keyboard_check(vk_left), keyboard_check(vk_up), keyboard_check(vk_down), 
keyboard_check_pressed(vk_right), keyboard_check_pressed(vk_left),  keyboard_check_pressed(vk_up),  
keyboard_check_pressed(vk_down), mouse_check_button_pressed(mb_left), keyboard_check_pressed(vk_space), 
mouse_check_button_pressed(mb_right), keyboard_check_pressed(vk_enter),
keyboard_check(ord("I")) ) == true 
{
	global.gamepad_active = false;
} else if max (gamepad_button_check(global.pad, gp_face1), gamepad_button_check(global.pad, gp_face2), gamepad_button_check(global.pad, gp_face3),gamepad_button_check(global.pad,gp_face4), gamepad_button_check(global.pad,gp_shoulderl), gamepad_button_check(global.pad,gp_shoulderlb), 
	gamepad_button_check(global.pad,gp_shoulderr), gamepad_button_check(global.pad,gp_shoulderrb), gamepad_button_check(global.pad,gp_start),  gamepad_button_check(global.pad,gp_select), gamepad_axis_value(global.pad,gp_axislh), gamepad_axis_value(global.pad,gp_axisrh), gamepad_axis_value(global.pad,gp_axislv), gamepad_axis_value(global.pad,gp_axisrv), gamepad_button_check(global.pad,gp_padd), gamepad_button_check(global.pad,gp_padl), gamepad_button_check(global.pad,gp_padr), gamepad_button_check(global.pad,gp_padu)) == true {
	
	global.gamepad_active = true;
}

if  instance_exists(oMenu) {
	
	switch global.gamepad_active {

		case false:
		inputs_kb();
		break;
	
		case true:
		inputs_gp(global.pad);
		break;

	}

} else if instance_exists(oPlayer) {
	if oPlayer.hascontrol {
	
		switch global.gamepad_active {

			case false:
			inputs_kb();
			break;
	
			case true:
			inputs_gp(global.pad);
			break;

		}
	}
}


if menu_up or menu_down {
	if alarm_get(0) <=0 { 
		alarm_set(0,global.onesecond*.25);
	} else {
		menu_up = false;
		menu_down = false;
	}
} else if alarm_get(0) > 0 {
	menu_up = false;
	menu_down = false;
}