///hitpoints
if (hp <= 0)
{
	instance_destroy();
	with area {
		instance_destroy();
	}
}