/// @description Update camera

//Update destination
if (instance_exists(follow))
{
	xTo = follow.x;
	yTo = follow.y;
	
	if ((follow).object_index == oDeadPlayer)
	{
		x = xTo;
		y = yTo;
	
	}
}

//Update object position
x += (xTo - x) / 10;
y += (yTo - y) / 10;

//Keep camera center inside room
x = clamp(x,view_w_half+buff,room_width - view_w_half-buff);
y = clamp(y,view_h_half+buff,room_height - view_h_half-buff);

//Screen Shake
x += random_range(-shake_remain,shake_remain);
y += random_range(-shake_remain,shake_remain);
shake_remain = max(0,shake_remain-((1/shake_length)*shake_magnitude));

//Update camera view
camera_set_view_pos(cam,x-view_w_half,y-view_h_half);


//Depth
if (layer_exists("Backgrounds1"))
{
	layer_x("Backgrounds1",x)	
}

if (layer_exists("Backgrounds2"))
{
	layer_x("Backgrounds2",x)	
}

if (layer_exists("Backgrounds3"))
{
	layer_x("Backgrounds3",x/1.025)	
}

if (layer_exists("Backgrounds4"))
{
	layer_x("Backgrounds4",x)	
}

if (layer_exists("Backgrounds5"))
{
	layer_x("Backgrounds5",x/1.075)	
}

if (layer_exists("Backgrounds6"))
{
	layer_x("Backgrounds6",x)	
}

if (layer_exists("Backgrounds7"))
{
	layer_x("Backgrounds7",x/1.125)	
}

if (layer_exists("Backgrounds8"))
{
	layer_x("Backgrounds8",x)	
}