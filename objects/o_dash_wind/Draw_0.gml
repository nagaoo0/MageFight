/// @description Live and fade till it dies

draw_sprite_ext(sprite_height, image_index, x, y, image_xscale, image_yscale, 
				direction, c_white, (1.0 * countdown--) / countdown_const,);
			
if (countdown <= 0)
	instance_destroy();