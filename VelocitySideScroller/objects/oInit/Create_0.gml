/// @description Game Setup
//Collision tiles
//Add all tiles to the screen

#macro TILE_SIZE 128
tiles = sprite_get_width(sColl) / TILE_SIZE;
heightstoget = tiles * TILE_SIZE;
//global.heights = [];

//Make Tile layer
var layerid = layer_create(0,"Tiles");
tilemapid = layer_tilemap_create(layerid,0,0,tColl,tiles,1);

//Create Tiles
//var data
var data
for (var i = 0; i <= tiles; i++)
{
	tilemap_set(tilemapid, i, i, 0);
	show_debug_message("Tile " + string(i) + " set");
}


//global.heights = [];

//////////////////////////////////////////////////////////////
//Make Tile layer
/*tilesslopes = sprite_get_width(sSlope) / TILE_SIZE;
heightstogetslopes = tilesslopes * TILE_SIZE;
var layeridSlopes = layer_create(0,"Slopes");
tilemapidslopes = layer_tilemap_create(layeridSlopes,0,0,tSlope,tilesslopes,1);

//Create Tiles
//var data
var data
for (var i = 0; i <= tilesslopes; i++)
{
	tilemap_set(tilemapidslopes, i, i, 0);
	show_debug_message("Tile " + string(i) + " set");
}*/



#macro SEC_TILE_SIZE 64
tiles64 = sprite_get_width(s64) / SEC_TILE_SIZE;
heightstoget64 = tiles64 * SEC_TILE_SIZE;
//global.heights = [];

//Make Tile layer
var layerid64 = layer_create(0,"Tiles64");
tilemapid64 = layer_tilemap_create(layerid,0,0,tColl64,tiles64,1);

//Create Tiles
//var data
var data
for (var i = 0; i <= tiles64; i++)
{
	tilemap_set(tilemapid64, i, i, 0);
	show_debug_message("Tile " + string(i) + " set");
}

