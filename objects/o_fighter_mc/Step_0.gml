/// @description Movement, attacking, recieving attack

// pausing
if keyboard_check_pressed(vk_escape)
	instance_create_layer(0, 0, "GUI", o_pause_menu)


// read player inputs
fighter_input();

if (state == "normal") {
	// movement begin
	
	// getting directional inputs
	var horiz = fitr_right_held - fitr_left_held;
	var vert  = fitr_down_held - fitr_up_held;

	// acceleration
	if (horiz != 0){
		vel[0] = clamp(vel[0] + (fitr_accl * horiz), -x_max_vel, x_max_vel);
	}
	// decceleration
	else if (horiz == 0)
		//vel[0] += vel[0] + (-sign(vel[0]) * fitr_dccl);
		vel[0] = clamp(vel[0] + (-sign(vel[0]) * fitr_dccl), -x_max_vel, x_max_vel);
	
	
	// jumping miniFSM begin
	// NOTE: not very optimised I know, will change if needed after prototype
	// check if max jump reached or if up let go (if jumping of course)
	var y_delt = y_o - y;
	if ( (vert >= 0 && jumping) || (y_delt > fitr_jmp) )
		falling = true;
	
	// check air-ability
	if (jumping && fitr_up && !ability_used) {
		switch(air_ability) {
			case 1 : // double jump
				double_jump();
				break;
			case 2 : // air dash
				//air_dash(); //Only dash if not moving; maybe it should be double tap the direction (left or right) 
				break;
			default : break;
		}
	}
	
	// if up held and not falling
	if (vert < 0 && !falling) {
		// if jump not started start
		if (!jumping)
			jumping = true;
		// increase velocity upwards
		vel[1] = clamp(vel[1] + (fitr_jmp_accl * vert), -y_max_vel, y_max_vel);	
	}

	// check if falling
	if (falling)
		vel[1] = clamp(vel[1] + GRAV, -y_max_vel, y_max_vel);
		
	/*// check air-ability
	if (jumping && fitr_up) {
		switch(air_ability) {
			case 1 : // double jump
				y_o = y;
				y--; // so that it isn't mistaken for landing on floor
				falling = false;
				break;
			case 2 : // air dash
				vel[0] += fitr_dash * image_xscale;
				break;
			default : break;
		}
	}*/
		
	// apply velocities in regards to collisions
	apply_movement(vel[0], vel[1]);
	
	// since apply_movement can reset y_o, check if it was reset
	// NOTE: even though y_o can equal y in mid air (because of air abilities), you cannot use abilities again because of the falling boolean
	if (y_o == y) {
		falling = false;
		jumping = false;
		ability_used = false;
	}
	// jumping miniFSM end
	
	// movement end
}
