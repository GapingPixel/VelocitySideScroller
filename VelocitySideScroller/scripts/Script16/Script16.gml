///@arg intensity
///@arg duration
function add_screenshake(_intensity, _duration) {

	if not instance_exists(oCamera) exit;

	with (oCamera)
	{
		screenshake_ = _intensity;
		alarm[0] = _duration;
	}

}
