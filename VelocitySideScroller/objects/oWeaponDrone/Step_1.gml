/// @desc Drone Position

//Movement
if point_distance(x, y, oPlayer.x-20, oPlayer.y-10) > 35
    {
    move_towards_point(oPlayer.x-20, oPlayer.y-10, 16) 
	
    }


else speed = 0;

image_angle = point_direction(x,y,mouse_x,mouse_y);



//Firing Controls & Recoil
firingdelay = firingdelay - 1;
recoil = max(0,recoil - 1);

if (mouse_check_button(mb_left)) and (firingdelay < 0)
{
	recoil = 4;
	firingdelay = 3
	screenshake(2,10);
	audio_sound_pitch(snLanding,choose(0.8,1.0,1.2));
	audio_play_sound(snShot,5,false);
	audio_play_sound(snLaser,5,false);
	with (instance_create_layer(x,y,"Bullets",oBullet))
	{
		speed = 25;
		direction = other.image_angle + random_range(-5,5)
		image_angle = direction;
	}
}

x = x - lengthdir_x(recoil,image_angle);
y = y - lengthdir_y(recoil,image_angle);

if (image_angle > 90) and (image_angle < 270)
{
	image_yscale = -1;	
}
else
{
	image_yscale = 1;
}