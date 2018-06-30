/// @description Creates a player fighter at given (x, y) and returns ID, returns -1 on error

/// @param x-pos
/// @param y-pos

if (global.player1_id < 0) {
	global.player1_id = instance_create_layer(argument0, argument1, "Instances", o_fighter);
	return 0;
}
else if (global.player2_id < 0) {
	global.player2_id = instance_create_layer(argument0, argument1, "Instances", o_fighter);
	return 0;
}
else {
	show_debug_message("Error creating player: Only 2 players at a time\n");
	return -1;
}