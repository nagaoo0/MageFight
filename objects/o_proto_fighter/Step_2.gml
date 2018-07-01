/// @description Apply gravity and velocities

// apply gravity
vel[1] = clamp(vel[1] + GRAV, -y_max_vel, y_max_vel);

// apply velocities in regards to collisions
apply_movement(vel[0], vel[1]);