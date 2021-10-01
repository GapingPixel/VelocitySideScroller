///PlayerMoveCollideState
function PlayerMoveCollideState() {
	//All Player Movement and Collission and Animation
	
	//Event Variables
	var bbox_side;
	var p1,p2,slope;
	
	var dir = input.key_right - input.key_left
	var _subdir = dir;
	if dir == 0 {
		_subdir = 1;
	}
	//Calculate Current Status Early
	var grounded = max( in_floor(global.tilemap,x,bbox_bottom+1) >= 0, in_floor64(global.tilemap64,x,bbox_bottom+1) >= 0, place_meeting(x,y+1,class_solid));  
	//var grounded = (tilemap_get_at_pixel(global.tilemap,x-16,bbox_bottom+1)) and (tilemap_get_at_pixel(global.tilemap,x+16,bbox_bottom+1)) >=0;
	var _slpGrounded = in_floor(global.tilemap,x,bbox_bottom+1) >= 0;
	var _slopeGrounded = in_floor_slopes(global.slopes,x,bbox_bottom+1) >= 0;
	var grounded_sld = !place_meeting(x,y+2,class_solid);
	var onwall = max(tilemap_get_at_pixel(global.tilemap,bbox_right+1,y),tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y)) - max(tilemap_get_at_pixel(global.tilemap,bbox_left-1,y), tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y) );
	
	if alarm_get(6) {
		hsp += knockback_dir*1;
	}
	
	//Calculate Horizantle Movement
	walljumpdelay = max(walljumpdelay-1,0);
	dashtimer = max(dashtimer-1,0);
	
	var crouch = (grounded /*or grounded_sld*/) && ( (input.key_down_held) or ( ( tilemap_get_at_pixel(global.tilemap,x,bbox_top-25) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top-25) ) && (sprite_index == sPlayer_Crouch or sprite_index == sPlayer_Crawl or sprite_index == sPlayer_Slide) ) );
	
	if crouch && !input.key_down_held { 
		 input.key_jump = false;
		 input.key_dash = false;
	}
	 
	var hsp_max_final = hsp_max;
	//Move
	if (walljumpdelay == 0) && (dashtimer == 0) && (!input.key_down_held) && (hop == 0) 
	{
		hsp += dir *hsp_acc;
		if (dir == 0)
		{
			if (grounded or grounded_sld) var hsp_fric_final = hsp_fric_ground;	
			if (!grounded) hsp_fric_final = hsp_fric_air;
			
			hsp = approach(hsp,0,hsp_fric_final);
		}
		hsp = clamp(hsp,-hsp_walk,hsp_walk);
	}
	//Run
	/*if (walljumpdelay == 0) && (dashtimer == 0) && (!input.key_down) && (input.key_shift) && (!input.key_dash) && (hop == 0) 
	{
		hsp += dir * hsp_run;
		if (dir == 0)
		{
			var hsp_fric_final = hsp_fric_ground;	
			if (!grounded ) hsp_fric_final = hsp_fric_air;
		/*	hsp = approach(hsp,0,hsp_fric_final);
		}
		hsp = clamp(hsp,-hsp_run,hsp_run)
	}*/
	//Crawl
	if (crouch) && (hsp <= hsp_walk && hsp >= -hsp_walk)
	{
		hsp += dir * hsp_acc;
		if(dir == 0)
		{
			hsp = approach(hsp,0,hsp_fric_ground);
		}
		hsp = clamp(hsp,-hsp_walk/1.5,hsp_walk/1.5);
		
	}

	//Slide Reset
	if (!crouch && alarm_get(2) < 0) {canslide = 1}
	//Slide
	if (input.key_down_held) && (grounded /*&& grounded_sld*/) 
	{
		if canslide = 1
		{
		hsp += dir * hsp_slide;
		canslide = 0
		}
		if(dir == 0) or (crouch)
		{
			hsp = approach(hsp,0,hsp_fric_slide);
		}
		hsp = clamp(hsp,-hsp_slide,hsp_slide)		
	}
	//Dash
	if (input.key_dash) && (walljumpdelay == 0) && (!input.key_down) && (energy >= COST.DASH) /*&& !tilemap_get_at_pixel(global.tilemap,x,bbox_top-14) *//*&& (input.key_right or input.key_left)*/ && (!crouch) && !( tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom+2) and ( tilemap_get_at_pixel(global.tilemap,bbox_left-16,bbox_top) or tilemap_get_at_pixel(global.tilemap,bbox_right+16,bbox_top) ) )
	{
		energy -= COST.DASH;
		dashtimer = dashtimer_max;
		
		if dir == 0 {
			hsp += image_xscale * hsp_dash;
		} else {
			hsp += dir * hsp_dash;
		}
		hsp = clamp(hsp,-hsp_dash,hsp_dash);
		
		if tilemap_get_at_pixel(global.tilemap,x+(vsp/4),y) or tilemap_get_at_pixel(global.tilemap64,x+(vsp/4),y) or tilemap_get_at_pixel(global.tilemap,x+(vsp/4),bbox_top) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top+(vsp)) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+(vsp)) or tilemap_get_at_pixel(global.tilemap64,x+(vsp/4),bbox_bottom) && (alarm_get(9) == -1) {
			vsp = 0;
			alarm_set(9, global.onesecond*.5);
		}
		/*if tilemap_get_at_pixel(global.tilemap,x+hsp,y) or tilemap_get_at_pixel(global.tilemap64,x+hsp,y) {
			hsp = 0;
		}*/
		
		if input.key_up_held {
			vsp = -vsp_jump;
			alarm_set(10,12);
			input.key_jump = true;
			input.key_jump_pressed = true;
		}
	}
	
	if alarm_get(10) > 0 {
		input.key_jump = true;
		//input.key_jump_pressed = true;
	}
	
	if (dashtimer == 0) {
		hsp = clamp(hsp,-hsp_max_final,hsp_max_final);	
	}
	
	//Wall Jump
	if (!grounded ) && (onwall !=0) && (input.key_jump_pressed) && (!input.key_dash) && (dashtimer == 0) && (sprite_index != sPlayer_Dash)
	{
		if true {
			walljumpdelay = walljumpdelay_max;
			//jumps = jumpsmax// remove comment to have a double jump after wall jump.  Seems like its too much to me, but possible experimentation later.
			hsp =  -onwall * hsp_wjump;
			vsp = vsp_wjump;
	
			hsp_fraction = 0;
			vsp_fraction = 0;
		}
	}
	
	var _atkwallspd = -24*hsp_dir;
	if input.key_attack && !grounded && onwall != 0 {
		
		if hsp_dir == 1 {
			hsp_dir = -1;
		} else {
			hsp_dir = 1;
		}
		//walljumpdelay = walljumpdelay_max;
		//hsp = -onwall * hsp_wjump*3;
		//hsp = 5*dir;
		//_atkwallspd = 5*dir;
		//vsp = vsp_wjump;
		/*hsp_fraction = 0;
		vsp_fraction = 0;*/
		alarm_set(4,global.onesecond*.2);
		//jump part
		jumps -= 1;
		jumpbuffer = 0;
		if jumps = 1 {
			vsp = -vsp_jump;
		} else {
			vsp = -vsp_jump/1.5;
		}
		vsp_fraction = 0;
	}
	
	if (hsp < 0) && (!grounded /*and !grounded_sld**/) && (!input.key_jump) && !instance_exists(oSwing) && (dashtimer == 0) && !place_meeting(x,y-1,class_solid) hsp = max(hsp,-hsp_wjump/5)
	if (hsp > 0) && (!grounded/* and !grounded_sld*/) && (!input.key_jump) && !instance_exists(oSwing) && (dashtimer == 0) && !place_meeting(x,y-1,class_solid)  hsp = max(-hsp,hsp_wjump/5)
	//Calculate Verticle Movement
	var grav_final = grav;
	var vsp_max_final = vsp_max;
	if (onwall != 0) && (vsp > 0)
	{
		grav_final = grav_wall;	
		vsp_max_final = vsp_max_wall;
	}
	vsp += grav_final;
	vsp = clamp(vsp,-vsp_max_final,vsp_max_final);

	//Ground Jump
	if ((grounded /*or grounded_sld*/) || (jumpbuffer > 0) || (in_floor(global.tilemap,bbox_left,bbox_bottom+1) >= 0) || (in_floor(global.tilemap,bbox_right,bbox_bottom+1) >= 0) || (in_floor(global.tilemap64,bbox_left,bbox_bottom+1) >= 0) || (in_floor(global.tilemap64,bbox_right,bbox_bottom+1) >= 0) || (in_floor_slopes(global.slopes,bbox_left,bbox_bottom+1) >= 0) || (in_floor_slopes(global.slopes,bbox_right,bbox_bottom+1) >= 0) ) && (!input.key_down_held) {
		jumps = jumpsmax;	
	}
	jumpbuffer--;
	if (input.key_jump_pressed) && (jumps > 0) 
	{
		if true/*!input.key_dash*/ {
			jumps -= 1;
			jumpbuffer = 0;
		
			if jumps = 1 {
				vsp = -vsp_jump;
			} else {
				vsp = -vsp_jump/1.1;
			}
			vsp_fraction = 0;
		}
		grounded = false;
		_slpGrounded = false;
		_slopeGrounded = false;
		//grounded_sld = false;
	}
	
	//Movement manipulation
	vsp = clamp(vsp,-vsp_max,vsp_max)

	if (vsp < 0) && (!input.key_jump) and (!input.key_dash) vsp = max(vsp,-vsp_jump/4);
	
	
	test = grounded; 
	//Slam
	if (!grounded /*and !grounded_sld*/) && (input.key_down_held) && (!input.key_dash)  /*(alarm_get(8) == -1)*/ && !tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_bottom+1) && !tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_bottom+1) && !tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom+1) && !tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom+1) //&& (alarm_get(9) == -1)
	{
		
		if sprite_index != sPlayer_Slam and energy >= COST.SLAM { 
			energy -= COST.SLAM;
			sprite_index = sPlayer_Slam;
		}
		if sprite_index == sPlayer_Slam {
			vsp = vsp_super_max;	
			if tilemap_get_at_pixel(global.tilemap,x,bbox_top) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) {
				vsp = 0;
			}
			if tilemap_get_at_pixel(global.tilemap,x,bbox_top+vsp/2) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top+vsp/2) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+vsp/2) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom+vsp/2) {
				//vsp = 0;
				while !tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom+1) and !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) {
					y++;
				}
			}
		}
	}
	if instance_exists(oTrampolinSide) {
		var _trampolinRight = instance_nearest(x,y,oTrampolinSide)
		
		if _trampolinRight.alarm[0] > 0 then hsp += 40;
	}
	
	if instance_exists(oTrampolinLeft) {
		var _trampolinLeft = instance_nearest(x,y,oTrampolinLeft)
		
		if _trampolinLeft.alarm[0] > 0 then hsp -= 40;
	}
	
	//Re apply fractions
	hsp += hsp_fraction;
	vsp += vsp_fraction;

	//Store and Remove fractions
	//Important: go into collision with whole integers ONLY!
	hsp_fraction = hsp - (floor(abs(hsp)) * sign(hsp));
	hsp -= hsp_fraction;
	vsp_fraction = vsp - (floor(abs(vsp)) * sign(vsp));
	vsp -= vsp_fraction;

	//Direction Check, used for ledgegrab after vertical collision
	if alarm_get(4) >= 0 {
		hsp = _atkwallspd;
	}
	
	if (hsp != 0) {
		hsp_dir = sign(hsp);	
	}
	//Horizontal Collision
	
	//-Tiles-
	if (hsp > 0) bbox_side = (bbox_right); else bbox_side = (bbox_left);
	p1 = tilemap_get_at_pixel(global.tilemap,bbox_side+hsp,bbox_top);
	p2 = tilemap_get_at_pixel(global.tilemap,bbox_side+hsp,bbox_bottom); 
	if (tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) > 1) then p2 = 0; //ignore bottom side tiles if on a slope.
	if (p1 == 1) || (p2 == 1) //Inside a tile with collision
	{
		if (hsp > 0) x = x - (x mod TILE_SIZE) + (TILE_SIZE-1) - (bbox_right - x);
		else x = x - (x mod TILE_SIZE) - (bbox_left - x);
		hsp = 0;
		dashing_screenshake();
	}
	/*if (hsp > 0) bbox_side = (bbox_right); else bbox_side = (bbox_left);
	p1 = tilemap_get_at_pixel(global.slopes,bbox_side+hsp,bbox_top);
	p2 = tilemap_get_at_pixel(global.slopes,bbox_side+hsp,bbox_bottom); 
	if (tilemap_get_at_pixel(global.slopes,x,bbox_bottom) > 1) then p2 = 0; //ignore bottom side tiles if on a slope.
	if (p1 == 1) || (p2 == 1) //Inside a tile with collision
	{
		if (hsp > 0) x = x - (x mod TILE_SIZE) + (TILE_SIZE-1) - (bbox_right - x);
		else x = x - (x mod TILE_SIZE) - (bbox_left - x);
		hsp = 0;
	}*/
	if (hsp > 0) bbox_side = (bbox_right); else bbox_side = (bbox_left);
	p1 = tilemap_get_at_pixel(global.tilemap64,bbox_side+hsp,bbox_top);
	p2 = tilemap_get_at_pixel(global.tilemap64,bbox_side+hsp,bbox_bottom); 
	if (tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) > 1) then p2 = 0; //ignore bottom side tiles if on a slope.
	if (p1 == 1) || (p2 == 1) //Inside a tile with collision
	{
		if (hsp > 0) {
			if sprite_index == sPlayer_Crawl or sprite_index == sPlayer_Crouch {
				while !tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_top) {
					++x;
				}
			} else {
				x = x - (x mod SEC_TILE_SIZE) + (SEC_TILE_SIZE-1) - (bbox_right - x);
			}
		} else {
			//check_y_adjust = x - (x mod SEC_TILE_SIZE) - (bbox_left - x);
			if sprite_index == sPlayer_Crawl or sprite_index == sPlayer_Crouch {
				while !tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_top) {
					--x;
				}
			} else {
				x = x - (x mod SEC_TILE_SIZE) - (bbox_left - x);
			}
		}
		hsp = 0;
		dashing_screenshake();
	}
	
	
	//-Objects-
	coll_sld_hor();
	if !(instance_exists(oSwing) and !grounded) {
		x += hsp;
	} 
	//Vertical Collision
	//is this not a slope?
	//if vault_delay == global.onesecond*.25 {
	if (tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+vsp) <= 1) 
	{
		if (vsp >= 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
			p1 = tilemap_get_at_pixel(global.tilemap,bbox_left, bbox_side+vsp);
			p2 = tilemap_get_at_pixel(global.tilemap, bbox_right, bbox_side+vsp);
			
		if (p1 == 1) || (p2 == 1) {
			if (vsp >= 0) y = y - (y mod TILE_SIZE) + (TILE_SIZE-1) - (bbox_bottom - y);
			else y = y - (y mod TILE_SIZE) - (bbox_top - y);
			vsp = 0;
			dashing_screenshake();
			if sprite_index == sPlayer_U then grounded = true;
		}
	}
	
	/*if (tilemap_get_at_pixel(global.slopes,x,bbox_bottom+vsp) <= 1) 
	{
		if (vsp >= 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
			p1 = tilemap_get_at_pixel(global.slopes,bbox_left, bbox_side+vsp);
			p2 = tilemap_get_at_pixel(global.slopes, bbox_right, bbox_side+vsp);
			
		if (p1 == 1) || (p2 == 1) {
			if (vsp >= 0) y = y - (y mod TILE_SIZE) + (TILE_SIZE-1) - (bbox_bottom - y);
			else y = y - (y mod TILE_SIZE) - (bbox_top - y);
			vsp = 0;
			
			if sprite_index == sPlayer_U then grounded = true;
		}
	}*/
	
	if (tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom+vsp) <= 1) 
	{
		if (vsp >= 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
			p1 = tilemap_get_at_pixel(global.tilemap64,bbox_left, bbox_side+vsp);
			p2 = tilemap_get_at_pixel(global.tilemap64, bbox_right, bbox_side+vsp);
			
		if (p1 == 1) || (p2 == 1) {
			if (vsp >= 0) {
				y = (y - (y mod SEC_TILE_SIZE) + (SEC_TILE_SIZE-1) - (bbox_bottom - y)) + SEC_TILE_SIZE;
			} else { 
				y = (y - (y mod SEC_TILE_SIZE) - (bbox_top - y)) - SEC_TILE_SIZE;
			} 
			vsp = 0;
			
			if sprite_index == sPlayer_U then grounded = true;
		}
	}
	//}
	check_vsp = vsp;
	if !wallrun or (input.key_jump or input.key_jump_pressed) {
		var floordist = in_floor(global.tilemap,x,bbox_bottom+vsp);
		
		if (floordist >= 0) {
			y += vsp;
			y -= (floordist+1);	
			vsp = 0;
			floordist = -1;
		}
		/*var floordistSlop = in_floor_slopes(global.slopes,x,bbox_bottom+vsp);
		if (floordistSlop >= 0) {
			y += vsp;
			y -= (floordistSlop+1);	
			vsp = 0;
			floordistSlop = -1;
		}*/
		var floordist64 = in_floor64(global.tilemap64,x,bbox_bottom+vsp);
		
		if (floordist64 >= 0) {
			y += vsp;
			y -= (floordist64+1);	
			vsp = 0;
			floordist64 = -1;
		}
		//-Solid coll-
		coll_sld_ver();
		if !(instance_exists(oSwing) and !grounded) {
			y +=  vsp;
		} 
		//Walk down slopes
		if ( _slpGrounded )
		{
			y += abs(floordist)-1;
			//if at base of current tile
			if ((bbox_bottom mod TILE_SIZE) == TILE_SIZE-1)
			{
				// if slope continues
				if (tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) > 1)
				{
					//move there
					y += abs(in_floor(global.tilemap,x,bbox_bottom+1));
					
				}
			}
		}
		/*if ( _slopeGrounded )
		{
			y += abs(floordistSlop)-1;
			//if at base of current tile
			if ((bbox_bottom mod TILE_SIZE) == TILE_SIZE-1)
			{
				// if slope continues
				if (tilemap_get_at_pixel(global.slopes,x,bbox_bottom+1) > 1)
				{
					//move there
					y += abs(in_floor_slopes(global.slopes,x,bbox_bottom+1));
					
				}
			}
		}*/
	}
	//Calculate Current Status Late
	if (grounded /*or grounded_sld*/) jumpbuffer = 6

	if wallrun_locked == true {
		if (input.key_right_released) or (input.key_left_released) {
			wallrun_lock_key_released = true;
		}
		if wallrun_lock_key_released and ( ( tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_bottom+1) > 0 ) or ( tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_bottom+1) > 0 ) or ( tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) > 0 ) or ( tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom+1) > 0 ) or ( tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom+1) > 0 ) or ( tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom+1) > 0 ) ) {
			wallrun_locked = false;
			wallrun_lock_key_released = false;
		} 
	}
	
	var _onwallalt = max( (tilemap_get_at_pixel(global.tilemap,bbox_right+1,y) > 0), (tilemap_get_at_pixel(global.tilemap,bbox_left-1,y) > 0), (tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y) > 0), (tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y) > 0) );
	if _onwallalt && hop == 0 and state != PLAYERSTATE.LEDGE_GRAB and !input.key_down_held and alarm_get(3) <=0 {
			
			if input.key_jump or input.key_jump_pressed {
				alarm_set(3,global.onesecond*.2);
				wallrun = false;
			}
			
			if input.key_right and alarm_get(3) <= 0 {
				
				if !wallrun && vsp == 0 && (tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom)) and tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top)  and !tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top-1) and (!tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom-sprite_height*2) or !tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_bottom+sprite_height+1) ) /*or !tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom+sprite_height+1))*/ and ( tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top) or tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top) ) { 
					vault_delay--;
					if vault_delay <= 0 and tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top) == 1 {
						y -= (sprite_height/2);
						if tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom) {
							y -= sprite_height/2;
						}
						if !tilemap_get_at_pixel(global.tilemap,bbox_right+TILE_SIZE+1,bbox_bottom+1) {
							hop = 1;
							hop_dir = 1;//show_message("boas")
							if alarm_get(2) == -1 then alarm_set(2,global.onesecond*.15);
						}
						vault_delay = 2;
					}			
					
				} else if (wallrun and !wallrun_locked) or (!wallrun_locked and tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom) and tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top-sprite_height/2) ) {
					if !wallrun then alarm_set(1,global.onesecond*.65);
					
					if tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top-wallrun_spd) and !tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_top-wallrun_spd) { //+15
						image_xscale = 1;
						wallrun = true;
						if tilemap_get_at_pixel(global.tilemap,bbox_right+1,y-wallrun_spd) {
							y -= wallrun_spd;
						} /*else { 
							y -= wallrun_spd/2;
						}*/
						wallrun_height += wallrun_spd;
						wallrun_dir = 1;
						
						//if tilemap_get_at_pixel(global.tilemap,x,bbox_bottom)
						if wallrun_height >= (sprite_height*2) or tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_top-16) or tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_top-16)/*+96*/ {
							wallrun = false;
							wallrun_height = 0;
							wallrun_locked = true;
						}
						if  !tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top-15) //( is_free && not_free) 
						{
							hsp = 0;
							vsp = 0;
							sprite_index = sPlayer_Ledge;
							//Snap to ledge based on sprite origin
							while !(tilemap_get_at_pixel(global.tilemap,bbox_right+1,y))  {
								++x;
							}
							while !(tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top))  {
								++y;
							}
							//y-=15;
							// Make sure we are the correct vertical position against the ledge
							
							state = PLAYERSTATE.LEDGE_GRAB;
							exit;
						}
					} 
				}
			} else if input.key_left and alarm_get(3) <=0 {
				if !wallrun && vsp == 0 and (tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_bottom)) and tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top) and !tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top-1) and (!tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_bottom-sprite_height*2) or !tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_bottom+sprite_height+1)) and ( tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top) or tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top) ) {//and ( tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_bottom-(sprite_height/2)) or tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom-(sprite_height/2)) ) {
					vault_delay--;//x-=1;
					if vault_delay <= 0 and tilemap_get_at_pixel(global.tilemap,bbox_left-2,bbox_top) == 1 {
						y -= sprite_height/2;
						if tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom) {
							y -= sprite_height/2;
						}
						if !tilemap_get_at_pixel(global.tilemap,bbox_left-(TILE_SIZE+1),bbox_bottom+1) {
							hop = 1;
							hop_dir = -1;
							if alarm_get(2) == -1 then alarm_set(2,global.onesecond*.15);
						}
						vault_delay = 1;
					}				
				} else if (wallrun and !wallrun_locked) or (!wallrun_locked and tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_bottom) and tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top-sprite_height/2) ) {
					
					if !wallrun then alarm_set(1,global.onesecond*.65);
					
					if tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top-wallrun_spd) and !tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_top-wallrun_spd) { //+15
						image_xscale = -1;
						wallrun = true;
						if tilemap_get_at_pixel(global.tilemap,bbox_left-1,y-wallrun_spd) {
							y -= wallrun_spd;
						} /*else { 
							y -= wallrun_spd/2;
						}*/
						wallrun_height += wallrun_spd;
						wallrun_dir = 1;
						if wallrun_height >= sprite_height*2 or tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_top-16) or tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_top-16) {
							wallrun = false;
							wallrun_height = 0;
							wallrun_locked = true;
						}
						if  !tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top-16) //( is_free && not_free) 
						{
							hsp = 0;
							vsp = 0;
							sprite_index = sPlayer_Ledge;
							//Snap to ledge based on sprite origin
							while !(tilemap_get_at_pixel(global.tilemap,bbox_left-1,y))  {
								--x;
							}
							//y-=12;
							while !(tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top))  {
								++y;
							}
							// Make sure we are the correct vertical position against the ledge
							
							state = PLAYERSTATE.LEDGE_GRAB;
							exit;
						}
					} 
				}
			} 
			else {
				vault_delay = global.onesecond*.25;
				wallrun = false;
			}
			//rep
			if input.key_jump or input.key_jump_pressed {
				alarm_set(3,global.onesecond*.2);
				wallrun = false;
			}
	}
	var _onwallalt = max( (tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y) > 0), (tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y) > 0) );
	//(tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y)) or (tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y)) /*or (tilemap_get_at_pixel(global.tilemap,bbox_right+1,y)) or (tilemap_get_at_pixel(global.tilemap,bbox_left-1,y))*/ > 0;
	if _onwallalt && hop == 0 and state != PLAYERSTATE.LEDGE_GRAB and !input.key_down_held and alarm_get(3) <=0  {
			
			if input.key_jump or input.key_jump_pressed {
				alarm_set(3,global.onesecond*.2);
				wallrun = false;
			}
			if input.key_right and alarm_get(3) <=0 {
				
				if !wallrun && vsp == 0 && !tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_top-1) and !tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom+sprite_height+1) and tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom-63) and tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom) and tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom-1) and tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom-2) { 
					vault_delay--;
					if vault_delay <= 0 {
						y -= (sprite_height/2)-1;
						if tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom)  {
							y -= (sprite_height/2)-1;
						}
						if !tilemap_get_at_pixel(global.tilemap64,bbox_right+SEC_TILE_SIZE+1,bbox_bottom+1) {
							hop = 1;
							hop_dir = 1;
							if alarm_get(2) == -1 then alarm_set(2,global.onesecond*.15);
						}
						vault_delay = 3;
					}					
					
				} else if (wallrun and !wallrun_locked) or (!wallrun_locked and tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom) and !tilemap_get_at_pixel(global.tilemap64,bbox_right-2,bbox_bottom) and tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_top-sprite_height/2) ) {
					
					if !wallrun then alarm_set(1,global.onesecond*.65);
					
					if tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_top-wallrun_spd-10) and !tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_top-wallrun_spd) { //+15
						image_xscale = 1;
						wallrun = true;
						if tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y-wallrun_spd) {
							y -= wallrun_spd;
						} else { 
							y -= wallrun_spd/2;
						}
						
						wallrun_height += wallrun_spd;
						wallrun_dir = 1;
						if wallrun_height >= sprite_height*2 {
							wallrun = false;
							wallrun_height = 0;
							wallrun_locked = true;
						}
					
						if  !tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_top-15) and !tilemap_get_at_pixel(global.tilemap,x,bbox_top-50) //( is_free && not_free) 
						{
							hsp = 0;
							vsp = 0;
							sprite_index = sPlayer_Ledge;
							//Snap to ledge based on sprite origin
							while !(tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y))  {
								++x;
							}
							y-=12;
							// Make sure we are the correct vertical position against the ledge
							state = PLAYERSTATE.LEDGE_GRAB;
							exit;
						}
					}
				}
				
			} else if input.key_left and alarm_get(3) <=0 {
				
				if !wallrun && vsp == 0 and !tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_top-1) and !tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom+sprite_height+1) and tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom-63) and tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom) and tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom-1) and tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom-2) { //tilemap_get_at_pixel(global.tilemap64,bbox_right+1,bbox_bottom+(sprite_height/2))  {
					vault_delay--;
					
					if vault_delay <= 0 {
						y -= (sprite_height/2)-1;
						if tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom) {
							y -= (sprite_height/2)-1;
						}
						if !tilemap_get_at_pixel(global.tilemap,bbox_left-(TILE_SIZE+1),bbox_bottom+1) {
							hop = 1;
							hop_dir = -1;
							if alarm_get(2) == -1 then alarm_set(2,global.onesecond*.15);
						}
						vault_delay = 3;
					}					
				} else if (wallrun and !wallrun_locked) or (!wallrun_locked and tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_bottom) and !tilemap_get_at_pixel(global.tilemap64,bbox_left+2,bbox_bottom) and tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_top-sprite_height/2) ) {
					
					if !wallrun then alarm_set(1,global.onesecond*.65);
					
					if tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_top-wallrun_spd-10) and !tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_top-wallrun_spd) { //+15
						image_xscale = -1;
						wallrun = true;
						if tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y-wallrun_spd) {
							y -= wallrun_spd;
						} else { 
							y -= wallrun_spd/2;
						}
						
						wallrun_height += wallrun_spd;
						wallrun_dir = 1;
						if wallrun_height >= sprite_height*2 {
							wallrun = false;
							wallrun_height = 0;
							wallrun_locked = true;
						}
						
						if  !tilemap_get_at_pixel(global.tilemap64,bbox_left-1,bbox_top-16) and !tilemap_get_at_pixel(global.tilemap,x,bbox_top-50) //( is_free && not_free) 
						{
							hsp = 0;
							vsp = 0;
							sprite_index = sPlayer_Ledge;
							//Snap to ledge based on sprite origin
							while !(tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y))  {
								--x;
							}
							y-=12;
							// Make sure we are the correct vertical position against the ledge
							state = PLAYERSTATE.LEDGE_GRAB;
							exit;
						}
					} 
				}
			} 
			else {
				vault_delay = global.onesecond*.25;
				wallrun = false;
			}
			//rep
			if input.key_jump_pressed or input.key_jump {
				alarm_set(3,global.onesecond*.2);
				wallrun = false;
				
			}
	}
	
	//Vault
	if alarm_get(2) <= 0 and hop == 1 {
		//x+=32+16;
		hop = 2;
		switch hop_dir {
			case 1: alarm_set(2,global.onesecond*.14); break;
			case -1: alarm_set(2,global.onesecond*.11); break;
		}
		
	}  
	if alarm_get(2) > 0 and hop == 2 {
		
		switch hop_dir {
			case 1: x+=hop_spd; break;
			case -1: x-=hop_spd; break;
		}
		
	}
	if alarm_get(2) == -1 and hop == 2 {
		hop = 0;
	}
	
	//Sprites and Animation
	var dash = instance_create_layer(x,y,"Entities",oGhostTrail)
	image_speed = 1;
	if (hsp != 0) image_xscale = sign(hsp);

	if y == yprevious && sprite_index == sPlayer_Slam {
		sprite_index = sPlayer;
		vsp = 0;
	}
	
	if (grounded /*or grounded_sld*/) && (!crouch) && (dashtimer == 0) 
	{
		if (hsp = 0) && (vsp = 0)
		{
		sprite_index = sPlayer;
		}
		if (hsp != 0 )
		{
		sprite_index = sPlayer_Run;	
		}
		if sprite_index == sPlayer_U
		{
			sprite_index = sPlayer;
		}
	}
	if (!grounded /*and !grounded_sld*/) && (dashtimer == 0)
	{
		if (vsp > vsp_max )
		{
				if sprite_index == sPlayer_Ledge {
					var _xoff = 6;
					if image_xscale == 1 then x+=_xoff; else x-=_xoff;
				}
				
				sprite_index = sPlayer_Slam;
				/*if tilemap_get_at_pixel(global.tilemap,x,y) or tilemap_get_at_pixel(global.tilemap64,x,y) or tilemap_get_at_pixel(global.tilemap,x,bbox_top) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) {
					vsp = 0;
					alarm_set(9, global.onesecond*.5);
				}*/
				dash.sprite_index = sprite_index;
				dash.image_index = image_index;
				screenshake(1,5);
				
				if tilemap_get_at_pixel(global.tilemap,bbox_right,y) or tilemap_get_at_pixel(global.tilemap64,bbox_right,y) {
					x-=3;
				}
		}
		if ( tilemap_get_at_pixel(global.tilemap,bbox_right+1,y) or tilemap_get_at_pixel(global.tilemap,bbox_left-1,y) or tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y) or tilemap_get_at_pixel(global.tilemap64,bbox_left-1,y)) && (vsp <= vsp_max) && sprite_index != sPlayer_Slam 
		{
			hsp = 0;
			//(onwall != 0) &&  (vsp <= vsp_max)
		//		image_xscale = onwall; //THIS LINE IS MAKING THE BOX FLIP THE FUCK OUT WHEN LANDING ON SLOPES, WHYYYY? Shauns Wall Jumping w momentum video around min 11
			//if sprite_index != sPlayer_Wall && tilemap_get_at_pixel(global.tilemap,bbox_right+1,y) { 
			if  tilemap_get_at_pixel(global.tilemap,bbox_right+1,y) && sprite_index != sPlayer_Ledge && sprite_index != sPlayer_Slam && !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) && !tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) {
				while tilemap_get_at_pixel(global.tilemap,bbox_right,y) {
					x--;
				}
			}
			
			if  tilemap_get_at_pixel(global.tilemap64,bbox_right+1,y) && sprite_index != sPlayer_Ledge && sprite_index != sPlayer_Slam && !tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) && !tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) {
				while tilemap_get_at_pixel(global.tilemap64,bbox_right,y) {
					x--;
				}
			}
			//}
			sprite_index = sPlayer_Wall;
			
			var side = bbox_left;
			if (onwall == 1) side = bbox_right;
			
			dust++;
			if ((dust > 2) && (vsp > 0)) {
				
				if (onwall == 1) side = bbox_right;
				
				var _dust = instance_create_layer(side,bbox_top,"Entities",oDust);
				dust = 0;
				_dust.hspeed = -onwall*0.5;
				
			}
		}
		
		
		if (onwall == 0) && (vsp <= vsp_max)
		{
			if (vsp < 0)
			{
				dust = 0;
				sprite_index = sPlayer_F;	
			}
			else if vsp != 0
			{
				dust = 0;
				sprite_index = sPlayer_U;
				image_speed = 0;
				image_index = (vsp > 0);
			}
		}

	}
	
	if (crouch)
	{
		if (hsp <= hsp_walk or hsp >= -hsp_walk) && (hsp !=0)
		{
			sprite_index = sPlayer_Crawl;
		}
		if (hsp > hsp_walk or hsp < -hsp_walk)
		{
			sprite_index = sPlayer_Slide;
			//image_xscale = dir;deactivated cuz made it invisible
			var side = bbox_right;
			if (dir = 1) side = bbox_left;
			dust++;
			if ((dust > 2) && (hsp != 0)) with (instance_create_layer(side,bbox_bottom,"Entities",oDust))
			{
				other.dust = 0;
				hspeed = -dir*0.5;
			}
		}
		if (hsp = 0)
		{
			sprite_index = sPlayer_Crouch;
		}
	}
	
	if dashtimer > 0 
	{
		sprite_index = sPlayer_Dash;
		dash.sprite_index = sprite_index;
		dash.image_index = image_index;
		//if (hsp != 0) 
		dash.image_xscale = sign(hsp);
		screenshake(1,5);
	}
	if crouch and place_meeting(x,y-1,class_solid) {
		sprite_index = sPlayer_Crouch;
	}
	
	//Audio
	if ((dashtimer > 0) && (input.key_dash) && (hsp > hsp_max or hsp < -hsp_max))
	{
		audio_sound_pitch(snFlap,random_range(0.9,1.2))
		audio_play_sound(snFlap,5,false);
		if (!input.key_dash)
		{
			audio_stop_sound(snFlap)
		}
	}
	if (input.key_down or input.key_down_held) && (vsp > vsp_max)
	{
		
		if !audio_is_playing(snFlap) {
			audio_sound_pitch(snFlap,random_range(0.9,1.2))
			audio_play_sound(snFlap,5,false);
		}
		
	}
	
	//Collision End Checks for Ledge Grab
	var _yoff = 70;
	var slope_comp = place_meeting(x+2,y,oNotLedge) or place_meeting(x-2,y,oNotLedge);
	var was_free = !tilemap_get_at_pixel(global.tilemap,x+(40*hsp_dir),yprevious-_yoff);
	var not_free = tilemap_get_at_pixel(global.tilemap,x+(40*hsp_dir),y-_yoff);
	/*var was_free = !tilemap_get_at_pixel(global.tilemap,x+(68*hsp_dir),yprevious-_yoff);
	var not_free = tilemap_get_at_pixel(global.tilemap,x+(32*hsp_dir),y+_yoff);*/
	var moving_down = yprevious < y;
	if vault_delay == global.onesecond*.25 {
		if (was_free && not_free && moving_down /*&& !slope_comp*/ && !grounded && sprite_index != sPlayer_Slam ) && tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10) != 2 and !place_meeting(x,y+64,oDashUp) and tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top+1) != 3//&& !grounded_sld
		{
			hsp = 0;
			vsp = 0;
			
			//Snap to ledge based on sprite origin
			while !(tilemap_get_at_pixel(global.tilemap,x+hsp_dir,y))  {
				x+=hsp_dir;
			}
			
			// Make sure we are the correct vertical position against the ledge
			while tilemap_get_at_pixel(global.tilemap,x+(50*hsp_dir),y-56)  {
				y-=1;
			}
			if !tilemap_get_at_pixel(global.tilemap,bbox_right+1,y) {
				image_xscale = -1;
				hsp_dir = -1;
			}
			
			if tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10) != 2 and !place_meeting(x,y+64,oDashUp) and tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top+1) != 3 {
				state = PLAYERSTATE.LEDGE_GRAB;
				sprite_index = sPlayer_Ledge;
				if tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top+1) == 3 or tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10) == 2 {
					state = PLAYERSTATE.MOVE;
					exit;
				}
			
			} else if tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+10) == 2  {
				x+= 36;
			} else if place_meeting(x,y+64,oDashUp) {
				x-=36;
			}
			
			/*if tilemap_get_at_pixel(global.tilemap,bbox_left-1,bbox_top+16) == 2 or tilemap_get_at_pixel(global.tilemap,bbox_right+1,bbox_top+16) {
				state = PLAYERSTATE.LEDGE_GRAB;
			}*/
			
			//sprite_index = sPlayer_Ledge;
		}
	}
	
	var _yoff = 70;
	var was_free = !tilemap_get_at_pixel(global.tilemap64,x+(40*hsp_dir),yprevious-_yoff);
	var not_free = tilemap_get_at_pixel(global.tilemap64,x+(40*hsp_dir),y-_yoff);
	var moving_down = yprevious < y;
	if vault_delay == global.onesecond*.25 {
		if (was_free && not_free && moving_down && !grounded && sprite_index != sPlayer_Dash && sprite_index != sPlayer_Slam && !tilemap_get_at_pixel(global.tilemap64,x,y) && !tilemap_get_at_pixel(global.tilemap,x,bbox_top-90)) and tilemap_get_at_pixel(global.tilemap,bbox_right+2,bbox_top+1) != 3//&& !grounded_sld
		{
			hsp = 0;
			vsp = 0;
			
			//Snap to ledge based on sprite origin
			if tilemap_get_at_pixel(global.tilemap64,x+68,y) {
				while !(tilemap_get_at_pixel(global.tilemap64,x+hsp_dir,y)) {
					x+=hsp_dir;
				}
			} 
			
			if image_xscale == -1 { 
				//sprite_index = sPlayer_Ledge;
				//while (!tilemap_get_at_pixel(global.tilemap64,bbox_left-5,y)) {x--;}
				if !tilemap_get_at_pixel(global.tilemap64,x,y) and !tilemap_get_at_pixel(global.tilemap,x,y) {
					x-=31;
				}
			}
			
			// Make sure we are the correct vertical position against the ledge
			while tilemap_get_at_pixel(global.tilemap64,x+(50*hsp_dir),y-56) and !tilemap_get_at_pixel(global.tilemap,x,y-1) {
				y-=1;
			}
			
			sprite_index = sPlayer_Ledge;
			if (hsp != 0) image_xscale = sign(hsp);
			if !tilemap_get_at_pixel(global.tilemap64,x+(image_xscale*36),y) {
				if image_xscale == 1 then image_xscale = 0 else image_xscale = 1
			}
			while !tilemap_get_at_pixel(global.tilemap64,x+(image_xscale*1),y) {
					x += image_xscale;
			}
			
			if !tilemap_get_at_pixel(global.tilemap,x,y-60) and !tilemap_get_at_pixel(global.tilemap64,x,y) {
				state = PLAYERSTATE.LEDGE_GRAB;
			}
		}
	}
	if sprite_index != sPlayer_Wall {
		wallrun_height = 0;
	}
	
	/*if ( tilemap_get_at_pixel(global.tilemap,x,y) or tilemap_get_at_pixel(global.tilemap64,x,y) ) && (sprite_index == sPlayer_Dash or sprite_index == sPlayer_Slam ) {
		x = xprevious;
		y = yprevious;
	}*/
	
	if place_meeting(x,y,oNotLedge) and (sprite_index == sPlayer or sprite_index == sPlayer_Slide or sprite_index == sPlayer_U or sprite_index == sPlayer_Crouch or sprite_index == sPlayer_Crawl or sprite_index == sPlayer_Wall or sprite_index == sPlayer_F or sprite_index == sPlayer_Ledge or sprite_index == sPlayer_Slam) {
		if x < xprevious {
			if xprevious - x >= 8 and ( tilemap_get_at_pixel(global.tilemap,bbox_left,y) or tilemap_get_at_pixel(global.tilemap,bbox_right,y) or tilemap_get_at_pixel(global.tilemap64,bbox_left,y) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-6) or tilemap_get_at_pixel(global.tilemap64,bbox_right,y)  ) {
				x = xprevious;
				y = yprevious;
			}
		} else if x > xprevious {
			if x - xprevious >= 8 and ( tilemap_get_at_pixel(global.tilemap,bbox_left,y) or tilemap_get_at_pixel(global.tilemap,bbox_right,y) or tilemap_get_at_pixel(global.tilemap64,bbox_left,y) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-6) or tilemap_get_at_pixel(global.tilemap64,bbox_right,y)  ) {
				x = xprevious;
				y = yprevious;
			}
		} else if y > yprevious {
			if y - yprevious >= 8 and ( tilemap_get_at_pixel(global.tilemap,x,bbox_top) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-6) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top)) {
				x = xprevious;
				y = yprevious;
			}
		} else if y < yprevious {
			if yprevious - y >= 8 and ( tilemap_get_at_pixel(global.tilemap,x,bbox_top) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-6) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top)) {
				x = xprevious;
				y = yprevious;
			}
		}
	}
	
	//Move out Player sprite when facing to 64* tile
	if sprite_index == sPlayer_Crouch or sprite_index == sPlayer_Crawl {
		  switch image_xscale {
		  
			  case 1:
			  if tilemap_get_at_pixel(global.tilemap64,bbox_right,y+12) {
				while tilemap_get_at_pixel(global.tilemap64,bbox_right,y-1) {
					--x;
				}
			  }
			  break;
		  
			  case -1:
			  if tilemap_get_at_pixel(global.tilemap64,bbox_left,y+12) {
				while tilemap_get_at_pixel(global.tilemap64,bbox_left,y-1) {
					++x;
				}
			  }
			  break;
		  }
	}
	
	if sprite_index == sPlayer_U  {
		/*vault_delay = global.onesecond*.25;
		hop = false;
		hop_dir = 1;
		hop_spd = 32;//6 

		//Wallrun
		wallrun = false;
		wallrun_spd = 12;
		wallrun_height = 0;
		wallrun_locked = false;
		wallrun_dir = 1;*/
		if tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-2) { 
			//x = xprevious;
			//y-=128;
			while tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-2) { 
				y--;
			}
		}
	}
	
	if sprite_index == sPlayer_Dash  {
		/*vault_delay = global.onesecond*.25;
		hop = false;
		hop_dir = 1;
		hop_spd = 32;//6 
		//Wallrun
		wallrun = false;
		wallrun_spd = 12;
		wallrun_height = 0;
		wallrun_locked = false;
		wallrun_dir = 1;*/
		if tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-2) { 
			//x = xprevious;
			//y-=65;
			while tilemap_get_at_pixel(global.tilemap64,x,bbox_bottom-2) { 
				y--;
			}
		}
	}
	
	
}
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
function PlayerHitState() {
	//Event Variables
	var bbox_side;
	var p1,p2,slope;

	var dir = knockback_dir;
	var _subdir = dir;
	if dir == 0 {
		_subdir = 1;
	}
	//Calculate Current Status Early
	var grounded = (in_floor(global.tilemap,x,bbox_bottom+1) >= 0);  
	//var grounded = (tilemap_get_at_pixel(global.tilemap,x-16,bbox_bottom+1)) and (tilemap_get_at_pixel(global.tilemap,x+16,bbox_bottom+1)) >=0;
	var grounded_sld = !place_meeting(x,y+2,class_solid);
	var onwall = (tilemap_get_at_pixel(global.tilemap,bbox_right+1,y)) - (tilemap_get_at_pixel(global.tilemap,bbox_left-1,y));
	//var onwall = (tilemap_get_at_pixel(global.tilemap,bbox_right+1,y)) or (tilemap_get_at_pixel(global.tilemap,bbox_left-1,y)) > 0;


	//Calculate Horizantle Movement
	walljumpdelay = max(walljumpdelay-1,0);
	dashtimer = max(dashtimer-1,0);
	var crouch = (grounded /*or grounded_sld*/) && (input.key_down_held)
	var hsp_max_final = hsp_max;
	
	//Move
	if (walljumpdelay == 0) && (dashtimer == 0) 
	{
		hsp += dir * hsp_walk;
		
		hsp = clamp(hsp,-hsp_walk,hsp_walk)
	}

	
	//Calculate Verticle Movement
	var grav_final = grav;
	var vsp_max_final = vsp_max;
	if (onwall != 0) && (vsp > 0)
	{
		grav_final = grav_wall;	
		vsp_max_final = vsp_max_wall;
	}
	vsp += grav_final;
	vsp = clamp(vsp,-vsp_max_final,vsp_max_final);

	
	//Movement manipulation
	vsp = clamp(vsp,-vsp_max,vsp_max)

	if (vsp < 0) && (!input.key_jump) and (!input.key_dash) vsp = max(vsp,-vsp_jump/4);

	//Slam
	if (!grounded /*and !grounded_sld*/) && (input.key_down_held) && (!input.key_dash)
	{
		vsp = vsp_super_max;	
		if tilemap_get_at_pixel(global.tilemap,x,y+vsp) or tilemap_get_at_pixel(global.tilemap64,x,y+vsp) {
			vsp = 0;
		}
	}
	
	
	//Re apply fractions
	hsp += hsp_fraction;
	vsp += vsp_fraction;

	//Store and Remove fractions
	//Important: go into collision with whole integers ONLY!
	hsp_fraction = hsp - (floor(abs(hsp)) * sign(hsp));
	hsp -= hsp_fraction;
	vsp_fraction = vsp - (floor(abs(vsp)) * sign(vsp));
	vsp -= vsp_fraction;

	//Direction Check, used for ledgegrab after vertical collision
	if (hsp != 0) 
	{
		hsp_dir = sign(hsp);	
	}
	
	//Horizontal Collision
	
	//-Tiles-
	if (hsp > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
	p1 = tilemap_get_at_pixel(global.tilemap,bbox_side+hsp,bbox_top);
	p2 = tilemap_get_at_pixel(global.tilemap,bbox_side+hsp,bbox_bottom); 
	if (tilemap_get_at_pixel(global.tilemap,x,bbox_bottom) > 1) p2 = 0; //ignore bottom side tiles if on a slope.
	if (p1 == 1) || (p2 == 1) //Inside a tile with collision
	{
		if (hsp > 0) x = x - (x mod TILE_SIZE) + (TILE_SIZE-1) - (bbox_right - x);
		else x = x - (x mod TILE_SIZE) - (bbox_left - x);
		hsp = 0;
	}
	
	
	//-Objects-
	coll_sld_hor();
	x += hsp;

	//Vertical Collision
	//is this not a slope?
	//if vault_delay == global.onesecond*.25 {
	
		if (tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+vsp) <= 1)
		{
			if (vsp >= 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
			p1 = tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_side+vsp) 
			p2 = tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_side+vsp)
			if (p1 == 1) || (p2 == 1)
			{
				if (vsp >= 0) { 
				y = y - (y mod TILE_SIZE) + (TILE_SIZE-1) - (bbox_bottom - y);
				} else {
					y = y - (y mod TILE_SIZE) - (bbox_top - y);
				}
				vsp = 0;
				if sprite_index == sPlayer_U then grounded = true;
			}
		}
	
	//}
	
	if !wallrun or (input.key_jump or input.key_jump_pressed) {
		var floordist = in_floor(global.tilemap,x,bbox_bottom+vsp)
		if (floordist >= 0)
		{
			y += vsp;
			y -= (floordist+1);		
			vsp = 0;
			floordist = -1;
		}
		//-Solid coll-
		coll_sld_ver();
		y +=  vsp;
		
		//Walk down slopes
		if (grounded /*or grounded_sld*/)
		{
			y += abs(floordist)-1;
			//if at base of current tile
			if ((bbox_bottom mod TILE_SIZE) == TILE_SIZE-1)
			{
				// if slope continues
				if (tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+1) > 1)
				{
					//move there
					y += abs(in_floor(global.tilemap,x,bbox_bottom+1));
				}
			}
		}
	
	}
	//Collision End Checks for Ledge Grab
	var was_free = !tilemap_get_at_pixel(global.tilemap,x+(17*hsp_dir),yprevious-12);
	var not_free = tilemap_get_at_pixel(global.tilemap,x+(17*hsp_dir),y-12);
	var moving_down = yprevious < y;
	
		if (was_free && not_free && moving_down && !grounded ) ///&& !grounded_sld
		{
			hsp = 0;
			vsp = 0;
	
			//Snap to ledge based on sprite origin
			while !(tilemap_get_at_pixel(global.tilemap,x+hsp_dir,y))
			{
				x+=hsp_dir;
			}
	
			// Make sure we are the correct vertical position against the ledge
		
			while (tilemap_get_at_pixel(global.tilemap,x+(17*hsp_dir),y-13))
			{
				y-=1;
			}
	
			state = PLAYERSTATE.LEDGE_GRAB;
	
		}
	

	//Calculate Current Status Late
	if (grounded /*or grounded_sld*/) jumpbuffer = 6

	//Sprites and Animation
	var dash = instance_create_layer(x,y,"Entities",oGhostTrail)
	image_speed = 1;
	if (hsp != 0) image_xscale = sign(hsp);

	if (grounded /*or grounded_sld*/) && (!crouch) && (dashtimer == 0)
	{
		if (hsp = 0) && (vsp = 0)
		{
		sprite_index = sPlayer;
		}
		if (hsp != 0)
		{
		sprite_index = sPlayer_Run;	
		}
		if sprite_index = sPlayer_U
		{
			sprite_index = sPlayer;
		}
	}
	if (!grounded /*and !grounded_sld*/) && (dashtimer == 0)
	{
		if (vsp > vsp_max)
		{
				sprite_index = sPlayer_Slam;
				dash.sprite_index = sprite_index;
				dash.image_index = image_index;
				screenshake(1,5);
		}
		if (onwall != 0) && (vsp <= vsp_max)
		{
			sprite_index = sPlayer_Wall;
	//		image_xscale = onwall; //THIS LINE IS MAKING THE BOX FLIP THE FUCK OUT WHEN LANDING ON SLOPES, WHYYYY? Shauns Wall Jumping w momentum video around min 11
			var side = bbox_left;
			if (onwall == 1) side = bbox_right;
			
			
			dust++;
			if ((dust > 2) && (vsp > 0)) with (instance_create_layer(side,bbox_top,"Entities",oDust))
			{
				other.dust = 0;
				hspeed = -onwall*0.5;
			}
			
		}
		
		if (onwall == 0) && (vsp <= vsp_max)
		{
			if (vsp < 0)
			{
				dust = 0;
				sprite_index = sPlayer_F;	
			}
			else if vsp != 0
			{
				dust = 0;
				sprite_index = sPlayer_U;
				image_speed = 0;
				image_index = (vsp > 0);
			}
		}

	}
	if dashtimer > 0 && hsp !=0
	{
		sprite_index = sPlayer_Dash;
		dash.sprite_index = sprite_index;
		dash.image_index = image_index;
		if (hsp != 0) dash.image_xscale = sign(hsp);
		
		screenshake(1,5);
		
	}


}
	
	
	
