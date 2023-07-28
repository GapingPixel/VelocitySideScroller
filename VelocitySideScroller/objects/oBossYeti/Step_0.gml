/// @description Inserte aquí la descripción
// Puede escribir su código en este editor




/*
enum BossYetiStates {

Cinematic,Stand, Walk, Lunge, Hurt, 
Dead, Shoot_Laser, Shoot_Paralyse,
FrontPunch, FloorPunch, Charge

}
BossYetiStates.Stand
BossYetiStates.Walk
BossYetiStates.Lunge
BossYetiStates.Hurt
BossYetiStates.Dead
BossYetiStates.Shoot_laser
BossYetiStates.Shooot_Paralyse
BossYetiStates.FrontPunch
BossYetiStates.FloorPunch
BossYetiStates.Charge
BossYetiStates.



ActualYetiBossState=BossYetiStates.Stand;

*/


if place_meeting(x,y,oSword) {if Tangible==1 {ActualYetiBossState=BossYetiStates.Hurt;}}



_HorOrientation=sign(image_xscale);



switch ActualYetiBossState {

case BossYetiStates.Cinematic:
break;



case BossYetiStates.Stand:
break;




case BossYetiStates.Walk:
break;




case BossYetiStates.Lunge:
break;





case BossYetiStates.Hurt:
Tangible=0; Occupied=1 
if AnimDurHurt=0 {sprite_index=sprYetiBossHurt image_index=0; image_speed=0.3; Immunity=1;} AnimDurHurt++;
if AnimDurHurt>20 {ActualYetiBossState=BossYetiStates.Stand; AnimDurHurt=0; Occupied=0;}


break;





case BossYetiStates.Dead:
break;





case BossYetiStates.Shoot_Laser:

Occupied=1;  SaveYetiState=BossYetiStates.Shoot_Laser; Tangible=1;  sprite_index=sprYetiBossShoot_1; 
if AnimDurShootLaser=0 { image_index=0 image_speed=0.3} AnimDurShootLaser++; 
if AnimDurShootLaser=20 {if !instance_exists(oYetiLaser) { var _LaserProjectile = instance_create_layer(x,y-32,"Instances",oYetiLaser) _LaserProjectile.hspeed=10*_HorOrientation;}}
if AnimDurShootLaser>=40{ActualYetiBossState=BossYetiStates.Stand; AnimDurShootLaser=0; Occupied=0;}


break;


case BossYetiStates.Shoot_Paralyse:

Occupied=1;  SaveYetiState=BossYetiStates.Shoot_Paralyse; Tangible=1;  sprite_index=sprYetiBossShoot_2; 
if AnimDurShootParalyse=0 { image_index=0 image_speed=0.3} AnimDurShootParalyse++; 
if AnimDurShootParalyse=20 {if !instance_exists(oYetiParalyse) { var _LaserProjectile = instance_create_layer(x,y-32,"Instances",oYetiParalyse)}}
if AnimDurShootParalyse>=40{ActualYetiBossState=BossYetiStates.Stand; AnimDurShootParalyse=0; Occupied=0;}


break;

case BossYetiStates.FrontPunch:
Occupied=1; SaveYetiState=BossYetiStates.FrontPunch; Tangible=1 sprite_index=sprYetiBossFrontPunch; 
if AnimDurFrontPunch=0 { image_index=0 image_speed=0.3} AnimDurFrontPunch++;
if AnimDurFrontPunch=20 {instance_create_layer((x+(20*_HorOrientation)),y-15,"Instances",oYetiHit)}
if AnimDurFrontPunch>=40 {ActualYetiBossState=BossYetiStates.Stand; AnimDurFrontPunch=0; Occupied=0;}
break;

case BossYetiStates.FloorPunch:
Occupied=1; SaveYetiState=BossYetiStates.FloorPunch; Tangible=1 sprite_index=sprYetiBossFloorPunch; 
if AnimDurFloorPunch=0 { image_index=0 image_speed=0.3} AnimDurFloorPunch++;
if AnimDurFloorPunch=20 {instance_create_layer((x+(20*_HorOrientation)),y,"Instances",oYetiHit)}
if AnimDurFloorPunch>=40 {ActualYetiBossState=BossYetiStates.Stand; AnimDurFloorPunch=0; Occupied=0;}
break;


case BossYetiStates.Charge:
break;

case BossYetiStates.TakeDistance:
Tangible=0; Occupied=1; sprite_index=sprYetiBossTakeDistance;  

AnimDurTakeDistance=0 {

if instance_exists(oPlayer){
if oPlayer.x>x { if !place_meeting(x-8,y,o_solid){ _DistanceOr=-1 } else { _DistanceOr=1} }
if oPlayer.x<x { if !place_meeting(x+8,y,o_solid){ _DistanceOr=1} else { _DistanceOr=-1 } }}} 

AnimDurTakeDistance++;

if (AnimDurTakeDistance>1 and AnimDurTakeDistance<=29) {if _DistanceOr=1 { x++;} 
                                                        else  {x--;}} 

if AnimDurTakeDistance==30 {ActualYetiBossState=BossYetiStates.TakeDistance; AnimDurTakeDistance=0; Occupied=0;}




break;

default :

}




///Limits to No Clip
if x<=48 {x=64}
if x>=752 {x=736}


///IMMUNITY
 if Immunity=1 { Tangible=0;  if Immunity_Timer>1 {Immunity_Timer--;} if Immunity_Timer<=1 {Immunity_Timer=120; Immunity=0;} }









