global.onesecond = 60;
draw_set_font(fMenu);
randomize();

//Global variable used for room descriptions.
global.room_info = " ";

//Create debug object
//This is what writes the text to screen and enables keyboard controls.
//This object is persistent so it doesn't appear in the room editor anywhere.
//instance_create(0,0,cont_debug);