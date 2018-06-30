/// @description Movement, attacking, recieving attack

// pausing
if keyboard_check_pressed(vk_escape)
	instance_create_layer(0, 0, "GUI", o_pause_menu)

// read player inputs
fighter_input();

// getting directional inputs
var horiz = fitr_right_held - fitr_left_held;
var vert  = fitr_down_held - fitr_up_held;

// redoing state machine toincorporate jumping/falling smoothly
if (state == fighter_state.normal) {
	/*// getting directional inputs
	var horiz = fitr_right_held - fitr_left_held;
	var vert  = fitr_down_held - fitr_up_held;*/
	
	// acceleration
	if (horiz != 0) 
		vel[0] = clamp(vel[0] + (fitr_accl * horiz), -x_max_vel, x_max_vel);
	// decceleration
	else if (horiz == 0)
		//vel[0] += vel[0] + (-sign(vel[0]) * fitr_dccl);
		vel[0] = clamp(vel[0] + (-sign(vel[0]) * fitr_dccl), -x_max_vel, x_max_vel);
	
	// crouching
	if (vert > 0)
		sprite_index = s_fighter_crouch_placeholder; // crouch
	else
		sprite_index = s_fighter_placeholder; // stand
	
	// move state to jumping
	if (vert < 0) {
		state = fighter_state.jumping;
		y_o = y;
	}
		
	// testing exit keyword, should end this step event and continue rest of game loop
	exit;
}

if (state == fighter_state.jumping) {
	// calculate change from floor level of jump
	var y_delta = y_o - y;
	// while up held and height below limit, accel upwards
	if ( fitr_up_held && (y_delta <= fitr_jmp ) ) {
		vel[1] = clamp(vel[1] + (fitr_jmp_accl * vert), -y_max_vel, y_max_vel);
		// if kick inputted, do air kick
		if (fitr_kick) 
			state = fighter_state.air_kicking;
	}
	// if up let go or height limit reach, fall
	else
		state = fighter_state.falling;
	// if state changed then exit step event
	if state != fighter_state.jumping
		exit;
}

if (state == fighter_state.falling) {
	if (place_meeting(x, y + 1, o_collision))
		state = fighter_state.normal;
	if (fitr_kick) 
		state = fighter_state.air_kicking;
}



/*
// movement begin
if (state == "normal") {
	// movement begin
	
	// getting directional inputs
	var horiz = fitr_right_held - fitr_left_held;
	var vert  = fitr_down_held - fitr_up_held;
	
	// acceleration
	if (horiz != 0) 
		vel[0] = clamp(vel[0] + (fitr_accl * horiz), -x_max_vel, x_max_vel);
	// decceleration
	else if (horiz == 0)
		//vel[0] += vel[0] + (-sign(vel[0]) * fitr_dccl);
		vel[0] = clamp(vel[0] + (-sign(vel[0]) * fitr_dccl), -x_max_vel, x_max_vel);
	
	// crouching
	if (vert > 0)
		sprite_index = s_fighter_crouch_placeholder; // crouch
	else
		sprite_index = s_fighter_placeholder; // stand
	
	// jumping miniFSM begin
	// NOTE: might just make jumping a state in the regular FSM since that can help vert movement to stop/reduce
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
				air_dash();
				//if (horiz == 0) air_dash(); //Only dash if not moving
				break;
			default : break;
		}
	}
	
	// check if up pressed to start jump; to stop continous jumping if up held; NOTE: still continous jumping
	if (!jumping && !falling && fitr_up)
		jumping = true;
		
	// if up held and not falling
	if (vert < 0 /*&& !falling) {*/
		// if jump not started start
		/*if (!jumping)		moved up
			jumping = true;
		// increase velocity upwards
		vel[1] = clamp(vel[1] + (fitr_jmp_accl * vert), -y_max_vel, y_max_vel);
	}

	// check if falling
	if (falling)*/
		vel[1] = clamp(vel[1] + GRAV, -y_max_vel, y_max_vel);		
	
	/*
	// apply velocities in regards to collisions
	apply_movement(vel[0], vel[1]);
	
	// once we know we are on floor, remove any possible verticle momentum and reset jump FSM
	if (place_meeting(x, y + 1, o_collision)) {
		falling = false;
		jumping = false;
		ability_used = false;
		vel[1] = 0;
	}
	*/
	// jumping miniFSM end
	
	// movement end
	
	// attacking begin
//}

// apply velocities in regards to collisions
apply_movement(vel[0], vel[1]);

// once we know we are on floor, remove any possible verticle momentum and reset jump FSM
if (place_meeting(x, y + 1, o_collision)) {
	falling = false;
	jumping = false;
	ability_used = false;
	vel[1] = 0;
}
//else if (y_delt <= 0)
//	falling = true;