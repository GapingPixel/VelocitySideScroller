/// @description Build height table then start game

/*draw_tilemap(tilemapid,0,0);
for (var i = heightstoget-1; i >= 0; i--)
{
	var check = 0;
	while (check <= TILE_SIZE)
	{
			global.heights[i] = check;
			if (check == TILE_SIZE) break;
			if (surface_getpixel(application_surface,i,check) != c_black) break;
			check++;
	}
}

draw_tilemap(tilemapid64,0,128);
	for (var i = heightstoget64-1; i >= 0; i--)
	{
		var check = 0;
		while (check <= SEC_TILE_SIZE)
		{
			global.heights64[i] = check;
			if (check == SEC_TILE_SIZE) break;
			if (surface_getpixel(application_surface,i,check+128) != c_black) break;
			check++;
		}
	}*/
draw_tilemap(tilemapid,0,0);
for (var i = heightstoget-1; i >= 0; i--)
{
	var check = 0;
	while (check <= TILE_SIZE)
	{
			global.heights[i] = check;
			if (check == TILE_SIZE) break;
			if (surface_getpixel(application_surface,i,check) != c_black) break;
			check++;
	}
}

/*draw_tilemap(tilemapidslopes,0, 128);
for (var i = heightstogetslopes-1; i >= 0; i--)
{
	var check = 0;
	while (check <= TILE_SIZE)
	{
			global.heightsSlopes[i] = check;
			if (check == TILE_SIZE) break;
			if (surface_getpixel(application_surface,i,check+128) != c_black) break;
			check++;
	}
}*/

draw_tilemap(tilemapid64,0,128);
for (var i = heightstoget64-1; i >= 0; i--)
{
	var check = 0;
	while (check <= SEC_TILE_SIZE)
	{
		global.heights64[i] = check;
		if (check == SEC_TILE_SIZE) break;
		if (surface_getpixel(application_surface,i,check+128) != c_black) break;
		check++;
	}
}

room_goto_next();
/*
{
	draw_tilemap(tilemapid,0,0);
	for (var i = heightstoget-1; i >= 0; i--)
	{
		var check = 0;
		while (check <= (TILE_SIZE*2))
		{
			global.heights_slope[i] = check;
			if (check == (TILE_SIZE*2) ) break;
			if (surface_getpixel(application_surface,i,check) != c_black)
			{
				break;
			}
			check++;
		}
	}
}*/


//instance_destroy(id,false);