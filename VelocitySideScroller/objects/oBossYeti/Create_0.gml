/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
_Distance_count=0;
_HorOrientation=0;
_DistanceOr=0;
name="Yeti"
hp=16
tangible=0;
segundo=0;
count_seg=0;
image_alpha=1;
image_speed=0.3;
Occupied=0;
Immunity=0;
Immunity_Timer=120;
_Grounded=0;
CanJump=0;


seg_cap=0;
comp_capt=0;



enum BossYetiStates {

Cinematic,Stand, Walk, Lunge, Hurt, 
Dead, Shoot_Laser, Shoot_Paralyse,
FrontPunch, FloorPunch, Charge,TakeDistance

}

ActualYetiBossState=BossYetiStates.Cinematic;
SaveYetiState=0

anim_dur_cin=0;
AnimDurStand=0;
AnimDurWalk=0;
AnimDurLunge=0;
AnimDurHurt=0;
AnimDurDead=0;
AnimDurShootLaser=0
AnimDurShootParalyse=0
AnimDurFrontPunch=0;
AnimDurFloorPunch=0;
AnimDurCharge=0;
AnimDurTakeDistance=0;








