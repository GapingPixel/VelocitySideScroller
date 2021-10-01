/// @description Insert description here
// You can write your code in this editor

if room != rInit and room != rLevelSelect and room != rMenu {
	
	if paused_ {
		if input.pause_exit {
			instance_activate_all();
			with oMenu {
				instance_destroy();
			}
			paused_ = false;
		}
		
	}
	
	if input.pause and !paused_ {
		if instance_exists(oPlayer) {
				paused_ = true;
				//paused_sprite_ = sprite_create_from_surface(application_surface, 0 , 0, view_wport[0], view_hport[0], false, false, 0, 0);
				instance_deactivate_all(true);
				instance_activate_object(input);
				//instance_activate_object(oCamera);
				var _menu = instance_create_depth(x,y,depth,oMenu);
				_menu.menu_page = MENU_PAGE_LEVEL_SELECT;
		}
	}
		
}

