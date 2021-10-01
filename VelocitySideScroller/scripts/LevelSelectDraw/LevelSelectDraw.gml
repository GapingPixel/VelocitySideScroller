// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LevelSelectDraw() {
	if System.paused_ {
		draw_sprite(sBlack,0,0,0);
	}
	
	draw_set_font(fLevelSelect);
	var col = c_white;
	draw_set_color(col);
	draw_sprite(sLevelSelectCircle,0,500,400); draw_text(640,675,"TEST");
	draw_sprite(sLevelSelectCircle,0,1300,400); draw_text(1510,675,"1");
	draw_sprite(sLevelSelectCircle,0,2100,400); draw_text(1510+795,675,"2");
	draw_sprite(sLevelSelectCircle,0,2900,400); draw_text(1510+795+795,675,"3");
	draw_sprite(sLevelSelectCircle,0,500,950); draw_text(700,1225,"4")
	draw_sprite(sLevelSelectCircle,0,1300,950); draw_text(1510,1225,"5");
	draw_sprite(sLevelSelectCircle,0,2100,950); draw_text(1510+795,1225,"6");
	draw_sprite(sLevelSelectCircle,0,2900,950); draw_text(1510+795+705,1225,"MENU");
	
	//draw_sprite(sLevelSelectCircle5,0,2900,50);
	//draw_circle(2900,50,200,true)
	
	for (var i = 0; i < 8; i++)
	{
		var col = c_grey;
		draw_set_color(col);
		if i == level_select_cursor {
			switch i {
		
				case 0:
				draw_sprite_ext(sLevelSelectCircle,0,500,400,image_xscale,image_yscale,image_angle,col,1);
				draw_text(640,675,"TEST");
				break;
			
				case 1:
				draw_sprite_ext(sLevelSelectCircle,0,1300,400,image_xscale,image_yscale,image_angle,col,1);
				draw_text(1510,675,"1");
				break;
			
				case 2:
				draw_sprite_ext(sLevelSelectCircle,0,2100,400,image_xscale,image_yscale,image_angle,col,1);
				draw_text(1510+795,675,"2");
				break;
			
				case 3:
				draw_sprite_ext(sLevelSelectCircle,0,2900,400,image_xscale,image_yscale,image_angle,col,1);
				draw_text(1510+795+795,675,"3");
				break;
			
				case 4:
				draw_sprite_ext(sLevelSelectCircle,0,500,950,image_xscale,image_yscale,image_angle,col,1);
				draw_text(700,1225,"4");
				break;
			
				case 5:
				draw_sprite_ext(sLevelSelectCircle,0,1300,950,image_xscale,image_yscale,image_angle,col,1);
				draw_text(1510,1225,"5");
				break;
			
				case 6:
				draw_sprite_ext(sLevelSelectCircle,0,2100,950,image_xscale,image_yscale,image_angle,col,1);
				draw_text(1510+795,1225,"6");
				break;
			
				case 7:
				draw_sprite_ext(sLevelSelectCircle,0,2900,950,image_xscale,image_yscale,image_angle,col,1);
				draw_text(1510+795+705,1225,"MENU");
				break;
			}
		}
	}

	//Subtitle
	var col = c_white;
	draw_set_color(col);
	draw_set_font(fLevelSelectText);
	draw_text(1380,1850,"SELECT LOCATION");
	
}