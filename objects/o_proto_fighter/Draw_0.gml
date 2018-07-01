/// @description Turning and Sprite-Changing

// turning if opposite direction is inputted
// NOTE: if this turns out to be a 1v1 fighting game then turning will be based
	// off of where opponent is
if (fitr_left && image_xscale > 0) {
	image_xscale = -1;
	//vel[0] = 0;
	}
else if (fitr_right && image_xscale < 0) {
	image_xscale = 1;
	//vel[0] = 0;
}

// make sure you're drawn!
draw_self();