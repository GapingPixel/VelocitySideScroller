// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SwordThrow() {
	
	with oPlayer {
			energy -= COST.THROW;
			if hsp == 0 {
				var _dir;
				if hsp_dir == 1 {
					_dir = 0;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else {
					_dir = 180;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
				}
				if input.key_right and input.key_up_held {
					_dir = 45;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
					
				} else if input.key_right and input.key_down_held {
					_dir = 315;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_left and input.key_up_held {
					_dir = 135;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_left and input.key_down_held {
					_dir = 225;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_down_held  {
					_dir = 270;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_up_held  {
					_dir = 90;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				}
				
				//var _thrsword = instance_create_depth(x,y,depth,oThrowedSword);
				
				
			} else {
				var _dir = 0;
				
				if input.key_right and input.key_up_held {
					_dir = 45;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
				} else if input.key_right and input.key_down_held {
					_dir = 315;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
				} else if input.key_left and input.key_up_held {
					_dir = 135;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_left and input.key_down_held {
					_dir = 225;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_left  {
					_dir = 180;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_right {
					_dir = 0;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_down_held  {
					_dir = 270;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				} else if input.key_up_held  {
					_dir = 90;
					var _seg = instance_create_depth(x,y,depth,oSegmentCollCheck);
					_seg.image_angle = _dir;
					_seg.direction = _dir;
					
				}
				
				
				/*_thrsword.direction = _dir;
				_thrsword.image_angle = _dir;*/
			}
			var _yoffset = 128;
				if oPlayer.vsp == 0 {
					var _thrsword = instance_create_depth(oPlayer.x+(128*oPlayer.image_xscale),y,depth,oThrowedSword);
				} if oPlayer.vsp > 0 {
					var _thrsword = instance_create_depth(oPlayer.x+(128*oPlayer.image_xscale),y+_yoffset,depth,oThrowedSword);
				} if oPlayer.vsp < 0 {
					var _thrsword = instance_create_depth(oPlayer.x+(128*oPlayer.image_xscale),y-_yoffset,depth,oThrowedSword);
				}
			_thrsword.direction = _dir;
			_thrsword.image_angle = _dir;
		}
}