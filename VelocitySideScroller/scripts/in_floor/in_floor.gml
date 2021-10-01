/// @description Checks to see if position is below the floor height of a given tile, returns how deep in floor
/// @arg tilemap
/// @arg x
/// @arg y
function in_floor(tilemap, x, y) {
	var pos = tilemap_get_at_pixel(tilemap,x,y);
	if (pos > 0)
	{
		if (pos == 1) { 
			return (y mod TILE_SIZE);  //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		}
		var thefloor = global.heights[(x mod TILE_SIZE) + pos*TILE_SIZE];
		return ((y mod TILE_SIZE) - thefloor);
	} else {
		return -(TILE_SIZE - (y mod TILE_SIZE));
	}

}

function in_floor_slopes(tilemap, x, y) {
	var pos = tilemap_get_at_pixel(tilemap,x,y);
	if (pos > 0)
	{
		if (pos == 1) { 
			return (y mod TILE_SIZE);  //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		}
		var thefloor = global.heightsSlopes[(x mod TILE_SIZE) + pos*TILE_SIZE];
		return ((y mod TILE_SIZE) - thefloor);
	} else {
		return -(TILE_SIZE - (y mod TILE_SIZE));
	}

}

function in_floor64(tilemap, x, y) {
	var pos = tilemap_get_at_pixel(tilemap,x,y);
	if (pos > 0)
	{
		if (pos == 1) { 
			return (y mod SEC_TILE_SIZE);//65 mod 64 1  //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		}
		//x 130 y 64+1 / 64+vsp
		// (130 mod 64) + 0*64  // (124 mod 64) + 1*64
		//       2 + 0 = 2  //  60 + 64 = 124
		var thefloor = global.heights64[((x mod SEC_TILE_SIZE) + pos*SEC_TILE_SIZE )  ];
		return ((y mod SEC_TILE_SIZE) - thefloor);
		// 1 - 2 = -1 // 1 - 128 = -127
	} else {
		return -(SEC_TILE_SIZE - (y mod SEC_TILE_SIZE));
		//       -(64   - 1) = -63
		
		//  - ( 128  -  130 mod 128) = -(128 -  2) = -126
	}

}
/*function in_floor(_tilemap, _x, _y) {
	var pos = tilemap_get_at_pixel(_tilemap,_x,_y);
	var _p1 = tilemap_get_at_pixel(_tilemap,bbox_left,_y) 
	var	_p2 = tilemap_get_at_pixel(_tilemap,bbox_right,_y)
	
	if (_p2 or _p1)
	{
		if (_p2 == 1 or _p1 == 1) return (_y mod (TILE_SIZE)); //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		var thefloor = global.heights[(_x mod TILE_SIZE) + pos*(TILE_SIZE)];
		return ( (_y mod (TILE_SIZE) ) - thefloor );
		//var _precComp = 1;
		//var thefloor = _x mod TILE_SIZE + (pos * TILE_SIZE);
		
		
		//2048 mod 128 + (0)=  0  --- 2048 mod 128 + 128 = 128 // 2000 mod 128 + 128 = 208
		//(global.heights[( ( _x/_precComp) mod (TILE_SIZE)) + (pos/_precComp) * (TILE_SIZE) ] );
	} else return -( (TILE_SIZE) - (_y mod (TILE_SIZE) ))
}*/

/*function in_floor(tilemap, argument1, y) {
	var pos = tilemap_get_at_pixel(_tilemap,_x,_y);
	var _p1 = tilemap_get_at_pixel(_tilemap,bbox_left,_y) 
	var	_p2 = tilemap_get_at_pixel(_tilemap,bbox_right,_y)
	
	
	var pos = tilemap_get_at_pixel(tilemap,x,y);
	if (pos > 0)
	{
		if (pos == 1) return (y mod TILE_SIZE); //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		var thefloor = global.heights[(argument1 mod TILE_SIZE) + pos*TILE_SIZE];
		return ((y mod TILE_SIZE) - thefloor);
	} else return -(TILE_SIZE - (y mod TILE_SIZE))

}*/
	/*if (_p2 or _p1)
	{
		if (_p2 == 1 or _p1 == 1) return (_y mod TILE_SIZE); //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		var thefloor = global.heights[_x mod TILE_SIZE + pos*TILE_SIZE];
		return ( (_y mod TILE_SIZE) - thefloor );
		//var _precComp = 1;
		//var thefloor = _x mod TILE_SIZE + (pos * TILE_SIZE);
		
		
		//2048 mod 128 + (0)=  0  --- 2048 mod 128 + 128 = 128 // 2000 mod 128 + 128 = 208
		//(global.heights[( ( _x/_precComp) mod (TILE_SIZE)) + (pos/_precComp) * (TILE_SIZE) ] );
		
		
	} else return -(TILE_SIZE - (_y mod TILE_SIZE))*/


/*var pos = tilemap_get_at_pixel(_tilemap,_x,_y);
	if (pos > 0)
	{
		if (pos == 1) return (_y mod TILE_SIZE); //solid block, would end up returning true anyway but this is FASTER, GOTTAGOFAST.
		var thefloor = global.heights[(_x mod TILE_SIZE) + pos*TILE_SIZE];
		return ((_y mod TILE_SIZE) - thefloor);
	} else return -(TILE_SIZE - (_y mod TILE_SIZE))
	*/
	
	

