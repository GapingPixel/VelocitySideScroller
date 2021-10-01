/// @description Insert description here
// You can write your code in this editor
var txt = "Press Space to toggle FXAA, left/right to change the strength";
if(fxaa_on) {
    txt += "#FXAA: On";
} else {
    txt += "#FXAA: Off";
}
txt += "#Strength: " + string(fxaa_strength);
draw_set_colour(c_black);
draw_text(5, 5, txt);
draw_set_colour(c_white);
draw_text(4, 4, txt);