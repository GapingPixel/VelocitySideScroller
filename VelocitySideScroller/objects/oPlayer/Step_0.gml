///Execute the player's state

//HP Regen
var _regen_value = .025;
hp = min(hp+_regen_value,maxhp);
energy = min(energy+_regen_value,maxenergy);

switch (state) {

	case PLAYERSTATE.MOVE:
	PlayerMoveCollideState();
	
	//Movement update for moving plats
	var _sol = instance_nearest(x,y,oSolid);
	if place_meeting(x,y+3,oSolid) {
		x+= _sol.hsp*2;
	}
	break;
	
	case PLAYERSTATE.LEDGE_GRAB:
	LedgeGrabState();
	break;
	
	case PLAYERSTATE.HIT:
	hsp += knockback_dir*3;
	PlayerHitState();
	if alarm_get(11) <= 0 {
		state = PLAYERSTATE.MOVE;
	}
	break;
	
	case PLAYERSTATE.STUN:
	
	break;
	
	case PLAYERSTATE.DASH:
	/*
	
	var bbox_side;
	var p1,p2,slope;
	var grounded = false;
	var _slpGrounded = false;
	
		
	if tilemap_get_at_pixel(global.tilemap,x+(vsp/4),y) or tilemap_get_at_pixel(global.tilemap64,x+(vsp/4),y) or tilemap_get_at_pixel(global.tilemap,x+(vsp/4),bbox_top) or tilemap_get_at_pixel(global.tilemap64,x,bbox_top+(vsp)) or tilemap_get_at_pixel(global.tilemap,x,bbox_bottom+(vsp)) or tilemap_get_at_pixel(global.tilemap64,x+(vsp/4),bbox_bottom) && (alarm_get(9) == -1) {
		vsp = 0;
		alarm_set(9, global.onesecond*.5);
	}
		
		
		
	//Movement manipulation
	vsp = clamp(vsp,-vsp_super_max,vsp_super_max)

	//if (vsp < 0) && (!input.key_jump) and (!input.key_dash) vsp = max(vsp,-vsp_jump/4);

	
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
	}	
		
	//ANim stuff
	var dash = instance_create_layer(x,y,"Entities",oGhostTrail)
	image_speed = 1;
	
	if vsp == vsp_super_max {
		sprite_index = sPlayer_Slam_Normal;
		dash.sprite_index = sprite_index;
		dash.image_index = image_index;
		dash.image_xscale = 1;
	} else if vsp == -vsp_super_max {
		sprite_index = sPlayer_Slam_Inverse;
		
		dash.sprite_index = sprite_index;
		dash.image_index = image_index;
		//if (hsp != 0) 
		dash.image_xscale = 1;
		
	} else if vsp == 0 {
		sprite_index = sPlayer_DashState;
		dash.sprite_index = sprite_index;
		dash.image_index = image_index;
		//if (hsp != 0) 
		dash.image_xscale = sign(hsp);
	}
	screenshake(1,5);
		
	if !place_meeting(x,y,class_dash) {
		state = PLAYERSTATE.MOVE;
	}*/
	var dash = instance_create_layer(x,y,"Entities",oGhostTrail)
	image_speed = 1;
	
	if (direction >= 357 and direction <= 360) or (direction >= 0 and direction <= 10) {
		sprite_index = sPlayer_DashState;
		image_xscale = 1;
	} else if direction >= 90 and direction < 91 {
		sprite_index = sPlayer_Slam_Inverse;
		image_xscale = 1;
	} else if direction >= 180 and direction < 181 {
		sprite_index = sPlayer_DashState;
		image_xscale = -1;
	} else if direction >= 270 and direction < 271 {
		sprite_index = sPlayer_Slam_Normal;
		image_xscale = 1;
	} 
	dash.sprite_index = sprite_index;
	dash.image_index = image_index;
	dash.image_xscale = image_xscale;
	
	
	if path_position == 1 {
		state = PLAYERSTATE.MOVE;
		alarm_set(6,global.onesecond*.1);
	}
	break;
	
	case PLAYERSTATE.DEATH:
	sprite_index = sPlayer_Death;
	break;

}
position = vect2(x,y);

//Screenshake at collision when dashing slamming 
/*if (sprite_index == sPlayer_Dash or sprite_index == sPlayer_Slam) and (
	tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_bottom) or tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_bottom) or
	tilemap_get_at_pixel(global.tilemap,bbox_left,bbox_top) or tilemap_get_at_pixel(global.tilemap,bbox_right,bbox_top) or
	tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_bottom) or tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_bottom) or
	tilemap_get_at_pixel(global.tilemap64,bbox_left,bbox_top) or tilemap_get_at_pixel(global.tilemap64,bbox_right,bbox_top) or
	place_meeting(x,y,class_enemy) ) {
	
		screenshake(6,global.onesecond*.5);

}

