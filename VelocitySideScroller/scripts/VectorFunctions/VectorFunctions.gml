// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function vect4(x,y,z,a){
	var v;
	v[0] = 4;
	v[1] = x;
	v[2] = y;
	v[3] = z;
	v[4] = a;
	return v;
}

function vect3(x,y,z) {
	var v;
	v[0] = 3;
	v[1] = x;
	v[2] = y;
	v[3] = z;
	return v;
}

function vect2(x,y) {
	var v;
	v[2] = y;
	v[1] = x;
	v[0] = 2;
	return v;
}

function vect_truncate(_vec,_len) {
	if(vect_len(_vec)>_len)
    _vec=vect_scaler(_vec,_len);

	return(_vec);
}

function vect_to_vect4(v1) {
	//converts vect to a vect4
	var i;
	var v;

	var num = min(v1[0],4);
	v[0] = num;
	v[1] = 0;
	v[2] = 0;
	v[3] = 0;
	v[4] = 0;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i];
	}
	return v;
}

function vect_to_vect3(v1) {
	//converts vect to a vect3
	var i;
	var v;

	var num = min(v1[0],3);
	v[0] = num;
	v[1] = 0;
	v[2] = 0;
	v[3] = 0;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i];
	}
	return v;
}

function vect_to_vect2(v1) {
	//converts vect to a vect2
	var i;
	var v;

	var num = min(v1[0],2);
	v[0] = num;
	v[1] = 0;
	v[2] = 0;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i];
	}
	return v;

}

function vect_subtract(v1, v2) {
	//Subtracts each component of vect2 from each component of vect1
	var i;
	var v;

	var num = min(v1[0],v2[0]);
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]-v2[i];
	}
	return v;
}

function vect_scaler(vect, scale ) {
	//scales the vector to the distance specified

	var i;
	var v1 = vect_norm(vect);
	var v;

	var num = v1[0];
	var tot = 0;
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]*scale;
	}

	return v;
}

function vect_rev(v1) {
	//reverse direction for the vector

	var i;
	var v;

	var num = v1[0];
	var tot = 0;
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = -v1[i];
	}

	return v;
}

function vect_perp(v1) {
	//perpendicular vector for the vector
	var i;
	var v;

	var num = v1[0];
	v[0] = num;
	if(num ==2)
	{
	    v[1] = -v1[2];
	    v[2] = v1[1];
	}
	else if(num ==3)
	{
	    v = vect3(0,0,0);
	    show_debug_message("vect_perp, todo vect3")
	}
	else
	{
	    v = vect4(0,0,0,0);
	    show_debug_message("vect_perp, todo vect4")
	}

	return v;
}

function vect_norm(v1) {
	//normalises a scalar to vector 
	var i;
	var v;

	var num = v1[0];
	var tot = 0;
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = 0;
	    tot+=v1[i]*v1[i];
	}
	if(tot != 0)
	{
	    tot = sqrt(tot);
	    for(i=1; i<= num; i++)
	    {
	        v[i] = v1[i]/tot;
	    }
	}
	return v;
}

function vect_multr(v1, r) {
	//multiplies each component of vect by the value specified

	var i;
	var v;

	var num = v1[0];
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]*r;
	}
	return v;
}

function vect_mult(v1,v2) {
	//multiplies each component of vect1 with each component of vect2

	var i;
	var v;

	var num = min(v1[0],v2[0]);
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]*v2[i];
	}
	return v;
}

function vect_len(v1) {
	//returns the length of a scalar 
	var i;
	var num = v1[0];
	var tot = 0;
	for(i=1; i<= num; i++)
	{
	    tot+=v1[i]*v1[i];
	}
	if(tot != 0)
	{
	    tot = sqrt(tot);
	}
	return tot;
}

function vect_dot(v1, v2) {
	//returns the dot product between vect1 and vect2
	var i;
	var num = min(v1[0],v2[0]);
	var tot = 0;
	for(i=1; i<= num; i++)
	{
	    tot+=v1[i] * v2[i];
	}

	return tot;
}

function vect_divr(v1, r) {
	//divides each component of vect by the value specified

	var i;
	var v;
	var num = v1[0];
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]/r;
	}
	return v;
}

function vect_div(v1, v2) {
	//divide each component of vect1 by each component of vect2
	var i;
	var v;

	var num = min(v1[0],v2[0]);
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]/v2[i];
	}
	return v;
}

function vect_dist(v1, v2) {
	//returns the distance between vect1 and vect2
	var i;
	
	var num = min(v1[0],v2[0]);
	var tot = 0;
	for(i=1; i<= num; i++)
	{
	    tot+=v1[i]*v1[i] + v2[i] * v2[i];
	}
	if(tot != 0)
	{
	    tot = sqrt(tot);
	}
	return tot;
}

function vect_direction(_vec) {
	//returns direction of given vector
	if(_vec[1]==0 && _vec[2]==0)
	    return(-1);
	else
	    return(point_direction(0,0,_vec[1],_vec[2]));

}

function vect_cross(v1, v2) {
	//returns the cross product between vect1 and vect2
	var i;
	var num = min(v1[0],v2[0]);
	if(num ==2)
	{
	    var v3 = vect_cross(vect3(v1[1],v1[2],1),vect3(v2[1],v2[2],1));
	    v3[0] = 2;
	    return v3;
	}
	else if (num ==3)
	{
	    return vect3(v1[2] * v2[3] - v1[3] * v2[2], v1[3] * v2[1] - v1[1] * v2[3],v1[1] * v2[2] - v1[2] * v2[1]);
	}
	else
	{
	    show_debug_message("vect_cross todo vect4")
	    return vect4(0,0,0,0);
	}
	return 0;
}


function vect_add(v1 , v2) {
	//adds each component of vect1 with each component of vect2
	var i;
	var v;

	var num = min(v1[0],v2[0]);
	v[0] = num;
	for(i=1; i<= num; i++)
	{
	    v[i] = v1[i]+v2[i];
	}
	return v;
}

function speed_dir_to_vect2(_speed, _direction) {
	//returns a vect2 with the given arguments.
	var _x = lengthdir_x(_speed,_direction);
	var _y = lengthdir_y(_speed,_direction);

	return(vect2(_x,_y));

}


