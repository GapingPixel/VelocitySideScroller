// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function coll_sld_hor() {
	var yslope = 0;
	if (place_meeting(x+ hsp, y, class_solid)) {
	    
	    while (place_meeting(x+hsp, y-yslope, class_solid) && yslope <= abs( hsp)) {
	        yslope++;
	    }
    
	    if (place_meeting(x+ hsp, y-yslope, class_solid)) {
	        // Move to contact and bounce
	        while (!place_meeting(x+sign( hsp), y, class_solid)) {
	            x+=sign( hsp);
	        }
        
	        // Update the horizontal speeds
	        hsp = 0;
			dashing_screenshake();
	    } else {
	        y-=yslope;
	    
		}	
	}
}

function coll_sld_ver() {
	if (place_meeting(x, y+ vsp, class_solid)) {
		while (!place_meeting(x, y+sign( vsp), class_solid)) {
			y+=sign( vsp);
		}
    // Update the vertical speeds
	 vsp = 0;
	 dashing_screenshake();
	}
}

function move_movement_entity() {
	var yslope = 0; // Used to calculate movement along a slope

	// Move down a slope
	if (!place_meeting(x+ hsp, y, class_solid) && abs( hsp) > 0 && place_meeting(x, y+1, class_solid)) {
	    while (!place_meeting(x+ hsp, y-yslope, class_solid) && yslope >= -abs( hsp)) {
	        yslope--;
	    }
    
	    // Make sure we actually need to move down
	    if (yslope != 0 && place_meeting(x+ hsp, y-yslope+1, class_solid)) {
	        y -= yslope;
	    }
	}

	// Horizontal check
	if (place_meeting(x+ hsp, y, class_solid)) {
	    
	    while (place_meeting(x+ hsp, y-yslope, class_solid) && yslope <= abs( hsp)) {
	        yslope++;
	    }
    
	    if (place_meeting(x+ hsp, y-yslope, class_solid)) {
	        // Move to contact and bounce
	        while (!place_meeting(x+sign( hsp), y, class_solid)) {
	            x+=sign( hsp);
	        }
        
	        // Update the horizontal speeds
	        hsp = 0;
		} else {
	        y-=yslope;
	    }
	}
	if (!place_meeting(x+ hsp, y, class_solid)) {
	    x +=  hsp;
	}

	// Vertical collision check
	if (place_meeting(x, y+ vsp, class_solid)) {
	    while (!place_meeting(x, y+sign( vsp), class_solid)) {
	        y+=sign( vsp);
	    }
    
	    // Update the vertical speeds
	     vsp = 0;
	}
	y +=  vsp;

}