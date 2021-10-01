/// @desc Control Menu

//Item ease in
menu_x += (menu_x_target - menu_x) / menu_speed;

//Keyboard Controls
switch menu_page {
	
	case MENU_PAGE_MAIN:
	if (menu_control)
	{
		if input.menu_up
		{
			menu_cursor++;
			if (menu_cursor >= menu_items) menu_cursor = 0;
		}
	
		if input.menu_down
		{
			menu_cursor--;
			if (menu_cursor < 0) menu_cursor = menu_items-1;
		}
	
		if input.enter
		{
			menu_x_target = gui_width-4000;
			menu_committed = menu_cursor;
			screenshake(4,30);
			//menu_control = false;
		} 
	}
	if (menu_x < -800/*gui_width-200*/) && (menu_committed != -1)
	{
		switch (menu_committed)
		{
			case 2: 
			//slide_transition(TRANS_MODE.NEXT); 
			menu_page = MENU_PAGE_LEVEL_SELECT;
			room_goto(rLevelSelect);
			//slide_transition(TRANS_MODE.GOTO,rLevelSelect);
			menu_committed = -1;
			break;
			case 1:
			{
				/*menu_page = MENU_PAGE_LEVEL_SELECT;
				menu_committed = -1;*/
				if (!file_exists(SAVEFILE))
				{
					//slide_transition(TRANS_MODE.NEXT);	
					slide_transition(TRANS_MODE.GOTO,rOne);
					instance_destroy();
				}
				else
				{
					var file = file_text_open_read(SAVEFILE);
					var target = file_text_read_real(file);
					file_text_close(file);
					slide_transition(TRANS_MODE.GOTO,target);
					instance_destroy();
				}
			}
			break;
			case 0: game_end(); break;
		}
	}
	break;
	
	case MENU_PAGE_LEVEL_SELECT:
	if (menu_control)
	{
		if input.menu_left 
		{
			level_select_cursor--;
		}
	
		if input.menu_right 
		{
			level_select_cursor++;
		}
		level_select_cursor = clamp(level_select_cursor,0,7);
		//0 1 2 3 
		//4 5 6 7  
		if input.menu_up
		{
			if level_select_cursor == 4 {
				level_select_cursor = 0;
			} else if level_select_cursor == 5 {
				level_select_cursor = 1;
			} else if level_select_cursor == 6 {
				level_select_cursor = 2;
			} else if level_select_cursor == 7 {
				level_select_cursor = 3;
			}
		}
		
		if input.menu_down
		{
			if level_select_cursor == 0 {
				level_select_cursor = 4;
			} else if level_select_cursor == 1 {
				level_select_cursor = 5;
			} else if level_select_cursor == 2 {
				level_select_cursor = 6;
			} else if level_select_cursor == 3 {
				level_select_cursor = 7;
			}
		}
	
		if input.enter
		{
			level_select_x_target = gui_width+325;
			menu_committed = level_select_cursor;
			screenshake(4,30);
			menu_control = false;
		} 
		
		if input.menu_back
		{
			//menu_x_target = gui_width+325;
			menu_committed = -1;
			screenshake(4,30);
			//menu_control = false;
			menu_page = MENU_PAGE_MAIN;
		} 
	}
	if (menu_committed != -1)
	{
		if System.paused_ {
			instance_activate_all();
			//instance_destroy();
			if room != rLevelSelect {
				System.paused_ = false;
			}
		}
		switch (menu_committed)
		{
			case 0: 
			slide_transition(TRANS_MODE.GOTO,rTest);
			draw_set_font(fMenu);
			break;
			
			case 1:
			slide_transition(TRANS_MODE.GOTO,rOne);
			draw_set_font(fMenu);
			break;
			
			case 2: 
			slide_transition(TRANS_MODE.GOTO,rTwo);
			draw_set_font(fMenu);
			break;
			
			case 3: 
			slide_transition(TRANS_MODE.GOTO,rThree); 
			draw_set_font(fMenu);
			break;
			
			case 4:
			slide_transition(TRANS_MODE.GOTO,rFour);
			draw_set_font(fMenu);
			break;
			
			case 5: 
			slide_transition(TRANS_MODE.GOTO,rFive);
			draw_set_font(fMenu);
			break;
			
			case 6:
			slide_transition(TRANS_MODE.GOTO,rSix);
			draw_set_font(fMenu);
			break;
			
			case 7: 
			
				menu_committed = -1;
				screenshake(4,30);
				//menu_control = false;
				menu_page = MENU_PAGE_MAIN;
				room_goto(rMenu);
				
			//instance_destroy();
			break;
		}
		
		instance_destroy();
		
	}
	/*if (menu_x > gui_width+150) && (menu_committed != -1)
	{
		switch (menu_committed)
		{
			case 2: slide_transition(TRANS_MODE.NEXT); break;
			case 1:
			{
				if (!file_exists(SAVEFILE))
				{
					slide_transition(TRANS_MODE.NEXT);	
				}
				else
				{
					var file = file_text_open_read(SAVEFILE);
					var target = file_text_read_real(file);
					file_text_close(file);
					slide_transition(TRANS_MODE.GOTO,target);
				}
			}
			break;
			//case 0: game_end(); break;
		}
	}*/
	break;

}