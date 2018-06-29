/// @description resets values in fighter objects to allow an extra jump

// error checking if calling instance is a fighter object
// NOTE: I think we will only go one level in inheritence but if we go further we need to change how this works
var parent = object_get_parent(self);
if ( (object_get_name(self) != "o_fighter") && ( (parent >= 0) && (object_get_name(parent) != "o_fighter") ) ) {
	show_debug_message("Error in fighter_input(): calling object isn't a fighter\n");
	return -1;
}

self.y_o = y;
self.y--; // so that it isn't mistaken for landing on floor
self.falling = false;
self.ability_used = true;