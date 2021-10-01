/// @description Insert description here
// You can write your code in this editor
/// @description Detect Controllers
show_debug_message("Event = " + async_load[? "event_type"]);        // Debug cocde so you can see which event has been
show_debug_message("Pad = " + string(async_load[? "pad_index"]));   // triggered and the pad associated with it.

switch(async_load[? "event_type"])             // Parse the async_load map to see which event has been triggered
{
case "gamepad discovered":                     
     var index = async_load[? "pad_index"];
     global.pad = index;       // Get the pad index value from the async_load map
     gamepad_set_axis_deadzone(global.pad, global.gamepad_thresh);       
     gamepad_set_button_threshold(global.pad, global.gamepad_thresh);   
	 global.gamepad_active = true;
     break;
case "gamepad lost":                           
     var index = async_load[? "pad_index"];   
     global.pad = noone;  
	 global.gamepad_active = false;
     break;
}