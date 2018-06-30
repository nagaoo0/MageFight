/// @description Turning and Sprite-Changing

image_speed=abs(vel[0])/10
image = image+image_speed


	var horiz = fitr_right_held - fitr_left_held;
	var vert  = fitr_down_held - fitr_up_held
	
	
if horiz!=0 facing=horiz

var sprite_arm = s_sword_idle_ninja

	if state == "normal"{
		
			if (vert > 0)
				sprite_index = s_fighter_idle_crouch_ninja; // crouch
			else
				sprite_index = s_fighter_idle_ninja; // stand
		
		if !falling && !jumping {
			if vert>0 && horiz!=0 {
				sprite_index = s_fighter_idle_ninja
				sprite_arm = s_sword_idle_ninja
			}else
			if vert==1{
				sprite_index = s_fighter_idle_crouch_ninja //NOTE Crouching sprite to be added
				sprite_arm = s_sword_idle_crouch_ninja
			}
			if horiz!=0 && vert!=-1{
				sprite_index = s_fighter_run_ninja;
				sprite_arm = s_sword_run_ninja
			}	
		}
		if falling {
			sprite_index = s_fighter_jump_ninja;
			sprite_arm = s_sword_jump_ninja
			image = 1;
		}
		if jumping && !falling {
			sprite_index = s_fighter_jump_ninja;
			sprite_arm = s_sword_jump_ninja
			image = 0;
		}	
	}
	

draw_sprite_ext(sprite_index, image, x, y, image_xscale * facing, image_yscale, 0, c_white,1)
draw_sprite_ext(sprite_arm,image,x,y,image_xscale * facing,image_yscale,0,c_white,1)
