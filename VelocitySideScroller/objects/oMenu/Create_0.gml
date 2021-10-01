/// @desc GUI/Vars/Menu setup
#macro SAVEFILE "Save.sav"
#macro MENU_PAGE_MAIN 0
#macro MENU_PAGE_LEVEL_SELECT 1

display_set_gui_size(3840,2160);

var _viewport = room_get_viewport(room,0);

gui_width = _viewport[3];
gui_height = _viewport[4];
gui_margin = 32;

menu_x = gui_width -2900;
menu_y = gui_height - gui_margin+200;
menu_x_target = gui_width - gui_margin-2400;
menu_speed = 25; //lower is faster
menu_font = fMenu;
menu_itemheight = font_get_size(fMenu);
menu_committed = -1;
menu_control = true;
menu_page = MENU_PAGE_MAIN;


menu[2] = "NEW GAME";
menu[1] = "CONTINUE";
menu[0] = "QUIT";
menu_items = array_length_1d(menu);
menu_cursor = 2;


level_select_x = gui_width-200;
level_select_y = gui_height - gui_margin;
level_select_x_target = gui_width+400 - gui_margin;
level_select[7] = "TEST";
level_select[6] = "1";
level_select[5] = "2";
level_select[4] = "3";
level_select[3] = "4";
level_select[2] = "5";
level_select[1] = "6";
level_select[0] = "MENU";
level_select_items = array_length_1d(level_select);



level_select_cursor = 0;

alarm_set(0,1);