/// @description Makes caller perform air-dash
// NOTE: will add a trail behnd fighter since the movement is instant

// error checking if calling instance is a fighter object
// NOTE: I think we will only go one level in inheritence but if we go further we need to change how this works
var parent = object_get_parent(self);
if ( (object_get_name(self) != "o_fighter") && ( (parent >= 0) && (object_get_name(parent) != "o_fighter") ) ) {
	show_debug_message("Error in fighter_input(): calling object isn't a fighter\n");
	return -1;
}

var _vel = [self.fitr_dash * image_xscale, 0];
apply_movement(_vel[0], _vel[1]);
self.ability_used = true;
