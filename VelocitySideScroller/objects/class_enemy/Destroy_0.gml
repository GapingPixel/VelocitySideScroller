/// @description Generate Spawn
// You can write your code in this editor
randomize();
var _ammount = irandom_range(0,5);

repeat _ammount {
	instance_create_depth(x-irandom_range(-10, -15), y-irandom_range(25, 0), class_player.depth-1, oOrb);
}