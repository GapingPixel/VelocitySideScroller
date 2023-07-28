/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
if (!collision_rectangle(x-8,y,x+8,y+1,o_solid,false,false)) {
gravity=0.3 _Grounded=0
}

if (vspeed > 0) 
{var ground = collision_rectangle(x-8,y,x+8,y+speed,o_solid,false,false);
	if (ground) {y = ground.y;
		         vspeed=0;
				 gravity=0; 
				CanJump=1 
				 _Grounded=1} }




//if estado=1 and (distance_to_object(o_player)>=30) {if x<o_player.x{x+=vel_}  if x>o_player.x{x-=vel_} }

















