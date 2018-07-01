/// @description Sprite Animation

// set image speed
image_speed = abs(vel[0]) / 10;
image = wrap(image + image_speed, 0, sprite_get_number(s_fighter_run_ninja) - 1);

// directional inputs
var horiz = fitr_right_held - fitr_left_held;
var vert  = fitr_down_held - fitr_up_held;
	
// facing according to directions
if (horiz!=0) facing=horiz

if (state == fighter_state.normal) {
	if (vert > 0) {	  // crouch
		sprite_index = s_fighter_idle_crouch_ninja; // NOTE Crouching sprite to be added
		sprite_arm = s_sword_idle_crouch_ninja;
	}
	else if (horiz == 0) {			 // stand
		sprite_index = s_fighter_idle_ninja; 
		sprite_arm = s_sword_idle_ninja;
	}
	else if (sprite_index != s_fighter_run_ninja) { // moving/running
		sprite_index = s_fighter_run_ninja;
		sprite_arm = s_sword_run_ninja;
		image = 0;
	}	
}

if (state == fighter_state.jumping) {
	sprite_index = s_fighter_jump_ninja;
	sprite_arm = s_sword_jump_ninja
	image = 0;
}

if (state == fighter_state.falling) {
	sprite_index = s_fighter_jump_ninja;
	sprite_arm = s_sword_jump_ninja
	image = 1;
}

draw_sprite_ext(sprite_index, image, x, y, image_xscale * facing, image_yscale, 0, c_white,1);
draw_sprite_ext(sprite_arm, image, x, y,image_xscale * facing, image_yscale, 0, c_white, 1);
