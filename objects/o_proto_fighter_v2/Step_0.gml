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
		// up in-air activates air ability
		if (fitr_up && !air_ability_used && (air_ability > 0))
			state = fighter_state.air_ability;
	}
	// if up let go or height limit reached, fall
	else
		state = fighter_state.falling;
		
	// if up held and punch made, then do an up-air attack
	if (fitr_up_held && fitr_punch)
		state = fighter_state.air_up_punch;
		
	exit;
}

if (state == fighter_state.falling) {
	// check if on floor to change state to normal movement
	if (place_meeting(x, y + 1, o_collision)) {
		state = fighter_state.normal;
		air_ability_used = false;
	}
	// kicking in air performs an air kick
	if (fitr_kick) 
		state = fighter_state.air_kicking;
	// up in-air activates air ability
	if (fitr_up && !air_ability_used && (air_ability > 0))
			state = fighter_state.air_ability;	
	exit;
}

// air abilities are only dashing and double jumping so far (or forever)
// NOTE: past functions to double-jump or dash are now obsolete in this new FSM
if (state == fighter_state.air_ability) {
	// 1: double jump
	if (air_ability == 1) {
		// basically reset jump
		y_o = y;
		state = fighter_state.jumping;
		// air ability only used once per being in mid-air
		air_ability_used = true;
	}
	// 2: air-dash
	else if (air_ability == 2) {
		// move instantly ahead in facing direction (applying collisions as well)
		apply_movement(facing * fitr_dash, 0);
		// stop all previous forward momentum
		vel[0] = 0;
		// create an object for the dash visual effect itself; shouldn't cause performance probs
		var _dash = instance_create_layer(x + (-sign(facing) * (sprite_width / 2)), y, "Instances", o_dash_wind);
		_dash.x += -sign(facing) * (_dash.sprite_width / 2);
		_dash.image_xscale *= facing * (fitr_dash / _dash.sprite_width);
		// air ability only used once per being in mid-air
		air_ability_used = true;
		state = fighter_state.falling;
	}
	// by default if you somehow ended up here without ability, just fall
	else
		state = fighter_state.falling;
	
	exit;
}

// up air-attack
if (state == fighter_state.air_up_punch) {
	// create punch hitbox if not made yet
	if (punch_hitbox == -1) {
		punch_hitbox = instance_create_depth(x, y - (sprite_height / 2), depth - 1, o_fighter_punch_hitbox);
		punch_hitbox.creator = self;
	}
	// if it is, check if it is done existing, then destroy
	else if (punch_hitbox.done) {
		instance_destroy(punch_hitbox);
		punch_hitbox = -1;
		// NOTE: for this, try setting state to falling since that returns us to normal if on ground
		state = fighter_state.falling;
	}
}

// air kick
// Q: are we still doing this?

if (state == fighter_state.air_kicking) {
	/*// create hitbox if not made yet
	if (kick_hitbox == -1) {
	
	}
	// if hitbox exists, check if still attacking; and if not then destory the hitbox and return to normal
	// NOTE: for this, try setting state to falling since that returns us to normal if on ground
	else {
	
	}*/
	state = fighter_state.falling; // for now until actually implimented
}  