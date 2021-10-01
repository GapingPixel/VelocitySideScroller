/// @desc Draw Menu
draw_set_font(fMenu);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

//draw_text(x,y,string(menu_x));

switch (menu_page) {

	case MENU_PAGE_MAIN:
	draw_set_font(fTitle);
	draw_set_color(c_white);
	draw_text(menu_x,500,"UNTITLED");

	for (var i = 0; i < menu_items; i++)
	{
		var offset = 0;
		var txt = menu[i];
		if (menu_cursor == i)
		{
			txt = string_insert("> ", txt, 0)
			var col = c_white;	
		}
		else
		{
			var col = c_gray;	
		}
		var xx = menu_x;
		var yy = menu_y - (menu_itemheight * (i * 3))
		draw_set_color(c_white);
		
		draw_set_font(fOptions);
		/*draw_text(xx-offset,yy,txt);
		draw_text(xx+offset,yy,txt);
		draw_text(xx,yy-offset,txt);
		draw_text(xx,yy+offset,txt);*/
		draw_set_color(col);
		draw_text(xx,yy,txt);

	}
	break;
	
	case MENU_PAGE_LEVEL_SELECT:
	if room != rLevelSelect {
		LevelSelectDraw();
	}
	break;

}