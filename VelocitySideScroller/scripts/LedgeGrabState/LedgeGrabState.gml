function LedgeGrabState() {
	if tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top+1) == 3 or tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10) == 2 {
		state = PLAYERSTATE.MOVE;
		exit;
	}
	vault_delay = global.onesecond*.25;
	hop = false;
	hop_dir = 1;
	hop_spd = 32;//6 
	//Wallrun
	wallrun = false;
	wallrun_spd = 12;
	wallrun_height = 0;
	wallrun_locked = false;
	wallrun_dir = 1;
	//Animation
	image_speed = 1;
	if (hsp != 0) image_xscale = sign(hsp);
	sprite_index = sPlayer_Ledge;
	
	switch image_xscale {
	
		case 1:
		while tilemap_get_at_pixel(global.tilemap,x+1,bbox_top) { 
			y--;
		}
		/*while tilemap_get_at_pixel(global.tilemap64,x+1,bbox_top) { 
			y--;
		}*/
		break;
	
		case -1:
		while tilemap_get_at_pixel(global.tilemap,x-1,bbox_top) { 
			y--;
		}
		/*while tilemap_get_at_pixel(global.tilemap64,x-1,bbox_top) { 
			y--;
		}*/
		if !tilemap_get_at_pixel(global.tilemap,x-8,y) { 
			while !tilemap_get_at_pixel(global.tilemap64,x-1,y)  { 
				--x;
			}
		}
	
		break;
	}
	///LedgeGrabState
	//Player Controls From Ledge Grab
	if (input.key_up)
	{
		vsp = -vsp_jump;
		state = PLAYERSTATE.MOVE;
		
		switch image_xscale {
			case 1:
			x+=64;
			
			break;
			
			case -1:
			x-=64;
			break;
		}
		y-=64;
		//y-=90;
	}

	if (input.key_down_held)
	{
		state = PLAYERSTATE.MOVE;
		if hsp_dir {
			x-=35;
		} else x+=25;
		
		
		audio_play_sound(snFlap,5,false);
	}

	if input.key_right_pressed == hsp_dir
	{
		y-=90;
		if tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) {
			if tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) {
			//x-=15;
				y-=90;
				while tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) {
					y--;
				}
			}  
		}
		state = PLAYERSTATE.MOVE;
	}

	if input.key_right_pressed == -hsp_dir 
	{
		y-=90;
		if tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) {
			if tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) {
				//x-=15;
				y-=90;
				while tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) {
					y--;
				}
			}  
		}
		state = PLAYERSTATE.MOVE;
	}

	if input.key_left_pressed == -hsp_dir
	{
		--x;
		y-=90;
		if tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom) {
			y-=90;
			while tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom) {
				y--;
			}
		}  
		state = PLAYERSTATE.MOVE;	
	}
	
	if input.key_left_pressed == hsp_dir
	{
			--x;
			--y;
			
			y-=90;
			if tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom) {
				//x-=15;
				y-=90;
				while tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom) {
					y-=10;
				}
				//x-=60;
			}
			state = PLAYERSTATE.MOVE;
	}
	
	if input.key_left_pressed and sprite_index == sPlayer_Ledge and image_xscale == 1  {
		//x-= 12; 
	}	
	
	if input.key_right_pressed and sprite_index == sPlayer_Ledge and image_xscale == -1 {
		//x+= 8; 
	}	
	
	if input.key_attack {
		if tilemap_get_at_pixel(global.tilemap,bbox_left-2,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,bbox_left-2,bbox_bottom) {
			--x;
			--y;
		} else if tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,bbox_right+2,bbox_bottom)  {
			++x;
			++y;
		}
		ledgeSwing = true;
		alarm_set(5,2);
		state = PLAYERSTATE.MOVE;
	}
	
	
}