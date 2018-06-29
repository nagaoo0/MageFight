/// @description Reads/sets input for fighter class and subclasses

// error checking if calling instance is a fighter object
// NOTE: I think we will only go one level in inheritence but if we go further we need to change how this works
var parent = object_get_parent(self);
if ( (object_get_name(self) != "o_fighter") && ( (parent >= 0) && (object_get_name(parent) != "o_fighter") ) ) {
	show_debug_message("Error in fighter_input(): calling object isn't a fighter\n");
	return -1;
}

// NOTE: Once a startup menu/object is made,these inputs will be saved globally, not to object

// reset inputs
self.fitr_punch = false;
self.fitr_kick = false;
self.fitr_down = false;
self.fitr_up = false;
self.fitr_right = false;
self.fitr_left = false;
self.fitr_down_held = false;
self.fitr_up_held = false;
self.fitr_right_held = false;
self.fitr_left_held = false;

// single-pressed inputs (for  attacks & combos)
self.fitr_punch = keyboard_check_pressed(ord("J"));
self.fitr_kick	= keyboard_check_pressed(ord("K"));
self.fitr_down  = keyboard_check_pressed(ord("S"));
self.fitr_up	= keyboard_check_pressed(ord("W"));
self.fitr_right = keyboard_check_pressed(ord("D"));
self.fitr_left  = keyboard_check_pressed(ord("A"));

// held-down inputs (for movement)
self.fitr_down_held  = keyboard_check(ord("S"));
self.fitr_up_held	 = keyboard_check(ord("W"));
self.fitr_right_held = keyboard_check(ord("D"));
self.fitr_left_held  = keyboard_check(ord("A"));

return 0;