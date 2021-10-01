/// @description Insert description here
// You can write your code in this editor
if !instance_exists(oPlayer) then exit;

var pc;
pc = (oPlayer.hp / oPlayer.maxhp) * 100;
draw_healthbar(40, 40, 380, 80, pc, c_black, c_red, c_red, 0, true, false);
var stm = (oPlayer.energy / oPlayer.maxenergy) * 100;
draw_healthbar(40, 110, 380, 150, stm, c_black, c_blue, c_blue, 0, true, false);

draw_sprite(sHudOrb,0,410,30);
draw_text_color(530,105,string(oPlayer.orb_count),c_white,c_white,c_white,c_white,1);