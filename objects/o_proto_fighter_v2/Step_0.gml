/// @description Inputs and FSM

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
	// move state to jumping
	if (vert < 0) {
		state = fighter_state.jumping;
		y_o = y;
	}
	
	// check if not on platform anymore and fall
	if !(place_meeting(x + (sprite_width / 2), y + 1, o_collision) ||
		 place_meeting(x - (sprite_width / 2), y + 1, o_collision) )
		state = fighter_state.falling;
		
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
	// if up let go or height limit reached, fall
	else
		state = fighter_state.falling;
		
	exit;
}

if (state == fighter_state.falling) {
	if (place_meeting(x, y + 1, o_collision))
		state = fighter_state.normal;
	if (fitr_kick) 
		state = fighter_state.air_kicking;

	exit;
}
