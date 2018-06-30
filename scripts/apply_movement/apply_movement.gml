/// @description Apply given velocity to calling object, with collsions

/// @param 2-cell velocity array

// an array is passed so that the values can be altered by refrence, allowing accl/deccl

// horizontal movement and collisions
if (place_meeting(x + argument[0], y, o_collision)) {
	while (!place_meeting(x + sign(argument[0]), y, o_collision)) {
		x += sign(argument[0]);
	}
	argument[0] = 0;
}

x += argument[0]

// verticle movement and collisions
if (place_meeting(x, y + argument[1], o_collision)) {
	while (!place_meeting(x, y + sign(argument[1]), o_collision)) {
		y += sign(argument[1]);
	}
	argument[1] = 0;
	// landing on floor; NOTE: no ceilings please
	//self.y_o = y;
}

y += argument[1];