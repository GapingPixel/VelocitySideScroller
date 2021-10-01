if (done == 0)
{
	vsp = vsp + grv;

	//Horizantle Collision
	if (place_meeting(x+hsp,y,class_solid))
	{
		while (!place_meeting(x+sign(hsp),y,class_solid))
		{
			x = x + sign(hsp);
		}
		hsp = 0;
	}

	x = x + hsp;

	//Vertical Collision
	if (place_meeting(x,y+vsp,class_solid))
	{
		if (vsp > 0)
		{
			done = 1;
			image_index = 0;
		}
		while (!place_meeting(x,y+sign(vsp),class_solid))
		{
			y = y + sign(vsp);
		}
		vsp = 0;
	}

	y = y + vsp;

	//Animation
	if (vsp != 0)
	{
		sprite_index = sEnemyD
		image_speed = 0;
		if (vsp > 0) image_index = 0; else image_index = 0;

	}

	if (hsp !=0) image_xscale = sign(hsp);
}