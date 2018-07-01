/// @description Function for wrapping values around certain range

/// @param input arg0
/// @param min	 arg1
/// @param max	 arg2

var out = argument0;
while ( (out > argument2) || (out < argument1) ) {
	// if input is found to reach below min_bound, return max_bound - (min_bound - input)
	if (argument0 < argument1)
		out = argument2 - ( argument1 - argument0 );
	// if input is found to reach above max_bound, return min_bound + (input - max_bound)
	if (argument0 > argument2)
		out = argument1 + (argument0 - argument2);
}
// if input found within range of bounds, just return input
return out;