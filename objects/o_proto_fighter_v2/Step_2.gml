/// @description Apply gravity, decceleration and velocities

// getting directional inputs
var horiz = fitr_right_held - fitr_left_held;
var vert  = fitr_down_held - fitr_up_held;

// regular acceleration
if (horiz != 0) {
		vel[0] = clamp(vel[0] + (fitr_accl * horiz), -x_max_vel, x_max_vel);
		// slowed down accel from jump/crouch
		if (vert > 0)
			vel[0] /= 2;
}
// decceleration
else {
	vel[0] = clamp(vel[0] + (-sign(vel[0]) * fitr_dccl), -x_max_vel, x_max_vel);
	// stops "jitters" that result from reduced speed in crouch
	if (abs(vel[0]) <= 2)
		vel[0] = 0;
}
// apply gravity
vel[1] = clamp(vel[1] + GRAV, -y_max_vel, y_max_vel);

// apply velocities in regards to collisions
apply_movement(vel[0], vel[1]);
