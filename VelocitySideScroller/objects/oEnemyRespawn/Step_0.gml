/// @description Insert description here
// You can write your code in this editor
/*if !instance_exists(enemyType) {
	 instance_create_layer( x, y, "Enemies", enemyType);
}*/

if !instance_exists(enemyType) and alarm_get(0) == -1 {
	alarm_set(0,timer);
}