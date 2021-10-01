/// @description Insert description here
// You can write your code in this editor
area.x = x;
area.y = y;
coll_box.x = x;
coll_box.y = y;

if (hp <= 0)
{
	instance_destroy();
	with area {
		instance_destroy();
	}
}