/// @description Constructor & Initial Stats

// global variable for player 1 (or only player)
// NOTE: player1_id and player2_id globals will be initialized at -1 when we have start menu; I made a 
	// script create_player() for when its made, then this code wouldn't be needed
global.player1_id = self;

// stats (so far)
fitr_hp = 100;
fitr_stammag = 50;
fitr_jmp = 30;
fitr_wght = 50;
fitr_accl = 2;
fitr_jmp_accl = 60;
fitr_dccl = 2;
fitr_dash = 50;

// movement
vel = [0, 0];
x_max_vel = 6;
y_max_vel = 6;

// states for finite state machine (FSM)
enum fighter_state {
	normal,
	jumping,
	falling,
	punching,
	kicking,
	air_kicking,
	air_ability,
	blocking,
	air_up_punch
};

// set state to normal
state = fighter_state.normal;

// mini FSM for jumping
jumping = false;
falling = true;
// y_o set every time fighter collides in y-direction; in apply_movement()
y_o = y;
// for double-jump or air-dash; 0: none, 1: double-jump, 2: air-dash
air_ability = 2;
air_ability_used = false;

// input booleans
// NOTE: Once a startup menu/object is made,these inputs will be saved globally, not to object
// single-pressed inputs (for  attacks & combos)
fitr_punch = false;
fitr_kick = false;
fitr_down = false;
fitr_up = false;
fitr_right = false;
fitr_left = false;
// held-down inputs (for movement)
fitr_down_held = false;
fitr_up_held = false;
fitr_right_held = false;
fitr_left_held = false;

// fighting hitbox instance IDs; -1 when empty
punch_hitbox = -1;
kick_hitbox = -1;

// Drawing
image = 0;
facing = image_xscale;
anim_cntr = 0;
sprite_arm = s_sword_run_ninja;