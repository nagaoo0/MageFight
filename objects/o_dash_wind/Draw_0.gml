/// @description Live and fade till it dies

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 
				0, c_white, (1.0 * countdown--) / countdown_const,);
			
if (countdown <= 0)
	instance_destroy();